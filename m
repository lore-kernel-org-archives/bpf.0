Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562883;
	b=1LkwY+7MvipRwXCjgNxoGvwSHxfoGJzX+ovqFs64IvcHEjO0KUyx7iGWL3TZHg1UcK8t
	 9Bv5nib8vyMdfPcbA/gXrKTl55N1TiyPyTxHaa6uyx7bS7iYd/DbfxkQ4wM6HoFYQtyd5
	 waC0uKm2l1zIoJ4/Wix8GHM+Wt5D60P/0MC9aOy32241DBY3G6ykkpdr1djqUOSzgKEvy
	 AwyOqKHEHczP04xuxaodcQGO+tcmfqCeUuZzEdomrF60uqS8Tb4wCACUrHKuZSCKG776S
	 lWlxdMuGT6dzkDC3VPAlTvwh60ejwT3yqV+N96Q+hwDokQYoKZkoDZHzkU22mq85YpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=FdD8nsrRzbhjr4E3zr0vV9y7hTxHd4p7KVaJoR4GPPc=;
	b=BsG7jzVGV6HAgdhb8R9y5Dey/VcrAHFx1Y2x6E5g95fmSc1M2r+zHrRAHJGoD8VncrV5
	 EeAhEjHK+X6pf+fJ55ySPPdOMlA8KB0+KdgcrrnCDiyuWfFGIsMo6SS7KpxpgZ+IPpmUM
	 LzZBukpUs9m32CyEgNVCiZ32X8ayFqFdEJwbgl7ic+Q64cRNbD/6kK2vrbvuxCWN6XS6c
	 buvhQXFuHzbm11nIrGjXvoG5NVeKg0Wok0QJz25U6yH4b5UUkprrIWrkZQ9mQRYSZlEM9
	 T49tY0Db37GnWNftjBNyXjBCxQE4rM9OIdcqOikUKkesneraMwkKjOYAbbjUxLS+SNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+nyoquG;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A0606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE9A0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+nyoquG
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f046b0adc0so27837095ad.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795562882; x=1796167682; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FdD8nsrRzbhjr4E3zr0vV9y7hTxHd4p7KVaJoR4GPPc=;
        b=z+nyoquGn02pafXKCrdr3Klc70j/V2CGP1tfLUWX99+u6+I8AQM4rTPVVJOLTTCqk4
         KZq3fqF7MnYuoS/E5OP6DCEl1dNF2FXUNQKnCa33epliUESnZbONB1veRdgYsTmHe2lG
         qm4cU0xVdcxJwS6PQUHUUNTde92u1yhhObcq0W1n4ACHAnWrNPptnbyY0ad9VsEOHoKy
         AtTyAxOfPBTuljEBcmxOk/ue26foe2Q7q86H+e/qn3BI/gKKw3zPsE5y3xWA/AVWZeI1
         7GKaH9yyK+uUPZbcKAOEJYMmzScNmB8t36p8LCSrpUFg7Z78wnS29XN3esVKd9VllLeP
         /pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795562882; x=1796167682;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FdD8nsrRzbhjr4E3zr0vV9y7hTxHd4p7KVaJoR4GPPc=;
        b=ykje1CMeRKzt71cYQyazyqe1A4m+far9h1A9RQll+vY3mDTkQ1zD0ChpOsOmBNAfk4
         hCWZUhnXyaIb1aY1l14aZvpvtD/xmyRYl/xKvLGwBc39f7Iw3GLN+9lLWlC0jglGtPay
         N5BLiOD4tMjkkoadi+z0zLSWJp/drN2CXZL2QVY3rKPqlQBahawhFwCeaRqK9+X/wNkX
         xzDv6SSOosBHiTUNScDj/EpXxFGxrSaaD6rIxfobVxiFewQVLDlFS15sGOXLjz4EWstP
         as7Of1dvg2lh6WZjy//ePzhrsUBSZM1Ml3hcWfz0H9c+WKl5z8H9AfwwXDMvUoHTAfAh
         gDoQ==
