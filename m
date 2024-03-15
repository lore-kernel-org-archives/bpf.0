Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543054735
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532513; cv=none; b=N144+r08xKXkEkqayJVJ2+DnNzHCPeA1oDdrldOyy1xcmyHBvzIEycRtcGI51PCxHJ0PaFnnf28SLZ1laY/KQiSKPdeMbEKlYRxDnBBJ/8YDfRTWw8etKGEqJTF/9GIpTOCiISZwbXuvqetyAWkA0aMv6uewJy9zB9GeKJUk1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532513; c=relaxed/simple;
	bh=9dZo3hhHILA1Vsa6/x7a9av0THiimjwMutRu9GgeKuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbVSMl+x76INnBBTL2M9HZDgu534dzMNDAwrNGTgl9fCuNKvehqY2h3rbvDJFMTPt68bDPuVEgVhFMpOhgfonWiXgwuLO8nPGi70W0Bw+bOgwWOmw5DtgEgWLn6FyyKhiBDqDW2MxSzz4vS3M+fXxeZM68Fz3h4YJb7yC5fTeqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BcUE/iwc; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BcUE/iwc"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-789db917876so120670385a.1
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 12:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710532509; x=1711137309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry29tyycjYxk6fFeMi1eD8C6LU69xTzMZ5f+WiAb3oo=;
        b=BcUE/iwcmxgAEyyLcpSB5a7khcC+/f/rFrXO6nFYtMUWgpgmJO4O12FN7mKbi89xvB
         mX9xtGcoq3YBHNj7mkbNBMhlZ2kSLwzD7h9nq2Fwr4N588iAU1j72HsCSANHuBWmi1dP
         px+P2PR6IPFnyq287SIEq9wAsgp+jMz06kQJv/kW5eQQ4Te2qUxyzqnARIyBGTFE3Vvl
         0I4Mklxyj1thsK1AeFl82BfwY/+HlDwS05DAxge4K4dtmKIP/mXmRrln+BWVuIt0NWNi
         /g122hKjGVRcDXhFC56AUuu89iOZd9/z+3mx1k/8o7oN+oEEKGxCMlc8OvWQbEVGYEe+
         dehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710532509; x=1711137309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ry29tyycjYxk6fFeMi1eD8C6LU69xTzMZ5f+WiAb3oo=;
        b=b4KCA+S3RrAiJIFHqP1efD/eF6Pbj44ZMfl5jS8wOXgRO1wV0OkE1msy8lUzD+5q0Q
         WhyjE2sFOnm7gWr8NA3AG9L72V7UcnvVxPzeHuzmQ4JAwXHfmBKhxMrZQmRN/wCjFxUO
         tuV718TqYGP63vOrLKOOU+ViR/hSOy1rsLb8/VKki4wjuKOaNa230ywe0rdSfGC9XRHE
         d6tVfSdQ6cfpCtjmbx11BahYTguQYBBL+CROj952JZ4cUY9kavML8hj50gdM3SH/BtmK
         dvL0Ap2K2H0+TnGoDQAHHCO3X5JN5K1j9jnKFgJ+XT8+jClvLevvqJbE0HDWGQYF//io
         UO5w==
X-Forwarded-Encrypted: i=1; AJvYcCV8cp5eyjQKw5KUDdoPBU8de40JGML9mp/L1j3Ft7wxezXr8bBaBJDHRXIpMTc2HV3IjrKAL6t66/1bgxGyT6Mta90D
X-Gm-Message-State: AOJu0Yyrxofa4V81djNpSQiUPlEF9Zvz14rLWtWyr36NE6paeCpjPfAg
	pBnk5TVG5ER6NCaY0kNB54khsRe0DlPfFnGoFYtKdqGLkdR27ZZoHHpn3kOvArA=
X-Google-Smtp-Source: AGHT+IFe+Jey6521uF7eX0BAurAqBmBT8HIizHqfi3SPi7OcH8reJREKFdT7IdpL5KWJ7UuCn5UH0Q==
X-Received: by 2002:a05:620a:821d:b0:788:12af:3f0e with SMTP id ow29-20020a05620a821d00b0078812af3f0emr6201880qkn.56.1710532509182;
        Fri, 15 Mar 2024 12:55:09 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:1046::19f:c])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a13e400b00789e94cf424sm431802qkl.108.2024.03.15.12.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 12:55:08 -0700 (PDT)
Date: Fri, 15 Mar 2024 12:55:06 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [PATCH v4 net 2/3] net: report RCU QS on threaded NAPI repolling
Message-ID: <2425bc9fbfb7ef396d68d755df79dbbae48a58ab.1710525524.git.yan@cloudflare.com>
References: <cover.1710525524.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710525524.git.yan@cloudflare.com>

NAPI threads can keep polling packets under load. Currently it is only
calling cond_resched() before repolling, but it is not sufficient to
clear out the holdout of RCU tasks, which prevent BPF tracing programs
from detaching for long period. This can be reproduced easily with
following set up:

ip netns add test1
ip netns add test2

ip -n test1 link add veth1 type veth peer name veth2 netns test2

ip -n test1 link set veth1 up
ip -n test1 link set lo up
ip -n test2 link set veth2 up
ip -n test2 link set lo up

ip -n test1 addr add 192.168.1.2/31 dev veth1
ip -n test1 addr add 1.1.1.1/32 dev lo
ip -n test2 addr add 192.168.1.3/31 dev veth2
ip -n test2 addr add 2.2.2.2/31 dev lo

ip -n test1 route add default via 192.168.1.3
ip -n test2 route add default via 192.168.1.2

for i in `seq 10 210`; do
 for j in `seq 10 210`; do
    ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport 5201
 done
done

ip netns exec test2 ethtool -K veth2 gro on
ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
ip netns exec test1 ethtool -K veth1 tso off

Then run an iperf3 client/server and a bpftrace script can trigger it:

ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 100 >/dev/null&
bpftrace -e 'kfunc:__napi_poll{@=count();} interval:s:1{exit();}'

Report RCU quiescent states periodically will resolve the issue.

Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v2->v3: abstracted the work into a RCU helper
v1->v2: moved rcu_softirq_qs out from bh critical section, and only
raise it after a second of repolling. Added some brief perf test result.

v2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
v1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 76e6438f4858..6b7fc42d4b3e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6708,6 +6708,8 @@ static int napi_threaded_poll(void *data)
 	void *have;
 
 	while (!napi_thread_wait(napi)) {
+		unsigned long last_qs = jiffies;
+
 		for (;;) {
 			bool repoll = false;
 
@@ -6732,6 +6734,7 @@ static int napi_threaded_poll(void *data)
 			if (!repoll)
 				break;
 
+			rcu_softirq_qs_periodic(last_qs);
 			cond_resched();
 		}
 	}
-- 
2.30.2


