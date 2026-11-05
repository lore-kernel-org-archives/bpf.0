Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793917931;
	b=aVEG3o0EoMw1IyHc6Kn585bLWFtGYjHDZsDkcZsI2nqZOxEjDhEzXpM3PJw/shw/OXgZ
	 BrTxAJPvDojoHCRSyZTkmvxLcH3FtF5yH7g0811QVqSEpuryTG4JhB/t+lAXgFmEwEvWY
	 RrA/aagembKpB9IBt/bJFtSkY0WUJoOmRwx5UYFBIF5BZoOc0yO80OpLvwNDIhL8I6LBw
	 MVuUxJzobrfftG9NGZQ/WYJTLfedWPgF/JEgkUI/aMeJQNJkl/1ybklbkpr35XYAX8ALb
	 f6Jbrma2usFQu8k0vBjYK+bY5AkD04flCcnRX92UJQ+3GVmZ5mkYM0DqQnOuoYzCR3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dVk8FlSCk0p0X/zLsBRSgcQPtRAQ4rsApX2OtPYv6mA=;
	b=1wxrx/FdymCJ/N6Bka+oDJVC25YEapaycCQ86AO1mOJR9e7N3OsOpFrU6c/bJmN4qxn7
	 tBNYH5zrQ2nuxfDeMSLmrB63N4SAhPKjEIFl1IRmIH8A4yPwcZeqReS6CMau8ZHzrkj9E
	 mrL+UgZtOWW7Bk3tMJ4Ly9ja90NlV0gfTO+wjoVOA5+27N+RVfAChMH4/BZxkIu0Taq4S
	 zrg42X8Vrr6JiKKjlSmW1Sb0zGubsP0v/QXaCSiJhxWDAF58FWog24PPtDLZzD4bgAqZT
	 NF+iwD9Su0nh3tJaWN+VTXwDHfgfnAv5jhTPhuTIF8PrdS7tLEBNO52AwgAOWkJmEzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Eh+RrIwy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47382606A328
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 22:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47382606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Eh+RrIwy
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b271e573adso514467b3a.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 14:32:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793917930; cv=none;
        d=google.com; s=arc-20260327;
        b=f+Aq48wmZhicctGqkjyROsdzi4zuC8Y7Xs9UQLuszDaCDJ3iDd3t0lVVu0ST+mIzSe
         vE8FoK8GhMi3efXC0yO+dB6px9KhscIUdkz7hAJ6S+0RqJ8GXkBCqAmzcSBlGk+h6+IX
         ddHSUA/cGWzeRDBSgtEUP5oKoxfveIZipTo/vXDkeNNXC5DtRXRtt+3Vdt2frCXKrSJC
         u8gQtEZzTyK93Wg42X2fgRTxoylI+/ruHtld1T5zQEuIzVoOk4mubZMc3x4P7t8BrVpB
         mF9nQzmFAprgsWoU9qmxJrTEj7r7AyG7WGQX3pQB5HJmHi3dyWHT0IWVTfhJoAKnj8ZH
         hCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dVk8FlSCk0p0X/zLsBRSgcQPtRAQ4rsApX2OtPYv6mA=;
        fh=gP8MIzFyoT0aKUoFjxBO39qFI8gFWAp4Kff+0ohqo6U=;
        b=NF0YR3JvTaCeR6kiSO2tUOXmpb3lMsYRb1Z8pD7M6+1+08/KQaTuBNwrffg0il4iMm
         ZiTuHa6Mq9ynqoA9rKWYiS4mkC4Tj+7RDzrYr7Q3Sb3ewwtPR+ifC6wV0Tr4q9bAiPbx
         /4vA55moXinB4HrEVZuF1CgUrbh0woQyVjCgXm3W+A4SOf8NcaN4Rr5JI7ZBwWN9ooaM
         WPxQLT93WujF+2up6EOAts6LClIZlHS//bogGUAVz3bM5vQVLtUBfQWbWxYVO+0/u2jh
         8UksMRlK9W6osMG36C+kEIC7gaSt+lc0oMUvJxUfXbrdlHzgaaVr5rUhePh9FdOlbt4q
         g5HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917930; x=1794522730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dVk8FlSCk0p0X/zLsBRSgcQPtRAQ4rsApX2OtPYv6mA=;
        b=Eh+RrIwyRW2pLFAckDF0MHCbB39wfpgowwsx1EjCEg4TjglDCPKN/+7ORVBplodNEl
         jPsuezn9sp+54nY0YFIN5id6tKlbCmtePGeBOzUEgEtD3zRu4wGuAGpQI9AU5O9H/OG2
         BPrZhYK4c4JMn8PnVzz5wZtQIKJrYDSceGNLApikgEpvL+Cm5kmuYnC7eHy1JGXZFMxb
         f758muqYNnvb4aLtbgJMg7+gE4B3HhSKAGYRVp57kx0wCQq7XDhPMG4nfMdkf23f4ouv
         mOvK402Ka+ie5oiUrYTV9bgBNPGKvXrkXueKKPphc1LciwU9R0c1CRCypkNY+ZaDHYvD
         3AgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917930; x=1794522730;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dVk8FlSCk0p0X/zLsBRSgcQPtRAQ4rsApX2OtPYv6mA=;
        b=k7XA/kBp29HKpF7AQUFgr5fjwnhvpcnGajV7nosOsW3/uQj19pHgdHgf5mte89qYZL
         3eXvH+Dt0xzN5aGe6bMJvtbigFxP5EbRMz/4mcDJC9xdK9KqEfLsHovFlPE8mFgyDYUB
         dcu3CA6/1etzlYxGyBXv0qrfYLjLhJxgplCPYGpfadRenYZrvc9RzxCzkVIXvr1gHeoR
         2t6EFz97MXD0JVrkut9hN9KNbNS1GOKgKeTY+vf30FSzcaNBTUNwef3OVjbyT6oMQxGt
         Le2YBzXyVl8B6z1QKOXke0x3i21XY3ZYLLSCz2SJsR+lkh7pggwgVzO7Z1IKvok6IwT1
         qTjA==
