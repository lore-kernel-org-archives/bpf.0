Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D033F5B2
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888833; cv=pass; b=bQNKDbqu2y8VcxOnZVRUZNu5yHnxsAwS26iF0QNZ6hJFYNoiX2RdV25rLpHGAxkI7gnltltzV+tK/ycR/MDCok/SOda4t2G4oFtWdywlSVLuFL1wDvjc/y70tU5O1FxfFSaErQT7w1Sy132+8CqV3cjmVN/BLRhQClc9FW47C6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888833; c=relaxed/simple;
	bh=Tg1mG369+Od1cS3/QPefmB1hVmVVudUR64WNcifkbvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qER+fSH5zLBfYJVg50uTD/eUGrD5yAhRsh2dh8yHZHjahMEJ2YRD/OqJBWQL8cFK4pcqTJNbHSLfcnkRbTnCoVSBW9EuaEJjr51R9E2j6k2yvRs5iT3otaEudSxzy/URBRNKIkEa2I3952N+etre52s1US0a0M7aXDMABWJbk20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrFj1fq7; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrFj1fq7"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15e03c2763so93833066b.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 17:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785888829; cv=none;
        d=google.com; s=arc-20260327;
        b=iD9UJDOqFK2lm5fePuTWXsvpxYA3b1wjYDHj5uifU8N2Zi1XcTauDDcBoLm1nWgnzg
         rgiRmLCbSCpjG3u2e5xfsJQ4ZzUkxuFzNfkOm6m6dG7++OXyw2W48JVd86D0/xhYqE6/
         2KV+et7pmbWXePEa7oHKZHUs4Rl6zhUCjX1F5irIQdY+m0pMZJ7M5lpNtqiwyInTfR2m
         Ry6VaCNJPGV54IYPPyXLrUmH8Q6Qus4rYuBQHAWvn5YpwPHUr/bE8OTuy53gBak6izMe
         fqc69G06G15iP0OCwq6M32/Oy1QggA3Qj9R+R7VM8bCqDe2mUQeE+MMJ71dDAOKk0mMx
         +KFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TFpjSAcjCB3drRnuWnc3QoqnOMyx7VYMyKfkRCzH2d8=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=OdYxnM8zY8tEs0V7B8gNIY5UpJuH9ZHBxuFfMfELfGi6EweLaxMKt5M1D4eghTXTHK
         CuPmFM6Mk1UjzkhsCOuC1PAgTh8uUHWTxCS36Zysj7w/Gk65pT8XS+HxpO8kM2yqTutU
         w99+OBegypcyFZmZ+DoF+5oYJnMq7hLh+mrcdqjJpNvmfbi+6xj+9lTWFRUvtjZ+DLQW
         Yjo9xu++TnWR1gjW2Qy5eS1UeaYQ/rjKcYo5yiJYQvObdPD2URyLSDI/VYWMaIc8NeI5
         Ubr8hzssAOULpDAjQeRU8oHnaFAFFjg2tfFblxfxtLwUxleBa7QhEltBF23hdGUtRTTr
         5MKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785888829; x=1786493629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TFpjSAcjCB3drRnuWnc3QoqnOMyx7VYMyKfkRCzH2d8=;
        b=CrFj1fq7YqxpRmXBw9gIW/JNPIV+TDd+Bdhx32kJZyFFFeI6PgA9e21N6s+su55kd6
         VdrLVYXP1C2A8niylZ52H+onCwbOUzqOUgVhJ9+hdOYa3hfBTz8ThPT6G0xhNfgq4CKU
         bI28MhJ7A+RmTT3LTNYzwExJ/wRpy6GhXo3MWSAoZD1i8ThfT+2XxhYxKhlDUZKTIABz
         eRQhhGNAnSSdxYf6NhwENJlj0IFA0uAk+85BPBOF4kRigo1iegJtqGXuPilZGm8GSkVf
         5yQnKz6OANGSWfvbBRaxVZLZS+HbIh9mSvApYS01sryjfFmeT+FtbFqJ47XO9AS73TRv
         L0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785888829; x=1786493629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFpjSAcjCB3drRnuWnc3QoqnOMyx7VYMyKfkRCzH2d8=;
        b=o+ah2B3WG8NQTKLNbIgJZ9UJCDz+wRtRZrzMR5aUj0rXahNmzQpDj7qyH7wVL/28sQ
         gHJtjtfF+ig/dnhiEktyPTjH18jOP4/ixuwEb+ZprLTmAAA0y7MiAQRWu9X2x/yiSDZk
         ALwY8JjzJ99uGfzke5W3CsT+qrD6FqerLCyOOSWm3Vzo4Fu/g5+DFxqNrLa+ICvJB+Wn
         KVADVzQw+g8Z3YDUK4xakNcd9dlyowe9KKTC16SytF1j1IZqA1l/wMMZmolbOg42X1U9
         kSW9728offLLqOG0g1fVDnB6SoC4++/jXCVPV1UJDpydNbExyrM1PTwdbP+8Ulvoy5iS
         pbQg==
X-Gm-Message-State: AOJu0YxB7MtTj3wZI49bPyxWmdICqP7OYmA1PqDyW6Zn+Ex+ZabCxRJz
	rSmwXjo1STyAAObKMVvWFgEy+21ZezFFMG2rg8OVq+Juv9rBwbb0yZTdasAu4l2N9HsBvEuIZyx
	aDrrXq5tMP6vrup6BDFmfjDk+y10iggtPgDSfHwp/LA==
