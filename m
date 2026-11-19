Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092032;
	b=e7fNcVL0iQ9R+kL4kKNx0u75fNiMZxRvRPddN6GbRSSYb750s/zw9T/0gqTS+qmIjCf2
	 9amBqvnZSUasdqI6ApChs7a6Qaw+Ux5r2pxS5pYqCaR7DK2VogRw6Ha1bvcOVmMdo8VfT
	 bn8QTSF5sKXM6H1Dbzdn+FtKbY638fIhs2bzKQj+QmoUazelL71ftWmgEpAUskA9sPZnk
	 bhaJ/DJ1+YFFTdAJEpuugzh0tRKTbVWBDSs9Zy/pCHjrAGVt7gCWn44CDHkIFysmKWd/J
	 lt01h6evzIKRPdYUJ9fxtnHED40z7bUtTidTwTVFZiL4jEtSvEMRMS9q9QHbjYFm4AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B+OXNLr0kdKkrvvm/CcRnGXdIGMgDEGRb/zrjUPqAT4=;
	b=JTcWSPIoGrTXDPTbT4aXrhDSxg1UEk7NXn1+gAsVVBIpT5Kabqt9vzTDdDx+t+FR/lka
	 XhbaS+mneVu43hZHnjNlJgkl51JUwVSMn9U5hauFhOraknUX0Ksj6VjPNQA8K2/eaxa7f
	 Z8od2rvOPYitTkCbKaOdYChJ1LEk382SMZ7RIuDLVSvw8LZqkcogLvpijaYimZJmZ5AOC
	 NXqfTy30y4hNoWfAcqwwe/TE4UNHGiZ2Vyrz6wFSyMtPwvme0nhHrlo0EtVba8q+DqVxC
	 nRQxHP8iUTfl8L41SVYAigznHFaucKIEYJoNjLPiGp1hktoDDC5tspqWNLLpeyqwbrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=HUQzosz2;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18875606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 12:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18875606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=HUQzosz2
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53664b4860bso22460681cf.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 04:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795092031; x=1795696831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B+OXNLr0kdKkrvvm/CcRnGXdIGMgDEGRb/zrjUPqAT4=;
        b=HUQzosz2FBP7Ozg3wh92TixJNdi76eZbRVeBDr9KL1inpC09+GZn7N50LzY73CrlRC
         nh/FMBhWjdHpER1JYb1oyIcsagvYrGr904tjFODs9sPS8LTkrvkw7IzUFvo++D8ejPoc
         ANbpimzCQhXkJChEAhWLaQoKbrKkvlIVyluUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795092031; x=1795696831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+OXNLr0kdKkrvvm/CcRnGXdIGMgDEGRb/zrjUPqAT4=;
        b=p+D28/brw4Qh+MLRUztQKncHCl4mYCNGKVjwWT3NngodGJTXXdlHFyXKapUxzDmm21
         7Pny+VyoNBXQckVGmOQlT7YYfL5hMoUgCZ4PyISzqx+AVrJMQ+dXAHJhOXIL9dax6VIH
         xgYcijL8Y6zXYAwl0P8J11GMnkjHM8GduP8MwLZ7iq+E3H41EXOYHIuaikjrf39sTQyy
         8NU3nLwz5wWWABN9z8JdNWcZQfOtcRaxVcWKLY8xlIoA0Omo2AgBFzjacE4Z40VM94Hi
         KGBykW+qO39CTOK+XS4GfsBXQetNazuCRWIqqX2mh1qjem6hbPyqxzKAQuoCZaRfMwtY
         y7VA==
X-Forwarded-Encrypted: i=1; AL+hErFJuWiwAc9rDyUpjYat1YtID1OdTigmfuPR8wr/Upet1Yb9YAhfSFdDh5Ia2nAovW1sWDY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ty9f9EwE6UdOxVDIh3DfoxU+g5O/SwI0yjal3dzkIG+y51fzD
	9TRuSKsiX0HM6FaZan80M3A7Vt1RUV/baVFovE3dn4BhB7fv+yaiF3ihBi9AMt9bkA==
