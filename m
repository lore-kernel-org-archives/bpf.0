Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1E1DC1AB
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774719097; cv=pass; b=FJiPur0JXcP5TF097VFpHfmxBCGj5Faxx4V4WHmFhOu7e2btiwZJdifTOO/3in+VoC5a1sgWByPFVmL/9MEGaM/PHFnuYNWIGDLzXNU1Ff7OKqYgrz1pS21U4ELrvu6sjm7TwztrCVhPlWlvqVLj2rcpihz0nbwBpgkeU8NV+kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774719097; c=relaxed/simple;
	bh=aRXa5dkkPR9HpHDJgU3ZJHG5f5J8GDl9KLDi4hro6Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcIHg9GKcoXWY8J/YiBmkyFvZKIwUNLYQbeU5+mMLrlxFJWL2gP+GLZhVh0ZFmHTflfxP8zLXDslnyXHZjbipMBoIk7om4S+aBrdrVrCCsnbFvoKpI61Gz1WlmSzwRONYzZ5r6y13k8vEb9aOiPu2/N9ANcnDasIbza5Ig8BZeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2IMsdr+; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2IMsdr+"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cf73bbfbdso135538f8f.1
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 10:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774719095; cv=none;
        d=google.com; s=arc-20240605;
        b=UvcnrEMdFvaZ9GcJYDKeGzQMiXDTeAHh/8i89Vc22XAQCSPMHrd9VDzgm73RqwGGQP
         GZhghln2pw+HKsO70D5x0vTuNG8n3mxNYw7cAtlRFUMHstLTQscfLSIbQOvtM/qgY9ug
         19XJWQmxrwezsZu3eF4wphfAHVvmKHRRDoFUDDXePocn84uMFzS1TTGIiUmq4mIh1yeQ
         s04S0SsMbbqVI+k4dNonmkFW1+pNvnUBShSnpkZ5ws8JVTwc9bte1t2HiwxTaVXLbLIC
         9FM7kcDWVjKQ8Xjft42ofFeyzPavcfvBkCuTGMedvmgDOD3Sy9aeF6dAuBHfCALVBl2H
         VuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g191wywC3C6A8Bl4NajHAZiUFAuR19jL8UMhMb1Vddo=;
        fh=i4ra377jioU2YTBV6nOH1Dd5LwsD14+ylHG1lf+guBU=;
        b=K2V7QG94KFVu1fUrsDjJXkDSGbI1PNAeRpICLffLbAJedkAslxYz+lF/NuHhS6MNZE
         MYr1PPnIYHybpPLAkN9Sr02iYUzIgtIYxKhopa4YW1jVUz/mcto+jR7mHs4v8J2svbAj
         9v8KdX4t0SYbfxA9wJZ6RwpjBvXCVtlRE3aORTUQmVJHDZKn9ip5ochOIpUQV3ZVqz+N
         Rzj4ud6/DIrNkgejl30BszEN4QURGgLr1Di/BgeXkX9Lc6C95qs7E/9zaE1cOKADoEV7
         cQuj0aIWq/6jSQq+qe5vQWp2YFYshGJhVTuwfZ3/3Gd2QehZTBMPftQPK6MHQw4Ri20c
         f6uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774719095; x=1775323895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g191wywC3C6A8Bl4NajHAZiUFAuR19jL8UMhMb1Vddo=;
        b=s2IMsdr+Hj4Ap59dGUD3sqijJbxYwKHkA9bde0V/Cl52ggTMyRt7yCgYiTZo0dLOPB
         vJYAjK0CWIZmZLiJFXpPO1qQ0R6UIQS1MytCOK5YOIBFXiWyC4HtAO/7TIFFpIFUe+l8
         tQK6dEE5Ol8YkxYMbCLhkSNp0VNdelHpAXfTYwYTEPjkbzN1aDzFguxOg0KdvxOEXL0S
         87ArlpPIz0bAXtzdXkiG5XxJZ6AZbCD9pCiTo+RoHtaho7WCBG6yAuEQ5D7hHMqq7CE9
         DBLbcKBbeeqH4Z/XT8Mhbi/3dwqL5nQAHFCzhOmcFa+w6QeaDIFHziVqVmb7Y3N0PF7I
         zKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774719095; x=1775323895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g191wywC3C6A8Bl4NajHAZiUFAuR19jL8UMhMb1Vddo=;
        b=WbpemWswv+RVmjMK24AeQ5EMi8b/ry6Q83/E534VaAqEd9guCYlmtwAh5FbmQNdr1g
         +VnnGQo2hN0euqYqfqdwZO+HoueZVKovOX13DlQJbvhk7G5J3y56Sfr78CmUGsSkZYkw
         F2OFr3HvDpUKkic06lBB1i5/l02eJRBMzy4smbWGwQ1chCq03sIyrX8RQhgqazuL6JCa
         s/7c7r+kot/hgi3k1No4yyrof/iH+L4w21/Jg5b7WzA0ovqxinTAsmM9RXNa9Q9NZ8zG
         bOSxeRn92Vedzk66SCuJ1VzR4c8RVLyQIbGOor6O2tZ7XMHpeFLISokAb7E3as6Z09cl
         Ybug==
