Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800CB4FECED
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870330; cv=none; b=Xns3nO+ufz3lIdkeDI5SZmyKXocGV/wFiMgG3c90iyv1XS+A6IrdqX24L38u6gif46TgWKp6yRCHc+VeXj6eSCEdNxNPqYdRKNdukoeEY6fCxe145XxAUM8E/3GjIAnU54m/hiDFsxPWoN55KF40MaezGPUd4yeKzfqIC61EZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870330; c=relaxed/simple;
	bh=kUmgtBRRW/6YFkzv9CdMafFAsp9/UnVBqyhb6OSx7bc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXgyIWYbIQKQHkM9rTvwQqtqCHzypRIUR6FTVdYNtZgFqv4Bq+DG0EIBrZK3ltRaYelwnLlZpCY7FrUvAIArx2H3yI1K2wZmO94JPwFj4cL6gUIOw0AA+i9z2tY4/GahZ/hV3umuLKCeGXBdrMCb4k0jHX+rm0XOtz9MnGjnBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbTUdmj1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbTUdmj1"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-485850cf499so3007424f8f.3
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788870327; x=1789475127; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JCVse+ZYy1JDa0fOFXVuj61Y1ueoZZouyA9Vhxgb3eU=;
        b=KbTUdmj1Zf0HHzRWVPEV+4jQfX2X15GG/3dbLWDqMg5d1R3D00n/7+k2wjHi+3rKks
         7DJIiB56I1jLIuYtYOJxq7QwmeIrFuwMB7iI73y3HoMrFAHsmQ44Pqjpz+xpFBihZOsK
         yYxi/odgmFc4MnpBjdKqVDjR4LpP1VJxbOZWVxD4R9yk1dALWhqbnpH8mei2V20cQYJ2
         /2MVt7hwuMNWPWi7FlzN0MGHfHIy+alPP46eEKvGYHk5DYfxm0/IwC8Rwaah4oYBCtTS
         jfbB4X+ZBBFi7PIQ3XR0+s4w/01j1VG3FbygInIyIWniaqcdc6NOglQc97V4bAGNV/T/
         1sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788870327; x=1789475127;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JCVse+ZYy1JDa0fOFXVuj61Y1ueoZZouyA9Vhxgb3eU=;
        b=E93JvdijgT7m+5NZHelbnaim9rm8j6961EdfHvXOqmqkm4N1mYLfSEalHaUoCAbjHE
         PAiDSrJv29AqIqBDK9VNWLpVqhA8jONzd+FFUmQy8ehJbjhA9xhkoAoqLhN5pIk9h+Uv
         uq8yA3aUSf0yl+9aMW6jCuah3l890DFr3bVyDyw6Jppxsk/Q9T19wCvia9HSjK/XgEBj
         lOV9B7ZeQza2GhMGX/rZ604bNwF6BrGZ3tlPaClVScLc3aoZA3qlGBHhVzdMj6X7xU9k
         VDygqU34/5kUwLpYmAhLww1CkZ71i7icbN0hnIfrwfjl5zhIyaVl80pXY3tNloJOmtiH
         F48A==
X-Forwarded-Encrypted: i=1; AKwUvBwefmCQraAoNzoE7NJ8GyjihPqLWhnkrAFAyJVY37PCUh7Po/2mPeF2EaKp7k03argYeaY=@vger.kernel.org
X-Gm-Message-State: AFuF++mSTpvMZR9TCJqQKAudZoMTG/y/lRdH5QZyOflvPiboWTRZIVjN
	BdL3Mf6+Wh8O0c2nEaldE9ougCSUlMxS6n/8e0ekeCwolE2r+OQ/1Pm0
X-Gm-Gg: AYBFou0PplH67qEDp8y7clkUMLQVpH5EC17kPaPI5OwTVUK6WdDsppLotG33HBT0ZZP
	RoEu3x8zhwFybKy3wiA3tbXE/IcW3i+tuoPSSG8VDUzXXZAvfZxvVTZNdn/DJ0VrZJe+k7SEb7P
	FB0ey1Tl06coQLCPpjNfR7rr1kdoOSZN2axz/0qkF59ePOEEoF0N3SDWyHsTFQryo+D/mwXBsrL
	yVFO8AmjbtV5weH8yxRbKYn34IsZf1GrMfrqaJhQPJ/m3mDQa87ZD+pcO2oyDfoBkxPs8BfX9+w
	rMB5bM3ofAezhyfQxSbS41JPMqHcWt/Q8jwe7lctNWULrxnOOY6GsRvHTdEqxRlC4xfneO1bnny
	tfLyckM5vVFBfq+vdrUWxb0FqA6bIPq0vb31v3Uuu9B9lIrfgz2a2WUSM1bWwYIML5qxYEJQpCY
	bw0RUETclDrFk/y1CoMW+psyzoIAQ4y5i6EBxQYNhcqPBUYkk=
