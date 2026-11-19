Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795128050;
	b=C1wuKk5tSSatTkS9aSfsenvgPE1vxrhwP/WXX4e/lu98t18yc6CVRybeBIfpyGoRNx8d
	 LQWvV1eJO2f5x+MKbnRAL+2XwaaWCplO3SR2Msw055BJXQP9gu2WpeCvBUfWtEUghxY0M
	 Bn6WWPc92ZpWZrREq1p7w8hbIOOVnIi2PUNUrnFjEN44nWXUUIjygC9hEpbP8bsNdw+RY
	 FAu1y2jS1nbwj9ONKH+m5awgbyfpqzLk9MEC4yk3gh3iWDY0zQUBmleicIZlwmqkaGQXK
	 Yeq/Ku2gP0CjUluMWN5xymSXbYV1wHSZQg0F6OGjkIbFmt4mqWLtfJpZVD5igjjyrlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795128050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=KX9gw45Ko3F9cAwUcCFt48mDU8KoNsjYHRyjJHpt4Bc=;
	b=DXA3fYSYKqiQBordXnGOZdChQ3envAP2HPvoF8qZMFp9icMQGdFTgxSSQYCKyOGZpwui
	 5ow2x+M+opsOzpYs+jWTh+C54jnU/jbKOR+mk5jbjo/ubddiRmpHC271djHDVdN1udAF+
	 WAuVYCi4lgJPOTF5J+Z96snTZHaPufQPMurCjwrLLdZGIP9cmoOtYtuCDH3FVbgte86oH
	 zq9TqOmHCabymLiMiVnLjrJQHHQzug2wpyDXobqOPmjXqCZaUBrtyM94199a4vtG4SaHh
	 Ix/JlF0fcEjrdcqI+Y5RTIT7aRAOIo8Ibp001IGfvXfiUBXIw6rYEBaq3XWyyc/g+OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=na+1krtj;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7E606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 22:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43A7E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=na+1krtj
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f01f296937so1935985ad.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795128049; x=1795732849; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KX9gw45Ko3F9cAwUcCFt48mDU8KoNsjYHRyjJHpt4Bc=;
        b=na+1krtjpl97nonC+fYj8Es1zVRSHZFi4IbHb4lhBhypuCekF9blk9Au8yUEMMyhp+
         91UE1d+FiU8OT017SDU1uYXndmYODI2IBUx06hyb7PN/8XolRV/H6i0hYbOf+P4nTASN
         dyyQs1F4l29D0mZ0pKvDF5r0qhSvSXxIupn/3CNNBekHhyT9KqjawODq/FkX7iBCo8UX
         TLrnOYOAw6rsQ2ANan2mwUiaL8YIyOmfeUIXvhizb0OnHIjn3t7KpgotYL9rgLi/N13F
         dOL3DEyfqGy7uKVu9p25dQIIX+ezcpyy8yIbqGUv4N6+ZmJHvN4347vMmqgMvJ6Lm0tZ
         VCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795128049; x=1795732849;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KX9gw45Ko3F9cAwUcCFt48mDU8KoNsjYHRyjJHpt4Bc=;
        b=qbG/F3GJcA6wzz1N4kQMyZSNs49BfhgRCVRa0PNJEurSYwf8QIIsAkHlWitS8uPgy7
         ktA1DTtyewTtDOEISb9fgS4mujoAHp9PX3Ptp0D5zFEx6wwVV8zxKyVEsjE4T9RfbqtX
         5AvB8CW4BqMBXPpFkwcjPiVw2EDGMkVnL6OOpbh3MeeDJv4PdAetdTy0QEJqiZ3cBlK0
         PFesbMxnVsy1xWRfKjvia88iqa+TZ6H5C8XeZbKwu/IHm70mUD/nMaPKNYMvpmxWtKS+
         3EBzEbHkPWWpR/7PgUkhZG1TuIY2Ixs/jiWkjTictpoDJYiE9XnlaH1+V4JVXFBaPKUC
         CCMw==
