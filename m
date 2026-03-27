Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA3274B39
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574140; cv=none; b=ulmNKAd1m+wrnI+JMNXp2PX9REpgEalRif/Ax182R2J+l5i8Xmz90Afv1IL+gWvo6kw1swESyANlbEiLMkNSNNEn0UOQrbmXyuwVGq+Ygq8HjbvZ6pyi79mDkO/PW+b+Xo0rrJKHJPQ75MheJine8v4d5UT/YZMc2KqZMiPLlT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574140; c=relaxed/simple;
	bh=jYVP9ZYgeU2Asp0oDQIPyj+S3j9ajhwQUKWvUhXZiEc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iYEpjVTZRSDHCVVyDVAHTrgMRbmctHKMbNa54dz0/c4eC/NMfVprbwmA4i3qzmywdV2GpOGcJr8B6btWt1o2hxEmbHLLRas4PSZ+AMHtivW5Fn6gWBcrZVGdNs7hjUGAb2JiGubfHRmUKbPCtLX0IYC8209f1mUf2cMHXL48mhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTWHxuL8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTWHxuL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CA1C19423;
	Fri, 27 Mar 2026 01:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574140;
	bh=jYVP9ZYgeU2Asp0oDQIPyj+S3j9ajhwQUKWvUhXZiEc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=MTWHxuL8EnUq7gQlfsWa9n5dELLwR0xoIyjDAqfebY6D5cKS6swM7DFuNDmqfZ5M9
	 85SjVhYp9J5ldCs6XmO0gfHbjGi4eCfoEXdICDUD4qAOyVwfAz0vxKtsR0/bK3dl4M
	 u0os9dslFDgfpNEVXuqE81x9Hm4hv6uIltbUnAQK3I1F9o3fVIuNG73vxZJu49LPw0
	 VhOIY7grhS6HUD+0Dd5HZIMdwprPy/bCULa/pRbn/VWvv711VWbFT28gFq+qj9Y0Hx
	 T7+JEiTDhxOaMUtyJUQxsexLxLBLNVRcyK/TXOiQ2wcPcfEiMM7j4OZnpBJcJxo5GO
	 Hpq0ZnYlkBnkw==
Content-Type: multipart/mixed; boundary="===============8064506777385460380=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9df5e40dc601aba53aea886e4087aad98d3987ef1986f6f1145da63ee8e43eca@mail.kernel.org>
In-Reply-To: <20260327002759.4033863-1-ihor.solodrai@linux.dev>
References: <20260327002759.4033863-1-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com
Cc: olsajiri@gmail.com,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 27 Mar 2026 01:15:39 +0000 (UTC)

--===============8064506777385460380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 11207e63c94e..33f6c226d528 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12369,7 +12369,8 @@ enum {
>  	KF_ARG_RES_SPIN_LOCK_ID,
>  	KF_ARG_TASK_WORK_ID,
>  	KF_ARG_PROG_AUX_ID,
> -	KF_ARG_TIMER_ID
> +	KF_ARG_TIMER_ID,
> +	KF_ARG_BTF_STRUCT_META,
>  };
>
>  BTF_ID_LIST(kf_arg_btf_ids)
> @@ -12383,6 +12384,7 @@ BTF_ID(struct, bpf_res_spin_lock)
>  BTF_ID(struct, bpf_task_work)
>  BTF_ID(struct, bpf_prog_aux)
>  BTF_ID(struct, bpf_timer)
> +BTF_ID(struct, btf_struct_meta)

KF_ARG_BTF_STRUCT_META is added to the enum and btf_struct_meta is
added to kf_arg_btf_ids, but neither appears to be referenced anywhere
in the verifier.  The other entries (KF_ARG_TIMER_ID, KF_ARG_PROG_AUX_ID,
etc.) are each used by a corresponding is_kfunc_arg_*() function.

Was this intended as scaffolding for a follow-up patch, or is
there a missing is_kfunc_arg_btf_struct_meta() helper?

[ ... ]

The commit message lists 7 kfuncs accepting void *meta__ign:

>  The following kfuncs currently accept void *meta__ign argument:
>    * bpf_obj_new_impl
>    * bpf_obj_drop_impl
>    * bpf_percpu_obj_new_impl
>    * bpf_percpu_obj_drop_impl
>    * bpf_refcount_acquire_impl
>    * bpf_list_push_front_impl
>    * bpf_rbtree_add_impl

bpf_list_push_back_impl also accepts void *meta__ign and is converted
in this patch, but it is not listed here.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23625407551
--===============8064506777385460380==--
