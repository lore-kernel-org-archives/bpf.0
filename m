Received: from out28-130.mail.aliyun.com (out28-130.mail.aliyun.com [115.124.28.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A731A579;
	Fri, 23 Jan 2026 01:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131133; cv=none; b=SMdHZmyd6/AJyJopU2l6jKx/ywlZ/fos4mkYzRqVR7C3vySWvZ1xmb2XgHu2crdIiUfVBdFPRUpkulFSjNBJVtqzBaxIcWuNGnYlF1YOE5opdE7iFEqSWpGLUZwiw8PzQDXZkQxgM7Fwm98qDHaUnmp4ftB8/tGfE+2r07G+1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131133; c=relaxed/simple;
	bh=MeSh+vAteVf4kOdL3k7B7vIsfyeY5mKjbxKzFhuUjEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MC8tyG5sZo0Aw7fxslovpCIf/ixIzBmThdpisYF90Fs/D0VVrADuMz5EKX+b7WV1PnRiJPTv3Truxd9bO8u3lVQteOXDFqOAPpjHchJyKZIjFlHm/vYspndBUOLfgnsjA7mAXinf4Dwc0G31qfEHKl5C2qlTJfY3G1Wg46LEhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gDSYVlh_1769131114 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 09:18:35 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	hawk@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 net-next 00/15] nbl driver for Nebulamatrix NICs
Date: Fri, 23 Jan 2026 09:17:37 +0800
Message-ID: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

The patch series add the nbl driver, which will support nebula-matrix
18100 and 18110 series of network cards.
This submission is the first phase. which only supports the PF-based 
Ethernet transmit and receive functionality. Once this is merged.
will submit addition patches to implement support for other
features. such as ethtool support, flow management, adminq msg, vf
support, debugfs support and etc.

chanages v2 →v3
Link to v2: https://lore.kernel.org/netdev/20260109100146.63569-1-illusion.wang@nebula-matrix.com/
1.cut down to a mini driver:
    delete vf support
    use promisc mode to cut down flow management
    drop patch15 in v2
    delete adminq msg
    delete abnormal handling
    delete some unimportant interfaces
2.modify issues found by ai review
Changes v1->v2
Link to v1: https://lore.kernel.org/netdev/20251223035113.31122-1-illusion.wang@nebula-matrix.com/
1.Format Issues and Compilation Issues
- Paolo Abeni
2.add sysfs patch and drop coexisting patch
- Andrew Lunn
3.delete some unimportant ndo operations
4.add machine generated headers patch
5.Modify the issues found in patch1-2 and apply the same fixes to other
patches
6.modify issues found by nipa

illusion.wang (15):
  net/nebula-matrix: add minimum nbl build framework
  net/nebula-matrix: add our driver architecture
  net/nebula-matrix: add machine-generated headers and chip definitions
  net/nebula-matrix: add channel layer implementation and the
    corresponding hw interfaces
  net/nebula-matrix: add resource layer common part implementation
  net/nebula-matrix: add intr resource implementation
  net/nebula-matrix: add queue resource implementation
  net/nebula-matrix: add vsi resource implementation
  net/nebula-matrix: add txrx resource interfaces and tx func
  net/nebula-matrix: add txrx interrupt handling logic
  net/nebula-matrix: add Dispatch layer implementation
  net/nebula-matrix: add common/ctrl dev init/reinit operation
  net/nebula-matrix: add net dev init/reinit operation
  net/nebula-matrix: add common dev start/stop operation
  net/nebula-matrix: add net dev start/stop operation

 .../ethernet/nebula-matrix/m18100.rst         |   47 +
 MAINTAINERS                                   |   10 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/nebula-matrix/Kconfig    |   37 +
 drivers/net/ethernet/nebula-matrix/Makefile   |    6 +
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   26 +
 .../nbl/nbl_channel/nbl_channel.c             | 1289 ++++++
 .../nbl/nbl_channel/nbl_channel.h             |  177 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  302 ++
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   29 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  130 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 1369 ++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  131 +
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 1977 +++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   76 +
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  | 1256 ++++++
 .../nebula-matrix/nbl/nbl_core/nbl_service.h  |  132 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw.h         |  172 +
 .../nbl_hw/nbl_hw_leonis/base/nbl_datapath.h  |   11 +
 .../nbl_hw_leonis/base/nbl_datapath_dped.h    | 2152 +++++++++
 .../nbl_hw_leonis/base/nbl_datapath_dstore.h  |  929 ++++
 .../nbl_hw_leonis/base/nbl_datapath_ucar.h    |  414 ++
 .../nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h   |   10 +
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h  |  665 +++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h  | 1397 ++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 1882 ++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  | 1142 +++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c | 3903 +++++++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h |   12 +
 .../nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c   | 1129 +++++
 .../nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h   |   15 +
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  582 +++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   25 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |  139 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  |  314 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |   13 +
 .../nebula-matrix/nbl/nbl_hw/nbl_queue.c      |   60 +
 .../nebula-matrix/nbl/nbl_hw/nbl_queue.h      |   11 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  299 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  439 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_txrx.c       | 1984 +++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_txrx.h       |  184 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.c        |  120 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.h        |   12 +
 .../nbl/nbl_include/nbl_def_channel.h         |  481 ++
 .../nbl/nbl_include/nbl_def_common.h          |  165 +
 .../nbl/nbl_include/nbl_def_dev.h             |   28 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |   92 +
 .../nbl/nbl_include/nbl_def_hw.h              |  105 +
 .../nbl/nbl_include/nbl_def_resource.h        |   93 +
 .../nbl/nbl_include/nbl_def_service.h         |   80 +
 .../nbl/nbl_include/nbl_include.h             |  326 ++
 .../nbl/nbl_include/nbl_product_base.h        |   20 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  352 ++
 55 files changed, 26753 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/nebula-matrix/m18100.rst
 create mode 100644 drivers/net/ethernet/nebula-matrix/Kconfig
 create mode 100644 drivers/net/ethernet/nebula-matrix/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dped.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dstore.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_ucar.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

-- 
2.47.3

