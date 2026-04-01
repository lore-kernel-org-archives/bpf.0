Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53531376BD3
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058169; cv=pass; b=Fru8Q1BEzpYAewSMyiLAa1CLXaD0toa4saTQMImZTITsjaA74KVEpu7cn9oHtbfv6ozIqpr+LZQE5M/MQdBC0PtZ4bx/+LYj9MbNCHEKfOqJP8xPLk7HtBpf6wfVdiyqinqbtonF7NdL39Xrz8EhKGn4KEnLAAd51sw2gtiPqbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058169; c=relaxed/simple;
	bh=kX98sxG++45eJbC7brkRJQm2nK+Yw6PFaAP4I6JBXf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdDDOcq4J6kMO0laoyR1V4XYnaf0gdXJWxVY9HtM6fm0x/IQSGScZMRkX8D3rcmU62WbDiCZ5Ga14KgPs50J2gpxQKZ9xtdMl8d5oec66u2xwaaz813WLCCeS1bFJAYYaVGNa8ZJMJD0MsY+hgMcpsRqtlEOZ3Mo7nc38VKMIdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5u/lfRa; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5u/lfRa"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4887d4c6234so24195165e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 08:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775058167; cv=none;
        d=google.com; s=arc-20240605;
        b=jcRSbyFbqyMl4SAAMNLHrNePwge0y4VTV+fUjHkwY58Cmc833ys/PbVKbFaDTYoPvA
         VgvW/WwPrQV/Hagq1wEKPBlX9LEGzWkoCf4XeGMwYLskQqjykt7uwwiSsh97f77q38s8
         wdIKOaVCuZcOzMmalahP+k9wG6UrG4hA9OuNFuDkIfiAh0vRI1yCDjwuIQ+U5VDy9dFe
         phoMLO0TL+ba+pTCQxhX8LG2mJgXYIFtevfiBW3sXtVGR/eFZqqbFGG/DKGKJtLuQMwZ
         yva1goe2MtFO/ytw9fsvxvNNoftzKqldXqS8Ate/vBbmq0Qh5gttjPmXYIvPu6WXbCr6
         0bgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kX98sxG++45eJbC7brkRJQm2nK+Yw6PFaAP4I6JBXf0=;
        fh=qqv4dVk/6fgOZLiBoXqlNfpz0ftqMW1QU8bcbRd7o84=;
        b=cQh+z8AMdNq4cdSE/OPrQGSTpU2obnYQeEIrGZaEcZmCbIscJpjfsu0rpO3ACDXc+9
         qyHIejaBfqCAbHho8fXeshjfQweNQcfZzlQMJCjTkeG91gKSTJ16JNiDY61Z2Pdh47YX
         5Ky2jObapa02FDRJ8PvFri/U/W6efxUnjVCRkL0fuY881XkF7rz7BectAk8ObdrbbwtF
         LbARWBdcKGpph/WgZ/Is1fZrgLl4MM7W+Jb39Ocjh2sCbLyyJHL3o7MNHEyP8blaJJ/p
         /A81SrcEhD4ktz7jtk/jQuVnvB9MG4c/6ZDEVghIEMC2XzBMnK/nJjJTh+oCZK8pMEWX
         3zUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775058167; x=1775662967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kX98sxG++45eJbC7brkRJQm2nK+Yw6PFaAP4I6JBXf0=;
        b=s5u/lfRa7pNfVjROQAkdzmTTMJkQND1f7nvbG27ghj1dXU1kQK9lwiiIK/vCRNE/ku
         jb3EWVVAPoulH0GeOEx8jSMf1Z6J1+jDiUbwEKe3jg0djKsYgIXqdCwCs2uiTJQPiGUN
         MyLMqH/1615z2XSJJFujt0JraMuMabiuTvSInHXhQ13Wjca/nrz/sYIi7RuIb2EpM9oa
         8IDc/Swz3dOTIbqCA3/p0FNx4cgJI7p1a1Ba6FNNG03QRtqm/+waNENrwxXm0p5E6OIP
         g1d9zb/vAasaUEEbjoaTLpp5MVd+0JQ7fUae4J1Nf+LRn6uDDEkUvoJ0B9WIVztISk3p
         kRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775058167; x=1775662967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX98sxG++45eJbC7brkRJQm2nK+Yw6PFaAP4I6JBXf0=;
        b=DGDs8Mf6+bw00+086QZbqWd/Txa/VfRRW0IriU/pcx3KymQsOOjjmhnq68zWccMKND
         vtkO63ssLxoxqv3/EyIgFJmX+HcG8Udo4zuW+Cyf2o7Idk/AAp2KTzc+YKdnq9gSG/XI
         uSGSLrFjgEHWz3SJftWDa3jjpPnh/cFJc8pfCI0ojRaHYTgoFPAl6M/gOb0Fz8/YjIxc
         sXewREttZ3vPnhrmOY3QTMhHbWXeRHensHKDzHwTBt8EwjJuJQzZwg1PWPVhtmHs08iy
         DVOW6tY8WFgY26Up3VyVmjzWC1hwaxjXk42XyUa5rMOpALeW/OFhzOVbDVeKYTS+vW/A
         Gi4g==
