Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE1329E55
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663866; cv=pass; b=n105ktsLjhlzE8zTdUjw5oe/ALGp28T4v02clKEizShRazaIao7eaLQz97CxyuMpPWIOpTUoRJjpmePPfuei1ecYqnrQLQYZB4/6l8zSRdUCuv8YTXJzIaNSmyhxSevuyy7iSJaHofamP1tcd8PZGcEc92oZ5XL9ILSpo16Ixrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663866; c=relaxed/simple;
	bh=aq/BY+Jwl0ArxIyMnB+97m5Maj1U782i3CsVD4IDVaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chSulq74yt9qzoU2FQVjN+CrkxssVCvxbV9svz/kDNWr1JrQb1Gbyt5KQXedL71wEJMLqlhSNKUWsDuY68FGPdjOCXdHzhY4x/CilJ3kJs81QCdXpVIqaok4/zf8hGB5a4MVC9z4t8pRC5rtEIL1ufIku+6AWy5xK5CdefJX0I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2FoeZsW; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2FoeZsW"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cf906b007so3393138f8f.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775663861; cv=none;
        d=google.com; s=arc-20240605;
        b=Z8BOcWr15anPbbnbF4bOe8iMsFAWoOuWXO/9rp7l/ouhihvuHovEgTajHsuZlz7GHI
         KKYPBf+NPDbG9zTm/jh398Edq2oe1GC6YKstSTC/YQjnyQagNDfSGLLRxWz647QuO66v
         MxdnqodpMINIG5A2FmcQfxWCDkXlhepEyX9uLLPQGYOl2+b42vJOV+lq+1DUeQyOPp99
         DbIjhfFzJKqPhZSgx72dZE2IRbDITTt7VrkMpJ9bD/VwgthnVx95ga9/GEZLovUHmxkx
         aEUxLeCxIw8hjHQ7ZDr5hnhrZxP9wsjNHNXYdy1Py9+zx8AfBXzibMqfJ2uLVw0lQs6+
         JGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WT22eQe8O3onS7OBK6mPA/rdypgU3bQWjCQkWTzFw9g=;
        fh=hLj4MRh/OEdRt9K/neAFCx82N+eE0PR712bWvrqRbQ4=;
        b=PPfpdIM6eKLhgUZKS2bQZT8f+03NbSngdW+IbQKYLBmHXO4g+vYYd4yhHlhkW3xHZ9
         ccNYAbFTOVTDgLIADLGwjcS6FrC085NwSmnvKQAbnp6xIaZZUfj3LT9rtxAHpANRAXel
         hOEzc+CmdT/NFYvorZ4u0EbkR5xqnir6hAiio+QVJSNBoiR5ZY+9S6L1AZHpQ+hbfNZD
         0XcxA3q2Y+bzq8BcT7AtGde/4x7Jhn9jn6RSHVD5mXtgQQonVcB7rlINsh8LVYvNuQyQ
         p8MIYxfdIMfrywVdZBhUnfjRPNkhLAVFDTcMrf8hQubOwUOl3r3ns3L4bBRZWVqdiVE0
         QAIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775663861; x=1776268661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT22eQe8O3onS7OBK6mPA/rdypgU3bQWjCQkWTzFw9g=;
        b=Q2FoeZsWuUqS/CubaEc/LktTsULm1Qz7ZAfNScgzSskUoRlSBW9LiZKV/B7Ezdkp+9
         n0TJDPCas025u7dINDnEdie/1jdxaI1dKFhS8h3rKMkomXpqF8WruD/UhqlYKdIXaW4+
         2YX048E0YZZl1BZwJErf2Ql3R1BBA3qPuNBDbPgeY6K39koA2VsuVtojkKZ1KExkPFFL
         X4FQnSnYmtVUaDfFE0GArEonXuvcVPc+N/XKwPBu1DaCNHt6tktjmz8kOc+shXXIkKlS
         Dg6pZE5TAgZhZDI++3Yi6vheMsQeWSNG6oH5yQpFd0g5pQtfufbIc+dJGwS1pbgTWZPI
         xG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775663861; x=1776268661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WT22eQe8O3onS7OBK6mPA/rdypgU3bQWjCQkWTzFw9g=;
        b=sQPk9uMoZ9vkUJ2zw7mXx+hFMgnGJYh2Qfs2ERpN5BggjWURH+WT53Drzt75S4qKQF
         LOWXOr1al25/qNUdBdRUz47JO8G7voe06CClpbMDCowPo8ObhlUdfIvLQYUd39psI8JK
         F3R2Yaw0mtRzIyTsPgtE5jdPgkud5ReCe2msOgywQncksXHZiA+TVo4sVtQQmOU1lbek
         qCORp/LVa2n7yrAfrJUTeb7wWOmEVJMmmp/jehnazcobbvboVe8d4WkkWDULkqJKs38R
         GdiUYVD2byfvWAyoeJ4uIj7vzF2gfEEXZ84WBtt3+1RlSmpCVilQvB6AMTD/J1kOc/I2
         JLzg==
