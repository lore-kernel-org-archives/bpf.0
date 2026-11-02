Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604170;
	b=LsBfCbMch+7bt+aLoTPvO7NkMs11CDyhoFFtyUC1jv9VCv4W9gJ5EhI64UNr5dYwNZ5m
	 Gh2qpAktzeiheeP6SIw4Wag8LhNPP9sUPcx1swOhrpEdN2qircSeaXj2GoZY8v3aevush
	 vgpJNN7qfE1JdYFW9/dBntzc2UgoEYnn/yP+VOHeRhpMS5az4B7/2SOMeLXuCML23Wtol
	 KDrtsEefIjJz7zTIbo60e7kWMS5L7tLMvAhO19XPY6nD41IcOmfruyEtKIoSXnEXJMIJ3
	 e5hUgBKa/1DN+w1mWSok0gWSYLV/RboCeSRsxVnFwG1ZI5iungJQ9INf6sST8lnmjSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NDzvE7/RY4XbRl2y4tH5HHBBw1sRz/QLmpS0WsHMYoQ=;
	b=yhYoXaKpQec5XTYjsOhNhqlSzcjZo12FXYT079nFixPHdGx6WsIS3zVfyif7Vq6AH5iN
	 GzhM3gqdwYynq/TxX/MBoDoBlfmwaIsITzgJvwTz+OwQVM14EOHbh5zYiJLXrrtYUAWAU
	 k6xTI73upxROSFgiORY7WvvbKXnZEtYFlWhueY28XRkKkXTwjXyoZGKw4uMzWV7q31xN/
	 ZqcVf+M9JklXEFJTX0RLWrqwBmiujy+aOp5112DDc1LgGFWMRZyucPRLU0M/iM7sJApDY
	 y0S98wjHZQSc+6UPyHrTyU5HiKptST7HfMuaN7byho9RxQczNcqVBmwbTrW0CIdt9DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fHQDVma4;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDDB606A33E
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEDDB606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fHQDVma4
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso1115954a91.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604169; x=1794208969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NDzvE7/RY4XbRl2y4tH5HHBBw1sRz/QLmpS0WsHMYoQ=;
        b=fHQDVma42emL/UWszHS+aFx4fa7rns3WRGBd2Y4N4hD1nDUOU44AqJWhTKW7ACgkrE
         gzrNO3j4mRUqueiAYvIwpQma6EmNNzPQ/cdZwXWhs6z/hEFVmSdxXsW9SWdeqXeVyyo9
         xveIB10O7Ew8E0nfpeCDNsT08t6c2NMJIYHNFkhqrlD5sxuuQqVlTa20aIytyz0BHtEZ
         hFTOm3OJIhIQ0cxVxYs0EeC+YrAchQv5EnT6nqZhEPU4GTjCOaEN/7bSZcMfgavyHONI
         deg6ofEHyOYqWyMisqZAPUymUE/Qqjgbw0Tl1/9LzJTczyfhe0sJV8AYxiM6Z70ppoBS
         ik5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604169; x=1794208969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NDzvE7/RY4XbRl2y4tH5HHBBw1sRz/QLmpS0WsHMYoQ=;
        b=E6IGD58zi1kSY6IUQVnuwrh+DKXAo/oaPiuuabTPXxQuvHW6DODbCMX/jgWRDliBZf
         UUclhnETE5lj42okgekNkT0dGAoqG0ix9tsMHatbp8pJk26t0p+cxUr3jdyIHgHwnkML
         F3Yq75NAGUPsoPy1Os71/GbFbmybszpyPSZ+J5NHvjA3cfEXURSB5KVI8n3X5SldEtIt
         dhfV37D2NNkm2hVavSBmvXjQr9a1+cq7vNY7/4lht+g27sg6lzmHVkYJBFB+HiJaoss6
         agWpra4nP6HNNKXIQ9c8MNe5DVmsuVeUEYN/uOFNULgUnEWP0KjWQzKuynF9unJNks2K
         WjMA==
