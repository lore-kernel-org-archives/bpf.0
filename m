Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3F40628E;
	Thu, 19 Mar 2026 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773960117; cv=none; b=hXk+ltdqagSvh8kueKH01S9I+R+glYrfRJnUIFAlhabwvk8MwOv01nVb29H8BkG9HCkHRVqbMEEh/IxqqCO4oCi8mwjI4xxC7xMiv27O6MjNzlZTW6613Go6kFi550LHnTZANwUYtwyYMM4402sy4YBQCCodHFs+JYPwSPTqMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773960117; c=relaxed/simple;
	bh=w42GVYaBOiENOnZTs/bf+y6P5cN1lu44uYlM0XIDM0A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sPyPadO0PfGBiru/NTPN5bmWWC6/j0MIY7Eq7GBtHI7d8QxYmEAFmbsAGwQaRS47dfRXqNoK10REOfMu5CwRrme0Xs8KFPGHFlyenjWmmFvt0JRFWxCHANrgmfzxp9U8oxOcoHGhGnVnQh+HiExtTXath8Cf7ZcQQuzvcryL5Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1JwJQpl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1JwJQpl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773960116; x=1805496116;
  h=from:to:cc:subject:date:message-id;
  bh=w42GVYaBOiENOnZTs/bf+y6P5cN1lu44uYlM0XIDM0A=;
  b=I1JwJQpl7aVXUiWUETz/DQ8gBTrzfMNVvVk9L939LkakZ+T9jC5KR0IL
   Xt9RapGN4mCQBNaGqNMMJYRbT4Q1dhj7ke9BA0X3TRBIMK2LO5WxJqL9m
   ZJNaSj+iF6Cnwi5+ijtWaI916gDBRO3k5+nMU2Wxn+CUii0eVqT03A1uP
   4gOXMVgVkvY3URPgzZ1s+Lm/nji3aWeR9ifzx3cG07yhzgsb1IlRadKSJ
   ks7SXBGwMjxASPQxDdOLnA0rxjzKprH4EPDtN1jbze3v5yU+RMRqdE3da
   ltli5vT7cofA9R3c9rxhPfGn5z2vvB6Va25a9F/Z4u5LCjESbDHzSnZYc
   g==;
X-CSE-ConnectionGUID: tNSJR+tGTuegwFpGc6PR7Q==
X-CSE-MsgGUID: QbDVCmhBTU6/wkZtI8isAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74060139"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74060139"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 15:41:54 -0700
X-CSE-ConnectionGUID: cjgj4rPqS52u0ucCRTXghw==
X-CSE-MsgGUID: 7P+ErQc7SHKpge4J3R2xDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223326020"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa007.jf.intel.com with ESMTP; 19 Mar 2026 15:41:53 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	aleksander.lobakin@intel.com,
	decot@google.com,
	willemb@google.com,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v2] idpf: fix xdp crash in soft reset error path
Date: Thu, 19 Mar 2026 15:41:59 -0700
Message-Id: <20260319224159.23885-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

NULL pointer dereference is reported in cases where idpf_vport_open()
fails during soft reset:

./xdpsock -i <inf> -q -r -N

[ 3179.186687] idpf 0000:83:00.0: Failed to initialize queue ids for vport 0: -12
[ 3179.276739] BUG: kernel NULL pointer dereference, address: 0000000000000010
[ 3179.277636] #PF: supervisor read access in kernel mode
[ 3179.278470] #PF: error_code(0x0000) - not-present page
[ 3179.279285] PGD 0
[ 3179.280083] Oops: Oops: 0000 [#1] SMP NOPTI
...
[ 3179.283997] Workqueue: events xp_release_deferred
[ 3179.284770] RIP: 0010:idpf_find_rxq_vec+0x17/0x30 [idpf]
...
[ 3179.291937] Call Trace:
[ 3179.292392]  <TASK>
[ 3179.292843]  idpf_qp_switch+0x25/0x820 [idpf]
[ 3179.293325]  idpf_xsk_pool_setup+0x7c/0x520 [idpf]
[ 3179.293803]  idpf_xdp+0x59/0x240 [idpf]
[ 3179.294275]  xp_disable_drv_zc+0x62/0xb0
[ 3179.294743]  xp_clear_dev+0x40/0xb0
[ 3179.295198]  xp_release_deferred+0x1f/0xa0
[ 3179.295648]  process_one_work+0x226/0x730
[ 3179.296106]  worker_thread+0x19e/0x340
[ 3179.296557]  ? __pfx_worker_thread+0x10/0x10
[ 3179.297009]  kthread+0xf4/0x130
[ 3179.297459]  ? __pfx_kthread+0x10/0x10
[ 3179.297910]  ret_from_fork+0x32c/0x410
[ 3179.298361]  ? __pfx_kthread+0x10/0x10
[ 3179.298702]  ret_from_fork_asm+0x1a/0x30

Fix the error handling of the soft reset in idpf_xdp_setup_prog() by
restoring the vport->xdp_prog to the old value. This avoids referencing
the orphaned prog that was copied to vport->xdp_prog in the soft reset
and prevents subsequent false positive by idpf_xdp_enabled().

Update the restart check in idpf_xsk_pool_setup() to use IDPF_VPORT_UP bit
instead of netif_running(). The idpf_vport_stop/start() calls will not
update the __LINK_STATE_START bit, making this test a false positive
should the soft reset fail.

Fixes: 3d57b2c00f09 ("idpf: add XSk pool initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
Changelog:
v1->v2:
- Cleaned up the error handling in idpf_xdp_setup_prog() to avoid extra
  check and bpf_prog_put() call in the error path and fixed indentation
  at the assignment of restart. Caught in review by Alexander Lobakin.

v1:
https://lore.kernel.org/netdev/20260318011545.12874-1-emil.s.tantilov@intel.com/
---
 drivers/net/ethernet/intel/idpf/xdp.c | 1 +
 drivers/net/ethernet/intel/idpf/xsk.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index cbccd4546768..18a6e7062863 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -488,6 +488,7 @@ static int idpf_xdp_setup_prog(struct idpf_vport *vport,
 				   "Could not reopen the vport after XDP setup");
 
 		cfg->user_config.xdp_prog = old;
+		vport->xdp_prog = old;
 		old = prog;
 	}
 
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index d95d3efdfd36..3d8c430efd2b 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -553,6 +553,7 @@ int idpf_xskrq_poll(struct idpf_rx_queue *rxq, u32 budget)
 
 int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
 {
+	const struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 	struct xsk_buff_pool *pool = bpf->xsk.pool;
 	u32 qid = bpf->xsk.queue_id;
 	bool restart;
@@ -568,7 +569,8 @@ int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
 		return -EINVAL;
 	}
 
-	restart = idpf_xdp_enabled(vport) && netif_running(vport->netdev);
+	restart = idpf_xdp_enabled(vport) &&
+		  test_bit(IDPF_VPORT_UP, np->state);
 	if (!restart)
 		goto pool;
 
-- 
2.37.3

