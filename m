Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C133DA7F9
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 05:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522792; cv=none; b=IxgsRJzmGb7P9SpaB7U2P1Wn5TvSEJrcxi+d4TtNVJb6OjJTf5bMCRr04SzErYYVSHUHZvbxLQHv5H7Q0o7Qjq+6gO2twg9jc0SC7TY84R2OxoR4y0Wdwpt3FYCdNDMwDMEhm2/UFsBzfITKa0sdYhYH/G7Cg0Xaw0EHmgb+mRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522792; c=relaxed/simple;
	bh=nlA/HFLUtMIX3BJBAm9xhBhFmNGctGfz5Q54s6jWIcw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rf4PVZgmHiVrF18HRQgw9BHDn60SKEDwQb5yZAYAMi2Q2cCS4UEG6NFOjLw8vqiBZ/SqQYJiSVTBEB4LhgnednIxkLoiNvu/lEZI0q76qDFWwu6zTzVqRNenAzXF41DVuUs4rdnKQoZUzKjZpt66Nhu60Yfl2AbHkib8NIBn4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2fuptoP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2fuptoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0D31F000FF;
	Fri,  9 Oct 2026 05:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791522791;
	bh=xE5kc/44lRrMUdkQijxRolRsrKeSiMi+/zqy/akzelw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=k2fuptoPMqntQQluUxvDCaF/3/UviYRcx+xzshmgJxg3/wlQzpSEhvtAZIezltXdc
	 04g7By1T7pKO0PJRZgIy/9gByKUH1o05pAjj1H27vvlQTuipmIcTLiqCM4FpolMuTY
	 3QngLx0zc74d4Q8jplo8RPq1pNMnS/+NcR0k7hs7C3Dzg1e0iae/fcnYRAmFQ1uNCf
	 toyrOUW6vLHe+sNiQu8yqdVO3HawUVz/l8KY0JbLScTRlusKB7LmKtouNS3nMvXJzb
	 dn1P31McL2y57DL9jGtR6r6bcXKopYqkHBIOfk4YrrJ9b7Rf9s+jDTPZXKgRRlT9Zc
	 N14XRhWqcuyew==
Content-Type: multipart/mixed; boundary="===============0548453300609736784=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <59c036011bdc8e7bee4cdb78ab4ed375729668c9e99f62a82b7c156c80967bc9@mail.kernel.org>
In-Reply-To: <20261009041523.26992-1-yonghong.song@linux.dev>
References: <20261009041523.26992-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v10 07/24] bpf: Verify an unwind through landing pads and epilogues
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 05:13:10 +0000 (UTC)

--===============0548453300609736784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Verify an unwind through landing pads and epilogues

TL;DR: Nit only: unwind_frames() sets r0 to zero in two calls;
__mark_reg_const_zero() could do it in one, as process_iter_next_call() does,
and the explanatory comment could go. No bug.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0cf30220b777..1553c7d5bbdb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19203,6 +19212,135 @@ enum {
[ ... ]
> +static int unwind_frames(struct bpf_verifier_env *env, bool *do_print_state)
> +{

[ ... ]

> +	/*
> +	 * The call clobbered r1-r5, and r0 holds the zero the fixups put
> +	 * there. Mark r0 unknown first: the known-zero helper keeps a NOT_INIT
> +	 * type.
> +	 */
> +	clear_caller_saved_regs(env, cur_regs(env));
> +	mark_reg_unknown(env, cur_regs(env), BPF_REG_0);
> +	mark_reg_known_zero(env, cur_regs(env), BPF_REG_0);

this isn't a bug, but could this use __mark_reg_const_zero(env,
&cur_regs(env)[BPF_REG_0]), as process_iter_next_call() does, and drop
the part of the comment that explains why two calls are needed?

unwind_frames() sets r0 to a scalar zero in two steps here:
mark_reg_unknown() sets the SCALAR_VALUE type, then mark_reg_known_zero()
sets the value.  __mark_reg_const_zero() already sets the type to
SCALAR_VALUE, the value to known zero, and precise to !bpf_capable in one
call.  process_iter_next_call() and check_kfunc_call() both use it for
r0 this way.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37884246994
--===============0548453300609736784==--
