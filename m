Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D173A872A
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617508; cv=none; b=fiz/CsFuyDmaX+zLVc58+ouZJW+vLuavZX8z+FTj2o6lVt/CfwpMo7lcbWDBYKkbWVMqiPQCbObgffISmsZH/HqNX2ZKO7E9bfOu9Sow/n9j5bm4OSuSJXtMshZGtT7TB2E8mhcbk+PR/4nLZvAcaEEhe1CLKwmJNqH1jSVH9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617508; c=relaxed/simple;
	bh=m0ESfkmOsyPlUrIt3fsGQo2uJhcnp73827mKcOAnU4I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fCN3nKXsGSdxSRV4ZU8AtF1WG/ANDZSLjhSbaY+IGB7wmpst6aamCptXMjBLREDGKRQIhNvLtJtd1gbIrwdUQX0NiZAEeWkb1xkcExBnsYRJ+SA1BAxP07nvFQ+sKXdjzWWOlTl26BXYUmtfSU64wDkQ90vQ0JB0kpl2AAb6PHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSPFhKiF; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSPFhKiF"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dea1272943so3192783a34.0
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 13:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778617506; x=1779222306; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0ESfkmOsyPlUrIt3fsGQo2uJhcnp73827mKcOAnU4I=;
        b=BSPFhKiF2MuZDv4KuDYw6t6ooj5ZT8vbvAmNfuCRrBuTswnjDiKbSpHHJe4SJTgsqi
         jvkuQQxiTzhpokJBH1HQt2wWAhMROgWbj+M7qgDf9DWFNS1IWUp6iNldEOx6w+W5Hx2c
         vARIGvk79d2EBmnAa8A7M0fGs3pgkmAIsceMUgaKXFTbtDz9EtNwLTB4IghuPo26aQ9Q
         AUbquVatt6/NvDxunHRUVMNjzPVcplcNf8Z+UdtaXZurt9dvON+zDtetPJV0jd9yJsUS
         jNySSaUabNYqDoizPk33jQvlVBnYyPaMJ4EhWkBNdcYPPq0zuM5bqBlblSVCU1LprmEo
         jLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617506; x=1779222306;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m0ESfkmOsyPlUrIt3fsGQo2uJhcnp73827mKcOAnU4I=;
        b=LVI6QXovTs/RTPqxeoZVl0L2gHSvOy1B8M7+LlLPsfPgr3ERpLmDhS7Uh2HksKSc+h
         CiVAPUWayXg7IJHjS3BuhjoJ+HRQpUX6jK1tv13+TybZ/nhovfAW4TQR3YGlWcezbm3P
         m6bqcox6g+4OfwJXrpP391J3b1P+7dUg1SSvwZrIM+dHUZylg3j4RNznixTqdoSB1h3q
         klaB/OE3LtAR9NxO5NRcYYgFP9Fdia01HMkL7Qsq+HReDqdPoUVX/IOHwR4R2BnvI6Km
         PoBv0Lh2DRz24NktEwlQCvArEDpA263EgB1nnY1RfQtmNXZhx70FCoZCr0mrjiJs5cI7
         6CEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bLPPZFcd7ohXrk5GmbinBY6W1zFK+rRJRIEfudTQQ19n1dPjqhJaHt9S+lq9sYPp+NNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTsuaxEvbzfarP2aT5fFg0d4utIqemd85wS/tiE+x58Xnc7KI6
	9H8xHIP7yQm/E8yboXHaey4rHEnQiseMEAeoqsofwhQgEhxIqUNVIttQ
X-Gm-Gg: Acq92OE8SNSJdH5nEJ2lTo3nGT/gles/V4kS7SqXYaPebLUz8laiBnoFL+b1/4+Ln84
	axrArVga1Y6Xcc5GLV2dl7MRrgw1NM6h4Z7XF/j+oV+tlyS2tpmankBfdfd3k34g7Syl6fsWNeF
	6tYAH1k1MB0FdjgzqKmmZbuKgcQkYKMuDKh9+msTDy0/8RJ6WNc9b4lng9GIiZVf6sA4MSxtLaT
	BLrkLiL/mpifTD0eFm/pbYY8pCes7fkjKJmgKBQzFWVE1AZU7v1Mx4CK6kyCdlQAWQ/BFWy+jTC
	NlRSAd7tQM3+kQkNaCJjAdTtuiNzVt6pZSqBMegtvVNetjw16DQ+C7sHKTzYQlVyuI93pZQD6gO
	K+oOjtvJPoUjLekCzAdb3QC2sg3Q7iQOpkcms/bJgNGs/l//EYbuNtFVa+11lwnOFO7oaTLKu6W
	U+YmbMfbXUFCjhP1h0bmevGceyE7byA5I0R4VXEC+Up4aqpwxdXnptNh2bftHa7QfbH32zYAhRC
	i84gVdNogRfbK2HzA==
