Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1AA352029
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 04:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789706142; cv=none; b=E+Di4zCW0BJ4tYFP50OktVe7MTQ9d6/2tprE1aLB3wGJWW2rAP/NSF7UUm6MjCATejB90ZG8wn47L66VsVIIBjiAw+0ws4/onG+uKMoSRO7K3r7AR/efmqytXNz3TUUNHvgdHO6WrHQcwpuNNBeqH6cL0+HL+he6+HqEeu/UUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789706142; c=relaxed/simple;
	bh=bGRLaDmE0tGe3dzGXjqwaS0i7oukhbkfyXv4P/hl9lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sz3EUWoqQnrBB9EF9zC9icn8qLjJjuD+xtyheZY9jrzDVYIkeMjWtxDlkB8N34+pxOVBQR3d5M3aTDJvdwHfMnPI9IWr3t0GGTdoCvL/1og6aT3KB6UGp4ZTPeIt9YSGUGiTbv96Ujo/QpZvxSpgO5d7X6lpxItqltAJOCEFyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=OE9en6ex; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="OE9en6ex"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so304442a91.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 21:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1789706141; x=1790310941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QuXWbq9lF2IllK6DYKHV1u9ljCegelyzeKlijMgJK7Q=;
        b=OE9en6exVfIqAQIUWihZcZQRdDdMKoCMYfbXftp92HXnlJasiU/E14eF6gRwBjZ+8Q
         N+Tia09SOTpd5VgLUXqnyMkRNxpZNppPtCUi7BgmKPHbRQD3Bp9Ql3/nQvcfzwTqwXzY
         bbU7x9/qSUNcJm8LPLvPxQvwD+IWZl32MU9NTq9eQuQrqrMjancrwCRLHAMq7EMnGC05
         2B/D2RE1GiRXg0wj4nUjbRKVfBldRgx0mHWmwN7p3H4fGjwkVk5+8FicpZ5JZFa3ZoFX
         qKCRipLJIw+RHE7xidHVV51PFO0Jh3PinARK90eHLn1prTj1I4opnJlL8emWybWNQwm2
         XVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789706141; x=1790310941;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QuXWbq9lF2IllK6DYKHV1u9ljCegelyzeKlijMgJK7Q=;
        b=rQxBQRpTSdAWjCGuGxRUocTE+ANSxQ8rsPUDFoZmUfhS7RmenZnVirqqgu4OpikA0w
         EEKPgPnle0i57AE98Y8YVUTxC8cTZONtqlJWcJ5iaq2PxlfbEsmvQgDibTCo7PpkIyhA
         lSD3Z1wuSlzCUiCveLqTiMdlN0kMLnTLRF5TWtrScMeXfFqtCNMiCeredhXaTmnRga7z
         52QZjqougwgt/BI0nuCBRiQV6tWqjzK4lCb7iJJ/PsbVJWXT0IZ8ElYhkeRsC1KVg3qC
         bbXIHuUH96uWtBeOV0blrvpvTgWKsfF3OPRGgeYUU9O5NRgfYVt2a4WsyX02GR1C6DbL
         RRCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPwcQWMqfb/MSEKpX7Vyr0zCTKmEUuhGemq4tcvj0wzXN7zBYZiQdMp9MpfdYfrcYUjiU=@vger.kernel.org
X-Gm-Message-State: AFuF++nw1qJ/ALqRS9LEWXqFIufwii37AyGdBVotxTpxvW3amHJVTyj1
	D2ECafPTFdS2knd/6vX/BBqT4CiHmUP4s/tCNHS8wESjH3GSRFuvO5VYJ/XEBm/c+Eg=
