Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9664301B8
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300817; cv=none; b=gaHuQ9u3K8RyH4awBHO/9tgdA8WE63lYlsBc67/dhSzNemI46YqirhgqvObD2idvbwc+0MYjdOoYJKt471BRN8rFPzKq/mEjM2FebOj83jx57yih+obmokgJiR9xRDTyo50pv5HENz0n1fAV/n/zLSONbqFTXJJD2FLsFlkZe3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300817; c=relaxed/simple;
	bh=ucFGNhQbyvRgliJm2iclmlbV7LXFrBb9Ujgx98X8vXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BstY4nx13wKF2MciKsXA/DBtL4MSwk6xIKqJzo+QwQUhscJ6LX+V/zCnUH5accSrnkEvxzGrP6kS3awhTmQnyUPwW4jWXnRHYY5fvtlfDsNOS2IlD9JxU34ZQt/ETyNInp9xxkQDAoY1McR8Xg7PYrfLXwJemLwbN4GujQvZV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NsTZTRUW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NsTZTRUW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48378136adcso18056725e9.1
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 09:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772300815; x=1772905615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7g3kt179KaVjeiiNTGHXSByoR9j5QH912SUkq7k1du8=;
        b=NsTZTRUWKKQvZaSGJXfavNcGAC+2LOz8cSCD8iCBqxMC1KA3usvrImsbCw/7/dkZqq
         UydBcIUTnMPnOwizdf48XYmatQPhXAI+ikw53vxZG6D9bsYENXitL4AbWaJUmlT0cVUJ
         hFGrm5Er3elTIf040avIOlfMYHEKFFpOezN6LcVeWqzMq/L/UIEs+k5uWwWlZUG0hZEG
         ou8/FfDCY6QMx/SRv4hic4B8QtfbvUcbFeKEJfmyycmGwEcF7uwrok3X5M9yj0AO8zZ6
         VSyMk0h4Cclj1zEwbNSbDYlRMkJCPgzjmRy7Qer86a914XJxpZBtg0BFgaiUOjg4ZxhV
         Rjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772300815; x=1772905615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7g3kt179KaVjeiiNTGHXSByoR9j5QH912SUkq7k1du8=;
        b=JbDC3vHZHisIZ+KkSrdnQ4eFkzxw6bz+gy90GYoEMKFmblXqHUu69l78KIg43+p/F0
         ROwzI+dilaAYPM/55Sb/UByMbYZjo+u7b/JfRSD+wlmnDxP7tONc6Pb547XkRsYbGcm/
         OKPsWbsO2x4c7M9HJLlLImFEqzxqN08WrPTMlWlZw+CP7zLKEIjhCg9y3n7VQ9Loyyi1
         0L4SXGGY6tPdPMhLPEZqeqFR3IeuePT9Acl76cBvGfEjBnDaIeNqUDrIOmfaAlxS026b
         CAUuvliZy9GocMVgLbAZd1uWfL8nte1scTMB4DNMIl8zep90sIkZ3GCjamkFaLnClV/R
         RzUg==
X-Forwarded-Encrypted: i=1; AJvYcCUnYFg3Ie6NifN53SecizzkZTos/w5Ukd+KdgtKDqp3XmH6UlhdlN0S105YIHknXnFf6rY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtueg5klxDWjt+PApMv491fmIh6ssGosf5+ikTtS3mxL6TmyJo
	kKLwx4lDlZRv1VV65IpjVIAQUNUFN8V9MrvslDO/sCkjf4ymIWRUPXOk3mcnqhPk51E=
X-Gm-Gg: ATEYQzyxmV+0Cuz3kWg6Zil5HttzWbF+JbMVt9OZ5H98QZ99nKih0Wo3emS7j3ebxMa
	35Qu4q699VlEDfwHdY9gXysqptmCpBhz35DlyKYq4f8/NjWXxeOwpJjMiCwncHhqrlWxtnaD374
	bKPG2IjtEC0dhfsy4DbFf0KNB6h7SPjVl5Q+CLFFHD4/bZwMU/V6NY1FkcdP4gjpXbJ/usqKGWW
	DNRnW8a71IGx9Q84uMWSODlmGEHP6aM60sYIQ0LjkMVT1KXUvc2Rpg4vJypi8vwoT9ukLbmzLlC
	cXQDnkyC/mdf+HoiUNGlDkKSNWaEyBQr1nqubFmGTQudaRvhxoV8rWpB4ddgt+km9Dq1ispTW6k
	pvoz4nSLsK3yvJJwSn21fvTGL20UNFjvkQ8DqlrLI4zWOtJ5R7koDAqPRpdcVNfaL7REMTSqENw
	2QDTkd4yO+
X-Received: by 2002:a05:600c:3b22:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-483c9bff7b0mr109487805e9.22.1772300813862;
        Sat, 28 Feb 2026 09:46:53 -0800 (PST)
Received: from localhost ([189.99.238.12])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1ea116c8sm8808512137.10.2026.02.28.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 09:46:50 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Sat, 28 Feb 2026 14:46:26 -0300
Subject: [PATCH net 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference
 when IPv6 is disabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260228-net-nd_tbl_fixes-v1-1-2b2a274df9bb@suse.com>
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
In-Reply-To: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772300803; l=2182;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=ucFGNhQbyvRgliJm2iclmlbV7LXFrBb9Ujgx98X8vXQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLqZmcEzlqILSWD7UP8bPCY/O1xURrrkYnEZviyYV9TEw84KCTDDT97+pGEpf5s2Sx5NOTFb0HA
 dNu1zqk+zRwU=
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
index 0d5d5a17acb2..9ab2fae3a0d9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2335,6 +2335,10 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 
 		neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
 	} else if (nh->nh_family == AF_INET6) {
+		if (!ipv6_stub->nd_tbl) {
+			rcu_read_unlock();
+			goto out_drop;
+		}
 		neigh = ip_neigh_gw6(dev, &nh->ipv6_nh);
 		is_v6gw = true;
 	} else if (nh->nh_family == AF_INET) {

-- 
2.53.0

