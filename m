Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648155C1D3
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000235; cv=none; b=qnrIdWtwXxYcZ/YycuXPG1clyrXk1WCLmAfWFeWhivG+adA7YM2u0CJP841K6ecCvzTC9RH5EBWf+IY5Zhpv60JjnY1cf1wiy4+ikSN8IzQxQiAqcQZU0rRDQIV9uLP1MWEZFYn8sQ7NQgXdRC1UYpCNxNDsoVtcDrs+XPab3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000235; c=relaxed/simple;
	bh=jOEgE+7hZGq23m4Kwf1DaF7fI9X9TN6cpMzxIR01eQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iun7Hvu7Juiwru4wR27M0jJy/SL/qWsTlxgm/j2nGs+HDRrWC82+XNCJh228L7kJuu929NH/vWOYm3ePQHD6kb+rvGiCLnM3BQFkaA9rusbquUzgeLwnvzIZc6nfju1jKiF+j4LrnKuSUzLXBoM/Pxj9tnfebeetspb1eggGSYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Y5QLkfFY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Y5QLkfFY"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c3156e7705cso224737466b.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792000231; x=1792605031; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jOEgE+7hZGq23m4Kwf1DaF7fI9X9TN6cpMzxIR01eQE=;
        b=Y5QLkfFYSxuogsDX4uu/tbPvzVjdCeKaqy7iLif0uAul8WBT456ad1lf9GLSP5JRrE
         OXzeKf3uF6vndKe5lsL56e8/Payw2YXccq0GECvDERhQpvQV+PAaVhrwyAK+t0Ziq868
         fWBxvNKsM5q32VCqttcYHUQp+pOHm1cYnq6Mdw5DMiecJ99xer+Pw0zzRYzrdfeS+LcV
         q1dCYm49/w9rToog9UyQVE2hDmcZVGjQ4O8TUKNh7ZEDDD69ZoopuR64Wxfzh8lyb5Ot
         STFCb9Q/QUlaPIlWj9tX2REcR9azHVASrUA3+/W2v65FlYxaChE6tz15YPKE0FAKPLYx
         DQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792000231; x=1792605031;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jOEgE+7hZGq23m4Kwf1DaF7fI9X9TN6cpMzxIR01eQE=;
        b=CzrE1ZxaVaArQS+HIfb51OfD6D93E2I0jLxUAT39T4+Fvu4+E/ELJvG0JSwXFVlTsa
         DAYIvOlGoVymemj25vHy9AClPSeUKLll6GPQt3+6Dp5uhvBl0USEb4V/JI2XH7QnJycC
         kMlB6FikvCjso9y6eMlARmeDVF+m5vEtBhCFz7z11SbEKe2+38hgMLAG25vCW5F11RIB
         HfthKEku8ozuhnZlCR5gldPOhUxUl/T74Wjx4QUUl5+lLvOYr3/HMCQrRxvrXrDZD+60
         bkBuuwbzKp1XmKH+YT/w/hmOFdpXDn1j962IIxPlWVbbWQRJl2Q1CRAWGR/dxEmE3pAV
         k1mg==
X-Forwarded-Encrypted: i=1; AKwUvBygNQjVFEO0ecdGxQG0SgkfytqURFsSqQNMKwbXxkwXAIWyegNC/3gWpOlnXXv92/CfnXg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK90kGmynV5EN+fU/T5r9Vo7radGFYPdK38p5fA2KnESh0lc/H3
	yXWNSL3iAtuuwc2dFe/Lc0Y2BQTp7nm8RCB8oXQi7El8kcgyA+vgpcJ60LmQMqrUfes=
X-Gm-Gg: AYBFou0tqhKezb8ZohiX90XgEXgHQXrkIJ2ubxYb48olU4ETU0PNAsAxNuQ3KAgiZg0
	GzyMPkD8tEbtLkXhH6pXch8XaR+brtr/i9fqXg25ZQes++e7qGkIuL+RF3A6MBNVNGs4JcL7HsS
	qXkU16OihR5ke+dCj3FWNrH1Le2cipt895qLu8d7HGpZ1wJcBUs9lww03t7GBtkCrXIP3PnxXBX
	ds9i8rqxBMesXDo5Ix7G2l7lX4YOvlGuauzbgm2NyiE1LaAVHsiB5GTS1M0YqRKTXiK98HWKTp8
	r6aNKdWv+SZIQmpDQ2dMP0XsgQrAbxGWPxbvraABWaQTPppRzB2xzMK3HSq+oSO2ykGrvl29q9t
	TMIg3+sC7IB66D32GXN4xf9+ww+fXHGoZVZ7nenrHE0c/31i+QYB9I/3+/FQZy0yY6zg7MHhFfn
	FFRfvEBWNJfp3ALsT2Yhd+N18pTI+f8gwBm7osZ/vBn25LSFnK9sn78Lr4Wi3K
