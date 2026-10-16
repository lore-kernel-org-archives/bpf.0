Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF53101A6
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163182; cv=none; b=SX/Sb8OdlOlb4t0Wn2LSK6I9yOt/a6bOmTd3IYyMumRgtRa1gWtka5SypQDWwjTdzD+1W9BcTP62/YTewXYGGkIhXdwmEynJprTA/bs+d6hxhzVvOjupaktd0thNqABo4+cLFQ2VrCbYw0hXzI46jjTJaajfzI3umZ5fjz1T8ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163182; c=relaxed/simple;
	bh=F9tVYstefVXNBFGdnpQ2yzC11l3f4oySkF0wmLDMJRg=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=YdT3pNouUXDs4/5JVbwIu9rap0i7VLcoq+E1PEyiYm32FjdV65qn6B3DstB4WHOEOP4PGqifaWcxecaR07wVZwvWkC5cA8EsosZzLR1d9kGU443cOAKMfWMTNzw6InsNKDEf5D5ekEMaK1qpnVdzOt8EhG7/kwDvFYjmr8O9UbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyQaJg3F; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyQaJg3F"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab9268d90eso66518a91.3
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 08:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792163181; x=1792767981; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R0/kOu9Vo/zJiBjLTBWedq2zmfz3+xfDwpc4EXkFj1g=;
        b=QyQaJg3FOWuUZCIJGv0XttYjGmZ7QcAuO9HnZkcj3S69RVeZoDzMSqQ7yFB3VQBxuk
         GCpm9cqT+Yi/4c9NoysajS4xVeTmckI7sLpwmSgbPDQu8qvhWrK3t7gQyTLRc37RjR6Y
         UD6KMTe8qEql7olxy53oYZuFDjXJywYsZ+Pt91ZbVvS/TZTdpNBfMzkTdXkn1qDrwj59
         Nw2n7M87O/FOnGbCMfQ/HVwk0oDpikubVWVsv67cZhS7gqsaZf1aSdgxqw7IkmgkhThr
         DY8fYh6XggSYtGmZeCQ3LNt9aBKn07h4AGNzAt9v8o/Smxe9tz0/XKUB1GtERWVpWzrp
         kXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163181; x=1792767981;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R0/kOu9Vo/zJiBjLTBWedq2zmfz3+xfDwpc4EXkFj1g=;
        b=MvpaZgdHOoLp0km+xHJL5+TToKhf0Zq1KVZAvR6Q4/nAmF+EKKAgxQFiIRTkMyHn6a
         pFoM+6Aba3sV1W80miC2Rc7mV/kDDzKI7RsS1FeA7J0TG+mQzMeXea3Gm5kuMfg/lc/C
         yFd1BTDnzQGlatmEciF5iFXOo4a8JaWmuKNZys5NCJRMP4HSIj/+ylzE81EuaiL9dffZ
         yVitt10zvz3Xs/saD3eAEwwCRH/lMpkRUDB67F9fnmJ8+Jxhv+q9Ix5oFntIDopqE/nT
         M+4iHGJknzmSu6CCpkheboCW9kijpDHnV55f6TuxDYDUndN0+E9PwuLmh3EX6ETtQWhV
         hf5w==
X-Forwarded-Encrypted: i=1; AKwUvBxeWlVge3kXwKWs7ACxfBVSS0nMZrPKlKTLdwdFlxNial9OmYfXiwfz0vnVpGhBE1Vxno8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKy/tc6m37So+nMN8CFrZBBIPb/W/2+C5Z88LZF1iDrpVr1o6li
	uy8Oynbom6u5g5dSAoYL4wj0Vo/wBTZVIkkxnS3BuOHVsjBKPBUyMNIn
X-Gm-Gg: AYBFou1lEeBwxCulhQJY8qF0Pr1jXYFtZFepZQGmjHk3Uz6gwB1Zhn0s3ZCvbSAqc8K
	3ZPZf0+YkZz9JdVhK9BiK4rpvpPwuOjP1deZurE8+2VLu9PGKuInNwgHmN8JMDhXzkJAX5TCx9l
	09I/D4VOWk5hNxIpyutcehS2HMRaQvOJq8woBh6WwMcjch95ZlB1rQJSXi64eNBn/ST62pPsi1H
	1wmHbo/wxjOzh06BWfmrngH85k1vo+cWArvmJRrULXUqNurDXxW4C0vEHCVEbw6T/2yYEYP/qcV
	9Z7KLaPPsHturXsUQQPsSlBNffTaMmGuksQCPnIdXr7RQhe0kWM3btn3T2dAN+nGZ6XkVh+mHW3
	49q1fxAlV/PDHoi5O3dweJQLUhFgddDCU5q5bSMAeKjremaH1obDyYIpBCuMRE9PT8U7JvkicBh
	pGGXx/vxbqEjRfncOt5PVryYR90XIanDNl50j2Cg9dAjdZEnrcaIpIl8INZgY1krjTNsupO/2MK
	O92nXqEfIiiLeDGzC80VLddqdPiyqW5UOe9OHGHKshKCNDYvoJ7dxU4V6RijU+6AA/2rUqYQIIj
	2iYeb0h4DRsNkmY=
X-Received: by 2002:a17:90b:17d1:b0:3a0:ace4:d2b4 with SMTP id 98e67ed59e1d1-3aceec25263mr109707a91.23.1792163180660;
        Fri, 16 Oct 2026 08:06:20 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05c9255sm1984298a91.2.2026.10.16.08.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 08:06:20 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 15:06:19 +0000
Message-Id: <DM6CTQQV55G1.1AU1HIBPQYW8J@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "Kaiyan Mei" <M202472210@hust.edu.cn>, "Yinhao Hu" <dddddd@hust.edu.cn>,
 "Dongliang Mu" <dzm91@hust.edu.cn>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Fix verifier WARN on narrow read of
 bpf_tcp_sock u64 fields
In-Reply-To: <20261016111643.247553-1-jiayuan.chen@linux.dev>
References: <20261016111643.247553-1-jiayuan.chen@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 07:16 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> Just disallow the narrower access by matching the whole u64 range of the
> two fields, so it is turned down at check time:
>
> 	invalid tcp_sock access off=84 size=4

Pls add a selftest as patch 2.
progs/verifier_sock.c already has
"bpf_tcp_sock(skb->sk): tp->bytes_acked".
Copy it and do u32 load at offsetof(bytes_received) + 4 and
at offsetof(bytes_acked) + 4 with
__failure __msg("invalid tcp_sock access") __failure_unpriv.
cgroup/skb is loadable by unpriv, so both modes should be covered.
See
commit ba578b87fe2b ("selftests/bpf: Test invalid narrower ctx load")
that Paul added for the same warn in ctx fields.

I'm hesitating to apply it as-is, since all earlier fixes for this
warn came with a test.

pw-bot: cr
