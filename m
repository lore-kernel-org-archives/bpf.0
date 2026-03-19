Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A22C0F81;
	Thu, 19 Mar 2026 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942948; cv=none; b=QENJszGkiREMzym/Or7GVa7FiNOxSSpubWC+QtXYZFWaMIl+9m4ax1cSEnAggA55N8g0hAW3boS+oBetukrgLT2/t7V3tNOjs/24YFHeIFkmyOyhcOH98V8tqazDeUfyHkebZCFe8Mb6CQW7TtshwT+zfREWQo+qNEnC6PiF6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942948; c=relaxed/simple;
	bh=DDxAOZ70XScEu44FhyuhK40fHpzL1B8BbtDWULsAoYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HXLYDMferWlHRcA/Fg1Vc39Ls/VquS4449XpQ2jNROenEBi8KhXwEsHR5rkWzAZQ4paQB0YjnMdteRvW1i+7bgUUeaUa3oluLQqVKkApm4tCElfPbC+NyrFjzMTuhKl7HZzieeVg2rkGCGfynU/gWD4QeW/Ql1u7MCytf5WFvS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrMgkGaR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrMgkGaR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773942945; x=1805478945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DDxAOZ70XScEu44FhyuhK40fHpzL1B8BbtDWULsAoYA=;
  b=nrMgkGaR6i0I5Z5CDkUZsJpLI/c6Z+nOEp9KcA6RXktBQQLIQ7GG0gHS
   4XktJRDkb3xWlAC4pQmZuv2DpPxr5Bw8d12j9oVKHjsL3WN98qifooLqy
   KR5GSvA75g8JjrJwm1GKti60VmeMS5V4xmhezi1sP8ug7hoLKoZzYEIT3
   2bB9ba2MErNSgZShbwTxTXStd8ZHf/6IFxKapkBouTRkRFP8OKFEX32Yf
   MlQQDR8S1NqmbhyK5tWR4BbNMNiFLVHwPu2kjjhu+JLb3MbAVNwKRXn1V
   dLArObpiVIjj70RWYqmkn3GPqVrYw2YuXDjs4Iu9AmxtfUpjh1OKetxg6
   w==;
X-CSE-ConnectionGUID: zGJy64xxSYuYgcj8viQeUw==
X-CSE-MsgGUID: vjYgfP3NQqm34PaQY3sfoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74038576"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74038576"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:55:44 -0700
X-CSE-ConnectionGUID: IinG5dz/S7GCuN4a1t/UDw==
X-CSE-MsgGUID: 67/fu9D4TdGVXl49iU26PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="246058545"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 19 Mar 2026 10:55:41 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net 0/8] xsk: tailroom reservation and MTU validation
Date: Thu, 19 Mar 2026 18:55:30 +0100
Message-Id: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1->v2:
- remove xsk_pool_get_tailroom() definition for !CONFIG_XDP_SOCKETS
  (Stan)
- do not rely on pool->umem->zc when configuring tailroom (Stan, Bjorn)
- simplify dbuff setting in ZC drivers (Bjorn)
- use defines for {head,tail}room in tests (Bjorn)
- return EINVAL instead of EOPNOTSUPP when mtu setting is wrong (Bjorn)
- include vlan headers and fcs length when validating mtu (Olek)
- tighten umem headroom validation when registering umem (Sashiko AI)
- set XDP_USE_SG in xp_assign_dev_shared() (Sashiko AI)
- adjust rx dropped xskxceiver test

Hi,

here we fix a long-standing issue regarding multi-buffer scenario in ZC
mode - we have not been providing space at the end of the buffer where
multi-buffer XDP works on skb_shared_info. This has been brought to our
attention via [0].

Unaligned mode does not get any specific treatment, it is user's
responsibility to properly handle XSK addresses in queues.

With two adjustments included here in this set against xskxceiver I have
been able to pass the full test suite on ice.

Thanks,
Maciej

[0]: https://community.intel.com/t5/Ethernet-Products/X710-XDP-Packet-Corruption-Issue-DRV-MODE-Zero-Copy-Multi-Buffer/m-p/1724208


Maciej Fijalkowski (8):
  xsk: tighten UMEM headroom validation to account for tailroom and min
    frame
  xsk: respect tailroom for ZC setups
  ice: do not round up result of dbuf calculation for xsk pool
  i40e: do not round up result of dbuff calculation for xsk pool
  xsk: validate MTU against usable frame size on bind
  selftests: bpf: fix pkt grow tests
  selftests: bpf: have a separate variable for drop test
  selftests: bpf: adjust rx_dropped xskxceiver's test to respect
    tailroom

 drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 ++
 drivers/net/ethernet/intel/ice/ice_base.c     |  5 ++++
 include/net/xdp_sock_drv.h                    | 16 +++++++++-
 net/xdp/xdp_umem.c                            |  3 +-
 net/xdp/xsk_buff_pool.c                       | 16 ++++++++--
 .../selftests/bpf/prog_tests/test_xsk.c       | 29 +++++++++++++++----
 .../selftests/bpf/progs/xsk_xdp_progs.c       |  3 +-
 7 files changed, 64 insertions(+), 10 deletions(-)

-- 
2.43.0

