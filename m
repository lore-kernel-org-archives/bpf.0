Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794BD426EBE
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768930382; cv=none; b=oqsVTBK63zzUz1hNpVI8Lj26qySHJdPRrO4uL8V23yb0mf2HXurJKjAguIeTf7DM3kpXw68IocaZ8yUb4tWQdGoAaSJND4HifTrKE5vaa84q3JTZuGV5mZvC+6AFGUYQ0PmPDqjl+JLN7h4H5+2EPXMwwGVO9RVnYcjevL0mt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768930382; c=relaxed/simple;
	bh=Ckdv+LBfVcrA4JvvMxCIADVWbw04Tilid9Ikn1lV+1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a86I3lSbJFBtI/MHeEfW8oxqIJml58BN8LccSOwBuMu/Xp/Ww93yiNamomuH9KbNDbtmacg6/kwU1VPbHq7ULc4kzLf3ANLyTZos0lJC2o0+5yfJdAT476Si9ZJysJKu8CVargbJ49JVp/Fek8W6tsFasz/7J+mG5AMVs39F3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwGRGyaG; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwGRGyaG"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b70abe3417so813779eec.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768930378; x=1769535178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=md0g+j6qZSK2w0IJlJPci/fZMbMlDX58xj6TKgMT//Y=;
        b=HwGRGyaGmbwMuIzukvTx5mJBmfNre9u2qndPBBTy6MGCpcI+riImr0W9oNDYTDvaK/
         IExE0Ekge8JItNdYq3L3knhk4hI6rYacTgbi8tmm/EO6Q82OqkVofozh7qFAwexva8r4
         VZB608OcqcYI29rbShlCCEe6MKdQgFoM8gkxiy0SClW1AdeG33Lh3jVfqHK52lUQ+nWh
         CzRFO05TjO11pAA1Exp3WaMgQki6kvQbRc/QCoBOaXOSCgrOcdlvDyh3B5E74cSwAKzw
         AeSyFbGkynePFTlOSUu4jojUHfWGaVLrmDrNesSmgTZw7TzrwY3n+GqKNU4iDB0oIHzK
         upCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768930378; x=1769535178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md0g+j6qZSK2w0IJlJPci/fZMbMlDX58xj6TKgMT//Y=;
        b=lk3cn37g5j9sDKfAv6HelHx6NNwrHZ5E9aHUU/vqZ64vfBr2zU2lHT2e5AB26rj5n3
         CogFwYuq47ffg2fnn//Q0ZL9Za4K+fI0QIxeKI/yUNYjUnQnLFJofoeT1d2wwEBXyq2c
         v6bMIfZ52VRwJaFqQ3KeT7LhMoioAzdy8kvfv8fkdHsoHha0l46n/UNdgW/D5TjzQJhw
         Bwdgv3YO5DGKcgWeIjpMOlDcqUGzC+oxf7VtymQCa+JOSRUa8EyxHqWR2VIoUNoy6ciJ
         z3FhUBHNCv75FE5Gk5Ln023li2rcvl2BlpB/7D01zM7q8ahmhU6sxq8ixbmZ6uIeY9Sq
         bC6A==
X-Forwarded-Encrypted: i=1; AJvYcCXkJdMAVhqrjZcLOmq4XXRZUdEBwmZc8+G3Uw3+Ys/MdfDFs+vBKU1GHIm4Y5xh6YB3IYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0YvjJS9H0NeXE4ME/zAOSEUmzDp2NULdDkkcZPVPbI2DLL4L3
	Z2QXzyNqLM5GphaZN4quRQHESrzwtcHbgA3CMThuAsEIEN3xDSdLy7uI1q+FOg==
X-Gm-Gg: AZuq6aKR7pKNf+ciPrIbhJLRXo5zv24jF8ysnK3YvxgLjoyStg5yijAGyRZoNY6DYKx
	47is2ZH9V+WnJTxVhBRHAxupFhTmXiFn1P2szMMN3b3e4b0Qb77r/w7aCO4r4OVza5QVR8aqtCw
	FsMy+a+KX2KIaedVKspnb72oOWHZv3VlIevAHDSvpL8Wx3ANV7Qcvy7VAZYwsqUkkBEnpOXjX1g
	MERC253Mo/ut9gukRGdYWlNKRA8oBjnR6dxgIMz6Ip4n92+HgYkn/hTfmmcCjDP/ETjZk1wV8DS
	i0XVlXDYXb+f6LBSi/j0EP71WG1XF2OeSBNshht5kdz94ZdXw6q8otB+wh36QN7W3AQwNhvjIRv
	5QbOSy5fxUd9rmAcHiuVJZCpr7vit14GcpdaPLHL6wNYFVEEYZ47Dk/n9nW8C/y9MkF52fY4EeX
	Bb9a3Adus/CyM=
X-Received: by 2002:a17:902:d4cb:b0:2a7:9196:a94e with SMTP id d9443c01a7336-2a79196aa80mr1234755ad.15.1768923524001;
        Tue, 20 Jan 2026 07:38:44 -0800 (PST)
Received: from gmail.com ([98.97.43.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce693sm112017965ad.36.2026.01.20.07.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:38:43 -0800 (PST)
Date: Tue, 20 Jan 2026 07:38:16 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Michal Luczaj <mhal@rbox.co>,
	Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
Message-ID: <20260120153807.gzwnhxxtcocycfmr@gmail.com>
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
 <20260113025121.197535-2-jiayuan.chen@linux.dev>
 <875x8wuy4e.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x8wuy4e.fsf@cloudflare.com>

On 2026-01-20 16:01:21, Jakub Sitnicki wrote:
> On Tue, Jan 13, 2026 at 10:50 AM +08, Jiayuan Chen wrote:
> > A socket using sockmap has its own independent receive queue: ingress_msg.
> > This queue may contain data from its own protocol stack or from other
> > sockets.
> >
> > The issue is that when reading from ingress_msg, we update tp->copied_seq
> > by default. However, if the data is not from its own protocol stack,
> > tcp->rcv_nxt is not increased. Later, if we convert this socket to a
> > native socket, reading from this socket may fail because copied_seq might
> > be significantly larger than rcv_nxt.
> >
> > This fix also addresses the syzkaller-reported bug referenced in the
> > Closes tag.
> >
> > This patch marks the skmsg objects in ingress_msg. When reading, we update
> > copied_seq only if the data is from its own protocol stack.
> >
> >                                                      FD1:read()
> >                                                      --  FD1->copied_seq++
> >                                                          |  [read data]
> >                                                          |
> >                                 [enqueue data]           v
> >                   [sockmap]     -> ingress to self ->  ingress_msg queue
> > FD1 native stack  ------>                                 ^
> > -- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
> >                                        |                  |
> >                                        |             ingress to FD1
> >                                        v                  ^
> >                                       ...                 |  [sockmap]
> >                                                      FD2 native stack
> >
> > Closes: https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983
> > Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> > Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

[...]

> > @@ -487,6 +494,14 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> >  out:
> >  	return copied;
> >  }
> > +EXPORT_SYMBOL_GPL(__sk_msg_recvmsg);
> 
> Nit: Sorry, I haven't caught that before. tcp_bpf is a built-in. We
> don't need to export this internal helper to modules.

We could probably push this without the 2/3 patch? If we are debating
that patch still would be good to get this merged.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
