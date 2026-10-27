Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793134330;
	b=LY8aQPiYElZWlWHW6td7p3EvVFhdeggDKOjLxwUGob2cZnM0rFrxlRGFyQWLAoMRRlWm
	 DY0QdFEjJfBRxJLKliwHftq1zP6LCxwqq/17k+vqM81OagAXKLS7Suo5ZPVS7emKNtK83
	 e84MR/Pcm84aAY+5vPFMYEfdUDyOSPXXETFdRAS0R6BA72nmF/dome32mtY52koV68dz8
	 mZd3ViBPRSYXdmd8Dj29A9gLP1mAUl3QAFh6xR2j1bzKSiMgOQq8t+HHkW4jqImCCkQGh
	 7R5VXwxjTlsN9bfnjBNmvMptfxQ40HLZQbYCclGCS23yIF40OXHI4d2C9EocY2k+MTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=7GDvLuXXpL52b0ovddXSOSszIk8p5cQntkA2ZQ4tYQc=;
	b=XabrPXEdJOJKD+isvefV0WtyPTlT0sJr/3ekGf33ODlpNXST7CsMuhVuO0fe50E3jKF7
	 vmxO3ZW2yAk0p/DAqyfMZtRMCq7a+ve4EXrdxBjnu1JWSxLD1s3NeE5qtZG3hB0KnjuZG
	 L0UpfAiaE6EiGOr4NPGo2QiQ0tGutY6q3UCqoBREQ3JdiuwJoHeEhRc9VuAfVsFUhVy1H
	 +U+QxGhIJMSouZc8rpGRRJx/a/dfbJA+rdtIj4y/sh1Y+lMw6nAKBpH6SvTIe1bQEi+f6
	 +jECBlwN/cEZWBiGNVm1UKb38w9VJ4064h4RWMjqEXjBFHK+nh84eax+ePn99PBmm5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b="xTkyCu+/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D0606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 20:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 134D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=xTkyCu+/
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6798eb0d13fso438445d50.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793134329; cv=none;
        d=google.com; s=arc-20260327;
        b=U2NBXAQKe0uZnN944HzFHTUYqBhvrglTUW5RRHqyY3G92QNAEscSUXVFBSKrRu6jDk
         atd9EzJGt7sh3xX0jpKWeNOYh1jpNeU2v/FsCWikGFkyY5Jf2u0OrMKtaiNVIJiAJ1La
         1VtXJg8DuFcYlfQ31zlHula8EkrmGuEcK0iPPfZ0doL+i2n4rF6EwhNqFRyyIl6rT1+w
         zwoexF6wQWQBhNxG+5FcFkoWTDf8vBvBxxA87H+9oL98SBy87aXY+tGb1Jd1SSsfzc9W
         FyqQb+TLuDr+P34Mth+jE9K922t6J/SxWPjlKS6KvBd9rAMsoVjGTe12x/uojxBj9HFQ
         +IIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7GDvLuXXpL52b0ovddXSOSszIk8p5cQntkA2ZQ4tYQc=;
        fh=GsizxCaGQ2nVZN5bHfNu+gnasnbmBAOTZ+FBDFs+xqE=;
        b=b15rOP1el2S888wFMX1njROBKFKJ6ee9r0cYRk1yZ7EvCLMVxoO/tIcXxeCYHH4KC2
         m8m7m8pVVKQFNhKA81vjFg0gjrK8ZRAJfW/GIoGFbGNtPST7YxMBWZjrQMETirFoOVH1
         NfOkm7Q7avyMXuspF3m1B6p3YKHRfMPW8Glg6AcNhDAnCJS0WTcdUNyRS/e2aH6KERkH
         nQSAb7Y75eIi+0h38I+Y0c25mNO/IkfAd/FBdTMybNBgOVmYLu9Ol7/D4OnLL4Q3Dvle
         amC827pHLBdjaMfOE4Ar5BmNr44UmPFN4BcaXPRZn/conZPRn0z2jyuPMmPuoQtIkG2c
         Jb8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793134329; x=1793739129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7GDvLuXXpL52b0ovddXSOSszIk8p5cQntkA2ZQ4tYQc=;
        b=xTkyCu+/mJweMOMoY0lKnFidgjQG5vXGR1Xcm07VMm5w8NsAV+wQHnjdms5x5lVv3X
         o+PGvRUqEBblT3Sq6S7BopDE4QE2pWQw66g/7BwnxLshKZFKAnXEy6ecLJZy0ymbFNpI
         +25Cq0UWcsgSKMhtaykpqfKdoGS3vvGksWCo8hJHJL5Vq7I0k/qT0U5aM6uwAJ+7MU5+
         2tO+1mE/OBNVlhNqpsgXNnz9RybX+1KTcU5AJfiYLl6weM2pprhT23nHNoErcKfByI6c
         PmTUCYp22bY3KJx5E11MbzY+6HcXuXFZsDW9m4O2Tjp0vC0I5nixeiFGNC6QFvyGIKsG
         HnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793134329; x=1793739129;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7GDvLuXXpL52b0ovddXSOSszIk8p5cQntkA2ZQ4tYQc=;
        b=x5/o6ZdsmqUHnK1FR6C8eKZntNZF7pkiu+vqffC6HTe9rgfCa2qQMaWjV82OYQ/vVX
         M3jQylYoJCYeFnX+gcPIIp0tEvol2gtjgTaGQ8X0Yvng3KKKMx8d9YN+8RQrzygESz+T
         YoWpjqAqCgQU30dWHJuPUoUU9aNAEEialA1QR2NDOy+xSpAtF29P1F0BvoKESzEadJ8p
         MwoMcBH7EUBlQApJgIV/2oaFU3aWEgrZxascRh//ZvBV5QrjOX/Cw9J0NdLnCO+TSQ0Q
         i1dD+Loj6K5szVRQBVK2hywqHlP8wXJpW6GGZA22DPeUfv2pC51iXVoCp8Bxk0EpLPLd
         xDvw==
