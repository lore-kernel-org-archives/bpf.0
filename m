Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B806386552
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759772; cv=none; b=lNDKXhieBxKFA3jd9M4CzdVF4QHna6AvtBxs3HfpZVrFVT800WdB5j56yp3JN8CGQu8lRaWxfHVCc/EsMKmbCsTq6gAJhbwITipLWHlB9uq1ZC/H9jIMCLe89t2/CoH1cwlk06Iw/3l3v9x+PoJ6n+jQx85QbGszjlttivWb3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759772; c=relaxed/simple;
	bh=L9Q7H6XzdldeK7oJVUx64Jc4Oyk5d2RSK8iopIFNoWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+TCcrZSNRBXh2LubVA9tI3ZPC6P7Q6/W2tTLbkzGOO9eKjLogsarXMJ+ciGhF4HcWli5hpPjGho7Xcp78iC39zeOzgaFTBHKkJVNdH1b1YT3qvdnoeMdFb9NOxLtBMJGn1S0IPGHg1+ccWqAaRk77UXhRKL9HkCwCeNviFjEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGKiPRlr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGKiPRlr"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d94c868ea5so31916705ad.3
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 22:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788759771; x=1789364571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVyebJSrPANro9+ZzIJ5GUMECycDoWkIReTgM/W+/mE=;
        b=pGKiPRlrCglX5ZlCCX+8muWb1y+DK89kIAfAtF6w/pV8fWmI+kwlRAzL1fH7QObWJ+
         zuLN3biM2/1oEGi17JfIKa+5IKe3/2CJlyIgsTSkNhHAodz8ARzpIXhMHKnFlQn8RaaZ
         Iu/Ylrp6C9TQwQOJ/J0YmEcVdwLrPVPm3Z83iak61AQuNeAB2nFmprPGE6QQjPPvkCjp
         Fflfra9EgDytmgKwSx71OOm4aPxjGx8DMm6kX1no30TuQ3Y3+nHoVHenqGLgFYpagw2S
         kdPClZGXzs+/fU4MhNGwSM4gATfUmKGdCxNJXvjOIS+PVdyeORtxG5yabPAmEvnNTMP7
         jGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788759771; x=1789364571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RVyebJSrPANro9+ZzIJ5GUMECycDoWkIReTgM/W+/mE=;
        b=hucUOe5hGE3awh1bemyDTIeE1qXZM+ZjWh3TBEmzlzM+2nlSxTEIyOGdwYaKgSwJTx
         M4FtjdBIZMp9rrLIripWzelMHjbbOc9zjNyX55nnKO180so0gv++66yQQXD6N92RTWg1
         91XpfPTKeqbXE2LsDf334Rlop8PDhbyRb8ifO6AWbYKN3Cybgn8oUScPC4wTtEhvJJFG
         IjekYwKJyXXn7Lx3NWPIgO2ebfTVq0ASXYlSsJKnoIPkummmTcTbIe+gizabtgTSYLWg
         bcvafikPYdbs5pFTiV+98x0ZT6is+Qw41ekGK4yp0IKVbsHR6SBM5p7ju5EBer3qaf7P
         mCxA==
X-Gm-Message-State: AFuF++lLh4bk7TFAVLzzyHaRbO9SseZledM0BxUxptCXgfq1w11FCTWw
	SM1YaigRpAu0aDMHVboj1rTJagrGj3Z257yiwWeDsux7JL3K7lYUIPA=
X-Gm-Gg: AYBFou3mLfy7Pek/ym0Xp3D/ulCkqoS6YekHbEAO1Bi0OK0HIh5lHWxe3EsIVlBn7Q8
	f/T3nLadNOZncJKupWZe0E4uFV6+CGYN8I3Yam4x79y1GQAKE6PKICA/SibvGt27Fncpzrto4hS
	+HG9KzjZBcLU4VaRyIiaAZNw2Jv4FBeu6s9f5UrTW1HLJQGYD3NH2t4wex3YIZED57UHSmu5xZl
	/c1GVNd3VRiTy9pIBvvhOHE09pgGfSZzF2OQrMt3sGY3DzbusYBZY2ZqVNUK65gym4nn8r8Myv9
	YxBM02zTKA7qJcEli/q7o6MWDJ+hPGirgckVxPh2+ZBdmADN6cf5DdUWBPJWVVD0yrb8USVwt5N
	8a7PqcCXgD+EdPo35nfGEJy+kNhObsedQlwAE/R5HLTtQmNA8ZgY/fRfsAzxuWOIqZ25uIkRLC0
	th8tpDC8wBYGnoRSDmo1F5sCVduK29apskFWCNzUvq/k13WFPt/aWmHVjQzwnVbSmfKGwVj2fSC
	qT2T9pZE+nwyh/U
X-Received: by 2002:a17:902:d587:b0:2c8:248a:5dbb with SMTP id d9443c01a7336-2db1265add0mr308117045ad.7.1788759770837;
        Sun, 06 Sep 2026 22:42:50 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1483dbddsm39107695ad.12.2026.09.06.22.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 22:42:50 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH bpf v2 1/2] bpf, arm64: set up the frame pointer for the exception callback
Date: Mon,  7 Sep 2026 14:42:34 +0900
Message-ID: <20260907054235.473103-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907054235.473103-1-donggeunyoo.kernel@gmail.com>
References: <20260907054235.473103-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A program acting as exception boundary saves all callee-saved registers,
so build_prologue() takes the exception_cb path and never calls
push_callee_regs(). That is the only place find_used_callee_regs() runs,
and with it the only place ctx->fp_used is set, so the callback prologue
does not emit the

  mov x25, sp

that points BPF_REG_FP at the frame the callback runs on. x25 keeps
whatever it held when bpf_throw() was called. If the throw came from a
subprogram that uses its own BPF stack, that is the subprogram's frame
pointer, and since the subprogram never returns it never restores x25
either.

Stack accesses through BPF_REG_FP are rewritten to be stack pointer
relative, so those still land in the callback's own frame. Materializing
the register does not: a callback that passes the address of a local
variable to a helper hands over an address in the dead subprogram's
frame. That address is below the callback's stack pointer by then, and
the helper's own call chain covers it, so the helper can write over its
own return address. 0x1234 below is the value the helper was asked to
store:

  pc : 0x1234
  lr : 0x1234
  Call trace:
   0x1234 (P)
   bpf_test_run+0x188/0x3e0
   bpf_prog_test_run_skb+0x47c/0x998
   __sys_bpf+0xbdc/0xdd8
  Kernel panic - not syncing: Oops: Fatal exception in interrupt

Set ctx->fp_used on the exception callback path so that the existing code
further down sets x25 from the stack pointer. The epilogue restores it
from the main program's save area along with the other callee-saved
registers, as it already does. x86 sets the frame pointer for the
callback from the argument it is passed, and powerpc computes it from
the stack pointer.

Fixes: 5d4fa9ec5643 ("bpf, arm64: Avoid blindly saving/restoring all callee-saved registers")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c18e005a41db..c5f55d6161fe 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -600,6 +600,8 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 		 * 12 registers are on the stack
 		 */
 		emit(A64_SUB_I(1, A64_SP, A64_FP, 96), ctx);
+		/* The callback may use its own BPF stack, set up fp for it. */
+		ctx->fp_used = true;
 	}
 
 	/* Stack must be multiples of 16B */
-- 
2.53.0

