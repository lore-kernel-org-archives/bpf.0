Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604150;
	b=Us6ESUIgLLLc2VuI1w155JSn0Ov0G6pt+5ZczX/tmq8+VjCmTNSGX2ptGgqNvA0hN1Ao
	 qTusCVVFf7ZmkrLKC29hsxq23kPMQX8VFbmR57lbqp6TwtSGyAqtvVE5cz4MSehzOrNW8
	 RMkyBn8nKKHDSLLd544SQQHriRwrSyeSC2Xi+QSiEdUaTNB3CAL89JL7x4n/VR84YBPhZ
	 xv3M4MS8hZWhDeIBi1HTeiWx5SaPR8S/2jYFnTnNsxyQl4kFAA73mGvoSHFuY5o31euhi
	 s49f7JAlBRCcr4lLRl/UwkdDfu/VY79chjdTznXg/Z2CD9u1iXAp5mSfVT1qMuE9utQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9Zt7GQo7rKWxtj60oDqSl5MgB+Al+Ojst9KtoXZQtmY=;
	b=YeAyBaOnJryBuDb3jlpo8d4b4oNWKQ3NK83AgrZLny9j+Zh891VlLJzw0NykjRi+4o5W
	 JXxwNrom79wlIHyWJRR/W2LXBN5M7yjpzT4X8TzKJmd1GIzEam/8l3z9uLSeBCzgSA5Vo
	 bOFQseD9MxxjHFXbMgfXleSXwxPYJjDeF6Wn9z47EDL2ohVhvvkMTOOiBMaS082gUMXxn
	 Tezg4gneRFVOnZ0Gj+5ZEOkmwo+tiu4c+Kfyb0TZdNI1omV+XA4u4nPzRZnKRX2f5ypxI
	 DD5ABv0csNbay0Uot5WYu6pbwuflP+E3A0QU8RBxf2sLn+iS7jhGsZIUTps3Adhv7mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DgZwYw2K;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A6606A32E
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B82A6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DgZwYw2K
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a070781f63so979720b3a.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604149; x=1794208949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Zt7GQo7rKWxtj60oDqSl5MgB+Al+Ojst9KtoXZQtmY=;
        b=DgZwYw2KbwxGowmlJVT8BaD/23fNgzAst5CdFAGisZiRKr5Pr0NvdqBs3NsjzXYC2F
         MUBGjMpedoXAN70Z7ynkiOhfr0N5nA1GvMBgzGXr4GP5aHFYF5tOySTCIHuJjbMAQ5tI
         zXkB0496ArVjUGKgcdB46i9KL8yTpMSNDcM3Gki9MZg7ycTRYMWpVKbEJP6BBFuEVnQS
         A0piu4Tk/7+9ffaJkYizv3h65HmpSkJLW5COx56yMryhtPE32702meD/84uLGYnlXIkv
         S9BvuOEVsBAOlIcEwgsWgGQPzGKK2KpWtRuFHYipQkkDspdJAaxOcgGMxc9Te8pjX8Vk
         s7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604149; x=1794208949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Zt7GQo7rKWxtj60oDqSl5MgB+Al+Ojst9KtoXZQtmY=;
        b=O38HXypBjHyVVQRX4drxfCAU9jiGUBPqWGZe3KW6yYSzbIAFXIeH2i2Fe4zu7YAD4G
         YUdwRhfAzcC/vh5n7yTQZEzLmrIoL5ASrtGUxnSZFY7BVNZoAtio+aJyJQJQxFvNYJjW
         oFSl9FW0JYJ2RayRxF4lKAXgUMmE8BWj1r7Mxte1vszyBg1JhXrMJ4OD/st/AqruLJ61
         mlmVONq5hIAAIL+WUW5bsHXDItLZgSZUzl/t0F9/LqN0RtJ8yigQbckLr2FcS+zPOra/
         Eea3AAJnscrebjlTsXqxWIWMfaDZe8AYnzOGbxgJH9KZI3STPdu+c8EOpZqs95mASVie
         /JIg==
X-Gm-Message-State: APuU4Z8c3DOQgFvr4K1prf6oHh/K3JdzTWvIVgTL9+cxqNUlXEmWyHMK
	GgnY1UEwOy5VyvPkTEwf/qTtVu77qSRlc0uV3EoSajeIzfIkHjJDhQp2HtUZow==
