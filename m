Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D38324B30
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540037; cv=pass; b=k4THtxgLU2JnqNXBb9uB2hZGO7yc/nMAM23qwCmexXkYF8F747dUi5g6f23IFRNAamNIP1IWHj07tf/UkjqsJVLazTxKRqoxNr6dwKaWPKCUqXJNmOQKpmcy9url9mfGY492XN3pocVfyrqW6G4sAtjepDHIPSu8JTW2grAdl4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540037; c=relaxed/simple;
	bh=HqGSSIMQnvrXMkQS669lVrjmCn7djiy611x09at2CcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hc9o66hKpTVd7P01/8v6jVClpKR+G95PqhHV/yTFodk5XSGCzTKRJ0rJZ/1nHwdxmwQC995Woc0zSHFwt7mqIG9CydtNo5dtaUVUQBwR2C1FQJ73y2DERDoo1BQA5VUkHUlMWPb+/ZdNAcA2sOiFLaJPyBvWM7xJebtzaXzjGmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6bB/S49; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6bB/S49"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c718c5481so3510721a91.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:53:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769540035; cv=none;
        d=google.com; s=arc-20240605;
        b=YcqDwqoHQd1ln2jAzdDZdt+xmxqfUGe5KbJwLGziQVOPeAkTOP+ijtnezkHzxFD4p9
         NTQXHDXc8wYYSTtzfuY6dZSaSOgTe2AUwEhXdbL5rKImCid2bxzUJBld8yp220mYVN31
         neFhR36/3mJAA8w5vtlwU4M9U5o/Z4ClDp17RQ7IcoXYSARX9Ja8B6R/sPBDAI4GaMQ3
         ANzFgU+5U4zeqtbCZZDLwPLlFLQ4tnEI1084v6AVGlL1fF/xlNW+i02RNJJedoTuVoP5
         rB7aHGRnoKyyu53Lny7xMWhssjjdT+pRDAZed7pL4+QbI4Jm+J+fo4teGuLio3xwlvbr
         irCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zd/RgR03nCqHhHXHjAaLt6Gai7jQtXKD9XomL5p9iLw=;
        fh=afqtdvjCksjM+sFbTjIqgTNP6PY46hPOoOpghAXPXCQ=;
        b=OEu+1s/SDyNduQJQVG/qUPUlvp6rEl/hORmRDUqTWuwIFmCWPybM4HpHPMnApnBUrw
         K6UFtBWafchrSnlrlPgxstqRXJGt+3KQrGUIRsDOhyz4q0IIxYOXq5D5/rUkWnhuPd43
         FXJd5QqK/HSH2JtNf9TE2TraBM0dAi0ok5AnuVeF/Ru8XSP6SFJb2SVVkP/LS7rxzIct
         xY7uP6Ws3Ns8TERzCcShNIVDlQVdkiMCE9CZM/5qwpVv78k8htl4P3pqmXQXViAtbsaS
         P/c3/MkNIeXRB4doBbj1VcuKHde9xJWdCYv5vU4JXWq3IdckUQHCuo/Ck0fe3BmODp6j
         fW+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769540035; x=1770144835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zd/RgR03nCqHhHXHjAaLt6Gai7jQtXKD9XomL5p9iLw=;
        b=F6bB/S49f14iOrJewNQyQ1+/R9eIvFRTgz/JS6MD8N04dYQFR0PBG+qdOPRZ1KTWXg
         3to52+m+5s2WT23AeqtWnWWBsYX+XnAr/8LARUjOzKpEJfixYCPJj2OmDQpTTtgudSeM
         dwMZYkuyOxXf8gzNflzRMuOfAnnv/knmOcDz3djZeoObhelQDHR+gsLx2SHNJO922lZM
         oIHgM/ReoFN6EKfTRcw2D+cLWPBfE/ljMgnCkx0Xpwv8ofpNJVw5VFnbQyjyfVaWVPhD
         ptMaE0z1lttrlSDvdYhsPjXoAsjxZML1Doay6jbyeSR43I6/c4iBHVnfc+tFkrRdHVII
         Eexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769540035; x=1770144835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zd/RgR03nCqHhHXHjAaLt6Gai7jQtXKD9XomL5p9iLw=;
        b=tmUqLM8Y6sfBvBMjY8BJYyltcR90W9SfKiMac1kQPiymlkchw5iKAJ36WWM9pkyZFB
         svC7OrlaSRKaUbvsNGm1ESR0x4iyr3thDAhxiJluItyV+QAwYorCi+yRKKeytoW2p2TT
         CILPBx5+Cbx03bd8AZT4hPUr/p7nTktvh0yyJqlM5NsG52MPxgttECv2Ejo6cD/gMZ6A
         72nylLraYdoI75LIP36xKOKZrBRswc7A4iEz++vh3Y2vOP7NFu2BBoSW0LJI16PrH+ud
         lVqHZdZ8okz66KUNlczdnC4KduJ4ZiY5I5A7oX6TSoVohINU2xGY/Zkl6uAd9X68J8nW
         fDzQ==
