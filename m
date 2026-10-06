Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DE3859D3
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324426; cv=none; b=QnEVDW635aSrBVMOmQZrNgkEWTCwfdlmJ6hOSzyU7aUDv1BSXIt2tQaFAAqMfrWHUjATM0y2lywxlHUd86vWzG+75xWRRQOQymoZlR00GjfD5+fYgRUqvivmnibXrgFDV6OGULJN4wzdPlIEQ8bHd8Y0ZCO1aYIlEU28nzjO/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324426; c=relaxed/simple;
	bh=oLowqW4kTT1TNYX2A/gZw2hQoXAMth+pOFnbIsMCdaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ6sWq3kQE/iBfWjf0xjxorFtaHlcJaa45TErwvV7a+mmkYSk5tdvXYmafURVa5uP/ai79Amm9eFwKZoxB4WDIFzUMqrD83mXbkwqXizF1T/kTNXTqWHhCywqkYjRdVR/Ix8KnlSnvBVjKvz1LY5ht7JuEhBWaIwauuq/rsHRRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IG54vHzI; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG54vHzI"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a854dffb5dso509952a91.1
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324423; x=1791929223; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OGTI2frF8RrBIeT4/ePn5rUSGsgZXEb1V8OC+n96/mk=;
        b=IG54vHzImmmbr4Y8m8Xp5wLUFkdbL5HQMXRvk5+2kzRzDWQ1XYvbucB8zomHoFZEyN
         2cxY0CzNuGA/CTE7qWYzflmyq43AaCW+NGmUJZEjahy8uJX4DMn8yRL02+S1WCj6I29r
         oCH0qxtCxvtbPBEGASxKTFqOnVuvtZKE060GVzbEkHeV7XMKByEcSA7yhChHP7mausVe
         mMcE9lLNvuBbc8q4bFyH9hcPnOlH3iDPtcPDk27UpjAFoGu5qhCt7bdUmkq5bW0tPUoe
         de40QR6/vQG6nelaYJ7WdooNLi+cI4AV7wpOmmvqApwCeteBDHcWTV7iX6Nydt+h4y6F
         n8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324423; x=1791929223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OGTI2frF8RrBIeT4/ePn5rUSGsgZXEb1V8OC+n96/mk=;
        b=ToFNh9Ts1hKrnIDRSCVzN5nmp20KHObRwj0KQ6nOuGNKa7c4LXI9sNqqtOls8YIOLZ
         lpDeLD+jzSICl5LeEIfcha3Ft3cnFcNF6Vb5Jf22v1Q4gg+vHGGYfxwdpIaBjlh1RSFT
         EmX5je4mD2pUAO+WIlSplCpHJGsAfm/jw4e34M0KNdfj0mOnUsJljZ7a5ECw2GuMZ5+e
         Ib12CXK5Nseh3WgqEr8BWHdy4q1ZkQWLoiodQmUT3ToDPCvKVlltsDaVnqH3rY/Xu0SW
         A7ndttidpeSNU6Ghgu/7vyla9sgAcP4xr3gBQb4sIrHmnvwTY8quEystj+Uov0rE80JN
         P4Hw==
X-Forwarded-Encrypted: i=1; AKwUvBy0fbgeQtVEcgG6wOTOE043s8a2YiFq7xEgYbrAeagBwwRbZhAmeEDFervSk+1GS7QmQws=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhHmxxTTqj8m9NWd+MwErGA7Cix2c2zBHh6FPXL9yLqMp1Mq2L
	rjzFf1YYIgVV4+VbFStdjeZJvrI/7JaWWEpI+nqNRyjkCaOi0juzRIr+
X-Gm-Gg: AYBFou09Hx/DbMs0FdXK84QVMQ9sIGGhjDm5oZVtVHQYfyX9/Ja2dciGQI/B/PEO7Gj
	XXDQukQC4aw8Xv+ZwpnXzh4OFEcj80Eqjrsgk95FtQ1cpfCSz6e40SOsfORKF2HOCC7yH8Qpl7W
	tnZObRwLKPCd5ZH01yj5m3K1vrcm8XHhekjJEwTpnYABq26S8A3SVLxQVdO2xBVJlL+mTLxWoEs
	MGCa4je3k/q22xyLFYUTew41EUcTA/CN8BseTDQ9GpRVOkr326JOD/McV8bHCOQtZ4tLSJMamtA
	3ofHbkXvjr09oWAlX7EpR09fLmf6RtQLUuZYxXElhkjywp3a4l8s/R5DgRJGzbMvdtpS4xrua31
	qaRsDDiWVWxNT5PD/J0s6/QP/zMSuMSaxGIV0hmXdLP5HRsiQFHDV/aw+K2lDR2h+gndlD82EMh
	h3sdMUjDqWaYG6tT2prqV96z112mY57w+rIHhuAZcnghpCi9vfXaJ6NsuevUgYaiI7
X-Received: by 2002:a17:90b:1c0a:b0:3a0:42a9:9c75 with SMTP id 98e67ed59e1d1-3a8a1b5d361mr332289a91.43.1791324422809;
        Tue, 06 Oct 2026 15:07:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89d5ced5asm504062a91.0.2026.10.06.15.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:01 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:02:42 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Luigi Rizzo <lrizzo@google.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net-next v1 2/2] docs: netmem: document netmem and memory
 provider design principles
