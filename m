Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2462FBE1F
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772307950; cv=none; b=h3J1L5CTJZqwUPMT0SXoqvAcZlU3E6BUWHm6e3ttQ+JsXawe9cL8aEV2rjvBKsqdBfFGm5ssFmswr5q/GzFi9IjMmYLnIFSi3XlcvIOHj86/T8TC+oVRB8rd8XrUGwouubuUAS1BhYWSzfhM1ZHU49uM3ibyoILzznEva4Qpcbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772307950; c=relaxed/simple;
	bh=HZ/cg1rh+FU6pxOi1Q9rdJCc+qOc66Q8EwKzNGrQEc0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Em9+DT7t61DxQ+GxtMJ9sFScyI5ARzZdpQEikHnWFGbN2ja86+JtTQKqr/0rDNabRftNAK8HRhW99IBYDvLBfPH8dvAu6W4S4DDB4jxmnK7h94D1n3JSwyjOfs/K0y3ANczSKnkq5qkFkEog+YhcYzsex3qphfPtmKy3ikeYTWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZJJl24/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZJJl24/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4CFC116D0;
	Sat, 28 Feb 2026 19:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772307950;
	bh=HZ/cg1rh+FU6pxOi1Q9rdJCc+qOc66Q8EwKzNGrQEc0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QZJJl24/OKbVpRC2EX+pf82JQBZNxqgoxaD85L/9Yg62iZ2Pu9KV3aYgoud8g7ulU
	 jZTYvL3TA2BX0nqIn2EryG2CjJ0V/+lctmQW6CtoH78jsMJ9+7wjS/k2rBZPTo1mCW
	 NxtV5uUDCcokIZviMQPzrPD+AJfKy/1dxv/9DbZz2Cyc7cugcPKfubUWUi8arHOU4C
	 hBEQfdhGRsil2LQKGsAm9T+ila7qqnjp0ApJy0opx+2ILHlgcbHU06tf3zBiQacHB+
	 EXoIo8Bz0cptEhxDz+CIvfCgyteTydEMCYgYK2WExstmusZUnaD2iWlxS/LkhN2Yf/
	 jwGQ0EXLt0OYg==
Content-Type: multipart/mixed; boundary="===============8226162180068454019=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9014655d9498ca02086847eec5b1f50737bc3de06999b3fecd9aa67345b98cae@mail.kernel.org>
In-Reply-To: <20260228184759.108145-4-emil@etsalapatis.com>
References: <20260228184759.108145-4-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v6 3/5] bpf: extract check_global_subprog_return_code() for clarity
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,martin.lau@kernel.org,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 28 Feb 2026 19:45:49 +0000 (UTC)

--===============8226162180068454019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 80b6fb821456..ebcca81ccdaf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17987,15 +17984,6 @@ static int check_return_code(...)
>  		goto enforce_retval;
>  	}
>
> -	if (is_subprog && !frame->in_exception_callback_fn) {
> -		if (reg->type != SCALAR_VALUE) {
> -			verbose(env, "At subprogram exit the register R%d is not a scalar value (%s)\n",
> -				regno, reg_type_str(env, reg->type));
> -			return -EINVAL;
> -		}
> -		return 0;
> -	}

check_return_code() has two callers: process_bpf_exit_full() and
check_kfunc_call(). The new dispatch in process_bpf_exit_full()
correctly routes global subprogs to the new function, but
check_kfunc_call() still calls check_return_code() directly
when validating bpf_throw() arguments:

    check_kfunc_call() {
        ...
        if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
            ...
            if (!env->exception_callback_subprog) {
                err = check_return_code(env, BPF_REG_1, "R1");

When verifying a global subprog (frame[0]->subprogno != 0), the
removed block would have accepted any scalar R1 and returned
early. With it gone, R1 now falls through to full return value
range validation.

Could this reject previously accepted programs? For instance, in
a struct_ops program where return_retval_range() returns (0, 0),
calling bpf_throw(1) from a global subprog would now fail
verification where it previously succeeded.

The cover letter for this series indicates patches 4-5 may
complete the bpf_throw refactoring, but they are outside the
provided range.

[ ... ]

> Both main progs and subprogs use the same function in the verifier,
> check_return_code, to verify the type and value range of the register
> being returned. However, subprogs only need a subset of the logic in
> check_return_code. this also goes the way - check_return_code explicitly

"this also goes the way" -- should this read "this also goes the
other way"?

> checks whether it is handling a subprogram in multiple places, complicating
> the logic. Separate the handling of the two into separate functions.

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22527094257

AI-authorship-score: low
AI-authorship-explanation: Grammar error in commit message and iterative human review process across v1-v6 suggest human authorship, though the cover letter notes AI assistance on a different patch in the series.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Behavioral change in check_kfunc_call bpf_throw path could reject previously accepted programs, but the impact is limited to an unusual code pattern (global subprogs calling bpf_throw without exception callback) and is likely addressed in subsequent patches outside the provided range.

--===============8226162180068454019==--
