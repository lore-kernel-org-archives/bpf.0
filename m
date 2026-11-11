Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794433305;
	b=woUZCdKfDa2C0Lt8ACJY9tlHT8Cs4WeB5rWiVfQelgN/aROpVexJ9k+7PbaPP65UpHXH
	 qxOW6AINCAferOpdrX37boIBlCjA9SnyOaCnMMS2qz4vdjaDmdPC/birRrTnm4l9aNLlx
	 QJuQkYRRZuG6sAq2FSe6wFSo1BDpIi2mYpCb6BI6gNe15Pc04BRjRmtMBW6NnGtiYHWqI
	 zRUvTtS1SrLfKFKvSsCISKMECkmV0y5bhIErAXiw6EYu6m8jLFHLihSqfl+l5+wtmAA8H
	 SF6W+TxwIQanUo4n9vwZUebii3WSg2/ewpcywPYnIZZSRhq+KHx7MLanQlYtZWRrsSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=I3NsBH7dbDhUWpFoVCuwiBWZEyjMNzIdlKNXXp/dwQk=;
	b=0My2UAa0aR75QqzyAgV+EPkvUKFdFkVAXp/YOmJI//3nfK2akGU9t9X1Zrs+cA5RvRAv
	 9eG3HKYZzG/IwPCN/3ehNMa74Pm7jx16aOiU8VO4EKQmezvvekmhNtLHwOFZ9HKQ6J0kJ
	 U2PLgARhg8fXUFoOITwLSgdunag/Pgn76MuJBKHc1oWKoJb5XVI1uBK2x3o3AivM3VGHE
	 P0vmtqWxc3zN0Q73+vynwYvZW3OYanIpPGgltmBNxtDT5mZP3Oy0qxWo9abqTtX8056Yb
	 LkRNy9mTBFFj8n1SnWU/4A+VCDvO0KoZ9f+7W0lARwH03ubaKrx9KUtmDpOWniopzgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=UcyXBCV8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D1606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 21:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 799D1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=UcyXBCV8
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-70b875f6f1fso2877219eaf.2
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 13:41:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794433304; cv=none;
        d=google.com; s=arc-20260327;
        b=BgMlq/8ycBt3E/kR1OjNfbm8blxKm/ifQqZKMbGTN1R6nds303AIlI31xEeL7tIi3w
         GpSDM6196Zztkz3WisNYISgsaE6BgxLXIhm8+YBTd17zszcTqefs7doPpX/jihkGx1Ru
         p4baQvfcLfJv/QgpbXPZV1HVEIGENv34mAiTzizTekxp9KeGOqIP2aNIiQJ6rZ2ZLEUy
         IfzGfUuapA0h5RBTcyi64LEuusmYSPHGbh5+wX9SXNmgJkxcQUpzZrYbQV4y4+7e8egy
         iBgY8VxIQdgzSHHdZxXBtwY87xUrRaF08Zr866I5SZSJ5SuXum9B6pEot/O9sJFgBW8i
         GecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I3NsBH7dbDhUWpFoVCuwiBWZEyjMNzIdlKNXXp/dwQk=;
        fh=qXBrqzpcyhxuhGAAE+B0MhtqBxrbfcbNqdHF28lCvME=;
        b=Yz9M6Zkn8gtMpOVWFtr+JxNR4eof/UjbINKVRHUqLa8IM9HsHxObzMwkOtiJIXIBdW
         ltDqVGB63/NtKtgbm3/W4/86u05qprH2oLzY311gVuIwbri6MAJbS8i0otyyQNEkZ530
         JK1lOm/aaIU+UIXgHFAIN3fQVa+df+nObsK12vK3BYHKiJnuU2PUK6QYxYpLQ5x+5Bu7
         HDvthrE2AGYFuIQ3le+yO3dIF+TOTBjwyeUGvyod5SdBr9y2KjKxS7oetF4tyYDL0lsM
         iimHfMLNuTrhlTdxFkeuKkFFSAVsKdyPz/TFSZfS7kLe2yO3/EE3bWfogoWsurLQDaFw
         WHmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794433304; x=1795038104; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I3NsBH7dbDhUWpFoVCuwiBWZEyjMNzIdlKNXXp/dwQk=;
        b=UcyXBCV8rw5ddDzDbkoaJQUVWsIT6kVT6wFFWaz1WNOTMbtQXHB0ZwAqYFcr23lc/l
         7Av723/mVkuv1fOQ79N1SNhCfGc2WVDE7cx217hf1YgVFaYMwIN7Q0bLPWoxkBQCpAeA
         q3vC3GcTxOGHRg8wY+fKEME/WsXwlxDoth3MH8wNkNJnDq5Mldxkv0PeHRBYE7Uuxeko
         LHd1kyueEJ02RLdSIH/OyvhdIO7gIrV8aGNUYZeuBK4UVS45ZUo2quIU3AVZhRDlZ9at
         4rr3WJlBr2V4t0HbZicTPu7UluOtwoWSsbYyEJg3lkeg9bNphizDGEc3BEzwiH4a0tfw
         jWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794433304; x=1795038104;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I3NsBH7dbDhUWpFoVCuwiBWZEyjMNzIdlKNXXp/dwQk=;
        b=ugdGQHXI451AeWAT9VWuFNDV+RGnlMlIYQZCIiRWdZEJyZf3En4xTMC/bKjfQPfeMF
         GDxk+ra8ly7GnkordYlWM31uAcdNQ1wSTPFvYgSFWqueY6LoKoN9hciy1EqdvLrdEx7l
         p7CWUj4qSAw+9IdSMK/zpbmlxXEPhFRLPdGAtSnHDLHB9JOB142SbZq0xPUgNewx064R
         UyI1H6nMv1bpGTbE1AQ5DTl6ipx0F3obDxI3VYx35+JNvXDMgkh9ttCT1BB2cgei4RSk
         Rgee7BqJzr/iG4f4A4Fl951cIJB2hCz9ELJbsrrPIsuyC0WTBpcJ0DLYL4/tSwCnWfDI
         Qaiw==
