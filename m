Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0873C3C0F
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986561; cv=none; b=nrSLje/7Q+cQiby4oym9s5ltgg64wBQBY1Ex1wW7KJG/tF+bbVb4G9JaQG8m6mkewiRNDRX9c28TYDEbHGiFCDHNMu4bjZQ0uZIYwccyNw6Ds83MIFPWCwsDN931dmm0zKFlOeu7tBdttM3BON9b2oGl9gJf3G0ZOg9M8Qx6zKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986561; c=relaxed/simple;
	bh=4QK22JD6oH4SvxZHmOyYQJJkExZcrvgo8YM1Io2s18M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Oti6OjPRC0aZzxdmObUSK/v4HBnr/5TVgyS1STd/9Fmn5CjPPB/iL1SkrUXJNUYk8CiAnMMP952Cau9MjWKTZutLGCcYWPW4fKopEFAUtRU71HI8+ErI7sjYC4Qt2nlp4m3A2hWt+rlqSLRLvMsqEVoYP5yUsnk8ZtlUQf+LeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLL5rnvK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLL5rnvK"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so6331946a91.2
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788986544; x=1789591344; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oN/gqs4AWaGEOYc4NXETn7MgtPOtvKlXrZlfFK+KbqY=;
        b=rLL5rnvKxJ7bimUEcTFKJMabTEqZECh1pV/CVR3V0vpTtduiuEKKDH14JkcVkTV45d
         1X3JNvE+5ko7Ihvn8ahXUTqh0ngrHVK5lGNB80LtJbLAepPvIcFM1JmR7W9/JzK1UN1F
         QC+5ddYNQhk08DFWGt7G5OQaH9Um3qRp0mRQrHHmRFt7qa8UGAFah9fq/kLcOrB6CCXS
         K3m/RvXf9GUkV0CAhd10bPKJeQQfoPS/bl961dDJcTFxHNdMW7YgaW/VsHBK8wB5jo9l
         5OM4Yn+MEKIM++DCpv9cDPEnmF631Ws6RY9dWAaTFUE1h13FdtksuMFYg0h4sKT5NAoO
         vVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986544; x=1789591344;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oN/gqs4AWaGEOYc4NXETn7MgtPOtvKlXrZlfFK+KbqY=;
        b=qJktLSFqBpa/hFLpBPp+Rn967MqqqvfOKkHUtNR2rol1mCdftQcqEhUVZwK/FOo2rw
         LTZV+iwkld86+3uy0zI4Kd127Pc9JNX9IrsyDJVZ5HyLnfDxJdZkgnikxJqgxf6DQJHM
         Q1eCP84iJTYkNBXp2TmpDDG/pN7EhUUolwdPMoSBWEQ5Zhxv5qASbkt0PIv5iRwLw5t+
         M/XOZIMtxhEJ4ARGGPVLB7nHcNdvQXRp+Rb7u+GPP/q0oOF94QLXWNEOGw9icGrt/TFJ
         K66Pt88RV7swylZVlz9sg5PP++jKwLbCklswM7Fw+ySVGjtnzi9oMkc0dBLQQDE6QVGT
         2U9w==
X-Forwarded-Encrypted: i=1; AKwUvBw0uS7UbMu9I1SaJZIFXanmfWXuhoiU7j/Q0RMa9EKSa6vQhsqSck5yp2JqkOJIYQXVy/0=@vger.kernel.org
X-Gm-Message-State: AFuF++kNGkQI5AoO2W0wSxzdd0NeUBaNWaeFKxBiuyMH+ycrhKJr78xQ
	c9Id+SAX5sKsGygPswDOVd3b69SJDDGYqbWSiApgpKqBcvjekxyjmY9F
