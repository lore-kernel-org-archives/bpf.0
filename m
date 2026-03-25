Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF773FB04B
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457757; cv=none; b=PJacnYX3TV7QvwBaTgSjyfnyi84on7RpGd6xJLAAvyZCE/f4IZbqfRRBVCsEQA9nixY9kiSGS8MICveKX1p4a2w3Kd01Mz84qzTvWk0Tl+weIvMLYYbZf/pbYBCEttPZocVUb23QaSWA4psL9GBVuFBBgdjgxS6EzsLOzyrDPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457757; c=relaxed/simple;
	bh=+OjMb5092maQp2iEGHKWjP63NT/l3FVLEKtpncsAeD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gn060QBwMZ/JXsj57orBdcZfI7HL1rSJKxdJjoRZQU1EYEcnmG+2khgYjTflhU5DCnwF7FUMGULTagWZV3Vsvjd40nFXo8MgS0p5+pNCgSzZGDiQB8t9rTWBUsig4kFgiBWLAWJsosmBHuozshEGU4L3UPPp1UmTZV52qZGm8kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewzOSV46; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyHX7MSI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewzOSV46";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyHX7MSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774457752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5gZ/S9pbjjkoQ+gcMJJTXTQUJ/FjVdC55bH/vaTcEqo=;
	b=ewzOSV46u1ANS/Rf7aHfXMgM9RPRU+yErI82+z7BjptmN6dQj8pqInI2Z/Ffg1KQBWW0ya
	b6ohzlc2QYLqwPJ9pb4n7A/BrEltJWoc72bk7WEdmBGZMLykpwo4Cs3qmI0LbWj0XlEWGr
	ZPLcw4Iecd9zeo3FClUGfjZMek7TOKI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-R4ojkzpSMj2QZZGWS5xW8A-1; Wed, 25 Mar 2026 12:55:50 -0400
X-MC-Unique: R4ojkzpSMj2QZZGWS5xW8A-1
X-Mimecast-MFC-AGG-ID: R4ojkzpSMj2QZZGWS5xW8A_1774457749
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b7ec737c1so4178f8f.1
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774457749; x=1775062549; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gZ/S9pbjjkoQ+gcMJJTXTQUJ/FjVdC55bH/vaTcEqo=;
        b=eyHX7MSI6oZdAa22UyAPTlJ8LHOsi0Ion/mlPzlSv3lFbYvrqMw73uIqMIKJbSWnKb
         bqrXm4B07UejB7h7leQCGCWyu3l8ZQdeCCG9/sNPrrTLSdkWak7REOf99Bajoj0gPtwO
         7518ZZVdeaLxgmVd7ByA4plKt3bNsl5epnL7N4VDgl4Debxd6qVqmPLj3awyZO87U5+N
         1TvX2mQew2TXiiA4fLfMVbuy4GwoNhjtZ9FA/Tmccp/eAIYschOCwuaZKUR+puhYaU7/
         O45Le7ZGq5b0J1sQC09R4mWeIwGWQMleKGljLaTrM4u1FGVC5gRlU7jMVZpIjEsV7RXa
         8Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774457749; x=1775062549;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gZ/S9pbjjkoQ+gcMJJTXTQUJ/FjVdC55bH/vaTcEqo=;
        b=c2d5KNjAuISAh8UrvYaNYazVQn5QI5dQEX6IgNxmvdzXbdXZNOzd3RsfsYDdTzTzSu
         Sy0zTYCDC4A0hOx2vaC5YhAw4ssbcSMEGuGXAatEqn5+XhGrhlIe7dS3s3dYQnMN55j3
         j4fqVtOl52KrKzYyz5KD5k3hfIuvWcfJfVmUZsXnoY2btCVcN/JfyQITHPG5R7Y9jcjy
         4XPxCfebH/0xtxDaeA/OFUe1ZxC8HPIlFvXdtt1qMbWTfwzXGPjs1e/njwjBtaCZWRED
         B6oWrWt6nxnU1w3Db0Nizi2eQgTWO+J20ZhUx3Jj5jNGuCDUn8o0YUH0nUSWGtNSqkjR
         pn5g==
X-Gm-Message-State: AOJu0Yxc6haqkN1uyHfqIgy1tpdckzAzNJ6BSvAfKx9wM1Savrt/IRUB
	AyysrGzj2lUZKj5tNgHO7xGqSUTjTZ57pxwbyM9DgDg9O3oImWTda4T9jLf6onpyvoZCdxIO0xs
	x/mI2Xvcpc8JnsUPS9QgKa0NegoRvsIqdFew0YLW/MkGsa1usQapyjw==
X-Gm-Gg: ATEYQzxEFbA8NNFD1bbm+KxaZgQhslVEIPH8uppFEHqdqwraygprIKuWz3CCRbs6dfB
	JcHVgVQsL+QJWX6tM3sVxnbXPmgV5m4euEOK8j/rES72ERNwJ3qPtMNAWqDhxCXgxK1569iSWYZ
	qZ5uXlkLiqM6C0HmGw9F1lxwAPiXHochk67ZmySqr6W8ceIbetrn2kYe2VaaQngGWdY+YcCqaqN
	QaJ6vA34xEHAPfKO7dBLkI1A7X/3f875znCsZcJ5JM/ASs4c3BovnibObqICZHBU5UdlIU7WTIu
	lmIvXD9iqP8Al7Ki4cd1tRQ7HN6bp6PzMaOqYTxNluKoNLYJxDroZjxIHRNnVk2XQ6P2VWGnf90
	YuS12bMbmJdCNKEw1
