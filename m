Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6023A21CC4F
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774409032; cv=pass; b=gzJOanvvl2dg5wgoDe8PKbVTe69TUgUFiGZwg2weeeEAsLkQ1YNDtbSldwQbt1Lbyqgc9T3jFgfFZ79TIvIrTgr6aY1GCOtOgD40a7li3sn/5HeqP8uYeXhs8QaLs1AhdCa5m6YP6HHyR6CxunyfpAhN4VPSEbHW+LGd444q4K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774409032; c=relaxed/simple;
	bh=sLK8OWwZjayd3tAhyOIgWHaeIGYhBUTkOpnmChjQNtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDPaMz58IUAD+28YJ1cRvsmLmsEFsJEWj6pI3inijuGXetPzgo05M2DJPtjIZKEQiB3aypm7iGiTBzPX1YI4Z27J66uBgnRY5aM1IOvaECyS6ByzxRc6rcfA+3BgbKkj2Irpu8rGYdykx4d9/ZhrICzyNgZAeOqb9dtmozcaHEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTV/puxE; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTV/puxE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-487035181a7so26011345e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 20:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774409029; cv=none;
        d=google.com; s=arc-20240605;
        b=Rcw8uVJrx5tggFdCyeH3ye+O61nCtOpaQZjnhuGOrV4qZyZecaclYs5koPrIp9c2MA
         tw+u6LXR9NQJB+DmQUwYyVxrET+W/fpvBpuFbEwUqZnI072bl8Uhd7NCVrMxQKjOMMv+
         dH+bW/Im5LPIbIZguZKqCO2Nah31OHh+qAhHbmIOfRC6SpgydDlbbIaJr+YvKpySCgxx
         VFEOxoJ66vY8SRQMviRi1MBxL9dI+H178ItXduRW2BnvgMP9k9eHaZ8FjZwrg3WQR7Vg
         cUHL+tBv2FNw1V+5NEBwkkFCU4kmToGRCc8M7Lb90fXBCWtzpG77023oh/3BldpBikOy
         pBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UYXcM9SdcYlkJEdFcPEs3vxCNRp/Exg3Ym+FC4nraAg=;
        fh=0DU+z+Q5bKuVnh4JGR/t9GghP+VHHsmwhCGEO9jJuSI=;
        b=H98hNS0UX/yKih7BepXi/di2yCCcW9iFBNbWcb66lQzM/bBwo3FRlUEzKwgiCRhVW5
         4+/UNV0bJLYVIhGxUmrhhyq8X499JP+/dm+IfufVtFsZnbOrtbHpweiUNWWp553GgJ3c
         cukPsy3kS3Y/9p0dpXg6jJHRX+AKMhmbKyCgKHJ1bhT6V0Udv/jjs0FK0rrIDFQDkY/W
         qQoTabNERie4EHl5AjLJRG9l+LVQvG6MK1pe/ymWmOxlV6q5haEvv18g9RvcgfAvB0Xe
         ahl6WjWUyT3nryckO7EB5SyxMtleH6/Nsj2iEPprc9j9j0vOvqrqctUP//yDpcawB5Y8
         vdtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774409029; x=1775013829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYXcM9SdcYlkJEdFcPEs3vxCNRp/Exg3Ym+FC4nraAg=;
        b=kTV/puxEzQrVK/8/wdoP0LHNyxZBnuJzT97LqAr13878Bk9TgLiaepn6ZmH3/SwHF3
         uQfrIv+crIsl2B+mH2ILtGY6+ny/ObiLv3XoyrDS0fD6Hsq4TSrMNbuFGeGtPSmQe6ry
         m8mRMxpqw2/cSq1X8OHeMfnmE9fVGA1Zit6rV3pxTdf0hbhZ1PUFLWQ1VUMHy5St0ASN
         iuFOPVlAmZxKK5YZVKxZPFwsrbYhPtTohXP/iZbJTVCVSYBzbI1uwmcyOMI/8hjRgdwu
         BFHsr2lQnYZ/I2HXg3Fe8Bpf5fZYWDh7IJty9vb6mb/D0IQlULZWfsTcw8DtW4RMFsu2
         pdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774409029; x=1775013829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UYXcM9SdcYlkJEdFcPEs3vxCNRp/Exg3Ym+FC4nraAg=;
        b=PyLzFfB5dn6ZAAR7fy7uxMu8wSzvQG4wTzRbJrHhM5zd0OQIhGgzK1FmmuHQQeFiHS
         zN4BpsWlfcr1Ei580ewF3hkDcnKvygZSgjM91st+B1bLX00ugDiwFs5PEOgvgAPTQnZ8
         F3TGV9LjUT/4afaFDaWfbsNUGatEpIQljANa4n7Niie7OMV2a2+lJijd1imXmx9vk8k8
         /vWr35uEPc1gBRm89LIJe+Jc770ev1UunZGYGsSv4pTN+U12iwkXVbBw7/nR1ArSwdNZ
         yd5EWJfvKkSIR7gnWosWA3Am6fehq3xEwojwnLN2vG3RrZNZi+UJ6lZsBi5/8C3IIKX1
         5C9w==