X-Gm-Message-State: AFq9FYJ8RUq8Bj0J2Lu2EXvTHF39TUFRf+2LvYVkK7SufpJ2B/nek2AR
	uOPsVgBhKQagwcqjb/Ga3EtU26OM2bBcwrPmUrQSPXaHP3C7GYiucEMG1/PAdCAbcP5XiuZljiw
	9Fr9Ajfzj+m3g5ZlgL6m7UiCbT9OaR1UvvDASO9WR0w==
X-Gm-Gg: AYBFou2OkXxMP0E/73Ljkw5MpQUAUqJ3xr+dcZPIZ9ZkOWqhmcMMwJNltcClu/Uufl+
	JRp1N9GPDJgW3ZDInzY9hv7zQYqvJJgVli+cIVle0fEjMDk9u3vUQtp3D7mm8sJvlSc1XLSOrf8
	Rc2sBb1uh0Bbjz0E/uqTCYZEdDU4anui2z+7QY6bJVfp7q8OZmouE21JQVV+7GxEWjmSUGlKL/l
	fYvE8NUj3KTrFnOsXZeLlh4snfT7xgAG2/hnZSa0OtIoS2zH/DXZgwhO4VFZInfrc6fQFwGsiwr
	gNp5vtM7DWH2MUR6mz0cJ4oltRQvYwvqNfuYLAHr32ghNvM9Q4CJxPpFyrqg98gXurgya8fGwE+
	BY/7atcVZbrHwZBxtZQVxWnKjRjaxo2DTfk6wdndE0RuSgLXra56n
X-Received: by 2002:a05:690e:4391:b0:677:b49d:2fee with SMTP id
 956f58d0204a3-67a7bd0ee4emr396093d50.115.1793134328987; Tue, 27 Oct 2026
 13:52:08 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023002056.6647-1-emil@etsalapatis.com> <20261023002056.6647-7-emil@etsalapatis.com>
 <DMFVT5P2IT5V.3U8JXPSPQR8CG@gmail.com>
In-Reply-To: <DMFVT5P2IT5V.3U8JXPSPQR8CG@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 27 Oct 2026 20:51:57 +0000
X-Gm-Features: AclHuK---VK51LUAmKJ9sbG1KDkYhg628BzXX7M1QzVlyIbivEcljk_xmQvtj_Q
Message-ID: <CABFh=a5LTwnh0qZECGbiJpJwYSOLmyETfpotVc_VCy2ZvUBYkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] selftests/bpf: libarena: Add a transfer cache
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 22, 2026 at 05:20 PM Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
> > When the array is full or its lock is busy, spill the local batch to th=
e
> > buddy allocator with buddy_free_bulk(), so the next frees fit in the
> > local cache instead of each taking the transfer and buddy locks. NMI
>
> My earlier feedback must have been lost:
> Pls add the buddy_free_bulk() spill in patch 5, next to the batched
> refill. Keep only the transfer array in this patch, on top of it.
> As posted buddy_cache_spill() arrives here with both branches. Until this
> patch a free into a full cache takes the buddy lock for every object.
>

Hi Alexei,

Yes I must have missed that, sorry about that. I will address and respin.

> Also your libarena compatibility fixups series changes the same lines of
> buddy.h, it seems. I suspect you want them to go first and rebase this on=
e.
>

Yes, the plan is to first merge the compatibility fixes then make the large=
r
change. I'll respin on top once we handle the compatibility patch.

> pw-bot: cr
