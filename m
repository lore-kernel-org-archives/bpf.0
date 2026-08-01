Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7133D50F
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785617315; cv=pass; b=hDuf0P6NKiQCIgJV5hpb+qGrefTDAdnPD77cVvMP/pWvqW1dNSu5EIXmrCRv0/Q7Iv/OLGStDGKZFcdWIupqcckuK4HE5hpZ/r/BTgCeVX7WQyN5FWNnFTvo2vCnJJXthoG+TP8ajtstnBDcT3gtUAeE0sOdgLsGqcBHowLh3pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785617315; c=relaxed/simple;
	bh=mBnkT6ThApqljIooYhlHy2KrG4XpgC9Us1AFdPaobNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFRF4xjNJ3CgwEnMwh8SiyQLBPi9q/ryY4hhcYkTqFzIrHmzGUpceSl0JziES/JW5goD4ETFwKPbsE41G4Rcp7adRminZQPI4sVcXVD4UwCi1gV5PoEY/pXvv/2iDQVdiSoBghgAppaYu+8qXw7BzIJbuq9hrE1pxYw0FLiMZn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B51Qao1Y; arc=pass smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B51Qao1Y"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so3736905e9.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 13:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785617312; cv=none;
        d=google.com; s=arc-20260327;
        b=Jfzp7WtpUQKXpMgVihOM2O5XmIH1aDa8Sf6heQHXse965l/a5nYZf6h/gXuHZqMVC+
         cS9N2XPXzwVqXWVB+bUJJyc3+vSDyPofUfvgbSr6o22wFWsYUHvp+vlWpO9zE3toXBb6
         F+Tx5HFseP3DCdAQgbDxrElc80MilSro1q2LgSBi9ePaKb0Yg858JmEFO865UD89+Nlq
         guyiZXS3zlh4N2PUmVNs+Rd760lk7NlfyQYke0wkWpr8ErmNH0HvVkj8dAqFCVSTOkN1
         9073brgEEbiaMtIiK1od7RH2i+NU/FWMOW9g3FSiOVF60Iw2nE5//r9e88CeNtqEUquJ
         Pwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8C6J3xKw6R8FPOPnn4w954ZGYhiuE4HGYU/iy6pgEu8=;
        fh=Sc2rY1M2ieGnZMN9hfbXyLvCES/c4zp8Gh8A6xegGMk=;
        b=EuWfSj3m+DhO0cV1F0nElw8GdUmLySFoxNDCIWW8kkK/JVd+EpDLQfiIoVUQU3oSmW
         XHkdBrAfpGIyrhSWa7yKYJGdWLD3yIumHEJ7lYcva5m0lkm/QTdG3isOBwiO7Hm3o4AK
         rQn4OnGWHbyk4bsMy/BwBh3yFfufg/o4eYBtmLxzUhK8kpAyM1NA1L1dXpKIL6yJxjKl
         BTZsthKm2H8w7hTRwePGEvHJ4rjV0o7zfK3eKMSLR+4XpRx3j3mgoVz2eaoT3705g+yf
         Ty0A0RQsm09l+M/Bf9H+UBtYgRSx1JSmcYvKJvtGw5oiKb8eHvIMS3+jV1+zmQ360mkJ
         eM1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785617312; x=1786222112; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8C6J3xKw6R8FPOPnn4w954ZGYhiuE4HGYU/iy6pgEu8=;
        b=B51Qao1YgKHjoy6NE3z60EXlzaoafaoZE6zBSCUCqr+2uohOr2Ad41H/zDiCemt7gO
         UJ9LmzMq4uUYePu6eJs3rbptnxkYZNB1xa1ONi2SkpgbFAqdGMphAUYEqZaV7+FHpQF5
         nNO3Ppk0o71Pj1penEcsWyvLIg7MgG3RdPj899aDxPXE4MnJwfx9KigXZGif6CUOCq3m
         bng85gZQPThfDRWSSDk5h6CyhaZTu5XJbhNU3rrem4045Siuint9V116qnrNd9Dz4VBs
         7W7MgoD42g0nh73iOjV1dEJgdymBz9XSmBlnbvPXP6YZFyy0TLsBk8Poi1+S7z2ijiUy
         8Ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785617312; x=1786222112;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8C6J3xKw6R8FPOPnn4w954ZGYhiuE4HGYU/iy6pgEu8=;
        b=M3hbqLIFB1p35l/DCkQqPf8te5zUYWlk1hLNaJ2PwG8LFxs/CHEuRHzxgHxw1L/yk3
         X5Ea6u26EUhZgUrZkeWpLXG5vJnaNvKdDo8m2w6XWkfS263X4t1XxMyiFS08em2/9NKL
         VOUbxDLE5c2wuoGJLu15f0jxtHr8qAsdPq5fWGI0E///IINMCWwg2W1DLtfe/RXGcBlW
         C5c+M/Pn3QOLzk14FjaX/Kj6i0M1Mh9lw4yDmnuLWlYNojYixvisDYgCuuVydSPRCaBv
         bi7LlL1Zv02AbjhqlDVM18qQAbPuYoeCbaT2t80lyNrgaE9SFDWKfoblag4tDe/QfEcN
         UqKw==
