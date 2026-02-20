Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723F433F8CE;
	Fri, 20 Feb 2026 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585075; cv=none; b=AKciUID2sExbRQWQ5s5OH3yhIOkbhTEr+vpNb+SogLg7ogyQowJdGAgVwEcp18H0fQb0jEybMdTJKsJvg0/yfGfm1bqYqdqF9/FVMrrKgDozbAw5bMEVtJ6Rcq5Xh7le3dS6pJ7nIwvZGZIWwQp7EXHz6yg5+PyOBxomQU5FnIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585075; c=relaxed/simple;
	bh=CiHuZTnydyBotiAdFQldr8f3dlhH5WbztsMtvmrp+/M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=e9Q5FIdsLaKcaPdklDQMtyTH63iaWStV/rAiVIY9IEJmOgOvpLCPcOeN7FSRQmJKDQpdygZx+hqZu9CS867KbucHSYNGZnlbmeeNtsqYIlu8R8QWV4zfsOB452qpc+Cjio1gXT7dv5S7kGK/5xFytuJs/++6BoAd/bTUQvxn5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0XGg2+L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0XGg2+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE1AC116C6;
	Fri, 20 Feb 2026 10:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771585075;
	bh=CiHuZTnydyBotiAdFQldr8f3dlhH5WbztsMtvmrp+/M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=K0XGg2+L5ubC6JMjOQUuq0oWDRrOH2bselqsZhAKEXYFlGUjBlPUA/0FXFfjp3rhb
	 R8kafjCBCY7aXYNRdb5mjb0KazGNCh7gPLfQUCn7ATtfpjIAqilvElUhpYZkjFzdfo
	 U3R3ezwvGbnamIxvE9KgooRogL/TWbn64JSu3C/esg/4w15+nnhYQkPKOKsWV7UhVh
	 qKxnVcxUKpmXPndk7UWJbofbJXjdEvP09fpqz9BE6fZyx0sLsDe5v8pghpCN5rXMUX
	 DpTgsTXJi/oHPvSjmhQU8WKz70s3mGA00i/ZW/1WV4QvPwaRRFMzfsY/J0PqqkVNH1
	 +KExBc5YitomQ==
Content-Type: multipart/mixed; boundary="===============7618066035719249140=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e9f20706c4184df2a84a176fd520277f1d2a9bc08f1101b00b34ff415b6158c@mail.kernel.org>
In-Reply-To: <20260220100649.628307-8-jolsa@kernel.org>
References: <20260220100649.628307-8-jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 07/17] bpf: Add bpf_trampoline_multi_attach/detach functions
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 20 Feb 2026 10:57:54 +0000 (UTC)

--===============7618066035719249140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 2d701bc6e1a5..c32205adfebe 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> +static int unregister_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr,
> +				   void *ptr)
> +{
> +	unsigned long addr = (unsigned long) old_addr;
> +	unsigned long ip = ftrace_location(tr->ip);
> +	struct fentry_multi_data *data = ptr;
> +
> +	if (bpf_trampoline_use_jmp(tr->flags))
> +		addr = ftrace_jmp_set(addr);
> +	return add_ftrace_hash_entry_direct(data->unreg, ip, addr) ? 0 : -ENOMEM;
> +}

[ ... ]

> +int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
> +				struct bpf_tracing_multi_link *link)
> +{
> +	struct bpf_attach_target_info tgt_info = {};
> +	struct bpf_tracing_multi_node *mnode;
> +	int j, i, err, cnt = link->nodes_cnt;
> +	struct fentry_multi_data data = {};
> +	struct bpf_trampoline *tr;
> +	u64 key;
> +
> +	data.reg = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> +	if (!data.reg)
> +		return -ENOMEM;
> +
> +	data.modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> +	if (!data.modify) {
> +		free_ftrace_hash(data.reg);
> +		return -ENOMEM;
> +	}

data.unreg is left as NULL here. In the forward path this is
fine since only data.reg and data.modify are used, but the
rollback path can reach unregister_fentry_multi() which calls
add_ftrace_hash_entry_direct(data->unreg, ...) with a NULL hash.

This happens when rollback_unlink calls
__bpf_trampoline_unlink_prog() on a trampoline that had no
other BPF programs before this attach. Removing the only
program brings total to 0, so bpf_trampoline_update_ops()
calls ops->unregister_fentry, reaching:

    unregister_fentry_multi()
      add_ftrace_hash_entry_direct(data->unreg, ip, addr)
        __add_hash_entry(hash, entry)
          ftrace_hash_key(hash, ...)    <-- NULL dereference

Should data.unreg also be allocated here to cover the rollback
path?

> +
> +	for (i = 0; i < cnt; i++) {
> +		mnode = &link->nodes[i];
> +		err = bpf_check_attach_target(NULL, prog, NULL, ids[i], &tgt_info);
> +		if (err)
> +			goto rollback_put;
> +
> +		key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf, ids[i]);
> +
> +		tr = bpf_trampoline_get(key, &tgt_info);
> +		if (!tr) {
> +			err = -ENOMEM;
> +			goto rollback_put;
> +		}
> +
> +		mnode->trampoline = tr;
> +		mnode->node.link = &link->link;
> +	}

After this loop completes, all cnt trampolines have been
obtained via bpf_trampoline_get() with refcounts incremented.

> +
> +	trampoline_lock_all();
> +
> +	for (i = 0; i < cnt; i++) {
> +		mnode = &link->nodes[i];
> +		err = __bpf_trampoline_link_prog(&mnode->node, mnode->trampoline, NULL,
> +						 &trampoline_multi_ops, &data);
> +		if (err)
> +			goto rollback_unlink;
> +	}

[ ... ]

> +rollback_unlink:
> +	for (j = 0; j < i; j++) {
> +		mnode = &link->nodes[j];
> +		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,
> +					NULL, &trampoline_multi_ops, &data));
> +	}
> +	trampoline_unlock_all();
> +
> +rollback_put:
> +	for (j = 0; j < i; j++)
> +		bpf_trampoline_put(link->nodes[j].trampoline);

When __bpf_trampoline_link_prog() fails at index i in the
second loop, this falls through from rollback_unlink to
rollback_put with i still set to the failing index. But all
cnt trampolines were obtained in the first loop above.

The rollback_put loop only puts trampolines 0..i-1, leaving
trampolines i..cnt-1 with elevated refcounts that are never
released.

When rollback_put is reached directly from the first loop
(bpf_trampoline_get or bpf_check_attach_target failure), the
j < i bound is correct since only 0..i-1 were obtained.

Could the rollback_unlink path set i = cnt before falling
through, or use a separate loop bound for the put?

> +
> +	free_fentry_multi_data(&data);
> +	return err;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22220470181

AI-authorship-score: low
AI-authorship-explanation: Natural kernel development style from a known BPF maintainer, with human-typical error handling oversights in batch operation code.
issues-found: 2
issue-severity-score: high
issue-severity-explanation: NULL pointer dereference in error rollback path causes kernel crash, combined with trampoline refcount leak preventing resource cleanup.

--===============7618066035719249140==--
