Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552D2BEFED;
	Fri, 17 Apr 2026 20:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776457356; cv=none; b=XPTNcghFCdlctzvB3s3MSN6W7Kt/8wvnzi4D5C4Ut+nH1f+2vzW/zinGM9AE2UAfb63/6PAnepVYshzMKSS+zOAm6PYDWgXwMmJ+rRNghRMFiNg8bh61xl0cALNHW4lypUGuw9jAaG3NPKtov9xw/DDJ6OqYBmvzRBzexOKlr3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776457356; c=relaxed/simple;
	bh=UFICwoR3l29oefome02gwjvP6XoTQhJXJINEDjPBK04=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sI0omps1cg0NeOvd9Cv9dXS196+RpW9/booWaL173/WzGm1mTix9WdmVVZLefotU0mlumWD1sn9q1RQvsTb2mKQ+4Rz65rlx2kyj/qQzacQZQbNOIQu9SNC17gPhpPQy89rryMMU7dyUIgjYykwi8bea/RIGtSaU1y/rJHKJm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7sMn6Q9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7sMn6Q9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A46C19425;
	Fri, 17 Apr 2026 20:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776457356;
	bh=UFICwoR3l29oefome02gwjvP6XoTQhJXJINEDjPBK04=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=W7sMn6Q9jKH9FOwhClxeENDFyOjdnMk+81J3ocBBuTbdGIYNh6Oh/NQb7YqCYmUol
	 SJhT1XpKElmZcdjsDFzqEA1WJ4zIZDCJ5Ed03AvjP9fS+AKRcpheFxaca49i3LF2m/
	 ZuJvpRDooF5uF2xc85r5tik9HO94idfejfBWimczB5y9zKXrK120RjSiUm/iRd7K+T
	 XL3hI1bD5p6lF5pV251uFdq/5Rhsfo3ltSWPN4WvtmAZ7+RtS/+UpAICsql6sepOhq
	 RSSbPT8CTjmExLQW61tW+rCMrCpQxYaR/Jj717X/hiK7ErcE2oFyf4n0vlFgQhHD77
	 lOBEXC1IfavQQ==
Content-Type: multipart/mixed; boundary="===============9202257925490167783=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <11459a06ee7d070bdbdc3699d59adcdca12d5178eaa6ebd15286e0f51cc27141@mail.kernel.org>
In-Reply-To: <20260417192502.194548-13-jolsa@kernel.org>
References: <20260417192502.194548-13-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 12/28] bpf: Add bpf_trampoline_multi_attach/detach functions
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 20:22:36 +0000 (UTC)

--===============9202257925490167783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c815227f3bc6..37c96daaae9a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 23856bd28d59..f6180f15d5a4 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1447,6 +1447,276 @@ int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,

[ ... ]

> +int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
> +				struct bpf_tracing_multi_link *link)
> +{
> +	struct bpf_tracing_multi_data *data = &link->data;
> +	struct bpf_attach_target_info tgt_info = {};
> +	struct btf *btf = prog->aux->attach_btf;
> +	struct bpf_tracing_multi_node *mnode;
> +	struct bpf_trampoline *tr;
> +	int i, err, rollback_cnt;
> +	u64 key;
> +
> +	for_each_mnode(mnode, link) {
> +		rollback_cnt = i;
> +
> +		err = bpf_check_attach_btf_id_multi(btf, prog, ids[i], &tgt_info);
> +		if (err)
> +			goto rollback_put;
> +
> +		key = bpf_trampoline_compute_key(NULL, btf, ids[i]);
> +
> +		tr = bpf_trampoline_get(key, &tgt_info);
> +		if (!tr) {
> +			err = -ENOMEM;
> +			goto rollback_put;
> +		}
> +
> +		mnode->trampoline = tr;
> +		mnode->node.link = &link->link;
> +
> +		cond_resched();
> +	}
> +
> +	err = init_tracing_multi_data(data);
> +	if (err) {
> +		rollback_cnt = link->nodes_cnt;
> +		goto rollback_put;
> +	}
> +
> +	trampoline_lock_all();
> +
> +	for_each_mnode(mnode, link) {
> +		bpf_trampoline_multi_attach_init(mnode->trampoline);
> +
> +		data->entry = &mnode->entry;
> +		err = __bpf_trampoline_link_prog(&mnode->node, mnode->trampoline, NULL,
> +						 &trampoline_multi_ops, data);
> +		if (err) {
> +			rollback_cnt = i;
> +			goto rollback_unlink;
> +		}
> +	}
> +
> +	rollback_cnt = link->nodes_cnt;
> +	if (ftrace_hash_count(data->reg)) {
> +		err = update_ftrace_direct_add(&direct_ops, data->reg);
> +		if (err)
> +			goto rollback_unlink;
> +	}
> +
> +	if (ftrace_hash_count(data->modify)) {
> +		err = update_ftrace_direct_mod(&direct_ops, data->modify, true);
> +		if (err) {
> +			WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->reg));
> +			goto rollback_unlink;
> +		}
> +	}

Does update_ftrace_direct_del need a guard here?

When update_ftrace_direct_mod fails, the recovery code unconditionally
calls update_ftrace_direct_del(&direct_ops, data->reg). However,
update_ftrace_direct_add is itself only invoked when data->reg is
non-empty:

    if (ftrace_hash_count(data->reg)) {
        err = update_ftrace_direct_add(&direct_ops, data->reg);
        ...
    }

