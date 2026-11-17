Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941347;
	b=i442gYXkbLgPfAG1ZGK0WH0zT6lWZ8QDA30Pbh7eP8aZ5wn2+XPNs98PUI0MyZxToVkh
	 rlQMfeZyBqJ9qR/EPnQ86cAU9a7N3zmvY3gju9vpSWuOdIsRPTLqboabrPjWVVHx+h9m5
	 20fm+drHJLY/X2v6gf6OlZJ+RVSd8HFfxDZ/Em1rzB6htJN9vgbCaGWiXVAGmFCAS8RmY
	 pahKUC7St51dfPLxBh27Bjs+gd3TWEiMMAtH0DWKaxBcV3HTXxDfwcigMUD+zZUwP4XVj
	 dQAFbiTBHhpBNiY9dZoWBDlZH1+/wDyckJBdhe7AUSoEzmwxm5d7J/OrB/feDQ0rvMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=wNOZ8QyL0UheBANe+7QNGXLjq8SQVqhuN9MkvsYBKOU=;
	b=Q0a3TzZMeSuyY8/tHEsAUXu+gTElKRQL9Gbnt4M4RP2wd+VSE77f1tiMEt8FcgQwn6cF
	 DPN5iHoOlqDbY8kTE+Xo8ztdMVWons3Nu3hlg/1iYkVA/RnbqRELKRHc5CKP46dbLtpn0
	 qomZhsfktV0UXlueGBXGcNZUYi8PZVNoawa77GHgn3Vk+cZ5X73pmiJft/RzcWOiAQNur
	 zjb1c12M2tKBjicYlCOTMdU5by5FIVY2H84GP9V6r48Ybf1h6Wjh+hwYHWocyn+twmtuA
	 K4Qsw/CZqq48NlokW4Hb95hu+50ppvger/sDRLBMi4PaDkswDkuP4lUZPjFdN4GXD8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JNkeI6Li;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F7606A333
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 18:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B80F7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JNkeI6Li
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so237809eec.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 10:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941346; x=1795546146; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNOZ8QyL0UheBANe+7QNGXLjq8SQVqhuN9MkvsYBKOU=;
        b=JNkeI6Lik9gq7/WT5nEQ1cPRfW7ta7RMM2zBM4mBeDtTbvvf4A6pQyjz6ZoMuY18vn
         vflQQ14Cf3lnf3HR8IAtMjs1EliZInJ3zy1jD+FrsLqZyPkg4RFPeaywIx1GQhat4YWn
         fkQGa4myjJ8jFhdI58quqccSZkVfCC/BCPl8AzUuQjdtu0l/ivTDVwqmBav5EDJoe9+9
         pL/KY8fMr3YeylUtFjxQRxqIhwUpnthN9cSl8RZq8yYeNtwoe+Gzd+dDfWGIIwDVUABS
         gdnIx6M3RcTCQJa8NlFQQBLwwzqGaHyD6D5UWMZOZ3xQysz5+gFqdpdaTNkuZJL4A8sK
         jvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941346; x=1795546146;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNOZ8QyL0UheBANe+7QNGXLjq8SQVqhuN9MkvsYBKOU=;
        b=FT/ucnC518OAVpTMgkDGoUU3Kz80kII0Lof++NXxYl/45q5S0R2hBHQBW0ta5me8DE
         zr5yPZyTeGF9TKUS/im+v2Ij6oUi5jQ6dPQSgHkfn9m6YG3R1Vxm+AZHTePLWPDk5tMT
         /FE9OQk8FEQvHkt4ExIh9H7dhQhTpDSrjc7Wa81IcpcrJ3sf0vNAzUqUNtH7qdjc1q8F
         uhLASDclF3vVxqk0BV7CZbMcyLzRVj0+tJIWZIWa9xvOD8RkW1XLSZ/FC3jEACKWxvjv
         y6xLLTJx5y6RzwUECsH1K+fYNRL1rAnMSJGdzrJHXPtVs2HVI9sISL4NrM8Q5Oi/A3ZS
         IUDg==
X-Forwarded-Encrypted: i=1; AL+hErFVMeQ8++EPsYtE+C8JAxoljJcjppfQjzZ+QXlNZuDePrY4ri3bhhFRb7jU2sDssyit5mw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uxibO3lMEF1SXUDYGMhkqyuinGp9Fq0N068oS2g1KamkK5qQp
	GmfjLnPL9kmzOdHenvhHIEbZuIqb2PNfRNwxSa3ddt122E6xUaox4mu5imWUUmq2qgpPHF3QYj8
	vATR3Tngvvg==
X-Received: from dyvo18-n1.prod.google.com ([2002:a05:693c:41d2:10b0:370:f640:2508])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fb02:b0:36a:3453:a356
 with SMTP id 5a478bee46e88-38281b03e42mr251247eec.36.1794941345512; Tue, 17
 Nov 2026 10:49:05 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:22 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-2-irogers@google.com>
Subject: [PATCH v14 01/23] compiler-context-analysis: Avoid unused parameter
 warning in _context_unsafe_alias()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

_context_unsafe_alias() does not use its parameter 'p', which triggers
-Wunused-parameter when building code that enables -Wextra (such as
tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
Explicitly cast 'p' to void to silence the warning, matching
__assume_ctx_lock() and __assume_shared_ctx_lock().

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/compiler-context-analysis.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compiler-context-analysis.h
index 8302ebc2ea8c..024e303188ad 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -243,7 +243,7 @@
  * alias as a function argument).
  */
 #define context_unsafe_alias(p) _context_unsafe_alias((void **)&(p))
-static inline void _context_unsafe_alias(void **p) { }
+static inline void _context_unsafe_alias(void **p) { (void)p; }
 
 /**
  * token_context_lock() - declare an abstract global context lock instance
-- 
2.56.1.703.gf848ed807c-goog

