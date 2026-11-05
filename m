Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871204;
	b=b6Ff9VGD5/p2A/gR5qz68YODgqCDSh6IiRi37ehyGkc1NdxCO1ziwxEKVveRCFYoG8UF
	 mXaoFRQJcIpO0FCespzMXzu1G+RSj9JaH5AtzPt9ZSl70vuJMuhwcOpVYmVMi5xKsKXuS
	 6ZAQaOyO1wDL+crw8w2ZGRxB0kzNJQSB7JqDsTzMmlIX8pbAfxg+++BfFheVCT03GJae4
	 DWXcLTxXfBPpkXGAj6a/4egih5zambWzEEqbVW3JaCiYKUUcM7b5Q54QhLijo2OYYNyeA
	 D3A1DwU40fCxft2wgcXeO+gW0PBuIguiApQpAw9eUgDHWSL7dYROIG8i66+/yggP6+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871204;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Dm3dgTuQGaoDU0dTrd0Cq8Teann1h5cYynTUQ71j/ik=;
	b=cBEZ3Bi73khphTYF1Q1Bf3LHoLqmTx/BVBJDnLf1QY5S85r0Y7619kdEsH2kWG3ZghZw
	 K6V1DpqEGPG9st2NaOo5gy1QxWdYi/CROLH2VKYbH8P+Ka5lP+PkRuMZIcAf4R2S9tg26
	 DLFSq3IDmX39LvaoWs2XuxR3S9TfxKIYH9W3PcoOdai09Af972EPGAQiQ+hkYdyeq88PC
	 1YZdfAhRJ82E1J1WLH3+uTcaTR/lJL9f5m88MLL0NwqpyVKOatBUsaOZdd0Khdz0+xAW9
	 uUquwWfra8F86+JjyrjRU1fHVraulzIkbX4i8UrXlLsJyYNEjXHPVr0amvZFu0ZfHGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BrA1Yzh4;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D585606A31B;
	Thu,  5 Nov 2026 09:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D585606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BrA1Yzh4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Dm
	3dgTuQGaoDU0dTrd0Cq8Teann1h5cYynTUQ71j/ik=; b=BrA1Yzh4vp2SlBFaO1
	Uxf68SUyWso3cH4MTzjytFNzq9586raozVoLE4Pyt78e9J4sLJrQl1g0PCnc1diT
	cbPunZlhfO8GbVFrqwWtJsjPsvZK/nJVCS9XmgQ5h/SLfVPwnIkcWA113eQlG1Ah
	0DWWqrRSaVutXi6K+lzyJoRqQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCXnyQcTexqw6hoFQ--.43864S2;
	Thu, 05 Nov 2026 17:32:14 +0800 (CST)
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
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 1/2] bpf: Add sleepable version of bpf_get_stack in raw_tp_prog_func_proto and tp_prog_func_proto
Date: Thu,  5 Nov 2026 17:32:11 +0800
Message-Id: <20261105093212.826479-1-yangfeng59949@163.com>
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
X-CM-TRANSID:_____wCXnyQcTexqw6hoFQ--.43864S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr1fKw4kKF1kZFW3uF43Awb_yoW7try3pF
	9IyF1akrs5X3ySqrZxGw1qvFy5W3ykX3y8KFyxC34Y9r1UZr18tFy7KF4agF1rur97W342
	93W0qrsFkw40va7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ja4E_UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0B8wqGrsTR9daQAA33

From: Feng Yang <yangfeng@kylinos.cn>

bpf_get_stack() has two implementations.  bpf_get_stack() passes
may_fault == false and resolves build IDs with build_id_parse_nofault(),
so an IP whose backing file page is not resident falls back to
BPF_STACK_BUILD_ID_IP.  bpf_get_stack_sleepable() passes may_fault == true
and uses build_id_parse_file(), which faults the page in and returns a real
build ID.

Only kprobe/uprobe programs are routed to the sleepable implementation
today, so the other program types that can be sleepable keep losing
build IDs for non-resident pages:

 - tracing_prog_func_proto() serves BPF_TRACE_ITER, fentry/fexit/fmod_ret
   and BPF_TRACE_RAW_TP programs, and falls back to
   raw_tp_prog_func_proto() for BPF_FUNC_get_stack, which is also the
   get_func_proto() of BPF_PROG_TYPE_RAW_TRACEPOINT and is reached by
   BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL through the default cases
   of bpf_lsm_func_proto() and syscall_prog_func_proto().

 - tp_prog_func_proto() serves BPF_PROG_TYPE_TRACEPOINT programs.

Route them to bpf_get_stack_sleepable() as well and mark the new
prototypes might_sleep, as
commit 9d02927fdf4e ("bpf: Mark faultable stack helpers as sleepable")
did for the faultable stack helper prototypes.

The verifier then rejects bpf_get_stack() from these program types
marked sleepable whenever in_sleepable_context() is false:
inside bpf_rcu_read_lock(), bpf_preempt_disable(), and so on. This also
covers calls that do not pass BPF_F_USER_BUILD_ID and would not sleep;
such programs load today. This is consistent with the existing constraints.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
v4: Update commit messages. Test modification: limit capture to one hit, add s390 flags.

v3: Add selftest. Update commit messages.
https://lore.kernel.org/all/20261104083833.971911-1-yangfeng59949@163.com/

v2: Move regs onto the stack.
https://lore.kernel.org/all/20261102073714.1103088-1-yangfeng59949@163.com/

v1: https://lore.kernel.org/all/20261028093548.790977-1-yangfeng59949@163.com/
---
 kernel/trace/bpf_trace.c | 54 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2aec56d7f3d3..1229ee06dd71 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -84,6 +84,7 @@ static struct bpf_raw_event_map *bpf_get_raw_tracepoint_module(const char *name)
 
 u64 bpf_get_stackid(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 u64 bpf_get_stack(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
+u64 bpf_get_stack_sleepable(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
 static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
 				  u64 flags, const struct btf **btf,
@@ -1477,6 +1478,26 @@ static const struct bpf_func_proto bpf_get_stack_proto_tp = {
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
@@ -1486,7 +1507,8 @@ tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_stackid:
 		return &bpf_get_stackid_proto_tp;
 	case BPF_FUNC_get_stack:
-		return &bpf_get_stack_proto_tp;
+		return prog->sleepable ? &bpf_get_stack_proto_tp_sleepable
+				       : &bpf_get_stack_proto_tp;
 	case BPF_FUNC_get_attach_cookie:
 		return &bpf_get_attach_cookie_proto_trace;
 	default:
@@ -1716,6 +1738,33 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_get_stack_raw_tp_sleepable, struct bpf_raw_tracepoint_args *, args,
+	   void *, buf, u32, size, u64, flags)
+{
+	/*
+	 * Don't take a per-CPU bpf_raw_tp_regs slot here: those slots are a
+	 * LIFO nest counter and are vulnerable to slot overwrite and
+	 * corruption across sleep.  Sleepable programs never run in
+	 * IRQ/NMI context, so a local pt_regs is sufficient.
+	 */
+	struct pt_regs regs = {};
+
+	perf_fetch_caller_regs(&regs);
+	return bpf_get_stack_sleepable((unsigned long) &regs, (unsigned long) buf,
+				       (unsigned long) size, flags, 0);
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
@@ -1725,7 +1774,8 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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

