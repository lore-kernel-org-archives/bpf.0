Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9C3E51FF
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092668; cv=none; b=bcQJKT6F4X9K7J/xgbB0++r1KtmroZ2CWa21A0pumER82hrs0Ag5LTSYNOrsoNEqgvxlBHVTkMCRBeKCJASVnShvdJOuRNmJlvSwuLckp5beDh++C3dE3NlKQrnTe4Bur51CJZvuW5U+xKMhvczjnSMhT2pzSA3Q4RnjL/jDbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092668; c=relaxed/simple;
	bh=tZtPPNL9Vrc2JmWRN3ooRrA5uBIMk5/gsLjd/4M/DXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YL8/O6eVasOvk5y5yTXsVlp72zP48UnKU7xdylNUnd21u+UZ0vyuyecnnU9abARW1MS1y2tn1hZN4WNGNJ57YszqhASsI1euSc1Iun+aH5y64tzsWfzoMw9InywaMoB66NA5JBWxz65cGAe1IawSNIshXAdw/fW93w/4RjpWErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pb484C78; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pb484C78"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c827313dac0so1201553a12.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 01:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092666; x=1779697466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6QyqDaqjvExe25pt6hbxG1OXe8peYolpHaEpUnsVIc=;
        b=pb484C78zr5kBRcZeZh9Mfo9D9lMKJjkm50qdlF34FJ4qUb1gsknrXgp4xajY9bCVZ
         NV3aGoNB30aoYsnOn1wD3zAHFCRD6hiX6GI2BAwJik+tepBKeWLRtawjLYBlRjNqyeRk
         +49nRbGCoMu5DDZSXAELvFIngeHz304wJl6pWoQVh5tnFVbHGvObDnUQa3QyW5RlRY87
         LI1bE+rQbl9ByDonkUD8jMrrxYi2RC/0DTtOkXTLksdB1dTUP1ln+XaMnAZs06vA49O4
         0aBPKMrk5xxQKPXIiiA3qKGM0deXnr0jBlyBU+QQx8gM+V9/tlb8BvOWbgRjTIPe+Rou
         UWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092666; x=1779697466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6QyqDaqjvExe25pt6hbxG1OXe8peYolpHaEpUnsVIc=;
        b=T1Fo30/gBLygeqoTD8SDzWmo9DCeDy7f4VTjSCOpQf7DzJ5NXrBUNO7ujX+EIiC6GT
         MG+mBzrtPRFfBwZlip01kD4XJDuZGblzoVPRHBnGoWfWb+vx+gveecZ2Kmb96lsY8tEf
         mXrHRs1zHM2IJ7IOQlr8Ktwm/nGW6Ge2z3C3vFjvVnID/J4FpjU5q95Lf3kI8hkXszHI
         CWzD/Z/FuWnMspHHuL5ce70/cJR+wIU682Wu/PqsIUkohZEhNU0ot9rF9iKbfnjocgsW
         ndPq9VHZI/2kfBuv6bdNWh2slUxv7+b0QxL+YJh8XAuECdrrLh69KhX2Qbxj1F8PuhzU
         gSqg==
X-Forwarded-Encrypted: i=1; AFNElJ+BF/t86EKeH1iGbb3ix2o590kTRzDzS8CeccqzZfbLNx2QSjuhDMWdQrPreafYLpOHEzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fhci6gNNQEGbJXfTi7mACzFbOXUgmGasnUUb+r41SKqJFb7j
	mwJDcmiGY53fIWnCcXIqFTX49GY8VFdk/sz+NE2nj3i6dz01OSvtRXAS
