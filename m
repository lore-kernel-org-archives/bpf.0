Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ADC244687
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316532; cv=pass; b=iI2IOW7SaMfA2kgbJycTj9bN4Q0qFwEL11sjjsV1d2/4dAs563uuA97ar0Zs9XRqOIS2JFt4vBV5LglrcwjV+5RUhgzjPMpa67oM4+w9wPpwpp6B8FE8EdcLQJaUBOS+hu49U4dGnia0JQ9u9GXG7UA03swp8gllhTvnf0p1w8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316532; c=relaxed/simple;
	bh=r7y211ubp3omMELp5KqhHWQhgFjAYpzJD+K9D8lTZVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmpEc+bct1z6hOwQxHh714SEUMgTbyfHndy3eXo3HZBAOoVqsk7/6ywLKpFLiMqBiiKxsNenHizEMz2txmUMTboiGBBJYgze4UTr4U5s3UEFHigloxlGHohyUzcgNRVbQnnVRWAAEpBadfurkmfqH9eBsiZTB5TdomHbwEXHZ+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKs8pDCn; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKs8pDCn"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43b40fb7f95so702576f8f.3
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 18:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316529; cv=none;
        d=google.com; s=arc-20240605;
        b=fmzMYCajkBrEEhtERAQYBR+3vShAok03wPN4iMe5CKc6tejQPx5qy7NZ5hYDE6ckg3
         d0iFZxpvW12va2u08i/XomiiKN0n18Ewx2kANzsVC8Jxpb9JUkQhrFoK4E/PH8Bl4a+K
         bZQgd4NL0uLhcDrMvDZ0QLdbPl9Xbqs+c3zDHUFIXBhqAfFce+XwHOTbzOWekIxhAxXm
         rB1LWNd1fVwmPrJ7EfNgA3wa/erxxEtCAN68a0XO6/BRzoGg4VOQhFwy8Zies4WzmUdF
         OFR+3uFaH/7fZYWsV4aG+ZD9DQULPefsRox3b6VP2p5sbAQoYAVN548SOKPVL0+QVkB5
         ST4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oczxcm+7nIYhSCAxtv8AlUWabW040X/K7A4VrdDatnY=;
        fh=Fxdxlz5huq+erk9LWCDvm2szBJMOkVXaZgjKMFWRp34=;
        b=PxyG5s8KPBQwtd8vmLj0QsDxhn6ndHivE0Ok0otpu7Cz3jOvH0LikU3f+CZBveuIK2
         mt5ewQ8NY1qUCsSmo4o6+hoOaC7HzyTuHJ1YfDK5JHqvUQmV+J2IP0mi2MAob68knDTr
         M61+lRPicWSVaTyvwuO+rCUR+mqCoAPPFXGZmhZy83TqX3ZyKjXXqg96DHEBpbia0p6U
         T9AbiKY6U2xjBWjWFyGzSJVDA4WKyEvf9XF9wlHO9C42bbZZQiPwKvFDa339azzcwTTd
         X1YJi1aw8nnnGw9uDxdpsZ0SYw5BXnPE2QimiZ38mxJHNxcKotFgP4EGNCLNH4vY/W0g
         w4Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774316529; x=1774921329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oczxcm+7nIYhSCAxtv8AlUWabW040X/K7A4VrdDatnY=;
        b=HKs8pDCnsqZbg+efqRElU/3hk6RLrt10qQMxA0BouX8bW2WiqL8v/8xhFzltMnQNA/
         EsD9dCLiUldsx+eUvYw6Z5eIlhOe0gtw+6qGIxgauhtJONqcqpyU2kJa/g8RDRVtQtY6
         9vj/mTdgeMLpAPr+spnh9AN+CQLdMklT784IMUbZAST9HZbfXCSbUjy+gPp3+T6msxwD
         87opeLCtObJYEKqRLDR/xi3rVnZ4rFQiL1j/AmA0dH7k4ygujsBuFnuGOunRkOoLlbRS
         2R6jkrDMryrb0uTEJq2rYcj98zFn6vxOqI8SpmL3aQ+xOGBL2g9iQMEkvIVVPz6ovjml
         r/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316529; x=1774921329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oczxcm+7nIYhSCAxtv8AlUWabW040X/K7A4VrdDatnY=;
        b=A1zF+DsB5IqOcIoks8yetPwdhttSGCh7/GgEOU9A825jTLmzplmI1KLtuIBDfVrKyj
         2KJP0vXvXW71rVc68XVyDAAIQgINAihTL593QQHR0Agz1d8KpOqaIP3S45kLNRAOGrUn
         pwXD7Uq47buXD93278svoqor/1O2YZMjGOXVXb9P1aME0qUTBHfNLdjmSeSBgQz0WYut
         vNVkYxA5R58vx76JIQDf/UY6tnyrFevKefklA8dLXwppjMWCPai9jCR4r1kH8SejB6NE
         M8pWmeqs7tdVzNah8wR6wIWteYkHR3Tr8qSCegaBA2Hfftc1o4Kux/haVZe54XOP+wSr
         /44A==
