Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814232;
	b=qKId6jvsiga65a9pTpkXcvaANnthBa7gVxpAtT5SuC6XCz+9Yvi08Z+crsKvq4fZCyNQ
	 0iYDHPcw1o/0B2seCaPzu7j3LJoZNpyhxDpZdQXlUhK1dz1orktBzYAgfgA1xTm6XrM2Y
	 OaIcw2K2sjnJ6TtRZ4TgxMtJQnakaDmEMuvOk0R12g7+xkZwe7a9ygreiE5p9n41NQlDh
	 27eX0olVHJBCkujHJJC0NUA8FZ+cYhYD7f/HLp2RAGjcxq27ktUNGSlOcb34zuc301h5F
	 rKarujlLWfuRu/CImUisb6ABvS7EBfKwVg+m+gTklFfIWrAJ5T812miDHl5iOoPRtzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=qf2hRKhFhKH70S6KxPnT6SQuFQWB8KH6vcovfBYK69A=;
	b=QDVUIpZSTIKnkzdvo6UE382ffk7O/MZTXkpMYNwXhUA0HfBJQZDyVU9E6EuSiuFdtCGH
	 bz6YS+BMJJsoLj9idSRtZcxqNZJr5Fpz8puLlLTFOreMk2EtQWdVPxeBD0H4s8kUX16h3
	 RhRLFxaoiaOpSeFKvkD9NiDAdDE0rFcfpTAFXFrlzjwipWlvoIv6EZI/JKUE5K2dHtzs4
	 dPcV+Y7i0uKYheMQaaQKOtIOcsPN6MeR6UJ6TCZBaqAzLJ8QH++/UAaG2ffZMRqtID4zV
	 Zdn3pE7sDMB6fQ4VmehpHjoPr2ztgsICNC2iTOcahwFth3FEFOzXEpTiYWyBOMzKNSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Py9Jmxz7;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA15F606A31B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 03:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA15F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Py9Jmxz7
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso849600a91.3
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 20:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792814231; x=1793419031; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qf2hRKhFhKH70S6KxPnT6SQuFQWB8KH6vcovfBYK69A=;
        b=Py9Jmxz7V8E4vB+2bbuLbiddb4ALSjWJ4Jn1EHjNEItU2bPdw37aJnkI64PkxHX2P1
         Wl9MMxXB4HK0qUVpYORaaUBt9i0XS5WPLPRi3ZWDol5LJVGfDbDiggQxDF6ifeRfvRrd
         oPlij3ckMPQ2QXhnQaUm+MRNjkreGIvEqI869YkeDPS5F3T0kPxvk1+Br6wIhn1ZTcpt
         +TssZRTe9Sr2FHGRblCYaakqkhwFLKvaOeQEb2xx9SUJAGCCYq2dSxpdFndeIEX680ak
         L4m+aGIIb+6PoZGhVUT49DKk0+C5sAy48OHlQSRKZdPLeBN2PbGKmEvEKOb8u8ncxENm
         MhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792814231; x=1793419031;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qf2hRKhFhKH70S6KxPnT6SQuFQWB8KH6vcovfBYK69A=;
        b=GehhcVuX9bhZyPXVcsQH9dlKSQlAI7gyYRJRavC/XIDNkXLZYf2Z4u30CaohzltTg9
         neFV9UEhEDhibbhJMhkP6ElUfDUeNGK2/UGaSOqarPlK/TzwipOPgEsAg3u5H1G7mkQg
         TyMHdACLpqCtxUGvxa0FWe/iqyFRawHnKt0i849+jF5orRF5/zriYAX0VH8CCV2oYd+7
         jV/vSeBuMp57h+RfWjyY+dj4d2cz3E0Zs45QTI0ruhvsiqAQl7CVbDJxklliEU2S9klU
         1/o5ztO6kpFknZSr9GSywTfiwccBjyvVnHGKtqamKTMUHN48ieD0Dqg0B/EcMWFNQL8e
         pQ7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzZ7kts/ZH24zBkCmsYkSkXKnFhvisVQhF9XT53t6L1X5qW3fA9re6UxA4sv/e4ZZ35APQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYEa/ztbvR7GLJh5diBLbWCjc0dKPPZhfvn20aok7oBHlxlMHh
	UbZ5ToQ3uA51fmAw8D51ijtwjWJCdCpkNf+Xq/DcJuToAIi3cU+Zt89h
