Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA81F52CCF8;
	Fri, 18 Sep 2026 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766707; cv=none; b=Qp6f12GhHrwbVuabV98YORq18WZxfdfxKs9Ifw6RlxS8cLoAgYBepnOfe5k11qCVc2AG9kWTqg89ILRLOKFhXu89VunuUuwHvyV5Fcq/9TPhDJ2VFhFiJaGAXilrSmXmvF8ryGZtGws8nKIkY8BiGFFiDyDK1WmBejMRffruD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766707; c=relaxed/simple;
	bh=lniSNryGmy8lAfxF+rBnxTLORla1OPlxzxjOaa0fnkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Huqfji6JD8xYnO/mMyykl2yUzlHvMFov9S5WlfGNn9NpOiKo3drkfI4xRH0jk5eDmmdi8mH1ZCu3sq/eJPbJPGzk2ZLgXchzX8ITDvxhaYXJPKeCnErRlUYomU+ggZzX7iBtHJVYcHteqH+CXyVVGadeqFZNA7gWIBQIbQYHrx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKA8prvX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKA8prvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789766705; x=1821302705;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lniSNryGmy8lAfxF+rBnxTLORla1OPlxzxjOaa0fnkk=;
  b=VKA8prvXmu4Tbo00ssjk+aOSZnoz9ppmOjaT0GdWroJPa8rN9H29g1aj
   rvD3lJL47P7sZ+j9Q+56FbjvjYzgVJkP7ApfRnLwbqgFZGlY3PMmwPZmI
   Ix2rZlnBoZQjyTkFY7pbk09Fc16XAhkInhFEgkGzsCAf//5Q+uKOQFV94
   PC0o0w+HRTC18loMIUNIQgtWoaDCLmf47+6aq2g7Ht43kZfgs61RDbq4B
   bBzNx4Qk5AL7ek3YTxYk41nf9rpgDznEPolY9q6dlWZhH+sdyyOHlcCtl
   lmGST4R/18DcXA20UdrlwlWXxOlxLdUaeS152VIe533IoIAPy09WTotEJ
   g==;
X-CSE-ConnectionGUID: J6z27n1qQVOvdwimiIYYVw==
X-CSE-MsgGUID: 6IQ7c/cgTNKNBDdNaRrasA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="89436204"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="89436204"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 14:25:04 -0700
X-CSE-ConnectionGUID: SdWSZjlxRf+YyclxZoP+Ug==
X-CSE-MsgGUID: fW6QyodTR22EMLWpkmCKtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271251346"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Sep 2026 14:25:03 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	maciej.fijalkowski@intel.com,
	zhaochenguang@kylinos.cn,
	magnus.karlsson@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jbrandeb@kernel.org,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org
Subject: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates 2026-09-18 (i40e)
Date: Fri, 18 Sep 2026 14:24:47 -0700
Message-ID: <20260918212458.550425-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maciej fixes various issues with VSI setup, cleanup, and rebuild paths.
Notably, keeping q_vector allocation synchronized with channel-count
changes to prevent threaded NAPI reconfiguration failures.

Chenguang Zhao fixes AF_XDP multi-buffer handling by correctly copying
and attaching fragments and cleaning up on allocation failure.

The following are changes since commit 46bc52d13594848023e681860df8700c8db14354:
  ipv4: fib: fix data-race and stale genid check around nh->nh_saddr
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Chenguang Zhao (1):
  i40e: xsk: fix multi-buffer XDP_PASS skb construction

Maciej Fijalkowski (7):
  i40e: unregister netdev before clearing VSI on reinit failure
  i40e: avoid null ptr dereference in i40e_ptp_stop()
  i40e: make ring pointers unreachable before freeing via rcu
  i40e: avoid deadlock when calling unregister_netdev()
  i40e: fix potential UAF in i40e_vsi_setup()'s error path
  i40e: do not expose netdev too early
  i40e: keep q_vectors array in sync with channel count changes

 drivers/net/ethernet/intel/i40e/i40e_main.c | 129 ++++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  |   5 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  |  13 +-
 3 files changed, 88 insertions(+), 59 deletions(-)

-- 
2.47.1

