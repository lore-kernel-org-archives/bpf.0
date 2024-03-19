Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D783D55D
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710891545; cv=none; b=JPoR9Yh6J8Nw+Xcpr/lZMz1NuIELlq//7FzIvDdnQrHZcpHuTmVZZZpo39uHlxVUq8X0CwcSGYSu49vipwRRRj91TqlO8LUSCjvs8xezCC4tg3AxMLFx4LhsYnNpyQ7nA3t4bDb5ZxDzKZYkDxkNP/bDUIOApuSmUNVEQCLgGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710891545; c=relaxed/simple;
	bh=f8/T0V8TwvWrp6xoUX92Wq76oxy7mC5VOt8vWS5HfDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lo4MUKBm1FcoMbabgJhu615O3zngNAenvJSLkl7qM6qz1zRjJnlttwqmMgVDGm70At6v0opjGA8Py6t0L/ArPRdZUlTs8mBhvuXyuauxTn6wX+pkSHxWjIEPx6LPLyT/86XXru6+HcqsmVb2ankv5lin3VFAAdpgOi0YAokNNuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxZ3gf9R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxZ3gf9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8BBC433F1;
	Tue, 19 Mar 2024 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710891545;
	bh=f8/T0V8TwvWrp6xoUX92Wq76oxy7mC5VOt8vWS5HfDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxZ3gf9Rpi8YqkJpmYLht5wrGNw0rb4WOaGYWXw3Ejt7/nz28ns7VMRxhNbLJVLdz
	 iGEWiYyORkp2Yxov1Y02CT0XMtm1oA/QSBYXTyrpCnqeUrBFRIPdFVzQpAM8W2B9pB
	 USTSxobwvZF+RnMHBkIdhRq8yHbRIBpB5rwyhmof60oSOd2fNm2UFt47Mr4DUmSEO0
	 psOf8whBUy8UqOjj8yZOWTwdLfdJXHmkZHIMvwRKBQcSIe5vML1gyWizppHNLMbZgR
	 DI5RjRVyjhaTvU+10KTSi0QlPWaEa/iXqBorN8o/vtJXy2ZgxxzB9hKGF/0rc4w7A1
	 9IZqecd9Vc/9Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Stanislav Fomichev <sdf@google.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 3/5] bpf: support BPF cookie in raw tracepoint (raw_tp, tp_btf) programs
Date: Tue, 19 Mar 2024 16:38:50 -0700
Message-ID: <20240319233852.1977493-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319233852.1977493-1-andrii@kernel.org>
References: <20240319233852.1977493-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up BPF cookie for raw tracepoint programs (both BTF and non-BTF
aware variants). This brings them up to part w.r.t. BPF cookie usage
with classic tracepoint and fentry/fexit programs.

Acked-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  6 ++++--
 kernel/bpf/syscall.c           | 13 +++++++++----
 kernel/trace/bpf_trace.c       | 13 +++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 5 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2ea8ce59f582..62762390c93d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1610,6 +1610,7 @@ struct bpf_tracing_link {
 struct bpf_raw_tp_link {
 	struct bpf_link link;
 	struct bpf_raw_event_map *btp;
+	u64 cookie;
 };
 
 struct bpf_link_primer {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3c42b9f1bada..9585f5345353 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1662,8 +1662,10 @@ union bpf_attr {
 	} query;
 
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
-		__u64 name;
-		__u32 prog_fd;
+		__u64		name;
+		__u32		prog_fd;
+		__u32		:32;
+		__aligned_u64	cookie;
 	} raw_tracepoint;
 
 	struct { /* anonymous struct for BPF_BTF_LOAD */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1cb4c3809af4..e44c276e8617 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3774,7 +3774,7 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
 #endif /* CONFIG_PERF_EVENTS */
 
 static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
-				  const char __user *user_tp_name)
+				  const char __user *user_tp_name, u64 cookie)
 {
 	struct bpf_link_primer link_primer;
 	struct bpf_raw_tp_link *link;
@@ -3821,6 +3821,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 	bpf_link_init(&link->link, BPF_LINK_TYPE_RAW_TRACEPOINT,
 		      &bpf_raw_tp_link_lops, prog);
 	link->btp = btp;
+	link->cookie = cookie;
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err) {
@@ -3841,11 +3842,13 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 	return err;
 }
 
-#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
+#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.cookie
 
 static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 {
 	struct bpf_prog *prog;
+	void __user *tp_name;
+	__u64 cookie;
 	int fd;
 
 	if (CHECK_ATTR(BPF_RAW_TRACEPOINT_OPEN))
@@ -3855,7 +3858,9 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
-	fd = bpf_raw_tp_link_attach(prog, u64_to_user_ptr(attr->raw_tracepoint.name));
+	tp_name = u64_to_user_ptr(attr->raw_tracepoint.name);
+	cookie = attr->raw_tracepoint.cookie;
+	fd = bpf_raw_tp_link_attach(prog, tp_name, cookie);
 	if (fd < 0)
 		bpf_prog_put(prog);
 	return fd;
@@ -5193,7 +5198,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			goto out;
 		}
 		if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
-			ret = bpf_raw_tp_link_attach(prog, NULL);
+			ret = bpf_raw_tp_link_attach(prog, NULL, attr->link_create.tracing.cookie);
 		else if (prog->expected_attach_type == BPF_TRACE_ITER)
 			ret = bpf_iter_link_attach(attr, uattr, prog);
 		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 17de91ad4a1f..434e3ece6688 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2004,6 +2004,8 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_stackid_proto_raw_tp;
 	case BPF_FUNC_get_stack:
 		return &bpf_get_stack_proto_raw_tp;
+	case BPF_FUNC_get_attach_cookie:
+		return &bpf_get_attach_cookie_proto_tracing;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
@@ -2066,6 +2068,9 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_func_arg_cnt:
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
 	case BPF_FUNC_get_attach_cookie:
+		if (prog->type == BPF_PROG_TYPE_TRACING &&
+		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
+			return &bpf_get_attach_cookie_proto_tracing;
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_attach_cookie_proto_tracing : NULL;
 	default:
 		fn = raw_tp_prog_func_proto(func_id, prog);
@@ -2369,15 +2374,23 @@ static __always_inline
 void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 {
 	struct bpf_prog *prog = link->link.prog;
+	struct bpf_run_ctx *old_run_ctx;
+	struct bpf_trace_run_ctx run_ctx;
 
 	cant_sleep();
 	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
 	}
+
+	run_ctx.bpf_cookie = link->cookie;
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+
 	rcu_read_lock();
 	(void) bpf_prog_run(prog, args);
 	rcu_read_unlock();
+
+	bpf_reset_run_ctx(old_run_ctx);
 out:
 	this_cpu_dec(*(prog->active));
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3c42b9f1bada..bf80b614c4db 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1664,6 +1664,7 @@ union bpf_attr {
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
 		__u64 name;
 		__u32 prog_fd;
+		__aligned_u64 cookie;
 	} raw_tracepoint;
 
 	struct { /* anonymous struct for BPF_BTF_LOAD */
-- 
2.43.0

