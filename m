Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1A0311946;
	Fri,  4 Sep 2026 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527286; cv=none; b=QRkw4zZbgIV1/22cEXcV9d8on1DU1MYzUb73EDDN4FkrXEBZ0boLvo00P7dz4fIhyA785pSra/UVYGhUkl1zhSf9FHmGQrkHh5UyX5ByrQxUaIjodY5no/8BJFEqfiTF7GT2hcc0uEnbSatgouTV3o9n9P2U3/ApM2sd6GgSVEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527286; c=relaxed/simple;
	bh=0n+Qd2pw61JB2O3Z+5PQDlNMwMrmFpN2nG4Z6Yttf5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AGiASwvKSpaBe2xmbsy1gYmAH26S8o8/wlNwm0piBxtPUoCh6ME1JfEC6tcd64lsgc9sgPAyIakVjj0HebwKI5BtQuDLrTmqDA8U6jl5R5kSeQtbO9rWLgzi5yAK78+5AFSVtNYOAHF13iX1jCl+zhYjDvboaigweRZRxoAxMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=pGrOkn+o; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=pGrOkn+o; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="pGrOkn+o";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="pGrOkn+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527276; bh=0n+Qd2pw61JB2O3Z+5PQDlNMwMrmFpN2nG4Z6Yttf5E=;
	h=From:To:Cc:Subject:Date:From;
	b=pGrOkn+ougvPuwGnWeiS6+nU0V3MFKHZfxdpxojdGZsBuppOh8Muaxnd6Dt5tRCz+
	 if/ByE07kmj8iuIxWF4p/zjFYGwuXUkNE3brGJXOIAeKgvIuidPWsnhuzYXUeYiTg8
	 dV1q5cg4m6yl6YLFXRoByYMLDqR+sLaCYfTpjl36oyEBTIgcFxiB7sfYFJG0R2edea
	 pWQBfoK4FTdJX6Jdmj/9msGbE6lJpAhyNl3x0Y3q4ljEQA+yQmAAgsoJKkbGjm5500
	 /NyYw6L9g+o+1U1xlR3eZ5tgFVuFvHL5qh9cHtkxf9tFms/mskLxg2cCYHQZk24/u3
	 18hPkq91zV6Bg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id DD9BD41446; Fri, 04 Sep 2026 14:07:56 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527276; bh=0n+Qd2pw61JB2O3Z+5PQDlNMwMrmFpN2nG4Z6Yttf5E=;
	h=From:To:Cc:Subject:Date:From;
	b=pGrOkn+ougvPuwGnWeiS6+nU0V3MFKHZfxdpxojdGZsBuppOh8Muaxnd6Dt5tRCz+
	 if/ByE07kmj8iuIxWF4p/zjFYGwuXUkNE3brGJXOIAeKgvIuidPWsnhuzYXUeYiTg8
	 dV1q5cg4m6yl6YLFXRoByYMLDqR+sLaCYfTpjl36oyEBTIgcFxiB7sfYFJG0R2edea
	 pWQBfoK4FTdJX6Jdmj/9msGbE6lJpAhyNl3x0Y3q4ljEQA+yQmAAgsoJKkbGjm5500
	 /NyYw6L9g+o+1U1xlR3eZ5tgFVuFvHL5qh9cHtkxf9tFms/mskLxg2cCYHQZk24/u3
	 18hPkq91zV6Bg==
Received: from maru.mess.org (hephaestus.mess.org [82.68.61.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 0F7D74018A;
	Fri, 04 Sep 2026 14:07:56 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org
Cc: Rik van Riel <riel@surriel.com>,
	Sean Young <sean@mess.org>,
	bpf@vger.kernel.org
Subject: [PATCH v3 00/17] media: Fix locking issues in rc core
Date: Fri,  4 Sep 2026 14:07:28 +0100
Message-ID: <cover.1788526920.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues found by Sashiko and claude, and other cleanups. 

Resending because Sashiko failed to check v2 and fix more issues.

Changes since v2:
 - Cosmetic changes in:  Add missing locking for keymap
 - Patch 7 to 17 are new issues found

Changes since v1:
 - Fix issue where input device was still leaked
 - Add: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
 - Add: Fix inconsistent locking of keylock
 
Sean Young (17):
  media: rc: Ensure registered is cleared in error path
  media: rc: Ensure that rc_unregister_device() does not free input
    device
  media: rc: Fix ABBA deadlock by making locks more fine grained
  media: rc: Add missing locking for keymap
  media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
  media: rc: mce_kbd: Fix inconsistent locking of keylock
  media: ene_ir: Ensure teardown is done in the correct order
  media: rc: Use binary search for adding or updating a scancode
  media: rc: imon: Bind both interfaces via usb_driver_claim_interface()
  media: ir_toy: Remove unused struct field
  media: nuvoton-cir: Remove unused struct field
  media: ite-cir: Removed unused struct field
  media: fintek-cir: Remove unused fields
  media: mceusb: Remove unused field
  media: serial_ir: Fix race condition where timer can be re-armed
  media: rc: After rc_unregister_device() timers can be re-armed
  media: rc: Validate carrier range in LIRC_SET_REC_CARRIER ioctl

 drivers/media/rc/ene_ir.c             |   4 +-
 drivers/media/rc/fintek-cir.c         |  13 --
 drivers/media/rc/fintek-cir.h         |  22 ----
 drivers/media/rc/imon.c               | 166 +++++++++++--------------
 drivers/media/rc/ir-mce_kbd-decoder.c |   5 +-
 drivers/media/rc/ir_toy.c             |   2 -
 drivers/media/rc/ite-cir.c            |   1 -
 drivers/media/rc/ite-cir.h            |   1 -
 drivers/media/rc/lirc_dev.c           |   2 +
 drivers/media/rc/mceusb.c             |   1 -
 drivers/media/rc/nuvoton-cir.h        |   3 -
 drivers/media/rc/rc-ir-raw.c          |  39 +++---
 drivers/media/rc/rc-loopback.c        |   5 -
 drivers/media/rc/rc-main.c            | 172 ++++++++++++++++----------
 drivers/media/rc/serial_ir.c          |  11 +-
 include/media/rc-map.h                |   2 -
 16 files changed, 219 insertions(+), 230 deletions(-)

-- 
2.55.0

