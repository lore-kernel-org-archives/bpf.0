Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336CB377006
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497007; cv=none; b=gszXrjcpy7mj/OARRxpD6vnSQ+KysFgFzCJSZ7axdcOXPm2QArqtH/nmQnC3VrLsVyGn2P0xBro60dmfX2u88gJBDd+eUiiHAp9J3ax2a/yn8ORHaokt1Z8S+7I5qmAt54HALaMNDhiA9pyIfYYsQ52yz0YZK0fyBR/1vje9tB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497007; c=relaxed/simple;
	bh=PNqfpIFCpzuHm4qqOgei004aiAbRdNH5sHIFWvEgZls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gf0Ors69L3WHjia41NqLzScvoGnXC3Po6wDyEXmrKELah2XghGQ9xIvaveFXofn446CwYwEM9RRh3DHGavlTgrlNz+SufF1WXlR5v3wx/Cgp4SAoYLRXZW8CKjkLDRKgKTBgvsm9nsP30Db/GujWKivNWqv1zNQbx4wuRjbXJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGipapLs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGipapLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55AAC19425;
	Wed, 29 Apr 2026 21:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777497007;
	bh=PNqfpIFCpzuHm4qqOgei004aiAbRdNH5sHIFWvEgZls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qGipapLspUTDiYRZZDvTRWvYyNj3SBO2F1m9tMM1m8HxRfQF1IySoHi1Xlg6Jz2ty
	 M0kodpBgPxRcKFyCYtCttWPFLeUUik/iTZ7OJsCGNoHzrUo0NvG9KTEPoCOVOGutHL
	 09cD/zECMooa6pDqavGUErwMQjwr/AxaBpfgz66nLE+4Ow4OPx1YKT4+unS6Sg5LuW
	 UHA1ZCaaOgzgVO7GHF/N5xCqmhNRvJOSwTAmFzwxa0v9RJ8YLRd1rC4nGOq9g2BCaY
	 rjU/cBKHxiVKUae52GzUiZHK7f1cEkIeO25tsuOkjsioDsjukXFR5CFGZyz8R9M7BX
	 Ga4vT/AzBKtCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 2/3] bpf: Fix s16 truncation for large
 bpf-to-bpf call offsets
Reply-To: sashiko@lists.linux.dev
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429171904.107244-3-tangyazhou@zju.edu.cn>
References: <20260429171904.107244-3-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 21:10:06 +0000
Message-Id: <20260429211006.E55AAC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unprivileged users will see broken control flow graphs and `call=
 pc+0` in BPF-to-BPF pseudo calls.
--

commit c7ae76817147356f188b1975260698d1d9dcd44a
Author: Yazhou Tang <tangyazhou518@outlook.com>

bpf: Fix s16 truncation for large bpf-to-bpf call offsets

This commit fixes s16 truncation for large BPF-to-BPF call offsets by keepi=
ng
the relative offset in the 32-bit imm field instead of downcasting it to the
16-bit off field. It updates the JIT, interpreter, and related dumper code =
to
swap the usages of imm and off for BPF pseudo calls.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 300e4e251931..8947ef74f6a8 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1250,9 +1250,9 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
>  		}
>  		if (!bpf_pseudo_call(insn))
>  			continue;
> -		insn->off =3D env->insn_aux_data[i].call_imm;
> -		subprog =3D bpf_find_subprog(env, i + insn->off + 1);
> -		insn->imm =3D subprog;
> +		insn->imm =3D env->insn_aux_data[i].call_imm;
> +		subprog =3D bpf_find_subprog(env, i + insn->imm + 1);
> +		insn->off =3D subprog;
>  	}

Because this patch swaps the usage of insn->imm and insn->off for BPF pseudo
calls, will this cause a regression for unprivileged users dumping programs?

In kernel/bpf/syscall.c:bpf_insn_prepare_dump(), the kernel zeroes insn->imm
for all BPF_CALL instructions when the user lacks privileges:

    if (code =3D=3D (BPF_JMP | BPF_CALL)) {
        insns[i].imm =3D 0;
        ...

Previously, this only hid the subprogram index. Now that insn->imm holds the
actual relative offset, zeroing it means tools like bpftool will receive an
offset of 0.

Could this regression cause bpftool prog dump xlated to output call pc+0 and
break the control flow graph generation for unprivileged users?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429171904.1072=
44-1-tangyazhou@zju.edu.cn?part=3D2