X-Forwarded-Encrypted: i=1; AJvYcCXTStw+H2urRyOFPse0ww0pOPx794hwTrykMqVguYIK3ne7kZyhF/t4DVQgBv2jeHsRLww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNBtRhqELGraH2UamFoWspdgHf/393QCUfggDOCsH8FDf0kXD
	QQRcu1xi8vNhQSElI/jfRCivWNXvRGtTxOHd6w26m4l4YBhLJoxzi1XkbIKkIVtE4F3HEDpuyS3
	Yl5mHT3svmB5NdCgdd6A2FivV6iT2SQU=
X-Gm-Gg: AeBDieu5BLTueWoMvof5xKFM084gPSzkoZ6zoY5SBqY4NYXR5ZxvNt+fRKqfL6ni/ln
	cozY4R9hUuwn6nnjPIQ3pUGeb9GTye/v75jie6JN2JkvXWqWi6+hbSLUAak0xYjkhe0kV23jeGb
	qrKuDGs94Or1Yc99mz4+cPxLeYQ2cKOK3G3o3DKdsRhBvdg9WzdTlhSQOH2FYmkXDHNbzmNF5j9
	P/BMsh9Fxh83/thynH+VUCOsPafTHZhQPpc4BbtVzPxWQp1JeKFSp8aPYXe2unMxWTCT6bTSf0X
	Kj2+eNeRuqH3NayRPIwSaW9qL6e4mVv2LJJo8EunXLV8aLSqk1X9cjFeu/rJOGKVycGFW/mdP6t
	7EMN4i/JLYnUECEbZN6jyp4yqpg==
X-Received: by 2002:a05:6000:1869:b0:43d:dd:8cad with SMTP id
 ffacd0b85a97d-43d292cbccdmr30811808f8f.32.1775663861058; Wed, 08 Apr 2026
 08:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408062109.386083-1-dongml2@chinatelecom.cn>
 <20260408062109.386083-2-dongml2@chinatelecom.cn> <adZWStMinOeunjSH@krava>
In-Reply-To: <adZWStMinOeunjSH@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Apr 2026 08:57:29 -0700
X-Gm-Features: AQROBzARpGaxDLz1UDfH6Eu7LwXGA7jnp4IgmMy08jJSkUqOPBF6lbIjtU-iI2I
Message-ID: <CAADnVQLq3ZJOV49-EfsX+5-KRLaU0fRmaXo=G-TgTCb-efQ9dQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: add missing fsession to the verifier log
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 6:21=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Apr 08, 2026 at 02:21:07PM +0800, Menglong Dong wrote:
> > The fsession attach type is missed in the verifier log in
> > check_get_func_ip(), bpf_check_attach_target() and check_attach_btf_id(=
).
> > Update them to make the verifier log proper. Meanwhile, update the
> > corresponding selftests.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Acked-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> > v2:
> > - add a missing FSESSION in bpf_check_attach_target()
> > ---
> >  kernel/bpf/verifier.c                               | 10 +++++-----
> >  tools/testing/selftests/bpf/prog_tests/exceptions.c |  8 ++++----
> >  tools/testing/selftests/bpf/verifier/sleepable.c    |  2 +-
> >  3 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 594260c1f382..beb660b4c3ec 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11757,7 +11757,7 @@ static int check_get_func_ip(struct bpf_verifie=
r_env *env)
> >
> >       if (type =3D=3D BPF_PROG_TYPE_TRACING) {
> >               if (!bpf_prog_has_trampoline(env->prog)) {
> > -                     verbose(env, "func %s#%d supported only for fentr=
y/fexit/fmod_ret programs\n",
> > +                     verbose(env, "func %s#%d supported only for fentr=
y/fexit/fsession/fmod_ret programs\n",
> >                               func_id_name(func_id), func_id);
> >                       return -ENOTSUPP;
> >               }
> > @@ -25561,7 +25561,7 @@ int bpf_check_attach_target(struct bpf_verifier=
_log *log,
> >       btf =3D tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
> >       if (!btf) {
> >               bpf_log(log,
> > -                     "FENTRY/FEXIT program can only be attached to ano=
ther program annotated with BTF\n");
> > +                     "FENTRY/FEXIT/FSESSION program can only be attach=
ed to another program annotated with BTF\n");
>
> I wonder this should say 'Tracing program...' instead,
> we have other tracing types not covered in this error

+1

pw-bot: cr