X-Forwarded-Encrypted: i=1; AHgh+RpXjxBggnsEoy36qrtsb2ANjDvF0hQJlz1klOfR5qCqCrtMZvyZwRDWn5fXgYULLqO+rtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEAgQJKD5BlBhi4dYKWmbx4jmjP5h1b2zJf7ECa6Joqol1WX97
	4cKO1SCfiph9jilP/Fd6tB/EVImkT9NWUIqmASs4CqlTcIRwExvefhecWDmBmF+dYF8GGBzgNUi
	+8vnKc2d9scc2KFs4WUVEI4GVDlYfrEQ=
X-Gm-Gg: AR+sD12cbVi8mOx/uhi3i2RppbKXZ4/16pdgf4SRKgzezSdUuZ+oRhnBAuBGUDkg2OZ
	Ga1PFptJwB4/HOlW0UMFtCRjWPgTqWlareSGk74+Mp2OREaeIcqsCa0M71IfY4XZN4XXCdY/11O
	SJlzr/mceELsg3M0LeNRcjyGqJe+iYtg7eXTUbRLIDCLywq4J768zhiblJjkKorTAQbtzL4F0my
	LT1Cci6V0EtNeK9IShtwRS3EF88956ayU510eDKsqzI3XdGMwSYmPKcjFnkoG4MX8UGY80TFhiT
	CewVrWOPOK4xeLT321lmmBOY8Stw0A+MMaicNLdcDgiBYTyZTJK4foPX3WjK9ntWK0NiiQMkrr/
	DQrjNaCRAZRZL3b2NkzuQrwQKildnxBSthNdj4y4KJJAap6Jc1Lb1mnnN+SaOJREowFsNl8Obh7
	bTM5rngqYFq0W3xv1SV9Cm
X-Received: by 2002:a05:600c:4e8c:b0:492:3e69:a86f with SMTP id
 5b1f17b1804b1-4980c66c82dmr61216715e9.1.1785617312375; Sat, 01 Aug 2026
 13:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731003925.2728977-1-ebiggers@kernel.org> <DKDRHTVNMQ2E.1FCTWQZO2EB7Z@gmail.com>
 <20260801171549.GB3567@quark> <DKDSE8AVM7Q3.3KZHCSNL4NT4L@gmail.com>
 <DKDSGKU7WKI2.3UV1GEZW2VZWY@gmail.com> <20260801201830.GA9537@quark>
In-Reply-To: <20260801201830.GA9537@quark>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 1 Aug 2026 22:47:55 +0200
X-Gm-Features: AUfX_mzLIMowetDUO0vAuf8KJJkY3h7UzUQoep8RdQws3hVuyYMF4336u1MQHcg
Message-ID: <CAP01T74A0umBf_2hCuAygvUFBocjrDogxnu1_U+RkKBw8ictfw@mail.gmail.com>
Subject: Re: [PATCH] fsverity: Fix bpf_get_fsverity_digest() dynptr assumptions
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Jiri Olsa <jolsa@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Aug 2026 at 22:18, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sat, Aug 01, 2026 at 07:38:08PM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Sat Aug 1, 2026 at 7:35 PM CEST, Kumar Kartikeya Dwivedi wrote:
> > > On Sat Aug 1, 2026 at 7:15 PM CEST, Eric Biggers wrote:
> > >> On Sat, Aug 01, 2026 at 06:52:45PM +0200, Kumar Kartikeya Dwivedi wrote:
> > >>> > Also correctly handle sizes over INT_MAX, which previously caused an
> > >>> > integer overflow and crash.  __bpf_dynptr_size() returns a u64.
> > >>> >
> > >>>
> > >>> I guess this occurs when using file dynptrs? Otherwise the size is capped to
> > >>> DYNPTR_SIZE_MASK.
> > >>
> > >> Yes, though it looks like __bpf_dynptr_data_rw() excludes file dynptrs.
> > >> So this particular issue might be unreachable.  Still seems like a good
> > >> idea to match the u64 type that __bpf_dynptr_size() returns though.
> > >>
> > >
> > > I don't see this in patchwork, so you might have to resend this with [PATCH
> > > bpf-next] subject again to trigger CI if you want this to go through bpf tree.
> > >
> >
> > Sorry, [PATCH bpf], rather.
>
> Sure I can do that.
>
> Would it be okay to also make this function return -EOVERFLOW if
> out_digest_sz is too small, similar to FS_IOC_MEASURE_VERITY, instead of
> silently truncating?  The silent truncation is a footgun.

Yeah, I think it makes sense. I will also ping Song to ack this on
Monday (or your new version).
Thanks

>
> - Eric
