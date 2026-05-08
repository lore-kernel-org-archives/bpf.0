Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF8A1F4176
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 02:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778206061; cv=none; b=p6PfsyAE4+Xx8s6bySAQZHUoSZKTH5l8JtCt/SV3Y4DbhZoSVwhS79mqiJJJvEr3DqBSirc0ppvDtbps6kODvXjBpFumIcxYrWISTXnXPqEV5BVHFqdiz3NnfYdVZz4QsyS6txYiSNRspNCIp8Rlzn17qBvaAJnPCkea84N8oC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778206061; c=relaxed/simple;
	bh=yvPrZSwAgyHjdFiVZiOmx7a+dPOpedNska5ilx9rgyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rV2MO4tcFqTVyUSZCV3zVw8Da4NC1H2VnMNcuxDOR+V0cgn9ljEft17HU1yUgP1r9NIKKZQ14XnvYHnbLbW2Yrd/SJ1+6GhOKcV6vYG6J4utuLLNPj8O0eMRbB2eFY50909ihP2cvCdK9X4Yvr5Uq0KrlMV5r5uJieyljC7Wlno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2cRf8ZG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2cRf8ZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C614C2BCB2;
	Fri,  8 May 2026 02:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778206061;
	bh=yvPrZSwAgyHjdFiVZiOmx7a+dPOpedNska5ilx9rgyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=m2cRf8ZGlZJEQkK6UyFfdObEdc4wWayLf2PP7HckwFAYJfcL8o8cMX5vC4D1Yku4D
	 aaH1hp3S2hFbujKJbAZAqQjqPFPKdNy19bVWgnwP3h4Dy/kaRvBxi09GY1gX6S2lEO
	 q1Wz+qW+O3JE8YZejLjStsQ7znD5VdX3ZXj233z0zndgh3t9FoR5Uv5E387/gM7N2D
	 adUp1en0LWaKtCLPsaks5Ic9wdqpeQIXDZS2z5oWC2OSQ+6DAqcIh/5dzY6LgTVsT2
	 ejltD48/lw+WdFa1+4hhYHSK68zIl5Eq2CcP9DiPWJUkCIPZmInC5P7fXjw0WNmVHT
	 QZ7ZA4vDkzy8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] security: Hornet LSM
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507191416.2984054-7-bboscaccy@linux.microsoft.com>
References: <20260507191416.2984054-7-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 02:07:40 +0000
Message-Id: <20260508020741.1C614C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) vulnerability during BPF=
 program load allows bypassing map signature verification.
- [High] Unbounded memory allocation with user-provided `attr->signature_si=
ze` leads to denial of service.
- [High] Arbitrary user keyring injection allows unprivileged users to bypa=
ss system-wide signature verification.
- [High] Map verification logic allows map substitution by improperly track=
ing matched hashes.
- [High] Programs signed with an empty map hash SET bypass map verification=
 entirely while receiving an OK verdict.
- [High] Runtime map verification only hooks `bpf(BPF_PROG_RUN)`, leaving n=
ormal event-driven eBPF execution unprotected against runtime map tampering.
- [Medium] Skipping a map in the signature causes valid test runs to be den=
ied with `-EPERM` if the map is frozen.
- [Medium] Off-by-one bounds check in `hornet_next_map` incorrectly rejects=
 valid signatures containing exactly 64 maps.
--

commit 33400a9d1c16d89f1fcfeabbd6450005c549df6e
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

security: Hornet LSM

