Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012770;
	b=MFype9+Ocy8M8/9BZ4fZU6pcHTHONQit5FsW31P5EW/46CJHttRcrh7Y5Q2AwzX57oqX
	 JSLxy6n0yHj4cvW/4+t85cHzwbf+oS/0hlaV5LHUtJpZLvrk+2ZiIL9U3/XJomPicLTPT
	 IhVAlmzU4uFGMX5b80Matj2MRgzCmHvze1WRJAHa8fUmwsCg84bf3+NDPXnRK+0nzxim5
	 j5W6ckv4pmBF7KxzQd54nbdJFijbCcfVB8vzJm+7a1vWIw1hddyojhXnpwEij3NEdZ7Km
	 kd6sRqpI9GCBvXpbg6t6DkYRnkXLTOvBupKAxVzB5gUdhQZOJE1qjH1zM4Zbl9pM07A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=tTUSlvJBt7PDLOQ/Qfve+QTEq2GZ/zMWuOJTMyxeOhE=;
	b=abYfqJvyZGmjVsv3OLhcj131yQX91oRmXvj2FNSmaEe2pfCYR6ODnZxmRNdwVTrOG/pw
	 XyYnoYfGX1b3osTOwFiXHhUKFeA0fMfj/uc6oiqOU4jgorfrX/15UjAZnASAyXJdoYds/
	 eI/LUI3IhkthzmXI2rLCGqYAJoYwzKO8TYGCDpGYk4gT0HaFwsXaLTTUoHN6LdV5I/TnF
	 ElEG/2o4PNtaK2+4v7VTDtceVNa6AG0YgiVJUywVtvsdYa7FHNMGMFvwMHTVjvto553qD
	 ypG3Zc5q9mE0r9r1EEfYk+dRr7NHg4/OrPKHtnsp+eEgv7BsPcNaal834PZt4XGNi/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="h0HS3DX/";
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D6606A31F
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 11:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 512D6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h0HS3DX/
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e7ad9f78dso353530785a.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793012769; x=1793617569; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tTUSlvJBt7PDLOQ/Qfve+QTEq2GZ/zMWuOJTMyxeOhE=;
        b=h0HS3DX/AajEdG8H6zqVr5GOPIWtpAgYkOty4YtE1JUciY+UMFTUJyAw9+cv8fZl0R
         9DdUcy7w9DLvg/C3OSv266oOwaX5VzADbsTw7QMaLPCdFPcKa1Gg9YiRT5LLJQSKMFZP
         KguCMUVMrFs66LBezyTBn6l1yac7pEO263j4ZD6yvV36lsYlYFd4rlxzBnMNu+aN3YMN
         mmL7HITYGnEVmauzhPaCYlj4ud5mg1qwTtiOj9llVNQy9dAX2IRLPgxxP6UqTLrKPTFM
         X/O5g975nCh5irO6R5iusXMahvBxLZyApeJ5D7NtlZkR1TKDBsKIFSUQokfHQadp/rGW
         30eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012769; x=1793617569;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tTUSlvJBt7PDLOQ/Qfve+QTEq2GZ/zMWuOJTMyxeOhE=;
        b=2dYBliMOWSk05QRgAne9FHKTiizoaLcr5x7UuWIhPdcKloahFYN3Ckg/CCJBvDjuZZ
         gAgN15jwtTdJWJ/UX2Wp/s4/dlAQnhZskjH8d9tQmpigJ0Kr/1+5twMlmJzba2POnxjY
         bzU9kN7Pus/GJPHXlfr2omz86xXBEJWE0pSDMShPWjcl+4hWVbaKHjTWIpUucDHkDsF2
         fBB5cx2ZijwskRLVL1rjd9hcuLAnPNeaBgkoJwEEvfFGpNZFAIRJiFvvQhRjpbMx/DXI
         lhwZRxJeESe8V/dC/zb3CpGqn40ydf53j8n9euISvIaoGcqScsKrAv5PRLJUhfu3vY6K
         v36Q==
X-Forwarded-Encrypted: i=1; AKwUvBymEoftqzKS+7BWpHO3sUIT82JJ6Ru9KV7dwUIjwbdxyHZGGKylDtsQA9YnqtXDO+6W5jk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUJCxfus+J6HNQRo+xHWyTY2wz64dHQCeqpGRCeFLICC52ALP+
	nJ0e0qcfwfkMtHmGGYtD/XC4lnuAoTpncCQQeOLC7MgKxtivmCSgzuTP
