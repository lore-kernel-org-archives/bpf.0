Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B463112BA
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772743073; cv=none; b=uCCcuAIn1toNP15eHNqXYhDsd/w9qFbnP2SAiUlJt2Yo81r5fEeTLMH8Op4AyWOrhhpAh5qehSTTnBRuCz0O75cJs/ujSVvfjaT6v3NU0BE4+pVqCmSubCVswqbEhXFFmBp3OzufzJy61WkjU3UgM4SWLWMkveHTjpgufSUdBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772743073; c=relaxed/simple;
	bh=Yfucwf5JHvyU/znf9S6sDQrRZ/qy3di3N5iSoXWL4aM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bPUjxp04yX6qQ4T1FqGf3O84BKMoR6NYt2HAkKK8q58wKb5IoX+VbPRkwirI/J79f0UJyyoDyrNtFgXAWXKdsrz8iCeqJkqx7HxQFT5V0zEMyQ1UrVAkmBD32Vtul5gMm0iI8CsJzkaTmD6eKZVOEpIJ2w9x3f9XC2LQ/gQwsw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OwYnViCU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OwYnViCU"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48375f1defeso64059865e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 12:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772743069; x=1773347869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qqlYUk2uLknCELv6zwONHG5x3atJmpFah5PNZJ3m1g=;
        b=OwYnViCUQd7q/FhqXzjz9Q8r4KoWEKZa/1pt39UHCDDILvlIgm+PK7qqo4Vlen4XXy
         2Z4rIFVx1DOj9kRtPCN5wbKFjxEjqzoEUuJ02KGLheB21r9V2LomJqBSr4mn0Qs3IIJx
         F3MTZCV6eeSc/fCcHPeWyoRYGbcTd3LUNPkTwOk/FhKGWMD2xwyJQUysJhI86E+ts30Z
         QbJ/dlzu4aSatL9iHEdQwfCLLuSFPLLC+25n5Ll6PItYogwGRsFzBPTz/8Rr6A/IVVd0
         oX3WdG94wBeovCVbLngT+x2pFaAU2/mrlK4mXyDzkEx5O685ylrzRTzqFMOJ3oMficqx
         Gotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772743069; x=1773347869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6qqlYUk2uLknCELv6zwONHG5x3atJmpFah5PNZJ3m1g=;
        b=Er6GdX2yDCqafV8dto3nWHPYJnUWitoOTNbMPYlZFMzRUOqKsLDAj8QOKb51lGU7Vm
         Yk9tjSp1RxaJF5QBu3F91z18EGo+szUxZug7oNM/zw2aMnaj0sZpQtPBgL/KqMbSNgIg
         w/9JToU9pOgmgQf7mWTHxlNjMA0xkZKLnkW+bTZRl7MnpMRpQdVrflXXLfRC1aGwBXAL
         WTnrrEo77qGqq64R/G15pJWVVnNmMUv+MDkaPpRngKBvhvJh14yh5eFQrLqEcEOTCEhp
         yA1at97KmGoMfwwSF0tunOD7noEfJciDZO2IOM06kSRGHxe/u/qOERPsXtnjYwJhOTyu
         tZfA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1oNpoCpzIbE88f37+N1rTxw6HAx1Aryk6Ndp2the2Y1JNrBfm5u2h7AMGHavDbFLPr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAfk+ZZ5jtMI3TPotWLP2QxXIyTqrtRppOK1be6yFQVz1SrLC1
	GD9Xrw0WntuGmNtILx+797Cb/Q6gmJbAdP72qRRr22waBgTpsN6PsSVpa0T5Lw9n56g=
X-Gm-Gg: ATEYQzxHapWreFMp9xyk9lSC6dSIbCfWksm0qXFXx5CudcyWyy5tfAwbdPG5kfN8o8z
	YtLJVr29QU5km8ynf+PYd7D0ZgxczAATYGCxdtIG84MT1JLfr7DuOoOoerhBxuk1crltWHeyPxZ
	KmO3lsqAnuyPwSMpybszMSsKukvm8pjIG5bZ1kilXIgyHiVYESkh1ScN2Bfi8M5W93PzZCWLWQp
	ivXLTk/S1F2vK2ZwSFxm+Fp30I4ByK2w6BMl/nVXh+kOlNvD9bEv/KaJ1q1vzY7AXe+vWSDhwCD
	Xc03HFWYfeIYO69OlE6QpgIrPZM6ZbuZdIx7v52fEHGEsn5KkOc5PyFXnAtFDyn50XnYG59oODc
	LZxcs9/Uih+7qLXc6/J55ks0+4/vmQXAMWpM31tEjCGovexW5Ajat97BZ9A8KmNdBq1p8IytLhf
	FY17qDmdtEbw==
X-Received: by 2002:a05:600c:3f10:b0:483:b01c:9508 with SMTP id 5b1f17b1804b1-485235a78d8mr14649615e9.2.1772743068926;
        Thu, 05 Mar 2026 12:37:48 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffce11d29dsm2610413137.7.2026.03.05.12.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:37:48 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 05 Mar 2026 17:37:39 -0300
Subject: [PATCH net v2 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-net-nd_tbl_fixes-v2-1-b7177db1a9f3@suse.com>
References: <20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com>
In-Reply-To: <20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772743062; l=2193;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=Yfucwf5JHvyU/znf9S6sDQrRZ/qy3di3N5iSoXWL4aM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QELA4fZ8Uu1G8uhu9+u3KMAefcDUWGgV/dwgvshG/ifXp0EaQKOUYgVehq7+ApJEY+ASGkfwf7P
 bFe0OGSXMmgI=
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
index 0d5d5a17acb2..ff02dbe4c94f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2335,6 +2335,10 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 
 		neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
 	} else if (nh->nh_family == AF_INET6) {
+		if (unlikely(!ipv6_mod_enabled())) {
+			rcu_read_unlock();
+			goto out_drop;
+		}
 		neigh = ip_neigh_gw6(dev, &nh->ipv6_nh);
 		is_v6gw = true;
 	} else if (nh->nh_family == AF_INET) {

-- 
2.53.0

