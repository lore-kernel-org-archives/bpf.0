Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A43B2AA
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776375236; cv=none; b=Ns6+MLeuTpvnBlD8pL8C4sLsrBU+9WpkhSxKt5nMuLpmwfZ4EEgw7fBVFh8x+OdrABNTo4McaSPgD9FCmsagcXpjBqLnVPctRAcWyzTe3TCK92NwCXKif4KxonWeZNLzAPsm33t5I5atM/EP7eVaz6tlcYNsyn+XHaMRmv+KI8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776375236; c=relaxed/simple;
	bh=14FQwScIPbCfTUcIizYYcCXMXYll1/oSoZC8zODNGYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rG+SF57tJ3aV/KD6ecvrgSUuCVejwGfANpIBeifjSbHxohBXODNfUBZ8sw3erPV799dkNSnv/KUSw/vNo3VZdhMzv1Q5xZA8JXZOyPG2nrvf2JpGiOPh99lVz8gNbyCw9QIjRtnAOICCqkiF1LraPyLLMoJrzZa7uT9wT5wgHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5WB2Ljh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5WB2Ljh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C66C2BCB5;
	Thu, 16 Apr 2026 21:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776375236;
	bh=14FQwScIPbCfTUcIizYYcCXMXYll1/oSoZC8zODNGYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=I5WB2Ljh8XpKPrOnA+oYR6cd7G/rvJHmh0BOyPX8JkMHqOYVVyA6v1OfwqimxtXkw
	 0pAsnYPeiwC79FGicrpF5hSUymug4lJ1pbDnffbLdkva2amnxec8x0CMCAromOMkaz
	 k0m3yivcmOeddAUmu8xhiCIN0qN11e3ZXzt77uXlx0QdUOI7ruf0TWvRjhGToA+Inc
	 d1/CoaKf797vNoz3GONKAKhgXknrHj5XPmdAZxhqoxCHn37Uo5D0Mfzhy+Iy0rHlbQ
	 iEFUeF+/ZYXIKQ1gDN71jkqhPRN1CrgirG9zz/XMXOMT9m+OmGcWRyt+mOsFz4g1vV
	 Z+vJJBiPbHQUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/10] hornet: Introduce gen_sig
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416173500.176716-8-bboscaccy@linux.microsoft.com>
References: <20260416173500.176716-8-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 21:33:55 +0000
Message-Id: <20260416213356.39C66C2BCB5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Infinite loop during argument parsing on architectures with unsign=
ed `char`.
- [High] Unchecked `sha256()` return value leads to usage of uninitialized =
stack memory.
- [Medium] Stack buffer overflow when parsing `--add` arguments.
- [Medium] Unchecked return values for OpenSSL serialization and file outpu=
t lead to silent failures.
- [Medium] `write-sig.sh` outputs to stdout instead of modifying the target=
 file in-place.
--

commit 5e34aa795f3e17cbd08a08fff14bbdb70263937f
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

hornet: Introduce gen_sig

This introduces the gen_sig tool to create a pkcs#7 signature of a
data payload. It additionally appends a signed attribute containing a
set of hashes.

> diff --git a/scripts/hornet/gen_sig.c b/scripts/hornet/gen_sig.c
> new file mode 100644
> index 0000000000000..f966516ebc99b
> --- /dev/null
> +++ b/scripts/hornet/gen_sig.c

[ ... ]

> +int main(int argc, char **argv)
> +{
> +	const char *cert_path =3D NULL;
> +	const char *key_path =3D NULL;
> +	const char *data_path =3D NULL;
> +	const char *out_path =3D NULL;
> +
> +	X509 *signer;
> +	EVP_PKEY *pkey;
> +	BIO *data_in;
> +	CMS_ContentInfo *cms_out;
> +	struct hash_spec hashes[MAX_HASHES];
> +	int hash_count =3D 0;
> +	int flags;
> +	CMS_SignerInfo *si;
> +	MAP_SET *set;
> +	unsigned char hash_buffer[SHA256_LEN];
> +	unsigned int hash_len;
> +	ASN1_OBJECT *oid;
> +	unsigned char *der =3D NULL;
> +	int der_len;
> +	int err;
> +	BIO *b_out;
> +	int i;
> +	char opt;

Could this cause an infinite loop on certain architectures?

Because opt is a char, on platforms where char is unsigned by default (such=
 as
ARM and PowerPC), it cannot hold the value -1.=20

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

When getopt_long_only() returns -1, it would be converted to 255. The loop
condition 255 !=3D -1 would evaluate to true, resulting in an infinite loop=
 that
could hang the build process.

> +		switch (opt) {

[ ... ]

> +		case 'A':
> +			if (strchr(optarg, ':')) {
> +				hashes[hash_count].file =3D strsep(&optarg, ":");
> +				hashes[hash_count].index =3D atoi(optarg);
> +				hash_count++;

Is it possible to overflow the hashes array here?

The hashes array is allocated with a fixed capacity of MAX_HASHES (64). Sin=
ce
hash_count is incremented without bounds checking, providing more than 64 -=
-add
flags could write out of bounds on the stack.

> +			} else {
> +				usage(argv[0]);
> +				return EXIT_FAILURE;
> +			}
> +		}
> +	}

[ ... ]

> +	set =3D MAP_SET_new();
> +	set->maps =3D sk_HORNET_MAP_new_null();
> +
> +	for (i =3D 0; i < hash_count; i++) {
> +		sha256(hashes[i].file, hash_buffer, &hash_len);

What happens if sha256() fails here?

If sha256() returns a negative error code (for instance, if the file cannot=
 be
opened), the local variables hash_buffer and hash_len remain uninitialized.

> +		add_hash(set, hash_buffer, hash_len, hashes[i].index);

Since the return value of sha256() is unchecked, this could blindly pass
uninitialized stack memory to add_hash(). The garbage value in hash_len mig=
ht
be very large, causing out of bounds reads from the stack and potentially
embedding uninitialized memory into the generated signature.

> +	}
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

Can ASN1_item_i2d() fail and return a negative length?

If der_len is negative upon failure, passing it to CMS_signed_add1_attr_by_=
OBJ()
might cause memory issues inside OpenSSL.

> +
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

Does this silently ignore write failures?

If writing the final signature to the output file fails (e.g., due to a full
disk or an I/O error), ignoring the return value of i2d_CMS_bio_stream() me=
ans
the tool will still exit with a 0 status code. This could silently fail to
produce the necessary signature artifacts without breaking the build.

> +
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

Should this use the -i flag for in-place modification?

Currently, sed prints the modified content to standard output instead of
modifying the target header file, which appears to leave the original file
unchanged.

> +fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416173500.1767=
16-1-bboscaccy@linux.microsoft.com?part=3D7
