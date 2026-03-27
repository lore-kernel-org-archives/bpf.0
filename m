Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE693F7864
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620986; cv=none; b=BVDQDmBhwW0kRifWmyaaQP7HDedj704FSZZVtGUGBhMUQlvwJYMlcbHOsSotWrYzZlu4LPphdMN57CiEAyORRoX79jXNFyiotNh4aMCgc9hVJTeQXg9VSBSObWjXhj6HtD0hYMwRlCfKTwoh+22/eZCGpuY4QsfsGHcXBZAG7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620986; c=relaxed/simple;
	bh=mCB+uW4a761n0d2aVwv1tBGBLpbO8o3tzqc2Q88DMSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APt/6Wx7jk5OGzohK6WrPlotasLnEkPO7n2XCO2QIo7OjTgOWO9PpxkzW2oqSuVuS0obP1MryGKYSN5q3ajhdreaoUmKA3XTsYes2oAidE5jvizFFNBMBA1+tC2/Yai9rXIj2qax3vzNsasa84BOIqlr0A7PTWEy6USWAKtu5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7PXC/Ch; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7PXC/Ch"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b0603ee486so13570955ad.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774620982; x=1775225782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI8/ynCoj9QXIX8q6/wyTK1N5QESD0qh826RNi2z3ds=;
        b=U7PXC/Ch3zV8dvp/VxQPIvRhLHyFzL/oy+H9Aej02b05/i4Ye+anDKZN2SxcldSVRU
         aleJIqVhpyr66fmWWxiRSVujS6r7hE4B8TQ6ifc6ZQhDzn7ueYIM/TEEM8HCyrVN6v4W
         UI8l63ac1s/bxmIuuqTmcy6U8EfABI6k4fV15MFMaqvIzC1OkcI6RzQ+TmzjK7WAc2Zg
         On3F83godTBHtduKMqrdCVSCV5a0lOE76BroXoLPHIfP2wH55lYKfoaNgxgms9YS3eEe
         an5xjMqSvhEPCP9F4/JytFG3HtPBTXVAjrudTkDHrIxAI/O+ftDFocT0EwtTpY9kuKRJ
         p3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620982; x=1775225782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CI8/ynCoj9QXIX8q6/wyTK1N5QESD0qh826RNi2z3ds=;
        b=FpevFin0IWtB2AhdQ08b0RZwjyKawQAEYfKH2KiZlP/jHivD4TPa6j+nM0UE5+ruB0
         My4qSZglzec85Kzdn6nSJcXYRF0Pn+5XubTHo0a7dwf2IpayAZ94sS9zCsAv/rdYq+Nu
         cPRXhJB5F6+4++ClDEzQIzCCNRK55eVHDzB+I0DUBOvrnXcTg2YTcXO+MkREXVCEOyRq
         fTAtCk4scsHAcB24C9vylEz674KgTKUWiLw2fVb6fPQWz0ptjVVTaTJETF0/3KwvZUe2
         4dpVtXuwlIz5B/TFxWCuNMPYByo1tF9nF/X4FMlebrxXhxgV8e35NvUvwz/Pezhv7P0s
         ifpg==
X-Gm-Message-State: AOJu0YzehK9cQVrXrgzV6p5BjOJr/v/4M80/jqsssjiCbyJ0sUSM3nqf
	r5T6EYC6mEJOQbIuu6eSywAnR9Moj/Jwa/USZM0u/jB3WXJu8Si0pMI9
X-Gm-Gg: ATEYQzx3Z3EgehfOlv7JaON/9VEEYp/owfbbQaM8rcwxfCzPA9Wh6I+Rmifl5zsj84X
	SOPBPEu7rhX5y3Q/8qjem08hO3pV+8jrJryZFtMch/mNn1WWG0Ef8vfN1BCXaznXwf4tvtTf7lU
	KGUmo4tPDXDFqFNzZY5fs80JQbYscgoT+VwTNmFzR8wagDy1aKHusR9yITnjhCS0QB9N8lpzwVM
	R4WQv2cLOysF9VM1rwVpsKt/a1l5/KIn9sYQ2TjiV6AxczcqGfvAH5tdoBUSqEOiw3kNgQh141u
	7AnIGAWXsZeO3yErGqYAhsCD128PMjapE3l7+LkKmr1GBLHMHzYI0PpyCmSQ6xcWOaTO5mkkOcY
	QqiM7DCv1NCOqY0e+BtkYNfczeWYCGGhsaKLMI9UoDjv4c/bB+7RRno6qwImdkj3nkRkktrOaFa
	wE0Dwct27huxfoyJKuxWm++XVfghSytojoQa8Qanb1HkB7yxDmR+r32zqMt/LXGCLQlDWSDgLb9
	aLSUpILId7KRl4cN1zHRHouA5V7LKHsvw==
