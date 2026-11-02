Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647910;
	b=rZ96aiDlkxRLMb+iMPoOr4Fh6UjiG4F6WzRVLioESLh3u9EmljfIHPcV8gqKpbUgJ9iD
	 kqSqLrc1Qfkhdkff4AzsinwVbEXg+6ublw26Y7s55h93pKqc1bm1FLGGlVjO6S2Eomhla
	 hxm6nsvkuB6nTF5VbfkGRMGKSzXs6LDod9MjJ8BZd06fx8TGThguCgljgKSLux9zadPJY
	 VyjmF8d9WH9Onx2KEHqrgOVkL3m35S97Ac9YKGOHXiA0GxHwI88G6ah+UvxSD5lVC8k78
	 YUb8xFyJPxQZ16+Kpcct4hbW6BREuDwgjApFeLtF/y6dcps0GSMnwGT2gB1mem/cCIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:User-Agent:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=17T5xkmwSXx3rxRgsFuuietPjSf4dCY3suvqmMRm7Q8=;
	b=wXlphf3yTVpsBCx9kk64CjV+qJy1GE7RofXEGFoBgIDRKDGaCqPAih8dqxB//Dzz31FN
	 oLf9SYbnkixIQrr786Bp4BROP31X2jeP7WtVl9Y9JL/gEKWv3T3eqOtHAtW2EIUwa6teq
	 awdhPclgomd8lwqhPIXDtvoU6aS8sCiNPnbTFMWYuPJadj6q2YBlFZ5T7jehHzCSaSHrQ
	 sqqzAFWe4fRZFxtBWH2Gi+fU3AoqEmQOrIHHgs21WRSBaiRe8plPdynH12gaSrhqTHPTk
	 HLrO/0uCyKr3Trurau4eo9SwTEuhU565kGw6uBj6pnI0aXiedgmh8aWsJywi3Ueqh+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GdHSYviw;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19849606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 19:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19849606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GdHSYviw
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so3823428a91.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 11:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647909; x=1794252709; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=17T5xkmwSXx3rxRgsFuuietPjSf4dCY3suvqmMRm7Q8=;
        b=GdHSYviwd1X+v6uswMpn2cvWX+0O3yEy0F0a3vUT4TyQr3cNjOa4dGxmA9qY01O+nM
         fcBPAFXhQdCYYQWMVp0smvus0XCiB22mj41VippG/7buLqH4o6Dg1vOduypdzOxHMxII
         aLdrUCZXth4A6wBn6bjsJ9ER9nwTnIkx8Ic77MtpHrII2fGdzdQ+1hCwQwOvJy7T8A6T
         OGoYbFdx5jF6Z0N77KzK+bEAyaXq6CUB4O23umbcjg4mbFy1a4dDQ4EU/t51L0I/Dxnm
         xF4IkD7t/TiA52979g9R6Mfvqy5v29es/RYZOZMa8V1k19nZ7o+Vu53ExjNw/BxcR+h8
         LT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647909; x=1794252709;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=17T5xkmwSXx3rxRgsFuuietPjSf4dCY3suvqmMRm7Q8=;
        b=oLdxekWMOc7vP4JqhRSB5AWtwaACIwqsOESithJ8l0El72WulKRIUnL39HWj4/G2yt
         dmBxkeQ+6/8fCBmIIcbjIGnSo1YMBJwa55EcIN+knD9TqIs1eN6mqf8Lp05ORxHonuq9
         4rBDBN154lw9Pb61wTdBQOatzXNSm8tnbazu+0XthNKrcEJgVcN0POSvN+8k9UIGw8O7
         SAwKLsJymUV22HHCq61+GNSC8UHZE3lrArbfdbz0Uygc/bFK/tYoTXqxcF1o2qkLcDvQ
         IS7qN4524Idd8N4jx3p0NSY5vPHDgdkodxETjWqoRhINgBFEtMUXkk7MXhgo4d0SmdJl
         YZEQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4khIJrCu9ngLvKQGG/wTCPtKYJJwKeDQO/o1Re1tbM2Xgkih1frZLH8oprxqsWOPEALM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tkFKRwdazrVGXOlDXzKS0wde9D3kchs1VnL8G9vTRlwq434QW
	3sgGGuGlAaTtmOCL2S5FDP1TdZQulbkJL/6i4U5YM96+1h3+M3pbdZz7