X-Received: by 2002:a05:6830:44ab:b0:7d7:5b78:ef31 with SMTP id 46e09a7af769-7e3da0d1f5amr198517a34.12.1778617506540;
        Tue, 12 May 2026 13:25:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c04e66sm9540853a34.8.2026.05.12.13.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 13:25:04 -0700
Message-Id: <DIGZA9DICBXO.2QQ1V7T186JW2@gmail.com>
Cc: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <andrii@kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <eddyz87@gmail.com>,
 <edumazet@google.com>, <john.fastabend@gmail.com>, <martin.lau@linux.dev>,
 <pabeni@redhat.com>, <song@kernel.org>, <liamwisehart@meta.com>
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
 <20260511085344.3302-2-mahe.tardy@gmail.com>
 <20260511182019.69ebc7c6@kernel.org> <DIGBS3WKQN94.1YYMZM0K6CETY@gmail.com>
 <20260511193603.3ef00cee@kernel.org> <DIGD21MXE0XM.3CLUL6BVK74PK@gmail.com>
 <20260512065335.50647ee9@kernel.org>
In-Reply-To: <20260512065335.50647ee9@kernel.org>

On Tue May 12, 2026 at 6:53 AM PDT, Jakub Kicinski wrote:
>> >> I like this netpoll approach way more then creating and keeping prope=
r socket
>> >> within bpf and all head aches of keeping it around and doing send fro=
m
>> >> good context. With netpoll all of these issues are gone.
>> >> Just bpf_netpoll_send_udp() from anywhere and it works just like it d=
oes
>> >> for dmesg. =20
>> >
>> > No, netpoll is high risk / brittle and tightly integrated with NAPI.
>> >
>> > "I don't want to run a tiny user space program" is nowhere near strong
>> > enough justification to expose this API. SMH. =20
>>=20
>> No. Nothing to do with 'user space prog'.
>
> I'm sorry, are you saying that the motivation in the cover letter is
> not the motivation? It'd be great if someone could reveal the real
> motivation then.

AI makes commit logs sound very convincing, so I don't read them anymore
to avoid bias. Only looking at the code.
And what I see in this set is a facility for emergency notifications
that is safe to use in any context.

If people bolt crypto on top and make a toy prototype out of it
it doesn't take away from usefulness of sending UDP packets out.

I want to use it out of bpf core to notify of things like divide by zero,
arena fault, etc. Currently they are sent via bpf_stream, but
user space has to be there to pick up from the stream.
We cannot use printk, since it's not safe.
So netcons is the only option available today for 'bad things happen'
notifications.
Theoretically con->write_atomic() can be wrapped in such helper/kfunc
that both bpf core and bpf progs can call.
progs also need emergency notifications.
Like sched-ext might detect something bad and notify.
But at the end netconsole_write() is netpoll_send_udp(),
so more natural and simpler to just use that.

> In kernel sockets are used broadly. I accept that it's more work
> for you but it's also the correct way to go about this if you want=20
> to send traffic from BPF.

proper sockets and full TCP/UDP back and forth is a different use case.
Maybe it will work for Mahe/Liam. I don't know.
I'm arguing that emergency UDP is necessary too.
We can skip netpoll_send_udp() and let bpf core prepare skb
earlier in a good context, then at div-by-0 time populate it
with a message and call netpoll_send_skb().
Looks like netcons, bridge, vlan are using it, so why not let
bpf core use it too?
__netpoll_send_skb() is the main value here because
it's all trylock based at every step.
The div-by-0 notification using normal sockets would have to be
done async and that's the main downside.
We'd need to irq_work, then schedule_work and then send it via socket.
Way too many steps to do in emergency. If sched-ext messed it up
kthread may or may not wakeup.
