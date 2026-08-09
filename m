Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B03D45F4;
	Sun,  9 Aug 2026 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786292424; cv=none; b=hUtnknGfrD5BDJGsP9WXIkWBKALp6+st5wpIboSJlRdhm+UYpMfaShXPewTxQk2NiiQPhGHATYxaNx/tXoyKRH58b4bcu1sjoZ88C+/2eoc8+jYNOhEFf5TMKrAR3pBrtsuAfCvev806em/kuFDU7wvSV2CO+cML5e0TdsjjJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786292424; c=relaxed/simple;
	bh=4UJbLaSX91g5F19rrQD6Lvd+qUXC0mOURq4nXniGT7Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iTTI5Iwza3Bz/KZkj8ily71sRzPyHw0Z1fYb3A0U3Ahtp5aZwjkKyGBoQIRNSYZSuJccCljfZcrbCGUo52JTi9/lkSUNHlfNmTHugs8Fsid/IKXugjID2ND8sjLjg1jk7F9MoRZDdvJP1ckeFhVzT+b/8wvDcyOiWnGIgFBs1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja9NgRj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja9NgRj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D941F00A3A;
	Sun,  9 Aug 2026 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786292423;
	bh=CQJHcuy8BsZF0djR/GT3fEirKHsP6LDi/tUq1xY8IQI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ja9NgRj1j7vcFcyxbrH2+ED9tbQhco+9JmpoAibxqhbEA9A6OxYJR7rCKdyYX1Qkt
	 5rJ+2vFrybDA7cvwo6Osc9d5rTO9GkwASoypsT4P5wSABx9uwJwLZgTT+b3MNMwJWw
	 bd+wP2Hw3SQlWxyyFaOkaeVqSfHhWjAoGko6P6rzApcwgjjrb8ENdxkwTxOtGnzLJx
	 LSpe2l82N7xaK64KZ17LOa9FCXEi4Q+asfD+ifW/Ug/j5q7bT1OSD895g/LEoKmH4P
	 LQVjmJE+LgtKfGsIVREVmRlKrIwVmhR5+aPuK6yORJR3KygKQu/KAF+sDpyy5hYtig
	 lyoj3hdyx3ZxA==
Content-Type: multipart/mixed; boundary="===============6885693806017726717=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f227b719d241d4cc87954725d9ddaab8377c9991c7b6b03aaef4aa5d098fcca7@mail.kernel.org>
In-Reply-To: <20260809150111.45000-7-leon.hwang@linux.dev>
References: <20260809150111.45000-7-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 06/13] bpf: Add tracing_multi link fdinfo support for bpf progs
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,yatsenko@meta.com,avinash.duduskar@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,jordan@jrife.io,rongtao@cestc.cn,eyal.birger@gmail.com,pulehui@huawei.com,tanjingguo@huawei.com,malin89@huawei.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  9 Aug 2026 16:20:21 +0000 (UTC)

--===============6885693806017726717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a805a5b73303f..80928401830c7 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3759,26 +3759,46 @@ static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
>  }
>
>  #ifdef CONFIG_PROC_FS
> +static const char *bpf_prog_func_name(struct bpf_prog *prog, u32 btf_id)
> +{
> +	const struct btf *btf = prog->aux->btf;
> +	const struct btf_type *t;
> +
> +	t = btf_type_by_id(btf, btf_id);
> +	if (!t || !btf_type_is_func(t))
> +		return "";
> +
> +	return btf_name_by_offset(btf, t->name_off);
> +}
> +
>  static void bpf_tracing_multi_show_fdinfo(const struct bpf_link *link,
>  					  struct seq_file *seq)
>  {
>  	struct bpf_tracing_multi_link *tr_link =
>  		container_of(link, struct bpf_tracing_multi_link, link);
>  	bool has_cookies = !!tr_link->cookies;
> +	bool has_progs = !!tr_link->progs;
>
>  	seq_printf(seq, "attach_type:\t%u\n", tr_link->link.attach_type);
>  	seq_printf(seq, "cnt:\t%u\n", tr_link->nodes_cnt);
>
> -	seq_printf(seq, "%s\t %s\t %s\t %s\n", "obj-id", "btf-id", "cookie", "func");
> +	seq_printf(seq, "%s\t %s\t %s\t %s\n", has_progs ? "prog-id" : "obj-id", "btf-id", "cookie",
> +		   "func");
>  	for (int i = 0; i < tr_link->nodes_cnt; i++) {
>  		struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
> +		u64 cookie = has_cookies ? tr_link->cookies[i] : 0;
>  		u32 btf_id, obj_id;
>
>  		bpf_trampoline_unpack_key(mnode->trampoline->key, &obj_id, &btf_id);
> +		btf_id = has_progs ? (u32) mnode->trampoline->key : btf_id;
                        ^^^^

This isn't a bug, but since bpf_trampoline_unpack_key() only masks off
bit 31, which is never set for prog targets, does this re-assignment
change anything, or could the unpacked value be used directly?

bpf_trampoline_unpack_key() already sets btf_id = key & 0x7FFFFFFF, and
bit 31 is only set by the !tgt_prog branch of bpf_trampoline_compute_key()
(the kernel-BTF case).

In the has_progs case the key was built as:

    ((u64)tgt_prog->aux->id << 32) | ids[i]

and ids[i] must be a valid BTF type id (<= BTF_MAX_TYPE, 0xfffff) or
bpf_check_attach_target() would have rejected the attach, so (u32)key
and the unpacked btf_id are always equal here.

> +		if (has_progs)
> +			seq_printf(seq, "%u\t %u\t %llu\t %s\n",
> +				   obj_id, btf_id, cookie,
> +				   bpf_prog_func_name(tr_link->progs[i], btf_id));
> +		else
> +			seq_printf(seq, "%u\t %u\t %llu\t %pS\n",
> +				   obj_id, btf_id, cookie,
> +				   (void *) mnode->trampoline->ip);
>
>  		cond_resched();
>  	}

The commit message shows the sample fdinfo output but doesn't say much
about the implementation or why this change is needed. In particular:

> Show the target bpf prog info in the fdinfo.
>
> $ cat /proc/self/fdinfo/13
> pos:    0
> flags:  02000000
> mnt_id: 18
> ino:    1045
> link_type:      tracing_multi
> link_id:        9
> prog_tag:       9a7f9e3ab6f138ab
> prog_id:        25
> attach_type:    61
> cnt:    2
> prog-id  btf-id  cookie  func
> 21       4       16706819        target_1
> 22       5       16706819        target_2

This isn't a bug, but could the changelog say why the trampoline ip is
not usable as the func column for prog targets (tr->ip is 0 for JIT'd
prog addresses), rather than mostly showing the resulting output? It
also doesn't mention that the first column header changes from "obj-id"
to "prog-id" for prog-target links.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31320427087
--===============6885693806017726717==--
