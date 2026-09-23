Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2C476694
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152942; cv=none; b=nCN4kSqgsX2yeywP73/jk8bZUn9+PcCmM8l5m0UVXUHVHDJoz4J91Roi5SiGpG+ZE3dO3d6dqjsMv2qjyekCooiNf8i0VQR32JrZoefO6q1lgc46BB05G03/KQ2aMauRP2jRGDm9APozoOLiCGaryJ0s3gzQMhRFppcwgw24IY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152942; c=relaxed/simple;
	bh=DOyS1CPECR94FS4O1jSftoS4FtluVkKxiJWl4+ZqPWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WV70XqteTQ75XcAQVcqaAcqKd2mY9w0SppMthBzkLxidHhT2uSoCKTxrTGK8WZ4wheCyRIXhiqpbeFQ/VmkcCAXwE2GW42HGOih+ZHKAxsie5orYhYRQ8on5MNVPnFnhNsF21GhveEem8XZ3RDaLF1r5VRY6S15omk/4p3G4nVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWrJp5Bm; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWrJp5Bm"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49b0dd21eb8so1166745e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 01:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790152928; x=1790757728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0MiYWv8nATX8UuMcrgTfEjfOZdAtVU5t6f1RtGnqyXc=;
        b=DWrJp5Bm9vZeCI1ssaHwk6b4sWoKaVhiQX4uhTor9SlAafQ2Gw/jg5dkVS9JDcpEVj
         8KAAf4Rv0mQ3qcD2W5eieatsCTHzeevl6PptcB5Zpsm/uFQkHXjXSBGCpZdjDxuHcMY0
         wT49cqfNhQsOkQnt1MPfvN0R28VPclrwH4U0Q+jL9sKL1SZjBDcteTZsK+nCCrjr7Cez
         2226lva4Y1VA0GQpxugdRC27gdPSzyD/4eJWcnyTvTEBmtsDdLxykMO4w9QmDU1u5ajZ
         ZkrAepSqssAvSUXZzPIl5H/EYQCUV+PdvVqz8sBKSPjuo3u7K12njTalSgaWL9+XfFJS
         tNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152928; x=1790757728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0MiYWv8nATX8UuMcrgTfEjfOZdAtVU5t6f1RtGnqyXc=;
        b=bDE/NDfsZFUns7P9IHzJhXGCHXRa3ugMzIQWYhcl93YHfAw8QFe8kNZSfm3u3F32tq
         W2HkZOqYu3JpebyD/3uVXAvMDkSx2uVsiRsSET7Kah4iKArlbKzCxYXzPQU+fuEa3z0l
         dt0th3MqoJi8usz0dQ30zIPGyADJeUm5FP3zUKo+FCgyx8b6Vaulx+Hrfcezt+1+orXG
         KT81eALjdctRBeduyRNyT1oMLpuoUDBMI5CLyQMjJRooRL3/w+qqYeb75bhi8wa8/u5Z
         vg1tvIn05HArC2EBuQKD/CybdkqNWzG7rcqneILcI6QI78OHMEBlOMEyo7P2oAMLM/qP
         6npg==
X-Gm-Message-State: AFuF++mrmFbROvp4JsNg7lWxN6fiWEq/AoLTJbnstNXIWsLZ8hYa3oh5
	aaOS24Gga2i+SQMJKdX+e3YR+KBGdIQbYFp3LfrNEt+5oYwH89osR2KeTimAejR2
X-Gm-Gg: AYBFou1cYHJH0Ci46c3JYgND3zGdiddFQXTS5N3acXymt36cacu6V+otLQbETOuS/X5
	o9wBmmD9fPT/q2ABF6kl057FkOIgk/l02y8ubsROLHd73GU1iDCB8f84iHc/mIHEwHmdFzYxcCq
	Vtuq+dU5nM6jWXd/Fy/DnpAoLhLynPgepksnv/HSXgL9QI2E+PTKTHXgCoijIhUzVZM0+gxwsKH
	2h0bSR3B7rsi8yYTTMON3cgwaFeP/z8zC4ubiCkXnbO1WU2tZI5DeWm22V0TV6yuK7U8KFYQ+8c
	nOcZi/WKQ3vrcgbxZy62UEP/LXx/Zi0132duD+G018pN0uJ0kWkaAzouy8bbmhPNKFq5SwkLVb4
	nGBsQKwRJN2nuQsX05CCbnLTO48SzLo4mXhKS/BTkaERx1jh/orT11aE2dyn6P75Tjpd/i9fwMc
	sy/A+/E+YPeLse1BrGMA70CllvZ1aTHOoPHD05yxlSJz+Gs0j8ZmZR7N+AUmXcbFQgkCiBCHjGv
	8Bvnaz2l3VcM3SgoGDr27L3qHgJcI1Rc2u9pelSDl5kUQoHcfUTtyE3lRyF8r+2Ic2OfW/j9MQS
	cV9i8u811gUF+2uUqpc0Wo4KVCs+tgIA8AduHi+VFTGgg2Wh
