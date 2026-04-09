Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A52255F2D
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701037; cv=pass; b=XDGIs92fEkVWWRth7fBU1z8M+FuUgpScwOYS1FLsSqfpNUiko7Og2jUbkUsFJBY4qwjCW2QCsmUfnErt1kXhvHUJQHeg58+x4oIovBxhQzwPftblvAv5jNArPIVfhYLZVuegymm/iZgCMAFrPdM/Rwjw88Y6278a9rBI6q7GFTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701037; c=relaxed/simple;
	bh=6pTJUmlcGIwBt2ZwkaGQ0fp37YJQNxwNj/qKID23L8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Blxk5Znf4WVo7iyPegHe3xtYSG3cuIuuoPGDw+9PaENxFki+4/uF++hiNQoJha1lTKkpnAxOVgoLn6yiB3/CFu9q8sTo8lN1jCDrzYvdEI0ThyJTcopT8DuEpqXhlO0H6wjNtp65YWrxcNHyOScZKrWmcLddIbviIMVakaBBB78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBmOEMqT; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBmOEMqT"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso251085f8f.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 19:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775701034; cv=none;
        d=google.com; s=arc-20240605;
        b=UVSEUHVNZNQmQKsOpbJ/WY6pL8EQk3Jxm4p3YjgvbcxDDGu7Dlg1xYuSxT64bjPAo3
         nfgnwBY+IBNiyPSRwpN+/c6Qj/xQasfIVzfXfGG64qcH6rXSMJxAwfSw9IQuZki/3umX
         +wYvA2YbHOKj1jz7B8DVUJC4woyqeODw2ir54ZCViJ+Yt7CnaK6m0KdUtcVHmOH7nNmw
         bkYf+vRFTG9U1cenQl6YxRxidEEO/V5KSX4x+OIkhAnDNXMm7V7L1eJaFwCjybLsUKJB
         hJJWvYkU+Wvs1+oTpyI8y1Azc6fbv3P4QKuKJLmpNB0tB2vZveK5W6B8TDVZ+alBDG49
         AQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h8eHOTcJ7iFcsoCtNd1vyogjwvQzTShZmwKH7GXQgLI=;
        fh=hfRje2veXRgnK/5UbF368BTRuTdPC/oA5JvW+CkXkIA=;
        b=UF9ojTl6r9YwzXUqVy4DVEbPs/WLMfw3Q1nFjvaJ+mzw1I3TwlaDC+vEmwhIVrpC/+
         qBqU6O4xsYBPjoq6QfAkpeWB+zsNE8IIoha0vyyQeEOBPLwZFtqFym1DHlj15q9NRAfb
         oA+AMy0CWMowQe15tm6QKGr2VUA8uxX3BWPCFP8hBIzEvtYaU9pSD5Tzs0ol2HNCpc/f
         3F0oD8ZR3O1q5Ez0zN9WuBqArjszfEAfdhzZE26JJzTLfSQVtnqKj2CQo3P3ZgBsIjS/
         KS49S4L2WKkyJFULQF4f736riBLV/f/6bkTt+z0KEC0R2KsW+SS9sXW7k+Rjfm8INDGn
         utLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775701034; x=1776305834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8eHOTcJ7iFcsoCtNd1vyogjwvQzTShZmwKH7GXQgLI=;
        b=UBmOEMqT2oevggSORSWLQoPJAwajX8884V9CSZ/tkIo4BvBzAeTUwotNhnXwaMqXzl
         u3PjaRVDGvOVIVXEcfqgZIypj3Vi31NDWT6IzAd+hlvy76W28U0udw+1qxINKM09EbLF
         ouzgYUt5189CFTgkT9lugDpnyG/w/uu06Bi94q0Tqto68kUsfbGPmichdIJ9+u+pTws+
         cSVxXyj3stJ7u6CGbY4Z/36EKzPNCtzeNvbATU+jzlUquZrL69b6c0ctrtsvEJi1h5eC
         YK+5BTgJPrz1n4TiGESrb/hcGFwVqmiM3K8SiqxZ/E3zk9O4nWwxdUfmo1wgYDLanD/L
         889w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775701034; x=1776305834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8eHOTcJ7iFcsoCtNd1vyogjwvQzTShZmwKH7GXQgLI=;
        b=NTOhWX6VjCHB+3vA1mkVMndRMovHkuI2akccWDtpaAnKvPFjHoNsL9MjrGVRY+PJ+C
         Ao8Kxw8HM4UVwT6ySgXl42kHOU6JUdlAFqUbh5u+SAYog4XCAl3n5amVc/pfv+tMozLa
         InoZbfILoCAy7qPbgofqxMJnVB13oFKmE2jPl94Rp7bXkxCUC+j88zBX+c6B/grde152
         yudrL6r4ck4C4CFWeCT4XxvSLO9Al9rBK/HuPGnj8uVloMX+HXF2riaUSSu8EmKVANXg
         NPSQo/mF94nk3Fl0PGwp2qNhVlbHJTUEPh4hA2boacvEHACZgmHC9I7akA5KeuNuoudy
         2gYA==
