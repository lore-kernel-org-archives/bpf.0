Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F83BB5A
	for <bpf@vger.kernel.org>; Sun, 25 Jan 2026 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769300371; cv=pass; b=ja+irQLtsQ1Mvul+M9OA8LKqbmp4Vlg+2dTZrBdryWZSh8o7HXRjbk83FWz/yHL6pKENhHvEoHbmn5m2N2zCbwVUiyRueEzO1lhdjdc21+gyQvuU6HFRMDGXaaIhaPUX3oa8vhiVKiElKjELA6setNndruePuE0JFifG+NLzRyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769300371; c=relaxed/simple;
	bh=If3fkU4YA4+MSsxYXa/lyK9BrLCbxbAeIY/q+H3wkxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FP1RVz+Bds+BH6MyAHkKfic+zQg/Du2h5qki0la4k+JPCgLJNoQsvkTLKoI6iRwHpz5yP8yjkgXLrntgwY0qp44CLLmYlbfqLi+yDJCszcBy/6LytwBFjTeFQimVPEXvBFsyfzYvSIMZqt7ZMYOZAy94ocJB/R5FeUdo1XkHgVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEriKacV; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEriKacV"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so35493255e9.2
        for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 16:19:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769300368; cv=none;
        d=google.com; s=arc-20240605;
        b=ALQH0xpp21nAj91APFbnaaxtHQTUb6+SRmdzujIgA7wdWhfeZsg2zfweXUQ5GUTGSV
         Kf5dLsgc/hmPPZ67uWH2XhQoNOf0L423ex5fffTQ0UTepXAv+50mrU3Jby8R5aCAxX0x
         1/ogLLEhhV/kkmj9eNKSX1waep0bOr/BtQazbeOPhsPFbHFa5CS/wHSmqLeuKBZoKyrZ
         z3to04so3aGdK8vgOt9rf7leX694XX5GHl1xEPWb1Sdk1WaL0N3rmPOTeKY00KOQ25iY
         SJxJ+ffi1Hy5fA4qq39XUH8hV2oXq121YgP5lIRPi5Zv+A51EAfe3xbnHBh4U7Gfawpg
         Przg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/cWk0M9f08GlkKjx4FmxOL3406KPYNW++Cx0SwVE/qw=;
        fh=kNUGkxli1KZwZV8mJkLZPh7Silb/6tfe7KiAnRaxH3w=;
        b=lPmhOPLoAUTL56IbUn1nCwHell8tyoiUVvZ6HWLSooUAwiJ0cNmx6BxWAhgWBee4LX
         wey7sKz317EIdzGPfSNBSydo1Y+Cuk2ClgsrwX6nYWkx1mdnJn+2YSYQ9xp9ehTIJSrv
         Y1kOA0E++q1tSJzENXuF8d4BjyJjrTFXw7ThxiDQc9H0jf5/ncAJzuxOQdKeuwqMvV7H
         hAH32oQU7tpWFBGDg2IM/SXJb1e34A61jpZ3L+44KG8qKEUazZmUB3tPUhCPIQWguykU
         L8n2lbHnF56PiIyfLIC45bt6LE5dUipCawnBOz/28RJei3FGTLVR1gQ+bbWdb36J+R1m
         m9+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769300368; x=1769905168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cWk0M9f08GlkKjx4FmxOL3406KPYNW++Cx0SwVE/qw=;
        b=jEriKacVJTI7Qv7KgOLtEBJcAv05zn6E8yhcP06r846B/37d9fi9XF+7GpFJAdqeDU
         x2pPwcLiUfuhZ2b/ZckwA2m0zZuDzHCYmnEBe4XOZBsXusJzvC776paS9NFkIrBQ93Cw
         iKJM9g9mPUhyRU+FOPofXJ5X21wyGF8orbBfiUZI19mGVga+jsKEaQKuToF+ys1orwyW
         0v3UXk4jbnYyxVJI5dF3JNxWER06OCjYjQpPIxwUod5yDPTn6Yr4WNRtjsqqpQFQxdxl
         AbKRfS+8tDAMsVMhlb04UdjXhhFMP8jUQvNGoaLQsa5ERAQ7VnmmtBriVlQ+nJ3mwEYw
         aUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769300368; x=1769905168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/cWk0M9f08GlkKjx4FmxOL3406KPYNW++Cx0SwVE/qw=;
        b=oAEe1ZnKR+hIWlcUK1+9ZmkTDMdbK6mCQeobp3W7AB5VUcVfza/Ghi1UYCYqjN9ZEg
         N7dO8kajfRvTPm40jzGq5LRfjXHE6eEhzd/Fmk8Kg52G9vY6KzUAtHiLm9zKGnz3ZvB2
         1cgaLlIIicZtTrmPUvARbfuEcTS6Mj6eb35dw/b2S/3zu851aM3oBV5SGzCk5g00ekrr
         eHpm3G5xCv0RhHlT+XrI0ZTZVsB4BVeFr3VjPZgyZ+j8ZHSN3+Hns5D2cVMc2LgvhH3t
         f9dKGU/ZufcA4k3oZJwXhRGe1TzMroLdW8txUtq4FtbyF9ia+JU319R1W2RlGJJTqHXX
         ZHVw==
