Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63A33F54AA
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267541; cv=none; b=gHmM5vRYnArkibfQ4mDbukncSiJHD3/SeFHGT37tr+tg0Jbhc39vpcp2dxTlM1cdEgqjuElgDYk2BvjcFyKugKdv//SR74kccE7wlO0iNGzwGxSWhJcSPNzBVlBjAj0sXNrnPAhWaIte5n8xIRjpj8KM8Oe0h4IgMASZB0TH4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267541; c=relaxed/simple;
	bh=quYMvWUwO7boIXLxbD55gR9zkLwNS/IB5roYLQCyGmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPSsNUdBFDOOZp2J/GGrQRZTkIV4Dh1rfnOk/3KvyeLmxkjeW5MU9QsUM44OGE+ax6IdOZdG3UOfXLOHfqYK74sscBtqTNjLl+pTMwJ2oC8WKgTStRFHxH3d9YS/8D5NcCwMx8z7hYyKt1nfSK97AiRFIKZXvnKCxvRy53yM+HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHWaj/ZJ; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHWaj/ZJ"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-484392e3450so1263f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267538; x=1790872338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eVQ8JEms7POvUUEQGlzf25XejAcIwzrSpES6KFXciMA=;
        b=WHWaj/ZJ1JryYtzrITvDONDWRcozJELw6zFNRM/e+Qk6IJ82JKgZKPQFzcsf0TEBvT
         SERwNXkhDDYx1dd+EPL4AzHNAuEEhCIwk+Sy2mD17gMd9ErO6Y8BAqA3yTfLIxJYsNCA
         YmAiPO8bvZYylhttsMD6lOzIJKMG1p78ckeoCZ2I/HMAZafd7ku7gqVra2lnXhsD4SiA
         39EF8unFIeEV23IhnJCswk7lk0IQ1jJVnQL1dCBkJiGqnPUOtsaJ+rvYo4itPBNHPeKg
         bmynGUWDhXvg8oKqyXhBO7ybc+zkHY/KkVdKnnoTGIhgkf11JRCPBdbs77W1jLt0jAOo
         M8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267538; x=1790872338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eVQ8JEms7POvUUEQGlzf25XejAcIwzrSpES6KFXciMA=;
        b=Is17+OVp/wA+AyRKFLAiuhb/En9uv27bR9TEtDsxaeS8OAOSfCr7pM54WiXMSLKW7+
         8/uxIo3J6TWklux17SbyAYah5ay6L22rCSwEy/Z2/a+soHiv28g7dKTaimD2tHl2u2U6
         u9dvzo+dPmPMjNasLOAtquOZvjMXOBi2p7CMWG+0KR71zc2oCz6+QSOfS1AHUXVwCCu+
         tDhdrlrmMtSEv6A/2zrMGmk6vaI+mjFIIOgzqakWa13Fx9gM7BG91QELhpaHt2em7BCc
         AHkUw0+H7q7j3Bi5jBHwIC1OPyatEAaHyxMxT0/0SQbab10T24oAF7JkZdgSA71DbonX
         S57w==
X-Gm-Message-State: AFuF++k3vgGjt7nUixODANA5y8bQ/SmGDn9QtyKji5mTcD4DnUWMjtBn
	k4sJ+Ol9AzB7fR/OFCFwP4K7c6QRuRItzeLRs09+mBrcED2lO4Zyox8+piAL/ghq
X-Gm-Gg: AYBFou16+zuJBKRZlPXCp1kKYKNADPqK67eWX8Qg+rHNgRcbjPwwrU11+fitdix1C2T
	VxYEU/7d3znEl3gaph9/2Qu0GrxSpjljoaHygL2w8sO7t6Qe/y0m5xqkx8MnrY847xd1GnesCu0
	sV0wN9J0YeEtsMq65zdNYqgtj2z1QEz4wDch59uRQ5tqmGaDhGeNAT7nTPVjY3UwJSoohJNv13B
	KJ1yOXCjLJuUCYB98hJwYrvc9V5hR/zW/opGbinj4ojfOzatpPEWh5CQXJHkNNmwfmi4z2dQBga
	nbUxI2ZrNglg6+IPGYhceiYgYEn6ey3kUqf+oSGsf0bYHxe8LUY4Qp88F7GEkmPy56WJtU0BRC8
	tklrCqM+Ee8xdx7fORmdwekTRzsYw1hXHJIPqGHVQ77D/sVwQJJ3gjFGxmV4fEsXd/MnJunJdw5
	DAc//aF+q55ZvEr+6DSOX33jHR6+AWpeRPOns4XXVJqrSRTtZKFXXL0w3rhxVyObNBTC+OrVKc6
	MSbg2pmglL5+N6eXh2feyTxYfiMiO5tQ3fWEJPc371YV2I7ty8i9n4RZtWNL81wXs2ZBeTWXT6V
	Lhkxn/P9jWsm4p5H1MUwGql8OOuGY+a659ecBg==
X-Received: by 2002:a05:600c:c1d7:20b0:49f:e897:b62b with SMTP id 5b1f17b1804b1-49fe897b890mr32580155e9.14.1790267538198;
        Thu, 24 Sep 2026 09:32:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee915f3dsm173315e9.1.2026.09.24.09.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:32:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 17/18] bpf, arm64: Allow programs 2 KiB of stack
Date: Thu, 24 Sep 2026 18:31:31 +0200
Message-ID: <20260924163144.1945455-18-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924163144.1945455-1-memxor@gmail.com>
References: <20260924163144.1945455-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=memxor@gmail.com; h=from:subject; bh=quYMvWUwO7boIXLxbD55gR9zkLwNS/IB5roYLQCyGmk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur7zu39n8zFEsn3nWY8+Jk9nl23sOzZdXaupPP7J+30 jq8QMCro5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNx3sLwz6B9QXT0TXNf7Q8O e78UTPdo5Pgbw7pRnfPk+sDQ+jcLjzMyPHlltEvAmKvbpCm0f3Io641sR72Mpimm1prr1z3hF3n OAQA=
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

