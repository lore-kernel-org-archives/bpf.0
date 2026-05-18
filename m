Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B283E51EC
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092661; cv=none; b=eXSJD7yeMAeOD1JcWgW3SjCVMaQF36DocceuT/Zw99jRYRSXmcESBv5BikP8MITNnTrS/vUkG91+kwCReoQJMSoN6weRU/IQYcEqhipfK09JRPlUkQM6ADpFv/JEo2l8WnmOgw0a4HOvjUxp1/2d0YDg6QwJ8JSRWCN7VITIhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092661; c=relaxed/simple;
	bh=7dRN2lVYiQcHQj85FKXslQHT95uAqRClKyLM9OSsglg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7DWxhwr51+R02Pw5zryF+Q+bBPpe0GGzkaa/aZBO4GBk59ckoTF3zqdRNGU7IzFRLlLA8mLbCwN4iS8wBTqK1XC2ixStpDX161+RXgvDgxzbGiqDvTH9piyKTCUtkqbDA6iVveJPZXugXFNjyPFeJbRaytP8CBdGUhKkyOdR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sa36u6rh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa36u6rh"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so831214a91.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092660; x=1779697460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uxNYLIbpi8gIXuY+ONhzYZBPNfuEelESGS8WTu/ln4=;
        b=sa36u6rhPN/NAPkvLYNOj7hx3EAS4l3JTyY8cno2f+DOPH0PLarZ6CM6GHhZhGeaF1
         jyh0+XObc9j2ZrAemDLwvL8lcKk6AoCt3O+zUWhEqEA64prowqi4DBeNVP5Tg1rffatd
         vampPiUJUuxbvdFdx8V0giq93OYgtPHP6zhhIPRbn6EOqhG0PNf4MvHfWbIiOkJO/z47
         qvQOyOTCxeybMOj1w5wlRxcTeBg19GVweqHU+jezcFFfTTTzmwiQOJLLqhjE4oU81p1b
         I08NvBkzQ7tkoB6w7geD4bGpD2HBRH1sWHa1aLQQ6VrfsUVObiD/QAqJj1cHewIt6pmi
         uNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092660; x=1779697460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3uxNYLIbpi8gIXuY+ONhzYZBPNfuEelESGS8WTu/ln4=;
        b=dW9TN0kcjY0Kta+D2K5CBO//P8LdGOJJzThIOa/ZPgtHPwT3WCG1MF74WdESYaZ4Ii
         I4xpjLK7Yfn4sOFjBFU7p8cXuz+H50ESqwjgLsDcGCSj6PKtkSpm9n0UwE7TA/d30qXf
         qhmDJLi0chFo+X0uccofNSry0vVtgT4yJpu8Mx4xRm0jx5Xm7pgMM6AjXbRwhpvbJVbu
         uFUaZGXBua+HgutftsJcKq6V4uqX6qRGL/9ZKTH72bP1gJoelG/nFBmzXknZHy6I9hAn
         ABM0vCYwFGv0wI9TckWjrr1wUqLyorOJ5iWE3F7pkyywU9D3S8cHI2onbN3GqbeGV1TY
         fWJg==
X-Forwarded-Encrypted: i=1; AFNElJ/crxYT386RlKouE4ySrInei0LmuY/LnuPtCd1jU93L9hFoSap2/9wz1P+g7Ma3nATykVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBVr+00gu5YrN8jpS/YSMNjNTriDPkgCuQBl0VPezKso9pdAYA
	UkiIzOFizJLJTfnFufmygArAvwh71cJGLunKTI3L5PYyjvgF9RSGpML8
X-Gm-Gg: Acq92OGTv1BfFxITgxbPA9T/W8dnwt2uIFJMXLK31DgmpwaimeXgz1hPi4UhB902u9q
	TyNOWWAB01tJUVincZxFmCv1rW5QKKdHSONjhr5a94tXlZQxGRtdQRMy9e3SRESQyjVl2Pcyr4A
	c272TfQEhVCnZLmPEDORcIwXLIjnjseGy3Vmq0BDIWzkjxFTGdEMZrTaGteC2tMJS2KUWjKRJkq
	Bq+8c0Ev195d8BvMjE89IVBXBqGrB+IDyqL4TnIBW+saMzL2nM/XIW1r+44M/ljCJF3DMCi9rNT
	p5dQKfFNmDzUSCEsGuSixtBj7eIwy1x2Yzg36sX3Md8H8kE/XDMq9QqmEaCoWejuhITWS//1CjG
	ss6mBM92SeE9bg1C0zfgkxylzs3HspuR//pSao+Hwf/BoQ7JPXrGkLm+utNHN6TdjBLmBPljRsv
	Je2gCfXiefnYXWuCl9CX3j1NIXFNqr/xxVAvmUaqTC9fWSfb2m1BwREisQiPvpZFxfN3FHWwc8/
	p43WKqpNJgzIPRUGkTwm/fQeeih6Q==
X-Received: by 2002:a17:90b:3c10:b0:369:a359:b189 with SMTP id 98e67ed59e1d1-369a35a15a7mr5394598a91.19.1779092659728;
        Mon, 18 May 2026 01:24:19 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:19 -0700 (PDT)
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
Subject: [PATCH net-next 2/6] net: export sock_disable_timestamp() declaration
Date: Mon, 18 May 2026 16:23:40 +0800
Message-Id: <20260518082344.96647-3-kerneljasonxing@gmail.com>
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

In the series, sock_disable_timestamp() will be shortly used by bpf
timestamping rx feature to dynamically turn off the global time record
function. So remove the static label.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h | 1 +
 net/core/sock.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index e0263bae8da9..a579d5b09207 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -3047,6 +3047,7 @@ static inline bool sk_listener_or_tw(const struct sock *sk)
 }
 
 void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
+void sock_disable_timestamp(struct sock *sk, unsigned long flags);
 int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len, int level,
 		       int type);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index f362e3ce1efb..f3d78da3aeba 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -474,7 +474,7 @@ static bool sock_needs_netstamp(const struct sock *sk)
 	}
 }
 
-static void sock_disable_timestamp(struct sock *sk, unsigned long flags)
+void sock_disable_timestamp(struct sock *sk, unsigned long flags)
 {
 	if (sk->sk_flags & flags) {
 		sk->sk_flags &= ~flags;
-- 
2.43.7

