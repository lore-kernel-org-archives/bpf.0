Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0180334888F
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528595; cv=none; b=Ikw0zcKJgupwcBFWSUu2erP5872t9LX/MT568+oBP+XDji+ZP2+62AR8bbsxkEYnRuQZWGujSQZ4UCQXcQKR0yoNxya9igIiqZua61h+R4qpQlyCVqAwf8gtBKCMHDISJFynjRo6ZHLcS9r2zSRI9IYu9G/4UVnzKesXw43qLeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528595; c=relaxed/simple;
	bh=g5/7271p85oAFH7CnX6LEhojBJAeOSW1YL/XFb0Tq6k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cWrDi3BjoGK3IqSP2sieii+IidqESkuXB/IEGrD1p5Ka904EtQwbEqqCs2vPDOXdV8wYBHaYGJj4a72KSuRZkz8Mw1sx4WjYTP0HiDaRpdjYMs9s8XAxvVYnzZ2tnSXY1704EZi7a2wq2dPQ8Uvn/Puc/zPIi4YxW76bFRhn/l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jugLYeNN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jugLYeNN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C744F1F00AC4;
	Fri, 31 Jul 2026 20:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785528593;
	bh=f16mOQSNxS4D8SDYYsrlnADD0ZYBWEuRxdxkLf5M2Ic=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jugLYeNN4ygpOj7Pum/0DW5jKQqbCXjz9mfaG/oOhB5AXBUs4zCQpsCAu/M71vi4u
	 DoMx17xyOFu3Kho6PTXvlXcT6SvDWBz8oxGu1dBUmMsIOdSEa4yJpprM2g1gznHTPo
	 3JwdskI3wkt7g/2x0JBoSwxuxBL0gwjQCoyXHFgpkXeeMJxg96mPbmOUP2x5l1MKmU
	 9VA52f2FI9LIWQehwInEAJ63tgOPVXxPmdjLhCy/gU6jqYldKgjZJfoYPIOCYZNXKN
	 xoASAcxHuQPeEPQ50ThqL/jAxsAYjztA/Uk8qTcJMZLEc8X76PA5Z3JfC8GMCCqPxt
	 bf/2hAgo/RzmA==
Content-Type: multipart/mixed; boundary="===============9125118984046841705=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <41de1b91c637814541763c352b7254d39f2f44cb4810e646022f31c98e55a37f@mail.kernel.org>
In-Reply-To: <20260731-static-zext-v1-4-98a4dc73e94b@gmail.com>
References: <20260731-static-zext-v1-4-98a4dc73e94b@gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpf: simplify the bpf_is_reg64() signature
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,iii@linux.ibm.com,gimm78064@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Jul 2026 20:09:52 +0000 (UTC)

--===============9125118984046841705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: simplify the bpf_is_reg64() signature
>
> After the previous commit this function is only used in a context
> where destination register's property is queried.
> Hence, simplify the function by removing the 'regno' and 't'
> parameters.

The changelog appears to undercount the removed parameters. Looking at the
actual signature change:

include/linux/bpf_verifier.h:
-bool bpf_is_reg64(struct bpf_insn *insn, u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t);
+bool bpf_is_reg64(struct bpf_insn *insn);

Three parameters are dropped: regno, reg, and t. The message mentions only
'regno' and 't', omitting 'struct bpf_reg_state *reg'.

The reg parameter isn't incidental: it was the only pointer argument, both
call sites passed NULL for it, and its removal retires the contract that
the BPF_STX SRC_OP arm relied on. The fixups.c comment at line 622
explicitly documented this:

kernel/bpf/fixups.c:
    /* NOTE: arg "reg" (the fourth one) is only used for
     *       BPF_STX + SRC_OP, so it is safe to pass NULL
     *       here.
     */
    if (bpf_is_reg64(&insn)) {

Could the message say 'removing the regno, reg and t parameters' (or
'removing all parameters except insn') so readers following the series can
account for all three removals?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30658911996
--===============9125118984046841705==--
