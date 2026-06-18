Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873B135F5FB
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806844; cv=none; b=QjRNvDb43+blHXKX0JMatvqslu+mEHh3nIdHXXOad4ryUu1nxH/PfuZqGB1P5Jfcr1gVOR6UmZAyNkP9wKizcfLtPSzZ1jgI8t/E1/W+R5WYHCKOD6QZAe1hI1pGxlszuZDJT4MNGRJXsiceYzEqHBxu8esTGx/s7lfoicHSi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806844; c=relaxed/simple;
	bh=KLWSy+uOiu8A6irIA3J6az/xmGCIyZRKBNJ3RGdXe6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vD2taw+iys7JUnqiuPIEZ+V/XA6LZtqlTxjugKns4Syfzh9E6TEMeKpsGuGMw6SGra1g2EK3JTV8/5hsYC4uNH4DnAcM57nP62XiQsSFgYbp1KvoBhEFu1Pn2QrOjZhU3UWVtHicNcY7CNtMTJElONx0PiUoxRk1HSUg3NfI7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=M1Mp5VeL; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="M1Mp5VeL"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30bec3b6fb0so71543eec.1
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781806839; x=1782411639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxfXRAD4Q8BkMmwZ9NjvqUwhKA17UvJt+JpE+ccCIUc=;
        b=M1Mp5VeLQs1KwHfwUcSIOGfQN/ieYY25ARpditbcDt/17slj/Es+ONpj+KgwGRw0SY
         Q6suvDB3IMEVCkswpDRIwBBBzYQoZqKuEjMtah2tX0E9tKD7vpVxUw65ochl8F1lP4tv
         YYv4ES+cIoKIjSux4nw3g23/UceEfeii3HdX/XOsM6OW+dbSiEAnhC9SuVV3FZBMdMn4
         tNcqsLU4klpC7+3lqTxRfyu2qZSbEXXdal6LNvSLy7ZuNibn/jvgM1D+3rxMqbdz4NYq
         TO6Ak5CtOiIHNPyj6069VmY9otO+MfGnDmbqxlQeHAsrTyOBRlbwgRcQRVuHduYfc4gF
         2mSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781806839; x=1782411639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxfXRAD4Q8BkMmwZ9NjvqUwhKA17UvJt+JpE+ccCIUc=;
        b=feYgFHxBdV0dztxVLl3M9GzO6b9Gq8fV8rQOPAVkQu5K+xTEF7XES24g0cEkNpJXwe
         fBQBrQYXldfX1kcxvJs9kHHr12lby+pZ5qHaWGzaRVthPWUDcw/drY+hI9wqghB2F7Dm
         oyxTRTLiccYXLdLd8+npJVbVdVXUVG+RKZnE2IvguQoY230evAQlCdB2zTOv6MrKZsfA
         7EIllPzchE/O/E3sDH3KCMG+gXEMELGYnXI7jBnOtasjeLMwk7f+0t1nqvsYoJJsEAYU
         83I71jcvHSOoVeXFTwQzun+rGYmaVJOvgYlkPaV4O9sqIdaBjVj65Gs6XKGu9R6WJLIt
         Wtjg==
X-Gm-Message-State: AOJu0YwIFXdenE+S31B2c8LeqqcsZJDr/BNcRyBH56MWslAf4NnzZeoI
	qTzmmbYMPxv4rRz6PatvalCHmBOvlCoiACXgPYFWkec3j8mr6bdfkgdeilFDsmEj0gyMkLJ8Gox
	LD9B7
X-Gm-Gg: AfdE7ckjwBtszXDO6I7meTkmigIRK4ygbX7Kjq7b6kJDy2FRv1CD8/EvecFIizLnsWV
	d5tyf0CqSUlOWw3E69ZqujngidL3LfBSblEVSFMPsV1+VnODgOONEMbCQsnSKnP+GpScR2jdVAs
	IqgQMjibw6Byzklm2YL7fMn/0Gv5l6PFS9Tcba9YQqQ2VpdBBBx89oItINB4Vek6RUSW+ZoHPyk
	lLMY6nWxXQTJQekZ90y/4JHHxxis7nzkCabQv68SobD8dOipM461uDTw5rRHzuY8CsO0/FD4j57
	OjdBoq/SDC1VOMTdJ3uclP2ARaIGk5xTzVYacwwEtm9O/XjFz7WI7WvH8UDjKaGZHlfWOwrLEMC
	A/frPzWpKcv66pELxrh4NrvdUo4rPOj5EAy5V4gjTVfhhtEiFC+yiQp4/S8EdP4I+3mb/805Nxv
	furenmaEEDSVo=
X-Received: by 2002:a05:7300:220d:b0:30b:ab02:9e5d with SMTP id 5a478bee46e88-30c071939edmr123634eec.6.1781806839191;
        Thu, 18 Jun 2026 11:20:39 -0700 (PDT)
