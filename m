Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD91F3D56
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101928; cv=none; b=i8ef4yqaesjhfC7p2++cC0osjrXP1qs19dCryVpy0If8fvGIB9dibllyjP73Njl7xwOlqx/70/HIt/wMYBbV5Zatf8i/qEp+bLfB0cbJ6S8UE6dSZLIbZtYqjw0jr5PpjRQnFLONARAQhR5XEf2xW6eIyimSeqZom7aVBiL9Z2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101928; c=relaxed/simple;
	bh=ug/KDapPo6mc6xH7wK278E9ChkGQuPCqAXYgN5ZnOy8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R9eNIbO2MvlxBhu6Ww3sfue51kOWCIHNAWn7D39r7PQmGMKUz0rXLFZIuv8kxuPjh0ybOh9sn99mtRTs6MXDSWIAhs7L9nkUoTfvjrQC6FyFxQQok/57FOToR2K7PkzfOTgJa2iyGoAh5dprO7d/TcxjGLoMx1j/DTvW8Xsxlx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfNCA4wE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfNCA4wE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4FC1F00893;
	Sat, 30 May 2026 00:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101926;
	bh=8gR2R8v/2iCbPgGfn4cX3n4A7FjJA8m1DC/Irn/sipY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AfNCA4wE2H52EI+pKJM5y758/LuYpuv3Gl2hbR+bYHU2n/FlzVAPg3uHHBU2FUVFI
	 XMYsQhQdPNYfOrBt7kiVt4ov80QLZ/P7T4BQcQV+Lx0QtXwqTn/c0bdZBJfLlPd8sM
	 h+Yw80ua3ui0NL3Pfe1VB2zTx9ppTl54pt5yTwlP1wxPgMDSwxHJXThVbJgNPsr+HG
	 D2c7cEUnmck5IvACViyTu4wBP9oYunTuOSfmFKoZmB1hkRab/0n6kAQMhodRfkd33b
	 s0HzCXHcz6rEe4ty2CxMqoUjtER3jHdFGyz7XrnOMbu8Xdg38I92AV2kEIzd271Na2
	 3DM8k7HoNC+wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] selftests: net: add kTLS async split record
 regression
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christopher Lusk" <clusk@northecho.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521025840.976378-3-clusk@northecho.dev>
References: <20260521025840.976378-3-clusk@northecho.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:45:26 +0000
Message-Id: <20260530004526.6E4FC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Memory and file descriptor leak of `struct bpf_object` on error =
paths inside `attach_bpf()`.
- [Low] Including libbpf source headers directly instead of installed/expor=
ted headers in Makefile.
--

commit 4256015d1c1b459bffc8e935d002cdb7f0465799
Author: Christopher Lusk <clusk@northecho.dev>

selftests: net: add kTLS async split record regression

Add a kTLS TX regression test for the BPF sk_msg apply_bytes split-record
path. The test sends four 4096-byte writes through a sockmap verdict program
that applies 512-byte verdict windows, then verifies that the peer receives
the full TLS-protected stream.

> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index f3da38c54d276..0435327e93a72 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
[ ... ]
> @@ -236,3 +237,7 @@ $(OUTPUT)/bind_bhash: LDLIBS +=3D -lpthread
>  $(OUTPUT)/io_uring_zerocopy_tx: CFLAGS +=3D -I../../../include/
> =20
>  include bpf.mk
> +
> +$(OUTPUT)/ktls_async_split: CFLAGS +=3D -I../../../lib

[Severity: Low]
Is this include path correct? By pointing directly to lib instead of the
exported headers like ../../../include/, could we bypass the proper libbpf
build and export step and rely on raw source headers instead?

> diff --git a/tools/testing/selftests/net/ktls_async_split.c b/tools/testi=
ng/selftests/net/ktls_async_split.c
> new file mode 100644
> index 0000000000000..5601ce4b5f688
> --- /dev/null
> +++ b/tools/testing/selftests/net/ktls_async_split.c
[ ... ]
> +static int attach_bpf(const char *obj_path, int sock_fd, struct bpf_obje=
ct **obj_out)
> +{
> +	struct bpf_object *obj;
> +	struct bpf_program *prog;
> +	int map_fd, prog_fd;
> +	__u32 key =3D 0;
> +
> +	obj =3D bpf_object__open_file(obj_path, NULL);
> +	if (libbpf_get_error(obj))
> +		return -EINVAL;
> +	if (bpf_object__load(obj))
> +		return -EINVAL;

[Severity: Medium]
Does this leak the bpf_object structure and associated resources on error
paths?

Since *obj_out is only assigned at the end of the function upon success, if
bpf_object__load() or any subsequent operations fail, the caller receives a
NULL pointer and cannot clean up the leaked object via bpf_object__close().

> +
> +	prog =3D bpf_object__find_program_by_name(obj, "apply_bytes_verdict");
> +	if (!prog)
> +		return -ENOENT;
> +	prog_fd =3D bpf_program__fd(prog);
> +	if (prog_fd < 0)
> +		return prog_fd;
> +
> +	map_fd =3D bpf_object__find_map_fd_by_name(obj, "sock_map");
> +	if (map_fd < 0)
> +		return -ENOENT;
> +
> +	if (bpf_prog_attach(prog_fd, map_fd, BPF_SK_MSG_VERDICT, 0))
> +		return -errno;
> +	if (bpf_map_update_elem(map_fd, &key, &sock_fd, BPF_ANY))
> +		return -errno;
> +
> +	*obj_out =3D obj;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521025840.9763=
78-1-clusk@northecho.dev?part=3D2
