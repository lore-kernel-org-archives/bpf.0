Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35353322B7B
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775443505; cv=pass; b=Nm1FqwatMwpoS0rLXzZkf3IymY3jNZRnFnh0UpekIxvy4avwgbaJXl2BKv/n7cnwlOvbzpcKhrBeukBl6xDx1RnrnRUR03WFNB4sEvoaMXtjvsiJCAUYkURGXCFTbZQmBk3sXuyJQ5NTc9HUj5hDEEJIAi6Ta3X8hqX+vv+wBkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775443505; c=relaxed/simple;
	bh=Y1f5TSat9qViDqAlLViPj1+ziJfijnBvdOp7c/4J24Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ia0/kxg5ubjeQCBhMDzjtr98cajRdIxbsZR+D9ElvlwoKNYY4JsiJd5cikztrqCKw6wL2gpuI4mrMXINHRkXFzdpCs8k6tp8iMfVHI39jaUF+HBRYuCtsZuCu3OUGnwrhnVZuP1DSFhB91f6+yFWqB8bdOlf3LKP6NqiepfIuIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC2KsSi/; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC2KsSi/"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4888375f735so31355525e9.3
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 19:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775443502; cv=none;
        d=google.com; s=arc-20240605;
        b=bEQfHQES9LvsUF5HmSLaXjQTB9hMec87VoxuiPoC10WyFBKgosffpXinN/99+n3/nT
         Q24pxOhSQoegygPATB0rZAQhoRUmkGYpZAxEh8cLqh//Gbo2Nb5ys85SXY1BY/h9ha4z
         q1OZLerZlmmcrWs2bpi9lIo+Se9L+50ctdFC6YMDje2sl3ohQmIOalMMBUoWl5R1ErOw
         swb0B65pKkJ8F0s8kNtCOQzoXmmsVC8/Bi1k7SSYyUO8NLYEOwtV9nHcmBNfnEBiUBI3
         7v2Dse+43jJI/8sDYhZIeNG1dmfDQDEjknJVLEk5Bxe/2GFI2u6qINYTj0zDET76VqFg
         GPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F+jIHjIf8Dil6huRx8IzDf657IaMj1INOhDj0G1F7So=;
        fh=kSSmC1CM3HjUJzoRIhv4HbMM2a6WIqCJziIdtaCJ6Fs=;
        b=WBssELmVzG/33pjXJyEEH94/h7vAuPRpZo6ccbQWQCr/b44HK4RlpQADdKjabYijdy
         fHG4a1RVz8dAF9E/batYJHmvjyFUoFVhyXmb/TKoLY+5K8G4bxPw5Vi5Cw9IUK6Mscu1
         jg9Mbs5t298McYCeeCAKvlowW4VeLXg5OrKp5gAnB6pj9+0W0UwXDvLHuuR1F1yQbNTG
         m5/kEesF6h37KYVxJaGIHgQEUAK2yCoc5J4Th76/cCQrT4pwnRnYo2PEQldVCeEoybC1
         8oEGUuAdXQBMwjq6SknCBJ0SDmOIKe3n0gFMWxgYdrTLaTZUqS/X+X17eqBrZxIacxP+
         ChsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775443502; x=1776048302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+jIHjIf8Dil6huRx8IzDf657IaMj1INOhDj0G1F7So=;
        b=EC2KsSi/Lj842QihB6lk4/2HK9a7DJKT76DLlSNHcJSWgi2RvWh0vN2lnBAAYBvF5m
         s4XRlKmhnFEKToGjL1ZGfp5YcZzw2LC0PX8BoslSqxD9Ya2rFWVGmyPpqCYs0ky4ZiUD
         h+7cWfMCnu9wO/KzyHM2ahgJkbSWGm3xKiWXUtF6zNTwT82uyxlcNQ3AuhGf4wWgICR+
         Yo+1AQY6OPyIUEwojFVaAoUfDxBkY6W+mtbzuQVulzDVyoWNvwpb3209luuLiiQ3LzPB
         LJhhngTUur4bekAK2wklPWnAnmeoT6f4/BPXCSD++TJKCL0MjH2oSEQDUbiq4PwJ9pK5
         xpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775443502; x=1776048302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+jIHjIf8Dil6huRx8IzDf657IaMj1INOhDj0G1F7So=;
        b=PLfCuflU0/IqSVYUr7KYtR+c8yZcW4j9sZTJJoVPu6EaGRQZHdaPQDdZ5dflG2Z/74
         9Gs8hMIu6L/qQVmzTNAgLsF2m5ai7vaj+8uWZOQrPfpX5RAJHKKhTQE0Uh11CzDkGpJZ
         65b82uk6KuE+g90hWI+Rgwh2ljSz6/Hi9BmD2wM+bXIuu4145wuUEjH/Wp6N+qgwXe4B
         bUpd79VST3b221QHSoDsGBgWVjbpuy2rcKMj6DDOsOMrVtkF1xTQFXJVQhVT9xZL4ple
         g+5EXAzYSIw5Mre1pnXa9Szh3ukkUlMV0K6TCdzZqApVK17OGdnHvCkAEsnm9+TPqwNT
         NJAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQp0P9flTmCCz7IUgrVQVocFJI2tSqKl1ScqyoOt3JHLUrQ8XUJRTtiYXCOXswrJQjqcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMuFYoDZIQV7tStbwKO6WIMcIuwoNrYuVPQQecxyD4IN3sW62H
	7SLa9kQg1pDJ1r63dDE6DjWhQCoHgp1vDWb2mtLL4WyitJIm7zu4auRF5m6a6oMlxH0la0ZbG2d
	Vte3tjf4ZC1G4sw6BmWC3CLBXWw6EoK4=
