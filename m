Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D271EB5C2
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 02:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778206980; cv=none; b=vDgFhV3saNcRFFpMwA2UabyTP9Z2GxHTFLZqAmYfOaKC77ms5bnQYO4+I/1/OCRY4bhPf5UZ2ZwQloZ8fNnvczEx+CboEKNa4MNv6EejBx5MUeOw7C7zTW/zo4cuKRSjsHgCaeQf3e+Mx95TM7le4Jm9ZrybSQYikgmo0w2kR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778206980; c=relaxed/simple;
	bh=/IQyjNRIufdZWdOKYLT9hZ6X03CfeUbDxjRLZc3Zyb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X9MsYNjrv9IaHrm4eXgGFxIcHdFEB8deKQBrqO3erq1ba27SP8LV1vim5fypdU4yKK0ALjiPFSgwXFEbzqRJY034UHyoUVfrshH1auDkFvUolFjlLu9DnLvsNC/XwIOi7OmG3BkyIa4B+WNYPKCkbH1pwD4Cr0GV7XcwmW0LFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc4r4V/g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc4r4V/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BA3C2BCB2;
	Fri,  8 May 2026 02:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778206979;
	bh=/IQyjNRIufdZWdOKYLT9hZ6X03CfeUbDxjRLZc3Zyb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Bc4r4V/g4PIthSTRelzRpZtUkKPrYdhMtu1FaJxvmegto9I3n3XxlpJmqov0vSR4Z
	 /f7L5h/wB5jcNZZXsEcDjydO7ZKXP0JiKYCH89S5WsBAk37zejis14nlAKJ7BIjSkJ
	 HtEaWGTqtISL6bXkL13h0Ep7CopX998ivOuMk4agyYQuT1usJJVGOFNi/kIegSwRn8
	 3bwbtJbdbYm8yGecW9ct5BzCQ4Mq2TNTIjeU7U1GcyT6G4+uLbxVpeyxRBZxYC1nHV
	 IZl6Rn7VETMy9rbhRvS5mPgV4DjQK0doRl8i6fGvqTcuRshYx2Oc99igT9UD6Y1MdV
	 IPNXyVUpInafQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] hornet: Introduce gen_sig
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507191416.2984054-8-bboscaccy@linux.microsoft.com>
References: <20260507191416.2984054-8-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 02:22:58 +0000
Message-Id: <20260508022259.80BA3C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing error checks for memory allocations and OpenSSL APIs can l=
ead to crashes or silently corrupted outputs.
- [Medium] Off-by-one error limits the maximum number of hashes.
- [Low] Command-line option parsing errors due to mismatched `short_opts` a=
nd missing switch cases.
- [Low] Premature teardown of global OpenSSL error strings inside a loop.
- [Low] Unquoted variables in `write-sig.sh` can cause word splitting and u=
nexpected file reads.
--

commit deefd8583c7763e2999adf448f86a8e2512b3368
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

hornet: Introduce gen_sig

This introduces the gen_sig tool to create a pkcs#7 signature of a data
payload and append a signed attribute containing a set of hashes.

> diff --git a/scripts/hornet/gen_sig.c b/scripts/hornet/gen_sig.c
> new file mode 100644
> index 0000000000000..4d59b70f5fff4
> --- /dev/null
> +++ b/scripts/hornet/gen_sig.c
[ ... ]
> +static int sha256(const char *path, unsigned char out[SHA256_LEN], unsig=
ned int *out_len)
> +{
[ ... ]
> +	ERR_load_crypto_strings();
> +
> +	rc =3D -3;
> +	ctx =3D EVP_MD_CTX_new();
[ ... ]
> +done:
> +	EVP_MD_CTX_free(ctx);
> +	fclose(f);
> +	ERR_free_strings();
> +	return rc;
> +}

Because sha256() is called inside a loop in main(), will calling
ERR_free_strings() here prematurely free the global error string table? This
might cause subsequent OpenSSL errors to only print raw numeric codes inste=
ad
of human-readable messages.

