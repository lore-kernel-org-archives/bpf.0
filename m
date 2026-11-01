Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560910;
	b=dK+D1T+7PpWpmtOLD0lw4DiQFq8MVeQa4lDyjTMUnN8E8hsgzOpmzQ4yBGYMCJMLK815
	 2LEhU0SgELgjbYB/szVeWlfQPN9jbnBrgpfz8IBGHXUbqDv0fVH7iX6HdEJWvFbWq/6Y5
	 /ppTdHBvvP6yr36HEPJwRjtyu4tt7eoTG2A294a9b9qx+Fe/3G1W8BYCU2fg8pqGoUeHo
	 +HENnpwAbffSeJZDtpy9y2xlBcgUIvJNA+DwnNpi9F59I7b/cAn9L54UvViT02YUGlMhZ
	 nvHV/z7HSCTEL32Clr16natWF5O0QwS6mnek6FPP2XirZ/7dw1JQjrdj5XLFQZmPC9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
	b=iN2Wuccgx6NhffZzekY3nfAGUD5dm6UJDJLIBsP5dhbJJwYCHSnyuOGZaeREevETltRn
	 ceBJpSh7h3ln0/jUhED94mggNVjbxWiS6gcMKcykJrxUSa0TFopwC6lgq0sGpPlrn991k
	 fRUS0+aYmYyHtgveOoHMGs4g/nR3mRbeJBlyegyXzWDHjl44BcuCe7urBgMVeJ97mZN4d
	 fBwLVCJ1CUvHFBR/1J7uh8SrlGluTqKG+tsZEXAUOhEPRkX5MLXpvR80qrhMURCNDbkkB
	 SRtXkRWxepPEBDOEyjtY/nH22vX+BmmYyrf60LiEJi32zRmgjlOInWC/UBvxmIgyC5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=huBau9VF;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769FD606A326
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 769FD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=huBau9VF
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1384238a91.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560910; x=1794165710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
        b=huBau9VFx3baoQw7ZWb9BSHofqTRsVq2Mr9yK9PQ3ZMt5ZFNDqOnGz6llDw7S8hWZY
         s74SzHLpyXpMNVyyhbv6ExfwNJvLLyyw/SlOmWpUIJggb4Fn0xx63b9JoYu0e/zEasei
         FLg0wW4ecO/RU0DfTLbGc9OexWFOj84kLoIErjfzww7zq+NCtGeKMKDcJegv2zlpa9bv
         5O5EhTUAeqeb7fXn8HDRSUrqab0xv760y2xlFV4J6p5E1kcdxvHmdyjSmNqt657W6fih
         V+BQCSo671L2Xy/GussTTonaaX8KFYX4TrB3ZAfNRpliXL+kvSD4tvqo1r4BfSf9fZW9
         tOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560910; x=1794165710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
        b=1mXCsZ3WrZLKaYLdFv1yz3NTi2La/6cDFx+5ame+dOaYsvEoqmhksrV1quIPvMicok
         EyI4qmUa6p06EbGEfIGUYOlsCI7Y/Hm1mhBZ7T8se8BH/eOSFwPXKMws5LjFzqYVbUVp
         TUivnxup+pKKKAOp5pR3UQjPNr0jL1bHXDRWWpejKvEqB1hHUPHSVwMx+FlECgwxxAb3
         /brE5SM6gkoJU0v5LL3O7g2gLDLbOnXf2WNNHa/oWhnyYT2s+8LzDDMJfhC3rfAHiHXd
         7f0RViGF1Kd+BiZitV1t4sjSXQAxspKOMZlCC7Dp9YOqDkbfwJIHNLfIoLEPGS90j2br
         w9Rg==
X-Gm-Message-State: APuU4Z8uxts4Ru5looJrhUrqFzAxtGJy54eXjM2AGBCBHoJ+KfFbJ+Ns
	xP4MSJ9KyAvAm9ja4Eu++2b78alumhyNTOzS5xTiX2hS8NN03selhJqa2dvyhA==
