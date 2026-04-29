Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8BA3DB63F;
	Wed, 29 Apr 2026 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501803; cv=none; b=F7Zzsy2ZW5Ngl4AiU+zT9SXI5eTbbREj8+wLdDkiF1dvtdTC4kQn3vw/FeAHWfMr/djvYVZghMHQf/+sbk3RC+8XOA6Qz8kPf8Ntn6rnDPMsIMwW9tu6AVccbR2+cd7mpgFRHm6zHREAAi/qFMYNZxeXLdfz0x82FyOKmUiw5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501803; c=relaxed/simple;
	bh=o1fefdr5F7Pqw4hBOXEbJ4RfB8jK8KQxC0uc5FpgzbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=en7ioQlNX7GQfwW2Hm4oLwmIvaduYpHaCljI7M06jUcrrDqrRxYYWvv619JcTiu43bXrqMX+RD67bPNkRPxjgqaDAqjCYreNsfnxLSDoGMSGrsgcy0YanO58gVNU4+X1aRZCDOY4NoXoPVDsAiz1f62SGsn2ro1LsKJDbLZw6sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVzoHCP2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVzoHCP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A737BC2BCC6;
	Wed, 29 Apr 2026 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777501803;
	bh=o1fefdr5F7Pqw4hBOXEbJ4RfB8jK8KQxC0uc5FpgzbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVzoHCP29bwUXMc4MBEAfE8efdcVvb9bZKN4yOHvQ5QP2/o4v5eFXIhURHYHORZDr
	 2TM1mG6N2tD9Fcho0b3Dtitc0DUzrCQ4Y0sd4AB8im/YvWyWSb1Id2ThNjdVKn4HMH
	 /XmKROnGjUWlzl1Xag/IieHuSsko41rwb/o370/Z6AuH1PvUwImtKvL9Mpxm/Lek9Q
	 OURX2opyFtAfvKQ60nBz4lfRqaX8sqmnCZO8LpJ2kpKv4s83JYvHK0f7ulT4WbLunc
	 pTKE2vx0YkVIds8297mtmeLMgPKwQRokaNZ81lcJLWo5mIN5gZOINiJ2j09rHTPAsV
	 CEZ5hJUf/G0Yg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/7] net: tls: fix silent data drop under pipe back-pressure
Date: Wed, 29 Apr 2026 15:29:38 -0700
Message-ID: <20260429222944.2139041-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429222944.2139041-1-kuba@kernel.org>
References: <20260429222944.2139041-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tls_sw_splice_read() uses len when advancing rxm->offset / rxm->full_len
after skb_splice_bits(), rather than copied (the actual number of bytes
successfully spliced into the pipe). When the destination pipe cannot
accept all the requested bytes, splice_to_pipe() returns fewer bytes
than len, and 'len - copied' of data is effectively skipped over.

Fixes: e062fe99cccd ("tls: splice_read: fix accessing pre-processed records")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: john.fastabend@gmail.com
CC: sd@queasysnail.net
---
 net/tls/tls_sw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 798243eabb1f..2590e855f6a5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2317,9 +2317,9 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	if (copied < 0)
 		goto splice_requeue;
 
-	if (chunk < rxm->full_len) {
-		rxm->offset += len;
-		rxm->full_len -= len;
+	if (copied < rxm->full_len) {
+		rxm->offset += copied;
+		rxm->full_len -= copied;
 		goto splice_requeue;
 	}
 
-- 
2.54.0

