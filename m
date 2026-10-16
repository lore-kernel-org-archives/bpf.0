Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340D4825D4
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161155; cv=none; b=X65Mg4sKU3BDhwN5lhoeeHo+/Rz/zZAOOa/64aNOlqqQN60yfZPs7E+VicVCogBEPsduGIHzwl297QG5BPQWRchw2Dfq0exiSxlpecV+t29wyrNgQ9sXtRNBqssfVQqjUnAi3aYdMHGXBlbA9cczLeCCKSTZGbuyTkcOvy+N2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161155; c=relaxed/simple;
	bh=VVNakDMTxzMJn2n2gE2ACK0ulY/jgAeUFh5PVPReGLs=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=b4lumRoPX7w+KKf3MydO63AzuT9lgJ7SHr3kbL5sb1As2PJ7C8twmSSBu1OVuDTYlspXQLv2GMPf6RdXJugVvNZb2fWbnywA18zCyerPUS2bM+GeV9hZQHxSjXzVtnzt8KxQunRA7upYDKsBof3r+XXu5XCEZBm1fw2UdYYTKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLGmIyq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLGmIyq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9561F000C4;
	Fri, 16 Oct 2026 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792161153;
	bh=woOGb239pK8VI+KKr4DHfDE0SdXZrpkfLbA8LoA5MFA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MLGmIyq4J/mb83MxoCKxwMWheWWCJRCytI0e0YgbO2dFv9AASKIFer4I0oTZ6PiI5
	 zOq35K2GrUKJOWjC0dlEoOuH6A75d18FyMM5zrrD6wXeriCZDR34WKQnmuMSEg3gn+
	 eeKX4gXb999UhqwD1fWo7DKG7MwPhZ+u+knNw4U8UtJ1S66ymA5bBNBTjU6BQpsMm9
	 JLsMTc2yExeq6JHKYbkQhjOW1BzeWP9UrDfPYSXnOVyDwtLbJmYt2wLZlh/YtgnV0w
	 6IHQrIONDnD2UM+vrKNiMOqnRQsrP7I+6FHhhP4TlZROQTVQmY68JQKLwt/MNm6P0Y
	 oHuZ5sx/Zogsg==
Message-ID: <sashiko-outbox-174460@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Initialize ftrace_managed in
 bpf_trampoline_get()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261016142014.12420-2-leon.hwang@linux.dev>
References: <20261016142014.12420-1-leon.hwang@linux.dev>
 <20261016142014.12420-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 14:32:32 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: dummy trampoline causes ftrace_managed text corruption
--

commit df0c3beb4928ce14ffbe4b44e2bc365c2a470352
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Initialize ftrace_managed in bpf_trampoline_get()

This patch removes the dynamic ftrace_location() check from
register_fentry() and instead initializes ftrace_managed in
bpf_trampoline_get() based on whether tr->ip is non-zero.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 24edb59238f34..17f2a8133f611 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -475,18 +475,11 @@ static int register_fentry(struct bpf_trampoline *t=
r, struct bpf_tramp_image *im
>  			   void *data __maybe_unused)
>  {
>  	void *new_addr =3D im->image;
> -	void *ip =3D tr->func.addr;
> -	unsigned long faddr;
>  	int ret;
> =20
> -	faddr =3D ftrace_location((unsigned long)ip);
> -	if (faddr) {
> +	if (tr->func.ftrace_managed) {
>  		if (!tr->fops)
>  			return -ENOTSUPP;
> -		tr->func.ftrace_managed =3D true;
> -	}
> -
> -	if (tr->func.ftrace_managed) {
>  		ret =3D direct_ops_add(tr, new_addr);
>  	} else {
>  		ret =3D bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);

[Severity: High]
Because ftrace_managed is no longer evaluated dynamically here, is there a
risk of corrupting ftrace-managed text if tr->func.ftrace_managed was
incorrectly cached as false?=20

If it evaluates to false, register_fentry() falls back to=20
bpf_trampoline_update_fentry() which does raw text poking.

[ ... ]

> @@ -1286,6 +1279,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
> =20
>  	memcpy(&tr->func.model, &tgt_info->fmodel, sizeof(tgt_info->fmodel));
>  	tr->func.addr =3D (void *)tgt_info->tgt_addr;
> +	tr->func.ftrace_managed =3D tr->ip !=3D 0;
>  out:
>  	trampoline_unlock(tr);
>  	return tr;

[Severity: High]
Can this assignment incorrectly mark a ftrace-managed target as non-managed
if a concurrent operation creates a dummy trampoline?

If bpf_trampoline_unlink_cgroup_shim() is called for a program that was
never successfully linked to a trampoline, it calls
bpf_trampoline_lookup(key, 0). Since the trampoline doesn't exist, a dummy
trampoline with tr->ip =3D 0 is temporarily created.

If a concurrent bpf_trampoline_get() targets the same hook during this
window, it finds the dummy trampoline. With this change, it will cache
tr->func.ftrace_managed as false because tr->ip is 0, regardless of the
actual target address.

When register_fentry() then runs, it bypasses direct ops and uses raw
bpf_arch_text_poke() on the address. Could this cause kernel text
corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016142014.1242=
0-1-leon.hwang@linux.dev?part=3D1
