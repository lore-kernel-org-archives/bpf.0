Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB5407568;
	Tue,  9 Jun 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011926; cv=none; b=bgE+wuPYWu32spcNh7To4mzq8pYNy8HPs571T5l364rEnPbB3iylkVGHPhzdRMl+31UjmlYL3yVOWz2NIS2x3Iad4HsMB/c9QzUVZ9O/xNrdamPelrbcmG7SzA/crwO8+OJK38JSVBCElGK3JCIb2QTIr0NZLxSJAmnu96bdHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011926; c=relaxed/simple;
	bh=kWFES2TyrlYMSvzwVz4tP7SHjJ2+pPBrSQZXOG7ngYs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sKfuH+RN7APoZ/wHON8QFAlhxtPSIA7Cy0s+M1bdnsgjynSBcVN91/1VexchAD4roPXzjXobhte1wXyWD9kjSiKL8fG9srIRjegWE27KJdun+AJRDPq9k7v0hyBOMnV6MbujY2opp07TwTzvswQL67Y+DNpQyNEDlxgObrD7tvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1rVReY2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1rVReY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D371F00893;
	Tue,  9 Jun 2026 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781011925;
	bh=cNJvP8iSMNDLZrQvXGZzQlhjpHwyyEaglze8F2MRqxI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=M1rVReY2dvffCNh3Y8nfTmNX9TtEn/OWxJSAugwbKvkQx8L2zz3fPInlEjknu1OGt
	 TNSBnw8PcaICPk2DboXctkLyi8u4eU8vPzOkBX3zIgYhm1ELmhESOLEKW7UpO8gSFh
	 SJo86nx9mhnyOLzh+8jqjFEWrSJlm9+YWe5CCISZAlBfDOuEMyzaw3oeGwA2L3Jppv
	 KeWGtGVZxtNX3W3rgaxA+q5y7+gpEysQTG6Fz7K9+z2CJBNL08e+GLVxnizm5H7vRO
	 32yu9r83DgmqBmxIu9QI1AsTgB+l1Hxwc9Ka3Bq1PEbC0DdvYAatE9EtLLvWiCJuhy
	 jyVA1bPuSpycg==
Content-Type: multipart/mixed; boundary="===============1101246908249260579=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cbd1d4c4f72fe182f10751be48e9a18974ec718927ea0049fe0fa60d34555c44@mail.kernel.org>
In-Reply-To: <20260609125214.3096351-2-chenyuan_fl@163.com>
References: <20260609125214.3096351-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf v6 1/2] bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointer deref
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,chenyuan_fl@163.com
Cc: andrii@kernel.org,ast@kernel.org,bot+bpf-ci@kernel.org,bpf@vger.kernel.org,chenyuan@kylinos.cn,clm@meta.com,daniel@iogearbox.net,eddyz87@gmail.com,ihor.solodrai@linux.dev,jolsa@kernel.org,linux-kernel@vger.kernel.org,martin.lau@kernel.org,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  9 Jun 2026 13:32:04 +0000 (UTC)

--===============1101246908249260579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4..806c86388984 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12082,9 +12082,28 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		continue;
>  	}
>
> -	if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
> +	if (is_kfunc_arg_ignore(btf, &args[i]))
>  		continue;
>
> +	if (is_kfunc_arg_implicit(meta, i)) {
> +		/*
> +		 * This is an exhaustive list of the non-bpf_prog_aux
> +		 * implicit args kfuncs, which are handled
> +		 * post-verification by bpf_fixup_kfunc_call().
> +		 */
> +		if (is_bpf_obj_new_kfunc(meta->func_id) ||
> +		    is_bpf_percpu_obj_new_kfunc(meta->func_id) ||
> +		    is_bpf_obj_drop_kfunc(meta->func_id) ||
> +		    is_bpf_percpu_obj_drop_kfunc(meta->func_id) ||
> +		    is_bpf_refcount_acquire_kfunc(meta->func_id) ||
> +		    is_bpf_list_push_kfunc(meta->func_id) ||
> +		    is_bpf_rbtree_add_kfunc(meta->func_id))
> +			continue;
> +		verbose(env, "%s unrecognized implicit argument, possible BTF mismatch\n",
> +			reg_arg_name(env, argno));
> +		return -EFAULT;
> +	}
> +

Does this code compile? The call to reg_arg_name(env, argno) references
two symbols that don't exist at this commit. The function reg_arg_name()
is not defined in the tree: searching kernel/bpf/verifier.c finds the
identifier only once at this call site, and a tree-wide search yields no
definition. The variable argno is also undeclared: check_kfunc_args()
declares 'u32 regno = i + 1, ref_id, type_size;' but has no argno local.

Both trigger build failures (implicit declaration of function and
undeclared variable). The intended register is likely regno, matching the
pattern used elsewhere in this function:

    verbose(env, "R%d ...", regno);

Looking at the comment by Ihor Solodrai on Mon, 8 Jun 2026 17:54:36 -0700
(https://lore.kernel.org/bpf/eab4e479-2023-49b8-9915-1c8ef2356837@linux.dev/),
the list of allowed kfuncs is incomplete. It omits bpf_wq_set_callback,
bpf_stream_vprintk, bpf_stream_print_stack, bpf_task_work_schedule_signal,
and bpf_task_work_schedule_resume, all of which have KF_IMPLICIT_ARGS and
would trigger the new error path incorrectly.

Eduard Zingerman's response on Mon, 08 Jun 2026 23:20:36 -0700
(https://lore.kernel.org/bpf/0d63a8d68bf0778d6e931ed27892a5bcb151295d.camel@gmail.com/)
suggested an alternative fix: instead of enumerating kfuncs in the
verifier, check in bpf_fixup_kfunc_call() whether an implicit arg has the
KF_IMPLICIT_ARGS flag but wasn't filled by an earlier handler. This would
catch the BTF mismatch case without needing to maintain a list and without
breaking valid kfuncs.

The comment claims the list is exhaustive, but it's missing at least five
kfuncs. Should this use Eduard's suggested approach in bpf_fixup_kfunc_call()
instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27208267613
--===============1101246908249260579==--
