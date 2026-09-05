Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681D233956;
	Sat,  5 Sep 2026 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591823; cv=none; b=of51M+v5J9tSWhLt0LmPaJvCnR/nB6QRrfAXyhkzoHADef8shG8bohrySDBfEtlfx3R/I8/q2tZRSNQa/p/KJLYE8MfoqfngonANrE2ixvrs2iyICHC07aNkPEd9dfRo0JcUwx/pz94KUUNpZf6XwqeoJeDl32iLH1ADGyxK1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591823; c=relaxed/simple;
	bh=SeBWSOb1qf9Bg0eA4nbAYm+OQzTz1jL6stZZQm4Cyqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmAl9KLPAXj5RfhzKdXPPD8sgVhKlhUO4lr412iy27vHE4ZBc3NVbpF9/9wlEVAS1PKMTFFvhUpEYd1vd81wMV2+e4wGuwL+uUiWMPUnc3gIBMKeqToxYN+cSOjS83Lr9sF9M6FeQzaRE1nPLCx0F9pc3oR7AgGkt7dGCMJKVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LedNeuKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LedNeuKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1C91F00A3D;
	Sat,  5 Sep 2026 07:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788591819;
	bh=kCLjtnqzGTdq0E5NzkKTnwmOkR6pFXvKGu8NsTngeNU=;
	h=From:To:Cc:Subject:Date;
	b=LedNeuKFQidD5DIB4244v393FoF4+1GyDWz7cS14ckSEIKWHC7vNph3hEolfaa9I5
	 aCs2BAardKnz/CRU3uUur+ahHW0eDhp6ZMvq58LUhVfnelZ31HeCa4f0PLhn92AZDz
	 ZwzCZl7cjJ300c050lTjyZ0Vcd9HpjPfEYmUNPsFxoz7D6OoC4wJVBlJARSWAOlWdI
	 8tHyibjickpsdasgxHYvPca2kqrSI2UzOl6Qn09Ym86YyjWAjBQZkemQ3fiYjK4l/3
	 0h+RwqA0S4MzMrkyQv6DwZhUGOIGq3WIws0oUVtdTstdFNOdgnaZLKpfvcOyGXJuFh
	 g92JNeqjJReeQ==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2] bpf, sockmap: Fix self-redirect copied_seq double-counting
Date: Sat,  5 Sep 2026 15:03:03 +0800
Message-ID: <1d2370f4c81f10834b8dd77524924575c629a464.1788591198.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When a BPF stream_verdict program redirects an skb back to the same
socket (self-redirect with BPF_F_INGRESS), sk_psock_verdict_apply()
calls tcp_eat_skb() which advances tcp_sk->copied_seq. However, the
skb is then delivered to the socket's psock ingress queue and later
read by tcp_bpf_recvmsg_parser(), which also advances copied_seq via
the copied_from_self accounting path. This double-counting causes
copied_seq to advance by 2x the actual data length, triggering:

  TCP recvmsg seq # bug 2: copied BF2E806, seq BF2E7FD, \
			   rcvnxt BF2E806, fl 0
  WARNING: net/ipv4/tcp.c:2745 at tcp_recvmsg_locked+0x72b/0x2640
  Call Trace:
   tcp_recvmsg+0x10a/0x500
   sock_recvmsg+0x168/0x1d0
   __sys_recvfrom+0x19a/0x2a0
   __x64_sys_recvfrom+0xe4/0x1f0
   do_syscall_64+0xf7/0x530
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  cleanup rbuf bug: copied BF2E806 seq BF2E806 rcvnxt BF2E806
  WARNING: net/ipv4/tcp.c:1609 at tcp_cleanup_rbuf+0xf2/0x1c0
  Call Trace:
   tcp_recvmsg_locked+0x8d1/0x2640
   tcp_recvmsg+0x10a/0x500
   sock_recvmsg+0x168/0x1d0
   __sys_recvfrom+0x19a/0x2a0
   __x64_sys_recvfrom+0xe4/0x1f0
   do_syscall_64+0xf7/0x530
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fix this by converting self-redirect verdict to __SK_PASS at the
beginning of sk_psock_verdict_apply(). This bypasses the
__SK_REDIRECT case entirely (which calls sk_psock_eat_skb), letting
the __SK_PASS path queue the skb to the psock ingress queue. The
data is then read via tcp_bpf_recvmsg_parser(), which advances
copied_seq exactly once through copied_from_self. Cross-socket
redirects continue through __SK_REDIRECT with sk_psock_eat_skb()
unchanged.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - fixup the verdict as Jakub and Jiayuan suggested.

v1:
 - https://patchwork.kernel.org/project/netdevbpf/patch/b840c35fdfdf36e9fddedfa645b12699bc51aa34.1787968065.git.tanggeliang@kylinos.cn/
---
 net/core/skmsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2521b643fa05..df385a5a961e 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1000,6 +1000,10 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 	int err = 0;
 	u32 len, off;
 
+	if (verdict == __SK_REDIRECT && skb_bpf_ingress(skb) &&
+	    skb_bpf_redirect_fetch(skb) == psock->sk)
+		verdict = __SK_PASS;
+
 	switch (verdict) {
 	case __SK_PASS:
 		err = -EIO;
-- 
2.53.0