X-Forwarded-Encrypted: i=1; AKwUvBz6FkScMREJaFMs4y+AS2A+YF5qKSh6zWc2aKsGznYL4B2IuK6CjGgjpmbo3LbyuN9FT0w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yF2iMogG/yg2Ym1n2qCQtP9BgshNxIdClfwLIaGTJXsWFD+hy
	eURqrClGCZSxpFFbLj6W45xAcCKbAg21BalI5JvL2eE8pA3UzkuzRoYtHWfxNxUg5dCxiRA3tnQ
	JUbARRUrFeuDvsi6rOoflCvlc9VjJwhc=
X-Gm-Gg: AYBFou3gf/QvbqD8gB2Xo7yzuiZRoWhg2yREUZLSZN1hI+oGjoCBWM+d2VJ5lSf5DYM
	cjTwMMgxJlzoiZcjMMLigbqEibLQ72It4EhmdxhX1IhHEOxSNG8Jm2/tYwR6iAXmpQoI+aquOIR
	CBg1rOilhOCI9fMV222B/+KOXOozT/cJl38wFPKGQfyUJrS16BWHNaPO/dhVP/gYJ9sJGvHlcuY
	By8qt+jhxmPci1fNr8TremoQhiBQuVIPiljerER05Oz0NBE49lBApsWN1eVr3XsI/F7jB/ewbug
	5uF5b8zzFbEymeXUiCTUQc2dMaVyjF5aBG3CrgwpbFLVM0XwiyolJ3e30OXaOnIg8f9VHzFbPbP
	c2hceEFnbAtTliwbzIIcAEcpWVavi1gAM5uI190PQEiDxlJg65UNlym2T1qu6YDkgge1LkNPtyF
	GdelIVenkcUR5Pg2GtpqW05Pbwocy5ehK9XA==
