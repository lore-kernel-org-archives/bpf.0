Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614625;
	b=fX/ozbkPNey7nWcgZWbt6FTUx0vCKcfhwZPO3qnqM1bR+cWYkeV9gT7Se2gykxZIjQeu
	 OYtFC2HakwwSB/CAekRZsgbEHBjcL6QfzKsxvojpgFD+N+R7wqpPg7hc4M/2NqgYpo/KA
	 VLKb0aY6/HkOPwnr5TFmXzY6jmrFFHSMkoKxF9xWaj1Eh7HTC0no6pF6yNmuejkBj2xgg
	 LuiSPuEvf2zhmmEmK9jTa4Y+Svsfv84a9CLTvshbOoEBpgE+LaW0Z+lrHZA482JLYkaI1
	 I65PHRYhdCEW4HcxEyVQipPdrtwxuKz5IBWXZd8Vnh51ET6lLOX/1weZfKuNrwGK8Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614625;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=KBK4LZ76/LMHs38+RcqRgWOhkYyz4na1Z6dIKP/tOqk=;
	b=p0J0KbLLiBegVLqhZICmOlHSQ63ghHuQqtE7FRl6i0CYOz1HeUzEc3bqooaKdEmkKRqm
	 yrzsaOwno8ZiwdJ3TbEzt0ywo30NvKpNQoeXImf60NDTIjSaq9lJaacNTxiJH04e9iApA
	 YifDCBbpjZDMDA/0Q8XGmAbdHk+74JZxKq+zsuKiwZKOK0IgdnYzPYFEyjiuPc3rXGJKa
	 zT3haFovYHa2iu/xCfx4liWU8A8DQFKbp4Bl86l8QfW6VKTBBYnRP06KEZiA9hqB4m8VQ
	 87bLBkjC1fLXVkTFemvtT6b6kfumxJrcfD7q4P+YMJ+6TgPSQJXtOb1RC+LakZa+pxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGcJTwNS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9419606A31D;
	Wed, 21 Oct 2026 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGcJTwNS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BE01F000C2;
	Wed, 21 Oct 2026 20:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792614624;
	bh=KBK4LZ76/LMHs38+RcqRgWOhkYyz4na1Z6dIKP/tOqk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LGcJTwNS+wrlBBLVvQ9ovngE23Noc9VOmWvk2FRS75Y/m/cgQwVkUTonRoFDY/Frv
	 WLGOMZ04f4qVLz7PtsOIxRPvCKIlgUMIi/7JVI9zP9SDlYdI2+ZlT5rje/up+3NVHe
	 q+Q8DK4stx0Zuum4v4z2Jdf76/uRakBFa3nwABCIzPQoGRfndK1P1ObqSfPI26ryJt
	 KXBcJe91FoGxwtKVgEN3R6jj7JkhTMa29qbJv/83ZBzdgKhDvYfpzUJFGBQan4wmES
	 MAQpQVk/1Rd17mCrUwpUqfXmUgsYdU0nlaFIaXpIifjnPcAtJJf7s9OmsW2QsJPYrr
	 SizUAhXRnvmiQ==
Content-Type: multipart/mixed; boundary="===============0931245153222694076=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <409d58c6952c879c08413c5f5b00b325789263b4704147098dc43d9a4fd93b33@mail.kernel.org>
In-Reply-To: <20261021195759.119421-3-jolsa@kernel.org>
References: <20261021195759.119421-3-jolsa@kernel.org>
Subject: Re: [RFC bpf-next 2/9] bpf: Add uprobe faultable user copy kfunc
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: bpf@vger.kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,linux-mm@kvack.org,akpm@linux-foundation.org,liam@infradead.org,ljs@kernel.org,linux-kselftest@vger.kernel.org,shuah@kernel.org,john.fastabend@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 21 Oct 2026 20:30:23 +0000 (UTC)

--===============0931245153222694076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add uprobe faultable user copy kfunc

TL;DR:
- New write-to-user kfunc may let CAP_BPF+CAP_PERFMON loaders write user
  memory, bypassing the helper's CAP_SYS_ADMIN requirement
- Unused enum (nit)

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -5139,6 +5170,31 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
>  	.set   = &generic_btf_ids,
>  };
>
> +BTF_KFUNCS_START(user_mem_btf_ids)
> +BTF_ID_FLAGS(func, bpf_probe_write_user_faultable, KF_SLEEPABLE | KF_PERFMON)
> +BTF_KFUNCS_END(user_mem_btf_ids)

The new kfunc does the same job as bpf_probe_write_user(), but it is gated
only by KF_PERFMON.  The verifier checks that flag as env->allow_ptr_leaks,
which is bpf_token_capable(token, CAP_PERFMON), and loading a
BPF_PROG_TYPE_KPROBE program already requires CAP_PERFMON (see
is_perfmon_prog_type() in syscall.c).  For this program type KF_PERFMON
doesn't seem to add any restriction.

The existing helper is gated on CAP_SYS_ADMIN in bpf_tracing_func_proto():

    if (!bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN))
        return NULL;
    switch (func_id) {
    case BPF_FUNC_probe_write_user:
        return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
               NULL : &bpf_probe_write_user_proto;

and include/uapi/linux/capability.h documents "CAP_SYS_ADMIN is required to
use bpf_probe_write_user."

With this patch, can a loader holding only CAP_BPF and CAP_PERFMON write to
user memory through the kfunc even though the helper refuses it?

The commit message carries over the LOCKDOWN_BPF_WRITE_USER restriction from
the helper but says nothing about the capability requirement.  Should
user_mem_kfunc_filter() also require
bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN) for this kfunc?  If
CAP_PERFMON is meant to be enough, could the changelog and capability.h
explain why?

> +
> +enum user_mem_kfunc_id {
> +	KF_bpf_probe_write_user_faultable,
> +};
> +

This isn't a bug, but enum user_mem_kfunc_id and its enumerator
KF_bpf_probe_write_user_faultable don't seem to be referenced anywhere, in
this commit or later in the series.  user_mem_kfunc_filter() compares against
bpf_probe_write_user_faultable_btf_id[0] from the BTF_ID_LIST_SINGLE below
instead.

The similar pattern in verifier.c (enum special_kfunc_type) works because it
indexes a BTF_ID_LIST, and there is no such list here.  Can the enum be
dropped?

> +BTF_ID_LIST_SINGLE(bpf_probe_write_user_faultable_btf_id, func,
> +		   bpf_probe_write_user_faultable)
> +
> +static int user_mem_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	if (kfunc_id == bpf_probe_write_user_faultable_btf_id[0])
> +		return security_locked_down(LOCKDOWN_BPF_WRITE_USER);
> +
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39668036298
--===============0931245153222694076==--
