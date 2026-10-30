Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361721;
	b=g3mTHRtsbWVBgr7VHTGARK3SPG+L1VQLiZiXduvYOjV8ry0pGVxE6ETPwqIUFTtOLRYy
	 1Nn6+WD6lfR4RaFPCDyJgc7auPVbJkNz8z6rQ6zHQyDKTak9F/sNSuyOuAVAd+FwR8wS7
	 TaPHq1M9XSb/le4ATIGuTzVDVxuXFnyxU/JD8IKfrajU6xQrcb84kv1ahYInNN9XNJoUL
	 0BpUu8C3GX38+hAi4INhtmbWwHR2FvgOm+JEBIbFp4Lv0/CX4jFzEewbcASMcnYIp40NX
	 Fw7XaMTdehmZ0oKNq9bhoj/1ryG+2qBQhK449tSAnEuKE4K8igvXZOvrbxCkYWfnTdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=eotohAuTIxTgrdX2GkJnACy0BcJ9VGXmEHUch3gw/Wk=;
	b=V3QJdFh/50LgUg4Lqzpx2ZWCTeVMbTeU4Cup1tOhlCAGIvb6nrdKWfYhi5XPrsyQU8gy
	 C5DW7Ebktu+AKT0qdfx98MO4xYnSMbJjj7zZWv0DSRkUy8+9IQ+0c8d8Qfd3WvQufpF8B
	 YA4hjpLvlsRGUtgZRiaqrQZ7h0pohkK4s6MA5HsZVeF8fSouD9+gTaOzqJ49lp92crlpd
	 lm9er0QNnhuUg9fGh7KAI5E5NtgKyu4m6ouX0NbWuGgie2klxAcIFYGKTHZF6yVu0+SdX
	 /jb+LG60Z4QcvVMHyBmHMSKWBmjhEGMqtPkwnZBAxmc7TBo60oaRgASgzjYsbZ6ZUmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=O04swbkT;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B61606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 12:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85B61606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=O04swbkT
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c43fbcb4393so90956766b.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 05:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793361719; x=1793966519; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eotohAuTIxTgrdX2GkJnACy0BcJ9VGXmEHUch3gw/Wk=;
        b=O04swbkThTGDeGx5khwvzewY4a5ByAgXASfltMMP5FzsS0MCCDUb3yxBTt7MKWJ3+W
         PyQF0ie/ewr5GhK4wX0xU/qCb8XFhR2K+NizO+2iBmY9iWwFX/auSnls223PYVDWsNys
         41xFtMeJHfvYMqLllH87zNsSLX7XKBQ4B1YKNqbTgBuIi45jipf26xjUt9mTmpwfd/ka
         Sfghl8Au1QFM9OkN9Wy/vOEuIcjfD7yGh2AiBqAu+NYMKin7EmwmZ0betImJN9+JEqG2
         ctPGK/5TzYXRj1hxSd2L8udUMZ/fspK5CaZElwCMXXCjptho3ju0b5GFDad3qHrs4s0L
         Uy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361719; x=1793966519;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eotohAuTIxTgrdX2GkJnACy0BcJ9VGXmEHUch3gw/Wk=;
        b=ng8LxYE3P7Ep0eiN7IzMZWqMmoPnJHJrJWyT/ElsHEgFVm7yOhprkkzt2/O3EJQP4X
         czBaEjhlTFL5tMIPGS+Q+6VUbKdOVkLYN3/ZxeXtJ6GycyoImyAGJfBoW5c5An1UJLeR
         F/6uA3ZGaAeXPmoWxZQwBnP/0K7/PnedoeZAShNqJ15i5JrET5H4IK5vBPwHp1qumc+S
         xCFkbD0gaGTgXaBu12FxQ/1LvSZtT3TNEM9vn7wqI7cA2C4YrUJsUmQ9RNeUg3hddeYr
         /oAl0d/VKAAtds5rsCbQ7c2Loat9lZdcYUuFc6+uJKyqdO/fSfB2ZZf5h6lVMnDzYVcl
         gwRw==
X-Gm-Message-State: AFq9FYL6d4CzveWS/9VSzfLo3bgc8hZ4Yxc6wR19JyNNg1NpMzWYdOqo
	YkoorZE7Og1WppVCle7No2/pF65oa6E1RG/Bff14GYpt5EreW3BNvL5bmRJS8lHkMMk=
X-Gm-Gg: AYBFou1AuPShp++xdGQsYR4TzXGnEwzOtJ9zUa7DrwfV27cmlNQqQ4EL6HGRq8BjL/c
	DPCf7Ha9TG8AFSzS9s1laQZC0LQwE6tZqRy7T30PgoF8ZmucuMzF+ENZqoUSZO5czeYuR2PBn9m
	RTqePlCBM8iDblsQqfeZhD4SsAUtj5z1kUisAIuyGjBUrO7uGF4j2hMGpaW2kuxx2dD9RU5kxAZ
	aRReFyfs+5RHp+kibeWA9+eNmi793rK8kEQFINcwzh3afS/C2rrkgEjYwb9FHRv63QxuZF3Qydg
	6FyMh/GAuJXiHA64I/lGGs4eyIPHITqo2GzXItGvbQ9aMXiKac19kDhzl/97Jom+miZBQlXE11a
	ujowLZUTiYyLyvkQFZW0BG5fFw1Bk8p6cw+3P2gUtfo2lu4h+xSYnLm1GTgGygvlYeXeNHV9LpR
	WvHIuGgXoe9HvePJIlhVKimIcMeg19PLhvyszldhJI4ilqzTwRcSJoH/m7xrU3twC6HFpA68LRW
	8qasWCT9bMCPYLZnPF0iU4ByrDYSrrEnR5uU+KcLdBANvUZgye9EzwDFGqq6Hc8JagMc66XLTl1
	0weAgU+MjvDoqQGAhm6SjnQNm7BFBGD9D/0gmw==
X-Received: by 2002:a17:906:9f92:b0:c29:4915:83cb with SMTP id a640c23a62f3a-c4ca7ab09dbmr187592466b.39.1793361718960;
        Fri, 30 Oct 2026 05:01:58 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:491b:1300:7cff:6795:2d76:e9de])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe0fd97sm58702466b.47.2026.10.30.05.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:01:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next 0/2] Fix psock update-side data races on
 sk->sk_prot and progs
Date: Fri, 30 Oct 2026 13:01:52 +0100
Message-Id: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADCH5GoC/zWMSwqEMBAFryJvbSBpRwWvIi78dLRdZCRREcS7G
 2dwWVRRJwJ74YAqOeF5lyBfF8GkCfqpdSMrGSKDNBVGZ1p1i1WOj1XZgQzRJ2/L0iDmi2crx29
 V463Q/E3Yupn79Tnhum7LtvLYdgAAAA==
X-Change-ID: 20261030-bpf-next-fd212245a771
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.16.0

Follow up to the thread at [1]. See individual patches for details.

[1] https://lore.kernel.org/bpf/20261022054811.35008-1-phx0fer@gmail.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (2):
      selftests/bpf: Cover concurrent sockmap update and delete
      bpf, sockmap: Fix psock update-side data races on sk->sk_prot and progs

 net/core/sock_map.c                                | 22 ++++---
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 77 ++++++++++++++++++++++
 2 files changed, 90 insertions(+), 9 deletions(-)