X-Gm-Gg: Acq92OFsWt/Hf//wsEX0GlCpRFI/dWWCC9x+cddMUSRVZ1AbYm8M7WMaQoQ2x7ZEVag
	qPf0nQqSpF8bufDWAO8ZxzJ38/F8Lklr+q2bx7jAM6LjKOkrfz3eWSeJ+AIw+eAGBZN9KSCqoO1
	RShg6W4Wp81pRo+3JbP9WHDcp00UBKcD77L5y160KsgrAuW2twjeLUYMA+QmjxHtR+4xW55ZtUq
	OYZMQXBOKypm9xpJjUsIqhyJvGxpA7XolVcj60ugqz+YB8ozOGl/0xD9Ps5AlhPD+cQFizSSzOT
	tQsWbgKS33pXJPaGwOPcFFOggszNKnFRBdBc+I0tf6LYpnHi/wSBj71cYjmbe3wxjNHqCdwgUsQ
	n/Ks/8V205eEdhuMl0fxP3/bLrFUd8n9uWJRtC8C0rUCPLL80zQxmpH7G44ebKIPWGHqp3Kao7W
	BoHdciLUU6EQr88vKc+ZaynEjIqJGHwaS7Nl/zgO2h0I6w+F6qmqMDDnZeNjLhXRZeVfaIT6zT2
	IwFoG3oGC8nIbv88994sODZ1r+TYg==
X-Received: by 2002:a17:90b:4c03:b0:35f:c493:cac5 with SMTP id 98e67ed59e1d1-36923639232mr17170261a91.16.1779092666081;
        Mon, 18 May 2026 01:24:26 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:25 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 3/6] bpf: support bpf_setsockopt for bpf timestamping rx feature
Date: Mon, 18 May 2026 16:23:41 +0800
Message-Id: <20260518082344.96647-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260518082344.96647-1-kerneljasonxing@gmail.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add SK_BPF_CB_RX_TIMESTAMPING callback flag to enable RX timestamping
via bpf_setsockopt(SK_BPF_CB_FLAGS).

Add SOCK_BPF_TIMESTAMPING_RX into enum sock_flags that is used as
centralized management of net_enable/disable_timestamp. Note that only
one of them (timestamp, so_timestamping and bpf timestamping rx) can
enable and disable the global time record of skbs.

In addition, include SOCK_BPF_TIMESTAMPING_RX in SK_FLAGS_TIMESTAMP so
that __sk_destruct() calling sock_disable_timestamp() to thoroughly turn
off the global time record.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h       | 5 ++++-
 include/uapi/linux/bpf.h | 5 +++--
 net/core/filter.c        | 8 ++++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index a579d5b09207..cf0e82e46482 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1022,9 +1022,12 @@ enum sock_flags {
 	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
 	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
 	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
+	SOCK_BPF_TIMESTAMPING_RX, /* BPF RX timestamping enabled */
 };
 
-#define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
+#define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | \
+			    (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
+			    (1UL << SOCK_BPF_TIMESTAMPING_RX))
 /*
  * The highest bit of sk_tsflags is reserved for kernel-internal
  * SOCKCM_FLAG_TS_OPT_ID. There is a check in core/sock.c to control that
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 552bc5d9afbd..1e09b5cd7a39 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7029,8 +7029,9 @@ enum {
 
 enum {
 	SK_BPF_CB_TX_TIMESTAMPING	= 1<<0,
-	SK_BPF_CB_MASK			= (SK_BPF_CB_TX_TIMESTAMPING - 1) |
-					   SK_BPF_CB_TX_TIMESTAMPING
+	SK_BPF_CB_RX_TIMESTAMPING	= 1<<1,
+	SK_BPF_CB_MASK			= (SK_BPF_CB_RX_TIMESTAMPING - 1) |
+					   SK_BPF_CB_RX_TIMESTAMPING
 };
 
 /* List of known BPF sock_ops operators.
diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..08ad102f204e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5304,6 +5304,14 @@ static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, bool getopt)
 	if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
 		return -EINVAL;
 
+	if ((sk_bpf_cb_flags ^ sk->sk_bpf_cb_flags) & SK_BPF_CB_RX_TIMESTAMPING) {
+		if (sk_bpf_cb_flags & SK_BPF_CB_RX_TIMESTAMPING)
+			sock_enable_timestamp(sk, SOCK_BPF_TIMESTAMPING_RX);
+		else
+			sock_disable_timestamp(sk,
+					       (1UL << SOCK_BPF_TIMESTAMPING_RX));
+	}
+
 	sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
 
 	return 0;
-- 
2.43.7