Message-ID: <asVvzDm8rf5BMl3b@devvm7509.cco0.facebook.com>
References: <20261005004958.3603059-1-almasrymina@google.com>
 <20261005004958.3603059-3-almasrymina@google.com>
 <asPNJ2V8Tv2Z05n-@devvm7509.cco0.facebook.com>
 <CAHS8izOvea3eas4i09pMds2zzqbCtf8VL0Zdvo3fBT_+AM1TBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOvea3eas4i09pMds2zzqbCtf8VL0Zdvo3fBT_+AM1TBg@mail.gmail.com>

On 10/05, Mina Almasry wrote:
> On Mon, Oct 5, 2026 at 9:19 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 10/05, Mina Almasry wrote:
> > > Add a Design Principles section to Documentation/networking/netmem.rst
> > > covering the netmem_ref abstraction, the prohibition on direct
> > > downcasting in callers, decoupling memory providers from net_iov,
> > > decoupling net_iov from unreadability, delegating provider/type logic to
> > > memory_provider_ops and netmem helpers, and the homogeneous skb fragment
> > > memory type invariant.
> > >
> > > Cc: Luigi Rizzo <lrizzo@google.com>
> > > Cc: Björn Töpel <bjorn@kernel.org>
> > > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > > Cc: Pavel Begunkov <asml.silence@gmail.com>
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > ---
> > >  Documentation/networking/netmem.rst | 46 +++++++++++++++++++++++++++++
> > >  1 file changed, 46 insertions(+)
> > >
> > > diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> > > index 217869d1108dd..57e52a947663d 100644
> > > --- a/Documentation/networking/netmem.rst
> > > +++ b/Documentation/networking/netmem.rst
> > > @@ -19,6 +19,52 @@ Benefits of Netmem :
> > >  * Simplified Development: Drivers interact with a consistent API,
> > >    regardless of the underlying memory implementation.
> > >
> > > +Design Principles
> > > +=================
> > > +
> > > +Memory providers (or the default ``page_pool`` allocator) allocate underlying
> > > +memory (``struct net_iov`` or ``struct page``), cast it to ``netmem_ref``, and
> > > +supply it to ``page_pool``. The ``page_pool``, drivers, and networking stack
> > > +operate on ``netmem_ref`` as the abstract type. Existing ``page_pool`` APIs
> > > +that allocate or free ``struct page`` are legacy compatibility wrappers for
> > > +drivers that do not yet support ``netmem_ref``. Code that is not yet
> > > +``netmem``-aware should be converted to ``netmem_ref`` unless it will never
> > > +need to support ``netmem``.
> > > +
> > > +1. **Operate on netmem_ref, do not downcast**: ``page_pool``, drivers, and the
> > > +   core networking stack should deal with ``netmem_ref`` rather than
> > > +   ``struct net_iov`` or ``struct page``. Downcasting ``netmem_ref`` to
> > > +   ``struct net_iov`` or ``struct page`` is not allowed unless a code path
> > > +   strictly cannot function without knowing the underlying memory type (for
> > > +   example, ``kmap_local_page()``). In those cases, to keep call sites simple,
> > > +   add a ``netmem`` helper that performs the operation on behalf of the caller,
> > > +   cleanly handles all ``net_iov`` and ``page`` cases, and returns an error if
> > > +   the ``netmem`` type cannot support the requested operation.
> >
> > [..]
> >
> > > +2. **Decouple memory providers from net_iov**: Memory providers are not limited
> > > +   to ``struct net_iov``. A memory provider that returns ``struct page``-backed
> > > +   ``netmem_ref``\ s to upper layers is allowed. Code must not assume that using
> > > +   a memory provider implies ``net_iov`` memory.
> > > +
> > > +3. **Decouple net_iov from unreadability**: ``struct net_iov`` is flexible and
> > > +   has no inherent restrictions. While current ``net_iov`` implementations are
> > > +   unreadable by the CPU, future readable ``net_iov`` implementations are
> > > +   allowed. Code must not assume ``net_iov`` is unreadable; check readability
> > > +   via ``netmem_address()`` or ``skb_frags_readable()`` instead.
> >
> > For these, idk, I do agree in principle, but it is not true right now? And
> > there needs to be a bunch of work to generalize?
> >
> 
> I may have misunderstood, but I think Bjorn is creating readable
> net_iovs for his work (patch 5). And I think that's great work and I
> plan to support the series. So this will become true very soon.
> 
> https://lore.kernel.org/netdev/20261002190018.696925-1-bjorn@kernel.org/
> 
> > Should we document where we are right now (mp return niov, niov == unreadable)
> > and where we wanna be (mp can return whatever, niov can imply readable or
> > unreadable). And when Bjorn's xsk work lands, he can update the mp section.
> > And sometime later maybe we'll lift niov == unreadable.
> 
> I think that's a good idea with 1 addendum. I'll say something like,
> "This is where we are right now, but new code should, as much as
> possible, update existing limitations to generalize and match the
> design principles.""I basically don't want LLMs lazily reward hacking
> and say "I'll just write code matching where we are right now and
> ignore the design principles." WDYT?

SGTM!
