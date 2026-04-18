Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FBC2FF
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776474264; cv=none; b=Xpc9/MxD1ETAam28Jum4hHpw3dOsqNvVLBJyuxubpWGx/hOOCCbvZljVcuZepBBabvNAsRkgVQR+Aa+PfxxtpEgnIVf+9dkwOhKvN1zEu0ai0pkZgG0YdBGF3Et+GaX+yBVoTANGVIfrT5JqtVRfkm7FnkObUtN6rZfhvjwXpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776474264; c=relaxed/simple;
	bh=qD4mWCUF2fY4TWdb8hKq15HWfSc+uVWApvk141vaC3U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RAx9k36e6MvEKCqmSFz7j2sVTRdjOktcH7M84Q7Xke2rGE+DU2P7L3urNrd7bfUEFMnBt2pVlCC7v4oShL4UdM+VJCPJ+2HQ0/oHjArYiRkLwJynmyTN8x7z4R+D0IE904tBj9QKxVIMOidoK+n7p0QOz5pPnrPj9N4bqe1AefI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP71GQHx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP71GQHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D623C19425;
	Sat, 18 Apr 2026 01:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776474263;
	bh=qD4mWCUF2fY4TWdb8hKq15HWfSc+uVWApvk141vaC3U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=eP71GQHxfsotQDtKLDGUIL8XX5DiRRAbA8IqlILV3P3VqH6IzHKkyhdfQacBnhvyy
	 6qilzv/mnJWY4oB3ELUm9iM32TyswIhkHniZd6OiEV9vUb9ILb9sMWvco8e3Ga8GfY
	 mnADQhTtQhdRHvkFlp6FxxrFByELhIsDPMnPax1CQ03vPBmR/IhbBlG6orpUeC4u3V
	 JqetmCwxtOUWNHmCV/tgz7V3cNzuCNx84NBnbqNlmhZ5QtWPC/eZKX6aVUGz+eiuiX
	 c4RQZSNpKrTim8j7arkAD89X/45PYSLS1cwrVrI1NKsPdnAfOdtwGEyxbeAJv5yogu
	 1HuzgQKr1Gztg==
Content-Type: multipart/mixed; boundary="===============5822537336994928138=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <567ac7cd59c86c94cb33ef18e4e39dec988bf6ef968301ee359f6ee401cbbedf@mail.kernel.org>
In-Reply-To: <20260417034749.2630580-1-yonghong.song@linux.dev>
References: <20260417034749.2630580-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 10/16] bpf: Reject stack arguments if tail call reachable
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 01:04:23 +0000 (UTC)

--===============5822537336994928138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Reject stack arguments if tail call reachable
>
> Tailcalls are been deprecated. So reject stack arguments

This isn't a bug, but there's a grammar error: 'are been' should be
'have been' or 'are being'.

The commit message states that "Tailcalls are been deprecated." Is this
claim accurate?

Based on earlier mailing list discussion, the restriction exists because
tail calls and stack arguments require incompatible stack frame handling,
not because tail calls are being deprecated.

Could the commit message be more precise about the actual technical reason
for the restriction?

This commit appears to fix a bug but lacks a Fixes: tag. The suggested tag
would be:

Fixes: 13ee5d67a7c9 ("bpf: Support stack arguments for bpf functions")

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7a65b532e84a..739c3127520c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5662,6 +5662,11 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  				verbose(env, "cannot tail call within exception cb\n");
>  				return -EINVAL;
>  			}
> +			if (subprog[tmp].incoming_stack_arg_depth ||
> +			    subprog[tmp].outgoing_stack_arg_depth) {
> +				verbose(env, "tail_calls are not allowed in programs with stack args\n");
> +				return -EINVAL;
> +			}
>  			subprog[tmp].tail_call_reachable = true;
>  		}
>  	if (subprog[0].tail_call_reachable)

When the DFS traversal in check_max_stack_depth_subprog() pops a frame to
return to the caller (moving from a child subprogram back to its parent),
is the tail_call_reachable variable reset to false?

Looking at the code, tail_call_reachable is initialized at the function
start but appears to persist across the entire traversal. Consider this
scenario:

1. The verifier traverses a subprogram that contains a tail call, setting
   tail_call_reachable = true
2. The traversal returns to the parent (pops the frame via idx =
   dinfo[idx].caller)
3. The traversal then visits a sibling subprogram that uses stack arguments

In this scenario, wouldn't tail_call_reachable still be true from step 1,
causing the check in the new code to incorrectly reject the sibling
subprogram even though it has no tail calls in its own call chain?

This could cause false positive rejections of valid BPF programs where one
subprogram uses tail calls and a completely unrelated sibling subprogram
uses stack arguments.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564
--===============5822537336994928138==--
