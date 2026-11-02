Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604104;
	b=k2rJXBTNPF5l465kMmlN0oi+izE3purt/gEcbRMoU0JI6G8qQzL21dx3oalTfheLUmq9
	 l/Ojlgotbq7mO8KJ6rBQyXXrpWv7rEi7tDlcGrTiemCXmu+v9VAJ3A6y4dZ34Ff7Amekv
	 lIIv5woQRy4BtcrSqm1Xy75bb20YgszGsbQ8X5bChZmXiCbf4onp0KFCNnKPZo/WMk0U+
	 p7vkAFZWkEAcwJl654l8+QcemFOeOGjyCsyv9p9Gh5VaeXH6hNGjiri6C/aX9P5qzKO57
	 B2Wd53j3My87NqwruOXw+eh54nG2VxuW9aRGxbPBR/79q+YjdEzOBQD4v54d1PvHh1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lw6EOCCC6sbUctDXo+tERpXOU4fD8zFY96sMocjjruQ=;
	b=0r2v57GUJlzZaKmAeZE2DHW2n2Q/MYaPYoCQRzcgyIa9qTgdxx02z0H9MUYtixj5T15c
	 kqBHOhl0F8OKiQIu23k/Z+JqbtzKrn8Pz0cQlxYN1gF+beBaSxMqHOHDHakjeZtUU/Tze
	 9Afeq2H9PRFzGhaOQzkfg7ejPLaEQyCWHkQOPnSPssGxZ3aG2+yk+7sM/SLpLACfH41O2
	 nK2F4ehESaZUek6j0uBHYTEaEw6irlkdoq4YQIbBvurYAcbkhuWymdLRboRuu6r3oLU9j
	 4j6Uj9PHi9yDcCQee7ZX8BN+6SQGNNk6SwgSj6+/YE7Zue985KGPe974T3S8lM3fh6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UdU7K/zl";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50F606A32E
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA50F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UdU7K/zl
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so1896371a91.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604103; x=1794208903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lw6EOCCC6sbUctDXo+tERpXOU4fD8zFY96sMocjjruQ=;
        b=UdU7K/zl7+AfYut04J2RYdwN/ElOPqf7v48tRRcqux9UpLJONFqejFO1m+Wr99ltvU
         BHe6ie/S4nOi1B1EbNXX+f3V/4lyKdddQC2Uba8BnuaoGLvZm5PasbW+2YHdUGZfnSEj
         PicmQbC/ROQCoWPof6Nc/fQFxB1fse3XkRwM8lk0h00M6ZJNjGxZEesPi9rzIRH8zq/b
         waJV2CqBsLsZmYFeTzvs83oFrL7RA1YuHFwOiArQA/Duej66C5LmFS9SeD+6Pe0/lhC6
         6W7iKB6N37dLyhdHC/il9yCqk0fZRVmt3A7Wkc2y6XBUbD2IPSkUulrJIhkI03E1CZD9
         4BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604103; x=1794208903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lw6EOCCC6sbUctDXo+tERpXOU4fD8zFY96sMocjjruQ=;
        b=ZMK76n7aP/C5Loz6BBOX2Pk4hduKMuFsHGO/5iZ+iSK1B7UOqmlZac2MLO8a1pbeXk
         m+sZr3GlfhbdWRKhXj+i/Zmuw0SjPMOuU1QVZnb7OFlSYQpF9hQBD/V//D8R0noAcpd7
         lMJ7Kbgucrd6JwRzI1iwg6dncw18Ze9EWNAfJOBAb/irmK8Efsib3h2AF/HGc23CxXbn
         eBPeZerGEZ/cgGu9mgeZkq6A8cVAO4JMJ+vGTbWaimsc8QwUCq3XKw+h4YpzS1azLiP2
         kJFtQzXZipvQBWFWgY1VdE0jXFjqFCKcPDnZlCB6p1Stzd4xu+oPyuXJ8gdqTLRCkWDu
         bFGg==
