Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393A22065
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787246; cv=none; b=EEZJ0EcD/EgTQIdQ450+Ap3zaKht/t8WlI+mhgsLTsdsDR6aUGyLkZeAd+gSFqmhqKHxGYfLE2VQo5em8ECl9YepGBzvgoTpArqEakXUs2PWskPj2G0icZ2r9o8FE34VFGnKm79v2p9STrB84b/GLXy8y6bNQj2gvjjtMzegzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787246; c=relaxed/simple;
	bh=V8S6ArvyWGIZniiNN6YeRZbWY4anVGMrfwLjWNFiD8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu+O5jPhuct8qpd/m1qPz7aXS8U7wsBhQlD+AIOUP3VZlEkVDsKMLmqF3kfDUX2OOnAJZ+KcNDXenJC75LVRkAObHV47pQIkEPTXKNpEvigRjkJeLr/dSkUJYxJjoFqiWfg1irvF03wTOB01xsit14YoJ73g8W5HHhjl7SGAe6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgO++OgU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgO++OgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32FDC433F1;
	Mon, 18 Mar 2024 18:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710787245;
	bh=V8S6ArvyWGIZniiNN6YeRZbWY4anVGMrfwLjWNFiD8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EgO++OgUvSLp2W7RM0MBmKXrvynStqjufuLnTiDsrFfomZgIurnjFI2o03lJqOJLX
	 SmHWb1mkTISAfqZ7SsES+VH09Hmu9cmpQq+vlJ3LYD1M7KETlAq341cG53B3rTtCmC
	 LBa2AjoNINwUiGZIQ17UYcdusQfVmSV3a/5dg+clKaVh0c6DJ5wdegTHpyT3CGs/8m
	 Io7SGM9KouBZ+5YU98hR+F/cFEYTvI7vbIjtojyrCLKWCw+f7Wrb/dmzTMUq+oASbn
	 1KOmc7N/P74a/NXrKyb3hQszkHcGreANZjOdSPKCOvvt5dikCmDCPn/buLzebX9sPo
	 AErctYsYj4ssg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v2 bpf-next 2/5] bpf: pass whole link instead of prog when triggering raw tracepoint
Date: Mon, 18 Mar 2024 11:40:34 -0700
Message-ID: <20240318184037.3209242-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240318184037.3209242-1-andrii@kernel.org>
References: <20240318184037.3209242-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of passing prog as an argument to bpf_trace_runX() helpers, that
are called from tracepoint triggering calls, store BPF link itself
(struct bpf_raw_tp_link for raw tracepoints). This will allow to pass
extra information like BPF cookie into raw tracepoint registration.

Instead of replacing `struct bpf_prog *prog = __data;` with
corresponding `struct bpf_raw_tp_link *link = __data;` assignment in
`__bpf_trace_##call` I just passed `__data` through into underlying
bpf_trace_runX() call. This works well because we implicitly cast `void *`,
and it also avoids naming clashes with arguments coming from
tracepoint's "proto" list. We could have run into the same problem with
"prog", we just happened to not have a tracepoint that has "prog" input
argument. We are less lucky with "link", as there are tracepoints using
"link" argument name already. So instead of trying to avoid naming
conflicts, let's just remove intermediate local variable. It doesn't
hurt readibility, it's either way a bit of a maze of calls and macros,
that requires careful reading.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h          |  5 +++++
 include/linux/trace_events.h | 36 ++++++++++++++++++++----------------
 include/trace/bpf_probe.h    |  3 +--
 kernel/bpf/syscall.c         |  9 ++-------
 kernel/trace/bpf_trace.c     | 18 ++++++++++--------
 5 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f20f62f9d63..f8a09a742e38 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1608,6 +1608,11 @@ struct bpf_tracing_link {
 	struct bpf_prog *tgt_prog;
 };
 
+struct bpf_raw_tp_link {
+	struct bpf_link link;
+	struct bpf_raw_event_map *btp;
+};
+
 struct bpf_link_primer {
 	struct bpf_link *link;
 	struct file *file;
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d68ff9b1247f..a7fc6fb6de3c 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -759,8 +759,11 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
 int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
 void perf_event_detach_bpf_prog(struct perf_event *event);
 int perf_event_query_prog_array(struct perf_event *event, void __user *info);
-int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
-int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
+
+struct bpf_raw_tp_link;
+int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link);
+int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link);
+
 struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
 void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
@@ -788,11 +791,12 @@ perf_event_query_prog_array(struct perf_event *event, void __user *info)
 {
 	return -EOPNOTSUPP;
 }
-static inline int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *p)
+struct bpf_raw_tp_link;
+static inline int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link)
 {
 	return -EOPNOTSUPP;
 }
