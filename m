Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C43150997
	for <bpf@vger.kernel.org>; Sun, 25 Jan 2026 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769307016; cv=pass; b=mhJ0P0vX0viXG4W6mkgORnxtwQgI3t90tyEECM9XhZSdV3jyCqIgM5KU/RBFxBthkCuKBaWi+pfd6W4MZkrzIGjldhcCjLm4hq2Vhnjdx5xayIV7sDHuETa9m6zfWd2ZpSOk9TiXUDZAkDsJRJeD/iIDaXKd890QfZsyzQFNqyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769307016; c=relaxed/simple;
	bh=XLZyAyp5UIrnE16IaKCD9XtL/eqE6lBlGhHJnAAFVHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDz5EDGFxPzlLEQKXCkEmNCOkcSGJt1CB+COZba1wCl5wBZ6o3uRW6nuXyzwldh1QN0Oh6h2WvICPB5nyTegQyY7x3lBuXwTm2HvJ2RHkusqIvPfRDYStFi/PduhQf7rYuvaF3wURBKEswADGl9IQotOQ95lYJW6+GCxoJ7L7Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUjbdJwH; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUjbdJwH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso39004645e9.0
        for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 18:10:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769307013; cv=none;
        d=google.com; s=arc-20240605;
        b=f18WtSiP4X51FMKCX2u9XV3S7nbWKl23RQat3jfKmAe2UWevJE+IGbTbXschBjwQj8
         gPHIYXY3ph+Eu9V5EER7V0lCyJZyE54YmbHKJdtPg0hJodCLbGwyiFMq5g9HwgBmV/VF
         ELmMgRki/4ZtSgm0uEPdkXFVXjnuVpsrArO2i6tDdPZ6Fz09jEP6UbmM+pjr+ZKtcmEo
         MyBsEziycU4sg7bbmVdsXrwMOSb0UWmTKfa2Yv2qC6Ejka3Au4t7ej0YJoDfYUaDeaRP
         9Bx38SihDlZwqdgAHUXSAp3YiJNQqrsucz+GxLQXM+95IZR1CuBZEy2oiWVFM21Lv4TQ
         y31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rgZwVVbLFRja+NPlNhTLut3FqFbwxjNQ1zZe8RLLWeI=;
        fh=t3LK221JNULJ7WUvE4m04mkMSvYT8w2zxZiHwIuYVmc=;
        b=UX9atHE0ZdtnwmPqoMWRAiiDuDeEvIxh5CM9Ub0V4mmy86u8LocaWKqcVUFShLZwMt
         foKYvRRlgPl0LD6Fn1K66IIz7JYrZZ7tFQeAAPGdQ6GcVI48PUfec8Bl5Xl8Ca1FfWP7
         wePxNVoUnf+RZgjL/F8mveBIrhSJCgGI8PaDqpW5EwKXgVuRYtr7mJYKqimmsEscIn7D
         o933UhMs4v2PYM/OQGdOZX7ToWAjqI1yBxO2LvHZu9Yhj27x9/FGr9FLyuvIB7mAOjRS
         DKBP31WiYhDSEwGId0EvL8i178p6yLpnLBdle7PTTJRs4lXZmF/wkJKF51GMWAhjXvUO
         PG1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769307013; x=1769911813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgZwVVbLFRja+NPlNhTLut3FqFbwxjNQ1zZe8RLLWeI=;
        b=SUjbdJwHyDUnyCgfDnC/proUrN8BT2d7uSQd2AcybskPpAS6dHhVlW9UNsCrCpjo+L
         Gui/lz+XR9VeAz1KAd9SoEdWdCmdOLCSHpMT4F/QajAEyOQqLxXqZNtdJWGX0cgHMUdI
         WlikwMA1Bsvsw8BT0LLEJjGU9iRCxNC3ZTEF/lCLZRhpV31WF3m7PHFbEakXZLOMuOEk
         bT8Hd87kRe2pI/2X8sE0H1fxDSB0HnIfP/f8jQNzjAy3Okjo6tNvvC0a7wHccW1UrWwS
         kF70mjkx7f0XPJpL0g2eCJldUjJomCPVBkqwNdfuQXbmKCV0NW3HSDYvTv6SqO0TbhKZ
         xYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769307013; x=1769911813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rgZwVVbLFRja+NPlNhTLut3FqFbwxjNQ1zZe8RLLWeI=;
        b=bhLyAWUPQLqCbVT+VDHRrAgWsGofvaudbhJjRLoM1hPlxWop+4RMX0QmVztCo6mU+I
         X4oFSTxnJ+hsu/gtzApUZVLf5DcjsJfDtoU84/+m4RI0xRP4iuaqHN7heXj/srYVKpUT
         i3xc88foi/NQqGeYfAqmcxAI+EDV/L2ene/VuXZKjWGtPZBEnuUnh9JpI1dI6myQKr+T
         NA1ScFSVEXL0aXw/txcX0Sw9swWgG2KYHhFsmA5HyyfuiBy9hZmJrLqP9dyEnSORk4uB
         E+ypecduBqCBFk6TdE7/lYIRZwjXYxnWGuvJiGv0SbY/IGR6yT+1CDnBmhrIQ4sdo0PB
         BfrA==
