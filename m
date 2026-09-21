Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3944FE2CC
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016358; cv=none; b=fhxGcgDSPmIady27HmO3g4397Mb7HDtgsyiMVunm+jTcZ7ZVt+x0HyTuFl+XvZn1fG7dlE0fpFU7yib8L+rBeTN/1EqbB7lt/DvLQypZUHecppVP6SrCVp7qyLigwWxfGCpHD3+5MgiNqH2ZDV8g9sVK1zl5NtYyFC7i8T6lbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016358; c=relaxed/simple;
	bh=6bBjpny5N1e2SRsS37EoTapMfmRF26k/B1H4vibyuJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYznKdBIPpTF9GLsmUT3dTNYS3Hb8LG58LIW3bZJSniACnHv3JSVc/M7kW2EO7YFhRJC9w73ytyW14iiro7B4VIm3bwOebVcLrTHaFFOwxX2G/rN62AkbQCBrH010yo7ikd4JnPZgPdsY2roUWBOcgiwJ0MsLHcDmiAINNY8J80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOQKnvMW; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOQKnvMW"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-398e10200a6so2142358a91.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790016356; x=1790621156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ys3kcQzfZ3490e1gxpoxMXZSPnIfno7l6ut1Q4fF6Vw=;
        b=hOQKnvMWQwpRnVRXE8QY6K3vqazsMI4ZNNeHq7YTFv55hW/MQWfln0tO7f4k3IdFX/
         pS3O/oGobmt5rTTn7VrziRLHRadVGWN+DWKVvClCjJiaLKR90ewERsKBIr9JB61Dlr4N
         M5RLs8uKIeC2K3KS8G6s3XamsexN6VOyeqjD3qSqC6WqQD87RymMdfxu+HV99BsNI+cN
         nq9JiSSmha+fUpMJ3oX6xQILYCwOAaDlcdiD9mFTdY7gGjMZYWbRffqgibFLxO8RqBvW
         7k+sKSakhouoQmVxXGhdUNSOxM+Ta+2wOWEgbXksITRN1+2IewWPKxLb8Y80ny6Q2HVo
         L/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790016356; x=1790621156;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ys3kcQzfZ3490e1gxpoxMXZSPnIfno7l6ut1Q4fF6Vw=;
        b=k/zsGEc6aIxUeqU21/lM/sWsEWgW9XIW9QY4rCyKYz/T5KEZ1hX5P3igEBVCAMFNUu
         hJYfrty8jjrhUrKTyuNRY3d11MeOB3wOlQiPEr/gN3T06US8CfTOvx3IHGYmOjcR92Q+
         fWzSu05JB8dCaHV9+s579tCEWKn6u3qXA+cuTBDEWDqw9QpTkGOn49Str8l4DBeltJAU
         hx7w1w6/EOKPxI7/l1PsFEhYaQw3D/KWWnoP6VS0JK7uf60kAqFWmWbAaw8zz0yeDS0j
         zH4tkGdkK5suLo7cv3TzdiNA0dh2Me+dVn+DXZrZURHyMejoAkmZr5ii3uMAS6JNZ9EW
         DHug==
X-Forwarded-Encrypted: i=1; AKwUvBwnm8DrlnZs9EdKApVtX1n4hjH1SV7PlutSdvsl115Di56ly4lMVsUpxNS/iCvnby1lAbw=@vger.kernel.org
X-Gm-Message-State: AFuF++m8PqmuqcbTHNWmI7ChwuY7a6K8NcqVdlK53jxJy7T5bqIYUJKU
	m+TtJOn+pbKh2V2IgWrWxtjnJPAcUtOO55dntSbbS4TwOTuexeaG13yf
X-Gm-Gg: AYBFou1ck9U6+32vgD/7cPeih8ifg5xHa3UaxcpUGVdGopP+lJk/G40b38iI+bC3H98
	UmKLr6+g1GTvIWIc/F5ct6D0BIUpOBOtTy3D56H3ms4BzKSTpTAciJaHqe6X+7aXAkhLvlzBRsa
	NY8mxOUPH967mH+gneNnXuoIm6x+6/RVrhOPbmLiH5TKwb2KgUl2qznJ0i5uGn7DSOtni63YUe9
	tNtuCkTp3r+TiCrTeKGa9XJBN0HORZTT8JSCxMoe/EKP0uraPdblKrFIGhpEolXg7fVFI37LsAf
	OtFNkkYLjtiScyeZ2P4H1l5EOY84vdXMB2ZVEBKIIdOeYRpGbqpiQCnCimit/zeIeP8c0kjZncC
	XKol7BWF3O9xp28BQItcVvewJSt2Nz2fByk74YLX9TfhDo7MZrXOMupvjVd4PcKzMISw8y2jqlT
	pLjRbMrWeH0MXHc6QJ5W5tEP2AwxpZgLqz5x5ckuUC8FW0VD9Lq8qiJZp8FQIsokC3
