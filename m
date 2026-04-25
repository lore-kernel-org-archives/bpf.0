Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9625B23ABB9
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777149635; cv=none; b=i2cK+OT0XWLQaJNgxqd74sDD6x8cXAi6LTjFCxey/rq6VUlayGtbnmXhe5mJ/qAzQAffRnW3gWH/o4i6DmfdwGR5N45h8xWrpw/G4knYQ/mEFG5d7gnSE4o0YniNHVnOkmgZGSohX2mvJ32bqSgLcz/GBHdT/j38GVlifkCUX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777149635; c=relaxed/simple;
	bh=eXGKJ1cs1uwpHb74uKwDKSH51r13CWDhacHB3RprwGQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFHYTMd6MV3GsKzJP3Q1KlLoZutoa4cIOggqTHvVhVsEV7G7C5yYtu4A+BYqriXhxprStFgfUBurDqq0m9J7kwbpjRCLkrbgVH/mSQJfiFUMOc1o2j/EMk6lRWiu/VKK6rVfiEysF3+Kr4cbs+oxB0IfFkQkJdDVx/HmllBJFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f748ubWh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f748ubWh"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b150559bso71095755e9.1
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777149633; x=1777754433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yFJdJ7NkrEvPSxW0yIUSUiyvLY54UgTANBDOvschyzw=;
        b=f748ubWhpBDF2YqTDpzXbwVNnZNEIimCqXg+52Y4H15qQ/gCbdN2GOthb6tlA9XEW9
         yw0UIkZDy1N0Jf6lmwuzcrxJXB4ZBWrOj9G42+fsRamRFOQv6jtcVKQCc11Z63CYfip0
         BIh+THIEQHKr+S4zAwW1iVbHO/NX++SBuE3a6oo125HbuLGoCGLQJf8jUR48P0HDilnu
         VGBQMAJ+dm6Bow2JO5ZSIEyaJuAJ1rieJnvMeDj5cHac/a7uTVIOOLGlwJECmlLzWbDG
         sUqSNCJlTfhJn95YS1zOus7eA9UYLtkw0Xm3ZXomjQIKfdeb2cRyuABS8aDhu6uUdPUF
         gSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777149633; x=1777754433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFJdJ7NkrEvPSxW0yIUSUiyvLY54UgTANBDOvschyzw=;
        b=Uz1c7xGfEOwJn+j6f2f7rwrVJsVV1JEWq7QskjJKWSzDfg7XkgqxVL02YAzureTfNX
         dWo1prnCqvGia24q20QH5SK/bJFQR4BaZN/w8tPGpIxkrIHHWxI6MQQwb7jnSSov7TYz
         RbgdY+avd0RPOZDyKsGUWSxmUB14tBtdMvZ5mwD3PVYfxPI+I8pIfYzlKeQvUj8M3rsc
         kxLfO2Fbknf/HIoSmaHNPjY8QX4HTjfiQB7HP3aGfeww/aosMREBfkgdi1QKDuzxJN6t
         xMhAQ2kcXe5PcTIzSiR/GJnVYUmEJCE4nlQJGQZ1vPHUbMBVZM+LHl63joxDLqpkaZoo
         TvvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/M7gKinZiRYHmvsiQyY2yL/avyrmHXe5IegcBswJPHOpPbVeeddQztOorYv/K7bW/UlBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBv2RPBY2/H9ehLBMq9W99OUbKnYGt4NHA6Rpx3QhSrwTxS/k
	+hMBJRhUxbxauLfzdv4GQW26McxoWzpKU0hZmAyN1liR06i5ess+arV5
X-Gm-Gg: AeBDieu984EdvERKUbzWxhZjSKIFHwoMWxdGNXeMRypmH7J4xDdB5EmiQTwcvo+Blul
	ZwQM/5vZGQNAKjL/B3jo+c7x1fXe2BjdXHVVFonJAW9zTtLl6304WP53khamR3Pis3cu3hRGR/I
	99eg5NiiFfA2d09yKdu8HJ2VwuINs5OvTJofKHGGtVAKhrpD3P9tKVm300tLExdbQqw3ikY4DOY
	IYJRTxcv4J6BXWtGvYgHTHyZfZ5ejIlDHHmWqa4BQpT7lvyw7TuSVrMV5R0tYjTYoFmM6uJWSC1
	2cce7Y6eRe89Momd74CsacC5mP3Vnk3EbH0NziYukvMipHKFuPS3n7jKkC+70iHLB4hClhFTdzx
	MZrjndgCZ1kWX4W7Iaba9fxcHjtvoWH9xRizaI3Kybgi1SrnvlzddxZ+Xs1ubepdPi/77IcWr93
	b1GwHt49P8J2VCHkZQs4t7o4qCiTpV2LU+
X-Received: by 2002:a05:600c:3546:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488fb7880camr521977565e9.23.1777149632839;
        Sat, 25 Apr 2026 13:40:32 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm67028315f8f.33.2026.04.25.13.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 13:40:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 25 Apr 2026 22:40:30 +0200
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf 1/2] bpf: Do not release trampoline image in case off
 unregister error
Message-ID: <ae0mvi9yCiGakqdH@krava>
References: <20260424153905.354922-1-jolsa@kernel.org>
 <CAPhsuW5rcXABPeOy7PFkHkO8WNyfqppGpB5ijTvmMbj7GVWfcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5rcXABPeOy7PFkHkO8WNyfqppGpB5ijTvmMbj7GVWfcg@mail.gmail.com>

On Fri, Apr 24, 2026 at 08:50:51AM -0700, Song Liu wrote:
> On Fri, Apr 24, 2026 at 8:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > If unregister_fentry fails we still have trampoline image attached
> > to a function, so releasing it could trigger crash. Releasing the
> > trampoline image only when the unregister succeeds.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> The fix looks good.
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> Can we add a test case that triggers this crash without the fix?

I don't about valid scenario where unregister_fentry would fail now,
that'd be bug that we'd need to fix. We have WARN_ON_ONCE on tampoline
unlink fail.

The fix is meant for when this happens let's go with un-released
trampoline image rather than kernel crash.

jirka
