Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D33264E7
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782572661; cv=none; b=Nj0IThK/WnnmNzkf71k1YradBFaR0yfbM253F4+q9Qw+/3whDn0nfFhJJT5ccvcfNQ6ltbOxXksjtdrtY01D3HkfgVHpSQ6kYnJ6RqIaqtyfimeCp4IUGkZ28QI7HTzdOfivWirfoyf8W2S2yzP1cHdTuuTRBHsdHINE78/+AO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782572661; c=relaxed/simple;
	bh=eQQLJLEXxxcrYmbKxuUGJghtd/Aa81gccc2d2DzyEUM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iVdYs6dqh4znZNxbfRjH1Q2JiU4zayLcijN5bbVAJuuOnFtblphXmGtN6geMNqZOitgTQzMD6Byt6QYmynAaQDoR/9QTJ08xWtr9suOaGz7yaEEvY8cPxwTF7C+cc2sAtdks2WneKxEj8e8xmQ6UwdAia1NRWGBGL0UDtPBswBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InzT+zdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InzT+zdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E1B1F000E9;
	Sat, 27 Jun 2026 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782572659;
	bh=1EwifvZMA9+XI453MBtkeb5uQReCyrbuES+mIO+ZOtw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=InzT+zdE0hVkaSTkmLCj3+s2NjNQptyNdf2sKpZSJBFcsPYWN/UAVsGUKEIOTKqel
	 SzFtgHzFH5cIVA1Ht9qA9jO1rwE6lN/XYxh0Me/udCix1H0rZkFnCKPRti6Ah5YDfm
	 N1BXfjJT7tr/c77gS2VxTCFSjgfBUOVqTyUkktJfdtMCpOIx8CQh9aOG/8KNzgc5Tn
	 AMd7BN26XlofUlVy7+Tl5QDqMZizuiZKLTeiEbH6z/iGPKYokat2rSCC+Ox4Og4+xC
	 fWJGFc9pj/rC2BJz5LER79PFZuHLOtNuC/sB8S4XcsejqcR0pPbOJIpb/OvJ1tUDTL
	 v7FuqA9cGu72g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 06/12] bpf: Add type check for SDT probe
 site
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <d20d2be69ab6bfa5f81c249bf54c2d47558d239e.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <d20d2be69ab6bfa5f81c249bf54c2d47558d239e.1782571533.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 15:04:18 +0000
Message-Id: <20260627150418.E0E1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Out-of-bounds read of the verifier state `regs` array in `check_sd=
t_probe` due to unvalidated `val->arg_reg[i]`.
- [High] Missing validation of constant offset for `PTR_TO_BTF_ID` argument=
s in `check_sdt_probe` leading to type confusion.
- [Medium] Out-of-bounds read in `compute_insn_live_regs` due to unvalidate=
d `sdt->nargs`.
- [Medium] If `bpf_insn_array_init` fails during SDT probe validation, it l=
eaves the map permanently locked (`used =3D 1`).
--

commit 1e24bd6e76a99cfb094092a5071e910e30cca308
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Add type check for SDT probe site

The NOP instruction at SDT probe site will be patched to a call
instruction to observer programs. To ensure the arguments passed
to observers are as expected, add type check for bpf SDT probe site.

> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> index aca8676ab5633..fe30b08712fff 100644
> --- a/kernel/bpf/bpf_insn_array.c
> +++ b/kernel/bpf/bpf_insn_array.c

[ ... ]

> @@ -224,6 +227,15 @@ int bpf_insn_array_init(struct bpf_map *map, const s=
truct bpf_prog *prog)
>  	for (i =3D 0; i < map->max_entries; i++)
>  		values[i].xlated_off =3D values[i].orig_off;
> =20
> +	if (insn_array->subtype =3D=3D BPF_INSN_ARRAY_SUBTYPE_SDT) {
> +		for (i =3D 0; i < map->max_entries; i++) {
> +			insn =3D &prog->insnsi[values[i].orig_off];
> +			if (insn->code !=3D (BPF_JMP | BPF_JA) || insn->off !=3D 0)
> +				return -EINVAL;

[Severity: Medium]
If the instruction check fails and returns -EINVAL here, does it leave
the map permanently locked?

Earlier in bpf_insn_array_init() we do:

	if (atomic_xchg(&insn_array->used, 1))
		return -EBUSY;

If we return -EINVAL without clearing this flag or adding the map to
env->insn_array_maps for standard cleanup, it seems the map will remain
unusable. Should this error path clear the used flag?

> +			env->insn_aux_data[values[i].orig_off].sdt_entry =3D &values[i];
> +		}
> +	}
> +
>  	return 0;
>  }

