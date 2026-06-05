Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E82EEE94
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642295; cv=none; b=oM5nGcodaK32JgTiyE+FC3cHMaql5hKyvaDMFx0uNrSZO+Y4oK2b46LYRMitQ8FLDtanC7EpmzWrIiuA8wsPSD8cLcL5Z0vmI2C279yAVNrsnSAOfpzJmmtNOt9+j+e1LTc3HChEsFLhbRatte65xZ9RwyIxGuJGl5SpgzipQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642295; c=relaxed/simple;
	bh=YDoWJX8vttbQUOSP1FEzKoxi2LyJ7iF07itRCzVWO8o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PgP1Vy+mnnFeQkg0132liQtiTBDEAc32PepakvcSPzMLr3A3r2mgYk7KKmFEuNxd0cTjhsLfQqfMLB56d0G22JWa0FEa8Y/hoQdm9OMjZ2Znh/uK/wbTLT8yjb3dpN24zuVKW/IGR1pOW5ebg1Id1OuuzXHoDYbwZ9B+fb0fiOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPQ5fvgT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPQ5fvgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6CA1F00893;
	Fri,  5 Jun 2026 06:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780642290;
	bh=W92OzjYBKA86UozxWOmt5HG4X32IEKQLkvx1BWGkgjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DPQ5fvgTmJlJ5BcIL3ji+n2fKszwwIm7EwsMkKCL5qJ/Uhddj+8j4XjspZp+iY/yw
	 C5/z9ZJWSnmwnVyjDFbbNpaxW0PV683gv4ABS0ABgZqT/ZVAURszkgyZwlN1x7grHX
	 kgdX+heLP0SCMp6BocohOmjbiCoNjv5NX/mtcwr0kiW4UmGCNgSmY4PMeSgOTcT8wZ
	 LZxmY7R238eQBt2ZJDHiIzt7wOe/yAUNz/ML91h/Ve1ZmQqexiDrtDzTMPcSmyinAW
	 FW6sICWS/nXXDEPoGZRq38t3BSVbiBmzKpqN6SJ9eWBNYAtpkkplTVn9+yX9ip9RaG
	 aW+aGujAprGJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 13/17] bpf: Report Program Structure CFG
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-14-memxor@gmail.com>
References: <20260605063412.974640-14-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:51:30 +0000
Message-Id: <20260605065130.BB6CA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `reason` stack buffer in `check_subprogs()` is undersized an=
d will truncate the diagnostic message for moderately sized BPF programs.
- [Medium] The newly added diagnostic suggestion explicitly advises users t=
o use `throw` to end subprograms, contradicting the verifier's actual enfor=
cement logic.
--

commit 18889a5137c9a55cdba7f071532572199ed7120c
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Program Structure CFG errors

This commit augments selected subprogram CFG validation failures with
Program Structure reports. It covers jumps leaving the current subprogram
and subprograms falling through into the next.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e30d79149cc7d..325c162e3df0d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -2879,6 +2879,7 @@ static int check_subprogs(struct bpf_verifier_env *=
env)
>  	int i, subprog_start, subprog_end, off, cur_subprog =3D 0;
>  	struct bpf_subprog_info *subprog =3D env->subprog_info;
>  	struct bpf_insn *insn =3D env->prog->insnsi;
> +	char reason[160];
>  	int insn_cnt =3D env->prog->len;
> =20
>  	/* now check that all jumps are within the same subprog */
> @@ -2907,6 +2908,15 @@ static int check_subprogs(struct bpf_verifier_env =
*env)
>  		off =3D i + bpf_jmp_offset(&insn[i]) + 1;
>  		if (off < subprog_start || off >=3D subprog_end) {
>  			verbose(env, "jump out of range from insn %d to %d\n", i, off);
> +			scnprintf(reason, sizeof(reason),
> +				  "Instruction %d jumps to instruction %d, but subprogram %d only co=
ntains instructions %d through %d. A branch target must stay inside "
> +				  "the same subprogram",
> +				  i, off, cur_subprog, subprog_start,
> +				  subprog_end - 1);

[Severity: Medium]
Does this code risk truncating the diagnostic message?

The format string contains 142 characters of static text and accepts 5 inte=
ger
arguments. Because BPF programs can contain up to 1,000,000 instructions,
instruction indices can take up to 7 digits.

Formatting these integers can add up to 31 characters, resulting in a string
length of around 173 bytes.

Since the reason buffer is limited to 160 bytes, scnprintf() will silently
truncate the output and the user will see a cut-off diagnostic message.

> +			bpf_diag_report_program_structure(env, i,
> +							  "jump out of range",
> +							  reason,
> +							  "Keep branch targets within the same subprogram, or use an expl=
icit subprogram call.");
>  			return -EINVAL;
>  		}
>  next:
> @@ -2919,6 +2929,13 @@ static int check_subprogs(struct bpf_verifier_env =
*env)
>  			    code !=3D (BPF_JMP32 | BPF_JA) &&
>  			    code !=3D (BPF_JMP | BPF_JA)) {
>  				verbose(env, "last insn is not an exit or jmp\n");
> +				scnprintf(reason, sizeof(reason),
> +					  "Subprogram %d reaches its last instruction %d without an exit or=
 jump, so control could continue into the next subprogram",
> +					  cur_subprog, i);
> +				bpf_diag_report_program_structure(env, i,
> +								  "subprogram can fall through",
> +								  reason,
> +								  "End each subprogram with exit, throw, or an explicit jump tha=
t keeps control flow inside the subprogram.");

[Severity: Medium]
Will this suggestion mislead users trying to end their subprogram with a th=
row?

The newly added suggestion advises users to use throw to end subprograms.

However, the immediately preceding logic in check_subprogs() verifies the f=
inal
instruction using:

    if (code !=3D (BPF_JMP | BPF_EXIT) &&
        code !=3D (BPF_JMP32 | BPF_JA) &&
        code !=3D (BPF_JMP | BPF_JA)) {

This condition does not account for bpf_throw(), which is a kfunc and evalu=
ates
as a BPF_JMP | BPF_CALL instruction.

If a user writes assembly following the newly provided suggestion and place=
s a
bpf_throw call as the absolute end of their subprogram, won't the verifier
still reject it and print this exact error?

>  				return -EINVAL;
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D13
