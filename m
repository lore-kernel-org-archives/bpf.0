Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815111;
	b=m6ePZurmS/5QiuBmKJbuzrSloBOGi4yD0SKmSeKaIFJ6HGE1IK0MhSC92M7mWKgtrNQb
	 mVGb6YAJh3tgzOKTM9u4MP/HFXjkaZnJdhTfl3PdNBVXB4l7It5a3xGSZUX2caMM8H2K+
	 reqAVh2ekk7MkcHapdsLZ4sH+XedzT7kIzFJUYe5qf2/akukXs1rBBVPZ6RzZ0wrQ83RM
	 Kite9KP6O4CdB57UcInEkGGdI9DnGliidh025DifvyYfsgtVl61KMzxssEwWPUhiQbpN+
	 w0GbdyCKw+hX4cKllDtJsnS69KYvosTDS2XiHLLRBrRkVFTkkG/VqNAS2zUBsIF/Ihg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=VhmVWVRrk2339BmZFkj7hmAbe8j2FMXF93AwQ4jIvsU=;
	b=doKDqH4NXwdVho9CXN0a8mA7XxHHRYiVVQut8ocPC0uIZ/ssSh0E80cfcaK24L0LUUpr
	 3J0ufzpb6mtUR0bKTOBmC+/maB3cYdFbbiAgCWOwLzjAaysWOxZuWVE8jtbSlTHOzgaOW
	 2bM+Wj1eu9uIERWwqMHjaOK6retUNgHNJVFScad7cckc4x8wvdR3i1h9KIGazixlSrfcM
	 BVlFmHHSRujWvZpBKwDdOMbJbgBDHDtPJhkLvogOMiqaIqZmbhi+lsTjqam7w/PvDzxD2
	 fMHRmcOwce9+SY22qPW9wt7nRH3gdRuZ1saBu6k9x82IBJ6UOzKaBCfKELbG2MXXkcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TpYUQ9mr;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF6606A33D
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56DF6606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TpYUQ9mr
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-37549877380so4364000eec.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 23:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815109; x=1795419909; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VhmVWVRrk2339BmZFkj7hmAbe8j2FMXF93AwQ4jIvsU=;
        b=TpYUQ9mrYK18ylzU/qW2jN4cLwlmXwHRsuugDsgXNoihNQW29xUQbGlyihr+RIJcCl
         y3zxNpG5aUMRY7Ka1GuvmCBEKRa+4XHhA/W7GLr1wjZReFN74YtwIvdnXOi7KtSfOS/9
         /hJCbYzAw76Bg1SlS+pujjgp6ol/afwLkTf+aRpdDLNGaCEZOpKjq7TCTSwHJa/sYTRo
         QnzfaA8zcc/b+jqbIT0m7XYrDmnLI1jHBrbOAEEKzkxgUtnd/MBb67ZsAiU+zS/Tp15u
         0S12vuK6VfirFt88KjTh1NZMQeI/tltZorhOg+0vvqbeEHfnij6Yci6OfJFYgMbChHhY
         evFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815109; x=1795419909;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VhmVWVRrk2339BmZFkj7hmAbe8j2FMXF93AwQ4jIvsU=;
        b=EfBP8bp+p4t0kYqcdkb2CcHjDgApRYC9auxebNVpMrGwZlDB+zWadL2flEqbl2ne6r
         TaQYSSyHZ3lI/N4z/cn3WFIMk5itLfksPTY9nLkQHmsYJQUl2fDCR7l8cEV92r7KZ4I+
         K4MhmmRZ+0z1nTNmP9DnIHlV4vASuvYvv+PG/HA/gSdZpL2QPqvv9kHf28vpZwxSo5ra
         +3BJpJ7stKHm6awzjc1McifwDhFYtfwaLzC8YrSrsrFwgB08Y+fQduqcEs4ffEVPh1OE
         HC225EcfGho28FVqUzZKNeegQJgUf/b5loK4kpQZqDo35E1YoMjVXaa427IFvhpdqaCB
         /gTw==
X-Forwarded-Encrypted: i=1; AL+hErHrXt/xuvGV7v8gyMNJR7ka59P6fKKdQ+V63fJdqoptyrWuizflwij9SrWi50RnSjQbkPs=@vger.kernel.org
X-Gm-Message-State: APuU4Z96hHGu6U45uUwOsJyp+mQLzTm9xKqPqQ/NoLtNYrLYAhOpvdHQ
	gwaBqTl05AX5uLxKLBIhvRe5KMPe7Ez8VRZAjACJAevUcayZ7hHNsqSpYYCc9NdaYXbMiY0E3pb
	RPulK94k8DQ==
X-Received: from dlgx28-n1.prod.google.com ([2002:a05:701a:ccdc:10b0:1b5:345d:ed30])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:d0c:b0:1a2:fa1d:1de5
 with SMTP id a92af1059eb24-1b5030f284cmr11497837c88.20.1794815108990; Sun, 15
 Nov 2026 23:45:08 -0800 (PST)
Date: Sun, 15 Nov 2026 23:43:56 -0800
In-Reply-To: <20261116074414.3174737-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116074414.3174737-2-irogers@google.com>
Subject: [PATCH v3 01/19] perf/core: Protect per-CPU callchain buffer across bpf_overflow_handler()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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
index 614f9f0e6500..fd9f654de269 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10818,8 +10818,15 @@ static int bpf_overflow_handler(struct perf_event *event,
 	rcu_read_lock();
 	prog = READ_ONCE(event->prog);
 	if (prog) {
+		struct perf_callchain_entry *callchain = NULL;
+		int callchain_rctx;
+
 		perf_prepare_sample(data, event, regs);
+		if (data->sample_flags & PERF_SAMPLE_CALLCHAIN)
+			callchain = get_callchain_entry(&callchain_rctx);
 		ret = bpf_prog_run(prog, &ctx);
+		if (callchain)
+			put_callchain_entry(callchain_rctx);
 	}
 	rcu_read_unlock();
 out:
-- 
2.56.1.703.gf848ed807c-goog

