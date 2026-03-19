Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFBA3CCA19
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773925990; cv=pass; b=cEDlqiua80anr9d2VMHCX5thn5+kXHNf0u6WM93r6mZ+pFGusc7hQlpUzIGi13YbZV4RBUAmIZQoomy3kkdsG9f5H2W0pzCl+OkK5R9YW69+80bYTQ2vx37CgzGHee3UqXoXPswEX+Z7T+I3tO0nE93+2FBvfXAa81OcFCsyT9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773925990; c=relaxed/simple;
	bh=KSwrrlbSCc3vBNCfUUU4wIh6+oeD4vylWNPrVV4BjNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjnxbsz/6WQRBbdFoEiTFGtp/NTaIa/a5szv/QA5bkloo2wYEeMFn56YG3EcGmzGmGqMQhIHk2qS7SJEhUFfjUrb1pECz/1ez97sYQFeMroGoecUaQgPlE0iq6zkYzo+G9lDMLnwg5GBWxSZpOM0Ps699gmbjDHMyDP8hdyrNxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZMWM5Fx; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZMWM5Fx"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b97d5b790cbso105489466b.0
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 06:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773925987; cv=none;
        d=google.com; s=arc-20240605;
        b=P+y4cKEiP2hvOwyltrGYXoY8neB7DqtiohKz/l8AFRaeHxfyERHZkXYQ7lolkJrUs8
         YsJGEbMZn6fFI569tRVXSdiVWzpzIq61K6kt2eS6IxhfMT9KJoCqtDIneQlls4wKvHVm
         XbEhUE0svVl9VzQEVP3zUUV7G5k1C8FxBwD7VaNWdbnIwforKKdOpW8xVGE82I/uv6Yf
         NVkREW7FbxPMGtylaT+4p7xT9wpXQbhEzCn31HzyKas8EIrv9sAi9ZRX85JIjmNsMLVv
         CzTsR0D6ZtcENhB+Rc3N4hwwy+c/b6a7Q/IIW7mGCcPXyDENBunI0Mjmuan5ncMNrCp7
         c9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JNPtCCQ4aaYYGicK4HCq7Xnks7DOM5LxwGdCWeAtZh8=;
        fh=VxGtFywnrGVzo4z2F3k9IJbwbUIsA8G4zSNUfTjG8mc=;
        b=kyL/31bC6HEiMn/40IoB8AZOdnEo+JlGz1u9wGZ6O41754jC/xeOj4iiVDk/Sfo1LH
         TYd+KwUAtdylgo9Wo2v+/Cqr7aCOUqMAJDCU9rwQ4flY/GFi/BksqLg9usijRqlU5tse
         5fTP4EvvWmHSHoskurmLrm9W64oEnVXNd/GZxWD6mbWVrKahoI0HUUcfjQtB7hxWTI7U
         Mjr28N9oqSds62Gia7eQ9tYBw+4eAAVxtvM4Dg1WjZi9R1TsbGojZ9nw8XK4ba9WbeVe
         pHO5pr+kmEyOur3cytonAS4PqY5wn9xs4+NB3Bym6kC022t89wEBBHH0DZw0IhSOQn3+
         DPmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773925987; x=1774530787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNPtCCQ4aaYYGicK4HCq7Xnks7DOM5LxwGdCWeAtZh8=;
        b=RZMWM5FxjefHoowu7p4XoaC/kluagqF0bsEYyUAlzeowmb7qNdEpaG99B4XGRTYgWx
         a3TAuomn0JKGNzK6eaddHUHA7pMNEvp1D8Jq4r48EPNJpnXvVIA0yefE/PUa3zcJdAki
         8mK1lxpQDLnPPPToeZjRYLljC3FMrm3C3UYLIv85dcVKgL+6d5SUx/3SaCn9DcrDXxgL
         Id4h8G30Nu+0/L490gSkGoG60zl2yNEUf5fN3W0iHi+lxU95Qq8jcsHD8CK9thW/bNgb
         oY40TKpxhnEZnIQA1UShU42kNpBIrgvHsUUXqHwCtF6IX+SuNAko8LfYNaKFkLyqYOdD
         amWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773925987; x=1774530787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JNPtCCQ4aaYYGicK4HCq7Xnks7DOM5LxwGdCWeAtZh8=;
        b=HLDUBY1aPAuQ62pN546KYTSqUCRwWr6WPjqiT5x2oCw8pl18jHsS58IGqJ+7unQrro
         3lGlbBT4vPlnazD9OV2Xl/fMgUTvL9yl8/u0OQsCLeicgDNKj0io6dfAcUMbwofuc+Bn
         ve2pQQAUlL8vDroVp46j0/Ycc5qsAyBsmVX4ERnV9JwGTUQwVPuBevBZSmViOMvYT7rQ
         cQH1KkICEP8KoMbWxYT7ltVyCbiEABZ/zTKeLFRQRdrbYaEn/mhz6cxc4baHTswRwKBw
         p4+oekfI3+BnoXJw3eEw28XFSGEnFI7SctumcxcgVdw+H93Xj3K32+d/mkFDiRSdNs5h
         iLfA==