X-Gm-Gg: AYBFou1SdEC46TmMB0LRdmnBxji9sEr8SnbIxDmSUyj6uj3x8vlUxs4oAsdVmYkDV15
	zWT+BvSFnS8UFx+6NrGJFOFwdM4oGimL8RcLnzny6BffSe/klzj6XjZKiEuZhwKXQ2E1naly5+0
	ZiK8/lx7rsVP3JCnq+B6a0OJMiLY+iZnUH94KeWxKzerA2UGIxdtCnG6VpFJ85NykuLhbcgzr8l
	onPQWpq7iE9r19Iq1yvQ7rYG+W6n6XHi8LWEV37UPqFu5uGPIh4lsTIQdEN+BVQucKdzeGWZQi5
	b0jWxydvdgPwkr2+7Hogg87w+A+GwnCZ+EIVzta3xljD6zvVEXOmER9Y5gRBy93WYPOHQTMhOFF
	+eU7QydJl4rIvRezePNHNW5laA+7IMtdwv8hdijreT+MgmZu9jPiauF7ZNK3B4DJxdYYx6Uu2uO
	5dDllxVmWZMLjTVhCMzz+Fpn9q9q0ehLTPgBuvQ406xAz2Mp2OUEZi8SLZLTE7W7MHXtvvjJ1eK
	AQ19kkmJijxaa4wc5CODf0PchTozDBY7C7hE/Z9HNRZjmQj+kXTwnd+tShrNfavOhRBWh+wUnrz
	mSuxGaORukGpVWxgm9tN+j84PERCrshlzsdS4QUuhzknwbZHnbGNiQz3nqTQpQJePali
X-Received: by 2002:a17:90b:3c08:b0:3a8:bd51:205b with SMTP id 98e67ed59e1d1-3ae89812f18mr9476854a91.37.1793647909469;
        Mon, 02 Nov 2026 11:31:49 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9928d1sm510981a91.14.2026.11.02.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:31:49 -0800 (PST)
Date: Mon, 02 Nov 2026 12:31:17 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 06/15] bpf, sockmap: Give no progs to a TCP listener
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-7-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-7-alexei.starovoitov@gmail.com>
Message-ID: <tnw3l0.2z8ao1ckh4em1@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 00:21, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>From: Chris Mason <mason@kernel.org>
>
>A psock with a verdict prog replaces sk_data_ready and sk_write_space of
>its socket. It saves the old callbacks, and the new callbacks call them.
>sock_map_link() does this to a TCP listener too. Its new sk_data_ready
>cannot read and does not call the old one. Thus it does not wake accept().
>
>sk_clone() copies the new callbacks to each child, but not the psock.
>tcp_bpf_clone() restores only sk_prot. Without a psock the child loses data
>or does not wake its reader. If it gets a psock, the psock saves the copies
>as the old callbacks. Then sk_psock_verdict_data_ready() calls itself until
>the stack overflows. sk_psock_write_space() calls itself too, without end.
>
>Give no progs to a TCP listener, as before the first commit below. A
>listener receives and sends no data. It stays in the map and keeps its own
>callbacks. Add this exception to map_sockmap.rst. A listener no longer gets
>-EBUSY from a second map with progs of the same kind.
>
>Since the second commit below, a socket keeps its psock when TCP unhashes
>it. sock_map_link() does not see the state that the socket gets later. Do
>not depend on TCP to keep such a socket out of TCP_LISTEN. Set both
>callbacks in tcp_bpf_clone() to the TCP defaults.
>
>Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
>Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
>Signed-off-by: Chris Mason <mason@kernel.org>
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
