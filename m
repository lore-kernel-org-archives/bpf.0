Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792905049;
	b=kzRuDdTqOcE1j/seRdZ6LF348dDzvgijynYK60HstCLJ6tKtlCGtn7YhzASGuLrgrQrp
	 +qwaw43nH1jN0RojqZ8RQiRLtx+q83QxUcl+o+bQHiAXgk3Ajw9olizeuiNnwxar7QvmP
	 aBLdAljg9piUpXEVnUbkIozy796VyBRGrAmgEC42D+JhaWYIjMH3RsfBpDEB+XoO6H7m9
	 I1dylfgGjlO6kC5BZzSK41dm59bd0Jte9mBUopPjk0FFV+BLpuDyoM7oihJi3bZr+3Aaz
	 KAhKEP3oJQneevwSdZ219YmqFC+SuyXQyBCUjLk8RC69Uiys1jHP46M+HZfZDFwOnog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792905049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=I9HIL3LoF+huKxPct+Fn089zAG/PdllSpNpMVi9VcmI=;
	b=ygBXKFlFoB8wC03YcYS9/JwgOLh0q/lY3g8S28zJobyPj54iD0ZVzgHzca9Xc76k1K3V
	 kGFQoxWtztOQ5qtchdePbBNoyUurlqHK6ohPsyoTLigae6u+h0pG3sNQ0DHTBmE4n9IOA
	 jOtDXeLT+Z25LRfzUXTTLkbPMkl9ZC1R6XcF0X9hZIAtf7BjQFwJiUVakNSypid5aUELj
	 UVe0jgBI1DoRQmNakkB1MQhE/PX3rPggjuR9S4W4sH+nIiCpR5UjAaFidFZrgHNd/fCUV
	 I54P37rp+sdC1PCiNzlCqnZd8Lqr4lZCuU4zX+vRiD+pAhSZugKNagTPQ/4YaK0dlSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q6lUOAKf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D156606A31A
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 05:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D156606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q6lUOAKf
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8b20a899fso11766565ad.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 22:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792905049; cv=none;
        d=google.com; s=arc-20260327;
        b=raZicvOXvnzAtVWUk0Y+k0Qvi5dpxdwLpUsoGe0/Q0UBcLWoXhBSm0hM8xTrtWI0wm
         05n/zvtsvQYOZiXLh244n3jmcwTaJZh9WtzRibRnLX92UThlk+Uk2xdgVXC6fn4KcOGe
         +RGyOwDHWA+pLezLIQlRpwvMKhRJtYNkwgIdy+0LjaEcG6/QTr+HrLQ2h1keQ6Y/ztil
         lUvxrfOWyCK6SR8BSMkXlsu+2k3wQiAfuuAMHDbZfzoxkqdq/wOWofYgqET/InvXE5Gg
         kUJsqVbz/xEGK0LdY8czrIM13pWl8dN5ZTcrt/Nv+bBNQRUsiRTtXJZAIolbAvXefw8Z
         ucMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I9HIL3LoF+huKxPct+Fn089zAG/PdllSpNpMVi9VcmI=;
        fh=bSPJnovnuUroZ2uN1+F9ONA+s4cy/SXPPEI0oSUQ9to=;
        b=mXC5JkeLb4wo6C6dS1F7Uc0i03miW/mp6kWqv4JXe1RB+CBcbjjy4Tkf9zHY/tIyEz
         0CZorZva0LK7/5A9HZ7PLhnou45BHWsalr7gngADPAD70CTn6jmZdBQ2G89DtGQwrmiB
         SX5xpUSm3qm8bki55q5+eZCaJk667/+rVy8fA7R2XP0giTPl6Z8qB6uMbVzblaNsLXAP
         FERNkISOYPUs2+g7/uSGADe+YhS25boloHnzdNdDPM4GhzqjFWeezjts7TYVLtIACbli
         3f1p2SX0J05nrC1KzjVVnKFBVPJAOIT8q4nOWFe4GUmZVQy1W4PX1gTnCc9AleSPw1qr
         480A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792905049; x=1793509849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I9HIL3LoF+huKxPct+Fn089zAG/PdllSpNpMVi9VcmI=;
        b=Q6lUOAKfyFlp+V1zGTNXPJBCHRDgoRq0CSPXMp0fhXRzC75n7MbA3774SpJtdNT18z
         MiukDtWWcgGF8s3FXYiYn7qRU43HLduAB3MvKJK4b+BAXIjDoP2dAvuAzeZuGVtBEpjG
         EG9mr8/ZcKtTEzd496D/evjqGp5Oc3SrZXMKxtXdM46EZikChUV/9WnKb7FBhWIz/rHh
         r10URtDuodiq+KLF2iWUKs4l0OS/exzoVg0HO7aPMzHLc/2PfXTdTRr85T79tXThhplw
         X7pDDd5Qu5N7pKTBaKt04+pK/oPUWFC/U7Z5E5Aj87dpQUrVON4L3BBEPoMjV6LM+AVQ
         6yiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792905049; x=1793509849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I9HIL3LoF+huKxPct+Fn089zAG/PdllSpNpMVi9VcmI=;
        b=W9puq9CniTvv6U1EL7qsBePyAqmaw73yXItZrOOYzBiE9BllwBIrEa1Df0/M/4aL84
         NQ+Hh54vUPVmEbxDrUB+bh4GCfqfmRdv7pmJwtzf973852nvp8mkzj69OCrGgkovWbCJ
         V/2s06uV4YWLGI++4O0Pceo1Sk2TLkSgo6DhgDrJ0Q2AuRJ/mhLpbn4fAooABc9xOUyH
         uIUC4e8AfUzs09RELgyDLklc/sWDF72nUgsRGItcBg6f80a7+pvLhasGcswN1J9NIRTs
         vGsHvs3A1JLPuVr9JDKfFw+la1k+7IrdzOMqRVdAa+KACkXru3+hFUlH9FCIVk1sYCKK
         bQnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdmoyT4LzJynIIOmseh9Oxzh0dePmLSdd+F3mftLGgEl5nhcFncJkQNVyKuS6m2YJtO2o=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZTrvwg/pqV1P3KfVB/J59669uTaruUp8gsMm2UE/KotEb/hqV
	wnzHbgyX1zaabVAN6gLFkxShNk7yxzenYejzaEPelNUXdbyipb2Zj1IutpsbbQ9eN36yCejNEIw
	4hYJAQ7uDuSTTvdI1Q4/CYYJg1U5M89M=
