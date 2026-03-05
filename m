Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4D2FE04E
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758289; cv=none; b=XsiD883fUvvZwEv8WEJ/AmawY0xpHTcKJThuyw0rX7P5zKcP0y33IgrDPh5SNrO7lVhaMkMVgmro/2EoLmZ2ZRcppRrxW6VNnJTLNSbvrLSGO+9UIOxu7USN18wlaDf4xBXPo94CL+m5Yl3Et167+v0cSdBeCCZJVwJjCLy+VEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758289; c=relaxed/simple;
	bh=uY/cmt2Sth4SxjohY5zGzx4ELvftPGuex3rlN1K/nqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWjcEYpps46y6uxvS4hyDv97ZYUh2MN4BhkVCK0pTQPnWhg7p3tdqQmnYBpgINR/3aHRFz7qu+/785sDbEjrf4kfwW59Ud6IYQ2spV7TTf/BGLsiZ/DGw14ii47lZ3tK02lfI9wOIEQmm3KYf+So7XCH8HW6mGr8q9zmclLCHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U7IjsFI6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U7IjsFI6"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4327790c4e9so6642652f8f.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 16:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772758282; x=1773363082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cj+T9d3Zgf3+ritNDiK94fhxI8rgFwWgGmiNKUx6cEs=;
        b=U7IjsFI6ZVhXKXQSlulUJAniGOY6cfVExehoDjuQI5Yc/glgmnzQRFqgGA81U9jmFr
         I4L8908AT0JDZckZDWklLZgH7mhn0OZjQiSkar0FqeA1h4sH5yrX1jy3tYgP5MJyT+XP
         KILxkoy/qcQUkxAV5JI/wmyTui/8HUAbHap7Zvv3cNmm0OXoreWRZOGZG1SLC/xhY4Cv
         h6n/HenZeto74K4ui47fN+pnU/v8MAjBNt2hrN69G2NbIcJVuYRefQoJwh9LglkOdble
         x28WyLjmIt3AMKRzL9jjmP9CqAMW13b5dXiMm7iR9MAbCZkMxydBtXPg7dpDMJKBvBiL
         OmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772758282; x=1773363082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cj+T9d3Zgf3+ritNDiK94fhxI8rgFwWgGmiNKUx6cEs=;
        b=XnsQZQlzvzfP5qvwAs9ERCVZhc8t2FwTRx8DSP8HfSJN8HCTNJpQ8TiS1Qtfmk0zxe
         YtGyYfJmWtBJWmy2Yi3udmvH2fm4M6TVLPueMPFriH1eSHxR7sf4PvQBFRuoCJiJSvAr
         BHo1JUAQmPATnrBeCEedpkY9mLIvpS5wNYTFpcoxpJY28QeekKcKqUb6IpZ/uSMBBEHu
         M1ctl/Wfeg/lV79RBmpbfN3sigvrCqysV6z9F+uiii/bJv0O9JphdCWdbuuwD4pht7d/
         v438l5Qpjq4tI9T6zEgRmCgvAiaZiAhXho/kaGYzO/CPTwYOoOTYw5da79P+V+itMXLe
         uY0w==
X-Forwarded-Encrypted: i=1; AJvYcCUjvVwVtjQc2zGjvvFa93QmNOxU9pobulFPTSMD8qdSdeHjyE7UKgK9jtjB4sDrhGFbsqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJGL7ypU6h534X0XXLA0MMp+kihIinYFKUYBYSy9qBtJmGt13h
	I0aiR22sYE329bEeGsHCAdqNuGjXKp53AUmSEFAjGX1HWMC0RSAb1SS+lU/DlNyiIEM=
X-Gm-Gg: ATEYQzzw4JB8Lgfs8r5Dzw5Bd5ACKgxY6zWgoeFX+q3OrU6y0OU6xC5FWpeWDkF1Avc
	GiMQcVeM0jEHDunfgdEPbhQkAq0JOxniS/v359/NBsHpcMH5dHiBJZK4PqsMvYDReu1SQhKMCxq
	hrkPGOoAT9ww4jCl93sJDco3VKMarjLUElmUbvaR90BAXzgdG6cJEQ3y4Hcmnae9+N1HP5qTSLZ
	Ll6cm4ZVBfLQl9VlIPcAOCP5EOvEAxDovVc1UnUYiuerQAtMKf3XwLIVz4qJ1JG8iSRuVysS63u
	ixVNMg8oFHBTKQ47YM1bnSW3jJ8QosbLoQSgWnmRMxU97kityvENaZ+rW3orHhriMOdm2dhvapX
	iiGxiLFxj0O9wl+DoumNSRfRoZ86cGIUxIEuy+7O1Hq5bhqymxvxZjCSn5v5gM5rjWXnyha2PB7
	awYB40nhs0Cg==
X-Received: by 2002:a05:600c:8115:b0:480:52fd:d2e4 with SMTP id 5b1f17b1804b1-485268bcfb4mr4040065e9.0.1772758281849;
        Thu, 05 Mar 2026 16:51:21 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b0865825asm51909e0c.9.2026.03.05.16.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:51:21 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 05 Mar 2026 18:29:56 -0300
Subject: [PATCH net v3 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-net-nd_tbl_fixes-v3-2-fde28b30a744@suse.com>
References: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
In-Reply-To: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1772758271; l=1999;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=uY/cmt2Sth4SxjohY5zGzx4ELvftPGuex3rlN1K/nqM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QF1Q1aDL07UnscOXXDba/eBfS/TWj0GNuavW/i1D9zrky1fKqHpr6myU7MaBBl1bEnmCjHaihP4
 uj5GNpCcc8QA=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called which
initializes it. If bpf_redirect_neigh() is called with explicit AF_INET6
nexthop parameters, __bpf_redirect_neigh_v6() can skip the IPv6 FIB lookup
and call bpf_out_neigh_v6() directly. bpf_out_neigh_v6() then calls
ip_neigh_gw6(), which uses ipv6_stub->nd_tbl.

 BUG: kernel NULL pointer dereference, address: 0000000000000248
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:skb_do_redirect+0x44f/0xf40
 Call Trace:
  <TASK>
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __tcf_classify.constprop.0+0x83/0x160
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? tcf_classify+0x2b/0x50
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? tc_run+0xb8/0x120
  ? srso_alias_return_thunk+0x5/0xfbef5
  __dev_queue_xmit+0x6fa/0x1000
  ? srso_alias_return_thunk+0x5/0xfbef5
  packet_sendmsg+0x10da/0x1700
  ? srso_alias_return_thunk+0x5/0xfbef5
  __sys_sendto+0x1f3/0x220
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x101/0xf80
  ? exc_page_fault+0x6e/0x170
  ? srso_alias_return_thunk+0x5/0xfbef5
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

Fix this by adding an early check in bpf_out_neigh_v6(). If
ipv6_stub->nd_tbl is NULL, drop the packet before neighbor lookup.

Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support supplying nexthop")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4f8ff05c4ec4..3be669347e62 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2228,6 +2228,9 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
 			return -ENOMEM;
 	}
 
+	if (unlikely(!ipv6_stub->nd_tbl))
+		goto out_drop;
+
 	rcu_read_lock();
 	if (!nh) {
 		dst = skb_dst(skb);

-- 
2.53.0

