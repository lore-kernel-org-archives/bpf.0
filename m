Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C2332623
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740586; cv=none; b=ERhDf64CtUkbCXQ23bbUka3L7vZlWDKNE9TG7B34fHqovP58MKp3rTR+cvbXl4FljbKusOC5Kgj4tJTx4nupTd/Tn96RJN7k3oDwR/xYWTlAroE54zLWbXnenYI+L+ml28e9xkPiQ1ZlR7fskuZQv7dbG8wwvTxfF/1yaaf206k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740586; c=relaxed/simple;
	bh=byiO81E6MX9h/njLlgv5IvYDC1ITDmOLRbJNiZDtRck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bGN9w0OiM3q2C7qissQY5WUj5xM4zodNiVRkbLNBYCRttp1tItvV/1JvWjuUlOD5Wt3acfgcD9/hb4iqQVg0wZEz6/QIL9gzGXbP1ON6P1Ly+wYJDnoJ4oMJw+ibz+ClGpNynnlmoEJtwoGRvAvhZzPasuYJ60Q3zgXVcnrzHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1wkIZko; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1wkIZko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957A9C19425;
	Tue, 21 Apr 2026 03:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776740585;
	bh=byiO81E6MX9h/njLlgv5IvYDC1ITDmOLRbJNiZDtRck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=I1wkIZko19QA+3Kz0IP1aozBE6Q8Ezfe/Be/aYSjdSuDzaVH/WcV7E8BQiJk1mac0
	 M9vwx+g0+x/DqE3BxgSD84xGIdy9ChkebiMyGXilO+6BWV6/O6a67vOikZIAUwrcLL
	 3eI2pVI8KxR5lJWJO3doui0F4DdSqYOyE7mllF6WJDIpGx9wr/c9Rbn7QC2s14L2PU
	 CvLq0vqrKxzM5z6G7zrRzFPqGJJP4GksPdCXS8HiFd2ZVC3hmzknYGPhfzENp1TmoO
	 WN18IyvKGiJxUJFYmbnyG3U1aiCAiArCNURnxO/Bq9NUtB9Bkyh/rFKqhlSGwHiUKZ
	 y5dJhCNpJpJ7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/10] hornet: Introduce gen_sig
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420212653.438685-8-bboscaccy@linux.microsoft.com>
References: <20260420212653.438685-8-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 03:03:05 +0000
Message-Id: <20260421030305.957A9C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Infinite loop during argument parsing on architectures with unsign=
ed char.
- [Medium] Ignored return value of `sha256()` causes use of uninitialized m=
emory.
- [Medium] Stack buffer overflow when parsing '--add' arguments.
- [Medium] Missing NULL pointer checks for OpenSSL allocations.
- [Medium] Unchecked return value of `ASN1_item_i2d()`.
--

commit 72bf19e54c723e2a7111cbc219bbeb6e98977318
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

hornet: Introduce gen_sig

This commit introduces the gen_sig tool. It creates a pkcs#7 signature of a
data payload and appends a signed attribute containing a set of hashes.

> diff --git a/scripts/hornet/gen_sig.c b/scripts/hornet/gen_sig.c
> index 0000000000000..f966516ebc99b
> --- /dev/null
> +++ b/scripts/hornet/gen_sig.c

[ ... ]

> +static void add_hash(MAP_SET *set, unsigned char *buffer, int buffer_len=
, int index)
> +{
> +	HORNET_MAP *map =3D NULL;
> +
> +	map =3D HORNET_MAP_new();
> +	ASN1_INTEGER_set(map->index, index);

map is allocated via HORNET_MAP_new(), but the return value is not checked
for NULL before dereferencing it in ASN1_INTEGER_set(). Should we handle
potential allocation failures here?

[ ... ]

> +int main(int argc, char **argv)
> +{

[ ... ]

> +	int i;
> +	char opt;
> +
> +	const char *short_opts =3D "C:K:P:O:A:Sh";
> +
> +	static const struct option long_opts[] =3D {
> +		{"cert", required_argument, 0, 'C'},
> +		{"key",  required_argument, 0, 'K'},
> +		{"pass",  required_argument, 0, 'P'},
> +		{"out",  required_argument, 0, 'O'},
> +		{"data",  required_argument, 0, 'D'},
> +		{"add",  required_argument, 0, 'A'},
> +		{"help",    no_argument,       0, 'h'},
> +		{0, 0, 0, 0}
> +	};
> +
> +	while ((opt =3D getopt_long_only(argc, argv, short_opts, long_opts, NUL=
L)) !=3D -1) {

getopt_long_only() returns an int. If it returns -1, and opt is a char,
architectures where char is unsigned by default (like ARM or PowerPC) will
evaluate opt as 255.

Since 255 !=3D -1, will this cause an infinite loop during argument parsing=
 on
those platforms?

> +		switch (opt) {
> +		case 'C':
> +			cert_path =3D optarg;
> +			break;

[ ... ]

> +		case 'A':
> +			if (strchr(optarg, ':')) {
> +				hashes[hash_count].file =3D strsep(&optarg, ":");
> +				hashes[hash_count].index =3D atoi(optarg);
> +				hash_count++;

The hashes array is defined with a fixed size of MAX_HASHES. Does this code
need to check if hash_count is less than MAX_HASHES before writing to the
array to prevent a stack buffer overflow if too many arguments are provided?

[ ... ]

> +	si =3D CMS_add1_signer(cms_out, signer, pkey, EVP_sha256(), flags);
> +	ERR(!si, "add signer failed");
> +
> +	set =3D MAP_SET_new();
> +	set->maps =3D sk_HORNET_MAP_new_null();

MAP_SET_new() and sk_HORNET_MAP_new_null() can return NULL if memory
allocation fails. Since set->maps dereferences set immediately, can this
result in a segmentation fault under memory pressure?

> +
> +	for (i =3D 0; i < hash_count; i++) {
> +		sha256(hashes[i].file, hash_buffer, &hash_len);
> +		add_hash(set, hash_buffer, hash_len, hashes[i].index);
> +	}

The return value of sha256() is ignored here. If the file cannot be opened,
sha256() will fail, leaving hash_buffer and hash_len uninitialized.

Will this lead to an out-of-bounds read of uninitialized stack memory when
passed to add_hash()?

> +
> +	oid =3D OBJ_txt2obj("2.25.316487325684022475439036912669789383960", 1);
> +	if (!oid) {
> +		ERR_print_errors_fp(stderr);
> +		DIE("create oid failed");
> +	}
> +
> +	der_len =3D ASN1_item_i2d((ASN1_VALUE *)set, &der, ASN1_ITEM_rptr(MAP_S=
ET));
> +	CMS_signed_add1_attr_by_OBJ(si, oid, V_ASN1_SEQUENCE, der, der_len);

ASN1_item_i2d() returns a negative value on failure. Since der_len is passed
directly to CMS_signed_add1_attr_by_OBJ() without checking for errors, could
this cause issues by passing a negative length to the OpenSSL routine?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420212653.4386=
85-1-bboscaccy@linux.microsoft.com?part=3D7
