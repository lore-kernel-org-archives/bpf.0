Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577600;
	b=yvhzKLWURsHbEMDaY9mYzcHpu51eMCysBQ/vD1GB65JUQYvQx7Q/D87htwWVdcQxStiC
	 A1JaWuxjGYpuqSp0pPPBFaXF8g7xn53ss2Ry7wSp3+ynrWFkiEtMo0Ulgc82B53AToCDB
	 uwAl0oOHF5fTzrgI0nnr4kWNT/Uby4HMtoGHokJkm/4u/UPBioi5MZeK2qKsfGiJlmHG7
	 rHmXRSOjz9hfe7aG+s7e/NfwoOyW5+0hsJ/6VmfVgSXOdcEpjoxUF3OLBMpZsCxOGK9/y
	 FmOTuElf6jNWKIUdpPVtmrgGhgInLak3E21eEmpW5ZYjbn9Me3iK7cjCK6UJzHV3S4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k1rvGbMTaaJoWzjI2ftw2k3Ldej7kblyr58x2NSedzw=;
	b=SxEDJahBWCsrLnWP4efbS0u7Zk+1i2GuJs4ptd3+vnZlzV5roTzU2DYfglub0RY/G7Ly
	 Im2sHVCx26BPFCd7bH7d1cvgvZdeIVXRccLPdByXJ0AnDBsWONKQaBs3Vs4fZdF4c52M9
	 Bg0oJLThsJyxnqfB4Xlm1OTd5S4sg867DdNFAGPykzUwh10kXTTye57y8+8aXPDztN84s
	 i0E+P32FziIni+aJA5XyPOh+4jQC5mxx4W8Yg/8XHtonoDhWuLG1uTFUC21fZUSJQOiDh
	 2X104t6QMiz3gGokb29dH06lUXLj/1K3iHWKdO14+rwi3/1sE+PuHsk4fAlGcvYKygg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a6q0Wxlq;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3A606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4F3A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a6q0Wxlq
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f0464dd6b6so31541475ad.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577599; x=1796182399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k1rvGbMTaaJoWzjI2ftw2k3Ldej7kblyr58x2NSedzw=;
        b=a6q0WxlqQjuxorWjuCo8kxSooE7gTX5voH7ILZ4rspjOnPeDl5LiM+VmOsqfzsZvyk
         TW8klSu+PmfTLO7MQhWL/2qqYOrFhdeqkWIg0MaqlMCESIEQlEl5mNw1iCqFcjHleZMW
         Kj4OQF7WkeX8yDCAVm3XEGzsWY+C1N5XUmL9VHHoUfXC/bPC23Gc6ui2lkM43AHPtoio
         ALLkUAYX4zNGBSB86Qxi/FtQBK+SgN+TomZr86QhZwp5uSJAblEf+EA/8J8KNRHqC342
         Ea6wImdJt0po68KUbhSaJuY9UPx/dQ6dMUHVUq9Ke9k1FKMa0uBanAjeysheF2ydSexH
         WAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577599; x=1796182399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k1rvGbMTaaJoWzjI2ftw2k3Ldej7kblyr58x2NSedzw=;
        b=mJtU7XbUYio3cum7/mG9Q1XClO4m3CWBkfkkW1N0qVvsC4PfAkAHC7Siqf+Hq8ldkw
         btSLNhxdvwpQ/hm2agY9I6aK1ZkHDweHIY57rCUDV9b1cH1UbCz583QGsZOGutIn4oDf
         pclRLVV7kYeTBCZeEjG4UdnBis2Sr+jTsC2i8/fhO8iIN0wGEGm+Ad4QUNz/YDNQ9M3J
         a/lJGQDCWb2KIsZlTx+RDnAKmdXT1xAsiJdIa9oTrfNEpikoxAC/qGAusa0gvdPykWWW
         BmnpOH9CX1tMBf8ZEiDvfb2aTt1T66Xfgqz6L0fUgFrlK+vFLDosCODdlrd6+0LIVmHv
         NYQA==
X-Gm-Message-State: APuU4Z96qHN+9eMJagqxY6rB2ezPYWoKkFcKGM8GPKV4vdOb0VlLSuEe
	LRJ5hAXziNtAMPRBMwjG0g4metVbP8dUpIgJ6JeoPSwRZHL98xNMxAwZGnT4MjwF