X-Forwarded-Encrypted: i=1; AL+hErFQGWbhaXNBc/1t8zRj8zsUbdVy12ewZK4owKnx9oVm1jQipiBneruKc07yYzny0Nk2InY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MhU2bLFEMkoEFjU0L0UlBT37bYgMSReFVk6pk9Xv8+LoSDWcD
	lefNjcAJUHusYU2n4TkbUVJukIegzEuNlJrLHmWwPJO1JuA8vuRjbyuu
X-Gm-Gg: AZFdTZcZV6o6LJHRXfh1Q+U9Z+mLJlyvLFrIUFjnnZDGvpAy0eALu54zxOSIaM/u9qZ
	SDWnTb+sTbHTQLG9qaaEQpDzh3q8odEUWOegaeZTUKnWndxth0t4JK56lBqhhOCOBZRMKBzp6Xx
	4uaUkTPxCemORhi86nVRm68/kTZtYMuQ8mniFr4Tl65jyln4hfdfZXU/r6fi+MDsvec4TOwHpfk
	0gK8O8PHP9TWt0OpfxlFJUlYiP6hKIoL7XWiG6Sv6NR7Bptl8Yr8cdQuLQIYFKFoPsMQ73mBB0B
	wdd5/gSnE5uduUrnsXG7N3XISHTXQOt6iQkz/pixHgfpuupjVhjex9RtmpsWL/a8gdd6qIiLqi2
	uvhcOJFKkkdfYAvyOxJ3aPOQpmHWh0wOGDo7HRAYGFlVZOs93Qfce5Y0gGMePjpYqBvk+BsLN32
	1/ETZMvoR8QOaTFMiB/eQAm+5xvRPMFVjy+JZPTi4glyaxaoZfcrwIm3Kzd+JgU3WnrKOIr8xvH
	x/VxFU9GcHO1X4377rJyXLbnaknFhDv1VCWN4ihPK+3y4mb7/IHWtdujP0G3dXuR7yooWcRFnQu
	ZJ5gIyidvdhCqNkhe7OCo7/Br1c3weZZ1b/sdkwOC26QyoKKHsGGE0oHNbuoCGbGJgZ1yzljxci
	ZqKdzmnUftSb95KyJzq6g2lGa4CJvRrR6vA==
X-Received: by 2002:a17:903:228e:b0:2d9:216a:cdd3 with SMTP id d9443c01a7336-2f03f1cfe41mr12272775ad.18.1795128049336;
        Thu, 19 Nov 2026 14:40:49 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1482c3sm5251995ad.73.2026.11.19.14.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 14:40:48 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 22:40:48 +0000
Message-Id: <DMZJS8O5A4YX.9T2P4DT0DAB7@gmail.com>
Cc: <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <martin.lau@linux.dev>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>, <davem@davemloft.net>,
 <edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <bpf@vger.kernel.org>, <jiri@resnulli.us>,
 <victor@mojatatu.com>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v4 4/4] bpf: drop the stale dst when
 redirecting to an explicit nexthop
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jamal Hadi Salim" <jhs@mojatatu.com>, <netdev-bot+sashiko@kernel.org>
In-Reply-To: <CAM0EoMkppFKECwmjw+E3tWpXEL3=cyg2VYhgpL+StaSiQf+WAQ@mail.gmail.com>
References: <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com> <179511856597.3136.7846835490904436138@kernel.org> <CAM0EoMkppFKECwmjw+E3tWpXEL3=cyg2VYhgpL+StaSiQf+WAQ@mail.gmail.com>
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

On Thu, Nov 19, 2026 at 12:29 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> This is still under discussion with Alexei  - so:

Answering your earlier quesiton: 
yes, a route for A is acceptable on a frame that leaves B.
bpf_redirect() and mirred egress do that today.
__bpf_tx_skb() and tcf_mirred_to_dev() set skb->dev and keep the dst.
__dev_queue_xmit() drops the dst when B has IFF_XMIT_DST_RELEASE.

> I will consider this feedback if we have to resend the whole series or
> per Alexei's pov 1 or 2.

imo 2, 3 and 4 can go.

So pls consider adopting my earlier neigh_update_process_arp_queue() diff.

Need to think more about patch 1. It's probably ok on its own.

