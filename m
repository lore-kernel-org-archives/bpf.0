Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85E3D9035
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039032; cv=none; b=T9ya2FHtgTXncw/q3Kz4p9D6VjtRG7Pe1uwosLOz3s1BULdaykzDwTVDTxhS37237u5mWO538nhPI0yvXSFPDZG463PuLns4X2/QBEJj0EISw7jRQeYzdRwVVnIuve0lK2NEwcDPC/bJXbawJizeG/LguP4L51HtO9vUA37AKxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039032; c=relaxed/simple;
	bh=YkV/gmu/iRF0QtidaJru1TGFWT+3DjghSB2koHn0JDo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=InvixpZhpxDg+lfOL4fcDjbYKfVvzX4Ni3i32hZu8WavDK4VPlgxyMNlJF7/276EsMqGpxJfEtSEuo1t7huedn4dJnb4uZoJV1dvQB5VVQPDddyOkHy/WdOWE229uNwFX06xE2b3rKJnCHSgY2yLiiV3yWO3L/Ty1kT4slaColY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW5umCQo; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW5umCQo"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dcc9b506d9so4619934a34.1
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777039028; x=1777643828; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4lmyNqo07GvwFuIjU1VCEb9Ql2ZQ/Si0G3lWH77Zr8=;
        b=IW5umCQoqLETi2iYdYdIhV8l5n/rEvRFo6Ou1Dw/d9co91mDhom5bx5teNAErLcps3
         AfMBtNjrjws9oBcVBXd/+IH//OYGLe63sBQUbc3zZIsA3TB4CV+IXj0jHhD+Lf213TLt
         RsVMDNE7+EVdvPd16ewRxrjVr6wEg9lXNkTGVOMClnHk+11Fq73BaWpzQAlIfJd0w9UE
         YqYHGbUwqXXKz2h4ipD8huBUF6XDX2AYCMcki6d8j9hPMTMQcS1Jdp26yIxgvdlIw60r
         ARQaqKTLZFxsyBFWxYPH41ah9qoj1fCXzZ5EhR0SezofxQR4gE1SuzAZbAh5jaYZkL+Q
         pGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777039028; x=1777643828;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4lmyNqo07GvwFuIjU1VCEb9Ql2ZQ/Si0G3lWH77Zr8=;
        b=m3Boqyq4JIMPy394uK42sACZ0R+vlq/lyiNxxA+HEvjXm5Sn+9tFXzhzHgQXcEK0ys
         5HMNb/SV4hcbu2vxXw+tWIswAqJlK9jks0qRfYrRnpy5DI4wfosyZ6h0jWUY0dj3moum
         Wza+umtzLdvyyRaVRN0YNp2erP+8aCkqovvSg4XfGuL2bgleq0aueFUg/7xYb/9tYzrk
         1qFrJLZvsCUBiUX29daHk5qY/ILbL8lmTHF7JX8vZ9CCCCkWqup0Pd/+12Bybvhn83/h
         iBI1cqmV41dIS4K4FhQ0wQaDQSRGahc3RXVjD20rbQUD2wrQe1wXZRoeSvk/hZVpGYv3
         ReMw==
X-Forwarded-Encrypted: i=1; AFNElJ8VIgmql+Ua7wu11ftlJO3utyPxksAdnNeNoojlmFdSV8nm2eVaYr9K4hR8VfoQTof69c0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye4BSsXNFk7FJg7BcRsXIs8P+VoLKkRfBDHG0RkNPuRPow7MGz
	tqNH1KqklUUdUN6uyl+03Lnwk/3ztn5s7C3W9T8RL4DX1/Fvvthp+kTW
