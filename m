Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989B38AC8A
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776374695; cv=none; b=d75m6jwdLUeYnBSANCRs1vJGpBbwGaGZObMniEinKJDmAExxiyTCJoPvca8t0UfCbvyxQiTxNdSKkAJT1FeLzBQxfohdkKmtnzoR1muR4dJxph6LqmbPisODVbaDye6gG1tZXm0MJHozoAmkgLdx+Tntcl8dX/YlSsedtlR2xuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776374695; c=relaxed/simple;
	bh=PS1mQyhQ8eD43s00w8Tun+Ai9ECQ+oznSNVR16wd5po=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qyJI9JtWusb2u0lWwAtnUqIsI6RlVMceY38ceoYaN93feM0NlVsbXM8Q8o4yF4VR8G9t7rD4o5tfWTk+yYeV5CJwqc5oCNDAvvyk8pnBv1VrRRBOLltBdKnoGw0TzFjxvwX+E91H/TxdACpslQ2hHrFErtovwd05u8yM0T+enCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEEzS6w2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEEzS6w2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850C2C2BCAF;
	Thu, 16 Apr 2026 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776374694;
	bh=PS1mQyhQ8eD43s00w8Tun+Ai9ECQ+oznSNVR16wd5po=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dEEzS6w2aCChbsaNchwnfhBfIsZPr3EQHnzCjeXAaFUcwyYBzcw5qkqSVAU9Azk62
	 JATAVuD+Fxqhw9WIReR11cEhGqWNbJEyvLI5bRn8dFcLNMoRfySLV+jw1YmKTGEPQu
	 hME4TQMnuYPYyf6Jb7IstkSzR83KZVEW98T77BtNz+GKWWU/sHtcc2eZcgi5cqGl+O
	 BZkUwrM1xlfscd1tViPGBx7e8XKbU26gxTZbKtl4XTyrMaIUyAljyaRnUHzJBa1d+W
	 ptTCHPbzgq3MmZiEYX+S+ffWS0Dm88s22GrfwkRowEUnqF4+Y1P28h80+kMaQkKv4w
	 VTkB6XGcMggHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/10] security: Hornet LSM
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416173500.176716-7-bboscaccy@linux.microsoft.com>
References: <20260416173500.176716-7-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 21:24:53 +0000
Message-Id: <20260416212454.850C2C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 11 potential issue(s):
- [Critical] Improper error handling in userspace copies leads to security =
bypass and uninitialized variable use.
- [High] Unchecked `lookup_user_key` return value causes kernel panic.
- [High] Memory and resource leak of key references.
- [High] NULL pointer dereference when invoking `map_get_hash`.
- [High] State corruption via shared BPF map security blob causes denial of=
 service.
- [High] Runtime map verification loop logic allows integrity check bypass.
- [High] File descriptor TOCTOU race condition in `hornet_bpf` hook.
- [Medium] Subsystem guideline violation: Mixing scope-based cleanup with g=
oto.
- [Medium] Out-of-bounds read in `hornet_map_index()` when `vlen =3D=3D 0`.
- [Medium] Off-by-one error in `hornet_next_map()` rejects valid signatures.
- [Low] Unchecked allocation size causes memory allocation warnings.
--

commit 6fbe5a3d726790559c6e3d3f0367735ef6beae27
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

security: Hornet LSM

This commit adds the Hornet Linux Security Module to provide enhanced
signature verification and data validation for eBPF programs. It verifies
PKCS#7 signatures on eBPF bytecode and associated map hashes at load time,
and re-verifies map hashes before execution.

> diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
> new file mode 100644
> --- /dev/null
> +++ b/security/hornet/hornet_lsm.c
[ ... ]
> +static int hornet_verify_hashes(struct hornet_maps *maps,
> +				struct hornet_parse_context *ctx,
> +				struct bpf_prog *prog)
> +{
> +	int map_fd;
> +	u32 i;
> +	struct bpf_map *map;
> +	int err =3D 0;
> +	unsigned char hash[SHA256_DIGEST_SIZE];
> +	struct hornet_prog_security_struct *security =3D hornet_bpf_prog_securi=
ty(prog);
> +	struct hornet_map_security_struct *map_security;
> +
> +	for (i =3D 0; i < ctx->hash_count; i++) {
> +		if (ctx->skips[i])
> +			continue;
> +
> +		err =3D copy_from_bpfptr_offset(&map_fd, maps->fd_array,
> +					      ctx->indexes[i] * sizeof(map_fd),
> +					      sizeof(map_fd));
> +		if (err < 0)
> +			return LSM_INT_VERDICT_FAULT;

Because copy_from_bpfptr_offset() returns the number of uncopied bytes
(a positive integer) upon failure, does this if statement fail to catch
a failed copy? If the copy fails, it seems map_fd could remain
uninitialized when passed to CLASS(fd, f)(map_fd) below, resulting in
an arbitrary file descriptor lookup.

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

Does this code safely handle map types that do not implement the
map_get_hash callback? Many standard BPF map types (like
BPF_MAP_TYPE_PROG_ARRAY) do not implement this. Providing a signature
for such a map type might result in a NULL pointer dereference.

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

Is it possible for state corruption to occur here since BPF maps can be
shared across multiple eBPF programs?

If a second program loads and verifies the same map, it appears it would
overwrite map_security->index with its own signature index. When the
first program is later executed, hornet_verify_map() would see a mismatch,
potentially causing a denial of service regression for the first program.

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
> +		return -EINVAL;

Could this unintentionally reject valid signatures that use exactly 64
maps? Because MAX_USED_MAPS is 64, incrementing the count for the 64th
map makes the condition true, returning -EINVAL.

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

Are we missing a check for vlen =3D=3D 0 here? If a malformed signature
specifies an integer length of 0, it looks like this could read one
byte out of bounds from the value pointer.

> +	return 0;
> +}
[ ... ]
> +static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *a=
ttr,
> +				struct bpf_token *token, bool is_kernel,
> +				enum lsm_integrity_verdict *verdict)
> +{
> +	struct hornet_maps maps =3D {0};
> +	bpfptr_t usig =3D make_bpfptr(attr->signature, is_kernel);
> +	struct pkcs7_message *msg;
> +	struct hornet_parse_context *ctx;
> +	void *sig;
> +	int err;
> +	const void *authattrs;
> +	size_t authattrs_len;
> +	struct key *key;
> +
> +	if (!attr->signature) {
> +		*verdict =3D LSM_INT_VERDICT_UNSIGNED;
> +		return 0;
> +	}
> +
> +	ctx =3D kzalloc(sizeof(struct hornet_parse_context), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	maps.fd_array =3D make_bpfptr(attr->fd_array, is_kernel);
> +	sig =3D kzalloc(attr->signature_size, GFP_KERNEL);

Since attr->signature_size is a user-controlled value, could a very
large size intentionally trigger kernel memory allocation warnings
(OOM splats)? Should this use __GFP_NOWARN or enforce an upper limit?

> +	if (!sig) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
> +	err =3D copy_from_bpfptr(sig, usig, attr->signature_size);
> +	if (err !=3D 0)
> +		goto cleanup_sig;

Similar to the map copy check earlier, copy_from_bpfptr() returns a positive
integer on failure. This causes hornet_check_program() to return a positive
value when the copy fails.

Looking at hornet_bpf_prog_load_integrity(), it checks if the result
is less than zero:

static int hornet_bpf_prog_load_integrity(...)
{
        enum lsm_integrity_verdict verdict;
        int result =3D hornet_check_program(prog, attr, token, is_kernel, &=
verdict);

        if (result < 0)
                return result;

        return security_bpf_prog_load_post_integrity(prog, attr, token, is_=
kernel,
                                                     &hornet_lsmid, verdict=
);
}

Could this result in proceeding to security_bpf_prog_load_post_integrity()
with an uninitialized verdict variable? If the stack memory happens to
hold LSM_INT_VERDICT_OK, it seems signature verification would be fully
bypassed.

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

If lookup_user_key() fails (for example, due to an invalid ID or
permission denied), it returns an error-encoded key_ref_t.

Since IS_ERR() is not used to check the return value, could this pass an
invalid pointer through key_ref_to_ptr() and subsequently to
verify_pkcs7_message_sig(), potentially causing a panic?

Also, when lookup_user_key() successfully finds a key, it increments its
usage count. Is there a missing key_put(key) to drop this reference before
the function returns? Without it, repeated calls could leak struct key
objects.

[ ... ]
> +static int hornet_check_prog_maps(u32 ufd)
> +{
> +	CLASS(fd, f)(ufd);
> +	struct bpf_prog *prog;
> +	int i, result =3D 0;

This isn't a bug, but using CLASS(fd, f) alongside a goto-based error
handling pattern appears to violate the cleanup guidelines, which
suggest converting all resources to scope-based cleanup or none of them
to prevent inconsistent resource management.

> +
> +	if (fd_empty(f))
> +		return -EBADF;
> +	if (fd_file(f)->f_op !=3D &bpf_prog_fops)
> +		return -EINVAL;
> +
> +	prog =3D fd_file(f)->private_data;
> +
> +	mutex_lock(&prog->aux->used_maps_mutex);
> +	if (!prog->aux->used_map_cnt)
> +		goto out;
> +
> +	for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
> +		result =3D hornet_verify_map(prog, i);

Does using the loop counter i as the signature index for hornet_verify_map()
allow bypassing the integrity check for some maps?

The number of used maps doesn't seem to have a fixed relation to the
signature's map sequence length. If a map was verified at load time with a
signature index greater than or equal to used_map_cnt, it appears this loop
would never call hornet_verify_map() for that index, allowing the map
contents to be modified after loading.

> +		if (result)
> +			goto out;
> +	}
> +out:
> +	mutex_unlock(&prog->aux->used_maps_mutex);
> +	return result;
> +}
> +
> +static int hornet_bpf(int cmd, union bpf_attr *attr, unsigned int size, =
bool kernel)
> +{
> +	/* in horent_bpf(), anything that had originated from kernel space we a=
ssume
> +	   has already been checked, in some form or another, so we don't bother
> +	   checking the intergity of any maps. In hornet_bpf_prog_load_integrit=
y(),
> +	   hornet doesn't make any opinion on that and delegates that to the do=
wnstream
> +	   policy enforcement. */
> +
> +	if (cmd !=3D BPF_PROG_RUN)
> +		return 0;
> +	if (kernel)
> +		return 0;
> +
> +	return hornet_check_prog_maps(attr->test.prog_fd);

Is there a race condition here between the security check and the actual
execution in the syscall?

The hook resolves attr->test.prog_fd, performs checks, and then drops the
file descriptor reference before returning. The bpf() syscall will then
resolve the file descriptor again.

Could a concurrent thread use dup2() to overwrite attr->test.prog_fd
with an unsigned BPF program in the window between the check and the
execution?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416173500.1767=
16-1-bboscaccy@linux.microsoft.com?part=3D6
