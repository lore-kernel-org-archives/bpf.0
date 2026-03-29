Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6794727707
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801091; cv=none; b=AgnAJztz7Xfd6sDgfMEy/PgQuqE1+K7uSF8+3h8qCcKkik89fi1f095C/eWN2s1cfCClJDIyAB8RHEj7EOl7gdOfbSjJzzC2KyCOSS5+1oohuDVtINJOaTcBgjVctdAti0av3qPvNehpAfYuGacXlR/2+/8A2BPVUQZ5pPDVHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801091; c=relaxed/simple;
	bh=vA7FGZ4QgImw8H7FwAwRGPAFqoafQa4yOe2ds6Od3rU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWInwgUnbSpqcHAUQsM58JHuP+jt3J4Ynp+GunOpwRtrb1tnrWXdCgv4rXvWDnaj51vr93+oH2zca9QoOqviDVXjyuyZodKtn0tjiiHesPueaQQXxY/1jJKFCUxWMrfaL80e15b8dScKiFnPQ0+rmtuhavgV5nuZkZWBtFypNbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt1CAXSE; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt1CAXSE"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64e8cdafeffso7104234d50.1
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774801089; x=1775405889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a83TUsskxy1VkF8Vg9eln+jbw7jfWEDWtbMcqUkZ9fM=;
        b=gt1CAXSEcqSMUTCq4NvcKCfGmVvMF3qN1b9CQoHH28GLay64l9eB6scxUgJIjsMCFU
         kBLwWUQF1ebkikqZ1+XW8T/prpRtQx5bqth0JE7X8ZFqF9gMuOnRJnQlH3weUw8vyayM
         ntvBru3B6TP7TxC5p9AxCNP8g+/xFuDVOa9DBc3EFR5NSE0mWaQSUUwJogPnC3peNgsQ
         y8eo3zFUtc+54yEquulqa9MYjxhS188WvPaEhmL5kZ+/tFPJ2dKEeus0rtUGxH20ETAw
         A38ny0uIQURiZzQzvqnrwzg9zd4ZpQ1aSA42X6YHbsnAxaJ9J1mKclU79JqBz91kjhoF
         Q98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801089; x=1775405889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a83TUsskxy1VkF8Vg9eln+jbw7jfWEDWtbMcqUkZ9fM=;
        b=JkZT/9E1oemkrj32SwCMvjM6EOxYd/urIdsPCrKjdev/VKe5ZZT0IJxlxyypSwni79
         8+essTsd5zMnnNzkiFXz5Ft89zy6233igRHXX72yrrXzcycYKxKNcwq91mD1dtXbYDHv
         OwpPceKLrxyP0cniPRTeVqNDXuRZ+bByc8TXjr2g/42h7aEBPzAR3kZ3TaPhp/WOL55L
         blWUwGhR1kkUdq7ePH98RsmoRGS/43zCsq+tY0l096rSbpQClKcgHPKsb+CYjI/ljzcw
         1Ei5n/B+GZjzbQbTBtDqXf/JYMtfz19ul1fWEdJo7+OlyiaFo9WGUO69MvDMJINbzEKN
         Idrg==
X-Forwarded-Encrypted: i=1; AJvYcCVOo/BxEKyCQEgjamUi5blCAzqBObso+7hYByiWqJ9oMwaxIxKIiJh50Bu+fa0c3mtiI5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzahGqycc+OAdHexBgyIXC2FTgR4QkkzF0IUTJ9l6hd2XCayYKf
	D7pZM+miTGq1h+6XUyiACwZB4Nvi2BQ60GtEsTla3VOI9QGAXIAZzYmA
X-Gm-Gg: ATEYQzyvVgEM/vLimgClqQAL+SuJluBsWjcGIg2SbTO6z+n1iN9UKVXpA1hmL/jF//4
	a26FZ0FdP0FuPXMsn/zjXpJG+Ks2VOyeL/CZiiO1UcgoObgqCg/fM8pNtkuYfVX1jze8yZlsjIm
	zakHlbtDic2vupCepsC4WmcRaYLBvUs4KwvALEQg2oHUwPCUzwznLqG0mF+GoaKnqx4ksgcng7U
	oUBqFAQj1mydQjfxRHOma5Qd0kfTgh6MVfaIPstHJ4/HVpKj6Ii1c3CAU64nB1UIWRv0Izo1Naa
	llmxJoYz9jJK9krk7RMGfPECKUgEFYy8gziDx8OG0VRyqCoxLCuxRpFuZ8ZZnCHHbtQyWfHFzXw
	YSolHqqKPSIlDRMy3nhOPsaTQNJlsjAZ4WpNj7/MZjdBnL1uhhIZbWf1ac+yBo1PuuZG3TQh+/d
	rK4VVsSmW2t+NOe/HSzVmL+Hy+ad3QySCEJc+1sfv5fs9TIn0sa1Kh2nKW2uik4mF67O6KDYPMv
	FWBNsXO9XfEtt/J3aYL05plWGxjLhNqBIeOZ7U4XQ5HNQGTlcqyVHEV044d5xWXPY8=
X-Received: by 2002:a05:690e:4092:b0:64e:e833:337a with SMTP id 956f58d0204a3-64fee1b61a5mr10432402d50.2.1774801089372;
        Sun, 29 Mar 2026 09:18:09 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6500936f692sm2638216d50.19.2026.03.29.09.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:18:09 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>,
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Subject: [PATCH v2] selftests/bpf: Reject malformed IPv4/IPv6 skb test input
Date: Mon, 30 Mar 2026 00:17:51 +0800
Message-ID: <20260329161751.1914272-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_prog_test_run_skb() derives skb->protocol from the Ethernet header
through eth_type_trans(), but it does not verify that the provided
linear input is long enough to contain the corresponding L3 base header.

This can result in an inconsistent skb being passed to test_run helpers
such as bpf_skb_adjust_room(), where inferred protocol offsets can lead
to operating on uninitialized memory, triggering KMSAN errors.

To reject such malformed test input, we check that the linear head is
sufficiently large to contain the corresponding L3 base header (IPv4
or IPv6) before running the program.

Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
v2:
 - Ensured that the linear head is large enough to accommodate the corresponding L3 base header (IPv4 or IPv6), before running the program.

Link: <https://lore.kernel.org/bpf/129d235b04aca276c0a57c7c3646ce48644458cdc85d9b92b25f405e2d58a9ae@mail.kernel.org/>

 net/bpf/test_run.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..4790bee535b9 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1118,6 +1118,25 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	skb->protocol = eth_type_trans(skb, dev);
 	skb_reset_network_header(skb);
 
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		if (skb_headlen(skb) < sizeof(struct iphdr)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		if (skb_headlen(skb) < sizeof(struct ipv6hdr)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		break;
+#endif
+	default:
+		break;
+	}
+
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		sk->sk_family = AF_INET;

base-commit: cbfffcca2bf0622b601b7eaf477aa29035169184
-- 
2.43.0

