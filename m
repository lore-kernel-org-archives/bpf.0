Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE6367F2F
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584733; cv=pass; b=QAQCNEuCRwcm9P/zu7n2GnLWlWSaLD5DuADCUzdDZFQseSCq8l7Y95XdCm8dV9ho/FVveXPaPXGhtBWEYf3ijikGOxh1fZ5hMy5ZSZUgBs/F4ERPOM9bze4LNk79yYHNz8Gz+37t9FtmDT3rp1SeGW+/bshrfw8P8wX0Sswdca4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584733; c=relaxed/simple;
	bh=BcIjz0TwFTjpzBBWL7usC6KhzrrYdTOn3cvUnb4jHYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEO7QT3U8/CmJeLgO0rgQRLx+p41cZeqK0A9bLHSG7k86Al8jjiMR0dLbBmlTw3RhPvsn7+Z1D6DNq+t/pQzpU7tBWmuZbHhXwHPgk9Gmkk7z+zk1b/UOFk7ikiEiagHYZW/voP2mIB6H5TiHfMn2fa4exanFJR/bao96PmLe94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DmC7Tzi/; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DmC7Tzi/"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso3161853a12.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 08:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787584732; cv=none;
        d=google.com; s=arc-20260327;
        b=WkV3Ou14GCP3ogdrVGykecgJ086n1mmMdmGlcmmNG1jjWg+uX8V+UHFFeONsBFQfG5
         p7zWuTg4UMbh5pFmkFwj9Eo3XH0D9V+1zoDMNhIjZ88ID7CUCcNT4jvKAovadADaH3f8
         DzI/JchCKct+gSHe578txekmLy0h/ngNl4CBRlyDAKXtXR3WwhmKtilRbD+rwFmh//gn
         d50iaF/ulJW9Fw3RkxrdiHHXZ+JWscWW+AlD4bXAVIygmvlpjQok7y9tmHISh2mlrW8w
         WqE5S+PDxcT5NcJ+8I7AeFb/5fcC2Ni9JUrKpoVJe5p7Siag1o6ydVCkZnN1dqBJV6Wn
         VDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gqb137FAD3j5AecU+kBp3iNtBsHjhinz7tGtlFwvT1g=;
        fh=j60FGbLnMTzZics3jwX74xxVFAFNheP5iRgEYEyAO5s=;
        b=e9SgwLExE8rQ0jHoj4sRepyPy316AfV8FdkAa72Tp1U8pgpPb5BXdcj1leO1pIZaBC
         uP+vF4kaI0qARjwAe9iwtnQUPERdzWklJlcoRjNHR0BBTOpn0URG2c6l2Imeh1EFelDb
         xQ6hJ6YsBj0hC2VXW6Mpju509G9s3fkwLiiPO2qtX5DjtYgM3t0rYKuDdPk30fBHuEXJ
         REh9/W59BVW8MpoH7h43rBGiivT4DOUHHV1ghqdyh0hVfbND8PJk9OLMZ+3cRMJ71IxC
         eqJJA+zq7vBqUTAmaQk2gxnGe3PbASzRoPOK2fAYOd8YB+nuqBnBLsVBHwMMX/dUkasf
         yX+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787584732; x=1788189532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gqb137FAD3j5AecU+kBp3iNtBsHjhinz7tGtlFwvT1g=;
        b=DmC7Tzi/pqA1ivkYiKhm4VJ4/+FkXwv8qpNPqPOlpvZ74P/sl1t4Jy139gOQtY7RDL
         uCFU6cklEI2Wa8Da28cf23dyMILTvIsn/wpMAnXxGmno8vtwhs6u/M1xhuZxk3k2SoZ/
         T/h9/o4RecRGw8/QtDe2LUHD8itb3b0S60pdFlegWxNwg1ez9/80pCrynu/pl7XJkyGZ
         UVua9hBtiy/wX1d4smdlv6AmBCREEMGj3IlPxGb0sY5tzyzCSQqMzSyhkKn7ywRta0ZZ
         Geest7hN3h6VoGYE38PRxrdsZzIKfxTBWlu8EZNnNeumFvSrTXwLVBNWobINQswcq7sy
         astA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584732; x=1788189532;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gqb137FAD3j5AecU+kBp3iNtBsHjhinz7tGtlFwvT1g=;
        b=FcQ6wlh+K7OFvjh1/nrwDvP0TmRwEXTgD7p0AebsiFX0beUqgVMQvOXZ0yjRl7Wo+4
         t5VtoxQGNgMvHHRTSsU8dystJJwG4C3s5s1/jISDyO7xdY4M6Pu6mcarXUDdkfe/v2F9
         uw+NwpNivilkl9oabvcyxo/7/Q9i6/PVo+5tK8W3WGuv25A2ShVYBeiibim6Co4SB7gt
         cbuELNBcPnYcNbKKxZsXaf/JuK2vimtxw1oZgu8lOXTto+2cFI8uOrcAGSiWcm2LZMhv
         JdjLTFD5apfLTOl5NqgXVH4Gpiy0HoAvSKbg/iNB2D4c9Y3w4KgSmwFnVymzraU38vB0
         kLeA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3BxP/sQulx0dtD5CmZ8ovna7C8Yi3qG4PaY4KrSjaUiWmSbVJqUaJw0q4L9KWgVXoqNc=@vger.kernel.org
