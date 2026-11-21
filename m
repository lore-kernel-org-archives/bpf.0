Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795226825;
	b=dKOkyrsv+YqolMxJLLeAP0cTH9TgmWFmO6RKvplTpcso1oWS9A//EpOm4Mu9pswAZsQe
	 K2UiCoWVIviBOqjzHDIV1AfCHs4pb+VZkTEvs2IkrWA0cFc2JDw2OHh5wqNLmhvfNIyur
	 bz1ayo64Uvl7d9X5wS3/n2A1J/5KqRfXX2vKnoG5jPYQw+gsNCgGYrcEwRViQ8fXJMxyW
	 eErYqmFSY2nDMjHeDIAk/ifkh3rucjkcnwP+076cYnHKL03HpdZUOWtLoP+Rzh2e9yRyB
	 17C7RukHIC3Wg0gG08Bv0thtGw54XhewAfFfnvU8pZCdPn/rJQhyy7Sa/O8F7+GCvqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795226825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=vVLuUuI6K1ifz1GqKSYzHprCpYxeZl0+IrxVN2vu0Ng=;
	b=Wb5ESj3daTs0H/0iimzN6WG1d4F64qnj8oDHf3TRIMV/Vza7HXHnLWws66alPJVr//6V
	 NLOOmJomRe2ZFtg6XNtgvsJyM4b+WCINF0xt1RQQJq/sDzg4oOSl/x0y8dONh24wi2kXY
	 6kGs7t1vGtc+vkfSI5Lqieg0gkQkPSHxnMWa6CCZqSaCr85sA7IdVvKLOBF0xX0QWVmKo
	 aYjIeYA/cNcsAhnZ82ulCwGBo7MN9+LCy+d4svoWMeiPu0iOWrg18FW3GhFf8OUCFSxz9
	 rryuZ/Oy/QWJ+2Xc/bei+sjGx77+CU2g6R4gtvcPwDM61K8IHxJf1qj4hnFnRz8Irlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IdnzAlce;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8C606A69C
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 02:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BD8C606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IdnzAlce
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f0634667aaso1317745ad.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 18:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795226815; x=1795831615; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vVLuUuI6K1ifz1GqKSYzHprCpYxeZl0+IrxVN2vu0Ng=;
        b=IdnzAlcejCgRfV1yTDlJ7JIXQKOF3i9fDJ+P+8gEkJZsOhEe4ALRElG8HRM6exjIny
         NopIK4jtjjEpBRi6NrLDXdlevi9shStO7+tGo8DRFcSB5vv1jJJkA5cquC0yRkXk2cQ4
         wJxXCGenDy89ljTPiX9F/HOX/pim1azvz5SwQ+TrLiNTS1MZlvqrtV+jk8rwb92LoklP
         f7Eq7UBwWYIPUezJ8AO9gyKpqjBLajm6oyv/pZVxcE6uSMpPrR4e0WIybPl/MQWhJ/kt
         O8xL4r5EHL0acB/ce4nPFbfXE7FBybhS0/4jnshnXsMcOimlXzKPzCvpXNp8VLXNQQDg
         8VUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795226815; x=1795831615;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVLuUuI6K1ifz1GqKSYzHprCpYxeZl0+IrxVN2vu0Ng=;
        b=WSGdxdZcPltS/krvySG11wt9YCMXafCV5CzmRl/HOYrSIvlOX39NYfdBS2yLngkI2+
         Mq0W124F8i5VJzUDzGBbUUdIBfn8o9rBSQr1Jw0rjCtod04NyOJqcnVPk3mnjEw22DUl
         xu7IHv5miAeDAzarotRxIqb4gpTLSiMnpsJ+zv2jCLjyRf1BP198xq0WvgHv0JAVVd+P
         hXKo++SFIv9TECIYZn+54jKmnDPpE6/dea1aezno+3gPh+hIx19VDK0muX68PiWkcgyb
         If2TOysiwlZx9UfIJmVE2b9hEy8FUPBBH5EhQFoe6fh+Kx2fZi3/D9iKP9wnKczTYKX6
         sunw==
