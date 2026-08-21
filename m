Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA23358B9
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276550; cv=none; b=PTdwuRwEqiDLfEnebwqPeprV0MZ7g50JrfWuF8D3CK/l4x6pUnBcOQIV/D6h/fvd2orwa8bSO6GNkSU8syMoLuSGVLdk/KDKvilqpTWY5BzI+NGYq5mtG4I89NDgxIIQyPByjaYq1xVoWIXC40pU7IjTwKR6eyXKcfqooWT27P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276550; c=relaxed/simple;
	bh=cnGO77SZwM6ztR2iXPrLT1hQRzW3joCybwJahJ7pjaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDhPzWedvAOKjW2fy0wJEd+Za9AolPkeyhPApZDWRx/ImQ055gPXV7iB7GQ1+73i23qAhxiJfJZJvUVtN+ezBe7uTQJir90/QgH0A0DRNdGVlazTDPbCuBqU8doKWYGaUeAGEpFAxfkzztphaOxOtQn9ClwNQFK+/2RbXQjjLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCS+sxW1; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCS+sxW1"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so620637a12.2
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 18:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787276549; x=1787881349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IPPlPTzVw1FwO75QG0O3qCtpPyGRlfV8iguadoA9NEM=;
        b=tCS+sxW1mFfpp8fg+Fv9HH1hdnzpHYIPw/KdCo0C+o0FPJdevpsMQGKLQA9WUjphCE
         TW47o6/oVvqAPBwKmQocey6+oyuvvdKECUo8+w7+7ahKyjz9CJin0aPe+R1y9qNzKWDM
         u4n8kObdctDV2kFtVf2fedJfWLVPbXDXkCeVN4bq0WQQlU5GpAbGPc3J0zEqAdvKFYL+
         nMLeKB8+qfTvfJaSKpnSg9FBfNc+Xdm4vOeBOm8komiiTBgvDiOdJLKRN/xIKZhsa2WJ
         NnmhRPn9DvBWmsOlhi/nJRlqXe92By4XY4CMV6e0jOlgccqoXMMdzyv9RsakfRIvmuTn
         L3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787276549; x=1787881349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IPPlPTzVw1FwO75QG0O3qCtpPyGRlfV8iguadoA9NEM=;
        b=dNojp4F54syfAXyM2ARJ+x7pVuCx0etP2dd6CwS1JfMo5W5cV/gGZFtNNHqXDCibeZ
         LQn8TV8lpq1TvTq8sIme9CAEHNBjztyEWP6EErnyx0lm7wb2SMHtYagH0Kf7L6eSy1d5
         DPjI3G6aNzXe0EJwTmn0xbQT+dWtayulMWlj8jJrUVKQbT/HwP9YeBE97/lWsdD3H+wv
         SmIj43Uo4EKTVOcyYm7GnPtTKQ/586Ymsu6BM+AcFuk2qXfCnOFWUg52+SNpxifOfoBW
         ww3tURGpLw/1zFlqI35wXe1nLHwZljdjV4nizSx15jFixYk4q2jwCW7y2uiy2J5rZUyd
         co7w==
X-Forwarded-Encrypted: i=1; AHgh+RomDvJIg2Svc0iYsztFKMQ234za7mkePxmAp8tOJQ9FY0ma2P1cjpzoNwRdWA8YQN2He8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBQA5UQffIu3l9uimozgnFpzglYJv3DRFt2EHUdzJDODRHDvL
	2ue3OV5rrHub91bCD79XdQ7bnTpfGbI+E3THg8KN7xavb8RF5OJitpyk
X-Gm-Gg: AR+sD10iEBVd6FMn3TFrgkW4JsABqmjjfr1vBjzG4nEqejU8RE58+KKusDKNLPdAynk
	XR4hHkAWp092+MlyUw4l0Te3plv+/4cJ7eLqdvsG4NR0R76sittAzVRIMqQ77Y7kl/7KH9J9eml
	g0om2sFxjiecZftsGoKK6xLM8BKFsEuJfRY3CrW16rSajQX8BeReILVCN4Uj0wjs64XICpa0rOs
	QAUSXvuuf/5s2+v+oMQfM5war9/Xxv3G3ZAQUV0GLy4Hs3sWuuYyEuj7/NefL3AOTIkC3gK8FM1
	e8kEdxugTjhMkf0hZGFLYTYqhESneRv5IQDqJpYk7FPykc8sfQL3a0THKGKpMltSr2oJyT3ez4E
	o2zWA9mONwfPo0BWNPuskHQS2u0YrTikUHvSuFFYeb9uTK5xebImqwsa4Zeb6p8BNsFx8WPoXT1
	RpYR02n+hIPpgp2VHDvBsIhGxttFYELgE3ZG1pWMFzv0yBijKWTbtNVWv9ZkvtcRDSJ2tu+3Elc
	C72Un12nefTsXZfU18O7Oa25G13fWmk/z137umYqA/AjvjJMJme+g==
X-Received: by 2002:a05:6a20:c90c:b0:3cc:22bb:8911 with SMTP id adf61e73a8af0-3cd2fe7a2cdmr5359717637.6.1787276548650;
        Thu, 20 Aug 2026 18:42:28 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:707f:3e47:3c20:b84e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad53874sm32078704c88.4.2026.08.20.18.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 18:42:27 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	olsajiri@gmail.com,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
Date: Fri, 21 Aug 2026 07:12:10 +0530
Message-ID: <20260821014210.18681-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During fork(), perf_event_alloc() reads parent_event->prog locklessly
which can race with a concurrent bpf_perf_link_release() clearing and
freeing the prog via perf_event_detach_bpf_prog(). This can result in
a NULL pointer dereference or use-after-free in bpf_prog_inc().

Fix by holding bpf_event_mutex when inheriting the BPF program during
fork(). Make bpf_event_mutex non-static and declare it extern in
perf_event.h so it is accessible from kernel/events/core.c.

Fixes: 85192dbf4de0 ("bpf: Convert bpf_prog refcnt to atomic64_t")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 include/linux/perf_event.h | 2 ++
 kernel/events/core.c       | 8 +++++---
 kernel/trace/bpf_trace.c   | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..5c6dabb6dccb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -2136,4 +2136,6 @@ static inline void perf_lopwr_cb(bool mode)
 }
 #endif
 
+extern struct mutex bpf_event_mutex;
+
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ba5bd6a78fe7..a89e33c47073 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13433,12 +13433,15 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		overflow_handler = parent_event->overflow_handler;
 		context = parent_event->overflow_handler_context;
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
-		if (parent_event->prog) {
-			struct bpf_prog *prog = parent_event->prog;
-
+		struct bpf_prog *prog;
+
+		mutex_lock(&bpf_event_mutex);
+		prog = parent_event->prog;
+		if (prog) {
 			bpf_prog_inc(prog);
 			event->prog = prog;
 		}
+		mutex_unlock(&bpf_event_mutex);
 #endif
 	}
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 75495a5c3507..730fc22a9daa 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1944,7 +1944,7 @@ const struct bpf_verifier_ops perf_event_verifier_ops = {
 const struct bpf_prog_ops perf_event_prog_ops = {
 };
 
-static DEFINE_MUTEX(bpf_event_mutex);
+DEFINE_MUTEX(bpf_event_mutex);
 
 #define BPF_TRACE_MAX_PROGS 64
 
-- 
2.43.0

