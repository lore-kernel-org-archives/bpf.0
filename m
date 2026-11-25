Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577460;
	b=r7NYJcpadrvLEpw4Hf/Bw7yq/CcTAKguvuo5IeOIgQRy38Nebmn6psxewzy1fNLnl1Ct
	 wnzYy0XVCX1KFrnpNuDX3cQh840nPZBhjxG9gxqYmE+zoeTq9AHbdJJ2u9tE5t7xmtqKX
	 mlx5o+EXFVdAg3gNWdfzwUl+Bd9FGZ4sr4LiRNLA1wO4VVplo2UU/3ybXqrnjmOu6s0Fl
	 xovjBrykF1DJm+acJnxoHDqyfhOICEY/4gwhRQp6vK0+/eavWIQDhLq2NYmktIDMypCVV
	 qsXbsLNx84n6vMHbSWHto0okxJhI5MIyx/sB+kY+jJmRYaBAhStKTbhRX6iLsWLJ50A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oTME3xtjD1fA+Iidk7GGeMaMxMBMOSwmPQ4dozKmWo4=;
	b=KlJuM5EVM9dVmhVgfhpBLJmozMfHeBf0gRGPyynlvpio7xWTck85J+Dz2WYBXpLPtuum
	 DmEupV1pgLVyRaXgDpIMwqQOzpUNgvyLi6mdFJg8frX2VZsOhtbVlZOvpbFrdET9GT6U2
	 qvfnqNn/qXO0HV5uYbhjYZ2f5OkXlQtrYRI/Klj/codDt77/JV1R2Jm0OKiDmCV3kruEd
	 xsqvQMQskskDyUoiPRzMaFWlOsk9sjbdWMmIkmJaCS6bmc49/mftrBzSj9crYIChthx13
	 E6ykklG+2kxpGGeJiU1iIbB86CRI47kk7Eydz6pqhw9Ec1rIiP/PL/zjXewATXVOxlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxPTDHAZ;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8D606A32D
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BC8D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxPTDHAZ
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so2817604a91.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577459; x=1796182259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTME3xtjD1fA+Iidk7GGeMaMxMBMOSwmPQ4dozKmWo4=;
        b=oxPTDHAZGRIUmRmSMRF5AQB7qUeab++jspRZq96Vd+HRF+hkQHb3rh2DjZ+Ai3WTIY
         FZgKvBVv5UxD19Iry5nHfZr+Bq5h7nxH8wrT04SDdR1ml4MTBMxo8svoKDXpClklJA6S
         q8GWBk2yR2Y3zYdyb50gl1NtbMk1FDS7xU16XY9HDNcHmzYffbLJs8xUc8F6Cu5GmjwE
         8FumrPk01MDzyVQOGntjYGjttEtOsqObkttNOm01vf56VB0SJ7qM7pCaKZhZ9ARaW868
         5yBzuoCt0FLDfwcZIAPuZvtmbeSPk9JtNtDogrMJ1BCPhNZJDmHVSo/7J5Tlx/HrZCwu
         jx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577459; x=1796182259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTME3xtjD1fA+Iidk7GGeMaMxMBMOSwmPQ4dozKmWo4=;
        b=sLK+qMsM77VtbnA7fdQwbG4/GW2bD/MbW9XmOcrYAIXcB0US4jvqFaNrbr4/gnPRKA
         mZXnqEbyFumwr3NSJY1MyjFmEelkWAjl/vIekyYN9Ec7Hk6gjgFxE2+JS4oE7YEGBZ1g
         Z1cpZ5ZXt++usws1KwQejpo2VEklQ542n7KMPPJ3T4aJCkB7TchlZfuQYv8KmOLfQ8KV
         eWhpLS3YUU4wBA6TiAg16H5zWk/bWGYWDOYLrjgFivNUpgZ9jpumT3SP/IIsVuLQXmWO
         ywjgE0kxWE0LImBHv9N3Xg5t5BwG4ULEqpqfhOG+umT4VlVl7EBEnYca0dURAXYSq6q1
         UC4A==
X-Gm-Message-State: APuU4Z8lzg7Krdg0CS3sKBZx9gQXNrw8O0BVkRQkbWhxkSVnulTkC6Gn
	/dQwnUdbXb4kiiR7bQbZGXEHRn3UdIGqTAmTgkbtAiStrAeJqUs/0PavZHySDDSV
