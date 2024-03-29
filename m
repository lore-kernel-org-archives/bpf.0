Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE462C692
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737035; cv=none; b=DuEwAPQfU2YbTsd2d8YPhHdG6zWshCKWI3m5qNhjkHIogzpA1DSwjddtA4k244xOYlv7QXKHGYPZGKIiWLbAw+fvrfn8Rn7XFxSraXm34CMtEXAJd1HkDCZPcF2wZ9OAWLQIk34U9JDMMn/rchs+jBRELbeamOmPVc5Eb/LN/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737035; c=relaxed/simple;
	bh=q/F1TNYPkJhFsuDuppKsN8HVYoImbE00nNc6S2CCJac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FO8coDWR+9EU2LQIdtQeE2evR9gUz58OMsQ9KuwgO756XGxZkCae+MDTcmBCH4Jgx+QIA1cNJymVB3lnmzhXCm+W23/GNFdRu3xPo0L6iqcJ4LufJ0cNjkJy7K1nMTd2mlhYKmRVVyBYoKsi1ky5D28pTy1i2e68PnadmYvf0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOUbBHtT; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOUbBHtT"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29dd91f3aaeso1636372a91.3
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 11:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711737033; x=1712341833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J05HSZIDd8jTGpq5C2OUElFJzTTpntn4mQdyHRKZmoM=;
        b=WOUbBHtTzlZPPEGh+ACpkWE75aFGnw3Z0Ue3QPvlj158vcOR5C4LCUFr2L65QKJXXs
         Aw48KBU2kvxV2dNHBHsZW/7F2K0JJBibVIZNV4gZIeLXVuWWq33DWK/VHMbCw9K1JjcV
         ND2m/QL/J31ApjwndTJcTB8ugikqSH08yF8uDtBvrkEPsX+b+d6XM0wkfg2vNJQyDXC6
         bkkJQEL58YkJyVeAMz1xB6CrBMJS+vFYW1WvtRKZ5yj+NVpLw7v8D3bW3KqZxkp6VvKW
         SWtgQ7oMbbyEegDLwzx4Q56lR0pZkHEw/HoPmdzXLBIx/BOXCswVY9dgZCf/HnbToUg2
         4PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711737033; x=1712341833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J05HSZIDd8jTGpq5C2OUElFJzTTpntn4mQdyHRKZmoM=;
        b=kJLSUUkaQJ0KB6mO2onD/qvQI2LcZ/qI8H/eRS6BbIUDG9YrqCTMaA7hmytoYzKWCP
         H4fmm9MT56zm7YpRJJzsCXDEi1PY+f3Frbxk3iHUvo6aN0zhrr1moEd0ZZwsEiWvhzup
         oDQWila2u+aTzzaW2s9nq9hmTUXINCvT6Pcz/11gStXJkygI0u9cRrljR6BUGVPXdVus
         atoe/exZy29BKRvkX2YqFvD6sxlILZCKB1M5Zf+QRkxdpemWeoGFBs9SyMSc4ZV1UQHj
         NIWvw558c7jw7Z6V2mLeKt9+w74xAa9Vt1IluJqbyS1zhOd9Iop+FRR2+TQIuTd/ZsMn
         uo3g==
X-Forwarded-Encrypted: i=1; AJvYcCXZRP8TWVTc+EqEFe6mzNu02YtcCe5OPlHVQ6W/HA8enTvETyj/xIaDOADn0MkLGKTfoAek7iiLK4knybcqaVYHf2V2
X-Gm-Message-State: AOJu0YwuVkmvXY84LipLH0Ld3ZsFLRDTyYo4X9VsiFo6goe0dC8wY+iZ
	wz+ZhQ3ZPqyk0uRUi9aH3eTYnurO6I62mayMNGbfuZMz/PKnjDEt1zrCC1tmebGRW/1Ox6IBYYd
	y7wYJiaOoInmlfF9cHAb4ro1ezimNaOTQ
X-Google-Smtp-Source: AGHT+IE9y4Naod0ZuC9aj7oPrnLuZfXQWr7q7WRJT0YlqgjCZFvXghS6URohH5fywjTzuN8oUQbM87Lgp95xeN/VkRU=
X-Received: by 2002:a17:90a:df97:b0:29a:6c13:f0a with SMTP id
 p23-20020a17090adf9700b0029a6c130f0amr2720746pjv.16.1711737033137; Fri, 29
 Mar 2024 11:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329173654.3174156-1-andrii@kernel.org> <CAADnVQ+8ZHKu54A4E=drNb_gUW988x=T+ojNfVJNs+aMQ-7i+Q@mail.gmail.com>
In-Reply-To: <CAADnVQ+8ZHKu54A4E=drNb_gUW988x=T+ojNfVJNs+aMQ-7i+Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 11:30:20 -0700
Message-ID: <CAEf4BzabrOvorkt+cjYdqfSrHDLSycOB8vGEgP-E0UngQnrKdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: make multi-uprobe tests work in
 RELEASE=1 mode
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:21=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 29, 2024 at 10:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > When BPF selftests are built in RELEASE=3D1 mode with -O2 optimization
> > level, uprobe_multi binary, called from multi-uprobe tests is optimized
> > to the point that all the thousands of target uprobe_multi_func_XXX
> > functions are eliminated, breaking tests.
> >
> > So ensure they are preserved through noinline + asm volatile trick.
> >
> > But, actually, compiling uprobe_multi binary with -O2 takes a really
> > long time, and is quite useless (it's not a benchmark). So in addition
> > to ensuring that uprobe_multi_func_XXX functions are preserved, opt-out
> > of -O2 explicitly in Makefile and stick to -O0. This saves a lot of
> > compilation time.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/Makefile       | 2 +-
> >  tools/testing/selftests/bpf/uprobe_multi.c | 4 +++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 3b9eb40d6343..b0ac3dd80acf 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -759,7 +759,7 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
> >
> >  $(OUTPUT)/uprobe_multi: uprobe_multi.c
> >         $(call msg,BINARY,,$@)
> > -       $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
> > +       $(Q)$(CC) $(CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
> >
> >  EXTRA_CLEAN :=3D $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)                   =
   \
> >         prog_tests/tests.h map_tests/tests.h verifier/tests.h          =
 \
> > diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing=
/selftests/bpf/uprobe_multi.c
> > index a61ceab60b68..e38228563766 100644
> > --- a/tools/testing/selftests/bpf/uprobe_multi.c
> > +++ b/tools/testing/selftests/bpf/uprobe_multi.c
> > @@ -9,7 +9,9 @@
> >
> >  #define NAME(name, idx) PASTE(name, idx)
> >
> > -#define DEF(name, idx)  int NAME(name, idx)(void) { return 0; }
> > +#define DEF(name, idx) \
> > +       int __attribute__((noinline)) \
> > +       NAME(name, idx)(void) { asm volatile (""); return 0; }
>
> I prefer to use __weak to avoid inlining and compiler optimizations.
> It's less work for compiler as well,
> since noinline doesn't tell compiler to stop analyzing the body
> of the function, while __weak does have such an effect.
> And asm won't be necessary as well.


makes sense, will do __weak, maybe it will make -O0 unnecessary as well