X-Received: by 2002:a05:6000:26c2:b0:485:9a53:9145 with SMTP id ffacd0b85a97d-4859a539201mr13546430f8f.40.1788870326381;
        Tue, 08 Sep 2026 05:25:26 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm34890455f8f.23.2026.09.08.05.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:25:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 8 Sep 2026 14:25:24 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH bpf-next] bpf, x86: Use global buffer for trampoline size
 generation
Message-ID: <ap_-tAGAqguRdFUn@krava>
References: <20260907160538.922450-1-jolsa@kernel.org>
 <DL9CKPXX2OFG.2EK0RAZUT2PMV@gmail.com>
 <ap8d2AhD7Ax13rJ8@krava>
 <CAADnVQL-vs02PyTOQE9wYK+S988hG7cUMq+DAiD=X1K5+E=zmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL-vs02PyTOQE9wYK+S988hG7cUMq+DAiD=X1K5+E=zmw@mail.gmail.com>

On Mon, Sep 07, 2026 at 05:13:29PM -0700, Alexei Starovoitov wrote:
> On Mon, Sep 7, 2026 at 1:26 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Sep 07, 2026 at 12:56:33PM -0700, Alexei Starovoitov wrote:
> > > On Mon Sep 7, 2026 at 9:05 AM PDT, Jiri Olsa wrote:
> > > > Currently arch_bpf_trampoline_size allocates and frees a temporary
> > > > trampoline buffer on every invocation. The buffer is only used as a
> > > > scratch space while __arch_prepare_bpf_trampoline() calculates the
> > > > required size, and the generated trampoline is discarded.
> > > >
> > > > Allocating a writable scratch page during kernel initialization and
> > > > reusing it for all size calculations. This improves tracing_multi
> > > > attachment time.
> > > >
> > > > With current code:
> > > >
> > > >   # ./test_progs -t tracing_multi_bench_attach -v
> > > >   ...
> > > >   serial_test_tracing_multi_bench_attach: found 55227 functions
> > > >   serial_test_tracing_multi_bench_attach: attached in   1.563s
> > > >   serial_test_tracing_multi_bench_attach: detached in   0.256s
> > > >
> > > > With the fix:
> > > >
> > > >   # ./test_progs -t tracing_multi_bench_attach -v
> > > >   ...
> > > >   serial_test_tracing_multi_bench_attach: found 55235 functions
> > > >   serial_test_tracing_multi_bench_attach: attached in   0.798s
> > > >   serial_test_tracing_multi_bench_attach: detached in   0.258s
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > > was "bpf, x86: Add support for jit dry run",
> > > > - doing this by having single scratch page instead as suggested by Alexei
> > > >
> > > >  arch/x86/net/bpf_jit_comp.c | 30 +++++++++++++++---------------
> > > >  1 file changed, 15 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > > index bba351944202..13ef0d53ca29 100644
> > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > @@ -9,6 +9,7 @@
> > > >  #include <linux/filter.h>
> > > >  #include <linux/if_vlan.h>
> > > >  #include <linux/bitfield.h>
> > > > +#include <linux/init.h>
> > > >  #include <linux/bpf.h>
> > > >  #include <linux/bpf_verifier.h>
> > > >  #include <linux/memory.h>
> > > > @@ -35,6 +36,15 @@ void __asan_store8(void *p);
> > > >
> > > >  static bool all_callee_regs_used[4] = {true, true, true, true};
> > > >
> > > > +static void *trampoline_size_image;
> > > > +
> > > > +static int __init init_trampoline_size_image(void)
> > > > +{
> > > > +   trampoline_size_image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
> > >
> > > I think I asked it earlier... why does it have to be execmem ?
> > > Can it be normal page?
> >
> > ugh sorry I forgot.. the page/image needs to be in execmem range
> > for emitting call/jmp otherwise the delta won't fit in 4 bytes
> > and it fails on emit_patch is_simm32 check
> 
> ahh. I see. Please mention it in the comment and
> also use bpf_jit_alloc_exec(PAGE_SIZE).
> 
> execmem_alloc(EXECMEM_MODULE_DATA...) was working by accident.
> The VM ranges could have been different.

bpf_jit_alloc_exec returns read only page so I'd use bpf_jit_alloc_exec_rw,
but it was recently removed in:

  c7a2a3618290 x86/bpf: Make arch_bpf_trampoline_size allocate from EXECMEM_MODULE_DATA

so I ended up with:

  trampoline_size_image = execmem_alloc_rw(EXECMEM_BPF, PAGE_SIZE);

> 
> > >
> > > If so then alloc it and free it every time. No need to keep one page in reserve.
> >
> > hum, you mean drop the change then?
> 
> Since it needs to be execmem preallocating one page for this is fine.

ok, great

jirka
