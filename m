Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04A257844
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786288647; cv=none; b=aOMwQ9ptp448io1spxMblUaKrm6S4qiBN2PN00Nm7op1jQWPxX8jOqDd9Lnnb/8lw/C4ocdFNOCdIPkx3XGcmbyGMiq9kpfZt0TRSmZTyq9l+u191BAkBuKpG8xLe4edxfzhRt1ZAq6tV8151sc4qXF1YnckbSxIBkSe1oGVUS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786288647; c=relaxed/simple;
	bh=6PLDfcgXfDhz6Z4ngCUxII4K0g6uvzvje4A36c3iXi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qsKiyv6EOzK/19X5VkdyvQK8lup0+D9aX1WAmub89ZySlMKXQNUxbN2C59Z3IiCpplcfej92f+GEylGJj9yCcOuOKYxScGdF5pKwL+qVaxPe1zqloVgjF1mYtEDrWdQB/t0MbRtr3SUqlXUMb5BqCQmbHo/sOBddblv8JccBicg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUMw0Iyn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUMw0Iyn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269221F000E9;
	Sun,  9 Aug 2026 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786288646;
	bh=KKwgkDkGhvNEgVvu0hNpIP8/7H/ZS+eSTaISTOthPLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QUMw0Iyn3pDdnWiveiq/vh2uNTaz+CxLu021If0jhz/9BaHA5qbFCgwNxFELnbaf2
	 9BGakRPZRMrJztUxzW7lPJ+jYrKWkj9YgRa89GlXyo4I04Xa83K7wvLZS96Aa35euo
	 4V7Wd55J650pxoO1TZ4V9p0PaFq5sHASYpXgwKJxppCyEatT9UfGRKV21Umfdy8nHr
	 /D3iiJME5twRrcCtq36LYPtbbPh2xoNa+Zb+4E5pZwdVVxvp6GW6nluGU1nDOREb8J
	 nFwpVZPyBtFIcwnkT+BraowPyyfGusq3b6ZysMSBimx6Ly9PS0verlrEr9DsoYvryy
	 EMjoXODcKcP/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 07/13] bpf: Add tracing_multi link info support
 for bpf progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260809150111.45000-8-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <20260809150111.45000-8-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 15:17:25 +0000
Message-Id: <20260809151726.269221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Out-of-bounds Read / Uninitialized Memory Leak in sym_name_trim_=
prefix()
- [Medium] UAPI Anti-Pattern: Usage of C bitfields in UAPI headers
--

--- Patch [7]: [PATCH bpf-next 07/13] bpf: Add tracing_multi link info supp=
ort for bpf progs ---
commit 65386c192a0d673092c95f3f31578ae7c4d19498
Author: Leon Hwang <leon.hwang@linux.dev>
Subject: bpf: Add tracing_multi link info support for bpf progs

This commit adds tracing_multi link info support for BPF programs. It
updates the bpf_link_info structure and extends bpftool to show function
BTF IDs and program IDs.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6fa93a6ff54f2..e0c8ea5ed2c8f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6890,10 +6890,12 @@ struct bpf_link_info {
>  			__u32 attach_type;
>  			__u32 count; /* in/out: tracing_multi target count */
>  			__u32 btf_obj_id;
> -			__u32 :32;
> +			__u32 tgt_progs:1;
> +			__u32 :31;

[Severity: Medium]
Could this cause endianness issues since C bitfield layout is
implementation-defined?

The established Linux UAPI standard is to use a __u32 flags field with
bitmask macros instead of C bitfields to ensure portability across
architectures and cross-platform tools. (This also applies to the mirrored
header in tools/include/uapi/linux/bpf.h).

[ ... ]

> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 088d1d206065f..d5c5ec433350b 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
[ ... ]
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
> +	prefix_len +=3D 1;			/* skip the '_' */
> +	return sym->name + prefix_len;

[Severity: Medium]
Does this code read past the null terminator for unnamed BPF programs?

When processing an unnamed BPF program (e.g., exported in kallsyms as
bpf_prog_9a7f9e3ab6f138ab), the sym->name buffer contains exactly 25
characters. Here, prefix_len is calculated as 26 (9 + 16 + 1).

This offset advances the pointer past the null terminator into
uninitialized heap memory, which is then passed to the JSON string writer
when calling jsonw_string_field() later in show_tracing_multi_json().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809150111.4500=
0-1-leon.hwang@linux.dev?part=3D7
