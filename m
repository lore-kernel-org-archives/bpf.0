Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560874;
	b=UErbyVt/H1h/5GCUjEliw8gi1g1R8SJ66NbaZunJUZaq8lzxGHEcQiNxmZvQFpG4Ddb8
	 Hi4T6zGdPSdyAriFcvdRFYAtpZueFlZO6N34HeRg4Rki4TTbuUH0aTRaH4LzgAu0unjEa
	 nW62msLmsMPVUbXRKE2K2VJXEzUdty6DYnc7IfyGlgrudzWBu2Lson89wAzEiqlCWlbqw
	 uqneSvV9KfR4oIXxE6Iv7Lubd5Q8wLNy+vUwETUGuhy4y2S582mBT/cOeYryBhrsktTTn
	 QGTYMMFBAsG0il1ndcfqsLWEkyADQCjZe/pmLUAUiK9wOH58WvY1zEBPTc1B/jmYErw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
	b=ojOGbW4l8M1d1ocz7ygLxP6uZJ48iOtoc9UGO/XyY1NJy0M02/GfMPkV9itjnpezQcxx
	 bVfCBRXdHCwcaob29EhD7gKm86nyRfLZVpjdrCHk5Nbx4DdmjZ3IODuYq3JD6bU18Nxpr
	 pGpUa5hQJER9yUfv33t+R01dQNKweOpCExWHiKg6YMgQuRoINx/xPkB80xUlMz7VR8sjj
	 a8qsR+Uh7aAG1s1S0bv4XbQktOMKHtsnLqnje5ZQnm3akHpd0e5p9/U/Es2JFIBNq2XbZ
	 GpmIyUAZvBoDyeLqAMG4DrI1HXZQQP8cksJ97uo7UT1mSmgczkdZlzX43FMXlMGzHiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylgSOtds;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3BF606A327
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD3BF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylgSOtds
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so953561a91.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560873; x=1794165673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
        b=ylgSOtds+vKuQGO1SPIK0b4CWLnsS+qzZzgDEcEQL4+/c5pQDRfVVyh1wVdjYxgvGp
         NktSTa3+keIK+P2ZhO63JArzYwBBmykW5b1GMyNdIZsyWvxDPkgAGK4aSzfz+lGdKH/y
         TTzyps4007E8pNYrkJyHZW1ZDDLYBsRqRrwneSO9r5fj7m/68x0UteDtrFUTjODOCgFM
         KFD9Tv6cTYDLVpgDczrfmELzjRvVSCYu+i0R49+31HtabQd/Q7T3HdWdMq+9zxN/Hgvs
         VFjIT99QoAl+vOztR+Sv9tOXvf2owrGJw5Gi1ihgwYLe2eb5yDRUM7WY6J7jzAFHUDPd
         sCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560873; x=1794165673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
        b=O2oxidqjKfozdYpnsAmHY17Zl1ugpadLd55slhvTLHJVj6abB65eE9J+Ue5invpowu
         ZOHnCnMIx5IKZoOTLl0ikzSrFMNj2a9j1joN0z6QUvEpqnC2PfTp6d5B1xwlEZkwYpqY
         vDbBioaXj3CjAZXQezTpjTrmBmerjdhpHmq2frB66y3WtpiadUB6Wn9NiXnoJkfeWg/I
         reBNAsItO/onJPvTmxNxpotY8Acj0HNHr1bTeobM/TSPhUe0dblBFxRtqKDf0eQzL6x1
         AMTI43QvPqfH8UYHVqhGjXDJ9Gb4u1c5VHa9fFYETO0epwIa/lCO0WQzTPifRmG5BTcv
         kUYQ==
X-Gm-Message-State: APuU4Z+kyWbHavoQOyyKFI/ouvjWA7dF5NqBpwPlCNEn+nj9jZg8//tx
	+r4jOBPLB0d2M/zv5nsHDARpozp/JEqu1b/Jvf/6WQKfo58HgTNvbQ+xCi5Y8g==
X-Gm-Gg: AYBFou2J+UT5yFotbdVUx/LT5PA+71YwpdfiUzu6xfRs9BP3j9SOdQK+xO6iDPDCMrz
	oob5Oinqmfhtaq0Q5WmClJbBJmJRaw7BJ21+TbawBte4zBk5XXsztwxlAvUMYVJsIQb9kXOBlIJ
	Gp3HA+5Bf+uQY54JSc0R7+omMhOOM/EsjS5Z/0nWlof5qHlzuOqdrTygSkqrfTi6//JY3CRYb7k
	KCoC/3V41G9eagvvlRuu8rze4uBTq59g9jMRSj4o6PYxHPFkKxgbcMExXCX24ty4VWpg4r0dG3Y
	1JOn1ibFT9Hk1cU7GjTUVR3fILH3FSiqLo4PA+aVzkhdmkAKsDI2EUulV3MbinWs4DusaWDE76Z
	t07HLk/+/ytI9Ctz4vjhrUHvRuMKS+GeP6XAOR4YIw/EPqx1+Tt24kdm6oWUYAKVFVi7CT6xRf+
	FQ3UyANU7O/3lVy7kdYrEvKEB1cO3YEGAoJ0nBsEdisav0aJJQcRuSBNmebaawJqGvJrNC6iiL6
	PiWpBjr/FJvRGCR4lfalV86CYOiEIhk9v/xoaCcYc0zLWHfW2fQEZOwG22dUN6LXu2YQ+GJ8kOX
	tS4RVgyA3GR2wApU9dEmTA1PX5wi74++NdkjMn4Vgu9293uREJmK4q1DhplE0MoLWpJze8v4SIt
	QSoYCEUDVJEavZVCKhLF+kOaGfV01p4+Ogtvx8tHgpr48SF2THAvNflRHl4fJ/8ISweJHtqMLM9
	uK9tONXecC3vtDbTne5Yg=
X-Received: by 2002:a17:90b:164f:b0:3ac:9ed8:f310 with SMTP id 98e67ed59e1d1-3ae8984da7fmr7182937a91.49.1793560873116;
        Sun, 01 Nov 2026 11:21:13 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87f69605sm6059562a91.2.2026.11.01.11.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:12 -0800 (PST)
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
Subject: [PATCH bpf 02/15] bpf, sockmap: Don't let an SK_DROP verdict stick
Date: Sun,  1 Nov 2026 19:20:44 +0000
Message-ID: <20261101192057.2296489-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

The verdict of an sk_msg prog is valid for one message, or for the bytes
that bpf_msg_apply_bytes() requests. These bytes can come from many
sendmsg() calls. Thus tcp_bpf_send_verdict() keeps the verdict in
psock->eval and runs the prog only when psock->eval is __SK_NONE. The code
that resets psock->eval is after the switch statement, but the __SK_DROP
branch returns before that code. Then sendmsg() drops all subsequent
messages with -EACCES and does not run the prog.

Reset psock->eval when apply_bytes is 0, as the __SK_REDIRECT branch does.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8cf63a9e7fed..d90bcc911b36 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -509,6 +509,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 	default:
 		sk_msg_free(sk, msg);
 		sk_msg_apply_bytes(psock, tosend);
+		/* The verdict holds for apply_bytes, not for ever */
+		if (!psock->apply_bytes)
+			psock->eval = __SK_NONE;
 		*copied -= (tosend + delta);
 		return -EACCES;
 	}
-- 
2.55.0

