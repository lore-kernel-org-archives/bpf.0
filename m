Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180222;
	b=CmaMhlF2jAH8LIo94IaNq0hLn1FHKYPNFqAn1lYXRWjhBRbMEWwvjocS/zdYnY1LugcQ
	 fgJA3sSwNq5Tivqw+WRxvUELyqRH6R61SFswq8whYZNZ+YUdQd7KMU9Ozg/NBfYWAEoF9
	 XdBuKxRlnYIWN+G+cKxBb5d+n0etc5yMXTArVbxa2DoD9VPOPFUerAN4AusVxIcoB+Rn7
	 StZVKBvpBG9ftPiUTCwHH1puYbm/Y/IH0Xa/0lnt7n/rkpcWf2r4wT4HbE7jUuQJpgvYZ
	 d2f77cvkaW2ujaTsSO0+puGoentXdm2VJq13heRcH4TUlC9NX1V3fSX6gGfEmLVa3Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180222;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=v4mpiG/I5NwSPXtUiBGXM9rWjGORly/Rcu8pnm4rux4=;
	b=ez6cIJ7BL/56EBQNNPwUl20R22GFyzUU+umCnumoMHnvuP4x7ra4pIpaCcO5LTldakK0
	 Nby0RcH2KIz4jSsBGhmteFeI0xTpLivSLCsXgvxQYzu92QTOv71wuH3nxzdDb+HNdyf7c
	 2Sq4zmGZPjuRcliM77E6K9PHjAvDYxoO4FYelTLyGRP0uSD1mCjiKySRdS8mWi86zPVul
	 sfQ2kMzwJcIfCbAD8Jj+o+cTmv9Nr21jJaNFpXrsAXVNlXz3g2DKMzW3+OL93r5vgi/zj
	 xlId91Tke1LoW6jTMiSjlJ//khbstkFGk7izaandUIpj+Wr3MUdnAlZQBdBjdGjD0YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MHmPxkd7;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4B4606A31C;
	Wed, 28 Oct 2026 09:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD4B4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MHmPxkd7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=v4
	mpiG/I5NwSPXtUiBGXM9rWjGORly/Rcu8pnm4rux4=; b=MHmPxkd7yPkWQAaYQL
	wz9GYbb1+U0YqTDDjGIvVt3Jyhy6Xmh14kXYp3EtFqjaPq2HbCKjwx198FhGeVuc
	rqAEr+3o07eD8JfIir/mNEmsLrFEH4uPnwVpOn0sY0/s3BhqiDX2L2yttABeC3p8
	DJaO8YYHoXYHr/sawyCWR/CNA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3_670weFqtKo6Cg--.4521S2;
	Wed, 28 Oct 2026 17:35:49 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: song@kernel.org,
	jolsa@kernel.org,
	ihor.solodrai@linux.dev,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Fix suspicious RCU usage for sleepable bpf_get_stack()
Date: Wed, 28 Oct 2026 17:35:48 +0800
Message-Id: <20261028093548.790977-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3_670weFqtKo6Cg--.4521S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFW7KFWfJFyDtr1UKFWUXFb_yoW7try3pF
	9IyF9FyFs8X3ySqrZxGw1qvFy5W3ykXrW2kFyfCrya9r1UZr18KFy7KF4agF1rur97G342
	vFy0qrsFkw4Iva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVGQhUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8hXAOWrhwfUAfQAA3c

From: Feng Yang <yangfeng@kylinos.cn>

Sleepable BPF programs run under rcu_read_lock_trace(), not classic RCU.
bpf_get_stack() relies on the caller holding a classic RCU read lock:
get_perf_callchain() -> get_callchain_entry() dereferences
callchain_cpus_entries, and the returned entry is read until
callchain_store().  __bpf_get_stack() takes that lock only for the
sleepable variant, i.e. when may_fault is true.

