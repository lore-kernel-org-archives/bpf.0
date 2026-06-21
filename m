Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE92E54AA
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782075389; cv=none; b=JK0/qBij0ng6wboQMvbtj3ggdqF7Z6kE/pjA91bDF/bIY2r/jQ7/Ow0FSj7qM8SCc9kfXYqgfZyCTMNWI+/Nf0tt9Z+fYgo5i66mkwLMW6Y4kl5Pe1r4tapEpxVnrY1z4HaT47ZyGLUVCMV9qaxlK6wTkZ0FmsS0Eq/EMbOnyWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782075389; c=relaxed/simple;
	bh=cMOaF3j8DRdH1LrjTuzaLClMhitLSKOS5l7zJ/gUFTY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FmtbXWKlyxpCQS7+9TrnFkBEgsmvroMZeTj0JH/BN7n4MlVp7FINm1qgP6ZVrobnqVgq+ErulNFQJmDP9j7EBhK7JpGbghHz4x501t/1FEEazUuJyWsJE/dAF83AojWj8M/w7qNjwap81XgbwA60AYyGcSU7NndZof1SRWiI9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/UHN2r9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/UHN2r9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2920D1F000E9;
	Sun, 21 Jun 2026 20:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782075388;
	bh=jwORh5kt6jHqHUnKNjpI/WNRuQKhdIgjKV+4dAR3TOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q/UHN2r9fHh01Qln0HdfQA6dBTbRt8KMdR2VIfOWRrCc7E5yf+frRx/g5Mmhk+7Cu
	 EjE4s94lMfDPlzCvpDvR71fXvcHmsMG2gullLLvJK7+f6eyF6YP0IvWQIQI18eRE0e
	 jYLxcIgeDg4SS2JxXVzg04jJzG56Q3uAhWrV9mxb81oYJpHrJIRuWNFVLm29uHNGp9
	 s0QPZD2h7HNfxqnTK25ILWQP0RuFgq3ywZQERpdH4ioyI02+0OewO9onELOPLH18H3
	 vDcVkOAidT1Ayy+E1eqvC+cLT9R5k5qBRtLz+5a7qBCMnzRqVyhoPwpKs6vgc9p1Be
	 f/tVf6DNIdPqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/3] bpftool: Add tracing_multi link info
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260621204524.61067-4-jolsa@kernel.org>
References: <20260621204524.61067-1-jolsa@kernel.org>
 <20260621204524.61067-4-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 20:56:27 +0000
Message-Id: <20260621205628.2920D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Repeated parsing of `/proc/kallsyms` in an O(N) loop when symbol=
 loading fails.
--

commit 0f11f8e705a95b6aa483a05374ffb9b22bcb78c0
Author: Jiri Olsa <jolsa@kernel.org>

bpftool: Add tracing_multi link info output

This commit adds bpftool support to show tracing_multi link details for both
plain and JSON outputs.

> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index bdcd717b0348f..58dadee984a07 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -377,6 +377,31 @@ static __u64 *u64_to_arr(__u64 val)
>  	return (__u64 *) u64_to_ptr(val);
>  }
> =20
> +static __u32 *u64_to_u32_arr(__u64 val)
> +{
> +	return (__u32 *)u64_to_ptr(val);
> +}
> +
> +static struct kernel_sym *find_kernel_sym_by_addr(__u64 addr, bool is_ib=
t_enabled)
> +{
> +	struct kernel_sym *sym;
> +
> +	if (!addr)
> +		return NULL;
> +
> +	/* Load it once for all. */
> +	if (!dd.sym_count)
> +		kernel_syms_load(&dd);
> +	if (!dd.sym_count)
> +		return NULL;
> +
> +	sym =3D kernel_syms_search(&dd, addr);
> +	if (!sym && is_ibt_enabled && addr >=3D 4)
> +		sym =3D kernel_syms_search(&dd, addr - 4);
> +
> +	return sym;
> +}

[ ... ]

> @@ -403,6 +428,43 @@ show_uprobe_multi_json(struct bpf_link_info *info, j=
son_writer_t *wtr)
>  	jsonw_end_array(json_wtr);
>  }
> =20
> +static void
> +show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> +{
> +	bool is_ibt_enabled =3D is_x86_ibt_enabled();
> +	__u32 i;
> +
> +	show_link_attach_type_json(info->tracing_multi.attach_type, wtr);
> +	jsonw_uint_field(wtr, "func_cnt", info->tracing_multi.count);
> +	jsonw_uint_field(wtr, "obj_id", info->tracing_multi.obj_id);
> +	jsonw_name(wtr, "funcs");
> +
> +	jsonw_start_array(wtr);
> +
> +	for (i =3D 0; i < info->tracing_multi.count; i++) {
> +		__u64 addr =3D u64_to_arr(info->tracing_multi.addrs)[i];
> +		struct kernel_sym *sym;
> +
> +		sym =3D find_kernel_sym_by_addr(addr, is_ibt_enabled);

[Severity: Medium]
If kernel_syms_load() fails (for example, due to kernel.kptr_restrict or
a lack of read permissions for /proc/kallsyms), dd.sym_count remains 0.

Since find_kernel_sym_by_addr() checks !dd.sym_count to decide whether to l=
oad
symbols, won't this cause /proc/kallsyms to be repeatedly opened and parsed=
 on
every iteration of this loop if the initial load fails?

This loop occurs here in show_tracing_multi_json() as well as in
show_tracing_multi_plain(). For tracing_multi links with potentially thousa=
nds
of targets, could this result in a significant performance hang for bpftool?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621204524.6106=
7-1-jolsa@kernel.org?part=3D3
