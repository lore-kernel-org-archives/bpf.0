Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DAF3B19AF;
	Wed, 22 Jul 2026 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715819; cv=none; b=rBDFkhzl0QmzhM/EB49rhvs+1x6EdoJYstrrU8uiIEjhU0MKQauCemsmia9/xhO5V1yDAH8tpesbhPnfxDWv3Uwf9EthmlkgvAxMfqWxTQWUN+KPqBDYoQr4B10s2WP7ZEBmhwWQAW8faPnxx1dajz0R2sjrx2Vf4NlK+dsvCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715819; c=relaxed/simple;
	bh=ScN/GYWMG9bFf7QCQ4WW9FhbJFboxppSiGKKS+CNLnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzmflI4nsip5DXp4W/RAqOrAJsm71tBf5XUcX2L04uWJvbeUlTROKERKaUVoYBe13tnZOaJIc/VD0Q78Zco4uXrLq7Ai7CNcsFd1caFyWxExKq07Wi7NkEMUQ/cgAiY5OFiJPwSYenGp6lPctk5O4j9NAAV5vIX1rl+gbh/G5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Qmly8Lcn; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=mX1Ympy6; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Qmly8Lcn";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="mX1Ympy6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1784715816; bh=ScN/GYWMG9bFf7QCQ4WW9FhbJFboxppSiGKKS+CNLnk=;
	h=From:To:Cc:Subject:Date:From;
	b=Qmly8LcnNsVPKG/mz29thcJbZhSk+WHMQSCWBDuCN8HtRhltnNPMzX1BTGG+pykUJ
	 1/aSif7pDg1U5WBKDne1uGKDaSNwEFix4kr8QeeW7/R9PINa9NZTVez0KlFptP4gab
	 QCyQaY1972hCbyWz33ITT4h4zOLDSP6DXdamgNYoCXh5FuIXXiEzYbP0kmXnPz1XYu
	 DBOXA8LYJHMTvwJ4LaaJScjRS+T+5oXKNpLJFIArU/d9FemUTFmxMDQVZrmZvjvJrw
	 wcA1H5NLDY5u0H44qAsWk9jRzMkPcAnG2hW3WvGhQbdFFh7lcNgXtetpl5bX8leBbk
	 7EF5zM+ZXibAA==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 463BA4017A; Wed, 22 Jul 2026 11:23:36 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1784715815; bh=ScN/GYWMG9bFf7QCQ4WW9FhbJFboxppSiGKKS+CNLnk=;
	h=From:To:Cc:Subject:Date:From;
	b=mX1Ympy6E9LLp/Gj2oY9QzItI/7gErZocMvMY8xgjRF1WJREKYkliwiphN7N8R0Au
	 Hsl6YrLXz5+3/gztoFc6VknWfZAKxmb6fBigMs1Ax5M13c6g5xTY+iFJp3Z4RPqZ37
	 ifgg82MAYXfsgD7paaGBPeJOpkqXbJ9GK+S7pbpmXYPVomGJVc2jpVt3LENE1y+WgE
	 RA4LhhPY2ndI8dlAvbWqtnFG7N2MnbQNn6XFRly7gFssGqNvFmd6HqBr2XiP6l9vkl
	 hCFlhN5thJhArNVedIoQXEe6bKri96xFOSUH+j5u9nUgIjDX3tmYU3MKoGBadEfUMi
	 chu8259tIjZ8w==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 61A1A4017A;
	Wed, 22 Jul 2026 11:23:35 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	bpf@vger.kernel.org
Subject: [PATCH v3 00/13] Fix leaks in rc core 
Date: Wed, 22 Jul 2026 11:23:12 +0100
Message-ID: <cover.1784715737.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


Sean Young (13):
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
  media: rc: Fix race condition during rc_register_device()

 drivers/media/rc/bpf-lirc.c    | 18 ++++++++++-----
 drivers/media/rc/ir-hix5hd2.c  |  5 +++--
 drivers/media/rc/meson-ir-tx.c | 14 +++++-------
 drivers/media/rc/rc-ir-raw.c   | 40 ++++++++++------------------------
 drivers/media/rc/rc-main.c     | 18 +++++++++------
 drivers/media/rc/redrat3.c     | 35 ++++++++++++++++++++++++-----
 drivers/media/rc/streamzap.c   |  1 +
 drivers/media/rc/sunxi-cir.c   |  2 +-
 8 files changed, 75 insertions(+), 58 deletions(-)

-- 
2.55.0

