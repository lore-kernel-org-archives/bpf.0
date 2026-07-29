Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6F3B05BD;
	Wed, 29 Jul 2026 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338593; cv=none; b=KrjfVIIWfnhTtRUdhUD+WpDiDUaCPzovtp8cWFVtkJumaDBHqd2qpKir++jZqyAWJ3tWYltkB2UBIcbdIfeR4LdnrSu3BpCd/f/EfA8w5C50UFYHn5i+yFC5K4F29bCFIIjtStEcKr0k7YTH+AqvAgteFn6UVGrTDqDLA6Meplk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338593; c=relaxed/simple;
	bh=k/6SmGSg5ON0gie0WtFUaI4E74ijFvWO6hxtuheYxyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3ST5I91GeexIIYVIrxPJw1PPTjew5iXasw73H0QnsYNzdVwJups3He6+W/YA+KihuwIoDYXMnqjz6EIpUMfBqegMDInrFmN6oMEjSxvA02NRHTgNYqrYCjJjck1RewyjR0iEwSqZK5srTwpKGLqwzpkaemw9pjId5U1oib6PlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=bxIxFITP; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=bxIxFITP; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="bxIxFITP";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="bxIxFITP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338589; bh=k/6SmGSg5ON0gie0WtFUaI4E74ijFvWO6hxtuheYxyw=;
	h=From:To:Cc:Subject:Date:From;
	b=bxIxFITPIY7XnW/gby4nDSbC+QD5rPDZU8pnU6f6uO5IkIiZGpSTwQ+Z4KSvaByK3
	 66fLul/+ZR3krHXrOknHijna2qRV1Ez6f09Ps8lI1l5RV9mg1iwadzKb1JTKjv+evw
	 Ud2jFtvrghWaOxra8upzyYy4dWRrHbKAtyd/PgVhWBnzW+Q7ilHGeVxb6UsIjuBz1/
	 OFiFI3UNisu8til2ysq89R07q9m3l27xIx31ToNRnkMbYSYtIiChdG259v5KeqgkVn
	 cgFwgVzPpbpFPtplVmoHA00O/UTIMse5ra23hXAC+BxeP783xqKmIiD/sIehH2+4lh
	 rBHNKqcEP8Pwg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id ED6B542526; Wed, 29 Jul 2026 16:23:09 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338589; bh=k/6SmGSg5ON0gie0WtFUaI4E74ijFvWO6hxtuheYxyw=;
	h=From:To:Cc:Subject:Date:From;
	b=bxIxFITPIY7XnW/gby4nDSbC+QD5rPDZU8pnU6f6uO5IkIiZGpSTwQ+Z4KSvaByK3
	 66fLul/+ZR3krHXrOknHijna2qRV1Ez6f09Ps8lI1l5RV9mg1iwadzKb1JTKjv+evw
	 Ud2jFtvrghWaOxra8upzyYy4dWRrHbKAtyd/PgVhWBnzW+Q7ilHGeVxb6UsIjuBz1/
	 OFiFI3UNisu8til2ysq89R07q9m3l27xIx31ToNRnkMbYSYtIiChdG259v5KeqgkVn
	 cgFwgVzPpbpFPtplVmoHA00O/UTIMse5ra23hXAC+BxeP783xqKmIiD/sIehH2+4lh
	 rBHNKqcEP8Pwg==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id E91884017A;
	Wed, 29 Jul 2026 16:23:08 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	bpf@vger.kernel.org
Subject: [PATCH v5 00/15] Fix leaks in rc core
Date: Wed, 29 Jul 2026 16:22:38 +0100
Message-ID: <cover.1785338381.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v4:
 - media: redrat3: Error path leaves device in transmitting state 
   - this now removes the check for transmitting boolean in transmit as it
     is now redundant.
   - Reworded commit message
 - media: rc: Use after free in ir_raw_event_handle()
 - media: rc: Fix race condition during rc_register_device()
   - Reworded commit message
 - commits affecting particular modules are sorted together

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
  media: cx88: Specify rc type at rc_allocate_type()
  media: saa7134: Specify rc type at rc_allocate_type()
  media: rc: Fix race condition during rc_register_device()
  media: rc: Use after free in ir_raw_event_handle()
  media: rc: Fix use after free in bpf progs

 drivers/media/pci/cx88/cx88-input.c       | 22 ++++++-----
 drivers/media/pci/saa7134/saa7134-input.c |  7 ++--
 drivers/media/rc/bpf-lirc.c               | 18 ++++++---
 drivers/media/rc/ir-hix5hd2.c             |  5 ++-
 drivers/media/rc/meson-ir-tx.c            | 14 +++----
 drivers/media/rc/rc-ir-raw.c              | 47 +++++++++--------------
 drivers/media/rc/rc-main.c                | 19 +++++----
 drivers/media/rc/redrat3.c                | 40 +++++++++++++------
 drivers/media/rc/streamzap.c              |  1 +
 drivers/media/rc/sunxi-cir.c              |  2 +-
 10 files changed, 97 insertions(+), 78 deletions(-)

-- 
2.55.0

