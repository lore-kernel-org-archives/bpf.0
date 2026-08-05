Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE73446CB
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894058; cv=pass; b=JP5Gx9cOx4P5kRZYRecft1ThV8y9DAQQTwoGbkLrMKLNSPbaiCPG6H7jlaw1lqZtB3RGxVTWGJY0m5MFM65QMDiS7WoRTq7O3mezmm8wj2aNJhzvF6w7JlBsAbFpAJJ054lbbYiFVzd/wk7O0LcCHAmZXZZkanz/8sANWMQNpPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894058; c=relaxed/simple;
	bh=pPyg7K2vslrzk0vHWbu4dVkgZmi+23mzJxE0mTnTsA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsursjdHz5hJFB3S6JvkGEQuUXPcgubGNV730nGlFDN/l/trBrAdyJwjtAiXJKVvBa+Heh37X2P7y9e0skgF61H8BMcROi4FAF9YmPO4I6aHlccoi4wKl4Cu/T2Va7UDZGzw7ORurJgQNWUeaF/yIT+S1k+Xu3+nNCW/KrFsezM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgRzSu8i; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgRzSu8i"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso321056a12.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 18:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785894055; cv=none;
        d=google.com; s=arc-20260327;
        b=RA0bqXSEKoJ+0uEi8wFd0if3P9kGV4I3wecb9v/7z6KBYVEHUqNeooSKz6Y4msDUvd
         N5REHi//JQ0jaczn1e4d0Xs75smGYAS1kjYZFCOYn2eL5koeNhggZYK9EAuEz0//7nN2
         zOQPdqNqWX9Jje3a0A7l5Q5I5W5AfqHIWuRtOCVcinFuwx+QspgUh/Rbm4Z3ktO7NgRw
         SGTitTDaa9O4AB11tmZEizANoHtBKPCIBnj82jRBiOGvrc9fi3+exrSfFlimr+YV7pKk
         Gn6jf8BC3wiAdaL0DxRCVJRjVcnohSRCwq9wgWNvzU2YvF23fNClifSZBFiZZRRowDWP
         KX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tCe1PHBV2z5lmY55d+MmZeq9ngGC4whGPN9INfCQUbw=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=O5OvAJVoeEb9kv6icE3RIFhRd/7ShLvQ14NPVJ6e0JR3zWsqB/GfxZ+zYY1XJA48gL
         TNS6M34hkR135Bq8MgEuT9T0OFsAeiGfOjDzUVzB04RXfhwi9ElHGZ56zOkjw8KVD2B1
         kzW/gCKlD+YQ1ZYL0a8+rJLzxZZvWi63tXuzeai5gJgPvjUwnZQbGiKnKw2phLU1gGW2
         83Ixz2S6KHICyL8lgL9lSWOheW6Tk1wCvk/sKVqLTcL6I0EB0VVky/CfSN2SiwAyrNXX
         9vZEaMo10DCU6bQmcOzSgvvajEwmnZnaAWHY7vs86EtzhfjFVotMg/7mYz3vw7mFQWkN
         dXmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785894055; x=1786498855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tCe1PHBV2z5lmY55d+MmZeq9ngGC4whGPN9INfCQUbw=;
        b=bgRzSu8ixzLWsViiWQQqwct/TDji74ym3ayiKU5QUYMGbhPX6Da+J6MO6cf/bpHSH1
         OsFV6y56QVepsuarIurePo94sMZD5STUp7fXfzW2Wl8Ges62zD4IBVklAn8kjPhuNyPD
         Vxjc/DktdO/Uv9snRzyNSPSmGXeFaarDY8DcmxZTgPVQRJkUO5Cw27FHt3Dya4nVuadz
         krtNHzYMV3PmghBFoFW9+huhb+4f/l8ffF76bglfYP+Y84OMH84ekJjZ91tBn1WKD29r
         bGXYnniRTEnytPUWbFbvbbhqG9HAL9CxoN/ltT3opuYjJ+qJS+hf0svNPJ7sRtHuZgdo
         HC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785894055; x=1786498855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tCe1PHBV2z5lmY55d+MmZeq9ngGC4whGPN9INfCQUbw=;
        b=ouKnYbFeGUFVPnT3J1YKeQRLGMj61VCduTNDWAydhKY4MKiid/AskfAragNP/2IGd3
         h6KebrRtbsj42rEIQ6oV6NZI1hjyfys0qkYe9l6f2ihG8xkpashKWnW8as5ri2ij3h8C
         RB2Gi26y5jUGab43fiyobQeDRNV0ERRbnLNK3kotH49/SWNCjZlbFR8vXWhmBIct/uU2
         K3J5yP/Zpt+MIWJAOdI3iJVDq2yZNR/kqZm9AdxVIO23NyOlNqdRezFBdESbyD0u0f63
         jJBzayc9/fh7H83bByxx7j5usN8u1rd5Ez8gbvT1TTzUZO2Fb9+gkqH3s969PHYvQQFZ
         uPKA==
