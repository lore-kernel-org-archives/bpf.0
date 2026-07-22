Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD233A9D6
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 04:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784695810; cv=pass; b=J6gCPLKqoiPxQnh/yzWT1IS6ypUzOwJaJteUyQroz3qvTVF8fEyYS2y0qhEWn7tS2xtQVJs6XkvaRFUeLZde3viDng8NebtsIUOmLbE6/o3F1jWGKV3rf2Q9GGwCCzkJifY5CQq+jxtATbRTmrioEherQWzG6P0eF4pa6T4g1Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784695810; c=relaxed/simple;
	bh=DZtoM11vWBXpN7yeX143KogHmDSn59wuNdvkW8Rs0g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wyp+B1iKW1UzZw9swvChIH0NPoH8rEymVzsnXL7FxxPBYVSks6YgJMlsVtlUfH99RrqIhXZMH6ss8wfdbj08yZSbUM+N6jEksWe/yovtVGHtNLyi4paI+azLh0IJRejfSUgeYRstj2mclqgEXds/wp+PYHEKPWdPCqN30O8Mo0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjc0HrLO; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjc0HrLO"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so912390266b.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 21:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784695807; cv=none;
        d=google.com; s=arc-20260327;
        b=qN1zILBZj9Au6CNCnRmNTDX1VNhkG7iWV8kkWkksIfMIfF4j2tb6Jygo5wBafDet13
         q/apc/ruVerV7XWkyfNrwcsc+BrQf/x1mebTotpqkxHLaNGk8C6PfkymI4baARpGfiJO
         X/sSYtjqRo7pxMiJeopM+OAmw4StZaFRfRZYHGgkp+a7MSV1TKSVo2Xgds1AXYI5LEni
         KSrDZT/8rL5plsqN3yCW3okXSzVOzTffFnIojsg4+Hg8nQhmc1P45lF7CQqMilSQMFFd
         h3Q72BDHfOIurWMYxG2n/qRl91kvHXYB17+FIJ+ta/81O633DwtyfamwntmlpDrQohh+
         2Hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LeaH/TFJ1GwO1Q8eKs9LjZXB370WPJ5FOv2mW/b/SmU=;
        fh=7Arrm4x/e3jLuY/3jfr0FhtOrbmLzIqss9WWJZ8vNjE=;
        b=H3lZjxv8//q1TFcLvWyHEoRzl/rbuV08xftQ8r9ADjzYRH31qjAscCeLAzBs9uKbQU
         D114OJBR0K9A/G2W0TrL9ImxMs8mjbWHMqNoSUMCHiQEsQIGUE3cn04IPjsq1kr6h3uf
         FyKBKbEAju6AIjvHSHvGq0c4HT49R/WcCaRsWOii/E+ElyhJwuhm71Ok47aSyHZDgZhm
         CkXYQ5ZA0/f7bG7zmCEvUVQK7xZWUM7WCznnfb/qe/qA8tG4f6FWBS6G1BhMHOYsjeDJ
         5JNGbdTVCLF1CM+vOk+TDQnp+ghJBKwGXh+nP4XhjuI+DWwFH/w7alCVZXRQRGMt4H4a
         IFew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784695807; x=1785300607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LeaH/TFJ1GwO1Q8eKs9LjZXB370WPJ5FOv2mW/b/SmU=;
        b=fjc0HrLOJvTvYfsd0UldKAMhJu+qXV3ZwM5W2nbntHR2vVMQ97FgfUaSf/PPmuJ6ok
         TFDSN/DjV8chU02l2KjDjur3hBOoD1own6QAi9K07lsHpVGzKsvaBp2ScJaFhMI4PPO3
         M6JNNP6BEkd8eVdfY+kjoLzkxTapcIr4xjTZZSqBrQ+PZGoNfHPhFqkAMBDJFxguADUx
         hlEhPw2mkm9Yg6LoPAnD7I5Aow9SZWbMP1VUa+RrPy2erEkVnzfB6KHUvPt+7nLZHXgH
         qUE2IPXz85YISLUN1FqtH/BgQMH+xmWGlm7t9pRX6jcR1l96tSDGxGQwGfWCDhQsYtb0
         fJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784695807; x=1785300607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LeaH/TFJ1GwO1Q8eKs9LjZXB370WPJ5FOv2mW/b/SmU=;
        b=rJCTB3qsTYj16eMEhS2D3Q6mkRGcK5cNbxmL63S/YeOQ5WNqob3m1/52THV1V0Kb7B
         YvQZzs67i9ZHYKqDWm0m1kLLuqkBjbuUg1hVZumebyS2Tk67YdUIPSoif6RPSlVucFfG
         pu0k0N1Pcw0LMoG5zUyjoGfeAcrgemaOtjZsnOgUCF2f2ZOeqvugYFlIR2dsp8XRTIRc
         p+FpswpidCqzJdDtFcyexLeK3izkYzOz4y3ajewdI24nkEa8m+An7jOsEXMs9xojMpvs
         QYp6JHJdHbWWRpiiHrKu/MD2SwGxT/halYOGbQJ65dRGnXij54iJ9jlF/JbOCqJJva9c
         RxbQ==