X-Forwarded-Encrypted: i=1; AJvYcCULLwYRqgqYjGwP45OrrIoaT6k81oRdBboHlnENxl/OjIdEAZlxDAe2WfazS4i0WQulzJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQf/dffhIBirbYS3B5pRVW4zfcszS0jk6t5CDO7jg38DdUkTZB
	zlwH4jxO/j03eYH5kdRgGCTOvjpbCV/TXutxeSZzALWdPI4TQMo9cxe69Jn+AMZzXAiG9xhQVa5
	VYZBtv16oc97laO2w++1fbbJBRmQWfw==
X-Gm-Gg: ATEYQzzIyRRIKlI0qaPrAN1CzPt+8P9sJNG/Ff/zDEJKq/K+kMpGWj+t+Wa+WU24seM
	Aw0/xN03M80hZVy1auo3Evm3x3WPx4H9CNeflh6CVHrpk2deFQiZB4NVFT5vZNKcv/6zlcoUr+/
	VsToJeA6x3s3yz8zwd7PLARy4HKVMwtOEodF9HKTVpU+BcL4XK2ogDcpHJBLb/cmekzMbnACEq2
	0xFaNyFAtJpfXFiyvR5ATNhtgLNf3vbtLmjJlt637znD9hHlqoQAzNRwR2yWYALebB0RqHf4sHe
	xidygwMHBGGk4uuclCCb2lpn1A==
X-Received: by 2002:a17:907:c02:b0:b96:edcd:cd04 with SMTP id
 a640c23a62f3a-b97f4b16f67mr440043866b.49.1773925986823; Thu, 19 Mar 2026
 06:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318171906.53174-1-hao.sun@inf.ethz.ch> <atwy3evusj7cjafp3fnrzgimj3dimcyuxasohegjc2enplb3cb@4l7i5hoe2ify>
 <CACkBjsbcv4woDZZ0_BA4idBwfLPXNTX7BzJMXTH54zq_8F0BuA@mail.gmail.com> <abvDSjl633b_Hb1O@mail.gmail.com>
In-Reply-To: <abvDSjl633b_Hb1O@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Thu, 19 Mar 2026 14:12:54 +0100
X-Gm-Features: AaiRm52KxxUpa2prxfBFArVN5tvWg21UeJAD-yx8r0tO1jmFptcgKNiy-_Ya4mU
Message-ID: <CACkBjsZBiQdA-yKCAt0Ng_PRyQBkXFK5ymN0RXx2xG+uJ6P7PQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Simplify tnum_step()
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	john.fastabend@gmail.com, martin.lau@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 10:35=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail=
.com> wrote:
>
> On Thu, Mar 19, 2026 at 10:01:31AM +0100, Hao Sun wrote:
>
> Thanks for the cc Shung-Hsi. We were discussing it with Hari who's
> planning to double check soundness.

Great, let me know the result when the verification is done; I will then
send the v2.

>
> > [...]
> > > > -             res =3D w;
> > > > -     }
> > > > -     return res;
> > > > +     d =3D z - t.value;
> > >
> > > A bit of comment explaining would be nice.
> > >
> >
> > The commit message is self-contained; anyone interested can git blame.
> > But I am unsure. If a detailed description is preferred, I can add a
> > comment to v2.
>
> Not disagreeing about the role of git blame, but it's not a replacement
> for code comments either. Having just the intuition in comments can help
> a lot; as you mention below, it's one less indirection ;)
>
> In its current form, I find the proof harder to follow than the
> previous, very verbose version. Maybe there's a good middle ground?
>

By `proof`, you are referring to the description/commit message,  not
the Lean4 proof, right? I was a bit confused here.

[...]