X-Gm-Gg: AYBFou00OOCwGFcv0CYJQlRp+BgB8O5B3tRyWKHwu1jcXmDa1S94bBGkdKHUmcpwewV
	S6ggbrwLU/JGBJlaG1tMV/fVcp+QXwc58kd7eejlu2T/p9C8OCC9pNZ0yN7s6FEt+Dcz3aIFz5Z
	34xk0qDj41rlXNrw9MNexLXKlKgLxA6hAqzKjWAgT4EFVHAzFfgPuY6D8zXNEpeQtSedlaa721h
	jjlmOZJT6jZEniW24c/5Tbiyd+KrGy0+7o2dT67b7SS5sN5JWfThQylFPjFl45kKcB4ORL82M39
	wzC95SuDMFkYOkmcCYY+xBB+vg5qOM2JCvUiGUAiElWgbmQtX7Cq3ywsw2XH/5oMHTNNz3Vcw4T
	hOvmu3qi+9+ByrwzQYc+XKAQqimxKs81ExWIbbt6KsL71Q0RrRPD0X+zcY8wfZNxqkXn4tHNGNB
	PLGuZ8o2GIemEP/eb9W/204QAlzUXkXAaQv7GdqFCQBZ6EZJJd9gycdLESU+q2LPcbCVQMp1/7y
	7PtthDzkbenroahhlh/wxzvqGXR3/Vf0Qtsfbve2hfJu9OvkZmp+PvJtoLTLeJnxa41HypVQlcP
	XpOvS3XEXm8wRsBElZf5k0rwZhf107OB39hQ4rxl6LVCUmak9R71lxknw/RoufiiAPDMbz/fUP0
	OasgtnADkUpz+ODt8G2UjjWDtw5tXZHxIIni9rq7LE77+/EVLmrORFafO7iclHZdnbkoMX1b1pg
	==
X-Received: by 2002:a05:6a00:a215:b0:882:2195:5a6f with SMTP id d2e1a72fcca58-8a9bf04e229mr7517325b3a.43.1793604148654;
        Sun, 01 Nov 2026 23:22:28 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad7707ed0sm1659597b3a.4.2026.11.01.23.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:28 -0800 (PST)
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
Subject: [PATCH bpf v2 11/15] bpf, sockmap: Don't copy 0 bytes into a full cork
Date: Mon,  2 Nov 2026 07:21:08 +0000
Message-ID: <20261102072112.4160195-12-alexei.starovoitov@gmail.com>
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

psock->cork is a ring. sk_msg_memcopy_from_iter() writes at sg.curr.
sk_msg_alloc() adds room at sg.end, where a full ring has a spare element.

When only a part of the data fits, tcp_bpf_sendmsg() copies this part and
flushes the cork. If nothing fits, it copies 0 bytes. This copy writes
nothing, but it moves sg.curr to sg.end and returns -ENOSPC. Thus sendmsg()
fails without a flush. sg.curr stays at sg.end, and from there a copy moves
it past the spare element. Then a copy can skip the first new element, and
the peer gets memory that nobody wrote.

Skip the copy when sk_msg_alloc() adds nothing, as tls_sw_sendmsg_locked()
does. This pass of the loop flushes the cork. The flush empties the element
at sg.curr, thus the copy in the next pass starts at the first new element.
Now sendmsg() on a full cork does not fail with ENOSPC. The prog runs on
less data than it wants to cork, as it does when a part fits.

The first Fixes tag is for the -ENOSPC without a flush. The commit in the
second tag added the spare element. Since then sg.curr can move past it.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Fixes: 031097d9e079 ("net: skmsg: fix TLS 1.3 crash with full sk_msg")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d534974c33f8..d8e29b09818c 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -619,8 +619,15 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			copy = msg_tx->sg.size - osize;
 		}
 
-		ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
-					       copy);
+		/*
+		 * copy is 0 if the ring of the cork was full already and its
+		 * last element could not be extended. Flush the cork below,
+		 * and let the next pass take the data.
+		 */
+		ret = 0;
+		if (copy)
+			ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter,
+						       msg_tx, copy);
 		if (ret < 0) {
 			sk_msg_trim(sk, msg_tx, osize);
 			err = ret;
-- 
2.55.0