X-Received: by 2002:a17:90b:4ac2:b0:3a0:2111:d15a with SMTP id 98e67ed59e1d1-3a02111e27dmr10344795a91.29.1790016356058;
        Mon, 21 Sep 2026 11:45:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0699ba967sm120008a91.11.2026.09.21.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:45:55 -0700 (PDT)
Date: Mon, 21 Sep 2026 11:45:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, Jason Xing <kernelxing@gmail.com>
Subject: Re: [PATCH RFC net-next 0/9] net: BPF Timestamping 2.0 for TCP
Message-ID: <arF7FGr8rQqDw8Pj@devvm7509.cco0.facebook.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>

On 09/19, Jason Xing wrote:
> From: Jason Xing <kernelxing@gmail.com>
> 
> Greeting,
> 
> It's BPF Timestamping 2.0 that aims to observe the packet latency
> more efficiently and simply for different protocols. The current
> series is only focused on TCP protocol.
> 
> At Netdev 0x1a/Netconf 2026, the history, background, motivation and
> rough implementation of the feature were exhaustively introduced[1].
> 
> History
> =======
> - In 2009, Patrick Ohly implemented the basic infrastructure
> - In 2014, Willem de Bruijn enhanced the TCP latency observation
> - In 2024, Jason Xing proposed its lightweight BPF version
> Detailed slides from 28 to 32 [1].
> 
> Background
> ==========
> Even though BPF Timetamping 1.0 is comparatively low-overhead,
> transparent, it's still complicated due to a few points inherited
> from the design:
> - Inflexible/fixed reporting phases (qdisc/driver/ack)
>   When we confirm the issue arises from the kernel by using attribution
>   ability of timestamping feature, we need to further minimize the scope
>   until the issue is fixed. That means, we then have to resort to write
>   a few complex BPF progs with the similar functionalities (like skb
>   level tag) which should not happen.
> - Not enough low-overhead
>   Serving the sensitive applications, an always-on latency observation
>   platform should mitigate the self-impact as much as possible. As we
>   can conclude from BPF Timestamping selftests, there are some blocking
>   and time-consuming points like where reading/writing BPF maps happen
>   in the extremely hot paths.
> - Minor flaws
>   There are a few minor flaws inherited from the initial design, like
>   missing tagging the last packet[2][3][4].
> Detailed slides from 33 to 39 [1].
> 
> Motivation
> ==========
> During the process of the large scale deployment over the last few years,
> we eventually realized timestamping feature doesn't support container
> scenario and we need a finer-grained and flexible tracing tool (packet
> basis) after a few rounds of attribution of issues.
> 
> Design
> ======
> - Start time
>   For the specific protocol, we need to accurately set the start time of
>   each packet first. For TCP, we chose the entry of tcp_sendmsg_locked
>   and the driver time as the start point, so that any BPF program is
>   capable of computing the delta between start time and current time.
> - Simplicity
>   Previous BPF program (like selftests) is too complex to implement. The
>   core idea is to make everything as simple as possible. And it should be
>   decoupled from BPF area and previous timestamping feature as much as
>   possible.
> - Flexibility
>   BPF program hooking any function with skb parameter can get the latency
>   value, which means it's no longer bound to the pre-embeded reporting
>   phases (see __skb_tstamp_tx)
> - Efficiency
>   Avoid the previous BPF operations as much as possible. Make sure the
>   feature achieves the lowest performance impact, which means only time
>   operations remain.
> Detailed slides from 40 to 62 [1].
> 
> Implementations
> ===============
> in-kernel
> - Find a suitable place to timestamp for each packet
> - Pick the right start time for TCP
> - Handle the split skb due to various reasons
> BPF prog
> - Hook any functions that carry skb parameter
> - Read out the start time from the skb
> - Generate the current time and then compute the latency
> 
> Discussion?
> ===========
> - Do we need a kfunc to allow users to reset the start time of each skb?
>   What I had in mind is if someone tries to observe the latency between
>   two specific functions (rather than tcp_sendmsg_locked).
> - Current implementation is real hardware timestamp always wins, which
>   means BPF prog possibly gets the hardware time that is not aligned
>   with bpf_ktime_get_real_ns.
> - After the series, do we need to implement the same logic for
>   SYN/FIN/PROBE... As far as I know according to numerous user reports,
>   a small handful of issues came from 3-way handshake.
> - Reusing the slot of hwtstamp might bring potential problems or make the
>   code hard to maintain. Can we add a timestamping specific field in
>   skb to deal with the latency observation?
> - netdev_data conflict in IGC driver. It seems unavoidable to pollute
>   start time when it's enabled. Should V2 feature coexist with hardware
>   timestamping?
> - Should V2 coexist with net timestamping and BPF timestamping? If not,
>   the maintenance should be easier.

After netconf discussion, I was under the impressions that no kernel
changes are needed, so what changed? Is it hard to track start_time
from tcp_sendmsg_locked on the bpf side that we need kernel support?