X-Gm-Message-State: AFuF++lEFyAbtFaIsQx1BEW19TIGU9RC11wyff8ii/tio641c0rWewaz
	2dF3Qtr4mS4aaTxfqJTUbbJFUDlEFORJNSVmr4b6G83LYBCTlQazVyugrsN6zS9nRDw9RWTr2n7
	+6fJ/QjjFaYVrhtqBsVqrWL+w9k15D2C2a17oQV0G
X-Gm-Gg: AR+sD110lwXmSPR9Ximc25yFEcsFH4naHXJYlzVKDWdJz2Usci/pUnWHs4hDde0sLMd
	+FWzGNctDzB3TLy37f2+1t8zegAqVpO7BSR91M7vYqwPkcNug3uMj+ZvXSnKCegmU6BTIPP2wIk
	DYz6Mt5wvV8HU73TsYUafXvZkMvfK90W1IXZWE3I8oPGUjc8Yqh4panruKqRKknz+UwiGDNx8Zc
	gJvnPDqRv+m7iOSAMA8TT9iAVav6vnJW+pDPZ88ZRIfZhYyIAiG1/cmbFRUDfD3617eUD7a/K+2
	0qrocrf6y44di2Xho0t7GWbuvwKoMc7Px96tVJV338AY
X-Received: by 2002:a17:90b:4aca:b0:390:84db:888e with SMTP id
 98e67ed59e1d1-395c50b3dd6mr21407866a91.7.1787584731573; Mon, 24 Aug 2026
 08:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821214111.1120748-1-daniel@iogearbox.net>
In-Reply-To: <20260821214111.1120748-1-daniel@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 24 Aug 2026 11:18:39 -0400
X-Gm-Features: AcwNN1WWEwc8Nxt5gv5xsgwSa3ey-6k014cKfPpsLJfAMhEvNSlS6jEnRNiPYeM
Message-ID: <CAHC9VhQb9-zR-W5acwACe=bH0VvmwPEAyGvsJNG5VyVxEVhtJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/11] BPF keyring and signed loader ML-DSA support
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, 
	memxor@gmail.com, brauner@kernel.org, kpsingh@kernel.org, ast@kernel.org, 
	john.fastabend@gmail.com, a.s.protopopov@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 5:41=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Add a dedicated BPF keyring which is integrated for BPF signing. It
> is modelled after the dm-verity keyring which was added in commit
> 033724b ("dm-verity: add dm-verity keyring") and which can eventually
> be used also via systemd through the same enrollment method as in
> dm-verity's case. It is selected with a new well-known keyring_id
> VERIFY_USE_BPF_KEYRING and gives an operator a place to enroll a
> BPF-only signing key at boot, specifically scoped to signed BPF
> program loading. Next, to demonstrate that BPF signing is algorithm
> agnostic, we add a few small tooling changes to support ML-DSA and
> integrate everything into BPF selftest for BPF CI to ensure nothing
> breaks with future changes. For more details, see individual commits.
>
> Daniel Borkmann (11):
>   bpf: Add a bpf keyring for program signature validation
>   bpf: Refuse caller-supplied keyrings when the bpf one is active
>   bpf: Raise the bound on a program's signature size
>   bpftool: Support ML-DSA program signing
>   selftests/bpf: Add a test for the sealed bpf keyring
>   selftests/bpf: Rebuild signed lskels when signing key changes
>   selftests/bpf: Rename the verify_sig_setup.sh setup into setup-rsa
>   selftests/bpf: Add an end-to-end ML-DSA signed loader test
>   selftests/bpf: Allow appending to guest kernel cmdline in vmtest.sh
>   selftests/bpf: Add tests for bpf keyring in signed loader
>   Documentation/bpf: Document the bpf keyring and improve examples
>
>  .../admin-guide/kernel-parameters.txt         |  15 +
>  Documentation/bpf/signing.rst                 | 274 +++++++--
>  include/linux/bpf.h                           |  13 +
>  include/linux/verification.h                  |  10 +
>  kernel/bpf/Makefile                           |   3 +
>  kernel/bpf/keys.c                             |  72 +++
>  kernel/bpf/verifier.c                         |  42 +-
>  tools/bpf/bpftool/main.h                      |   2 +-
>  tools/bpf/bpftool/sign.c                      |  22 +-
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  tools/testing/selftests/bpf/config            |   1 +
>  .../selftests/bpf/prog_tests/signed_loader.c  | 518 +++++++++++++++++-
>  .../bpf/prog_tests/verify_pkcs7_sig.c         |   4 +-
>  .../testing/selftests/bpf/verify_sig_setup.sh |  63 ++-
>  tools/testing/selftests/bpf/vmtest.sh         |  16 +-
>  15 files changed, 974 insertions(+), 83 deletions(-)
>  create mode 100644 kernel/bpf/keys.c

CC'ing the keyring folks for obvious reasons.  A lore link to the full
thread can be found below:

https://lore.kernel.org/all/20260821214111.1120748-1-daniel@iogearbox.net

--=20
paul-moore.com