Received: from t14.. ([2001:5a8:47ec:d700:1b1d:38b6:64b7:ee72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c06c33c88sm205950eec.19.2026.06.18.11.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:20:38 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: [PATCH v2 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
Date: Thu, 18 Jun 2026 11:20:31 -0700
Message-ID: <20260618182035.43811-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have several use cases where a pod injects traffic into the datapath
of another so that the traffic appears to have originated from that
pod. One such use case is a synthetic flow generator which injects
synthetic traffic into a pod's datapath to enable dynamic probing and
debugging. Another is a transparent proxy where connections originating
from one pod are redirected towards another which proxies that
connection. The new connection is bound to the IP of the original pod
using IP_TRANSPARENT and its traffic is injected into that pod's
datapath and handled as if it had originated there. This can be used for
mTLS, etc.

We use bpf_redirect(BPF_F_INGRESS) to direct traffic leaving the proxy,
flow generator, etc. towards the target pod, ensuring that eBPF programs
that are meant to intercept traffic leaving that pod are executed.
However, this doesn't work with netkit.

With netkit, an ingress redirection from proxy to workload skips eBPF
programs that are meant to intercept traffic leaving the pod, since they
reside on the netkit peer device. One workaround is to attach the
same program to both the netkit peer device and the TCX ingress hook for
the netkit pair's primary interface, but

a) This seems hacky and we need to be careful not to run the same
   program twice for the same skb in cases where we want to pass that
   traffic to the host stack.
b) We're trying to keep the proxy redirection / traffic injection
   systems as modular and separated from Cilium as possible, the system
   that manages netkit setup and core eBPF programming.

It would be handy if instead we could redirect traffic directly from
one netkit peer device to another. This patch proposes an extension
to bpf_redirect_peer to allow us to do just that.

With this patch, the BPF_F_EGRESS flag tells bpf_redirect_peer to emit
the skb in the egress direction of the target interface's peer device
While the main use case is netkit, I suppose you could also use this
mode with veth as well if, e.g., there were some eBPF programs attached
to that side of the veth pair that needed to intercept traffic.

 +---------------------------------------------------------------------+
 | +-------------------------+         6. bpf_redirect_neigh(eth0)     |
 | | pod (10.244.0.10)       |           ------------------------      |
 | |                         |          |                        |     |
 | |              +--------+ |          |      +---------+       |     |
 | | 1. packet -->|        | |          |      |         |       |     |
 | |    leaves ^  | netkit |<===========|======| netkit  |       |     |
 | |           |  | peer   |=======(eBPF)=====>| primary |       |     |
 | |           |  |        | |          |      |         |       |     |
 | |           |  +--------+ |          |      +---------+       |     |
 | |           |             |          | 2. bpf_redirect        v     |
 | +-----------|-------------+          |___________________   +-------|
 |             |                                            |  | eth0  |
 |             | 5. bpf_redirect_peer(BPF_F_EGRESS)         |  +-------|
 |             |________________________                    |          |
 | +-------------------------+          |                   |          |
 | | proxy (10.244.0.11)     |          |                   |          |
 | | IP_TRANSPARENT          |          |                   |          |
 | |              +--------+ |          |      +---------+  |          |
 | | 3. packet <--|        | |          |      |         |<--          |
 | |    enters    | netkit |<===========|======| netkit  |             |
 | |    [proxy]   | peer   |=======(eBPF)=====>| primary |             |
 | | 4. packet -->|        | |                 |         |             |
 | |    leaves    +--------+ |                 +---------+             |
 | |    sip=10.244.0.10      |                                         |
 | +-------------------------+                                         |
 +---------------------------------------------------------------------+

Using the proxy use case as an example, in step 5 we would redirect
traffic leaving the proxy towards the pod's peer device using
bpf_redirect_peer(BPF_F_EGRESS).

As a bonus, since the skb doesn't have to go through the backlog queue
it can take full advantage of netkit's performance benefits. I set up a
test where outgoing iperf3 traffic is injected into the datapath of
another pod using either bpf_redirect_peer(BPF_F_EGRESS) or
bpf_redirect(BPF_F_INGRESS). I used Cilium's eBPF host routing mode
which skips the host stack and uses BPF redirect helpers to do all the
routing.

  (net.ipv4.tcp_congestion_control=cubic,mtu=1500,100GiB link,Cilium
   eBPF host routing mode)

BASELINE [bpf_redirect(BPF_F_INGRESS)]
  1. [iperf pod] ==bpf_redirect([pod b], BPF_F_INGRESS)==> [pod b]
  2. [pod b]     ==bpf_redirect_neigh([eth0])==>           eth0
  3. eth0        ==over network==>                         [host b]

  [ ID] Interval           Transfer     Bitrate         Retr
  [  5]   0.00-60.00  sec   231 GBytes  33.0 Gbits/sec  12060     sender
  [  5]   0.00-60.00  sec   230 GBytes  33.0 Gbits/sec            receiver

TEST [bpf_redirect_peer(BPF_F_EGRESS)]
  1. [iperf pod] ==bpf_redirect_peer([pod b], BPF_F_EGRESS)==> [pod b]
  2. [pod b]     ==bpf_redirect_neigh([eth0])==>               eth0
  3. eth0        ==over network==>                             [host b]

  [ ID] Interval           Transfer     Bitrate         Retr
  [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
  [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver

In this test, using bpf_redirect_peer(BPF_F_EGRESS) for the hop from
[iperf pod] to [pod b] led to ~18% more throughput compared to
bpf_redirect(BPF_F_INGRESS).

CHANGES
=======
v1->v2: https://lore.kernel.org/bpf/20260613183424.1198073-1-jordan@jrife.io/
* Introduce and use BPF_F_EGRESS instead of BPF_F_INGRESS (Paul,
  Jiayuan).
    Overall opinion was that BPF_F_EGRESS was clearer, but it was
    acknowledged that this creates some inconsistencies with
    bpf_redirect where 0 means egress implicitly.
* Invert `skb->dev = dev;` and `dev_sw_netstats_rx_add` to make the
  diff cleaner.

Jordan Rife (2):
  bpf: Support BPF_F_EGRESS with bpf_redirect_peer
  selftests/bpf: Add tests for bpf_redirect_peer with BPF_F_EGRESS

 include/uapi/linux/bpf.h                      | 19 +++---
 net/core/filter.c                             | 12 ++--
 tools/include/uapi/linux/bpf.h                | 19 +++---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 68 +++++++++++++++++++
 .../selftests/bpf/progs/test_tc_peer.c        | 22 ++++++
 5 files changed, 119 insertions(+), 21 deletions(-)

-- 
2.43.0

