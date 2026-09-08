Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393156260E;
	Tue,  8 Sep 2026 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882856; cv=none; b=kW6Y38ZWyzr5T89jnWH8ZoaJBzyJYcysiHBo1ecjBqtXqDEPTI1M52eXeOdQew+C15c38A9YxUZX9S2M+m9dOR8TIuHqBDJuzwu0JoyXTWU4U4SIPcN4fKJXY00wwA0Gml/0dAAcy5jArSPKI/eBjGD6TaOSp2Zl+a+4y1uBExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882856; c=relaxed/simple;
	bh=03q6FZQlIyLzpD7o+e9mgehH6a7CrXSppjnQrHjnWds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYhhvsFC6nB/jwGq9vQO/OoUrpyYsPOIPkEdYj3nSPS1j+EKILXLBo6+tjxXCBueps5U08RTmdVYbxvwCf2NA9XZOKeikD18LsdwuyyNMLZuSrMk8wXsrOMCjZGhWwXT7r+sFTJvrcz/gmkKtWSScAap5mvstMC+M2XQhfMQQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=qLBzoKrB; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=KMiwVTKJ; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="qLBzoKrB";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="KMiwVTKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882846; bh=03q6FZQlIyLzpD7o+e9mgehH6a7CrXSppjnQrHjnWds=;
	h=From:To:Cc:Subject:Date:From;
	b=qLBzoKrBYbJnnDNycp5TxfOFCWGfQEX5uf2laMJuaNOPmytvNsgZYbJmUdPt7as/2
	 fbMem5q8Xg0znMNEgeXowvBEw9OaBtODOz1BAOcQEN+tMacbifsTzS4LPt8/6w1KPc
	 KP9pGbElkCKO4XWLndFXmXKR02olBjzVuj7OM7vZgELkYUur2Sfl/GFuT80B03JcBv
	 2MsZs86p8lSzaPrsu4jTZn8JJRCPVkWkbkDufyxsd268koyWFTsHbj2dcaRh+ytH52
	 QwYLXy2eEi3osXdrYhzCpuczNXBYbBpgkydQvcz/qZP5/vPIn5bp/ZL+OLCiatxvbp
	 8UYFWhbSn+tdQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 44F9541445; Tue, 08 Sep 2026 16:54:06 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882845; bh=03q6FZQlIyLzpD7o+e9mgehH6a7CrXSppjnQrHjnWds=;
	h=From:To:Cc:Subject:Date:From;
	b=KMiwVTKJnrwX/yqpusZbpe727N61NOWJcbAkNU4QpMH+fkQ+qsDuXbrvRBaiGCJ+R
	 DBBHs2Dpp8EZt5jcVlGyjgfkN9VYCVzZ+5Ou8OUO46qq3KbiDfb/lL6wYKewPH/IqY
	 XOY1r6WwnEnivgnEHQPv5jSQVTRXlNtvE/gFENfZ+JFFqrpGSZjENdRK3oRlYhCRdZ
	 9xlFPFss9CKF4DKHJ4or1VUjAoVHHA96UyBaYyraWp4lLezqjoNBNT19XKi/5cp/M5
	 Q4oSFLzDvOWLlzVOVfgMBdP05XwHNBd4dNOyBodXRalrHLJomtNfBUzIAUbaS0zT0s
	 Q3c8Ham0vZzZg==
Received: from maru.home (host86-150-50-53.range86-150.btcentralplus.com [86.150.50.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 64D234018A;
	Tue, 08 Sep 2026 16:54:05 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org
Cc: Rik van Riel <riel@surriel.com>,
	Sean Young <sean@mess.org>,
	bpf@vger.kernel.org
Subject: [PATCH v4 00/19] media: Fix locking issues in rc core
Date: Tue,  8 Sep 2026 16:51:48 +0100
Message-ID: <cover.1788882189.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues found by Sashiko and claude, and other cleanups.

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


Sean Young (19):
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
  media: ir_toy: Validate the maximum tx carrier
  media: meson-ir-tx: Validate carrier and duty_cycle

 drivers/media/rc/ene_ir.c             |   4 +-
 drivers/media/rc/fintek-cir.c         |  13 --
 drivers/media/rc/fintek-cir.h         |  22 ----
 drivers/media/rc/imon.c               | 166 +++++++++++--------------
 drivers/media/rc/ir-mce_kbd-decoder.c |   5 +-
 drivers/media/rc/ir_toy.c             |   4 +-
 drivers/media/rc/ite-cir.c            |   1 -
 drivers/media/rc/ite-cir.h            |   1 -
 drivers/media/rc/lirc_dev.c           |   2 +
 drivers/media/rc/mceusb.c             |   1 -
 drivers/media/rc/meson-ir-tx.c        |  54 ++++++--
 drivers/media/rc/nuvoton-cir.h        |   3 -
 drivers/media/rc/rc-ir-raw.c          |  39 +++---
 drivers/media/rc/rc-loopback.c        |   5 -
 drivers/media/rc/rc-main.c            | 169 ++++++++++++++++----------
 drivers/media/rc/serial_ir.c          |   2 +-
 include/media/rc-map.h                |   2 -
 17 files changed, 251 insertions(+), 242 deletions(-)

-- 
2.55.0

