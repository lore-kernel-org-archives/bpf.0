Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482973B8950
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236442; cv=none; b=H/uFvBvzP0Gy7SyT316A8WlxijfJ+6K7d4r3gcsBKGeKQ2Y4++6+eYsmOWOdtmRJiAVHDkZXD0mGCmvxqmfs73M4PobejQipYjDr9BC0O1BYxDwfZoyhXo8N9NwRbZBlGGeuOTaKxcGgc8vMZLezW8PgG0t8Pg+Xz0L+OHrc1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236442; c=relaxed/simple;
	bh=K4T2r/+yWGJyrtHppNXCDFzcDdLab7mdFu17JtIQpm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzhyE/sgpEK9Pa8JCp19SvaJwxUgH0dTfbzRvxqea+DOQRUhs+ZNFFjK9SX3LQ1wyhxu4ZNAXEQeUWvlDNZp/dojEhhibfOpcKrOLL4nWJLV08IP1SVjc0m9zO6FfqwkYkfXxErp8y7ZxkYu4uYITC1Te9mqW5dxT7EeW54iwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXiKAVUw; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXiKAVUw"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49814d35686so388855e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790236438; x=1790841238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nonQ2U9/QFHaERgf3oRsPVuMS149Fy+A2szR/ywmsVM=;
        b=LXiKAVUwBg0xkRdXQnbXBixn+D9lnz2CHt6gYwaFIP1DE+DV8xHog9f5DEduGQ2dYp
         d2juhYo1awKcluMz2jKjAiwpqEtz5G98TzBXxOXCk6jcHnMZpf5uDFOswoBRJwz1LlIk
         cCTbInLK5WRjReH6O7OzlcIsDhS6N3SjAmfa+ro2cmh+ohKajKPqwYTnJaij66Hhh3HY
         8BZAzJeJKMKmOAphmN8VtQovobFLe/I5GfWIPspoocGEkRz9h5RkiMXLYujORT0ZQ9Qd
         yR2ARh/HAOEIijfHTliVr3xfyXmIVQvzuVb98h9LZEtpgoDSt8FlwMDnfAmkjSh93C80
         /qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236438; x=1790841238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nonQ2U9/QFHaERgf3oRsPVuMS149Fy+A2szR/ywmsVM=;
        b=N7raSrsbIiSYy9hbhsfbixQOMYlBwgKcsNffKkTqHpreooQN7lkjcuQnGMqebrhYi5
         ejtXozOtlBj8z318Z1qhcWfLSL3qidVojFF1ahrOHYeSEHs4uK0my1O6P8oC72vHnD4X
         I85/PeOA+bXWqYCHlitzE6vfNmW+Wq9JtAQ4x4lPKJBLTwu/lAfhumg+slypSPNzjesR
         x7fj0HhCvjyFCDwMG7K5Gq7AAvE2kv4XEL2i6ZZxGVR6koAOAoKpAZ8ePzt1em8qICml
         OqJe9rSrQ88HoPtY8hgCZz1RNSTszkzHj1UiFVjU2a1WnqOiRza1RuY8AT9pKExQI4YU
         Cm5g==
X-Gm-Message-State: AFuF++no/zc211Z1A5sj0N4r0Pm5vBRnJ7JQhxsQMV7dm5gKa0vat3dW
	Agp6Vb6MPBbsIA25NAvNdcAuWV/Eq+sP7VQunIQJUPJigCAxnOXVkcAzj/vAtjwC
X-Gm-Gg: AYBFou0rA+o2QeujCdCLZ3wyriIzAh+oat1bY+b33oyX1vNKcnsfDQthUsV8GmEFfPE
	ILm/giE14g+V+r1aFrpZX48TLTv1k75vyd5mmCFVvVvT+TV/lso7ATQNoIFCascTPt2SZDFFLr8
	jeldIEm8pXoNBgbqRElig/7/8CbPuDVwyW53CZU7PzdMAQR+q4p+/uQVwV38hVubzxZRyWKe91o
	LU7wLhrKxMPuZxiKM/rOljwLsFKO3K6b51xlLS4fqmXCl8ZwEFrorVGz8Un1zB9/f9WZvTzgvL3
	YlSmNUh6zPcSYc3fg3UBSbFoGr/YHrAy+L4L3tZYWei5ynzP82C46/CCb6v+zLWk3fHqBdN212i
	XyrFnSVuDjW5EgvjSktiSH4cvkQ3u6IXZlCLCbKho6aolykF8khO5otI9fIuOsGnPCZE0enGWox
	evlmGrGdLAEDLh0uwjbb2TLCaKjIbKnyulLUOGPvrBDdBADU1OPv3bHrckzINmwIGs7SA/iiVcJ
	d2AbZdArlSG8dUGtZTKQvPtldUMTYrqQu5+yvwcT6b4y+mna9cXzGqU6sGQa4aKqrzKoMESg0Os
	2NVMp5FR+Ky8ilFrQtoIzRgjDI5k441v7YThbg==
X-Received: by 2002:a05:600c:4705:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49fe66d03b6mr26129375e9.5.1790236437772;
        Thu, 24 Sep 2026 00:53:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5bb9891sm42797365e9.6.2026.09.24.00.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:53:57 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test fastcall rewrite with indirect stack accesses
Date: Thu, 24 Sep 2026 09:53:50 +0200
Message-ID: <20260924075352.2343553-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924075352.2343553-1-memxor@gmail.com>
References: <20260924075352.2343553-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5695; i=memxor@gmail.com; h=from:subject; bh=K4T2r/+yWGJyrtHppNXCDFzcDdLab7mdFu17JtIQpm4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLtXOPfLjkvvioJyhuqfVjv9WU+6Q2tlMn68xZjmt+0 vPuVD7tKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERcVzAybDmdkD9JZvcNg0jt Ff9/snGm+kV3nj5X270k857uAsvaGQz/jEXqH9xa0zU3dv3tzz5TpfjTLx73un444G3Ooc266Tm KrAA=
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
 .../bpf/progs/verifier_bpf_fastcall.c         | 169 ++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index a73b837553fb..e0c389102db9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -502,6 +502,175 @@ __naked void bad_helper_write(void)
 	: __clobber_all);
 }
 
+/*
+ * A helper buffer or a callee's pointer that reaches a fastcall spill slot
+ * must keep the spill/fill pair and the stack that covers it. Only load
+ * these programs: without the fix, they access kernel stack outside their
+ * frame.
+ *
+ * Uninitialized outputs without CAP_PERFMON have no explicit stack accesses.
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
+/* Same output in the caller's stack, passed to the helper by a callee. */
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
+/* A helper input whose only initialization is the fastcall spill. */
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
+/* A callee load from the caller's fastcall spill slot. */
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
+/* A zero-sized buffer touches no stack, the rewrite is still applied. */
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