-static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *p)
+static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link)
 {
 	return -EOPNOTSUPP;
 }
@@ -903,31 +907,31 @@ void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
 int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
 void perf_event_free_bpf_prog(struct perf_event *event);
 
-void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
-void bpf_trace_run2(struct bpf_prog *prog, u64 arg1, u64 arg2);
-void bpf_trace_run3(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run1(struct bpf_raw_tp_link *link, u64 arg1);
+void bpf_trace_run2(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2);
+void bpf_trace_run3(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
 		    u64 arg3);
-void bpf_trace_run4(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run4(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
 		    u64 arg3, u64 arg4);
-void bpf_trace_run5(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run5(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
 		    u64 arg3, u64 arg4, u64 arg5);
-void bpf_trace_run6(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run6(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
 		    u64 arg3, u64 arg4, u64 arg5, u64 arg6);
-void bpf_trace_run7(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run7(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
 		    u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7);
-void bpf_trace_run8(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run8(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
 		    u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
 		    u64 arg8);
-void bpf_trace_run9(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run9(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
 		    u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
 		    u64 arg8, u64 arg9);
-void bpf_trace_run10(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run10(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
 		     u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
 		     u64 arg8, u64 arg9, u64 arg10);
-void bpf_trace_run11(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run11(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
 		     u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
 		     u64 arg8, u64 arg9, u64 arg10, u64 arg11);
-void bpf_trace_run12(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run12(struct bpf_raw_tp_link *link, u64 arg1, u64 arg2,
 		     u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
 		     u64 arg8, u64 arg9, u64 arg10, u64 arg11, u64 arg12);
 void perf_trace_run_bpf_submit(void *raw_data, int size, int rctx,
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index e609cd7da47e..a2ea11cc912e 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -46,8 +46,7 @@
 static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
-	struct bpf_prog *prog = __data;					\
-	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	\
+	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
 }
 
 #undef DECLARE_EVENT_CLASS
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ae2ff73bde7e..1cb4c3809af4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3469,17 +3469,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	return err;
 }
 
-struct bpf_raw_tp_link {
-	struct bpf_link link;
-	struct bpf_raw_event_map *btp;
-};
-
 static void bpf_raw_tp_link_release(struct bpf_link *link)
 {
 	struct bpf_raw_tp_link *raw_tp =
 		container_of(link, struct bpf_raw_tp_link, link);
 
-	bpf_probe_unregister(raw_tp->btp, raw_tp->link.prog);
+	bpf_probe_unregister(raw_tp->btp, raw_tp);
 	bpf_put_raw_tracepoint(raw_tp->btp);
 }
 
@@ -3833,7 +3828,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 		goto out_put_btp;
 	}
 
-	err = bpf_probe_register(link->btp, prog);
+	err = bpf_probe_register(link->btp, link);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		goto out_put_btp;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f29735bb7aed..ed4c3610b5b5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2370,8 +2370,10 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 }
 
 static __always_inline
-void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
+void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 {
+	struct bpf_prog *prog = link->link.prog;
+
 	cant_sleep();
 	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
 		bpf_prog_inc_misses_counter(prog);
@@ -2408,12 +2410,12 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 #define __SEQ_0_11	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
 
 #define BPF_TRACE_DEFN_x(x)						\
-	void bpf_trace_run##x(struct bpf_prog *prog,			\
+	void bpf_trace_run##x(struct bpf_raw_tp_link *link,		\
 			      REPEAT(x, SARG, __DL_COM, __SEQ_0_11))	\
 	{								\
 		u64 args[x];						\
 		REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);			\
-		__bpf_trace_run(prog, args);				\
+		__bpf_trace_run(link, args);				\
 	}								\
 	EXPORT_SYMBOL_GPL(bpf_trace_run##x)
 BPF_TRACE_DEFN_x(1);
@@ -2429,9 +2431,10 @@ BPF_TRACE_DEFN_x(10);
 BPF_TRACE_DEFN_x(11);
 BPF_TRACE_DEFN_x(12);
 
-int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
+int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link)
 {
 	struct tracepoint *tp = btp->tp;
+	struct bpf_prog *prog = link->link.prog;
 
 	/*
 	 * check that program doesn't access arguments beyond what's
@@ -2443,13 +2446,12 @@ int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
 	if (prog->aux->max_tp_access > btp->writable_size)
 		return -EINVAL;
 
-	return tracepoint_probe_register_may_exist(tp, (void *)btp->bpf_func,
-						   prog);
+	return tracepoint_probe_register_may_exist(tp, (void *)btp->bpf_func, link);
 }
 
-int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
+int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link)
 {
-	return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, prog);
+	return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, link);
 }
 
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
-- 
2.43.0