X-Received: by 2002:a17:906:f59f:b0:c2e:4b90:3c56 with SMTP id a640c23a62f3a-c31a9fcf0c2mr1509659066b.13.1792000231355;
        Wed, 14 Oct 2026 10:50:31 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:2dc::49:1e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3eda433582sm10353666b.64.2026.10.14.10.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:50:30 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Willem Ferguson <wferguson@cloudflare.com>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  edumazet@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  ncardwell@google.com,
  bpf@vger.kernel.org,  ast@kernel.org,  daniel@iogearbox.net,
  andrii@kernel.org,  eddyz87@gmail.com,  memxor@gmail.com,
  linux-doc@vger.kernel.org,  corbet@lwn.net,
  linux-kselftest@vger.kernel.org,  shuah@kernel.org,
  linux-kernel@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [RFC PATCH net-next 2/4] tcp: add BPF_SOCK_OPS_TCP_TS_ID_CB to
 assign a TSval identifier
In-Reply-To: <20261013103906.2660384-3-wferguson@cloudflare.com> (Willem
	Ferguson's message of "Tue, 13 Oct 2026 10:39:04 +0000")
References: <20261013103906.2660384-1-wferguson@cloudflare.com>
	<20261013103906.2660384-3-wferguson@cloudflare.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 14 Oct 2026 19:50:29 +0200
Message-ID: <877bjk893u.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 13, 2026 at 10:39 AM GMT, Willem Ferguson wrote:
> Let a sock_ops program pick the identifier that the previous patch
> encodes in the low bits of TSval, for passively opened connections.
>
> The width is set per network namespace by the new tcp_ts_id_bits sysctl
> (0 to 8, default 0). A listener opts in by setting
> BPF_SOCK_OPS_TCP_TS_ID_CB_FLAG, typically from BPF_SOCK_OPS_TCP_LISTEN_CB.
> tcp_conn_request() then runs BPF_SOCK_OPS_TCP_TS_ID_CB once the request
> socket exists and before the SYN-ACK is built, so the SYN-ACK already
> carries the identifier. The program sees the request socket, the SYN
> (bpf_load_hdr_opt() works on it) and the available width in args[1]. A
> reply that fits in that width is stored with the width in the request
> socket and is inherited by the child, including Fast Open children; any
> other reply leaves the connection unencoded.
>
> The callback is not run for SYN cookies, which have nowhere to keep the
> identifier, or when the peer did not negotiate timestamps. It is skipped
> for connections using microsecond timestamps and while the sysctl is 0.
> The width is captured per connection, so changing the sysctl does not
> affect existing connections.
>
> New /proc/net/netstat counters report how often an identifier was
> assigned, declined by the program or skipped. TCPTSIdEchoMismatch counts
> third ACKs whose TSecr no longer carries the identifier, which shows the
> echo was rewritten in flight.
>
> BPF_SOCK_OPS_ALL_CB_FLAGS grows from 0x7f to 0xff. The tcpbpf selftest
> used 0x80 as an example of an unsupported flag, so move it to 0x100.
>
> Encoding makes the timestamp clock appear 2^bits times faster to the
> peer. That shrinks the real-time span of the peer's PAWS window, and
> peers that keep ts_recent for the RFC 7323 24 days stall connections
> idle for longer than 24.8/2^bits days. ip-sysctl.rst documents both,
> along with the lack of TCP_REPAIR support.
>
> Signed-off-by: Willem Ferguson <wferguson@cloudflare.com>
> ---

I think SOCK_OPS are considered legacy.
We probably want bpf_tcp_ops struct_ops.
See [1] for an example.

[1] https://lore.kernel.org/all/20261006192601.1875100-11-kuniyu@google.com/
