Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E249A1A680F
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782348474; cv=none; b=Sl8q5BfZBBlXdpD3FSCT+tlaqcaMrmcuMZeUIBzrlPiga+ByB+NEGqUOo/dJIu4QeFbIR0mAeLvhAxq2hHHBW1sJ0vlgJMKctwGiPsODeTM0MuYOqR9pQ31p7wKqQ5AulEXbRt8rcifY8F2AoswbciPQxm0B9+syRUmVG9ItRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782348474; c=relaxed/simple;
	bh=b91Vb0vfTqTmIx7XZCz2vJpvenmTrm70ehToTwR4yVo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iDZPr/X+ZbMVYImKq3SkGj/qQwQX8NoAJCXFicWgYVFe+Yu7dt9r/YJWq0RloI3u0QnusEmV3klSUmKlUpQlHsvTY4z+QwGg04kW/VChaTjE3YGL7tCn9nPBtbw4NFbTBUkki1truTx+33nGtJi0xZV0XUacnp4MHvopfwTHESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfMykjc3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfMykjc3"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8423f236418so1078408b3a.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 17:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782348472; x=1782953272; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WdahB+I9NZOe5G0Lzjk9Wwsf1tc+Ghs7JEI7HU+xrKA=;
        b=AfMykjc38WhmM6fEEGSxlG1chW78cu60EnqQFAm2mr1znFSBJBltIWjlTYPNJdeaM1
         9fSiGkkz8aRExPpFuefwsnRm1QUX2Cv2yLc8LmGrIxQKpDONcqhFwdouTILtGrDt8CTE
         Mh/gk8J8NOwxa+QsA0DLhWK1zwBfhj45UYRSuyO7HvbrYPfVf/lvE0k97PCJe+NSfryL
         mkMFzz6m84YhGA1ccnGS8qxBbSC3fJ6UDuVKBEn8dRSOTGpL2JFIoAhRm+2dTxnuzscs
         o0O0fAeN+zKYeVSW5XP56kCNMPID+A4tyvLR89beCQx0BM758Hz8FkudyREUQFyIKscV
         R6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782348472; x=1782953272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdahB+I9NZOe5G0Lzjk9Wwsf1tc+Ghs7JEI7HU+xrKA=;
        b=qoQxQrpgfHP9y20twOGXEJASgzHqo88eokckVFtMg0YKWmhQLW+dt/E6bJBD4Ybfk2
         d0zc/pUTtBTnj4id9XlWWrNJZ25sBaqzcK086y6gVdtKBTuh+6LtnW8ZL7ZuEOIVZo9i
         JsMNqJ7m80lWihylwW5GkXwPh7Kgt1FV0tYYozaHO9kY2W3b7cBMCLFcIC1suOhXt6Iu
         N9XQz43NoEM/XKcgvuWtVW1n9FwiZlXo3nXVPvI0q1959gXG33yWhswzMJt1ABqX0xMA
         5IkDMkSW/uYmfBBI3dteLpS2i923xxMKG5GBOji4KXEytb2g16ge7401SQDGiOuMxU+p
         HLdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4SXR2VF8CPlQvfeMyRnyAwCbDjd4FgmPLtoyrdb64QitfSQnyUOkNvlF4wJv2raZ9K9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhW4GSt/IA6PXpiSu2j8vtnCvQuECnDjlWg3CvB/3tyPuTTUzz
	bvZFI0+FJPyxr4Vr7wxFXmBpBsJbxcQOGaD5zEgO9ZUrSMnEzo6lJCmP
