Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213236195B
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828754; cv=none; b=LSXltoj7irtq+TroCuY1jpbOy+ZjX/WJ6S5O5hqL6vzOMGoYQ9iP+y1EYoznN5kQHw9/6VpKYRrEUxMCdV7BD0BhS44pEgvgXg3bLR/Vjkpu+is/phiHQRg9RZe6Ansddf+8CqWz2nBD/Oh9IBAMd01wqI9twtaD7o6FYQCPyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828754; c=relaxed/simple;
	bh=Mhp9R0MCJnTDusbMi0FJ0eO35srlQlW9YSNrSMYga/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lCQGcMZxUuyuqQ8azMJce0w1nJSxyPo1XLKoDOAa05AaghFacs+Heiu1/fCRpXUjx9iFdeuaR5FlWp+zsSrrSngMyBvRquExx8qnnVlQeObEFtgCjBIgzX+35n4WnwkxZxqmF1YF/jMILLWYonouXqA8So9I0uKi97d0gcozfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeCerQc5; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeCerQc5"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fdc579daso18904715ad.1
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828753; x=1790433553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9LRQZ57qeaendWDYofTy5iNhQaGS0Bdj4+bJU5zeKFs=;
        b=TeCerQc5TmVIsPH4E306TqildhkF7hx/cjv2m+dPqRE4FvBaofUVvTovVhviubO9uE
         2rbMZEi7vouYQpGgUKHco5qdLl8axLjXfjKjDzOCYukEXK1tTwBfp/QJfHJo/7sQHYLv
         KR+IAO5Ur8qqo3X8IfNNl0UeN0XMeDhY+A4X3OIqN+MpXHEIngtRM7ZpBAmwL/n62Hc/
         FAWoQTEFNkNhbKRgJIg+HcXYOg8gLC/ZOFVHY0DyR2jiI68OvO06SDNDsT5kvLNDBKKu
         h1ZOvxU+T0H3pd0piaBESAZTvn+Y77aOu6+wTB2CBfRhPgr93R8sbz77mbCVGNMzf9pX
         dY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828753; x=1790433553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9LRQZ57qeaendWDYofTy5iNhQaGS0Bdj4+bJU5zeKFs=;
        b=A0uaKJSyScgfX9ig+Cwsj1Ya4NNpWx5DB3g8xci+/9m1RqosoXLtemS7d+s7DflWmE
         8zZ6/6jnAvoUfs5pUHx+RBRNbKCAkRtIQFshgO4qjtJvG0Y8NmxqUjU9457IbaR8p4zC
         70KacVeFiSVkvycuJSvcKgUH10l3mqOL49ccRIUkuiMi+PjpgX9pEp7m5ex/867t10CI
         SsKqM07yejE7JQkAYqkomHBzN/mUKAhsQh2ClENW6NwkKZ34N44X81OR7jDPlgiqNe24
         gW/L0aR8d4NplDSWZsrqo5CyEi3T13aUmelygzz/UADk5wwUodwW/TxX4IRo0Gvq6ezn
         p32A==
X-Forwarded-Encrypted: i=1; AKwUvBz4w/pEQhrRXrB+93nFL5yFLWkv2xhaXozlWBu/9kV9M2f+ewQu/vMFdsBBbEKVHtaK848=@vger.kernel.org
X-Gm-Message-State: AFuF++ljSj2JiG/hJosd9wWSRWiwj50mlRMmWfZy5miBnrHndTvShIS/
	NPPPrmAAa6pg5tCjtP3xQCDQ+rgfb6B5vw7oAkm+bAIFhCuldxUAFKFQ
X-Gm-Gg: AYBFou0GrLp/AaS85QWedU5Pxsh2GZ7pTppbDttKGcIpQ/R3Gk9/J5YOvyMyRWsQTsv
	efo7jF+1z3spvn39hirtGhYfsDofykciks1QK7LZqK2UbG0dbUAuOTn3H43tgNGMR3it2A1m5wZ
	R8V3HgYaDR1hPgs5+fH5ds35gLCeU63xl3jU+CrlbH28+RkPwMM/1ipX439TjPAAlFr0kle4f7C
	VUfsD+rhwjvM/gX+Iw1XONHXA9pBnKtCn9KPuu32jEYm2SVTyWk0kiOmZtKllBE4ME8yHQNmem4
	/B6v8+S8gaYaB5MUo3Y6iLKpQvwAElcOCTQpREQM/N2byLBIRlzfUlsMFRQgxGfUFzNrtXz8s6q
	4ItxS5K7JNOmdRN/PbpMr26WhVEYnxR7L21zPR4h7kC80uAzTrG1DnLrQZx1r//KAo49S93Sla+
	mdBaoxCVp6Lo1SNb7X2QO+RRPrCxu3OJpfQUurlCj+/SNkKL1+TbUF69udXUzFeYut+kzRELa1U
	X9hNid3MAQYA4g2XkbhN1UmLxXWrvBMw/OySA75lPq6VKj3Yx2HK+6WLR5mHUFviCKy6Gd8m5uI
	omofg4xfBUCUmWOF6bF0HrsvyiJARItnqkjLbduls6kXJIuQASq8KQYN6lA=
X-Received: by 2002:a17:903:1b45:b0:2dd:c100:3142 with SMTP id d9443c01a7336-2ddc1003253mr39175395ad.62.1789828752736;
        Sat, 19 Sep 2026 07:39:12 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:39:11 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RFC net-next 7/9] tcp: propagate the start time onto every skb in the tx path
Date: Sat, 19 Sep 2026 22:37:30 +0800
Message-Id: <20260919143732.11772-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that sendmsg() records a start time in sk->sk_start_time within
the socket lock protection, copy that value into the shared hwtstamps
of each skb.

The timing is tcp_skb_entail() runs once per newly allocated skb
in the sendmsg() loop, every segment produced by a single sendmsg()
carries the same start time.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/ipv4/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 28730a3e4473..85e3bae3569d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -702,6 +702,9 @@ void tcp_skb_entail(struct sock *sk, struct sk_buff *skb)
 	tcb->tcp_flags = TCPHDR_ACK;
 	__skb_header_release(skb);
 	psp_enqueue_set_decrypted(sk, skb);
+	if (static_branch_unlikely(&bpfts_v2_needed_key) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TIMESTAMPING_V2))
+		skb_hwtstamps(skb)->start_time = sk->sk_start_time;
 	tcp_add_write_queue_tail(sk, skb);
 	sk_wmem_queued_add(sk, skb->truesize);
 	sk_mem_charge(sk, skb->truesize);
-- 
2.43.7