X-Gm-Gg: AYBFou0ITqWflxQYTHjyg1LO9Jawlrw9a97eA16uz4KipQqRrV8bhCkVeR2VyeH6P7N
	93OBr2PSBNzsVElwoRiQpARBngAxSeQcSCXrXc/Zjf3IulKixWxQ6MnK5Rl7rEcqkumFRFQ/5Yr
	PRfpA5dcdMC8Z1XqbZ7wpJabBz2XYVJ4pfPl7dekhIp921ybVBPgp46ovsy1swMRc2zsqbwVt4y
	Z2X0wyXVxx0F4F6YtwkBHHJXgsSq3aHtSFb0myA+qtRP4omJCKgoddo4a9hubq3Y63tC9dyHMsb
	m3W5r2RjXCaad+mKzUZ1jKw9GpYpJqj8u5CZxGOwqLKhIDxw5wZv96FYTjBn0J1/Q9BnxB7VGpV
	9IUeewFGUiA3Nwa0aI8sKMXmdm6X27zuhScKOPhuIxLnP1IGUXa/IDbSbPanm5IOns9PfnRKHST
	Yk5zV1SODKj23nbIpUf7Tsxl0dWdD7+2eaI5tPIPM4fU36hSMqcUMpijJDMa8cfD3agYxbiQYTb
	NDkvbYIAgVbLyX6iRXWyodMm1QFV380B0ZRtHy+xqWDcdqicjoDxOY2ELyK
X-Received: by 2002:a05:620a:280d:b0:93e:c12c:f147 with SMTP id af79cd13be357-940ef955f06mr896905585a.81.1793012769242;
        Mon, 26 Oct 2026 04:06:09 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f067f330sm660111485a.24.2026.10.26.04.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 04:06:08 -0700 (PDT)
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
Date: Mon, 26 Oct 2026 07:06:07 -0400
Message-Id: <DMEPZAAH894H.2LX47UFLJTCQW@gmail.com>
Cc: "Daniel Zahka" <daniel.zahka@gmail.com>, "Alexander Duyck"
 <alexanderduyck@fb.com>, <kernel-team@meta.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Paolo
 Abeni" <pabeni@redhat.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Eric Dumazet" <edumazet@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Jakub Kicinski"
 <kuba@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
 <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
 <20261016220930.i32JEcqe@linutronix.de>
 <DM8U47F4MNK3.2V54CCQ9YTNBY@gmail.com>
 <20261019215405.OCzrrKYw@linutronix.de>
 <20261019190543.419e70bc@kernel.org>
 <20261020212155.47v0ot4g@linutronix.de>
 <20261020145038.4f7eb295@kernel.org>
 <20261026101117.YTmp0eu2@linutronix.de>
In-Reply-To: <20261026101117.YTmp0eu2@linutronix.de>

On Mon Oct 26, 2026 at 6:11 AM EDT, Sebastian Andrzej Siewior wrote:
> On 2026-10-20 14:50:38 [-0700], Jakub Kicinski wrote:
>> On Tue, 20 Oct 2026 23:21:55 +0200 Sebastian Andrzej Siewior wrote:
>> > > > Is there any other driver doing this?
>> > > > There is ::get_sset_count() and so on for the per-queue stats. =20
>> > >=20
>> > > You may be mixing up queue stats (netlink) with the old ethtool -S
>> > > kitchen sink / garbage dump. =20
>> >=20
>> > The statistics is folded on device-down into a global counter. So on
>> > device-up the statistics is still available. At least that is my
>> > understanding. This means the per-queue stats are lost and global stat=
s
>> > don't match the per queue stats anymore.
>>=20
>> Yes, that's intentional and recommended by the docs for queue stats.
>
> I guess this is Documentation/networking/statistics.rst that I need to
> study.
>
>> > So if this never happens, it might not be needed to preserve this. Tha=
t
>> > force-RCU might not be needed. This does happen on down and I would
>> > assume that the device is no longer processing packets.
>>=20
>> The (old) ndo for stats reading runs under RCU, only.
>> AI will immediately point that out if we remove the sync.
>>=20
>> May I ask why you care? Is there another driver you're trying=20
>> to implement stats in? I'm not sure where you're coming from
>> and therefore what to explain to you.
>
> I tried to be useful and do so some reviews and this stats part is what
> I did not expect to be "expected". I would expect per-queue stats which
> are folded into device stats on query time. Anyway. Let me study what is
> recommended before making noise here again.
> One last thing: If you replace RCU with SRCU then the logic should
> remain the same. On the plus side you would have some domain separation
> and the "synchronize" part will not force/ wait for the global grace
> period but be limited to the local one.
>
> Sebastian

I do appreciate the review. Thanks for the SRCU suggestion. I hadn't
considered that. Optimizing the writer side performance will become more
important when we implement ethtool ringparam/channel reconfiguration.
Another idea we had was to heap allocate the base stats and use
call_rcu() to free instead. I decided against that for now, because I
thought it was more complicated, and the writer side is limted to just
ndo_open/ndo_stop for now.=20
