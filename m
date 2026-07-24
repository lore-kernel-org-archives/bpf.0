Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06130C15F
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 04:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784867307; cv=pass; b=S5vooKUyw383SCRylQqisZr4Zqlck8QwYOjuQ9E7ELClx/DuX+Vm0wbiSZntDWrCFjgPDa1fk10BfucM9YK9u/B+wOWDd9e6FUb/oElUxvxVb7EWKtcZsx98YL+TA50sjxJVmHxWpwFdyZmhFo/O2yQVoe6C0ye85uL8XfZqWu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784867307; c=relaxed/simple;
	bh=MyPDn4eooePolahvWlF1muKvZlIemQXxt01XJY8Q680=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afzg8HYhqitSTW9RkoHEOzKZlAnlqgd4JMIjHxt1MbqjdOnSOxF6XqwkouhFc5hvyKJ7ngzXssq/A0nKfuS4q3kGDOaJWH9aAx0YmQJWYHilF5uiiGc2Lbx110hxX25rh+TVUmm9TqSpk3obrtb16G3Kd5T/zCuz78bmGExTwfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjLIwe9c; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjLIwe9c"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15c42a45adso164726166b.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 21:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784867305; cv=none;
        d=google.com; s=arc-20260327;
        b=ELzwaKdMDyiClfOWTyXalB7bsif9QuZVvtlaS8YjdDrr8oiuFqZw/0MmPt78m4eDdy
         ePagpEYF7vJDPGUnDw2DOn/Twrt5V3aUu5H1S4qflZIQ7o3O+iaMEEracA7prtBtxJAJ
         RBNe1Fv2nxKMJkMUZSA/3vBmP9uPQCn31q3XzIzTc74+fsgQ/vAdKQBXifrwhrO4UfzQ
         N08ql65f8AaM17+ALozlcY3x8xZPZO6wxnGluQZBkvw+ZiJasatC1Y4348Oq63KGnTWe
         +zTdiFO74qtZ3uIf1YtXlI/rz9HoT2GcCPzjbxF7LoLi078/xze75eowQneBI3m3HK07
         CKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bsCAxnqusFzsOq/kKmF0UBtYjQK+mfSaqLYWf8TgnT8=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=qy5OKS2nv727LBgZbn1Sv8c9jZ4Pkmd4oas9Z9HUL4+B1Lja4Zac86+7aViAd7m0f0
         Wk27CKpGCBKg+nEyqTsyGAmzSgWIEJz/1YQIIaKBxUZuEC6l+8/ZPslFD1r6bey/nBln
         9QcGkEqRO2mE0Txa5KVLZohTGgN30o/RJxnnOE1y0M0bBS8lTqY4OOQ4RqIiEm7iJWmm
         54O9YBLXaRO9OxtqkpYwbDfcWSwScQnRteg0zN/NsnyPi9K0c0C/use9j8NXMk766xGb
         QL7NBOs/Tasl8HlHXeh/y9OwXlUjc4/LoYE7mxQIRVqEpe/fpgR3Tc7AqdfJA1lP/Y6w
         1dYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784867305; x=1785472105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bsCAxnqusFzsOq/kKmF0UBtYjQK+mfSaqLYWf8TgnT8=;
        b=bjLIwe9cxIJ7WxMHKk/WYr8RjG7xSTrZ2hXYSgjZ+5uC2EObv9jCiib6AVJT8KO1Xr
         HoscKx9+MaGsJKoMuPWymXEOxVos0zZEJFgFP2Dk3qgXeofwz3my13y82kNVZ82a9OXr
         rRlz/guzj0Q3gefYeCvx0aOcwX7KlHa1SgLtyrn0BWBRJMF2fdFq4ZLH2+8414sJ+lTY
         0oHJDB/rUs3/WzFU4VQuGdsmK4US1KBTJlj3gtohJIwuwkjvSzNpP/zIInxzD2H4mYWt
         kUH9TFmjnMp4olODYEVDxC9N02RbrOkADP0uYTU8IxajvnCV95YcoVOs2K6xFM0xIlq0
         28iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784867305; x=1785472105;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bsCAxnqusFzsOq/kKmF0UBtYjQK+mfSaqLYWf8TgnT8=;
        b=oKDVjV55PKbCrGdSYWVSJXmKOK3r6L/wBVwJFABRR4YFySDN4iWRTauKYbaFlLTaDg
         s3IG7jOEJofXCSQZvKijhCiTxwYM58EdScTfayeRcf0oymIk2cqPXWXfM8YWihfgsibh
         yXMZLsbHybhuV8zZbgMRqn8+3vbCPur9eHqxv2v4wUWF/HIi5Mo844D5Ui58lUUxOtls
         guDF1WwirRRqtCahdcZttQm3fJ3E4nqJ3CdengxCWwqFCfD/cZfvw0xG5AvYxz4cUurM
         pYmbCh0JRs/3tMb5sC3l05Kd0cOrC+4SDAuCXj64Rg+XzYFgrujsOcjhbtxP7drsOpWo
         XN4w==
