Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716E13375C3
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790298475; cv=none; b=O04/u1/GcOMBWFOhxjoDAoM1vDeIR1fkTVp440xfj5vSM1kn7vukShLKY6nXd3pA4rzvoFy0bCSERgNB5XYn+yyu9RWEVc03IJL67hL5bdenqPnNq+vKWNTE9YEYQjjnSLu5g/X8p7GDDXuqd2P8a2+XJaqzTsxyYjyxeo9tVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790298475; c=relaxed/simple;
	bh=8UABYydPGylXofY0HIINAqZSkfiYDcvxV/Qu5GNl+RA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sfMwf8Y89W7R4KBob6dC4kMBUViCniX4pht7RCXHG9hnooJxAadbGDj0S3p20oDnJ/ZmKB9yPC1haQIrjdfo4Eaf5ppVyOO2FIe5TeTjYVZ7k4EZmf3+aMCKuuslLa3p0z5UMbxaKpda2X5oEvO6IVFohJ8UDkhfHAzH6wiTwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHguzDn4; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHguzDn4"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f38so1342755ad.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790298469; x=1790903269; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gJ9TQ6nmLCn6X5u9an9cYs7PHJYbmVzNFZPSWypRc2Y=;
        b=mHguzDn4DKkpqZ4zCsoVStNpKDtmB2hvEt5UHeY5bQWcNfPQnVVHjofm8pHD6LIo2D
         gbA11tRzPaFPBrVteNBZe1lcQRYBWkpSRg6Gw2kaQ8HKgdsj+QJhgt14ofsbhsU+f42Z
         wlTU0qhdqxQrzPn9q4BpNFZJv0erlGzmfNyrNguU5NdOPUNtFmMoynTi4TvI3UOiYBgF
         +NXpuU09EX/VRl6qNpCLBgvcN7/Ayc8XWYWZskXx+MvQwU2USLzbOeRvyTe1IlC8giZV
         NVml4sNDmRcu0qveEVbIcKTxVRe6Z0OdSSoULE8TIAaF0nqyMNViHBk2FVK/w7Z3fyl7
         YpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790298469; x=1790903269;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gJ9TQ6nmLCn6X5u9an9cYs7PHJYbmVzNFZPSWypRc2Y=;
        b=LVc0wP51IlOfeFsqUamzdsqw4N+Oy/YxfJPPuETjumBG+CzHQDWtPCC8VDS1+nMyqT
         UGmB5lnj0iw1Qh1MLEYKaLYI2nudsIckoh9hs+6flSjHac3EWb3kX9KupZBUomDIEHuy
         mV5xX3YVbrj/xiktzuqgqPsHfErqOer+8Ca/m4/sR+cVHYPoEWO0pDl77jAxKPjo2EUT
         iXvuNFgoLh/2y7GUYp3aiNZ9meFWwsUD8uIzMQkklYtUsCAbkaMVV4zXJIAHJXoKVkch
         cGGXk/xlKt1IuJ1fkbHcoZPdh1g5YMrdLxedj7FrZhGka5K6S+TC00zey4ATpxHxxNlT
         ED6g==
X-Forwarded-Encrypted: i=1; AKwUvBxkAdYDDDQRi69Lf8WWcow2IlPH/XsWV5yTsISexsTmycmGHydBKJsjnZC5z8wtZVkdhW8=@vger.kernel.org
X-Gm-Message-State: AFuF++kVrWuimqSR5DN7Ct2DLtCEfybmvO6DWGCehYyMzGCsHaBCwTHc
	EvVvpMuzfhJWZMQJXHJyhx/badYW7N8q+iaEVjzj3gqrwX4fS7DRM3BZ1wpFhUeW
X-Gm-Gg: AYBFou1yjvXUwR7ddGxp1vaiXS+C5XItCf3ulqRegQQA7TQ2hBPB96frTY/+F5zOzVh
	O3ZM2UNjrZptRXF4awBaFJWtFYoFhb1zU/WXSz6OfJREI/MMyY5UoXVBovv+qqYqabpjEiOJ7ht
	Z0BYamW8ztlmianEjDpLTL5RENwQxCwvo86dX2iKuK+3vhx1pM3HZpB9iuVHZ8YYUTh1VZr2H08
	GH9KJD6Ppb/FKqIUxioNxPaKYvAuLdNBsafS3A7Ol3WggYgZqh3MSIk7LeY5ekUDfyv7evEqs7Q
	KaBCaIPgNlUOqnUiLduADnlKpPH8B9LV1wJ9rwOR5qagj442ouxOwnpSCgPrZGBi/RXEvpaUL7L
	+BVaQgVA7dvl3ER8M2+KUmoHgvy3ixHEw4kzXUE7hh8fKQWLT7xMfjERSrPoaA62yE+44j52JVd
	8rihUMzoqi1Yl8rf6BUtTSFyiDmrEFtoMdiDnM/icmBhyVfxPmM0t6vfb1XQsUCaKvh3m8xevrD
	8OOowdCelO81VKNxu0r6aqSOkuprqVGN+ggN8eTs5vDLaalHYHhaqyw0RujhcY2myvTvNO1KULF
	rRTFqOLStGVPBtw=
X-Received: by 2002:a17:903:19c8:b0:2db:539c:b7c7 with SMTP id d9443c01a7336-2df7da7efd5mr36387595ad.20.1790298468891;
        Thu, 24 Sep 2026 18:07:48 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913e030dsm2589525ad.16.2026.09.24.18.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 18:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 01:07:47 +0000
Message-Id: <DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com>
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
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>, "Daniel Zahka"
 <daniel.zahka@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com> <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com> <DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com>
In-Reply-To: <87fqyypp67.fsf@cloudflare.com>

On Thu Sep 24, 2026 at 4:52 PM UTC, Jakub Sitnicki wrote:
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

Well, the numbers speak for themselves. I think :)

