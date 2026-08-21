Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F237E5EF
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787352869; cv=none; b=ivjXMq11zh5IBpMui9JF1HdKy00sq+zXYYgO/6TNKRtWAM5dtMUuAHX1FPS0FCI3ChkQs3BL+NPl2ZW/Vk//5ninXzroMVl1yG/p+aBZfn7aecHsphoBgsp13LBwxt3TTgkX+HgloANR5n2x7J4TRYCQkPH6OnQ6CKrXrjGX5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787352869; c=relaxed/simple;
	bh=fhmG/PdQsc7hwgynJ4oQHd3jF5f+hsJnUmoAbiQDwQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hRWdLEA0J9e8a7fkRopBfs2ml4unOSy2GxElgHEwi6gueNCtZSOQC2WlC74LDg1Q50oQZR8uO0Qfb1fAqT0DWkXl8pIeFYy/tvr0imwmnreVa+gkXiBZUq1dmOYWx0XqUgKPB9GomuF+B3GsxXPYz0NIqlSfyWqOnz2jO9UaS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZluiF9ad; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZluiF9ad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09F41F00A3A;
	Fri, 21 Aug 2026 22:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787352868;
	bh=3Lwb+jAY66yb6bVipv/lytm1DLRs7O1ZaNU54pih/tw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZluiF9adw1C9DzQxzu1lFxn9FjBoRpn503HfpPvOpGymKWkRyKWB/cWLwcLj06mPs
	 JC/Cfa0ggXo5Fjf2mZP6pO54VIAL8pY5k+y70gN2gJiSM+/NSUWfwvDbTnd/sFXmsm
	 /H+HGOTKg/Gnx83JHI7akXXx80BX8P/kYmVWtk36RJVGXVANnmLUppwximFYn2Hhvf
	 R0z7BoTRp03wuxENCF/Psxek6ivEBIY3u9Z3qDrIhjvMNK+yLyA7fPxQl5Quez+Jid
	 h6MPN4xO5w59FdHXDDDAt7ulibCwkr0u1vMisHlsNKMhekJ6hhc9G0DmGG2/y+mVhQ
	 tLEgerkVTKzBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 1/9] bpf: mark instructions accessing
 program stack
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260822-kasan-v7-1-99afee6ef7fd@bootlin.com>
References: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>
 <20260822-kasan-v7-1-99afee6ef7fd@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 22:54:27 +0000
Message-Id: <20260821225427.D09F41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The `adjust_insn_aux_data()` logic leaks the `non_stack_access` fla=
g onto non-memory instructions when a patch entirely drops the original ins=
truction.
- [Low] Duplicated original instructions in a patch sequence lose their `no=
n_stack_access` marking.
--

--- Patch [1]: [PATCH bpf-next v7 1/9] bpf: mark instructions accessing pro=
gram stack ---
commit e45a03bdb90ce436777e9a9558206c04d0705394
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf: mark instructions accessing program stack

This commit adds tracking in the BPF verifier for load/store instructions
that access memory other than the BPF program stack. It modifies instruction
patching logic to retain or conservatively mark these instructions to aid
JIT compilers in emitting KASAN checks.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 65b441e4a3517..edcb0cbbb13de 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -239,8 +259,25 @@ static void adjust_insn_aux_data(struct bpf_verifier=
_env *env,
>  		/* Expand insni[off]'s seen count to the patched range. */
>  		data[i].seen =3D old_seen;
>  		data[i].zext_dst =3D bpf_insn_def32(new_prog, insn + i) >=3D 0;
> +		if (!memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
> +			data[i].non_stack_access =3D
> +				data[off + cnt - 1].non_stack_access;
> +			data[off + cnt - 1].non_stack_access =3D false;

[Severity: Low]
Does this logic correctly handle patch sequences that might duplicate the
original instruction?

If a patch duplicates the original instruction, the first match correctly
inherits the non_stack_access marking, but then actively clears the source
value by setting it to false here.

Any subsequent duplicated original instruction would then inherit a cleared
false marking, leading to missing KASAN runtime instrumentation checks for
that memory access.

> +		} else if (is_mem_insn(insn + i)) {
> +			data[i].non_stack_access =3D true;
> +		}
>  	}
> =20
> +	/*
> +	 * Last slot instruction could be a newly generated
> +	 * BPF_ST/BPF_LDX/BPF_STX, systematically mark it for non-stack access
> +	 * if it is not the original instruction, otherwise keep the
> +	 * original marking
> +	 */
> +	if (is_mem_insn(insn + off + cnt - 1) &&
> +	    memcmp(insn + off + cnt - 1, original_insn, sizeof(struct bpf_insn)=
))
> +		data[off + cnt - 1].non_stack_access =3D true;

[Severity: Low]
Can the non_stack_access flag leak onto non-memory instructions if a patch
entirely drops the original instruction?

A preceding memmove copies the original instruction's marking to the final
patched instruction's slot:

	memmove(data + off + cnt - 1, data + off,
		sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));

If the original memory instruction is replaced by a sequence that does not
contain the exact original instruction and ends in a non-memory instruction,
this final check fails to reset the inherited true flag back to false since=
 it
only evaluates is_mem_insn().

While the leaked flag is currently benign because JIT compilers exclusively
evaluate the flag for memory instructions, it seems like an unintended state
for the verifier auxiliary data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-kasan-v7-0=
-99afee6ef7fd@bootlin.com?part=3D1
