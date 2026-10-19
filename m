Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [51.250.60.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7F139099C;
	Mon, 19 Oct 2026 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.60.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398144; cv=none; b=ubarJ3vjzLqdZUn1gXBBPMNVAYG2hQq26SUvHPONQqSPspJa0aPDJgFdGx9kUGh20vVfpswv/xLqbwnaAaqWvYf418l/PqAemK1BUGxRTyrFavvFnCc+uAdI1a8RNIoFCWVlzPPbheoiqDWu7BPzvKpI1X6atpRu2CUrRiKjUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398144; c=relaxed/simple;
	bh=wNGjvvDOkUEQLTcMKCYG8jQ1uAuLjJifJ1f5viyc1HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lhbm/LDeZiHq6oPAQo7n5fXWfa4+tTuQlzYXes7JlW6hBRcqF9IScE0sJVLxAttTKvvrIpxosFFQEB9MD4L6uCx0wVns27+AN8UYyQOG6UNX2VOki3ns/lk1NY3wRzXePqVhqPCIhAciSlKldJIg/qDGnUhrqAMIEL6qUGSGp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=nTZA2JpV; arc=none smtp.client-ip=51.250.60.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="nTZA2JpV"
Received: from mail-nwsmtp-smtp-production-main-80.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.yp-c.yandex.net)
	by forward101d.mail.yandex.net (postfix) with ESMTPS id 5979DC00C0;
	Mon, 19 Oct 2026 11:22:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80 with ESMTPSA id FMUh5QXdISw0-fSJhSDdh;
	Mon, 19 Oct 2026 11:22:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792398136; bh=UwurFYGWjQXk7l+9kKaGrj3yOkB2j+2Uzg794igvGr4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=nTZA2JpVk15t6zRlt+WyZ/+qKxuPOb5/X86ZGsBhnGUiX23IJKt9lyjPa8uxrd62l
	 J7NABKOTZ3Z973TlF51T+vFxHA90FakIdri1Usz3E0OyaOXg7lD8cp2N7Fx24ubwvW
	 Mja5LWNHPGyOMq9k0U3csIpPr01CMhoQUvBuqfco=
Authentication-Results: mail-nwsmtp-smtp-production-main-80; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Eric Dumazet <edumazet@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Levi Zim <rsworktech@outlook.com>
Cc: Denis Yarapov <yarapov_d@mcst.ru>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sashiko <shodan.ai@mcst.ru>
Subject: [PATCH v2] tcp_bpf: propagate error code in tcp_bpf_sendmsg()
Date: Mon, 19 Oct 2026 11:22:14 +0300
Message-ID: <20261019082214.102398-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tcp_bpf_sendmsg(), the value returned by sk_msg_memcopy_from_iter()
is checked for error but not propagated to 'out_err' label, so error
handling may not work as expected. Fix this by assigning error value
to 'err', thus making sure that error won't be silently ignored.

Reported-by: Sashiko <shodan.ai@mcst.ru>
Fixes: 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: more descriptive commit message
---
 net/ipv4/tcp_bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 2e234d155b5e..0ce583f68d3b 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -581,6 +581,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 					       copy);
 		if (ret < 0) {
 			sk_msg_trim(sk, msg_tx, osize);
+			err = ret;
 			goto out_err;
 		}
 
-- 
2.56.0
