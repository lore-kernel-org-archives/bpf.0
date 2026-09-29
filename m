Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D03DEAD3;
	Tue, 29 Sep 2026 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670949; cv=none; b=FGwnHag/hyKbqEXuyBwuzBIBdGsegKwc8id2bZ5iKCVxga2drsC5eY+ZoONL2r0ejSUmMkIBPD/qQH6O7wmM7qGcYk/4Brdf5BQPh0rJZA9q9XwRtKy30G9KlfVEo1oYVDkR7eAjqZG9n+aUKkyGEi4nUc2bpIGAoNc5NyFUZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670949; c=relaxed/simple;
	bh=26s2Byk8YuXobhtK9pQRAsPXANbN9TjshX7nxF2Q1Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1816dsVHbuAKvkEpMqVR/0jkq8GrBeIDyLXb93jtaaVk8QXqSUPqIhLoQJjg5ZdJELBzdk32TgPpic0XM/x7Aok2vNjTxv4WGR4x4sC/WX2pLnW6mT+lGI8FGbdtgHVZLi9QwLX+cTotoPBNjQk5jXcra52jZOyl3gEfLu2PsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gFsDpE4k; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gFsDpE4k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=a0
	/ApTQ8z0E7J+4U7miE76EY6mccpvjtxEhGKrs8PsQ=; b=gFsDpE4kp5zysSD2tz
	U5AnEoyRfe5fVmL/iREYTwefBBl0zAjSSy+oo7ekUeII51mg0dwaQ8taESRgwque
	qr2GXsokVuUtDfdYTJYQFJUStZXpwLza3PnXTHs//nWIpLQ0VnuMfK1dodpbjpEK
	Hvj7Cq8oUjnT24fvDNJBOsOI0=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3vx8seLtq177cBQ--.12081S3;
	Tue, 29 Sep 2026 16:34:55 +0800 (CST)
From: chenyuan_fl@163.com
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	daniel@iogearbox.net,
	ast@kernel.org,
	cong.wang@bytedance.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf, sockmap: Fix udp_bpf_recvmsg() spinning on backlog-only ingress
Date: Tue, 29 Sep 2026 16:34:46 +0800
Message-ID: <20260929083447.558818-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929083447.558818-1-chenyuan_fl@163.com>
References: <20260929083447.558818-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vx8seLtq177cBQ--.12081S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFykCF48WrWxAF47ZF43Jrb_yoW8WFyxpF
	WYvayrAF1ktr4j9wn5AFWxX3Wfuw15Ja1xGr1rCw1fZwsYkr1fXFWrKFyFvF4jyr4vya1Y
	qFWvgr1aywsxA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbdb8UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5Q+ycGq7eC9sMwAA3x

From: Yuan Chen <chenyuan@kylinos.cn>

udp_bpf_recvmsg() re-arms its msg_bytes_ready loop whenever
psock_has_data() is true, but that predicate also covers an skb parked
in psock->ingress_skb, which sk_msg_recvmsg() can never consume: it
only walks psock->ingress_msg.

When the backlog stays populated, e.g. while sk_psock_handle_skb()
keeps returning -EAGAIN, every round gets copied == 0 and
udp_msg_wait_data() returns 1 again from that same skb, so the loop
never sleeps: recvmsg() spins at 100% CPU while holding the socket
lock, ignores SO_RCVTIMEO and never returns to user space.

The wide probe is intended for the entry check and the wait condition,
but re-arming can only make progress from ingress_msg. TCP and
unix_bpf_recvmsg() therefore re-arm on !sk_psock_queue_empty(psock)
and otherwise fall back to the plain receive path. Do the same for UDP
so the reader sleeps and returns -EAGAIN on timeout as expected.

Fixes: 9f2470fbc4cb ("skmsg: Improve udp_bpf_recvmsg() accuracy")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 net/ipv4/udp_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index ad57c4c9eaab..8aca9fb89334 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -91,7 +91,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 		data = udp_msg_wait_data(sk, psock, timeo);
 		if (data) {
-			if (psock_has_data(psock))
+			if (!sk_psock_queue_empty(psock))
 				goto msg_bytes_ready;
 
 			release_sock(sk);
-- 
2.54.0