X-Received: by 2002:a17:903:2304:b0:2ed:1f0c:d31 with SMTP id
 d9443c01a7336-2ed40e688c7mr9370095ad.59.1793917930400; Thu, 05 Nov 2026
 14:32:10 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <20261028134012.01d52e94@pumpkin> <CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
 <20261030100215.6f8e0d4f@pumpkin> <CAG2KctqdPq6NmK6rB13s2bgM7kP2w4OMMy2hdp_OFMVYYhTnZA@mail.gmail.com>
 <20261104142307.431fc12f@pumpkin> <CAG2KctrY6GmVqsKP+fXYCsL6wDR4zp1kdRd7a7uOdCgg_JcMdQ@mail.gmail.com>
In-Reply-To: <CAG2KctrY6GmVqsKP+fXYCsL6wDR4zp1kdRd7a7uOdCgg_JcMdQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 14:31:58 -0800
X-Gm-Features: AclHuK8BPGpbYIUoL0zJXTIzG60i-gPbL3KKgBgfTHwRc2VAS0UUrPKJVoGciTA
Message-ID: <CAEf4BzbYqbPRPWQU9yM29E+Pr68y+KX0O8whK-36dyH=Zd_udg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Samuel Wu <wusamuel@google.com>
Cc: David Laight <david.laight.linux@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 4:06=E2=80=AFPM Samuel Wu <wusamuel@google.com> wrot=
e:
>
> On Wed, Nov 4, 2026 at 6:23=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 3 Nov 2026 17:14:26 -0800
> > Samuel Wu <wusamuel@google.com> wrote:
> >
> > > On Fri, Oct 30, 2026 at 3:02=E2=80=AFAM David Laight
> > > <david.laight.linux@gmail.com> wrote:
> > > >
> > > > On Thu, 29 Oct 2026 15:05:45 -0700
> > > > Samuel Wu <wusamuel@google.com> wrote:
> > > [...]
> > > > > BY_NAME matches names exactly, like kallsyms_lookup_name(), so th=
ey
> > > > > would be different symbols at different addresses. Please correct=
 me
> > > > > if I'm missing something here!
> > > >
> > > > Only that the user might really want one of the copies.
> > > > Sometimes there is only the copy.
> > >
> > > Good point. I'll have v3 add KALLSYMS_F_PREFIX + pos/next_pos
> > > pagination to cover these. A prefix query for "foo." also finds the
> > > copies when plain foo does not exist (expanded on this in my reply to
> > > Andrii's Oct 30 mail in this thread).
> >
> > I'm busy rebasing my patches - they got stamped all over :-(
> > I should get a v3 that applies by the end of the week.
> >
> > I will add a 'prefix' variant for you.
> > The 'next symbol matches' flag is exactly that (actually it is a
> > this symbol is a duplicate to avoid issues at the start of the array).
> > So in this case that application would always need to read
> > the next symbol (by name).
>
> Thanks, that would be helpful. For my v3, I'll keep the lower_bound()
> approach so the two series stay independent, but I can switch over
> once your series lands, so there is only one search over the name
> table.
>
> > I think it might be more sensible (less pitfalls later on) to return
> > the symbol number - not that of the next one.
>
> What pitfalls were you anticipating? If the current symbol's position
> is returned, userspace needs another ioctl() call and an -ENOENT
> check, to learn that there are no more matches. Alternatively,
> returning the next position means every call pays for a look-ahead,
> which for an unfiltered query walks the module symbols even when
> userspace only wants the first match.
>
> Andrii, do you have a preference between the two?

no perfect solution, but given you don't always care about duplicates,
I'd probably return the found symbol's position, which can be used for
further pagination (if necessary, user just does +1). so, let's return
current symbol index, and have way to say "find by name/prefix 'blah'
starting from position X", where X will be previous symbol index + 1?

but tbh, you have to write some code on how to do these "typical"
queries and see whether API is convenient and meaningful, hard to know
upfront what makes the most sense
