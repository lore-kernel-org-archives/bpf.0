Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3504C4F40
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349853; cv=none; b=aFtmKtgn74JXeTKoP5WDEoxNJsOnUXEhytU+23cwNOx/qL2xRiJXOLwLIhprHb6DZof4E4tM6jiUqGjZ7uzkfEOd/l8AULtP8Eb15jM+1L2CKfeE+pYXqL+Jii6a5brjrg7PkUBxaJXNfHvdCsGmYVWZkVsXIWE6IhFtSKxCRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349853; c=relaxed/simple;
	bh=gnXIFxNj0f+9/sIwBuR0kWygKjn6ND0POLoXGVjDgHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rt9NyiBQBA/iYe7Ksk8cLXUuxADaafgAzZn3kUde5Mjjykvr3ygWm/QjyOyT99tuMcZZ8cxKafarbzXBtzwyu2f2qVZWg0uJxQLot997frrZwvrZrnZDONPLOjnSJlgC6GARxs/SfdhbP+Y31A1504ukM8/Q8GRwpvRZNVUNYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SG7DBCC2; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SG7DBCC2"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7dbeso128908566b.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790349849; x=1790954649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LVKVdTfVgge5LbrHqsqXvmQeab/dTYns0kONplxXyYM=;
        b=SG7DBCC22H9OHxMYJE1L/7pmynvcxHbnpt42HqB/4Hjq12DjonGN0HI7SHxIXk2w/x
         TJra3W5PCFQks6ij3G3uGn9ieRukskVoZvGo9AocWZaSXPva8VpAoyc+yiQXItQmnEgq
         cCfQF3nGkOEBMzZvqAceirV6gliKo5gTI0QwHuFpaw/3nidehAqkggo+mhEVagWfsHYu
         3RrFcDDOoqyeWjtE2PfZmh5lwgNeTPOXE+UdBu2SvejGcW4u0Y7n9yACupN5ISiQ4bTO
         fSqnFB7yn3n+vZm95FbYH3dsU3Gf32ViNsaTr0k8k/O94+3Hma6gx5x82UsxI6MGjUHx
         1CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349849; x=1790954649;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LVKVdTfVgge5LbrHqsqXvmQeab/dTYns0kONplxXyYM=;
        b=tUf37Y+10JD62pTKq96cHJl7lA5Xhieh/DKS4D+qc53hEQqa2c+iRXb8ySY+n7/LYk
         2fIwkXfFLPu++0MmmmNWUhRg6FDdZ3+ggYhuELnzixPmATsrjrZcl2Ch77zX9kJ3pCRx
         JXoHhqkN+Qfv0qi4K/y7HMsxejsDGG9EKhRnElMilR7apBXFqufIAZGjUCyXIVzh5U1Y
         vUndEc9yOyGw0T2Swfa29eby+Lu0KlFAXAS5HadKsTT7LMQMj5PXEZ0gKlnn6AHDcTfu
         X1zpYKo17Hg/h0K6GTlZMib9lxeuc4r/23MkLj0ZIBO0fJoHt5ozKJRf913hoWYLQH3L
         8seQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIsR9GcIeHVtekDYRqoUcfY216j7jq1gUsG6IftiE5FlThSY+uzSuZYcAiMJ8IjmBqDBQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mPyVpkxdBWhpsh/wY9ClOQiw5nUAZ3HA5+UE1XOh1DJ4kb0PUO
	KqijmdhV1ayHm7XyHbaoGW5pGt9xnWT1N2LDt3F92MB0VimesVSSLGdXse56hEDJjg0=
X-Gm-Gg: AYBFou3GB2jBIKyPI2CgNJdUV+Lap+W0qt8uGb49X61oO8SylA8buZcZUKmIqpeUYvr
	W75F2lgtoTxuHtS8gkXa6+WL0VYrmRjoAbeFqIGv0kMEX7DxQ1a3/at6XIRW1Q9tw0taAUJvvcY
	3O/hia0Lr/x456igISuKChUsQUiNV63ISVORaqGfIOd4s4p7jqczNZd1ZJi22p5xX8TXznY5NFI
	B/FK3XyanjouZ8Ti1DJZaunn74Cb9cyFYOpSd6aeabEzTJvFt/63wmp700mjQtD2/lYIkP0895D
	e+CoV5SqI+DnTls/+y/Ioe8bCqW/Q0hOvv8yMHQ7lLRuDfBYQbaTWZ64torhBUmA+5hYYspDSvy
	SxNmM75bZxwfPm3+aKWLk6150mSWHzYfYDzsP3SD5ftH0BlQGWGJL+u0BlVUwzxMV6x2Q3VyOGF
	aryUAOjhCjdJR4TKszTiN8gkgrDs++gLrGbYcBZc7oI/kmvw5qa+Cm4lJx5C3rLbKr4ZhEAk6G
