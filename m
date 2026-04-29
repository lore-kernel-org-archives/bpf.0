Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C9331220
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504708; cv=none; b=Q9nZ4SnmTDM9lxC8no/UycHbhvB7ajOA/6Bf/Xcf8qQxH83FhSafmre7qztssNFzrSvL7/ucaWBuLL/mvUoceyTZEebu9w1T12zCw4fH9bqrbd9fmSJ+fUS6GdaJdtOX1/QUZmlaA7esEwptLlsdfcBYPaOxI2gXqQ5Wzlx+z3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504708; c=relaxed/simple;
	bh=Nz/0KV4Q1OYo3W0dM4w7d3Wj5TQOGVmJetUmAx8xj5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yv4esLKE3Bh9I2JCIL/Z1/Sj3jc884VCL2hbVFcBEnZ7zbfV6d0R6jh+0xtK2/0s41Pl0sS+kPuwQW/FrSNq6KsbpPdCpTvzzLCCXKy5EvdLxeE+SrKf+WP3DuYKZWCg+TlT2F05qTM8hre+8/Sa3ndZgOYM6HgMLEoWQbAFIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dymUhrJ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dymUhrJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D09CC19425;
	Wed, 29 Apr 2026 23:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777504707;
	bh=Nz/0KV4Q1OYo3W0dM4w7d3Wj5TQOGVmJetUmAx8xj5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dymUhrJ6lXej7tgkEFmBvFvKz/9ucseij2qYl6iY11+PrJgVhEygZioDa0ys4IeIy
	 OCToRM5znLTX97ie2+cwxNyThiW8JPPtgoirLwwus4kxmW0DStg4E/+OzpI9qu3MG3
	 Ez15d32Hz+jlJPw/AlEn8/l34QesRSYUWNbpIV99GFgtQNfOVILCoE2o8YMcPGiQvB
	 Urpv3TeRXc67YiwDc0TavyLBnjxibPz+0Srg1DfFUruco7Uf8jyJ8L1qLBm68TrqNa
	 /8eSSHYlrgncgB6l1fQfy4UYydd4V9RgiKlTjz6ePY3mrRlOaEvAiZvwS5mSI/pkbt
	 Uj/i+NZHuBWdA==
From: sashiko-bot@kernel.org
Subject: Re: [v6 06/10] security: Hornet LSM
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429191431.2345448-7-bboscaccy@linux.microsoft.com>
References: <20260429191431.2345448-7-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 23:18:26 +0000
Message-Id: <20260429231827.8D09CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] A Time-of-Check to Time-of-Use (TOCTOU) race condition in the =
`bpf` LSM hook allows attackers to bypass runtime map verification.
- [Critical] TOCTOU race condition on `attr->fd_array` allows loading unsig=
ned maps.
- [High] Unbounded memory allocation for the signature buffer based on user=
 input allows local Denial of Service.
- [High] Synchronous map hashing over potentially massive BPF maps causes s=
evere CPU stalls.
- [High] Lockless read of `map->frozen` lacks memory barriers, allowing rac=
e condition bypass.
- [High] Hardcoded fail-open logic for unsigned programs overrides downstre=
am LSM policy.
- [Medium] Off-by-one error in ASN.1 decoder rejects valid signatures with =
exactly 64 maps.
- [Medium] Legitimately skipped frozen maps are unconditionally rejected at=
 runtime.
- [Medium] Deduplication of `used_maps` causes state mismatch, rejecting va=
lid programs.
--

commit 88fd67d9d38369a17372ee4205b99a1b455d1487
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

security: Hornet LSM

This adds the Hornet Linux Security Module which provides enhanced
signature verification and data validation for eBPF programs. It
verifies PKCS#7 signatures and map hashes to solidify auditing and
prevent tampering.

> diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
> new file mode 100644
> index 000000000000..4656457657cc
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

Can this lead to a Time-of-Check to Time-of-Use race condition?
The map file descriptors are read directly from the user-provided fd_array.
After Hornet successfully verifies these maps against the signature, the BPF
verifier reads from the exact same user-space memory to bind the maps to the
program. It appears an attacker could swap the map file descriptors in user
memory with malicious, unsigned maps between the LSM check and the verifier
binding.

> +		if (err !=3D 0)
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

Could this check bypass the integrity verification due to missing memory
barriers? map->frozen is read locklessly here without smp_load_acquire().
While bpf_map_freeze uses a mutex, memory reordering could allow Hornet to
read benign map data while seeing map->frozen as true from a concurrent
freeze. An attacker could potentially update the map with malicious data
right before freezing it.

