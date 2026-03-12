Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2772351C39
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773340521; cv=none; b=nVfx4oDryTe/j2evPMzgM93piNM7LV8aJ4KeBVJlJYeij6sWx3haxllmcSsYffjij1Q5AtCECQ0b/3R/Bo8MABxi2qqAimMP17UhQSeM/aPwrTUY39rKbWIN2MX94JB8LIqSCPLQNCiKl+XMJMnU6GaMUaY8m2i5vF7xcVpi0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773340521; c=relaxed/simple;
	bh=aEp7YR5TxoqHGYC2291CeVYXnVb96fxBGcOumLk3yX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URcFWg4XnFeq6tl9aSY3rzSJG18XproLmxoxdLfoKqID9Mtzt+BGK0dP5xqqhLh7ZCtJjnKEX1prayHx4GodE3km3M92wU2LAdR/7ck4q9FWJtsKv9D+7dHeMRGM7GscHUkLYn76T3KIiKc2g0iTwZzNai7YemQhLN4RCOx+i0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqJ2/UJF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqJ2/UJF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso12157725e9.3
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773340518; x=1773945318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6KWFBO7MKAjgJ1/v3YqmpWL3yxjy1pepKYb1u6eEcc=;
        b=PqJ2/UJFmSq3fnr3u/ARU5GjzhqoHJX6iFiykI3OiU8/9hsdUe1MHYLroS1W9dk+V/
         X45i0j2/8ZYy7ozpU5/+mupE1UEtCBaK9etErKQVeWkD5WueTDrJGQ/aYjF1HPllZMz5
         v9gBkyYhfOxs/rHkfTRT9Ajkzou97ujens5fh5h4ebbdkx3IhL8aAkGm5f4MqygxMWxq
         ttcvVMIe9QxAxpRM+zY7d3wEICggOo8KEcOZyaNxf8YCO4Fm6OiWUJwfbTZuGwjxdQkr
         sMOPpqul1RMdsucgFEwWX2nUr7GUTXdNUOKCmsqJa2R7m54grwL3ANPDX/KP6CXYV8lT
         dhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773340518; x=1773945318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6KWFBO7MKAjgJ1/v3YqmpWL3yxjy1pepKYb1u6eEcc=;
        b=q+aBM6nC38Rh18tLkp7SXZoB/FV9oVVgtYIv/MYqJTzhDWieUPyaR48DH3IzCqjLjt
         zvXnDbHuHGwGsV+SmeQHfABMOG7MlzKWkF/IH3iw7N4q0RuypCu7txCGEHXIIPh7T7yH
         3652jSVvtH0grdbLhBPNaaxj4Q5oTXT143R0ylk59HGg9lR0a/oWlEs0yBppxw1Cg+of
         ah5fCQZuQj6h/fkWvZtQu5a/GCSSz8nY1ed0zECAI4ARNIKlk/8zpIvRtN/K74569BwS
         AaPLpU/QRM5urmI90rWePz8BBzM/DyfGL2Px1bvnsQ81VqECTjRyh+o5SseXm8sG6dw7
         VLdw==
X-Gm-Message-State: AOJu0Yzafh3vBw29GaT22G5et89lmP9j8wXZ+GUJ9Q994Rcs606AjAto
	eiIoFkZTRBBos/QBZM4ZfOaqoGkBFuy2Yo6IiN8/AIHMVPfR3SoMWyAp
