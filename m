Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FFF480335
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283904; cv=none; b=sPos0EAvFk7MUNxRD/XMoN7N/RT0FlNe1iJsZXm+A4d8mTummiAmZJWAn/JzsKOH0usPo0itwqahMj/4TRNebZ0zVHhbYbzO7wkBBShww9IXJG6i2W+YcyiVSqnOUpOW1hNyJOgBrLlRS0XSt9HYsq2C0QIrV2xbEu0r5lHLxMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283904; c=relaxed/simple;
	bh=HJ2xIbh0oWTdMH0REN3APnwAa2RPG5tjkFhvKB4UGcc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Oy4aLrtF+8Q74yftJh58dS9pNoPz30U+v8cNyufZFHpEcXb7rS/rmiCggNhgd/sRQLcVXT81d3GMAg7eYLuiaUqwy9z8yEdqPvNXSnZX1yrHuZUEcaIFsVpRFvmkWHfNI/CgirXrKSxR95ZmDu4/YY+mINgkxdm1dP7wz8URhcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG3rKKex; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG3rKKex"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0af40d240so183533a91.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 14:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790283902; x=1790888702; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5lxSVXCMELqqjPBNPKdm/yFxvm4MjMRUQX7vr9/r/Vw=;
        b=JG3rKKex3wvKYt2ACrNo7dM4llJU68KQchx/qHAbjyMeBPPyxMIl7p6mlv5VWLDOf7
         LoXuqjKUwn9j/YppQtgQvoqu/zcq0rJ1rrPXc7K0Wob7vW9O091WxnD21BkEGQIvtxIJ
         8XabGCzMB80BCk3Wavdmdt5ZmPf/15ZmN/R+hpaghVawqQI8Hcl+QFYcaabwbEC9Z56s
         IXyvQDT46aQp1am/7FGaRBwm1B2XpGCPk0ntZlNidn/itjEQYjF6w2VXVSgrCqtNi/ah
         NbHt8aB3/f8yVQw/MkZoFWV0wq9Ha+j8utNZ7692RZVbn0KD5VIIExg0/f3qu/uq64Aj
         WZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790283902; x=1790888702;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5lxSVXCMELqqjPBNPKdm/yFxvm4MjMRUQX7vr9/r/Vw=;
        b=fljnNmD9ofT4frBJ/udU5KE3P18kGfkGTYnwTP/ZQR+9dUsvMNI6Zk8+k8s0qkilYf
         ounEwyrKM73qtCFEHsUNKwu1eDGeBHVOkgniqhB9KiMw7zKe9lU9V8mXl0Ico5QSMq/v
         DK4DcsxlEFJ/QCfhw9HEg8IxxqrEwQXPYfZ3bf7v/h1I0yGkoh1TYiX8hQpCLI8egYhv
         saZjZZ6iCoyD+hAKoMexjN1I3bd2Zf3nuEk08OtiT2D/qtiuvb+pE0/OTDCGlf2NG0fc
         UFSJBdbPEdPBypZUJn3EIfBGn/zwLDrbqeOmMneZkV+ex/O/qPkMammm4KhZ4g3GPLjF
         n94g==
X-Forwarded-Encrypted: i=1; AKwUvBx6nvowdU8CHFV5k4515FhENQWYLm2aoXndiaEdN6IrW1bvxdivNCwmmNMLOhGTCQIcb/4=@vger.kernel.org
X-Gm-Message-State: AFuF++l4+5OtwySo0oi/rUR45Of5z/X6IWt7PbLApC9ASWJSTLhr5Bzz
	nDNjEluN6B2R7tvcnZ4O/7+6w1en8Ku83hJwGnqt1GtvQN65KF/TdiZq
