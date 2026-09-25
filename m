Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF653A1A3F
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337837; cv=none; b=u+4tHN5WVfA/8WpCY19YK3VnuIBuNsIwOYrwp0wkIQX8CvIY315F9KgisbZbEjDgcX0WgktUCqUu8x0a2fCt0bhShhm6mf8d/NyE02q6KllPYT0sosY/lggeHVS4jD8+eX7VDN/VMNm216ngPKF+QUchyURpOfC1TekYM62f6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337837; c=relaxed/simple;
	bh=ixwmkNZ3SWDZVz8mQfPlOlJTV0BDbUAdCzjM6VcNE+M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LBSn53FpH6sd61iow1VtEG5MGvH98MryQBNT+rXRnkUE3yVd5fMIaIHUiEPzDCLnAIqbgd8NPHbCelQor/+xBuE93nJ41gcJhzrR+rE650q+r/3WVKbYW6jAGR48fsZbi/RhYJkZ9wkxkXa14gW71zU45xf/s1USuCFpQejiApc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqwsL1MD; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqwsL1MD"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-91415b09bf9so7178756d6.3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 05:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790337832; x=1790942632; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YdWP4IV1+oqFik4nzEL8bohta4om7bbzxqnMeqGI3WY=;
        b=gqwsL1MDoFSow8VaQWh/J/FH40JCAmn2g94E01++CaTbjhc0kJlAlwgZiGwaVMwRf7
         HahbO+VCohFpHvjGSiuNzTNhueHhCf0ejva6V7D1wb5dJaJSkbvt05VbNcETbCp3BrVo
         shLpOa2hmyBYrw+3TSHZicM2qod062VzUcexke5bOw22QNmQ9VXkY0yl+JyXTrZhTubK
         1eaG8EyW42z176QwOHVTLl/Ul29Nc2t/n7GBffe2vc3Lpl/1u+b0cmGPc+oTU+I8QXds
         KWD7HWB0jE8XGAdH/XDE8uJMp6pq7Ms0pRlrBRgZpE02BIim73QVjamEacudWsesUfZj
         i7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790337832; x=1790942632;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdWP4IV1+oqFik4nzEL8bohta4om7bbzxqnMeqGI3WY=;
        b=JJx7rAZpk2QaT5O61N8Y7mtg9Hzi+dZ+fY6oyAU4ITUPxZTobzN5nty/XRqP/9Nqi5
         S+wsCAUPU2k/MkjL77otQAR6067PQY2AXw+ddguc1R8xzJxLmfQpSKkbb4xrnGSVIurM
         65S+e8yt0bm23le8khLyQkVdGMWJbJniDVPCh6r/wx0a2O2ScZe8Xg1pFn42Y3npvEkH
         tDI9WejXBvjtkxTWzdfoFgqBGZVu0g2KEhyVYcA07hK644P9xv/iW0uyoUELjEXA+Wu4
         zEhEzCg3SxZMSU7c55PP8zsa3FIZ+RYMlrDFI6gC+EgFZACkpp+N246705q8F8VdQIh9
         PtcA==
X-Forwarded-Encrypted: i=1; AKwUvBwyqVXlelJqJ6Cfo+3DUusRrEJX/CGZcybtgVBTkBj+S+YbqhksvMT2dAvxNJy2DuiZT5o=@vger.kernel.org
X-Gm-Message-State: AFuF++ntwAqe9HOrJryliqFLJw77vjkJjp9Cm9kdhl7HPBuC+18iWrXg
	BinyPLg8snJ4FGQdAP6oJmcJuwgHFaFs/WUjNLgHUF+O1wk270xhrXgj
X-Gm-Gg: AYBFou18QDI9Njrtkm1H3lZGqyTAWQUx6Yina2D/RRW39P7r3w209l7kYR7eucr9faJ
	mwgh10qiHnO8H29jW87j9UdQlTXO7kABp3Q5X9Rh6v8ypIHvDil0xxCDoF58F1jOe9iNWhD74qq
	nCxnePUNI+WHIewTOxsILPDVI79mShlzsiK6sbacQzmU3Gs8KtL2mwEe2L9qV+XjE291I6FOkVG
	AxIkegj7sFYndULcKdD9m7mW/Ou1YxJdOaVe+yJzfLrBsTJfb1mxAycFSUV3Hnl5HIL6lTySDYF
	jH5YOe6C1uZNEAVMDyHsl8PRa7jdDqcGTF5Qkf946KQIaJg2a0nCYfwQL65fFH1aVx9F5mWICl/
	Naq9DergrTpZNy8SsW/SltyAnYrqB33XwMg5J6NAbxJ5EeoPA4zhPu1RQ2AWwuspUb5MQEZ5d0j
	C1O4WmhN4tazbZQzF1e7sebTBhER/VDS6b4Hg93UV+hAdtLfKAqjmtr0U+8mZTQm1wpiNra7N1l
	C0=