X-Gm-Gg: AYBFou3WAJ5FQr5dgLnOMoO7Jk6aMH7JVSbYAfwgY+zvGUh9ILr0zEDdW3/Yd2kC7SP
	GcaqCwlBl3s9lhaI89YbCmjxQTlW900EH3j3RtWKhmc9w7zuRf8iCRlaAXHTOdtVBCCcV02wvCt
	MMDmVdGfVS+E/ooAVvchTcEIQbLiac2g0AQCn+OE47ww48MEIRB48Em/VR0jQVOFJDwAh0eYJ8Z
	MESRD0NLdAsU5zm2DNJivmlghLABVmJLNQQDCn1ykR5DFRXMoEVSOh7i8MmOZgA4l1G07PZHt4m
	Mme+XHcrqpjGbmMYE2eZ8zK/YuIpvbKmoqjeMisfkXOiBKh7/s1KDq9WYPrkTdlCRC3FuRGx+38
	ApNzYJojM0xrj8l9nq2i3DYfrWM2PXvYN59+Dh7UJV/+SyARrjEK9zMQmd+1dDLwohmrdM+AJ+M
	MK9OdNe8OusDY5F1/Pf47wH6RIn+jhTgVWBwCLrrWBqbAaGSA98bk6ZE5ZXZLx0b42rbBajTSHx
	wxrj1E2Jv0iXyHgofw2xRXqCwj/OxsaK826SrMvW3Q=
X-Received: by 2002:a17:90b:2b43:b0:39e:1ff0:331b with SMTP id 98e67ed59e1d1-39e54d37ad0mr3147621a91.2.1789706140902;
        Thu, 17 Sep 2026 21:35:40 -0700 (PDT)
Received: from [192.168.86.26] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5333829asm770181a91.0.2026.09.17.21.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 21:35:40 -0700 (PDT)
Message-ID: <7986f36c-e95a-4083-9bdf-67c59e951b95@davidwei.uk>
Date: Thu, 17 Sep 2026 21:35:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tcp: prevent stale tx timestamp keys on rtx
 fallback
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
References: <20260917172050.2191062-1-dw@davidwei.uk>
 <CAL+tcoBpFM6MvZGPDJAH1j6aX8UaRcJLhtGbS_kRX_bQ=J5oMA@mail.gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAL+tcoBpFM6MvZGPDJAH1j6aX8UaRcJLhtGbS_kRX_bQ=J5oMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-09-17 18:59, Jason Xing wrote:
> On Fri, Sep 18, 2026 at 1:20 AM David Wei <dw@davidwei.uk> wrote:
>>
>> tcp_tx_timestamp() can select skbs from the rtx queue when all the
>> copied data has been sent in tcp_sendmsg_locked(). These skbs may be
>> already cloned, sharing the same shinfo, and handed off into the lower
>> tx layers.
>>
>> tcp_tx_timestamp() sets tx_flags before setting skb tskey, racing with
>> any reader of both. It is possible to observe a valid tx_flag, but an
>> uninitialized tskey, which produces a large underflow after subtracting
>> the socket tskey.
>>
>> Reorder the writes in tcp_tx_timestamp() and
>> bpf_sock_ops_enable_tx_tstamp() to write the tskey first, followed by
>> publishing tx_flags via store-release.
>>
>> Readers perform a symmetric load-acquire on the tx_flags, followed by a
>> relaxed read of tskey.
>>
>> Fixes: 838eb9687691 ("tcp: tcp_tx_timestamp() must look at the rtx queue")
>> Assisted-by: LLM
>> Signed-off-by: David Wei <dw@davidwei.uk>
> 
> Thanks for the work.
> 
> Yesterday I remarked on your V1 at
> https://lore.kernel.org/all/CAL+tcoDMR87sxJftp7T0JX-+NUz8VkXU67M3oNZy8Tk88sDPOA@mail.gmail.com/
> 
> I'm still doubtful if we really need to introduce this much code churn
> just to fix the problem of this best-effort behavior. Even if the
> patch is fixed thoroughly, it's still a best-effort attempt since
> there are a few report points where it misses generating timestamps.
> It has nothing to do with the patch itself, but rather the design of
> net timestamping.

Hi Jason, I saw your response yesterday but it seemed like you were
discussing with Eric and not me. I had this code ready anyway before you
responded, so I sent it should Eric decide to keep 838eb9687691 and
review this approach.

If you decide to revert 838eb9687691, that is fine too and I can abandon
this patch. The main thing for me is to prevent userspace from seeing
underflows, but missing timestamps are okay.

> 
> Thanks,
> Jason
> 
