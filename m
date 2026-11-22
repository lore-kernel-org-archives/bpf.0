Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795335448;
	b=YzqE3HtluJ7Htwqz0IdCifgEGGg5Od6jvPhlqcW1kJgCjMmhW+pQX0ozue9L1oJq/oyW
	 OFyVbaNvfYE2fF5Ui7u20A9hmn5Y0TP1b6bp+o2vBq4loHkx10Ad00i9M8qYIiyCvTeUW
	 l+rH8++g8wFNZk7z9fzxoVGlWt5qZlGsbh9RcwWRKkXCp3qnV07p3JfG9YDEdZ6huRr0X
	 9+/ed/wmpNw51dNnZmr2QjX4GrmgS5YOTh7svR7LbGHb8uI8hCAbuWL5vg1YQObBD/Pyf
	 9vehsQofduuvbvZQyDyevIzp/MuWNS8OREkQVl/Ip4pyxWvrs9LdwJvVvl8Roythlqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795335448;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=kzlLI3VmcU197xNNJ2LEd4Fj/tsv/XcZsjqi8t3VDdw=;
	b=kX5JpjtGjB3NTgLUot3UiXYu/qx6J+3kR5Jfuot/tX5onVZgy6ZG/uB8V8yf+EX2hzbv
	 UzKxlu6wgouhn79/ljPBFUPG3vP+edDW/bhrX3qaFaTzFq2jRDa+o605zl+L4B8XeluHe
	 vLmJF556FhAxzZMpdM48r9qMb96H2Uhf+FAEntcpNgFaybAa3gpYTArB4GeSrMq4L7N66
	 4iL0ONK2K+3MqIihAWVf0Rx9mdfFa92SyPYRbqLv2MPJNpj44djqlJIGAPtrhecLa9FyG
	 r+8VAlWIjnSEF2rgVA0OK28ZdgsGuj4tRCa/n2l0GVL7l8mRZR0Bu0DsFLcYA5DbcUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIVTvBIq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB594606A320;
	Sun, 22 Nov 2026 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIVTvBIq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795335448;
	b=pUA/1hCEwCoTxfGM7vu+PoWp9nQNm2E1bIoPnAEBvvmODdj90J8b40bun/+ZkbCfeBjD
	 XbBB//stJ7dCEq4NjFPVvirmSZ7jvJ+f9rxi55/oGbplqRf3CbOQyjTGOi39PiKlsbVUK
	 kdHdsxlsull9eK04ILwmMIh9zqIxXQQ6y2G+g8xlXabMU+XRnYLNot35XMEMA3VYbilQl
	 T922FJjORcfibXSzGD0HxiJk+Q9opH+h67x3fRYgflE96v63bjPXbdJZ9FDnSZeikTbT3
	 gta0/h1uqKqkt478LlPE9mMwTssBczjxbdZ2fdlGs0Jufa1rF5G9HkCDdheSeFy4Y8A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795335448;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=kzlLI3VmcU197xNNJ2LEd4Fj/tsv/XcZsjqi8t3VDdw=;
	b=GvVFWhvYtLZwpoNCeRsBZXAiePznUyE3HKoIoOGrn2prC7AT/nBV7Gyf6ngHPMtSjBon
	 ztjzCr/87ZAI9R3i9a/lkmbyD8iFZUjA4y4CfFLiVustsA1jJXWaWCXvpk9XCPKr/hJv5
	 rS6vxBEVJYcA7qDKEFuBpxMk9A3RbEvCnYdFNLVtvhlSkiX/j7L28pdvZxaCn0cjk8QaP
	 jEYwI0PXdNuEZqsjGGtrPsi5UI6Hok2eVXr0YHyoMpz/gjhvHwlOiZLLE8tqhoyF6iSpY
	 YF1HnTGHZsu0M8XfFEvNHb0qMu7WTGczNXR1WULiRTpxcQaXNZKY9h6EH70Hb5jpUgA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CA91C1F000C4;
	Sun, 22 Nov 2026 08:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795335448;
	bh=kzlLI3VmcU197xNNJ2LEd4Fj/tsv/XcZsjqi8t3VDdw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=WIVTvBIq3kPFN64MjqKAqlX2L79x3czdTV9Y+MhMNcOg57b5nt+KLGSZr1D0MUIBr
	 wExqqoIvdrZRGGWR7dJ0dvTvIdk1ldbvWFHI6jzEtvh5XqlKlSnvNB7Qao7XXuaLZi
	 KKBGJwU+0qieMLF8tXZYyTLfyJw10TIp+L7JdRrz24EdPOcCcd5fVnYifg343DcYoe
	 E2FFRdf+HQzZq8Qm/7UO5LLEEjgep4cQQav+ajXJhRebA/Rq3krRDPQyPPaUkaUpQq
	 yzUNmMvJnzRXGRX9J+jBVeAP/ZSHljW9iMpVpWoT4J4u8ww6h7H9by9eowhucekKwT
	 unPbWinuGI0vQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 317404BFAE;
	Sun, 22 Nov 2026 08:17:27 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 08:17:26 +0000
