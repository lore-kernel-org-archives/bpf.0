Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF606280037;
	Tue,  1 Sep 2026 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788297488; cv=none; b=EP8dSX3EX6sUTxczKNiJOJifyObQKblNQo8Vfb0W5j4hj6veESJahX6xn3xzc0vBFnZhSOdKQ4biu2l7HyMPLTkKV5K9b6URzLvoo8XbOE3cngSK8wUhpyT8LcDnJcabKROwWh2ALqVy+6TmCho2E69gsNNzsjf1MmdbB3ZVoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788297488; c=relaxed/simple;
	bh=EDRhiVArZ2sz+giVM69a/qTT07qRJM11Kqkmm3swd7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQqpOr054E8QDYqHPBUEw2qM+K7mABdtJ1sv48z1nyqgUtvi1A+dAEvv1nfjgcuG1HKJJ8HXieZOzgOFv1YCvNm5ufp6aiJTmls4gUsSXe76L2yx3oJU8ZHBoa2qyFVSsDJnE1nMvZ4y14uMMby1FkwFphm92NlBhuKBid93ZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8JT8VaH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8JT8VaH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788297486; x=1819833486;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EDRhiVArZ2sz+giVM69a/qTT07qRJM11Kqkmm3swd7c=;
  b=L8JT8VaH2i3zbpwYQk2k2rrrgYuiLMnq0nmV1zMVQwnhTNxikKSlJzGR
   UvtR17lESCcRo8CB6UaVrYLtlnDeBYhfeqT2cS2XxcfpweA5z7RSvclKf
   l+eTkKmOLGcMQyKyqkALkRfTRjNGN+b7p+SyQi7RLwmA5Agpik1q+1dYf
   MOX2a1FSZnrbaQKiHkPUWhVvt1jDuCUVMg8tYjs6+Lr24nDLdUMKxEhbG
   PpxMS8hOsI3lGilhc+kT2aeN7CpFFZZJaarhPQd77y79To/SW++lxLMAs
   eu2XJHNUX4vZT5WIcKKQgKSrUNhP/GHFJZFkcM7nrx7linEHrilUYng01
   A==;
X-CSE-ConnectionGUID: KQD9mRUpQseFO5FnjACWdA==
X-CSE-MsgGUID: HLl9aeh5RzWSjuJFnBNUzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88670336"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="88670336"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 14:18:05 -0700
X-CSE-ConnectionGUID: cgOZS5o1SUiUz6Xt17L0Wg==
X-CSE-MsgGUID: RXVmL+hnSFWya8T9Guwbug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="267439747"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 01 Sep 2026 14:18:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	kohei.enju@gmail.com,
	enjuk@amazon.com,
	chris.packham@alliedtelesis.co.nz,
	przemyslaw.kitszel@intel.com,
	blair.steven@alliedtelesis.co.nz,
	carl.smith@alliedtelesis.co.nz,
	horms@kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org
Subject: [PATCH net-next 0/4][pull request] Intel Wired LAN Driver Updates 2026-09-01 (i40e)
Date: Tue,  1 Sep 2026 14:17:46 -0700
Message-ID: <20260901211752.1922993-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kohei Enju adds support for XDP metadata of Rx hash and VLAN tag.

Chris Packham reduces messaging when Rx filters are exhausted, and
promiscuous mode is enabled, to occur once when the mode is enabled
rather than repeated messaging for each filter.
---
These are the i40e patches split off from this PR:
https://lore.kernel.org/netdev/20260805213541.2281287-1-anthony.l.nguyen@intel.com/

The following are changes since commit c8ea08ba34f2a2e9bfb18ff3d69eb2d69b324f49:
  Merge branch 'netlink-specs-rt-link-ipv6-devconf-updates'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Chris Packham (1):
  i40e: Avoid repeating RX filter warning

Kohei Enju (3):
  i40e: prepare for XDP metadata ops support
  i40e: add support for bpf_xdp_metadata_rx_hash()
  i40e: add support for bpf_xdp_metadata_rx_vlan_tag()

 drivers/net/ethernet/intel/i40e/i40e_main.c | 70 ++++++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  5 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  7 ++-
 drivers/net/ethernet/intel/i40e/i40e_type.h |  5 ++
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 12 ++++
 5 files changed, 88 insertions(+), 11 deletions(-)

-- 
2.47.1

