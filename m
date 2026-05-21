Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3D379ED8;
	Thu, 21 May 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380845; cv=none; b=Go8c/s6JhrECSqewJkXi0tm2dcgy67QA3UiKuOsde3+3VIzJ4XjrCqHpujPfEaUbBJIb3W0vg1kmuHdyMlghJpVGgkEbMGS0hN8v+LW/2AhwQBMHdfMNjkrieeMZ/HHMQFzTcywRE42W5IC5bxZruqQJ3Fn/HGaj/Qa8u0ImQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380845; c=relaxed/simple;
	bh=/h2suqSmh1VRy0ZDF7M+hpAPAXzQc14eVg4ZcH/J93w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mslgteVw7XasQzRn/cD1K50S1S9U/4U29mMO/7TuRuwJDK5Wz4+/G+2HPpyCqqMrOrxa+F7shgWZr/X5XZ9paP2zAhLHQKEqYsYKGJ8WBHtOc58c2nUO2vFNcZZdISTSSQFu6GqcpeVH0/RE+e6UMOAe9mWwfuwIOU7puLfrJmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=mOT6rEaX; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="mOT6rEaX"
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4c9f:0:640:5657:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 9368580C2E;
	Thu, 21 May 2026 19:27:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp) with ESMTPSA id ARWPO30gRuQ0-PRtRLhY9;
	Thu, 21 May 2026 19:27:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1779380831; bh=gEM7FQjpHaiA+zwiIQRtAFpWhBBRhsP6Tj3J5miCxNY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=mOT6rEaXu27R+d3Bnx8a7nYNDzFZ8nl9tbc3BVj1Rkiw4sjLuSEsVh2Do6uXgGS+/
	 hR8Zvyma2tjs35v8sM2ntdathbpxoQ6QHsL2n7Vxr4JOUnYw2QJJx0Y3cZQWjE8iqI
	 wVt05+oK+xa9qzKNnYu9IycE2TRYskKZPmA5Ud6E=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
Subject: [PATCH] udp: fix use-after-free in __sk_msg_recvmsg()
Date: Thu, 21 May 2026 19:27:09 +0300
Message-ID: <20260521162709.578638-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'udp_bpf_recvmsg()', 'sk_msg_recvmsg()' should be called
with socket locked. Otherwise two threads may peek the same
message, and one of the threads may dequeue and free that
message while it is still processed by another thread.

Reported-by: syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=431f9a9e3f5227fbb904
Fixes: 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/ipv4/udp_bpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 9f33b07b1481..ac628eaa7759 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -79,6 +79,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		goto out;
 	}
 
+	lock_sock(sk);
 msg_bytes_ready:
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	if (!copied) {
@@ -91,11 +92,13 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			if (psock_has_data(psock))
 				goto msg_bytes_ready;
 			ret = sk_udp_recvmsg(sk, msg, len, flags);
-			goto out;
+			goto unlock;
 		}
 		copied = -EAGAIN;
 	}
 	ret = copied;
+unlock:
+	release_sock(sk);
 out:
 	sk_psock_put(sk, psock);
 	return ret;
-- 
2.54.0