X-Received: by 2002:a17:902:ccc7:b0:2b0:615f:9c2b with SMTP id d9443c01a7336-2b0cdd3fb5amr29434635ad.24.1774620982187;
        Fri, 27 Mar 2026 07:16:22 -0700 (PDT)
Received: from lab-kiba-ocxma-dut-01.. (191.68.231.218.rev.ocx2915.net. [218.231.68.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8e958csm61371365ad.66.2026.03.27.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:16:21 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	x86@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf, x86: patch tail-call fentry slot on non-IBT JITs
Date: Fri, 27 Mar 2026 14:16:01 +0000
Message-ID: <20260327141616.1961457-2-hayatake396@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327141616.1961457-1-hayatake396@gmail.com>
References: <20260327141616.1961457-1-hayatake396@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86 tail-call fentry patching mirrors CALL text pokes to the tail-call
landing slot.

The helper that locates that mirrored slot assumes an ENDBR-prefixed
landing, which works on IBT JITs but fails on non-IBT JITs where the
landing starts directly with the 5-byte patch slot.

As a result, the regular entry gets patched but the tail-call landing
remains NOP5, so fentry never fires for tail-called programs on non-IBT
kernels.

Anchor the lookup on the landing address, verify the short-jump layout
first, and only check ENDBR when one is actually emitted.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 47 ++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e9b78040d703..fe5fd37f65d8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -325,8 +325,10 @@ struct jit_context {
 
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
+/* Number of bytes used by the short jump that skips the tail-call hook. */
+#define X86_TAIL_CALL_SKIP_JMP_SIZE	2
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(12 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(12 + X86_TAIL_CALL_SKIP_JMP_SIZE + ENDBR_INSN_SIZE)
 
 static void push_r9(u8 **pprog)
 {
@@ -545,8 +547,15 @@ static void emit_prologue(u8 **pprog, u8 *ip, u32 stack_depth, bool ebpf_from_cb
 		EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
 	}
 
+	if (!is_subprog) {
+		/* Normal entry skips the tail-call-only trampoline hook. */
+		EMIT2(0xEB, ENDBR_INSN_SIZE + X86_PATCH_SIZE);
+	}
+
 	/* X86_TAIL_CALL_OFFSET is here */
 	EMIT_ENDBR();
+	if (!is_subprog)
+		emit_nops(&prog, X86_PATCH_SIZE);
 
 	/* sub rsp, rounded_stack_depth */
 	if (stack_depth)
@@ -632,12 +641,33 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	return ret;
 }
 
+static void *bpf_tail_call_fentry_ip(void *ip)
+{
+	u8 *tail_ip = ip + X86_TAIL_CALL_OFFSET;
+	u8 *landing = tail_ip - ENDBR_INSN_SIZE;
+
+	/* ip points at the regular fentry slot after the entry ENDBR. */
+	if (landing[-X86_TAIL_CALL_SKIP_JMP_SIZE] != 0xEB ||
+	    landing[-X86_TAIL_CALL_SKIP_JMP_SIZE + 1] !=
+		    ENDBR_INSN_SIZE + X86_PATCH_SIZE)
+		return NULL;
+
+	if (ENDBR_INSN_SIZE && !is_endbr((u32 *)landing))
+		return NULL;
+
+	return tail_ip;
+}
+
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 		       enum bpf_text_poke_type new_t, void *old_addr,
 		       void *new_addr)
 {
+	void *tail_ip = NULL;
+	bool is_bpf_text = is_bpf_text_address((long)ip);
+	int ret, tail_ret;
+
 	if (!is_kernel_text((long)ip) &&
-	    !is_bpf_text_address((long)ip))
+	    !is_bpf_text)
 		/* BPF poking in modules is not supported */
 		return -EINVAL;
 
@@ -648,7 +678,18 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	if (is_endbr(ip))
 		ip += ENDBR_INSN_SIZE;
 
-	return __bpf_arch_text_poke(ip, old_t, new_t, old_addr, new_addr);
+	if (is_bpf_text && (old_t == BPF_MOD_CALL || new_t == BPF_MOD_CALL))
+		tail_ip = bpf_tail_call_fentry_ip(ip);
+
+	ret = __bpf_arch_text_poke(ip, old_t, new_t, old_addr, new_addr);
+	if (ret < 0 || !tail_ip)
+		return ret;
+
+	tail_ret = __bpf_arch_text_poke(tail_ip, old_t, new_t, old_addr, new_addr);
+	if (tail_ret < 0)
+		return tail_ret;
+
+	return ret && tail_ret;
 }
 
 #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
-- 
2.43.0

