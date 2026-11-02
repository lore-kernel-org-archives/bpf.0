Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604137;
	b=njseP7gc5i/ENePgViRIxAZK69KD9FVuMdAF4sSFGQmS+Cfkt1h0D9D6i6U6LeCsKklA
	 sOny3nOIfH4xYjrarTddWHyQO3OOstrqx/wec+P8o3Qdh3TfZcbAB3bGhe50u+ruufT1w
	 tZSEwQZTxZZBR6dku138/domURp4ODLaH978NdLF/AMJVy0cvSH8uwhJ8edj3xXRXSE2L
	 g/NWfq0PUwT+ob5No9gOjFr9P/YrMRU2sLUGWtwzG1eo4aorol0KZJ61JF/smlFA97iHH
	 eowYdfvk2hLoICmUQBTuhxJOF/ZIul+U0YUaGwer/rlRFTRssUlShPOuvvrgCak5P1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IIVQCChPoYZLHDZpOQjjkNqmaU+lbodlGj9e9gYxfdo=;
	b=otaJOEE7H2Zj3LbsujpZHYy593clQY7mU2NlJ77uS9fONyxERD36r4W2xN71LAmJkaDV
	 JXziZBytnVN3PnbvH7Q7T00ygTSvwGUlUmLMcJqzaUhCPjPdsLfWJz4TBwRyzT+W73Bae
	 r9//GUUCoo32bwqcwlPuG2d+DhDwRdz4CEm7YOeSylDjRPBL5y0JXZU+/7HqQ7W72BYeo
	 4GmWqLDnumu8cAY9Ig3lFdvZDrugpUP6Z7RYZewhCdJ9PA9Vs0ZPqjzOGMuVge/RijyTa
	 WNS6qpjtQFoHZaQRSX23lfeXSWlpY/8KLWT+OH6OD+X1b/OypgqVAeLJiSsTACeyLWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J86FxYek;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7C9606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A7C9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J86FxYek
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso1818255a12.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604136; x=1794208936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IIVQCChPoYZLHDZpOQjjkNqmaU+lbodlGj9e9gYxfdo=;
        b=J86FxYekk/QPYPKi9wXndksGulQs0bA7zqT+6Zw7mqjcv/zRrIA+25U6lUuGtvtorE
         rQ44QOMwcupUrZ54O8n2DNwyCcARbetnRYIGqkyqZztqEtU/HQFVtfiGRzAob1MG9uau
         bThmbRMT1FZ7V8xk1R7QYWZdKvLfNfgg/CXII77j4L9crd0qQThzWaVZJtqlEOFeGw+r
         C3iQm3+zN2eIRjUYKoAUUFtKe1anu7LTPH5Cparjrp9cUKjVclDDx899z4L1i/QFpO3T
         S7YLdxDjTRBjjhGVtv2i3Ma+OXgaMtliMHPCIC5eyJ34XnjMnubxJnn+Z44oGjfTdup7
         v+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604136; x=1794208936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IIVQCChPoYZLHDZpOQjjkNqmaU+lbodlGj9e9gYxfdo=;
        b=whuNVqG7VllIrBHGQv9Adt5e17H+a4KFmV1pO1NIDRAVTbjDMveKws+GRa83iGDHLf
         bCmNrk3k0Jfk86QLm8+Bf9HOsO9w+GVJJD8CwQNuPRh+q6FD2iuwM+EOypgs64tbQVcL
         SnUPFhSNxcbej8oJBN/no9ySHm5RQHBJKDOyFPd8lExf651kZcVxQ3YSg3BzYbkG+bcO
         3SYSQ9cEkqL04jMQ8Edo/aVaILFJv+DQYUEX2Q+HYtdFuc5+9/sNhHTH1pSKThE4g2P6
         gJRZI1l0DCSUsN53FhhqTCy7WGN2b9xMjcI+n6E2DHI85KY+5qQZASee3ceFYtINCwz5
         i08g==
X-Gm-Message-State: AFq9FYIeGNsT+8aWUtVTGM0hwNw/EfLqg3OaGtX+ipSx6l0ggeK94aLI
	aWRH1jl48xCoo42Yxcd7Buw5FUr6MeK6ooUqsmD5DdgHuJRvsI3K8geolrwTBw==
