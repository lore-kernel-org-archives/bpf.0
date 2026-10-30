Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363088;
	b=GmH8TW5WTkfZ22J7wKd2BeaK1lJ8GSnE7l4J90fSmEdWXXmwkiYS1IvKnFOs7TMcrTPX
	 K7BSd/lfBuFxuF80qBh9zK2uU1Zp5HH9qQq5HSZBBiZt9/9vbaCZHF9J/7N2bpeB3eD61
	 HlySzXTI22nAI/OYFBchWW/iQYQnuWM5xDDFz8DSeUCtMYsk4ignpaPpKhca7XxOKClwK
	 ukTM4SEKRfzWrsj05BZz1Av2FsmYAskDnc3f2H0gmJc5fkN37QaZZBTd8APxGZBvs5uxj
	 nygPCKhM59yOIIUjU//qQLqRdzSSbwgGVNXbAgYOqFx0I6tjQfuTshuiB50XbAWENdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363088;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3I/2M7RjZD4SPEX/p2fQbxHQfZLPkPM8s8iyu/POfw0=;
	b=DmNhgUItlcsuq+1J+IahKq42b2kf0Njq1mtTvAsn+j6pX7jZU6sZn/wYOQZC5YuW0vdO
	 Ts3vRQBOmySUCiQ1VIenIDclp0bElBTbwqvSlHU1EZr4gopRlkKse/wv7Ir9vVFs49gRu
	 acjvbndD7r8eK1ZAUTi6SgB24EQasTeiWo/D2aGQEaVQ5heBqoj0N1tKEMM4wRJFZ5Asp
	 pX7/fYuTCKbjNcw9G/yaCPRW6EBk/Z3eZNuW11E0l/iNmp9ipyzEHmD2EzBsPsQH2GdSK
	 /NsHmUnIvO6k9qJlAqlpZ/GMe1Hl7cOypwymxnrxi1jAplDg4e8evUnEBw+miUezNFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWCr0P6s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A39606A32E
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWCr0P6s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5F41F00A1A;
	Fri, 30 Oct 2026 12:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793363088;
	bh=3I/2M7RjZD4SPEX/p2fQbxHQfZLPkPM8s8iyu/POfw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iWCr0P6sqsX9BpIhpGzKhBoqgyrq3u91vMPAoyKQhM71DH4k6LNW4g2cnAIGG1ojB
	 gCMa2sIV+wO8TjSI3wpbPUmtjG2puVBsMiDYL8LD2C9tIK2z/eT+foPc6hWagkRBB0
	 VtmmPJnuWMOXiRusZS5WR56qz2iD5GA54S1dxoZGvY1i8gh9/sJNNSj3XfMK/eNAMl
	 Uk3pBA5S+8TNIjnjZ4hc0P9juO7on9stwkTUBgD+hNICrwgix666i+OjAG53osTYye
	 XxkweApd3mpfQKqL0l5RoKF5HzgPIOGdbakIHmFwQoaRTjOGevD/sjf+9rfzY4yakW
	 Z5knhVt9OC+0A==
Message-ID: <sashiko-outbox-191010@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 14/22] bpf: Move bpf_convert_ctx_accesses()
 to the patch list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-14-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
 <20261030-bpf-verifier-patch-batch-v2-14-55cd43439f7c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 12:24:46 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: lost in-place insn 0 rewrites in bpf_convert_ctx_accesses=
()
--

commit 4384b7c62a67d8070d7d3e407afbbb78ae703556
Author: Qiliang Yuan <odys.yuan@gmail.com>

bpf: Move bpf_convert_ctx_accesses() to the patch list

