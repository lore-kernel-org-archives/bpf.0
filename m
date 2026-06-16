Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D63DF007
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634833; cv=pass; b=JqL/cKKCVWVXBVcXu3Wv/8guDKprtKjgaAU3GIJ4KGFzqPxNwAlBigVzrJXl7CaQ/5UbWDPi1r9xK42k2HfET4GX6qIonO6PQ3VdhpbsYVtpCdt7dmLpyz0WtxQMcEeso8GaCtsyGqqwUvxeRJh4I/xC6rAXpL52zu/HJlHhm90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634833; c=relaxed/simple;
	bh=sOhlqxN1qxKBwhvm+ri4qwEDLQ9bJn8qASOPOcgsuPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9JMKybci1jQh9jaV6UUfiA2jofLZng6TsAZFGWLCxcGNKX0jzthO/BGtJZFFMacmJ8WC4dlNGY0IPYlGjzxWdG7yN1xOhvJ5Beg7JEAR547tWh+NU2LeqNejHj0SDnIEsDHXAr2/g/KObFRaRES9SUQDu/lLbqAeCILnM7DT1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaSJ4b+G; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaSJ4b+G"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso3040180a91.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 11:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781634830; cv=none;
        d=google.com; s=arc-20240605;
        b=DXF/Lf7PlPjwS8syPVTmCnRMREpABkQrMNhGI/Rer7YB0bU+EZkdfK+OVn3yq/lwjh
         RNtf5HBJcPnCFRurprxWPTdPti1eyQw84Tj839ogNoFCvRjfeIqaqftwwrYIu/MjpDM+
         sI32nkQPd2f7TDZZ+88XLuAEFu1Wjom/xGrofAovu8JChCY3iUA3GNpCRWXPK8UG/F8x
         2bAN/z97jCTGwnitqKdgYneUmw30U6UdsLVqk5a7YWqXqr1d61HWJDsgxTBl5bDBP+Aw
         X6tTrZMOX+7mmOGtSSOto8o4aOIFJS55DsUB7PoUImUIMpKqv1VNC26+4WTflGmz0Hsj
         EZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z2GD8QHUKY/U9GJPMUu0PNTy3ueaGFFkhZ/ZmWvkLEU=;
        fh=TxsJeoLkYIrvknhYhAndCd4NgjwK4E667IDnuvN9Qjw=;
        b=e1/7F1W5Bhh11t1aNUSUDB7IUYnoXVRPfTbR3Fveg81hze+MqBjiCUKfag27J7voA/
         mWHojeYWCRDfBG02Vv3zmHtaP3WO+A+KTdHUsddee2C5+Q67Cg1zOktQW2vLAYG4aWxw
         VL7Ia7L3Hjj5oE1FYC3FESXKoL2IH1wvK6oe4yZ9FTA1Kri2QPiZaqiHv1In+18Jf1Di
         tT2CBOAis7bWEM7OrIRWFSUVVHz9LapFXv1TOW1mKa7tBfoSI8DB+Z1G7MYs4lZlNMCo
         qzA/vo7Hwpk2vJbEhR+QifE7mIpCroyhk9XWLscT2vdG0EthyF/XqX3UKJlfiEVDM0pN
         bFSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781634830; x=1782239630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2GD8QHUKY/U9GJPMUu0PNTy3ueaGFFkhZ/ZmWvkLEU=;
        b=MaSJ4b+GpHCOQGqvy7YaWVhtMTHbCT/bEDKnu0pfaJqD4lxKIKA+p7nAcUlHG6bK+T
         J5V6lGhyeA32y/8MzT5MPoz3yd3vKIUimYV4jz9ajYG6vTb4s1dEdCuiXdH1TOXtp0QQ
         ubiHx+WWbWxfIsm9wa5mh0rFsQlRDadW+DsNrHKMTfJ/k3aZjYQvAyjw86ccF/bj3qCf
         mLVSB4xNffxFPYxl1B4pFoS+1ZVDhxN5bE3P016rTVrsXoIi7bx9YO++8dU8ODcWlPtD
         VqPwKsm0nA73jFGaAl14Y+96vYJMb4fpW/fuFMJxrIwXPEWZmAAQ3P3LfpwE6cAwErB7
         tN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781634830; x=1782239630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z2GD8QHUKY/U9GJPMUu0PNTy3ueaGFFkhZ/ZmWvkLEU=;
        b=ZADM4Sv1m39EOlJ4mn49BIU47lZsgJV06IcHCs+XGXwpu77QXSjIxjNqUBcUkPeMJG
         ozKD1YOADKdPm1zwIlkPa8A/pi4iSEhXW7MUa5rE1/+7piMQEiY3rAaUNcFrWBn8ds+S
         TT1L046oam7OgSSJ7TpfhpbGihowZUj7tCgj34yavy9NfDpPABwp+VwavUEGJd+EbOXF
         kfuSjwRLJMQ0HhUPuHkWU6VetefEfhF95T2gEnqa5PZxo85WWmPe2ifrf4tY5+nsd8B8
         qWZL4LUYcWX7TOLBSWvL7DoAq/q7R2Ly2cjKXwsXjsJhI4KOYesU42UOniaCpQYQc+Ap
         ugRw==
