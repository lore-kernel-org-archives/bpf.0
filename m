Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834FB1CBEB9;
	Wed, 25 Feb 2026 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043448; cv=none; b=qMfLFreH+EcdQLa90RBE7SW+yiPghWcAbbvITMb6xaYEPHWYzISXBDYr4NwC/DLigKDcXjN3tG/lc+Ax2rZXbZyym4kvWN77/37wQcYVJTmgdWN5nTQ6QR0kxphwXrSDkEZuwVNwmD6J3k/g6G7DAzjZh/shEMSURSNHphSfk8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043448; c=relaxed/simple;
	bh=UucAOz994cV+L7XaqXObhEfee3wJbdE/6/J3TtjyssY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rikEriYB3WX0gGx4y0Ua/NALc6eNy3jtHGTtMOOsDzP0AH5kHfdP7TjXaY7n7KAdVKXYznRnfpI1ffZ1Etu3L9hSaDF8khdZpqG14nfHBhS3U0fkYN5qCaJKo3aSST+djK7+MjqNHL/UVTJH2HdON1/LVW/prY6NxkGU4wODcOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEXKKiDb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEXKKiDb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772043446; x=1803579446;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UucAOz994cV+L7XaqXObhEfee3wJbdE/6/J3TtjyssY=;
  b=NEXKKiDbflbbendMEbSRZC6O25EWp+ciC99tvoCjOmkkMdclzH0DwHF2
   TlMwGOo2+eOie5tYzlb5cLhiWbO1Xol4EZZoR+S8WcedMh+gOMhrwEKzH
   fDkenLMmh8KIa4RWqdlLSQhTG1v7JDovSbnJEHTtqD6ox2RVC91mA4UDy
   uDfoD5sYz9ddmJdxgGHeAFI7upqf1omodqftxyVMeB7zNfprPp/vFpRjY
   EhIOECW0EOtdyWuCVfIyL/2jr6vQabpvbQh9uSd+5a3Nw4dCxh7LnKpu7
   cSS5BwRDn8tHooBBoDwDwDgfDiqeP3xr2VXnm2WP5YxfoVr++sI/qOd7P
   g==;
X-CSE-ConnectionGUID: gS3CfVdTT6S6LhjE94ZoHw==
X-CSE-MsgGUID: cqxaZO4tTOSBqyIyh8/syg==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="72967631"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="72967631"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 10:17:26 -0800
X-CSE-ConnectionGUID: EiyiVOgUSxCRGP3NzQaxSA==
X-CSE-MsgGUID: 0pRomoGlTAWqXMRnqrxLdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="254070266"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 25 Feb 2026 10:17:22 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 36A0232C80;
	Wed, 25 Feb 2026 18:17:20 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v2 00/10] libeth and full XDP for ixgbevf
Date: Wed, 25 Feb 2026 18:46:34 +0100
Message-ID: <20260225174646.3514556-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update ixgbevf with standard XDP features by utilizing libeth library.

First, in patches 1-4 refactor existing general and XDP Rx code
to use libeth fill queues. Then in patches 5-7, add support for
XDP multi-buffer and XDP_REDIRECT (target and source). Patch 8 addresses
particularities of one HW type by using a software header split.
Patches 9-10 address page pool not being reconfigured on MTU change.

v1->v2:
* fix wrong return value when allocating descriptor memory fails
* tag xdp_prog in ring structure as RCU

Larysa Zaremba (9):
  ixgbevf: remove legacy Rx
  ixgbevf: do not share pages between packets
  ixgbevf: use libeth in Rx processing
  ixgbevf: branch prediction and cleanup
  ixgbevf: support XDP multi-buffer on Rx path
  ixgbevf: XDP_TX in multi-buffer through libeth
  ixgbevf: support XDP_REDIRECT and .ndo_xdp_xmit
  ixgbevf: reconfigure page pool when reallocating buffers
  ixgbevf: allow changing MTU when XDP program is attached

Natalia Wochtman (1):
  ixgbevf: add pseudo header split

 drivers/net/ethernet/intel/Kconfig            |    1 +
 drivers/net/ethernet/intel/ixgbevf/defines.h  |    2 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |   48 -
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |   98 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 1104 +++++++----------
 include/net/libeth/xdp.h                      |    2 +-
 6 files changed, 487 insertions(+), 768 deletions(-)

-- 
2.52.0

