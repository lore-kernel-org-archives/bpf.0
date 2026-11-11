Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794394702;
	b=KpIWUCObPl71wCQTy2tVBwEmuSdhowqvVQSNHE6guP6rPTpUDeZxRbSZ1LM9e9hOu/7h
	 hJRWoS7p5SQZtFI85BzupK1MlPYH72igIayPK0PFmhbwNDsSmV/MVnMH9unCMPjhqYdvt
	 U8We6yqgrg/CWcHcxOf5O0rGcQeXvB8WfFP8Kinr3VD4yatGS/u6pgCziJyHjkETNLC64
	 urrQ1I5M9CLddJjOmOm+xF56r2aSpN2B6tp9GFhdYHsvCZ/WHSYRSQ50lRVdYxaZj/RFt
	 uf8znz7Cfc5C2RSPU54T9p26B0A904JwFACwVXDdufFM/Q1KeaMxIUWcQ8jNPdphk0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=jSNboseJHmMbjWA7WKSfZ1vyDpr+PcUdD6zBvgewwJQ=;
	b=u0ZRamCAfT0CFqYPyRh8r9kCMRIB6YWJ6BfSAXFEGLvXbAeDpk/SWWldFn9JMeRjxyoS
	 WosE/O4TXjTr66Pudg39MS4iGqlsN6Mkh9sS9FtoEriLlHCAoGAbWYDZBNdYU5cVmlYmH
	 ty+6X+3FGrwer9jTAOF2wvFzumcGbTH8heBpx28Nqc552XPwLfOygdvpy7Dz/mH3kexbw
	 uCsb87tJSxEzvPykhHAomI19QN0Wmc6H7xFYplMOG8FWPcuVUWHk1i6Gf8ZnLd/fPbP0G
	 skDcRAIFA6QqhGwAnDW04yPF3za/gYRtYHWjAOKkZAXzDUJgtFjELZfoQCex9L8X8qA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XiiVfPVa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC38606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBC38606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XiiVfPVa
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67bef25eb92so4291141d50.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 02:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794394701; cv=none;
        d=google.com; s=arc-20260327;
        b=X4wlNL44cpu1ve1aqEgYyLFvzyCouwC4/a1UrUMyDCv3Afg84i1vWdSuqyVYertDAe
         PukqA9V+Q655XCs8KE4K2/2G4FIcsO3Uiq37PbuJJkM+dpydAJXVIRh3bVMZoaaNKXZH
         CEgvkvfUeL94V8JhH+22yRB1ek8ufO1h3xvsdcyAZx3o4HACeCuInnxf9sbTRI3N5gvK
         3v9k+07N6RgHmtLDGbeMLEsRcUJPAvY4NuIFquXJysNVnlcuo/cRuDDJbB0hl/gYA1lC
         zojVxF7+sr7lz7nehflDJxGoES/XSDgQ1PwzuBEaPjK4DeUmtlOY8eB9GYhIwv8os5kl
         CfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jSNboseJHmMbjWA7WKSfZ1vyDpr+PcUdD6zBvgewwJQ=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=Yn88es8f4pL81sj5Mxa6xFPQUYS6QGMg89CD5Exqy1oiP6th+aj8g2FMVaNMma8Pdt
         4GL8i6M7pt2IGfYvTebkkGXTn9UG1fgoql/4k5oYNdrB59f2bVsxhd3XBuPCh1DsyMLE
         +B6cX3ABoe4MH7k67BkkuPlKcrC8n9iVLHBWeypIxCUlXIV5+nnDAG5P7hC/astDDEsc
         S87q69o3HTrDmj0/SGY+c4+VCOdLgni3/HY0yME9d5vrZhI9IZF5IsnOvXmjwtIPpp25
         kHo6a+2+rQ5qxF9aKhFwXKuoMvPm/j0Z2ec4fh/JzZepUBb7hENQB4lJUlF0b8TovSS5
         9B1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794394701; x=1794999501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jSNboseJHmMbjWA7WKSfZ1vyDpr+PcUdD6zBvgewwJQ=;
        b=XiiVfPVahhelk17uYWlxw6fZUpSloZHukV/mAUIeOTBtwZGHx8XX/kwMA4whQdKiRm
         L2L4nWPb0aw20E0Teq1I684TcdD4joACV9hotasJ6x4LFLGZJDAvdLIXKTTB9dJoAbgR
         RuXSnut+vGplROBWdxIzpxFal6fsw+sQXTjcB45sN4KZXGtWIj/gJhg7YmfoMICf8mft
         uzfPUnXJrtsVJKwMhqjE7EI5QQKU2Ihl/VYy7ShbjZVAYLZMUF0p/kwHyzU8vV8u8oZ8
         +qutRNJWuW3D0sftzccsvldA5EwIwJhjuewP8Ok3evVFixNqXNM+C2ElG1ukfT9IjWha
         nFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794394701; x=1794999501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSNboseJHmMbjWA7WKSfZ1vyDpr+PcUdD6zBvgewwJQ=;
        b=2YrX3R71qmoRpCkrcalvoaJ5whzq3nlGCDNRIZoUXb4lR/lwcGqzhD+y13gEeC9dIb
         /R4SDcVd5bm56TMK+HCo8J6vF+zmbUD6QQMplek2yuXYSagU3PGm2LUaMERxzs9rQ6s7
         rJh2N4gA65bxqrvgrfa24Kl5uYpzN0xZF3pM+v9uhYxQcQx8xdmfFrBXP+kFAoIFLWls
         67y6fPpQGMNMmEVNJIrImTec1QzHMDmdnLbnUg3nG+8An/jNvAp71mhUgD96AQGCWmDv
         XV4u/i74/u4Pf7O64gbrDUMYW4vmh6kej+guLXmerKM+vUj/HTc4vmFhENyjy/2QGymE
         pPBw==