X-Forwarded-Encrypted: i=1; AJvYcCXpYZVjISccy7Q+4hYwytCK+JMSdexPbDhxD8Dn5pqAiL95QshNkJpkU7SRBvyUWHPYZqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7bnTrjYvXt4XFlRQSJLs7r88vtUVADnuMHZS2dFPIQ4iydlWh
	50NO6dbh/pfq3DzbW2r4d467OO4UaVDYp0dbnh0YjrNKqq3uXJSzkr4AEOXCPoajmiUY55dqEBe
	MrAwsEP95IpNPDaBMcQ9CqSeWfkclLgFud7m0
X-Gm-Gg: ATEYQzxLLRo+GzZIdQzq2I8w+oUGn0Q94EPTs1/U3O7DzY1lho+qB6R1V+WpSRR+UR4
	GA44jWQVaxYvpAwX739GaqMc3flFGBgh+1OSS8kLakZSQ6gwia46n1/1PSpZOUsalQ1oEynuw/7
	CBV8Z3G3JKrKY1PngCk0be6WxZt97lTGLBNcv089+GXK7+5qjp2DFWdhQAs0bH2ZIqF1bo0/9Pl
	fuMtu1kiLhSwHgGecBtxvc4X82kEOxrImo6qL5qmC5CbaEu0Q5jvmTSTNJYUrbtEt/7r5aUg24E
	uCIHg3pDnLpWq394WnC47op1MlglSeuNQ9B98JKiUVdFCcIftxtDTEhG28qslfJATN3TDfSLsF5
	C7Ca4/VZcyJXym5Zak13P7tY/9A==
X-Received: by 2002:a05:6000:4013:b0:43b:50d6:4f04 with SMTP id
 ffacd0b85a97d-43b9ea66dc1mr10726122f8f.38.1774719094545; Sat, 28 Mar 2026
 10:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774025082.git.paul.chaignon@gmail.com> <b82e9240f62200aae173a1c69c782f56ed7f8f21.1774025082.git.paul.chaignon@gmail.com>
 <87ikamjv5q.fsf@gmail.com> <acf_3HgkpATWYzs9@Tunnel>
In-Reply-To: <acf_3HgkpATWYzs9@Tunnel>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 28 Mar 2026 10:31:23 -0700
X-Gm-Features: AQROBzDcUMVJXJDF4ADJ28bMjEdCnSRzgU6Zg1-hHn9WLLwZ_2S8uCQN-YItf8g
Message-ID: <CAADnVQJ2hX6E1_p557MYJOQLxXROzDxezwr-x79A7MyZZLzJuA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/6] selftests/bpf: Cover invariant violation
 cases from syzbot
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 9:20=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> On Mon, Mar 23, 2026 at 05:46:41PM +0000, Mykyta Yatsenko wrote:
> > Paul Chaignon <paul.chaignon@gmail.com> writes:
>
> [...]
>
> > > +/* Last jump can be detected as always taken because the intersectio=
n of R5 and
> > > + * R7 32bit tnums produces a constant that isn't within R7's s32 bou=
nds.
> > > + */
> > > +SEC("socket")
> > > +__description("dead branch: tnums give impossible constant if equal"=
)
> > > +__success
> > > +__flag(BPF_F_TEST_REG_INVARIANTS)
> > > +__naked void tnums_equal_impossible_constant(void *ctx)
> > > +{
> > > +   asm volatile("                                                   =
                       \
> > > +   call %[bpf_get_prandom_u32];                                     =
                       \
> > > +   r5 =3D r0;                                                       =
                         \
> > > +   r5 &=3D 0xfffffffffffffffc;       /* var_off32=3D(0; 0xfffffffc) =
*/                         \
> > > +   r7 =3D r0;                                                       =
                         \
> > > +   r7 &=3D 0x1;                      /* var_off32=3D(0x0; 0x1) */   =
                           \
> > > +   r7 +=3D -43;                      /* s32=3D[-43; -42] & var_off32=
=3D(0xffffffd4; 0x3) */      \
> > > +   if w5 !=3D w7 goto +1;            /* on fallthrough var_off32=3D-=
44, not in s32 */          \
> > w5 has bits 0,1 zero, rest unknown
> > w7 has top bits known as 0xffffffd4, and bits 0,1 unknown
> > If w5 =3D=3D w7, their tnums must intersect to a single
> > value =3D 0xffffffd4(-44). Which is outside of w7's range [-43; 42]. So
> > the r10 =3D 0 branch should be unreachable.
> > I guess the comment should be updated to the kernel style as well.
>
> Thanks for the review! We already have a lot of end-of-line comments on
> the BPF assembly in selftests (including two tests above) so I assumed
> that was fine.

btw we have two comment styles in bpf progs.
I personally prefer this one:
        /*
         * Checkpoint at function entry should not fire, as caller
         * stack fp[0]-8 is alive at this point.
         */
        "r6 =3D r2;"
        "r1 =3D *(u64 *)(r6 + 0);"
        "*(u64*)(r10 - 8) =3D 7;"
        "r2 =3D r10;"

because of color highlighting.
But some prefer the other one:

        asm volatile ("                                 \
        /* spill R1(ctx) into stack */                  \
        *(u64*)(r10 - 8) =3D r1;                          \
        /* fill it back into R2 */                      \
        r2 =3D *(u64*)(r10 - 8);                          \

The comments have the same color as asm, but
no " " marks.


> (Unrelated: On some mail clients, your comments are hard to spot. It
> might help if you could include a blank line before and after them :) )

+1
