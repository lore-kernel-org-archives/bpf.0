Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96193221F39
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210022; cv=none; b=Z68JaGdiU3wwn8FtO+Jy+9WAUVrz8PYC8hEIUfQ0BM7m+VqcXL0WHwrpxjIOU1N8DXCNlCXL6WpprE1m/bOZZLPXZgwsHt+tMuGA3R1wEptN1XVKL0juEH08f6W/Jm97FMLvvrqPPAYMwPCU78BjUtweToS2qWUZrcg/kF2bzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210022; c=relaxed/simple;
	bh=jo/6ZWnxtBeJd9NNDmCdNWsQp/+pnQ8GRVOdjSbdaM0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Gr0vh7GpIAqSOaB01cIPthhG8ZbgQXxLI2GznikY4PvDHLiwnVPzWGHeGkHzQMJRLo/VW/DvQG1ELs8ha87suTUFovMpmoiWOm5rHs3xie4CvO/BTibA5bhcO4+9DFrCXsBAGi6RRnY1vmZyuL7C3L/XhWvMJ1X6nfUlwATNnGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdatN1ro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdatN1ro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132F41F000FF;
	Thu, 24 Sep 2026 00:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790210021;
	bh=xceZNVTcwk16mozOpLsrOvG3ZcX8ASyE77IRM8ySP2I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jdatN1ro0FPtRtXx5RNazFjNCKqzlbcvcejgdKNel2aDo2LvsQ1nuu1DOJKW+CiVi
	 lDsC7wNYor0ZI0TF8rVap+tHjn4y6iqTJ/P5PhsVhk+ZU4arLzCQsPv5TGgh429ajq
	 nsSk7YxJdhtqqPgufUzsVOs5IA7K1qD69oEfyKkW85fk0vi2BMvKSQWbem2ghvjZ8H
	 Bc//AA5NmiVLHW5+mEUki1C+Ew++25LuTAOJcWwweOjPcO+6U4a8T8/aaV+25QxcBI
	 v4aVGksCJhMT07bvPCbv1H3talqSb1+0gTPLNcn/6ttXdeNOLYiUTZiDPZVZbFS5Px
	 IS8yzwCVaIMkw==
Content-Type: multipart/mixed; boundary="===============2300511165320433124=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <93380e845ef2c8c3804dc961e2dbc9b21acb52cbf22de618ccef1f568ca209d2@mail.kernel.org>
In-Reply-To: <20260922011323.1298619-16-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-16-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 15/17] selftests/bpf: Add tests for callx
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 00:33:39 +0000 (UTC)

--===============2300511165320433124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
> new file mode 100644
> index 000000000000..ec63d2107e6c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_callx.c

[ ... ]

> +/* return value of the callee is tracked */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("R0=6")
> +__naked void callx_retval_is_tracked(void)
> +{
> +	asm volatile (
> +		"r1 = 5;"
> +		"r2 = %[add1] ll;"
> +		"callx r2;"
> +		"exit;"
> +		:
> +		: __imm_addr(add1)
> +		: __clobber_all);
> +}

The comment says this test checks that the callee's return value is
tracked in the caller, but does __msg("R0=6") actually verify that?

The level 2 log first prints the callee's frame state. Since add1 is
appended at insn 5, the log contains a line from inside the callee:

  6: (07) r0 += 1   ; frame1: R0=6

This line comes from print_insn_state() and matches the __msg check, even
though it's in the callee's frame, not the caller's.

The line that should be checked appears later, after prepare_func_exit()
copies R0 back to the caller:

  to caller at 4:
   R0=6 R10=fp0
  from 7 to 4: R0=6 R10=fp0

validate_msgs() takes the first match, so the test passes even if the
caller never sees R0=6. If check_func_callx() or the return path left the
caller's R0 as an unknown scalar, the program would still be accepted (and
__msg("R0=6") would still pass), but the test would fail to catch that
regression. callx_basic already covers the runtime result with __retval(6).

Could the message be anchored to the caller context? For example,
__msg("to caller at 4:") followed by __msg("R0=6 R10=fp0"), or
__msg("from 7 to 4: R0=6") would specifically check that the caller sees
the tracked return value, similar to how verifier_precision.c anchors with
instruction indices.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35935998342
--===============2300511165320433124==--