[ ... ]

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 0aadfbae0acc5..50ab8c29c0ebd 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -2163,10 +2164,27 @@ static void compute_insn_live_regs(struct bpf_ver=
ifier_env *env,
>  		switch (code) {
>  		case BPF_JA:
>  			def =3D 0;
> -			if (BPF_SRC(insn->code) =3D=3D BPF_X)
> +			if (BPF_SRC(insn->code) =3D=3D BPF_X) {
>  				use =3D dst;
> -			else
> +			} else if (env->insn_aux_data[insn_idx].sdt_entry) {
> +				struct bpf_insn_array_value *sdt;
> +				int i;
> +
> +				/*
> +				 * Without marking the argument registers arg_reg[]
> +				 * as live, the liveness pass would clear them before
> +				 * the probe site, causing check_sdt_probe() to reject
> +				 * the prog with "arg is uninitialized".
> +				 */
>  				use =3D 0;
> +				sdt =3D env->insn_aux_data[insn_idx].sdt_entry;
> +				for (i =3D 0; i < sdt->nargs; i++) {
> +					if (sdt->arg_reg[i] < BPF_REG_FP)
> +						use |=3D BIT(sdt->arg_reg[i]);
> +				}

[Severity: Medium]
Can this loop read out of bounds of the arg_reg array?

The sdt->nargs value is provided by userspace and doesn't appear to be
validated prior to this liveness pass. Since arg_reg is defined as a
5-element array in struct bpf_insn_array_value, a malicious userspace
program could provide a large nargs value, causing this loop to read past
the end of arg_reg and corrupt the verifier's liveness state.

Should we validate sdt->nargs against the maximum allowed arguments
before iterating?

> +			} else {
> +				use =3D 0;
> +			}
>  			break;

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 05734163650a7..bc972beb80cf4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +static int check_sdt_probe(struct bpf_verifier_env *env, int insn_idx)
> +{

[ ... ]

> +	frame =3D env->cur_state->frame[env->cur_state->curframe];
> +	regs =3D frame->regs;
> +
> +	for (i =3D 0; i < val->nargs; i++) {
> +		u8 reg =3D val->arg_reg[i];
> +		struct bpf_reg_state *rs =3D &regs[reg];

[Severity: High]
Could this lead to an out-of-bounds read on the verifier's regs array?

The val->arg_reg[i] values come directly from a BPF_MAP_TYPE_INSN_ARRAY
populated by userspace. If a user provides an index larger than or equal to
MAX_BPF_REG, regs[reg] will access memory past the end of the regs array in
the bpf_func_state structure, potentially causing a kernel panic.

Does val->arg_reg[i] need a bounds check against MAX_BPF_REG before
it is used as an index?

> +
> +		if (rs->type =3D=3D NOT_INIT) {
> +			verbose(env, "SDT arg%d (r%d) is uninitialized\n", i, reg);
> +			return -EINVAL;
> +		}
> +	}
> +

[ ... ]

> +		if (base_type(rs->type) !=3D PTR_TO_BTF_ID) {
> +			verbose(env, "SDT arg%d (r%d) type %s expected PTR_TO_BTF_ID\n",
> +				i, reg, reg_type_str(env, rs->type));
> +			return -EACCES;
> +		}
> +
> +		if (!btf_struct_ids_match(&env->log, rs->btf, rs->btf_id,
> +					  rs->var_off.value, btf, arg_btf_id, false)) {

[Severity: High]
Is it safe to pass rs->var_off.value directly without ensuring the offset
is constant?

If a BPF program adds a variable offset to a PTR_TO_BTF_ID register,
rs->var_off.value will just represent the lower bound or known bits of
that offset. Without enforcing tnum_is_const(rs->var_off), the verifier
might accept a variable-offset pointer as if it points to the base object.

Could this cause type confusion or out-of-bounds reads in the observer
program? Should we verify the offset is strictly constant first?

> +			verbose(env, "SDT arg%d (r%d) btf_id %u does not match expected %u\n",
> +				i, reg, rs->btf_id, arg_btf_id);
> +			return -EACCES;
> +		}
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782571533.gi=
t.xukuohai@huawei.com?part=3D6
