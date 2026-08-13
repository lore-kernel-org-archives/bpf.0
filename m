Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD033936D
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660512; cv=none; b=PuzoBLKLghlv1EpvoAS/oB1eG4jCwVKV7siUmLmoR8LAiMuGbbHlx+9rBbArTVt8D8cIVztrb+2iBy8jZZMt5XNddEouURtguua8HifDhbP7TR7rOvfUrGLn/X/Owtk2PNfQaBgXvWGaHkaKcbUBlyGPmtMP+MF1qD/8uXZr+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660512; c=relaxed/simple;
	bh=relX+gdahBLny3oG8go28FRDqD/9bCmsgRagjQj+2Ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a5tEqFGSYjAcf6Rishjkl0An0rkv37hwxuTn9+PGoGwztnSMgEAtzFmRx6dok6sr8tA/pQneZP7SzxQI8cUjzQGZTqoCxGqEcUow7tfYtnHggO2lUgwUjxibIj5VZVgBeUMSSqtVBxE0oDRPzz/qjmbeiHB3Wr0smNKjBXVf4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVsrzc9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVsrzc9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7EE1F000E9;
	Thu, 13 Aug 2026 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786660510;
	bh=nnm6wUkadtfHAauyrNExtKStT70aqHxWnrtGiP2U5lU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DVsrzc9TsuWtKxS1EHhquzfnlmyUDMzTJwF/Lvtv3dgaaFppJpXvrw51q7fqyue9K
	 nmVK4ZT0m7Qua2p9gS0zndC+AW3vBOFWia9ZoVus0yYRwraKdIogKEAmKUrmmKD8VX
	 uSGLIS5b6c6UClQvNGF3hHgyQ4beaFDeirunCSsqUbgfv6YNmOeGBlOBKyzi/zYqve
	 fKvvHWyN/1WStu/ru8cEEmb0cpsVdPur2xfcTMl7k2n/+fUyC+qT9ITNrsvQa17FTR
	 1pqEPUQg1sLZbriSPNCp7F94gABKg7W7rPNoZ8jpIqz2yPhjIBNRdfitkbktzjaP7g
	 OcaJtzHnpsh5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 bpf-next 8/9] selftests/bpf: Test kind
 encoding/decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260324174450.1570809-9-alan.maguire@oracle.com>
References: <20260324174450.1570809-9-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:35:10 +0000
Message-Id: <20260813223510.7E7EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The BTF object `btf` is leaked on early error paths.
--

--- Patch [8]: [PATCH v15 bpf-next 8/9] selftests/bpf: Test kind encoding/d=
ecoding ---
commit 2e5fe50dd1168fa6e0f69edd9f780d42539e7151
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Test kind encoding/decoding

This commit adds tests to verify that btf__new_empty_opts() correctly adds
layouts for all supported kinds. It also ensures that parsing of a BTF
containing unrecognized kinds can still succeed.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_kind.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_kind.c
> new file mode 100644
> index 0000000000000..64ceac1d999e6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
> @@ -0,0 +1,226 @@
[ ... ]
> +static void test_btf_kind_encoding(void)
> +{
> +	LIBBPF_OPTS(btf_new_opts, opts);
> +	const struct btf_header *hdr;
> +	const void *raw_btf;
> +	struct btf *btf;
> +	__u32 raw_size;
> +
> +	opts.add_layout =3D true;
> +	btf =3D btf__new_empty_opts(&opts);
> +	if (!ASSERT_OK_PTR(btf, "btf_new"))
> +		return;
> +
> +	raw_btf =3D btf__raw_data(btf, &raw_size);
> +	if (!ASSERT_OK_PTR(raw_btf, "btf__raw_data"))
> +		return;

[Severity: Medium]
Does this early return leak the btf object allocated just above by=20
btf__new_empty_opts()? It looks like btf__free(btf) is skipped if
btf__raw_data() fails.

[ ... ]
> +void test_btf_kind_decoding(void)
> +{
> +	char btf_kind_file1[] =3D "/tmp/test_btf_kind.XXXXXX";
> +	char btf_kind_file2[] =3D "/tmp/test_btf_kind.XXXXXX";
> +	char btf_kind_file3[] =3D "/tmp/test_btf_kind.XXXXXX";
> +	struct btf *btf =3D NULL, *new_btf =3D NULL;
> +	__s32 int_id, unrec_id, id, id2;
> +	LIBBPF_OPTS(btf_new_opts, opts);
> +	struct btf_layout *l;
> +	struct btf_header *hdr;
> +	const void *raw_btf;
> +	struct btf_type *t;
> +	void *new_raw_btf;
> +	void *str_data;
> +	__u32 raw_size;
> +
> +	opts.add_layout =3D true;
> +	btf =3D btf__new_empty_opts(&opts);
> +	if (!ASSERT_OK_PTR(btf, "btf_new"))
> +		return;
> +
> +	int_id =3D btf__add_int(btf, "test_char", 1, BTF_INT_CHAR);
> +	if (!ASSERT_GT(int_id, 0, "add_int_id"))
> +		return;

[Severity: Medium]
Will this direct return bypass the cleanup block at the end of the function
and leak the btf object?=20

There are several other similar return statements following this one. Shoul=
d=20
these early failure paths use goto out to ensure btf__free(btf) is called?

> +
> +	/*
> +	 * Create our type with unrecognized kind by adding a typedef kind
> +	 * we will overwrite it with our unrecognized kind value.
> +	 */
> +	unrec_id =3D btf__add_typedef(btf, "unrec_kind", int_id);
> +	if (!ASSERT_GT(unrec_id, 0, "add_unrec_id"))
> +		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324174450.1570=
809-1-alan.maguire@oracle.com?part=3D8
