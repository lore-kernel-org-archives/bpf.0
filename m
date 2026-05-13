Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034F3815F5
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712504; cv=none; b=ZKlIrz4QDwh78C2epeD/yDqeQLERIe9uuG1gDWHo3R3/FIg1KkDfpBJ6+9UAgVetHTiAEPWsOzMxSdKG3kV0K4PGViqp8iY8vPvx8ONJv08Fec7l8unyGAaL14ds+OdUnGEjDgJU6Yi5EGkfBCQg1/qmXOxWCW1tg95TAN6285s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712504; c=relaxed/simple;
	bh=0TklWVHUfhbp8wiHIG2JftV7AJJ/W0jqsunHktG5nV0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KsZH6Kr3Df2+aoD/MKYB3Aem6saB5fkL12VVf338M9RKizLuoguM5yx11I51pU5l0ULz7kWu9Www0Y9Qs3HW+Y8gwleOOiSmZB5P8SqakFhFQIIhXyXQLgPQ+v99/qtlvTyRP5wbLp9jzRAi5K2LRBJfKPfWcaDmLaYnoVH8bLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk/sNdHS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk/sNdHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6494FC19425;
	Wed, 13 May 2026 22:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778712503;
	bh=0TklWVHUfhbp8wiHIG2JftV7AJJ/W0jqsunHktG5nV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Jk/sNdHS3aW4YFCqAIR5cmFq5up7+L0FNp8KlvsP041XAxyXzUzqmgqwTKYXnj4MH
	 Q0wNywMB9h1Ar/AII9P4Z/UCRe6yh6A83xus/I+Bzrf2ZYTD4zcICQXYWURHSg8S1P
	 slPQToc9z6Zy5eIJLViSfaszq+z3u0cgEH/AzIMjTkwbtY/BSfaR9UDOWdxb25wgqr
	 o+EJ3Dfd2+Sw9nLAs6PnOruAi2lfT+szuMoIUaMYnduk/TdAb6npugbSX6aOYDXiKf
	 0ihgyHne38rBHzQ8V0VAkPT9r92Uxk0DxVSQfwoLYYf++rAH+rErCMIrrnQig/bTIQ
	 xb1PNhr8DPr9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v14 1/8] bpf: Extend BPF syscall with common
 attributes support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260512153157.28382-2-leon.hwang@linux.dev>
References: <20260512153157.28382-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 22:48:22 +0000
Message-Id: <20260513224823.6494FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Implicit compiler padding in UAPI `struct bpf_common_attr` comprom=
ises backward compatibility.
- [High] `BPF_COMMON_ATTRS` flag is silently accepted and ignored for unsup=
ported BPF commands, breaking UAPI feature probing.
--

commit 8985d7da06248bc1e83a6cb46060187b0440e549
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Extend BPF syscall with common attributes support

This commit adds generic BPF syscall support for passing common attributes
like log_buf, log_size, log_level, and log_true_size. It introduces a new
UAPI struct bpf_common_attr and a BPF_COMMON_ATTRS command flag bit to
indicate when these attributes are provided.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h

[ ... ]

> @@ -1500,6 +1501,13 @@ struct bpf_stack_build_id {
>  	};
>  };
> =20
> +struct bpf_common_attr {
> +	__aligned_u64 log_buf;
> +	__u32 log_size;
> +	__u32 log_level;
> +	__u32 log_true_size;
> +};

Does this UAPI structure contain implicit trailing padding? With one
__aligned_u64 (8 bytes) and three __u32 fields (12 bytes), there are 20
bytes of data. Because of the 8-byte alignment, the compiler will pad the
structure to 24 bytes.

If a future kernel extension adds a new 4-byte field, older userspace progr=
ams
allocating this structure on the stack might inadvertently pass uninitializ=
ed
stack garbage into the new field, permanently breaking backward compatibili=
ty.

Should this include an explicit __u32 pad; field, and should the kernel
explicitly validate that attr_common.pad =3D=3D 0?

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -6226,6 +6228,20 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t ua=
ttr, unsigned int size)
>  	if (copy_from_bpfptr(&attr, uattr, size) !=3D 0)
>  		return -EFAULT;
> =20
> +	memset(&attr_common, 0, sizeof(attr_common));
> +	if (cmd & BPF_COMMON_ATTRS) {
> +		err =3D bpf_check_uarg_tail_zero(uattr_common, sizeof(attr_common), si=
ze_common);
> +		if (err)
> +			return err;
> +
> +		cmd &=3D ~BPF_COMMON_ATTRS;

By unconditionally stripping BPF_COMMON_ATTRS from the command here, won't =
any
BPF command (such as BPF_MAP_FREEZE) successfully accept the flag but silen=
tly
ignore the provided common attributes?

This might prevent userspace from correctly probing whether the running ker=
nel
actually supports common attributes for a given command.

Should __sys_bpf() enforce a whitelist of supported commands before strippi=
ng
the flag, or explicitly reject the flag for commands that do not support it?

> +		size_common =3D min_t(u32, size_common, sizeof(attr_common));
> +		if (copy_from_bpfptr(&attr_common, uattr_common, size_common) !=3D 0)
> +			return -EFAULT;
> +	} else {
> +		size_common =3D 0;
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512153157.2838=
2-1-leon.hwang@linux.dev?part=3D1
