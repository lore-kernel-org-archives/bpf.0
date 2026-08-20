Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8E233933
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192427; cv=none; b=IziIAyOSMzNn/oKm0hICAV/RLfprL3u0aEiiSq/KM/s3d0Y2HFN2uxO9Thjw0/v3keJAuvimRtNbosz14W4xkq05dqAjpoR4S+qVPKEqJv8/zQhqp/9csKRPe4IFuDPE51rHFPrCbZ9f1MGNZ3D2o/UZlg/TYLHAJ+wIVXlkers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192427; c=relaxed/simple;
	bh=Dzi/Qri9K8kzrUG7P1B65Khs//y+qKQWm9Z8Oi7w2Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAtssC990RfQMzYnYbsNMaLHMnab4igfUnFmQQZsM9+sPYhxJRsYGWee1ORRqiWLFLJIT3rfVlDqAADLjY0WKA9lw0HGOy4t+D2i68mgL7x6ueYM8sXWy4RFs5WXutaT9L/PjjyzB858l6zx6eqN3t4um3B7QJPzyiTxdAd5Dvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SA473GSd; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA473GSd"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495482c36b8so6160035e9.0
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787192424; x=1787797224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7MbD8n6D3p5OaYoVZnAW7eRWJzTqHf+c1/e1AY2Rzog=;
        b=SA473GSdw4gkenvKfrUbqPejrw82cbE6FHLXtyk6pCeoScfkEnKE0Ng8GNf6iidn9f
         bnOjEcaIuwPWt0ltqPUw1c2J04ZjWOQehgZTCgOykY8EFkOozdsb1PvrS8Gh+w5qWcvF
         /t3IXfr4Sx19Y7EKvg6QmemO5Dx9/ZUHxWrSGcqRBl+wWTmVuJSb0W61FtNSViPvutyK
         ZHQr3rY76ucZ2N8vVdiy5ThSW2E1M5ZbA/1jmY1wrbdkryOlFfxq5WBP1Q6K4MAwuH6S
         1B+hyyLXy9BvxEmBOYClsCAFU2mu3js06MldNRNyta3TwET8ir9EwfUMa7PsrJj2XeXQ
         52mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787192424; x=1787797224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7MbD8n6D3p5OaYoVZnAW7eRWJzTqHf+c1/e1AY2Rzog=;
        b=sYEzTyoC0lSVVTfSNdhTDIVpVJS/Eme3JGHCH8wFhTBkkT8nvvRc/XXwYA3Da9glzk
         sCpbKv7MGpZifiwNRMw85tRDGzzVH/lPUe5/J6ajJ+IvkGLd6E5oxbJsouJsSFV2Hhmb
         JpS5I7IK8+7nPSqgkx6QgxsoD11jQk+RTbgShMUSIxUE1ooZHY2/wDEIxh+f3yyl08Fy
         Vg63zQai1VTwpr39cKRBRUoLMZq6Ya3ufLtW1Lmo919bDJZLY3F9Gl/3uDsDVecDfxnj
         LsCNux8RQsesT0jxjxPetWwnpITNjt7D/wo+XtZgFxsS51IMWk25KCoLeSLsT7SzXaR2
         mL9Q==
X-Gm-Message-State: AOJu0YztWT/WlXVfe/RBZXn7CeFJNZloMmJ6JrMdNUIdOqdM3PpmhdkJ
	Jbx+0FicdqThtgAj/pXa/lXAhf4Qbi/iWfvSmoEMWFxwgwAkXIdde99KdOC7/EtB
X-Gm-Gg: AR+sD11CxLmVrsQx2BgvIUmRdrjjapbO74HMFpN3vhhBgEbevOSBxXZoqIZouxAU8rz
	rY/ry+mWXEvls7QyOxM884J9dS4jK5xU0iHHgkQCW0aOpM2QOgFYhakbmn3p8Xt57yRG2Kd/QQm
	N4vHs1Zv1FDXeyfz72nKxViWhflXtHnWG8oZLinJowv53YI4SH68m+XP13HFA1GdTRhIxnT5Hwe
	5fx1p3H51Q9TH5UKlPLyacB1DfLGKUbpr1F4udOlPPQGNDqR1etzmy8ZowrGe8onbmQTjb6JQBr
	xCfle2tsWCzdRv5HSvkjOSAxd+Y3VrE4UP3HZaJn8hpR+fBEko0mIbFUX0o/Iv901ozYK345/Df
	mm5darqV0maiGOyqhXJcQaRzyjM3F47/qKULt6A5+SmE4v6Ev6vzJU/3p0nAImw6g3JGKmtTKXY
	+TZ37ADDtKhpDP4M8XZZtLaMX98/zsCFPiaCqHcu0+3sXTEBcH+VdbGuC+TYxFMth8tC1hoIM38
	43jcOY60X6mUw9Qgwkxa5h2qsQ0ONDp8ycBsttE8UaxScz/SPNVWgdxtQqkBazY/OP2uaHGCQJo
	RBRCSa7d+Lv6EAkGkt8NkzPGLPE=
X-Received: by 2002:a05:600c:3ba2:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499aa1a93fbmr171705015e9.10.1787192423656;
        Wed, 19 Aug 2026 19:20:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c46f2sm10880272f8f.29.2026.08.19.19.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 19:20:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: syzbot+3544d9b2a9206be8ba37@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Reject invalid LDSX instruction in disassembly
Date: Thu, 20 Aug 2026 04:20:18 +0200
Message-ID: <20260820022020.3450479-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820022020.3450479-1-memxor@gmail.com>
References: <20260820022020.3450479-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=memxor@gmail.com; h=from:subject; bh=Dzi/Qri9K8kzrUG7P1B65Khs//y+qKQWm9Z8Oi7w2Jc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIastReu9wJQzzrPKaut/CVo+P7bAPsNc/obM1utNSjf+t xy8pHSyo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNZ4sDIsLJ3puWWgwavWeSi vzk/cU4RWrL44jy1Se7St1n3z//os4Xhf+Wz6byPPfu7pX4Fm6/3OhfidTEyLelIwBdt3u0b3W9 m8AIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The signed-load mnemonic table has entries for byte, half-word, and word
loads because BPF_MEMSX does not support double-word loads. A BPF_MEMSX
| BPF_DW instruction nevertheless selects index 3, past the end of this
table.

Program Structure diagnostics can disassemble a malformed instruction
before check_and_resolve_insns() rejects its opcode. Placing the invalid
signed double-word load at the end of a program therefore triggers an
out-of-bounds access while reporting subprogram fallthrough.

Treat signed double-word loads as invalid in the disassembler and use
the existing BUG_ldx fallback instead.

Fixes: a8f427835394 ("bpf: Report Program Structure CFG errors")
Reported-by: syzbot+3544d9b2a9206be8ba37@syzkaller.appspotmail.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/disasm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 50b3ca5149a0..b1a3fbe3fda5 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -295,7 +295,8 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			verbose(cbs->private_data, "BUG_st_%02x", insn->code);
 		}
 	} else if (class == BPF_LDX) {
-		if (BPF_MODE(insn->code) != BPF_MEM && BPF_MODE(insn->code) != BPF_MEMSX) {
+		if ((BPF_MODE(insn->code) != BPF_MEM && BPF_MODE(insn->code) != BPF_MEMSX) ||
+		    (BPF_MODE(insn->code) == BPF_MEMSX && BPF_SIZE(insn->code) == BPF_DW)) {
 			verbose(cbs->private_data, "BUG_ldx_%02x", insn->code);
 			return;
 		}
-- 
2.53.0

