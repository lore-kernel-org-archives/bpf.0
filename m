Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D958395ACC
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787612055; cv=pass; b=qf1gNsTHCYCBWjUgaaMepeWDps/dpwLTgYY6VeqxJJPUvpygE/OP74ItPogejyU1z0wpRpaLxklv9+XKlqGBWoiC0HyWOAm8XxLu2UM9WiAVmS2dODsJ1ZG9O1FKzvZE6q4v6kIL88xEfbZiWSEHKeZ2hcsgsjNgxDsVaMXy2eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787612055; c=relaxed/simple;
	bh=+xUTBWWUiVy00ozpJeB7LFUbe7I8yxK6IklfDpccSL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxlDYSv0ju7IBQMRetpiNEMj3O31o910OPFyDmEoJVPWR9Tp88R5bipn9KlR/RDC80NDtshMiZpWh3s39gmpbYAstSwdQ+OVQsfL9E8GALLMZ7NGgTctWLgZnaDTE+3LY5767iJLK04Iu067KeX6iB1/KwP67mThjFryjEwCsoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qN6oLX//; arc=pass smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qN6oLX//"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473913157edso1031551f8f.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787612052; cv=none;
        d=google.com; s=arc-20260327;
        b=Y/4B4STYstTiDCH+FvIKIM38kH15cgznT1nZ/fWl1AlAAaO8XX1jKiWtU40MVJ/hD3
         1cqHmrp4fE40y7MVUYkp8J+EE7uJX/+GheZOqoxYm02R7tAK+mKKLW8i+L8VX3T+KDqd
         RIJTum5E5wzmA4oOI1gnsvn8yK0uWPNyDvPaHQCR8py3SoE18CXBwfLDCIZ1s6yCCciq
         e8b9DWeedoDhAkx5iJLDYA4iCEtvPbATEPLb+eFPRvAFrK6kFStL7+FUTXn8xNc1Mwqz
         3uBFz+/DGPDa8ZmBdPSK9KN24f6q03NVjd/dqUdNCRBDmHiwRwujKRbLc1Fboiyby+GR
         bmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5zlMv2e6DM7PZ+P5lffrEKvGMK71rMFWp0f3bprp35o=;
        fh=j32kraQBvGnT7sBi2cI2niS49axgMloD3RaZATMi/as=;
        b=TCM8GvW02b+pHwh/7+Q6fnZA59IO87iJ0qAPNIY38ywhrB+YoxhTTTlyjvacbdQ75t
         JbdQoEwZc8IA9gLnhOG3M+pmxX24rHnknheMdZ0g2DPNP0exjnYnOkA3qsVN4y3F8Xiw
         DY8fLT2VizPYWIDYISs3Pt7+uhwiZBcTz2lBCov+nfQ09aGgJnEdiuwPrL+2M55XnLq9
         CkmXISwWY8tIQHN64GgS9rn9dp9DkpxNCKE01HS3SgS0squcEehWPFAstdZgvZI3aMnM
         Vb/OVD8qXL4YhQday2xgTG7DlmnCEuIR8ZPehb51l5LzTgyLqLNlpPz/r1Xe9a0QHZHj
         5zQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787612052; x=1788216852; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5zlMv2e6DM7PZ+P5lffrEKvGMK71rMFWp0f3bprp35o=;
        b=qN6oLX//DBtrXRwSO8VnorK5ORng4knxjbjmPY5jyboV/PKYB6zoUhDhZlUmol3K36
         3Mh6406+kFtj0+mgo7adpa6LKk/r/HRWlc2bpqwM0xOJsYIHsZpLi5h0en6xiDJTwBFb
         PkR8+r2XT49Vjtc+JQRt4m2pBaKdwNqIQjGfv2ErUwQ2sbF+5mXDI5Oneap9AyvTxUct
         WEjRXJSU9SEMlZvW3xUGqgvkpO/fniQDqzo2w3RHi5Y+3Ri339X7U24xY/cdYC8hsCcn
         qW11Swh2bw6ztf9i8eUgLjFJg+fymJOuj6BtmexHiXKqGNbMhXG/M/HdTwJ7KbgX7Zbq
         gRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787612052; x=1788216852;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5zlMv2e6DM7PZ+P5lffrEKvGMK71rMFWp0f3bprp35o=;
        b=lBhIeNmXd8MdvJqHwpzgQbtIisY8blF6890nusQwZqyV9Ls4C5YPLc+YeSWoEQoNXP
         b+LQHx0qsIUGbca479kbwyWA0KPwS9RwbYxeuOTeT1P0/2C8PHJIXR7iFnXaXaWkOKYA
         JiaJmHiILNXyMrQQ2Yuv2OhOQK6brlBgVg6zbTps89gIAGJoXNj+D6lS6RrzUQRQpkg3
         92BXMkPmFLOrieg1+2gpeC8Vtg8PVADAKHJIK7jv5oFxEk+Df5k+gz1Ji85t4s9bTo22
         y9RDDNYRyu1LbWgjylkhPNmhbXhA5rKz9C/8ew2bDYfkXIIiPQrY87UFDw78SkAwkeC+
         EhRQ==
