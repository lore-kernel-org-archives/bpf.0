Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F2360EC4
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828741; cv=none; b=Mq/e69A3JtI+qiecc5P9zsOkCfsPchcCL2WGfbM1MvOYbiJ6x2F7fepBlcXVGVNsP3St5IdDzM+jOhE/Vm4vontMdo0OtFLPwn/MumkdQhtL9WKq/+3n8Hl594+yAYOJgIpLxFRLxffsz/x+Qi24WbY999K5khfkhHGZlXuIedU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828741; c=relaxed/simple;
	bh=av8t/T6ZS5uCE/nEyR9vVivlj8OSsiMscYwP23L8oIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFL4SzyKQKfaMbyVgmsh6v9LxsRfMLniQKBFDwgE8pnzzZVUPEbNhbiY/Byjj/IAf+px5qACf3dO46Ucp7E8BlWe+6q4NrtjWnaaRuu3T1gZkS7siJDDoU2CsDVoJVH43O5YuCp81PsqNKvB5cRLAzqGLIdPk/+7rscPBkh/me4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdBd7JFg; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdBd7JFg"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed1368so21494495ad.1
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828739; x=1790433539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mg7vwSHdpgkjHuAuSf6HmJMBzQg1Mbs7T+3qFylATrw=;
        b=gdBd7JFgIWkdZvt42Vp6+76AsV3stf6PB10xc19jamFxAZiJwIIUw/O3TiHbO0FmkG
         x9xKyHu8X0NhN1/GYSB6+5bRI1ipGv4/E9aohY/jd6Y6i2qantHU+iiE7u2Mi3fYq3Au
         rHVX6BBEBDjMrSoBK7+gTKiXWur9DTQc0gjzumYS0WUCytmernbI+8VUazwFIHSB3PBU
         lwwCR1WtgjhTPtrtvJRPNuSr+jIW3ghFMPWrk0NpvevEDnCByDFCsQ768Fj6IPQ+kDUy
         rsKiPz65bVzjd0jwatMLq2AgyW73YMqKVqwxexLxXfU1H/lT+EVLc5DNdlq7g1tSlby5
         c4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828739; x=1790433539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mg7vwSHdpgkjHuAuSf6HmJMBzQg1Mbs7T+3qFylATrw=;
        b=tQVmW0Ca/vX1mMo+63p9gkRE8Ix2X5YB99L9WvPACL12vj/uaZ8uci+KXxRhzC6h/8
         M7nGLVGQZX7PrUgw9WsoErSRHXDpNSDrBhE3exxm0q9sUbl6bXx+ACRS1fobzWxGF0fC
         pwUAhEyPWCxPqkYvKS4fXr/zIvcPSpsZGyujtiWqM/bUJCERJDB08idL9JsfIr+2Ch47
         awnhhDJMjWj7o7x/CZBRnHPgrvuralUgvxb0AGQ88AluHOIEGC2ueXt/P3lweJG5fUV9
         zYwvCs6fXR+DNIGrFqKjpWKyLcw45E1c+279xQnqvktLFIXslYKfXuRQXDlmjMT/aveb
         A+fg==
X-Forwarded-Encrypted: i=1; AKwUvBzHUwJypoFYZC4qPRWRjdKi/UzhlnZbYlZnSdhVEi13xsDZtV9dG5oLVxTa8WDe+CVqqUc=@vger.kernel.org
X-Gm-Message-State: AFuF++nYaej7jossvGDA3jg+gbz+834QbkiVWL1uC9OAtWrUs5tkUbEn
	+w2IBpiZQQNcP33s0YcFt79/v9AdcxYVpJh0p8I/ZUPq44G2oov1YZLp