X-Gm-Gg: AYBFou2dHC+aFgwhBdr0p9zBxFZHSRdFy/hBXHEEM1alFrw1Ugd2axcA6kQyshPbzX6
	RRAMoyZS0o5R4H7+7K2gc5MZxweogNZ6vAl0NzM1w2L+/pqSvuLuOi0GcaFoYfXmXkUnb1KbLan
	CRJZV5NZr2EqIHtkWBTf7U2EflJYSNTDQPkqqPewK5+sBGz6rbhpTZrrq0AhFD3rmlCtVjUyhj9
	FfgHC46LHRRQK9vi/24JXZPI/t+5KlajujfmwgIBT7Kfx7e1CKSQ80WbhsJbFfSbSfvQWh0i8Ug
	Z15pe/HyxniPsHKTImr6IXvaEyTtlxxMv2rxfzbUa3zB2XDadUZNpwoHR2kEmWdtdETOCKgXEB2
	/LqPVTvF96k5Cs04nx+brt6ClEF0trZ+2Emgv5HhR2YShmX9ipHRFDooGHcx6W3Vq4W6cWyEHJM
	sd78RliqfEvFoPiRq9BCCAOvM6XbsCa1psJujs/yptAaU5JhiJE1/WcXFLekVcmd6UxqSI/nG0K
	/53R5SqGHahizbL5jSoBQMof3xd2x5M95ExDBphFNnNeWUqApH1UtyCVXIAiCuwFvlP0cN32fLZ
	1zs=
X-Received: by 2002:a17:90b:3d89:b0:3a0:9640:803e with SMTP id 98e67ed59e1d1-3a09853e39cmr3361122a91.7.1790283901935;
        Thu, 24 Sep 2026 14:05:01 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c8f8dsm6796781a91.12.2026.09.24.14.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 14:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 21:05:00 +0000
Message-Id: <DLNUODSRIPTF.1MRZX3443BJ19@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 6/7] bpf: Correct Program Structure
 diagnostic context
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260924092941.3174809-1-memxor@gmail.com>
 <20260924092941.3174809-7-memxor@gmail.com>
In-Reply-To: <20260924092941.3174809-7-memxor@gmail.com>

