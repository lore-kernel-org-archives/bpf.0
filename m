Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257315;
	b=Y+/ZuBqoSJ6CdM92qFUb2oXfSa44NUcfllUi6evVfLDZg0hHgv54HDKqyGrMIOUVmrHG
	 K+NbaJ8xGZKhxd9tyUxFFCe+xM8wwk2JtslQNVOT7+fDWJynzJByc0KpZe8mGmwicueyD
	 E3mTwLFiPAu6IbtUl5JLZ6OyXMdDAYroQr8SHQ9GzWBam2gA7CTTHRiVyc8gyJnfJuXoF
	 bKhpCphy3KUIIWo/lI8NhweVGbkOZNV6CVZZwrsIEX/UK2qapbkoaKMthMTOPtdxU7fTP
	 NfUa5LaPqRAMH97h/VP7uUPucK99Tbu9qiVzkj++z30fxiUNr55FIjte1ofFojXIzEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257315;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bjG2Okz8iGgbh3ees3i7reQXyGSwi++CYO+Z/Q8Ttss=;
	b=pZujDUWwuqjPu01DVxX7o9ZBICzOoULg/zWhvkgdRV6i4Sf+Kee+wtxI6q7rNDKd94yN
	 xKy39sPhOEsnTGvuSGhI2bcjL/GoGb8kmILWWqgXr5vv+BpzeaYicXwEpFHz8ogURwfDJ
	 CZsaXN0My9l0XfUQLMzA8w8EY1OTZcPqFCZRsXMgICqPXlpDhXqNYfwod52Hx8J82upLM
	 B6Wu104Bsdj5a+vXUkaMo2XPoSb96CC5J0UVURKi5b5tlAJa30dReOty/UANMDihXI6bS
	 erl+tQ5rFGeEHct00pgCbn5GLOFnGsPAc5M1hz8pP/c+CQZwCDj7LOFqcdKeyFJh0HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=no0X1i4V;
	arc=none smtp.remote-ip=95.215.58.157
Received: from mta1.migadu.com (out-157.mta1.migadu.com [95.215.58.157])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0A6606A325
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C0A6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=no0X1i4V
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YCflmLbeG3eTiOPqoz6EeAAsvzcvl036eUCwFD/lgzA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795257312; v=1; x=1795862112;
 b=no0X1i4VZ03Qw/IOrQYLDL2gMbV5wbikTaszoB+In5vR79RtHK6OPnAVvHe4ZtmuLW1NPCLL
 wUHCbRtRfzHExTLrcjYx7YnKty+I651FMgyEdY8XtSKF7MWvxT4dul82C4M5olFt2efflMUOnfk
 90eSHugg3OT3WaDS/setCpss=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0bf361dc8874d648;
	Sat, 21 Nov 2026 10:35:12 +0000
X-Mizu-Trace-ID: 0bf361dc8874d648
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	Mattia Meleleo <mattia.meleleo@coralogix.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 06/11] bpf, sockmap: Fix reconnect with a psock by rejecting disconnect
Date: Sat, 21 Nov 2026 18:30:07 +0800
Message-ID: <20261121103222.88209-7-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121103222.88209-1-jiayuan.chen@linux.dev>
References: <20261121103222.88209-1-jiayuan.chen@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash
and lhash2.") rejects connect() -> disconnect -> listen(), but
connect() -> disconnect -> connect() is still allowed.

A socket in a sockmap keeps its psock across tcp_disconnect(), and the
new connection runs into what the old one left there:

 - recvmsg() returns the old data still queued on psock->ingress_msg.
 - psock->copied_seq and psock->ingress_bytes still account for it, so
   copied_seq runs ahead of rcv_nxt for the rest of the connection.
 - sk_psock_backlog() does not take the socket lock for ingress, so it
   can queue old skbs from psock->ingress_skb after the reconnect.

Cleaning all of this up on disconnect is hard. Do what TLS did in commit
5071a1e606b3 ("net: tls: explicitly disallow disconnect") and reject the
disconnect with -EOPNOTSUPP.

Unlike TLS, some callers have to be let through. None of them leads to
a reconnect with old data:

 - A child can be added to a sockmap before accept(), e.g. by a sockops
   prog. When the listener is closed, inet_child_forget() disconnects
   the child and frees it right after, without looking at the return
   value. Such a child has no sk_socket.
 - close() with a zero linger time disconnects through sk_prot, which
   is still tcp_bpf as long as somebody else holds the psock.
   sock_map_close() sets SK_PSOCK_CLOSING for it.
 - A listener is disconnected by shutdown(SHUT_RD) and
   connect(AF_UNSPEC), and has no data.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/skmsg.h |  1 +
 net/core/sock_map.c   |  1 +
 net/ipv4/tcp_bpf.c    | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 98f71c6d0af73..7e8256b2b4d6c 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -70,6 +70,7 @@ enum sk_psock_state_bits {
 	SK_PSOCK_RX_STRP_ENABLED,
 	SK_PSOCK_STRP_DONE_PENDING,
 	SK_PSOCK_TX_BUSY,
+	SK_PSOCK_CLOSING,
 };
 
 struct sk_psock_link {
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 6747b3cc1cac1..6fc1d29ac6ed5 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1763,6 +1763,7 @@ void sock_map_close(struct sock *sk, long timeout)
 		sock_map_remove_links(sk, psock);
 		rcu_read_unlock();
 		sk_psock_stop(psock);
+		sk_psock_set_state(psock, SK_PSOCK_CLOSING);
 		release_sock(sk);
 		cancel_delayed_work_sync(&psock->work);
 		sk_psock_put(sk, psock);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 077b65927ac8d..9715716518c49 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -710,12 +710,33 @@ static struct proto *tcpv6_prot_saved __read_mostly;
 static DEFINE_SPINLOCK(tcpv6_prot_lock);
 static struct proto tcp_bpf_prots[TCP_BPF_NUM_PROTS][TCP_BPF_NUM_CFGS];
 
+static int tcp_bpf_disconnect(struct sock *sk, int flags)
+{
+	struct sk_psock *psock;
+	bool reject;
+
+	/*
+	 * A new connection must not reuse the psock. Let through a child
+	 * that nobody has accepted yet, a socket in close() and a listener.
+	 */
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	reject = psock && sk->sk_socket && sk->sk_state != TCP_LISTEN &&
+		 !sk_psock_test_state(psock, SK_PSOCK_CLOSING);
+	rcu_read_unlock();
+	if (reject)
+		return -EOPNOTSUPP;
+
+	return tcp_disconnect(sk, flags);
+}
+
 static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 				   struct proto *base)
 {
 	prot[TCP_BPF_BASE]			= *base;
 	prot[TCP_BPF_BASE].destroy		= sock_map_destroy;
 	prot[TCP_BPF_BASE].close		= sock_map_close;
+	prot[TCP_BPF_BASE].disconnect		= tcp_bpf_disconnect;
 	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
 	prot[TCP_BPF_BASE].sock_is_readable	= sk_msg_is_readable;
 	prot[TCP_BPF_BASE].ioctl		= tcp_bpf_ioctl;
-- 
2.43.0

