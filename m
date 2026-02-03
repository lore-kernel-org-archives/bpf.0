Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F363291C07
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144260; cv=pass; b=ZvHCbkj/Ujv6urma7ay/0nOGOxrIEK2S82vEwGtoq/bS5G1NVZ4Q2ZcgW0hh60xgLXJkMx483RsCFnSlchXLIVg/8lvrF8gDowhAEl3bKusuMr/rPfuKZiMlpvEXJtMIqwvFiu4QyTp9vTmSTKTf/EwJpW5ge9f3chsxqKV+erM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144260; c=relaxed/simple;
	bh=Im4rgwf3E6ZwNtN9dEhHYqmY2ELHiRifIkUXHstQmAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJI5o1y1+RqZsxKmS7H8TXEuDpDpoSL451RU7DdysaPh6Ft+UhLSeF3td6nQVr0VbUm7nZ4ISYQU/Bf/K43ZRhetoMGv+4eyEBTIXO2qdxev6AAKrsUtfqKPpfHbGiqrah6+9EYwNqh0IhhNVwkDgeII7aeh4si75xcU1m3JrQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQvnCaJC; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQvnCaJC"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so3843729f8f.3
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 10:44:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770144257; cv=none;
        d=google.com; s=arc-20240605;
        b=IwFVL97pbi0fZ1xjgg6nHNqfEYTRuYmfFpN4zIFlEPIrD7Te1eyDjGNZLnekyyowkt
         /60MqqTIJAPti8yGgEuwicTviVY9a+ql1zm3HdM1U7L8y4UNQjMOdHqiy9cJQfziRGS5
         U4HSt8DOgJ4fr8kX3BVWOGzbtLpapHmwx+02FuHU2wM29pV0k9LVMuY+3Bjhx6SJ+S2W
         xVImLGDn75KuQBeqlmN1+1/6u8D4qte6GakG302mrXuYbOSWwefIN+jUhTHM6GbOYV1n
         Og2Ghtm821Om2gSuSKC06hmt6r1jmDL5b1C/zSbJlmeDeo8bohZmViIhNCqG1+Ln6awQ
         VYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y/eSjMPi8545w/2b1wcpinwGLR1TY3uQV5L/lXYN5do=;
        fh=kNUGkxli1KZwZV8mJkLZPh7Silb/6tfe7KiAnRaxH3w=;
        b=Uju1hccn57ZF/75qM/wQkK0uUjNF7Uf+pGNiPNo0/oWmBOcUQGkbMpx/Lb/h2aEkfc
         zzjwvijkdZMQmQ5nPk0cHC98AuJ516Y7R9yFOxqkcF4F2beZMW5ISUSEChlFn45L+rtg
         YmilFf18SKZm2RZW89ttBQ6+1aDfjOWBLECjlCWSN8Dsho41h8ZQHVZk5eOPgeOjyIP6
         dJ0476/TOFxQlTasoKJWh/6AI1elUFSd3a6tE+JXxc2iPTw9b1+l2K/ghsOjyE3kaD3H
         ac1/1aTGmIkFinSYf+AS6YzdzBGd40U3oC5FqGmav5qtESLix1QipQQPKHJmWxCxf+4a
         cccg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770144257; x=1770749057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/eSjMPi8545w/2b1wcpinwGLR1TY3uQV5L/lXYN5do=;
        b=iQvnCaJCty2JIWhQas86REZ9bYZlxyM45VOMQ6RnhCNLXlwVCSDYNvll931NLtifbR
         hkAryy+iivUzgKsYedtYuHtmaxe8G5f3R8gc2qYAuxCgSlZsIqkfuSNg9vKqMKQ4flX6
         A+0ZV3bocn46aKIp5knSSv1sW1k2DyLEPiUOuG2tOAOb4fjzFpC5PaLa0WBluIKQa14+
         +GfqN2SFNcHT1hgLr0RQD8prLprdnem9PGEpADRaR6mKEXRz2ksjz2R9g3GDISWVR9x4
         VVzqdY9fPgA6qrFBvFpVG6S5Txmqh640NKw+wswhOkQkr2IrNQqLll0UR0AKV7wBGE15
         +oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770144257; x=1770749057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y/eSjMPi8545w/2b1wcpinwGLR1TY3uQV5L/lXYN5do=;
        b=aJFdaflaFCvcp3zFXxbSq7V/37tXbGSjbYuLXuYEJ0wwCWnvCMACsLGXva6q/mp20Q
         EUSPh+mFZPzkvXbPsfpiWDufitgZ43RW9lTHDXZmsV3ltQl9G8b6K5saCWsnhFO1B9o0
         YJ252tWj3zRGNbGJ+4EfpbBC9PImWU3tPWL/H5jZ9RNq6coZZyC9NQziWcZpSi9m5zON
         yW5pzAPVVQjH3/FlEL/CSQ+HajUG8lz0IO9kJ9LbWYFwTcKQqEaFDZ47yZMVG208mDD9
         N/hyWae5hBy/kxOwPhbpnx+eQquygDvbMV2nROU0r6dzJu3ZZX/f4OMZbzCa7UR6QwAR
         Up0A==
