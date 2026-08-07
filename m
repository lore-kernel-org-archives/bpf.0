Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC8274641
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124065; cv=pass; b=bPMt3FWJ7e/GgISMvMpz2y/DS9KB9Lafcir7K8BgEALwWi1k97jA2M+4UvQfsLdyJngHI4uRYTM6PrlEF1jDQ0M+SDRTaCskDE/jc1zIg++CzctY9XgZsQycc8aQ2cOXRb9sKa0MPfslLR/RLv7k5VJBm0mxKfGrpz5INF1DfJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124065; c=relaxed/simple;
	bh=Xj42kzvtY7hVZXpL84O/HcqpcwKY6/OAxbNIO5KfMOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7v3SM6YgQjqsG8yo5hJjyl75UCqE+eH9MSrQ1WwpgmXkW2sAeTxADy1C51b16Hom4GBF1gm3rmtiP3sw1j7/DwVt1C/+5X+t/rBeCrXUrZXANE+IgJp6H4ILSlmc2hmM/fxZaXMvZYqsOvuYbgBGtOGPQIYab4katRpSgINpJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Try16zb0; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Try16zb0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cecdc24b1cso4471765ad.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 10:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786124063; cv=none;
        d=google.com; s=arc-20260327;
        b=EjhK5tuhNTt0hc6NzYFo0hIId01RTJDxNAjBAkQkOJIs7qWFGlVe8IJMh0KO4LAzfT
         cgiRor8y3gnd8lcAi+tdWpYjc0PFJKbeAitftFIXwEez5rxGXyStVxxGX9KNRi97FRrw
         WY0aEP9exO546vM8g2Nu7MwQmC79U+bPG5BEr4vDWks2Dc1cUUhoIk1BxxIUO2F8+HxJ
         tcdKBud4ogpiwU89+CGBnoy91S22x1DPKderyWaiTcvu7Cg0+t6xoktLqRwyIeYmZTlo
         Q3OK2zfFbGkI6Wwn+fnr3hWfd5cBST8MeddllFUf+nWmWVeuOOUsSU+owk40C54lfgrn
         APww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6kvT16JAmy75WGpIzBN7wM7HnztOWxyNPMwrylGyhI0=;
        fh=iK240bwQiB1gfieYCTMFqnY6uaZAEZ07SxsZ7Lvovvo=;
        b=lHv9TggIexJbGOvSgKszSkOmTYaIvSnGSKE+1x19HT3MPkaMnK5YiVCBN5iMFkJERy
         eVH0p3c3+ej7HBNuKbk2BwuQkOkOg7aiZtmoAdZmQL2yLWrgkVZoqzZpr4IX3Y4e1YTC
         yRLZGriLxP96yi7Ht3AwBPw/VUIAkftGakey1NSCsq/1qCb/VbQHY88IJykLMt7SLacU
         GamPO52EvrjiQvCmUzxeACxqKRMTq0VZqo9pFQxEn3Y9i8fgfjkChenPi8Z95tYy4IGf
         SoRe7ABbJcmmJ3gwvTpwNSfqKMW3jEkbS2pmKfVMrUFdEubIaPmnOPGSMfbGaqoDODZ7
         S2Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786124063; x=1786728863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6kvT16JAmy75WGpIzBN7wM7HnztOWxyNPMwrylGyhI0=;
        b=Try16zb0Y+SEXPUVlMMTVAFb3+FjmEJlwOdQKXRsjpsRu4/0vx0PwfQYg3WVJbqVi2
         Bj1ycxJV0mTuL121CGOQ1E3VJybp8UVqFnfTqQYvNmhsnJNenZFMfd0jkBL2KDDBLsJD
         01qUFoyI5p2Pc5zd2DwKCXTsyNe0YymhJKuBoqb+H9ZRBfx47ARGd+Ru2mtRx9bH2avX
         bbSh9s56rDVCT62yGURt2enRg1g5Df0pcFgcIJaLkSVvblaO4yshlh86PfIAROt2MsQw
         r4HryHQkqc9utLSgfHZVn10OrZEFIMqx6AUaOxqweRL9dlfkosTgyxInIxWImbHvB+fo
         OQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786124063; x=1786728863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6kvT16JAmy75WGpIzBN7wM7HnztOWxyNPMwrylGyhI0=;
        b=qtcNFw0BDs6by1uZVtC24TWUA3J8wcsoEgDAsO8ZSIjjREbaWDufxr1v35G9ouo4PS
         L0Yya2Vp7iVL0ieueHd7Aj6cBCDIe4PDdLRitWuiwJxm2CBkEPnSjVxZtnZAbWaP3Kvk
         /BFXskT3NIl9k8g4TbBtlBOs2rEmBQkGlkowv67utg121RF28Y5v8BoYPGxvbJGxuZXk
         JXFU8HEZdV/HwB8P+blFpYdfRMSpFua5iKibfcI1gYsQtOkZFo6baDFE/JiKabaJi1jf
         2UiH00adin0NWiBfHW6ZtLd7G+xYZFtYMnG2e2bDn8N8mzOJrT9SxSpR92Re/WOV3dbK
         7tBA==
