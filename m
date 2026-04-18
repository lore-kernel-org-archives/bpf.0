Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763C253F13;
	Sat, 18 Apr 2026 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776492657; cv=none; b=aGp3anZtmeQlOEnIUkwucyLcwRR+X6jPMTA6kK8BgwSCU+8LslZRPGzNb4Textl5SdbGtAiEAWcjmHPVkMAYnBsFNLyfaVpW+pUtf56uCzxBLMtDg773Vvi+bpf2RMAAgd+Cj2Wpm9L9igZOlKUknXrqey1miU3Nha9h5YEqBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776492657; c=relaxed/simple;
	bh=jUh5HmiqFg5m+A/RafzH7BAp4tTUKoTOwxK92EFXLIg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=klqWQ0grjvOWNABsuQBCtvy15y5mSv8qAsGzsQmudoA9RiAAWuivfwSssD7p/NonNYNKBVW+iRUCL++FEOAgQG/JDurh10j2JEaiegrWvJYAeB3gCpaAyB/fMzrdFsyEMouEE8mJ3WVFXP8j/+7QAeF9Zs4rbWAo8nMWD0Lc9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhvMoYRD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhvMoYRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A38C19424;
	Sat, 18 Apr 2026 06:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776492657;
	bh=jUh5HmiqFg5m+A/RafzH7BAp4tTUKoTOwxK92EFXLIg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=DhvMoYRDwVIjRj0D8gYo2J9UhSFnHFBRquD8FotGThMTH8nuI7r7846+QhN2/EDq2
	 37Z8Ib2kjQPwTqAX2Fl+raRMSpdlqDICKOGD/oMqPTe0HOcDUh6K/lb1rBHqPzGycc
	 VJT2UD+6A/RscVFLnL2uMLiY422+wQi2ix5JTdBXfIHoOP6CSMXnNbL5Ta3WWGQDUX
	 0g0fh5mfCyHZFM5/KXrnjUopjIiJ3+KI3DqQ7onrRIchCqPTzuz8664th5m0AMNXEY
	 aPsJd3V2cBtW8VnFUbvmvpCHzJlkZydCWN2n337YtOEba7b8NBPdXXqSoxLDQvNw/o
	 x0ufTFkuStFYg==
Content-Type: multipart/mixed; boundary="===============6606325903023202105=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0fefc9ca058787dddef9c125163a0182c6ddd1f47d2754f2ddbb5a82bfc9126a@mail.kernel.org>
In-Reply-To: <20260417192502.194548-13-jolsa@kernel.org>
References: <20260417192502.194548-13-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 12/28] bpf: Add bpf_trampoline_multi_attach/detach functions
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 06:10:57 +0000 (UTC)

