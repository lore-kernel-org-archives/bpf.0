Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2E9368D51;
	Wed,  3 Jun 2026 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487538; cv=none; b=SxRSohjmP4npa5t5ueez1HMrSqorP+ONR/YI5S3JR8chj07Y2Hodig7yIat2dOutW+XDQe5f4z7zqjUHqe92XudVHWqznNDaVsXLzsMOlrMr1WUnCqziIEwxePdbM1qSHjTLBM39EyhrmJWitN5Ybp2LUebtkh3i3g+vzdAtNlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487538; c=relaxed/simple;
	bh=5/A7O3DT79Gdd6TU4cNV7fFyd6HLjaPFHcSvC0Fq2Bo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lK/9dgJRZn5JHlrgSle+s2VPPbJqOGEBIUQy2iuHhsjvdCji3a2ue80gcCxeP78egot/I9TVmu/oNF9a6M8gHVvIdYZoEInjJXvPOZ1wSVv2Fl1VnjQRReDQ5wucBxMrf6UK0q+mDHl10abaKq5vDnEtB0EAKEYOzwP31ELJUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdAVhWLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdAVhWLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C461F00893;
	Wed,  3 Jun 2026 11:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780487537;
	bh=AtHYcQ8rMbNlczfIJ0Hn37C1PknrbDcuvN1c7vLYZBQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CdAVhWLF8QUrAFUGncevOqhCnRm6Wcq9FBjSiYNEB6c5neJRzZnrq8IBMLEkas9Ub
	 i2WWDTSAsJjErk6FPwvNkmT+pBOwT0NlMUHJPRSHXId5s3K9v+musTQ4IFdX98shmO
	 rkPZpc7v2VrzBVee4cvFpyG7E2SasD3FZgwiTYFyybL81RF550sZFqQ8y6f9Rbt0qT
	 L4DOh1+P5j7hirQqjTqghqk6BDyqyCULPCk7zoJ/FKXSWpDFzKcLhr3QcvznQUaSIt
	 V7G/UYa1P/xiAQpyJTn727qzPiZgpZT1huoRJhm7oyBY0gV/RZvUK9tYG8nDSfWhQR
	 ju3ztfNzDwD+g==
Content-Type: multipart/mixed; boundary="===============6022185078031312976=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fff707db5383c996a05ea6013a227410ebc522c041d2b6719485328f18194169@mail.kernel.org>
In-Reply-To: <20260603110554.29590-13-jolsa@kernel.org>
References: <20260603110554.29590-13-jolsa@kernel.org>
Subject: Re: [PATCHv7 bpf-next 12/29] bpf: Add bpf_trampoline_multi_attach/detach functions
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  3 Jun 2026 11:52:17 +0000 (UTC)

--===============6022185078031312976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index ae7e4fdfe2a3..957e5d7f9554 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -1447,6 +1447,277 @@ int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>  	return -ENOTSUPP;
>  }
>
> +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
> +    defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS) && \
> +    defined(CONFIG_BPF_SYSCALL)

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

[ ... ]

> +int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
> +{
> +	struct bpf_tracing_multi_data *data = &link->data;
> +	struct bpf_tracing_multi_node *mnode;
> +	int i;
> +
> +	trampoline_lock_all();
> +
> +	for_each_mnode(mnode, link) {
> +		data->entry = &mnode->entry;
> +		bpf_trampoline_multi_attach_init(mnode->trampoline);
> +		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,
> +					NULL, &trampoline_multi_ops, data));
> +	}
> +
> +	if (ftrace_hash_count(data->unreg))
> +		WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->unreg));
> +	if (ftrace_hash_count(data->modify))
> +		WARN_ON_ONCE(update_ftrace_direct_mod(&direct_ops, data->modify, true));
> +
> +	for_each_mnode(mnode, link)
> +		bpf_trampoline_multi_attach_free(mnode->trampoline);
> +
> +	trampoline_unlock_all();
> +
> +	for_each_mnode(mnode, link)
> +		bpf_trampoline_put(mnode->trampoline);
> +
> +	clear_tracing_multi_data(data);
> +	return 0;
> +}

In v4, bot+bpf-ci@kernel.org raised a concern about the detach function
potentially failing due to memory allocation. The concern was that if
alloc_ftrace_hash() failed, the function would return -ENOMEM without
detaching any trampolines or releasing refcounts. Since the caller
(bpf_tracing_multi_link_release) uses WARN_ON_ONCE to drop the error,
the link struct would be freed while trampolines remained attached with
elevated refcounts, permanently leaking them and their ftrace hooks.

The reviewer suggested pre-allocating hashes during attach and storing
them in the link struct so that detach cannot fail.

In v7 (the current code), the bpf_tracing_multi_data structure is
embedded in the link structure and init_tracing_multi_data is called
during bpf_trampoline_multi_attach. The detach function now uses the
pre-allocated data from link->data rather than allocating new hashes,
which appears to resolve the original concern.

Reference: https://lore.kernel.org/bpf/711e8b90d27722e47cccfc30a1ccfe243ea7a696322997c15fda1a2147dba6a4@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26881310426
--===============6022185078031312976==--
