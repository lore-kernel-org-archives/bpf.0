Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032946;
	b=l+n5HxJ0ZVhhqwDaBOJqE5EX1/85SA/gqX2keOxeicd8PwmkpI4Vld8n6kfmauddCAHc
	 Op5dY//ssAvLr1ddcZgx2Df/d7bd39krukoBUoJ6EmFghtBB8LQMexvve0pqAYTFZcAkD
	 SsHs52Zg/VDdWx2nYXFk7sIQZ1H+Uh2SqIK7oleaDJN+jJNPbuOVASRlIQNT0M2aHDrRx
	 f6ekxg9XQkeg3BSqI9SAE65gD/sOAT5Sbc1yOfM0Q5gPmFhGmOEC+u5jjGC7IhFPCP2Ii
	 1W5TcYNGQ+KqZN3KqRB9OptTouWJPJZVVl/n8jlou3IKstpVctSf55fisdY79SOhTIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=alE3qKWc8NVAdXHhS7gzmUz2VtKJvT/F5tzY0t38/Ok=;
	b=vXb7azevLSx8eqJ7LrS7nQMts1neju9cL1DJDIo9EgqSq5z5EpXDnY6c5E4w8u0j8aYP
	 dWwu09EBYUQ/qivqQ1y/jARM4b9S+7c41CiEB0XgcOz6Gewc3zUMf0XG91oS3KvicscQe
	 hjuLGi/iA9NEQR6jXqedA7IpNzsu514FwD4cKPVRzSWcPf2s7QaVlW5yjd3+HE9DJ2eVh
	 Cd9FYlZBNtCeZLy/QEP4UWOkg2qJs6BLjoN0v/rvM9ytbBqJ9X+Unc2RVGziiV0jKHz5q
	 yXMn/kJDsL8XrzsGnnm+sVguoVNplI23xfg8c0jEKFlpYeqmSIopMhHl3Trx0gx4Gbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j6ZLz9gc;
	arc=none smtp.remote-ip=209.85.221.200
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C0606A31C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 20:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B9C0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j6ZLz9gc
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5eac42e83e0so425410e0c.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 12:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795032945; x=1795637745; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alE3qKWc8NVAdXHhS7gzmUz2VtKJvT/F5tzY0t38/Ok=;
        b=j6ZLz9gcnoh/yCLGPw27IZQHM1iLGDhjgvjd4iKPziOV+l4XFss7jDz8l+hyNtAtMq
         GfaCWT27iBVt4qJOL3c9Nug3ryKOYKFTNZTRCotBsUh3qB2RXNCg+2Xjltth0ovj7WpA
         Wmra0gSUnqHGG0rGR1i+NwKCIQQrFOnco2u+bhxtnbdhCk+WwiXkuaym6TanSHA/NTVX
         MbxFDHRcxCmo9g3pji96KYGMuquJj/BEJFjYSaSW90ZsEnMNqg9GQuKU5MUiJ7H4kone
         9cmk/CwQTgv00udvQVaKJn1pfX6FtKcTxLdn9aC5cMaieM739MZn5UTu7P6Vrj4Zp9oE
         173g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795032945; x=1795637745;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=alE3qKWc8NVAdXHhS7gzmUz2VtKJvT/F5tzY0t38/Ok=;
        b=pBHgSHFXgfuUAveFm0ph76TMFcNnWntO4h61LxRiMnNutW6UVigGX7OU8yDr/SR7RR
         1D9BsLWnacZnqr7vSFzUvB+5bq+Ro+QKstuldi1Z3ji9CznzeA3VtI+IzJQ9Ed9FyYmy
         Vk1TuoHt8v3a/zifrVLggkWqkZSMdDscDVGAJuIUL/r4d1LE2HKlFjybsyJhk2QRhZ4O
         IHH6iVRx7Z7Wo07725ph6n6+PE2upqNYu5f4hHg8uLsRCJAIvz10id+FlF24ZDEkkEzR
         6r9qJYPd98i8wzw2UdAC2pPYbesPmPWfr78P689DJVVkf+54OCalcA1EM6kwGuPOB8BJ
         6pPg==
