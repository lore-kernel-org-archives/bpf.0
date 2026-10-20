Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522566;
	b=PxdNa0XHxQM/yJ04C1wu6WCrSJS2CW331B1RfjtokKZCRLxOoDXOYuEevQa71TkwBpvv
	 s0WWTPFXxZ3Cgc9C5odaxpKKodoSYQfsIyuRoNuIuc2YJNVmiJay5Vd01qA9tJAyHgH1D
	 LZd90mDNkeuDEKubTlPpjwjrnu3rTHGFBqt2xbZpyhPheXnD2jfvgG5RNGUVe1phIcadl
	 nBcaw7QRS4+PY2VGIClHo49vakSyFRXJYe7vXOS1stOhOUyT2xTkn1GCtORkB5o5nFEfy
	 dGIuxuhcFnvBoOSFM0Rz4br6Trdnv9s64aLuBmKlWZGsjBp0NHWluxkLMp6vXD1MRTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522566;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TJlC6VUEh5AfipZyxwBcvzYedyAj1EsAZs+u+emKWRE=;
	b=RRYR5qVUNquTuqy/tSujcQEmc2S86bopAC02ANkktQ23PzENLppE54CbRC0mcOXoMrLq
	 eTheCswSlQZ4wzgw6nvVF1HpzmbE8Fp3bgHDdMbOgYie65O707DscB4Kv9bGuJdtILnZH
	 dZMAEzRu5akNdBqA2GuY1vcQelDIDTVeaUOihImfj4bOyIvyj58Fc4wtBtLtTBSlXJms6
	 W6Uy72TfdUeAqR61Ex9iw4wz758v6xwdz/E5G2Da0I9qFqgtcLUc09O+1JidKtpR3mmfZ
	 biOjjmv3wA0r//BvbeR3iqxfjJcmNZGENeuCyPt0iSQFaVHYkGGGPC3Zb1BSBUHItag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRq5lHsD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AD606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRq5lHsD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C645E1F000C9;
	Tue, 20 Oct 2026 18:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522566;
	bh=TJlC6VUEh5AfipZyxwBcvzYedyAj1EsAZs+u+emKWRE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DRq5lHsD98BeB01WEeqN/LAxQGSBcFzUqXqEP8SOdUQOxJwcJBGwm+NyMXWDh/jFP
	 SxGDGZQlRwSrK40BnxQuv5+DnsjvNPfDFwVD2f7i0fhkrKnIsAnpFFF4x0g+/BmmWe
	 OUylHXGnVTfY5Q/hLHAJ+7aW4JTnSwjupKAdkta1PsoDP29h9KJ1x0z3cpQHprcjTI
	 ED3X8wNztjZ69DWsjoG7Fzt1ECEkVi3vyBtMxO9RibJ33rgZDyp8K30D94joG8qRtB
	 7zao5dW0pM/JrqHNzBq4e/rrLgc0kyINKtN2iVtyn2/HgNG4Mw2QsAcSfOwkNg3qp7
	 C/sAdYj/pybrg==
Message-ID: <sashiko-outbox-179498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 bpf-next 2/6] bpf, x86: Support unwind_goto and
 unwind_exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261020181320.1284798-3-alexei.starovoitov@gmail.com>
References: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
 <20261020181320.1284798-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:56:05 +0000
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
- [High] bpf, x86: emit_unwind_ret_addr() in exception_cb unwinds caller fr=
ame
--

commit c3cf97c5b42c930ee82a85d0896d91eed8f4f5f6
Author: Alexei Starovoitov <ast@kernel.org>

bpf, x86: Support unwind_goto and unwind_exit