Subject: [PATCH net] net: reuseport: honour SO_LOCK_FILTER in
 SO_DETACH_REUSEPORT_BPF
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-reuseport-lock-filter-v1-1-a3e5324c8d55@gmail.com>
X-B4-Tracking: v=1; b=H4sIABWlAmsC/yWMQQrCMBBFr1Jm7UAzC0WvIi7a+KOjJSkzqQild
 zcq/M378N5KDlM4nbqVDC91LblB2HUU70O+gfXamKSXfQgibFgcc7HKU4lPTjpVGPfD8dAGSWO
 k5s6GpO9f90wZlS7/05fxgVi/Rdq2D9MIuAV+AAAA
X-Change-ID: 20261122-reuseport-lock-filter-0a97a97e2fbc
To: pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net, 
 kuba@kernel.org, kuniyu@google.com, willemb@google.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev, 
 linux-kernel@vger.kernel.org, horms@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795335446; l=1823;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=mUix/dSzrnbiMpxouGrm26+4a6yRQiNkofJT/Rp0r4M=;
 b=C1HoG1h2Yi2qB7Kdc+loDObrbf9S1VJqaIK5MIwN6f++LFKuMYPoKCW2ZkeSJiVs9NmNBGxi0
 mtivHQUnok/AMsBnjA4qQrkHfDt9B432CJehtFfaLM26ZDiEE7c7I55
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

SO_LOCK_FILTER lets a process lock the filters on a socket before
handing it to a less privileged one. Once it is set, the existing attach
and detach paths reject changes to the socket's BPF filters with -EPERM,
but SO_DETACH_REUSEPORT_BPF does not check SOCK_FILTER_LOCKED. So an
unprivileged process that receives a locked socket can still remove the
reuseport program, which then changes how packets and connections are
spread over the whole reuseport group.

Return -EPERM from reuseport_detach_prog() when the filter is locked,
like sk_detach_filter() does.

Found with a static analysis tool and checked by hand.

Fixes: 99f3a064bc2e ("bpf: net: Add SO_DETACH_REUSEPORT_BPF")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Tested in QEMU (x86_64): root binds a UDP socket with SO_REUSEPORT,
attaches a reuseport cBPF program and sets SO_LOCK_FILTER, then a child
running as nobody uses the inherited socket.

Before:
  SO_ATTACH_REUSEPORT_CBPF: EPERM
  SO_DETACH_FILTER:         EPERM
  SO_DETACH_REUSEPORT_BPF:  succeeds, the program is gone

After:

SO_DETACH_REUSEPORT_BPF: EPERM as well
---
 net/core/sock_reuseport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index b9e5648fa4c5..cdff61161a70 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -727,6 +727,9 @@ int reuseport_detach_prog(struct sock *sk)
 	struct sock_reuseport *reuse;
 	struct bpf_prog *old_prog;
 
+	if (sock_flag(sk, SOCK_FILTER_LOCKED))
+		return -EPERM;
+
 	old_prog = NULL;
 	spin_lock_bh(&reuseport_lock);
 	reuse = rcu_dereference_protected(sk->sk_reuseport_cb,




