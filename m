Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44804CA776
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023818; cv=none; b=D3U4sK8LFUc2IsdXKL99oVCAbydDBziKO/2bX68iOM0/+Wimi1kVHvlITg91n/mHEoIvbovCEhecydY5R05iuQ8weHHl1MpfE36lqE73rrWWCb/urCvAPY57D6OQawLAKDbx7MiaLF6UoLbD0KhKATqiLurkIoF2oAQX885hsTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023818; c=relaxed/simple;
	bh=R0dC7AzYf0qWr4TrOi51tjRCzHfNwSax++tiE5KtnoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy8nzHfhsCP/bDquxYuvr8hQ4IjNyCKxHKJobVkgIg+uBZwHjJ4lBvjo9eKujfiJ7RmoWgh7VtzGoVTF1715U3zJygKEZEK5/YC2j5W0ni51PG9voelQXzAmDn7Wbjne3GzYHBPJkvyBUSzatH1WSgw2lRQTAWxOoTeo0tsBlPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sK0EEQiE; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sK0EEQiE"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3896ccc93b5so1124833a91.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 13:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790023812; x=1790628612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aCdR8n1lNuuohtFDAs+Am9lP1Oe411QNhr8MAfHsozw=;
        b=sK0EEQiEXEWOmeQyxDB2/Ryd2vOIkxMFvYWtoWRf85VZNLhfdbWKKXRE1ZxpBf+lB/
         s8l+pKnpgLvE1wll9wViRwRdcTCbPC0orzWow14Xwaic4HPeR40amgS4bPf8aFOFCw4I
         tz9c6gakfxbgFyR1eOjii+VVy8XJ0EyCTTd9BXH0OMGhYD35uFwC9aGu+My+2WA73vKd
         iEqBvf35J4N+wJ9glapQmCDWEIA6ykA78ULnUlDuZ/rIpjnQIgEY0K5rGRjVUED3eNir
         8aiAdW0fkjS3hL7G+5YJd+YKvfwveaxRnZ9B+eDzOjVstP3ikPPFeiTuXuomjmMaIHV8
         +EbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023812; x=1790628612;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCdR8n1lNuuohtFDAs+Am9lP1Oe411QNhr8MAfHsozw=;
        b=NzIVwt9UU9LYxbhog++Ahj4FTUq0pvE8Xep95BVdOSVbawCbSPbpRZ18S9xt2CeY0f
         zllDYHZBZlXlIcDZ7pcWhm9pv105NDeog0x97him4qKRD6GgJMwXIbi2hE7nSrTCvkRE
         0yZSEFdRX/zf+j/1WxzTVYOxfLZjRg6Wno8ulDz3IZjMIJwMU27e3xAbs8Sdm6OZOek0
         weMqR/O6D8M9O89GFMLYu1ScPIJDJzLO/AM0bQY9SNkL9SF9zp61s1pWio3mHRlCMGDT
         4lvw2GFNV1+nhwElvizmCw33EIrnt5Fe/7OuIUjSK3UbpiGCBShHl9C4O3/Z8R4IztuT
         q6vw==
X-Forwarded-Encrypted: i=1; AKwUvBzD9smlXFvI+pAq7fCg6bog79z7FvQk/56DWSFtvccFJAxiR80Ralu5nUDOw9My0VW5gro=@vger.kernel.org
X-Gm-Message-State: AFuF++k4oUGIu7c8xrxeN5SpNmPPFDUuvQpa6YphtNLJ31HUjP76JfdL
	GJqfmh9mubVkF9dclXX95PhHewvIswyhUm+EvvluhxxNt+/TNUOLe29X
X-Gm-Gg: AYBFou3ubdOfizvWvSlSo0OwFwOwcVWTEkUz/YBSUkLjBRNmxTGkmjhWrQK30sYFJbj
	4gtNZjwoebPVMpZY6AuUZ15Dv1mR8u+o25zG/Ig58bzPLLzAWAu6iTSHOcbzd4F1ma4VyFuy9y6
	6FkXop5RIBPtIqHhUEapVIRlOYjX6aMY7AsuMp7HmrkY0RWJYwm/LFivGoyahJQIhRoUGi90fXh
	hCbXVdrONh5eSZPJpUneJjLyra8L13eRsgdBII1TutjVLYin2LellhPYRbW78MKF+60JOgTpAzU
	uyyPaf4kWvS9UGYX+ilf/bXyq42ZFlRYPpaxvxIm32tCy09PrYGZySuHnD6vdPC7aihBPxAAQky
	3lNfZZYtYVxf5winYxXXfjSqsiOT11izi/wWat0OyJL85xpSURsHACumxgODX+Y4bVXB+KTtI91
	37KCqCJpq3DGjhRdkUGXsF9LUYs0fLK1XurnAgMDGbsMZxom33M980jqSqnfq56xT+hgzktsK/3
	0w=
X-Received: by 2002:a17:90b:448e:b0:3a0:22bd:6ee5 with SMTP id 98e67ed59e1d1-3a022bd8582mr9956024a91.14.1790023811973;
        Mon, 21 Sep 2026 13:50:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a067021ca6sm989249a91.2.2026.09.21.13.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:50:11 -0700 (PDT)
Date: Mon, 21 Sep 2026 13:48:54 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/7] tcp: Split out __tcp_set_rcvlowat().
Message-ID: <arGYL1cqUZLBjpP8@devvm7509.cco0.facebook.com>
References: <20260920195633.3033620-1-kuniyu@google.com>
 <20260920195633.3033620-5-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920195633.3033620-5-kuniyu@google.com>

On 09/20, Kuniyuki Iwashima wrote:
> We will add a kfunc for bpf_tcp_ops.{enqueue,dequeue}_rcvq()
> to adjust sk->sk_rcvlowat.
> 
> These hooks are triggered
> 
>   * when the TCP stack enqueues an skb to sk->sk_receive_queue
>   * after data is dequeued from sk->sk_receive_queue
> 
> In the enqueue path, tcp_data_ready() is always called after
> the hooks in tcp_queue_rcv() and tcp_ofo_queue().
> 
> If tcp_set_rcvlowat() were used as is, tcp_data_ready() could
> be called twice for the same skb, which is redundant and also
> confusing.
> 
> Let's split out __tcp_set_rcvlowat() and add a flag to control
> wakeup behaviour.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
