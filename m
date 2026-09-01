Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C238655B;
	Tue,  1 Sep 2026 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272728; cv=none; b=Vov2jn0fAH90VaGXilNEUNuenDioBvr3AmxIC/HT7Lyd1mcIHjG0AVIMm3pV5VYLyk/fi3ply2aK2xD9UvjYLOhOUzk0ME2nzitvwzFsRKmqLAwSuRJBXx80vN+cU+fS8DCTA2uvRQ9qdNCpsQe2bkB7rCMcJLOZTVHHm716M8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272728; c=relaxed/simple;
	bh=XK6sSKEwsTfLilCrYZAiLuaxfigeiZA5W9QZx8lWtWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+wg/dd3D/uwEkw8H9RYk9ZFEB+ycvXuhwnxlVF7DzoYp8MfDNCMTMTgPNkYujAD9jqRk0TSl0KOSSxBBIMClVLXNMXnGgeJioPbkplbIlMsG8OzZFGuTPiA0PNmTYRD3kJqT+9JcjAdaff2nAHciBF9AmpPptSQoQI3a8Atuos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=ojSlXgaZ; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=ghbQgCp9; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="ojSlXgaZ";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="ghbQgCp9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788272725; bh=XK6sSKEwsTfLilCrYZAiLuaxfigeiZA5W9QZx8lWtWY=;
	h=From:To:Cc:Subject:Date:From;
	b=ojSlXgaZt0n3+XN+XHjz7OSm+7kkVucR2uUesmCqR4WPnpl2UbiYuveY1UN/ilUT3
	 rI+CUOwx/PZpzUW88WskQ/iQo0odX4jzydchQH6e99iNwJnFlgfBF71zV2CzZmAePS
	 t4tk34jFtKtX5veFTcEjL2vCZtPFKF7G9vgrnuAu6JLHlFbmxzAg00mUtifIKQoP4Y
	 9UkRKY3k4pPNDT/7LyKcko40Ky9Yzw81B8Jk6OzC1yVzVnvwbikWQOGkbFpobggysV
	 UKC6bRi9BWM+MU0a+IUlT5vMGUohipwA0WuJlfkHaOLFHmr91yEIxI+iy4Mq+/RAYQ
	 lxDm6D92+UF0w==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 1870A41446; Tue, 01 Sep 2026 15:25:25 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788272724; bh=XK6sSKEwsTfLilCrYZAiLuaxfigeiZA5W9QZx8lWtWY=;
	h=From:To:Cc:Subject:Date:From;
	b=ghbQgCp90GtIotppm3iilSQcXWdgiYQnKQAs6HnX9VDXiDhlBEkaNcTrDWQRMpEv4
	 yuQVrd+g+7S0TOVDWwNhIMy9UChrTxktKg8/uVVUb6Pe9HMvLX8pN2fJ2C28RwRJDT
	 1PJ6L+GSoTznbjSUp//5JnGbGC94hsxcc6FCu9OajmITBKmGN9kimVY8puAp/zxKTs
	 L0n7yf+ZZ2rtbDlkfEsdkoBiCKfEvJ7TlV57pp+4ESH2qLKYY4XX5VOUH2gPdkMJAq
	 kmn3KQEjrku5coXM+5hu7MeBAChQjmZhRoHqrrxFJHG4HrvHbh0sfIu3JuoJtf1jSF
	 qyVJQ13KRpHVg==
Received: from maru.home (host86-128-233-22.range86-128.btcentralplus.com [86.128.233.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 8ABED4017A;
	Tue, 01 Sep 2026 15:25:24 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org
Cc: Rik van Riel <riel@surriel.com>,
	Sean Young <sean@mess.org>,
	bpf@vger.kernel.org
Subject: [PATCH v2 0/6] Fix locking issues in rc core 
Date: Tue,  1 Sep 2026 15:24:50 +0100
Message-ID: <cover.1788272198.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
 - Fix issue where input device was still leaked
 - Add: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
 - Add: Fix inconsistent locking of keylock

Sean Young (6):
  media: rc: Ensure registered is cleared in error path
  media: rc: Ensure that rc_unregister_device() does not free input
    device
  media: rc: Fix ABBA deadlock by making locks more fine grained
  media: rc: Add missing locking for keymap
  media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
  media: rc: mce_kbd: Fix inconsistent locking of keylock

 drivers/media/rc/ir-mce_kbd-decoder.c |   5 +-
 drivers/media/rc/rc-ir-raw.c          |  39 ++++---
 drivers/media/rc/rc-main.c            | 147 +++++++++++++++-----------
 include/media/rc-map.h                |   2 -
 4 files changed, 115 insertions(+), 78 deletions(-)

-- 
2.55.0

