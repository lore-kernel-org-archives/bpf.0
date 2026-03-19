Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06D2356BE
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910905; cv=pass; b=j8PLE+ppAF/C9aQEXcZ5ZKFo/HcCza3jO0jqVoPJusBl1saKfCXPkU/jul/NfLXZBD+jVzJfRH8Lk0Iezb+qzFVe51XdvKYihR7U+dIPeJkHhLl4/MxiJPPksv4i9X2S86GqT5qCBAaT9UPNWUu2TUQiTNlmGI12joXkyIb+ZBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910905; c=relaxed/simple;
	bh=y4XzTkHyZwwKq7Lc4dfD2MgvHa8YwVeUUN4EYX7J9aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duoXgrc+WyYvzZtLNNLgiHh8z0gnmZzxb2T2Q2Js1LgL+ZJgMikeYQ4Mg7DbFRyT2DPIHyjnIBplhk1bTSayNKbqBUlpW1C2oV+MYnnRblmVu2aJpOFscR7spHzkoTQL+bBxGrgKXsSvfgvXa4u9RYXYlm7LUo8ExyzfPB3arGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+n1SmQB; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+n1SmQB"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66174cf4549so1275826a12.0
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 02:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773910903; cv=none;
        d=google.com; s=arc-20240605;
        b=ZdQ62d3ZUuPxqqwrEfH1Cq4YBroV7YX9pogCAHUBu7M7yOm7rJ+pYnalxEo1RM7F4r
         ovRLDMt7ghKLR21yhiFrql/HrP37iksvOEXkryk2cjzjlBOftDv7HN75JGxO4rmRVxbL
         9YZiYuRT4DK+dSB5Gq7Y5fsYn18WCMPw2HSpupuIpwgMkn6S7lIW8AypteNj8qNzEaaX
         /iR1v2liI6TLyfPTkRqL+TElTX1Cg7KBvq7BGkG0j7ZuuEG1C7hmWZne/egGHcG/NPNy
         JJXBoBNurzeUrazyLil24MmOz0B5oDOhkvAmpGVwmwWBiadP7CwO1MqqPzlO5uI7xf8z
         Wssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aHp8QIilO6dMcb8Fbui8Z54MxNDCB8m/GYOx+Vb5b94=;
        fh=jceCy6P6m1yZ9uGLZftEQG+7T7lmmhCoVdcKqlvADKg=;
        b=N+WeJefJpeo7jL7PQrUYQWRezd2vQDHQbQq+q0KFVXIB0UB5Rh/hqIdkbjwAkZdwWT
         QhCSQOg0711K40QvYOerP0oepU/rm6WVTcEHfh4BVClJ6XogYW5a1HtyQM2fmlpV01KF
         mcH35s7ptHx3abXAfssBJ/w1p4GVNMO6eJx0Dh1gFo973j0juB+MOX6scT6lilgkKVJz
         w6nGNxuFS4s7/G4Lr+CmSmRL3ZlfQdfeIN+0Cf2edKIbl8PkDxh4PQtylORUWthD/GL3
         ZPZpfcMtpVNivzFDdxhEnAi9xUXTr5rKCHOuWFNXHtwHLLC8MXe6pxwz/TytaB+0JyG+
         lKcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773910903; x=1774515703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aHp8QIilO6dMcb8Fbui8Z54MxNDCB8m/GYOx+Vb5b94=;
        b=e+n1SmQBPFgPH2s73GjcObpK7BZF0dkEQcBKNAStms8hFEHbxZs6Q09RM9nfA4KMeG
         5sIdJYEhgEHxWDw6DCnjuQBC4VHG8cnlFcUvmTWmC7GZp4bEoarKD0EkuogsAsPr6VB7
         GN6akheBsWS8MM+ebTzdZkTF4uZJEaLsTUwvbrScGEfFxaJ7NgzkdpER1ARDAY4ZwfZD
         4nWkk8ldQBc6e/deG2rfp8xIXUbKb2qdUEHA9LXNqfhuj0/3AmSUzws8NaiQD901rB2a
         UvZCOQrA/Ge90Au2ov69Y+9GzKooPOAg+1Q48s02Yhra08PKtG4cYYEFyepGX42bGHaf
         vyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773910903; x=1774515703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHp8QIilO6dMcb8Fbui8Z54MxNDCB8m/GYOx+Vb5b94=;
        b=j3dSvgM/OlnWFaeTVVwMw7EmFHJDsbtWl/iBzAAhOESRVmaGyx2EhGcVpXYBk45enm
         Ns/lwSSqa199LHf3JBgm1YLeYEzvLqx/nmEMv0d2Gj8wajq1LYO55vynZVi+SOCx4f/T
         /JwAQXLE96ZOnkZTulEgGR3u03ix3jra5sH/xJTpx2LF+ePAjbIvWvdtZoCXeDnDKxrd
         UuTFVgPbTxcFSAUPr+RooG1j71TrIQevPUVB+Y4uH2gcyVT81XUBtwmVU+VxQx1e8bc3
         PO/WQTcKMRxFrS6Vt/gDS3QZrCxr+AwlB+3yaT4Xo0CJlTBDFj73lyAzpBMMqzsY7OTm
         oR1g==
