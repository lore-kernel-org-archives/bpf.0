Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6413175A6F;
	Wed, 18 Mar 2026 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796541; cv=none; b=FaqBvfTbLbLQsVs7JWx1YO9dp7TzcESSYYdJxjGglTc4AoeKzYxT2TJYFcxjbNOQMGuUcd5CTnuubUZvE09dMzgH3ywuALFs7hXLUiVgYM1U+VNEHt3snSPoc+kfh/TusNgdrTnV7NDws3JWEuSIAD7uluo3OHzWNkgkIhelWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796541; c=relaxed/simple;
	bh=em6SO/ENzXNvRZ3dWi95voyC+ziv/4ohmr3+F+lO8SI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pk/kqB2z/92i+kAyaGQiEHSA5fHzWbeH8T1ejnIOotHlFbMgdkrTyaRT+b/ih2TVSUye3TWCAv6k8u5v5zxd2QIa5mhXAfYwPWj28KgubfGA1zpqWpKfOwsQyCfmakzXokTHydthbVthG9sn+44/iOyVmjjFIAnN41v1TWUC+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1erzp2z; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1erzp2z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773796540; x=1805332540;
  h=from:to:cc:subject:date:message-id;
  bh=em6SO/ENzXNvRZ3dWi95voyC+ziv/4ohmr3+F+lO8SI=;
  b=g1erzp2zSjULYSuaJO+Cg7RJzU3i0BbXeN8ZP/BCXHgyhtuL+41AXoFe
   CMIOLTyyHE0yE+/npOS/j9ZURNjv/QLL46aDvkZUbLvtyiLVEUVrkNsoq
   +inJmKpLsHi5UEsr/jxUp/8gWDZTkmdHzaFSue6/yQy/NaDjzAugMXvFm
   XAW6DQwV9lhkevxyXYX8+uNCjAU/3Gblw8S2eVhFs/YlqoUGWRejLotfZ
   Xp0+L3DWiWI8vDPUjo3KqSK+rOF9RBysNT2AhmqBkmHhnXPO79HoZz01p
   fCTzWy/Wk7X2MI7A2RbglsgPesUzwm0OaLk7iKMuaGK/9MTUxPPRsebVw
   Q==;
X-CSE-ConnectionGUID: BEg10WviT/6pYt2l1SOQ6Q==
X-CSE-MsgGUID: jjOx2lq6SjG35bZGB6IjQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="77454303"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="77454303"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 18:15:38 -0700
X-CSE-ConnectionGUID: R0w3j8ZNTka8JCKtuJP+ow==
X-CSE-MsgGUID: DPDHn4CoT3i6kMZ+2jRzFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="227399796"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa005.jf.intel.com with ESMTP; 17 Mar 2026 18:15:36 -0700
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
	willemb@google.com
Subject: [PATCH iwl-net] idpf: fix xdp crash in soft reset error path
Date: Tue, 17 Mar 2026 18:15:45 -0700
Message-Id: <20260318011545.12874-1-emil.s.tantilov@intel.com>
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
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c | 7 ++++++-
 drivers/net/ethernet/intel/idpf/xsk.c | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index cbccd4546768..b670f0ea20b3 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -488,12 +488,17 @@ static int idpf_xdp_setup_prog(struct idpf_vport *vport,
 				   "Could not reopen the vport after XDP setup");
 
 		cfg->user_config.xdp_prog = old;
-		old = prog;
+		vport->xdp_prog = old;
+		if (prog)
+			bpf_prog_put(prog);
+
+		goto out;
 	}
 
 	if (old)
 		bpf_prog_put(old);
 
+out:
 	libeth_xdp_set_redirect(vport->netdev, vport->xdp_prog);
 
 	return ret;
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index d95d3efdfd36..b601b6c298c7 100644
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
+	       test_bit(IDPF_VPORT_UP, np->state);
 	if (!restart)
 		goto pool;
 
-- 
2.37.3

