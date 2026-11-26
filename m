Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688462;
	b=mdRGmbbOJ/Gvtxr30V+XYbSynyWWnoi1++OyCGQSMMC+X5+BswL4P7uK9Y+YK6fGMklh
	 Z6QAMTMsoHOQPf8kPZCK6Hs4LeSKx+/HLUNnESx1klJWTem0kvuJgMylz6JGpO8H8sm3k
	 e8RpTq0HoLm9WTsT/UtMZu1n2iVjkRIBt3/lrPWLqkRanjKwzMy8ZQ1ekOaLAgTJ0c5/2
	 GZlZZtdLAwwDhJDMnNS1JF3ZYUzsS0WPhbLCmmgiwICsfbKdjNyrq9IwKVZSnBrbYDnrx
	 qS/rOjrew76kRwuzZ/E558XQgMzUkwMHP51RMlpLLsQy9j3EVzgt8nZFE4C5yJooLtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Dz5Obh5lP0tOLHLiHWSWNzgVimL59XKVdrhzCbJPLAQ=;
	b=AO1bhB3oNb9CF6487wZ7T1ENZftBT7ILeJz62bG+XIsl2OsXFogD3u6uDp8pwTFF7fWx
	 hoSOx0DjtI7c4H87vgXXaYnNAp53u5sZNx9oWnZSI+HBLIdadM2FbDDosJZm5rMekdFLZ
	 Pt6eK8EOvqljC3FFYCUTZHyberC5XPxWYenSCRj+tbJxURzIRw/oz6QyQU6VC9pwt0Ukr
	 AhHgZDaiK4Fo+oGG5bGhWfUsSnyF9yQDtN3F6QS/1ZZQTelLgF7SLa3n3sj+qTVwdaox6
	 fjulrKUvLA4xkK09qJyVBUhQGFa788ugGm3HRPdG5pSabE+wmNk1Z2uMAKn4NFXpm0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="CD7VT//B";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D4606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 10:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 312D4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CD7VT//B
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so65112815e9.3
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 02:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795688460; x=1796293260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dz5Obh5lP0tOLHLiHWSWNzgVimL59XKVdrhzCbJPLAQ=;
        b=CD7VT//BnwjcVd/x9W08z4hh0qia6Xph8wF/i4minXZySyXu8zsDolv0LFjazmM/6m
         pIGU6L76Mawk8H2KfnDIrG2oDmO7Tv7sO/LEOBXhymVTUcYfViwFwrXpTpNkkpHs8gl4
         otBJYE9GgyVPV2IUsre2NvaRLOV2zPcBDOjAv1YT/TJrss4Pq0CevX+URUlIVbdF1LB+
         iN55YZDkHNufNljGtkNuEStzk9IaQR+nbcYV+y7g4IE4bHodjC1+Z4Qpfkkd525fXANf
         yjTMIfngYNzhYLbG2HD7dSz7i6QkbKb7sIKmnwYNW0QDrTCnZACMi6z8+NrNv2a+YLfm
         iQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688460; x=1796293260;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dz5Obh5lP0tOLHLiHWSWNzgVimL59XKVdrhzCbJPLAQ=;
        b=lZF8HHCXJWhlaVXVIbxWrwvUalhSPLn+ze9/CnxA67bdnSr0TFA/eKIDPOk861Bkn9
         CHoB546F9+06c6cx+fO0W2Y+iRJNOD2C8tfBuP9w13xTQuxDZPGlP3szX4iFmzrpa3IY
         EMGlh8jdtRLuSQPhRlqQJsw/g/xKAmX5mf32p3YRX7KtR9R689oyUAmtMLTQaElM8NA2
         AsbkmZRXSXy8Aa//8o78cutWpI2FaL2BkhWEWcNR/wLaeiBlfQGxH4w4b5V0ZLCYFs++
         YV1WQSgfDDqf+FpmGm93LQUt3MhHyXTY0dTY1snbEeo6tpGA0ws4GvTRYz4/0LWuc31x
         R2Ug==
