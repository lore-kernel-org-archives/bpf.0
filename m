Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316815;
	b=vJIuWitIBl3X+A4TpRXn1h1AXeIzP+sLrNazbfhY5rqOBJijrvyXhIFxFXqN7V5toZvU
	 CsUzjb6a1A5gid3oonbONdw3E/RkHcM5irvKCi7PaOTvo6TCBhvdXIDAaUC2iigpnR1Uf
	 il/Fm32/RYLCc414lS3yuVomdp8vCX05M/9foQrQdsaUExyw0oxH/9qXhqN9eYWkPDh0W
	 1TWKujvtFIODBGt27y8aSAtAz1Sct+yMTBWcOJXU8ojKzrxAJNaxXbJkH98HiZcFOaErn
	 45cdHZUB+LtH9sv2h0DKIPru5/43TLu1DMsfLqUsxVkBEY2klySUG7V000FZIo90bvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316815;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BuFQdLxm76k2ibrTpYCTvB4FrdQtvYcaSVR0hj2U17U=;
	b=1XQnnfXEC7kJHl5eml8zGbK9+YheqYv8a0Dm4R4bCw2ZsxXnlLNvlNzclTqWwISX4qIC
	 oy1+es/2RN91InMUgB/xtTP5AwoPw+BHO6A55HCaF2whtMiNuPR3zpq4xJrSeUl0ZJmeA
	 9FHCztPn08pBs5SbumMNqXnOyyt2B845YOE23jyVEcbIJFTNtW6VHYKbXVfQghrCA1L53
	 kcipvgPe7/sTNOgPuyIUlfroPfTNSvK1qFjScIcSDVYFqo8DCRDShCXtkaWYifK9goH8e
	 xc/ev2mxk5ZG7CAWGgBgWXrl4XPwGRnzcmtbE8Ng+8/fxTidn2P+NSAJZwmdRugMN5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IvrudmQJ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nYdmCcfe;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E0606BFDF
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D37E0606BFDF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IvrudmQJ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nYdmCcfe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BuFQdLxm76k2ibrTpYCTvB4FrdQtvYcaSVR0hj2U17U=;
	b=IvrudmQJfYkadeOp7SK4ad3G/gNGG8y3qIhFgMPlyS2tuI37N9cG+3OHy/9KjyolLgDr3s
	l0wuekWTPDEalJvUqK5R4nbtmrkNjy9aRcdNtjt4PzbOUoplSpcSo+0VJbEE9ZENkMmQEr
	vs2wFP799o+IYyF9IOoWq6/qX5I1qnY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-8dJZvq27PaOEFa-PCU4Q2Q-1; Tue, 10 Nov 2026 08:20:10 -0500
X-MC-Unique: 8dJZvq27PaOEFa-PCU4Q2Q-1
X-Mimecast-MFC-AGG-ID: 8dJZvq27PaOEFa-PCU4Q2Q_1794316809
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c5051881421so54876866b.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794316809; x=1794921609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BuFQdLxm76k2ibrTpYCTvB4FrdQtvYcaSVR0hj2U17U=;
        b=nYdmCcfeo3QLxglJR/X9RKwdepZWlzRx50obo24T1NdllDNI6GQM04V8VEVd1Q8Dmz
         oY6Bl8GFbumrIX9GAsAz+Y7ibEm/kIuhLe9d7xFXGAQsdsQBS23zUTfI3byK/EF9k9xz
         D0v7pHQPI00JE7/myvSJLtn6AUr5IVNv0T96Eq8JLcuC+73gw1In3y9LQiVSfy3uMgcx
         NiN9o/isV3uylb8YkaN4fdMJIcgLfKaU9sSKoNdSga7acGKyeyjc+0W5lC8WqjXIweDJ
         01zNuKqHeFnPXhieLYLtRZoxg8XsJmymvsLqLjVRWJI5uOKzVFF3IP15IpQCrH+5DYa9
         DOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316809; x=1794921609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BuFQdLxm76k2ibrTpYCTvB4FrdQtvYcaSVR0hj2U17U=;
        b=e1U499uxHKheKSyKI1PuN9bmh5kzS/VZx9DU+0x7KCi9OmS3zJBRsHO3vQP0Zk01ql
         LeEtDPSpnrlCFbW64qXqcwv3jlMG/OPGpKbXUBkoJ+YeUC1ktgrZRcdpcJTiE2EDnZF0
         vwPyaHKO6cJG5VRbnmy5gyaL7txXNa5aMjFicYASj1mK4KX3QynjSn5uky5UBG3qATtI
         AGzmkzxYTV3rmj6Swley7kJZbRzpefejbaIExSNGXPueCYh2uZ1tmlbluKx25oHKctkb
         NyNM7hx1/6E12f8WM4Of6xF9B4QxvqFiZjdWIOPE3k7o/a0nkrZFFpd37o+VPQvyDTsM
         2Qgg==
