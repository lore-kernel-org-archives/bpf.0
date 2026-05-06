Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900636C582
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051073; cv=pass; b=T222FUvreeziG53uRF2C6JmWNEtAlQ7cV7baqDePEUr7ohGQk0Ka5iXBn5YGRga5lJC+AfofDsbyuB0Rlk/V9JsWcfrpMLfIoK7zCvRX2FDeELx+u5efVF3lM4h4IRB99kmxLW0LrUjPmI+IRyaFeyCsaDlBdJtX33fNCPYw/L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051073; c=relaxed/simple;
	bh=ssFSspPkI/ZVkAske6pW54q8l5QUCB7qB+KlWa5BVuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqU/LYmEshbLCF6LuHNAeWq2XXZsdd6ZbNjwncwsTDLPmlpQImQZDIsvp2OyOLczMOB0oEgxoQNO1S1x4yBt+bjoPvcDgcmr7zjt5Q6+fq13P2KO6DC8Jdwerbfnul8bQAggueANVC9Ty2M3goCj2HeVzQO0wc75eWl982/jeCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVEW81Ua; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVEW81Ua"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4094b31a037so3811328fac.1
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 00:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778051071; cv=none;
        d=google.com; s=arc-20240605;
        b=hFVRYcQm7d1ZTbZnngy2LiedQIjrErxw1VW+qFOPLYhN1OC0I7bcL/wz5x3PfyPIKX
         rVvY3izHOxovQPClQ3zRLzVb+dlzrQfv5rikzyjy41QPqGLiMuYd6DMaY7+1H/+WR9gP
         jDdh4i61MHyqgVuHS58t0bTuCzpFAOII9eZtAUQHokHCf7wgC24lEOWx9OSUjnWKTNkG
         1lNZ6YhZ7wQKfN6VyC7cDVPgNFNUsB5vVk5sE9wH195RBEJ1DesE0Vs9fZHl5yr2AJwq
         dxH9WDClNV1r8m80mzH2PkWJ50P49x9GL3miq5q6UvKsFqrdzvGJ42qu0oVhJ2uIqOJl
         OM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YFgyP3bTzum2n+ShJZRbTnBUvnnZ+xO2mUQjUayQ0co=;
        fh=SDTypENubaayL27R7NbnbS3uL6VUeA6K11fVOxlVp3o=;
        b=ls6PaRqDiIDYwFn7zdsAZpvgnr4JHyv/PDZFEOYJTVQdOQ8vpnbPuV4qvB1X+xv/Wg
         k1Ioftr9iKsNVE/sqQVztWMJ6XW91jGnQqDnKQTn/4AZM4dRlv5ZQ5Ni1psFkugboygv
         VoJHd2WzEO4OmQBiJKIKLD74HMKipXv2dRkRWrpsoLoJknR8OqjybjDu0F2P9LInFqlo
         BNiLwNtRnKyxOueSAqub1+ua4ljAvjvbu7xGQFtf5fPF9LtB5gR4OHV14uyn09x9b5Ey
         d3ie+CoWqlRoT45Kc2BSnMUyFPrLvtZ9tzxa5hy7xc3nb7vcVVlUIfmxWNsadTkg4StC
         p4jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778051071; x=1778655871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YFgyP3bTzum2n+ShJZRbTnBUvnnZ+xO2mUQjUayQ0co=;
        b=aVEW81UaAR9DQibUUrbfNTCuF9xAD0LNd226+lepCSczZ+ZYU+S6nD8GxLv0LNqh2G
         G07R/+xPKILUwCrOV7a3eDt+EaNW4j4MVAxUiVGDcMZlekq3QEdnT2U2EDjifIeSi1x+
         jLk2FH2OGQP1/hPxh8RlEXcbuk8fd9C0cvyOxSErehODpUpip1ur7Go2yzF5+Md5nyWO
         LfqXKT/kA69roYbkUGhUnSV4oFVREUUekg1rxf6Fx8t7Hg/FXnOmHia7coWE2vdRgJVg
         67ytz7whFBdXItAgpYWwwfh82IpAwMtuXTf4d7MWIhzXi94hz8to7DX6wpmGaTpRCF7Q
         Bdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778051071; x=1778655871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFgyP3bTzum2n+ShJZRbTnBUvnnZ+xO2mUQjUayQ0co=;
        b=faRwnuzXOCnhfBV7vMVWQn9At+uzFDZ+T03RhqEk6Yp+8N0QViV6R8OMTEFFReY4ZT
         0QuEnecOQWX7aMATYL4hG9VUWh1dTCAM0aXUnYDRZleRfGorgmmsiqwXgJ5B3y37r/mV
         +IAgPnRy1Ce2Lb4wDo8r6brJXgX915eAL9vKm9RgLhy7bh4Mn4ubxvp+DTINGIofLXt/
         YW1+8/foy9L5awKTsu2sbqJAjHosqgmYTy+AHECIbBcGgIqgN2d3HQwZnf0lPe0kjYr3
         ttsiSbg1X5RAQr0k8NGzhGfJxHtoKXIoP9/BLmIBsUEpwKcajMi2jr9PL8DeG8XPjmBk
         l3Rg==
