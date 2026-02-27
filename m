Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1A1DE2C9
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772160031; cv=pass; b=DzeaFPLHDu8kMdaEfmNBx/OBXDS+0Mk4sCQQWotMQxeKABXghi0IHGx9UyFAkq66wO8dObaqjNac0JpE88n7ALlhTbThwOjy81xICTJzpDLU2qGMjek3MWXU39Zk28aDjxN6yn4KYck2jG8Yn6bsFeeIWl9YC+qS5gSaFFFzsiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772160031; c=relaxed/simple;
	bh=HKZuj36rBnw8TWPt0aMo5dnrfaWitAuoaG0fZu2f1bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCj4JXOqhFi6G85pWYMLbDuN4Hd4XY4+l6lehH51dLC5Pi1WK34+tlQ7FldqsrJJST+JJj3Jd1cZaGjftbfc4m/e0oCh6MehceWjQ4lCNMFpyn5KmS3bpYDTrNCfBzSoU9XSlR0g0cV60rKyu3faVQrVBI8vSPH5niQdC/K3Mdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlRKVbp7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RumM/1IQ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlRKVbp7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RumM/1IQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772160028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxM+CPBR7Ohg7XCtFajNeorsUraH9JbsyGjaezvyFGs=;
	b=PlRKVbp7DO1K933suydhMx3ujmJG5uxkJDkpp6v70b+ONtIVBsDruZ6X78V9RegbrvWlp+
	QE3Aej8Jsvds67L5D6O3eRI8nptfzbMTlV1V7LO3kTyFH1abX+XYhR1lL9LPB33eA7kkXq
	1XjV5ygRNeV7HeOntoB1EgWsQVN2ecA=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-Wl-4luKJMTeGw86jlwCupw-1; Thu, 26 Feb 2026 21:40:27 -0500
X-MC-Unique: Wl-4luKJMTeGw86jlwCupw-1
X-Mimecast-MFC-AGG-ID: Wl-4luKJMTeGw86jlwCupw_1772160026
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdcd394f5bso1614820eec.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 18:40:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772160026; cv=none;
        d=google.com; s=arc-20240605;
        b=CVWtHyN+Edhy2O6qgrf5jd1gaUOczCOpF9iK5G1RkzZ4crOa9QRwpd+WePoFI3+EQU
         KRoGbgcPRVUMoVhYrJLFaTJI+Vq6ylsn955IuuBmP7XBL5OU9b4UUHAD374YHssFKWYz
         MKEQ1pX/OzVBLz6CYHnVxbIWJYhQ8+W/YyaTfqfoqfzUtb+8LBidRqXPKxQZjxIQL+9Q
         j6y6cY5dys8wGdgHYSaL2KUaHy7u8GsR5/BLWM7hSdBNJsgXF4igLbxh2DaWgkd1Utcl
         YhMcdyqYDUiRPXjSDYmUOxEg/DFOOSMCIB9DwP160YXWVu4MbLkNunTK0uXTAjCvOxiQ
         KimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MxM+CPBR7Ohg7XCtFajNeorsUraH9JbsyGjaezvyFGs=;
        fh=kt+YlI6Q7iF7c0NkgahcNIApQTZjdggdo4H9lPwY9kU=;
        b=G4/xgPjOVBWAZSbBfGklqcIR6d74lwkI1JfFYpeENJVkoDeKmyUGuYsHlHBqmeWWY2
         gQWvO4r1ea6RrRZtuheHzRHr6RiRBPo6LogcoJYWTfUtBhvxrF6bAqjxVXzyFaMmXuAd
         RySxukDa4zI8npjbXapbXNocr8JLTjKfBRK510A12Y6V4glb1+aqSn/F+EKC/il5fcoV
         2axbJwQESmLvZPBEmIA8pB47akB/kegyazJjYhGU4PkWN71XWys1EkV21RBoU3PLeowI
         rUe/CXfMFuE66aqPE2SQHHW6YUZB+2Jbpt2Nb2fA9aTX7jfeFxWPeOtfW9aZmg0vz069
         n1fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772160026; x=1772764826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxM+CPBR7Ohg7XCtFajNeorsUraH9JbsyGjaezvyFGs=;
        b=RumM/1IQPE7OkBUKLxeMA7aai2pXTjoRG2VAF7D2JiR5/PXURkudsmHSw/xg1HObzw
         CQGja2Qv5w51QGQ/FiJYY4sRP336HU64xVuCp2HHCWriCGR8UVecVNDoss4VR5ye0sgp
         8rYjWjGZurY+4UhSwZ4TMtO8sdhn2VqlNee71HX4PFAV3lqtzTm6aQBrS8PG3gtNbImm
         0zJ2XGBEKM2tCUGDbeTlXYYwuEmSEF2zpG747Qa9kbnFFcnWnzEf+y3YLx+r+T7hrWbb
         uMl1UAm3ZU2DP3VYNGUcSMbFEaQe2mc0NUsKe1vxsEzYM6MhhqtjNFjnkXGL5aSSUl3e
         gQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772160026; x=1772764826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MxM+CPBR7Ohg7XCtFajNeorsUraH9JbsyGjaezvyFGs=;
        b=qhk2GCZVOVp+TYLr50dSEoOnvDleSA3yCktMU02WQc9F3+10xm/5nkwUVN4WY4mDA6
         qHYUn8jebJkcF7bnKMVWi/kxiMMLr7srV7pCDsmYkyceoxHRqXPSCmsz6xChtT+TPvHG
         lqFyplakpmda1X1uZIte8GrSaI791ATfLdnfi6fb0ab84AJBVck8mlVnaVnuykl0aHFz
         oD/AjbyLQ97qqn1VKtJ38PoaF7bh+P9t0Y8RlRrmS+OLrk3XeK54+c8dfo/SgB0pNpcp
         cY0/nAjy8TMzk7mvsZ9za1ljRdkWRN509JDJJyq9TI874vPGbZc9XVc26khiIB90JH7e
         VSUA==