This commit converts bpf_convert_ctx_accesses() from patching instructions
immediately via bpf_patch_insn_data() to queuing prologues, epilogue context
stores, and instruction rewrites in env->patch_list and committing them at
the end of the pass.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 6d99de1be2581..08c89f2baffb6 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1090,16 +1090,15 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_=
env *env)
>  {
>  	struct bpf_subprog_info *subprogs =3D env->subprog_info;
>  	const struct bpf_verifier_ops *ops =3D env->ops;
> -	int i, cnt, size, ctx_field_size, ret, delta =3D 0, epilogue_cnt =3D 0;
> +	int i, cnt, size, ctx_field_size, ret, epilogue_cnt =3D 0;
>  	const int insn_cnt =3D env->prog->len;
>  	struct bpf_insn *epilogue_buf =3D env->epilogue_buf;
>  	struct bpf_insn *insn_buf =3D env->insn_buf;
>  	struct bpf_insn *insn;
>  	u32 target_size, size_default, off;
> -	struct bpf_prog *new_prog;
>  	enum bpf_access_type type;
>  	bool is_narrower_load;
> -	int epilogue_idx =3D 0;
> +	int epilogue_idx =3D -1;
> =20
>  	if (ops->gen_epilogue) {
>  		epilogue_cnt =3D ops->gen_epilogue(epilogue_buf, env->prog,
> @@ -1109,17 +1108,12 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_=
env *env)
>  			return -EFAULT;
>  		} else if (epilogue_cnt) {
>  			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
> -			cnt =3D 0;
>  			subprogs[0].stack_depth +=3D 8;
> -			insn_buf[cnt++] =3D BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
> -						      -subprogs[0].stack_depth);
> -			insn_buf[cnt++] =3D env->prog->insnsi[0];
> -			new_prog =3D __bpf_patch_insn_data(env, 0, insn_buf, cnt,
> -							 BPF_PATCH_MOVE_TARGET);
> -			if (!new_prog)
> -				return -ENOMEM;
> -			env->prog =3D new_prog;
> -			delta +=3D cnt - 1;
> +			insn_buf[0] =3D BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
> +						  -subprogs[0].stack_depth);
> +			ret =3D bpf_patch_list_insert(env, 0, insn_buf, 1);
> +			if (ret)
> +				return ret;
> =20
>  			ret =3D add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);
>  			if (ret < 0)
> @@ -1150,13 +1144,14 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_=
env *env)
>  						   env->prog->aux->attach_btf_id))
>  				return -EINVAL;
>  			env->prog->aux->has_prologue =3D true;
> -			new_prog =3D __bpf_patch_insn_data(env, 0, insn_buf, cnt,
> -							 BPF_PATCH_MOVE_TARGET);
> -			if (!new_prog)
> -				return -ENOMEM;
> -
> -			env->prog =3D new_prog;
> -			delta +=3D cnt - 1;
> +			/* the prologue ends with the first insn of the program */
> +			if (verifier_bug_if(memcmp(&insn_buf[cnt - 1], env->prog->insnsi,
> +						   sizeof(*insn_buf)), env,
> +					    "prologue doesn't end with the first insn"))
> +				return -EFAULT;
> +			ret =3D bpf_patch_list_insert(env, 0, insn_buf, cnt - 1);
> +			if (ret)
> +				return ret;
> =20
>  			ret =3D add_kfunc_in_insns(env, insn_buf, cnt - 1);
>  			if (ret < 0)
> @@ -1164,21 +1159,18 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_=
env *env)
>  		}
>  	}
> =20
> -	if (delta)
> -		WARN_ON(adjust_jmp_off(env->prog, 0, delta));
> -
>  	if (bpf_prog_is_offloaded(env->prog->aux))
> -		return 0;
> -
> -	insn =3D env->prog->insnsi + delta;
> +		return bpf_patch_list_commit(env);
> =20
> -	for (i =3D 0; i < insn_cnt; i++, insn++) {
> +	for (i =3D 0; i < insn_cnt; i++) {
>  		bpf_convert_ctx_access_t convert_ctx_access;
>  		enum bpf_reg_type ptr_type;
>  		u8 mode;
> =20
> -		if (env->insn_aux_data[i + delta].nospec) {
> -			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
> +		insn =3D &env->prog->insnsi[i];

[ ... ]

> @@ -1226,42 +1214,34 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_=
env *env)
>  			    insn->code =3D=3D (BPF_STX | BPF_ATOMIC | BPF_H) ||
>  			    insn->code =3D=3D (BPF_STX | BPF_ATOMIC | BPF_W) ||
>  			    insn->code =3D=3D (BPF_STX | BPF_ATOMIC | BPF_DW)) &&
> -			   env->insn_aux_data[i + delta].ptr_type =3D=3D PTR_TO_ARENA) {
> +			   env->insn_aux_data[i].ptr_type =3D=3D PTR_TO_ARENA) {
>  			insn->code =3D BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
>  			env->prog->aux->num_exentries++;
>  			continue;

[Severity: Critical]
When ops->gen_epilogue or ops->gen_prologue emits instructions before the
loop in bpf_convert_ctx_accesses(), bpf_patch_list_insert(env, 0, ...)
creates a patch entry at offset 0 in env->patch_list and copies the
unpatched env->prog->insnsi[0] into env->patch_list.insns.

In the loop, insn is initialized to &env->prog->insnsi[i]. When i =3D=3D 0 =
and
env->insn_aux_data[0].nospec is false, several branches modify insn->code in
place and execute continue without calling bpf_patch_list_add():

1. PTR_TO_ARENA atomic operations rewritten to BPF_STX | BPF_PROBE_ATOMIC:

	insn->code =3D BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
	env->prog->aux->num_exentries++;
	continue;

2. PTR_TO_ARENA loads and stores rewritten to BPF_PROBE_MEM32SX or
   BPF_PROBE_MEM32:

	if (BPF_MODE(insn->code) =3D=3D BPF_MEMSX) {
		...
		insn->code =3D BPF_CLASS(insn->code) | BPF_PROBE_MEM32SX | BPF_SIZE(insn-=
>code);
	} else {
		insn->code =3D BPF_CLASS(insn->code) | BPF_PROBE_MEM32 | BPF_SIZE(insn->c=
ode);
	}
	env->prog->aux->num_exentries++;
	continue;

3. Fault-prone pointer loads (bpf_may_fault_on_deref(ptr_type)) rewritten to
   BPF_LDX | BPF_PROBE_MEM or BPF_LDX | BPF_PROBE_MEMSX when
   arena_member_fixup() returns 0:

	if (BPF_MODE(insn->code) =3D=3D BPF_MEM)
		insn->code =3D BPF_LDX | BPF_PROBE_MEM |
			     BPF_SIZE(insn->code);
	else
		insn->code =3D BPF_LDX | BPF_PROBE_MEMSX |
			     BPF_SIZE(insn->code);
	env->prog->aux->num_exentries++;

Because those branches only mutate env->prog->insnsi[0].code and do not
update the copy already queued in env->patch_list.insns (nor call
bpf_patch_list_add()), won't bpf_patch_list_commit() overwrite instruction 0
with the unpatched copy from env->patch_list.insns, losing the
BPF_PROBE_ATOMIC, BPF_PROBE_MEM32, or BPF_PROBE_MEM rewrite and leaving the
instruction without arena address relocation or exception table protection?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-bpf-verifi=
er-patch-batch-v2-0-55cd43439f7c@gmail.com?part=3D14
