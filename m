Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781582;
	b=jAdCqEYq1+zTu/BivWs/OcxN9p7mMD2BXWvRxJK9biU0MfOYTb0QO/ac2564oEbbc8s8
	 gSq0yAQeUWgIzPtqk24+7r/iAiZKrnGQ4pJtII6+74t3YmGKFJpcgWlTWIfJBbBvIzSui
	 x6ARF7uzy63KdpmpsRdCrZALS98ih785xaSn6Nc1lsEhcg1VknkBz1FCSyFfDwYIYkyzE
	 2KXKI/wrjnjiwgUXnSCFQnJ3qB/4iE07Z0DHau/JVLHF9SDeQTIowvSgg7UO2+2NRtheM
	 AI+MaHcBfKjexx27KVfkggMDXIqzEvPj9dwAO8vyy6A9d30ZOQvytMJ7u31dtrpEPOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781582;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=PxxRd/okwspTcATcRMnJkqLx7V5OMPg49j6hXfab6ws=;
	b=gMp5ae5zdx3w0oQAeqH1vXIHnetbYMl59XrmGKJD7ui7DvrzfU8raR3/EFKjsYSoaR5v
	 42eRMBIhywTMhR+KzqY79ysO+QaONM1jaDpaX0mxpwKVGDDMTLtrelSkd7jCBBmOf+zK0
	 fN4THW/9psByTSoymkYe2tKFeKkdpIF+lf+lP+CQjKhp60h7yR+17iny/PPdAcDASNqaZ
	 wNfQJD6/gWwbkXkOo7wscjE87IugT5WrZ8DQtk6bzV4dEG5hHnnR6VLO4Jk22jOSHK2an
	 swL5qR4fcZwcPDhBAocIspJWx7AtAHu+fKO2ISQAkk7ka9Bk3sZrHiZ6izMyE55eMAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UNYq18WU;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DE8606A326;
	Wed,  4 Nov 2026 08:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43DE8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UNYq18WU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Px
	xRd/okwspTcATcRMnJkqLx7V5OMPg49j6hXfab6ws=; b=UNYq18WUVXDVLSc5Zo
	AtYAXQcFBZHZXg4/IDFit6vyqJR87OKx8xnQffrMBV/A8EcBOf9Dmo5/CU0OLzlF
	knw2k6DGI2iXkcfXvgfantHba7exMB7TgCyr+biPpQLO7SzKjh6hTlQVd4BAqUfX
	h9g3PHta4MZYotyCUTDbw4E40=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3vy8J7+pqdSeZFQ--.24622S2;
	Wed, 04 Nov 2026 16:38:35 +0800 (CST)
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
Subject: [PATCH bpf-next v3 1/2] bpf: Add sleepable version of bpf_get_stack in tracing_prog_func_proto and tp_prog_func_proto
Date: Wed,  4 Nov 2026 16:38:32 +0800
Message-Id: <20261104083833.971911-1-yangfeng59949@163.com>
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
X-CM-TRANSID:_____wD3vy8J7+pqdSeZFQ--.24622S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr1fKw4kKF1kZFW3uF43Awb_yoW7tr4DpF
	9IyFyayr4kX3ySqFZxGw1DZFy5W3ykX3yUKFyxG34Y9r1UXr18tFy7KF4a9F1rur97G342
	93W0qrsFkw40va7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ja4E_UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzw1UzGrq7w2LrQAA3e

From: Feng Yang <yangfeng@kylinos.cn>

bpf_get_stack() has two implementations.  bpf_get_stack() passes
may_fault == false and resolves build IDs with build_id_parse_nofault(),
so an IP whose backing file page is not resident falls back to
BPF_STACK_BUILD_ID_IP.  bpf_get_stack_sleepable() passes may_fault == true
and uses build_id_parse(), which faults the page in and returns a real
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
prototypes might_sleep, following
commit 9d02927fdf4e ("bpf: Mark faultable stack helpers as sleepable"),
which did the same for bpf_get_task_stack() and uprobe programs.

The verifier then rejects bpf_get_stack() from these program types
whenever in_sleepable_context() is false: inside bpf_rcu_read_lock(),
bpf_preempt_disable(), bpf_local_irq_save() and bpf_spin_lock() regions,
and in callback subprograms running under rcu_read_lock().  This also
covers calls that do not pass BPF_F_USER_BUILD_ID and would not sleep;
such programs load today.  This is the same trade off that making the
faultable stack helpers sleepable made for bpf_get_task_stack().

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
v3: Add selftest. Update commit messages.

v2: Move regs onto the stack.
https://lore.kernel.org/all/20261102073714.1103088-1-yangfeng59949@163.com/

v1: https://lore.kernel.org/all/20261028093548.790977-1-yangfeng59949@163.com/
---
 kernel/trace/bpf_trace.c | 54 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2aec56d7f3d3..87f7758ffd04 100644
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
+	 * LIFO nest counter and cannot be held across the sleep that
+	 * build_id_parse() may take.  Sleepable programs never run in
+	 * IRQ/NMI context, so a stack copy is sufficient.
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

