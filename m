Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228386;
	b=3fab1OoOKiJIcYrHwG0dZ1wmrmSkCWOoc8l48KRbwr8t85sO/i23058wS6Ie1ULZ4T1c
	 dhiZ+TNkHMdbKdyfu2eD+yKV75YFR37s5NYvhtjV5R9+8TBKqgsVEQLCivFolL3biYeWu
	 opfCLHzEheqZN6kM/elJ9+kCbFpOFCoFoR/mjFwnD0LdgPu/y7PeuIWZjgvqDnL6wep/C
	 4e8ZBoqVjnlsh0wGyyuxhLOOAvqCNilt4dVDbw4gJ2nPromaHqFF90vIMXkXp6/M0F/L+
	 ZxwwOnW/bqaFUkTORaKM0R12KKerINyVG4UoUsyYxT1TN5mlsw/68YrJMfX+Yb6pBFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228386;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/X2DksPtlhZO70cM7uYMBeEMKvZfW8cBCz15/mjTiOo=;
	b=uJJmpMANz7CqDL0vQJd8AmbGquBxwdEsrXw7vkH2eu6nIKqDduDaBUQVMGBhJuSvJ/FW
	 JpHPgav4M5gge+WeP2k1o/c2WzjweU4CuiBwixl0t/iJ/gcD6ul8JgJ1W5fgKp5wdoSkX
	 9J3yGmyx5YmPS/YkVArtIFxvEPFFzhUiQ27OontCgmR05r6UFwkPjGbH7f34nOqK4xeBs
	 I1fIXJhYqAEv7seXdupIs9dxfRRnqVywjgXMVHzgesMhpJsQDZbDzpJKt+2nU1DCW7KtU
	 0/qt6KeSdDXjcoRGOeyJSPFmGE4PSZgkc4JyaNt6H1D5HZQG9v6eJj0R47Hi56JKNPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=bQptTWAW;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA49606A322;
	Mon,  9 Nov 2026 12:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEA49606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=bQptTWAW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1794228383; bh=6jmmZ4W4ME6d9x/jtJIJ+LI0O9t8/g23Z4plskKUHw4=;
	h=From:To:Cc:Subject:Date:From;
	b=bQptTWAWLOYZ7amrl0pHXjg459OhB941F1bebKRqQve5fceYPRp8/FHbbZWm8efbn
	 sj4C74k6nnHHkhzpagx5L+MQDo5sgDGrpyWX92pqgPbFx8WG5Cs+HM0XtMZY1gedhG
	 Shysqz0ueHlaciPpXAJxm/6a1WJSVrzLsB+9QYO1ymz2t4Pk5itvC33iFN/hEums4z
	 NFjPTYpn7oz5LRgK/FHuueRytfuEoo8X851s5XT7zXmoKAM+6Kwd+GL1AFz9tYCh1/
	 vh6dVNSJzecxZF0n5/6jpGUtoSEVSnBUq8VA/1SyZh8xRavhQzeg6JiKW3FFspI0fI
	 lYpNeVCuVNPtA==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id 30D3D44C0593;
	Mon,  9 Nov 2026 13:46:23 +0100 (CET)
From: Alexandre Cassen <acassen@corp.free.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 0/4] net/sched: let actions drop their per CPU memory
Date: Mon,  9 Nov 2026 13:46:11 +0100
Message-ID: <20261109124618.933149-1-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
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

This series lets actions drop their per CPU stats and lets skip_sw
tunnel_key actions drop their dst cache:

- skbedit, police, mpls and sample honor TCA_ACT_FLAGS_NO_PERCPU_STATS.
- bpf, ife and skbmod honor it too. All actions now do.
- Action init sees the offload flags of the filter. A skip_sw filter
  alone now satisfies the skbedit queue_mapping check.
- tunnel_key skips the dst cache for skip_sw actions.

v3:
- Add patch 2 for bpf, ife and skbmod (Jamal).
- Add Jamal's Reviewed-by to patch 3.
- Correct the memory saving in patch 1 to 8 KB. The 6.5 KB in v2 ignored
  the padding that the alignment of the stats adds.
- Reword the title. Patch 2 does not concern hardware only actions.

v2: https://lore.kernel.org/netdev/20261104214607.556269-1-acassen@corp.free.fr/
- Add the act_api patch so that a skip_sw filter is enough for the
  tunnel_key patch (Sashiko [1], Jakub).
- Give the memory saving in the tunnel_key patch (Sashiko [1], Jakub)
  and in patch 1.
- Drop the race note from patch 1. Commit 1800f27a5ef8 ("net/sched:
  act_api: take tcfa_lock for hardware stats updates") fixes this race,
  which Sashiko [1] also flags.
- Add Jamal's Reviewed-by to patch 1 and the tunnel_key patch.

v1: https://lore.kernel.org/netdev/20261009051930.3619697-1-acassen@corp.free.fr/
[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009051930.3619697-1-acassen%40corp.free.fr

Alexandre Cassen (4):
  net/sched: honor TCA_ACT_FLAGS_NO_PERCPU_STATS in more actions
  net/sched: honor TCA_ACT_FLAGS_NO_PERCPU_STATS in bpf, ife and skbmod
  net/sched: act_api: pass the filter offload flags to action init
  net/sched: act_tunnel_key: skip dst cache for skip_sw actions

 net/sched/act_api.c        | 17 +++++++----------
 net/sched/act_bpf.c        |  8 ++++----
 net/sched/act_ife.c        | 24 ++++++++++++------------
 net/sched/act_mpls.c       |  8 ++++----
 net/sched/act_police.c     | 10 +++++-----
 net/sched/act_sample.c     |  6 +++---
 net/sched/act_skbedit.c    |  9 +++++----
 net/sched/act_skbmod.c     |  8 ++++----
 net/sched/act_tunnel_key.c | 10 +++++++---
 9 files changed, 51 insertions(+), 49 deletions(-)

-- 
2.43.0