X-Forwarded-Encrypted: i=1; AL+hErHJTGBBI8fxxKd/9mXmrrlAznMn3JAQhJS3hR/NdgspwCAuV4ChLE1xvRT63wiVFlaKC4w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NjJs3WRJXsfqZqllsNt81mgecEB/6jsLRy4IWvUk+tQnKI/GK
	2u0OsDUmslIZJ+jPp8n0A5xO08YafOZip7cWYg8VE2Q2FIeIhK4lWAj3n6yu+5CiaJEWGQKQN2O
	hke5ShDeuY6c4hKVKM7dJZHY1MVq5mXetYb+3snL662W4pUmDjR5OSQ==
X-Gm-Gg: AYBFou065uDPezSyAKIXHfs3kBZBv8q+TNk7QAAAPlPOLwp91V/KBjy3RftDH5pwO54
	RsTlVdqxY8Ag4mvVnlWVRyh6EHV+5/Tu3VHBk+EQCQZ4fclnSHZq2LMVsAkAOCgH9TfTTALHezW
	ujODr/ymnYibkxYbaBdiuW5dZbH4H4jzSkj9riwkv6H1FkZf8NzlwkOHmsq590dKgZuNON11I1x
	RpTFGZ/Xhwhg5PeHKWowmCKHr8ZBx4rnv7iM6uwsjcVyuuA1qXyrXe/rqGNac2PVYrykuEvDdLM
	rlcuIaNbXpfzV9qQ4hahljGxdGOGtEH7NeoneYFOjHA5Ib47Fr58HVVoafLN+RIrb14BniLpSTC
	qWa6iXP+mvR42daSB+0ZEFLvmfX/D1jMmowXFDyAzSRKP8iQTqOY07E2HfKbNOaVbCDcrBZaYqs
	jtMYkr91hb6xHuNcAm8hN0sH9xW4wIxyBqDVVRXNaX4jnQMDlH5OtrtodnzH8n6CNVJknZiJn5f
	klKWq7BwBqQesBF5q9dVRD9+SUNCCEHfbZFOEW/u5osIAbU2DYj
X-Received: by 2002:a17:907:3fa9:b0:c46:7645:861 with SMTP id a640c23a62f3a-c50491b945cmr220483166b.7.1794316808791;
        Tue, 10 Nov 2026 05:20:08 -0800 (PST)
X-Received: by 2002:a17:907:3fa9:b0:c46:7645:861 with SMTP id a640c23a62f3a-c50491b945cmr220481366b.7.1794316808211;
        Tue, 10 Nov 2026 05:20:08 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5d54bbsm107791166b.48.2026.11.10.05.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:07 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 00/12] io_uring: opaque TCP payload objects
Date: Tue, 10 Nov 2026 13:19:54 +0000
Message-Id: <20261110132006.3280986-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A proxy, cache or key-value store often does not read the payload. It
parses a header, decides, and forwards the body or keeps it to serve
again. The body should stay in the kernel. The application needs a
handle, not a mapping.

Sharing pages with the application does not give it that. MSG_ZEROCOPY
and SEND_ZC pin the application's buffer. TCP_ZEROCOPY_RECEIVE and
io_uring zcrx map receive pages into the application, and zcrx also
wants a header/data split and a queue steered to one ring. splice()
and sendfile() ask nothing of the NIC, but a pipe only carries bytes
in order, and a file holds them only after a copy into the page cache.
There is nothing to retain and send again.

This series keeps the payload in the kernel and names it. Nothing is
mapped. Capture uses the socket's receive queue through
tcp_read_sock(), after the stack, on whatever pages the driver used.
A fragment nothing else shares is kept by reference. The rest is copied
into pages the store owns. The NIC is not asked for a split, a provider,
a queue or flow steering. The same path runs on any driver that delivers
TCP to the socket.