X-Gm-Gg: AeBDiet+ZjG4ZrS5DzSdLlB5M8ixZ/Uv1YptvSsZyI0vNf+7ZfE1u9v/0qIM0MIy10O
	X++ti2UiZTMACCoCaO1urpscy39Twl95pKuHWvEbMqqd5lOxYvmhRV2Y2IWtkRbDer4jXChFd4I
	AV0ZWuS9I0YwSaZm1v7lc+7Km/+q3ww+tW9JgmCOG8MtYobHll/z03nS2C4j8c9dnV2CQCb9mXV
	YFo+kYx7YVSYpBua8YLSHU38MF5mA3taWWuTlWopESfMAhkX9ojy9sV0mx5g8mCj2B8xVRLoZ2m
	WdvxWcGnur027stAbJ0QLcRL5ESjKIRg3uMCdWDT3YCcKPnCiPdmNmF/BuLSUEO/ZVPFGxT6OHw
	L6YFn7gyoRGN2m9VNOkbV/zqy2g==
X-Received: by 2002:a05:600c:4593:b0:488:7a24:9ddf with SMTP id
 5b1f17b1804b1-488997dfafbmr168712745e9.28.1775443502192; Sun, 05 Apr 2026
 19:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acr7Whmn0br3xeBP@kspp>
In-Reply-To: <acr7Whmn0br3xeBP@kspp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 5 Apr 2026 19:44:51 -0700
X-Gm-Features: AQROBzB8-Pn9Ichq-vOkmEF_VItHpDQnrFoCdbel0YalhiFhbK8zofuiLK6bVPk
Message-ID: <CAADnVQL1kaAZE0L2k6svR4FK8UZvw44WXp=g+Df+SseMkc7xGA@mail.gmail.com>
Subject: Re: [PATCH v2][next] bpf: Avoid thousands of -Wflex-array-members-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:39=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Apparently, struct bpf_empty_prog_array exists entirely to populate a
> single element of "items" in a global variable. "null_prog" is only
> used during the initializer.
>
> None of this is needed; globals will be correctly sized with an array
> initializer of a flexible-array member.
>
> So, remove struct bpf_empty_prog_array and adjust the rest of the code,
> accordingly.
>
> With these changes, fix the following warnings:
>
> 7659 ./include/linux/bpf.h:2369:31: warning: structure containing a flexi=
ble array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Remove struct bpf_empty_prog_array. (Kees)

Kees,

It really bothers me that you ask people to clean up
warnings for the sake of removing warnings.

This has to stop.

This patch adds a ticking time bomb.
See bpf_prog_run_array_cg() and think why it's an exploit
waiting to happen.

Fixing -Wflex-array-member-not-at-end warnings make the kernel more secure.=
..
It's the opposite!
Such crusade against warnings introduces subtle bugs.

Look, this patch was Acked. bpf CI is green.
No failing tests and I was about to apply it,
since it looked correct on the first glance,
but something felt wrong...
'null_prog' was there for a reason.

I so hate this "hardening" cleanups that introduce bugs.

pw-bot: cr