X-Gm-Message-State: AOJu0Yyg8mM2L4DUUgKepNah2jPstvpmbdlLn65slxg2Ny2w7lroeBit
	RF543nes2sFCkRCp9NNen6FyLCFkcDgXC+FFxbcyvn3WLxEEHzxjRFr7kNOwWDeDazDXZo9BQ+W
	ccmKvT2ELX8b8ktu/Ww4DC3sXvYI4cmI=
X-Gm-Gg: AZuq6aIaWogqn4+cmS7FC/vjl3DuRACVrwGKX88InhG/IFVnVMCO69AgmiShMZffD+m
	3n3M1fIQGpeijQoegYkqM1XJxo4Oc7IZaz56OqXATaZeT2/FBScLIHAYrS3L2NJzMkr4vgwq/sj
	H+/JpHNIK2GNDm7a6zfmOhw3h3lZeoxwlNbuSPSA5te9e5cDxHPwNeFTLcDnCWiRJmp/bOvbKLh
	9OA6p0X/YqBfZ1cRd0UgIccvdusv2SZMP9H6yWmECHKZQW0RBn5Xi2ZUz4bzUXA+Mqfe3pcvHwa
	7TF9q8ujZZw=
X-Received: by 2002:a17:90b:3fcd:b0:32b:baaa:21b0 with SMTP id
 98e67ed59e1d1-353fecc6bcbmr2432865a91.6.1769540035582; Tue, 27 Jan 2026
 10:53:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127163408.1991583-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260127163408.1991583-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Jan 2026 10:53:43 -0800
X-Gm-Features: AZwV_QgYhG50F_7rnnYhuT3Tx_JIWcpSM0kV0zDsK_a1gCkQBUMIA8yahEFcG6M
Message-ID: <CAEf4BzY48PKYcUU9sQ+g9CXd69Xuf1Js6Ow0TtTSt8m9SC353Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add hexdump fallback when xxd
 is unavailable
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	kpsingh@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 8:34=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> The verification signature header generation requires converting a
> binary certificate to a C array. Previously this only worked with
> xxd (part of vim-common package). Add a fallback using
> hexdump (available on most Unix systems) to generate equivalent C array
> output when xxd is not found. The XXD variable is auto-detected at
> Makefile parse time.

why not always use hexdump then?

>
> Fixes: b720903e2b14d ("selftests/bpf: Enable signature verification for s=
ome lskel tests")
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 9488d076c740..820816257590 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -31,6 +31,7 @@ SAN_CFLAGS    ?=3D
>  SAN_LDFLAGS    ?=3D $(SAN_CFLAGS)
>  RELEASE                ?=3D
>  OPT_FLAGS      ?=3D $(if $(RELEASE),-O2,-O0)
> +XXD            ?=3D $(shell command -v xxd;)
>
>  LIBELF_CFLAGS  :=3D $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
>  LIBELF_LIBS    :=3D $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || e=
cho -lelf)
> @@ -722,9 +723,19 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SE=
TUP)
>         $(Q)mkdir -p $(BUILD_DIR)
>         $(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
>
> +ifneq ($(XXD),)
>  $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
>         $(Q)ln -fs $< test_progs_verification_cert && \
> -       xxd -i test_progs_verification_cert > $@
> +       $(XXD) -i test_progs_verification_cert > $@
> +else
> +# Fallback when xxd is not available: use hexdump to generate C array
> +$(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
> +       $(Q)ln -fs $< test_progs_verification_cert && \
> +       (echo "unsigned char test_progs_verification_cert[] =3D {"; \
> +        hexdump -v -e '12/1 "  0x%02x," "\n"' test_progs_verification_ce=
rt | sed 's/0x  ,//g; $$s/,$$//'; \
> +        echo "};"; \
> +        echo "unsigned int test_progs_verification_cert_len =3D $$(wc -c=
 < test_progs_verification_cert);") > $@
> +endif
>
>  # Define test_progs test runner.
>  TRUNNER_TESTS_DIR :=3D prog_tests
> --
> 2.52.0
>
