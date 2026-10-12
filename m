Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E244A4983;
	Mon, 12 Oct 2026 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823008; cv=none; b=DDw40zbsmALrxA/yeHS6H6IpGVMXyf8M70M2unF3lTzpEBSa72LPFIJq0OxTzHNZN0Udur04SuTSG6/wlwkQqH3AvYmUAZ7zdL5zp5VzIxOUlDvmRxpW3pK9yzzvZ5udakdgW4L66qHBLIJzzLSdE8PomfDjN/5ynfHCEMjqpZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823008; c=relaxed/simple;
	bh=lS65VTYOy71Tt0C/gecqcnSLKjaDdjm5KAh124Itp1U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=a5DSK0QosXzMD4Y1ZmpI9UxcwWGWwagwrMe8S7+xvUfvW9XRF12OnEXG+ODrnRg2Aq+xgoM18Dg8mV3GjtRK+ROW6Lju7ZXXSSA18b/9kOl+xvgCDN0HzDg6xD24Vb54LmqqbgN8YEXXdZ77bJQbJg4zmXSJi0QG/jDrONWaqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCJa24Ij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCJa24Ij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6971F1F0089B;
	Mon, 12 Oct 2026 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791823006;
	bh=rs9xq6F89m82dVlmpRzPL7OWq5H23Mx4nxInBIHtSbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PCJa24Ij2crw6NrWb5Dk6TeKhX40tgkOjuQoC5zbMe0GDEnwXTcuw18qfGFYiU+K7
	 75px+iFe7ryMM2meOjuzCP4CBodEmiN/8JKdu006TU106tyMXtw2j/WONSzfk9ikr9
	 oZZ5mG+8d44vZYpPtqr5uWhJF2melbXloS76ZH86IyT5vsnB7of6YXnBinV4FiHvih
	 PIps6Eil4yzOe8SW+UlmelMeFJ0K6haUW4ocj7Gdn6KC5u4CgFPCNzzgMbVlwpu5Tu
	 W6rZboQRklqMyRzVY+qX+FRCgp1E++7K0wXJfsOiE/bl/wH9RNdGpfCOqPECkjDCN6
	 Q1p0eKijzDBDA==
Message-ID: <sashiko-outbox-168400@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 14/21] bpf: Add tracing_multi link info
 support for bpf progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261012154024.29423-15-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <20261012154024.29423-15-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 16:36:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpftool: buffer over-read of uninitialized heap memory in sym_na=
me_trim_prefix()
- [Medium] bpf: strict fids check in bpf_tracing_multi_link_fill_link_info(=
) breaks UAPI
--

commit 69edd76aa1ef54260b1403707834fa758ec91952
Author: Leon Hwang <leon.hwang@linux.dev>
bpf: Add tracing_multi link info support for bpf progs

This commit adds support for showing BPF program information in tracing_mul=
ti=20
links via bpftool.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 8b1a52350cfda..39c911917ae24 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
[ ... ]
> @@ -3725,9 +3726,13 @@ static int bpf_tracing_multi_link_fill_link_info(c=
onst struct bpf_link *link,
>  	info->tracing_multi.attach_type =3D tr_link->link.attach_type;
>  	info->tracing_multi.count =3D tr_link->nodes_cnt;
>  	info->tracing_multi.btf_obj_id =3D btf_obj_id(tr_link->link.prog->aux->=
attach_btf);
> +	has_progs =3D !!tr_link->tgt_progs;
> +	info->tracing_multi.flags =3D has_progs ? BPF_F_TRACING_MULTI_TGT_PROGS=
 : 0;
> =20
> -	if (!uids && !ucookies && !uaddrs)
> +	if (!uids && !ucookies && !uaddrs && !fids)
>  		return 0;
> +	if (has_progs !=3D !!fids)
> +		return -EINVAL;

[Severity: Medium]
Does this strict equality check break forward compatibility for generic=20
userspace tools?

If a tool unconditionally pre-allocates and provides a func_btf_ids array=20
while querying an older, non-BPF-targeted tracing_multi link (where has_pro=
gs=20
is false), bpf_obj_get_info_by_fd() will fail with -EINVAL.

Would it be safer to gracefully ignore or zero-fill the fids buffer if the=
=20
target does not have programs, rather than rejecting the query entirely?

> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 5cffa2d283b47..da7e430b14c8a 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
[ ... ]
> @@ -422,12 +422,31 @@ show_uprobe_multi_json(struct bpf_link_info *info, =
json_writer_t *wtr)
>  	jsonw_end_array(json_wtr);
>  }
> =20
> +#define BPF_PROG_PREFIX		"bpf_prog_"
> +#define BPF_PROG_PREFIX_LEN	(sizeof(BPF_PROG_PREFIX) - 1)
> +
> +static const char *
> +sym_name_trim_prefix(struct kernel_sym *sym, bool is_prog)
> +{
> +	int prefix_len;
> +
> +	if (!is_prog)
> +		return sym->name;
> +
> +	/* Ref kernel/bpf/core.c::bpf_prog_ksym_set_name() */
> +	prefix_len  =3D BPF_PROG_PREFIX_LEN;
> +	prefix_len +=3D BPF_TAG_SIZE * 2;
> +	if (sym->name[prefix_len] !=3D '\0')

[Severity: Medium]
Can this result in an out-of-bounds read if the kernel symbol name is short=
er=20
than the prefix length?

In bpftool, sym->name is allocated using libbpf_reallocarray() and populate=
d=20
via sscanf(), which null-terminates the string but leaves the remainder of=
=20
the buffer uninitialized.

If a target address resolves to a short kernel symbol (for example, due to =
a=20
TOCTOU race where a BPF program is unloaded and its vmalloc address is=20
reused), sym->name[prefix_len] evaluates uninitialized heap memory. If that=
=20
byte happens to be non-zero, it skips it and returns a pointer into the=20
uninitialized region, potentially corrupting CLI or JSON output.

Should we verify that strlen(sym->name) is sufficiently large before checki=
ng=20
the character at prefix_len?

> +		prefix_len +=3D 1;		/* skip the '_' */
> +	return sym->name + prefix_len;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012154024.2942=
3-1-leon.hwang@linux.dev?part=3D14
