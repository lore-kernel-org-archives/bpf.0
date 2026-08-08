Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4689281532
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786151831; cv=none; b=bI+3xSwEjtcZTUVhHUbVrkFg6+10swiCtLqLP4bhpzFu8uXPZseceBE9tZed4sK8CZmqBCqwgikHobRKM16g2MbMQIdlnsGWhzeXHcNn6LGra6E4t/RQj5ZBECUWqYm+D6eQIqs6Mr1HbIeO5y/1kTYztKC03WqqpQZp88NiT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786151831; c=relaxed/simple;
	bh=rMQWuTH/07v7isV110Di4g+7HicapqqbY1oYZ977o+Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qG9uICpdBo4pLlJhLqbFBU7+SSsYRFwCta1GoEQTRpd27xln8Jf+upnmX4S6LtpzhcHWO8o2pMJOu7rIcMXomWJIB3Wr59ZkfpB/hWWbEP/VdXO4eOPWA955dFjGewbsc4Sa1xbC4u7kWXVQyOPYW8QvJbeaAp0NaMZWZ020M4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAEIotS2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAEIotS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1391F00A3A;
	Sat,  8 Aug 2026 01:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786151830;
	bh=9pRLpJy7tSB9qCWWb5XQPCLqViXMXygbC3nM11oTO7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kAEIotS2KoDBv3y2jmMa7mJYpTml+DknSvuYYDS7vqz+pHHbSEJ8CKwYomvTYA0Ap
	 VTrzaHwRvjxHm/HmIaiiBjzEG6pS5kAzNDJ9lWQqb1M8rSu1eS3wcTN6ujii6Fcrf5
	 vKbdxYUaCAMGFIilBhIZUN7I6x34Rfi6wcmboXwWlJF6YIGuG72eukYESnoRCTRuKl
	 U1i56Bpq45BK37P4sCTPLD9A7wdZftQW9G4zybE3vewendYzrvomPM53UbLqPt16/T
	 XCr/cys8Ropc4gZx/pFkpK350rue+8/O2AGk99aZYvyDH4ax30ylxmvT+5O2qjlR75
	 1BEBW8dR7OHAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 13/14] bpf: Reject tracing/freplace progs
 for struct_ops with arena args
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260808003938.3486067-14-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
 <20260808003938.3486067-14-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 01:17:09 +0000
Message-Id: <20260808011710.3A1391F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The patch restricts attaching extension or tracing programs to=
 the main program (`subprog =3D=3D 0`) of a target with arena context argum=
ents, but explicitly fails to restrict attachments to global subprograms (`=
subprog > 0`). This leaves a type confusion vulnerability open where a 32-b=
it user-controlled arena offset is treated as a trusted 64-bit kernel point=
er.
- [High] A `WARN_ON_ONCE` check in the trampoline linking code incorrectly =
validates the attached tracing/extension program instead of the target prog=
ram, rendering the safety check ineffective.
--

--- Patch [13]: [PATCH bpf-next v5 13/14] bpf: Reject tracing/freplace prog=
s for struct_ops with arena args ---
commit b54b0858382f938c9a42e0941274db3241ba575f
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

    bpf: Reject tracing/freplace progs for struct_ops with arena args

    This commit restricts attaching tracing and extension programs to a tar=
get
    program with arena context arguments. The restriction is added because =
the
    struct_ops indirect trampoline converts these arguments, and a generic
    tracing trampoline would expose the converted offset as a regular BTF
    pointer.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 74592272b124d..4bb3102ae4333 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19258,6 +19258,16 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
>  			bpf_log(log, "Subprog %s doesn't exist\n", tname);
>  			return -EINVAL;
>  		}
> +		/*
> +		 * A struct_ops indirect trampoline converts arena arguments
> +		 * before invoking its program. A tracing or extension program
> +		 * attached to the main program would see the converted offset as a
> +		 * regular BTF pointer.
> +		 */
> +		if (subprog =3D=3D 0 && bpf_prog_has_arena_ctx_arg(tgt_prog)) {

[Severity: Critical]
Does this code leave a type confusion vulnerability open for global
subprograms?

This check explicitly requires subprog =3D=3D 0 and relies on ctx_arg_info =
from
the main program, bypassing protection for attachments to global subprogram=
s.

Can an attacker load a struct_ops program that passes its converted 32-bit
arena offset to a global subprogram taking a struct bpf_arena * argument wi=
th
the __arg_arena tag, and then attach an fentry tracing program to the global
subprogram?

In btf_ctx_access(), this loop is skipped for fentry programs because their
ctx_arg_info_size is 0:

kernel/bpf/btf.c:btf_ctx_access() {
    ...
	for (i =3D 0; i < prog->aux->ctx_arg_info_size; i++) {
    ...
}

Would this cause the verifier to fall through, ignore the __arg_arena tag,
and incorrectly type the intercepted 32-bit offset as a 64-bit
PTR_TO_BTF_ID | PTR_TRUSTED kernel pointer, leading to arbitrary
out-of-bounds kernel memory read/write?

> +			bpf_log(log, "Cannot attach to a target with arena context arguments\=
n");
> +			return -EOPNOTSUPP;
> +		}
>  		if (aux->func && aux->func[subprog]->aux->exception_cb) {
>  			bpf_log(log,
>  				"%s programs cannot attach to exception callback\n",

[Severity: High]
Does the WARN_ON_ONCE check in the trampoline linking code incorrectly
validate the attached tracing/extension program instead of the target
program?

In __bpf_trampoline_link_prog():

kernel/bpf/trampoline.c:__bpf_trampoline_link_prog() {
    ...
	if (WARN_ON_ONCE(bpf_prog_has_arena_ctx_arg(node->link->prog)))
		return -ENOTSUPP;
    ...
}

When an fentry or freplace program is linked via bpf_trampoline_link_prog(),
__bpf_trampoline_link_prog() calls bpf_prog_has_arena_ctx_arg() with
node->link->prog.

Since node->link->prog is the fentry/freplace program (which never has
ctx_arg_info populated), doesn't this check always evaluate to false?

Should it have checked tgt_prog instead, so it doesn't fail to prevent
generic trampolines from attaching to programs with arena arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808003938.3486=
067-1-memxor@gmail.com?part=3D13
