Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF0B37DABE
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216491; cv=none; b=pmR66EGwFcDt9aGJpzuP3oefNsaAdgmSOhwLy8P7C5KIQcVt0vUCriXGTTHuQKiyCrAcH1110YjYtuThR+tmpg/Tpy3L9zC0sSkhnUv0RP6DzwUDB0f5u9uEufGAe/BLkFBcOMpSeaoGD933+1B2LYPSQdp97HrBI+VGaWsg8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216491; c=relaxed/simple;
	bh=Eq4lmYtrlAeF7jbc9Q21hlbnCp28y75gMteiOcIp+J8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dALv5+Ok3cmJ7Foh2gz+e/R1NSDjTREL3x0eBF+fENCpXoKJ8V+Jyxg1A+/+vSIk6hp/bznFtm/ItPLDKpjKt9ojsE7MyntKY5igfRx9ggYyVklZeSvjh2q0AY30ZvafqFwrpaPiNO5bwEnyrNeBm3cms1NooZhsEqOUdVtZLMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=QYyqDZGh; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="QYyqDZGh"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30749947917so1163459eec.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 15:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781216489; x=1781821289; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDEvOsRqYx3jPMtNGZB+BXNwwMMroPQVOwUd7G8FazQ=;
        b=QYyqDZGhRjmR8ZAgcg5eajd8tg/tsB7Fy4yv14lb0G50SZnfZSLOPA8keSp2ZZoenZ
         uOFHw024mDplnvtdZXk83TG3PpKCvej0ziTdrykvn8LvScmeaOp6z7wqSXzMRGlhnz4U
         HR8dZcclDvsUcT6qWDx3WS4i5Nn+l8Wn1+nBZ+tioJKCjcOWRlerlz6SzKSjmN57Dps/
         2DzyWMQF+1JQCuA/FXHkgkQ30wPi5e79l11WDZ0YswlJbHELjHcXSaQaL6fF+zp+qmRX
         O311GPJDV7dS5mfNLskCKWadwJT3je8T6Zy+IeW1+/umkS2BFna/bj8j6BznN7Mil/Nc
         YZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781216489; x=1781821289;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zDEvOsRqYx3jPMtNGZB+BXNwwMMroPQVOwUd7G8FazQ=;
        b=gE39PDE+yXMM+V2JQHWTZngrW0DH6v2A50iKmty23p2M2OZv7/cnoMBJPaOGAZP5vI
         Tj4sU7kCdyqSZbnVisgeTnfsvaKDBHD+rCSa8fCT6ChIljIa/XWpceT1OoRVVQViRl/R
         YQosxHt/hURj/G7jtN0C/PJTfT0d4cw6/3C765tSWM8zzS3EgYikGyUl6wRmcFoKeUI4
         gMNpefozLyEI0qMnCy2WfjilKsYzPaz59ej2c5GfxFaGasVhaMqIL2xUwgKQ4sckKb2B
         Vl8Y3xJL6omkAOb1R4BfnUJtiN799sz5oOHwJ4WriU92BtunTn87p+KDrwHedinclrNN
         plMA==
X-Gm-Message-State: AOJu0Yz3NTVHYRAgXYYf/ZXpEx5T+SN7zfJUHa18QA9Dfq5tQFarH5SX
	R6ALKn6WyOpH6BmeuzgUob+nvuJ5OuxaY0kPGbAdpo8rz2J6jPA77cf9OELjJFwb9JOA1eg7BTc
	UpGoZQbY=
X-Gm-Gg: Acq92OGY5p9NqAt1xRsObUS/OA4t4039h3L4qo5uLuYWfdIRcl1svPf76Gt+l/ltgUR
	BlyHMzIoGAMEwqDwIeP6Epzz9PPqMe/pJnl/VbDt1a/wCG7H19mtXf/Hl+eG+1HT1Q46dWlgQS/
	w541qGvWaCJmaPcRwzWYIbEHzUU9truWCSQIJ/KiJ4RrxoWCi571X3ltUObZQ7FRIlckwwRWGpg
	eYjZIEHG2iN7CUpMopaPykiNairtbXq+gD7YX02Z60cF48WnvNZ1PoDmokKIPoEldmJynubt19f
	PZ1Rxyl45Dc4k0M+9wGGUII7rzuwW8uvXPm3iHC0sQNp1MoOGsYhaNNGCjgR/8HafMtmIjQWRJt
	Z181vRU8pvHduRANoDZM9k9U9FpwcApPmTMjUDmnF+ej1AoaZMiY7fzqzHjo/l0MFtqRdGz7vo6
	2YrEsU
X-Received: by 2002:a05:7300:a484:b0:304:2af3:5ffa with SMTP id 5a478bee46e88-3082009836bmr153469eec.19.1781216488620;
        Thu, 11 Jun 2026 15:21:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::3c95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d810fsm616118eec.12.2026.06.11.15.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 15:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 18:21:26 -0400
