Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965316;
	b=ZiInR0FihrBRBTK7Z/sLTJrvXEKV3Pmr4jQ11/5M2ExbnA3gcQDJqLl0ViWyQxTvmSUj
	 6iR5MAsYmYQ6i66P6/2L9SfWncfFsm9GdOgYHWApbCKr6aUqZrul4ibGoYZUU7kmSaxOJ
	 Yo5upRqfbhXHzuSaxvuGMyfWQPwdhseF4ri4HoZCGK/OTlLw+AXoxRQq6QvHkr/XYstdG
	 uPmiaKmBeq87hTBFO0HXhNu5tv7UA7bSqh6TIO52sOkTAh8qqmNyGw8EN/OMufkadhwpt
	 0hO2OavANHFqQE7Xaag4QKw+Etu+2Yp0COQUV8bgGBrB8/khUq9Y2Enq9O+QkXmtQig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:
	 Content-Type;
	bh=be+eoT3QXvYSp5cD2UBO8L2IBVcg5ae12G53Zlbjp1A=;
	b=gVMfG4poC+HzBCdZrfo2rZHYSuoJscpsXViWRQFJn/6wNuCbiobKSY6u8mZttMnH3Cwy
	 xWPYa/pkTtyb5P5RS3uWUZiPDDJ1bdvP/QnQqXLDWUf8r2c/ByBNupCBQG1hyLDsMDR6f
	 +E0yxM0Xa5kihNJrCzyP8lRta4wcGxGkL2IR/4mlhJy1HF3u7Pwr1aLFUXpKT7S+lj5bi
	 X7ct/Zzs/Ho8jjhO8WKadPi6sl/Dw3/2sLAlSoWnCSPOYjW2+4Lu09Rn5Um0IZ5pOeuSv
	 FKsBWqQR2uLSpMgREEb1nZ3gGJj45lytnadS+ZG6LvzPysNdWQqLKpo1nbBLydtcC5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VHZNMs9X;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF5A606A327
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 21:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CF5A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VHZNMs9X
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3548cdfd2fbso4052430eec.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 14:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792965315; x=1793570115; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=be+eoT3QXvYSp5cD2UBO8L2IBVcg5ae12G53Zlbjp1A=;
        b=VHZNMs9XcrJQJzmv9ySJ+QK7YaF3BopioLtT1jqlmjNamn8uKjO8B63GQQhsKn7jUx
         Cli249SJ26BQw4zQ6B3AuZTg2GtLSusoTK7Pbfjj3bYxmbV90ovqGRXgsFwY0/m8JSOB
         mv+MJh3zFZXcxKJKJCwLe4ZPZd8hC9zSCbUmFbcuUi33X0073PWx1GHzkf4StHySsAWR
         4rcTIrDH6yVgdhCpuTtPsoHt44O/C2WsMF05mGc//fmyUlx/SZcN6VS18vQ0nW5z/fxf
         HWlyHX7MfWb8Qy2uhHS4+2SpvgGcI2bBxEUYKChuD5O6TR0/dL/xXq1UT6bau1N7NAyL
         dDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792965315; x=1793570115;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=be+eoT3QXvYSp5cD2UBO8L2IBVcg5ae12G53Zlbjp1A=;
        b=E5zFIsBetYQuhZGpsH2wWMMLRtFXZK2sYNqtsq65qF/5zABAx7WjthkwXkVnauhZvw
         PkDnBRFMfrS1xAlugEj83pQ/U/Y0atg48yU6/wjUWcryrTFlJNDCDv6xkFSjzr2nGgEy
         SNpTquYPNcvQo/2Iq1rC46MB+stXEiu3BwPDpV9GCQQuuqyZ5AjHfbY9/jsiJu/LGVo4
         a3a+mdD21xnDKrCOUckpvwhUZFmwqtA/iK3seH1IT2AQJ+u6kOuf7pg4u3WICWhHskop
         UmE9OhLPZochrYFdD+t7LiC5OUBCFA0CQdqM9PDzFiEg2bHUWvje3RqjpY/WYfG7nLTX
         XAew==
