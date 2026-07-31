Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ACE23909C
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785532664; cv=none; b=Q57c05YoR6I3OQ0Z/K85SdjQfNbbM/uIcKQ0FwwSDdWUoHyPiGhlEEsiASWDRyNkz9Bvtm/WMfTdpvf5vJzcXWi+ApOEXXVHKemnGv9kZ248MCRIv+zk+ve6XvqjU9rJwvAPYWBdypG4ePcfKURSyW8aLY0RKXjcIF9ZhWaRF00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785532664; c=relaxed/simple;
	bh=6zwdZqsLAxLbpUXAqgCODH4XW7KYd2Pe0HqW4jEuDeU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kFeen2jbJL1aXMrJmAkACttx9IJeib0WcvEQ0Er3jVrizaBB5FazpbNL3dhlKx8gK8eMae13eGesyh/11ryADh1V15vvLaUYLt6odII1wwDCTZPwv4vEG6KwSAUZ1pB2aR6BoM30GJ/JgyihUxLPhb2rQp7vdub7cD9Xf3MgTa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQYqWQyE; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQYqWQyE"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-caf45fc5202so918406a12.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785532662; x=1786137462; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=F1fj8dyyMAmWETpHXezC8DdOLZLfz/lEB4bEENSW9/Y=;
        b=TQYqWQyE2eDV72YZdk2e91VeQtqks2JYWK76jBQvMJWCvDwxCeLhbCqK28NcLLAqVY
         lVxPxahafYK697galX+35Xj4d/gZH41TH0oNhiCWS6f2lTdoxbuux3vWDrp2TI6hRl34
         gP35YZs8y2OdY5wRGvChg+Psz0/bkDaysQ7HhoYqyQ+UB5pFkGbiSLChc0BO5uA8wGlQ
         du4Ut87LnUQ3JtffGaal7UOIstQRnIcuQDgF6QOvhFMRyCFb+zDMQVQSU5kD5BnX9sB6
         8AkhwDcqnH3y1e5U8viGS43lKkT+AbLsX8FiKXGqzSe3H84g7f19HggLb1E+Z7OjRMQf
         QnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785532662; x=1786137462;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F1fj8dyyMAmWETpHXezC8DdOLZLfz/lEB4bEENSW9/Y=;
        b=V9otlap9dhO983+K6HPIFPwqc2VlxjbhpnG6KEsrm78amUowtKB1mLtcL1ppNlXiaD
         0wOiBqlLFkn3/1amHJZ98uYCTDJQbZnIh1av9DQpMzMvGXOZ/1kXo8AlDTl+MEPRfnS2
         DqcdCz62e2RwySSvkU2YoyTmm9sSMpARZDy1dPp5hL0Okrq4fOJRNF7U1U1H5wOw8kPk
         lMhvR9sgo1TrCKrHHg3NBGn/ucbM/gAYT2Xc6LR5h5e9fihbaiglXgX1Hxr4y8dPCC9I
         kv578IUP+Frn+0nuRaVr75Q8MpYwyI0bogabtvtZtVW2PQLItpkq7dniV53HX0vva4oj
         Tqeg==
X-Gm-Message-State: AOJu0YzVKPZ3QjGghMQFXgnEU/5lU+LhpSKkxWkcJZY+7/DyYCYo+auA
	qN1YV2s7H/1tyOsUoBGQK1bi9tTR+8N1cMz3+AU12O5Du30Msyi9pYmCgQ67P4tN
X-Gm-Gg: AR+sD12rMFotpW05Z7pQ1DAE62YjCde+L/uFkjrOc5deOCqB1m+ByLDUGWmHmUo96+7
	cAxTBma5kWv3LTtTai/vP+D64ShHkq2fp6SYVccVvu7uHwosM6haBiyF3LK6ARCVudCCVA4hKks
	hKt7hR7q02IcrouaHBHDhlaLppViKsF5MjasxPd7/dhxfoQEiD1Be4+MJVmdax9jZJ+tuIi2baB
	eE7Sj/v7OtFlBbRrN/9/RRyGdSRfH6ELsihSrzVxqE5Z0ne+YXGt/QXrQS8YwMxV0OGnOiS8Rct
	JRLVKXn/+v+976YzU9qPJYMemH5hwVZi/+2sjV8yUFkFJDFsevS1LGOUSKqm1LTlSCPD8IcKuLs
	QsudT3s+KWUlroFqA1nZI3XEW/dPwYRWORmBLGLC8AwGdXC8rGYE/pCjRNWVKEmqCpzRhT+vHFH
	i1lWcuXHGLkUI3Tu+/JLKgc4n2u5x7THl2V6bU6dYm8GegRN8Emp9yIZDJic5vd79bEjzRpTrFk
	iGIhlVokCin/HsKgyD3Ka/octCylL/UcqNXdZgizG3IYg==