X-Gm-Message-State: AOJu0YzPHAGi53tWpepkJuTFceoovndm0J9+2VxFoJyISAli4aPgOP9K
	qhf6B1rKL36LWsmj7EsnTagpXyWjkocD5if0ntVpcHxhDYe3ywum7PdXVFhP5iOnjDLhxeowMca
	FpwOZsPpxWj+YaUmiC89jJfFThHQO1o9CAeYCE5kXyQ==
X-Gm-Gg: AR+sD124I13QG++S6/itrQ2kv5X8Wnlw8UBrZR9PflBrOrmD2hlg7b5KQGTznkToysl
	KNg9tlhNvmhe9eyz/kEkh3n8DRAIj/keoITjQvm51VW841MLUYMiYBhpggBP5qNBv8aNmruCc1i
	7tSHpcPhrE9Z3OvyEAfEPiEk3A1hO9DpA2KSwth7gRktl9iE+R6R2uurAk4F7O18VBInvfkSHTa
	cW87C/8Tdc6qnpsolaDG+dgFkKlrdyo1SA80Uf8PO+mUZYRwXibg7JyRk5J/g6R2cSXNsBtHYY4
	gG2HPpM97o5hnjxjxNuDSYe08HSIlmn5jaRnuftAs8egCmJHskL65YFY0Ry83K91wOc6igi4ASP
	SF4lAVKgDpStI
X-Received: by 2002:a17:907:3e8d:b0:c20:2d38:e518 with SMTP id
 a640c23a62f3a-c2039ce5eafmr131391866b.2.1785894054463; Tue, 04 Aug 2026
 18:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
 <20260804170156.1709916-7-nickolay.lysenko@gmail.com> <20260804175948.3AFF11F000E9@smtp.kernel.org>
In-Reply-To: <20260804175948.3AFF11F000E9@smtp.kernel.org>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Tue, 4 Aug 2026 18:40:42 -0700
X-Gm-Features: AUfX_mwNkS3kz9QKXZvh_atQ8kHPSx-Jv81lPBEPMvjZcwdqAHj7BQQjJ6y2lVc
Message-ID: <CAMtxOX2Kpzom-r7rEBJ4AWsBf67XdCfavR2GaOyXqo7Pe+ZDiA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 6/8] selftests/bpf: extract BPF skeleton
 generation into a helper script
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 10:59=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The patch introduces a behavior change in permissive mode that=
 results in noisy build logs and redundant error messages, contradicting th=
e commit message claim that 'behavior is unchanged'. Additionally, a script=
 comment references a non-existent file.
> --
>
> --- Patch [6]: [RFC PATCH bpf-next v5 6/8] selftests/bpf: extract BPF ske=
leton generation into a helper script ---
> commit e4a593d3d0bfe3675d723364cb65f81a2812b866
> Author: Mykola Lysenko <nickolay.lysenko@gmail.com>
>
> selftests/bpf: extract BPF skeleton generation into a helper script
>
> This commit extracts the BPF skeleton generation steps into a dedicated s=
hell
> script (gen_bpf_skel.sh) to reduce Makefile complexity and escaping issue=
s. It
> handles regular, light, signed light, and linked skeletons through script
> flags.
>
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 0ee02eeac6bca..dbde2f6bd044d 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
>
> [ ... ]
>
> > -$(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
> > -     $(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then                    \
> > -             $$(RM) $$@ $$(@:.skel.h=3D.subskel.h);                   =
 \
> > -             printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; =
\
> > -             exit 0;                                                 \
> > -     fi;)                                                            \
> > -     printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $=
$@)' 1>&2; \
> > -     $$(BPFTOOL) gen object $$(<:.o=3D.linked1.o) $$< &&              =
 \
