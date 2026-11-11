Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410256;
	b=f7lMHMureqe/Kfsop/dEqw/cmCUGm8W/LxoeIc/JRdgUpQjvkXiZBh1n8Sg697bv0Q6j
	 0bUYwALbHjTpH+P7pLV673aOG6jcTGtcGtMljpPMlUrDYmeiSTdgWTlwSM9wTXZijYbH7
	 DncZmosy5Eg7GdPYYGg8yaKeEIVX1fCwIsI0rnYCMmLMHvnhOzmQZeCDNPwA1xq6sOYwB
	 f4ptQrxxLVIFdDmr6hJOADfm+Z933TEkRlZbqE/n0pWs0HKaetbW8tk0fE69d1LA2SAbC
	 LYr3LJAML/mgEeHcj1ubnUG7wcwhsYdw3HVFp+BopvuJAI8rtswEDEYtEyom7aOupgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sbLdhSc5U9J/jxHyWnd4AxLJmzxGq1Euqj3lOEEmTkg=;
	b=SPxm4kVpMKYSnuE8vDxIBw14MnbJSgh5i+lEeh+EDMGVdQYVm4rJvwl0uat2GGgw7uf0
	 ZgCnuJmmSG3MUdBFACIDO2E5+tPOPzi+DsKgfx9khLzFApYqZKpnkOzMweHTEAdZJaj+s
	 5qZk7GJ3vEPUlpKECp3sRSX1n0PGX7M9bdvxDP6BJJ+jMIPyHH3IrIJhudKMMNahb+z0R
	 Lij2lM0OzKJXFgU9gc0bxTd+1+91/VUSwfudTYvX5bnFrMycH/EjLNKm5krigOUTZbxDK
	 +iYaXHssJ63OkEp8XJYUgoG2EduuR0OZSBQiRIhkOVecl6gjHj6PDHdFOmgtQqLghyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xHafV8Qv;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7B606A330
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24E7B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xHafV8Qv
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b3541bb1a2so20575597b3.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794410255; x=1795015055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sbLdhSc5U9J/jxHyWnd4AxLJmzxGq1Euqj3lOEEmTkg=;
        b=xHafV8QvPAPS0wmqNcRvcX4vJ2/brD72r6SyMudAQpf6u8hDjeTktS2nrreEE/jbal
         NcnWc1ZNJKWf1PaG+jvqJalk+nZcKfSFO7GhSyWm5pv+I90fwTb/zJiCa654A7x6SIhd
         GfvppRqTWeQoRyIj4mp2JG3M5BbtamXSG+jkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410255; x=1795015055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sbLdhSc5U9J/jxHyWnd4AxLJmzxGq1Euqj3lOEEmTkg=;
        b=IwPcajzFUxnvGXol9WpCLDSStcOvSgGF8vNV4mnMnhbgevAkxed6DUDoLkAw7fWr/9
         Q65ak0kONKzvO9JisWpWmM/SH9GYE8ZHoqIraKE7rF8CTAuetAuXIr7tmxmyFsjun3an
         v+VehdFgJDxWeH4lum430rY2jOh2jl0hRdb6qaIpUX3hVEEaqPCQPR/OeQSLtcsGvcd6
         wyq2qaQ4Ou4Nnsvj/yLf83njO+Pwn2e2zTI7NWF3s90v1lN9PHerIEvswIQ4o1H/xi2o
         hXpknNY+3832vbff1fliZzYzPGm2cCJGnm7Q3kyqcaQWuCQXOzyXn0VBEBeLykjVhDY6
         iVbw==
X-Forwarded-Encrypted: i=1; AL+hErGT8iJhFU8up84WSya7ht10aPNtZrFgDodQNBWPl3DVfl1dAcW1wbXhx1EikDekl55rqDE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7yq10vVd7ISoidegdpSir49v5haUg8CsqgLap7lriWyc7FQoQ
	CFhhHqp1KiS9IhFYPlQRmp4/p9pbOg9KrTNx76MGiTZ7NNziZ1nQSxL+zxjB3IsKu9AWjKlOI6r
	zZBo=