X-Forwarded-Encrypted: i=1; AKwUvBwDCPGxTjf6tBiiM+4WEVYxdiYBJgktilozq2ETLyuZR1PASj47WsMcp9uwGP02kE2U4Ps=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3C//uQ3sdAAMWzDsugLuZoPQzixElA+zyAmGMQXE/YQhOgcSM
	FejXDoAbqGLfbY5y9ioSKM/77sCUh2nlU2fS7rauie9+GMLo0yVCJrq3sHRzhkjILvHlW7qO3/A
	7e6d0cEAwTg==
X-Received: from dlad18.prod.google.com ([2002:a05:701b:2212:b0:17a:1e54:4da1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b887:b0:144:fb31:a597
 with SMTP id a92af1059eb24-19937bb1b5fmr6558543c88.47.1792965314300; Sun, 25
 Oct 2026 14:55:14 -0700 (PDT)
Date: Sun, 25 Oct 2026 14:55:08 -0700
In-Reply-To: <20261025215508.1237480-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025215508.1237480-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025215508.1237480-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf/core: Clamp deferred callchain entry count to fit
 u16 header.size
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In perf_callchain_deferred_output(), if trace->nr is large enough that
sizeof(deferred_event->event) + trace->nr * sizeof(u64) + id_header_size
exceeds U16_MAX, header.size wraps while the output loop still writes
all trace->nr entries into the ring buffer. Clamp nr per event (accounting
for event->id_header_size when sample_id_all is enabled) so the record
never overflows u16 header.size.

Fixes: c69993ecdd4d ("perf: Support deferred user unwind")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b43883a42566..37824ca7fe97 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10385,8 +10385,6 @@ struct perf_callchain_deferred_event {
 	struct {
 		struct perf_event_header	header;
 		u64				cookie;
-		u64				nr;
-		u64				ips[];
 	} event;
 };
 
@@ -10395,12 +10393,19 @@ static void perf_callchain_deferred_output(struct perf_event *event, void *data)
 	struct perf_callchain_deferred_event *deferred_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
+	u64 nr = deferred_event->trace->nr;
+	u16 size, id_size, max_payload;
 	int ret;
-	u16 size = sizeof(deferred_event->event) + (deferred_event->trace->nr * sizeof(u64));
 
 	if (!event->attr.defer_output)
 		return;
 
+	id_size = event->attr.sample_id_all ? event->id_header_size : 0;
+	max_payload = round_down(U16_MAX - sizeof(deferred_event->event) -
+				 sizeof(u64) - id_size, sizeof(u64));
+	nr = min_t(u64, nr, max_payload / sizeof(u64));
+	size = sizeof(deferred_event->event) + sizeof(u64) + nr * sizeof(u64);
+
 	/* XXX do we really need sample_id_all for this ??? */
 	perf_event_header__init(&deferred_event->event.header, &sample,
 				PERF_RECORD_CALLCHAIN_DEFERRED,
@@ -10414,8 +10419,10 @@ static void perf_callchain_deferred_output(struct perf_event *event, void *data)
 		return;
 
 	perf_output_put(&handle, deferred_event->event);
-	for (int i = 0; i < deferred_event->trace->nr; i++) {
+	perf_output_put(&handle, nr);
+	for (u64 i = 0; i < nr; i++) {
 		u64 entry = deferred_event->trace->entries[i];
+
 		perf_output_put(&handle, entry);
 	}
 	perf_event__output_id_sample(event, &handle, &sample);
@@ -10430,7 +10437,6 @@ static void perf_unwind_deferred_callback(struct unwind_work *work,
 		.trace = trace,
 		.event = {
 			.cookie = cookie,
-			.nr = trace->nr,
 		},
 	};
 
-- 
2.56.0.307.g5fe7bd680c-goog