X-Gm-Gg: AZFdTZfrzcCp6c2c+sVWaDrenMOevrSI8/lAlAYi1lETsEB/g9Gv2zcRee85YKhmdUW
	DDqiwnEOpMAXrUtkIavCQZSsD6wR/4nKOAartGxj4c5fQoLdWhsxkm5rs9s1YXUcNpbjr2HIQ82
	bNltMAwwVs44Bhvy2Uc7dIK8O5xcPQuHEr6o/FtflohVcTrBZbOG9pcgxyXoYR/o++lEkKsVhRd
	VdV0igkS6ENnrZCueS4TaP0T4HyxVGr6BOg5PddR1Cah7pVHANWRKb7Kyv29mN/V0IQ8BWWHADg
	ce0PPL6R25G3kAGstMog6IqXGefHA2hv+RShAb8xiQjaKybH5CpEY1ZXtJLKBVCGUhcLOpiv7J2
	y4OWpcNS+VCXMLqYGjlZwY6Y8X6pvuFAJv0sjNzZRA3TyhPs2AAg0pg9Kb3YO31ycj/JoaV2djt
	aJ2DEhkOPUPZ/H7HkeCEYdEpnv9eLb/E1Yfg4OZLU9yCiav7BaZwe0Rp+QOsnBEfl6OcnyxIVeA
	pl0RShzlf+/Nc0HKYImtXZZCnkLAR6t/igU/xjDQ7rfw7asCdJFNmpfAntdueC7OPekjZkRiW4Z
	UfT30LQIPiOizuJtczstCXLpgcmZ2aUN925TpebHeV4h1KajXzEBOicOBksNsH/idkJMePZQrEc
	2yvkAZkIMDG+TVz4rOqzPTtW+cwnhvHI8QlohNa54Eq9B4uiQ5IZMGPDmQfIfpgZ8p5x337EN/w
	==
X-Received: by 2002:a17:90a:e705:b0:3b4:fa3:36de with SMTP id 98e67ed59e1d1-3b41c9750e2mr14199898a91.51.1795577459101;
        Tue, 24 Nov 2026 19:30:59 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4afeaaa84sm9729644a91.10.2026.11.24.19.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:30:58 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 13/47] bpf: Leave nothing behind in the frame of bpf_throw()
Date: Wed, 25 Nov 2026 03:29:04 +0000
Message-ID: <20261125032938.670542-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

bpf_throw() does not return. What is kept for the return stays behind.

With fexit on bpf_throw() the trampoline is never freed. With kretprobes
and function_graph the next traced function up the stack takes the
return address of bpf_throw() for its own. Mark it notrace and
NOKPROBE_SYMBOL.

kasan_unpoison_task_stack_below() takes the stack for aligned to
THREAD_SIZE. The stack for interrupts of x86-64 is aligned to a page.
A program that throws in softirq can leave the redzones of bpf_throw()
there:

  BUG: KASAN: stack-out-of-bounds in stack_trace_consume_entry+0x14e/0x170

It is the only frame with redzones that is skipped. Do not instrument
it.

Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
Fixes: ec5290a178b7 ("bpf: Prevent KASAN false positive with bpf_throw")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/helpers.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 749169a0b157..70330a7088db 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -22,7 +22,7 @@
 #include <linux/security.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
-#include <linux/kasan.h>
+#include <linux/kprobes.h>
 #include <linux/bpf_verifier.h>
 #include <linux/uaccess.h>
 #include <linux/verification.h>
@@ -3463,7 +3463,8 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 	return false;
 }
 
-__bpf_kfunc void bpf_throw(u64 cookie)
+/* It does not return. What a tracer keeps for the return would stay behind, redzones too. */
+__bpf_kfunc notrace __no_sanitize_address void bpf_throw(u64 cookie)
 {
 	struct bpf_throw_ctx ctx = {};
 
@@ -3473,16 +3474,10 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 		WARN_ON_ONCE(!ctx.aux->exception_boundary);
 	WARN_ON_ONCE(!ctx.bp);
 	WARN_ON_ONCE(!ctx.cnt);
-	/*
-	 * Prevent KASAN false positives for CONFIG_KASAN_STACK by unpoisoning
-	 * deeper stack depths than ctx.sp as we do not return from bpf_throw,
-	 * which skips compiler generated instrumentation to do the same. Some
-	 * architectures cannot recover sp while unwinding, so fall back to bp.
-	 */
-	kasan_unpoison_task_stack_below((void *)(long)(ctx.sp ?: ctx.bp));
 	ctx.aux->bpf_exception_cb(cookie, ctx.sp + ctx.aux->stack_arg_sp_adjust, ctx.bp, 0, 0);
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
+NOKPROBE_SYMBOL(bpf_throw);
 
 __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__const_map, unsigned int flags)
 {
-- 
2.55.0