X-Forwarded-Encrypted: i=1; AHgh+RqduKM7h+ZQ7jj1iIbJyv5I06PVK09R4doaYihS5ogA9iX2darBRDwsynBxkzQvzgXHV3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1E8TCkQYHcwbtM3YaqJrbfvyArvqJnAR4ovTbOx9rIQe/J/ug
	eOKhu8WQarCDvyQtR8htY8iJbH3D/Uxm4C1zRzuPRsZOALCb4wAzEXbdFonD/jU5pk+hHpF7tCt
	DHK4tYGzZCk6wy2mVjXmBfH+rGWB86jM=
X-Gm-Gg: AR+sD1346xjin19Yu4l2yDHV5J7CsmLyrnOFSqxmEtog/oQAHVOjqYBgvnAKiwOSVHW
	ve0R4ZgCABxdtVgoyZnw/5jA1yYNujJe7jQntR15kAynsCGqshjNVG59InelMWy+gaoyT9MzXRL
	pbbW98teujaod/ohStdcK+dvbLRClvGRBKoFry47lbr7iohDcq4Jwz6vlLQDwSlxoBv2FqAtRpn
	X/0p94WjErsxDcsUVPc5BMGGsXGq7iTKlu3w4MlSBq8Ym8sr6dl891nnJVQop0y6B4h8kaHIVsw
	J8f/gAqv/Hi1a5x54p8e877hjLoHAwpKf8Ul7dVLSQUu3hAGCZmCJhYW7TYOBCc8e9BbsQyTS4s
	k4G2sVb2WwiSP3azZJiC5eSZhyEa6NYhfZmQxgSHtx+RGcduom7KdntVcZQdt
X-Received: by 2002:a17:903:2c0c:b0:2cc:d6de:d58e with SMTP id
 d9443c01a7336-2d0cab4cf8bmr196602745ad.4.1786124063116; Fri, 07 Aug 2026
 10:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731193102.110693-1-acme@kernel.org> <18b557a8-e1ca-46cf-b03f-5e68490c9229@oracle.com>
 <anXTAComw6XAvnXU@x1>
In-Reply-To: <anXTAComw6XAvnXU@x1>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Aug 2026 19:34:10 +0200
X-Gm-Features: AUfX_mzzvBqFiv6OKNhMJZDHG6Wjkrtx0DJ0DXR2V4K4yDYcAFM1opjoNTiHmlY
Message-ID: <CANiq72nHWY638h4mxJCfh_HFtzhwFEPyo6a-7k_3CxZsRV+Jiw@mail.gmail.com>
Subject: Re: [PATCHES 00/12] pahole: Support more rust tags and references to
 dwz alternate debug files
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	Clark Williams <williams@redhat.com>, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Mark Wieelard <mjw@redhat.com>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Gary Guo <gary@garyguo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:43=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Adding Miguel to the CC list, Miguel we're trying to improve BTF support
> for Rust, this series handles multiple enabling fixes/improvements that
> gets us to the next level, i.e. we can load everything from DWARF, now

Thanks for the Cc! Cc'ing rust-for-linux and Gary.

> its time to try to map it to existing BTF kinds and propose BTF
> extensions when we can't use existing encodings.

Sounds cool :)

> Inferring from "does any member have a niche layout" means
> reverse-engineering rustc's layout algorithm, which is explicitly
> unstable and unspecified. It'd break silently on a compiler bump, with
> no way to tell from the DWARF that you got it wrong.

Yeah, the LLM is correct here: the Rust compiler gives very few
guarantees for the default `repr`, i.e. in common cases it has the
freedom to use whatever layout it wants (i.e. even for essentially
equivalent types in the same compilation unit) -- the official docs
are at:

  https://doc.rust-lang.org/reference/type-layout.html

>     u8                  __discriminant;      /*  0  1 */

For the niche cases like `Option<NonZero<u32>>`, what would be printed?

Cheers,
Miguel
