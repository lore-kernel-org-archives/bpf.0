Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941391;
	b=4hG5Ajyqn0gtqUCAv6pVVag3oA+SJ2RnIGQ3AQ1Pr5ZEh7fhRVlUJbKQIMWGPQkdmRkF
	 V4qjVvedXToOPphAfQMk3wdL6qOR1B6cGmc3QcEYq5YFVjnT/oyfAov/TYBwE9Js40fZn
	 Tu9U5DVpIpKRn9dkMoZdH06OaZLU76RRPUxop7id0wGBSC9ZbbpviUUQ/zRi2l5Dy/AY/
	 C1F7HBHOeMpy4xKU9QxIE/rtiVdStLnTPy/P7n4TYbbgLTifPxU5+i2QG9M721b9OTZGj
	 kYOewytje5EAdGp2j3uf1TwLgyC71/QbaDux2yFhWpBI3+gR/ZojsZF1B0DZTpJd1rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=fE96Bwoq4dvubLO/ytQscTwlirtJcyD7QHCmaubFJQM=;
	b=rEPN7Xm+5ZZlkdK+xzJlJG+Ss3pCWy/0LYSle7peSYS4GWA5t0NhttWAeSSX40gBVNol
	 QDcU2Ggu77b3zQKlRJVCrzNzrL+iZpS8FH64iSeAdMXFzmqgj0QRRr71aFwXQsf8LHMey
	 BLud34Zjgg3Kws2siA/ooX35yrBmdbUaPNvNRyAAjwg0jWEQAXulfu6U7puC3gvimho5i
	 zVXLpfVL6aiaiYOxdDX/c+dK3Dn3cxRdmOdwaRdYLn38+rgFLdYSHbpTumyLbeGj9iqmn
	 Wsoz/k82l0SKXNrDhTs0Alf9LhiSMerirKGxJPJWAiEOmajWsNZ7qzbcaF+cQen/PcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WW1MgN0E;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7560A3802
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 18:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DC7560A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WW1MgN0E
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3821eb27024so220892eec.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 10:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941390; x=1795546190; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fE96Bwoq4dvubLO/ytQscTwlirtJcyD7QHCmaubFJQM=;
        b=WW1MgN0E610Ng/mUsdrMraSskJo17fZb1fON7UEmlBFyhEVKKchyibrIoPxMSyHET5
         thKIRP1YEZt79vZKCCim/zvSYsvxMduKm31ec5DGc2qP9ZWg3WrzigM8Oh4bA4SXU1QH
         HC49ZsHIKiK2gk+hqXR68p4l2XWMI3a0vTDWF6g+nskYW2WyEo40yskAlm/R6fhdzFiF
         pUV98xaovmjJqptj08FUKzpRz9Yp7oKtoEjH8u/g1db9D+gBDegs9yU6/yRkvCmQh9M6
         AEPcRMMf8dKHJMveKVvJH8jadIt/Ium6pGwaj8yTUWmHr49Jybhij42eDvL/d+Q55Hvk
         P3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941390; x=1795546190;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fE96Bwoq4dvubLO/ytQscTwlirtJcyD7QHCmaubFJQM=;
        b=l72yy+f6jU4HzPn4BLLUhwXayOMDJyI38oB9OHSo8LffAvf5EuZ8uf9oAH9Mh4cfZ+
         bP7iMkRozTpZg2jxKcrCFREw2IsQYxKZS0xtoSr/Vs+Pz9wWGbn03P8epewvXmiX+V+H
         sIEwm3QfAlGppc47psBbasoWy7/GMgIFCwafJgvEgaUHox+1xT7LjiZLQtQzv1KujIHt
         AEc0ce4LiqUhQ+B0BzVkVrZ0EWXRsMyJhT8CKf5Cvp0z9/mBjWTgEWYdkrHamZlygmtW
         y9BrfA0EtWC2z5pdAmYfr9X6+vISjLdHCY8HAZdnsp7wphUzj6LmF5b3PHu6n57JIBat
         nS6Q==
X-Forwarded-Encrypted: i=1; AL+hErEBtanGBzLJMaTlxYciBfgT/rPQZLvvtgvE626P1x68yj5g/BSIbWLGeCJVwukR+DD6200=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KRn0PWnRzoqv3roC5yAGh8x5/LM9K7CsqESbkMvzHlrCUMd+Q
	sruYVvDCezozqtypXQFAn0lj4zoRtGKlm9TlsKWXwtzT+DrSVmNAm/nnCN0rnWXctjJXXzMkUFH
	E9DQcp5gq9g==
X-Received: from dycnd10.prod.google.com ([2002:a05:7301:c0a:b0:343:520f:7a80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:804c:b0:378:2e89:3958
 with SMTP id 5a478bee46e88-38280f22793mr277558eec.19.1794941389993; Tue, 17
 Nov 2026 10:49:49 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:44 -0800
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
Message-ID: <20261117184844.99889-24-irogers@google.com>
Subject: [PATCH v14 23/23] perf machine: Add __guarded_by annotation to machines->guests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Annotate guests in struct machines with __guarded_by(&lock) and mark
machines__init() with __context_unsafe().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 1 +
 tools/perf/util/machine.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0cc593d5372a..70870baa157e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -234,6 +234,7 @@ void machine__delete(struct machine *machine)
 }
 
 int machines__init(struct machines *machines, struct perf_session *session)
+	__context_unsafe(/* initialization */)
 {
 	int err = machine__init(&machines->host, "", HOST_KERNEL_ID);
 
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 80191545ee8a..67d517742fb6 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -3,6 +3,7 @@
 #define __PERF_MACHINE_H
 
 #include <sys/types.h>
+#include <linux/compiler-context-analysis.h>
 #include <linux/rbtree.h>
 #include "maps.h"
 #include "dsos.h"
@@ -153,7 +154,7 @@ struct machines {
 	struct perf_session *session;
 	struct rw_semaphore lock;
 	struct machine host;
-	struct rb_root_cached guests;
+	struct rb_root_cached guests __guarded_by(&lock);
 };
 
 int machines__init(struct machines *machines, struct perf_session *session);
-- 
2.56.1.703.gf848ed807c-goog

