Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3D3D88F1
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782170; cv=pass; b=aNzs30DNVeH0fl1ANysziP18ZQJNpNBYrMS2+mAzuMGLJU/qGZiu0gKw5KGE/Sx9/q0f5nIuGcNjCPeU0CEXZbQDyxitXP5wHR1i7EpAkD5EjAu60H1EL9IYrkq3fhaxn2q4uqzyWXfoKmmJEGegMiLaoZ61SO4PhLqJDxcKu+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782170; c=relaxed/simple;
	bh=J1QZgBzIlGE0gPvzcDXH0r/TfQIdktLOAu9cNzIumCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3cHBxUNvz2cU+YTue3WQIS7tsekDD+9RrNL7Zpj61k15C3i5UTPmbsRGAdbuBAtPqcJfg3uMQizmKtrhsYEeX35jM9oTywl2ZXNSj8ZCNPkTH65x5nHT9cBen/z73rXCEEu2C1FARzyT5mhwj5mkh0frYwxxRaUU4S6Beuk45w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/fq/pWY; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/fq/pWY"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d73422431so3711534f8f.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 07:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776782168; cv=none;
        d=google.com; s=arc-20240605;
        b=Sy1v5F/ThTBP8DEVhiv8uDgbatQUN/NivqNwNPmAbUmL1LF2fqN9G0987yyeuSrE1q
         AcTgXoYwUdNgtgLTInxHzJzOvh8wbUYofGmc2LxXomrpyv3CoLCAASyWmz8Jo7D012TC
         wybOSOD3YJdjq3wV6dfH6BpKq3BHB8N2QzSUIhut0DBed7zKIF9jivj97c1qqR6UoOac
         MbaI+fR+VbTF752TT89uNDQtthQNoFTgYrHd5O1yP32epNGgwVEodIM9RpdqXR56oo96
         XUGuclPVfY4C8ddibHjXbFSkZicvwXD95VqcP5fwCAYrNisvcePIvAMithTeR+Ouc8gL
         8GbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uHVmZ+lezGdWdBxETgRF+bBWB7QOy6uy+Lzmdi2FOsY=;
        fh=YbES6cubIsAwXAyS0uGEDFvwZbAem/PAEC5zXCsgKfA=;
        b=PPmabRQPX1RUGpbC0/tusqeQF0dyR4nkakgJ5CjJxg8hkdkmt/QPlQxsVDfwVhn+Bk
         5Lyl5E9oN6TxZzCB7M33rEG9djsrtSBWXXYKd6vqOPXr/em4YuGnXwbjIV6f6OGkVtYY
         Bx1rHpJDBWZGeiEWWF3OxQcgCLrvam9WVeiAKJ4trcTC9s+JcYnppiKvkaq0zzC6MqP/
         Y8M9rx65ZKGU7KQjCHeZEPffTkwwcbNT8Jnh2zQIYWH36UFo/nQ5JHFr5ZXtNyY2nlxe
         bh5ayIV5GGUQTRYCDuTRGp3vUmECexMI9oXA1B8wcQ/F6s0LCD7XtNtVJI63eIsYw+wq
         RVoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776782168; x=1777386968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHVmZ+lezGdWdBxETgRF+bBWB7QOy6uy+Lzmdi2FOsY=;
        b=h/fq/pWYVYPdVZTV6v2l7CS8M/+F7A4F1PY8qO6R8G5UhRJuxre2lfN9T4/BMXCpVW
         hkkE01XsWcmIKxmULofcNv/kDH0LFniJ6GnbdEAhpVBuRKSZ88JOxOZY+zAbtOyvkSxo
         XgPDbLcnh7TCRfHKXRDTUjeJwvuKvmyps3xfEfM1IkmBseGYw0+byI8KZbNXt8Je7v1X
         COvt0t52vqSJMKLnwPoQohv9fxqPTJVAKCJIfMYKdWyQ6h4vhaxEKLTGftNeaoV0tlEd
         p1ZfFc4+kButW65vWAV1xWNM/8LjxUboD/WBaC09sKmoyumdDcyvgL7srXd7aK8gT91Z
         h5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776782168; x=1777386968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHVmZ+lezGdWdBxETgRF+bBWB7QOy6uy+Lzmdi2FOsY=;
        b=el8wniX9v1lgc3jzIOpqqaF+r5MVMDA5lX10aJWuU2lThNzUeY8Is7EOP1XdRKu2J8
         l4akNOrnSMzaATny7aDjbLXOqgb7BVV0l3/jYZ+jZI74qxVn8yMIAZi0K8sNoYHiwWjL
         2PZHLEPb33+aYszztid48wLrFmziI73wjKxH5QM3ZTPI8727ZesyDoYfnHT5c0ED/TdS
         LoKSfBXyJkozf7jJSN9VQJpY+olBtxEL+oIknFcy3/GkIQGLNFccOqIsU19e2SJx1E8f
         JitLtTyc7Xo0oIwS3IpaOB9XkQaxPdv7Bm+gDQQsc6QI1/18rRQ1+L4bF7UiVB0bEdbh
         2jIA==
X-Forwarded-Encrypted: i=1; AFNElJ9eYLCLotWEexVsUDUFP62dvv7sz78LiFVJBOZB10Dno56R36UJFf86zDoaXEvPaI1gLFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiV96Fh4ZVPZkxJd+HW+WQuf1CXHO/Db7j+DE0pPqPLTPCa1iZ
	3uLEa5y0jWqepj5grj52Mh4jGEBPGPuH82TnTOqtaSF6rkAFnittZPnViW/tgatJQBdzxYvIXzN
	v2HDwu/uPndoRr3Ji6vlN5w2rRB2P+2Q=
