Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C673220698;
	Sun, 14 Jun 2026 01:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401272; cv=none; b=hqBtXQLuJmwEM9iaefo9BHokb4HpMfnIY5XzYY4Qbd2rM8cSVRxESqWw3I4xgz5SF9E6aVvukKOWH9VLrDWhrC3VuGEjUohc68UPgwjXGyrS1wALuwjsxKm9qFKGwBLkPNO+/fySDWlzVaguxcRuIIzJXaClAJtHvetkcUWSBwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401272; c=relaxed/simple;
	bh=6ZtoVeNGv2HY0+HwNyGzEio7mlqG+hG8ysuvDF46ANo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRXBM5wOYNlrP6b4xeodEuOP6alZRugkU59xLHFaucRHR2fkXzvoFSh42dcRM55SaIFJTm6kB2c3tyx/93U8qiL7af6RJmsQiHx6cTWCGgAlM5i5+rtn/tdA0d7DMMCejTqLTjc50FbDWkwpH9Q3y2eMXI+PZKJZWldvkkfO+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE4CvqC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE4CvqC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0318F1F00A3A;
	Sun, 14 Jun 2026 01:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401271;
	bh=z+qwfR01qpsEEPHdOe1UAxcK9c4EBGjnwGheZ82rpLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HE4CvqC1xUrAx1iKsGTJoTpM2diFvkLkwwtZrLxmFYUEd8E+kYlXlVlnp3CF/gePh
	 P1IPbbeGDUwP4sH/UluCImsg/XYhk/RNH6iPEo2eXnQHCrYkfxXSZ/C4TnolELUoyr
	 9yJde2uPo2155+UbqhrJs1SIimV1HtN2G0j/pXSR7sugPAvJEcHBqgG8EKVjzTMi3g
	 uOBFDH8BYeBpJWaDp/8l1ELZAIe1QpM2lTLDrxNoSxfs7Kyu2ceitvgIocdV5BX+9e
	 uhybdbND8SvCGwl7v4SSlkVmp3CGgTym62extBU+bhDbPg8S60quG1XbQFhBPXXpXk
	 dC0NV9LAseKGg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/5] tls: reject the combination of TLS and sockmap
Date: Sat, 13 Jun 2026 18:40:56 -0700
Message-ID: <20260614014102.461064-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614014102.461064-1-kuba@kernel.org>
References: <20260614014102.461064-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TLS and sockmap (BPF psock) integration hides a lot of latent bugs.
Bugs which may be more or less relevant for real users but they
are definitely exploitable.

We could not find anyone actively using this integration so let's
reject this config. Adding a TLS socket to a sockmap was already
rejected by sk_psock_init() through the inet_csk_has_ulp() check.
We need to reject the attempts to configure the TLS keys (rather
than adding the ULP itself) because checking prior to the ULP
installation is tricky without risking a race with sockmap getting
added in parallel (sockmap does not hold the socket lock).

This patch is a minimal rejection of the feature. Subsequent patch
in the series will do a light dead code removal. Full cleanup would
require a major rewrite of the Tx path, we don't need skmsg any more.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tls/tls_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 13c88a7b8787..8e7ba018988d 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -643,6 +643,17 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	int rc = 0;
 	int conf;
 
+	/* TLS and sockmap are mutually exclusive. A socket already in a
+	 * sockmap (i.e. with a psock attached) cannot be upgraded to TLS.
+	 * sockmap rejects TLS sockets already (see sk_psock_init()).
+	 */
+	rcu_read_lock();
+	if (sk_psock(sk)) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	rcu_read_unlock();
+
 	if (sockptr_is_null(optval) || (optlen < sizeof(*crypto_info)))
 		return -EINVAL;
 
-- 
2.54.0