If all trampolines being multi-attached already had cur_image != NULL,
nothing is ever added to data->reg, and the add call is skipped. Yet
the recovery path still calls update_ftrace_direct_del with the empty
data->reg.

update_ftrace_direct_del() at kernel/trace/ftrace.c:6511 does:

    if (!hash_count(hash))
        return -EINVAL;

so it returns -EINVAL, and WARN_ON_ONCE fires. No further damage is
done since the rollback_unlink path still unwinds correctly, but this
is a spurious warning that becomes visible whenever
update_ftrace_direct_mod fails and data->reg happens to be empty.

The undo should match the guard used for the add:

    if (err) {
        if (ftrace_hash_count(data->reg))
            WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->reg));
        goto rollback_unlink;
    }

> +
> +	for_each_mnode(mnode, link)
> +		bpf_trampoline_multi_attach_free(mnode->trampoline);
> +
> +	trampoline_unlock_all();
> +
> +	remove_tracing_multi_data(data);
> +	return 0;
> +
> +rollback_unlink:
> +	for_each_mnode_cnt(mnode, link, rollback_cnt) {
> +		bpf_trampoline_remove_prog(mnode->trampoline, &mnode->node);
> +		bpf_trampoline_multi_attach_rollback(mnode->trampoline);
> +	}
> +
> +	trampoline_unlock_all();
> +
> +	clear_tracing_multi_data(data);
> +	rollback_cnt = link->nodes_cnt;
> +
> +rollback_put:
> +	for_each_mnode_cnt(mnode, link, rollback_cnt)
> +		bpf_trampoline_put(mnode->trampoline);
> +
> +	return err;
> +}

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 739e730add96..4f5a21a4eddc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19658,6 +19658,58 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
> +int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 btf_id,
> +				  struct bpf_attach_target_info *tgt_info)
> +{
> +	const struct btf_type *t;
> +	unsigned long addr;
> +	const char *tname;
> +	int err;
> +
> +	if (!btf_id || !btf)
> +		return -EINVAL;
> +
> +	/* Check noreturn attachment. */
> +	if (prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
> +	     btf_id_set_contains(&noreturn_deny, btf_id))
> +		return -EINVAL;

Should this be && instead of ||?

This condition rejects all BPF_TRACE_FEXIT_MULTI programs regardless
of whether the target is on the noreturn_deny list. The C operator
precedence makes this `A || B`, so if the program's expected_attach_type
is BPF_TRACE_FEXIT_MULTI, the entire condition is TRUE and the
function returns -EINVAL.

This breaks FEXIT_MULTI attachment support. The caller
bpf_trampoline_multi_attach is the multi-attach path that supports both
BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI (see is_tracing_multi()
in include/linux/bpf.h).

The equivalent check in the single-target path, check_attach_btf_id,
correctly uses &&:

    } else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
               prog->expected_attach_type == BPF_TRACE_FSESSION ||
               prog->expected_attach_type == BPF_MODIFY_RETURN) &&
               btf_id_set_contains(&noreturn_deny, btf_id)) {
            ...
    }

The intended semantics are to reject FEXIT_MULTI attachments only when
the target is on noreturn_deny. The correct operator is &&:

    if (prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI &&
        btf_id_set_contains(&noreturn_deny, btf_id))
        return -EINVAL;

Additional evidence:
1. The comment says "Check noreturn attachment" but the current code
   rejects all FEXIT_MULTI regardless of noreturn status.
2. The indentation of the second line matches the alignment pattern
   used when lines are joined by && rather than ||.
3. bpf_check_attach_target handles case BPF_TRACE_FEXIT_MULTI as a
   valid attach type in its switch.

Note: In this commit, bpf_trampoline_multi_attach has no callers yet;
it is infrastructure wired up by a later commit. Once the link creation
path invokes bpf_trampoline_multi_attach for a FEXIT_MULTI program,
every such attach will fail with -EINVAL.

> +
> +	/* Check and get function target data. */
> +	t = btf_type_by_id(btf, btf_id);
> +	if (!t)
> +		return -EINVAL;
> +	tname = btf_name_by_offset(btf, t->name_off);
> +	if (!tname)
> +		return -EINVAL;
> +	if (!btf_type_is_func(t))
> +		return -EINVAL;
> +	t = btf_type_by_id(btf, t->type);
> +	if (!btf_type_is_func_proto(t))
> +		return -EINVAL;
> +	err = btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel);
> +	if (err < 0)
> +		return err;
> +	if (btf_is_module(btf)) {
> +		/* The bpf program already holds reference to module. */
> +		if (WARN_ON_ONCE(!prog->aux->mod))
> +			return -EINVAL;
> +		addr = find_kallsyms_symbol_value(prog->aux->mod, tname);
> +	} else {
> +		addr = kallsyms_lookup_name(tname);
> +	}
> +	if (!addr || !ftrace_location(addr))
> +		return -ENOENT;
> +
> +	/* Check sleepable program attachment. */
> +	if (prog->sleepable) {
> +		err = btf_id_allow_sleepable(btf_id, addr, prog, btf);
> +		if (err)
> +			return err;
> +	}
> +	tgt_info->tgt_addr = addr;
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24583317711
--===============9202257925490167783==--
