Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4120C3A5433
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812767; cv=none; b=DGleGl52feOQfWSPJmYaiDZIxR8enql9roenheQOLsD910S43MEy6EJHzu2KyvGoTq2HSK2qyUMuuiqMUgkY7cZJrVZXs56O/fki2stw3zudDqDzWiyXtt5mHh04cpodndsS026dCR5NSEgOF3q+RX2yuQ/8GVyuDUm54vOEAuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812767; c=relaxed/simple;
	bh=moh5hpCr7pRJJMUG9wWpv3saN9bWlBA52pEqMbKCq18=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNuYca3EsjDxin9HTbfWoWwyBCUV5mXFisjQs06IVDJhJWES3wMQf6YGUmwYCjzPLyn3u8qGPNkwUWkECHs4lNOl0s6s+ODhiuJ2v5VtDwLKemdo3C4aYir6/L3pGfViaHTQqILminKLZv403xfFvmGUyfh5URfqlbFH9x+r8ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maKHY+nb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maKHY+nb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so31045945e9.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788812763; x=1789417563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zWxCDPj/3hUeZtfTgOpIwtXGMawirYtsDNoIJASJj7U=;
        b=maKHY+nb1Lf1aELPQybtZSX8H5XqAnYThmdUKyVM7RffiT/HRdI8fIbrO5dkUethFt
         JCib52mKGlgef2DA1+e1t58eG4fv3TNHz7O4LVmF/eE+BzWPoq5zjZ9ou1Whj8j+qH7B
         kSamcticHC0LIJ3CMUf3uNRjOLTHm1NyZXrsh613YoWrXsvX02IL2PCoeb40NQqA3FEq
         wDjy+Z1rV0qQ8JMaMxAGcv4JtfkjBvX3Eh9HFmI+GWudvbbbDF+DtJ55zX1e1sh6WxJq
         FzRaELTch/WbTVKa7T5QelSBhxRCUv+MlZ7yHgYO0e7305mmFOF4crRPnfMFV6SOk5YH
         d4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788812763; x=1789417563;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zWxCDPj/3hUeZtfTgOpIwtXGMawirYtsDNoIJASJj7U=;
        b=T2Z+jyV7dUsDK0oLYrXBJCfUU5fPA8Snt1wmAPz6I/uRyl8/HFtDVePm88cmSnnzcZ
         D0UrGL6d45sH7XuV1NZB1hOuZrroOaSnBH7jNLMfhIGmFSfbo63Xbojq3KtoDkwam18w
         CB+XAsaLsEd/KAApdV/iY8bvgZE2NPPVkj37n4vdIvLQIUkQ1COpNT4k8jTJbgO4Kw2J
         sEf62XHUiLuKTynfAK0jKJJCaz9m7ROW9s0QUT5v7F9uzp+Yq0/HdmNMhQYAnJkJyAf0
         R0FuxLtQxcoSH8eCStBOU1e6x2Qmyvw0LTfaNoryW+bj8a2+Z9JLP8Ajm+g4emiOkq5U
         0CWQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+9dn6ugyj1tsqEycRntrjHy854TWRA6zQYia7Dm5k5lv2KbJAJ9xzCZvu8OrF2GFX1Rk=@vger.kernel.org
X-Gm-Message-State: AFuF++m5H9r5XzOpc8M8N05lDS7wJT+NDTkC47iZ/dqgoOFp1XXddqy1
	A8dLU1oUZIG0hSdmiDnBhBgFK6/yuidUq21Bblw5N1FO8rINRzzjlQSR