X-Forwarded-Encrypted: i=1; AL+hErGjhISKLVZQVj53NV8ojLC9BHWXirS29ChQeraEsvjKw2dU4UQ1oUnsWz7d3YkIjVoJLpU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hfQHuqQephHNTbI/x7FHa6pMz2G8lcKtPvVpv0x3NAg4vW3AR
	TySL9gVqrJoseydrP3Dc4pdvMOOpS5dummeVbwC3pJ0WQXHv5Ynp58+q7falqv1uMJ3ZcQzH3+n
	GioMr6eSzpjC5SOQi+eYU8f8TVWUZIJgVIlBS1GvQhQ==
X-Gm-Gg: AYBFou31q+1+wt/toXH9xZd/BYefAV4P3n+v2Yb2pQvZ6NEiOPbwta/Bki2MQ7nBbNj
	hc/8bwPzeE1Lp3zQOxwC3cLfPw7PKIoNrjTZQbFTSxYElUDIVDTCbjp178XmTO5okNm+C7CJqmw
	+Hf/eeaxC7tKpmCvaUYQx/5ZHklI6kBjcuodn6PN9DtAb2+fdWK5zMALV1cdD7g0708uPuYQD7K
	ci2TpsaDQXO1u+yV/cE0M3cORp36kU0q10Ez40wjsTu38lRgi6Q87dkxzZoHPOUwnlCZ9EjtVyC
	TC6ECJP9LTCutl9m7SAHVuZLURoc+QEtlsGbhtaREXRqVSqvK949nCPKrQJBLpbnwBbRknpC6UF
	biecZ/yxJGaWWpWoF1FxZ8n/nAvEN0PAV9Ng62IifnapcPEL0s/jiGEslohICYODQURnhY1nxn9
	i6hZIPCSjbHg==
X-Received: by 2002:a05:6820:441b:b0:6d8:ccbf:a7c2 with SMTP id
 006d021491bc7-7191797df4fmr2278556eaf.68.1794433304290; Wed, 11 Nov 2026
 13:41:44 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794020868.git.tianyi@cloudflare.com> <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
 <willemdebruijn.kernel.1d64e7848503b@gmail.com> <20261107182526.69543-1-tianyi@cloudflare.com>
 <willemdebruijn.kernel.2c6a653eb65fa@gmail.com> <20261108190831.3f991a13@phoenix.local>
 <20261109154909.32748-1-tianyi@cloudflare.com> <avTOvr+yy+2j8xrQ@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
 <avTSBFpR2t7PO9tx@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
In-Reply-To: <avTSBFpR2t7PO9tx@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Wed, 11 Nov 2026 21:41:32 +0000
X-Gm-Features: AclHuK9Lzd82c8LN3lRJw2ClwKtYPqt-3w9VlW5CxKeZCzjufsRqZ2sayCWq8TY
Message-ID: <CAG4wq-d+LtEi-omGwzgqx14rCp_4J9HztGMpa8ioMsviaPw+ZQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and LL_ALLOC_SPACE()
To: David Keogh <dkeogh@amazon.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	David Woodhouse <dwmw2@infradead.org>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Nimrod Oren <noren@nvidia.com>, Alasdair McWilliam <alasdair@mcwilliam.dev>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Breno Leitao <leitao@debian.org>, 
	=?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, 
	Danielle Ratson <danieller@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@cloudflare.com, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 11, 2026 at 08:37:24PM +0000, David Keogh wrote:
> Our TC egress programs are not attached individually. A loader keeps
> a chain: only the head is attached to the NIC, and the rest, including
> the program that encapsulates, are reached by bpf_tail_call through a
> prog array. The head can change as programs are added and removed.
[...]
> For the BPF-side declaration to cover the TC egress case, it needs to
> account for tail call targets. Tianyi, how were you planning to handle
> a program that is only reached by tail call?

Thanks for checking how your hosts run the program.

My current plan is that the kernel reads the tag only from the program
that is attached with tcx. One way to use it is for the loader to tag
the head with the largest headroom that any program in the chain can
push. The tag describes the whole chain, so it does not matter that
the head pushes no headers itself. When the loader replaces the head,
the new head carries the tag and the kernel reads it again.

- The value can be larger than needed for some packets, because the
  tail call targets push headers of different lengths.
- Auto-tuning has its own problems, as stated in my previous reply
  [1].

I cannot find a solution where the value is always set correctly and
no UAPI is needed. What I can do is keep this UAPI minimal.

By the way, I plan to support tcx only in this series. A tcx program
is attached to one device, so the kernel knows which device to update
on attach. A cls_bpf filter can sit in a tc block that is shared by
several devices, which is harder to handle.

Let me know if this plan does not work for you. I plan to post v2
around next Monday.

[1] https://lore.kernel.org/all/20261108214356.95406-1-tianyi@cloudflare.com/

Thanks,
Tianyi