X-Gm-Message-State: AOJu0YwoR8G0taoWT5JqqjATKxYW/1NW7nxJ+/1Nu9D1gbX1Ng0kM1im
	N28gXZTCc0X50n4+NqDL6rA6QFKyRN9CdJ+MmRXj8w8Uy/KC26YfI1eBSyY+WMV939wDFwNLWMc
	MaO0VwbvnTpnQ515r+xkdtp8DaDwmNNo=
X-Gm-Gg: AZuq6aIsNHq6y0TT+hVKC26g7j69tEX/jXbiXtSEXB7JSgNLzOAMnAz5bTCWa3PPDbz
	btMQn4ZiMjvZx53ErK7Ce71K5Vzy/pqTrVh2njZY3Is2lKtOIjsFBLb462afhFyI28QidC7aYfD
	SPps6d3DZmNCfcn0KrT2TcQWfbUYjnh2M9K+T7ZX1kfMZElh83vwNsMQTdbzM5E6VTwxVwulVDR
	D/zmFQ8x6POiTdIvCKpLzAmb9p4FVNJ1sujCJ/1zM8haiiY96Tw6vW0vbdEoGFG4FpQZPVMEzif
	1AV7jqrd7uxi3tWnAQr9jTOGGKmRaiGVV0P+vVU+22Fe4lMD8B1spfIcdQcp+Se/Ph+wAg==
X-Received: by 2002:a5d:584d:0:b0:435:8f18:9539 with SMTP id
 ffacd0b85a97d-43617e3970bmr476836f8f.9.1770144256833; Tue, 03 Feb 2026
 10:44:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144749.22932-1-git@danielhodges.dev> <20260202144749.22932-4-git@danielhodges.dev>
In-Reply-To: <20260202144749.22932-4-git@danielhodges.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 10:44:05 -0800
X-Gm-Features: AZwV_Qjuc4yRZMN8e0jw82q4VJIVoJ4ryoLzyogKn1pKbtGVyVXGQl-iYAU8hyk
Message-ID: <CAADnVQJKjv5fZ0suJkOKtybMNsrDr9d+Au8T08AvHCPzP3z8sw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/4] bpf: Add signature verification kfuncs
To: Daniel Hodges <git@danielhodges.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Song Liu <song@kernel.org>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song <yonghong.song@linux.dev>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 6:48=E2=80=AFAM Daniel Hodges <git@danielhodges.dev>=
 wrote:
>
> Add a bpf_crypto_sig module that registers signature verification
> algorithms with the BPF crypto type system. This enables signature
> operations (like ECDSA) to use the unified bpf_crypto_ctx structure.
>
> The module provides:
>    - alloc_tfm/free_tfm for crypto_sig transform lifecycle
>    - has_algo to check algorithm availability
>    - setkey for public key configuration
>    - verify for signature verification
>    - get_flags for crypto API flags
>
> Introduce bpf_sig_verify, bpf_sig_keysize, bpf_sig_digestsize,
> and bpf_sig_maxsize kfuncs enabling BPF programs to verify digital
> signatures using the kernel's crypto infrastructure.
>
> Add enum bpf_crypto_type_id for runtime type checking to ensure
> operations are performed on the correct crypto context type. The enum
> values are assigned to all crypto type modules (skcipher, hash, sig).
>
> The verify kfunc takes a crypto context (initialized with the sig
> type and appropriate algorithm like "ecdsa-nist-p256"), a message
> digest, and a signature. These kfuncs support any signature algorithm
> registered with the crypto subsystem (e.g., ECDSA, RSA).
>
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>  MAINTAINERS                |   1 +
>  crypto/Makefile            |   3 +
>  crypto/bpf_crypto_sig.c    |  89 ++++++++++++++++++++++++++++
>  include/linux/bpf_crypto.h |   4 ++
>  kernel/bpf/crypto.c        | 117 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 214 insertions(+)
>  create mode 100644 crypto/bpf_crypto_sig.c

Other than the issue spotted by AI the patches look fine,
but we need Ack from crypto maintainers.

pw-bot: cr
