Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2910943F8D9
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238405; cv=none; b=qEHeIv/kNpyhsWbux2/Fp8JCdGgIVl38o7/rA4O0alUXgXothIyv5Yf0EvNAhbN48SxSkHWovJ91Z/OrwYQRwgbpxkOBdtx5+rad697oBFCnlmtkm3D2sNKfEQIDTjzMyKTynd9QNTrci8jTFEdN3RYToIcfk1xegK0b2DNmCZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238405; c=relaxed/simple;
	bh=quYMvWUwO7boIXLxbD55gR9zkLwNS/IB5roYLQCyGmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwJ5kTIoFuteNFmhWoqVwhHwQvzOrGL0s6Y+7yheBX+duSdGe7KTJvfz9hwrZGK2I+7b5cIqIVzVYgOjGu/v4YLxagcRiOlRB0URmo5PtQ4Goaq2I9Xxr0OIzcUy3Rh5rKxIruFg+RDcbrrD8lTcE2LAQrOH9o7W1Iufi0WsUCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTm1nxlL; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTm1nxlL"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e66652cc3so8588265e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238400; x=1790843200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eVQ8JEms7POvUUEQGlzf25XejAcIwzrSpES6KFXciMA=;
        b=JTm1nxlLzTZ3wHe/N0LbLI4txU+PRhxzZ7HkScu0IC0AAG9KUiv6mreHhTPrKKUXXk
         sGSL6eMNraRzGHFAG2ZRDAjYToVm5H3RBOPbghz2aukuLJLaLTaDeQ7YMDiQwYJ/YpKV
         /k4pHLWUEQ9V4tCY8Eyq6zvZbOxWIeaZt6WZsdu8azWFVtFYnQz28IoJrU3+J+TL+CEV
         27k/dghu9Ztwf2L/WwvaCe+ilbAusvybMmj/tHuyqMJE8PMdBBPQXvzrwnQEP0aYYhuh
         qoKP8P4oYHEbAFLFZJGoBxMMkgp+ELr/bLPTFu/bESnIpMVtzyLpfPtxo5lWfdKVPozH
         3Naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238400; x=1790843200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eVQ8JEms7POvUUEQGlzf25XejAcIwzrSpES6KFXciMA=;
        b=JwawibyEVufhPPJRIeWSmnZo96tIHf+EH+zxyKmiquqDS0veMqcQNwfewYkTGSuq9n
         xw9sb/Ky3GE5BfUpY4+Rhb6Hag83cxExQ86tzIVh1C3Aq2Map2Y4wHMLYOO/r7obESnU
         BV+252yU1+mzqaEpggxiHDA2+a826ipH3IYspZisqKTY5WO+ldATfbSjG+lXQjEwGPdn
         UF1ESAI6mzc0INRgKkS4WY9Reoq2Lty3gPIVmr9eausr4n2c9cb1RsoW9B90rZcLxcwe
         LZQiVYrvsitXSLHfyAaO2a2PJIvHOYpPt1OeJzEhjs+vUjqqk7MeLdYmaYgMZg8WkDVP
         CDbg==
X-Gm-Message-State: AFuF++kVtq1JQ02WXYVT2QjhAg5owoPazkBeqLnzV5/B/vjXlsBVdhuE
	T0KHMgowIve2A+G7WwDEBU1agPjlR1RieHZBqErQG2CGKZ8PXCXhJbINFr6ON5lC
X-Gm-Gg: AYBFou3GRfb1bnEXEBueLHataiddAwobMWj2NwFlVs6s8juZZNFklBSL3vxd2KXVlac
	nbnxSLWRUPMpuJNoeB0xej7dmu38ADcUhLElk1wYJDT/TO4UMqQi2JFnfGoZYbRKF4rbhT4HfUx
	oWJiovG4Bbs+0kcT5cdHABGZxiva0NizzxrQ+iYsl0ytfnpWekGSqp3cOm99ZZUSJs5SL3V5MWp
	Oyeb7BE2C4G4OWTFUqIJMCBZNzUH/CGmnic3ALhr3vjbUU8E9mRPx/7zHOyhsjGr0c5/ZkkwSBf
	qdMH8hq2UQz/0FoHuyl7dkIqa5D4A0bnoQUoLlHdugvQKySSetGNRD1Hj7O6Dtr61zWaYaW4PiE
	TOoiyuJ9Rq6x6jBajWa4uVtGGQWHz4Wzd1VDpvb7rGwEW/rqhjzbMvaMAB8cngjIQ1EasLsdEkt
	wapqI28CPsIcwHK5UQ3twsqv/dVsYpkKf4ykTZWtJUFuPOQvrHGgmnRXuSSf2zEReg2OdShEuaJ
	Kk/98ThZbbLux7wcGQXxFyo/zu1EqHCGGdnKkxSipsXz0O4W6HpcQ+qzEqiFsecZPCCUoqXECTX
	es0DHYpgNeaUfnzVn5EojatfFremnJCYm3yOAGojNBc4B4PGbg==
X-Received: by 2002:a05:600c:8b22:b0:49e:6fd2:a45 with SMTP id 5b1f17b1804b1-49fe66d81fbmr27642775e9.16.1790238400173;
        Thu, 24 Sep 2026 01:26:40 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5ce4941sm48297445e9.6.2026.09.24.01.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:26:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 17/18] bpf, arm64: Allow programs 2 KiB of stack
Date: Thu, 24 Sep 2026 10:25:53 +0200
Message-ID: <20260924082607.2695649-18-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924082607.2695649-1-memxor@gmail.com>
References: <20260924082607.2695649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=memxor@gmail.com; h=from:subject; bh=quYMvWUwO7boIXLxbD55gR9zkLwNS/IB5roYLQCyGmk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLvTS39n8zFEsn3nWY8+Jk9nl23sOzZdXaupPP7J+30 jq8QMCro5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABP528HI8ElBza9cl03k5a4V 6xUC0p5VlxtL3X51pbyJL1Dk6zKldob/iZ+5WLo3x/Okfzj7M66HIeL26VL/ULuJVR8dtzvPeRH ODAA=
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
 Documentation/bpf/bpf_design_QA.rst | 11 ++++++-----
 arch/arm64/net/bpf_jit_comp.c       |  5 +++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index be5fc4ac00d6..98d70b8a2533 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -223,11 +223,12 @@ Q: How much stack space a BPF program uses?
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
+whole amount. Elsewhere, and for programs verified for the interpreter,
+the limit is 512 bytes; the interpreter itself never runs a frame
+larger than that. The verifier computes the actual amount of stack
+used and both interpreter and most JITed code consume necessary amount.
 
 Q: Can BPF be offloaded to HW?
 ------------------------------
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 9544b2f483e5..2b2d6d178ea1 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2501,6 +2501,11 @@ bool bpf_jit_supports_callx(void)
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