X-Gm-Gg: AeBDiesfpwEKVtPE1EY3ju9hwyhUGFXRqYIBT28BX5/CPsCeEW6zePquc/JAv6ff5fv
	C2C9LjTfd3AeXmbO153UmGaJb0FP3pYPMHw2lL7qCQhpONfzH2LN3PsMzenGlAn+pCcFKfJFXpl
	4PrkrECoSxjxr6hST9JpST3wTWpke4bY9Ks+yegGDTrYTXeDFw+F7iLzue8d6DZ95ALUVsZiOu3
	b2w4kuE9XjoYpf7smAErTue2pTEoYMFA80ZiJLreqaZMt0xaQ/UMqDXu7iqq0DZxUspC8E4GJy7
	mMq9srLEGFPSKwQ1nmWjQolExRjLb4x8g2EYzRHSDz7jPoDsvSgnEaLnZqm5lVB3MTiNnl7kSzi
	zWRt9RHNKKqkQ66BRv5/2/fgP3vxzpyShb53Yac92QuW21LP17t2UCuUIYHI4UYlJw5Dl0pLSGF
	IVFivQNgUg5TsRrG9X2jHzEo2+6kLV048CWE+nNZVE5rDNqg5zs4Gb3ttO3+Xwt/Ip1zPKY3ufh
	ChnlKfdCzJP+z8ZdgXF7Nmitv2V
X-Received: by 2002:a05:6830:439f:b0:7dc:da80:42be with SMTP id 46e09a7af769-7dcda80470bmr11350922a34.21.1777039028015;
        Fri, 24 Apr 2026 06:57:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9759bfa3sm19510471a34.13.2026.04.24.06.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 06:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 06:57:05 -0700
Message-Id: <DI1FREJRMGWT.M8JZJADKO6WJ@gmail.com>
Cc: "Yinhao Hu" <dddddd@hust.edu.cn>, "Kaiyan Mei" <M202472210@hust.edu.cn>,
 "Dongliang Mu" <dzm91@hust.edu.cn>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Nikolay Aleksandrov" <razor@blackwall.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemb@google.com>, "Samiullah Khawaja" <skhawaja@google.com>,
 "Hangbin Liu" <liuhangbin@gmail.com>, "Krishna Kumar" <krikku@gmail.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/3] bpf, tcx: reject offloaded programs on
 attach
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260424104201.217604-1-jiayuan.chen@linux.dev>
 <20260424104201.217604-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260424104201.217604-2-jiayuan.chen@linux.dev>

On Fri Apr 24, 2026 at 3:41 AM PDT, Jiayuan Chen wrote:
> An offloaded prog's bpf_func is replaced by bpf_prog_warn_on_exec(),
> since it's supposed to run on the NIC, not the host. But tcx doesn't
> check this and happily attaches it to the software path, so the first
> packet hits the WARN.
>
> XDP already guards this in dev_xdp_attach(); tcx just never got the
> same check. Add it to tcx_prog_attach(), tcx_link_attach() and also
> tcx_link_update() so the fix cannot be bypassed by loading a normal
> program and then swapping it out via BPF_LINK_UPDATE.
>
> Use bpf_prog_is_offloaded() rather than bpf_prog_is_dev_bound() +
> bpf_offload_dev_match() (as XDP does): bpf_prog_dev_bound_init()
> already rejects BPF_F_XDP_DEV_BOUND_ONLY for BPF_PROG_TYPE_SCHED_CLS,
> so a dev-bound SCHED_CLS program is always offloaded. The simpler
> check is sufficient and also rejects attaching a program offloaded to
> device A onto device B.
>
> Fixes: e420bed025071 ("bpf: Add fd-based tcx multi-prog infra with link s=
upport")
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/64d8e2b5-a214-4f3c-b9e8-bcedbcb2c602@=
hust.edu.cn/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  kernel/bpf/tcx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
> index 02db0113b8e7c..1144627483d53 100644
> --- a/kernel/bpf/tcx.c
> +++ b/kernel/bpf/tcx.c
> @@ -16,6 +16,9 @@ int tcx_prog_attach(const union bpf_attr *attr, struct =
bpf_prog *prog)
>  	struct net_device *dev;
>  	int ret;
> =20
> +	if (bpf_prog_is_offloaded(prog->aux))
> +		return -EINVAL;
> +

instead of sprinkling the check everywhere do it at the source of the bug.

pw-bot: cr