X-Gm-Gg: AfdE7cnMuptbqD705D9ggeWm1L4pDdO/03BHf1UtGf5aNWZ57loKCAXX1WLcSqQL0Nj
	L3PKTkU///78nx8/TaQ7Deq0QGrbpZhj/hS7xk54opuJImpsLSHxV2Ccf1D0VtfUCGIoM7kRTja
	UwioCjzUK7kmUFLBW+coxgtRQoBsW3D62BDO7o41hNnRsg4OJU0p5lvsilDnMNaKyL0J8UxuUA6
	U5HDcwi3AgObyzus1qznfJNHpo1Bt+tNzP9k/8Q/4/li5X2jAdP5euBztQzGQwxVXEqFJaQATtW
	qiqy2ovJrx/wtcD9UGFSWUIaA1aAqyPnYapw0/UlVPR8ASspOgfptPDq0BtKxAEC8Fq63O+zMgn
	u+zP+Bv3wIcSn6K4jge3SmHPjN07vclhiwnPDVKlpqixvBmoWeqeYZGZGklfDSa1afyNaMfMcQd
	DZALzBYZnm8MuodCOPr4HkBJWoAI3vr0IfhBY0GA4/OQ==
X-Received: by 2002:a05:6a00:b48f:b0:838:29b3:9ed1 with SMTP id d2e1a72fcca58-845b3bf5544mr547140b3a.41.1782348472212;
        Wed, 24 Jun 2026 17:47:52 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fcc371sm3544618b3a.12.2026.06.24.17.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 17:47:51 -0700 (PDT)
Message-ID: <3f31912d549a6e99c1db812bccb93835d7087a3c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 13/17] bpf: Report Program Structure CFG
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 24 Jun 2026 17:47:44 -0700
In-Reply-To: <20260619205934.1312876-14-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-14-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 22:59 +0200, Kumar Kartikeya Dwivedi wrote:
> Augment selected subprogram CFG validation failures with Program Structur=
e
> reports. These errors are structural rather than path-dependent, so the r=
eport
> focuses on source and instruction context instead of causal history.
>=20
> Cover jumps that leave the current subprogram, subprograms whose last
> instruction can fall through into the next subprogram, and recursive bpf2=
bpf
> call graph edges.
>=20
> Format long jump-range reasons directly in diagnostics.c, and keep the
> fallthrough suggestion aligned with the verifier check by suggesting exit=
 or
> explicit jumps.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 26d37066465f..032b3dc56f2e 100644

[...]

> @@ -136,6 +143,11 @@ static int push_insn(int t, int w, int e, struct bpf=
_verifier_env *env)
>  		verbose_linfo(env, t, "%d: ", t);
>  		verbose_linfo(env, w, "%d: ", w);
>  		verbose(env, "back-edge from insn %d to %d\n", t, w);
> +		bpf_diag_report_program_structure(env, t,
> +						  "back-edge is not allowed",
> +						  "Rewrite the control flow as a verifier-supported bounded loop, =
or load with privileges that allow this back-edge.",

As far as I understand, this error fires if a control flow graph loop
is detected while loading a program in an unprivileged mode.
In such a context suggestion to "Rewrite ... as verifier-supported ... loop=
"
is not actionable, I'd rephrase it as
"Avoid loops for unprivileged programs or load with privileges ...".

> +						  "Instruction %d branches back to instruction %d. This program is=
 being rejected without the privilege needed for this back-edge.",
> +						  t, w);
>  		return -EINVAL;
>  	} else if (insn_state[w] =3D=3D EXPLORED) {
>  		/* forward- or cross-edge */
> @@ -316,6 +328,11 @@ static struct bpf_iarray *jt_from_subprog(struct bpf=
_verifier_env *env,
> =20
>  	if (!jt) {
>  		verbose(env, "no jump tables found for subprog starting at %u\n", subp=
rog_start);
> +		bpf_diag_report_program_structure(env, subprog_start,
> +						  "missing jump table",
> +						  "Provide a jump table whose entries target this subprogram.",

I'd rephrase it as "Make sure that subprograms containing gotox
instructions are accompanied by jump tables referencing these
subprograms.". (or "... derive jump target from a jump table
referencing the subprogram"?).

> +						  "No jump table was found for the subprogram that starts at instr=
uction %u.",
> +						  subprog_start);
>  		return ERR_PTR(-EINVAL);
>  	}
> =20

[...]
