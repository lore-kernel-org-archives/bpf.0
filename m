Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08C213AA2D
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770938248; cv=none; b=HLi+29vJIJme600q0ehoPg5XJiPgqsuBh45OZnzl4JY5EsigcVxspQPzW4IREmKmbmWk2M4XbmNpcUpjNIMSNWRqvQzlDh2VKhkTi3m8pi7540VNjpTh0EgdZz2Ge479GjgM1bXt5QdUeQVMSqxu1EhQwfTUPcQ1xCoEpbSr8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770938248; c=relaxed/simple;
	bh=S2ZWnBUH1jXnjiYo1eF0IpvB8kEX4u5lol/BTspQMic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WeGE3ocDdJsTT6Aju4OoTFYPpNBW8iVYsF8ugdwHOY5ytZj1QMyTG/W9FLeCGHb+06TtkIT/XNmHG/cznYHp070xfmxbGShxWbchOtDKiaz0UrnX/CdTaj6eRfH1FLvjZSzSqrHPTb5Cb5pIpBAIf+buIc7ZZvva+xYbdXQUmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEBI90YA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEBI90YA"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824ac5d28f9so334609b3a.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 15:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770938247; x=1771543047; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S2ZWnBUH1jXnjiYo1eF0IpvB8kEX4u5lol/BTspQMic=;
        b=BEBI90YASbz0snUIT/584RMqmoWEiJ/kzyppReRdzfc26z4KcZVrZXJfBsqWH4LRKh
         Q+hzMQJVO+gv/Nz8L+OGN3ff6/03d/GTcGtZLrFQhpVUXtp5Mmq2tyPwWrNsjcnoRGcl
         a1LN08o2+tcO9Ft9X66nkNfD9BVZ6WqA5GTQJII5XGdUfHRSp91EUER6AAmTUzaP2gdG
         /BQybh8c+/flTP1RT9kS5sAnyugKxmB9lgcXxV46b352jIf1t2U7s20GHJ0sZ+kYqIOx
         YH23chs7ItNmZkzrtmRbRDy4GJmP6ZXvoPwcRtM/WlgBa2YiyeGtgCTtrKRnqzlH5NoT
         Ug1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770938247; x=1771543047;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2ZWnBUH1jXnjiYo1eF0IpvB8kEX4u5lol/BTspQMic=;
        b=n2t/Ka7iPfyJDnbZfiASkwz7JUTjnPh1guRCr28f45G5C0x9ErbVZomnWNCzlEQPn2
         bMsS+icGNdijVCid3TnnlkpRpeZmY4DD4xRhclByZNO7mRRWoN5QUVDmo5/KtcGn73xm
         adLxdfUedqRBtxYjHc1nviHlsmpMZHOpqXh2O5UBI1/Doqu02ftZYzlq//hXyq0SbYdC
         I+47XKF3/xCSoJOKEHcCAaSAUTykk4T78WELRtqete02tXdP/XgptOF/Up5kBtwPNpcb
         YcK9Tyn5AKbuA03BCV3hqTZl4Rz6spb9rlyOG+9KhOXl4rlmyinRB9aZbQDPa9LpvM9t
         P5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWoNZrq5ZDEITUAYziqtfkR4Hf+KpjHzX2A6rinDPHS0KysqqlaQmrh6151Gdbu8uClgt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypqcJA4DvjdNmERyEYsuZjPnMiWjGyX67zSqrlN+F/p/h2w18G
	Ngyn0TU/WZjlITG4btS/W/LQsg5rxVuXtxhj6X8uDFUp4O/yQftYkO6/
X-Gm-Gg: AZuq6aLs3WufooUjeoV8Wi2BSY8K8V7PFkHv2GX1vSguRCLvQ42iLZlLqlLe0ixPgph
	62XVsLKjJ7swUQehTvQVxai3WWhDtRD01816xg1IChYDOuHrbqBAQ6dWlLqEV8NP21hiNhU2Dim
	gxhJkRCQToNkZIvWzFpd2VYbkocbdQbT35EEFho7RS/EE+y/qtjpCSdYiZrIezwaJSNHJRPX/xW
	a4m/7w1gQMOrNeDMII4BR6G17+XE9QQ7trpanjQZ0le3RkhTFJBb1PVWB8suHPZ7rxRIm3smP9c
	tecL7bhWuhd+xfVq3Syc5yEptRxb6DeqjkRPuNknhZ8p5U0QdEgLskeAu7CkJE0+XquZePksTjO
	9khcQqFzjc6dgBGs3HtBl6H+tzdyWYQcnld1qEgsy7Ot8jBYOlWXFZV/EHchKw5yM2eLUojqxoz
	oSG7JP8a8pGRKAcY3Of+RO2zQIkAv//07w7VyndZ7LrFWeYXvD+bM=
X-Received: by 2002:a05:6a00:1145:b0:81f:2140:136d with SMTP id d2e1a72fcca58-824c94bbca4mr57177b3a.23.1770938247138;
        Thu, 12 Feb 2026 15:17:27 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bb55adsm337728b3a.62.2026.02.12.15.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 15:17:26 -0800 (PST)
Message-ID: <4f2c347bec3e1192435e668f70eb70a0b3714c42.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 06/14] selftests/bpf: Fix cleanup in
 check_fd_array_cnt__fd_array_too_big()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
 Alexis =?ISO-8859-1?Q?Lothor=E9?=	 <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com
Date: Thu, 12 Feb 2026 15:17:24 -0800
In-Reply-To: <20260212011356.3266753-7-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
	 <20260212011356.3266753-7-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-11 at 17:13 -0800, Ihor Solodrai wrote:
> The Close() macro uses the passed in expression three times, which
> leads to repeated execution in case it has side effects. That is,
> Close(i--) would decrement i three times.
>=20
> ASAN caught a stack-buffer-undeflow error at a point where this was
> overlooked. Fix it.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(However, in bpf headers the common pattern is to define a variable
 in the macro body, something like `int ___fd =3D (FD);).

[...]