X-Gm-Gg: AYBFou2iaaynY8FfkEAe77ElksMWflLbteZjPTkK6jBthSrAbHZlwiU2v763WJ/rR7Z
	JItImD0D5lFre+F39dkjc0QcTaHtObU6zhsQgBtwfBrCo7NUUesdwK+Qj+cD+lpTmZZEXrHJyVo
	/T9mo4bFqhYf7tOpXDxX6ksWp9hhlx11F7jzVOfRmWjCKAAqYYW3qSlLzpx00MaH20uc3U/vyP8
	+uGsmwhTg5R+1tA5YnIqGiSu55RSeb3bcpiEDN1a9LydFF0wQWLIUKkbGC2Ey40ianzacrfIKXl
	wWieYnipDCjJFfXuBd3AzkyszIIp6Pd5BtCwoXbk+HgQc+7VEzei3a/xVc+OmRZtBxRnOC7L9ji
	ESEKd2cNgOU+S+nYCNUKTkuFd7uJdws6ZZJQklLJWYL8bQMxgXS9EUlrIk4wqxdkIIPSEmEPoGN
	GfpzqzJjvS5ktfO69kKdfwFg2OIEb1NjTCvikL7IgrOCfdjXc5XVAOP8eWIKQhoSiqT+CCqhu8A
	kVNaLasMojUk9BQ44aoicC5M4/MO1vOgG5TXcUxr8QNl9gqp82dvjwD2UT2SPaXrZpRPoznAKtC
	3uhs9FzvdvCj1HsW2d4w863tKBvldsobqzJXFbwJ/IHs+5fKDaBTYwaKi79lfvVRWo5Qwal8C8v
	HDLbLzYvgy+GuCIftyBStoZUzPg17sS8OfeyZyo3FbyrDyUhquj3ibEUkd/+3BhoWe4Y57njvPA
	==
X-Received: by 2002:a17:90b:2745:b0:3ad:544f:81e9 with SMTP id 98e67ed59e1d1-3ae8977685cmr6101064a91.15.1793560909716;
        Sun, 01 Nov 2026 11:21:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aec233ba08sm1097664a91.0.2026.11.01.11.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:49 -0800 (PST)
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
Subject: [PATCH bpf 08/15] net: Leave sk_stream_wait_memory() once the socket is dead
Date: Sun,  1 Nov 2026 19:20:50 +0000
Message-ID: <20261101192057.2296489-9-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

When an sk_msg prog redirects data to the egress of another socket, the
sender calls tcp_sendmsg_locked() on that socket. The sender holds a
reference to the sock, but not to its file. Thus __tcp_close() can call
sock_orphan() while the sender sleeps in sk_stream_wait_memory().
sock_orphan() sets SOCK_DEAD and sets sk_wq to NULL.

After the sleep the loop continues and does not test SOCK_DEAD. The
subsequent sk_set_bit() can dereference the NULL sk_wq. The tests of sk_err
and sk_shutdown do not always stop the sender. sock_error() clears sk_err,
and __tcp_close() can call tcp_disconnect(), which clears sk_shutdown. The
sender then adds data to the write queue of the dead socket, and
inet_sock_destruct() warns.

Leave the loop with -EPIPE when the socket is dead after the sleep. The
function already tests SOCK_DEAD before remove_wait_queue() for the same
reason. A caller that has the socket open never sees SOCK_DEAD.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/stream.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index cb255e2a3a5d..334124d683a7 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -150,7 +150,11 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 				    (sk_stream_memory_free(sk) && !vm_wait),
 				    &wait);
 		sk->sk_write_pending--;
-		if (ret < 0)
+		/*
+		 * A sender which sockmap has redirected to sk does not keep it
+		 * open. A dead socket has no sk_wq.
+		 */
+		if (ret < 0 || sock_flag(sk, SOCK_DEAD))
 			goto do_error;
 
 		if (vm_wait) {
-- 
2.55.0

