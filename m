Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9E36B937;
	Tue, 15 Sep 2026 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461185; cv=none; b=HrkXOqoKug1CWzD3KSycWAhVaHtu8cR7rB8c3fqFzIuxQKovN+3/PRjVtT+9fxP4sTmEjfJauNkwt9LwSijnjAR9NffyDesAKc8SC8X885NpjpnGNLTTF2KGXSzWZiTidHRxAg0VxKDTNvcRmxhRz3EvuG/Ns2jL2upZzhVaq5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461185; c=relaxed/simple;
	bh=VtAhDb6NREb44ppj0Ga81SnhKAdH0IigntJyB/N3QVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A21GWyU8aitwVKXk0qYZFi0o3z/gTwrY3MyHmMf9RjbiT7fztW7bDnXGr95u8MaOiOUYTza4ZncXNhJrLAAJQSpzGwXmNx2FbuemND90AxJnidiCtHr38r80wHR+nOXLWx8aDPUNKZiUzvfGEUbPIM0smgJnPuRWfwneOvJ0rEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=ofNRTHw9; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=FZ+CD7nF; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="ofNRTHw9";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="FZ+CD7nF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461175; bh=VtAhDb6NREb44ppj0Ga81SnhKAdH0IigntJyB/N3QVs=;
	h=From:To:Cc:Subject:Date:From;
	b=ofNRTHw9ybD0+AwUWzUAz+jcwPWu1H24csCCQnZPifEsvVLcotT7orYVyHrJOj5zp
	 wc/85y3cdgr0KJsP9ciYfwkbBaHenXssf92MJTY5jf7fT3GtBH1Ds5wgii3K/zIWWL
	 Y16KENR89rRprsr8hLsZdN+pYqbaRXQYGD9ukJAxjLKUw0IAVebfKUDuvhKNB4nO//
	 x+I8kw7JO22QWn+HvPG3YJiAbndWdgb7PKopT9BefiXCplaw0ud3/YFqrMXGi3CmKK
	 p+oK0jZAGsqPbaMmwlspunJROYKmKHwVSSfOcVOFfyhxW6y8M+e18jGD9htEFq/o4u
	 Xg6UxUeB++CgQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 051DC40B86; Tue, 15 Sep 2026 09:32:55 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461174; bh=VtAhDb6NREb44ppj0Ga81SnhKAdH0IigntJyB/N3QVs=;
	h=From:To:Cc:Subject:Date:From;
	b=FZ+CD7nFzCgzRD0L/5Zq37JiuzDofJJd7+UkXOJS55gyy7HCT6KgEvdn+Qm+YDSz8
	 S3BJjdWVSrAZFL298MItGVSGc4brYha8fXLspnYqhAqNKvuaipLfUazyWqMv54mr1u
	 XA9jbhFKMgp/FR611Pe9n9G8T1YoL9bzJPnuL/KgEjlQcBXj51EIgEe5YrfjZxc8Zc
	 ZtRQ4AgXjeCwMy1tLcIvq3Lq1MVUtLsPVgeIQs7oS3iy+xFamBLcZ90+cAVkShz1Fi
	 LGtsd5MsCdZGdKo3fzJw0K21a3bnlSKfOvJb53fEIQRjZPLhQ2rPg3jsV+0TyuXvCu
	 an3nXBidUimWg==
Received: from maru.home (host81-158-254-226.range81-158.btcentralplus.com [81.158.254.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 11E9A40155;
	Tue, 15 Sep 2026 09:32:54 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org
Cc: Rik van Riel <riel@surriel.com>,
	Sean Young <sean@mess.org>,
	bpf@vger.kernel.org
Subject: [PATCH v5 00/20] media: Fix locking issues in rc core
Date: Tue, 15 Sep 2026 09:32:10 +0100
Message-ID: <cover.1789460680.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues found by Sashiko and claude, and other cleanups.

Changes since v4:
 - Split keymap locking into two commits: one for krealloc rewrite
   and one for the locking
 - Fixed meson-ir-tx: Validate carrier and duty_cycle to actually
   fix divide by zero
 - Improved commit messages
 - imon calls usb_driver_claim_interface() before using it
 - Ensure lirc_unregister() is always called with registered = false
   else any polling fds never get triggered

Changes since v3:
 - serial_ir: Fix race condition where timer can be re-armed
   This introduced a new race condition; reworked
 - rc: After rc_unregister_device() timers can be re-armed
   Sashiko suggested a simpler implementation with
   timer_shutdown_sync()
 - Add meson-ir-tx: Validate carrier and duty_cycle
 - Add ir_toy: Validate the maximum tx carrier

Changes since v2:
 - Cosmetic changes in:  Add missing locking for keymap
 - Patch 7 to 17 are new issues found

Changes since v1:
 - Fix issue where input device was still leaked
 - Add: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
 - Add: Fix inconsistent locking of keylock

Sean Young (20):
  media: rc: Ensure registered is cleared in error path
  media: rc: Ensure that rc_unregister_device() does not free input
    device
  media: rc: Fix ABBA deadlock by making locks more fine grained
  media: rc: Replace open coded krealloc() for keymap
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
  media: ir_toy: Validate the maximum tx carrier
  media: meson-ir-tx: Prevent divide by zero in
    meson_irtx_prepare_pulse()

 drivers/media/rc/ene_ir.c             |   4 +-
 drivers/media/rc/fintek-cir.c         |  13 --
 drivers/media/rc/fintek-cir.h         |  22 ---
 drivers/media/rc/imon.c               | 164 ++++++++++-------------
 drivers/media/rc/ir-mce_kbd-decoder.c |   5 +-
 drivers/media/rc/ir_toy.c             |   4 +-
 drivers/media/rc/ite-cir.c            |   1 -
 drivers/media/rc/ite-cir.h            |   1 -
 drivers/media/rc/lirc_dev.c           |   2 +
 drivers/media/rc/mceusb.c             |   1 -
 drivers/media/rc/meson-ir-tx.c        |   3 +
 drivers/media/rc/nuvoton-cir.h        |   3 -
 drivers/media/rc/rc-ir-raw.c          |  39 +++---
 drivers/media/rc/rc-loopback.c        |   5 -
 drivers/media/rc/rc-main.c            | 186 ++++++++++++++++----------
 drivers/media/rc/serial_ir.c          |   2 +-
 include/media/rc-map.h                |   2 -
 17 files changed, 222 insertions(+), 235 deletions(-)

-- 
2.55.0

