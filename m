Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A12F744F
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758281; cv=none; b=Si+XDwShtpJenLTMZ69wh1fEyO7uByNxEQ0sbBXZdoLa0ylMOKybzwpXvuTa+kZVlUeH801paYsjY1qK+OrLg+cFCwnu73N6N7njXr7VwOYmAjmnZV/CjI81k/rmJbxSI0UGj2alFtW4wZEH558rCWophr5p03zCrrHAkcsTLFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758281; c=relaxed/simple;
	bh=rEUuZZA4ANDMcvCg6pyW/UJTRU9oRAre4nZ6TiKNFLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BpzXu3LX7nNPe2Dhvwpmn8SH0lW/ElB8VBW2ZamZDEHg86uzqbDRyjMU81GeOFm+GJdH3G72KKIGzmDX754arG2d9vjfVwV4H1Nhf4wCudwKoq94P5WyIiKHct4HGbY2BUSC4y57eutFRL/Oi+y9ScRSft1A5TTgLiYNOjMFjFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZcvEYh3g; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZcvEYh3g"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4833115090dso88475395e9.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 16:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772758278; x=1773363078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8d5hpiYB7XUuEuXpz7M550s7MAxfMslNPphPrHEEiTQ=;
        b=ZcvEYh3gLKjlx654lRrOER6D8AZGEZ+xNWN4PakhPqieRawNzRQg8FOHhKmmMwosQq
         dSXHQWv2yc/banmAyts3YxUSTXf5uqiVG/LXhT/kBFwv0SJxYEDwrAy3SI8gHco0eGgU
         0tr0KeJwG1odZHj6MYl6EfpuWsv6C3yuabiA7mJs08jlkR8gjpYJpxgRidZXPlvumyeq
         i5QeFAal8l2mdopOCzU0sbHMsf7NfSxzXVtO7JDIxtmSlcJvVhAblch+hnXshQfJzNCy
         CN99e5x/54TYxs/6Lh+nSEzVry+3mEPkUYu5yLSI1R3oNLYQP4mUcA1NzP7TZPNSWZXB
         tYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772758278; x=1773363078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8d5hpiYB7XUuEuXpz7M550s7MAxfMslNPphPrHEEiTQ=;
        b=qBGZuchRUSogrIE2jDerWEiXq79iZ6f8rEWDwnVKD1Gylqs3Rd14IJ7er8VYDJYKbT
         vuyqlZfhxaUYOi7/8KZMcdrEnYY5IuNuhSBa8W6b9pkhzcqBB/2aCSbBYiCsuEcgd+dq
         1uu3kZNrBFG6h3KIm+2JDqLZ1yg6g/V/LQ4YvZGBQtUx3fxNz+M8pT+VslZfkzW43fxH
         SfX3LjEHG9vS3dQld+4J66g79NqDHRWr2183QicMve3Lg2usBba4nIWPaVxI0ilnDqQL
         KcqF89h7zEl+GFcx3CtsUSalaoAOYbyBzzOZuhYJ4y+bL32TdRRqr1umwnRAyNer4DLY
         oAEg==
X-Forwarded-Encrypted: i=1; AJvYcCWMyINLoCwFLstkMcp7BWuE3SGHZ43blU2hR8T0A13P3+sipGMH07hwn8lyIaTSlJG1iV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR5b8AdRv7xS2kODEm9Yx6d+JvzQCBcnqZb03IV/YUrcid+KA3
	jj4QTNktJb0xJ/z6jke1t7+Vf80ujciKZIyGOnPcVtfOZg0yxiN636UfOkAIcW4i0H4=
X-Gm-Gg: ATEYQzzfwv2bdxT8CZj2SxlY1V16cIDeU7MuAwLBU5yTbpRMb/+mCtoPa/8YYVOLlFU
	k/6Utj9VygkDXV75Vlt/a5RO0+7X4rWVnQW6PuXc5hdpqYqiB6klqSIjpY3wKOJxrQemxdePYFN
	ghmuWhQ9/Z0g6I7x//yPIyPRKeWcJ3HfPc/laayzgJoKEZq2foGc1cZ1OZ3OrVPCIpoPjp2ULAM
	cQHrDsvSnaFK/ktz9pQmfeauToqJETWh+vmCwjyOesZUkSoxPHy+BSjGXqVz5nbDm+RY/hbAJrB
	P7gGcdQwKbp88vr/YLkWAfgKPBN3dzIB6DrWwl9v3++sO7d6Nrf4TvP9O/Psf1CuYzR/IxopfI8
	8QAajgTuzBAPEi00e31TQEQ4BBTv7yAJHKa6zBGeqSIlpEspuAAg4rcJUS/lT5yGA8Tz3d3Dscc
	ubpGST1SsEeIlJVUBVrdSy
X-Received: by 2002:a05:600c:19d4:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-48526923b15mr3594985e9.8.1772758278421;
        Thu, 05 Mar 2026 16:51:18 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b087d9e69sm24485e0c.15.2026.03.05.16.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:51:17 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 05 Mar 2026 18:29:55 -0300
Subject: [PATCH net v3 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-net-nd_tbl_fixes-v3-1-fde28b30a744@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772758271; l=2192;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=rEUuZZA4ANDMcvCg6pyW/UJTRU9oRAre4nZ6TiKNFLg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAqX5xIX1fDdNVLySfgqcNpq8zzpqBUX1kZwOhKrciL3jWWx4RUwsRhbdPvWDdjqg/5lFkWHs9/
 RWswQa5VhTQg=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called which
initializes it. If bpf_redirect_neigh() is called from tc with an explicit
nexthop of nh_family == AF_INET6, bpf_out_neigh_v4() takes the AF_INET6
branch and calls ip_neigh_gw6(), which relies on ipv6_stub->nd_tbl.

 BUG: kernel NULL pointer dereference, address: 0000000000000248
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:skb_do_redirect+0xb93/0xf00
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
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? alloc_skb_with_frags+0x58/0x200
  packet_sendmsg+0x10da/0x1700
  ? srso_alias_return_thunk+0x5/0xfbef5
  __sys_sendto+0x1f3/0x220
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x101/0xf80
  ? exc_page_fault+0x6e/0x170
  ? srso_alias_return_thunk+0x5/0xfbef5
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

Fix this by adding an early check in the AF_INET6 branch of
bpf_out_neigh_v4(). If ipv6_stub->nd_tbl is NULL, unlock RCU and drop the
packet.

Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support supplying nexthop")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0d5d5a17acb2..4f8ff05c4ec4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2335,6 +2335,10 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 
 		neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
 	} else if (nh->nh_family == AF_INET6) {
+		if (unlikely(!ipv6_stub->nd_tbl)) {
+			rcu_read_unlock();
+			goto out_drop;
+		}
 		neigh = ip_neigh_gw6(dev, &nh->ipv6_nh);
 		is_v6gw = true;
 	} else if (nh->nh_family == AF_INET) {

-- 
2.53.0