On Thu Sep 24, 2026 at 9:29 AM UTC, Kumar Kartikeya Dwivedi wrote:
> Program Structure reports have two attribution gaps. A missing jump
> table is reported at the beginning of its subprogram rather than at
> the gotox that needs the table, and the early subprogram-layout checks
> run before BTF line information is installed.
>
> Pass the failing gotox instruction into the jump-table lookup.
>
> The BTF validator needs the discovered subprogram boundaries together
> with the LD_ABS and tail-call properties collected during the layout
> scan. Collect those properties, along with the program's callx marker,
> with nested subprogram and instruction loops, then validate BTF before
> reporting layout errors. This makes validated source information
> available to the jump-boundary and fallthrough reports without changing
> either check.
>
> Moving BTF validation ahead of normal instruction validation also lets
> CO-RE see a truncated final LD_IMM64. Reject a relocation targeting
> that instruction before bpf_core_apply() can inspect or patch its
> missing second half.
>
> Link: https://lore.kernel.org/bpf/cf2f420c2b21de440a7dc51b1565c0f06d4b539=
640ee5c03384e5d77bcfb5686@mail.kernel.org/
> Fixes: a8f427835394 ("bpf: Report Program Structure CFG errors")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/cfg.c       |  6 ++---
>  kernel/bpf/check_btf.c | 15 +++++++++---
>  kernel/bpf/verifier.c  | 54 +++++++++++++++++++++++++++++-------------
>  3 files changed, 52 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 0de2f634ef67..33b98285e802 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -288,7 +288,7 @@ static struct bpf_iarray *jt_from_map(struct bpf_map =
*map)
>   * combined jump table in jt->items (allocated with kvcalloc)
>   */
>  static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
> -					  int subprog_start, int subprog_end)
> +					  int insn_idx, int subprog_start, int subprog_end)
>  {
>  	struct bpf_iarray *jt =3D NULL;
>  	struct bpf_map *map;
> @@ -328,7 +328,7 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_=
verifier_env *env,
>  	if (!jt) {
>  		verbose(env, "no jump tables found for subprog starting at %u\n", subp=
rog_start);
>  		bpf_diag_program_structure(
> -			env, subprog_start, "missing jump table",
> +			env, insn_idx, "missing jump table",
>  			"Make sure subprograms containing gotox instructions are accompanied =
by jump tables referencing these subprograms.",
>  			"No jump table was found for the subprogram that starts at instructio=
n %u.",
>  			subprog_start);
> @@ -350,7 +350,7 @@ create_jt(int t, struct bpf_verifier_env *env)
>  	subprog =3D bpf_find_containing_subprog(env, t);
>  	subprog_start =3D subprog->start;
>  	subprog_end =3D (subprog + 1)->start;
> -	jt =3D jt_from_subprog(env, subprog_start, subprog_end);
> +	jt =3D jt_from_subprog(env, t, subprog_start, subprog_end);
>  	if (IS_ERR(jt))
>  		return jt;
> =20
> diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
> index 0e8b3ccc7a5b..81f4dbfbf146 100644
> --- a/kernel/bpf/check_btf.c
> +++ b/kernel/bpf/check_btf.c
> @@ -373,6 +373,8 @@ static int check_core_relo(struct bpf_verifier_env *e=
nv,
>  	 * relocation record one at a time.
>  	 */
>  	for (i =3D 0; i < nr_core_relo; i++) {
> +		u32 insn_idx;
> +
>  		/* future proofing when sizeof(bpf_core_relo) changes */
>  		err =3D bpf_check_uarg_tail_zero(u_core_relo, expected_size, rec_size)=
;
>  		if (err) {
> @@ -391,15 +393,22 @@ static int check_core_relo(struct bpf_verifier_env =
*env,
>  			break;
>  		}
> =20
> -		if (core_relo.insn_off % 8 || core_relo.insn_off / 8 >=3D prog->len) {
> +		insn_idx =3D core_relo.insn_off / 8;
> +		if (core_relo.insn_off % 8 || insn_idx >=3D prog->len) {
>  			verbose(env, "Invalid core_relo[%u].insn_off:%u prog->len:%u\n",
>  				i, core_relo.insn_off, prog->len);
>  			err =3D -EINVAL;
>  			break;
>  		}
> +		if (insn_idx =3D=3D prog->len - 1 &&
> +		    prog->insnsi[insn_idx].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)) {
> +			verbose(env, "Invalid core_relo[%u] targets truncated bpf_ld_imm64 in=
sn\n",
> +				i);
> +			err =3D -EINVAL;
> +			break;
> +		}
> =20
> -		err =3D bpf_core_apply(&ctx, &core_relo, i,
> -				     &prog->insnsi[core_relo.insn_off / 8]);
> +		err =3D bpf_core_apply(&ctx, &core_relo, i, &prog->insnsi[insn_idx]);
>  		if (err)
>  			break;
>  		bpfptr_add(&u_core_relo, rec_size);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1c52e7bd570d..63b32a39a0f7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3098,6 +3098,34 @@ static int add_kfuncs(struct bpf_verifier_env *env=
)
>  	return 0;
>  }
> =20
> +static void find_subprog_properties(struct bpf_verifier_env *env)
> +{
> +	struct bpf_subprog_info *subprog =3D env->subprog_info;
> +	struct bpf_insn *insn =3D env->prog->insnsi;
> +	int cur_subprog;
> +
> +	for (cur_subprog =3D 0; cur_subprog < env->subprog_cnt; cur_subprog++) =
{
> +		int i;
> +
> +		for (i =3D subprog[cur_subprog].start;
> +		     i < subprog[cur_subprog + 1].start; i++) {
> +			u8 code =3D insn[i].code;
> +
> +			if (code =3D=3D (BPF_JMP | BPF_CALL) &&
> +			    insn[i].src_reg =3D=3D 0 &&
> +			    insn[i].imm =3D=3D BPF_FUNC_tail_call) {
> +				subprog[cur_subprog].has_tail_call =3D true;
> +				subprog[cur_subprog].tail_call_reachable =3D true;
> +			}
> +			if (BPF_CLASS(code) =3D=3D BPF_LD &&
> +			    (BPF_MODE(code) =3D=3D BPF_ABS || BPF_MODE(code) =3D=3D BPF_IND))
> +				subprog[cur_subprog].has_ld_abs =3D true;
> +			if (bpf_is_callx(&insn[i]))
> +				env->has_callx =3D true;
> +		}
> +	}
> +}
> +
>  static int check_subprogs(struct bpf_verifier_env *env)
>  {
>  	int i, subprog_start, subprog_end, off, cur_subprog =3D 0;
> @@ -3111,17 +3139,6 @@ static int check_subprogs(struct bpf_verifier_env =
*env)
>  	for (i =3D 0; i < insn_cnt; i++) {
>  		u8 code =3D insn[i].code;
> =20
> -		if (code =3D=3D (BPF_JMP | BPF_CALL) &&
> -		    insn[i].src_reg =3D=3D 0 &&
> -		    insn[i].imm =3D=3D BPF_FUNC_tail_call) {
> -			subprog[cur_subprog].has_tail_call =3D true;
> -			subprog[cur_subprog].tail_call_reachable =3D true;
> -		}
> -		if (BPF_CLASS(code) =3D=3D BPF_LD &&
> -		    (BPF_MODE(code) =3D=3D BPF_ABS || BPF_MODE(code) =3D=3D BPF_IND))
> -			subprog[cur_subprog].has_ld_abs =3D true;
> -		if (bpf_is_callx(&insn[i]))
> -			env->has_callx =3D true;
>  		if (BPF_CLASS(code) !=3D BPF_JMP && BPF_CLASS(code) !=3D BPF_JMP32)
>  			goto next;
>  		if (BPF_OP(code) =3D=3D BPF_CALL)
> @@ -3143,9 +3160,10 @@ static int check_subprogs(struct bpf_verifier_env =
*env)
>  		}
>  next:
>  		if (i =3D=3D subprog_end - 1) {
> -			/* to avoid fall-through from one subprog into another
> +			/*
> +			 * To avoid fall-through from one subprog into another,
>  			 * the last insn of the subprog should be either exit
> -			 * or unconditional jump back or bpf_throw call
> +			 * or unconditional jump back or bpf_throw call.
>  			 */
>  			if (code !=3D (BPF_JMP | BPF_EXIT) &&
>  			    code !=3D (BPF_JMP32 | BPF_JA) &&
> @@ -22410,17 +22428,19 @@ int bpf_check(struct bpf_prog **prog, union bpf=
_attr *attr, bpfptr_t uattr,
>  	if (ret < 0)
>  		goto skip_full_check;
> =20
> -	/* Discover all subprograms before validating their layout and BTF. */
> +	/* Discover all subprograms and collect the properties needed by BTF va=
lidation. */
>  	ret =3D add_subprogs(env);
>  	if (ret < 0)
>  		goto skip_full_check;
> =20
> -	ret =3D check_subprogs(env);
> +	find_subprog_properties(env);
> +
> +	/* Validate BTF and apply CO-RE before reporting subprogram layout erro=
rs. */
> +	ret =3D bpf_check_btf_info(env, attr, uattr);
>  	if (ret < 0)
>  		goto skip_full_check;
> =20
> -	/* Validate BTF against the complete subprogram layout and apply CO-RE.=
 */
> -	ret =3D bpf_check_btf_info(env, attr, uattr);
> +	ret =3D check_subprogs(env);

I think this is undoing your own fix
commit c26e97721b172163