X-Forwarded-Encrypted: i=1; AJvYcCVI8WwELJqyFvQbcJP9J7Y0KJ+4KiPxg7Dh31gVz4RUc6Io6Pi7D75xVKxb0sCbANRovYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyugjmFsTUH8mrHHwFWfGTc1/Nhr0M1DVku1iHngsuMHIVsXXUp
	TW9fvY5MIMCSZtLDmAwBatrVx4NW/OYe6c1uWWf09f/UwJTuylkkFv/iWeqa0JwT8Ojn+co0k66
	D/1I2zvxUMRz7ewVGlneq8132gsjwmvlK+ub/P/599LkU4Utl9o9jRI3hOa+SjVpqmHgqVsST7q
	GIeNyZ89hZLCT4PzTEYw2cH8HkvPuD
X-Gm-Gg: ATEYQzwTxnZ276NHmumxk2zzwrdWvfGFiSouvwiU/wQbkQctTITYWQcpxC3qftnx6Pr
	MpEw0JFKvaQ9TdgISRNeXLAVRiR6GpeWz86GigY+KobqKYjYmF1ORa3v/gXh/yjl3UAJX4sSbTK
	sv3GDd7sfr43NhOKKSARCJXgh79gGhSV/EQjvXQ1N8GChLm+tQhcqWXEzAmdFjMYGEX3+9LHpZS
	gwSpYs=
X-Received: by 2002:a05:7300:880b:b0:2ba:7b0b:e207 with SMTP id 5a478bee46e88-2bde1d0db6fmr382138eec.23.1772160026141;
        Thu, 26 Feb 2026 18:40:26 -0800 (PST)
X-Received: by 2002:a05:7300:880b:b0:2ba:7b0b:e207 with SMTP id
 5a478bee46e88-2bde1d0db6fmr382114eec.23.1772160025698; Thu, 26 Feb 2026
 18:40:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119032424.10781-1-piliu@redhat.com> <20260119032424.10781-5-piliu@redhat.com>
 <20260226143743.7e963ba9@rotkaeppchen>
