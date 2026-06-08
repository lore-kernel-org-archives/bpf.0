Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84513ECBD5
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931628; cv=none; b=gmh9O4oCOCPfYVS6hkeMPpWV/ZVtqAmO50yE0iQJRDH5nnxhmRSY6zkQsm8HQ5XNIvdNmvVmqrEJEbI6XuaFaHjaPbdKg5GObpR/NGvFzc4kiuE44cr5xElySrCD9uiOD6J09aHhRJgx4iXHdKe6q33+3LttJIlhsj5M5LJTLfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931628; c=relaxed/simple;
	bh=GyQ3RjwBG4jJJVdOilP5fzD4ExRDJPP4XZP47HoBNmM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RECPhDhIkVibDuklWpHhmZBBBxzURiB6CvCCdtfT4z2hDD0mRQPY8MqC7giCPrQS1Et76H/J9yspNOTAx2nXWMtbwXf/c36l67BUQcB9bCcmZsr8ZBOQHgR9KjJnI0Uk/jTwanuEXhDfqFQurgpvMzW7973e5hOeih2fxohPzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzq96onR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzq96onR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C77D1F00893;
	Mon,  8 Jun 2026 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780931627;
	bh=qrzLSBW1EKADETDygKV6fFc6kCpg5ITA/aTmaZLVSow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qzq96onRsP6EbAtGA9o8tfhdYdIoVakScLRuM4EZovHJD9sfhkfZQU2J1td/lg90f
	 AmNI+s9v0VxvImLep3Z7qoRGuE9FKKtOowB5Ls+8hAVicaIs/Lt/NWsh4BfcAz9bjt
	 UNTwW+i9F5ThoVWtYEP7+tAyYqhyX0PRUngJTr8znDnc/J1mSVxynkP859J6ZEB4bA
	 C/zNVrUee7URIj2MitJWnug9iolAyEIOrgIXcLKeeC1nIulkqPMW/KYCjmGOoKceps
	 fiwYE1OxvalJus+NK/RunJum5MdrhePqegYtFPfM7TCyE3RmWZ5v9xbXgmkj278z/0
	 cfGafXxv+VnVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/9] bpf: Introduce global percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608145113.65857-3-leon.hwang@linux.dev>
References: <20260608145113.65857-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:13:46 +0000
Message-Id: <20260608151347.2C77D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] If JIT compilation fails and the system falls back to the BPF =
interpreter, executing the newly injected BPF_MOV64_PERCPU_REG instruction =
causes a raw __percpu pointer dereference, crashing the kernel.
- [High] The verifier incorrectly rejects valid programs that perform reads=
 from read-only PERCPU_ARRAY maps due to unhandled -EINVAL propagation.
--

commit f1931b850b246570c8eae98aab56f3df89895ec5
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Introduce global percpu data

Introduce global percpu data, inspired by the commit
6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
definition of global percpu variables in BPF, similar to the
include/linux/percpu-defs.h::DEFINE_PER_CPU() macro.

Links:
[1] https://github.com/anakryiko/retsnoop
[2] https://github.com/bpfsnoop/bpfsnoop

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 3cf2cc6e3ab66..4f84d087ca69e 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1819,6 +1819,38 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
v)
>  			goto next_insn;
>  		}
> =20
> +		if (env->prog->jit_requested &&
> +		    bpf_jit_supports_percpu_insn() &&
> +		    insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
> +		    (insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE ||
> +		     insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE)) {
> +			struct bpf_map *map;
> +
> +			aux =3D &env->insn_aux_data[i + delta];
> +			map =3D env->used_maps[aux->map_index];
> +			if (map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +				goto next_insn;
> +
> +			/*
> +			 * Reuse the original ld_imm64 insn, and add one
> +			 * mov64_percpu_reg insn.
> +			 */
> +
> +			insn_buf[0] =3D insn[1];
> +			insn_buf[1] =3D BPF_MOV64_PERCPU_REG(insn->dst_reg, insn->dst_reg);

[Severity: Critical]
Can this crash the kernel if JIT compilation fails dynamically and falls ba=
ck
to the BPF interpreter?

While env->prog->jit_requested checks if JIT was requested, it doesn't
guarantee JIT success. If the interpreter (___bpf_prog_run()) executes this
BPF_MOV64_PERCPU_REG instruction, it ignores the special BPF_ADDR_PERCPU
offset (-1) for ALU64_MOV_X:

kernel/bpf/core.c:___bpf_prog_run() {
...
	ALU64_MOV_X:
		switch (OFF) {
		case 0:
			DST =3D SRC;
			break;
...
		}
		CONT;
}

This leaves the raw __percpu base pointer in the destination register witho=
ut
resolving it for the current CPU. Subsequent memory accesses using this
pointer could then trigger a kernel page fault or potentially allow arbitra=
ry
user-space memory access.

> +			cnt =3D 2;
> +
> +			i++;
> +			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2690d063a2400..eecd9ab82e91c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5556,6 +5556,8 @@ int bpf_map_direct_read(struct bpf_map *map, int of=
f, int size, u64 *val,
>  	u64 addr;
>  	int err;
> =20
> +	if (map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY || map->map_type =3D=
=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +		return -EINVAL;

[Severity: High]
Does this code cause the verifier to incorrectly reject valid programs that
read from read-only PERCPU_ARRAY maps?

Because BPF_MAP_TYPE_PERCPU_ARRAY was not added to the exclusion list in
check_mem_access() (unlike BPF_MAP_TYPE_INSN_ARRAY):

kernel/bpf/verifier.c:check_mem_access() {
...
			if (tnum_is_const(reg->var_off) &&
			    bpf_map_is_rdonly(map) &&
			    map->ops->map_direct_value_addr &&
			    map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY) {
...
}

returning -EINVAL here propagates the error back up to check_mem_access()
and aborts verification.

>  	err =3D map->ops->map_direct_value_addr(map, &addr, off);
>  	if (err)
>  		return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145113.6585=
7-1-leon.hwang@linux.dev?part=3D2
