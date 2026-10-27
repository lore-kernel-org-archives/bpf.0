Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793070879;
	b=hLzs0WAJR5J0/Op1HmBk/+w/80jTpGWTq2ZyxpBhytt8urLf1p6UXrc0kWN7A566cS4c
	 fRCyagu6N5GxkTLJ7jH9erCdBMth1O0xGsRjMgFN8qOdVohYVha69qLMwwQ07W0oU51fI
	 Z+wYWEuWV0skcerQzqmbgwh2UTy2KD7dyYe9pKpwRfenyR9MSu8wQkz1MafJB5ip8dZUg
	 drSnwB1G31Wpd2pQGxHQ9e1Am3Kq3lq4g4GS+odme7YOB+2C7mrLP7wNFHs/Y3rNruL/w
	 Z4v3ffMHPiCTWzsrW01JcI3VF7kl6vMosdBCd9lgAhcE+AkwHu42DG+VjyGagKp31yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793070879;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mFQQatuf+XSoHK+AFooyCL3ewxpPuUu4HT/v5KrUvdg=;
	b=CL/BH8tAmeUiz/BjYTokFEGsttSTuwW9/UQe0uLAga0z1MhhloKdeqPQ8+NJk2LSLV0O
	 KsBfnqA6anlG3Vz/JjHV9VBtTfz8J8LnbRYjWrGSLyPaK/efDZa2LH6Xu9xxksWv9YmeZ
	 P5iIaGJfilcai6FGkMa4VgoMCEN+mvBii5Pgdju53xWkXUOjyTuSalPHq6CXx0IVVqjT9
	 HYzdCVgDqW4rH4zegOwRNVTA/nTlGZ91zk5iBC/Yy+cyL4/dof9MeM3tKlbAvkQ9AfcBB
	 yWgT0pZhCXoagWn45QUdUwbLV7tU0Zlry53ERwOnIkwGSDz5kBCmEap7UueJ8rRbc2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsnTxSO+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81819606A31E
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 03:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsnTxSO+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6CF1F01825;
	Tue, 27 Oct 2026 03:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793070879;
	bh=mFQQatuf+XSoHK+AFooyCL3ewxpPuUu4HT/v5KrUvdg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JsnTxSO+KEha6zZ8C2PbZ4hGFcF6zjHuFXjvm0Tg9QmhtmbVc+/vGvO/+vMRfkyTc
	 Pw5VVf2NAFSw8Ps79Wo4dy7t+5G0DH7QUuiMkhQCMWRPc0WJzxBlitKuViVX9kcY20
	 b2OQZ+R5phBHqrT02zhEux+0YZdJTN6ZTiYsm9U/eOQIcVrj1q3dkW8JcV2Vp32ZAb
	 6eWRQGmBZQuaDKYhVNy/DmQEMjY14TtXmkARFrr/wN59sTLrifwai1DMTHE43F30+T
	 stJjfAk9avgy0lu7vFeI97k/v3OOYefJckKsswZZEesm47CjehUrlne3hlzVpm/2mX
	 Tk/bMg6uzIg+w==
Message-ID: <sashiko-outbox-186048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: check cpu_possible() in per-cpu helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "bo cao" <treebacker@foxmail.com>, bpf <bpf@vger.kernel.org>
In-Reply-To: <tencent_3A8413B414528B9802AB092A67AE015FFE09@qq.com>
References: <tencent_3A8413B414528B9802AB092A67AE015FFE09@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 03:14:38 +0000
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
- [Critical] bpf: cpu_possible() check in bpf_map_lookup_percpu_elem() bypa=
ssed by JIT
--

commit f9e290dde4ddd182ff551c50398cfc5c7e5ec1bb
Author: bo cao <treebacker@foxmail.com>

bpf: check cpu_possible() in per-cpu helpers

This commit adds cpu_possible() checks to bpf_map_lookup_percpu_elem() and
bpf_per_cpu_ptr() to prevent out-of-bounds per_cpu_ptr() calculations when a
hole CPU ID is passed on systems with a sparse cpu_possible_mask.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 648abe1ba63ae..f9f2bd665038b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -133,6 +133,10 @@ const struct bpf_func_proto bpf_map_peek_elem_proto =
=3D {
>  BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, ke=
y, u32, cpu)
>  {
>  	WARN_ON_ONCE(!bpf_rcu_lock_held());
> +
> +	if (cpu >=3D nr_cpu_ids || !cpu_possible(cpu))
> +		return 0;
> +
>  	return (unsigned long) map->ops->map_lookup_percpu_elem(map, key, cpu);
>  }

[Severity: Critical]
Does placing the cpu_possible(cpu) check only in bpf_map_lookup_percpu_elem=
()
leave 64-bit JITed programs unprotected when calling this helper?

In kernel/bpf/fixups.c:do_misc_fixups(), when prog->jit_requested &&
BITS_PER_LONG =3D=3D 64 and the map pointer is not poisoned
(!bpf_map_ptr_poisoned(aux)), the verifier rewrites
BPF_FUNC_map_lookup_percpu_elem to call ops->map_lookup_percpu_elem directl=
y,
bypassing bpf_map_lookup_percpu_elem() in kernel/bpf/helpers.c:

kernel/bpf/fixups.c:do_misc_fixups() {
    ...
		if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&
		    (insn->imm =3D=3D BPF_FUNC_map_lookup_elem ||
		     ...
		     insn->imm =3D=3D BPF_FUNC_map_lookup_percpu_elem)) {
			aux =3D &env->insn_aux_data[i + delta];
			if (bpf_map_ptr_poisoned(aux))
				goto patch_call_imm;
    ...
			case BPF_FUNC_map_lookup_percpu_elem:
				insn->imm =3D BPF_CALL_IMM(ops->map_lookup_percpu_elem);
				goto next_insn;
    ...
}

When that direct call path is taken, execution goes straight to the map
callbacks:
- kernel/bpf/arraymap.c:percpu_array_map_lookup_percpu_elem()
- kernel/bpf/hashtab.c:htab_percpu_map_lookup_percpu_elem()
- kernel/bpf/hashtab.c:htab_lru_percpu_map_lookup_percpu_elem()

All three callbacks still only check cpu >=3D nr_cpu_ids before indexing
per_cpu_ptr(..., cpu):

kernel/bpf/arraymap.c:percpu_array_map_lookup_percpu_elem() {
	if (cpu >=3D nr_cpu_ids)
		return NULL;

	if (unlikely(index >=3D array->map.max_entries))
		return NULL;

	return per_cpu_ptr(array->pptrs[index & array->index_mask], cpu);
}

Should the !cpu_possible(cpu) check be added to
percpu_array_map_lookup_percpu_elem(), htab_percpu_map_lookup_percpu_elem(),
and htab_lru_percpu_map_lookup_percpu_elem() as well so that direct calls f=
rom
64-bit JITed programs cannot index __per_cpu_offset[] with an uninitialized
hole CPU ID?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_3A8413B4145=
28B9802AB092A67AE015FFE09@qq.com?part=3D1