> +static void add_hash(MAP_SET *set, unsigned char *buffer, int buffer_len=
, int index)
> +{
> +	HORNET_MAP *map =3D NULL;
> +
> +	map =3D HORNET_MAP_new();
> +	ASN1_INTEGER_set(map->index, index);

Should we check if map is NULL before passing it to ASN1_INTEGER_set()? If
HORNET_MAP_new() fails during an out-of-memory condition, this could lead t=
o a
segmentation fault.

[ ... ]
> +int main(int argc, char **argv)
> +{
[ ... ]
> +	const char *short_opts =3D "C:K:P:O:A:Sh";

This isn't a bug, but short_opts appears to be missing D: for the data
argument. Will this cause the short -D option to be rejected even though it
is defined in long_opts?

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
> +		switch (opt) {
[ ... ]
> +		case 'A':
> +			if (strchr(optarg, ':')) {
> +				hashes[hash_count].file =3D strsep(&optarg, ":");
> +				hashes[hash_count].index =3D atoi(optarg);
> +				if (++hash_count >=3D MAX_HASHES) {

Does this condition inadvertently limit the maximum number of hashes to 63
instead of 64? If exactly 64 hashes are provided, hash_count increments to =
64,
the condition evaluates to true, and it immediately aborts.

> +					usage(argv[0]);
> +					return EXIT_FAILURE;
> +				}
> +			} else {
> +				usage(argv[0]);
> +				return EXIT_FAILURE;
> +			}
> +			break;
> +		default:
> +			usage(argv[0]);
> +			return EXIT_FAILURE;
> +		}
> +	}

Passing --help maps to 'h', but there is no case for 'h' in the switch
statement. Will this fall through to the default case and incorrectly return
EXIT_FAILURE instead of EXIT_SUCCESS?

[ ... ]
> +	set =3D MAP_SET_new();
> +	set->maps =3D sk_HORNET_MAP_new_null();

Could MAP_SET_new() return NULL here, causing a crash when set->maps is
subsequently accessed?

[ ... ]
> +	der_len =3D ASN1_item_i2d((ASN1_VALUE *)set, &der, ASN1_ITEM_rptr(MAP_S=
ET));
> +	CMS_signed_add1_attr_by_OBJ(si, oid, V_ASN1_SEQUENCE, der, der_len);

ASN1_item_i2d() can return a negative value on failure. Could passing this
unchecked der_len into CMS_signed_add1_attr_by_OBJ() cause an out-of-bounds
read or crash?

Additionally, should the return value of CMS_signed_add1_attr_by_OBJ() be
checked for errors?

[ ... ]
> +	err =3D CMS_final(cms_out, data_in, NULL, CMS_NOCERTS | CMS_BINARY);
> +	ERR(!err, "cms final failed");
> +
> +	OPENSSL_free(der);
> +	MAP_SET_free(set);
> +
> +	b_out =3D bio_open_wr(out_path);
> +	ERR(!b_out, "opening output path failed");
> +
> +	i2d_CMS_bio_stream(b_out, cms_out, NULL, 0);

Is it possible for i2d_CMS_bio_stream() to fail, for example if there is no
space left on the device? Since the return value is ignored, could the tool
exit successfully while leaving a corrupted or empty signature file?

> +	BIO_free(data_in);
> +	BIO_free(b_out);
> +	EVP_cleanup();
> +	ERR_free_strings();
> +	return 0;
> +}
> diff --git a/scripts/hornet/write-sig.sh b/scripts/hornet/write-sig.sh
> new file mode 100755
> index 0000000000000..7eaabe3bab9aa
> --- /dev/null
> +++ b/scripts/hornet/write-sig.sh
[ ... ]
> +if [ $ARGC -ne $EXPECTED_ARGS ] ; then
> +    usage
> +else
> +    SIG=3D$(xxd -p $2 | tr -d '\n' | sed 's/\(..\)/\\\\x\1/g')
> +    sed '/const char opts_sig/,/;/c\\tstatic const char opts_sig[] __att=
ribute__((__aligned__(8))) =3D "\\\n'"$(printf '%s\n' "$SIG")"'\";' $1
> +fi

This isn't a bug, but could leaving the variables $1 and $2 unquoted cause
issues if the provided filenames contain spaces? This might result in word
splitting and cause xxd or sed to read unintended files.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507191416.2984=
054-1-bboscaccy@linux.microsoft.com?part=3D7