X-Forwarded-Encrypted: i=1; AJvYcCWNgK6QUPeWduciWoAvP6T2j1a2jJNJBWvoRp1PJqPxVpvnWX6bpSB99EJSP6P2i1/BwV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KZ+YHKrJld7j8KfTLKIopqx3+uDA3jgKIgS88FPTTP+mxH1X
	bSETXGnGF23TSOJXJ8dx5sGO6sLALyReql6uozEiA7V/zWem9MNYHIcjcvoyaVeSyDK2/m6t9tc
	1aGYp3xGpRYSqhHMRy4f8CY6prMpu7vw=
X-Gm-Gg: ATEYQzx5ObQ8Nt3rc9sK6NceXdsG3eblCYO9UjH03KA5ehfTz6tdLAYPINYWZZFjVNS
	LpCLSHj0b59neZAsYWwOQN0VgYaNcXzoW/0oBT498J4NwT2vapf5JczucMqN515Kp/vaCoWDyWr
	/2nH4K/3XpNavfo4TZDzDZFYJqLJLAK/FjEfA9v1c35jBp/roF+Xi7rAQXE7jqOHzEJOM9dHf1t
	scfDxJwvvysuG1ztfpR9BGU44ZiXrDMQ/1e8FaHds9nW+8BA6zARblBitjMX7FBFsN1E1a5JlIi
	UlWDeqf03ahlRUx1DbkvbDrMXYvfUB1Iq2RCR54bbNo+TxLOSikDf0Kz190=
X-Received: by 2002:a05:6000:25c1:b0:439:b3bb:2777 with SMTP id
 ffacd0b85a97d-43b6423bc5bmr22855250f8f.22.1774316529365; Mon, 23 Mar 2026
 18:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com> <20260316013651.3225328-6-ankur.a.arora@oracle.com>
In-Reply-To: <20260316013651.3225328-6-ankur.a.arora@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 02:41:32 +0100
X-Gm-Features: AQROBzCFkof4eO3sQ5Mi_04Kqc10_skG3cyZZaVxF4JXZB25lRZil-hxigAR01M
Message-ID: <CAP01T75VaNGk+adULuX3q_8uxc0z78J5B_5ECLy2VR=i7pBi0g@mail.gmail.com>
Subject: Re: [PATCH v10 05/12] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com, 
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, rdunlap@infradead.org, 
	david.laight.linux@gmail.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 02:37, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> In preparation for defining smp_cond_load_acquire_timeout(), remove
> the private copy. Lacking this, the rqspinlock code falls back to using
> smp_cond_load_acquire().

nit: This temporarily breaks bisection (or rather, leaves things
broken until later commits), but I don't care too much.

>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: bpf@vger.kernel.org
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Haris Okanovic <harisokn@amazon.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]
>