X-Gm-Message-State: AOJu0Ywr6QkYYkGe+rctXOFCJKiewAS2NrLqbHOmbq7OIK//AZ+ggPvW
	krNMm9zFrTF7jmk+S+n2WJwcw7GF9U9/hr8j7urQQ7ZkWMIdoOn9Z799tx7E8A6z2qXCnpe/BDw
	bVZ63vZYxKWrTe9pPsZjIlPc4ibfjVLw=
X-Gm-Gg: AZuq6aJ6cJNgfLoLiHharybb25/HPCROF4QDen0KtbWcnS7ARjUsxLOnlKKsL4zjdpl
	28ydV78rB/4Cxht3hkscR58fxIeBAqttIYVtE53AypJd3fkd16Dk2/hg3LYNyaEAdREOfhtFEWS
	Dm0aUq6NEvytBHrIz47SgJq2SShAokvoBTEObJwQYOZiJnPZFU+LZEdN6GK21ktFHSbo32g7Ftw
	6zgoNeFHOdKB02funtb81VrS5WilQuvhIA4Yf6CEqMIV31i/yb5TJJxaWN7aG2+IcfrOBNgYf7u
	lCQYLB/mCSA2IzOw9JG7kq4mXOXChmJT+bgg6d++4JtI7QYrdRKllIE1xRynTTw2Tt5/a1RC7Zt
	xT2g1SyVkHJl0Ww==
X-Received: by 2002:a05:600c:1e0f:b0:47e:e807:a042 with SMTP id
 5b1f17b1804b1-4805ce50189mr4505125e9.15.1769300368107; Sat, 24 Jan 2026
 16:19:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124174349.16861-1-git@danielhodges.dev> <20260124174349.16861-5-git@danielhodges.dev>
In-Reply-To: <20260124174349.16861-5-git@danielhodges.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 24 Jan 2026 16:19:17 -0800
X-Gm-Features: AZwV_QjrseQV1Yh7RsryydskQrmIxIwJ1Lh1IXL8EzEcg7C91ASKKQZu5jxevv0
Message-ID: <CAADnVQJQsC0cQZPJpyofY4Othi5+j7xjAY+xbNRkX0p9wA7Khg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Add tests for signature
 verification kfuncs
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

On Sat, Jan 24, 2026 at 9:44=E2=80=AFAM Daniel Hodges <git@danielhodges.dev=
> wrote:
>
> Add tests for the signature verification kfuncs:
>
> 1. test_ecdsa_verify_valid_signature: Verifies that a valid ECDSA
>    signature over a known message hash is correctly verified using
>    the P-256 curve with a test vector.
>
> 2. test_ecdsa_verify_invalid_signature: Verifies that an invalid
>    signature (with modified r component) is correctly rejected.
>
> 3. test_ecdsa_size_queries: Tests the bpf_sig_keysize(),
>    bpf_sig_digestsize(), and bpf_sig_maxsize() kfuncs to ensure
>    they return valid positive values for a P-256 ECDSA context.
>
> 4. test_ecdsa_on_hash_ctx: Tests that calling bpf_sig_verify on
>    a hash context fails with -EINVAL due to type mismatch.
>
> 5. test_ecdsa_keysize_on_hash_ctx: Tests that calling bpf_sig_keysize
>    on a hash context fails with -EINVAL due to type mismatch.
>
> 6. test_ecdsa_zero_len_msg: Tests that zero-length message is rejected.
>
> 7. test_ecdsa_zero_len_sig: Tests that zero-length signature is rejected.
>
> The test uses the p1363(ecdsa-nist-p256) algorithm with a known
> NIST P-256 test vector for reliable and reproducible testing.
>
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>  MAINTAINERS                                   |   2 +
>  .../selftests/bpf/prog_tests/sig_verify.c     | 163 ++++++++++
>  .../selftests/bpf/progs/crypto_common.h       |   6 +
>  .../testing/selftests/bpf/progs/sig_verify.c  | 286 ++++++++++++++++++
>  4 files changed, 457 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/sig_verify.c
>  create mode 100644 tools/testing/selftests/bpf/progs/sig_verify.c

It's a v6 already, but your new selftests are still failing in CI.

Error: #385 sig_verify
Error: #385/1 sig_verify/verify_valid_signature
Error: #385/3 sig_verify/size_queries
Error: #385/6 sig_verify/zero_len_msg
Error: #385/7 sig_verify/zero_len_sig

Please make sure CI is green before submitting v7.
No one is reviewing the patches when they don't pass their own tests.

pw-bot: cr