X-Gm-Gg: AYBFou15TWYB7lrRgFMtIQTbzczMlC2SFsvjiQuiQSPQtJEB+reg3Wvxl4MBegIKJDU
	mFKOlOdjxs67cBFeOlvbulmC/r1kV57+jVEF/VW6vN33mWLPBwbvBTw9Q5QhYINdJVasVAUGEaY
	QA/zKMaIFTjfoJBWJxevskJvMansrsFuPpwQukeqYaOB/86gGAtqs45vdNBSsHG3GZLheBJmubB
	scxY60IqYsu+Hf8dpkhha7Xg5sqhaZvqfYeQRqCaKD6lOv4glUn0VzNQUCn/AGEi0lThDy/aO+i
	LpHZf9SPHMZsu23NT+RmVMmO9q66XXB1TBN99S+7U2piwnqjGZBH4Kxfqw7QZI/V8ZX4D1wFANy
	mODVen+Zy6HOM2KjY5PT0HL8mBQ3ul1/jG4+0xCoK56y6/4l6ffohpDzwE+MddautcdYAxqrKCC
	hZ+ZGPjc6wxrteXAP1Ai98rmr1ZJdrgBE1R3jaGsX+h+ONjkZSTQ7Uvdg=
X-Received: by 2002:a17:903:943:b0:2ea:9012:649 with SMTP id
 d9443c01a7336-2ea9c8f2b22mr29297105ad.57.1792905048638; Sat, 24 Oct 2026
 22:10:48 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-scev-simpler-clamp-v1-2-d43a07eda7af@gmail.com>
 <8443794e24eae423d0f499a1d2f24576aa5bb70f6e5f6e015914cb0d1a72210a@mail.kernel.org>
 <4656dc2d7b8749adb9c9b26490a3ef37aea58715.camel@gmail.com> <DMDIJ0LUPMZX.3B6KY51D9ZRB1@gmail.com>
