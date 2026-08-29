Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C73F1055;
	Sat, 29 Aug 2026 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787968852; cv=none; b=hEO55oqnBktL0WtWpiZqpnHv3Ci4eWiP/HIMXaz0zodkD93XjDQ7fikLdlAjXmgeGNFapAjsieaqzJwejGGEtL8NKl+FjUGzE4PQZDTHJjZ45+n5XIM0i65MhlRCqnz2GLAkDaWOAPTc0nn+BwkJfs4oQEW9kY0S8tgIZ+FB3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787968852; c=relaxed/simple;
	bh=fcgJKQ13NwZDQFiGuIFXg1tC9IF34aSOD3MOKSpLUhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLPKbPgrNQq9jf23xHJ09ah6o1X3uZUSHL8JJNyJVdx3gvw1xwe3L15QyPVhZufk0gaV48gmvtsIphjoo13qRPKmetGch3IpS2/QxUPEELK8YaedzUDswztzjDYVqrea6csnQqp/cLMyrWVN3VMec836+F+/FlIez8lZQn3urPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3MKV1Kx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3MKV1Kx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F116A1F000E9;
	Sat, 29 Aug 2026 02:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787968848;
	bh=BqBGi3eF6GR0R1wUXJeXZsTvg7gOn9/O04X1RxIM0kE=;
	h=From:To:Cc:Subject:Date;
	b=N3MKV1KxrWe6AV1QBQI6ERtSuiRFLqA4y+5g3l/+76Xb1s0AnMcWzePOvUv8zxj9o
	 EkQStN3DY5ONiz6TBFn0IKtjt14HqOqsFiFScHi6LKE8H+K3Ttk1DUCxW04lsy+bJY
	 b7oTAdLH5U4viRaHjmHNQXsdkyczSuyhLYUDlvGMFuK2RfyCdzx/TYsQmNj17D3hO/
	 WfHeCkils0hpE73BmzFOe2Z2Fl6ITq2EX63UJVoCxMfN2Fo/N190Hgch7Qyc0X2jaq
	 o/JrXiUsf6vEnK4bb33/N+1tE2VTK9E91IH854CxCbQWJM9zDTZBsfGwY9Mky2aSts
	 byO0bckqhoWUQ==
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
Subject: [PATCH] bpf, sockmap: Fix self-redirect copied_seq double-counting
Date: Sat, 29 Aug 2026 10:00:12 +0800
Message-ID: <b840c35fdfdf36e9fddedfa645b12699bc51aa34.1787968065.git.tanggeliang@kylinos.cn>
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

Fix this by checking if the redirect destination is the same socket.
For self-redirect (dst == psock->sk), skip tcp_eat_skb() since the
copied_seq will be advanced when the data is actually read from the
ingress queue. For cross-socket redirects, tcp_eat_skb() is still
needed to account for data leaving the source socket.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
Hi,

I encountered this while adding MPTCP BPF sockmap support. The existing
TCP sockmap selftests don't cover self-redirect, but the MPTCP tests do,
exposing this latent issue.

With this fix, both TCP and MPTCP tests pass, validating self-redirect
functionality.
---
 net/core/skmsg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2521b643fa05..5fa7b9639eef 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1039,10 +1039,14 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 				goto out_free;
 		}
 		break;
-	case __SK_REDIRECT:
-		tcp_eat_skb(psock->sk, skb);
+	case __SK_REDIRECT: {
+		struct sock *dst = skb_bpf_redirect_fetch(skb);
+
+		if (dst != psock->sk)
+			tcp_eat_skb(psock->sk, skb);
 		err = sk_psock_skb_redirect(psock, skb);
 		break;
+	}
 	case __SK_DROP:
 	default:
 out_free:
-- 
2.53.0