The sleepable variant was added by commit d4dd9775ec24 ("bpf: wire up
sleepable bpf_get_stack() and bpf_get_task_stack() helpers") but only
wired up for kprobe/uprobe.  All other program types that can be
sleepable still get the non-sleepable variant:

 - tracing_prog_func_proto() serves BPF_TRACE_ITER, fentry/fexit/fmod_ret
   and BPF_TRACE_RAW_TP programs, and falls back to
   raw_tp_prog_func_proto() for BPF_FUNC_get_stack, which always returns
   bpf_get_stack_proto_raw_tp.  Sleepable iterators have been allowed
   since commit cf83b2d2e2b6 ("bpf: Permit cond_resched for some
   iterators"), e.g. for the task_file target.

 - tp_prog_func_proto() serves BPF_PROG_TYPE_TRACEPOINT programs and
   always returns bpf_get_stack_proto_tp.  Sleepable programs of that
   type are allowed on syscall tracepoints since commit 8cfb77d30920
   ("bpf: Verifier support for sleepable tracepoint programs"); they run
   through trace_call_bpf_faultable() and bpf_prog_run_array_sleepable(),
   which hold rcu_tasks_trace but no classic RCU read lock.

So a sleepable program calling bpf_get_stack() triggers:

  WARNING: suspicious RCU usage
  suspicious rcu_dereference_check() usage!

Route these paths to bpf_get_stack_sleepable() and mark the new protos
might_sleep, since build_id_parse() may fault in file data for
BPF_F_USER_STACK | BPF_F_USER_BUILD_ID.  Sleepable programs that call
bpf_get_stack() from inside a bpf_rcu_read_lock() region are now rejected
by the verifier, which is the correct behavior for a helper that can
sleep.

Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Closes: https://lore.kernel.org/all/41ce77bf.17656.1a17b3fcb04.Coremail.kaiyanm@hust.edu.cn/
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/trace/bpf_trace.c | 54 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index dfac5e1b8f40..8cfc9a6542f2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -84,6 +84,7 @@ static struct bpf_raw_event_map *bpf_get_raw_tracepoint_module(const char *name)
 
 u64 bpf_get_stackid(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 u64 bpf_get_stack(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
+u64 bpf_get_stack_sleepable(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
 static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
 				  u64 flags, const struct btf **btf,
@@ -1469,6 +1470,26 @@ static const struct bpf_func_proto bpf_get_stack_proto_tp = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_get_stack_tp_sleepable, void *, tp_buff, void *, buf, u32, size,
+	   u64, flags)
+{
+	struct pt_regs *regs = *(struct pt_regs **)tp_buff;
+
+	return bpf_get_stack_sleepable((unsigned long) regs, (unsigned long) buf,
+				       (unsigned long) size, flags, 0);
+}
+
+static const struct bpf_func_proto bpf_get_stack_proto_tp_sleepable = {
+	.func		= bpf_get_stack_tp_sleepable,
+	.gpl_only	= true,
+	.might_sleep	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
+	.arg4_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1478,7 +1499,8 @@ tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_stackid:
 		return &bpf_get_stackid_proto_tp;
 	case BPF_FUNC_get_stack:
-		return &bpf_get_stack_proto_tp;
+		return prog->sleepable ? &bpf_get_stack_proto_tp_sleepable
+				       : &bpf_get_stack_proto_tp;
 	case BPF_FUNC_get_attach_cookie:
 		return &bpf_get_attach_cookie_proto_trace;
 	default:
@@ -1708,6 +1730,33 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_get_stack_raw_tp_sleepable, struct bpf_raw_tracepoint_args *, args,
+	   void *, buf, u32, size, u64, flags)
+{
+	struct pt_regs *regs = get_bpf_raw_tp_regs();
+	int ret;
+
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	perf_fetch_caller_regs(regs);
+	ret = bpf_get_stack_sleepable((unsigned long) regs, (unsigned long) buf,
+				      (unsigned long) size, flags, 0);
+	put_bpf_raw_tp_regs();
+	return ret;
+}
+
+static const struct bpf_func_proto bpf_get_stack_proto_raw_tp_sleepable = {
+	.func		= bpf_get_stack_raw_tp_sleepable,
+	.gpl_only	= true,
+	.might_sleep	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
+	.arg4_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1717,7 +1766,8 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_stackid:
 		return &bpf_get_stackid_proto_raw_tp;
 	case BPF_FUNC_get_stack:
-		return &bpf_get_stack_proto_raw_tp;
+		return prog->sleepable ? &bpf_get_stack_proto_raw_tp_sleepable
+				       : &bpf_get_stack_proto_raw_tp;
 	case BPF_FUNC_get_attach_cookie:
 		return &bpf_get_attach_cookie_proto_tracing;
 	default:
-- 
2.25.1

