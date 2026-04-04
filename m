Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF5B256C6D
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315103; cv=none; b=O/R82UEg5AczbdAtaljuRB2h6mAqWhU/ViUAC1Nxwe0up3sQ0Zln0wh6QE9JjRL0g6nnLf5P5NVIHxKpVN2D1DVaSxBGLSLfoxfhlrkBD8sT7QS0u/kiOzy7TeXjh4zr/DGe8G2RWp/Uw2aISFmqPtcz6rdO0YEg9cB2Gc8tRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315103; c=relaxed/simple;
	bh=wdmLZ4KEEkAnWdNrQzn00WcMrp08o/hgaa6m0lD7sMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P/4eKcO83FDqdMsOD8G+JbrMxurI+xcW7v/5Wmc+s7siTgkfjji5+34z5vW+58iXUmLKKPSwduhEi1F5lTyHATj5iJm2DpByNhXW1BAEA2N4iWLp4JeQBgkQnsmbAv43qbHhnm4bAawzbm4+FxlrhmNHunQH8wbNjtwc10JD4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad7qqnA6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad7qqnA6"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c74244dc0b3so1602210a12.2
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315102; x=1775919902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sltJ+jDdJqb4WY51NvTn4z5+M71KgXkyQpBGmt2DunM=;
        b=Ad7qqnA6VWIi/TmNJMw2XuPKevL279XEslX3R0EfGNBBfG20xnQB0CWMNIz7xE9YtJ
         SQe19PhkSl1c/fjTioNpD7BOB62HUIXJZgAu/CPnSOEGAc75vGHfRZT361UnH22K6wRg
         SXyaXU3M3lb/wqspWkcRI4MYHMQ9hzf0BiT2S0XCWXSqiNciaYqAQ2islrU1EksZHcEb
         vZHO7Ft5wpgTgw36rtQUre1rmPzuQz42xSFp7qqcvLr+WX6RdKUeempVosOBVquiFlxV
         TSTLPKo0veRiYq2iBMv0EqmnAIQefdC5wMW6LZnt87WC+Jsu9m6LcK+CZtIhm6wnLhgj
         XSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315102; x=1775919902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sltJ+jDdJqb4WY51NvTn4z5+M71KgXkyQpBGmt2DunM=;
        b=fttoqfO698QCcVarn9h9cCchBCVgBLDpWkNeLbXsg226N7IIT718Eulvb3Z1HdM8ZQ
         Uu/qeIJOLt/T0M1b8ZlLIdWBXg4HDnCq0sCtKSiO1eSDtZ7X3fh+3NN1sqs5vWbumn0U
         FNkbqi3GXUmMbIJDE0DYLx8zYsWQy7k8eDfRodJrR32+rXs42Qd3BUR4CjaSWKZupqD9
         Ps+LA+la10KDkVhUpotKTTlCszttA5EOnfwE5Jj2YbEdOMESYquVtKZ8586P/2pwvzeg
         BVn/QknifnbbIeCmTqu5DJbITIKbP75y0x9T4BrN/AEcVrqITLn3MYxJ4QY0LwsC491I
         al5w==
X-Forwarded-Encrypted: i=1; AJvYcCVapKcWIad4f32VXa2JSz6pm+G0ThaPEs7sdOdCOAr25zTSzB6cMcrfn6HmSquNgHzikGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznGRrrY0RMiTq/6rYa9BeSLJJHY1pvlMjSEsfwTz/0i1tm4vph
	WD9L/BuPO9mjD5lvqndM5nxQKrZKvq789WtYODrmBd3B/lFgStZivLcG
X-Gm-Gg: AeBDietudHi1wmJVAqkJJ+ZsHeX5aAINhJnvRIfUmzPifyPHbNEvD55Ds6VIqjsmdPg
	j7ZWa6OQYgilrOp7X/bi8a/sh9TtoGVJtvE+UhwYLjaJsNq44OqaOwPHPzXRnIcYH/kZEh5zM3N
	8X/KDMCu1s4JkIpYyW5HHveoVkQs+ZUlk9HwEqWDQD9a75BeYQ0FdpkVCMTH19ZgeCqr+jqDIeK
	Ys7uFzRE6Vx3rT1XgA2xlHo6t1+nQrwEmuAT+bWB/68+J0fBTyMJ3QslAhXaxFhSuJHlCFbDY6V
	xR8p+z7YL564jszfbvGYDc96FqJLZ73pyGW+pzFHhMUW6c5zecAdqVxNj6aH4QW6MEi+ag4ufW0
	y2C2QBw4j039pTqny7MA9gsD5JqVKNVBzE2cptIADgyQLmcQPKXTTGD0RNxGay/mXGIOdvhON2L
	u9/49e3p4qoyrP3gP4cUyxO1QnIKji5ykHsTRtR78Ly3SnahzfpKBFljQ0gJo=