X-Gm-Message-State: APuU4Z86i3RPvD72zi5TWN6ZoDbsvxvW1GLrrPVRNv4BuFmnep1uC5oy
	iKAnxqKXL8UgEvfZqCS8VzTuGOksjDrO1dDfUJ+Q1azP6QY5qS7la3VgVOI9Cg==
X-Gm-Gg: AYBFou3WW4mEmrnWFqc6EIpAmcKGkEILyxmgTlPvGtDZugfyJJErhPMzCbHH40e77EN
	RRJp4Se9dzPuGt0uvoG7P1JmJsb71EEHtEJURQgdjme/1s2sxyah23REPbvM/98GlO4c7nJBH2n
	jCyNo+9gTrwj9D3CcZQow5PNnx5BoT5t5YWl0BsBZrXFeCGDnZnyhFL11NKkxfJgMZdzbHL22Fd
	rAXZl1ehDcv7cuuEEVGUUtldf6UlFBFvcFFtwccZzvdlUJqyZidG33nQ+l4F8XmrGYuqgk64BaC
	DyBxlR+il0/A+9/npkZcz0P4/cshUPZB1CPXoHEvPf6gj96Ehb7rlNVv9p94JsmO32O2d5ifPsP
	yJ0/SrO+dU2+BveUe2kaGCYZorlYi+RCzFk8yKdLcoMgUQvdIyYAWABNbst9CUrDlwI6+KCQfqE
	qcom4hZkomnh1zEMxcbDRKtUA9wuo1Yw72ESoIhOpyPQi7CMPnnH+G8mMy3gc26B/Kti3OtV1CP
	aC/rnakRf98HHZUsQ1wNeD52iza3KER+owk5G7Qau1ULM7i8u3CunWOMQeK3aIL/SoSEfpN5WDO
	LI5yJr7dGcrLdF8qdei9ffgZRZqvI26s+U+0L0g/+pHxcz7DRr+y5RC8GLD7aanEURA7tJXHjgz
	sO09ycKZJAl+dr7i1gCNcjHIW0Q33hMfwZgd23SY1KhMtZzeOJ5Ayb02emSPV7kCQAabdijkfOR
	g=
X-Received: by 2002:a17:90a:dfc7:b0:3ac:6e91:3f1f with SMTP id 98e67ed59e1d1-3ae6f00cccemr7838997a91.37.1793604103048;
        Sun, 01 Nov 2026 23:21:43 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09814cb9sm2753697a12.24.2026.11.01.23.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:42 -0800 (PST)
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
Subject: [PATCH bpf v2 04/15] bpf, sockmap: Subtract all dropped bytes from the return value
Date: Mon,  2 Nov 2026 07:21:01 +0000
Message-ID: <20261102072112.4160195-5-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

When an sk_msg prog returns SK_DROP, tcp_bpf_send_verdict() frees the full
message. It then subtracts tosend bytes from *copied, the return value of
sendmsg(). But tosend is the number of bytes that the verdict applies to.
After bpf_msg_apply_bytes() tosend can be less than the message size. Then
sendmsg() reports dropped bytes as sent.

Subtract the number of bytes that sk_msg_free() frees. After an error the
SK_PASS branch already does this. The SK_REDIRECT branch does the same if
the message is not the cork. Nothing changes when tosend is equal to the
message size. Otherwise sendmsg() now returns -EACCES if it sends nothing.

Fixes: ca70b8baf2bd ("tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index b016aa419fb2..36d1bf46353a 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -521,12 +521,12 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		break;
 	case __SK_DROP:
 	default:
-		sk_msg_free(sk, msg);
+		/* All of it is thrown away, not only tosend bytes */
+		*copied -= sk_msg_free(sk, msg) + delta;
 		sk_msg_apply_bytes(psock, tosend);
 		/* The verdict holds for apply_bytes, not for ever */
 		if (!psock->apply_bytes)
 			psock->eval = __SK_NONE;
-		*copied -= (tosend + delta);
 		return -EACCES;
 	}
 
-- 
2.55.0

