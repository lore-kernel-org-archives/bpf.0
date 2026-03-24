Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3A23264EF
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363338; cv=pass; b=F50atkuhemYNwHBzE6vLEZ5nQSx2seuXW5MnXa2jG52+XyURIcS1YetE7BgZFWAr4YUeK0rT+RcEri/UEkU3WE/dB7Zc5I/aOvxbdCfj5sSfEm4PTCiwfG/Sx4r9bWRnSbxUDu+5Lu0rBN5HYUo1YbDr85BMOQkbjmtNmCpTEq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363338; c=relaxed/simple;
	bh=EJJwrBg03w0qylq/CHDsteukON6L2xX2lFGJ+zhUWN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvLucoosQrIy2ZpAZHIwG9MPuvXZjaYbO1tlv4J5vUi3vmteQDzyW/pXs5xgsdeC0CiAoO7O9m4kj8m1YgjKh++UygZ0yrHGN2ioN9KmczSy8LEnMbBTiHffTiIMSwLMhL5wADtHjqF4ZbOtJH70QLG6jWUrtHUPtnwQeNqvktE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If1AlV2C; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If1AlV2C"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48374014a77so53719795e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 07:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774363335; cv=none;
        d=google.com; s=arc-20240605;
        b=jQ3DxWhf06yLL2Ut3QwFLbFH6ozJnLuGxDWhJj5YEjRdUgc9F2LRrG+ZwYbWCl5XvJ
         0oAahBhWcbyVnO7Gjp2qTixC+MVaeFq+AtEeEEqaOLvR5F06SzB0E9kAcSurL3ptnI/1
         jNn76uUdtkQ6CCH8j4uj7d99hFYQApH5zORp2+lF6RAo0fSLzXTdXEgejxNOZst7i3Uy
         3gbc33agKYE0qcfBGXIVtL8VZIb0synKO2lvZc7pSMpYCoTbS1sals5GbuSZePzXwMcF
         wAGAOtcx+/eSKDk5pAJXIk49f5P9S6VSgM5gsXRmR3MY3gQS6NddncebF284W+hVY3bu
         UTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EJJwrBg03w0qylq/CHDsteukON6L2xX2lFGJ+zhUWN4=;
        fh=bduN/PSC8K3gSV0RPzjJ3OzTLXCeBroqLW9T6nCziok=;
        b=hj6/Lr4XR9gEpo/rKuR1fdGHQq2ZeAH/7Ok9f5wmcLohjM5kM58qssqmql0/lLYh8Y
         guCwQjG4l/WL4qy76rZnr/a9egmeRpTq1NvOko4gibqg62jwU6X8MaWYxySOnq2+uCe+
         d5SpFEy7miatVlpLeaWmofA+YaMTv1BDV5GCEj+reKvK7TYeI5q9Uu/GIZAkKzbubI9L
         EVaQlG7L4BEqZi8j2GNlcfaTc+mUaZ2On8JD2wEdm5DGNyK0x7bC2nkg2UJItv/I81iZ
         G41v38AqexKrF8DaixWxN6iKe76UU24ZPrYSietmiO70nRuCknWBGIaGol/GB8B1ZWWf
         SrNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774363335; x=1774968135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJJwrBg03w0qylq/CHDsteukON6L2xX2lFGJ+zhUWN4=;
        b=If1AlV2CEAbeG7fWh//nwAEAFH9XDJxIGv1UVVQF1+ocV/9pNywOhj5BnueBxVBwih
         PEccSlnPTjbgvEKoOA1A26J438YnWj864anbytEKm3owPA6lbARuwOrphKDwtuNAF0O7
         Mip4CTNeG4D77YZ+qZldsq1W37icY4s6usxtWpoZcfkvWX/LzdZzNxFy3X95bRnYoV2X
         FdHzMbjc6adZEgp3GFkSFeLj8PGF7hV90KtwtPWnmsUyYa9tH23Fqgdbk8yB5jzMvywM
         PRnv8vYjx9b6BkNT4tO+WS9EyLBYF9Ki05ViXzAKIipFia+NO3Nkf8Xe/nq3HXIPyqek
         ZmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363335; x=1774968135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJJwrBg03w0qylq/CHDsteukON6L2xX2lFGJ+zhUWN4=;
        b=SStG49xq6c5YeFtGvRpMktSBP2Q7kOJF5nrCAbyXVOB5lkO1/LxsUoOCh1NgQrss0X
         rIekPCwhzvBtYeTsnXAi7QjqPQ/m217HILueEWZkR9t0fPnAMbTzV/I5Ke6CN79f2ltO
         qJLtvZvDgtRbRrX2uGwFsVdkDn+RWZvLAj2nMx21ZdMtDzHfihgtWocY59DTM2C1mdPW
         EWs2O/3bCSI0TnlwiV+4KvSHNKF5Xb0yKYPlknHUuURHym+L0mlvFPIQp4MM7KjfBGEP
         SSzrQzb4Y/bZHa+h+mzQjbx7UItL93Voi62Lh26sNnFUCyh1fQqounBzgHHjfVvn3uZI
         E/hw==
