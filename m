Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7DA264612
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776745773; cv=none; b=W3KKSjB9K2ALDlVOCNfixWS12BN1bPwKu8os+d0h9Dk5KE2LZ1Dy8zU/weMFqSWjLqBW/4grwulnuKsvLU6Fgo452CVDAEyAjObZI+B8qoy8ruiLDvPHSWIUFB+4QziUq6TeDofxzJTFGBm9uq19bWf+SvkVKtUpsgZ1WsIqXM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776745773; c=relaxed/simple;
	bh=hzY6akz6bBA4MXzM6ViNqrPGWX+Pap4OKNgs8C1E1Xo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aZ59dFerOez3rUgz7TUNm1TtmWXnIKvO2JFkIE3KBMAGDUIDL7tkruNDbQ2xT4Hm7/6YbxMmIfY3B5oYViKZEup0BZp8KVUv6NTaHqyPCjTHIPZRu0KsJdfyF0u/qdLZZhhV8y2NWiZlAb9zeSsw5KK05x57c5uJMllEWWSIKcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBaE/OA/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBaE/OA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4805DC2BCB3;
	Tue, 21 Apr 2026 04:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776745773;
	bh=hzY6akz6bBA4MXzM6ViNqrPGWX+Pap4OKNgs8C1E1Xo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lBaE/OA/uMb8LphWXGW5a2BA2GokTCp1A6h+FTXBoKql1+qH5vwE4WEmA1bE7yKBz
	 DEck+qZL5FAYbDKL3tlkpUWKPjURg3sPoCzxknsxQtPuBUhyPqfphr5CbR7/roVbys
	 9iJ8LnqPa/xNv4Qp2sEOD8ss5eenkBgUUaWV3PiRE6u9aBITQuv9KSj3f813LzxaNS
	 SghDj4ZCwG7PM1w7lpSkayWDPfqeV7zuPUOCBvfFTyncJT26H9i7224XnjEPyZfu0w
	 j2JqOovT7wvOymIAPuiCVsmjNcKevoJWGAjow9ticdv1syWCK5FEBqa+O8byIZqpt/
	 42Z8HcEdZoORQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/10] security: Hornet LSM
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420212653.438685-7-bboscaccy@linux.microsoft.com>
References: <20260420212653.438685-7-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 04:29:32 +0000
Message-Id: <20260421042933.4805DC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 10 potential issue(s):
- [High] Invalid Pointer Dereference due to missing IS_ERR check on lookup_=
user_key().
- [High] Resource Leak due to missing key_put() on user keyring reference.
- [High] NULL Pointer Dereference when verifying map types that do not impl=
ement map_get_hash.
- [High] Security Bypass due to uninitialized verdict variable on copy_from=
_bpfptr() failure.
- [High] Logic Flaw allowing verification of arbitrary file descriptors on =
copy_from_bpfptr_offset() failure.
- [High] State Corruption and Data Race in globally shared map_security obj=
ect.
- [High] Logic Error bypassing runtime map verification due to incorrect lo=
op index.
- [High] False Positives and Logic Error due to matching unverified maps to=
 signature index 0.
- [Medium] Out-of-bounds Read in hornet_map_index() due to missing length c=
heck.
- [Medium] Off-by-One Error limits tracked maps to 63 instead of the intend=
ed 64.
--

commit 59054f5223757f6e86fcfcc7b0a3aa6b97918bab
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

security: Hornet LSM

This commit adds the Hornet Linux Security Module. It verifies PKCS#7
signatures attached to eBPF programs and checks SHA-256 hashes of BPF maps
at load and run time.

> diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
> new file mode 100644
> index 0000000000000..f7d62fe6229c9
> --- /dev/null
> +++ b/security/hornet/hornet_lsm.c
[ ... ]
> +static int hornet_verify_hashes(struct hornet_maps *maps,
> +				struct hornet_parse_context *ctx,
> +				struct bpf_prog *prog)
> +{
[ ... ]
> +	for (i =3D 0; i < ctx->hash_count; i++) {
> +		if (ctx->skips[i])
> +			continue;
> +
> +		err =3D copy_from_bpfptr_offset(&map_fd, maps->fd_array,
> +					      ctx->indexes[i] * sizeof(map_fd),
> +					      sizeof(map_fd));
> +		if (err < 0)

Does this correctly handle copy_from_bpfptr_offset() failures?

The copy_from_bpfptr_offset() function returns the positive number of
uncopied bytes on failure, so err < 0 will not catch the error.

Since the destination buffer is zero-filled on failure, could this allow
inspecting file descriptor 0 instead of the intended map?

> +			return LSM_INT_VERDICT_FAULT;
> +
> +		CLASS(fd, f)(map_fd);
> +		if (fd_empty(f))
> +			return LSM_INT_VERDICT_FAULT;
> +		if (unlikely(fd_file(f)->f_op !=3D &bpf_map_fops))
> +			return LSM_INT_VERDICT_FAULT;
> +
> +		map =3D fd_file(f)->private_data;
> +		if (!map->frozen)
> +			return LSM_INT_VERDICT_FAULT;
> +
> +		map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash);

Are we sure map_get_hash is implemented for all map types being checked?

Many standard BPF maps (such as hash maps) do not implement this callback.
Could calling it unconditionally trigger a NULL pointer dereference if an
unsupported map type is encountered?

> +
> +		err =3D memcmp(hash, &ctx->hashes[i * SHA256_DIGEST_SIZE],
> +			      SHA256_DIGEST_SIZE);
> +		if (err)
> +			return LSM_INT_VERDICT_UNEXPECTED;
> +
> +		security->checked[i] =3D true;
> +		memcpy(&security->hashes[i * SHA256_DIGEST_SIZE], hash, SHA256_DIGEST_=
SIZE);
> +		map_security =3D hornet_bpf_map_security(map);
> +		map_security->checked =3D true;
> +		map_security->index =3D i;

Is it safe to write the program-specific signature index into the globally
shared map_security object?

If multiple programs are concurrently loaded and attach the same map at
different signature indices, this could result in a data race. When the
first program runs, hornet_verify_map() expects the original index, which
might cause legitimate executions to fail.

> +	}
> +	return LSM_INT_VERDICT_OK;
> +}
> +
> +int hornet_next_map(void *context, size_t hdrlen,
> +		     unsigned char tag,
> +		     const void *value, size_t vlen)
> +{
> +	struct hornet_parse_context *ctx =3D (struct hornet_parse_context *)con=
text;
> +
> +	if (++ctx->hash_count >=3D MAX_USED_MAPS)

Should this condition be > instead of >=3D?

Since MAX_USED_MAPS is 64, returning an error when the count reaches 64
artificially restricts the maximum number of tracked maps to 63.

> +		return -EINVAL;
> +	return 0;
> +}
> +
> +int hornet_map_index(void *context, size_t hdrlen,
> +		     unsigned char tag,
> +		     const void *value, size_t vlen)
> +{
> +	struct hornet_parse_context *ctx =3D (struct hornet_parse_context *)con=
text;
> +
> +	if (vlen > 1)
> +		return -EINVAL;
> +
> +	ctx->indexes[ctx->hash_count] =3D *(u8 *)value;

Is it possible for vlen to be 0 here?

If a crafted ASN.1 signature provides a zero-length integer, this might
result in an out-of-bounds read when accessing *(u8 *)value.

> +	return 0;
> +}
[ ... ]
> +static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *a=
ttr,
> +				struct bpf_token *token, bool is_kernel,
> +				enum lsm_integrity_verdict *verdict)
> +{
[ ... ]
> +	err =3D copy_from_bpfptr(sig, usig, attr->signature_size);
> +	if (err !=3D 0)
> +		goto cleanup_sig;

Does this properly handle a copy_from_bpfptr() failure?

The copy_from_bpfptr() function returns the positive number of uncopied
bytes on failure, which is then propagated and returned by
hornet_check_program().

In hornet_bpf_prog_load_integrity(), the failure check is if (result < 0).
That check will pass on a positive return value, which could lead to
security_bpf_prog_load_post_integrity() being called with an uninitialized
verdict variable.

> +
> +	msg =3D pkcs7_parse_message(sig, attr->signature_size);
> +	if (IS_ERR(msg)) {
> +		*verdict =3D LSM_INT_VERDICT_BADSIG;
> +		err =3D 0;
> +		goto cleanup_sig;
> +	}
> +
> +	if (system_keyring_id_check(attr->keyring_id) =3D=3D 0)
> +		key =3D (struct key*)(unsigned long)attr->keyring_id;
> +	else
> +		key =3D key_ref_to_ptr(lookup_user_key(attr->keyring_id, 0, KEY_DEFER_=
PERM_CHECK));
> +
> +	if (verify_pkcs7_message_sig(prog->insnsi, prog->len * sizeof(struct bp=
f_insn), msg,
> +				     key,

Can lookup_user_key() return an error pointer here?

If lookup_user_key() fails (for instance, due to an invalid keyring ID),
key_ref_to_ptr() masks the reference but does not check for IS_ERR(). This
could lead to an invalid pointer dereference when key is evaluated later.

Additionally, lookup_user_key() increments the reference count of the
returned key. Is there a missing key_put() to release this reference? It
appears the reference is never dropped on either the success or error
paths, which could cause a memory leak.

[ ... ]
> +static int hornet_verify_map(struct bpf_prog *prog, int index)
> +{
> +	unsigned char hash[SHA256_DIGEST_SIZE];
> +	int i;
> +	struct bpf_map *map;
> +	struct hornet_prog_security_struct *security =3D hornet_bpf_prog_securi=
ty(prog);
> +	struct hornet_map_security_struct *map_security;
> +
> +	if (!security->checked[index])
> +		return 0;
> +
> +	for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
> +		map =3D prog->aux->used_maps[i];
> +		map_security =3D hornet_bpf_map_security(map);
> +		if (map_security->index !=3D index)

If a map has not been verified, its map_security structure is
zero-initialized, making map_security->index evaluate to 0.

When verifying signature index 0, could this wrongly match an unverified
map and attempt to compute its hash, leading to false positives?

> +			continue;
> +
> +		if (!map->frozen)
> +			return -EPERM;
> +
> +		map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash);

Similar to hornet_verify_hashes(), does this safely handle map types that
do not implement map_get_hash?

Calling it unconditionally on unsupported maps might trigger a NULL pointer
dereference.

> +		if (memcmp(hash, &security->hashes[index * SHA256_DIGEST_SIZE],
> +			   SHA256_DIGEST_SIZE) !=3D 0)
> +			return -EPERM;
> +		else
> +			return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int hornet_check_prog_maps(u32 ufd)
> +{
[ ... ]
> +	for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
> +		result =3D hornet_verify_map(prog, i);

Is i the correct value to pass as the signature index here?

The loop counter i iterates up to used_map_cnt. If a program uses maps
assigned to higher signature indices (e.g., indices 5 and 6) but only uses
2 maps overall, it appears this loop will only check indices 0 and 1,
skipping verification for the expected indices.

> +		if (result)
> +			goto out;
> +	}
> +out:
> +	mutex_unlock(&prog->aux->used_maps_mutex);
> +	return result;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420212653.4386=
85-1-bboscaccy@linux.microsoft.com?part=3D6
