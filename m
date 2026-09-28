Received: from mail-ej2-f26.google.com (mail-ej2-f26.google.com [74.125.228.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933C4E534C
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610863; cv=none; b=b3mCvINkKs1XRPdaOm3gbqAEJw2Ok1W7IAy3apM843XVYLyH04hapoXVl6IatlkiO4cJ3knU7yZnJKrKKyNXJ5yaDhDeU5koEecIxPQU4aGA/pQ1bkvzrky8Ual+iX84qz72DkH6WYwyc70YvXx3pKXnE80cel8/OWYaiq+izJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610863; c=relaxed/simple;
	bh=ghSZTabWnqxavl/W4iUtPMg/mi1Uq99yCxVqS1s2Znc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GA/ToNDKZ8zxYAbqqGkhI3eSwXEMpRDQM3jlfnGoUdoLONrkB7UdBx28s1LiQyOjB1iijaJNDAA8s4vHYwOoJRjKxrOX83FGEYCzcywF50BJAlR+WDw5pa9Wqlh3QUA/aN26tuoleVFGRRcmcBegOQGa2IgBNqjCzcJ7Zxh9Jog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GKeLAThI; arc=none smtp.client-ip=74.125.228.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GKeLAThI"
Received: by mail-ej2-f26.google.com with SMTP id a640c23a62f3a-c2940ef15d3so395780766b.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790610859; x=1791215659; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bUFOamo9O9BYWzyDGfu0crdKrXnEWewsENPgbfRd9Ig=;
        b=GKeLAThIaTL9gSl+ImfnBkW/NgkwABplPrMt6Q3EHlN0bp5j4jifEd/55KkZ/Lh64f
         cSWOkQZieQyhkVhfOc/w07DX7I2YjOyzcQJJt+y/sXeGMzgkVAuCffRBuG1T7xwpOwgD
         hBtnW6SVDEvkVSzME26ACJCbG4+oNWCdloAaJaoB0Y73mnDPvmRpvacOPs9plkqqmzLr
         X8be2lMALK0hWQN4oGz9btDh+03nqUiz1JW/rHV3hTwiJDJbUjspTBOkVeqqnlxPOE8j
         jPTLzL2B/Gatgjnw+ckcGGpi2MTFd1v2aydRzdwS7lt2Bq6sk55fd+ycZsPWK80TN9+C
         5tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610859; x=1791215659;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bUFOamo9O9BYWzyDGfu0crdKrXnEWewsENPgbfRd9Ig=;
        b=fCvUCgYY+fVhZVZzgV3FGSsJvvMrpEXY3NhDjpBgAb+wdbog5T5MNGlLS9xTqBY7yX
         6PRmOhS9S8sRjLYtrxqiKHXOPzR7d04LGFH74mWcKoyn19hz6db7Tz507HMw+9zymZAZ
         oWMwMYOocf99udnJjrW3o35/qXAR1AKnwwkdR2WJMZISv9Iqv41dpqVHocO3Hp+aEN7C
         vDNL3Nu48yX83jB4T0rXTLx0Kce4ZJxh00rOc7rxLSz7CnTiOvhjmMJWPYBoFVwlE6PK
         uvw5K9AGKZlIpfGC2M1AA6aT6a2my0vzXSTSGqcZCP8BFOwbKhM/vq3qitKyktg6qYsb
         VqLw==
X-Forwarded-Encrypted: i=1; AKwUvByWRBmfZLTG/tO3iy70N0/0Q5OU8rZYfLjTGSk/SRwG6ozzgu3wXouDjE9TyJUkLrtFbJU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFTcpxzA5whjUnletcu8uEv8aGZj0CyeKU4cyNXeob6gw6nRoF
	NqsMB27I9Q1hWSAGmCyiUHorzjeZyaiKx0iG+VMX3C7nAICbei3N+Ww/vXLxPXm01dU=
X-Gm-Gg: AYBFou3hlT+DC7MZWgSJ1omUbQcnv8ovUe9Bu/uLEv9d97+Zp1qaFhTiaPfdJklYvCk
	fxJAtn7Nby22F8TR8+idYJZsHfBx2m97xLTzeqIEUFm3BHxYUEzJSrh2LSBPDJNNdfsqGCFc2TG
	aa2WrYCuNKKdd0HwFMQPTW9J8ungRbBPoZWMCqWF3CTLERsoKs46cCwnf6uTNckHwcW+kuZp21h
	pgtirSasqKPRGHc5DK97iYwEm3sfWuYcwYhptoz3WuWhZMW6wftZgec1rUEQsw+7XmSSiKX1YMW
	JloLmMDmkJmXFvs2kCuS/W9gSghUU/NBmmHVZeE86A+avqyUY8kGRxk76dpE1RmXG6rsr0aUf91
	dvtiHI8W2PYT0XyN2tLbPSadFMcynZA7caP391afKx+DkjXI7P/G0kY2rGI+27kHHZt1iyGM5TD
	8VuOUQvnT/G/Sncdm2MxwpkRq7MlgjjaNMK04OVhXr5f+0+6mYc14Qb5FGl0yZ0/A4EmKZXqs3
X-Received: by 2002:a17:907:c24:b0:c20:1bc5:7002 with SMTP id a640c23a62f3a-c2ac22daf39mr1111903266b.3.1790610859621;
        Mon, 28 Sep 2026 08:54:19 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76a68aasm480717366b.35.2026.09.28.08.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:54:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>,  "Daniel Zahka"
 <daniel.zahka@gmail.com>,  <netdev@vger.kernel.org>,  "Kuniyuki Iwashima"
 <kuniyu@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Stanislav
 Fomichev" <sdf@fomichev.me>,  <bpf@vger.kernel.org>,
  <kernel-team@cloudflare.com>,  "Daniel Borkmann" <daniel@iogearbox.net>,
  "John Fastabend" <john.fastabend@gmail.com>,  "Andrii Nakryiko"
 <andrii@kernel.org>,  "Eduard Zingerman" <eddyz87@gmail.com>,  "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>,  "Martin KaFai Lau"
 <martin.lau@linux.dev>,  "Song Liu" <song@kernel.org>,  "Yonghong Song"
 <yonghong.song@linux.dev>,  "Jiri Olsa" <jolsa@kernel.org>,  "Emil
 Tsalapatis" <emil@etsalapatis.com>,  "David S. Miller"
 <davem@davemloft.net>,  "Eric Dumazet" <edumazet@google.com>,  "Simon
 Horman" <horms@kernel.org>,  "Jesper Dangaard Brouer" <hawk@kernel.org>,
  "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,  "Florian Westphal"
 <fw@strlen.de>,  "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
In-Reply-To: <DLOOI89GKM5B.W4XPBNJUXRV1@gmail.com> (Alexei Starovoitov's
	message of "Fri, 25 Sep 2026 20:27:31 +0000")
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
	<20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
	<DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com>
	<DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com>
	<20260925121849.2ac5150b@kernel.org>
	<DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com>
	<20260925132004.171b751e@kernel.org>
	<DLOOI89GKM5B.W4XPBNJUXRV1@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 28 Sep 2026 17:52:03 +0200
Message-ID: <87jyo5bcgs.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 25, 2026 at 08:27 PM GMT, Alexei Starovoitov wrote:
> On Fri Sep 25, 2026 at 8:20 PM UTC, Jakub Kicinski wrote:
>> On Fri, 25 Sep 2026 19:51:37 +0000 Alexei Starovoitov wrote:
>>> On Fri, Sep 25, 2026 at 12:18 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>> > Instead of improving the existing infra we're adding more BPF-specific
>>> > glue and another bit to the skb. Matter of perspective I suppose :/  
>>> 
>>> skb_ext version needs a bit too. SKB_EXT_BPF is the 8th id, so it takes
>>> the last bit of u8 active_extensions.
>>> skbuff_ext_cache object is sized for all ids, so it also grows by
>>> BPF_SKB_EXT_SIZE for xfrm, mptcp, psp whether bpf is used or not.
>>> 
>>> As I said earlier skb_ext is fine from bpf pov. If it can be made as
>>> cheap as bit + tracepoint I don't mind it at all.
>>> Which part of skb_ext would you improve?
>>
>> Mostly allocation speed. Either a small per-CPU cache like we have
>> for skbs or let the scalar matadata fields live inside the skb.
>
> makes sense to me. Speeding up generic infra is always a good thing.
>
>> That said, the selective tracing approach is also tempting.
>> It'd be great if we could have that for sockets.
>> Could we possibly think of a way to build that into tracepoints
>> instead of having the open coded
>>
>> obj_maybe_trace_bla()
>> {
>> 	if (obj->trace)
>> 		trace_bla();
>> }
>>
>> Having both:
>>
>> 	skb_maybe_trace_free(skb, SKB_CONSUMED);
>> 	skb_release_data(skb, SKB_CONSUMED);
>
> with a 3rd enum argument for different use cases?
> As a way to generalize different bits / different users?
>
> Also makes sense.

The benchmarks from Friday were wrong. I got bit by KVM halt polling,
which was randomly inflating the runtime cost by preventing batching.

The correct results - as in reproducible and with lower variance - are
the other way around - BPF skb ext is cheaper CPU-wise than gated skb
tracepoints. Please see:

https://patch.msgid.link/20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com

Despite that, I agree that the tracepoint approach is tempting from the
UX PoV.

While an skb extension seems like a natural continuation of the XDP/TC
metadata pattern, I think that model is not a great fit for skbs
traveling through the network stack.

For XDP hook, there will be usually a single owning process of the
attached program, I think. While TC, cgroup, tracepoints can have
independent program owners, each wanting to associate their own piece of
metadata with the skb.


I can iterate on on cosmetic aspects so that we don't have blocks like:

        if (reason == SKB_CONSUMED)
                trace_consume_skb(...)
        else
                trace_kfree_skb(..., reason, ...)
        skb_maybe_trace_free(..., reason, ...)

... in a couple places where they appear in v1.

Thanks for feedback.
