Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23A421247
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502715; cv=none; b=jCCHAU8+kWWLW63OrO+22zdaL8aQ/JXbuGaCxlIUERcpGpauI75xGR2nAAq5BWLIpxAVN5YC3/F0jn9jDV2zrGVhAa5B8eHp4hDkX4Woru/PYLGkbxNJqrmwCs49FSwGga7wl80DbFFBZTnZQ+FlvQQQSYBqyV2fIpVrb80Ukps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502715; c=relaxed/simple;
	bh=KStmycvbYqE2ZpA5LwirNRJZATpX6R2J5WRrOLJqOPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sViepwOl0/sBplfdM3MD/xb07cLHRKqYVkw6RKbtoLuPnsj8gbiC9TMbOQ7X+Okpp7ErGRUSqeHBEW+1bWrwTBQbYMWFQAYWv0nTptGdrXf/GKkvCuHHU3byc2IvWgEfxYclelxkwjzzvm0+DmuqQcQ1obCv3ohI4oty2Y0ILjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5zinVig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5zinVig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9751F00A3E;
	Fri,  4 Sep 2026 06:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502714;
	bh=o013/nvVGRijhwHp+t2EUlWSgTpkvLkRpXFjUFoiD9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5zinVigNAhODLrKpd9zIqcTihiIAYtc75petS4uLNAdj1pTbsijZnMJSY7H8oSBv
	 lp+eS2UaGF7KZhW0Hw0z7sgncnh1nOF7wo3M7j1LN2JWjjX9rvx7Za1T8/sj+F8ZUs
	 xGD6dtlJ+Tu6KaqRShqVTN9GnOU1MtSWlyyIc1ypRgRSYDesMHTUaTJfO1kzujiRkK
	 VvnRxr0/PRylG7Q4O4fyvuBg8OAaGhy5kDoQpigd3Ur/AeUnGoR2z6ltq+vT1LqlYo
	 Dtd9vxQ1ng8rOJMovGPO0rkLfaVa8FMclYQlBTw1MgvxdPfzsOVTUt6wkgDPWyOfXP
	 ot1bgzF2kikQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 05/12] bpf: Support by-value struct and
 __int128 kfunc arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904051023.3979415-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051023.3979415-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:18:33 +0000
Message-Id: <20260904061833.EF9751F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect buffer register resolution for memory bounds check in ch=
eck_kfunc_args() due to confusion between BTF argument index and register s=
lot index.
- [High] bpf_kfunc_stack_access_bytes() incorrectly uses register slot indi=
ces to index BTF arguments, breaking stack liveness tracking.
- [High] bpf_get_call_summary() incorrectly uses the number of BTF argument=
s instead of the number of argument slots for kfuncs, breaking register liv=
eness tracking.
--

commit 225a338e077323b335756911c91748fab0c8ec13
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Support by-value struct and __int128 kfunc arguments

A kfunc taking a struct or union by value is rejected today, and one
taking an __int128 is accepted but mis-counted:

  Unrecognized R2 type STRUCT

Give the kfunc argument walk the same slot count a BPF-to-BPF call now
uses: one argument register per eightbyte, so a 16-byte value takes two.
The outgoing stack argument count at the call site follows the slots for
the same reason. Similar to BPF-to-BPF aggregate handling, a kfunc
aggregate argument only supports tbe composed of scalars.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 17e576c7b7572..030fb37c22ef1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -12792,29 +12904,34 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_call_arg_me
[ ... ]
>  	/* Check that BTF function arguments match actual types that the
>  	 * verifier sees.
>  	 */
> -	for (i =3D 0; i < nargs; i++) {
> -		struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, i);
> +	for (i =3D 0, slots_used =3D 0; i < nargs; i++, slots_used +=3D nslots)=
 {
> +		struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, slots_use=
d);
>  		const struct btf_type *t, *ref_t, *resolve_ret;
>  		enum bpf_arg_type arg_type =3D ARG_DONTCARE;
> -		argno_t argno =3D argno_from_arg(i + 1);
> +		argno_t argno =3D argno_from_arg(slots_used + 1);

[Severity: High]
This change separates the BTF argument index (i) from the register slot
index (slots_used), but does it leave other parts of the loop using i
incorrectly?

For instance, further down in this loop, case KF_ARG_MEM_SIZE uses i - 1
instead of slots_used - 1 to find the buffer pointer:

    case KF_ARG_MEM_SIZE:
    {
        struct bpf_reg_state *buff_reg =3D get_func_arg_reg(caller, regs, i=
 - 1);
        struct bpf_reg_state *size_reg =3D reg;

Could this cause a kfunc memory bounds check to validate the size argument
against the memory bounds of the wrong pointer register if a preceding
argument consumed multiple slots?

[ ... ]
> @@ -14308,11 +14444,11 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
>  	if (bpf_is_kfunc_pkt_changing(&meta))
>  		clear_all_pkt_pointers(env);
> =20
> -	nargs =3D btf_type_vlen(meta.func_proto);
> -	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> +	proto_slots =3D kfunc_proto_slots(desc_btf, meta.func_proto);
> +	if (proto_slots > MAX_BPF_FUNC_REG_ARGS) {

[Severity: High]
This patch introduces multi-slot kfunc arguments, but were all places
that map register slots to BTF arguments updated?

For example, in bpf_kfunc_stack_access_bytes(), the register slot index
(arg) is still directly used to index the BTF argument array:

	args =3D btf_params(meta.func_proto);
	nargs =3D btf_type_vlen(meta.func_proto);
	if (arg >=3D nargs)
		return 0;

	t =3D btf_type_skip_modifiers(btf, args[arg].type, NULL);

Could this result in looking up the wrong parameter or going out of bounds
when querying stack accesses for kfuncs with multi-slot arguments?

[Severity: High]
And similarly, does bpf_get_call_summary() also need to be updated?

bool bpf_get_call_summary(...) {
...
	if (bpf_pseudo_kfunc_call(call)) {
...
		cs->num_params =3D btf_type_vlen(meta.func_proto);

Since liveness tracking uses cs->num_params to determine the number of live
registers, could using the BTF argument count instead of the number of
register slots cause the verifier to treat upper registers of multi-slot
arguments as dead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904050957.3976=
119-1-yonghong.song@linux.dev?part=3D5
