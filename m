Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57829898B
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778944589; cv=none; b=f8OoTuztNllfIf185PXfy9Lh7U4zbB9SOg6B1fZ9xnDC/8evT6MKa+BqnIxISBkfoKM03frnFIisT1FbdBYeBSyZMHJ1qF8jnOaI5ZV2Zlo5NuKjOiicTB7z37d5sZnl4Kl07JPzSc5Gt5i33JWS1oawUDY95mUI1A67LnRaH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778944589; c=relaxed/simple;
	bh=NGnFDaM7W0T+/Ro1p0fok6JfFZUE30dWrs6DI0gEnGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V85rKVdVEMPX5yDIAy1K4pOAqu9BZzNd1ZV0riFq7HHNfr8d7A0wAV1JH4nJzLryPNvSHVLH0fRlY72yQUr2OxQPGfW7KoFGY2UqXg13vKChtlwTMy9muEL4MwyixlpBdQJK17k0suXb3icQmIvUjMBwLNC298wj22jIGy4JbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1jKf0P0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1jKf0P0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988D7C19425;
	Sat, 16 May 2026 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778944589;
	bh=NGnFDaM7W0T+/Ro1p0fok6JfFZUE30dWrs6DI0gEnGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=h1jKf0P0C/CrH7KWfq3PQI7LsdwnrgMD7VP3Po2vmKfyjDa4UFfZbcVHyVZ+YkBqa
	 R3J2C0LAKCMGTQftNeD29C4GCkoLHgdP8oWxGto8naPBEzpU3RjGU7LiADty7OP1lp
	 SVaRqTRI6pdfXrqnc6RrSWgX9N+ZpxH4B3U1drOdTPnnNgAaTwnmOmMsbDDKt1X7dA
	 d+40QbKtJ8e2PzTc1qqDIZUby0PwbR24tmFrfAovOu51X1z3TKDKvb+r2Qw3u+nFL4
	 Db2tUkuZ3fLjAkUhdpi9IkWTsenALfV1uQCyo28JZM2RfGbAOoWPHHnfEuEdbc/egA
	 aAP2mKyXgqSyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] selftests: net: add kTLS async split record
 regression
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christopher Lusk" <clusk@northecho.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515151556.189841-3-clusk@northecho.dev>
References: <20260515151556.189841-3-clusk@northecho.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 15:16:29 +0000
Message-Id: <20260516151629.988D7C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The file descriptor returned by bpf_program__fd() is not validat=
ed before use.
--

commit d9776d4dbb9fe9a4990835389a529751f93e64af
Author: Christopher Lusk <clusk@northecho.dev>

selftests: net: add kTLS async split record regression

This commit adds a kTLS TX regression test for the BPF sk_msg apply_bytes
split-record path. It verifies that a stream with 512-byte verdict windows
is received correctly, testing both synchronous and async pcrypt providers.

> diff --git a/tools/testing/selftests/net/ktls_async_split.c b/tools/testi=
ng/selftests/net/ktls_async_split.c
> new file mode 100644
> index 0000000000000..a9a84e0f5f87b
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
> +
> +	prog =3D bpf_object__find_program_by_name(obj, "apply_bytes_verdict");
> +	if (!prog)
> +		return -ENOENT;
> +	prog_fd =3D bpf_program__fd(prog);

Should prog_fd be checked for negative values here?

When using manual lookup APIs, bpf_program__fd() can return a negative error
code if the program is invalid. Does it make sense to validate prog_fd befo=
re
passing it to bpf_prog_attach(), similar to the map_fd check right below?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515151556.1898=
41-1-clusk@northecho.dev?part=3D2
