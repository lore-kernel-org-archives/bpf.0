Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795864598;
	b=ut5VL02znHchU0LIUwFmAeMqP25He+e+Ku6SAguiICUONh6WMqYA0S0xi0d24jlEVZH2
	 /gXw7BwkB+kgOlGZj+hpm+qyEtmTg8OIaiLZrLpJ4fdGcyhiLZUbKwg7zIUXAO1ZXoAPR
	 x7t4zqT8PauTLNawq+UV1BxDEguKVbpmuNiayVaB/cgEx2FUPY2/8yQjKC36hjhflKaWE
	 IWEMCsKNq0rf9Yj2sKyHy9EAnVkNuBVDZQbHr9D4y0xNeNRf3BzcxOmXYDIkXU9YtgY4C
	 RuURYpUfz4kK+mDyjUnHOnKgqU3/J2gZUdrm6hLRhJg/8h+yCsFPkw9zxOxBlCWRGZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795864598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=T8XdOzjKahmMpUz1ofbmiwjYhp8+CGhzvAVMXv3NGSU=;
	b=UvYwYJm1RV2JIpvzxrn7q6hFs14l55gWrcl/MkmAEJEEiD7QGVxM4EWw195A5b04wz/M
	 QjKbRbGWM6qwTN+iid6plGJ8FKUd56UoD3OVmOxbdT+jI57W4/++CqeBgrVNAttL9fqC+
	 kz+dSgqxWYHSjheekaZJVGAcR94ZSnD4Ter1BgYshf9OZXjpSlSd8VOZKJer3XLGgJ2Al
	 OzN/r+iv+kxfyqspL2Ssh2AJoYs4a5L1kewzpEI8JI8OQqm2+TuPWA4+PiwNtmr1weV34
	 2Y/0eeWOMxNtWjKJcXspy6on050ksbJ7Bb0QBNhJc+xnsmBrnonErcOm1xhK5bNWsxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=orSXd3k5;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2B3606A31C
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 11:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF2B3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=orSXd3k5
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so5100295a12.1
        for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 03:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795864597; x=1796469397; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8XdOzjKahmMpUz1ofbmiwjYhp8+CGhzvAVMXv3NGSU=;
        b=orSXd3k5fGHivfquVZ8qd0Pp4pCJ96fkmt3H0WhMevX7m+8btrRgupliyGGKYf+Uyq
         cai/tm1nrQ4C/syOvrz+h9x1AX47/fNYpeUUC9dhlwMlIPbEF7LSffJ24vgRaZRlPAMh
         Py1CVZhpyOg2s7+sl96XPvtdFJu2QFIJQL0RYsn4LuYKW4RCqP5/MhuSca2CX5V2RT+b
         3Pr06+7bs/fTi6FsF8T/o8NEf8q55PB6ZHWsfREJ6FkchTHQxTjFgj4YvEIzi8QMl4cS
         wY88XZ+H9OlZ3/ZKLHy7SWTXfGkdIVe9AWwAcUYd1BY6YLSzhLrb6GStqElBk9bs/M2Q
         nj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795864597; x=1796469397;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8XdOzjKahmMpUz1ofbmiwjYhp8+CGhzvAVMXv3NGSU=;
        b=oSX9EJnLQsvARTbHUTDlVcdObE8w1UoFbcspzx0ztOqkHXMvKC8OSTnuQtXngZvhDA
         /92/guSvnO4tcAkqz5UgZdculrvYVNDcddOoPKB3eiUvjspLI2NYre2+bh9wXS6Z1w9e
         QW8OrsfzvwsYy1PqRQk3CWOkwTVcBoDzxHK6Hyqa0n4MpEK6vvCs6batoyGPxN0f2BeS
         KYOtpd1PQKBJASCz0mx1xQCPfS0Oj7OieJTeMlcEoVr6NT8PpI1oiPuMQhdykm0oBx5/
         Srd1FVBf1XpqSRsPeRU0O0EmI0p6adU/wtjn4tMFrg3VKIUmIMHuT4Kq4NPBtSfNSsRi
         RQgQ==
X-Forwarded-Encrypted: i=1; AL+hErF+fcng1AjOg+JqThhzR7A5STqnoho8a6oBXpvD+SDAyQC/TYKfCXVo82je1dOMe2ZuQfo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9T9Oct6oTOh6XdSdS0QfiH6CUqassvlOXKqPN+PigA7iZ9nFVT
	xeSUIwOze7bhvvCGd1sz24HYlUYtdkLJHoywVReVn803nz4MM0/M7B8qo37uKi1Mnz6VBg+zw2x
	TFKBSpQ==
X-Received: from pjbgb22.prod.google.com ([2002:a17:90b:616:b0:3b3:c91b:f23f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ecb:b0:3ac:8446:c1a5
 with SMTP id 98e67ed59e1d1-3b41c988620mr24472096a91.48.1795864596862; Sat, 28
 Nov 2026 03:16:36 -0800 (PST)
Date: Sat, 28 Nov 2026 11:16:36 +0000
In-Reply-To: <20261122-reuseport-lock-filter-v1-1-a3e5324c8d55@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122-reuseport-lock-filter-v1-1-a3e5324c8d55@gmail.com>
Message-ID: <awq4A4oFnegEB9rO@google.com>
Subject: Re: [PATCH net] net: reuseport: honour SO_LOCK_FILTER in SO_DETACH_REUSEPORT_BPF
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Suyuan Wang <shyckless@gmail.com>
Cc: pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, willemb@google.com, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, martin.lau@linux.dev, linux-kernel@vger.kernel.org, 
	horms@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, 22 Nov 2026 08:17:26 +0000, Suyuan Wang wrote:
> From: Suyuan Wang <stevewong@hust.edu.cn>
> 
> SO_LOCK_FILTER lets a process lock the filters on a socket before
> handing it to a less privileged one. Once it is set, the existing attach
> and detach paths reject changes to the socket's BPF filters with -EPERM,
> but SO_DETACH_REUSEPORT_BPF does not check SOCK_FILTER_LOCKED. So an
> unprivileged process that receives a locked socket can still remove the
> reuseport program, which then changes how packets and connections are
> spread over the whole reuseport group.
> 
> Return -EPERM from reuseport_detach_prog() when the filter is locked,
> like sk_detach_filter() does.
> 
> Found with a static analysis tool and checked by hand.
> 
> Fixes: 99f3a064bc2e ("bpf: net: Add SO_DETACH_REUSEPORT_BPF")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