This commit adds x86 JIT support for the BPF unwind_goto and unwind_exit
instructions using exception table entries and return address fixups.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 72a2a0a89e033..d3ab36281144d 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> +static u64 bpf_unwind_target(u64 ret_addr)
> +{
> +	const struct exception_table_entry *e =3D search_bpf_extables(ret_addr =
- 1);
> +
> +	/*
> +	 * The verifier made sure that unwind_goto follows a call in a prog. Wh=
en
> +	 * the kernel called an async or an exception callback, it's exit.
> +	 */
> +	return e ? ret_addr + e->fixup : ret_addr;
> +}
> +
> +/* unwind_exit: fix the return address of this frame. r0 and r2 are retu=
rned. */
> +static int emit_unwind_ret_addr(u8 **pprog, u8 *ip)
> +{
> +	u8 *prog =3D *pprog, *start =3D prog;
> +
> +	EMIT2(0x50, 0x56);			/* push rax; push rsi */
> +	EMIT4(0x48, 0x8B, 0x7D, 0x08);		/* mov rdi, [rbp + 8] */
> +	ip +=3D prog - start;
> +	ip +=3D x86_call_depth_emit_accounting(&prog, bpf_unwind_target, ip);
> +	if (emit_call(&prog, bpf_unwind_target, ip))
> +		return -EINVAL;
> +	EMIT4(0x48, 0x89, 0x45, 0x08);		/* mov [rbp + 8], rax */
> +	EMIT2(0x5E, 0x58);			/* pop rsi; pop rax */
> +	*pprog =3D prog;
> +	return 0;
> +}
[ ... ]
> @@ -3774,13 +3865,16 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
>  			break;
> =20
>  		case BPF_JMP | BPF_EXIT:
> +			if (src_reg =3D=3D BPF_UNWIND_EXIT && bpf_prog_can_unwind(bpf_prog) &&
> +			    emit_unwind_ret_addr(&prog, ip))
> +				return -EINVAL;

[Severity: High]
Can emitting emit_unwind_ret_addr() inside an exception callback subprogram
cause unwind_exit to unwind the exception boundary's caller frame into an
unverified landing pad?

In include/linux/filter.h, bpf_prog_can_unwind() returns true for any
subprogram:

include/linux/filter.h:bpf_prog_can_unwind() {
	return bpf_is_subprog(prog) || prog->type =3D=3D BPF_PROG_TYPE_EXT;
}

Because an exception callback is a subprogram (bpf_prog->aux->func_idx !=3D=
 0
with bpf_prog->aux->exception_cb set), bpf_prog_can_unwind(bpf_prog) is true
in do_jit(), while the verifier treats BPF_UNWIND_EXIT in an exception
callback as a normal frame-0 exit in process_bpf_exit_full() and ignores the
exception callback when setting prog->aux->can_unwind in check_unwind_insns=
().

The comment in bpf_unwind_target() assumes that when the kernel invokes an
exception callback, the return address at [rbp + 8] belongs to the kernel
caller and will not match any BPF extable entry. However, in
arch/x86/net/bpf_jit_comp.c, emit_prologue() resets rbp to the third argume=
nt
(ctx.bp of the exception boundary frame found by bpf_stack_walker()):

arch/x86/net/bpf_jit_comp.c:emit_prologue() {
	if (is_exception_cb) {
		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
		EMIT3(0x48, 0x89, 0xD5); /* mov rbp, rdx */
		...
		EMIT3(0x48, 0x89, 0xEC); /* mov rsp, rbp */
}

As a result, [rbp + 8] inside the exception callback is the return address =
of
the exception boundary frame (func[0]), not bpf_throw().

If the exception boundary frame was entered via a tail call from a subprogr=
am
that was called before an unwind_goto instruction, or if an extension progr=
am
(BPF_PROG_TYPE_EXT) with can_unwind =3D=3D false on func[0] replaces a glob=
al
subprogram followed by an unwind_goto instruction and then calls bpf_throw(=
),
[rbp + 8] points to the instruction after the subprogram call in the caller.
When the exception callback executes BPF_UNWIND_EXIT, bpf_unwind_target()
finds the caller's unwind_goto extable entry and redirects [rbp + 8] to the
landing pad with register and stack state that the verifier never checked f=
or
that path.

Should bpf_prog_can_unwind() (or the check in do_jit()) exclude
prog->aux->exception_cb?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020181320.1284=
798-1-alexei.starovoitov@gmail.com?part=3D2