X-Gm-Message-State: AFuF++mRTzeSmrV4zTCDxN6M03ZQgVGU5KrTdrduxd+GsSAZxytcSoLM
	oLdFJgxvEr0UftGJ7CKywlOf+fOpGurtAYrkCW+jJM362+MOjUPRYWxNh37XP2WxOfhdT2iw5fD
	7n01AjlK08eYlv7OVNV5HAgIehadOgnU=
X-Gm-Gg: AR+sD13FpiMxqgKCjSphHyz5lg47RSfdJdW1sejUENEIwfXjYWAUSI0XaSGh+2L3mMZ
	YDZnFnvLOzxU35ocFk7BpXUqzDKf6+OEiiXnKZRCRAe6VJSl2H5b5AOOmxm4oXcM5ZLaqemLJH7
	2hV4HnuigmAIHIYLZ347dM9agW6sJ/TkbwNi8735dtF/02y90GuBO1krxA+FdbycKxN1JznI7/X
	VuxNWiCsQOHbdlm33RBKFgwd+AiluYPiwt9dTntfpCeHQk/1DnOL7gZFUT1r3AmqSwzjIYxpnVC
	2IIBhPk4WGW4OiXXJdCGcqYlbHkUX4L/Xzd0FlQkMU9js4uWAMEmDCw2acQNBGs4QWHpLDeoIJG
	XwT391e3V+mi/CzGiJ63VjwkOWbMHQjOdITR1uy7X4FY5GFoRzys/Rh5GJrjfiKLvCWs6TVyZoi
	Ew1GNz7B2sp9dV8FmtMkrqc79yZWBuGJc=
X-Received: by 2002:a05:600c:840f:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-499c19f5111mr248602325e9.13.1787612051687; Mon, 24 Aug 2026
 15:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821233516.3426127-1-memxor@gmail.com> <20260821233516.3426127-13-memxor@gmail.com>
 <aa7fd53b3521c5f402700c5df7056a23962e4ac0.camel@gmail.com>
In-Reply-To: <aa7fd53b3521c5f402700c5df7056a23962e4ac0.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 25 Aug 2026 00:53:34 +0200
X-Gm-Features: AcwNN1VMV2UUrCrfGfPmWbUcf3nA-p6_YO_pEiSXPrdytbURkLWBdx5Alkrw8rE
Message-ID: <CAP01T744sZA8w8aLx7raT4h-aWcjsAidUAT2edsui7u1XXWSwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 12/14] resolve_btfids: Drop KF_ARENA_ARG flag support
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Aug 2026 at 00:25, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Sat, 2026-08-22 at 01:35 +0200, Kumar Kartikeya Dwivedi wrote:
>
> ...
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> > index 3f9949e8227d..a4381c7fa7da 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
>
> ...
>
> > @@ -57,9 +50,8 @@ struct kfunc_symbol {
> >  static struct kfunc_symbol kfunc_symbols[] = {
> >       { "kfunc_a", -1, 0, 0, false },
> >       { "kfunc_b", -1, KF_FASTCALL, 0, false },
> > -     { "kfunc_c", -1, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2,
> > -       ARENA_ARG(0) | ARENA_ARG(1), true },
> > -     { "kfunc_d", -1, KF_ARENA_ARG2, ARENA_ARG(1), false },
> > +     { "kfunc_c", -1, KF_ARENA_RET, 0, true },
> > +     { "kfunc_d", -1, 0, 0, false },
>
> This changes test cases for kfunc_{c,d}, which previously were
> expected to have arena args. Why?

They got it because they were tagged with KF_ARENA_ARG{1,2}. They
don't have suffix otherwise, so they don't get it now.
I can add the suffixes though in v2.

>
> >       { "kfunc_e", -1, 0, ARENA_ARG(0) | ARENA_ARG(1) | ARENA_ARG(2) |
> >         ARENA_ARG(3) | ARENA_ARG(4), false },
> >       { "kfunc_f", -1, 0, ARENA_ARG(1), false },
>
> ...
