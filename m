Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4932DB798
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400210; cv=none; b=TXY3ty4YbBPW4a5tYcfD62x2eLxdlDgZdVwCSDVYpDgRn5Au0vWrLWa53wa3rHGJcOePySyyhDfs9FzMAtqlY+vUBv7ZfT/L67xryGmbDoR+WPag8uvHiGTFhuaLlKIAwWzYwB/QQfGXdEpZf4oGdPs2rvBEFPGqbdN2uY9ceEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400210; c=relaxed/simple;
	bh=bWOz9tJfPM+87ktE6k5HUNo7Q8jvfwm93qQ7YqYOrlU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CzWuX4g1Xyopxz1498q7uYP318KYvOCoQSy5xVIB93gxxegTKexn7srP9l7/NgdBKCNR9hHYbOde20He9Dd1w58WPpljq/Ion8h1bCUPdIRgQo+plBQHtFKkxmVp82qjXit313ygFo83N/yuba+JuIO5wlUNJPTwHwA2mdX40bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDEigL9y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDEigL9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904A0C19425;
	Fri, 17 Apr 2026 04:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776400210;
	bh=bWOz9tJfPM+87ktE6k5HUNo7Q8jvfwm93qQ7YqYOrlU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hDEigL9yge6phhLORoZy1UfVLCsFKBvZcfANy/ZPB6ljAqIjGy59V60kPzvi3oqO3
	 yWcpD90n1kur5UPqL7WUeyYwPt5i6vybeUEEe4YOyTF6Hplh1TnwwtbDaOgTLAea5W
	 8+O05NtKfSqPg+iPmgAwYBclFz4kW+ENz3UUCoo/SvKUUE90H1qhSpH/ZfN6OcqWwg
	 56s7W1MdD3RMyoH6X4xrn/1TctJL1QYpWilO3QxXBH+7ZZFmkL6farVFqXHuJewEOd
	 cGLp8tCF97OZijPCKrSLPDpRFTgTh9Bdr3P5x5rwei9r2MwPfQcqiTvSm08uIYRTkO
	 n9Pqjkutdoqfg==
Content-Type: multipart/mixed; boundary="===============7444265718960743378=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <96af03177041a83cc1cb9c4795d95de986a364e4715dedce11b90f4b44a8bfd0@mail.kernel.org>
In-Reply-To: <20260417034749.2630580-1-yonghong.song@linux.dev>
References: <20260417034749.2630580-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 10/16] bpf: Reject stack arguments if tail call reachable
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 04:30:10 +0000 (UTC)

--===============7444265718960743378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit b77ef401ea17eab379f390ca5d89aeab4b271ca7
> Author: Yonghong Song <yonghong.song@linux.dev>
> Date:   Thu Apr 16 20:47:49 2026 -0700
>
>     bpf: Reject stack arguments if tail call reachable
>
>     Tailcalls are been deprecated. So reject stack arguments
>     if tail call is in the way.

The commit message has a grammatical error: "Tailcalls are been deprecated"
should be either "have been" or "are being".

Also, is the claim that tail calls are deprecated accurate? Based on earlier
mailing list discussion, the restriction exists because tail calls and stack
arguments require incompatible stack frame handling, not because tail calls
are being deprecated. Could the commit message be more precise about the
actual technical reason for the restriction?

This also appears to be a bug fix for the stack arguments feature. Should
this include a Fixes tag for the original stack arguments commit?

Suggested: Fixes: 21229535935384b01e3cef3c117233b23b2f3902 ("bpf: Support
stack arguments for bpf functions")

>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>
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

When the traversal pops a frame to return to the caller and jumps back to
continue_func, is the tail_call_reachable variable reset to false?

Looking at the broader context of check_max_stack_depth_subprog(), after
processing a callee, the code pops back to the caller:

    /* pop caller idx from callee */
    idx = dinfo[idx].caller;
    ...
    goto continue_func;

If the verifier traverses a subprogram with a tail call, returns, and then
traverses a completely unrelated sibling subprogram that uses stack
arguments, would it incorrectly evaluate tail_call_reachable as true and
reject the valid sibling?

Is there a state leak in this DFS traversal that could cause false positive
rejections of valid BPF programs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24546989054
--===============7444265718960743378==--