X-Forwarded-Encrypted: i=1; AFNElJ9tEEzRF0AIlVlyx87hRnlAN+daZnOVypuk1ygpbVwQgzqqR1EAh/IDAYEkLsM8qjDcICQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaNaLbQ/PY6VUeFZ23uGR+KoDoqhvin+PTBbsFuczkU5f1PsQg
	hk1ZS9uZ48D4VRqqwx0P4MNdkRGV/VAJd/HNo9p4S3CvELeyPNj0z19qUIBkf4eqVbBfgO90RQj
	A4j1bLZ3GlhZlVfrLNrdBBWYjxh9mOenwWcwQ
X-Gm-Gg: Acq92OHM8oika0TyZhV3wza3WN499GeMMaxVuIM3xNYkzHztcNQSUpDR68FGseOTN6n
	fu1j8wwmy8b/BPqGuJ6c81NDzvrC49iG8gLbaBRRyiSE2PZPv9jk5J5xcrV+Js2LR7MBsVVTbuL
	+Nui+eHlqRms2V8A9ZYfE89+cIzZft8Nfjf1KREAIH0q212mPZ4PuxyDMz+1z1ecOJao1GajQh7
	+pn/7XPzHdJKyBgXo5hUP13u4lmLV61lzjI4y00jbO+11NJ76uITMcYgI7fAzWoYfDQ9nf/ZLXe
	pXNOj4ccbFkeUQV/+cCK0uFThgrC7wnOIawokym/cAyYFe/JDnEVeprluN9/P3jMGJ3ay49RQGx
	v
X-Received: by 2002:a17:90b:3849:b0:36b:bbee:fb28 with SMTP id
 98e67ed59e1d1-37c92eaa16fmr646672a91.2.1781634830501; Tue, 16 Jun 2026
 11:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-5-ihor.solodrai@linux.dev> <DJAA8M3U5PJ7.W84BYRNJA7UY@etsalapatis.com>
In-Reply-To: <DJAA8M3U5PJ7.W84BYRNJA7UY@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Jun 2026 11:33:39 -0700
X-Gm-Features: AVVi8CccuGGJNiwf-tGInm6V6RfMkfsCHF2OFCLNtmu8oCH_6xSRE0ygqN0a8qA
Message-ID: <CAADnVQLLcDPnt5q3MdYjHC1zCJuBPrbRYgoY__5Gk=GKoBvWAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 04/14] selftests/bpf: Add kfunc set test to resolve_btfids
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 12:07=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> On Mon Jun 1, 2026 at 6:17 PM EDT, Ihor Solodrai wrote:
> > Extend the resolve_btfids selftest to cover kfunc sets defined with
> > BTF_KFUNCS_START/BTF_KFUNCS_END.
> >
> > The test verifies that resolve_btfids correctly processes BTF_ID_FLAGS,
> > resolves function IDs, and checks the kfunc set is sorted.
> >
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> One nit below.
>
> > ---
> >  .../selftests/bpf/prog_tests/resolve_btfids.c | 56 +++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/btf_data.c  | 10 ++++
> >  2 files changed, 66 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/=
tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> > index d0e51979d455..f6fd79b9dd23 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> > @@ -10,6 +10,10 @@
> >  #include <linux/btf_ids.h>
> >  #include "test_progs.h"
> >
> > +#ifndef KF_FASTCALL
> > +#define KF_FASTCALL (1 << 12)
> > +#endif
> > +
> >  struct symbol {
> >       const char      *name;
> >       int              type;
> > @@ -26,6 +30,17 @@ struct symbol test_symbols[] =3D {
> >       { "func",    BTF_KIND_FUNC,    -1 },
> >  };
> >
> > +struct kfunc_symbol {
> > +     const char      *name;
> > +     s32              id;
> > +     u32              flags;
> > +};
> > +
> > +static struct kfunc_symbol kfunc_symbols[] =3D {
> > +     { "kfunc_a", -1, 0 },
> > +     { "kfunc_b", -1, KF_FASTCALL },
> > +};
> > +
> >  /* Align the .BTF_ids section to 4 bytes */
> >  asm (
> >  ".pushsection " BTF_IDS_SECTION " ,\"a\"; \n"
> > @@ -77,7 +92,13 @@ BTF_ID(union,   U)
> >  BTF_ID(func,    func)
> >  BTF_SET_END(test_set)
> >
> > +BTF_KFUNCS_START(test_kfunc_set)
> > +BTF_ID_FLAGS(func, kfunc_a)
> > +BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
> > +BTF_KFUNCS_END(test_kfunc_set)
> > +
> >  #pragma GCC visibility pop
> > +
> >  static int
> >  __resolve_symbol(struct btf *btf, int type_id)
> >  {
> > @@ -108,6 +129,18 @@ __resolve_symbol(struct btf *btf, int type_id)
> >                       test_symbols[i].id =3D type_id;
> >       }
> >
> > +     if (BTF_INFO_KIND(type->info) =3D=3D BTF_KIND_FUNC) {
> > +             str =3D btf__name_by_offset(btf, type->name_off);
> > +             if (str) {
>
> This can be rewritten to collapse the nesting:
> if (BTF_INFO_KIND(type->info) !=3D BTF_KIND_FUNC)
>         return 0;
>
> str =3D btf__name_by_offset(btf, type->name_off);
> if (!str)
>         return 0;
>
> <the rest>

Thank you for this comment :)

Together we can fight claude habits :)
