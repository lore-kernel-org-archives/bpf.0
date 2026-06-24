Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948A28CF77
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297612; cv=none; b=LrFvnJiGEUWa65msToTUD/fMXvkXz4Ej0zN3WMOcFyAfCf2K6EzEYLEjkyshX11tmSaQWtleX0Si8yrBjhglYKrYnFRkhRrP7DtEG73fSROyiMzaiH+wuE8W/5DdC2886p64+fxqZau1xKTmq9LGYZITv90FJANoj1i1lKTNdl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297612; c=relaxed/simple;
	bh=SzwY0ArSkepQcN7OqNhWKPW3eLo9VWe8c4Ja3adS3cU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hgzolYfjob2Wm24zAzAxOukszckft4DsjdnUkea6nHjGDwTayulqiBrLwCyc/VZW8QVbfdub4ObL0ZDyWG41d/asrWbkPjCuoNOQgYet73qeskxvO2sZfLzdXJ9rPmDC3sBpWdIVXjV6vCkD4hH4ZXqzEpytHdNwW1Wr9trc1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DS3UbwvU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DS3UbwvU"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c08922c23ebso113952266b.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782297609; x=1782902409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzwY0ArSkepQcN7OqNhWKPW3eLo9VWe8c4Ja3adS3cU=;
        b=DS3UbwvUuClnt0f0ojHK2TcomlHSFCkVepvSFhJLCQx+7xeFSVcCyv6KHqasAdI5Sz
         9sDxDWWZGHvn9gAGBOcvaGcUiwpWxybjIo5wySO3hWzUUIWgG7m8VOr4vVOKcNEyRi+R
         8RiZ0lX3FmsVZk1ZdZ4AuO0bVWitpK34vvxg5clhJQqn5/7+h4D6pzduBjx6J9SAYsQ7
         o+9nstQVX4ZIqlzce78UYJSpOQ/CnQ+Ogu38kvXQQWMtPPcr8aCRx7uWlJbMx/3jez8b
         Tk8Z8EHPM98kVcfb5WC+jSAAXh0SzToeKePiLeX2mMgMMyHSD7o/BI/T3ULMI6hUyn6z
         pP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782297609; x=1782902409;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzwY0ArSkepQcN7OqNhWKPW3eLo9VWe8c4Ja3adS3cU=;
        b=f6MppTLrN/EqBuowQ9K+js55nHD14OcGYzsI30kzLwkFXwXVUE2I1O5hecduS+9/Rr
         CEe83HIMhzYiJfJZmJ85SyQv01UJk4VP6dTkQdT6IB9xZ3yV7iMXi87+M8+GthNyBSGK
         oHooQ6y0caHU8L5CHV/vfd4ibKqj7wU8zjZ3TyTt3kMoW/g9iwje3VOaxSkEhyuAime7
         16l941QIu6NiWh685LC8UqfncQABn2XZutBn7oQVMtj8/6Yh9xeICPUn1ifJdw0xRGIo
         GFzALUw5KvggNQjlNMV+L2P14/9k8QCkE/z78UD8Pd/Cfp8lPx30LSN8GeDi4l/Xf1FR
         +zcA==
X-Forwarded-Encrypted: i=1; AFNElJ9RyTMJeOupWEUMxmICfxr7IhjrgxS/LQIUclM5G05HFEtRK8aETJTeNY/TgCEunJJXM7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFYfOlAlZ2vcTlLdMUj9jBV3s9ILayxGKrximWMZJOXgeQBEC
	7VVadH0wvsXLIA0h+BousbKptLWrTtTjjqx9mdzJR7bYC4OpkizzjZR2lnsu9mT7+Xc=
X-Gm-Gg: AfdE7cm7uUc9HnVsZfnBDd1xLR1Si5FwiI58M9lLT8pPJ2erYRuszTBSFH+Vc3IbZHJ
	jninch4SGs3bi7iceyU3pABvqHWRQYe9W58qTXY7dtDVfDRj2Ym3CtfzUk3yuwy/GXxXC4wxbv4
	14t/hLS9p+mkxOfWaZcHEtvSSnOiqRGqGN8ZILeon8vz1Mn8BBYSZWDlDyjKjp1NyXE6GBZZDjB
	J6ptEh4bTgoVHWiXp29lN70DFHCCmeZI6K3urgdf1MAptwuA9USpjvYz93EuGXps/0LXNzIA0WT
	WUa8uT7ySCZUx/vUjHPUDHQDHcNifHf19cwAWqZKhEwfUEfbnO+hsic62POYe8oVkvQlLoAx1zU
	3EIUwg3jiL/HPuH9HqDerK3+NIASioDum6WPJlDqBvp+fzw69gkxzT/xjVrJT72pxYGn368zzt5
	S6J/1VOOAMxT3tRSw=
X-Received: by 2002:a17:906:c10b:b0:c05:b9db:68cc with SMTP id a640c23a62f3a-c107a353073mr371151966b.0.1782297609382;
        Wed, 24 Jun 2026 03:40:09 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e498807sm621703466b.1.2026.06.24.03.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:40:08 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,  Kuniyuki Iwashima
 <kuniyu@google.com>,  bpf <bpf@vger.kernel.org>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Jiayuan Chen <jiayuan.chen@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  Network Development <netdev@vger.kernel.org>,
  kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
In-Reply-To: <CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
	(Alexei Starovoitov's message of "Tue, 23 Jun 2026 14:26:06 -0700")
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
	<CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
	<87v7b9ysep.fsf@cloudflare.com>
	<CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
	<CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
	<87mrwlyqg4.fsf@cloudflare.com>
	<CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
	<878q85yoy5.fsf@cloudflare.com>
	<CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 24 Jun 2026 12:40:08 +0200
Message-ID: <8733ycz0fr.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 02:26 PM -07, Alexei Starovoitov wrote:
> On Tue, Jun 23, 2026 at 1:36=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> This is a follow up from discussions at BPF summit with Alexei & John.
>
> Not quite. The discussion was to disable pieces of sockmap
> that are causing trouble.
> Not to move them under config knobs, but disable them.

I really don't see how we can remove a feature that has users.
I guess we will just have to weather out the bug wave.