X-Received: by 2002:a5d:64e7:0:b0:43b:4960:60f2 with SMTP id ffacd0b85a97d-43b88a399aemr5997846f8f.47.1774457749429;
        Wed, 25 Mar 2026 09:55:49 -0700 (PDT)
X-Received: by 2002:a5d:64e7:0:b0:43b:4960:60f2 with SMTP id ffacd0b85a97d-43b88a399aemr5997793f8f.47.1774457748903;
        Wed, 25 Mar 2026 09:55:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b91943184sm1001694f8f.14.2026.03.25.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:55:48 -0700 (PDT)
Date: Wed, 25 Mar 2026 12:55:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org, Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com,
	stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] ptr_ring: disable KCSAN warnings
Message-ID: <97d39458d8dd7a00341f0be391b580650896ce42.1774457524.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Eric Dumazet reported KCSAN warnings:

BUG: KCSAN: data-race in pfifo_fast_dequeue / pfifo_fast_enqueue

write to 0xffff88811d5ccc00 of 8 bytes by interrupt on cpu 0:
__ptr_ring_zero_tail include/linux/ptr_ring.h:259 [inline]
__ptr_ring_discard_one include/linux/ptr_ring.h:291 [inline]
__ptr_ring_consume include/linux/ptr_ring.h:311 [inline]
__skb_array_consume include/linux/skb_array.h:98 [inline]
pfifo_fast_dequeue+0x770/0x8f0 net/sched/sch_generic.c:770
dequeue_skb net/sched/sch_generic.c:297 [inline]
qdisc_restart net/sched/sch_generic.c:402 [inline]
__qdisc_run+0x189/0xc80 net/sched/sch_generic.c:420
qdisc_run include/net/pkt_sched.h:120 [inline]
net_tx_action+0x379/0x590 net/core/dev.c:5793
handle_softirqs+0xb9/0x280 kernel/softirq.c:622
do_softirq+0x45/0x60 kernel/softirq.c:523
__local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
local_bh_enable include/linux/bottom_half.h:33 [inline]
bpf_test_run+0x2db/0x620 net/bpf/test_run.c:426
bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
__sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
__do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
__se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
__x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811d5ccc00 of 8 bytes by task 22632 on cpu 1:
__ptr_ring_produce include/linux/ptr_ring.h:106 [inline]
ptr_ring_produce include/linux/ptr_ring.h:129 [inline]
skb_array_produce include/linux/skb_array.h:44 [inline]
pfifo_fast_enqueue+0xd5/0x2c0 net/sched/sch_generic.c:741
dev_qdisc_enqueue net/core/dev.c:4144 [inline]
__dev_xmit_skb net/core/dev.c:4188 [inline]
__dev_queue_xmit+0x6a4/0x1f20 net/core/dev.c:4795
dev_queue_xmit include/linux/netdevice.h:3384 [inline]
__bpf_tx_skb net/core/filter.c:2153 [inline]
__bpf_redirect_common net/core/filter.c:2197 [inline]
__bpf_redirect+0x862/0x990 net/core/filter.c:2204
____bpf_clone_redirect net/core/filter.c:2487 [inline]
bpf_clone_redirect+0x20c/0x290 net/core/filter.c:2450
bpf_prog_53f18857bc887b09+0x22/0x2a
bpf_dispatcher_nop_func include/linux/bpf.h:1402 [inline]
__bpf_prog_run include/linux/filter.h:723 [inline]
bpf_prog_run include/linux/filter.h:730 [inline]
bpf_test_run+0x29d/0x620 net/bpf/test_run.c:423
bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
__sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
__do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
__se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
__x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff888104a93a00 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 22632 Comm: syz.0.4135 Tainted: G W syzkaller #0
PREEMPT(full)
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/24/2026

There is no race here: reading/writing a partial pointer
would be fine, because the reading is always done by the producer
which merely cares about NULL/non NULL.
Document this / disable the warnings using data_race().

Link: https://lore.kernel.org/all/CANn89iLHwZ4foPEL2TdQhYx3Ps3zXiwygb%3DQr7OTKW2R7Ldixg@mail.gmail.com/
Tested-by: Opus Sonnet 4.6 1M window.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/ptr_ring.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 534531807d95..87ff669b0c57 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -103,7 +103,7 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-	if (unlikely(!r->size) || r->queue[r->producer])
+	if (unlikely(!r->size) || data_race(r->queue[r->producer]))
 		return -ENOSPC;
 
 	/* Make sure the pointer we are storing points to a valid data. */
@@ -256,7 +256,7 @@ static inline void __ptr_ring_zero_tail(struct ptr_ring *r, int consumer_head)
 	 * besides the first one until we write out all entries.
 	 */
 	while (likely(head > r->consumer_tail))
-		r->queue[--head] = NULL;
+		data_race(r->queue[--head] = NULL);
 
 	r->consumer_tail = consumer_head;
 }
-- 
MST

