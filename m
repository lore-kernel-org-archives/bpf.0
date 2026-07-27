Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C25B400964;
	Mon, 27 Jul 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158361; cv=none; b=kE+g+RF99x4e7udQY8fKYRwREF40CTyy09gQXjmdqauFyelPcxX1QKHunhRh39cOL1uh57iP5MjNHsAgqKowiZ+cbe56CIZcL7EobDE+bU4aJcbQB/J40dU7pn9LkGQpByTJKDiFYCoUsrYkpbXeqF8FZg3vdxhnAoGFU5VFDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158361; c=relaxed/simple;
	bh=K2l+eENo+cky8q2QxxBBAwPhS5VVJ5YZNR6NYWB63z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKxR049hrEr7W8ZlvyQFxlNAya1ML0dLGrJka+PYAvk64XhqP8mGPqOMq+Zh/FfqFgbngvFDgoKjSCeaI9R4q2gN9LltQfyyvwh85OYikE+8HtZIG5ULX3tqCR6m/1a0fnhaU0NbWTAdZ9mPj87/eKYoNpfzpphjMB0qkfJhsUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=HXBGuYjI; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=iHKmlOo4; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="HXBGuYjI";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="iHKmlOo4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158351; bh=K2l+eENo+cky8q2QxxBBAwPhS5VVJ5YZNR6NYWB63z4=;
	h=From:To:Cc:Subject:Date:From;
	b=HXBGuYjIRRWRtvwTGIElv/CQem3zmz+Idn/TlAAfF2kYf45sL+MoI/e28oMK3XpXj
	 +q2ha2XgpkO2cYJqG6/DdJJ2FRb8CirCfGE/yg/rUDRFclV9NlEt6qEJNV53ZpoyaD
	 zjyvkIaJJAfaj+WXuLWmdhnlJYzwsRDWSWz3+88I4s3e1x5Yqup4/MO2UxTA1X77ZK
	 X6RWX/qZfLM3spsV5sA96y2AAmVXpCcEBPy58U/9jBSfqecpICg3j8TzprprSWnf2K
	 vOz/9pszXY3IXYYQrV9L88szD5+qL05B4OR5NkFokbG5kDqfsYObqCvesPUGTVWnEZ
	 0OwDSekkuz6jg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id BCE3B42526; Mon, 27 Jul 2026 14:19:11 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158350; bh=K2l+eENo+cky8q2QxxBBAwPhS5VVJ5YZNR6NYWB63z4=;
	h=From:To:Cc:Subject:Date:From;
	b=iHKmlOo49WiXb3Kx5maS4vLJf7a77xQ9VLbVTusXs5/Z3Yvd3Ry+aro5Nv9gUmY7N
	 mDNaNX1SCPF2vjE6as+jVe8ACaMQ0BX2mMgSBJhUbv+4dkeoi7AgX45E6Dq0FtLcae
	 ZK/FOJaupWBRMcla2oku6YQqNvM80QeTmttYkq9m7Tft3s5O4JrwzSnH1p+RoZokqT
	 /1jcLTFGTBJToBRfe68fv5kJpngNGUS4q5yAUVzu+pnKNEnluSC2MWEErcqG11UYc5
	 JTV2wFYBNxZyTq+xIEfKvco3+/kem2zQTGTCnPCS+arn1W0mFECY/cGO+9uU3BSZfC
	 pzbOopahel5QQ==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id B3FB34017A;
	Mon, 27 Jul 2026 14:19:10 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	bpf@vger.kernel.org
Subject: [PATCH v4 00/15] Fix leaks in rc core
Date: Mon, 27 Jul 2026 14:18:43 +0100
Message-ID: <cover.1785158244.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:
 - sashiko had many more good review comments

Changes since v2:
 - sashiko had many more good review comments

Changes since v1:
 - sashiko had many good review comments
 - Added fix rc: Use after free in ir_raw_event_handle()
 - Added fix meson-ir-tx: Ensure probe error is propagated
 - Added fix redrat3: Ensure all urbs are suspended
 - Added fix media: redrat3: Error path leaves device in transmitting state
 - streamzap fix was incorrect
 - Other minor fixes

Sean Young (15):
  media: streamzap: Add missing rc_unregister_device()
  media: redrat3: Ensure rc device is freed if enable_detector() fails
  media: redrat3: Ensure we don't read beyond the end of the packet
  media: redrat3: Ensure all urbs are suspended
  media: redrat3: Error path leaves device in transmitting state
  media: sunxi-cir: Ensure no more interrupts can occur before free
  media: meson-ir-tx: Ensure clock is disabled on unbind
  media: meson-ir-tx: Ensure rc_free_device() is called on unbind
  media: meson-ir-tx: Ensure probe error is propagated
  media: ir-hix5hd2: Ensure rdev is setup before interrupts are enabled
  media: rc: Use after free in ir_raw_event_handle()
  media: rc: Fix use after free in bpf progs
  media: cx88: Specify rc type at rc_allocate_type()
  media: saa7134: Specify rc type at rc_allocate_type()
  media: rc: Fix race condition during rc_register_device()

 drivers/media/pci/cx88/cx88-input.c       | 22 ++++++------
 drivers/media/pci/saa7134/saa7134-input.c |  8 ++---
 drivers/media/rc/bpf-lirc.c               | 18 +++++++---
 drivers/media/rc/ir-hix5hd2.c             |  5 +--
 drivers/media/rc/meson-ir-tx.c            | 14 ++++----
 drivers/media/rc/rc-ir-raw.c              | 41 +++++++----------------
 drivers/media/rc/rc-main.c                | 19 ++++++-----
 drivers/media/rc/redrat3.c                | 35 +++++++++++++++----
 drivers/media/rc/streamzap.c              |  1 +
 drivers/media/rc/sunxi-cir.c              |  2 +-
 10 files changed, 90 insertions(+), 75 deletions(-)

-- 
2.55.0

