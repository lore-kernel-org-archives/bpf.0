Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F776384CF7;
	Thu, 21 May 2026 04:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336494; cv=none; b=STsQjqI/jKUVCeV4P7IKoODjldEIpOAWYRC1sJW6MP8RrXKJg3JMJwLkriIEYcPExcVNUwWgh13/ionuJTDDevS5YlMTun54u31MD2LJ0jvbPXmPn4zO9jDJUacHniEhFUh8Po7fa0qk9DIDCcb61YEQoO32uUjhRKJqZ750C4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336494; c=relaxed/simple;
	bh=frUW20WnGgMuDfJc2ScOYEyKat+/Sx/KLi7IauRb7cQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FxrOMyu+74jTmytOPiMLXI6qEoCUYz9UGS51quKyP3BHILZuYyZDYkfqtw0cEgLLGuXlk7/9MN+vnPfWpU4P6ZIU5KIGsKoBwB322iFYvOuHYIds86bN0GGB9vcytN+tggmwKChbw+KIiqIPFbSFNaez2CySb9UQbNKBuD0GFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N69TSK8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N69TSK8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3173B1F000E9;
	Thu, 21 May 2026 04:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779336492;
	bh=Kw+VykLIyNoaSGIQROpIUwlv6U4ieWywxI0afM+yals=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=N69TSK8TTuaGO5MsVWTQmgTck1g20eufPe09YMJtSILq/8PVCpKYNRli0ol+lGqpu
	 uf8LQx1iXh2KKODhwM7c0VIqDCFn6J5LVGTG9Ih4drb7+8o/5PvBzxQ5a5xbSmdGdc
	 yST92inml/LVSP6z+7cEEx1ABOgzx6TA4ththlZiL4K6rBdt1S4U7BfBbxcG4m+sYH
	 4+HEOz33SuRtxL8EC07IhTirHu3ZS6yP9OJ3RYC/BjTQtFWs9Bzzxbxtny7bE3QcvM
	 3CPctnI5eV3CujOHAwSwxDJrYEITeAa2867gfgrIpTtXDGj39c5NYvQZfAbIeEH0sm
	 /zmi1DTSDRzFQ==
Content-Type: multipart/mixed; boundary="===============7048703539607253613=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <61871735d9151729b3092d42209dad08b1e38fa930bc1c9e452645240efbc40e@mail.kernel.org>
In-Reply-To: <20260521032306.97118-7-kaitao.cheng@linux.dev>
References: <20260521032306.97118-7-kaitao.cheng@linux.dev>
Subject: Re: [PATCH bpf-next v11 6/8] bpf: Add bpf_list_add to insert node after a given list node
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,ast@kernel.org,corbet@lwn.net,martin.lau@linux.dev,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,skhan@linuxfoundation.org,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-doc@vger.kernel.org,vmalik@redhat.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 04:08:12 +0000 (UTC)

--===============7048703539607253613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1c69476c8a09..89579165ef4d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2577,6 +2577,16 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
>  	return bpf_list_push_back(head, node, meta__ign, off);
>  }
>
> +__bpf_kfunc int bpf_list_add(struct bpf_list_head *head, struct bpf_list_node *new,
> +			     struct bpf_list_node *prev__nonown_allowed,
> +			     struct btf_struct_meta *meta, u64 off)
> +{
> +	struct bpf_list_node_kern *n = (void *)new, *p = (void *)prev__nonown_allowed;
> +	struct list_head *prev_ptr = &p->list_head;
> +
> +	return __bpf_list_add(n, head, &prev_ptr, meta ? meta->record : NULL, off);
> +}

If __bpf_list_add() fails at runtime (e.g., because prev is not in the
list indicated by head), it drops the 'new' node via __bpf_obj_drop_impl
in the fail path.

However, the verifier unconditionally converts 'new' into a non-owning
reference during check_kfunc_call(). If __bpf_list_add() fails, the BPF
program retains this non-owning reference to a freed node.

Could this allow the program to trigger a use-after-free within the lock
critical section?

(sashiko-bot@kernel.org, v10 RESEND)
https://lore.kernel.org/bpf/20260513204420.2BB22C19425@smtp.kernel.org/

>
>  static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
>  					    struct list_head *n)

[ ... ]

> @@ -4756,6 +4766,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_list_push_front_impl)
>  BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_list_push_back_impl)
> +BTF_ID_FLAGS(func, bpf_list_add, KF_IMPLICIT_ARGS)

Since bpf_list_add is marked with KF_IMPLICIT_ARGS, won't the verifier
look for a bpf_list_add_impl counterpart during program load?

Without defining and registering a bpf_list_add_impl function,
find_kfunc_impl_proto() will fail to find the required _impl suffix in
the vmlinux BTF.

Will this cause the verifier to unconditionally reject the kfunc?

(sashiko-bot@kernel.org, v10 RESEND)
https://lore.kernel.org/bpf/20260513204420.2BB22C19425@smtp.kernel.org/

>  BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 35eebb5e7769..662ad7312697 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19524,8 +19527,11 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		int struct_meta_reg = BPF_REG_3;
>  		int node_offset_reg = BPF_REG_4;
>
> -		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
> -		if (is_bpf_rbtree_add_kfunc(desc->func_id)) {
> +		/* list_add/rbtree_add have an extra arg (prev/less),
> +		 * so args-to-fixup are in diff regs.
> +		 */

This isn't a bug, but the multi-line comment format doesn't follow the
BPF subsystem style. The preferred form in kernel/bpf/ has the opening
/* on its own line.

Additionally, consider adding an is_bpf_list_add_kfunc() helper instead
of direct comparison with special_kfunc_list[KF_bpf_list_add].

(bot+bpf-ci@kernel.org and Eduard Zingerman, v10 RESEND)
https://lore.kernel.org/bpf/f573f7e0a5140fe6254d2ddfd3f69add455fa25c67c020c0312e2c2ceeca7c69@mail.kernel.org/

> +		if (desc->func_id == special_kfunc_list[KF_bpf_list_add] ||
> +		    is_bpf_rbtree_add_kfunc(desc->func_id)) {
>  			struct_meta_reg = BPF_REG_4;
>  			node_offset_reg = BPF_REG_5;
>  		}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26204125015
--===============7048703539607253613==--