X-Gm-Gg: AYBFou2jHJiBZ4y6rvFhRdkrIPsJPCfVpx3n1feu7JX0ERpoCTVk87YtCSsrTqtscQ3
	QX3Zj+FvA/Y06cdFs/CNG1EdAItHN4jQnEH2Jyd3EQR1JQHRGcOirRDo1AJZP7Us8Al+vys7ViC
	zSL45zRrUaArPdcV+f5JE8p8QrLDhNLDImFal1NRbI9Dmbs7Jt0uRXem6YCOV5+dpUtVIsfCDZA
	ZKwCGzI52ULxoITLAp6P4UoZjO7hLrlIs2v1K8+/ObEW937cymYIqtG+NHh3uEeWG5uBqiD4IyF
	apterrOpBZ0XWfoMYn+eanfQbEKYNtERpKVaSKJP/9XOesT+8ESmiIcvPNMChMtLVH4/T2b1MxW
	bade0JLqZH2RF+jKpQtF/DJgDQeqJjVqk480jV+OgETP9PDGOwoMHBIb0n1dQHucFQza9zaRA9P
	YgNnzVANVif9F5BIpcsx3jinAGWEHCr4yG9WSzh/85aC/S0tpUoEt0xRAwxrnc+kRjpJTzwhbv2
	T3E0D+WbWot3NqaXTKA2XPYvLnM9wvovzcB0VAzE8p9h0M3vr8oijgSeZRMsrPaU4/Q0cLhx6Jn
	OqxvW46MPpDMOt22gLvdHzfDQy27UgpBHjoyn34Jf2+khlcK4Ar3j9K1Wd4=
X-Received: by 2002:a17:903:1112:b0:2dd:c053:c20a with SMTP id d9443c01a7336-2ddc053c2a1mr41919155ad.38.1789828738993;
        Sat, 19 Sep 2026 07:38:58 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:38:58 -0700 (PDT)
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
Subject: [PATCH RFC net-next 3/9] tcp: record a start time in the tx path for SK_BPF_CB_TIMESTAMPING_V2
Date: Sat, 19 Sep 2026 22:37:26 +0800
Message-Id: <20260919143732.11772-4-kerneljasonxing@gmail.com>
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

Add a new field sk_start_time to 'struct sock' to support different
types of sockets (TCP/UDP/ICMP...) to record the pre-set start time
value and then propagates it into skbs.

Start time might vary across different protocols, so for TCP the
patch picks the entry of tcp_sendmsg_locked as the start time because
1) it already holds the socket lock,
2) it nearly reflects when to trigger a sendmsg syscall from applications.

The value for TCP is a real (wall-clock) time from ktime_get_real() so
it stays comparable with the timestamps produced elsewhere in the stack
and can be consumed directly by a BPF prog using newly added
bpf_ktime_get_real_ns()).

A later patch copies this value onto every skb entailed by the TCP
write queue.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/sock.h | 2 ++
 net/ipv4/tcp.c     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 51185222aac2..782ad5fc8ff5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -314,6 +314,7 @@ struct sk_filter;
   *	@mptcp_retransmit_timer: mptcp retransmit timer
   *	@sk_stamp: time stamp of last packet received
   *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
+  *	@sk_start_time: start time recorded for SK_BPF_CB_TIMESTAMPING_V2
   *	@sk_tsflags: SO_TIMESTAMPING flags
   *	@sk_bpf_cb_flags: used in bpf_setsockopt()
   *	@sk_use_task_frag: allow sk_page_frag() to use current->task_frag.
@@ -552,6 +553,7 @@ struct sock {
 #if BITS_PER_LONG==32
 	seqlock_t		sk_stamp_seq;
 #endif
+	ktime_t			sk_start_time;
 	int			sk_disconnects;
 
 	union {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b4237d0e994d..28730a3e4473 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1129,6 +1129,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 	flags = msg->msg_flags;
 
+	if (static_branch_unlikely(&bpfts_v2_needed_key) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TIMESTAMPING_V2))
+		sk->sk_start_time = ktime_get_real();
+
 	sockc = (struct sockcm_cookie){ .tsflags = READ_ONCE(sk->sk_tsflags) };
 	if (msg->msg_controllen) {
 		sockc_err = sock_cmsg_send(sk, msg, &sockc);
-- 
2.43.7

