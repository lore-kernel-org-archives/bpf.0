Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86CC3A0B1D
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946673; cv=pass; b=Dy7Iy/tGGaRSRPQr8on/idHlnLJK2MlS2XnH0FmeUcYgTxne+GV2XcANXOZ+vUZZZMQ+mRQoXjZFeJELr+2nQ+pJnvYCv9Sjn5toWJ5tii2jrQdPqDcV6ArQvrrT8esyajW/Vx08RvVGBbq/NlhRNXyAtB9XI4xHYbFghfJN8xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946673; c=relaxed/simple;
	bh=lYrSPjhiu5wxwbr+f+yUlZlwwnL6GbkjrbQSswSGkEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnimNg6fzMa2u8V/nP6g2tmWZvhwGqjbdR0ry2XFew3ur2Ob0mtmaSM37A8dVSGwyp0/U1uIWzbe2zPmfKW95GN7+6d1AXW6ZU9SF0EJAj6Oemn7+O8fPHsPw9rTGbXeH3SOJxVYOaDJIOpp0Wk+czQ/67Q6N9XgbREJhPSsp60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoP5pESr; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoP5pESr"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65807298140so8437826a12.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 07:24:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771946671; cv=none;
        d=google.com; s=arc-20240605;
        b=iWf4BTkcqmVBrPChXgHj4jwHe1MYcfsi/s1i0CKw4G6+eah+Vm+xsZTeuj/DTN7igZ
         UCjqyCmvzOHif1e9fQATU8/XHnsNDYn8pA/BzTvD6ykDf6+wZrm9AgtNPyD2Ak9eudps
         6S2H4OuD35n+V6vw+7V0bQZGjlJhNSy/CK/ltjswzao5mZXA3qUslMEyfwnnLNWb7MmH
         DZetbX2+yL1QfBrFCSvMDsgZdbpO9lwM/hXne/68H2A0N21XVip0/eYOtlrq23nR2ITO
         7Jttet2eYacvJ2UN9sIBjrZJXH4vXXxflkHMFvC655+rsmV1clxz36Pfj6geWKUb3NtR
         no8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eWgDvrMcY9filToDUtVYqT6eFb4pJkMZLJUawfSogpk=;
        fh=cKMUHX+7uaxJJpnCJTUj05r6u3b5LIa8H8LPnjF8mDI=;
        b=c9P5eR/v4SOK6w4i3zEuCGAt7YVSHm/HPvlMomPmOmytwILHGqnDulkJfZq7+N97kO
         vWgL+iBfzExQBghbcET//zD1CwiGQMexeDtgnwJdskbFLjO80vb3VLJT1Kxn3LAMAOY5
         vAZO5iUEECxGWPd5tQg56mnFqYjMDSx/MlZiljVGb9q18S1eZPH/KL/n3R9TD6miJnHd
         e8KMN4XYYM5YAWJu1dH//GzZBB+3BdAUCLxohFh9zOZF9ujiIuroB/IC7p6+5otIi6SV
         Jnp6DSGLFAEEk3naJ4TrKx8b4lKXjUSnR3Fi8s3YyImdLBMtcB36DAWPd3Au+8IqV7It
         gNZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771946671; x=1772551471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWgDvrMcY9filToDUtVYqT6eFb4pJkMZLJUawfSogpk=;
        b=eoP5pESr8tAJKSa+KiEMBimqpVTo9uP34JlCIm134+M0H7gvCJ0tJU/hAP/NtZ4pHn
         prGk7lhN4hkTlLZ52Hls891EK/5U+Ikd2l2t5aAMFO1ZraaIrcQwkUef1gXpZJwM8S8O
         MivTo1Mw/VCCpZqjK4Cw7EmC/BbFv1tL0OJpAV9l3EjGuvrSIWmtWYEtMXGTDbo30kbT
         8yiFZfl+P47CryT/ZLzydVW9GvZFuLwW5k3W62p1tbVDfaF5JOPHvSsGpL8KEBr+QbNw
         VzW9vu/A4esZdYTC8kQHd5KHWXtDb/q5NiKnQY89WM0eoW5MyN+zgmELRkX0vczNAIlc
         Wb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771946671; x=1772551471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eWgDvrMcY9filToDUtVYqT6eFb4pJkMZLJUawfSogpk=;
        b=mF37vdZzLYkOnnpMIZ1ylKAKCKje4yYcnaI73nV36BTQshQ3yPQ0cYmsH2HsFp+j7Z
         aiq8EqXSHF5IHDzEiXLezQRo5LjTZygtafXDLYjrD6Y09UIwRtmac7lCfecM4g8W/gpC
         nm7TKa/7r/ZysE3Srf+j6UAzwwPU0ddTA7XxSr2ujyWNM1ubXYCVGgL1II2P+NxCU2qU
         iSwOVEX98jsMnG4bwUr3LHtmo5PpJnwYpkboshsVkdgPMeyOpg9zgSjU2oS//DdW3GMT
         /NDoEXHh9HJziwX0GtWaSbdMki9f11hE3vv5YK/H/Vjc5JjqUqsQ5sb0BW212V3hy2A8
         V/8A==