X-Forwarded-Encrypted: i=1; AL+hErE6zTBxwjqGunUcVIchsmfZQ3dRvXWvVsP5LZCGdvfnlaVBXUYB0u+ZrKzNX6X4FBTLL8Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+o7X4iGtywtQlMD68wT1XcTx63PJyUTOc2M4A1nEz9GOnUsFTh
	AtLNXdpHgEQFlMTfXTWk+qMzRgZoTO6y1dH2vTlX338KfTqXj/55U6aZ
X-Gm-Gg: AZFdTZdU2xin1CONpn8TgdnoZoncJdh+B9P3TLFkgwV4GRlVkRiWhmL+jcQ1lYjCfqN
	9RbrlGrQdgTnLUsT+Kx/yKhVhScOvGZ8nAEBHr6Irrn1gfjQfZO7qflE54x+6Afj46cojowzeHa
	cVB3d9epNxhMTOwCTro+7vRWT80ojCuDIG5zYyHjPzt7ajD2cA+OMDm2BmHH89h2yOTDcX9k23N
	xXvce7rWUK8eURwuWxWH/w7VCnEVdfy+CK/r/AiSLshb1OPoxKgPxAPstqAr/DeqRb+tZFpTL89
	x2S+CleJvjqyd7h2+iytSKbeavJct/8iNS0F26ZAYhJsTdbpzZleA961dOMDsPREQiSeZ7N9FT2
	8i84Adi4ykmXirqQbjom8w+PyVGXNoCmaQ0PLRQy+JzNKOfL1HctDwiC46zT1gDGL+suM/YRdEk
	cMKMBjXCSNyHdkbFo6sbyfy/7+bdQiT3GLWY+eGr7ejA6/kZrfC7349NThQ2q+u2rClRSElwgoV
	NyNRqnx4D8ybuCK/WWM8fODIs8iSl4jy/w4bIl3xstjMbWC7aG8MNIlf3CUsm0kVlY8YgWY0Z9r
	tumK1xQ3X+TWOtsGfOEtxq3V8tC60keaFysjHkFoYIF6WoGnRrcfD2/JvJwePkZhVqReh1aIJU9
	FWJH1U/bnyWRJXCQRmW/xKMzLkViqMhPY9g==
X-Received: by 2002:a17:902:e80b:b0:2ed:ef1:f78 with SMTP id d9443c01a7336-2f03f11824amr157910985ad.21.1795562882035;
        Tue, 24 Nov 2026 15:28:02 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f105b66sm76166185ad.51.2026.11.24.15.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 15:28:01 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 23:28:01 +0000
Message-Id: <DN3TX43KWXO5.JWLJ9HO1C9K7@gmail.com>
Cc: "Gwanhyun Lee" <gwanhyunlee@gmail.com>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Jakub Sitnicki" <jakub@cloudflare.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] tcp: avoid NULL skb dereference in zerocopy receive
 with sockmap
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Junyoung Jang" <graypanda.inzag@gmail.com>, "Eric Dumazet"
 <edumazet@kernel.org>, "Neal Cardwell" <ncardwell@google.com>
In-Reply-To: <20261124230228.3868519-1-graypanda.inzag@gmail.com>
References: <20261124230228.3868519-1-graypanda.inzag@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 03:02 PM Junyoung Jang <graypanda.inzag@gmail.com> wrote:
> Check tcp_recv_skb() before using its result in both paths. Also stop
> before advancing beyond the last skb in sk_receive_queue. Neither
> check consumes data in the sockmap ingress queue.

This should be fixed on bpf side. Other readers trust copied_seq too:

  reader                             with stale copied_seq
  ---------------------------------  ----------------------------
  tcp_recvmsg_locked()               WARN "TCP recvmsg seq # bug"
  tcp_read_sock()                    frees new skbs
  tcp_collapse()                     BUG_ON(offset < 0)
  tls_strp_load_anchor_with_queue()  WARN_ON_ONCE(!first)


pw-bot: cr
