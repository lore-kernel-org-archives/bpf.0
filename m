Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C14594A
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470151; cv=none; b=Z/K6o8Wj6fvcLu2djhdS0QK6SPA4bZZX5gRuKX7HTaISHcpsWJze1s+cvYek94YkgeZZtDWTuR5k0dICINArPj7u31EwSavDAre5eq9Yyn0nSHxm/gcPevGAcfxsBz7n+iALJxw4ti2SAUdeBt7dDv+WyCHjXgauJ4+5AxAJgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470151; c=relaxed/simple;
	bh=hwRPTP7+cSEAXQjFByNdVpSp7+nQLHgl9HeDdBHvsFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N0yDClBOKlNhr5KozDNHMPv181eviDTILnrNMbe9+b1negu13JiAuoWyrRf6mRUrxVr/ydAHVYSU/yRsWsjm/5SpWhWzC8uiepDQ73jnkuy5rz06jmb/YDuJuwxMMxgpSGElFUanCej020PsA8qApYReMS4HbOaFGC6IOLYAIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noaJD86U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noaJD86U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6E81F000E9;
	Sun, 19 Jul 2026 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784470150;
	bh=y/oDXVHVkLHtXFGiJ4fVICZEfdiS/qE2Wes8UC51o/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=noaJD86UPATXFSq0NLJtr/k9TOlpx5jVphc2gUMpcoNS2Q8gXF98O+ySCPW2u6DJi
	 XgAyPcomQJ7yvjX9B1AwgczJhTLm2QZawQgw7j+PPp8cGYwZehaNrubYUi+NQ+zEm1
	 pZUFUpIMBaO7Gr4EtONnv9SUYQPhZfyiRj2kRAXzIhftmkfGB989BnVCDvG51Lw1O2
	 H7rQY+BBf3uKxgpb4gEtNZ0rud8VyP71lI0jBp1d21ULuWMvCDoaNZzEbuk6zwBrCG
	 yF//+uCMAYcPuQzYB83tjAWztlLh3dFd5ok1nOYFyUSiZjomtWcbVh6/1i/v1neLea
	 WVxogpdgczT5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/2] bpf: Fix is_tracing_prog_type() to
 cover fentry/fexit/fmod_ret
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260719113551.1294284-3-memxor@gmail.com>
References: <20260719113551.1294284-1-memxor@gmail.com>
 <20260719113551.1294284-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 14:09:09 +0000
Message-Id: <20260719140909.ED6E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Tracing programs can bypass the bpf_spin_lock restriction using bp=
f_map_update_elem() with BPF_F_LOCK, leading to per-CPU IRQ state corruptio=
n.
- [Medium] EXT programs extending iterators are incorrectly classified as t=
racing programs, restricting them from using spin locks, lists, and rbtrees.

Pre-existing issues:
- [High] Kernel warning and memory leak in `bpf_obj_free_fields` when freei=
ng map elements containing lists or rbtrees protected by `bpf_res_spin_lock=
`.
--

--- Patch [2]: [PATCH bpf-next v1 2/2] bpf: Fix is_tracing_prog_type() to c=
over fentry/fexit/fmod_ret ---
commit 94d71df738bb27d6ad27a15a0ce402fd7032420d
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Fix is_tracing_prog_type() to cover fentry/fexit/fmod_ret

This patch tightens the tracing program type checks and delays the evaluati=
on
of map spin lock and list restrictions to the point of use rather than duri=
ng
map compatibility checks.

> Fix this by tightening the check, and moving predicates checking for the
> restriction closer to the point of use. This change might affect
> existing programs using them in unsafe contexts, but in such cases, it
> is recommended for users to switch over to bpf_res_spin_lock instead.

[Severity: High]
This is a pre-existing issue, but recommending users switch to
bpf_res_spin_lock exposes an issue in bpf_obj_free_fields() when freeing
map elements containing lists or rbtrees.

When btf_parse_fields() encounters BPF_RES_SPIN_LOCK, it sets
res_spin_lock_off but leaves spin_lock_off as -EINVAL:

kernel/bpf/btf.c:btf_parse_fields() {
    ...
    rec->spin_lock_off =3D -EINVAL;
    rec->res_spin_lock_off =3D -EINVAL;
    ...
}

Later, bpf_obj_free_fields() unconditionally checks spin_lock_off:

kernel/bpf/syscall.c:bpf_obj_free_fields() {
    ...
    if (WARN_ON_ONCE(rec->spin_lock_off < 0))
        continue;
    ...
}

Could this trigger a WARN_ON_ONCE and leak memory for list/rbtree nodes
because the check skips the freeing logic when a bpf_res_spin_lock is
used instead of a standard bpf_spin_lock?


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17769,9 +17780,11 @@ static int check_pseudo_btf_id(struct bpf_verifi=
er_env *env,
[ ... ]
> -static bool is_tracing_prog_type(enum bpf_prog_type type)
> +static bool is_tracing_prog_type(struct bpf_prog *prog)
>  {
> -	switch (type) {
> +	switch (resolve_prog_type(prog)) {
> +	case BPF_PROG_TYPE_TRACING:
> +		return prog->expected_attach_type !=3D BPF_TRACE_ITER;

[Severity: Medium]
Does this check correctly handle extension programs (BPF_PROG_TYPE_EXT)?

For an extension program, the resolved type is BPF_PROG_TYPE_TRACING, but
its expected_attach_type is its own attach type (typically 0), not the
target's attach type which is stored in saved_dst_attach_type.

Could this cause valid extension programs that extend iterators to be
erroneously rejected by the verifier when trying to use spin locks, lists,
or rbtrees?


> @@ -17802,14 +17815,6 @@ static int check_map_prog_compatibility(struct b=
pf_verifier_env *env,
[ ... ]
> -	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
> -		if (is_tracing_prog_type(prog_type)) {
> -			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
> -			return -EINVAL;
> -		}
> -	}
> +	/*
> +	 * Restrictions on using BPF list,rbtree,spin_lock is checked later upon
> +	 * use, since rejecting accesing map containing them in programs is too
> +	 * conservative.
> +	 */

[Severity: High]
Does removing this map-level check allow tracing programs to bypass the
lock restriction using bpf_map_update_elem() with the BPF_F_LOCK flag?

While the explicit lock helper calls are now blocked in process_spin_lock(),
the BPF_F_LOCK flag bypasses those verifier checks and executes
copy_map_value_locked():

kernel/bpf/helpers.c:copy_map_value_locked() {
    ...
    __bpf_spin_lock_irqsave(lock);
    ...
}

Can this corrupt the irqsave_flags per-CPU variable when tracing programs
execute in NMI or arbitrary IRQ contexts, potentially leading to deadlocks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719113551.1294=
284-1-memxor@gmail.com?part=3D2