X-Forwarded-Encrypted: i=1; AL+hErGR0vbY4g/4DWfbEYNFgkymK8BBk4+agoInVmWccUDAXcorATV+TW5y0IedF7fRuTYVU4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8psLdEzJVBYvjYLKVHDU9LHCzwllB/6ab+3Y9NkEv7Me4JLU6V
	zMFkeT0L+tvZVLh7287x4zb8I0PUUsxWqp6NDmSRfwgvklC6hMHyitZD
X-Gm-Gg: AZFdTZe2cx89BFMjvr0CewhSv0O36psSqWmKmDwbXwtqc4g5WoDeim7bikzBtyPA0Ho
	UzvBTsK6DJ6VUIXhg7wP5oe+D/eXgI+DFbS9mRejoDLzYKB4HhbIJTl2RdClyT53y7reMI4DLrc
	a00ahH7dZtGnTddR790UsaPkHIZCNz4HIlgL3mV+xdNQ7sXYAe/xhn+5oYldaLTWOfKDEdYSe3w
	KlcDz9OrY5cdRegNq4i9HYe/371WbaNMh5YoBpFoAJtG5kQ5IrIBfVl4M7E0gitEDA2PlXPJcMP
	N+gNERe4+lNtrBw8rTONzBAWy/g5UI66OXRp25uPmOYp/DzWlX71dZSFfqWmBAWf9bz4OEOAhCk
	cfinrQUP/lamYehF35WpkVa75GqJ5RvohVHcrukkwVPhFcLz5YnaIA+Cz43Sz0ygef4qSPeZ1ZT
	ZpNuKOvqesohrfmprtGHuXQC5ggLtNwGVugjF/AFmq6owdg9ow9IGCbAfmMS7o9OEkmRPQ+R5t1
	+txIVn3h32Xk2L4T12MO5Bi55EsQtSOKZMwyp0gTtf4ocedc5xOH5rCItAJt1no5wT7lo/5wV4R
	6HAjFf21CRFHe64Y1kDgSjmL28IBieQ00a0+Zjjk0tcqr4hrw5Gk7A1HciV0f6/JFg==
X-Received: by 2002:a05:600c:3ac9:b0:4a2:a3b:7aa8 with SMTP id 5b1f17b1804b1-4bb887e068emr432378915e9.3.1795688460499;
        Thu, 26 Nov 2026 02:21:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm581334935e9.5.2026.11.26.02.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:21:00 -0800 (PST)
Date: Thu, 26 Nov 2026 10:20:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, David
 Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, Xuanqiang Luo
 <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net-next v1 0/6] net: avoid stack canaries in TCP/IPv4
 fast paths
Message-ID: <20261126102058.1fecf50f@pumpkin>
In-Reply-To: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>
References: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Nov 2026 22:06:25 +0900
Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:

> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> With CONFIG_STACKPROTECTOR_STRONG=y, a function that has a local array or
> passes the address of one of its locals to another function needs a stack
> canary. The canary is set up and checked on every call, also when the
> local is only used on a path that almost never runs.
> 
> This series removes the canary from functions of the TCP/IPv4 fast paths,
> by returning results by value, by using storage that is not on the stack,
> or by not calling a function that has nothing to do.
> 
> Patch 1 returns the two mptcp_space() values in a structure, so that
> __tcp_select_window() no longer needs a canary.

While all (I think) architectures can return a big integer in two
registers (dx:ax on x86), not all ABI do the same for small structures.
For those architectures returning a struct by value is implemented by
passing the address of a hidden on stack structure.
So code generation may be worse than passing the values by reference.
I can't remember the list of architectures, mostly old ones - but not
32bit x86 because the compiler option was set when regparm=3 was added
for 2.6.
(Note that this is different from passing small structures by value.)

David