X-Gm-Gg: AYBFou1qaXWvz7RAWO0XKl2pdFHFniIGulQJ8SvXoPkgwPn0SGS7czh+JlA3mAzYQsy
	5DLDcGTwnVVDSvZymsumNjC/TvnvcZOIpe/29DGK3h82CXLQG3P/10vaibpcAR5i2Z3ac+NvYLP
	klNE8T0I2ayKfY6gJx5xsJw968s5u7PNkbTHFyWGYlIXlICCn7+Xhc40Ii4mO0oBEm33KmqKp5f
	IDsGP8zkB+qXpQhw88YNkAwJEJ3onSq0jGTivzwB6dSY3ECoi/aI1GWcg/rXLeM8k5kOcSyzewC
	SCBAD7CxPyUEh2wFY6LvF+T2IoHkklIVKOFpeWhNNxPnucpEFfnqfr/Lr18Kgv9+l6rcO7+BZAw
	WsTjctu20yqM42lDGDK25HDSZYCI33sxm1m1J5Owun/8mIFUV504pv0Gw0zxrFHUOEXe/ki+9TO
	+umNgIYffcD3qL77v37PJuU0htpnYX0MiqC2+jn1B/qkkhm6fu0qVnIajOSiu+BsHmZ8JDEVn8x
	vGvY+cjV5xO7VA/k7FCtSLCuTtILUO8sEJ4XPIOSCNai9b7sVDmGpLZlGp0EdwSO2MwQjIX5pe9
	gLMFZvYztF2BYhm1e51RKh5AYCksCWQnM1kHINVTJhcve2BxcK5zgZe91YdbIIWnB5OcCmrjCfh
	BqfIvHyqV31VbbAuSXjic
X-Received: by 2002:a17:90b:578c:b0:398:e6b6:acc2 with SMTP id 98e67ed59e1d1-39b261e7649mr58879248a91.12.1788986543953;
        Wed, 09 Sep 2026 13:42:23 -0700 (PDT)
Received: from [127.0.1.1] ([43.227.225.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d770a010dsm1270437a91.3.2026.09.09.13.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:42:23 -0700 (PDT)
From: Nikhil Ludder <nikhilljatt@gmail.com>
To: Emil Tsalapatis <linux-lists@etsalapatis.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, horms@kernel.org, dsahern@gmail.com, hawk@kernel.org,
 razor@blackwall.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: fix reading neigh ha in bpf_fib_lookup()
In-Reply-To:
 <CABFh=a7Z=heZODVsXwisY3VwULDy-Rq1hwO09exgX2d0-KzgUQ@mail.gmail.com>
References: <20260909024011.1252694-1-nikhilljatt@gmail.com>
 <CABFh=a7Z=heZODVsXwisY3VwULDy-Rq1hwO09exgX2d0-KzgUQ@mail.gmail.com>
Date: Thu, 10 Sep 2026 02:12:14 +0530
Message-ID: <178898653497.1776876.10402414041023036972@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 9, 2026 at 1:18 PM Emil Tsalapatis <linux-lists@etsalapatis.com> wrote:
> Bot is right wrt possible lockups, please adjust the seqlock
> accordingly. Also please
> add your full name in the SOB.

Will fix the SOB in v2, thanks.

On the lockup: I don't think it can happen here.  neigh->ha_lock has
exactly one writer in the tree, __neigh_update() at
net/core/neighbour.c:1495, and it already runs with softirqs disabled:
write_lock_bh(&neigh->lock) at line 1384 covers it through
write_unlock_bh() at line 1524.  A reader in softirq context therefore
cannot preempt the writer on the same CPU and spin on the sequence
count.

The same pattern is already used by the other lockless readers of
neigh->ha on the tx path, neigh_resolve_output() and
neigh_connected_output() (neighbour.c:1610 and :1639), and by the two
recent fixes this patch follows, 57549ab90791 ("net: bridge: arp/nd
proxy: fix reading neigh ha") and b824059a673b ("vxlan: fix reading
neigh ha").

Am I missing a writer path?  If you would still prefer a different
form here, I am happy to respin.

Thanks,
Nikhil
