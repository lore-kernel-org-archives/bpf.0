Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747986;
	b=hnOG4zlhIZyMY0ch+7VgF/RFgVg0mzw9YKlM68IgfCXVwVbUr7lPobjzaF/gzIdXYX2S
	 eC8wAeV79UnrzaLMI+gFnxrIH0TmY7dK9bHPnQk53eKtnSNTY69oKOFIbtoE9LI/8HgAU
	 GFa6HtbYCIH8EXmi00catro5oVciZJk+rurTEHAM1pMxJ0ISMvxqfEFEgVW5jeiiG4VZ9
	 +BGHY8k9ke3h/YGVYT+043Lmh4jea0Mf+bpHnQpZCOOpQqFTMtbl3xT6KemBrt+KvaYUI
	 HaLb0JtZbO+6k7CGmXNMLlCxSYvGmn4gm0jhFm1vcVUjUK6+1LMyMtFhxHN4BqWECuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zmTiY3iYJOzEMQLaQl+6vWFUobfpyC2EOjOK1LRhSz4=;
	b=Ky9Y5IV/z1IgndQ/fFOprLN/IjTmZbJgg2f4cfk71jQ5VRLvLnyQfo9r/yZi7sqYYGTz
	 sSfytCLJ/MGNjHrXBf2S4PEPZ1eE1ZtLtvlciySWpmIw/x1iR9nb1O3AfZIndRpmBacBd
	 KsDwFf6lHLOmqRcsNzCykMAvp8hlmgvONidfLR3Jr7mfJZ/DuM4VkKgo2s7m64l/ojHAV
	 7cJLs8PjMsFLQXEhQU19k4//224tPkr8NpSgX8xJkOYGWzJ8dyU8u8dJUKVUdfaa06Jmd
	 Rk467/x4cq3KG98pGzmyy98h2WKL0o8G/nWCYyoS2cHph3AhGwHtiuBCIZC2bc9DA7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tsZUXPun;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A78606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11A78606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tsZUXPun
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso96177a91.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793747985; x=1794352785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmTiY3iYJOzEMQLaQl+6vWFUobfpyC2EOjOK1LRhSz4=;
        b=tsZUXPunrpjd1KCALuuDIrnfpE43ppAz/8zRcCO729/LjWhXF60uhH9fkrgF63vf/6
         rfwaB/V+mJ9NWPE62BtODJloIvCjjoT0C/dY3ol6nw3cJdCTzqChEbCMMG/RoCIs5nWf
         yoc8nSIFAdz+oZ9ply60fGWmWMsnU+rgT8kVep0oy60RUo1RD44p81A1LTxsCUEvUs6a
         LAL2LWl5/1aUdvwE/lhw6kogC8bmzB6+t5a9ou7VwlnmigTsnL6Dc5n2yIUAdWisl+W6
         C9I00TqEr0a6FYWf1+JwTqhso2+vVPEJ88QCyUd+Fy9Hps3Ha4ulI1uf/AZYtrnbEyeT
         HBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793747985; x=1794352785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zmTiY3iYJOzEMQLaQl+6vWFUobfpyC2EOjOK1LRhSz4=;
        b=EVTQDOUi5/tJb05UJ4FdrPFScHC1m85uF9NliFscNX1YFWMsm4ysE9VQ9Fe2PLT/jg
         951jMf12aYmXttQOP9NUHuZbt0cfzUt/N3XV8sy0gi2HZ/OQaeNDsJQvknRAx+HXaGpi
         kjG3d/ar37A2O2U26BlU+w04CBZXbZ9Hngw/N0eKtNS6S0LMol93VGwi7P5ZDaEChP6r
         Y2lUUEbgbCBxLgk5Vdkm1MTCfhDkgWVtsCh+38HckFzcXl/1Qu7+Gr8gPA771rEKitEi
         /Ixq4XRMG9XCXoh8Ji/7cFRkwA1SKQ9drBeAUvvTiIR8G+evSN/4XnzFoz/w5+94Rclf
         FyEQ==
X-Gm-Message-State: APuU4Z+1wuxoirt7nw8VoobNy2fj0P2FO27Dr3vp3BzRrKM927uTBCQr
	IxglkiddnPNkiQxupvMr4EZKiBhMJWQ4Vds/iLrFnCawFKyMBZOLhR241+zBKg==