X-Gm-Gg: AR+sD12CCX6/C1lDOChMLpGHDAiS49xI3avjYgon8MdGQGm1aZiaXZwmGvusYxqLfGK
	8mWndbAjWK99Kh06eaU1F7MRGBuhHC1UPZIGSY2Y/NsnERyWq2yf0bQfbVYWDAn0bufrvFNmkN1
	7O7a/wvwMxTSCmn1Z1Znu/CUiNvkYjUe8KnscOEDO8pklYCxVnFJyE6JmGTw++3cX16u8MaSFPV
	0j4igo87S657dvZ1xPbAComsjRzGjqy32f8ucnlLXEqxe/Mbu+g4VRcy38jfN+UI218yjMV1N0u
	VgEvZqSGxuX1k8HrTrqytpoQgpba29bJt2pdDd+eIuvd7+EB1bY0BSNtMyiPhXZv+yeMTaGDkGA
	NycJQBmwKu5r0
X-Received: by 2002:a17:907:c23:b0:c15:c323:36e5 with SMTP id
 a640c23a62f3a-c20247ce99dmr701047966b.10.1785888828957; Tue, 04 Aug 2026
 17:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
 <20260804170156.1709916-4-nickolay.lysenko@gmail.com> <20260804172109.442151F000E9@smtp.kernel.org>
In-Reply-To: <20260804172109.442151F000E9@smtp.kernel.org>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Tue, 4 Aug 2026 17:13:37 -0700
X-Gm-Features: AUfX_mxu2pzDdE-b3NdRwEZPqstjPE-uaWoUZB1ZTPpU2wJTrMt5tLLHhpftwuA
Message-ID: <CAMtxOX3f-u0cnDiXuHyxUuiMWwosC9sj3xmTDy-ATaFAKuX4RA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 3/8] selftests/bpf: factor the
 permissive-mode skip suffix into a helper
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 10:21=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Missing space in SKIP message output due to GNU Make's function a=
rgument whitespace stripping.
> --
>
> --- Patch [3]: [RFC PATCH bpf-next v5 3/8] selftests/bpf: factor the perm=
issive-mode skip suffix into a helper ---
> commit 5a41b62fa6a5d8d794a18de41a7ff9bb6b7087f6
> Author: Mykola Lysenko <nickolay.lysenko@gmail.com>
>
> selftests/bpf: factor the permissive-mode skip suffix into a helper
>
> This commit factors out the duplicated skip logic used for permissive bui=
lds
> into a common skip_on_fail macro in the Makefile.
>
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -49,6 +49,14 @@ SKIP_CRYPTO        ?=3D
> >  BPF_STRICT_BUILD ?=3D 1
> >  PERMISSIVE :=3D $(filter 0,$(BPF_STRICT_BUILD))
> >
> > +# Permissive-mode recipe suffix: on failure, remove the target, emit a
> > +# SKIP marker and report success so the rest of the build continues.
> > +# $(1) - SKIP tag (BPF, TEST, BENCH, SKEL, LINK, ...)
> > +# $(2) - optional extra files to remove alongside the target
> > +# $(3) - optional note appended to the SKIP message
> > +skip_on_fail =3D $(if $(PERMISSIVE),|| { $(RM) $@ $(2); \
> > +     printf '  %-12s %s\n' 'SKIP-$(1)' '$(notdir $@)$(if $(3), $(3))' =
1>&2; })
>
> [Severity: Low]
> Will GNU Make strip the leading space before $(3) in this if statement?
>
> Since Make strips leading whitespace after commas in function arguments, =
it
> appears the optional note gets appended directly to the target name witho=
ut
> any separation space.
>
> [ ... ]
>
> > @@ -1012,8 +1002,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
> >                $(OUTPUT)/usdt_2.o \
> >                #
> >       $(call msg,BINARY,,$@)
> > -     $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o =
$@ $(if $(PERMISSIVE),|| \
> > -             ($(RM) $@; printf '  %-12s %s\n' 'SKIP-LINK' '$(notdir $@=
) (some benchmarks may have been skipped)' 1>&2))
> > +     $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o =
$@ $(call skip_on_fail,LINK,,(some benchmarks may have been skipped))
>
> [Severity: Low]
> Because of the stripped whitespace mentioned above, will the console outp=
ut
> for this rule now print as "bench(some benchmarks may have been skipped)"
> instead of "bench (some benchmarks may have been skipped)"?

does not seems to be the case

prozak@powertower:/tmp/tmp.U6wCzgIl5v$ make --version
GNU Make 4.3
Built for x86_64-pc-linux-gnu
Copyright (C) 1988-2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

prozak@powertower:/tmp/tmp.U6wCzgIl5v$ cat Makefile
PERMISSIVE :=3D 1

skip_on_fail =3D $(if $(PERMISSIVE),||  \
{ printf "  %-12s %s\n" "SKIP-$(1)" "$(notdir $@)$(if $(3), $(3))" 1>&2; })

bench:
@false \
$(call skip_on_fail,LINK,,(some benchmarks may have been skipped))

prozak@powertower:/tmp/tmp.U6wCzgIl5v$ make bench
  SKIP-LINK    bench (some benchmarks may have been skipped)

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804170156.17=
09916-1-nickolay.lysenko@gmail.com?part=3D3