X-Forwarded-Encrypted: i=1; AJvYcCWc2jQ4fXR1PV5OGK0FfbcN/o4mEZX+4yXOicZYKIiAIuMKUU11yTmNkDF2e/nuDmc0XdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymIArG4JJyxGsoBEebY7qfOk/8M28LWBIUm/bVq0yn/WvPYZpt
	mWX+xNLqNp8u4Kawbsxv9XpB775ALAR+HTZazq1sEOpXLhow2iIGiIrPtq5U1x9rohTSTjsBc1B
	8DaHuWnpj5M8mN7ZsQTvh7DqPKfTBumU=
X-Gm-Gg: ATEYQzwx3Au+iHNfgFNvsvNrlIwLKig+l1f79LA/lypyRVNUeUC4VMQpOC3HqSM40b1
	hSvX4q5nd5YQTcYy7wXKWSlN4OA6SlL1vZOQr5Y0ccU3CLA2dDXT4+wHUYMGxw8+yAMtL0re9N0
	ujpewcBz6NePIGYBVssM2ERvABiLUtG6hjQcHm0ZtjKAkixKAT+uTwFnT7Uc84ysRcsGTZuCYgj
	4XrncrXZ68tWWZ6xbrr9xKCYvspngLzmiiC9eflPOysx49h18KMCtKJuwnXKkKky4PlpJZqenwR
	Zmr7DowyEfDaAyBjC/AoXCDGm0qau+IY6T6nTzKqopdvJtu+oA9bQIT5Sswmvfn4dupwhoorOG8
	PJW4Xp/ieY0tlJbX51wHhrsodTw==
X-Received: by 2002:a05:600c:1913:b0:487:1fc:14f9 with SMTP id
 5b1f17b1804b1-48715fffe21mr584595e9.15.1774363335176; Tue, 24 Mar 2026
 07:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324040535.work.851-kees@kernel.org> <202603232224.C1555BF@keescook>
In-Reply-To: <202603232224.C1555BF@keescook>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 07:42:04 -0700
X-Gm-Features: AQROBzDGuRSiN3hT9ODz0-PK-04DEkgU3eXT4KkiYPJTEFTkJ07mFjqnANlESZk
Message-ID: <CAADnVQLhWURvQ=gBYQvuEa3pTxabYQYhrPm9QG0gbxL9ee=vng@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 10:25=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Mar 23, 2026 at 09:05:39PM -0700, Kees Cook wrote:
> > While the original strncpy() would have copied a full 16 bytes from an
> > overlong name (producing an unterminated field that the syscall rejects=
),
> > but this wasn't a reachable state. This replacement will instead always
> > truncate to 15 bytes and keeps the NUL terminator, which should have no
> > behavioral changes with the present code and avoids potential issues
> > with future over-long string literals.
>
> Hm, I got a failure report, but it *seems* unrelated? But nothing else
> fails that way recently, so I will try a v2 with the "unterminated at 16
> bytes" behavior restored and see if it passes...
>
> test_progs_no_alu32-x86_64-llvm-21:
> https://github.com/kernel-patches/bpf/actions/runs/23472955268/job/683004=
40546

Don't fix what is not broken.

pw-bot: cr
