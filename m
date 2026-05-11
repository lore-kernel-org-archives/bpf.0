Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738EB2D3725
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 06:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480391; cv=none; b=MrFo2svvPurhQPZqwwQpJlmyjl5U5/2WDu8Q7pwoBh4YQM8soROnzveTmqQLcf5SuAcM4mRA6oJ2t85yi2pKwnplEGR8M7oz9UOvAc1AnIIkfjybx8JJQ94s0OW+W+AQmP4xBYWdXEj3LA83Y0SUqb/t1KpSFH10TPyPIhbfpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480391; c=relaxed/simple;
	bh=0R3W8mXBFbuKmE0YTAFL1WwGMjvVM/bvV/h+6ohddNA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Pfgu+xKDteYSG4+ErzZfzoom9ShA+QEcNbnOpDDJ9J+bdUnxkXVq5X7CVKr4zdz5BGuUWDGrb+wu+/dT28zXXRfKesTEyfR2ddIVxyQRBMgqPbxDW/08X+3cKSmwilOgJVjlE8S4Ua4uJmWyo038cbwDrwR7/jpiMEsf7BSi0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuEQ4Zcz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuEQ4Zcz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27B5C2BCB0;
	Mon, 11 May 2026 06:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778480391;
	bh=0R3W8mXBFbuKmE0YTAFL1WwGMjvVM/bvV/h+6ohddNA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GuEQ4ZczojIaVmngoCQL4k2zP7D6/PsUy/b+zN1C1LRm0bQdiDT9BSAs0Ent+U95c
	 GwPDV++v8CsnJh1aPhMGqyn4d9ym3bIFwxrB0c6GzGyKGTz89aMiyuq4KMtITAe08V
	 ammxJDklmusfmotpg5OHZVA/uxRV4JlYx5+YopSPIgGreV6fF1So5R7e+SmDkF/ltt
	 VHgqD7r9re4o8q+ha37XXHFNsHGghEHKU2EQS+8VdLcBE83F0QlswBbB2NMKR32M5h
	 M+URdsLexvg8u4VRr0M/uZBzgQ89lrgrSX/WjxWm8kWd0sG14cOFgGkFUBDCRhwCnb
	 r+2lxN1uOGdBQ==
Content-Type: multipart/mixed; boundary="===============1846128623982376436=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <93e6e9fcc7fd30afb580c0b88c8b28ad27f7f3ea79b42c82f9b359cfeec6fef8@mail.kernel.org>
In-Reply-To: <20260511053413.1888514-1-yonghong.song@linux.dev>
References: <20260511053413.1888514-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 14/24] bpf: Reject stack arguments if tail call reachable
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 11 May 2026 06:19:50 +0000 (UTC)

--===============1846128623982376436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 442f18d6c7d955b76622d405f1eddaf4f2545a7d
> Author: Yonghong Song <yonghong.song@linux.dev>
> Date:   Sun May 10 22:34:13 2026 -0700
>
>     bpf: Reject stack arguments if tail call reachable
>
>     Tail calls are deprecated and will be replaced by indirect calls
>     in the future. Reject programs that combine tail calls with stack
>     arguments rather than adding complexity for a deprecated feature.

Multiple reviewers across v4, v5, v6, v1, and v2 noted that the commit
message inaccurately states tail calls are deprecated when the actual
technical reason is that tail calls and stack arguments require incompatible
stack frame handling.

Looking at the mailing list discussion on the v1 series, Alexei's guidance
was about disallowing mixing stack arguments and tail calls due to stack
frame layout incompatibility, not because tail calls are being deprecated.

Could the commit message more precisely describe the actual technical
constraint rather than framing it as deprecation?

>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d596e6bd9a81..2f2814035f37 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5267,14 +5267,23 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	 * this info will be utilized by JIT so that we will be preserving the
>  	 * tail call counter throughout bpf2bpf calls combined with tailcalls
>  	 */
> -	if (tail_call_reachable)
> +	if (tail_call_reachable) {
>  		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
>  			if (subprog[tmp].is_exception_cb) {
>  				verbose(env, "cannot tail call within exception cb\n");
>  				return -EINVAL;
>  			}
> +			if (bpf_in_stack_arg_cnt(&subprog[tmp])) {
> +				verbose(env, "tail_calls are not allowed in programs with stack args\n");
> +				return -EINVAL;
> +			}
>  			subprog[tmp].tail_call_reachable = true;
>  		}
> +	} else if (!idx && subprog[0].has_tail_call && bpf_in_stack_arg_cnt(&subprog[0])) {
> +		verbose(env, "tail_calls are not allowed in programs with stack args\n");
> +		return -EINVAL;
> +	}

When the traversal pops a frame to return to the caller and jumps back
to continue_func (not shown in this diff), the tail_call_reachable
variable is not reset to false.

Consider this scenario:

1. Verifier traverses subprog A with a tail call, setting
   tail_call_reachable=true

2. Traversal returns to the parent (pops frame):
       idx = dinfo[idx].caller;
       goto continue_func;

3. Verifier then traverses unrelated sibling subprog B that uses stack
   arguments

At step 3, tail_call_reachable is still true from subprog A, so the code
would incorrectly reject the valid sibling subprog B.

Is there a state leak in this DFS traversal that could cause false positive
rejections of valid BPF programs? The author acknowledged this issue in v5
and v6, noting it would be fixed in the next revision.

> +
>  	if (subprog[0].tail_call_reachable)
>  		env->prog->aux->tail_call_reachable = true;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25652623893
--===============1846128623982376436==--
