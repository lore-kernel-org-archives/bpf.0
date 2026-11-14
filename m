Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794657165;
	b=lgSdDhkZ33Rs92Bn6mJQjr577EZ/yfWZgQpTGzXLGiPX4RUW0bKECSCi+C2rgwHYknow
	 HKJOGX43kqJjnAebFkHPvwMwvev5y1iPf5Pbp8J89Z5aMYH2JyRoOQJ7pUkAYdRBs6PK5
	 UDaXJh7RNsaeveqFZusFGzBPYDSLVyLdZifQkFKDTfpdIsobGHriy6P9/WeE+514R8WHB
	 tSM1TZdYyHHU57YD8eHJ2fD6eQu6aaWgR3X3AomRxl81/Kuf3SCyqmXajc5E217nCyHCB
	 tv8k0x6wkhpY5HE/Da3tPYVlUSvz0dzrpAktSfQgiG3QJhdTx3/5kzPIy810oxBvvHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YRKVGMHjS3p2r84erkyfVinxVv6si0HhmgQIB1esDbw=;
	b=a29miboWAChENA+fLUmo7BLpRRpaoLETguew6pUjpPAtpgoUKyzKfZxBw185ynhxLO/M
	 h5ZM+UQ9LO5MffsaznG+lS0vJ1JF1Vq0BPzpBfz2b+msqlH4X5DID6352ch0bGeWT6X7+
	 bmiYtxVKVGtDlLbZ1vD/NimvnADtjwpWf+XSJVcVSsAZ+Rwm7sftEzddMOuEylHJ5aysC
	 bN3dz8YAHemW+G+bhL6Oc/Z8fYXIQr1X//HCMEMDnEp3KG6ZKVZmfBiBWg6gc4Kw7hypH
	 XW0+9F2vYIaVsCcfWl2g9Iyy+0Bp4gvklN23PioaMVnR5MjLM5aGDUnDpnW90j+aJdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S6U9PXxx;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0C606A32D
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 11:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEA0C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S6U9PXxx
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so22857035e9.2
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 03:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794657163; x=1795261963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRKVGMHjS3p2r84erkyfVinxVv6si0HhmgQIB1esDbw=;
        b=S6U9PXxxEtF0JXngqOOGXo9QKTxCGJqS88mLrc7a97OkN6fwp9dpvFs2UBTVzJ+wnT
         eoRnGTMDvOZ0yjqA/SAMSao1uolmXhL6VawcHJDQD6FI8OXsg1PIX++vf3Vyy7V5xFsE
         7L6+51mhJQA6ztF8H+LN5JIs77kL2N2Ul+nyDLLdR+N0uiXuZsr/6njGUaXqz/uFfkLy
         8acqaloIZ8qIHYjoGE+e7Ty3cztsssOwS83Sq8HHCL4/9CGn+qPFsJ12BPq1F0qGoU8k
         FG01h0blYAjkbkmD3Bv5MNKStCHguWQGCUyeMqqiwq0EI6l6TPy7dHulEqRtXn1Rc5D4
         XX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657163; x=1795261963;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YRKVGMHjS3p2r84erkyfVinxVv6si0HhmgQIB1esDbw=;
        b=pigxpSB1OMY6eJpjfCYFoQfDN1J9xxvPZyz5rhfCpckw1OTruXtzxCGyXCBwRuI1pE
         frcpkYHMIgRFxxxyuabEHxKGSQTymsB7iEfW3J/rH0hWrXe8+1JDAhHQSTq8xFE01Kno
         ALUyJnTNvFIx43f/gxkVaY1eAP0xOCjJiFTuoOr2NPAjdJ1lBbB4jBsPykqUVkH/b3fx
         JDuCy46XGLztvjbBqLqjzEn8gTlHpLIGuDQjo+LiIzmo5z9TcyFtctWczyv6ftootR6r
         Gs0eLXKVs4Pxdgb/NY2IFBTGsKtG4Eo0lcFohLta+1njfVPWIpJ7EvkJXKWD5S4kDU7v
         ifHA==