X-Gm-Message-State: AOJu0YzDKVy2HbiPW5SHWLJSruxl+bNlFHYtcphmIDP4Jr2qqvR0gaiL
	o//z9Xdx/7vmv/4EW+i1TmOxmVKEKOotOxZLnW0oa0A8bfcTNTo4zhl3ZWq252kgzlYkHUJfn0V
	eLeCx5geItty9/6C5I26N9eCgdd/jj2s=
X-Gm-Gg: ATEYQzwuTId/pfQv2mHTBZGGtksXs5pUviK0cDhgATunJOd7DZFnudKfMZcztO5GXjq
	MHvEUeMf1kh59P8l1dV24vuGV7872jaZxkkRZoxViWi1SgB2bi5PZI4ZEQy1/0savszXVIpzJCA
	fJKCGCuonNp1S9Twwgmh9dMe72vECPTSZQ9Hh+aOzZm4Ayg12zNg03dX+Yifs2l4cE0mwxCqPB4
	nM6qAK5qf079neQLRJ22wL9T9P9ZyJ2LWh8NdOAGPQ+v4Rq3/6uckWj10Le13VEkH1RhxAMYa2m
	kyejnP9aAL41vx6X3ua/nHH22vJXdWxUW4X+IrUPy6PzUctOJVEoHRK/olk=
X-Received: by 2002:a05:600c:c04a:b0:485:5981:1423 with SMTP id
 5b1f17b1804b1-4888355e82bmr53890345e9.3.1775058166591; Wed, 01 Apr 2026
 08:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401-bpf_map_torn_writes-v1-0-782d071c55e7@meta.com>
 <CAP01T74g_=jSJTNzS41VzK81n3kwkM8EOY=Xv=t0yM5b1-+Z4w@mail.gmail.com> <c83b9eac-f739-4743-af84-4bc54c311d53@gmail.com>
In-Reply-To: <c83b9eac-f739-4743-af84-4bc54c311d53@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 1 Apr 2026 17:42:10 +0200
X-Gm-Features: AQROBzA31jyGYjl13WuCfxoipYrJBijTCDwzFk1gGDvt1QN2vhoICk27OV5rL2A
Message-ID: <CAP01T77X_PjfD0jFhMpcjn+sF2q1-xDmNbgHFU-xotwp4RhsAw@mail.gmail.com>
Subject: Re: [PATCH 0/2] bpf: Fix torn writes in non-prealloc htab with BPF_F_LOCK
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Aaron Esau <aaron1esau@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 17:33, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> On 4/1/26 4:21 PM, Kumar Kartikeya Dwivedi wrote:
> > On Wed, 1 Apr 2026 at 15:51, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >> A torn write issue was reported in htab_map_update_elem() with
> >> BPF_F_LOCK on hash maps. The BPF_F_LOCK fast path performs
> >> a lockless lookup and copies the value under the element's embedded
> >> spin_lock. A concurrent delete can free the element via
> >> bpf_mem_cache_free(), which allows immediate reuse. When
> >> alloc_htab_elem() recycles the same memory, it writes the value with
> >> plain copy_map_value() without taking the spin_lock, racing with the
> >> stale lock holder and producing torn writes.
> >>
> >> Patch 1 fixes alloc_htab_elem() to use copy_map_value_locked() when
> >> BPF_F_LOCK is set.
> >>
> >> Patch 2 adds a selftest that reliably detects the torn writes on an
> >> unpatched kernel.
> >>
> >> Reported-by: Aaron Esau <aaron1esau@gmail.com>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >
> > The fix looks correct, but I think the test needs more work.
> >
> > After reverting the test, it continues to pass for me the majority of
> > the times, so it's not deterministic. If a fix is made in the kernel,
> > it is essentially best-effort, so we cannot be confident whether
> > trials that didn't produce a fault were due to our inability to
> > reproduce the race or because the fix was correct.
> >
> > To be fair, I am not sure we can construct a deterministic test
> > without controlling thread schedules, so it might not be worth it and
> > we can continue with the best-effort test you have. It definitely has
> > some value, since I don't observe any failures on repeated runs but
> > can observe some without the fix.
> >
> > One way I considered strengthening the current test is to pin threads
> > to two CPUs. One thread will constantly lookup and verify that all
> > bytes are the same. This will use BPF_F_LOCK, ensuring serialization.
> > On the other CPU we constantly do delete + update with BPF_F_LOCK, and
> > keep changing the byte sequence we update. So aaaa -> bbbb -> cccc,
> > etc. Set max_entries = 1 so that we ensure the same element keeps
> > getting recycled constantly. I didn't try this but it might improve
> > the chances of success, esp. if the map value is big, such that the
> > window of reading and writing on either side can be long. We might
> > also want to do repeat = 1000 or more and then handle this sequence
> > copy in a tight loop inside the kernel in the program itself. This
> > ensures that precious time on either side is not lost bouncing back
> > and forth from user space to the kernel due to bpf_prog_test_run().
> >
> > Thoughts?
> >
>
> Yes, the test does not fail 100% of time on the baseline, but this
> particular implementation fails most of the time for me (like 9-8 out of
> 10). It passes consistently with the fix.
>
> Yes, probably pinning threads and making map value bigger may increase
> failure rate on the baseline. Thanks for checking the test on your setup
> and suggestions, I'm happy to implement them for the next version.
>

Maybe try pinning and a bigger map value, but if that doesn't help
much, I think the current thing is fine to go ahead with. The fix
looks correct and it wouldn't make sense to waste more time on it.

> >> [...]
> >>
>
