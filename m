Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C1F17A30A
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 04:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787633123; cv=none; b=r9r9v9q+snnB4+2RDnDHCSJrVXNfa6Wc7dDqnkET2fzpfVFDCzPJQPuDySaKk5QgR8Sk6NLoL3IvB0dTSmG5EkWKD8935y5sUapTmw1uFDu+VmN+hCZS1fnP1uFQmw70vpJQdUnjrsltXUoH8DtUEgNueGAqhQ2YVp1ELxR/CI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787633123; c=relaxed/simple;
	bh=U3WFWv1FAa4YBLRdz1h9/idaX2U2peMLstx9oXrCK/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a9Evm+qEj5uiTXGwatALiz31f5wkegRJtFHkDqx53cfEUjjN2qFkjGHjKxUgqwBitjTAytc8G4bR/2W2qcnXCChRXx9Y1X5oV6AFJY5a/ffGLekxwpMq1O4fjJthEThsz8G8ZDfRfz7Z5TZ7yIJiWm3zoHuNlaTq+dwnrnqbE/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7P3Qbia; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7P3Qbia"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d6e954afbdso2053615ad.2
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 21:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787633121; x=1788237921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U4h747TT8VehQ9CV4fksBaimDjY6TKEjNHbtfJohstY=;
        b=V7P3QbiaGC4KMQsYpMtpIGUH6GZf2mfhyNIHARPc37Yt/lI4j7rP4JGxdy73Um/yxk
         Vi+ZDb7ena/sN/D5vH0DZKTncZJRWDz3l6TJusrbmVkUQT6KGjix+7sfPzJ8UJciiJnx
         erNL6igCNU8EEaeq8LZmfPKNUQD+py+6v/MQWk9DxaixihVd9wFmnjbLqwduSFZVqwpu
         uXK1pWApFIU1wrnV4um/rkuUjxGo3P2gb3X58bpPzKnprqi09lGutMNWN9cJ7UB96hsj
         hhU87+FRk2hkIfyUE/fD9UYnOQRp4vJuFqLW3twBthqZCc57JiMRbCC8iDW4Z7bBkt2n
         VdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787633121; x=1788237921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4h747TT8VehQ9CV4fksBaimDjY6TKEjNHbtfJohstY=;
        b=dNywef8UDC9+mkItOFUTCjhhsXtM9QPAcxabriEWrVp0ZLmxjAFWPnCBD4lWpaXsJD
         DG9srR1t+gu7J/3YPsdn2wi0y9U1HS+mrjmWiAYdrb20Z7geRx56y7KrGqYarwM24NQq
         q3hEJ/KhkGIfefSQ3/8twSC22R2zdZ7vHEmEYnd4271wHc2v7DKKk9MKQZgy7dn8l4iF
         e0LyXpPXdar4PoMhGyaZ7MrDD0JdccuZHA+yFWRNtGt+aZxa0y0KYjKdkWds2uUfHlL2
         fDKSTvRqQpJg01HAjv8Q5zQfKTKgAbdFvNnu47uYi/BgtBdT0Cgt8HY5UmIUAvG2K0n3
         BQ7Q==
X-Forwarded-Encrypted: i=1; AHgh+RoYpmmYLtx7vkepamg6CivdnN6YIuCwjLwWB50I+wxlu/DcnxUPdOX5FgAuSyFOztYulqs=@vger.kernel.org
X-Gm-Message-State: AFuF++kG4oVvE7EyJ6bcLGqiEw+Q+at/SiW4OHAiwdGQSEqvY84ftQ8e
	0QdlMkFwAF4pbaAexEaSq+QwKocNSNFWIrzpt4C8+UdXHfrv7fhV1o0N
X-Gm-Gg: AR+sD13vzxAwXsBeJUtLRNyofD3rcwWIVTLcq9f0+/7uevfBh9zEPKywq29ybUY+2cb
	CPqNDOQJKjt72e2NZ8ffzqxVr2Vb5zwpc6WwjCKSFoOsjNQglgL3fjBz5JMZR1+ZoKpSHDnOX09
	UzI1aWKk09ZOtNh9geJOnAaM9i45fpeXLP1wy74iABqSljyElRGkUgY2sCFIOHZN4gfY/j4wMVA
	jGmSy+1rAXCVrf8JiQsZbORPqrcwmWpg/oKBFzqRYu8aYeXG6TC+aQKUO6OXUdhgi7clhqNevf5
	aDcOQlyEPpPvoTHjsogRi+bfUBTrL/W47iPoFZJSwWv+iVhVcWyd4yEID7yrFa5QkRelByncHvn
	rDOwFqlvj8n0n3w97GXrwIFyEN3waB8zWYDxltajusFmdkkpWcPvG3CMcNQh5LRxLc4WLEPBhE5
	8p25rrqu6I5UhUvOfiDCsx7jD8PN0dmQdB+JVSgBaZbjwB5Vi2XULfUWTSIog/N0k/e+c9GEEy7
	SKHy+XaAky9jezAFUM2GUutYPnxP0LqKB54ybIZwYKkbIUFQM9Q
X-Received: by 2002:a17:902:f647:b0:2cf:afa5:b19a with SMTP id d9443c01a7336-2d6dcbc9385mr79767655ad.11.1787633121117;
        Mon, 24 Aug 2026 21:45:21 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:a40b:24a4:97db:bc6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32801d7f812sm29372091eec.1.2026.08.24.21.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 21:45:19 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	daniel@iogearbox.net,
	andriin@fb.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH v2] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
Date: Tue, 25 Aug 2026 10:15:07 +0530
Message-ID: <20260825044507.15217-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During fork(), perf_event_alloc() reads parent_event->prog locklessly
which can race with concurrent detach clearing and freeing the prog via
perf_event_free_bpf_handler() or perf_event_detach_bpf_prog(). This
can result in a NULL pointer dereference or use-after-free in
bpf_prog_inc().

Fix by using READ_ONCE() to atomically read parent_event->prog into a
local variable and bpf_prog_inc_not_zero() to safely increment the
reference count only if the program is still alive. This handles both
tracing and non-tracing event types without requiring any additional
locking.

Fixes: 85192dbf4de0 ("bpf: Convert bpf_prog refcnt to atomic64_t")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2:
- Drop bpf_event_mutex approach which was wrong for non-tracing events
  as perf_event_free_bpf_handler() operates locklessly
- Use READ_ONCE() + bpf_prog_inc_not_zero() instead which handles both
  tracing and non-tracing event types safely without any lock
- Remove extern bpf_event_mutex from perf_event.h (no longer needed)
- Remove static removal from bpf_trace.c (no longer needed)
---
 kernel/events/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ba5bd6a78fe7..39755bfacc55 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13433,11 +13433,13 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		overflow_handler = parent_event->overflow_handler;
 		context = parent_event->overflow_handler_context;
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
-		if (parent_event->prog) {
-			struct bpf_prog *prog = parent_event->prog;
-
-			bpf_prog_inc(prog);
-			event->prog = prog;
+		struct bpf_prog *prog;
+
+		prog = READ_ONCE(parent_event->prog);
+		if (prog) {
+			prog = bpf_prog_inc_not_zero(prog);
+			if (!IS_ERR(prog))
+				event->prog = prog;
 		}
 #endif
 	}
-- 
2.43.0

