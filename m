Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459834F24E;
	Thu,  1 Oct 2026 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790817969; cv=none; b=AU7N0+nKTpWIWyf8IaaPHMUN2E1evmDISTbLOStXqGTmfjXiox7BsOvCTFsJX5G3oRHR6k85YCKJAYTyjOb4sCmsUdXL+wNngNNEQ6bA65ZFeLUlnJTc787IhWjbMm9jYRIAm8gjmWGTJ4xY0pAZMVbmQRdOb/Jua+uqZobBHZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790817969; c=relaxed/simple;
	bh=WEDGXkCGGeTtmmIndd7KMFiY/AOtuAwb7+AGRTiki30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6pOA/hJxNj0V78zsqGjJdxJhMQjzuW+FgVoEdjq2WeQJriI42bEyI6vQxk+DO2fZogcnLGh3Kl5Q+0fnq3QTnMYJlDCDGGN3PK5X7f2OI6vhsp4PO9bUuZ+HDk1guBtUJ6CVYqrCDv1msB+fEkM59Z3YUZfbhgiA1vkrQfIY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+2Dl0yw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+2Dl0yw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFDA1F000FF;
	Thu,  1 Oct 2026 01:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790817964;
	bh=twUEiJ/g4lCH2oTGsMXGzEknQ8y+KcaOrNrDuRnsPIg=;
	h=From:To:Cc:Subject:Date;
	b=R+2Dl0ywOSYdspW924BWc3j5sJih+z8B7UdUaB5jzWo+T8yZ1vRwPbxPPYnDVtcVQ
	 GEFzgsvcmoHqPxpUwPnjddywIL95aGJ5lq8X17i8j7Un800/4CmfQuxw+lVEEySAyD
	 sCoMe71D2VIwHOhPdP14F5+2FgLzkRQhdXo3R5c3hj77qfq8ffOEDd0dX8B6ZOGIYn
	 d1+dPI4W1j/AwBl1L28TfsEEadh7inq+RM/DDl8/oar57bqVDPpLaS+lZ8FLMnCRSQ
	 uCPVNklFcZ6YAVsLI5QnTX5LT7fbXYaWRQm/6JW+haZEjbq/BrHqdC0IKHpf5ZCtFR
	 elEzikM+Ly5IQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	ap420073@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH net] net: make dev_xdp_sb_prog_count() see programs attached through a link
Date: Wed, 30 Sep 2026 18:25:59 -0700
Message-ID: <20261001012559.297751-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethtool refuses to enable tcp-data-split on a device running
a single-buffer XDP program (which can't deal with the payload
landing in a separate buffer). dev_xdp_sb_prog_count() only looks
at xdp_state[].prog though, ignoring bpf_link integration.
Get the prog pointer from dev_xdp_prog(), which will consult both.

bpf_xdp_link_update() needs a bit of a touch-up, too, since
ethtool calls dev_xdp_sb_prog_count() with just the instance
lock (for ops-locked devices) - we now have to make sure the
link updates happen under that lock.

Spotted by AI while reviewing the XDP propagation series,
verified and tested on netdevsim with a C test along these lines:

  link = bpf_program__attach_xdp(prog, ifindex);
  system("ethtool -G eth0 tcp-data-split on")

Fixes: 197258f0ef68 ("net: ethtool: add hds_config member in ethtool_netdev_state")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: daniel@iogearbox.net
CC: hawk@kernel.org
CC: john.fastabend@gmail.com
CC: sdf@fomichev.me
CC: ap420073@gmail.com
CC: bpf@vger.kernel.org
---
 net/core/dev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 79be99b52f20..030c444aee45 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10367,13 +10367,15 @@ EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
 
 u8 dev_xdp_sb_prog_count(struct net_device *dev)
 {
+	struct bpf_prog *prog;
 	u8 count = 0;
 	int i;
 
-	for (i = 0; i < __MAX_XDP_MODE; i++)
-		if (dev->xdp_state[i].prog &&
-		    !dev->xdp_state[i].prog->aux->xdp_has_frags)
+	for (i = 0; i < __MAX_XDP_MODE; i++) {
+		prog = dev_xdp_prog(dev, i);
+		if (prog && !prog->aux->xdp_has_frags)
 			count++;
+	}
 	return count;
 }
 
@@ -10753,11 +10755,12 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 	bpf_op = dev_xdp_bpf_op(xdp_link->dev, mode);
 	err = dev_xdp_install(xdp_link->dev, mode, bpf_op, NULL,
 			      xdp_link->flags, new_prog);
+	if (!err)
+		old_prog = xchg(&link->prog, new_prog);
 	netdev_unlock_ops(xdp_link->dev);
 	if (err)
 		goto out_unlock;
 
-	old_prog = xchg(&link->prog, new_prog);
 	bpf_prog_put(old_prog);
 
 out_unlock:
-- 
2.55.0