X-Received: by 2002:a05:600c:19d2:b0:49c:e42b:a4ac with SMTP id 5b1f17b1804b1-49fdf0fb362mr22979905e9.11.1790152928152;
        Wed, 23 Sep 2026 01:42:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c3731fsm43821725e9.2.2026.09.23.01.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:42:07 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Test fastcall rewrite with indirect stack accesses
Date: Wed, 23 Sep 2026 10:41:58 +0200
Message-ID: <20260923084201.2437625-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923084201.2437625-1-memxor@gmail.com>
References: <20260923084201.2437625-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5243; i=memxor@gmail.com; h=from:subject; bh=DOyS1CPECR94FS4O1jSftoS4FtluVkKxiJWl4+ZqPWE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvzhF2/JzRGVh10iZ9hKfbFrb0poVP25oYN005Zysddj 95k+lGjo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABP5Ks/I0Mz0XL+h6NJO2RW7 Um4f7vl5NvWglpLuYtMdb3q37b+depuRoXdq4fTvmYp7xJTWTP4gcpxP0GmW6uYtM0wN4y4vvjL ZjQMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add tests where a helper stack buffer, or a load through a pointer into
another frame, overlaps the slots of a fastcall spill/fill pair. The
rewrite must not be applied in these cases, so check that the spill and
fill remain in the translated program and that the final stack depth
still covers the accessed slots. Cover:

 - a constant-sized uninitialized output without CAP_PERFMON;
 - the same output in the caller's stack, passed to a helper by a callee;
 - a helper input whose only initialization is the fastcall spill;
 - a callee load from the caller's fastcall spill slot.

Also add a zero-sized buffer, for which the rewrite must still be
applied.

The tests only load the programs and inspect the verifier log and the
translated instructions. Do not run them: without the fixes, the
verifier accepts programs that access memory outside their stack frame.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_bpf_fastcall.c         | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index a73b837553fb..5f54f542a622 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -502,6 +502,167 @@ __naked void bad_helper_write(void)
 	: __clobber_all);
 }
 
+/*
+ * Load these programs without running them: removing the fastcall spills must
+ * not shrink the stack below an output buffer that has no explicit accesses.
+ */
+SEC("tc")
+__log_level(4)
+__msg_unpriv("subprog 0 (helper_uninit_stack) main {{.*}} stack 64")
+__xlated_unpriv("*(u64 *)(r10 -8) = r1")
+__xlated_unpriv("...")
+__xlated_unpriv("r1 = *(u64 *)(r10 -8)")
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__success_unpriv
+__naked void helper_uninit_stack(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r2 = 0;"
+	"r3 = r10;"
+	"r3 += -64;"
+	"r4 = 8;"
+	"call %[bpf_skb_load_bytes];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id),
+	  __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+static __used __naked void helper_uninit_stack_callee(void)
+{
+	asm volatile (
+	"r3 = r2;"
+	"r2 = 0;"
+	"r4 = 8;"
+	"call %[bpf_skb_load_bytes];"
+	"exit;"
+	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__log_level(4)
+__msg_unpriv("subprog 0 (helper_uninit_stack_caller) main {{.*}} stack 64")
+__xlated_unpriv("*(u64 *)(r10 -8) = r1")
+__xlated_unpriv("...")
+__xlated_unpriv("r1 = *(u64 *)(r10 -8)")
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__success_unpriv
+__naked void helper_uninit_stack_caller(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r2 = r10;"
+	"r2 += -64;"
+	"call helper_uninit_stack_callee;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} fastcall_map SEC(".maps");
+
+SEC("tc")
+__log_level(4)
+__msg("subprog 0 (helper_reads_fastcall_spill) main {{.*}} stack 8")
+__xlated("*(u64 *)(r10 -8) = r1")
+__xlated("...")
+__xlated("r1 = *(u64 *)(r10 -8)")
+__success
+__naked void helper_reads_fastcall_spill(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 = %[fastcall_map] ll;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call %[bpf_map_lookup_elem];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(fastcall_map)
+	: __clobber_all);
+}
+
+static __used __naked void read_caller_stack_callee(void)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r1 + 0);"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("raw_tp")
+__log_level(4)
+__msg("subprog 0 (callee_reads_fastcall_spill) main {{.*}} stack 8")
+__xlated("*(u64 *)(r10 -8) = r1")
+__xlated("...")
+__xlated("r1 = *(u64 *)(r10 -8)")
+__success
+__naked void callee_reads_fastcall_spill(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call read_caller_stack_callee;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__log_level(4)
+__msg("subprog 0 (helper_zero_size_buffer) main {{.*}} stack 0")
+__xlated("0: r1 = 1")
+__xlated("1: r0 =")
+__success
+__naked void helper_zero_size_buffer(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 = r10;"
+	"r1 += -64;"
+	"r2 = 0;"
+	"r3 = 0;"
+	"call %[bpf_probe_read_kernel];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id),
+	  __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
 SEC("raw_tp")
 __arch_x86_64
 /* main, not patched */
-- 
2.53.0