X-Received: by 2002:a05:6a21:7a97:b0:3c0:b3f7:e5c9 with SMTP id adf61e73a8af0-3c92a814022mr1172493637.36.1785532662419;
        Fri, 31 Jul 2026 14:17:42 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f5a6:d314:fc37:ae46? ([2620:10d:c090:500::5:7346])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18d9c6sm9524973eec.30.2026.07.31.14.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 14:17:41 -0700 (PDT)
Message-ID: <bfa89ff4ec80943ffa5567f90779221ff82fa16c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: infer zext_dst based on static
 register liveness analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Fri, 31 Jul 2026 14:17:40 -0700
In-Reply-To: <20260731192635.8B8111F00AC4@smtp.kernel.org>
References: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
	 <20260731-static-zext-v1-3-98a4dc73e94b@gmail.com>
	 <20260731192635.8B8111F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-31 at 19:26 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] Incorrect static liveness tracking for 64-bit conditional ju=
mps leads to missing zero-extensions (`zext_dst`), resulting in verifier/ru=
ntime state divergence and potential privilege escalation.
> --
>=20
> --- Patch [3]: [PATCH bpf-next 3/5] bpf: infer zext_dst based on static r=
egister liveness analysis ---
> commit ab8592d6a434dbfed0cbb0bd067d9032b308db8d
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: infer zext_dst based on static register liveness analysis
>=20
> This commit replaces the dynamic subreg_def based zero-extension
> tracking with static liveness analysis to correctly infer zext_dst
> and prevent missing zero-extensions on architectures like s390x.
>=20
> Link: https://lore.kernel.org/bpf/CAGKGUv=3DsOuqQtA1Ub-5JXfA4FPosJFYKAQE4=
B79cK+P1erxqtg@mail.gmail.com/
>=20
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index c996b8a03e792..ea002550671a8 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
> > @@ -2317,9 +2318,18 @@ int bpf_compute_live_registers(struct bpf_verifi=
er_env *env)
> >  	}
> > =20
> >  	for (i =3D 0; i < insn_cnt; ++i) {
> > +		int def32 =3D bpf_insn_def32(&insns[i]);
> > +		u32 out =3D state[i].out;
> >  		u32 in =3D state[i].in;
> > =20
> >  		insn_aux[i].live_regs_before =3D mask_lo(in) | mask_hi(in);
> > +		/*
> > +		 * On architectures where 32-bit operations do not reset upper halve=
s
> > +		 * of the registers, the verifier needs to zero extend a destination
> > +		 * register if an instruction defines a 32-bit subregister and the
> > +		 * upper half of that register is alive after the instruction.
> > +		 */
> > +		insn_aux[i].zext_dst =3D def32 >=3D 0 && (mask_hi(out) & BIT(def32))=
;
>=20
> [Severity: Critical]
> Does this code correctly evaluate liveness for 64-bit conditional jumps?
>=20
> The new zext_dst logic relies on mask_hi(out) accurately reflecting if th=
e
> upper half of a register is alive.
>=20
> However, looking at compute_insn_live_regs() in kernel/bpf/liveness.c for
> conditional jumps:
>=20
>     const u8 class =3D BPF_CLASS(insn->code);
>     const u8 code =3D BPF_OP(insn->code);
>     ...
>     case BPF_JMP:
>     case BPF_JMP32:
>         switch (code) {
>         ...
>         default:
>             def =3D 0;
>             if (BPF_SRC(insn->code) =3D=3D BPF_K)
>                 use =3D dst;
>             else
>                 use =3D dst | (code =3D=3D BPF_JMP32 ? src : src32);
>         }
>=20
> Can the code variable ever equal BPF_JMP32?
>=20
> BPF_OP() extracts the operation code (which is a multiple of 16), while
> BPF_JMP32 is a class (0x06). This means the check code =3D=3D BPF_JMP32 e=
valuates
> to false, and the source register usage always falls back to src32, even =
for
> 64-bit jumps (BPF_JMP).
>=20
> If a 32-bit operation defines a register, and it is followed by a 64-bit
> conditional jump using that register as a source with no other uses of th=
e
> upper 32 bits, the upper half won't be marked as alive.
>=20
> As a result, zext_dst wouldn't be set, which could lead to the JIT skippi=
ng
> the mandatory zero extension. This would cause the 64-bit jump to compare
> against uninitialized garbage in the upper bits, potentially allowing
> out-of-bounds access.
>=20
> Should this check use class =3D=3D BPF_JMP32 instead?
>=20
> >  	}

This is the same (real) issue as reported for the previous patch.