X-Gm-Gg: AYBFou15iLgLDeYATJg6iljjd4EhmNCBo8SC+1pJGcO7otde3slc4RJRztrEkB2poi3
	gzDdWYLbL0nELJrG3VPHWw8AgoBqsJ4MS28wj9RhB2m4V245fuG/M/4f4Mw5qinWBrWeP6ZmMES
	gIHPHCq7fWMxM2e3uFkvNTLU69t/3XaUYWw8xDPk74MOUdiHBW9pQMZmdvSmdzQQ1tUU8B+rYVU
	F9DOiEBYlst2bxOL5S/vk57KlR0F2mK9V9Jddqp2bKTyLaRTQD0oHDCAGr4xVVrcl7AGKgvA8jo
	TaGM74z6l3tRAdiv0YY7kYAIK2OM3+LY6oWjnmQN6aRHkxACloeh+W0aQdHvVcORg6AlCFLAC94
	lHIqhc9Q9Kl6gStQ0bJQEejM7v5W2UWCF89uGkm+cU3shXMO0DKsRWkMLFvawPDuajmaJkDl9zA
	RQggsSdr/QFNt87++pQfWXRKH9MIu4aLDgUGZEWhxQmFrYSezYsCjKrvm/OXDVRdKnUOzex9WnM
	yYyegvCcE2sglpmiKrZRIn6h2K0yBpXw2vswU4Y6K5YG8khXGpkdjssoZg9ShasDIJrqnbzgVro
	bZ7Rb8N6RqpC92ud5CaPJP23lOX+ezOJhGhHpzk5m8jMx+j0S8Effe0sgc7spfWN6+dVi2uyQRr
	sGXuG1dQTMcb0V1F2seV1gwnoE52SON95LqvMgL94i/kwnEWhBsjl4VZ6pq2YN1KsCD0HGok2o8
	9dP5cpF85DDLQ7Sr6Z1efl
X-Received: by 2002:a17:90a:e7d2:b0:3ad:a270:a623 with SMTP id 98e67ed59e1d1-3ae8957452cmr11981016a91.4.1793747985386;
        Tue, 03 Nov 2026 15:19:45 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0969eeacdsm287627a91.4.2026.11.03.15.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:19:45 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/3] bpf, arm64: Filter user addresses of BPF_PROBE_MEM loads in the JIT
Date: Tue,  3 Nov 2026 23:19:30 +0000
Message-ID: <20261103231931.89739-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103231931.89739-1-alexei.starovoitov@gmail.com>
References: <20261103231931.89739-1-alexei.starovoitov@gmail.com>
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

A BPF_PROBE_MEM load must not touch user memory. On arm64 the verifier
skips the load when the upper 32 bits of the address are not above those
of TASK_SIZE. But the CPU ignores the top byte of a user address: with
a non-zero top byte and bit 55 clear it passes this guard.

do_page_fault() finds an exception table entry for the load, takes it
for a uaccess routine and handles a user fault in the prog's context:

- It sleeps on a contended mmap_lock in the RCU read-side critical
  section of the prog. BPF CI hits it in subprogs_extable, where
  bpf_testmod_return_ptr() returns 1ull << 60:

  BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1598
   lock_mm_and_find_vma
   do_page_fault
   bpf_prog_c3033363d3d961d2_handle_fexit_ret_subprogs3

- When the page is mapped, PAN refuses the load and handle_mm_fault()
  has nothing to fix. The load faults forever and the task can't be
  killed.

Bit 55 of an address selects the page table: TTBR0 for user, TTBR1 for
kernel. Test this bit in the JIT and read zero when it is clear.
Return 0 from bpf_arch_uaddress_limit() to turn off the guard of the
verifier, like x86 does. No prog is left without both: a kernel with
bpf(2) and the arm64 JIT has no interpreter.

A load from a kernel address now runs 3 extra insns instead of 6, and
2 instead of 5 when the offset is zero:

     before                          after
     mov   x9, x8                    add   x11, x8, #8
     add   x9, x9, #8                tst   x11, #0x80000000000000
     lsr   x9, x9, #32               b.ne  1f
     cmp   x9, #16, lsl #12          mov   x20, #0
     b.ls  1f                        b     2f
     ldr   x20, [x8, #8]          1: ldr   x20, [x11]
     b     2f                     2:
  1: mov   x20, #0
  2:

Fixes: 66e13b615a0c ("bpf: verifier: prevent userspace memory access")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index e99f105b7f61..b1d0840d26ba 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1966,6 +1966,24 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			src_adj = src;
 			off_adj = off;
 		}
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+		    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
+			/*
+			 * Read zero instead of user memory. Bit 55 of an address
+			 * selects the user or the kernel page table. The bits
+			 * above it don't tell: the CPU ignores the top byte of
+			 * a user address.
+			 */
+			if (off) {
+				emit_a64_add_i(1, tmp2, src, tmp, off, ctx);
+				src_adj = tmp2;
+				off_adj = 0;
+			}
+			emit(A64_TST_I(1, src_adj, BIT(55)), ctx);
+			emit(A64_B_(A64_COND_NE, 3), ctx);
+			emit(A64_MOVZ(1, dst, 0, 0), ctx);
+			emit(A64_B(2), ctx);
+		}
 		sign_extend = (BPF_MODE(insn->code) == BPF_MEMSX ||
 				BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
 				 BPF_MODE(insn->code) == BPF_PROBE_MEM32SX);
@@ -3503,6 +3521,12 @@ bool bpf_jit_supports_ptr_xchg(void)
 	return true;
 }
 
+/* The JIT emits its own code to filter user addresses */
+u64 bpf_arch_uaddress_limit(void)
+{
+	return 0;
+}
+
 bool bpf_jit_supports_exceptions(void)
 {
 	/* We unwind through both kernel frames starting from within bpf_throw
-- 
2.55.0