X-Gm-Message-State: AOJu0Yzs7GsiVMzJYZhYo6HN6mBoidIGzaEktofEMxZkD8REu9BqGHN8
	aUssQqx3fH9rLWaKT8U5rY9EHdPsOCNE78tzRFPQsJSVa4RCLqZqSBb9s6t2GK6jdwspOJZ4UGA
	FKuGNDueCL8jFFaqI6H/j1nXPiHDQt44=
X-Gm-Gg: AZuq6aKAaVaJGYcMBtZ/OZq/WM0vGKFR/dMFxyPMN74pd0oSXtWtd8Zq+9cN0Sfp3KJ
	On+WR8N7B/bIRGX1sCOsgRURjbbUeb+9GgiQVYVWYjSj2JISFZ26MJt96VmXYHV5fJojkOFEXaL
	QZdPj0MSYv7PQudGPdELTxejTx4Klp+jIQh0nwn0KkxFkPcvQ625ZihQaMk6QHNWeX4bmOs1rmq
	QsV9NvPwAvSjjAl1ukvKbANuj/cyOoO9I4ull8g/EXQ4ZF8AmXixTm8ImyCvacE+RvgcK1So3D/
	t0od7sqJgdAnYgRQVAObLDIOjK6lyshcbk0xFwbb5xGlE0UmjGAf/KGOQdw1gCL34SgjbFTa70U
	7qEQq2/O2RRRM7A==
X-Received: by 2002:a05:600c:530e:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-4805ce4e67amr6595865e9.10.1769307012798; Sat, 24 Jan 2026
 18:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124113314.113584-1-jiayuan.chen@linux.dev> <20260124113314.113584-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260124113314.113584-3-jiayuan.chen@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 24 Jan 2026 18:10:01 -0800
X-Gm-Features: AZwV_QjbA50cTkj4c5-gGI9H_-Xy1D3AWqQcM96i4DXaFF0Q5FjjiG99twxjLXM
Message-ID: <CAADnVQ+TGhrAhUfbhCtnN-EEWF=Vb3AHVqs=Vd7xoSJoptKcwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 2/3] bpf, sockmap: Fix FIONREAD for sockmap
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Michal Luczaj <mhal@rbox.co>, Cong Wang <cong.wang@bytedance.com>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 3:34=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> A socket using sockmap has its own independent receive queue: ingress_msg=
.
> This queue may contain data from its own protocol stack or from other
> sockets.
>
> Therefore, for sockmap, relying solely on copied_seq and rcv_nxt to
> calculate FIONREAD is not enough.
>
> This patch adds a new msg_tot_len field in the psock structure to record
> the data length in ingress_msg. Additionally, we implement new ioctl
> interfaces for TCP and UDP to intercept FIONREAD operations.
>
> Note that we intentionally do not include sk_receive_queue data in the
> FIONREAD result. Data in sk_receive_queue has not yet been processed by
> the BPF verdict program, and may be redirected to other sockets or
> dropped. Including it would create semantic ambiguity since this data
> may never be readable by the user.
>
> Unix and VSOCK sockets have similar issues, but fixing them is outside
> the scope of this patch as it would require more intrusive changes.
>
> Previous work by John Fastabend made some efforts towards FIONREAD suppor=
t:
> commit e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Although the current patch is based on the previous work by John Fastaben=
d,
> it is acceptable for our Fixes tag to point to the same commit.
>
>                                                       FD1:read()
>                                                       --  FD1->copied_seq=
++
>                                                           |  [read data]
>                                                           |
>                                    [enqueue data]         v
>                   [sockmap]     -> ingress to self ->  ingress_msg queue
> FD1 native stack  ------>                                 ^
> -- FD1->rcv_nxt++               -> redirect to other      | [enqueue data=
]
>                                        |                  |
>                                        |             ingress to FD1
>                                        v                  ^
>                                       ...                 |  [sockmap]
>                                                      FD2 native stack
>
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Jakub, John,
pls take another look at it and ack?