X-Received: by 2002:a05:6214:c82:b0:914:15ce:ed88 with SMTP id 6a1803df08f44-9142f664440mr38476586d6.3.1790337831716;
        Fri, 25 Sep 2026 05:03:51 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430dacc51sm15231996d6.11.2026.09.25.05.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 05:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 08:03:49 -0400
Message-Id: <DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail.com>
Cc: <netdev@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Stanislav Fomichev" <sdf@fomichev.me>,
 <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Florian Westphal"
 <fw@strlen.de>, "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>, "Daniel Zahka"
 <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com> <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com> <DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com>
In-Reply-To: <87fqyypp67.fsf@cloudflare.com>

On Thu Sep 24, 2026 at 12:52 PM EDT, Jakub Sitnicki wrote:
> Hi Daniel,
>
> On Wed, Sep 23, 2026 at 01:46 PM -04, Daniel Zahka wrote:
>> On Thu Sep 10, 2026 at 10:02 AM EDT, Jakub Sitnicki wrote:
>>> skb_scrub_packet() drops all skb extensions unconditionally via
>>> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_rc=
v,
>>> etc.) and cross-netns forwarding (dev_forward_skb).
>>>
>>> This makes it impossible for a BPF program to pass metadata via bpf_skb=
_ext
>>> through a tunnel or across a netns boundary. The extension is always lo=
st
>>> at the scrub point.
>>>
>>> Introduce skb_ext_scrub(), a selective variant of skb_ext_reset(). It
>>> deletes every extension except SKB_EXT_BPF. Scrubbing is safe when the
>>> extension slab is shared with clones: deleting an extension only clears=
 the
>>> per-skb active_extensions bit, and the shared slab payload is released
>>> lazily by __skb_ext_put() once the last reference goes away.
>>>
>>> Replace the skb_ext_reset() call in skb_scrub_packet() with skb_ext_scr=
ub()
>>> and also switch udp_try_make_stateless() to skb_ext_scrub() as well, so=
 the
>>> BPF metadata survives queueing onto a UDP socket receive queue and stay=
s
>>> readable there (e.g. for a sockmap verdict program). Only mark the skb
>>> stateless when no extension survives the scrub. Otherwise skb_consume_u=
dp()
>>> would take the __consume_stateless_skb() fast path, which skips
>>> skb_release_head_state(), and leak the extension slab.
>>>
>>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>>> ---
>>
>> Hello Jakub,
>> What are your current plans for this series? This commit solves the same
>> problem I have with wanting to preserve the PSP skb extension across
>> netns forwarding.
>
> I've implemented Alexei's idea of skb-lifecycle tracepoints that run
> only when an skb is marked/traced. Currently putting final touches on it
> before sending it out for the first round of feedback. You can take
> sneak peek at it on GH [1] to see if it meets your needs.
>
> The CPU overhead is lower compared to the skb extension, at least in my
> local runs, and the kernel changes are simpler, so it seems like a win
> overall:
>
> |                  | gated skb tps    | bpf skb ext      |
> |------------------|------------------|------------------|
> | **busy**         | **+5.44 =C2=B1 3.16** | **+8.01 =C2=B1 4.75** |
> | sys              | +2.62 =C2=B1 2.06     | +3.67 =C2=B1 2.76     |
> | soft             | +2.89 =C2=B1 1.43     | +3.83 =C2=B1 2.10     |
> | ns/pkt @146k pps | **+=E2=89=88 373**       | **+=E2=89=88 549**       =
|
>
> I'll be giving an update on it at LPC [1], if you're attending, and of
> course will keep you posted here on the ML.
>
> -jkbs
>
> [1] https://github.com/jsitnicki/linux/commits/gated-skb-tracepoints-2026=
-09-24/
> [2] https://lpc.events/event/20/contributions/2549/

Very cool. Thanks for sharing. So it seems your new approach will not
use skb extensions, and this commit will go away :(

I still have a need for this behavior of persisting certain skb
extensions through scrubbing. I haven't considered all of my options
yet, but I suspect the approach in this commit will work basically as
is. If you are going to abandon this commit, would you be ok if I
included it in a series of my own for PSP? I would, of course, leave you
as the commit author, or give you whatever other form attribution you
prefer.
