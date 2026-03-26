Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F056338592
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531077; cv=pass; b=sO68QIXn6LeowL3WlfmDPrcrRBugGClHdu1VzAHG2mL5syLoDkekjyjUnyolaEvFhoOe8Gn/Q32WR4fx/OHWHzxrlM5GZwSy4aBzRPSuNcOwW3r6Cu7UhV/1LjjINDYTVxigWvgKUKtyzPEupfkTb6fqPYecDKOtkrdfui4KRpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531077; c=relaxed/simple;
	bh=eLGJGgyu1TzFKa4K9rRTcQH2bxVNG7BkcbCGsEXt+/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sm6K/iRJ8zenL97Fx3UcfMuzsWLB1qG9WMGzFD3e5M3t/0kfyOCUZsaZMnKARJok4wl+b/u5Grbbg7hrloU/tjaXGQEE/W3VWHg14nt+cuHiRsTIY8SYukWZB0JZoAdbYxngB36uXN4SgW/FXqxzPMNlCiIiTmxIX81QaTSSnA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNapUVn1; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNapUVn1"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66b0f489f3aso123106a12.3
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 06:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774531074; cv=none;
        d=google.com; s=arc-20240605;
        b=JD/tCJGxrXZon0TBESOtGfA1/SMRh0UcqrqDMFgrQWTLB6UZeP1/CWXYIlR1iV2Wtv
         7MwKCJuB4xjpIKLv1I9gAEV9k4JHy5ZqHOiT4qO5uX3+flygQ0cxH3LYNAdUdhG9xrE4
         Mf9JfHMAg8NI/d42EhMniAO4tFZsLkO7V3oq1/v5LXZzfDlYnATpHmzBynUKuWJEHu4r
         vqFoS+VZlOOSPrvy/vLG777MfC6zQZBvCZT1z4BErORqKUis2NeVJXqrpto2deQFxdZ/
         DKZ1H91Vcu0G1svP6REQSSj1d92tvauB20s9b+lAB5JYc5lwIkVWIc+mrEtsLEFg71NZ
         K1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E9GTDCVwMeGBsczVO/cCzPw62IVDmrrWhei3TdiGhZ0=;
        fh=8mcoUJlAmM7/itAO+bolI9SAetKBC6s4i25nvlguGHM=;
        b=inoJhNtCaae9qVbq1kP0fSefSHOfad+0hSNGtF2tVvLI20mXoWSSMAQGq4bbjHp0tY
         amJuygdTywo0gwsIMuXUmB/WdT7IBg2w5uIrxKU1NmOLeJPyO6m+At/zfEsVi9f/oTVP
         PhYtUATqxToTm5+hfnuKddMMsFgl9QGg3uDUJyYAYYIfGT+u57gqkuCzD/RUmE5y2Ua+
         h0c4RrO0ZaczOYnuhvP68Y8A98wBEN0ZChbe43JW0dnhyuSwVpPaf3lJNwx9CFCIufy/
         dzKHwgl1RdQUJiCkKp/GBKn04ClZJPytSWoLElxUzouo8t/PL+8Z8HymRHAkIkZ6+FJy
         j9tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774531074; x=1775135874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9GTDCVwMeGBsczVO/cCzPw62IVDmrrWhei3TdiGhZ0=;
        b=rNapUVn1b8QWgv7/O+n2EEPXLgyneLd43RQwKFf1Ul8mJ+ztaiCA0p9rFHWLEkRIfd
         WrtfZlrzyuIgYHejRbeagp6xMfFjtgpmvxMx73XaziiUIy/te9OfeEpRSL/c63TVMb5y
         +Oxo9YA8sKph1gZWFrCcxc4stHkH9nPGjNvv6fNZhpdx0DE8k8d9ff4y3h/Gh5Rtgn/Y
         cfN+6GIZj8UCy9+wHwXw9jefyxZY45vq+ChTqP6/gAjQ5qtB89ACGe4CUBBOtUJfg35g
         U8b4trfjz9ivoUoKNuFl2bqpZcirsnSawz6S+l9KM2oT2uzmcCXeF/LU6MkHscNYwglI
         8RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774531074; x=1775135874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E9GTDCVwMeGBsczVO/cCzPw62IVDmrrWhei3TdiGhZ0=;
        b=D6hOoxsWYZWMp6oUeefGglmU8rwjgk76jwjseDM9dWmBHPWCR6Hg2hg5IEXs5VkolA
         3B5TXIybE/k/KBomti4KZ8yjheiC9t9AtkJIhkcp9YGq6FkdRDuONymfKd5vxk34IBo2
         UB0uv3dQPvYfUC3p+zNR+w13ZrdF8PSZNZGCNONaE9PrTaUnRi9iqn63IXsTuQQtkbI5
         l88jcK6znffofO6flk78rB5qFhDpoUzJnLY3ryNiQPfnOrS/kBJZGOmcBeXrgvA3aMMB
         kRXXJedEbNMHn3dGt7LDwLx4ylhQGDtVSzd8lkb725kwGybLiRkFNSot8YqnJu0fEkqt
         /3xA==
