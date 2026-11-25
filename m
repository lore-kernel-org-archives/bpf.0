Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567883;
	b=VmCjxdt+HHSamWhU77Hl5cE7iMXiNzHKpdkEOphCA7ifVIUcU207fQpLh21KIZYg+L/F
	 AvtGl483XHb6KW/D3Qf3euV1376UJgVyEu/j846jIQjvguE9eLHJROrYy2lcsnDyw6v8O
	 AdWQPUX8uZRLhu9UQlVDEk806SNX4h+j/o6k1Q/1iaTSavPD5Xb1qMK5u0a7wMQvJpqbO
	 8UIqP1dT3XjLM0GClzk6tg4dAr2pfXGYz7CKwkfUKeD8K+x4MfYxBoV9DmkuzJQqAEGDE
	 YP/3Vo6ue5bT93/3igpsct5Qo5XOjf5dPOnvKu32zp1V4U/0Zi0SUESOyi/YXX8YoiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=p2fy+DpqSZGCjXCmXOGO/oc1L9NBEimm7FRwFXyUqLA=;
	b=qA1Y/dHVKfFasfzEPQSBVEW6dWmmUGcYjlIdKq9Ch8tvjq9BsXp35UfGZ5ogNDMLiGWz
	 T+fFSNb5C/HFySKD2Pnjjv+3U6UaqJbdsTmwfTy48XOfne9+YqpfX9Zqdc3rKe9bKktsV
	 bqwg4G3/QgU7p9/TjqwnTUl62WsXyA2CmvBTXh/8eLRR1qMWnDyRgJdB5y4I0I/5vny6Z
	 8KS6E62aTfLMfmMTk+UbSw0LPgbFr6VaVnMd+fmyXrkdfLFq6i+7Jg/oJeOMNsbzH15cp
	 8Xwb8QEUb5YLeiosUQ2TMcvT5rBDPaTwKiBAIWdDcXs0EAZv/AMAnSC3Cf6D29vBSKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M3VRzKsP;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB7606A334
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 00:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49CB7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M3VRzKsP
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso6898674eec.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 16:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567883; x=1796172683; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2fy+DpqSZGCjXCmXOGO/oc1L9NBEimm7FRwFXyUqLA=;
        b=M3VRzKsP3UU+jOmahxJ9oJPAs3N0YNRgLeynysUqTwnKN3O2FrO+UiWcovRQjLYdUa
         PtOKXAvO/ZDaKwWxZtSt0sHyILm1do5CxcIgYdafcJigWctm4SKnk2egJEuZ1t1m/fz+
         c0+KgN/MA+HzF0EG8xpjKmNbgYocQNTK5o6CpooKWu3xsYvKdqghR7031/P9dZCfa1Qq
         VwUD1dN5h91xvEhmRQQ5uv1AHWOWFCpLMTcr5uGgZaAzdvnKRoK2iY+s8JfGgjZPf22n
         bPKDNfWTfpYtv9dYLV1WCJeNxA7y2rihYRc8Xhh6AMam5U1WrHYwcF/AyeIJWcVKZtTe
         +99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567883; x=1796172683;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p2fy+DpqSZGCjXCmXOGO/oc1L9NBEimm7FRwFXyUqLA=;
        b=a7hKtqzBLrUzz6bMpIL/190H1j/qbgcG2qw7GcUvprZOtE/obi6EHJw/OgFED1xerN
         9iTqNJi2QB7zjDb2NXq34yxIyyCzc8dIFCY+1yNwXinCo53/b7latT0hFCzqtEbJFeYs
         LTGjAhcVq+7eeIb145ZxYpPLC4e+/EFb0rONa0SjEOmreBkFqYu2XVtp3Hnpzo/taQRO
         9oZ0x1allJ5fyKQujuw3SmP0YwRWjErlH7ETMppQNFf6VIvDIM/wwqpk2mcFPtxbjdxm
         qdDl7S5Gk5tz7CexlppDmGL/+5+V1z42XI+3uTq3QhqEpHvch68NLZqpVzjdjy721nXF
         X8Ew==
X-Forwarded-Encrypted: i=1; AL+hErFtO+tkukHMQobsbk+g+qOQiXc3pwKLIzmQXS8Ujvi3AwOw2ujTCclJYJmGS9yU9e6dclA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GECYqjA0mk+GXq6zIz2528td0IuM3fCYofM8+DBvq4k+fb8Sz
	pNq1RsO8o6frUetA7+SoOgddP0vX9L55wTw84BtthspglH82HGouPEwktIWd9wCcoHe0TlnJhz9
	xSwv6T5YM2Q==
X-Received: from dyad21.prod.google.com ([2002:a05:693c:8355:b0:35d:1771:4816])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:42cb:b0:386:b621:d8ec
 with SMTP id 5a478bee46e88-386b621dc16mr6503137eec.19.1795567882190; Tue, 24
 Nov 2026 16:51:22 -0800 (PST)
Date: Tue, 24 Nov 2026 16:50:50 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-2-irogers@google.com>
Subject: [PATCH v4 01/19] perf/core: Protect per-CPU callchain buffer across bpf_overflow_handler()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In bpf_overflow_handler(), perf_prepare_sample() runs before bpf_prog_run()
and saves data->callchain pointing into the current CPU's callchain buffer
for the active interrupt_context_level(), after get_perf_callchain() has
already released its callchain_recursion slot.

If the attached BPF_PROG_TYPE_PERF_EVENT program invokes a helper at the
same interrupt_context_level() that calls get_callchain_entry() (such as
bpf_perf_event_output() on a PERF_COUNT_SW_BPF_OUTPUT event configured with
PERF_SAMPLE_CALLCHAIN and a larger stack, or bpf_get_task_stack()), it
re-acquires the same per-CPU callchain buffer and overwrites
data->callchain->nr in place. When bpf_prog_run() returns non-zero and
__perf_event_output() emits the outer event's sample, perf_output_begin()
reserves only the smaller dyn_size computed earlier while
perf_output_sample() copies the overwritten larger data->callchain->nr
entries, overflowing the ring-buffer reservation.

Hold the callchain recursion slot via get_callchain_entry() across
bpf_prog_run() when PERF_SAMPLE_CALLCHAIN has been prepared so nested
callers at the same context level cannot overwrite the active per-CPU
callchain buffer.

Fixes: 0eed28220598 ("perf/core: Call perf_prepare_sample() before running BPF")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 947f23973ed4..d67bb825c504 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10816,11 +10816,18 @@ static int bpf_overflow_handler(struct perf_event *event,
 	rcu_read_lock();
 	prog = READ_ONCE(event->prog);
 	if (prog) {
+		struct perf_callchain_entry *callchain = NULL;
+		int callchain_rctx;
+
 		perf_prepare_sample(data, event, regs);
 		/* bpf_perf_event_data::addr is readable without PERF_SAMPLE_ADDR */
 		if (!(data->sample_flags & PERF_SAMPLE_ADDR))
 			data->addr = 0;
+		if (data->sample_flags & PERF_SAMPLE_CALLCHAIN)
+			callchain = get_callchain_entry(&callchain_rctx);
 		ret = bpf_prog_run(prog, &ctx);
+		if (callchain)
+			put_callchain_entry(callchain_rctx);
 	}
 	rcu_read_unlock();
 out:
-- 
2.56.1.831.g720f3f5937-goog