X-Gm-Gg: AYBFou3ahKTrqbo2cDEm0k3qX3mrMrTC8PognOtpjdUY/rdaKiIo4WD+1FfnI/6lLr2
	ziDEo3EOn0i96LvXCCxMe3kvgnB9bBQmcbPFtFde5nZAsDRJnCVQM9n2FQqs+m/M+nnS5mPLTef
	pByGNok13GUUtbG6O4Rn54EJD0jS1JTCbUzgWff4IOiOSM8ZHzK+0dqph3cMYOHI4DU/Hy+b/wB
	T6tDp36HdPIIXKloNvDIuumoi92Kw3lc5evShCdNuWsR7frnHszMWB318k/LkPcRWFJpjM4kj1s
	/S++00/dnT5upA+DTIyflLbP7w3F/Uc1catygm6usyDkHYrMk6pb6uFMf7YMDarjfJR9tz1keLQ
	+juW0/qFOSx7Zinq+3pb0Jtc/KMIO5ETaBJ9vDJNg4e/ZrYFC7tG3x4lpGDIgFTv0umkVw4AIXl
	WA2HkWja1RNgWeGvDPfLOoAG0YhQos3fJ1kBuUtMiO4ZZaFnQ=
X-Received: by 2002:a05:600c:c494:b0:49d:286:83d5 with SMTP id 5b1f17b1804b1-49d028683f3mr169731205e9.13.1788812762529;
        Mon, 07 Sep 2026 13:26:02 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce4761dd1sm300214835e9.0.2026.09.07.13.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:26:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 7 Sep 2026 22:26:00 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH bpf-next] bpf, x86: Use global buffer for trampoline size
 generation
Message-ID: <ap8d2AhD7Ax13rJ8@krava>
References: <20260907160538.922450-1-jolsa@kernel.org>
 <DL9CKPXX2OFG.2EK0RAZUT2PMV@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL9CKPXX2OFG.2EK0RAZUT2PMV@gmail.com>

On Mon, Sep 07, 2026 at 12:56:33PM -0700, Alexei Starovoitov wrote:
> On Mon Sep 7, 2026 at 9:05 AM PDT, Jiri Olsa wrote:
> > Currently arch_bpf_trampoline_size allocates and frees a temporary
> > trampoline buffer on every invocation. The buffer is only used as a
> > scratch space while __arch_prepare_bpf_trampoline() calculates the
> > required size, and the generated trampoline is discarded.
> >
> > Allocating a writable scratch page during kernel initialization and
> > reusing it for all size calculations. This improves tracing_multi
> > attachment time.
> >
> > With current code:
> >
> >   # ./test_progs -t tracing_multi_bench_attach -v
> >   ...
> >   serial_test_tracing_multi_bench_attach: found 55227 functions
> >   serial_test_tracing_multi_bench_attach: attached in   1.563s
> >   serial_test_tracing_multi_bench_attach: detached in   0.256s
> >
> > With the fix:
> >
> >   # ./test_progs -t tracing_multi_bench_attach -v
> >   ...
> >   serial_test_tracing_multi_bench_attach: found 55235 functions
> >   serial_test_tracing_multi_bench_attach: attached in   0.798s
> >   serial_test_tracing_multi_bench_attach: detached in   0.258s
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> > was "bpf, x86: Add support for jit dry run",
> > - doing this by having single scratch page instead as suggested by Alexei
> >
> >  arch/x86/net/bpf_jit_comp.c | 30 +++++++++++++++---------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index bba351944202..13ef0d53ca29 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/filter.h>
> >  #include <linux/if_vlan.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/init.h>
> >  #include <linux/bpf.h>
> >  #include <linux/bpf_verifier.h>
> >  #include <linux/memory.h>
> > @@ -35,6 +36,15 @@ void __asan_store8(void *p);
> >  
> >  static bool all_callee_regs_used[4] = {true, true, true, true};
> >  
> > +static void *trampoline_size_image;
> > +
> > +static int __init init_trampoline_size_image(void)
> > +{
> > +	trampoline_size_image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
> 
> I think I asked it earlier... why does it have to be execmem ?
> Can it be normal page?

ugh sorry I forgot.. the page/image needs to be in execmem range
for emitting call/jmp otherwise the delta won't fit in 4 bytes
and it fails on emit_patch is_simm32 check

> 
> If so then alloc it and free it every time. No need to keep one page in reserve.

hum, you mean drop the change then?

jirka
