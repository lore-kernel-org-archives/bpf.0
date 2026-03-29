Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C197279DCC
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774788696; cv=none; b=NXuN2KSCp7KKzyv2H5pDR6uDl7NUXoYQp/dG197B9LkiidW1brmRnJAKhbC7Og8lrIIHaxHyz7pbzS0JoE4h9/S3gh51Feh+Y+9cwIl8LqfT5IffOOUfhMkbKJYppn0Fh9c77H5fnpjiCZKiHlp9rLq36dUaQx1F/0jNppTrjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774788696; c=relaxed/simple;
	bh=rQ5IgEx7vSEOACBcYD2az2IKo8vqUJCFsREwUTjrtW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZWBsJLOW6Ks4xKySSFmS/61JoaZdI0zxVXxjgclnWPWG/UkCa+Svq2a3rY8aSngmtph94nnCbW6XTlJ7/11qQSAto10aKV6wlkPVMbNmyA9wepQkk3MTT42KUQr4wysMh+Zrb+7nNYwEl8w0SNAkixA50ZxPEZf5GH7FnlvWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmLqOMDT; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmLqOMDT"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-127380532eeso4501258c88.1
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774788694; x=1775393494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHrJ+YBkWKslJsnTGwRqOoIlf9dJU7ItmGu9dzV1w6M=;
        b=LmLqOMDTl0SbkrN/T8cIPmz+hrObPl8KnL3nuMj9ZFT+cZtYJ6H+Jd1gfJTzyU31P+
         jjD6Ads/I3FTdyDXipa1HfyyLOCob42jzl5i7F67B+imugNzu5o031fIXMv/1y8KUTY3
         PFVMXQ0fp2flUI0Rfuo+ITWg+OvrQeoYAqrS7cQYDyRLSsuVrCq3GJYp3a7LUVSlgBBq
         8mYZFmSGZ4uxgwE0bLAnGOgCVXwo/kpHv+kNjrv54uvuzY7qCq1oC2GPOev66cL2HnVl
         0rWfViI3fy39EYId8O1XHx6OGiObwbGQbBQwrhhw32PmP6G0hOu0qOl02Juo4JHNm/fl
         j58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774788694; x=1775393494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHrJ+YBkWKslJsnTGwRqOoIlf9dJU7ItmGu9dzV1w6M=;
        b=ETZJ/xeer/bvPBq9QXJgsJtAUn+qvd1cs1nfWpXF7auAVN1NHO764LJU86cFScQTEr
         HNw/ZSQKaqP5DG5hJKALbK3yA3nGGsVzf3EXxMKpHXI6+zRZmHHQcPivrZYgW5PL1y1q
         R+Rsro2KcuM+CiTWdtc8xRYtMra/l5LDCq1hMtsadJ2CrmGlgD9NiXZ2zzUn0egKprgy
         FiXHsdt4T+vW2L2yunkZJttRr8fgnzC0X/IsdJwng+sF0n9Imwq0olmNiYk9I8A6T9Ux
         itFZVVwJl11oihD/joX1Q9Ikz9pgXmyIFhc4Wfgpp0vkGXmFzzkUbBYNYV3ZpGAzvcCv
         5czA==
X-Forwarded-Encrypted: i=1; AJvYcCUzthDA5A5+jb6lL6oZdNPR+uoY3oC9MzKV4DDwi4VBA1cCGaNIMze6LhsnIt7QB45ZCVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx81/hsHT/syW/IsTqi7nBWc2lqguaTMY91QfInS7qmjMwpMq/Q
	Yyoyjal1IAIypBlQ2f1ztt1Uvn/P72dlO5Nx0wRaCqhu3sRAdPQbhynj
X-Gm-Gg: ATEYQzwH4wHJW0OXbbuZb3M4cQlyZSgArbq8wkSXPAOH2PQYiffYuke7tgylJ2XRiRq
	cNjf1lNxyhjF4Hat7ZCSe53qFCu3SgkBZ+cMzIcNZ/vktknFF6BRsrQ1Cz+LHMfZaUgl3eoamDv
	DCcLH5jfNuOH21q7q0ZEB1dTRn161lNHzqUnbeuWrOjLklBzbgYCDtBtkbZl8SFVocZKd0tTOay
	gVmbEoe2wor+8rFlQtCo0eqnQMV2T8kdT55k20fon7HqK0TgT3wZlDUw5lRozg6mLdDdKquI76i
	KWL7AZohEBWMgw8p/5tKHksY6sY+cocFD29y/0hlN4Uux6bhFexqcg4XrHw3B/SCtR6SR0CiBEZ
	wfAv/uyBn76i6+2yhQAWJzqzItUjyu7GiyP26lVEbUgq0RtAOh+w16T1hsTUeAXSy4FVvMa4kxC
	mQqQUXyum9xC2YcqhNHN0Hr9NoOsvVbY0Odq24WCaBdFqdjSNAnDyGH2hPWKEYvAkZGNLzL/NWK
	58tSMHxT2BRRCbgJ0saTtJ9Jl0bGBqFNJHgW8pv7NXwkdNxzsCJMzX+RpEkGPzkF+E=
X-Received: by 2002:a05:7301:1e86:b0:2c6:31f0:9fe9 with SMTP id 5a478bee46e88-2c631f0b2b3mr55002eec.28.1774788694146;
        Sun, 29 Mar 2026 05:51:34 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c41c1547sm4529655eec.7.2026.03.29.05.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 05:51:33 -0700 (PDT)
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
Subject: [PATCH] selftests/bpf: Reject malformed IPv4/IPv6 skb test input
Date: Sun, 29 Mar 2026 20:50:56 +0800
Message-ID: <20260329125056.1909087-1-sun.jian.kdev@gmail.com>
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
linear input is long enough to contain the corresponding L3 base
header.

This can construct an inconsistent skb for test_run: the packet can be
recognized as IPv6 while skb_headlen() still only covers ETH_HLEN
bytes. In that case, helpers such as bpf_skb_adjust_room() may compute
offsets based on the inferred protocol and operate on bytes beyond the
initialized linear data, which can trigger KMSAN.

Reject such malformed IPv4/IPv6 skb test input early by checking that
the linear head covers both the Ethernet header and the corresponding
IPv4/IPv6 base header before running the program.

Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/bpf/test_run.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..65cfb408f52b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1118,6 +1118,25 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	skb->protocol = eth_type_trans(skb, dev);
 	skb_reset_network_header(skb);
 
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		if (skb_headlen(skb) < ETH_HLEN + sizeof(struct iphdr)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		if (skb_headlen(skb) < ETH_HLEN + sizeof(struct ipv6hdr)) {
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