X-Gm-Gg: ATEYQzxZivkW9/Hzo9gUeyd+LJ5B6KKb5hBrn8yae2CfIDj8TJPavd8tCIKnusCl7jx
	SMYnmahkO6zemGF1SKjYySNU+80+DZdfqNZJWITzNQTwi4630NimPeiith1cEpLDfwxfil7rLxh
	haTGnFpA2tLvzSou+BbQzIxK/JvzrXPqGtTqR6EjwakTtiYuZAUQuM3nQ1d3XPSuK4z7514/ESJ
	hEDFf6eBzymvkzjjDC/845vFrOKrhgQmVA0bo3pRLP8B/gZht3Zdtj123nvlLc1s9dmMQ1ZrBRP
	40Z6PMntVwSfREupGDleLn+VynDgafIDrKICtM99wzPeoeK+nmP4RaG0/Z+o5f4pvVENQLRj946
	1WZx9S58BKiegLqnhNFGecFK643vzvRANNionvTlICprQYaCHPuSQJwu+E2SRmBwJciEe5Fmq54
	wiu8M1iqbbVV45Teh8Dbx4NTFdZY9gMfqoNj+ur2fKQa0o341U0dxlXAuihcXWPocH5ummC+tn8
	5CabMollFVZFp6whxKI5E28/F9D6jCms5u7hJbf+CJcrIG875Z7imG/YI+F102m+JiUsZn6nSnA
	eDmho2rQFxA=
X-Received: by 2002:a05:600c:4fc6:b0:485:3fc8:de9c with SMTP id 5b1f17b1804b1-485566d520cmr5690955e9.12.1773340518016;
        Thu, 12 Mar 2026 11:35:18 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00e621310b96d0fd4d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:e621:310b:96d0:fd4d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a03cfd18fsm2982146f8f.36.2026.03.12.11.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:35:17 -0700 (PDT)
Date: Thu, 12 Mar 2026 19:35:15 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Avoid one round of bounds deduction
Message-ID: <abMHY2sCSe6xEKR3@mail.gmail.com>
References: <5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
 <621f8a301a3a29af041ea8384ab09498e3f20322.camel@gmail.com>
 <d4f6ebe35ff98cf3aeabe132027d7a05ae4dda4f.camel@gmail.com>
 <d6ed91eb3fc9783811ae9981728a5db57decbfe4.camel@gmail.com>
 <xec3lnz6smkki57civu5z6hlr5vl6kqnec7f7zxza4vifs2qf7@g4o6gxqmcnlz>
 <cc228139101e28d2bc76beb371a2c3f89eed75f3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc228139101e28d2bc76beb371a2c3f89eed75f3.camel@gmail.com>

On Tue, Mar 10, 2026 at 12:45:39PM -0700, Eduard Zingerman wrote:
> On Tue, 2026-03-10 at 15:56 +0800, Shung-Hsi Yu wrote:
> 
> [...]
> 
> > Agree that perhaps we still need to keep 3 rounds of deduction after
> > poking at this further.
> > 
> > I tried to run an updated cbmc script[a], manually editing the file to
> > change the number of __reg_deduce_bounds calls made, and check whether
> > an extra call would further change reg_state. For
> > __reg_deduce_bounds_old, it needs 3 calls to pass verification, and for
> > __reg_deduce_bounds_new, it still needs 3.
> 
> Using the same logic I played with orderings a bit:
> - For new ordering 3 and 4 deduction rounds are proven to be identical.
> - For ordering in [1] 2 and 3 deduction rounds are proven to be identical,

Nice!

>   1 round is not enough.
> 
> So, I think [2] is the way to go:
> 
> static void __reg_deduce_bounds(struct bpf_reg_state *reg)
> {
>         deduce_bounds_64_from_64(reg);
>         deduce_bounds_32_from_64(reg);
>         deduce_bounds_32_from_32(reg);
>         deduce_bounds_64_from_32(reg);
> }
> 
> With __reg_deduce_bounds() done 2 times.

Thanks Eduard and Shung-Hsi for the amazing reviews and contributions!
I'll send a v3 with:
1. The renaming commit from Eduard.
2. The initial reshuffle + additional reshuffle from [1].
3. The removal of one __reg_deduce_bounds.
4. The selftest and I'll see if I can craft a second selftest from the
   new inputs you shared Shung-Hsi.

> 
> [1] https://github.com/eddyz87/deduce-bounds-verif/blob/76755f763f9282b74ca4e2251f83767502a98e5e/deduce_bounds_new.c#L321
> [2] https://github.com/eddyz87/bpf/tree/deduce-bounds-reshuffle
> 
> [...]