X-Gm-Message-State: APuU4Z962OWXRCaWrzOPl6fSm+dWHr1khig6r114A0l8SzBkhnT6BKyL
	uhXO6Nk3eeEHRv2ubI6HV9bfz5wupCcfoPg4LkqYQohhaa5YnbvJHA92iv29fCehKCwEwcxxgbl
	VJ06/pjjpADXP/1EDvS2drcZFYloOzCvMI80vi60=
X-Gm-Gg: AYBFou0SFJ782M1sXXscARjDoPCuB+L+JnqQBXOFNnCkfaMZ5hzU6z/8mfQ8lZMJiJB
	6WWeQLbNdb8OPYO2sekl1k5EI217U94aV+g4QAQzE5RJAlHp/3tVtLIfdSWkNKA5sMY7IMtbmrh
	2Qy6VnXyCOqfQJeq405IbNb4040BbfbnUUM9fQx0MX4tUY6Cr3iwwXm3YPmUl54s3vfnW1eTmjA
	aBsJ3nkNehKR9iWZZYtZxkeY9Z9Yzv+g0lmDi76OpuaaHBFHSAhJygMx05enc/Xm1l1gF3mnaUY
	Q1nH2rzlxwdrIxSCFc8eEcrgC2pl52CptiVljCqHIMyWc2bUHw9jOjs1J1XffxyvDoL2EiKn8o0
	WFTqSf/t7Njw1ENp1F81XRQwsdmp9aXB9YYEWYg==
X-Received: by 2002:a05:690e:450c:20b0:677:eb7b:c701 with SMTP id
 956f58d0204a3-67c5703859emr2240271d50.39.1794394700644; Wed, 11 Nov 2026
 02:58:20 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110164046.454431-1-a.s.protopopov@gmail.com>
 <20261110164046.454431-15-a.s.protopopov@gmail.com> <sashiko-outbox-207493@kernel.org>
In-Reply-To: <sashiko-outbox-207493@kernel.org>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Wed, 11 Nov 2026 11:58:08 +0100
X-Gm-Features: AclHuK-Q4Eu_FS1-HlF4vKvLEdt8PMH7aN4qBEVYkbkPzJS8znNp5Ggh9wBRWMo
Message-ID: <CAGn_itzg7de6tt_W6UQ=aHyUCVDU3dOX9T7yv4vNz5-mAXCMMQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 14/18] bpf: Require the JIT for fmod_ret
 programs on found 64-bit targets
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 6:38=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] bpf: missing jit_required in fmodret_retval_init() for 32-bit
>   int on ppc64
> --
>
> commit be8ba9e6d31af4b7ee8b1ec3bc7241dc8e6ff517
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
>
> bpf: Require the JIT for fmod_ret programs on found 64-bit targets
>
> This commit sets jit_required for fmod_ret programs attached to found
> targets with 8-byte return types so the BPF interpreter does not truncate
> 64-bit return values to 32 bits.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b12b57c7403e4..920ff39aac429 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23883,6 +23883,9 @@ static int fmodret_retval_init(struct bpf_verif=
ier_env *env, u32 btf_id,
> >
> >       aux->fmodret_retvals =3D retvals;
> >       aux->fmodret_retval_cnt =3D cnt;
> > +     /* The interpreter returns only 32 bits */
> > +     if (size =3D=3D 8)
> > +             env->prog->jit_required =3D 1;
>
> [Severity: Medium]
> Does fmodret_retval_init() also need to set jit_required when size =3D=3D=
 4?
>
> On 64-bit PowerPC (which supports BPF trampolines without selecting
> ARCH_WANT_BPF_JIT_ALWAYS_ON), the ELF ABI requires a callee returning a
> 32-bit signed int to sign-extend r3 to 64 bits, and callers inspect all 6=
4
> bits of r3.  DEFINE_BPF_PROG_RUN() defines the interpreter entry points a=
s
> returning unsigned int, which zero-extends r3 to 64 bits.
>
> In arch/powerpc/net/bpf_jit_comp.c, invoke_bpf_prog() and
> __arch_prepare_bpf_trampoline() save and restore all 64 bits of r3 withou=
t
> sign-extending 32-bit return values, so when the interpreter runs an
> fmod_ret program on a target returning int, a negative error return value
> is zero-extended to a positive 64-bit value in r3 while skipping the
> target function.

PowerPC is not part of this patchset. However, in fact, I think I will just
remove this "if (size) =3D=3D 8" and force jit for all new progs. This does=
n't
break any old functionality, only new functions are getting here.

Will send it for v4 or as follow-up.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110164046.45=
4431-1-a.s.protopopov@gmail.com?part=3D14