X-Gm-Message-State: AOJu0Yx5MFaBntsZp8Z4D7AVhoCSYBNtT43tFg9WQAktHS1bgeO3fdpm
	tfrb6IPkZIeHtkBDD63ZqcchrMRLCcNDW/eUtDws0YbcvxyQ9gvPFFhYt64dLqBmFbdE0h5o0g0
	AFMG/r7RIt8Ez8hKZgkXHGPqdQc2SRdM=
X-Gm-Gg: AeBDievZ5j+T7omRcBVb+X4mpWaUcq7uhatZqm8yzJ/UmpFp9c1hA2ZIIiD5a/Z2Dpm
	vu1FEwrpILR2YKGMGcyh8myKVD2hh3xJs8LTZiZN9DJMpEywsFJboAx3NlzfL5qaZBkzwOgXKDO
	p3czRKpO1Fy2VrdkGpLs38GCtQRcKmtthfqryKs6y3xooiUQP3biDm606s/hFwA4LkFo43Q9flL
	Bp8Jj6rKTVidairewrw5bc8yoFL/3+Qruo1j4qn2MWC1aR/ncmHSB8cyxMrrdizv3GT4q0lLOIG
	+bbVwg7ZLC7vULdzWzKFEFXsRlc0B5jfzDjlZniJXS46NjCFgGBrl753G28SfgXK3oqRpiHjcTc
	IgU1cNgVswYlLNrpdsOEJBat5QA==
X-Received: by 2002:a05:6000:40dd:b0:43d:71b:204b with SMTP id
 ffacd0b85a97d-43d292ebf2fmr36221749f8f.39.1775701033732; Wed, 08 Apr 2026
 19:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407045730.13359-1-emil@etsalapatis.com> <20260407045730.13359-2-emil@etsalapatis.com>
 <CAADnVQL5Aheo7GrVtxaE0F1xOcUN=6aifGgh8RE9m4Orj0H19A@mail.gmail.com> <DHO6W3RC1IV7.QYXIRM4V8A2V@etsalapatis.com>
In-Reply-To: <DHO6W3RC1IV7.QYXIRM4V8A2V@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Apr 2026 19:17:02 -0700
X-Gm-Features: AQROBzAB746xU-Bt1WIod_j3BFjIJauL7w6YnId7O0Qoq8UeKkGf-rCZsSL1i0k
Message-ID: <CAADnVQKCzmywjs0UVs6LReC3cxhwVa=CR0rnkQawf4-Xxo4EUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on
 arena pointer addition
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 5:15=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> On Tue Apr 7, 2026 at 12:10 PM EDT, Alexei Starovoitov wrote:
> > On Mon, Apr 6, 2026 at 9:57=E2=80=AFPM Emil Tsalapatis <emil@etsalapati=
s.com> wrote:
> >>
> >> The compiler sometimes stores the result of a PTR_TO_ARENA + SCALAR
> >> addition into the scalar register rather than the pointer register.
> >> Handle this case by upgrading the destination scalar register to
> >> PTR_TO_ARENA, matching the existing handling when the destination is
> >> already PTR_TO_ARENA.
> >>
> >> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> >> Acked-by: Song Liu <song@kernel.org>
> >> ---
> >>  kernel/bpf/verifier.c | 27 +++++++++++++++++++++++++--
> >>  1 file changed, 25 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 8c1cf2eb6cbb..30bb71f90477 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -16297,11 +16297,34 @@ static int adjust_reg_min_max_vals(struct bp=
f_verifier_env *env,
> >>         int err;
> >>
> >>         dst_reg =3D &regs[insn->dst_reg];
> >> -       src_reg =3D NULL;
> >> +       if (BPF_SRC(insn->code) =3D=3D BPF_X)
> >> +               src_reg =3D &regs[insn->src_reg];
> >> +       else
> >> +               src_reg =3D NULL;
> >>
> >> -       if (dst_reg->type =3D=3D PTR_TO_ARENA) {
> >> +       /* Case where at least one operand is an arena. */
> >> +       if (dst_reg->type =3D=3D PTR_TO_ARENA || (src_reg && src_reg->=
type =3D=3D PTR_TO_ARENA)) {
> >>                 struct bpf_insn_aux_data *aux =3D cur_aux(env);
> >>
> >> +               /* The compiler sometimes stores the result of a SCALA=
R/PTR_TO_ARENA
> >> +                * operation into the scalar register. Properly mark t=
he result as
> >> +                * holding an arena pointer.
> >> +                */
> >
> > No networking comment style in the new code. Please.
> > Can probably drop the whole comment.
> >
> >> +               if (dst_reg->type !=3D PTR_TO_ARENA) {
> >> +                       /* Can't do arena arithmetic with non-scalars.=
 */
> >> +                       if (dst_reg->type !=3D SCALAR_VALUE) {
> >> +                               verbose(env, "R%d pointer %s arena pro=
hibited\n",
> >
> > How agents suppose to understand this message ?
> > The comment right above it is more meaningful than this verifier messag=
e.
>
> Ack (and generally for all reviews patches, I am going through to address
> specific points only as needed). Do we want to modify the other
> messages below to be more expressive as a followup?

Only in new code.
Old messages need full redesign. So it will be a really big followup.