> +			return LSM_INT_VERDICT_FAULT;
[ ... ]
> +int hornet_next_map(void *context, size_t hdrlen,
> +		     unsigned char tag,
> +		     const void *value, size_t vlen)
> +{
> +	struct hornet_parse_context *ctx =3D (struct hornet_parse_context *)con=
text;
> +
> +	if (++ctx->hash_count >=3D MAX_USED_MAPS)

Does this reject valid signatures with exactly 64 maps? Since hash_count is
incremented before the comparison, processing the 64th map will trigger the
condition and cause the function to return -EINVAL.

> +		return -EINVAL;
> +	return 0;
> +}
[ ... ]
> +static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *a=
ttr,
> +				struct bpf_token *token, bool is_kernel,
> +				enum lsm_integrity_verdict *verdict)
> +{
[ ... ]
> +	maps.fd_array =3D make_bpfptr(attr->fd_array, is_kernel);
> +	sig =3D kzalloc(attr->signature_size, GFP_KERNEL);

Is there a risk of memory pressure or Denial of Service here?
The allocation size relies directly on the user-controlled
attr->signature_size without any upper bound check. An excessively large
size could trigger a loud warning from the page allocator and spam the
kernel log.

> +	if (!sig) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
[ ... ]
> +static int hornet_check_prog_maps(u32 ufd)
> +{
> +	CLASS(fd, f)(ufd);
> +	struct bpf_prog *prog;
> +	struct hornet_prog_security_struct *security;
> +	unsigned char hash[SHA256_DIGEST_SIZE];
> +	struct bpf_map *map;
> +	int i, j;
> +	bool found;
> +	int covered_count =3D 0;
> +
> +	if (fd_empty(f))
> +		return -EBADF;
> +	if (fd_file(f)->f_op !=3D &bpf_prog_fops)
> +		return -EINVAL;
> +
> +	prog =3D fd_file(f)->private_data;
> +	security =3D hornet_bpf_prog_security(prog);
> +
> +	if (!security->signed_hash_count)

Does this hardcoded fail-open logic override downstream LSM policy?
If a downstream LSM allows unsigned programs, Hornet returns 0 here and
bypasses map checks. However, if it allows partially signed programs, Hornet
still enforces that all frozen maps match, breaking LSM composition.

> +		return 0;
> +
> +	mutex_lock(&prog->aux->used_maps_mutex);
> +
> +	/* Verify every used_map has a matching signed hash */
> +	for (j =3D 0; j < prog->aux->used_map_cnt; j++) {
> +		map =3D prog->aux->used_maps[j];
> +
> +		if (!map->frozen || !map->ops->map_get_hash)
> +			continue;
> +
> +		if (map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash))

Could this cause CPU stalls or local Denial of Service?
BPF maps can be extremely large. Computing the hash over the entire map
memory synchronously without yielding the CPU could cause multi-second RCU
stalls.

> +			continue;
> +
> +		found =3D false;
> +		for (i =3D 0; i < security->signed_hash_count; i++) {
> +			if (memcmp(hash,
> +				   &security->signed_hashes[i * SHA256_DIGEST_SIZE],
> +				   SHA256_DIGEST_SIZE) =3D=3D 0) {
> +				found =3D true;
> +				break;
> +			}
> +		}
> +		if (!found) {

Does this incorrectly reject legitimately skipped maps?
If a signature specifies a zero-length hash for a map, hornet_map_hash sets
skips to true and excludes it from signed_hashes. However, if the map is
frozen, this loop will fail to find it in signed_hashes and return -EPERM.

> +			mutex_unlock(&prog->aux->used_maps_mutex);
> +			return -EPERM;
> +		}
> +		covered_count++;
> +	}
> +
> +	mutex_unlock(&prog->aux->used_maps_mutex);
> +
> +	/* Ensure all signed hashes were accounted for */
> +	if (covered_count !=3D security->signed_hash_count)

Can this fail due to map deduplication?
If a program's signature contains multiple index entries for the same map
file descriptor, signed_hash_count is incremented for each entry. The BPF
core deduplicates maps in prog->aux->used_maps, so covered_count is only
incremented once per unique map, causing this check to reject valid program=
s.

> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +static int hornet_bpf(int cmd, union bpf_attr *attr, unsigned int size, =
bool kernel)
> +{
[ ... ]
> +	if (cmd !=3D BPF_PROG_RUN)
> +		return 0;
> +	if (kernel)
> +		return 0;
> +
> +	return hornet_check_prog_maps(attr->test.prog_fd);

Is there a Time-of-Check to Time-of-Use race condition here?
attr->test.prog_fd is resolved and checked inside hornet_check_prog_maps, b=
ut
the BPF core will resolve the same file descriptor again via bpf_prog_get()
before executing it. Because the file descriptor table is shared across
threads, an attacker could use dup2() to swap the file descriptor to point
to a malicious BPF program after Hornet's check but before execution.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429191431.2345=
448-1-bboscaccy@linux.microsoft.com?part=3D6