This commit adds the Hornet Linux Security Module to provide eBPF signature
verification and map validation. It uses PKCS#7 signed attributes to verify
map hashes at load time and before execution.

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
> +
> +	for (i =3D 0; i < ctx->hash_count; i++) {
> +		if (ctx->skips[i])
> +			continue;
> +
> +		err =3D copy_from_bpfptr_offset(&map_fd, maps->fd_array,
> +					      ctx->indexes[i] * sizeof(map_fd),
> +					      sizeof(map_fd));

Is this susceptible to a Time-of-Check to Time-of-Use race?

Since maps->fd_array is read from userspace here, and then read again later
by the core BPF verifier, could a malicious application swap the map file
descriptor to point to an unsigned map after this verification succeeds?

[ ... ]
> +int hornet_next_map(void *context, size_t hdrlen,
> +		     unsigned char tag,
> +		     const void *value, size_t vlen)
> +{
> +	struct hornet_parse_context *ctx =3D (struct hornet_parse_context *)con=
text;
> +
> +	if (++ctx->hash_count >=3D MAX_USED_MAPS)
> +		return -EINVAL;

Does this restrict the maximum number of maps to 63 instead of the intended=
 64?

If a valid signature contains exactly 64 maps, processing the 64th map will
increment hash_count to 64, causing this check to evaluate to true and reje=
ct
the signature.

[ ... ]
> +static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *a=
ttr,
> +				struct bpf_token *token, bool is_kernel,
> +				enum lsm_integrity_verdict *verdict)
> +{
[ ... ]
> +	maps.fd_array =3D make_bpfptr(attr->fd_array, is_kernel);
> +	sig =3D kzalloc(attr->signature_size, GFP_KERNEL);

Can a user provide an extremely large signature_size to trigger an unbounded
memory allocation?

Without a bounds check on attr->signature_size, an attacker could request a
size large enough to cause the slab allocator to fail, potentially triggeri=
ng
warnings or a system panic if panic_on_warn is enabled.

> +	if (!sig) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
[ ... ]
> +	if (system_keyring_id_check(attr->keyring_id) =3D=3D 0)
> +		key =3D (struct key *)(unsigned long)attr->keyring_id;
> +	else {
> +		user_key =3D lookup_user_key(attr->keyring_id, 0, KEY_DEFER_PERM_CHECK=
);

Does this allow an unprivileged user to specify their own user keyring for
signature verification?

If an attacker signs a malicious program with their own private key and loa=
ds
it with their own user keyring ID, will Hornet successfully verify it and
return an OK verdict to downstream LSMs?

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
> +		return 0;

If a program is signed without including any map hashes, will this return
success but allow an attacker to attach arbitrary unverified maps?

Since an empty map hash SET would produce an OK verdict at load time,
returning early here bypasses runtime verification completely.

> +
> +	mutex_lock(&prog->aux->used_maps_mutex);
> +
> +	/* Verify every used_map has a matching signed hash */
> +	for (j =3D 0; j < prog->aux->used_map_cnt; j++) {
> +		map =3D prog->aux->used_maps[j];
> +
> +		if (!READ_ONCE(map->frozen) || !map->ops->map_get_hash)
> +			continue;
> +
> +		if (map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash))
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

Does this allow map substitution if multiple maps share the same hash?

Because the matched hash isn't marked as consumed, an attacker could supply
multiple copies of the same map to satisfy the covered_count check, entirely
omitting another required map.

> +		if (!found) {
> +			mutex_unlock(&prog->aux->used_maps_mutex);
> +			return -EPERM;

If a valid signature explicitly skips a map using a zero-length SHA, but the
map happens to be frozen, will this incorrectly reject the execution?

Skipped maps are not added to signed_hashes at load time, so this loop will
fail to find the hash and return -EPERM, breaking execution for valid progr=
ams.

[ ... ]
> +static int hornet_bpf(int cmd, union bpf_attr *attr, unsigned int size, =
bool kernel)
> +{
> +	/* in horent_bpf(), anything that had originated from kernel space we a=
ssume
> +	 * has already been checked, in some form or another, so we don't bother
> +	 * checking the intergity of any maps. In hornet_bpf_prog_load_integrit=
y(),
> +	 * hornet doesn't make any opinion on that and delegates that to the do=
wnstream
> +	 * policy enforcement.
> +	 */
> +
> +	if (cmd !=3D BPF_PROG_RUN)
> +		return 0;
> +	if (kernel)
> +		return 0;
> +
> +	return hornet_check_prog_maps(attr->test.prog_fd);
> +}

Does hooking only the BPF_PROG_RUN command leave normal event-driven eBPF
executions unprotected?

Programs like XDP, TC, or kprobes execute asynchronously in response to ker=
nel
events and bypass the bpf() syscall entirely. Will this allow runtime map
tampering for these workloads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507191416.2984=
054-1-bboscaccy@linux.microsoft.com?part=3D6