X-Gm-Message-State: AOJu0YxSqvC2BRZBTWx5eGUhmcWOizc2Q5HwCor8JDmpZempO1Z51TFL
	+HCYWqGO0vDjEi1yB+9yWL1PF3h4islQRN7m8888SlSxqoya3dC0PTrYb0TIs3NNFDOwnmXPCQc
	QtsFudws75NX/Yh7yvrw27AUOeAd0p+FPYyQHjSc=
X-Gm-Gg: AR+sD11Xmg94cV/LihSh3nF/BlrCbdBS8HPTKNZyB9J3z8r+ZHTulEvgzkL7NW00a0G
	U+Nq/REQ28V+AKXxNKyzx+5B3JGRwQj74tcOdKlw6dsQBYB4j+ArKh4Z5VxBqDiG+LlStXy7K2P
	WqoCsUGcRgSJdTqZwbNtfyYZO1f6RfyT0CBYq/YM0Mr+aS9JrTrHi6HAMend536ZCL5gSc0Lqxv
	V32Z2VKAfYN/Gv2cZHMYTZsFpHHbSPfsv5O0ScIMIc0I5LhSBJrDuJSY9Ur9IhJbkhuD9V0QPya
	upmSyvZRTXR47b0+/cIMqK3mGU0X
X-Received: by 2002:a17:906:9c82:b0:c16:7c0:8f1f with SMTP id
 a640c23a62f3a-c16b47c8068mr993443566b.44.1784695806630; Tue, 21 Jul 2026
 21:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722040830.387979-1-nickolay.lysenko@gmail.com>
In-Reply-To: <20260722040830.387979-1-nickolay.lysenko@gmail.com>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Tue, 21 Jul 2026 21:49:54 -0700
X-Gm-Features: AUfX_mxAYcxPlTIIoz_MtkCkM2FMic-hjRSUVJmoQDMQ0nKNnwWDE0HHvo7HPA0
Message-ID: <CAMtxOX1R5Jnb5ZNBtGDcAqwHpWwKT9UBCfbecYj9oESCGaGidw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 0/3] selftests/bpf: restructure the
 Makefile as a layered build
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please do not review v3.

I noticed a problem in my manual BPF CI run
which I missed locally before sending.

Will address in v4.

Sorry for the noise.

