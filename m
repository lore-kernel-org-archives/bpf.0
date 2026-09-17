Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F68E44AB6E
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627733; cv=none; b=FeYtY0jVfbP1Zjq3JzrV+dtaFVN7WXTu3xCmqT7iqtLeUNVNPq+TUsG1HKYjsgDKPz6AHzhJwFlJQNvoRxVm+ODHu8klRIJ+H21MGorzGiHMgsc7v+C5m8fkN7F7Tt6Eyfivm1kGfHHCkKofbvX7G7pjror9ip/p7snXwmUBEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627733; c=relaxed/simple;
	bh=aAv46u/4EWQDq9kQi22X7s3/atkLMhKMxTR7Bb1FZms=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tX4QXkc8ENL32pyhRk4Dxvh+2taLJBxGXaEXUGI2GKxlBAuIAXsEVFwDSyAlKHIGD54nlilcHox1DqPsKXSuAHKclYS38n+4GCsHHNIfSgwlJwuFPMIT4qTRavp3dZ9K9kdKk/auvcsZgHRYtBMUB5/DNUmdF01jgaAzAuRAQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahZD5WXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahZD5WXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DF81F00893;
	Thu, 17 Sep 2026 06:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789627732;
	bh=yB92nxoMF+++vzh85303tzING09o4yFjEiiO+rbnx1M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ahZD5WXnxQ5bJmnV4JJLpmI4Rd1TT0kduPDkvmWv/k8LjqmF64hmHN1GFAgRk3eqs
	 ZsuuBGv9OL6SeQ94v+OllQAbW2wimfHJv2dztFuAFjgSHU9cSeT1Mre1ivpUF9fTTo
	 cMLA/R2BhB372DWSfwYL1a8u1hBlZZtBMMn/0Nx8ko1n6Z4eiZ9+FTcwrysgNpJA9n
	 GC8IaCFSZNlCe10aApo0lF8g6CawjrMHgOOOa9G98vDTPZQbsAVrPofxnv+O+lwi6n
	 oqCXAr1+4TpvegbjvnuP85p76FWROy5etsr9jPule8hsJ5kGngiIBrnK/jWWID0rST
	 8qlONhE9AdLmw==
Content-Type: multipart/mixed; boundary="===============0538707630271738666=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <596e9f402b0cd56f1897d2be75feb51ac53f6e2694619d594720057d2777aa09@mail.kernel.org>
In-Reply-To: <20260917051948.1588826-2-xyx2021@mail.ustc.edu.cn>
References: <20260917051948.1588826-2-xyx2021@mail.ustc.edu.cn>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Track iterator-owned BTF pointer lifetimes
From: bot+bpf-ci@kernel.org
To: xyx2021@mail.ustc.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 06:48:51 +0000 (UTC)

--===============0538707630271738666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Non-RCU struct iterator results borrow their lifetime from the iterator's
> current element. Associate these PTR_TO_BTF_ID results with the iterator
> reference and invalidate the previous result when processing the next
> iterator argument. This applies before modeling either next outcome;
> destroy continues to invalidate the result through reference release.
>
> Preserve that lifetime when loading a fully trusted BTF field. Capture the
> source lifetime before marking the destination, as the registers can
> alias. Keep RCU, user and percpu field results under their existing rules.
>
> A borrowed field can also back a dynptr. For example, a FILE dynptr owns
> reader state but borrows its file. Record the backing register's lifetime
> in the common dynptr constructor path, using the acquired ID for an owned
> reference and parent_id for a borrowed pointer. Keep clone handling and
> the ownership meaning of reg_is_referenced() unchanged.
>
> Reuse the existing child-reference leak check before advancing an iterator
> and propagate destroy errors. Outstanding child resources must be
> explicitly released before their backing lifetime ends. Preserve the
> existing rule that only the initial ID is removed from acquired references
> when release_reference() invalidates descendants.

This isn't a bug, but could the changelog open with the unsafe program
pattern and note that trusted-field loads from any released reference are
now rejected, rather than walking the hunks in order?

The patch tightens acceptance outside iterators too. After 'file =
bpf_get_task_exe_file(task)', loading 'inode = file->f_inode' now
inherits the file's reference id, so release_reference() on bpf_put_file()
invalidates 'inode' and a previously-accepted program using it afterwards
is now rejected. That user-visible consequence isn't mentioned.

> Fixes: 4cbee026db54 ("bpf: return VMA snapshot from task_vma iterator")
> Suggested-by: Amery Hung <ameryhung@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c6b8d8520cdf..3d47487233b75 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -753,8 +756,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>  		if (err)
>  			return err;
>
> -		/* Track parent's id if the parent is a referenced object */
> -		parent_id = ref_obj->id;
> +		/* All non-clone constructors take their backing object in R1. */
> +		parent_id = reg_lifetime_id(env, &cur_regs(env)[BPF_REG_1]);

This isn't a bug, but would it help to anchor this invariant somewhere
checkable?

The removed comment described the local operation, but the new one asserts
a whole-tree invariant about every dynptr constructor's argument order.
The invariant does hold - bpf_dynptr_from_mem, bpf_ringbuf_reserve_dynptr,
bpf_dynptr_from_file, and the skb/xdp variants all take the backing object
in R1 - but nothing in the code enforces it, so a reader has to
re-enumerate every 'ARG_PTR_TO_DYNPTR | MEM_UNINIT' proto to confirm.

Could you note which protos it covers, or key the lookup off the argument
the verifier already identified rather than a fixed R1?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35186779269
--===============0538707630271738666==--