X-Gm-Message-State: AOJu0Yw6IPfFJFpWnsa++vOnbnOZvy+pf1Vt7Iiwn9IsA+J3Jbguczt/
	20p88hHL2z+nz5LMqQct0pUtGy2Dpa4f8KDTlDNRoCB693WW7x9kSOJ5qXCuwgQu436xa++HrVt
	h+KnTQyDFHQJichMLq0G1zLsNV0Wy2Xw=
X-Gm-Gg: ATEYQzxNBV2WIK9EKu8R/4Sqq+o1R4aHpD92wVMQDSl2kizJTOoS1s0PDQs6Up+eA0j
	n1cpmrj6Mv35xxBE8mWthzZhQs4hwqePUum1GTOzskrbAHhBS0JxxyPjHbA3bTT66sUn/36tJjH
	KNJOxP0kblaSMPNjANKo4qYg/8QK1RK8syhuoy5qKpGpmHgG14U6p1ZA8gWKH8ptDk4OP0QHolR
	ZyD5NFRNvqHzE/WEaJ3R1y3ahUwFVcOPa7iWI8kN1DKGExS4L4P53hcOczLSST6JBIRM4O0B5Qt
	51J+BQXqwz22ZJLYa+s+rESx0abBTPEu36AV0TDv0NMe+sdQ28omFpPWsItCX1Xo6W0JPzQTPtJ
	ataqKMbBrnEPrTv4+VAw+lOBpBw==
X-Received: by 2002:a05:600c:8b6d:b0:485:3e20:4013 with SMTP id
 5b1f17b1804b1-4871604b905mr29245585e9.28.1774409028587; Tue, 24 Mar 2026
 20:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325012242.45606-1-alexei.starovoitov@gmail.com> <DHBJEWWLVRCH.2ZH320TJNWI21@etsalapatis.com>
In-Reply-To: <DHBJEWWLVRCH.2ZH320TJNWI21@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 20:23:37 -0700
X-Gm-Features: AQROBzB-tdXo03mkvILr2Ku0rf2114qDXlLedBekKPxovZ4owDXmfsKQXJM1P7Q
Message-ID: <CAADnVQLQ2AbCjvvo5LcZAW34C-SF3x-NdDLnUAfsaqj3FzaMEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Make reg_bounds test more robust
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 8:19=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Tue Mar 24, 2026 at 9:22 PM EDT, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The verifier log output may contain multiple lines that start with
> > 18: (bf) r0 =3D r6
> > teach reg_bounds to look for lines that have ';' in them,
> > since reg_bounds test is looking for:
> > 18: (bf) r0 =3D r6       ; R0=3D... R6=3D...
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> > ---
> >  .../selftests/bpf/prog_tests/reg_bounds.c      | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tool=
s/testing/selftests/bpf/prog_tests/reg_bounds.c
> > index cb8dd2f63296..49886f1b21e5 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > @@ -1217,7 +1217,23 @@ static int parse_range_cmp_log(const char *log_b=
uf, struct case_spec spec,
> >                       spec.compare_subregs ? "w0" : "r0",
> >                       spec.compare_subregs ? "w" : "r", specs[i].reg_id=
x);
> >
> > -             q =3D strstr(p, buf);
> > +             /*
> > +              * In the verifier log look for lines:
> > +              *   18: (bf) r0 =3D r6       ; R0=3D... R6=3D...
> > +              * Different verifier passes may print
> > +              *   18: (bf) r0 =3D r6
> > +              * as well, but never followed by ';'.
> > +              */
> > +             q =3D p;
> > +             while ((q =3D strstr(q, buf)) !=3D NULL) {
> > +                     const char *s =3D q + strlen(buf);
> > +
> > +                     while (*s =3D=3D ' ' || *s =3D=3D '\t')
> > +                             s++;
> > +                     if (*s =3D=3D ';')
> > +                             break;
> > +                     q++;
>
> I think the increment could alternatively be
>
> q =3D s;
>
> to avoid rescanning the whitespace.

Good point. Sorry for being sloppy.