--===============6606325903023202105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1447,6 +1447,276 @@ int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>  	return -ENOTSUPP;
>  }
>
> +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
> +    defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS) && \
> +    defined(CONFIG_BPF_SYSCALL)
> +
> +static void trampoline_lock_all(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
> +		mutex_lock(&trampoline_locks[i].mutex);
> +}
> +
> +static void trampoline_unlock_all(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
> +		mutex_unlock(&trampoline_locks[i].mutex);
> +}
> +
> +static void remove_tracing_multi_data(struct bpf_tracing_multi_data *data)
> +{
> +	ftrace_hash_remove(data->reg);
> +	ftrace_hash_remove(data->unreg);
> +	ftrace_hash_remove(data->modify);
> +}
> +
> +static void clear_tracing_multi_data(struct bpf_tracing_multi_data *data)
> +{
> +	remove_tracing_multi_data(data);
> +
> +	free_ftrace_hash(data->reg);
> +	free_ftrace_hash(data->unreg);
> +	free_ftrace_hash(data->modify);
> +}
> +
> +static int init_tracing_multi_data(struct bpf_tracing_multi_data *data)
> +{
> +	data->reg    = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> +	data->unreg  = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> +	data->modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> +
> +	if (!data->reg || !data->unreg || !data->modify) {
> +		clear_tracing_multi_data(data);
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +static void ftrace_hash_add(struct ftrace_hash *hash, struct ftrace_func_entry *entry,
> +			    unsigned long ip, unsigned long direct)
> +{
> +	entry->ip = ip;
> +	entry->direct = direct;
> +	add_ftrace_hash_entry(hash, entry);
> +}
> +
> +static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_image *im, void *ptr)
> +{
> +	unsigned long addr = (unsigned long) im->image;
> +	unsigned long ip = ftrace_location(tr->ip);
> +	struct bpf_tracing_multi_data *data = ptr;
> +
> +	if (bpf_trampoline_use_jmp(tr->flags))
> +		addr = ftrace_jmp_set(addr);
> +
> +	ftrace_hash_add(data->reg, data->entry, ip, addr);
> +	tr->cur_image = im;
> +	return 0;
> +}
> +
> +static int unregister_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *ptr)
> +{
> +	unsigned long addr = (unsigned long) tr->cur_image->image;
> +	unsigned long ip = ftrace_location(tr->ip);
> +	struct bpf_tracing_multi_data *data = ptr;
> +
> +	if (bpf_trampoline_use_jmp(tr->flags))
> +		addr = ftrace_jmp_set(addr);
> +
> +	ftrace_hash_add(data->unreg, data->entry, ip, addr);
> +	tr->cur_image = NULL;
> +	return 0;
> +}
> +
> +static int modify_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, struct bpf_tramp_image *im,
> +			       bool lock_direct_mutex, void *ptr)
> +{
> +	unsigned long addr = (unsigned long) im->image;
> +	unsigned long ip = ftrace_location(tr->ip);
> +	struct bpf_tracing_multi_data *data = ptr;
> +
> +	if (bpf_trampoline_use_jmp(tr->flags))
> +		addr = ftrace_jmp_set(addr);
> +
> +	ftrace_hash_add(data->modify, data->entry, ip, addr);
> +	tr->cur_image = im;
> +	return 0;
> +}
> +
> +static const struct bpf_trampoline_ops trampoline_multi_ops = {
> +	.register_fentry   = register_fentry_multi,
> +	.unregister_fentry = unregister_fentry_multi,
> +	.modify_fentry     = modify_fentry_multi,
> +};
> +
> +static void bpf_trampoline_multi_attach_init(struct bpf_trampoline *tr)
> +{
> +	tr->multi_attach.old_image = tr->cur_image;
> +	tr->multi_attach.old_flags = tr->flags;
> +}
> +
> +static void bpf_trampoline_multi_attach_free(struct bpf_trampoline *tr)
> +{
> +	if (tr->multi_attach.old_image)
> +		bpf_tramp_image_put(tr->multi_attach.old_image);
> +
> +	tr->multi_attach.old_image = NULL;
> +	tr->multi_attach.old_flags = 0;
> +}
> +
> +static void bpf_trampoline_multi_attach_rollback(struct bpf_trampoline *tr)
> +{
> +	if (tr->cur_image)
> +		bpf_tramp_image_put(tr->cur_image);
> +	tr->cur_image = tr->multi_attach.old_image;
> +	tr->flags = tr->multi_attach.old_flags;
> +
> +	tr->multi_attach.old_image = NULL;
> +	tr->multi_attach.old_flags = 0;
> +}
> +
> +#define for_each_mnode_cnt(mnode, link, cnt) \
> +	for (i = 0, mnode = &link->nodes[i]; i < cnt; i++, mnode = &link->nodes[i])
> +
> +#define for_each_mnode(mnode, link) \
> +	for_each_mnode_cnt(mnode, link, link->nodes_cnt)
> +
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

When user-provided ids[] contains duplicate BTF IDs (or distinct IDs
that resolve to the same trampoline key), multiple nodes point to the
same struct bpf_trampoline. The link loop above then calls
bpf_trampoline_multi_attach_init() more than once on that trampoline,
overwriting the saved old_image with the newly assigned cur_image from
the previous iteration.

Scenario with ids[0] == ids[1] and trampoline X starting with OLD_X:

  i=0: attach_init(X) saves old_image=OLD_X
       __bpf_trampoline_link_prog() -> modify_fentry_multi() sets
       X->cur_image=NEW_X (OLD_X refcount not dropped, intent is for
       multi_attach_free() to release it later).

  i=1: attach_init(X) re-runs on the same trampoline and overwrites
       old_image=NEW_X (the only saved reference to OLD_X is lost).
       __bpf_trampoline_link_prog() returns -EBUSY (duplicate prog).
       rollback_cnt=i=1; goto rollback_unlink.

  rollback_unlink calls bpf_trampoline_multi_attach_rollback(X) once:

    static void bpf_trampoline_multi_attach_rollback(struct bpf_trampoline *tr)
    {
        if (tr->cur_image)
            bpf_tramp_image_put(tr->cur_image);    /* puts NEW_X */
        tr->cur_image = tr->multi_attach.old_image;  /* = NEW_X (stale!) */
        ...
    }

