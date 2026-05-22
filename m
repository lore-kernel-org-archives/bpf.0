Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE703176FD
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779488924; cv=none; b=WPprWugzgA5iy930rngbL0UKaRmBnlzgYV3yIZlNlFNoEHphZGBtRcrIomJIbfO+GW1mrHovCz3pOl1+ffSW/qni504+VfIIcbhUnWgc5R1l70YyvKykXrtBJ7vSib3L1bncIm2QEitFMppPKubgLOaD3W7Z58a2ieJwW7haWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779488924; c=relaxed/simple;
	bh=NRwZvznJzH0wq328bqmIASK2sKxWsixEWSLdqwJPTHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=alG+FLGtkvv5l6A8hVPvoZOWGjpMREcD3fAORqxFUNhdhB6+IS1UWoi5S0to8HzvtOfr2QYLuUxpHJ4qa/f8VBN2qoJ0vYyT8I8f07LiwT+247oSea6fjR4UNlFGR4j+4gCmsU+MOarXmVmI2K1i9xSV13iwSiH+u9ft7E8D5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu1jHVlO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu1jHVlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5671F000E9;
	Fri, 22 May 2026 22:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779488923;
	bh=hKadN3YJ4npM4zkhkThipZRmRzJ9w0E2MrJte5rNPt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fu1jHVlO2tSU+J5cXThoFrkCSP7cErDJYbaXiYM01fhzuzbyqydaJpKgzytQHRKm1
	 uEEO5VCgsszhCSqz4BsDMUfT72oPniQOSe0YPRWTOWuSqjvb5wbHsiuf6m8bBRvoLs
	 z7RRDV3pKJK25q0eDuQurkwWhfoqfN7/nx9TMuoLG5z6Oz4Dd0xRY/Nu+uTWGhQpe3
	 ReWlk0vP/ZLurZPpg7bRnY94JHLeVRD8udARH37Yr9JWB5FSz6hRECfVduvQEVGmzB
	 70QtpTReXEuyg8hFnQAL4vx1v4tzy5E/rBawkWVsauvQJRJ7pNGkr3wWpg3MRWp1pl
	 tDTkYlKg/xQSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] libbpf: fix off-by-one in
 emit_signature_match jump offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "KP Singh" <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522215337.662271-2-kpsingh@kernel.org>
References: <20260522215337.662271-2-kpsingh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:28:43 +0000
Message-Id: <20260522222843.9C5671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional execution of `compute_sha_update_offsets` in `bpf_ge=
n__finish` leads to NULL pointer dereference, Heap Out-Of-Bounds Write, or =
Use-After-Free on error paths.
--

commit 7b5c3c90020ee6b64fbfb4b7121cda7da5a9c379
Author: KP Singh <kpsingh@kernel.org>
libbpf: fix off-by-one in emit_signature_match jump offset

This commit corrects a jump offset calculation in emit_signature_match() by
accounting for the previously emitted MOV instruction. It also removes a
redundant self-loop when the offset is out of range, relying on gen->error
to flag the failure.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index cd5c2543f54d8..9478b8f78f260 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -592,13 +592,12 @@ static void emit_signature_match(struct bpf_gen *ge=
n)
>  		gen->hash_insn_offset[i] =3D gen->insn_cur - gen->insn_start;
>  		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_3, 0, 0, 0, 0, 0));
> =20
> -		off =3D  -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 -=
 1;
> +		off =3D -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - =
2;
>  		if (is_simm16(off)) {
>  			emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
>  			emit(gen, BPF_JMP_REG(BPF_JNE, BPF_REG_2, BPF_REG_3, off));
>  		} else {
>  			gen->error =3D -ERANGE;
> -			emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));

[Severity: High]
This is a pre-existing issue, but I wanted to ask about how gen->error
is handled once it is set to -ERANGE here.

Since the emit functions become no-ops when gen->error is set, gen->insn_cur
stops advancing. However, gen_loader functions like bpf_gen__init() and
bpf_gen__prog_load() return void and do not propagate this error back to
the libbpf load paths.

Because of this, does the loading process continue and eventually execute
bpf_gen__finish() unconditionally?

If bpf_gen__finish() calls compute_sha_update_offsets() without checking
if gen->error is set, could this cause memory corruption? With gen->insn_cur
stalled, gen->hash_insn_offset could point exactly to the end of the
insn_start buffer.=20

When compute_sha_update_offsets() then writes to insn[0].imm and insn[1].im=
m,
could this lead to a heap out-of-bounds write?

Additionally, if a memory allocation failed earlier setting gen->error to
-ENOMEM, realloc_insn_buf() might have freed gen->insn_start and set it to
NULL. Would the same unconditional execution path then lead to a NULL
pointer dereference or use-after-free?

>  		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522215337.6622=
71-1-kpsingh@kernel.org?part=3D1