X-Received: by 2002:a05:6a21:99a3:b0:398:ac0d:9a0b with SMTP id adf61e73a8af0-39f2f100b43mr6626038637.50.1775315101644;
        Sat, 04 Apr 2026 08:05:01 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([121.25.96.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm8051444a12.26.2026.04.04.08.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:05:00 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	martin.lau@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/4] bpf-timestamp: convert to push-level granularity
Date: Sat,  4 Apr 2026 23:04:48 +0800
Message-Id: <20260404150452.83904-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

1. Design of send-level granularity
Originally, socket timestamping was designed to support tracing each
sendmsg instead of per packet because application needs to issue
multiple extra recvmsg() calls to get the skbs carrying the timestamp
one by one if application chooses tag with different tags(SCHED/DRV/ACK).
It's an obvious huge burden if the application expects to see a finer
grained behavior.
Another point I mentioned a bit in Netdev 0x19[1], supposing the amount of
data that application tries to transfer at one time is split into 100
smaller packets, recording the last skb's timestamps (SCHED/DRV/HARDWARE)
is no longer meaningful because at the moment timestamping only records
1/100 packets. In this case, only the delta between when to send and when
to ack matters.

2. Known missing tag issues in TCP
A critically important thing is that we can miss tagging the last packet
in a few conditions as the patch 3/4 explains. That means we lose track
of the send syscall. Digging into more into how tcp_sendmsg_locked works,
I found it's not feasible to successfully identify the last skb before
push functions get called. With that said, if we want to make the feature
better to cover all of these cases, we inevitably needs to place
tcp_bpf_tx_timestamp() function before each push function.

3. Practice at Tencent
In production, we have a version that applies the packet basis policy to
do the exhaustive profiling of each flow for months in order to:
1) 100% make sure to capture the jitter event. No sampling.
2) observe the performance, find the bottleneck and improve it.
We're still collecting data and investigating how it helps us in all the
potential aspects before upstreaming. My personal perspective on this is
to replace tcpdump eventually. It's worth mentioning tcpdump no longer
satisfies our micro observation in modern data center.

4. The tendency toward finer-grained observability
As we're aware that there are already many various bpf scripts trying to
implement the fine grained monitor of the packets, it's an unstoppable
tendency for the future observability. We're faced with so many latency
reports (like jitter, perf degradation) on a daily basis. Getting the
root cause of each report is exactly what we pursue.
After we know which request causes the problem, if it belongs to kernel,
we will dig into the packet behavior with more useful information
included. This is the process of tracing down the jitter problem.
Likewise, in BPF timestamping that mitigates the impact of calling extra
syscalls, breaking the coarse granularity into smaller ones is a first
good way to go. It shouldn't be the burden like before especially it's
independent of application.

5. Details of the series
Now it's time to convert BPF timestamping feature into push-level
granularity by only recording the last skb in each push function, which
is quite similar to how we previously treat each send syscall.
Regarding each push function as a whole, we only care about
the last skb from each push since the skb can be chunked into different
smaller packets. BPF scripts like progs/net_timestamping.c has the
ability to trace each tagged skb and calculate the latency:
1) delta between send and each tagged skb in tcp_sendmsg_locked()
2) delta between SCHED/DRV/ACK. Three timestamps are also correlated
   with the sendmsg time.

In conclusion, push-level is more of a compromise approach which covers
those corner cases and further enhances the capabilities (like a finer
grained observation of jitter and performance issues).

[1]: Page 29 of the slides demonstrates the picture of skb-level granularity
https://netdevconf.info/0x19/sessions/talk/the-future-of-so_timestamping.html

---
V2
Link: https://lore.kernel.org/all/20260402085831.36983-1-kerneljasonxing@gmail.com/
1. only handle BPF timestamping feature to cover those issues (Eric, Willem)
2. keep timestamping functions inline in send process (Eric)


Jason Xing (4):
  tcp: separate BPF timestamping from tcp_tx_timestamp
  tcp: advance the tsflags check to save cycles
  bpf-timestamp: keep track of the skb when wait_for_space occurs
  bpf-timestamp: complete tracing the skb from each push in sendmsg

 include/net/tcp.h | 20 ++++++++++++++++++++
 net/ipv4/tcp.c    | 23 +++++++++++++----------
 2 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.41.3

