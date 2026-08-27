Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B392472AF
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813760; cv=none; b=Lbq2RnpfsbaNjr5rkUejUABjXmtRGjKcRw1ouAzHOAyW+cmqmtOi2Znj9MVc3JD8a/89cxgXYp6BVzJ36d0cKbe6tmZ1EOl6UELF4YYqwYQ/7kjiWE5vUQBAWPSt7DGb+4yfPg8dHrcngaxUFifbcaykUqXbWegxVgxWNVLI/Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813760; c=relaxed/simple;
	bh=8hVjcoE58iN1UrTaL5fymoZ6PmbryInRE1jDSn6eGq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DC8uBJ6s2wnApUjDJI5L1Un6y0ZmoVGKA/ZPCCTAEasBlrE82oUPUNHh8C2zkMhoCrzNMsNd7XfWbKIyjUx3QoceJpYstalznHAPdbwUkigxlRtMacKeQklMbzoNVzvyjfIWqwtbtX7uL/E3j9cImoxp9DvQG/SfT+xmqXu7DDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT1xBL5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT1xBL5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91891F000E9;
	Thu, 27 Aug 2026 06:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787813759;
	bh=n7HJ0fplpDCZadPjTD7tydhImbBObr9dssh1OGKl22Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mT1xBL5RaTrPsbzlAGC22WwtOncXkVLB4mrmEhXRe21PUY7jrS15r/gNKN8GidWVB
	 wjMXeiq8ifZVU64/vsZYeGP6+ydkMgUyI/zXJo05CopWmYolIn7qdWKLRdMH0vIR1N
	 MbLzhjcF3hcfy6C/SWoTITSeZ0Lrq3SlNO5S06FoEw1okB1QE61yN2GULHCTQyvRqs
	 wAYWBLWx6OETp+1QNlCElLPUIOnoRHwxZIsoXLxNQOtaS5mt7dhIl8/vHizUk3uDz4
	 S/zl1pJdF6Up9WV5LJ5Vz3qAuz7m8Q4LfqWgjcS5vhizQ+6pfFrsSXpO2Cgt7wdlfU
	 fnyeEaH7Eqnhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 07/11] bpf: Allow arena pointers in a
 by-value kfunc return
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260827061150.2518572-1-yonghong.song@linux.dev>
References: <20260827061114.2514603-1-yonghong.song@linux.dev>
 <20260827061150.2518572-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 06:55:58 +0000
Message-Id: <20260827065558.C91891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kfuncs returning structs by value can leak uninitialized kernel st=
ack memory via struct padding.
--

commit a43266e4517bac02a4bb85149655178eefda72ad
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Allow arena pointers in a by-value kfunc return

This commit allows by-value struct returns from kfuncs to contain arena
pointers, in addition to scalars. An arena pointer has no provenance to lose
and can be cast by the program, so returning it as a scalar is safe.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 967ad010b3222..9a36808136c9a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14119,13 +14119,17 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
> =20
>  		/*
>  		 * The returned struct comes back as raw register bits modeled
> -		 * as an unknown scalar, so it must contain only scalars:
> -		 * otherwise a pointer field would be laundered into a scalar
> -		 * and escape provenance and reference tracking.
> +		 * as an unknown scalar, so a pointer member would be laundered
> +		 * into a scalar and escape provenance and reference tracking.
> +		 * Only scalars and arena pointers are allowed: an arena pointer
> +		 * has no provenance to lose, since a program may already derive
> +		 * one from any scalar with addr_space_cast(), which confines the
> +		 * result to the arena.
>  		 */
> -		if (!btf_struct_member_walk(env, desc_btf, t, BTF_MEMBER_SCALAR, 0, &p=
ath)) {
> +		if (!btf_struct_member_walk(env, desc_btf, t,
> +					    BTF_MEMBER_SCALAR | BTF_MEMBER_ARENA_PTR, 0, &path)) {

[Severity: High]
This is a pre-existing issue, but does returning structs by value from kfun=
cs
leak uninitialized kernel stack memory via struct padding?

When a BPF program calls a kfunc that returns a struct by value (up to 16
bytes) containing padding bytes, the C compiler leaves the padding bytes
uninitialized in the return registers (e.g., RAX/RDX on x86-64).

The verifier's check_kfunc_call() processes this using btf_struct_member_wa=
lk()
which ignores padding. The code then calls mark_kfunc_ret_regs() which
unconditionally marks the entire return registers as fully initialized
scalar values:

kernel/bpf/verifier.c:mark_kfunc_ret_regs() {
    ...
    mark_reg_unknown(env, regs, ret_regs[0]);
    if (nregs =3D=3D 1)
        return nregs;

    for (i =3D 1; i < nregs; i++) {
        mark_reg_unknown(env, regs, ret_regs[i]);
    }
    ...
}

Can a BPF program then read these registers and exfiltrate the uninitialized
padding bytes (e.g., via BPF maps)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827061114.2514=
603-1-yonghong.song@linux.dev?part=3D7