X-Forwarded-Encrypted: i=1; AL+hErE25UkyN6Eik5K/D8meFqUOuLkGDvApuMUnn6pDDCaQl5SfJC3YnyQQQmQe6Yvj6TTOsvE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VcZ8oqtaLD76j+bFuf9Kr/NjZDSj+jG1EzuXYlDHzYq2ASqn2
	HesasMq4TVDDPemlOcvSc5kU2ttmcTJBcC1bOEKEQQ1Jkppk55G/vbZD
X-Gm-Gg: AYBFou2cj3cDo++hMn/eO7juF/+r8Kzki0dmJv0ia0rzfkIN//Uu6YzLmbZ5r+SPU/B
	Rpb03Z6MZ9XxOXpem0UaS/mwgUBBcSfKH1lj2RAipNKCqJrOXMf/eugS/icBMs8m1Q0yCEggb0M
	VSgniJJmFzVpfPqdr91JQIFHnX1FBscKml3m16P/7DCgagTmaZ30pulM8+oRql6ov13ktTTt1XY
	Dp2p4jqfeRFwjK7R3DC3Fb9U9C5o9mEvc8nMJQfhIbV4zmgeX39suxyiGLjHSsc4zqFfLjxElPG
	Mmbyppg9v2q2eb/ex96LVoBzqrQkSm65XGRoZsDcKVsTrhQYVNgJ0lKrXDkE0k3QYCMxzP81jEq
	vvCYrmO9fFdJLjp3ySiTCwjcOt4ysfhIJDgLlPn2BMPCS7DZYstNmRlrfUCluLkTq6NmG5dXtQj
	VV7Fn40gxEAMZCbXUE8hn1+RqPjxiglVbpGxbl4tDeiCsyq3coHp3bbF8IMfGEukCCP3I0+Ogz/
	6CqV3OC0tYQbXZyyfKbYeGtNRNrnVdoiOl/rJFjsehw05xHuJwektwy+tD2nTFqOsrD6gGX9QAo
	8q9pkebfaWfOu9RGdsONbGGsJw==
X-Received: by 2002:a05:600c:4e8c:b0:4bb:60ba:49e0 with SMTP id 5b1f17b1804b1-4bb60ba4a70mr41019035e9.26.1794657162818;
        Sat, 14 Nov 2026 03:52:42 -0800 (PST)
Received: from metepc ([46.197.185.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c0e31sm9072338f8f.19.2026.11.14.03.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:52:42 -0800 (PST)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH] bpf, sockmap: fix cork data loss after redirect
Date: Sat, 14 Nov 2026 14:46:52 +0300
Message-ID: <20261114115222.180345-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In tcp_bpf_send_verdict(), when a corked message is redirected via
__SK_REDIRECT, the cork cleanup path unconditionally frees the entire
message and sets msg to NULL, even when only a partial send was
performed (tosend < total msg size due to apply_bytes).

This prevents the more_data loop at the end of the function from
processing the remaining bytes, silently dropping them.  The check:

    if (msg &&
        msg->sg.data[msg->sg.start].page_link &&
        msg->sg.data[msg->sg.start].length)
        goto more_data;

can never trigger because msg is always NULL after the cork path.

Fix this by only freeing the cork message when it is fully consumed
or when the redirect failed.  When unsent data remains, keep the
message alive so the more_data loop picks up the rest.

Discovered by Sashiko, not triggered, not runtime tested.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 net/ipv4/tcp_bpf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8cf63a9e7fed..e6a8184aad6a 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -499,9 +499,13 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 				*copied -= free;
 		}
 		if (cork) {
-			sk_msg_free(sk, msg);
-			kfree(msg);
-			msg = NULL;
+			if (ret < 0 ||
+			    !msg->sg.data[msg->sg.start].page_link ||
+			    !msg->sg.data[msg->sg.start].length) {
+				sk_msg_free(sk, msg);
+				kfree(msg);
+				msg = NULL;
+			}
 			ret = 0;
 		}
 		break;
--
2.56.0

