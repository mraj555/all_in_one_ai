import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  TextEditingController controller = TextEditingController();
  String answer = "";

  final List<String> top_today_models = [
    'google/gemini-2.0-flash-001',
    'openrouter/optimus-alpha',
    'anthropic/claude-3.7-sonnet',
    'google/gemini-2.5-pro-exp-03-25:free',
    'deepseek/deepseek-chat-v3-0324:free',
    'google/gemini-2.5-pro-preview-03-25',
    'meta-llama/llama-3.3-70b-instruct',
    'anthropic/claude-3.7-sonnet:thinking',
    'deepseek/deepseek-chat-v3-0324',
    'openai/gpt-4o-mini',
    'deepseek/deepseek-r1:free',
    'meta-llama/llama-3.1-8b-instruct',
    'anthropic/claude-3.5-sonnet',
    'google/gemini-2.0-flash-lite-001',
    'google/gemini-flash-1.5-8b',
    'google/gemini-2.0-flash-exp:free',
    'google/gemini-flash-1.5',
    'mistralai/mistral-nemo',
    'anthropic/claude-3.7-sonnet:beta',
    'deepseek/deepseek-r1-distill-llama-70b',
  ];

  final List<String> top_week_models = [
    'anthropic/claude-3.7-sonnet',
    'google/gemini-2.0-flash-001',
    'openrouter/quasar-alpha',
    'openai/gpt-4o-mini',
    'google/gemini-2.5-pro-exp-03-25:free',
    'deepseek/deepseek-chat-v3-0324:free',
    'openrouter/optimus-alpha',
    'meta-llama/llama-3.3-70b-instruct',
    'deepseek/deepseek-r1:free',
    'google/gemini-2.5-pro-preview-03-25',
    'anthropic/claude-3.7-sonnet:thinking',
    'deepseek/deepseek-chat-v3-0324',
    'google/gemini-flash-1.5-8b',
    'meta-llama/llama-3.1-8b-instruct',
    'anthropic/claude-3.5-sonnet',
    'google/gemini-2.0-flash-lite-001',
    'google/gemini-2.0-flash-exp:free',
    'google/gemini-flash-1.5',
    'anthropic/claude-3.7-sonnet:beta',
    'mistralai/mistral-nemo',
  ];

  final List<String> top_month_models = [
    'anthropic/claude-3.7-sonnet',
    'google/gemini-2.0-flash-001',
    'openai/gpt-4o-mini',
    'meta-llama/llama-3.3-70b-instruct',
    'google/gemini-2.5-pro-exp-03-25:free',
    'openrouter/quasar-alpha',
    'deepseek/deepseek-r1:free',
    'deepseek/deepseek-chat-v3-0324:free',
    'anthropic/claude-3.7-sonnet:thinking',
    'anthropic/claude-3.5-sonnet',
    'google/gemini-flash-1.5-8b',
    'anthropic/claude-3.7-sonnet:beta',
    'google/gemini-flash-1.5',
    'google/gemini-2.0-flash-exp:free',
    'google/gemini-2.0-flash-lite-001',
    'meta-llama/llama-3.1-8b-instruct',
    'deepseek/deepseek-chat-v3-0324',
    'mistralai/mistral-nemo',
    'openrouter/optimus-alpha',
    'anthropic/claude-3.5-haiku',
  ];

  final List<String> trending_models = [
    'openrouter/optimus-alpha',
    'meta-llama/llama-4-maverick:free',
    'inflection/inflection-3-productivity',
    'meta-llama/llama-4-maverick',
    'meta-llama/llama-4-scout',
    'qwen/qwen2.5-vl-32b-instruct',
    'qwen/qwen-2.5-7b-instruct:free',
    'google/gemini-2.5-pro-preview-03-25',
    'openrouter/quasar-alpha',
    'qwen/qwen-vl-max',
    'mistralai/mistral-7b-instruct-v0.2',
    'cohere/command-r7b-12-2024',
    'meta-llama/llama-guard-2-8b',
    'mistral/ministral-8b',
    'openai/gpt-4-32k-0314',
    'anthropic/claude-2.0',
    'anthropic/claude-2.0:beta',
    'openai/gpt-4o-2024-11-20',
    'openchat/openchat-7b',
    'google/gemma-3-4b-it',
  ];

  ///Functionality For Get Answer From AI
  talkToAI() async {
    String the_answer = await getOpenAIResponse(controller.text.trim());
    answer = the_answer;
    update();
  }

  getOpenAIResponse(String userInput) async {
    final headers = {
      'Authorization': 'Bearer ${dotenv.get('API_KEY')}',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'model': top_today_models[19],
      'prompt': userInput,
      'max_tokens': 100,
      'temperature': 0.7,
    });

    final response = await http.post(
      Uri.parse(dotenv.get('BASE_URL')),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['text'];
    } else {
      throw Exception('Failed to get response: ${response.body}');
    }
  }
}