X-Gm-Message-State: AOJu0YxAzKDzR4UeF+k6djJj+bS/U3a/dO8pvhxKMNa12yfKnv7rG2cw
	WEh0ZfCrinvxwqDcM/JTtd572Q5/E/dXcf71RUYrWLoKJWkySeZcB0qJOa2p7M+kTRQqJzWxzQN
	e3eF4tnVB6a8bnVLdfFXEFpmpgSwfWnYt+uyS95Q=
X-Gm-Gg: AR+sD10Pyo8sXJtrQS1YxiZMSgnRvjYN5d9DSF4e0KXSNG2i/eMJgoY8AgqiQugYJf4
	ycAY+uoC74uDUTY44dnerAUx6a/tsdEjezKr2cHMzhZEfZuO2ZBKet+eFaw2LvFFKcg2jI3bShn
	FjjGAZ+VfgmjSqbZ+DbRdDMQmFWNKZOhDPI6RH8LosbifQlf0QcaRrD4g7zLMpfUq/EPqeWaOr+
	ary04bhmmtQYJTXRIi1IChd5zD1UjBQJtFv31qkgErmbEbtRyYiD+uq8Hp2Tg1HJO6wzf6OBqE2
	DumFknsgK52B/V0SDmo=
X-Received: by 2002:a17:907:7246:b0:c15:ee17:47a with SMTP id
 a640c23a62f3a-c1c537e0bd6mr227777066b.15.1784867304541; Thu, 23 Jul 2026
 21:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721194111.334795-1-nickolay.lysenko@gmail.com>
 <20260721194111.334795-4-nickolay.lysenko@gmail.com> <20260721195155.B78721F00A3A@smtp.kernel.org>
In-Reply-To: <20260721195155.B78721F00A3A@smtp.kernel.org>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Thu, 23 Jul 2026 21:28:13 -0700
X-Gm-Features: AUfX_mz1ry_NYVT2qajIRIsr5RtNG0YgQuCj-21T2ekm8QsXLd2o0xSsYZTZuzg
Message-ID: <CAMtxOX3S0VGWwVV7RGQ8nr+S8ByxsEMSkzGNCYCa05tE_q98VQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 3/3] selftests/bpf: build each test runner
 instance in its own sub-make
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

addressed in https://lore.kernel.org/bpf/20260724042600.175440-1-nickolay.l=
ysenko@gmail.com/

On Tue, Jul 21, 2026 at 12:51=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] In permissive mode, test objects are treated exclusively as or=
der-only prerequisites, which completely breaks incremental test developmen=
t by never relinking the test runner when test sources are modified.
> --
>
> --- Patch [3]: [RFC PATCH bpf-next v2 3/3] selftests/bpf: build each test=
 runner instance in its own sub-make ---
> commit f7cbf6f3b146270d8f7ba71d9ea0557ab2070208
> Author: Mykola Lysenko <nickolay.lysenko@gmail.com>
>
> selftests/bpf: build each test runner instance in its own sub-make
>
> This commit refactors the bpf selftests build system to use a dedicated
> Makefile.runner for each test runner instance, running them in separate
> sub-makes. It aims to eliminate double-expansion complexity while fixing
> parallel build races.
>
> > diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testin=
g/selftests/bpf/Makefile.runner
> > new file mode 100644
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/Makefile.runner
>
> [ ... ]
>
> > +# In permissive mode, link whatever test objects were successfully bui=
lt
> > +# (their compilation may have been skipped); the wildcard in the recip=
e
> > +# picks up the survivors at link time.
> > +# Prerequisite order is also link order (test objects, extra objects,
> > +# libbpf, lib objects).
> > +$(OUTPUT)/$(BINARY): $(if $(PERMISSIVE_TESTS),,$(TEST_OBJS))         \
> > +                  $(EXTRA_OBJS) $(BPFOBJ) $(LIB_OBJS)                \
> > +                  $(TRUNNER_BPFTOOL) $(OUTPUT)/veristat              \
> > +                  | extras $(BPF_OBJS)                               \
> > +                  $(if $(PERMISSIVE_TESTS),$(TEST_OBJS))
>
> [Severity: Medium]
> Will this break incremental test development in permissive mode?
>
> By placing TEST_OBJS exclusively after the order-only prerequisite pipe (=
|)
> when PERMISSIVE_TESTS is active, make is instructed to not rebuild the ta=
rget
> when the test objects are updated.
>
> If a developer modifies an existing test file while using BPF_STRICT_BUIL=
D=3D0,
> the test object will successfully recompile, but the test runner binary
> (like test_progs) will not relink to include the new object. Does this ca=
use
> stale tests to be executed unknowingly?
>
> > +     $(call msg,BINARY,,$@)
> > +     $(Q)$(CC) $(CFLAGS)                                             \
> > +             $(if $(PERMISSIVE_TESTS),$(wildcard $(TEST_OBJS)))      \
> > +             $(filter %.a %.o,$^)                                    \
> > +             $(LDLIBS) $(LLVM_LDLIBS) $(LDFLAGS) $(LLVM_LDFLAGS) -o $@
> > +     $(Q)ln -sf $(if $(FLAVOR),..,.)/tools/build/bpftool/$(USE_BOOTSTR=
AP)bpftool \
> > +                $(RDIR)/bpftool
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721194111.33=
4795-1-nickolay.lysenko@gmail.com?part=3D3
