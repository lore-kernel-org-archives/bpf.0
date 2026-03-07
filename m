Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA32D3EEE
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916682; cv=none; b=tn+VyUemDB6vzZ8Kvu/SNUAqfTNkxxQhObCd+pQEQtpO2Gx4k7r+E3IlTcIw4eBmuEfQ2HIR5rWNa4MNHKAItNvtHz82IZVlm7Xj2lJV90Lu2Aj9tLJCtCV/SwdJwXX9duFWWluBg389gbnVvJsBKzoi91152ENnuq8COTHX7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916682; c=relaxed/simple;
	bh=LfIxcEnbfF8UcBAlQpsEC60tpSn836JRskSf+FgYy7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wj1ma9e1D2LF4srKIx1JrrnPTIqYaROMRcSqPCVcEK+Uf8efRjEv7fWkaYnHpkhBJEUqQ53kufgOVjJ0y5I/JoYyMUDMeijN+UJvu6BxmyimphkNY6HFZg81q2YxoWku/TkIDpvLc4TDrOZnE02QUf52rNLVK3ZdExeJlMjitlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NyJaqgXI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NyJaqgXI"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so119875415e9.1
        for <bpf@vger.kernel.org>; Sat, 07 Mar 2026 12:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772916676; x=1773521476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8YSb3tz18QqaSJGIXy5ZYeSWZygMaMUDj6N+n+MakU=;
        b=NyJaqgXIlqFmQfADBmL2KrY9It4WrL7J0rOKiK+s03mgGOTAK2bCRLgTuAe96ZtQFa
         2b7xtY5kWcLPmVpZGDJBCtofd8xSMpNot3ne6FWrPRxKkvjiPqf6d3xUmduUlxbQ2pn/
         1W5R4SZs0+BjBOO+yLasxVfYLROMWaKgD3eF+Ct8iK2d2dh7uRjtgswMpgrwzWldsdhx
         78Z6vsnGg0tlp9ztQOLzRsnYnWvw5q78gbXUXM64IKpXnWZNakuzGxlWNi0zSHsJ7Qz8
         wXJJOKZKPq3NXKzFDCBqdgJah1Q1dJHwYuqnRUSS9MtWVtugq04oCmFvhL2x6p3LWlu3
         c5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772916676; x=1773521476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+8YSb3tz18QqaSJGIXy5ZYeSWZygMaMUDj6N+n+MakU=;
        b=fjD8Z+ZFal4cu3GFue1mUBZZ8BQyUGXr/wGf3cGIRJDib/NLnV2wH+ILiuY+FQ9imc
         z4hBNGRynQNXehjxphCKXhJhlyw5bTg7bL1bJNKNesPZ2M7kffxjzbr5JJEZbh5Juboh
         SzJxVeM9hrZa6V6zcJ2rd24wIjCnaUl3xPadbAt9fgtiVXKBQc1zVshq34KI6zpYeEnN
         GXZQA+qkrkB7aiHfkiTbaNWSoh+3513EBvRaxBRdbJGV9zgXWgcgsspRnVKB2LguH7xE
         wYLMkXl8xt82dXE0TDYm3z1ysoarIe8ESTBY/mZJIoC/DctXsJaxo6seyVWGRZh5By0L
         WDhw==
X-Forwarded-Encrypted: i=1; AJvYcCXgumfJrFScGGWG8gVofDQSdKLZt/32/bG6PvhbqAHDQJogkbSeHCzxkkYDIcp/Y5Q+sLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylMMfyPB/f11vnYLfXmE8PIOGQG883lTT8m0LsxI3s+aae75pb
	RKUR7jttA/8LrGhW8NE25vBdqufdl2J4SkUwC3+N9/IexFJJvukVMRWyEZSGA13x67g=
X-Gm-Gg: ATEYQzx8G/d66U3RMkvM7iuR7HvpJUFG/vlRWQnpt5+WUBfGxVSUFIsxDIoRLCtaS/l
	8w4ae8iJpdfpwJXkQWsUW5NLkcnQwV86z8HawWTJz3KjloWa+YHzT4WZ7DISW2t73UJ2B0Qa6KG
	0UDH49PE1LWdSz5+vx+TiYKIUfAzTs4GwfLTxFBlZECiLTYvmEIh7qXgWtY9yaqye3z1heGx5lD
	5EJf5WT8oUVKsjigofgjmiFBxOU94ytaB09fMERgfGNeZnfXfm5haNHjqO8C9CUUDRdLph51Ihr
	7h6DHIL+f50Nmm0r54HiaLckg1j7wY6zlPLwF+eziG5E5gTKYankTywX4rk2LrEMyw27cw15J17
	y/pzHzNZFC2iM3PG0xum+j7jAw61b0XXzjJ59sfAVtKDnxCcWHG+ouYUhp0BV6H8ACgj8dFoeDr
	HCiSjbvpLvwA==
X-Received: by 2002:a05:600c:3e15:b0:485:2f8b:55e9 with SMTP id 5b1f17b1804b1-4852f8b5ca8mr40634795e9.26.1772916676004;
        Sat, 07 Mar 2026 12:51:16 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b09b20d3bsm5854727e0c.16.2026.03.07.12.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 12:51:15 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Sat, 07 Mar 2026 17:50:56 -0300
Subject: [PATCH net v4 4/4] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260307-net-nd_tbl_fixes-v4-4-e2677e85628c@suse.com>
References: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
In-Reply-To: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772916658; l=1991;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=LfIxcEnbfF8UcBAlQpsEC60tpSn836JRskSf+FgYy7k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QA78kdashxAZg6QDOFTFJ5DdZ4/gEYZMYataFMliZwhtsqkFf/nfobnSy0f0fdVlTgoSW3hutmQ
 V6JaQ4aFi8AE=
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

Fix this by adding an early check in bpf_out_neigh_v6(). If IPv6 is
disabled, drop the packet before neighbor lookup.

Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support supplying nexthop")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index ff02dbe4c94f..3344fa0789f0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2228,6 +2228,9 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
 			return -ENOMEM;
 	}
 
+	if (unlikely(!ipv6_mod_enabled()))
+		goto out_drop;
+
 	rcu_read_lock();
 	if (!nh) {
 		dst = skb_dst(skb);

-- 
2.53.0

