Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C1566C42
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190738; cv=none; b=l8iOX7Px/a23EM8F4wOMFciaSsENM6f/Syx4FMdBeyytx9Rj4msbNrR0S0k2dAOp4kysF8ZYvts50OnJ61yStYsmtdons+cT6+gwX14j5I8zln0qFA4iSm5nx9g1Y3jILlGmSiD4rZXIEnq6AFo55WoRtsKITAbOo5hDscp7tko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190738; c=relaxed/simple;
	bh=PF2agR1im5ZPZeAS03gN8k6dD1AeSltvrW87xGHq0TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuUdtm5GXxjYRG6mOdTUe6omXYFTEeMRsOOWGV4dyrRH2+PnOKeMGVAFNbZ03LQeaT1bTckU016/flg3EIGFbCeNISll6fECPpRLYXwF4cpDuRipKTAXcnxv5SpFBx8Vo5dhuifygHj9z32natT1jVxgVAs97bmL+I0rWIEW/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qK97zKDg; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qK97zKDg"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49fceb35b5cso3646365e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190735; x=1790795535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dhq4nZR6dTo5Xz1NbB1HsSMBWtA7hgQyMAkKkJZYBkA=;
        b=qK97zKDgNnes49Tfoviw+O7gS+oT5z/jGVK+eNlhgs44620EUZ2yG1+WJcJqDa3Ati
         kA1j28PE1B5tXHOSXVTPB3nCby5PCr1RHJzhvZd/LdPfoLZw8Bqf/JI8KRHuSogWBMCX
         B89pXYzeACAt0/vNW19b0gGC9Z5fHUf95IXJEhAAqPHL1OlnFQdrdC1CqW53UoO5RH+z
         nK+eRVbN9CUBv+x6w91FSEtJ0sNegjFs6Ksryg7adSM1fK0/4V+H7m0R4B3kb3QQq327
         OHGQ7taa98bgoUVjoZmn4idgKVcn8V8P52RDDXyzl+E9a4FOju/RoGnXO0X2oTHyqwVC
         VCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190735; x=1790795535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dhq4nZR6dTo5Xz1NbB1HsSMBWtA7hgQyMAkKkJZYBkA=;
        b=BLDsfuaXiLDlCgqiwhNluG9IRL4watVPxtu/kMTG4+IWICsQZKWeFD2Y57DY7MBGPA
         cUKZbW4aYp0UOsjwqkEbMSO7lVAK8B1zY1B5TBYB5dSfAX95118YAtjKwQE//BOxd3Cf
         UsqIzQSJq1vgDbIu+r7PYEFKRtb9v+mfzRvQb2DaoJVfvL6oON38R3U6M/RnmPMpvBiS
         a72R1s3qBNW9Ri/KrEqDu+gZDbcIOejnaHSxqt2AMs5LsiJQBQE32lFIH7d49jLx2Qg5
         ncdkHBTLUTgkfm9Huua2O7CNSUQsJKCeUbd+R4B0uzy1GxV9hRYzePmoC5rLAK4XZ0T5
         mgoA==
X-Gm-Message-State: AFuF++nqyHifOdL3DTAeM4cE/UiYPX+SukCZgDZ/SIbcOk1phgtLx0/u
	Y/sZOmuk8zzBeAP2encxIf6cifEH13kLZCF+8Q6DBRoK7ccbCmZ2msc7GXu/cDvk
