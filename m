Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793077145;
	b=vMJiW37z5szTGfWPY7MdOz01iDSjcp9nu7amug6enmmV8z3tggvj0Slgifv3psp/vX+y
	 a7vz8PJW5gZhJTC+u/HY0teE7S3zhbphZIWaF/Qa4EzA1EeXVMkhP9BZlOWKf94betDUT
	 wx4jEvEnrAJiI7SRC9q+YaHIU1Mg5zHruLd0R5cb1R/0DsFDsvErcSwdZehjas/NkRxgF
	 JR5JvUZcT3Y/qvWXAB2caGUf2r+rCgcc7KWyy+Lze55ZXauyNoQ0IRtW4+t5K9qlVnyHy
	 vi2CICFlAKe/HzLQrLrVUv5qifkytaTgqQxMeMbLCrkkUmtpluwR+EcTkDwL0WQ+SAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793077145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A1umM+mUhHMXhhzUaIKioVtRrS9R/R9JVZiISrrvwTA=;
	b=Zp42qtW6G70nMauAyubLY75r8P74wmTBTqudwP2oSFoTwGwa+Ey7tazVo7lzLEntbYGj
	 jP5JFvS2A0NIW9Eklu2ai8FJExS2vqS2eNOnAYAy1X+g6GGHgu4I565hyqeHV6mQAzMZT
	 n6maphPTX1xVS+GxenRk2abyPrdFjX22X/o09VxxBY+FeBbA/xOXwzib/6kDwkywxbTTo
	 cHOozsI+/dqOFwsKHdT8iFHaq7Mb3XWzJI1VPBBxlotQxOOrrEIYtyK1YiAACt+hc7Z3e
	 8QthMMoIsEzjsjbiX8G2sb8oPuxpuGJb8DaX3U48Mu8m+pf0PtkTWEiihrUUOQ14bcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=C02XwnvH;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F9606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 04:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 751F9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=C02XwnvH
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1a3c08d6928so1021678c88.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 21:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793077144; x=1793681944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A1umM+mUhHMXhhzUaIKioVtRrS9R/R9JVZiISrrvwTA=;
        b=C02XwnvHP5Ml6tFarUh5CNmbgmoB5cawKMvRnn1S5OcgBMypyeKoVWAfAojCfTVhFZ
         E4EUx1WyIthG2Na/UWsH8tKTyjn34GZZQkp49zAq+BuVbcXxZqwjAkRxqt0VTfPR+Wsp
         hPIjyFI2WWcQUgU/t7T2ePHODRoxMF4+hbNZXUJ3URiZIj8GfxD7y0ejIfLKLU7dy9Va
         k+DhV5GYniN0uln3Qye1zDFHsEFDfMCx2jXWJkxGsUryYa8sGVJYWDr6rBApnEDxrvMJ
         MfXDnb0HO1VUtCxx92a2v3RDgSD0+DWsSco+rjw6J86Pmuxa50z5m2EiNpEwyjVwMAoj
         B+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793077144; x=1793681944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A1umM+mUhHMXhhzUaIKioVtRrS9R/R9JVZiISrrvwTA=;
        b=h7T3rSrqBxGWIaAyTAyMOtJ3+oysK+AJPfGvEt3IknebIRhNZQG+gcJz1peCJgs3Ix
         VVNGd4gW2q7NtiN5D53Rd1/FMC0pAVVt5zWnhvKS3kn5I8+5PqZzxoEm7J4M8eiOf0gj
         1DnNVI3Qk5XdIizRGPrc4gW3bjt88uLzddaUH+Ni+6Y1CywZQQAtJmVX2Rb4+zhW35mD
         MpcQK+p3QqAQ1OAfJMDsozdXiGcVNSGgO9G3HaakpYSzSeGJoqetxieOkhw+ukmbBy39
         B2eOqgDEFZhQSXaVu4gSTRCDJmWUo1Hbm8DvzlfLIQJ4HnRld8kaTlb1ezXnWj/1pFW3
         h9Xw==
X-Forwarded-Encrypted: i=1; AKwUvBzuqiCDu0udSj6J/QAGBsgfK4rh9YGlPBLxNGKd9wl4Vok4eNTA/EGlQ7meDNmp9bcBxYk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIO39zKr+P9Mf4KvwUg4npKlCoy98Z25LwajcKAbP8t2Pdhlzzq
	rr8aGihBSBVOVdZkAsdiuMZu8T5z/7mhIZGVJk/bVfUO84dVuQ1zzXQGbRTDsXrWIdPi
