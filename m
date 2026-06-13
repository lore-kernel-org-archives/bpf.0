Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AED23D7CE
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781375676; cv=none; b=a1M0GFQPl2muGEc+592xvBmPTudn3BPycGqx79UEXheIhvonbTgffA9gqr8P1PeeuALLp2ihlrv4djrMsPRyIPl3XsrvqhILGwv4itKItY+CFUnXsaI/bFNqsEzROBTYMbIcTlFXb9aNgtSGdKtXI5pwy4itU7J8UmQ3Zrz2MRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781375676; c=relaxed/simple;
	bh=SXQSUZ0U/F4r/AXAi7Qh+DoP0lk/Q8qajpC4LoTLTmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJJge6FRr7IEp6g/gxm548t8QtHwmTPuiuCaLd5NGFRC4lOCsJ5ZEKWo2qFGAYEytaCLSSYPUZlIyc7Sej6WZ/0kSjmJS+glR3iDzV6Ukv3gMcCbyhl8D4tmnJyA9PuTeyC57hAwvEenLOC/nUKG2P4hGXjeXbjarpWxzYmDosE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=DiILeJaK; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="DiILeJaK"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304f9bc869aso235418eec.2
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781375673; x=1781980473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iVOTG9mqzAl5iIZdVjvL/CvNIxqnVecyzPnuB1AZvck=;
        b=DiILeJaKog1eHgI5lgJER4Yd5pRFJkcrd34HpiVtOK/88vmDdM3eHFgN6KcmDMPwzM
         0ZdYrOgbx5bJ8QAV8bSnx3eWX9qhYaJwjLW2aL0un/qaWtqaRaxzA80R/pQiI9id1sGC
         JcHi3a++NDtvILwcKrGvidDHATDV2bam9aQSoaoeAWW6JqG7oZse4QxTg1QuHeL1koq4
         fkx1DUmy2/fmF5aVES7sqvIUMJFA79Opn9RFVmcJlfLVmbpG5PO0CABNEdNpVOq03cr+
         XJuRtVL2bYoxulANHzrmDJhYd5ZFE6K/5zQ4XxzITqVXZas+izPjTV9j4tHLl6yHef5X
         SDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781375673; x=1781980473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVOTG9mqzAl5iIZdVjvL/CvNIxqnVecyzPnuB1AZvck=;
        b=EFxSHAeslG8GGjgjpdv2i2lMBPUweW2iuFurF6ZkiU4G5RgnN1BNkCIi0iXfAINZcV
         kHeAkwWCNki8vAqgr7WEOoyCbb1o/4JB8FdBvGRrbUR/DyBACLcL0ljSDyOwMzmJMpVD
         dzZT+wqN9a4y3TTTQfwgIWx3j/MLC91ksfAN6ucy+vGyGmCCZzON7fBYUZQ6f9OWTJhC
         I6RI2BEGpEJwp3E7g7YOC56waEVC5BphLaxSr9aQcDzfGY+lJ2QMU1CloN6e+K5C8ANT
         TayP3oGDTwWkSeKVv1oy7S6MVqVrtPr2mesmaLGjtEUENMgE0H6ZITKRcMk6d/hoq38K
         N4fA==
X-Gm-Message-State: AOJu0YwL4njzhJEAAd2RH2vfQVEdPO4Kbi2AilEF0WPuw8yMb0CUNuSe
	kCh4CFnV+BVLcQCqYP24CT6Ttd1J+QoL5JD5MvRWkNNwmnPxYMo3OEuJ6BcTHn5B3W+jqWZ9fFA
	9hL55
X-Gm-Gg: Acq92OEcUJksRO+X3gC2PQduXkNkdEumrFESyXGc9BlMNqWWhjwlwSU5HdxTltq0ka3
	DHlbLJnWuK4Z+ZMF+DIUdKWqIYVww8GKSCI94JXRqFn+P2RlLfWiPg4d6gIil419pZEipGZRpA4
	8ER7/c0ewUelG0p90q1Ba5TYJuf2KMyM1aBrZrJLtRnUgyR12gPdASO5vLlhr5WGN8qs8RwcBwl
	ZozdD0wAwZudkahfKiCAXvo71MFsnYYVegmPIyzlwoYaSixVDUvXbOPvVChJnWJ4VCV+eFPw9dh
	wMpg6sbHSlpcozJtKcyrmoh9erRdd9GXMpw1DrTHgeWK5ZLO0d4dmce3xZaKPpC53rwf4st5KfV
	tNCYgjnq5eLj56xrICjkdkN0SNOoPkR8Et7oARXXdKP7PlVJmUg/KqQtFkHC9AIN/chMFWnyYE8
	zX3Boiw6/PTgUKiT13Vo8NUA==
X-Received: by 2002:a05:693c:3742:b0:2da:a813:a629 with SMTP id 5a478bee46e88-3081ff4badamr2104625eec.2.1781375673225;
        Sat, 13 Jun 2026 11:34:33 -0700 (PDT)
Received: from t14.. ([2001:5a8:47ec:d700:7881:81f1:548c:e2d3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm9181543eec.4.2026.06.13.11.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 11:34:32 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v1 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
Date: Sat, 13 Jun 2026 11:34:04 -0700
Message-ID: <20260613183424.1198073-1-jordan@jrife.io>
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

With this patch, the BPF_F_INGRESS flag tells bpf_redirect_peer to emit
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
 |             | 5. bpf_redirect_peer(BPF_F_INGRESS)        |  +-------|
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
bpf_redirect_peer(BPF_F_INGRESS).

As a bonus, since the skb doesn't have to go through the backlog queue
it can take full advantage of netkit's performance benefits. I set up a
test where outgoing iperf3 traffic is injected into the datapath of
another pod using either bpf_redirect_peer(BPF_F_INGRESS) or
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

TEST [bpf_redirect_peer(BPF_F_INGRESS)]
  1. [iperf pod] ==bpf_redirect_peer([pod b], BPF_F_INGRESS)==> [pod b]
  2. [pod b]     ==bpf_redirect_neigh([eth0])==>                eth0
  3. eth0        ==over network==>                              [host b]

  [ ID] Interval           Transfer     Bitrate         Retr
  [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
  [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver

In this test, using bpf_redirect_peer(BPF_F_INGRESS) for the hop from
[iperf pod] to [pod b] led to ~18% more throughput compared to
bpf_redirect(BPF_F_INGRESS).

Note: I wasn't sure about the flag name. I can see where BPF_F_INGRESS
      might be confusing, since technically it's an egress redirection
      from the perspective of the peer device's namespace. But, I didn't
      want to add a BPF_F_EGRESS flag just for this and convinced myself
      it makes sense, because from the perspective of the caller the skb
      will be flowing towards the current namespace.

Jordan Rife (2):
  bpf: Support BPF_F_INGRESS with bpf_redirect_peer
  selftests/bpf: Add tests for bpf_redirect_peer with BPF_F_INGRESS

 include/uapi/linux/bpf.h                      | 16 +++--
 net/core/filter.c                             | 14 ++--
 tools/include/uapi/linux/bpf.h                | 16 +++--
 .../selftests/bpf/prog_tests/tc_redirect.c    | 68 +++++++++++++++++++
 .../selftests/bpf/progs/test_tc_peer.c        | 22 ++++++
 5 files changed, 116 insertions(+), 20 deletions(-)

-- 
2.43.0