X-Gm-Gg: AYBFou1m09XwpBWXN4Bq1mpWkZwUywd5jYXBLOFK78AFOlW4Gbt9FpXBFPv3oxGiu5K
	cpsXUQ1Q7c0q+ytXkBzjy8C8kNitbadYJkSRF50i9RPB+6lJakKlI83dqEdpGgU6wD9BCFWm0Iw
	GL030uMvBQuMY1BgX/YBfxm9Wv6qckrj8OT+f6mGBravaKv61s/GEy0DaMjX87OtFSU/kMRImI0
	Vw8UmtYZ+PCiRR4E9Y3vYpGpORY1D5M6H/SJgqs1L0os4e8t6qZEqYx0mEUA9p84JeNmtJVLvtT
	/tuorfu54dJlOh2sb4WRb4y3O6fPTYGiiZ2ilEF8H35hj/CHj7GYmPCtBCwl7k5lv6yRTNt3mzd
	dmy3PlZy76zFVDUIs/a0vJ109+BHwEnnrH2hATDSljV8EwC+wSe8I1NstAyt0LleXTrfu7FENop
	L7OLRV+tNDJS+HCdKEKaIQXdmTlD7wT3v0Aw69Sk/Lxf5AGfYOmV1vZQ5TySD0pBFbDU+fvcTuD
	qJ5wxdzI/MdyoJ1eCltHuBDWg9QSPHqUhWWvTD5wozbX/1ekVda1gxne2CVlAb04fDfN0S9b377
	3BBm1blCNGE6pUOsDR4iRl0KHbJPLqRntAghn8unOZetapi/x1vvPCSgqDZ9ZbDTNCDHVpnGzTL
	VFapIR470UNRFik8Tl3IVh3Fngbj1X77392UFeEhieXxB9WItvCcgbcWS8ir1Rw+lkdMBraAzNw
	==
X-Received: by 2002:a05:6300:6bcf:10b0:3eb:6198:7068 with SMTP id adf61e73a8af0-3eb61987343mr628123637.17.1793604135777;
        Sun, 01 Nov 2026 23:22:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096d3827sm2894741a12.12.2026.11.01.23.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 09/15] bpf, sockmap: Check the TCP state in recvmsg()
Date: Mon,  2 Nov 2026 07:21:06 +0000
Message-ID: <20261102072112.4160195-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

With an sk_skb verdict prog, tcp_bpf_recvmsg_parser() copies data from the
psock. Then it calls __tcp_cleanup_rbuf() to calculate the receive window
and to send an ACK. The window and the ACK need a connection on the socket.
But tcp_disconnect() keeps the socket in the sockmap and the data on the
psock. For a TCP socket sock_map_redirect_allowed() rejects only
TCP_LISTEN. Thus the psock can also get data after tcp_disconnect().

__tcp_select_window() divides by icsk_ack.rcv_mss, which can be 0 in
TCP_CLOSE. In TCP_SYN_SENT the new peer can get an ACK with the sequence
numbers of the old connection.

Call __tcp_cleanup_rbuf() only when tcp_can_send_ack() returns true.
recvmsg() returns the data as before. Move tcp_can_send_ack() from MPTCP to
tcp.h. It also returns false for a fastopen child in TCP_SYN_RECV. From its
peer the child has only the SYN data, and the SYN-ACK acknowledges it.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/net/tcp.h    | 6 ++++++
 net/ipv4/tcp_bpf.c   | 3 ++-
 net/mptcp/protocol.c | 6 ------
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3560adddf821..23a22d70718e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1845,6 +1845,12 @@ static inline void tcp_adjust_rcv_ssthresh(struct sock *sk)
 void tcp_cleanup_rbuf(struct sock *sk, int copied);
 void __tcp_cleanup_rbuf(struct sock *sk, int copied);
 
+/* Is the socket in a state in which TCP may send an ACK? */
+static inline bool tcp_can_send_ack(const struct sock *sk)
+{
+	return !((1 << inet_sk_state_load(sk)) &
+	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
+}
 
 /* We provision sk_rcvbuf around 200% of sk_rcvlowat.
  * If 87.5 % (7/8) of the space has been consumed, we want to override
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ef2e15de0fe3..3d703f1517d8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -343,7 +343,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	if (!peek)
 		WRITE_ONCE(tcp->copied_seq, seq);
 	tcp_rcv_space_adjust(sk);
-	if (copied > 0)
+	/* Data on the psock outlives the connection that it came in on */
+	if (copied > 0 && tcp_can_send_ack(sk))
 		__tcp_cleanup_rbuf(sk, copied);
 
 unlock:
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a22e9388e0e..d62cfbf2d490 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -619,12 +619,6 @@ static void mptcp_set_timeout(struct sock *sk)
 	__mptcp_set_timeout(sk, tout);
 }
 
-static inline bool tcp_can_send_ack(const struct sock *ssk)
-{
-	return !((1 << inet_sk_state_load(ssk)) &
-	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
-}
-
 void __mptcp_subflow_send_ack(struct sock *ssk)
 {
 	if (tcp_can_send_ack(ssk))
-- 
2.55.0