X-Gm-Gg: AZFdTZd51OAhl3TSS1NDyFxBsMbpFbx2N0oq6tv4NZnPzPL+XCaEcxLEvwQrDDmSWPR
	EkgIXZM6odW2s5UeV1V2GG0irqRVf5JO97E1N06CE0Qh30cF+oMyHds71qzFCvR1sTuyMFWzRG6
	TkwG9FXoc5cwySmfF6QgtOGQ3gPb2Z7mzvBnf3KJ3o2QwB+7hqxwJnY97/v8j67dSYARGhSBsYY
	F1nlhehLmNhKe5a3Xrvlvp/u82S3EmObnjyOqG4XYqNYzorSp8K3FTzf/uT/d/LtV2mRVFVUhF3
	bSwrIkhI5l1iPPAD3GiAo5+g2B3RDMg+0aEekO0333q4bzFtgnDs/DZK5UgWbKRFb5v8cLATCTZ
	uexLldC3CGZ4Jy+KnqjDLa2NZ8XNrYAoYEfRSYNqdPjQxVMCR6U1CCsDFKK/9i+jG3kbkor+T1E
	7KZNG3kGSFLQMxURYaNZcDj8rvdL/W2VBRPlS6W2yAuy/IJlAl/U4DOmfabcPMC7w/ws2wJ8N3w
	6JsVH8tX+ew6BjqHgYo5plM+cqidCZKYsaPpFdMgutsLVnOEmlFEyTHq/bKkEUR5qMBafkP7Rxf
	BYOHjmMxkK1VgQKsOdmaQf92P3/3rVETTJHufMDhET+R6sf9fnk0cyPRVfTSH0+/MGRiQuUOs8g
	IuevdVZF+AKYisZZ1kK/GPkS9y7YCrksyumftqK5DXFOU363K85nIb5mKyZJgWkzKvaan4Dhf7R
	q1
X-Received: by 2002:a17:903:f83:b0:2df:8f19:5db8 with SMTP id d9443c01a7336-2f03f1d09e3mr159326965ad.59.1795577599005;
        Tue, 24 Nov 2026 19:33:19 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0bc695f31sm20295845ad.49.2026.11.24.19.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:33:18 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 37/47] bpf, arm64: Restore the shadow call stack pointer after an exception
Date: Wed, 25 Nov 2026 03:29:28 +0000
Message-ID: <20261125032938.670542-38-alexei.starovoitov@gmail.com>
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

bpf_throw() does not return, its return address stays on the shadow
call stack. The caller of the program takes it for its own.
test_progs -t exceptions crashes the kernel with
CONFIG_SHADOW_CALL_STACK:

  Internal error: Oops - FPAC: 0000000072000000 [#1]  SMP
  pc : bpf_test_run+0x410/0x968

JITed code puts nothing on the shadow call stack, and bpf_throw() skips
only frames of JITed code. So that address is the only entry that is
left behind. Pop it in the prologue of the exception callback.

Fixes: 22fc0e80aeb5 ("bpf, arm64: support exceptions")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 7 +++++++
 kernel/bpf/helpers.c          | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 33632fb20997..bee2d3f6b868 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -15,6 +15,7 @@
 #include <linux/filter.h>
 #include <linux/memory.h>
 #include <linux/printk.h>
+#include <linux/scs.h>
 #include <linux/slab.h>
 
 #include <asm/asm-extable.h>
@@ -600,6 +601,12 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 		 * 12 registers are on the stack
 		 */
 		emit(A64_SUB_I(1, A64_SP, A64_FP, 96), ctx);
+		/*
+		 * Pop the return address of bpf_throw() from the shadow call
+		 * stack. The frames of the JIT put nothing there.
+		 */
+		if (scs_is_enabled())
+			emit(A64_SUB_I(1, A64_R(18), A64_R(18), 8), ctx);
 		/* The callback may use its own BPF stack, set up fp for it. */
 		ctx->fp_used = true;
 	}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b570b7314ab4..a0fd6bdb3278 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3474,6 +3474,7 @@ __bpf_kfunc notrace __no_sanitize_address void bpf_throw(u64 cookie)
 		WARN_ON_ONCE(!ctx.aux->exception_boundary);
 	WARN_ON_ONCE(!ctx.bp);
 	WARN_ON_ONCE(!ctx.cnt);
+	/* arm64 drops one entry of the shadow call stack, don't move the call to a callee */
 	ctx.aux->bpf_exception_cb(cookie, ctx.sp + ctx.aux->stack_arg_sp_adjust, ctx.bp, 0, 0);
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
-- 
2.55.0