X-Gm-Gg: AYBFou3oAFWGBLjYSMMd6eps441ERCmOABk7XQ/91jtvR4ndvYa4FOuSnmNMp314X8M
	8VMQZI6gzVwvrNjN8/6jloPCioGudmkCA2ON5My4AFlhgTpiECH/XkcC2D+A9wk8/QV3vojEwjX
	VwN+/jRo7f/gM1gdVuwwzgvAMsZCnb5AUB6VwBe5L2SSDKRv9aGIqGMDWeybf8qPgmdI2Qy5KXW
	GGBPkiPiMSB8O4taRS+/VGz04kVN6bUl2KNBNo/Svei8ahr7xX2p3z8uKMBK6UQTitkxPD9ARIY
	KL/ylePJcTRhStDj2V6Cx9+ludZglvVSHuGVijxQl1riCptLKHwy23Kyc8ptIRA/mq/EfRgGDEe
	fa38oK9536psTyhyamN9pnhTJ8aChv3O7S5KBeBjr5Vxe9iu3Bvs/m361xgbDeXhvbcDRc4BYv3
	QAemu+/6fv5XLlCxMowU4c5btTAXntqN0Q3dMPVVoG2lxzkcaPKiZirWpv7oVHmSP4Zfi3v0k3d
	brycGkMVX0MLtBNVWSCTosQtyNJ+qqA4DJRkNh5TSU1t6RQE3Eo1udrVo0mvPMgCRO7eytIXtRY
	MHZQzGm1ETzz9Uk1pIhZjG58YHquBq77Um8P0Bg=
X-Received: by 2002:a05:600c:3514:b0:49c:fa21:e749 with SMTP id 5b1f17b1804b1-49fe67043a0mr2739565e9.31.1790190735541;
        Wed, 23 Sep 2026 12:12:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c4054fsm66361615e9.3.2026.09.23.12.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:12:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 17/18] bpf, arm64: Allow programs 2 KiB of stack
Date: Wed, 23 Sep 2026 21:11:24 +0200
Message-ID: <20260923191139.2816206-18-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2904; i=memxor@gmail.com; h=from:subject; bh=PF2agR1im5ZPZeAS03gN8k6dD1AeSltvrW87xGHq0TA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4k+fXNM7fgfeqCTnLVp2yv/GzmbBpKLT56wXJfJIs qkUL8juKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwETi1zMytMYdfyslLbpfdcGB Mw9/C/jMt+MLlUg5+OHTSm3paIM2c0aGKxeV1wvaLKsQsEoNn565WMnieu9157fpNts/VkdG9Km xAwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The arm64 JIT sets up a frame with an add/sub immediate, which encodes
up to 4 KiB directly, addresses the BPF stack relative to SP or the
private stack pointer with offsets that fall back to a scratch register
when they do not fit the load/store immediate, and a tail call pops the
current frame and lands in the target's prologue before the target
sets up its own. The exception callback reuses the frame record of the
main program and does not depend on its size. Report
bpf_jit_supports_large_stack() to give JITed programs the same 2 KiB
budget as on x86-64.

Tested on an emulated arm64 guest with programs loaded and run through
the raw bpf() syscall: a 2 KiB frame, a 2 KiB frame with may_goto, a
chain of four 512-byte frames, and a tail call from a program with a
2 KiB frame into another one; a 2056-byte frame and five 512-byte frames
are rejected. The selftest suite was not run on arm64.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/bpf_design_QA.rst | 10 +++++-----
 arch/arm64/net/bpf_jit_comp.c       |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index be5fc4ac00d6..f4e4a7f4f9fd 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -223,11 +223,11 @@ Q: How much stack space a BPF program uses?
 -------------------------------------------
 A: A program may use up to 2 KiB of stack, combined over its call
 chain, when the JIT of the architecture reports support for large
-stacks (currently x86-64); a single function may use all of it, and
-every frame of a program running on a private stack gets the whole
-amount. Elsewhere, and whenever the interpreter is used, the limit is
-512 bytes. The verifier computes the actual amount of stack used and
-both interpreter and most JITed code consume necessary amount.
+stacks (currently x86-64 and arm64); a single function may use all of
+it, and every frame of a program running on a private stack gets the
+whole amount. Elsewhere, and whenever the interpreter is used, the
+limit is 512 bytes. The verifier computes the actual amount of stack
+used and both interpreter and most JITed code consume necessary amount.
 
 Q: Can BPF be offloaded to HW?
 ------------------------------
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 6c04fee46876..d92d7754578a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2485,6 +2485,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+bool bpf_jit_supports_large_stack(void)
+{
+	return true;
+}
+
 static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *node,
 			    int bargs_off, int retval_off, int run_ctx_off,
 			    bool save_ret)
-- 
2.53.0