X-Forwarded-Encrypted: i=1; AL+hErHpCP4vFsaxcuozHfxx9uml31Lrg3BAlwZQC8zZG+RLYeaaiYKPLBQVKAhwarKdf8Zqmj4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/H5Z1mrPbSvNfdDC66GJr6QzbIgGn/mmFtdLDVnDCdNKzh8+EJ
	dPUIZiI7seuVpudqVLC+RueG4eCGZdjAut0kj8aHlFm/QVOOlSM8z/vR
X-Gm-Gg: AZFdTZcsYbJKZlJDOBgkjfZMQ3L5rANpQv4V5sl/eKCf7heF/jHqBRqpBTCU71XPdvu
	JwJehw1JWEGzoILtFUx5c2LA5eaqJIx3mBukzSgFK0dI9SJ0glv0Jp712c0t9Y5GmGWtHMib5oz
	JRJmtwJ60Yya/ZQMPf83HdHt2cjZzMmDWXkt8+oLl5CXun2d35h9kCXkZqFkEqYW5BgEK28K0bY
	NJHrzjm/hLhHMsZXX/qr4khlGyflJ2bv3ZfCWMhs1krVTyFOdezjpEf/OqVhr77CN0c+6eBXl4o
	d2KQjQSxIUGmDZHaxBP0Lnu8YUkcLlAsZ0U+ELaP0tYAeFv8gKJKeEXG/R2b44RPS2EAPWVJFQA
	LTwlq+oY48drrl2WccW4dkZp1KZbFuloJB4HRlRX46Q+5lWo5rCSjfR9fBy3nqH5Zvrn9jrbYFV
	vJNls2xkPYkr5GzoUAh5DPNOFXhbZsNQaaWUT4T7jiAXn7PvijfJ98vipHqbql1JJKT21vHWPBR
	uRB+pXs5CNfIJwhlQ//d+YP1WHyjiWl/XQXJNC/HUOjVk6MzeruHqXr8G8KpbXgSHVm0aMMq1A/
	lejJ1MV1Mws7bZTwsnDx7837OAn1vNpFXdlagXpfo4Rc1MXkvLOhTZq3qFoJxNj9aJO68JADwOP
	sz1Ipm/4II4ilheYGJLymTdhbKCja4tNPL8y1djUHpM9ZrS+SjVxc9Cit
X-Received: by 2002:a17:903:1c9:b0:2e2:d3ef:125 with SMTP id d9443c01a7336-2f03efa3ce4mr35706575ad.5.1795226814533;
        Fri, 20 Nov 2026 18:06:54 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dcbe3sm20984035ad.28.2026.11.20.18.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 18:06:54 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Nov 2026 02:06:53 +0000
Message-Id: <DN0ISKVFQRMA.2NQOCMINC8LDX@gmail.com>
Cc: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
 <pabeni@redhat.com>, <edumazet@kernel.org>, <horms@kernel.org>,
 <davem@davemloft.net>, <shuah@kernel.org>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <willemb@google.com>,
 <petrm@nvidia.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: don't warn when bpftool is
 missing
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261118165338.1064930-1-maciej.fijalkowski@intel.com>
 <DMYSCT1OYI5F.2HSYP9MZ2BRJU@gmail.com> <20261120180307.363312fd@kernel.org>
In-Reply-To: <20261120180307.363312fd@kernel.org>

On Sat Nov 21, 2026 at 2:03 AM UTC, Jakub Kicinski wrote:
> On Thu, 19 Nov 2026 01:11:08 +0000 Alexei Starovoitov wrote:
>> On Wed, Nov 18, 2026 at 08:53 AM Maciej Fijalkowski <maciej.fijalkowski@=
intel.com> wrote:
>> > Based on the bpf-net-xsk-move tag so it can go to net-next and bpf-nex=
t
>> > through another shared branch, as Alexei asked: =20
>>=20
>> Acked-by: Alexei Starovoitov <ast@kernel.org>
>>=20
>> Thanks for the quick fix.
>>=20
>> Jakub,
>> could you make another stable branch to pull?
>
> Are you sure we need to fix this? Do we care about the bot?
> We have a similar warning for having latest version of liburing
> in drivers/net. I think it's useful to let the user know that
> they are not building all the tests.

the bot seems to yell every other day 'regression' in capital letters.
I suspect people will notice sooner or later.
If you think it's ok to just ignore it, then let's do that for now.

