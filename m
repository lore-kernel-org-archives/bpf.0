Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6CF486436
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268757; cv=none; b=L5qil2L4/Rpn9PFDVYZo5T3SD4CBYeUfgPwZ41jy3VbZPTlEJuiAa7jSaJ4Kw6vPP/5+KvFnhDoztxUdnvVhylvXWjZ9w0nduQlSQvk8VS8aqQppeKZqNGq63P6vs8evFEnu+Fg3wWUWFXnV3snsdIGgHZqNB6TcQo1VcX+veO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268757; c=relaxed/simple;
	bh=zajOpfpBg5ymkn/Jim8bbUW8GjfWWdYrue2j1pBz1T8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J0Fjl6UM0RbDY79j8Lf61sUlidXlFFPPhcKcOj+dZBcCuFuzQBRvoqY00rab7uCTYDWAelY3Dmzg/l1OC7c+Z/yRhjYaU26HH0gAPMsghwhpAlr+hBcNfPHecowK6zbNPdtX+tqvn7y+a2lSdhq3FPbplXU00iZ6LMOB8oFfS6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=f7Yue0/q; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="f7Yue0/q"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98505364aso98410a12.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790268754; x=1790873554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5ZgnWusXCU12zGzkWVjE72AKIB7phfrZXuIevy8gML4=;
        b=f7Yue0/qpeOInQp8bQpMhoJku1geFlUAPGz6JBPNi7FmjlOKjKTWuezqjX5X46OkHd
         oVBseXyLUF/eL/JRuuTA6pZBwZB+Yq5OqD4EExGzHirhBcsKEX1awlt53lzzRCycm76E
         K9rLbztJfLNVvgFQ8IG5bRlWNRvBlZwaIIts8TR1pvSyJqI7kLGkMW7wEmuE91yDP7EE
         NYCymrMnQffqABOFBBEwwDGcVqfW8LYS+e6taZOjK/VDNfdtClxLK7MirgQqR82B7T5x
         qZcCkXoZT5eG3hFxcjBdTyWm71TVD5SpRb61p6qxDMfveP3KsVC4qI4cSga16aWALnX3
         lsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790268754; x=1790873554;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZgnWusXCU12zGzkWVjE72AKIB7phfrZXuIevy8gML4=;
        b=emVRmZKwfjpSgKp7KPEJwBOjuJtisFukDGr/lPV2ZSDWKpagN6qxjZxl2xSNYhx2pc
         LS45sEaiUA3HlGJ/qRQlRWLd6XW1NZdVp8b88aoNiwovyzLo/jYbm8YUf2vQFrcJV73E
         xpOWXHBQ7MIhbg8hrHJsyU+M9flnwkzkNSQHtJ4Lv2pafjpUzGzcskK3/dx8NHy6zR7U
         BwTxHstEa0wUBjo1p8tpDgy8ac/BdS02vEFuFSFErBy+lknROwaL4CXUfB79ZtBTaN00
         uugXI88ZqkhFeTOCdWgryROP2f6UmxjjYTB0T6KnbE16tvrjycseG6mbohqHBs0Mt3rZ
         9L+Q==
X-Forwarded-Encrypted: i=1; AKwUvBy1njayrRJ8P6jsYQUAVxn2Nqy7XrqeNaqKspuIiqhWrVROzsaMA6BPdacKTYhFcFWk+qo=@vger.kernel.org
X-Gm-Message-State: AFuF++l72N0wKiDJ7S74fsAC5YD7ijvmG2++5kIyxS/bfDK2EcXyAphq
	tioXKjT7tCx0OL4SRlzzPZXdxOezlntQZmYUFYOHJWodCjmVpdCjc2BXKikmg6HvG3Q=