X-Forwarded-Encrypted: i=1; AJvYcCW1CgQGHMPUTHh77HjErwDk73D3SIX2Ac1GO1oWINnh3Buej51IGRN0jCbkNhITC0V9oyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKAaBIPQqeDtIr3AXd4qdI9KbuWFRfbSL5ZXSXoQnh07JzezCA
	0RX8mTFrxOm9kFTBXJYH5LjNE5e09jVQOfmFAsMA3TSyTQsDtGKyXmJvdAlg3+Sc9bK9W7sy1rJ
	y4mVEZ4QI/M0tdZvwnB6xziA/epWu08I=
X-Gm-Gg: ATEYQzyi7zqTzaS0k/pjPTt45Df/3oNXYw+Y+mRnFfff0vXh73y7v3ME/mDDZqTbPmt
	w4DX+xy8SoahDtHwQxZsH7pWkV530f7/SgwSTAex9OAF0Aczs1GIuuol95wiT3e7qdO+kAoUExT
	XeArNvrEvS6SEk8HUGmBgRgKc50xcseYPI+VqbqlSukyqOT27v7fq/2DYX8jfNH1Rq7sZ9LSmh3
	dve6SgK1AQsBsDGdQdN4sAB8XbGVWApyAuP5xF5O1Mm/9XkcnDaSrT9TKASjuYCc0ONieDV7DWz
	6QIU3wW9vf7epGZefNrMLPCwsxIJ07VwCdYgKawM
X-Received: by 2002:a05:6402:2116:b0:667:7fcb:3a2c with SMTP id
 4fb4d7f45d1cf-66a826b30b2mr5290589a12.24.1774531074263; Thu, 26 Mar 2026
 06:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <CAMgjq7A01C+wyHxytZfVFVvaJ+gUNqkKvYN61_Peo911YaBHOw@mail.gmail.com> <f617acf0-6bb6-4ea0-85c2-d6f377a2a574@lucifer.local>
In-Reply-To: <f617acf0-6bb6-4ea0-85c2-d6f377a2a574@lucifer.local>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 26 Mar 2026 21:17:17 +0800
X-Gm-Features: AQROBzAswvzSo_XDIOMliFjGAdPtY_-lxSRrG10NjtiUJ7upcypDaYx0cmhdW7U
Message-ID: <CAMgjq7BfuYsxhhf-XqKH4B622NGP-9bmriSP2eMiygH9ZJMANw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim (reclaim_ext)
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	lsf-pc@lists.linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
	Gregory Price <gourry@gourry.net>, Barry Song <21cnbao@gmail.com>, 
	David Stevens <stevensd@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	David Rientjes <rientjes@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	wangzicheng <wangzicheng@honor.com>, "T . J . Mercier" <tjmercier@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Suren Baghdasaryan <surenb@google.com>, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 8:31=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> +cc Gregory
>
> On Thu, Mar 26, 2026 at 08:06:13PM +0800, Kairui Song wrote:
> > On Thu, Mar 26, 2026 at 10:05=E2=80=AFAM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed, 25 Mar 2026 14:06:37 -0700 Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
> > >
> > > > We should unify both algorithms into a single code path.
> > >
> > > I'm here to ask the questions which others fear will sound dumb.
> > >
> > > Is it indeed the plan to maintain both implementations?  I thought th=
e
> > > long-term ambition was to knock MGLRU into shape and to drop the lega=
cy LRU?
> >
> > I personally also agree on that, so far I'm not aware of any major
> > issues with MGLRU except some corner cases that are not hard to fix.
> > Once these are done, I don't see the need for more complexity.
>
> Well... :)
>
> What about the issues Gregory raised here?
>
> https://lore.kernel.org/linux-mm/aaXM7xNSJaJBsety@gourry-fedora-PF4VCD3F/

Hi,

Thanks for linking Gregory's mail.

I'm not quite sure I fully get what the concern is, I'll try to
address the main points I see. Regarding the bi-modal distributions,
it's very workload-dependent, and the reclamation still performs well
with that distributions. So I think that's not really a problem?

The heuristics are a bit confusing and intertwined (gen number as
flags for atomic update and avoid LRU lock, tight coupling with
generational aging, etc.), decoupling them cleanly without hurting
performance is tricky, and the current approach has worked
dramatically well. Cleanup the code structure might be helpful?

Many distros have been running MGLRU by default for years now and the
feedback (plus our own production experience) has been very positive.
There are indeed some known rough edges, under-protected file cache,
ineffective swappiness, flag usage, etc. some of which I listed here
[1]. I believe they're all fixable, and once addressed MGLRU should be
a solid base.

Right, I realized after re-reading that some of these really are not
really easy to fix or improve... sorry for my earlier reply, guess I'm
too sleepy today and not thinking clearly :P, my apologies.

[1] https://lore.kernel.org/linux-mm/CAMgjq7BoekNjg-Ra3C8M7=3D8=3D75su38w=
=3DHD782T5E_cxyeCeH_g@mail.gmail.com/
