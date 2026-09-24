Received: from mail-ej2-f7.google.com (mail-ej2-f7.google.com [74.125.228.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC804A5EB3
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266279; cv=none; b=R2qC7PYdQf0bo3QX0ZXhXrZvpGySaN0j4cVCvT26RI79H24M1bUNYpz3iMEFHmvLKj52YK/PEC3K1DCisyS0iZM0bSXadFwwFQWvJhBwAdY8InK4xL+uN2dHbZZ2VByEVxQ21V6Gn1gl36zTJflLePwcII+BH3MMD25ZM0KBaUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266279; c=relaxed/simple;
	bh=sjvElm9OzlWd9WrncMVleTTJwLB5hWxvSqnArn7XMfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl2DXTd4WK9MJaVY1eLFQCU4ATkodF4J68N4OdgQusyZ6Ot1u8UCpsRS1xtaiajMetKntOmFLm2GTHnMSy1NOHDCj8OGHkK+GpNFMO4UVCtAiuSn8Nn03n1iY2f5hPF8yfKXTFmLC0a9Agzr6gs1A9jsk9Yy44K+iKhxDJaqJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ykjo9Xp1; arc=none smtp.client-ip=74.125.228.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ykjo9Xp1"
Received: by mail-ej2-f7.google.com with SMTP id a640c23a62f3a-c29390fa872so115767766b.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790266271; x=1790871071; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cgVhYRjknEsmYWb58NrczLpY1T7bzz+SkV3E9wrQGs0=;
        b=Ykjo9Xp1LLHmKT6UYu/N6qA4Q0NG4EcETWl8LgY1MdJ2Pm5gG/ZUw/gXTsOhJqbVs+
         91eXkFkR11DbUAj5DF/OtVgKuueC5BS6CDBSnwlislsfMfzGiRm6cjYTW4h1cHt0NCFP
         85TlZG/AdOnT4Ttw5RBD3TM3Wk26xTq4odZZaPoELeB5kS9n22eBkKvkGYz4tMRAxd7j
         IL/JO5etPD7KqZoHKtRRdHPzRmaQagQPHl573gs2Hi8LftS50IGHUr6KyB12bOyLMdeZ
         DeMVhXfkX69lN/7FFyCWa4RXHGHoOd5qPsk0sOU4osS5jM70huBcd94QeEtt2Qac3VRY
         A7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266271; x=1790871071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cgVhYRjknEsmYWb58NrczLpY1T7bzz+SkV3E9wrQGs0=;
        b=d6+V+Q4OsGX4cNH3zFaJnwpjlzI56yY37TemAuGi1qcemXj3Yg1XdWa7KFT04rRNbx
         18nUC25RlbpY0pY49/NWSiz1vNKtGrURneSxhkOtedEtVFJlz1RcIgYfwrArhHpd27Om
         QBxofpk4/+I3lUEEK2k4aTnipISNm3HZ7twXJYQTVR/e/KPbAHnzutyEaqYbNtrQB3fK
         9THa6NJRCx7F12ME93PI3WIDZWQrJQlP9VZd16Tck6oE2GZ3o1KIEsx6OKleWUGxtSoA
         O/BVZFaBR/V+kUcj7mqDwCJFhNocQJflx/8t8akZ0imnCQg1fpXo0cE9KEUFyBqpU+2+
         YA1A==
X-Forwarded-Encrypted: i=1; AKwUvBwQJkTRffQBYtj38hYTNK7zfGZfMmkyjSEy5dmocD/iMl7HUpBsve4yQrR+NRBLOG42CwM=@vger.kernel.org
X-Gm-Message-State: AFuF++nVLQlO5aHOImmiPDy3aeyZRXmmR9AD/nb0mUD8zgN4HTyL4SFe
	ZFCzdn4ploQoBJCtoWAO7iHGxM2I50BAS615yHYCysFT5835RU8AzB/X
X-Gm-Gg: AYBFou11sJav2FSHY4sB/5ohjQozX59sQHEN+ps97B6MulcbNShZEjGFUWx3TqC5LPd
	mG+y5TIOZzznNOjmXftZ3pEAh+arzVV/iAXBzgCu3de21SvUxsrfCQig+Qz3Hai1FjhjciVZQ9J
	t3OKvdvFvw6Shgsh5usP1XSg+03jLx0T9NoH2qCq5vuPLkzX/Z1kNzXvlwJMNWYJar6pUio+wva
	fs5VjFOh0FQXBN+zTRiowREOGVu6/AynyTvEt99jsd95ojnnXEOxJCJ6YmX/Ti+F8mqlNPDU6Vn
	s5sdAdIAsGp18V6obHOVDMIICOMX+WbJANC0cicVIZeD7iJe6cOdk2PURsdnfJt4nKXBTP+WmBd
	LrJ6Y6iZ/DNJjFHbhJAuwRCT64HweN44oZf9gv5IxsPydIWTgLj8URQA5pOguk1LtFTx0Vv6V4D
	zjV/3YWPG7Vb4c/xlxRu//MNQmowNcLKTqEobJL8wNGXiLSLGLm+84DVrd4mLHONr4
X-Received: by 2002:a17:907:cf86:b0:c21:601:6501 with SMTP id a640c23a62f3a-c2ac52c0b98mr216549166b.20.1790266270990;
        Thu, 24 Sep 2026 09:11:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ab3ffbc6dsm297599066b.30.2026.09.24.09.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:11:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:11:04 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/9] net: BPF Timestamping 2.0 for TCP
Message-ID: <arVLfFuu02eS2Txs@devvm7509.cco0.facebook.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
 <arF7FGr8rQqDw8Pj@devvm7509.cco0.facebook.com>
 <CAL+tcoDossUOJCVwZ-6U519L_bNMYngnd82e1_oQB-czA6rL3A@mail.gmail.com>
 <arLpc9BBv_W6nw8c@devvm7509.cco0.facebook.com>
 <CAL+tcoCE1MmEQKZRX2ct4zrWxZiSj53ztVuRWU_o1+9AmO7B_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCE1MmEQKZRX2ct4zrWxZiSj53ztVuRWU_o1+9AmO7B_g@mail.gmail.com>

On 09/23, Jason Xing wrote:
> On Wed, Sep 23, 2026 at 4:53 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 09/22, Jason Xing wrote:
> > > On Tue, Sep 22, 2026 at 2:45 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> > > >
> > > > On 09/19, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@gmail.com>
> > > > >
> > > > > Greeting,
> > > > >
> > > > > It's BPF Timestamping 2.0 that aims to observe the packet latency
> > > > > more efficiently and simply for different protocols. The current
> > > > > series is only focused on TCP protocol.
> > > > >
> > > > > At Netdev 0x1a/Netconf 2026, the history, background, motivation and
> > > > > rough implementation of the feature were exhaustively introduced[1].
> > > > >
> > > > > History
> > > > > =======
> > > > > - In 2009, Patrick Ohly implemented the basic infrastructure
> > > > > - In 2014, Willem de Bruijn enhanced the TCP latency observation
> > > > > - In 2024, Jason Xing proposed its lightweight BPF version
> > > > > Detailed slides from 28 to 32 [1].
> > > > >
> > > > > Background
> > > > > ==========
> > > > > Even though BPF Timetamping 1.0 is comparatively low-overhead,
> > > > > transparent, it's still complicated due to a few points inherited
> > > > > from the design:
> > > > > - Inflexible/fixed reporting phases (qdisc/driver/ack)
> > > > >   When we confirm the issue arises from the kernel by using attribution
> > > > >   ability of timestamping feature, we need to further minimize the scope
> > > > >   until the issue is fixed. That means, we then have to resort to write
> > > > >   a few complex BPF progs with the similar functionalities (like skb
> > > > >   level tag) which should not happen.
> > > > > - Not enough low-overhead
> > > > >   Serving the sensitive applications, an always-on latency observation
> > > > >   platform should mitigate the self-impact as much as possible. As we
> > > > >   can conclude from BPF Timestamping selftests, there are some blocking
> > > > >   and time-consuming points like where reading/writing BPF maps happen
> > > > >   in the extremely hot paths.
> > > > > - Minor flaws
> > > > >   There are a few minor flaws inherited from the initial design, like
> > > > >   missing tagging the last packet[2][3][4].
> > > > > Detailed slides from 33 to 39 [1].
> > > > >
> > > > > Motivation
> > > > > ==========
> > > > > During the process of the large scale deployment over the last few years,
> > > > > we eventually realized timestamping feature doesn't support container
> > > > > scenario and we need a finer-grained and flexible tracing tool (packet
> > > > > basis) after a few rounds of attribution of issues.
> > > > >
> > > > > Design
> > > > > ======
> > > > > - Start time
> > > > >   For the specific protocol, we need to accurately set the start time of
> > > > >   each packet first. For TCP, we chose the entry of tcp_sendmsg_locked
> > > > >   and the driver time as the start point, so that any BPF program is
> > > > >   capable of computing the delta between start time and current time.
> > > > > - Simplicity
> > > > >   Previous BPF program (like selftests) is too complex to implement. The
> > > > >   core idea is to make everything as simple as possible. And it should be
> > > > >   decoupled from BPF area and previous timestamping feature as much as
> > > > >   possible.
> > > > > - Flexibility
> > > > >   BPF program hooking any function with skb parameter can get the latency
> > > > >   value, which means it's no longer bound to the pre-embeded reporting
> > > > >   phases (see __skb_tstamp_tx)
> > > > > - Efficiency
> > > > >   Avoid the previous BPF operations as much as possible. Make sure the
> > > > >   feature achieves the lowest performance impact, which means only time
> > > > >   operations remain.
> > > > > Detailed slides from 40 to 62 [1].
> > > > >
> > > > > Implementations
> > > > > ===============
> > > > > in-kernel
> > > > > - Find a suitable place to timestamp for each packet
> > > > > - Pick the right start time for TCP
> > > > > - Handle the split skb due to various reasons
> > > > > BPF prog
> > > > > - Hook any functions that carry skb parameter
> > > > > - Read out the start time from the skb
> > > > > - Generate the current time and then compute the latency
> > > > >
> > > > > Discussion?
> > > > > ===========
> > > > > - Do we need a kfunc to allow users to reset the start time of each skb?
> > > > >   What I had in mind is if someone tries to observe the latency between
> > > > >   two specific functions (rather than tcp_sendmsg_locked).
> > > > > - Current implementation is real hardware timestamp always wins, which
> > > > >   means BPF prog possibly gets the hardware time that is not aligned
> > > > >   with bpf_ktime_get_real_ns.
> > > > > - After the series, do we need to implement the same logic for
> > > > >   SYN/FIN/PROBE... As far as I know according to numerous user reports,
> > > > >   a small handful of issues came from 3-way handshake.
> > > > > - Reusing the slot of hwtstamp might bring potential problems or make the
> > > > >   code hard to maintain. Can we add a timestamping specific field in
> > > > >   skb to deal with the latency observation?
> > > > > - netdev_data conflict in IGC driver. It seems unavoidable to pollute
> > > > >   start time when it's enabled. Should V2 feature coexist with hardware
> > > > >   timestamping?
> > > > > - Should V2 coexist with net timestamping and BPF timestamping? If not,
> > > > >   the maintenance should be easier.
> > > >
> > > > After netconf discussion, I was under the impressions that no kernel
> > > > changes are needed, so what changed? Is it hard to track start_time
> > >
> > > Ah, you refered to the internal version, right? We wrote a kernel
> > > module implementing similar logic which differently finds/borrows an
> > > unused field of socket to store the start time. It's quite similar to
> > > the series actually.
> > >
> > > After deploying it at a small scale in production, I think it's
> > > meaningful to upstream it. But as you noticed, there are remaining
> > > discussion points on which I hope we can share opinions, especially
> > > the future shape.
> > >
> > > > from tcp_sendmsg_locked on the bpf side that we need kernel support?
> >
> > [..]
> >
> > > Sure, we need kernel support that why I'm trying to introduce the
> > > sk_start_time to help.
> > > https://lore.kernel.org/all/20260919143732.11772-4-kerneljasonxing@gmail.com/
> >
> > Why can you not do this on the bpf side? There is even now a sendmsg_locked
> > tracepoint with skb/sk argument. Or is it mostly because you can't
> > distinguish between cgroups? And looking at your example [1] and don't
> > see why a tracepoint won't be enough. Or is it too much overhead? In this
> > case, it needs to have some numbers attached...
> 
> I understand what you meant. Sure, we can generate the initial time in
> the tcp_sendmsg_locked() and try to pass it on to each skb in
> skb_entail(), which means 1) we need at least two hooks, which brings
> obvious overhead, 2) it's still not that easy to use as I expect it to
> be super easy to use/write/deploy, 3) I try to decouple it from BPF
> infra or complex use for the convenience. It looks like we now go back
> to BPF Timestamping V1.0.
> 
> Adding hooks does harm to the performance to those real
> latency-sensitive users who were actually yelling at us. There are
> some interesting numbers I collected previously (Sorry, I will not be
> able to collect more real data because I left that company:( ):
> 1) The kernel module introduces around 5-15% performance impact in the
> real workload. After we removed the hook in tcp_sendmsg_locked, even
> though the module didn't have the full function to calculate the
> latency, the cost was decreased by ~3-5%.
> 2) Fentry has ~4% impact on some workloads. It's very similar to what
> we use netperf on loopback [1].
> 
> The crucial idea behind the feature is that we're trying so hard to
> deploy the latency platform 7x24 without any selective sampling. It
> now looks like an advanced/21-century tcpdump and it can be
> _always-on_. If someone is just looking for one-shot tools, of course
> there are a few alternatives that are not good enough though.

IMO the feature as posted looks very tailored to a specific/narrow
use case. You save the sendmsg time in the socket and then use
it during skb allocation (with a few quirks here and there to account
for fragmentation/tso/cloning/etc).

For the very least, If you're looking to turn it into a non-rfc submission, 
I'd add numbers: tracepoint based implementation vs this kernel
accelerated path. And then we can discuss how much slower the tracepoints
are and whether you're using the proper ones... (and have an actual selftest
example as part of the series)