X-Gm-Gg: AeBDietB3UVLi70891dWklICflABel1hl6Fid2kP3RwaV18Yn6pe6/tPHQ3RohiyxRQ
	jI65Tucei/79XhVGHqgvDju62kXvUrefoLhUi7cEBiF5MOqtjA5j9H1pLtY9KIlswBBYzf9ZzDB
	wbMD+opQvoQlnKTZKip04qgpGIybXUR2PsqytYBDr9+dz0fV9u7ycSZ0HHSI32GGhet8Ckx6PNc
	eylkqOsX+0L1vDmchlZ13Q7OvIO8qXjkvwafanN003JRc3WIY8t/rrsIyebL73fWaDxMjI+hWwH
	tIYGwtP2qXIQ115P0STUhvvri2rzlrYuV4w6EBuLAxDinC7bQcnM7Cvce+DqcHKqWTsaGWvVZ3B
	OZ2pvdyOIzADJxe/nzJ7N33e6Ep2XQcgbHQ69
X-Received: by 2002:a05:6000:40cb:b0:43e:aa43:243 with SMTP id
 ffacd0b85a97d-43fe3e24eaamr29243843f8f.43.1776782167435; Tue, 21 Apr 2026
 07:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414132421.63409-3-leon.hwang@linux.dev> <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org>
 <fef2c9a0-c609-49f4-a165-890aaecfbfd8@linux.dev> <yujp3deu4uko2xkr4dghofpvhrni6szmd7wlozehtzndvhasrl@f2xjf4egi5fd>
 <3556a456-70d3-45e7-affa-355107bac30e@linux.dev> <d0059a19-ab24-4e9c-ac54-dafc932317e9@linux.dev>
 <CAADnVQJ0o38xXn6E5ub7kWyoZPiaevr9mwDNxv0GbxyguVTKUg@mail.gmail.com>
 <20260420052459.85772-1-leon.hwang@linux.dev> <DHY2JXM90466.13PVYC6ITVFKS@gmail.com>
 <20260421014255.210566-1-leon.hwang@linux.dev> <CAADnVQKEkMjmARsWMvs6SP76nEdCzBYSffSFSNE-Do=MaXMv3A@mail.gmail.com>
 <20260421141326.38597-1-leon.hwang@linux.dev>
In-Reply-To: <20260421141326.38597-1-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Apr 2026 07:35:56 -0700
X-Gm-Features: AQROBzDuJXlOTf8UhL9JSxLn-gdV1HjwBnS54puTPwizpdTzGJUTAvGWiC2IY14
Message-ID: <CAADnVQJRL=18585U9Mk13dJJqnxEDPD5-8nB++Add=+kpjUThg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 7:24=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On Mon, 20 Apr 2026 18:59:39 -0700, Alexei Starovoitov <alexei.starovoito=
v@gmail.com> wrote:
> > On Mon, Apr 20, 2026 at 6:43=E2=80=AFPM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> On Mon, 20 Apr 2026 07:58:06 -0700, "Alexei Starovoitov" <alexei.staro=
voitov@gmail.com> wrote:
> >>> On Sun Apr 19, 2026 at 10:24 PM PDT, Leon Hwang wrote:
> >>>>
> >>>> int xdp_prog(struct xdp_md * ctx):
> >>>> ; cnt++;
> >>>> 0: (18) r6 =3D map[id:28][0]+0
> >>>> 2: (bf) r6 =3D &(void __percpu *)(r6)
> >>>
> >>> well. that insn was inserted by the verifier and it shows up in xlate=
d.
> >>> That was expected.
> >>> The point about 'bogus xlated' was about offset translation.
> >>> map_direct_value_meta() should recover proper insns[i + 1].imm =3D of=
f;
> >>> In your example it's zero, so not an interesting test.
> >>>
> >>
> >> The original insns[i + 1] wasn't broken. See the key change of this
> >> patch.
> >
> > You're missing the point insns[i + 1].imm =3D off is how
> > off returned from map_direct_value_meta() is used in updating _this_
> > ldimm64 insn.
>
> After looking into bpf_insn_prepare_dump(), agreed with
> "not an interesting test".
>
> Then, updated the selftest with non-zero offset. And updated
> disasm_helpers.c::disasm_insn() to dump such ldimm64 insn as map info by
> the way of bpftool/xlated_dumper.c::print_imm().
>
> +static volatile const char fmt2[] SEC(".percpu.fmt") =3D "data %d\n";
> +
> +SEC("?kprobe")
> +__success
> +__xlated("r{{[0-9]+}} =3D map[id:{{[0-9]+}}][0]+9")
> +__xlated("r{{[0-9]+}} =3D &(void __percpu *)(r{{[0-9]+}})")
> +__xlated("r{{[0-9]+}} =3D *(u8 *)(r{{[0-9]+}} +4)")

This is still pointless test.

> +int verifier_percpu_read(void *ctx)
> +{
> +       char c =3D fmt2[4];
> +
> +       return c =3D=3D ' ';
> +}
>
> It would verify the following xlated insns.
>
> XLATED:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 0: r1 =3D map[id:7][0]+9

what is 9 ? was it there in the incoming insn?

The whole point that xlated needs to translate it back.
Start from scratch and think what map_direct_value_meta()
suppose to do.