In-Reply-To: <DMDIJ0LUPMZX.3B6KY51D9ZRB1@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 24 Oct 2026 22:10:37 -0700
X-Gm-Features: AclHuK8JbPxpK7Qp2eZDEfR8FS301VIB6GoR_v9NIl1CPBXf1AHANcj6vac-5oo
Message-ID: <CAADnVQLgRWzEnAPJQ7FWZOYWEqYeGaWqQXEvitNaVw8w6oq_3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/11] bpf: do not intersect with current
 register range on clamp
To: Eduard Zingerman <eddyz87@gmail.com>, bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <mason@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 6:03=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat Oct 24, 2026 at 6:57 AM UTC, Eduard Zingerman wrote:
> > On Sat, 2026-10-24 at 00:41 +0000, bot+bpf-ci@kernel.org wrote:
> >
> > ...
> >
> >> Since bisection can land on this commit, could that change be folded i=
nto
> >> this patch or ordered before it?
> >
> > Commits should remain separate for documentation purposes.
> > Full test suite passes on both.
> >
> >> A related question about the end of the series.  cf18840bc068 only hel=
ps
> >> when the current frame has no active loop.  Consider states inside an =
inner
> >> loop that is entered again on the second iteration of a terminating ou=
ter
> >> loop.  current_loop() finds the inner loop in both states, but its
> >> entry_state differs, because handle_loop_entry_exit() splits a new one=
 on
> >> each entry.  So the EXACT check runs, and loop_stack_safe() does not
> >> compare entry_state.
> >>
> >> With the outer induction variable now the same on every outer iteratio=
n, a
> >> program like the one below looks like it would still hit "infinite loo=
p
> >> detected" after cf18840bc068 (with the old code the outer induction
> >> variable was [1..9] on the second outer iteration and the EXACT compar=
e
> >> failed):
> >>
> >>     w1 =3D 1;
> >>     *(u32 *)(r10 - 8) =3D r1;
> >>     r6 =3D 0;
> >> 1:  r7 =3D 0;
> >> 2:  *(u32 *)(r10 - 4) =3D 1;   /* fp-8 spill -> STACK_MISC */
> >>     r7 +=3D 1;
> >>     if r7 < 3 goto 2b;
> >>     r6 +=3D 1;
> >>     if r6 < 10 goto 1b;
> >>     r0 =3D *(u32 *)(r10 - 8);
> >>     exit;
> >>
> >> Is that case covered somewhere I missed?
> >
> > This example is valid. Need to relax the condition in the
> > current_loop() or bpf_is_state_visited().
>
> so you're going to respin it or follow up?
>
> It's fine to ignore CI in patch 3.
> We'll be removing states.c soon.

respin. The better fix is probably:
-               bounds.r64 =3D cnum64_intersect(reg->r64, bounds.r64);
-               bounds.r32 =3D cnum32_intersect(reg->r32, bounds.r32);
-               if (cnum64_is_empty(bounds.r64)) {
-                       verifier_bug(env, "scev clamp produced empty
range for r%d", r);
-                       return -EFAULT;
+               r64 =3D cnum64_intersect(reg->r64, bounds.r64);
+               r32 =3D cnum32_intersect(reg->r32, bounds.r32);
+               /*
+                * The state at the head doesn't know how the
variables depend on each other.
+                * It lets r6 =3D 0, r7 =3D 9 into the loop when both
count from 0, and r7 =3D 10
+                * comes back. No run gets here like that, so any
range is right for r7.
+                * Take the one it has at the head: the rest of the
state is still compared
+                * with the head, and what was pruned on the way here
relies on that.
+                */
+               if (!cnum64_is_empty(r64) && !cnum32_is_empty(r32)) {
+                       bounds.r64 =3D r64;
+                       bounds.r32 =3D r32;
