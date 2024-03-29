Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C52541206
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736495; cv=none; b=hHb3TfPPODT/RQQL9bwGgSp768Z98hh5eNi7JswPNS+ydqRkqr/3GwLo19EqnsyuyHJRy8YTznUeCIi7Es6SUv614FZifq+Dpz7RBOSmAQSMkIN50km06P2+VCEhpUVH2ZIMfJKvOUfxKI1t5dOSrd9t/tvXQ8WCO1OIniiEosQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736495; c=relaxed/simple;
	bh=M+Q/eR5VqZSe/tsJ3+qrm+Kj8G6rLHwu0eXPnJJAemM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c08T7kzSNvCYm2iKdyW7HE65COs5wROIFa6bmRLWclWk2SUNBxpzBy6b8EDVSL8t8Ksm589p8J9PlGpzZtIBycSHxzljTefdBnh03n0SADNdWLdAy2nxqISJM1bpkqonSG8+CPNJQ3/ct3kCm0o2n/THqtQ4SDC2Nx2ocuSA73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8X6CCXh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8X6CCXh"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34261edaf7eso1497793f8f.1
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 11:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711736492; x=1712341292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G43ZK/2OGjPcafVU9v8Nu4iPHIx3vRKhgWYPtXgufhU=;
        b=I8X6CCXhMelKDPsMgpOr7ixhESPh5IFac3qQcI3C7mn9B2KDvkVVWZdquUa2u/Q4vt
         IlN3+yW17S7s2KL0pBJjRoi9kDmyvBUiBcoUwXknOdKjLnQtZw+SHqvlldFs8IFbaVte
         1hCVZl20F12Okwq9uLZLlxXv/ORI8DzY/d8K5UiCxmXE3j5h/IFXaMN/6oKhNeBTYGxT
         o3bPSERxjBYwHcDeR359teh+l7bWKdozi//NW0NRloxU8URJUx7v1skLxmQ9XiOFZR5e
         6SohntJ8ITGJCrIiMBhymO86wEhnnDBKFG1Tv8CF5AJEk1+VHons+KoE2hW4ogxAO2jN
         uCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711736492; x=1712341292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G43ZK/2OGjPcafVU9v8Nu4iPHIx3vRKhgWYPtXgufhU=;
        b=wSR0dYsYPxEVsfQuEqfPQn4h7InALJtkdp5sJRzDKEbYndbEG/sz3IU4dpSiWc6kaM
         4BeoYmHO0MNxiAfb2Z9cbMCSFMKq/n/y6NY6RRFalebJMWEXFTpKC1e+XgHdSIE5ldiW
         x4NPKnvnwYas+Lqjnd4vbRaYDlsoEb1phSQfTnYQtQ6AnI8J4Uu52jgfkn0DM4DtWDKF
         E1dzAUyn6RBpKkAPBeDK7nMDi0gI3noOnEhxiC8jrYA8GYoIa4mhOo70NIieXbGMBFEv
         l51JzIc0uQJG5HG6RRttdKSU0CEOSgmmR1KsQXQUY5MKu5gs2DjH/i2+kIbqZBF+W5ix
         1Wlg==
X-Gm-Message-State: AOJu0Yw2hXVzSLTjVLmaR4fRF/zyVklYfRLp6iLdA80oW131Rp5exp7w
	swPV+0suT8SKcJF2LFPjHBq4nJ6qlqcb/aljcyXak4o5iYAkv47u0/B83weCYCWS1AOMcXDd8cs
	bJbk0AQa59x4U3qD8WMaaKxIoLCY=
X-Google-Smtp-Source: AGHT+IFBhtoW1S9d3rlYt3Ud6EvnXMg/IBx1oTQdAGgg3jT8bbs0lDYoo/Yx3aaQ6E6GDg0fBVQxaAqCCD+GpTjNhoA=
X-Received: by 2002:a5d:4ed0:0:b0:33e:c974:1290 with SMTP id
 s16-20020a5d4ed0000000b0033ec9741290mr1597114wrv.18.1711736492161; Fri, 29
 Mar 2024 11:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329173654.3174156-1-andrii@kernel.org>
In-Reply-To: <20240329173654.3174156-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 11:21:20 -0700
Message-ID: <CAADnVQ+8ZHKu54A4E=drNb_gUW988x=T+ojNfVJNs+aMQ-7i+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: make multi-uprobe tests work in
 RELEASE=1 mode
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 10:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> When BPF selftests are built in RELEASE=3D1 mode with -O2 optimization
> level, uprobe_multi binary, called from multi-uprobe tests is optimized
> to the point that all the thousands of target uprobe_multi_func_XXX
> functions are eliminated, breaking tests.
>
> So ensure they are preserved through noinline + asm volatile trick.
>
> But, actually, compiling uprobe_multi binary with -O2 takes a really
> long time, and is quite useless (it's not a benchmark). So in addition
> to ensuring that uprobe_multi_func_XXX functions are preserved, opt-out
> of -O2 explicitly in Makefile and stick to -O0. This saves a lot of
> compilation time.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile       | 2 +-
>  tools/testing/selftests/bpf/uprobe_multi.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 3b9eb40d6343..b0ac3dd80acf 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -759,7 +759,7 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
>
>  $(OUTPUT)/uprobe_multi: uprobe_multi.c
>         $(call msg,BINARY,,$@)
> -       $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
> +       $(Q)$(CC) $(CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
>
>  EXTRA_CLEAN :=3D $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)                     =
 \
>         prog_tests/tests.h map_tests/tests.h verifier/tests.h           \
> diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/s=
elftests/bpf/uprobe_multi.c
> index a61ceab60b68..e38228563766 100644
> --- a/tools/testing/selftests/bpf/uprobe_multi.c
> +++ b/tools/testing/selftests/bpf/uprobe_multi.c
> @@ -9,7 +9,9 @@
>
>  #define NAME(name, idx) PASTE(name, idx)
>
> -#define DEF(name, idx)  int NAME(name, idx)(void) { return 0; }
> +#define DEF(name, idx) \
> +       int __attribute__((noinline)) \
> +       NAME(name, idx)(void) { asm volatile (""); return 0; }

I prefer to use __weak to avoid inlining and compiler optimizations.
It's less work for compiler as well,
since noinline doesn't tell compiler to stop analyzing the body
of the function, while __weak does have such an effect.
And asm won't be necessary as well.