X-Gm-Gg: AYBFou0LN1hpDpyP1NOrPGW5CTE4G3p7JH+VFiWoLTj8a5jREJs7sQE4sHtZ4lY4tQb
	JIlV8/I2eXsFjt1/KIeSCt06rqj7Khfn12SDBpD1IH01GP+dlpblJya3tHk/oTTvB5iMsllg9oS
	xWh1jLbRwuE4EqopfUpHJxJw4bTrl815PRu5S8qvEYnmOKcbGpF56ixtFoCW6lHQHey5/ZhyJfQ
	Hx5euQ7xDX/XW7HAOb2U88UALIEY3IilS+zeiuI3n6ZWHbgGXg6j6V08v50I3tv1H1rL+rInWNz
	/hYHHK+21wtPHts6qvKXmhDXEmdEV8P1dlnLSZq1lOgboDCF74Im/OhGK6ZEeYY046Mt9xnNUop
	PRSrEeBl4m3sGgR9wcKJMbiTRlfWvapxpV1ef4hjgZu/TRGdJfQc1Dv+mqo+meYdjwWqqBVDCu/
	Itx4KJSRc71xjqIxNUNNQY5TsmCQrPPyksW+oY8J+Rwb45MNKY5kmx8RlXqQITsws5vVPv2zmbX
	2cYwfNd6DNZEz+kYKz4f7HxG02Ig3ZevxSZU7oZwWHbmlBRM2SCVQQQmGD2N1ef9lssxJkSBd+9
	47KYcLnmxt8Mhx4Mi7ExyZq5N3Zpgn+tPm+fE5Gh7D5+Bfmw8YeicuNiKPGYG/+umAaMQcbcD5U
	=
X-Received: by 2002:a05:622a:598d:b0:55c:840:1307 with SMTP id d75a77b69052e-55d5a62fbb3mr85938531cf.20.1795092030871;
        Thu, 19 Nov 2026 04:40:30 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d66b75823sm22370191cf.13.2026.11.19.04.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:40:29 -0800 (PST)
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net v6 0/3] net/sched: sch_teql: keep the transmit path's skb geometry and device lifetime intact
Date: Thu, 19 Nov 2026 07:40:22 -0500
Message-Id: <QDISC-6HS9.v6.r0.20261119070330@mojatatu.com>
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

Patch 1 makes the headroom private before the neighbour can write or queue
the skb, and pulls back only the header that slave added, so a
header-cloned skb is not corrupted and a userspace-supplied link header
survives a retry.

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

Changes v5 -> v6:
- patch 1 closes the finding Sashiko (nipa) raised on the v5 posting.  The
  retry no longer strips whatever offset it happens to find: every attempt
  starts from the network header, as neigh_resolve_output() does, so an skb
  that arrives with link-layer bytes in front of its network header is
  given one link header rather than a second one.  The length is recorded
  as the offset the neighbour built, so only what this slave added is
  pulled back on retry.  Considered comments from Sashiko (nipa).
- patches 2 and 3 keep their code, and their commit logs now name the
  cross-patch dependencies: patch 2 says which patch parks the skb it
  handles, and patch 3 names the patch 2 prerequisite and the ICMP error
  routing the skb->dev move also changes.  Considered comments from
  Sashiko (nipa).

Changes v4 -> v5:
- patch 1 closes the finding Sashiko (nipa) raised on the v4 posting.  The
  head is unshared before neigh_event_send(), so a skb parked on the
  slave's neighbour arp_queue is already private when that queue is
  drained and the neighbour writes the link header into it.  The retry
  strip fix is unchanged.  Considered comments from Sashiko (nipa).
- patches 2 and 3 are unchanged; this resend is for patch 1.
- patch 2 adds Kuniyuki Iwashima in its Cc set (nipa CI).

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
 net/sched/sch_teql.c | 27 +++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