A send takes page references through MSG_SPLICE_PAGES. There is no pin
per send, no registered buffer, and no range the application must leave
unchanged until a completion. The object is the received data, so the
body is not copied into an application buffer before it is forwarded,
retained or served to another client.

The net change
==============

recv(), splice() and tcp_zerocopy_receive() are the reader. They consume
the sequence as they go. They never hand the application a stable offset
over a queue that some other reader can still drain, so TCP had nothing
to protect.

The collector does. RECV_OBJECT and DISCARD name ranges counted from the
first unread byte at attach. If recv() or splice() takes bytes in the
meantime, those offsets no longer point at the same data, and the
application keeps or drops the wrong range. Patch 1 puts one receive
owner on the socket. While the collector holds it, the other readers
return -EBUSY.

The option is hidden and selected by this feature. With it off, struct
sock and those paths are unchanged. Patch 1 has no other user.

Interface
=========

IORING_REGISTER_OPAQUE_STORE creates a store with a memory budget.
Rings share it through a descriptor. IORING_OP_OPAQUE_COLLECT attaches
a connected TCP socket. Bytes the application has not decided about stop
the collector, so TCP flow control applies. Between passes the collector
waits on io_uring's own multishot poll. There is no second polling
mechanism and no new poll event for userspace.

IORING_OP_OPAQUE_OBJ carries the object operations. INSPECT copies out
the header bytes the application has to parse. RECV_OBJECT turns a range
of the stream into an object and returns its handle. DISCARD drops a
range. READ_OBJECT copies bytes out when they are needed after all, and
FREE releases the handle. CREATE copies application memory into an
object, for a value that is served many times rather than received.

IORING_OP_OPAQUE_OBJ_SEND sends one range, or a vector of up to 1024,
with a prefix and a suffix from application memory. An object can be
sent any number of times and on any socket. SEND_LAST gives it up with
the send. Sends through one store to one socket are ordered by enqueue
under the store's TX lock at first issue, not by SQE submission across
rings.

Backing is bounded per store, accounted like registered buffers and
charged to the memory cgroup of the task that created the store.

Measurements
============

These numbers are from development kernels (7.3-rc6 based), not from the
patches as posted. This series is a first-interface cut of that work and
has not been benchmarked itself. Those kernels also carried an earlier
skb_splice_from_iter() change, which made object sends 24% cheaper at
64 KiB and 14% at 256 KiB. This series applies and works without it.

The runs used virtio-net VMs with 32 vCPUs, one TCP flow and NIC
interrupts pinned. That is where the numbers were taken, not a limit of
the interface. CPU is the whole host's, total minus idle, per GB
delivered. Full speed is unpaced: from 4 KiB every sender, and every
receiver, moves what the path allows, so the comparison is CPU.

At full speed with 64 KiB writes, capturing the stream as objects costs
the receiving host 31% less CPU than recv(), and DISCARD 57% less. In
the runs where the path gave the flow 16 Gbit/s instead of 22, those
figures were 15% and 53%. Paced, capture and recv() are within 21% of
each other, in either direction. Receive at full speed was measured at
64 KiB only.

On send, from 16 KiB an object costs what SEND_ZC costs without its pin.
Sender CPU at full speed, one object or one buffer per request. Objects
against SEND_ZC that pins on every send:

   4 KiB   -15%
  16 KiB   -22%
  64 KiB   -24%
 256 KiB   -22%
   1 MiB   -27%

The pin itself, SEND_ZC pinning per send against SEND_ZC with a
registered buffer:

   4 KiB   +90%
  16 KiB   +25%
  64 KiB   +22%
 256 KiB   +17%
   1 MiB   +33%

The pin costs SEND_ZC 49-106 ns per 4 KiB page from 16 KiB to 1 MiB, so
it grows with the buffer, and 0.70 microseconds per send at 4 KiB.
Against a registered buffer, which is pinned once, objects are level
from 16 KiB (-21% to +4%, eight ranges per request on both sides).
Small sends are where a registered buffer stays ahead: by 6-12% at 1
and 4 KiB with eight ranges per request, and by more at 4 KiB with one.
Objects cost 40-57% less than copying send() from 16 KiB, and 12-48%
less than MSG_ZEROCOPY from 1 KiB to 1 MiB.

The SEND_ZC senders resend one page-aligned buffer and set MSG_EOR every
1 MiB to bound their notification chains.

The series
==========