X-Gm-Gg: AYBFou3DPKGrRsVFSo1zHyu0X3jV76N4KPxJmWrmnnczXB2Gjxu90s7sZa82TAh63kr
	NOkSS6Xtv8a8wWdY713s+fg5e5AO/j+EB36QNODqAuVnvOz8DLtCosmwjlRF6lIx3EvKqNhvsTc
	y+4pfP4kZ/Unwvu1rJpkuYGvefeNpacSObzu+ycfyBe/et9xhZO4mN8rsDrwHUK7isTXTa5s7aQ
	iZhvRgEB2oTV9djv+/NyhiWwReCnlV7YYBU/UVnKPtHtMqb3xuE6DCYJBqdhKET7skH9OEQZk85
	UvuwmcvoZPDiexW4m/Tx/ldp2Y88PTSPU4oJfvlJXo7/+aVE3AbZHy8H08gp9npAM2cJazCAZti
	uCoHTHNO7lZTFa9w+45Ntosrin67yRna9aseGaSyTKEm5qCB/agb5rRjQ0uv4mLkcquGgcOn0nX
	Ymlo74/NbD/6vISDtPCUpgN49svC7ZEp7qAmNx8Ne3dadMjbV+CcrG0UxwaJIvpL7AYAjiLLWm0
	Go+oyF7Wwwtd/6xMrjsKkUy7PuyZ3Isl9mZ/nTQB2Fktpz3607elLuStDMqIXZcoWHw
X-Received: by 2002:a05:7022:296:10b0:193:1148:64fe with SMTP id a92af1059eb24-19929009fd3mr11069310c88.6.1793077144382;
        Mon, 26 Oct 2026 21:59:04 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2001:49f0:d0db:fffe:97d4:c0de:15a1:9c01])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm28884906c88.22.2026.10.26.21.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:59:03 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: alexei.starovoitov@gmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH bpf v2 1/1] tcp_bpf: update copied_seq from current value
Date: Tue, 27 Oct 2026 12:58:48 +0800
Message-ID: <da2b3b99a2f41142acd0eab4b7ecd2210c3f4a51.1793076960.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
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

tcp_bpf_recvmsg_parser() snapshots tcp->copied_seq before processing
queued data and waiting for more. tcp_data_ready() and
tcp_msg_wait_data() can release the socket lock. While it is released,
a sockmap verdict can drop or redirect data and advance copied_seq. At
exit, writing back the old snapshot plus copied_from_self rewinds that
progress, leaving ordinary TCP receive behind queued data.

Keep copied_from_self as the count of bytes consumed from this socket,
but add it to the current tcp->copied_seq at exit instead of writing
back a stale snapshot. Count the FIN byte in copied_from_self as well.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
  - Update copied_seq relative to its current value at exit, preserving
    progress made while tcp_msg_wait_data() releases the socket lock.
  - Count the FIN sequence byte in copied_from_self.
  - v1 Link: https://lore.kernel.org/all/af73f81ba5060272e63bfe3757295fb09f5c6198.1792733621.git.zhilinz@nebusec.ai/

 net/ipv4/tcp_bpf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 2e234d155b5e6..fee7bd72cc272 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -228,7 +228,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	struct tcp_sock *tcp;
 	int copied_from_self = 0;
 	int copied = 0;
-	u32 seq;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
@@ -242,7 +241,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 
 	lock_sock(sk);
 	tcp = tcp_sk(sk);
-	seq = tcp->copied_seq;
 	/* We may have received data on the sk_receive_queue pre-accept and
 	 * then we can not use read_skb in this context because we haven't
 	 * assigned a sk_socket yet so have no link to the ops. The work-around
@@ -274,11 +272,10 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 
 		if (is_fin) {
 			copied = 0;
-			seq++;
+			copied_from_self++;
 			goto out;
 		}
 	}
-	seq += copied_from_self;
 	if (!copied) {
 		long timeo;
 		int data;
@@ -321,7 +318,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	}
 out:
 	if (!peek)
-		WRITE_ONCE(tcp->copied_seq, seq);
+		WRITE_ONCE(tcp->copied_seq, tcp->copied_seq + copied_from_self);
 	tcp_rcv_space_adjust(sk);
 	if (copied > 0)
 		__tcp_cleanup_rbuf(sk, copied);
-- 
2.55.0