>
> [ ... ]
>
> > +$(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $=
(TRUNNER_OUTPUT)
> > +     $$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
> > +     $(Q)BPFTOOL=3D$$(BPFTOOL) ./gen_bpf_skel.sh                      =
         \
> > +             --name $$(notdir $$(<:.bpf.o=3D))                        =
         \
> > +             --skel $$@ --subskel $$(@:.skel.h=3D.subskel.h) $$< $$(ca=
ll skip_on_fail,SKEL,$$(@:.skel.h=3D.subskel.h))
>
> [Severity: Medium]
> Does this change in permissive mode behavior contradict the commit messag=
e
> which states "behavior is unchanged"?
>
> Previously, if a .bpf.o file failed to compile in permissive mode, the
> skeleton generation recipe would quietly check for the missing file, prin=
t
> SKIP-SKEL, and exit early without executing bpftool.
>
> With the missing-file guard removed, the recipe now unconditionally print=
s
> GEN-SKEL and calls gen_bpf_skel.sh. This invokes bpftool on a missing fil=
e,
> causing it to fail loudly to stderr before the skip_on_fail suffix catche=
s
> the exit code. This results in noisy build logs and redundant error messa=
ges.

It does - good catch. Reproduced:

prozak@powertower$ touch progs/fentry_test.c && $MK LLVM=3D BPF_STRICT_BUIL=
D=3D0 \
 "progs/fentry_test.c-CFLAGS=3D--definitely-bogus-flag" \
 $PWD/fentry_test.bpf.o $PWD/fentry_test.lskel.h 2>&1 | tail -15
...
  CLNG-BPF [test_progs] fentry_test.bpf.o
clang: error: unknown argument: '--definitely-bogus-flag'
  SKIP-BPF     fentry_test.bpf.o
  GEN-SKEL [test_progs (signed)] fentry_test.lskel.h
libbpf: failed to open file '.../fentry_test.bpf.o': -ENOENT
Error: failed to link '.../fentry_test.bpf.o': No such file or directory (2=
)
  SKIP-SKEL    fentry_test.lskel.h

The GEN-SKEL line and the two error lines are new - the old recipe's
missing-input guard skipped silently before bpftool ever ran. The
final state is identical (outputs removed, build reports success and
continues):

prozak@powertower$ touch progs/fentry_test.c && $MK LLVM=3D
BPF_STRICT_BUILD=3D0 2>&1
...
  CLNG-BPF [test_progs] fentry_test.bpf.o
  GEN-SKEL [test_progs (signed)] fentry_test.lskel.h
...
  CLNG-BPF [test_progs-no_alu32] fentry_test.bpf.o
  GEN-SKEL [test_progs-no_alu32 (signed)] fentry_test.lskel.h
...
  CLNG-BPF [test_progs-cpuv4] fentry_test.bpf.o
  GEN-SKEL [test_progs-cpuv4 (signed)] fentry_test.lskel.h
...

While the output differs, on reflection the extra printing is
derivative - the compile failure is
already reported in full where it happens - so the next revision will
restore the quiet skip
(and with it, the 'behavior is unchanged' claim becomes accurate).

>
> > diff --git a/tools/testing/selftests/bpf/gen_bpf_skel.sh b/tools/testin=
g/selftests/bpf/gen_bpf_skel.sh
> > new file mode 100755
> > index 0000000000000..e234f3a57d46b
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/gen_bpf_skel.sh
> > @@ -0,0 +1,93 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
>
> [ ... ]
>
> > +# The bpftool binary is taken from $BPFTOOL (default: bpftool from PAT=
H).
> > +# On failure all outputs and intermediates are removed and the script
> > +# exits non-zero; permissive-mode skipping is the caller's business
> > +# (see skip_on_fail in Makefile.buildvars).
>
> [Severity: Medium]
> Is the reference to Makefile.buildvars correct here?
>
> The file Makefile.buildvars does not exist. It looks like skip_on_fail is
> actually defined directly in tools/testing/selftests/bpf/Makefile.

Fair, will fix before re-spin.

>
> > +
> > +set -u
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804170156.17=
09916-1-nickolay.lysenko@gmail.com?part=3D6