In-Reply-To: <20260226143743.7e963ba9@rotkaeppchen>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 27 Feb 2026 10:40:13 +0800
X-Gm-Features: AaiRm51JnGpS93nCE3-RTCORT-gV1_XekO5k86v7D4IWPLe5twAugzqBcKxFNYo
Message-ID: <CAF+s44RxsvVEKSg=OZpbq1YTp4qi4j-+ZnS=BK5dcHW5Q61W7w@mail.gmail.com>
Subject: Re: [PATCHv6 04/13] kexec_file: Use bpf-prog to decompose image
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 9:37=E2=80=AFPM Philipp Rudo <prudo@redhat.com> wro=
te:
>
> Hi Pingfan,
>
> On Mon, 19 Jan 2026 11:24:15 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
>
> [...]
>
> > diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> > new file mode 100644
> > index 0000000000000..dc59e1389da94
> > --- /dev/null
> > +++ b/kernel/kexec_bpf_loader.c
> > @@ -0,0 +1,161 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Kexec image bpf section helpers
> > + *
> > + * Copyright (C) 2025, 2026 Red Hat, Inc
> > + */
> > +
> > +#define pr_fmt(fmt)  "kexec_file(Image): " fmt
> > +
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/list.h>
> > +#include <linux/kernel.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/kexec.h>
> > +#include <linux/elf.h>
> > +#include <linux/string.h>
> > +#include <linux/bpf.h>
> > +#include <linux/filter.h>
> > +#include <asm/byteorder.h>
> > +#include <asm/image.h>
> > +#include <asm/memory.h>
> > +#include "kexec_internal.h"
> > +
> > +/* Load a ELF */
> > +static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void disarm_bpf_prog(void)
> > +{
> > +}
> > +
> > +struct kexec_context {
> > +     bool kdump;
> > +     char *kernel;
> > +     int kernel_sz;
> > +     char *initrd;
> > +     int initrd_sz;
> > +     char *cmdline;
> > +     int cmdline_sz;
> > +};
> > +
> > +void kexec_image_parser_anchor(struct kexec_context *context,
> > +             unsigned long parser_id);
> > +
> > +/*
> > + * optimize("O0") prevents inline, compiler constant propagation
> > + *
> > + * Let bpf be the program context pointer so that it will not be spill=
ed into
> > + * stack.
> > + */
> > +__attribute__((used, optimize("O0"))) void kexec_image_parser_anchor(
> > +             struct kexec_context *context,
> > +             unsigned long parser_id)
> > +{
> > +     /*
> > +      * To prevent linker from Identical Code Folding (ICF) with kexec=
_image_parser_anchor,
> > +      * making them have different code.
> > +      */
> > +     volatile int dummy =3D 0;
> > +
> > +     dummy +=3D 1;
> > +}
> > +
> > +
> > +BTF_KFUNCS_START(kexec_modify_return_ids)
> > +BTF_ID_FLAGS(func, kexec_image_parser_anchor, KF_SLEEPABLE)
> > +BTF_KFUNCS_END(kexec_modify_return_ids)
> > +
> > +static const struct btf_kfunc_id_set kexec_modify_return_set =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .set =3D &kexec_modify_return_ids,
> > +};
> > +
> > +static int __init kexec_bpf_prog_run_init(void)
> > +{
> > +     return register_btf_fmodret_id_set(&kexec_modify_return_set);
> > +}
> > +late_initcall(kexec_bpf_prog_run_init);
> > +
> > +static int kexec_buff_parser(struct bpf_parser_context *parser)
> > +{
> > +     return 0;
> > +}
> > +
> > +/* At present, only PE format file with .bpf section is supported */
> > +#define file_has_bpf_section pe_has_bpf_section
> > +#define file_get_section     pe_get_section
> > +
> > +int decompose_kexec_image(struct kimage *image, int extended_fd)
> > +{
> > +     struct kexec_context context =3D { 0 };
> > +     struct bpf_parser_context *bpf;
> > +     unsigned long kernel_sz, bpf_sz;
> > +     char *kernel_start, *bpf_start;
> > +     int ret =3D 0;
> > +
> > +     if (image->type !=3D KEXEC_TYPE_CRASH)
> > +             context.kdump =3D false;
> > +     else
> > +             context.kdump =3D true;
> > +
> > +     kernel_start =3D image->kernel_buf;
> > +     kernel_sz =3D image->kernel_buf_len;
> > +
> > +     while (file_has_bpf_section(kernel_start, kernel_sz)) {
> > +
> > +             bpf =3D alloc_bpf_parser_context(kexec_buff_parser, &cont=
ext);
> > +             if (!bpf)
> > +                     return -ENOMEM;
> > +             file_get_section((const char *)kernel_start, ".bpf", &bpf=
_start, &bpf_sz);
> > +             if (!!bpf_sz) {
> > +                     /* load and attach bpf-prog */
> > +                     ret =3D arm_bpf_prog(bpf_start, bpf_sz);
> > +                     if (ret) {
> > +                             put_bpf_parser_context(bpf);
> > +                             pr_err("Fail to load .bpf section\n");
> > +                             goto err;
> > +                     }
> > +             }
>
> I'm not sure this works as intended. In case a .bpf section exists but
> bpf_sz is 0, the function will skip arming the bpf-prog but still
> continue. That doesn't look right to me. IIUC a zero size bpf-prog
> should be an error. Or am I missing something?
>

Yes, you are right. It's better to treat a zero bpf_sz as an invalid format=
.

Thanks,

Pingfan

