Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7454F7D3F9
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 21:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277907; cv=none; b=dSkUIwHBeq5lLaKqJeCtye45W82Uc4nvBX1v071QeFYGYf6ylLsQoIFps0UWbjAxmVdTnL7Cv/WUv//Lc5m8XhIVoil4k2Czrb81TgR/24PKiV+DeLLWK0qiAYu2DR5t1J8rxJrd9fHIj80VEw0ctCzrNJf5vKEYJcU1f3XrTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277907; c=relaxed/simple;
	bh=T3kzBY9GfAnM+q51fC0moJWtnEIIEoGiMeFr1W4OVzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApA5P4156KTp9Hq9YJ+oDZX59h+9Au71/uIjN9cn8m84xHE8PynVjPLBAexfPpVll5+/nV4+CCnrE3PAc37IQoIb8+stG3DGw8m0lsJtXeKvrDWT0sbGcYxZWcJ0ez9AuDiWxujZyyGqiCRNIfJA50RhyqHOQ0KOCVwRnx8RUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C5qaRkd4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C5qaRkd4"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51320ca689aso5294020e87.2
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710277903; x=1710882703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FBYUhCU7Eheux/pd0BVM48w4mv0asJqGomAvUXs2qr4=;
        b=C5qaRkd40METKA5X49zd7Yl/tligf6NaqtTUaLTx1BvXbPiILhVJkDdx8Z3NZywZqN
         uqXUvItTsRu2of/PRd3S2u0NZoPtR2w9X4d2/oeYU5kTfXA5L24l4zB9AWi7McdRc7S+
         zLtDoztvdJnFvE53jEh+V61fCtuyfjnjr6lng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710277903; x=1710882703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBYUhCU7Eheux/pd0BVM48w4mv0asJqGomAvUXs2qr4=;
        b=ZqCduIU93ajmukbzWvvHgZhLA4c0Rhw4hhhYdK8DXm25TF9d6wB4MEXgN3mAzo0SBU
         DM/iq6P7rSbim1ZN5L0vS90ON5T2Ql9+WBi5u9w/rZILdC6ssh0m8uGPTzzCtRvDDjvk
         FTgIZwQnvxVuN27nrc4tUj2ydcgj51N2uv1u6jbCHaq5LKR1v17NOjCcYeULkgFzsBN5
         plWNWydeJITtkfN8Z/PH9rFWgJC/HCKRx3ozHn7OQcY2tEIOTVhQwYFSdAAChdZeaQ/W
         iVSAOmOAtsca25Ijt5sq98qDJpl782HQb96hPgkkYVqRHWlZPcXRW59VP7msUox8XpLd
         rNHg==
X-Forwarded-Encrypted: i=1; AJvYcCXVvnp0z+s6Cc4wqDQBLfQrIUHaj8nOuzy3ZH4iKTu0EBRAP/UKGx3KNk1IXxRPt6S6fEC5A9s8RRzuYgeH5xcUHj2S
X-Gm-Message-State: AOJu0YwmSmiPmKz1DRsLJbCc7JS5CDlvl1LsK1a0u17L1BnGuXeuPXxj
	6O/tOygAjrGdOkH2WMRzXihWTB/zqGXucoNdRpLrLXLN7blly6qwmd8bQDqlIcQYhVoyZfyVF6J
	eStIeAg==
X-Google-Smtp-Source: AGHT+IHqVsM1KHik5Ny8S3YyBZvr6nGkaATxEUX0okbDVwOojNV9ZXe3ILBxsx9lyO17Q7DPCSslnA==
X-Received: by 2002:a05:6512:3ed:b0:513:58a1:f4fd with SMTP id n13-20020a05651203ed00b0051358a1f4fdmr6104920lfq.25.1710277903528;
        Tue, 12 Mar 2024 14:11:43 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id qy25-20020a170907689900b00a464d16b7e2sm433210ejc.86.2024.03.12.14.11.41
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:11:41 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44ad785a44so597768466b.3
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 14:11:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKFN2ereX71Juvg9iDIGMtmurf/HymUjM3IjPRb94tbziA+PJsZ9fEHXCbXl673/YjVq/nS1dFL4yHEBYezwpedqi8
X-Received: by 2002:a17:906:e0f:b0:a45:da1:9364 with SMTP id
 l15-20020a1709060e0f00b00a450da19364mr6434203eji.19.1710277901356; Tue, 12
 Mar 2024 14:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312042504.1835743-1-kuba@kernel.org> <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
 <20240312133427.1a744844@kernel.org> <20240312134739.248e6bd3@kernel.org>
In-Reply-To: <20240312134739.248e6bd3@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 14:11:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
Message-ID: <CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.9
To: Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 13:47, Jakub Kicinski <kuba@kernel.org> wrote:
>
> With your tree as of 65d287c7eb1d it gets to prompt but dies soon after
> when prod services kick in (dunno what rpm Kdump does but says iocost
> so adding Tejun):

Both of your traces are timers that seem to either lock up in ioc_now():

   https://lore.kernel.org/all/20240312133427.1a744844@kernel.org/

and now it looks like ioc_timer_fn():

  https://lore.kernel.org/all/20240312134739.248e6bd3@kernel.org/

But in neither case does it actually look like it's a lockup on a *lock*.

IOW, the NMI isn't happening on some spin_lock sequence or anything like that.

Yes, ioc_now() could have been looping on the seq read-lock if the
sequence number was odd. But the writers do seem to be done with
interrupts disabled, plus then you wouldn't have this lockup in
ioc_timer_fn, so it's probably not that.

And yes, ioc_timer_fn() does take locks, but again, that doesn't seem
to be where it is hanging.

So it smells like it's an endless loop in ioc_timer_fn() to me, or
perhaps retriggering the timer itself infinitely.

Which would then explain both of those traces (that endless loop would
call ioc_now() as part of it).

The blk-iocost.c code itself hasn't changed, but the timer code has
gone through big changes.

That said, there's a more blk-related change: da4c8c3d0975 ("block:
cache current nsec time in struct blk_plug").

*And* your second dump is from that

        period_vtime = now.vnow - ioc->period_at_vtime;
        if (WARN_ON_ONCE(!period_vtime)) {

so it smells like the blk-iocost code is just completely confused by
the time caching. Jens?

Jakub, it might be worth seeing if just reverting that commit
da4c8c3d0975 makes the problem go away. Otherwise a bisect might be
needed...

          Linus