X-Forwarded-Encrypted: i=1; AFNElJ9HiV6cO09XzWvPDTU4U4SaFySMcmNchkDn/8PLllu3mUD2F6QQUKzpclCy6RgtkbvioZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGYTbGCVd8z4nVzP7xupi6teVyPESnY/tR5VpaZCew+yOwhyEj
	vHLRRmtEEeZNoJo3eQfWNkslmOXk1+BaR6WAEUJ13A+HtKs/yi6PX66sEOzF0lx0zk8nPCIFCt1
	mnxazQUJg0bdPcEvN6/fuoRzozArhhAt7fJcq24g=
X-Gm-Gg: AeBDiets4QKgcbvnjXFD0+IU/e7c7uA3OhwTixau/Nm+46SKcQdWARTZqWjTdAmutZN
	udGeg20FkH1NvTxrVDr2GIR7TFehx0oAj3a49G5tCC5LGEj4/OoQdfRnN5rEElJ4q/wfl9Uo+Ay
	Bbxou4Wvu5S7tRgCb8JrpWqBGXLHMgtgeMMYYX2e9DnB5+7kI+Ji7E7qwNjhQum5ltxMTBrDtPY
	IxWsvayVkhKNo5TzsNe+tysdglsGiPve6NIA8nkLas3QxOKlR5vAib8IYsKmvqAWo7/pHNFtgbY
	ZkpvCjAN9/SH+2HCv7LJf+4Z25E=
X-Received: by 2002:a05:6870:56a9:b0:3d9:2fe2:f5c8 with SMTP id
 586e51a60fabf-434f66c4375mr1629496fac.32.1778051070929; Wed, 06 May 2026
 00:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504135138.17050-1-suchitkarunakaran@gmail.com>
 <20260504172338.6FA50C2BCB8@smtp.kernel.org> <afpwnf5VfjxBgIhS@google.com>
In-Reply-To: <afpwnf5VfjxBgIhS@google.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Wed, 6 May 2026 12:34:20 +0530
X-Gm-Features: AVHnY4INiEqN-KWsg1sOGfy8sVSRnDlqIQwTNbQlo9Jl86AgtqsiN2NjxhytRD8
Message-ID: <CAO9wTFjS85h8DvgsfifGkaTJUMe=Etqto26pqf+wsgQbgvS+rA@mail.gmail.com>
Subject: Re: [PATCH RESEND] perf/lock: Fix non-atomic max/time and min_time
 updates in contention_data
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Namhyung,

On Wed, 6 May 2026 at 04:05, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Mon, May 04, 2026 at 05:23:37PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Low] The use of `__sync_val_compare_and_swap` introduces a compiler dependency on BPF ISA v3, breaking the `perf` tool build on older toolchains.
> > --
> >
> > commit 30820839a2cfcfa987fbc2e0f79fa0e2f2cf0dc3
> > Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> >
> > perf/lock: Fix non-atomic max/time and min_time updates in contention_data
> >
> > This commit replaces bare conditional assignments with a bpf_loop()-based CAS
> > retry loop to fix non-atomic updates of max_time and min_time.
> >
> > > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > index 96e7d853b9edf..5c8431be674ac 100644
> > > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > [ ... ]
> > > @@ -486,16 +493,49 @@ static inline s32 get_owner_stack_id(u64 *stacktrace)
> > >     return -1;
> > >  }
> > >
> > > +static long cas_min_max_cb(u64 idx, void *arg)
> > > +{
> > > +   struct cas_ctx *ctx = arg;
> > > +
> > > +   if (!ctx->max_done) {
> > > +           u64 old_max = ctx->data->max_time;
> > > +           if (old_max >= ctx->duration) {
> > > +                   ctx->max_done = 1;
> > > +           } else {
> > > +                   u64 r = __sync_val_compare_and_swap(
> > > +                           &ctx->data->max_time, old_max, ctx->duration);
> >
> > Does this cause build failures on older toolchains?
> >
> > The built-in __sync_val_compare_and_swap lowers to the BPF_CMPXCHG
> > instruction, which requires BPF CPU v3 (-mcpu=v3).
>
> Hmm.. this looks like a real concern.  We could add -mcpu=v3 to the
> compiler option, but then there would be compatibility issues with old
> kernels.  It seems it's added in v5.1 kernel and the oldest longterm
> support kernel version is 5.10.  So I think it's fine to add it.
>
> Could you please update the build flag as well?  It can be a separate
> commit.
>
> Thanks,
> Namhyung
>
> >

Sure, I'll send a patch for that as well.