X-Gm-Gg: AYBFou0SmqTlfKac9Xnq0JGrchxkwBnYwk/RqwJ9267pO3cyD9AJzltFLEsdxSgwtYj
	2GNu4eCiV6MKXMZ4ELBZgNodmyaTkVy3MDuTLRMkWx3jqVlkOfOS9Fp4cWT8nPnxwtP2jPFM3QH
	+HRlLg3liiK38teIZYkRjCO0fFGAno0d7QjT2TXlkHxxomMwzUr2lSIiqyO5UgyOz3ckLzEbHQf
	73w74gqdm2K1zot/Lu4bQXtwZ18MvmPppZAYN44VEmVrw3MrqBRnq0XrANQefq1zIHdur5iCLuv
	ZM2pITjmU3tHNctFEOyAwD/o7/PBB8A5bzaxo81ELrUkLfcsLJyPz2ZAcsg2kkllthLKkAVu/w9
	7mDoxMD+IsfAmPhJnYnYiaWyfGIcDFCp6HqIzMnZosmnpJ/gfX/OZmC46gIFRSTIsXKJpVknEmf
	Dk4SntqaMBmXo1Xnw1xon4cX32OJrXHzWDYQo2p2y4Suc30eMbLVgK1AFIJQqHej/AoB/Fs+pom
	Sk6/y5ZkuSwNVcPWcOfvWCbTpMv0KhYIV71mOecbtW/BKZqc822aDGdeNlFxS939jcHWZBRtW2X
	49HoGTtWsBzXXIKztsRaQ0jQkSIN+79S8nduz7FySRdQ2R5qtl2QUI0qGTFZ
X-Received: by 2002:a17:90b:280c:b0:3a4:a592:4cfa with SMTP id 98e67ed59e1d1-3adeae6dc11mr937549a91.45.1792814231151;
        Fri, 23 Oct 2026 20:57:11 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebae7f3csm917288a91.3.2026.10.23.20.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 20:57:10 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Oct 2026 03:57:09 +0000
Message-Id: <DMCRLR5MNV8U.GS7VU9KHKBNG@gmail.com>
Subject: Re: [PATCH net 1/1] tcp_bpf: sync copied_seq after pre-accept data
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Zhiling Zou" <zhilinz@nebusec.ai>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Cc: <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <edumazet@kernel.org>, <ncardwell@google.com>,
 <kuniyu@google.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <horms@kernel.org>, <daniel@iogearbox.net>, <vega@nebusec.ai>,
 <sashiko-bot@kernel.org>
In-Reply-To: <af73f81ba5060272e63bfe3757295fb09f5c6198.1792733621.git.zhilinz@nebusec.ai>
References: <cover.1792733621.git.zhilinz@nebusec.ai> <af73f81ba5060272e63bfe3757295fb09f5c6198.1792733621.git.zhilinz@nebusec.ai>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Oct 22, 2026 at 10:46 PM Zhiling Zou <zhilinz@nebusec.ai> wrote:
> Refresh the local sequence from tcp->copied_seq after tcp_data_ready()
> processes the pre-accept queue. This preserves progress made by the
> sockmap path, including when the receive queue could not be fully drained.

tcp_msg_wait_data() has the same problem.
sk_wait_event() releases the socket lock. A packet arrives, the verdict
prog returns SK_DROP or redirects it to another socket and tcp_eat_skb()
advances copied_seq. The reader wakes up, ingress_msg is empty and

    copied = -EAGAIN;
  out:
    WRITE_ONCE(tcp->copied_seq, seq);

rewinds it. So blocking recv() leaves copied_seq behind without any data
queued before accept(), and tcp_recvmsg_locked() hits the same WARN
after the socket is removed from the map.

The snapshot is the bug. copied_seq changes only under the socket lock.
Just add what was copied to it at the end.
Like this:

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d5fcf3c..d85fdd5 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -227,7 +227,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	struct tcp_sock *tcp;
 	int copied_from_self = 0;
 	int copied = 0;
-	u32 seq;

 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
@@ -241,7 +240,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,

 	lock_sock(sk);
 	tcp = tcp_sk(sk);
-	seq = tcp->copied_seq;
 	/* We may have received data on the sk_receive_queue pre-accept and
 	 * then we can not use read_skb in this context because we haven't
 	 * assigned a sk_socket yet so have no link to the ops. The work-around
@@ -273,11 +271,10 @@ msg_bytes_ready:

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
@@ -320,7 +317,7 @@ msg_bytes_ready:
 	}
 out:
 	if (!peek)
-		WRITE_ONCE(tcp->copied_seq, seq);
+		WRITE_ONCE(tcp->copied_seq, tcp->copied_seq + copied_from_self);
 	tcp_rcv_space_adjust(sk);
 	if (copied > 0)
 		__tcp_cleanup_rbuf(sk, copied);

> Link: https://sashiko.dev/#/patchset/20260630205043.184894-1-rhkrqnwk98@gmail.com
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260630205043.184894-1-rhkrqnwk98@gmail.com

That's a review of a different series.
Drop these tags.

sockmap fixes go via bpf tree. Pls tag the respin as [PATCH bpf v2].

pw-bot: cr