Patch 1 is the receive claim above. Patches 2-6 add the store, its
accounting and sharing between rings. Patch 7 adds the send and patch 8
its vectored form: at full speed, eight ranges per request make 1 KiB
sends 3.6 times cheaper. Patch 9 adds the collector, 10 CREATE, and 11
compaction, which copies an object out of sparsely used receive pages
into dense backing under the same handle. Patch 12 adds two KUnit cases
for budget admission and version release.

Registering a store needs DEFER_TASKRUN and CQE32 or CQE_MIXED.
Userspace helpers are not in this posting. A mapped mode, for
applications that do read the payload, is not in this RFC. Neither is
the later send-path work that takes one reference per folio instead of
one per fragment. The separate skb_splice_from_iter() series, which
builds one fragment per folio for every MSG_SPLICE_PAGES user, makes
sendfile() from 64 KiB folios 11% cheaper. This series does not depend
on it.

Testing
=======

Two KUnit cases passed on UML, with no skips. They check budget
admission and release of a page-backed version. A loopback program
against this kernel captured one payload, sent the handle twice with
framing, checked SEND_LAST, and left the store empty. The kernel build
used W=1 and WERROR=y.

This is smoke coverage, not a pressure or scheduling-race campaign.
io-wq fallback, native SMP callback lifetimes and runtime memcg
isolation are not covered. The numbers above are not a benchmark of
this series.

Known limits
============

 - Receive authorization is checked when the collector attaches and
   covers its lifetime; later policy changes do not revoke it.
 - If poll setup fails for lack of memory, collection ends and the
   undecided data is dropped.
 - Table sizes (objects, streams, extents) are fixed at registration.
 - An object holds the receive pages its bytes arrived in, which can be
   much more memory than its payload until it is compacted.
 - A large CREATE copies under the ring lock.

Feedback wanted
===============

 - The receive claim: is an owner in struct sock the right way to make
   a socket's receive side exclusive to one consumer?
 - One opcode with the operation in sqe->ioprio (OPAQUE_OBJ), against
   an opcode per operation.
 - Reporting the transfer of ownership in the extended CQE (CONSUMED).
 - Whether this is the right first scope.

Thanks,
Alex Markuze

Alex Markuze (12):
  net: add an exclusive TCP receive claim
  io_uring/opaque: add data structures and the UAPI header
  io_uring/opaque: add backing accounting and immutable versions
  io_uring/opaque: add owned-page helpers for dense copies
  io_uring/opaque: add store registration and IORING_OP_OPAQUE_OBJ
  io_uring/opaque: allow rings to share a store
  io_uring/opaque: add IORING_OP_OPAQUE_OBJ_SEND
  io_uring/opaque: add vectored IORING_OP_OPAQUE_OBJ_SEND
  io_uring/opaque: add IORING_OP_OPAQUE_COLLECT
  io_uring/opaque: add IORING_OPAQUE_CREATE
  io_uring/opaque: add manual and automatic compaction
  io_uring/opaque: add basic KUnit tests

 include/linux/io_uring_types.h       |   10 +
 include/linux/net.h                  |    8 +
 include/linux/poll.h                 |    3 +
 include/net/sock.h                   |   46 +
 include/uapi/linux/io_uring.h        |   10 +
 include/uapi/linux/io_uring/opaque.h |  145 ++
 io_uring/Kconfig                     |   21 +
 io_uring/Makefile                    |    2 +
 io_uring/cancel.c                    |    5 +
 io_uring/io_uring.c                  |    9 +
 io_uring/opaque.c                    | 3926 ++++++++++++++++++++++++++++++++++
 io_uring/opaque.h                    |  167 ++
 io_uring/opaque_compact.c            |  425 ++++
 io_uring/opaque_internal.h           |  295 +++
 io_uring/opaque_register.c           |  152 ++
 io_uring/opaque_test.c               |  128 ++
 io_uring/opdef.c                     |   55 +
 io_uring/poll.c                      |   58 +-
 io_uring/register.c                  |    7 +
 net/Kconfig                          |    7 +
 net/core/skmsg.c                     |    4 +
 net/core/sock.c                      |    6 +-
 net/ipv4/af_inet.c                   |    2 +
 net/ipv4/tcp.c                       |   22 +-
 net/ipv4/tcp_input.c                 |    1 +
 net/ipv4/tcp_ulp.c                   |    2 +
 26 files changed, 5512 insertions(+), 4 deletions(-)

base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d

