Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55A7311587;
	Wed, 25 Feb 2026 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014974; cv=none; b=oUichioal0sfFne6QVJwvBLOQ77PMmbADDrao6i3B7tZG8a7BEOoKnJQPhzEXrHdbwaicaID3RnEsTF20XT0389HUI4PM3OrTiIeDEnl62iBeH6sWZGo88fARLGjYvMUIrovEyE9BuE2vTyD84DoIRCdwZdUoPryJ0X5PhkK2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014974; c=relaxed/simple;
	bh=jgGKUSz+XveMGfQVqie6OFOhJ89K3azC6BD+pjBLiXg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qJAF19tPwXZ8x1aA5k3/NqX85p60/4Wgxw5dQ80S55t2N2pLSdQsXQTjrwfa1r+UsyWlkI8jbnQVibBcnkOfjjMPH79+5YkmRXbp7zYSL0zUAh8137Z407y4legqUWE1Th6U76wMjG2R9AY9/j5S/WnEFbi7Jheus0Anqj1SqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ufz2Bixx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ufz2Bixx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F584C19422;
	Wed, 25 Feb 2026 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772014974;
	bh=jgGKUSz+XveMGfQVqie6OFOhJ89K3azC6BD+pjBLiXg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Ufz2BixxHQ8oYF5MKEe4EFzACo3vZx0jrjsz6uwqg7SKb2g01g9DO0SRuihod/iE+
	 H57r3CRMnyRI4gLJoy7UFl1+LqR6brPLlx1EUTU8l7HP+AOYkGVq/L2RAyCNbseFT9
	 /rnqf+4439UyBVsy1I28c0dURYV/0zgpp8/7Pg1rlrFQMBO8Q31ioOjVgW5FoH36sP
	 fw0m19cDM8M7CeNLQ4TfJNAydMl8kW3ru9lhevdHWftT/D/erssHs/4JJAo8+CdCU7
	 kOxQUu7dQfNa9aKBsdNzIsYbIsjbhxKhf8ggVLANus5b4EfLyUS6YqbilG7744Jgfh
	 RLHAk1KcMGoWg==
Content-Type: multipart/mixed; boundary="===============7422068697806635002=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3168bba91f4e61774032a2227da0d9c9b7042f70f49fdbdd79ad7e2cf62d2c85@mail.kernel.org>
In-Reply-To: <20260225092651.94689-4-pilgrimtao@gmail.com>
References: <20260225092651.94689-4-pilgrimtao@gmail.com>
Subject: Re: [PATCH v2 3/6] bpf: add bpf_list_add_impl to insert node after a given list node
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,leon.hwang@linux.dev,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 10:22:52 +0000 (UTC)

--===============7422068697806635002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 093600363564..0d7581786a14 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> +__bpf_kfunc int bpf_list_add_impl(struct bpf_list_node *prev,
> +				  struct bpf_list_node *node,
> +				  void *meta__ign, u64 off)

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7a54cd749aec..9558b7020b89 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -14124,6 +14128,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>
>  	if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>  	    meta.func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> +	    meta.func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
>  	    meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>  		release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
>  		insn_aux->insert_off = regs[BPF_REG_2].off;

Is the verifier enforcing that the bpf_spin_lock is held when
bpf_list_add_impl is called?

The existing bpf_list_push_front_impl and bpf_list_push_back_impl get
lock enforcement because they take a bpf_list_head* as their first
argument. That argument type triggers __process_kf_arg_ptr_to_graph_root
in the verifier, which calls check_reg_allocation_locked():

kernel/bpf/verifier.c:__process_kf_arg_ptr_to_graph_root() {
    ...
    if (check_reg_allocation_locked(env, reg)) {
        verbose(env, "bpf_spin_lock at off=%d must be held for %s\n",
            rec->spin_lock_off, head_type_name);
        return -EINVAL;
    }
    ...
}

bpf_list_add_impl takes two bpf_list_node* arguments and no
bpf_list_head*. The verifier processes both arguments through
__process_kf_arg_ptr_to_graph_node, which does not call
check_reg_allocation_locked. This means a BPF program could call
bpf_list_add_impl without holding the spin lock.

With bpf_refcount, a program can hold an owning reference to an
in-list node that survives lock release:

    bpf_spin_lock(&lock);
    bpf_list_push_front(&head, &node->node);
    extra = bpf_refcount_acquire(node);
    bpf_spin_unlock(&lock);
    /* extra is still an owning ref, call without lock */
    bpf_list_add_impl(&extra->node, &new_node->node, ...);

This would execute list_add() without synchronization, which could
corrupt the list.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22391130139

AI-authorship-score: low
AI-authorship-explanation: Code closely follows existing bpf_list_push_front/back patterns with natural kernel commit style and precise BPF-specific terminology.
issues-found: 1
issue-severity-score: high
issue-severity-explanation: Missing verifier spin lock enforcement for bpf_list_add_impl allows unsynchronized list_add() calls that can corrupt the linked list.

--===============7422068697806635002==--