X-Gm-Message-State: AOJu0Yw5MxdkhikdaLn9trM2Qe8h5L2sOpxhfpSb0gUwvEUuEBSKR0HS
	dAbXXB7MWf3ixmM1vcREJeZ1aPcSXYFNujijjSYdIIuvt+3uIrJyg2fgbCQ390CVz0CpzF6RfHq
	lhoGWFK+Ck00RByTw9Tvp9E5xx3xTjqmfo0P8lR0=
X-Gm-Gg: ATEYQzz3jvq5SswRIBWu3bakznQvvRMn7BAuqC6NzcyIWxOTP5gCJH2al3unwDTTVtd
	WO2RmMuhwbRXe2I34iVBvEoGv2aVWE6wKqRfeBUJpyGbA8VdV+9ykEGG2sDiJhHruN81tz55vC0
	Xm4MOzpB3gt/Zy/K7/umptLTlX7gnHHI2keh3kt0GBI+ofAINdnnnt4waghxxr/mdyngKX2TZXz
	GAZatvZNXRqaNhWnCKg2DO6tz6Zl0GQNE6h/RHNxQ/a6/t8bAa04rMcaq9UjMg3Obp6eeMiVvmT
	EipCdfnTdxr938vShyO+bd9gMat3TDUc
X-Received: by 2002:a17:906:eec7:b0:b88:68b6:e578 with SMTP id
 a640c23a62f3a-b9081a56f6dmr865051266b.25.1771946670707; Tue, 24 Feb 2026
 07:24:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223174659.2749964-1-puranjay@kernel.org> <20260223174659.2749964-4-puranjay@kernel.org>
 <562fc6aeef17412ba8965bc4938fe9c0dbbe0f9e.camel@gmail.com>
In-Reply-To: <562fc6aeef17412ba8965bc4938fe9c0dbbe0f9e.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 24 Feb 2026 15:24:16 +0000
X-Gm-Features: AaiRm50jnE3R-X4Ci0IozwHDfovuQLwy_77um5GtfTrKHFUFe5K1VwTWWG8Hxy4
Message-ID: <CANk7y0gjg4tCcDvoK7nwcjw-w2aPtjDiJCdPvqRHS0Wvce2wiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add KF_FORBID_SLEEP modifier for
 KF_ACQUIRE kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 10:15=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2026-02-23 at 09:46 -0800, Puranjay Mohan wrote:
>
> [...]
>
> Would it be possible to move regular spin locks to similar semantics
> (reference forbidding sleep)?
>
> [...]
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 4872d2a6c42d..65327d2f19c1 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -8644,6 +8644,9 @@ static int btf_check_kfunc_protos(struct btf *btf=
, u32 func_id, u32 func_flags)
> >                       return err;
> >       }
> >
> > +     if ((func_flags & KF_FORBID_SLEEP) && !(func_flags & KF_ACQUIRE))
> > +             return -EINVAL;
> > +
>
> Are you sure this check is necessary?
>
> >       return 0;
> >  }
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c2a63f8c8984..a90c3d1b2d72 100644
>
> [...]
>
> > @@ -14214,6 +14228,11 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >               return -EACCES;
> >       }
> >
> > +     if (sleepable && env->cur_state->forbid_sleep_count) {
> > +             verbose(env, "sleepable kfunc %s in nosleep region\n", fu=
nc_name);
> > +             return -EACCES;
> > +     }
> > +
>
> Instead of adding this hunk please do the following:
> - add a refactoring patch as in the attachment;
> - remove the following check from do_check_insn():
>
>   >   if (env->cur_state->active_locks) {
>   >       if ((insn->src_reg =3D=3D BPF_REG_0 &&
>   >            insn->imm !=3D BPF_FUNC_spin_unlock) ||
>   >           (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
>   >            (insn->off !=3D 0 || !kfunc_spin_allowed(insn->imm)))) {
>   >           verbose(env,
>   >               "function calls are not allowed while holding a lock\n"=
);
>   >           return -EINVAL;
>   >       }
>   >   }
>
>   Relying instead on `sleepable && !in_sleepable_context()` checks in
>   check_kfunc_call() and check_helper_call(). (As one more refactoring pa=
tch).

But removing the above hunk has other effects, this check is not just
about sleepable but all function calls under bpf_spin_lock. Do we want
to relax this now?

>
> [...]
