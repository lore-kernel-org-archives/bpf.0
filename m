Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793405787;
	b=hS9j0SOTh98nAs0/On4e65ofwTUqih8NnHQ195LaXbp7JcKxJ0K+aJCsCkAf9OjBrKrZ
	 Q+h84aYKhRHaVC41ljj3KXLkwN/qlaGjRZQKoJ1PTXmJEvLS/p7Y5xqKjyrrHZ6r7WHfp
	 9iHSpnIG1ry7yXTYbs0XVcyYgt/eYjTzdhkEDhsABy3lGusFq9qz2iDk5Y1NQv4GoqYm3
	 HV7TBzCbFe+OCbl+89HpyJKpASAP3+SbbmMSAZ/1n9roZ7oVTVw4/F8GUTkOKDYMd36Ez
	 ZxgtxQTv36875paXg+njM4jgXHmHQII4syfPrbjU6aBZA4cSFDRXfHgIr1GIAJjDDMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793405787;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=qTebanYubPihYVX1ivIebVGmB7SpO0Fzh3GLZSHN+JI=;
	b=2bkBM2udi3Kq/6qMbVSAzjAOomylH0FZbdKQrVOMjTrWnp7Vm/XRrbdvHRCI6NxNNvQa
	 Y/4i5k3Shiy2iXtkJmU6/wqQ1SDSJWIm90WiArItcuhbL6klPQG1e0nl9DvPX256PvyaE
	 e9zlVH0WyDaBf1sxme0Ak14DyL4Ff0fYEA4NVzof3i+mXcBGhh+qI0nsJ/Tgv16Wg1AbI
	 UaEskDFmZEzb85WOxGQX+CGypheS2HI/skr5+eOcKagiZbDu64M0sSmRMp/ry3cO38+HB
	 1y+9Ss/+032a5fnnvwenFpSQV/WBsKIYnJVj6LXpBokvfLODqxqyisFK3Ej/zo8iuvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+2QUZdU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9053606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+2QUZdU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EA11F0093A;
	Sat, 31 Oct 2026 00:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793405786;
	bh=qTebanYubPihYVX1ivIebVGmB7SpO0Fzh3GLZSHN+JI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=X+2QUZdUs4uQjQGlPeiJfCUnpWdtQcdVO51GVqz+9lhN4cc7EybLgKerOLppPqHtB
	 7L7yb4FXCVyYvG9T/R/Z2vdK43a1YTSAEI0Q3p9AjdpV2Xd+9bwC1NOG0IGXaCy9ie
	 SCAGlnrnafLgmoMZY/puCAyepOCYM9tFLczEjTIpxYRpYtdakkvNpa+y3OMxhNY+hn
	 ygp7+1t43SqhOVpjcKg4T0/CYtuExRxp2rZi75qha8yJEc71FzFY5wETYLChiJDAvg
	 1JuozZtJQ9tESsRBdJzJJus+0mNouICjTFaIdyOk5Zr5kk8ktJwP9q4KDA1wKhkU3N
	 edfAkyOeHbyLg==
Content-Type: multipart/mixed; boundary="===============1990946174717383891=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <3c1960998302f1ac50394163cf62ccf59ad088c0f586512a5d7771c95ec7e3f2@mail.kernel.org>
In-Reply-To: <20261030233355.1836749-5-ihor.solodrai@linux.dev>
References: <20261030233355.1836749-5-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 04/13] bpftool: Normalize legacy arena type tags before C dumps
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,qmo@kernel.org
Cc: bpf@vger.kernel.org,alan.maguire@oracle.com,cupertino.miranda@oracle.com,david.faust@oss.qualcomm.com,irogers@google.com,jose.marchesi@oracle.com,vineet.gupta@linux.dev,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 00:16:26 +0000 (UTC)

--===============1990946174717383891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Normalize legacy arena type tags before C dumps

TL;DR: The legacy arena tag fixup skips split BTF, so module C dumps on older
kernels may still print "address_space(1)" for vmlinux arena kfuncs and fail
to compile; commit message doesn't say so.

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c

[ ... ]

> @@ -1092,13 +1093,47 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
>  	return datums;
>  }
>  
> -static int dump_btf_c(const struct btf *btf,
> +/*
> + * Older kernel BTF encodes kflagged arena type tags as "address_space(1)",
> + * which btf_dump prints as is. Rewrite them to the complete specifier.
> + */
> +static int btf_c_fixup_legacy_arena_tags(struct btf *btf)
> +{
> +	__u32 i, cnt = btf__type_cnt(btf);
> +	int off;
> +
> +	if (btf__base_btf(btf) ||
> +	    btf__find_by_name_kind(btf, LEGACY_ARENA_TAG, BTF_KIND_TYPE_TAG) < 0)
> +		return 0;

Can this early return for split BTF leave module C dumps broken on older
kernels?

The commit message says only "Split BTF is dumped as is."  But dump_btf_c()
walks every type ID up to btf__type_cnt(btf), and for split BTF that count
is start_id + nr_types, so it covers the base (vmlinux) types as well:

    int cnt = btf__type_cnt(btf);
    ...
    for (i = 0; i < cnt; i++) {

dump_btf_kfuncs() scans the same range with "for (i = 1; i < cnt; i++)".
This differs from dump_btf_raw(), which starts at btf__type_cnt(base).

On an older kernel whose vmlinux BTF has kflagged "address_space(1)" tags,
these commands take the split path:

    bpftool btf dump file /sys/kernel/btf/<module> format c
    bpftool btf dump id <module btf id> format c

do_dump() auto-detects the sysfs prefix, loads base through
get_vmlinux_btf_from_sysfs() and calls btf__parse_split(files[0], base).
Multi-file merges through merge_btf_files() end up in the same place.

The fixup then returns 0, and the dump still prints the vmlinux arena kfuncs
(for example bpf_arena_alloc_pages) as "void address_space(1) *...", which
does not compile unless BPF_NO_KFUNC_PROTOTYPES is defined.  Before commit
0c5eab4faab1 ("libbpf: Dump kflagged BTF tags as is"), btf_dump wrapped
kflagged tags in __attribute__((...)), so the same module dump compiled.

No later commit up to 6ca27da0fce8 changes this:
btf_c_fixup_legacy_arena_tags() is the same there, and the selftests added in
15fdeb448400 ("selftests/bpf: Cover legacy arena type tags in bpftool C
dumps") only cover non-split BTF.

Should the commit message state that module C dumps on older kernels still
fail to compile, and explain why that case can't be handled?

Alternatively, could split dumps be handled too, for example by adding the
string to the split BTF and pointing the base tags' name_off at it
(btf_dump resolves names through d->btf, which is the split BTF), or by
emitting a compatibility definition in the dump preamble?

> +
> +	off = btf__add_str(btf, "__attribute__((address_space(1)))");
> +	if (off < 0) {
> +		p_err("failed to rewrite legacy arena type tags: %s", strerror(-off));
> +		return off;
> +	}
> +
> +	for (i = 1; i < cnt; i++) {
> +		struct btf_type *t = (struct btf_type *)btf__type_by_id(btf, i);
> +
> +		if (btf_is_type_tag(t) && btf_kflag(t) &&
> +		    !strcmp(btf__name_by_offset(btf, t->name_off), LEGACY_ARENA_TAG))
> +			t->name_off = off;
> +	}
> +
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41147288626
--===============1990946174717383891==--