On Tue, Jul 21, 2026 at 9:08=E2=80=AFPM Mykola Lysenko
<nickolay.lysenko@gmail.com> wrote:
>
> The BPF selftests Makefile has grown to ~1,100 lines, with much of the
> complexity concentrated in the DEFINE_TEST_RUNNER double-expansion
> machinery: the per-runner rules are written in $$-escaped make and
> eval'd once per flavor, so the rules that actually run never appear in
> the source, are invisible to make's own debugging facilities, and are
> easy to break for one flavor while testing another.
>
> This series restructures the build in three steps, each independently
> buildable and each producing byte-identical artifacts:
>
>   1) the four near-identical skeleton generation recipes move into a
>      parameterized helper script (gen_bpf_skel.sh);
>   2) shared (non-rule) definitions move into Makefile.buildvars;
>   3) each test runner instance (test_progs, test_progs-<flavor>,
>      test_maps) becomes its own plain-make sub-make (Makefile.runner),
>      replacing the eval/escaping layer.
>
> After the series the top Makefile owns everything that exists once
> (toolchain setup, the libbpf/bpftool/resolve_btfids sub-builds,
> vmlinux.h, shared helper objects, standalone binaries, and the lib.mk
> run/install contract), while every runner instance is an ordinary
> single-flavor makefile with no escaping. Total line count is roughly a
> wash; the point is the structure, not the size.
>
> Sent as RFC to gather feedback on the overall direction.
>
> Validation (each patch, x86_64, identical toolchains, clean builds):
> 2,948/2,948 BPF objects, 5,352/5,352 skeleton headers and 1,413/1,413
> userspace objects byte-identical to the current Makefile's output. For
> the end state additionally: 20/22 binaries byte-identical, and the two
> exceptions (bench, test_maps) differ only in object link order, proven
> by relinking the current Makefile's objects in the new order and
> comparing bytes; emit_tests output and the installed tree identical;
> BPF CI green on a manual pre-submission run across x86_64 gcc/llvm,
> aarch64 and s390x (including GCC-BPF, ASAN and veristat jobs); and all
> 76 benchmarks produce identical outcomes on old- and new-built bench
> binaries.
>
> v2 -> v3:
> - BPF_GCC and TEST_KMODS are defined once (main Makefile, which needs
>   them before lib.mk) and exported to the runner sub-makes instead of
>   being duplicated in Makefile.buildvars, where the copies could
>   silently drift (reported by Sashiko AI review)
> - the permissive-mode runner link rule keeps the current Makefile's
>   incremental semantics: test objects existing at parse time are
>   normal prerequisites again, so editing a test source relinks the
>   runner (reported by Sashiko AI review; v2 had regressed this to
>   order-only)
> - v2: https://lore.kernel.org/bpf/20260721194111.334795-1-nickolay.lysenk=
o@gmail.com/
>
> v1 -> v2:
> - rebased onto current bpf-next: ported the semantics of commit
>   0b236ac75d04 ("selftests/bpf: Fix make install target") - bpftool
>   installed under tools/sbin/, *.BTF files installed - into the new
>   install rule (resolves the CI apply conflict against v1)
> - gen_bpf_skel.sh is a prerequisite of every skeleton rule, so editing
>   the script regenerates the headers (reported by Sashiko AI review)
> - the shared helper objects the top Makefile pre-builds now depend on
>   a superset of the prerequisites the runner-side object rule uses
>   (libarena skeletons, both generated tests.h headers), closing a
>   window where the unflavored test_progs and test_maps sub-makes could
>   both consider a shared helper object stale and recompile it
>   concurrently in the shared output directory (reported by Sashiko AI
>   review)
> - v1: https://lore.kernel.org/bpf/20260721174909.8044-1-nickolay.lysenko@=
gmail.com/
>
> Mykola Lysenko (3):
>   selftests/bpf: extract BPF skeleton generation into a helper script
>   selftests/bpf: move shared build definitions into Makefile.buildvars
>   selftests/bpf: build each test runner instance in its own sub-make
>
>  tools/testing/selftests/bpf/Makefile          | 950 +++++-------------
>  .../testing/selftests/bpf/Makefile.buildvars  | 204 ++++
>  tools/testing/selftests/bpf/Makefile.runner   | 316 ++++++
>  tools/testing/selftests/bpf/gen_bpf_skel.sh   |  97 ++
>  4 files changed, 886 insertions(+), 681 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars
>  create mode 100644 tools/testing/selftests/bpf/Makefile.runner
>  create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh
>
>
> base-commit: 5eb8921371c6fd117d4a328b6053dfda38707df8
> --
> 2.43.0
>
