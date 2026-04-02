Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647BA273D6D
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 05:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106582; cv=none; b=DJe0boMbO/uY70UCJmezufhANEv24VM+KeP6UZZsdY95ZXqUi8TWEcG11jdq37iHYPK97wf9NBqtHd1cTfu5xYUdVa4ptCh/TZsGW9BeKqkrt/u/DVqCgP1QdU1+m/KVSQL1PnVUeocilf+vFVVdijVJWOxdlCkNjyRUEV8gqU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106582; c=relaxed/simple;
	bh=x6EXvLd1wUC7SvCNDTvMHc1kTSqHTF4xEughUeks0d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVO8tHB0VICrHKwkNiL+DySqzwIWhEB/dMjNi/UhVZLC6N6SmWGdCHImz8tJFp+WlB0+ST8VANtd5Z9Gv0rnPgxkw/rvI7apZ8tmemR2lFfRJW0Mf6VqVFJrMYBSIhb8joVz8NV3D/RNL3SAOG99Dyph6OxcS3+MCMkPBPSCdyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfirjlRf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfirjlRf"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a871daa98fso3242805ad.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 22:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775106581; x=1775711381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8puRGWeANdZKsMbyIk9XwB9F11o8slKWtfPbwiNQgs=;
        b=PfirjlRfUZH60fEIyygrq48fRE0EKnWvYu5PWSyqy3HtCrFBo7+z7/hRZHtIZIy/bf
         0njlegEDg9rO2ibsMo5d94L6fk2QvQzpEhexwuoYUPynjvYVjN857jhL1WVwMRFdcjBs
         pMWbDmU1rkuveVd6w4TtoNXzpp+5lppByvkWili3TUiQinEWvFeH/vP+zWmXgiIpvLvl
         tkemErttn/ZucHuYlSj1Iny50SY+riOiuDrE8stolSTlJfEzn5/8GrLJKC4a71Ro3M2N
         4eXXvaCK98a+iAVcCvtNYy4uqUiIxuXbwZ/884UZajOsMQI8JR5QSM3XyPU6DjvmhXAE
         HpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775106581; x=1775711381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8puRGWeANdZKsMbyIk9XwB9F11o8slKWtfPbwiNQgs=;
        b=NnVit3t+2qU7Bar/xMxFFOn0/QC5c9aDmiKerWiorNXvoEH2yYQRqxxxyOkjfBDJwP
         fB6zaLTiOcPPNVnh5bcHIsvSltgPe8dMQKCm5/9wvz49p7OyONjbzo+kiNz4EDoUSdzn
         lg9lNkd8blX1ASVFxkODAjIherspylxGBszovXsFO+jVqQqgvLJo/mJWaG4jn9cBPqYJ
         ShABDiW8aqWUEXR/+NOvqnOzYwFRb93/X8lILY/F9OHmQG5V43fNsl1BWubEBGxCmJ5c
         PiZqxjd82/kEDtreB7bNYqXRkHO/7+obbUwEFqRMlks5Q3sPLqCrUHDyxFWFKShlftUx
         yo/A==
X-Forwarded-Encrypted: i=1; AJvYcCW1jnYA5zPEMf6waewtYrzZTVpdHZVeewgg0ZC5Auumnk2THXu57U4seUXgmrd31D0QQho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQX3gWE8XpkGPcgZsAV3+xq1nNRg1+xK8NKQ4Xn/g+/MYHadr1
	Kbp5CRgsz5jDrEohqHPZ489f+6QEbAsJUlnwEtvC5yyLi8BGJ0gSFdpQ
X-Gm-Gg: AeBDievIpHI6DFdK+HIQbzQCVMw0FcjJBi1Mko7nLJoC0Es5PQ0CAanuwZwY6Zx30o7
	RTU6FtsfOu9rgsPf1LtNTwfgd0YHFOC6PLaV/DL5TpxAvB2UuDyKa8YqAcBk9qTkzTjObSV1hgm
	kQ05G1hO0flKSn+w7JoSxSmZxydzHoke3xqULCndIwis4+CFqUYwGFXqjScVP1dHb414qrdO6j1
	vJ9CMtUyZFLTuv0QY21m1M0IJ7UL1B/OKNTq5ciYvILrEiXvCpRjSaeqdEKflazaO4NZs6iaPZE
	VOMQVancgsgQgFSqLuV7gd00KboYIhZ0YBXvrH46bdirewRZy7RhiXlpeP9yOiVC3tMTHwLtlje
	fQVGZiJBZPJ72xnMEw6Eli4hnQgpnjCaKXQS0gb/os9WW1qDBNFMEHKWutz71vBAG5rsSh3zioM
	BZRSH9y4ScVyFhb4ugXFoAdkxQGwCRWYDSpidrSU9KK9707j43mfGTz5l+wprPvAAnfQO51ynj+
	0cX+sM=
X-Received: by 2002:a17:903:b84:b0:2b2:4029:d781 with SMTP id d9443c01a7336-2b269ac7f68mr61839905ad.20.1775106580712;
        Wed, 01 Apr 2026 22:09:40 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:2c0b:3bf4:b5e1:33f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478b64csm15219615ad.30.2026.04.01.22.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:09:40 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: ast@kernel.org,
	cong.wang@bytedance.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
Subject: [PATCH] udp_bpf: fix use-after-free in udp_bpf_recvmsg()
Date: Thu,  2 Apr 2026 10:39:28 +0530
Message-ID: <20260402050928.32946-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_bpf_recvmsg() calls sk_msg_recvmsg() without holding lock_sock(),
unlike tcp_bpf_recvmsg() which properly acquires lock_sock() before
calling __sk_msg_recvmsg(). This allows concurrent tasks to race inside
sk_msg_recvmsg() on the same psock ingress queue, where one task can
free msg_rx via kfree_sk_msg() while another task is still reading it
via sk_msg_elem(), causing a slab-use-after-free.

Fix this by adding lock_sock()/release_sock() around the sk_msg_recvmsg()
path in udp_bpf_recvmsg(), consistent with tcp_bpf_recvmsg(). Also make
udp_msg_wait_data() release lock_sock() before sleeping and reacquire it
after waking, so it can be called with the socket lock held, consistent
with how tcp_msg_wait_data() uses sk_wait_event() which does the same
internally.

Note: syzbot testing shows a separate pre-existing warning:
  sk->sk_forward_alloc
  WARNING: net/ipv4/af_inet.c:162 inet_sock_destruct
This warning triggers from the idle CPU path (pv_native_safe_halt)
and is unrelated to this patch. It appears to be a pre-existing
memory accounting issue in the UDP sockmap path that requires
separate investigation.


Reported-by: syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=431f9a9e3f5227fbb904
Fixes: 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/ipv4/udp_bpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 9f33b07b1481..f924b255cee6 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -50,7 +50,9 @@ static int udp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	ret = udp_msg_has_data(sk, psock);
 	if (!ret) {
+		release_sock(sk);
 		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
+		lock_sock(sk);
 		ret = udp_msg_has_data(sk, psock);
 	}
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
@@ -79,6 +81,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		goto out;
 	}
 
+	lock_sock(sk);
 msg_bytes_ready:
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	if (!copied) {
@@ -90,12 +93,14 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (data) {
 			if (psock_has_data(psock))
 				goto msg_bytes_ready;
+			release_sock(sk);
 			ret = sk_udp_recvmsg(sk, msg, len, flags);
 			goto out;
 		}
 		copied = -EAGAIN;
 	}
 	ret = copied;
+	release_sock(sk);
 out:
 	sk_psock_put(sk, psock);
 	return ret;
-- 
2.43.0