X-Gm-Gg: AYBFou2g2xdZWNrr8drKYf7ZTLDty4P/gKJCzLYWwN20CejQSwDoik3P5IfkNj8j2qZ
	z/bQk47VGYhTWqNLJ3LLePBd0YhwRfU84mB9U3Yn+C1+M2CTdk6BFETI9qMXlUU3I4nam6nROeq
	FVho5csGIcGpFhrYKacXRlfp95DXA3AB1YynNi0+SP6Xlk0V2HcQN2rSXerfcLqNhzvH2Sh+1TP
	fwWs/a5gjko3JppDNaOCfs5fTob93g+mJ5crDU/KSMv3KBqXkM42X8B8rMHgqL/yH8+DonJycMB
	2FjFpx7mgd1ELP5VEJqolWUl/CGJdW21GWG3gcHKtbds83L0Nr82VXHQRvwND7cS7XjgOUKUqnW
	YGv0TfZEtFAllyD/BFp8KvHCN7I+FkxeUaNLEvvk1Pocf1QVURj84gzDOHbOp+4sn6aWhyg4Fgd
	Clt5QaRmCSpQAN/Jva2SEeR96aYEUgvCqciGsyu4lYajLyL70G+TSRQYZaw1JFEt/zSKYUmvI7H
	w0NDYppp0Gcde9PC/is3D1Me0qsWR+mXjXcBWO7VwJRdwlMCsiJYlg5lqEoEyDDqz40MQdMT7/H
	5HvC6K99T0S1yaaCDGXv5S3QTLcn4PF/G5NEt7THSUNnDDlrEb7dz+YsUu5PjtnlKtCMcWy1A/K
	h5B8Ooemnr2AApQ==
X-Received: by 2002:a05:690c:4484:b0:8b1:3606:65f6 with SMTP id 00721157ae682-8b3a81469bfmr17915477b3.64.1794410254970;
        Wed, 11 Nov 2026 07:17:34 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393409120sm46499187b3.27.2026.11.11.07.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:17:34 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net v4 0/3] net/sched: sch_teql: keep the transmit path's skb geometry and device lifetime intact
Date: Wed, 11 Nov 2026 10:17:27 -0500
Message-Id: <QDISC-6HS9.v4.r0.20261111094338@mojatatu.com>
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

Three pre-existing defects on the teql transmit path, all around
teql_master_xmit() -> teql_resolve(), plus the core helper they depend on
all derived from sashiko reports.

Patch 1 makes the headroom private before the slave's header write and
pulls back only the header that slave added, so a header-cloned skb is not
corrupted and a userspace-supplied link header survives a retry.

Patch 2 restores skb->dev at the arp-queue reinjection point when the
neighbour's device builds no link header. It is the neighbour half of the
version 3 patch 2, split out on review so it gets its own commit
log and its own Cc set; requested by Jakub.

Patch 3 moves skb->dev = slave ahead of teql_resolve() so a skb parked on a
slave's neighbour arp_queue names the device whose neighbour took it, and
so cannot outlive the master it came from.  With patch 2 in place it is
reinjected through the master and leaves with a link header.  Its commit
log carries the KASAN report the unfixed kernel prints when that queue is
drained.

Patch 3 is a follow-up to commit dc4b95b8fee9 ("net/sched: sch_teql:
restore skb->dev on the slave failure path") by Victor. Patch 1 is the
same commit's sibling on the successful-transmit path.

To prempt the sashikos:
- The pre-existing teql issues reported alongside this series are fixed
separately. For "the lower-qdisc drop use-after-free" see:
https://lore.kernel.org/netdev/QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com/

- For the pre-existing consumer nft/bpf complaint see:
https://lore.kernel.org/netdev/CORE-9NOG.v1.r0.20261111073528@mojatatu.com/
Note: nft/bpf combination _has never worked_: it is a producer-side
mismatch on two separate entry points, not a regression of anything here -
hence the net-next target.

Hope the sashikos read these and dont complain again about those issues.

Note also: part of the testing of patch 2 runs for packets that reach
neigh_xmit() from nft's `fwd ... neigh` statement, or from
bpf_redirect_neigh() with explicit nexthop parameters. Both keep the
route's dst attached while replacing skb->dev, so the neighbour that
queues the packet is not the one the dst names.

Changes v3 -> v4:
- patch 1, no code changes. Reviewed-by from Simon Horman stays, and a
  Link to the review of the v3 posting is added.
- patch 2 is new: the net/core/neighbour.c hunk of the v3 patch 2 is split
  out into its own fix, with the neighbour maintainers Cc'd.  Asked for on
  the v3 posting by Jakub.
- patch 3 is the v3 patch 2 with that hunk removed; the sch_teql change is
  unchanged in approach. Reviewed-by from Simon Horman stays.

Changes v2 -> v3:
- patch 1, no code changes.
- patch 2 corrects the conditions to recreate the bug: reaching a freed
  master needs sch_teql built as a module, the slave qdisc removed and the
  module unloaded while the skb still waits.  The message now says which
  part of it reproduces without the unload, and names the neighbour failure
  path that drains the same parked skb.  Considered comments from
  Sashiko (nipa).

Changes v1 -> v2:
- patch 1, no code changes.
- patch 2 limits the reinjection restore to a top-level neighbour whose
  device has no header_ops, the shaper/eql/sch_teql class.  Commit message
  also describes how a master is freed.  Considered comments from
  Sashiko (nipa) and Sashiko (gemini).

Jamal Hadi Salim (3):
  net/sched: sch_teql: unshare the header before writing and fix retry
    strip
  net: neighbour: reinject a parked skb through a headerless output
    device
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  3 +++
 net/sched/sch_teql.c | 26 ++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
-- 
2.43.0