X-Gm-Message-State: APuU4Z82Gz63CKH3JYcx9dq1f8I4xRl/657WwMTqgG4R26RK9qVL1VLs
	RV8hxJCF9dIPvtJ/Q23e0VdEMaPR/kwIe1Q60+wisDvq9EwTHeL+AiDtHI9bVw==
X-Gm-Gg: AYBFou3UMHFw9qsG/iCC7Unk0RMks7MFmVBYAnnutUIPA24eZ5yqPOUeZUJbNEaw/0H
	wRm7YuHykmbT4pZPBUpLH2i0hfChvCRoI67xARemPgN+CU9wJywstuz3HiFBx7AmltYgB8CjI2O
	EWtcvY6UJetT/yGRpcO1ZlhrnlCDP2wPBM7wP2f9wDHlFF5A0a+rpTjW/1fxTVhHC53g/Gdve4Y
	AYCM8zG7QfRzwx0GAs6Xpjsfb6bXgBpTn/6Tqp70VcdftgVI8l19j6iZwR0x2Ma+coMtFWSInGC
	TNQXqXTgThS/Hxx8XKt41LZ9PG4yRianMriHJaFgt0Cz4kNy5aJjLQOx56liG1m9SgSkW5l0EZh
	tRrGbzMpTGNGt7pJ6hvXyhNXRFhHI+LJsOs+XRpVlPuYZU0scszOKUSTMBeyf1Yj2PJnWBXhOoV
	y5g1/rZbpTW4fWGnsZWtpqBrB/bR3sotkQDRN1+V0UN59L88WIE2j8cUpOywWCvOgxA590BO72K
	j7qQMKUkcoqo3fxcMcKnQ1Gt5ziO6N1s4BnknSj8GHXNhzzZn54wbe8zFzv17pkdFqAdNR9oQRt
	4YjUED0UzDsLvF/WUEQyfRCjIjQxk3h48o00KbpXjN02Y+EekbnG8jXgCK2bi2luoxTAE3JbmYT
	JW79acl7+pQho5uYyLma1owjvkuAcaKJBK8pEro2G4qJ2kTIkrSAgG/haDcF1lEKmGoRQZ/ynab
	4=
X-Received: by 2002:a17:90a:e187:b0:3ac:77c8:ac29 with SMTP id 98e67ed59e1d1-3ae896f862emr6963704a91.15.1793604168982;
        Sun, 01 Nov 2026 23:22:48 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aec233ba08sm3293330a91.0.2026.11.01.23.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:48 -0800 (PST)
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
Subject: [PATCH bpf v2 14/15] bpf, sockmap: Keep the rest of the cork after a redirect
Date: Mon,  2 Nov 2026 07:21:11 +0000
Message-ID: <20261102072112.4160195-15-alexei.starovoitov@gmail.com>
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

After bpf_msg_apply_bytes() a verdict can apply to a part of the message.
Then tcp_bpf_send_verdict() sends this part and goes to more_data, and the
sk_msg prog runs on the rest. The SK_REDIRECT branch does not go there if
the message is the cork. It removes the cork from the psock before it
releases the socket lock. After the redirect it frees the cork together
with the rest. Thus the rest is lost, and sendmsg() reports it as sent.

If bytes remain after the redirect, put the cork back into the psock. Then
the prog runs on the rest, as after SK_PASS. If the new verdict is SK_DROP
or the push fails, sendmsg() now returns a smaller value or the error.

msg->cork_bytes keeps its value, thus the rest can stay in the cork. If the
psock has a new cork after lock_sock(), the kernel still frees the rest. If
the redirect of a cork fails, sendmsg() still returns success and frees it.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index b1071b0960cf..788ce08eef4d 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -544,6 +544,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			if (!cork)
 				*copied -= free;
 		}
+		/*
+		 * The verdict was for tosend bytes. The rest goes back, unless
+		 * another thread made a new cork while the lock was released.
+		 */
+		if (cork && msg->sg.size && !psock->cork) {
+			psock->cork = msg;
+			cork = false;
+		}
 		if (cork) {
 			sk_msg_free(sk, msg);
 			kfree(msg);
-- 
2.55.0

