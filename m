Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91D93BB57;
	Tue,  3 Feb 2026 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087880; cv=none; b=LTfhr0ImI3BEvYUvdRtP6ySMrb9+1oIDrb7VPcZ+o9BP9HHHxp9cocWPfy7V86nOnnsdodcwyIY39y94cnXfWO6kg/PEiuqhMf4Ozz3PyKnfLMH4zoX/HpFKLVndfUNhNJOydqffLhHWJErUyu9+i98pEqEziyAVvZtXHhRbhLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087880; c=relaxed/simple;
	bh=bF3DlkanlLmgqm9+KmI0PQ9tzBWPxly9drKEGHNWJfE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gK67e5IRhBvWV6bxR+94Aj03nS53qfEhi8jhXSlssxXp1hY+iShAYQt820W7uoi8lguJvUQc0PPzMUfbMoacv5bvoqvxM32T8pHQWZ8uZBL3kuB1bZpMMPfk+kLX6aLBHk7kvj3E5D3+mfna8rl+rnxhyGVMWhbWZ8L9/S049RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GC1MovLI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GC1MovLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E774C116C6;
	Tue,  3 Feb 2026 03:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770087880;
	bh=bF3DlkanlLmgqm9+KmI0PQ9tzBWPxly9drKEGHNWJfE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GC1MovLIDnCEGThK06dmsaJOKF+HvkHMsapCWVg1lrkeLN8CelHIF5fEV02YtYqbZ
	 1TaDB/S54Pw/bx7C3Nji0NjrYNSyeIc8h+nEx3wj7RBGc5xpVIPKRfN2/U+xTKoRKn
	 hFoDjS8OrEbgAMi7pXDABoR/JlpkPBBCQVnRMpsqgbFItxrEuqfZzL5YuTK8wrrOtN
	 Y+DCq44BQ5+zq+s1wbnCbka7lIuoSgW51wx8LzuWgPy+yxxAGJVBt1B6LfgzKjbfBF
	 jK9Q6IUFlVnONjSgUFth2TnyOHnnJMOmkPy/ligy3niFsy7YQX68dP/v8pFvGJOjYu
	 SLBDUoJitEUWg==
Content-Type: multipart/mixed; boundary="===============5018553600281611377=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <94483c320d8eaf29277fe60ca7d10ed70b0bb6ca636994a0eb07c26d5f139b0e@mail.kernel.org>
In-Reply-To: <20260203022712.99347-3-pilgrimtao@gmail.com>
References: <20260203022712.99347-3-pilgrimtao@gmail.com>
Subject: Re: [PATCH v5 2/3] bpf/verifier: allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,yangfeng@kylinos.cn,alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,chengkaitao@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Feb 2026 03:04:40 +0000 (UTC)

--===============5018553600281611377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2dd860ae12..bb45fa5612 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9300,7 +9300,8 @@ static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE }
>  static const struct bpf_reg_types kptr_xchg_dest_types = {
>  	.types = {
>  		PTR_TO_MAP_VALUE,
> -		PTR_TO_BTF_ID | MEM_ALLOC
> +		PTR_TO_BTF_ID | MEM_ALLOC,
> +		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF
>  	}
>  };

Is the MEM_RCU variant also needed here?

When ref_set_non_owning() marks a register as NON_OWN_REF, it also adds
MEM_RCU if the node has a bpf_refcount field (refcount_off >= 0):

    reg->type |= NON_OWN_REF;
    if (rec->refcount_off >= 0)
        reg->type |= MEM_RCU;

This means rbtree nodes with both a __kptr field and a bpf_refcount field
would have type PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU, which
won't match any entry in kptr_xchg_dest_types.

Should this also add:

    PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU

to handle that case?

> @@ -9460,6 +9461,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>  	}
>  	case PTR_TO_BTF_ID | MEM_ALLOC:
>  	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
> +	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
>  		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
>  		    meta->func_id != BPF_FUNC_kptr_xchg) {

Similarly, does this switch need a case for the MEM_RCU variant?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21614799102

AI-authorship-score: low
AI-authorship-explanation: The commit addresses a specific practical problem with minimal targeted changes, showing domain expertise typical of human kernel developers rather than AI-generated comprehensive solutions.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Missing MEM_RCU variant may prevent bpf_kptr_xchg on refcounted rbtree nodes, but this affects only a subset of use cases and causes verifier rejection rather than runtime issues.

--===============5018553600281611377==--