Message-Id: <DJ6KJPBLVV1H.2LSWOCVZXNFZQ@etsalapatis.com>
Subject: Re: [PATCH bpf v2 5/7] sockmap: Fix use-after-free in
 udp_bpf_recvmsg()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>
Cc: <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611123538.156005-6-jiayuan.chen@linux.dev>
 <20260611125338.277F91F00893@smtp.kernel.org>
In-Reply-To: <20260611125338.277F91F00893@smtp.kernel.org>

On Thu Jun 11, 2026 at 8:53 AM EDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Critical] The addition of `lock_sock(sk)` creates a D-state deadlock a=
nd an unkillable spin loop if a packet is queued to `psock->ingress_skb` bu=
t cannot be converted due to memory limits.
>
> Pre-existing issues:
> - [High] Delegating to `sk_udp_recvmsg` on a blocking socket can cause a =
permanent hang if BPF programs redirect incoming packets to `psock`.
> --
>
> commit 8b4a0fe8904c1ee85231827ded90d15006435b9c
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> sockmap: Fix use-after-free in udp_bpf_recvmsg()
>
> This patch aims to fix a use-after-free in sk_msg_recvmsg reported by syz=
bot.
> It adds lock_sock serialization around sk_msg_recvmsg in udp_bpf_recvmsg
> to prevent multiple threads from concurrently touching the same sk_msg.
>
> Link: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e0.GAE@go=
ogle.com/
>
>> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
>> index 9f33b07b14813..ad57c4c9eaab6 100644
>> --- a/net/ipv4/udp_bpf.c
>> +++ b/net/ipv4/udp_bpf.c
>
> [ ... ]
>
>> @@ -79,6 +81,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
>>  		goto out;
>>  	}
>> =20
>> +	lock_sock(sk);
>>  msg_bytes_ready:
>>  	copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);
>>  	if (!copied) {
>> @@ -90,11 +93,17 @@ static int udp_bpf_recvmsg(struct sock *sk, struct m=
sghdr *msg, size_t len,
>>  		if (data) {
>>  			if (psock_has_data(psock))
>>  				goto msg_bytes_ready;
>
> [Severity: Critical]
> Does this new locking introduce a potential unkillable spin loop under me=
mory
> pressure?
>
> If sk_receive_queue fills up and hits the sk_rcvbuf limit, and a BPF prog=
ram
> redirects a packet to psock (placing it in ingress_skb), the backlog work
> might fail to move it to ingress_msg with -EAGAIN due to the memory limit=
s.
>
> When recvmsg is called, it acquires lock_sock here, and sk_msg_recvmsg
> returns 0 since ingress_msg is empty.
>
> Then udp_msg_wait_data checks udp_msg_has_data. Since there is data
> in ingress_skb, it immediately returns 1 without releasing lock_sock:
>
> 	ret =3D udp_msg_has_data(sk, psock);
> 	if (!ret) {
> 		release_sock(sk);
> 		...
>
> Then back in udp_bpf_recvmsg, we hit the code above. Because
> psock_has_data is true, it jumps back to msg_bytes_ready.
>
> The lock is never released, and we never read from sk_receive_queue, so t=
he
> memory limit is never resolved. Could the syscall spin indefinitely holdi=
ng
> lock_sock, causing any other threads attempting to operate on the socket
> to hang in D-state?

I think this is slightly confusing in that it implies the system can
fall into a deadlock permanently. In reality the call is only stuck
for as long as memory pressure is preventing the deferred skb -> sk_msg
conversion. The lock itself isn't preventing the deferred work AFAICT, so
once memory pressure goes down the call will progress. The "unkillable loop=
"
could be avoided by changing some of the udp_msg_has_data/psock_has_data ca=
lls
to checks that ignore ingress_skb, but I'm not sure if there would be
significant benefits.

>
>> +
>> +			release_sock(sk);
>> +
>>  			ret =3D sk_udp_recvmsg(sk, msg, len, flags);
>>  			goto out;
>>  		}
>
> [Severity: High]
> This isn't a bug introduced by this patch, but could delegating to
> sk_udp_recvmsg here result in a permanent hang for blocking sockets?
>
> When psock_has_data is false, this code (and similar code at the start of
> udp_bpf_recvmsg) delegates to sk_udp_recvmsg. For a blocking socket,
> sk_udp_recvmsg will sleep waiting for data exclusively on sk_receive_queu=
e.
>
> If a packet arrives later and a BPF verdict program redirects it to the
> socket's psock (meaning it goes to psock->ingress_skb or ingress_msg
> instead of sk_receive_queue), the socket wait queue is awoken.
>
> However, sk_udp_recvmsg will only check sk_receive_queue, find it empty,
> and immediately go back to sleep.
>
> Will this result in the syscall ignoring valid data successfully queued i=
n
> psock and hanging indefinitely?
>
>>  		copied =3D -EAGAIN;
>>  	}
>> +
>> +	release_sock(sk);
>> +
>>  	ret =3D copied;
>>  out:
>>  	sk_psock_put(sk, psock);