X-Received: by 2002:a17:907:3d05:b0:c29:583a:c291 with SMTP id a640c23a62f3a-c2ac24d0b01mr598278066b.21.1790349848022;
        Fri, 25 Sep 2026 08:24:08 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae77ff064sm129043066b.48.2026.09.25.08.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:24:07 -0700 (PDT)
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
In-Reply-To: <DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail.com> (Daniel Zahka's message of
	"Fri, 25 Sep 2026 08:03:49 -0400")
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
	<20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
	<DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com>
	<DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 25 Sep 2026 17:24:06 +0200
Message-ID: <87pky14and.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 08:03 AM -04, Daniel Zahka wrote:
> On Thu Sep 24, 2026 at 12:52 PM EDT, Jakub Sitnicki wrote:
>> Hi Daniel,
>>
>> On Wed, Sep 23, 2026 at 01:46 PM -04, Daniel Zahka wrote:
>>> On Thu Sep 10, 2026 at 10:02 AM EDT, Jakub Sitnicki wrote:
>>>> skb_scrub_packet() drops all skb extensions unconditionally via
>>>> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_r=
cv,
>>>> etc.) and cross-netns forwarding (dev_forward_skb).
>>>>
>>>> This makes it impossible for a BPF program to pass metadata via bpf_sk=
b_ext
>>>> through a tunnel or across a netns boundary. The extension is always l=
ost
>>>> at the scrub point.
>>>>
>>>> Introduce skb_ext_scrub(), a selective variant of skb_ext_reset(). It
>>>> deletes every extension except SKB_EXT_BPF. Scrubbing is safe when the
>>>> extension slab is shared with clones: deleting an extension only clear=
s the
>>>> per-skb active_extensions bit, and the shared slab payload is released
>>>> lazily by __skb_ext_put() once the last reference goes away.
>>>>
>>>> Replace the skb_ext_reset() call in skb_scrub_packet() with skb_ext_sc=
rub()
>>>> and also switch udp_try_make_stateless() to skb_ext_scrub() as well, s=
o the
>>>> BPF metadata survives queueing onto a UDP socket receive queue and sta=
ys
>>>> readable there (e.g. for a sockmap verdict program). Only mark the skb
>>>> stateless when no extension survives the scrub. Otherwise skb_consume_=
udp()
>>>> would take the __consume_stateless_skb() fast path, which skips
>>>> skb_release_head_state(), and leak the extension slab.
>>>>
>>>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>>>> ---
>>>
>>> Hello Jakub,
>>> What are your current plans for this series? This commit solves the same
>>> problem I have with wanting to preserve the PSP skb extension across
>>> netns forwarding.
>>
>> I've implemented Alexei's idea of skb-lifecycle tracepoints that run
>> only when an skb is marked/traced. Currently putting final touches on it
>> before sending it out for the first round of feedback. You can take
>> sneak peek at it on GH [1] to see if it meets your needs.
>>
>> The CPU overhead is lower compared to the skb extension, at least in my
>> local runs, and the kernel changes are simpler, so it seems like a win
>> overall:
>>
>> |                  | gated skb tps    | bpf skb ext      |
>> |------------------|------------------|------------------|
>> | **busy**         | **+5.44 =C2=B1 3.16** | **+8.01 =C2=B1 4.75** |
>> | sys              | +2.62 =C2=B1 2.06     | +3.67 =C2=B1 2.76     |
>> | soft             | +2.89 =C2=B1 1.43     | +3.83 =C2=B1 2.10     |
>> | ns/pkt @146k pps | **+=E2=89=88 373**       | **+=E2=89=88 549**      =
 |
>>
>> I'll be giving an update on it at LPC [1], if you're attending, and of
>> course will keep you posted here on the ML.
>>
>> -jkbs
>>
>> [1] https://github.com/jsitnicki/linux/commits/gated-skb-tracepoints-202=
6-09-24/
>> [2] https://lpc.events/event/20/contributions/2549/
>
> Very cool. Thanks for sharing. So it seems your new approach will not
> use skb extensions, and this commit will go away :(
>
> I still have a need for this behavior of persisting certain skb
> extensions through scrubbing. I haven't considered all of my options
> yet, but I suspect the approach in this commit will work basically as
> is. If you are going to abandon this commit, would you be ok if I
> included it in a series of my own for PSP? I would, of course, leave you
> as the commit author, or give you whatever other form attribution you
> prefer.

Ah, I see now. I thought for a moment we were talking about extracting
some PSP state and passing it using BPF metadata.

Feel free to reuse & remix. I think it's enough if you link to the
original posting.
