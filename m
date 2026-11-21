Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244316;
	b=cEg2Fj+PE2qDmWJcyEBs5WBoE338ZGeRtZJ5aqKcuX0VllttgozBKRHTZTYQJ4wZSgIH
	 21n28gd6h9ialxIyM0EPzcUVjfPbrYomps2+qQ5Bm6ztiINyLPoqHuPKAjUAHofL/u4ry
	 poMn7grIMYZ/v3er0pHjvECM308JsA0z86gO3G3AmYA+rmDMks6qEX3Sx94hbHWBiBZ6E
	 iIpHUq71mX7dL4TS/HTIfAutjveSM86WhBpGLrAuo6uu2H/5/IQP5gzjM2uPViuQGsCPJ
	 vVEzfQNRB1SycgCJd9TJijeV3/TqLdQi/PpeuFtJbjbWw4/KEwYJu4voWd6LeoUjLVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=WFQYbBMhFIDNWh8RpPfdlWzTylnEhajA5E05wFXNi1k=;
	b=jKjtszVaxYioi/JIVfhSecdqX+nbV6zUS8DzxLm1T0hpZ3zZ0ThoBnf0jwagtkju2bwm
	 /JZYql4NCzHIf0cF45KBHa4SGUE99PxC1tqPfJ4G7VGdC9DxiTyY7R6emkzPHcuY11Ia/
	 EXhfqlw5D8J5uWtEY/+7PN+F0nZLhSZUE+4VlzTmctVWZX7kxsqzrnNPFMk5zK8keFxlR
	 /+I32/WLJA15Lh3bOJb84OYgHjYdwB9/2VeDOS15L+aTIVUUrUjtlQM7ejZW2utqZIY2P
	 ITQeLsmd/bBN7vhYoZPu2TjqlxsQr9aXkvNm9lnmoyD0V6fAcVj+B2L1IdB1xgjdycQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JFYp3AiY;
	arc=none smtp.remote-ip=209.85.210.71
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F5606A333
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 06:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B2F5606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JFYp3AiY
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-862a2ece202so1899247a34.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 22:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244315; x=1795849115; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFQYbBMhFIDNWh8RpPfdlWzTylnEhajA5E05wFXNi1k=;
        b=JFYp3AiYr2KxTluRFn6uMY7+yBx6+T7HVipHkYOk9Cez6+9NOVHCYf/1XHQvoqqhYi
         kuTEGw27MbAqIiq9lj62ufeFNKUuGJe9LTgTPBqISdFmvpdyCYf1ZAkZ3wSvKYDUGwfz
         T+faDkqA8yLt73wfcrpmH/5y3MaQEyarDdetrktLzodFY9LHSMFzHw5R/yS9BmRmMg7S
         uXkMMv9p17DA1Js2E/yz9a/fq7GysX9eBK/9QV9SPjOwWi/umVw02v5pq9Dcv9kkPXbt
         I9+q2Fo1vzetwxkYzcNdAx9xWCerlftk2PrWgUOXvpHSo9CFZb+KFYCOfwN5aS3vKaCG
         9pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244315; x=1795849115;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WFQYbBMhFIDNWh8RpPfdlWzTylnEhajA5E05wFXNi1k=;
        b=ug2HpEFwvWKASVm/YfdXqPqbQEAPUSTplkStZglsOW2ZoWYao4h7PILP5PcMLxNy7n
         XvpQwLncoVrrC363otDcOCz37Z80L1De08bGORpDCCjcTa2Idmn5Bsmu30XfNM9EETxn
         RKA5rEmFwUk9vkt5d1L6AGgY5TkGkkA608KvAvwYpisCQLARnCmcmVS08ld7N6rwph0b
         f7dmIA/buZA9i1j1iamzrplKRzrH5i7tPEHQjxb9OZie4ssrVuk2w1XPDmEia8oe5RmX
         xJ5iv98Z7mNhe0LAf1TPhRlPXrcnIV9DdbNgS7B+hG9MS98pj6P9J8yANsH0IkvmZ/G2
         HM+A==
X-Forwarded-Encrypted: i=1; AL+hErG/3ek9s9KtVphYP58oefhmJPNafdw3Aqx6K245wtMpiRejQkKAua4fuCXBzJIqHdVHzx4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dOhxpAjnszJIHSFSr1eh6Uhn0xbD33zKYYhffiaNsFw+MW6k0
	06OGkFKdUeCOA1b9kQGcyONivZ6d5BhUdudgpPRN4AMsz1vheZHNNdBhFOxIbWawNZLoyp9JEHN
	7Rx/yGs1fpQ==
X-Received: from oibmo2-n1.prod.google.com ([2002:a05:6809:702:10b0:579:7e19:d2e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:1314:b0:572:75e6:1cf3
 with SMTP id 5614622812f47-57a0b3464fcmr6263252b6e.35.1795244314813; Fri, 20
 Nov 2026 22:58:34 -0800 (PST)
Date: Fri, 20 Nov 2026 22:57:50 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-2-irogers@google.com>
Subject: [PATCH v15 01/23] compiler-context-analysis: Avoid unused parameter
 warning in _context_unsafe_alias()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
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
2.56.1.750.gf70dc682cf-goog

