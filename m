Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387773FD14C
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254550; cv=none; b=IpjGZqcwF83bXYOJGc7/4gpKj5wk2hjrCGCxwh8pb3bH9SrCr9fL9IYzzPe/4uoDu8/XbONEl2p5Udu0OrLMqVyT/8QLMowvwK/blMAqaUn0cGhqKbval3ub7WBrzcrTUJBvTk66NC2rzU7OoO4K6KDNH+X7G3tdI5U5BsApTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254550; c=relaxed/simple;
	bh=+Sqrd3+qAMwXxnn7YbjPZUDRiBSpsfeWZG5do9th/6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmJbuNSWXN883SLdw/Ii109pKGB1gLdCgrodIWVtPPd6tFHyqd0DWPak09RQehpXYdsWHbAqIoa/o6x1e+Ic9LBXFBtvZ32Nk7k1q2TMP/z10kuIUPPu0wkg6Z8SObefesG7JYdSPAiVRNKaLimQBewfsj70HOlRlx3nvuj2dd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIZoeBwj; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIZoeBwj"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-365d4d2f9c1so1458367a91.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778254548; x=1778859348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=13lGB/qr9bIuYWgUEqIjZKpDgkXvR7yqgv79HDTtvfs=;
        b=aIZoeBwjX7IC2U7N7E5A7mhosKQTaE+uamgxqB5LylqIFnmrXEnVXTNQWdRuzN7igc
         WqTjKj3Kfa4HGRVfuq8f3cBEpltpdPt2RjOtc5FO0YLpbFG7sVULXD3nz0/Z8IqXxl+n
         FgFrS8Wv4oJyZsyWk0gqsAof15hlrC33gXn0wBGIXQ+rmChFVyQGISdggWFGiovr9cUO
         /YLvQlrtAAd3Ip82X4S+kVqwUvE0sclV7sg4GdYN2NhIRHCy7kkV5QIyJ3G6ZquBqloE
         IhXjb2iR5TO1HrmU3BnOttRxp3VP2Xr48H+klu7pmFlKhHFt8xekBhhGK9paZhrE9XNb
         Z/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778254548; x=1778859348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13lGB/qr9bIuYWgUEqIjZKpDgkXvR7yqgv79HDTtvfs=;
        b=q4hut//7AqQSCNoE4drvvCXyCA71m4mSsEH34ul2Nv9ZNnKTQqLGuMhgeEt+meU4sz
         8HGE1P2fm1dzvsLa3CH0bNEEgTKPqKmlBc5TWOF8xq05a17EQFRKwbCwanOIbBE4Qt4W
         CGnQODgx1ND0cgqkVyvWG0elDh6h9yvC2hpKf5fdq/EJHIazyT48Rx0UFuXpUEY7I4RF
         FMvJSh7XnS9AYdB92vOzLQ2Tn0ClAFdZigqnoli7g/JPM/8ZyZIdD1WWcMCKCgu3S9zZ
         5L7F5WJ5IVC+6iYI+ZdQ+oN5YxAcXBsaRmvuo4CMSBmXXsIqq0o8nEso+trxCx/tCY/+
         SThQ==
X-Forwarded-Encrypted: i=1; AFNElJ8BobUnEozLv1UKZjlkXQX5Y9QIR+eVuNuih6OTRR9p6HCU/PpZA4GXFWWWr7qVtk3Gr+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3O40y/On4C0gTo+JauteEeHiqHXT027lFJAxGb5LO4Sn9y7G2
	RleGDBUHgF52AqIbtzhbBCWZu7v0swcc2BtdX8Mw1fPHPDWQt8pg/VVZ
X-Gm-Gg: Acq92OEehW2T95a+tZ6DKzDrKnK24paBRoWs2Q8f/m6AU5KD5UKcXBmovqbaHdWkbE8
	YAE50TTkRfdlJC7tZJ54gVeFy5ZNhsMkfok1SY6o1hY0KE/4+JvV+smKv9auvtdOy9qkCfmncvV
	6ECPJRaEas4eEXI21Dk66AHGJyq6UMjHfa00EYtw9z07TmyXbKE5iwxbhXz0QxTplWSttzeY8ai
	2JEHCr46kI3E0t82IHp/u68dbb8T6isbR0XP/Lfwm7aS1J2VjRPkREQ5CY2gJKOs87gRa077XXH
	+kP+xSbOjMv4N0/5QhZacnHIuE7mVJY8ugsZH4S7Oq6b7gniVwlAgMBDA3XYWpqCo1lXQ2q6emW
	wtYAmL2tV8i8A08xoocnLmz6y42sWYT2/kl3pN+J4WJrmoCDboNLPnN4hx8p5niJAc+v61Ejo/n
	HQvU3uCEAlw+C1rUA=
X-Received: by 2002:a17:90b:3805:b0:35e:b017:da6a with SMTP id 98e67ed59e1d1-365aa73cc81mr13780678a91.0.1778254548466;
        Fri, 08 May 2026 08:35:48 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367c1b6851esm119724a91.8.2026.05.08.08.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:35:48 -0700 (PDT)
Date: Fri, 8 May 2026 08:35:47 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 8/8] selftest: bpf: Add test for
 BPF_SOCK_OPS_RCVLOWAT_CB.
Message-ID: <af4CV5itdz5Dzwo7@devvm7509.cco0.facebook.com>
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-9-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260508073355.3916746-9-kuniyu@google.com>

On 05/08, Kuniyuki Iwashima wrote:
> The test is roughly divided into two stages, and the sequence
> is as follows:
> 
>   I) Setup
> 
>     1. Attach two BPF programs to a cgroup
>     2. Establish a TCP connection (@client <-> @child) within the cgroup
>     3. Enable BPF_SOCK_OPS_RCVLOWAT_CB on @child
> 
>  II) RPC frame exchange in various patterns
> 
>     4. Send a partial RPC descriptor from @client to @child
>     5. Verify that epoll does NOT wake up @child
>     6. Send the remaining data of the RPC frame
>     7. Verify that epoll finally wakes up @child
> 
> During setup, two BPF programs are attached to simulate
> a real-world scenario; one is SOCK_OPS and the other is
> CGROUP_SOCKOPT.
> 
> While the SOCK_OPS prog handles the dynamic adjustment of
> sk->sk_rcvlowat, the CGROUP_SOCKOPT prog is used to enable
> BPF_SOCK_OPS_RCVLOWAT_CB via userspace setsockopt() using
> pseudo options:
> 
>   #define SOL_BPF               0xdeadbeef
>   #define BPF_TCP_AUTOLOWAT     0x8badf00d
> 
>   setsockopt(fd, SOL_BPF, BPF_TCP_AUTOLOWAT, &(int){1}, sizeof(int));

Hmm, so you do want to have this enable-on-a-per-socket use case.. Then what
happens to the skbs already sitting in the rx queue by the time
we enable BPF_SOCK_OPS_RCVLOWAT_CB? Isn't there a race? Or am I missing
something?