Result: OLD_X leaks (its refcount is never decremented). cur_image
points at NEW_X which was just released via bpf_tramp_image_put().

The rollback_put loop calls bpf_trampoline_put() which frees the
trampoline (prog was removed, progs_hlist is empty), so the dangling
NEW_X pointer is cleaned up. However OLD_X remains allocated via
module_alloc forever.

Reachability: commit dbf2afe2f603 ("bpf: Add support for tracing multi
link") copies ids[] from userspace without deduplication. The series'
selftests (commit 411fb40d4b2a "selftests/bpf: Add tracing multi attach
fails test", 'fail#7 (kernel) attach with duplicate id') exercise this
path explicitly, expecting -EBUSY.

The trigger requires the shared trampoline to already have cur_image !=
NULL when the first iteration runs (i.e., another program attached to
the same function), so modify_fentry_multi() is used and there is a
real OLD_X to leak. The first-time-attach case (register_fentry_multi,
OLD_X=NULL) only leaves cur_image dangling briefly until the trampoline
is freed.

Can the code save old_image/old_flags once per trampoline instead of
once per node, or store them per-mnode to avoid overwriting the saved
state?

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
> +			                                                       ^^^^^^^^^^
> +			goto rollback_unlink;
> +		}
> +	}

The recovery path unconditionally calls update_ftrace_direct_del with
data->reg, but update_ftrace_direct_add is only invoked when data->reg
is non-empty:

    if (ftrace_hash_count(data->reg)) {
        err = update_ftrace_direct_add(&direct_ops, data->reg);
        ...
    }

When update_ftrace_direct_mod fails and all trampolines already had
cur_image != NULL (so nothing was added to data->reg),
update_ftrace_direct_del is called with an empty hash.
update_ftrace_direct_del at kernel/trace/ftrace.c:6511 checks:

    if (!hash_count(hash))
        return -EINVAL;

so it returns -EINVAL and the WARN_ON_ONCE fires spuriously. Should
this guard match the add path?

    if (ftrace_hash_count(data->reg))
        WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->reg));

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
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19658,6 +19658,58 @@ struct bpf_attach_target_info tgt_info = {};
>  	return 0;
>  }
>
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

Operator precedence issue in the noreturn check. The two subexpressions
are joined by ||, so the function returns -EINVAL whenever EITHER:

  (a) the program's expected_attach_type is BPF_TRACE_FEXIT_MULTI
      (regardless of whether btf_id targets a noreturn function), OR

  (b) the btf_id is in the noreturn_deny set (regardless of program
      attach type, rejecting FENTRY_MULTI attachments to noreturn
      functions as well).

The intent is to reject only FEXIT-like multi attachments to noreturn
functions. The non-multi path in check_attach_btf_id() correctly uses
&&:

    } else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
               prog->expected_attach_type == BPF_TRACE_FSESSION ||
               prog->expected_attach_type == BPF_MODIFY_RETURN) &&
               btf_id_set_contains(&noreturn_deny, btf_id)) {
        ...
        return -EINVAL;
    }

Consequences once bpf_trampoline_multi_attach() is wired up from
user-space (commit dbf2afe2f603 "bpf: Add support for tracing multi
link"):

  1. Every BPF_TRACE_FEXIT_MULTI program attach request is rejected
     with -EINVAL, even when the target function returns normally. This
     disables BPF_TRACE_FEXIT_MULTI entirely.

  2. Any tracing_multi program (including BPF_TRACE_FENTRY_MULTI) is
     rejected when its btf_id is in noreturn_deny (do_exit,
     __x64_sys_exit, make_task_dead, etc.). Rejecting FENTRY_MULTI on
     noreturn functions is an unintended behavioral restriction.

Forward search in the git range shows commit bfcad202ce99 ("bpf: Add
support for tracing_multi link session") rewrites this hunk to:

    if ((prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
         prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI) &&
         btf_id_set_contains(&noreturn_deny, btf_id))
        return -EINVAL;

The parenthesization + && in the later commit confirms this is a
precedence bug. Should this use && instead?

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
> +
>  struct btf *bpf_get_btf_vmlinux(void)
>  {
>  	if (!btf_vmlinux && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24598000047
--===============6606325903023202105==--