X-Gm-Gg: AYBFou2qJfLtIHwD+iY+pHjnGLATQitLOTDNWkbzFGYp85yLNzmw78LsA3lYg115YDo
	+YVd2tm0AX7nK0ccOnVuqEFCna39Dlzo76x9XTpKXTk7CeVZPM0nuck2DZVGMiiIihcdqTsiSV8
	7baCWW+mJmVu8cIZKBccfwCwwJQ1F/96tm1MwXcVHqaoH+rTW6aftWraeYdBNVmwv7nEurH1iBo
	7k2bW5NlPjrjgiOk17ZuX7po+nqHrzMAvRenAwNKdjX9lI9MuB9pY+0IErdzZP0u/6xPmxBd8u3
	lmOviMZ89AxmsADOLo0/3VrhrK1tyMAArVt2f3iDPer57cR7RNDR/GP4k2ETpE4PEqqJQq3AAOL
	te+zAw5KEXCKq/p8+jmSn0KQy93zJct1Yo1i03OM5esQRkTEvzs+/jLiP+HhWxwncL2RfHRl+R3
	G7J+UBRziMdEnkUPmXxjsiPmgYUkUj0wvxg+QiPdZ32CoRIZVodhhjh9QFEjGOzk5iLrmGY+aYy
	cdRFaJccOI=
X-Received: by 2002:a05:6402:52c1:b0:6aa:1d41:628 with SMTP id 4fb4d7f45d1cf-6aac8ecf666mr2384920a12.7.1790268754290;
        Thu, 24 Sep 2026 09:52:34 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae3a9924asm37248a12.30.2026.09.24.09.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:52:33 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: <netdev@vger.kernel.org>,  "Alexei Starovoitov" <ast@kernel.org>,
  "Jakub Kicinski" <kuba@kernel.org>,  "Kuniyuki Iwashima"
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
In-Reply-To: <DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> (Daniel Zahka's message of
	"Wed, 23 Sep 2026 13:46:28 -0400")
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
	<20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
	<DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 24 Sep 2026 18:52:32 +0200
Message-ID: <87fqyypp67.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Sep 23, 2026 at 01:46 PM -04, Daniel Zahka wrote:
> On Thu Sep 10, 2026 at 10:02 AM EDT, Jakub Sitnicki wrote:
>> skb_scrub_packet() drops all skb extensions unconditionally via
>> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_rcv,
>> etc.) and cross-netns forwarding (dev_forward_skb).
>>
>> This makes it impossible for a BPF program to pass metadata via bpf_skb_=
ext
>> through a tunnel or across a netns boundary. The extension is always lost
>> at the scrub point.
>>
>> Introduce skb_ext_scrub(), a selective variant of skb_ext_reset(). It
>> deletes every extension except SKB_EXT_BPF. Scrubbing is safe when the
>> extension slab is shared with clones: deleting an extension only clears =
the
>> per-skb active_extensions bit, and the shared slab payload is released
>> lazily by __skb_ext_put() once the last reference goes away.
>>
>> Replace the skb_ext_reset() call in skb_scrub_packet() with skb_ext_scru=
b()
>> and also switch udp_try_make_stateless() to skb_ext_scrub() as well, so =
the
>> BPF metadata survives queueing onto a UDP socket receive queue and stays
>> readable there (e.g. for a sockmap verdict program). Only mark the skb
>> stateless when no extension survives the scrub. Otherwise skb_consume_ud=
p()
>> would take the __consume_stateless_skb() fast path, which skips
>> skb_release_head_state(), and leak the extension slab.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>
> Hello Jakub,
> What are your current plans for this series? This commit solves the same
> problem I have with wanting to preserve the PSP skb extension across
> netns forwarding.

I've implemented Alexei's idea of skb-lifecycle tracepoints that run
only when an skb is marked/traced. Currently putting final touches on it
before sending it out for the first round of feedback. You can take
sneak peek at it on GH [1] to see if it meets your needs.

The CPU overhead is lower compared to the skb extension, at least in my
local runs, and the kernel changes are simpler, so it seems like a win
overall:

|                  | gated skb tps    | bpf skb ext      |
|------------------|------------------|------------------|
| **busy**         | **+5.44 =C2=B1 3.16** | **+8.01 =C2=B1 4.75** |
| sys              | +2.62 =C2=B1 2.06     | +3.67 =C2=B1 2.76     |
| soft             | +2.89 =C2=B1 1.43     | +3.83 =C2=B1 2.10     |
| ns/pkt @146k pps | **+=E2=89=88 373**       | **+=E2=89=88 549**       |

I'll be giving an update on it at LPC [1], if you're attending, and of
course will keep you posted here on the ML.

-jkbs

[1] https://github.com/jsitnicki/linux/commits/gated-skb-tracepoints-2026-0=
9-24/
[2] https://lpc.events/event/20/contributions/2549/
