Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98743B3F6
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525521; cv=none; b=pY5OWkeipRr+IasIeLP99751J3nbxwynutlKTsdDea3Kf9ckj2nbbXd9WiPT9tFUkSonvJ1s/5Grw67QM5mFdz9n4UT5Obfr4DgN0kayjHzmGNjtar8tTu/LNV6d5qxJFsPlTSB2Iitiky0g/mQ1DEwORUkPEy8pyX6NUSyfKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525521; c=relaxed/simple;
	bh=Yx1IgN4R30ElhArM4ryMQ1OzO0RSQLbgTT/+qqqLPJs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u17g4l53GmbUDwF/TeK2Cng4YdUzxUcACEI/oZELHurURtof6snNl+UGEhapF7Mhf/A6ya5zi3Spy/utkYgw10vklp3uauYiDXQBBSUMBVPnMrht4zt7QrWAwROvywC6YIMVK5wcw65n7UsRUys0TAPmjmZEQIrjxWZUYPipDyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAJA55Dr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAJA55Dr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5E01F00AC4;
	Fri, 31 Jul 2026 19:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785525519;
	bh=KBTqYkUct7oG/x+YuHFxMEAWSVzBOsiweBRKjgAQ854=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lAJA55Dr1tk5u24nQynejs8g/maKI+NK0lDlo9wtZcxwy/W3ugc91Hey25k0pQr4n
	 GHlpT2ZjMilEL4HfZsqCMK80mYj22OnWJzHdM9avsDC+L8twZipnwojphvKWyMgHMg
	 91Id5VjNwEo53BNv9m6mzaxaAhggnrG89hlA9nM8ckXOY+KlQlUbqiNb40q3VF2Qi9
	 aPT5m9L5vxckYLtxWzJIepPcVBm6USU0qKULrwGgHwUDjpaFKHMmlRfG0vzqV7e6L0
	 7FE/nxZ7tarMrT3j4qGrSCc9/8e0QIIhxKCVUgcnh/MyCCp+33luUY8Prp/o16xUap
	 Pahl0OMtswUzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/5] bpf: track upper 32-bit register halves'
 liveness in compute_live_registers()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731-static-zext-v1-2-98a4dc73e94b@gmail.com>
References: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
 <20260731-static-zext-v1-2-98a4dc73e94b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 19:18:39 +0000
Message-Id: <20260731191839.AB5E01F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Critical verifier bug in conditional jump liveness tracking ca=
using missing zero-extensions.
- [Low] Suboptimal liveness tracking for 32-bit conditional jumps causes un=
necessary zero-extensions.
--

--- Patch [2]: [PATCH bpf-next 2/5] bpf: track upper 32-bit register halves=
' liveness in compute_live_registers() ---
commit 977deff7b46d8e36a957595add75da7e58a91c59
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: track upper 32-bit register halves' liveness in compute_live_registers=
()

This commit extends compute_live_registers() to track upper and lower
register halves' liveness separately. It uses 2 bits per register and
updates compute_insn_live_regs() and kfunc call processing to infer usage
based on BTF type sizes.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index ff1e68cc4bd1c..c996b8a03e792 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
[ ... ]
> @@ -2174,17 +2228,15 @@ static void compute_insn_live_regs(struct bpf_ver=
ifier_env *env,
[ ... ]
>  		default:
>  			def =3D 0;
>  			if (BPF_SRC(insn->code) =3D=3D BPF_K)
>  				use =3D dst;

[Severity: Low]
Does this unconditionally apply the 64-bit mask for 32-bit jumps?

Because dst is defined as the 64-bit mask, using it for BPF_JMP32
conditional jumps incorrectly assumes the upper 32 bits are alive.

Could this trigger unnecessary zero-extension instructions in the JIT?

>  			else
> -				use =3D dst | src;
> +				use =3D dst | (code =3D=3D BPF_JMP32 ? src : src32);

[Severity: Critical]
Are the conditions and logic for tracking 64-bit jumps correct here?

The variable code is derived using BPF_OP(), which masks out the class bits.
Because of this, it will never equal the instruction class BPF_JMP32,
making the condition always false.

Additionally, if this were checking the class instead of code, it appears
the branches of the ternary operator are reversed. As written, 64-bit jumps
always evaluate to src32, marking only the lower 32 bits of the source
register as live.

Could this cause the verifier to incorrectly omit the zero-extension flag
for the preceding instruction that produced the source register, potentially
leaving garbage data in the upper 32 bits during 64-bit comparisons?

>  		}
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-static-zex=
t-v1-0-98a4dc73e94b@gmail.com?part=3D2
