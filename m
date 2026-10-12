Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [51.250.60.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C44AEBD0;
	Mon, 12 Oct 2026 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.60.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823031; cv=none; b=TmD8KpjzaYyPvQAcCrII5WO3d4C47/dQgGgxTx5RheH/20qKHOxyGbSq/JbYvz0m8mgheiUZ1iCFEjRxoAy3Se+e4KXB/LijHWZY3OLk0BEBqF7Alyb4vCkv3LjwigAI17ssSG/7gsTjfVxORbHOgz0Ss6a36mF0i8EIIyamS3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823031; c=relaxed/simple;
	bh=I1Au5zhhfk6ewU53/8hAATSVq5eIS+XKJOmB/K0YuhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6pajLbTqTXCAS3t4CvD5SstpAG4yWtwmm7k12SDykKik4zt7LegwuDSIJW+/DGX/+ClfEpzezLjrBZD35WeWSAWHn0+KlTqru/50XH26Fre+5ql9izAlSHRL28jb1mFA6+LNDCVaFOi6+iOF3uqj/uX6I4ahC1bjIeYEmank5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=UsRF0GcZ; arc=none smtp.client-ip=51.250.60.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="UsRF0GcZ"
Received: from mail-nwsmtp-smtp-production-main-58.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-58.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4705:0:640:c883:0])
	by forward103d.mail.yandex.net (postfix) with ESMTPS id 37866C0085;
	Mon, 12 Oct 2026 19:36:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-58.klg.yp-c.yandex.net (smtp) with ESMTPSA id taVr5f3kgSw0-a9FsvWSj;
	Mon, 12 Oct 2026 19:36:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1791823016; bh=i7tETMhSgGfka1qBHQyR0LY4YrOyLrdsyCX+E7J0BzU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=UsRF0GcZPCaJwSiPC47NYO/M9YIUNcIFKFUJo69jwkeu7QH/sCugexIyGcIgJxBZ7
	 v/46IfafjgogJABMgG+U+QyG4E1f8pzxNMFJ9Nz0llcvBiqF+M2xGtyoc8mtIZX9/P
	 YxBlETq4oOxqeK2MlGz4QIIUyFzpCCosqcnnXZMk=
Authentication-Results: mail-nwsmtp-smtp-production-main-58.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Eric Dumazet <edumazet@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Levi Zim <rsworktech@outlook.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] tcp_bpf: propagate error code in tcp_bpf_sendmsg()
Date: Mon, 12 Oct 2026 19:36:19 +0300
Message-ID: <20261012163619.47528-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tcp_bpf_sendmsg(), propagate error code possibly returned
by sk_msg_memcopy_from_iter() so that the former can handle
it properly at 'out_err' label.

Assisted-by: Sashiko:[unknown LLM model]
Fixes: 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
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