X-Forwarded-Encrypted: i=1; AL+hErHqVL6366TOzi2W3WeVDYjj9hj8J6FpgJiN88Qom5RX65A8YUWI6psJFhil5PaVtDvR+NY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VAK0jckwkEcyJSQK7PPOINACGSGp6+DNY8SbAu7mFGEKYCpvG
	517EJ26HHa7SDqCfn9VdUYs1owOgTHIEcbtlk3tVyBzdvBqs5qWLHVD2LSia/k/9cnYFHWaEgke
	vmFYNUMBQJBQx1fH4W3Am5t2jSw==
X-Received: from vkbed14.prod.google.com ([2002:a05:6122:470e:b0:5ee:363f:e720])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:208d:b0:5ce:76cf:fb2e with SMTP id 71dfb90a1353d-5ee6470544amr1998275e0c.16.1795032944886;
 Wed, 18 Nov 2026 12:15:44 -0800 (PST)
Date: Wed, 18 Nov 2026 20:15:40 +0000
In-Reply-To: <CAL4Wiir50_Z+m00GyU9BpRdAqgXs8V-L0S8kmmES=JiYyt==gg@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116023709.132684-1-thaisonphan@google.com>
 <20261116023709.132684-3-thaisonphan@google.com> <CAL4Wiir50_Z+m00GyU9BpRdAqgXs8V-L0S8kmmES=JiYyt==gg@mail.gmail.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261118201540.2446821-1-thaisonphan@google.com>
Subject: Re: [PATCH net v2 2/2] tcp: accecn: initialize AccECN fields in
 syncookie path
From: Thaison Phan <thaisonphan@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Thaison Phan <thaisonphan@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ij@kernel.org>, Olivier Tilmans <olivier.tilmans@nokia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, Stan Iliev <stani@google.com>, 
	netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 18, 2026 at 10:30:58AM +0100, Eric Dumazet wrote:
> Sashiko has a point about the BPF custom syncookie case.
>
> Requests coming from cookie_bpf_check() also reach this line, but the
> kernel did not send that SYN-ACK, a TC/XDP program did. The listener's
> tos/tclass says nothing about the ECN codepoint the program used, and
> struct bpf_tcp_req_attrs has no way to report it.
[...]
> Could you send a v3 doing something like this (untested)?
>
> In cookie_tcp_reqsk_init():
>
>         treq->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
>         treq->accecn_fail_mode = 0;
>         treq->syn_ect_rcv = 0;
>         treq->syn_ect_snt = 0;
>
> In cookie_v4_check():
>
>         /* SYN-ACK was not sent by the kernel if req->syncookie is set. */
>         if (!req->syncookie)
>                 treq->syn_ect_snt = READ_ONCE(inet_sk(sk)->tos) & INET_ECN_MASK;
>
> And the same in cookie_v6_check() with np->tclass.
>
> Letting the BPF program report the codepoint it used (a new field in
> struct bpf_tcp_req_attrs) would be net-next material.
>
> The other Sashiko remark (AccECN option carried by the third ACK is not
> processed in the syncookie path, unlike tcp_check_req()) looks correct,
> but this is not something added by this patch. It can be handled
> separately, no need to grow this series.
>
> Please mention the BPF case in the changelog. You can keep the
> Reviewed-by tags on both patches.

Makes sense, thanks for catching that and suggesting the fix. Since v3 [1]
already went out yesterday for Chia-Yu's changelog clarification, I'll fold
the !req->syncookie check, restore treq->syn_ect_snt = 0, and note the BPF
custom syncookie behavior in v4.

I think the Sashiko remark on the (AccEcn Option carried by the third ACK) is
correct as well, but I agree we can fix that in a separate patch set as it
isn't directly related to uninitialized fields.

[1] https://lore.kernel.org/netdev/20261117124710.1338951-1-thaisonphan@google.com/