X-Forwarded-Encrypted: i=1; AJvYcCXRZ6silUwm7weL8YTBsSWH+kbUAhuyo9hwGtQLAw7UUMPeBuyjJjRENlsa8JLQcREU/oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywP62xh9xaotAkIcQgvEGfJvq1D0+6o0u2AGxuvtxWSIGOBLoV
	ceDGU2kZNekbufov43+aB7O9gvisuVSelGLTkeAr3n5Ol3ki+wEfkASUEMhFMZNQKr+I11nzJXO
	EAoDFzJS17PqhkxgP/0p92GkD+CvFjQ==
X-Gm-Gg: ATEYQzzKzIFWZufOu0OEadSWbKRc11dYmjaWXdCaph1RzMJlEIWDZgHDzHeqQ2p8T6o
	Y6XKd3EYkZ0jkxK8N20wVdn6T0a7Ipu168/NFARxpSHnLov4+Uq5hbW5Y/STJ41ftAMqwZp9OhD
	NpyTV6nRwniimUVErIayDC1bBDyYeumq/fwtz0p25YuY9pt3onm/d7D8oydfTAwD20RlALPBXVW
	T8szQQ0HVkqlNiNWJ4p8DHqw4svXEn7oYF92VWqR43tN3yvBIK0XT23DQKmbmDS2Omzh9C1iiiT
	CNLSl5n5wvbrX/WJkDgAzR/2mg==
X-Received: by 2002:a05:6402:911:b0:65f:a47f:6e9c with SMTP id
 4fb4d7f45d1cf-66850ba83c1mr1589316a12.3.1773910902425; Thu, 19 Mar 2026
 02:01:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318171906.53174-1-hao.sun@inf.ethz.ch> <atwy3evusj7cjafp3fnrzgimj3dimcyuxasohegjc2enplb3cb@4l7i5hoe2ify>
In-Reply-To: <atwy3evusj7cjafp3fnrzgimj3dimcyuxasohegjc2enplb3cb@4l7i5hoe2ify>
From: Hao Sun <sunhao.th@gmail.com>
Date: Thu, 19 Mar 2026 10:01:31 +0100
X-Gm-Features: AaiRm50sUZ3nPlehxdSztd6N8B4R00eav7AAKbRMfviwDRmtIfQzGm7qaGS2w2w
Message-ID: <CACkBjsbcv4woDZZ0_BA4idBwfLPXNTX7BzJMXTH54zq_8F0BuA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Simplify tnum_step()
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	john.fastabend@gmail.com, martin.lau@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]
> > -             res = w;
> > -     }
> > -     return res;
> > +     d = z - t.value;
>
> A bit of comment explaining would be nice.
>

The commit message is self-contained; anyone interested can git blame.
But I am unsure. If a detailed description is preferred, I can add a
comment to v2.

> > +     carry_mask = (1ULL << fls64(d & ~t.mask)) - 1;
> > +     inc = ((d | carry_mask | ~t.mask) + 1) & t.mask;
>
> Maybe break out the calculation of inc, give it a name (next_submask?),

Maybe we can break this down as:

d = z - t.value;
carry_mask = (1ULL << fls64(d & ~t.mask)) - 1;
filled = d | carry_mask | ~t.mask;
inc = (filled + 1) & t.mask;

`next_submask` is not precise, as we ored `~t.mask` into it.
It's always hard to name the intermediate result :)

> and have it as preceding patch? It seems generic enough that I thought
> would have been implemented already, but bitmap_scatter() was the
> closest I could find.
>
> Perhaps could be submitted to include/linux/bitops.h in the future.
>

The calculation above is direct, adding a bitmap helper intros an indirection.
For me, it means I would have to check out the meaning of the helper
and then get back to understanding the algorithm.
