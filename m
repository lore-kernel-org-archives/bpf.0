Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F919388396
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203899; cv=none; b=ul7jfo/64M67OaxeOP+VcerBNpLX3PQcv2nIEhCDvLXli3XXQHAhxp7fn7fe7a4yRBUNLAwZ1hW8bQgfs63AIRwe5CXt9HkgtfcVjZ4OYorsnGD3sloDu2K8hwFrq2nEJcq5k25JrkCiRhHFNza+BX2qqr98/tVx2E4uOU3j1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203899; c=relaxed/simple;
	bh=a7RV4Rf7buAxYjMHe84G7MUlU192qKdA/FEnYHcVIAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qc9ZG0KTGtC+LOVR422DWyNqYVpaclV3xFgT/hscsurw5gWIZTXRNxwbZUvX7bzWBGfr4o9qC62RXa7Lkds6a45t+Mpl4Qdt1BOY9EwLxWfDO5juyGXtVnoBWk8F8CASyvNw+Bjf6mX4ItOFMwy/3FvtilpqvkXZ4xyR3rKFPEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkPW6/cR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkPW6/cR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5DEC19425;
	Tue, 14 Apr 2026 21:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776203898;
	bh=a7RV4Rf7buAxYjMHe84G7MUlU192qKdA/FEnYHcVIAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lkPW6/cRJ6nZ0lX7qQE//n7SRAVou8Y+iz2ODgfwreh4gn5sH0vl06LdIrlwbVdLr
	 +YLxOdIoTWEaXa6B1z6U98P4t4fao2EEvc5/5uB+z8S69ZsVhBQGEmtmlQQ+vRS01e
	 VC1dGIiV76ihE+ctb6dEcNGjpc89IIU+AVtyRjo/JhwTzHT9Bm0tZvCkj+2rMhuvuA
	 yLdpESj1im+EIv2WJvEKsoe4k/JLb7Fe51avsOtwWU0HWUXJ40PFq4YQfngyDOmfX9
	 mcM/3waYmOoXvYSmKOgYWrD8ncWt0FlMYXRoMejJ1CDbzoAHghAnJ47DgFAzdxIktv
	 44SpvkZ7hZPWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/6] libbpf: Add feature for kernel extended
 vlen/kind support
Reply-To: sashiko@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260414195019.684531-4-alan.maguire@oracle.com>
References: <20260414195019.684531-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 21:58:18 +0000
Message-Id: <20260414215818.AE5DEC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The feature probe incorrectly relies on finding an unused enum (`b=
tf_max`) in the `vmlinux` BTF, guaranteeing it will permanently fail and fa=
lsely reject valid BPF objects.
- [High] The feature probe violates libbpf's probe architecture by reading =
the multi-megabyte `vmlinux` BTF instead of using lightweight `bpf()` sysca=
lls, breaking containers and unprivileged token delegation.
- [Medium] The feature probe propagates negative errors when `vmlinux` BTF =
is absent, unconditionally spamming application logs with multiple warnings.
--

commit 3e8277b7bc260bfb527a032e5667d3e2d753d156
Author: Alan Maguire <alan.maguire@oracle.com>

libbpf: Add feature for kernel extended vlen/kind support
   =20
This commit adds a new feature probe to detect whether the kernel supports
extended BTF vlen and kind. It does this by loading the vmlinux BTF and
searching for an enum named btf_max with a BTF_MAX_VLEN member greater
than 0xffff.

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 4f19a0d79b0cf..4a75d6717bbbd 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c

[ ... ]

> @@ -615,6 +615,42 @@ static int probe_kern_btf_layout(int token_fd)
>  						 (char *)layout, token_fd));
>  }
> =20
> +static int probe_kern_btf_vlen_kind_extended(int token_fd)
> +{
> +	struct btf *btf;
> +	int ret =3D 0;
> +	__s32 id;
> +	int err;
> +
> +	btf =3D btf__load_vmlinux_btf();
> +	err =3D libbpf_get_error(btf);
> +	if (err)
> +		return err;

If /sys/kernel/btf/vmlinux does not exist, btf__load_vmlinux_btf() returns
a negative error code. By returning this error directly, won't the
feat_supported() cache layer log a warning message? This seems like it will
spam logs on systems without vmlinux BTF.

Also, since this probe ignores token_fd, does it break BPF token delegation
for unprivileged environments? This approach introduces a dependency on
vmlinux BTF and adds parsing latency, compared to a lightweight bpf() sysca=
ll
probe.

> +	id =3D btf__find_by_name_kind(btf, "btf_max", BTF_KIND_ENUM);
> +	if (id > 0) {
> +		const struct btf_type *t;
> +		const struct btf_enum *e;
> +		const char *name;
> +		__u32 i, vlen;
> +
> +		t =3D btf__type_by_id(btf, id);
> +		if (t) {
> +			vlen =3D btf_vlen(t);
> +
> +			for (i =3D 0, e =3D btf_enum(t); i < vlen; i++, e++) {
> +				name =3D btf__name_by_offset(btf, e->name_off);
> +				if (!name || strcmp(name, "BTF_MAX_VLEN") !=3D 0)
> +					continue;
> +				if (e->val > 0xffff)
> +					ret =3D 1;
> +			}
> +		}
> +	}
> +	btf__free(btf);
> +
> +	return ret;
> +}

Is enum btf_max actually instantiated in kernel C code?

If it is only used as a header construct, won't it be absent from the DWARF
debug info and the vmlinux BTF? If so, this probe would always fail to find
it, causing libbpf to unconditionally reject extended vlen/kind BTFs even on
capable kernels.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414195019.6845=
31-1-alan.maguire@oracle.com?part=3D3
