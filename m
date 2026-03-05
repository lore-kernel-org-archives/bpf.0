Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD3E344DAE
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772743076; cv=none; b=WIF9WyTypO/hCwxsmo7p6o3hgVocXBRfwtguyGXHoX7KYDyWuARvI11ueZRygUII7hS61QWyQw2waI012PDT8OP8RjvyPPl7/JLbZv9YMhfWX7qdNe3PF3B3mYN4rBf91EMWW1L4SLiQ+BW6iminMgAUjuFz1wiY1tLcZN6fHYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772743076; c=relaxed/simple;
	bh=BJNtUYfcCSIEf+KeHSlKgwI0CK0CjGEsuB477WGKkxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jwxKcjk14kmowFigt5giOQjsubw+p/NRRLSeQxos0oiEf9JxUUfx2O1cm5W4bSxV27hXwzrqvWU1QutEjoyME3VsMy9oNJIa5Cg2Z1yxzKbBKlDLuvOpzVdtNPvUoPh3HCi0ci/qTv0TsWFlANHX4lqP8fp0TtUYw652n5KSSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d40pxSfv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d40pxSfv"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48375f10628so56695695e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 12:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772743073; x=1773347873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iQa15gRV5WHmyp76havDhzqIhlaRupWnpaZaZ9e388=;
        b=d40pxSfvQg+T40WC4baDClvjkGivNBvgPsiskFs140c40hWoSXfX8PN7PeDorTS31G
         U0SZzVGlsToJ3T58uTfVTPrAX8HJQGNSrGfTzwyhZg/AfmIzTpF1wd0yTM2FjJAf+pI5
         l6EqbX6NaGSNrRtO66EENu6yu/ShkLrw2N4nJ4ZPUbreOAdKlQpqxUNm4OLhBIrmim5y
         9NoMIqG8Us39fHAi0ZGTzSdLTVz/w0oRrdGLpW+EmwuQ+FilrwkAQ3qEJy4Mmm2z5OM0
         Fwm8mQYV9EfQxuhHw+GaOpOY9s6tLtnyyR+ASCeNFBxf+Djhos4oExD6BzHKd1YUuncP
         zgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772743073; x=1773347873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5iQa15gRV5WHmyp76havDhzqIhlaRupWnpaZaZ9e388=;
        b=S6GVJQpiOi7dIug+IhbhF0RoFxL05Spsu2ycMJtTwow2NZ4aF2M2VOqouBdOLfd9wS
         rhshAZFg7fWkS1c7UnJiD2xjvfEFG6NxeAGClRGtlCkKkPLJMULQT94yNvuGJgfMKNOR
         F/g61+hXH/TpdTagxV8VmyrkZyv78grj6nQ+85oFuJ2Qp8/WZsXOoCW/R1SGdUmsIb8L
         08lL1LwEOOBzb/+poaPF8DmZyUjy+Yo6ejHKh8lODtLrJEOnbRaRKcFraobnzZ2qnw2+
         9Eacm2OVLmde/gocjbtJ7Dgigk9kWoxMdHOrlYCYWC6RyiOlqOVwm4f6tvPCKUDISmw5
         XAUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqDLLoYvdXowWkJNCbWsW2aDScZbYNZsPt/CBTmeno9FnCeC61uoOgSgLKm63v2r57sT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+UuHNxMZi9wszTTnsw/4DugiB1zWw59RtqeDUHqhcmNpSg9yU
	D398dNYkcfmsWzk7JkL77mqMZBwX47c5aZ6U8bp5DOlmUDcHAY6ZdAuOqeoATasdRww=
X-Gm-Gg: ATEYQzwhhVb1bqcsVTYuLdwbfK7demf/MyF+fHqnnICav+Oiqgg/w7f48ym/1dfr0UT
	A+GLarodEsaN++C3oLl7t/fl/Zt56CWawEkZ8aHu2esx9NESvkyLQIDtxddoZ9svUMYd26k2+3G
	SndipZbjDSgH5A5hzFMdorM9dHVSu1sZdB5SZYESoq09S5qbRYTTQ0AjzOHDTJCSjPX2ycK7qIe
	9wJQBmiAImNRS+IRarV4hvXAhte6QU0gknr5bhfBwGxJ0pNV4U9M8iHxoS7yC8SGnXyTh0lMkf/
	4glU+NcgY8cL/Dvz9YZj+gUbz9ugGzsjJjQ6VK1Sk3XaZDYJ2uLr2CBTZV7biTVYoRWhhKyYGcJ
	mKvU7jczYiWWnSZuP1XUrbhMCd9RCMb2+SWrMD5ynGqCpSLWq18ZXeOiTsf0otHKzkEvBdYXtMW
	fayJecQg8NAHVTAglm4W+3
X-Received: by 2002:a05:600c:4e8a:b0:47e:e9c9:23bc with SMTP id 5b1f17b1804b1-4851989fb4cmr108131025e9.30.1772743073493;
        Thu, 05 Mar 2026 12:37:53 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df65a2a0esm21503219241.12.2026.03.05.12.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:37:51 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 05 Mar 2026 17:37:40 -0300
Subject: [PATCH net v2 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-net-nd_tbl_fixes-v2-2-b7177db1a9f3@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772743062; l=2000;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=BJNtUYfcCSIEf+KeHSlKgwI0CK0CjGEsuB477WGKkxc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKpwaygzkyRw1nX1Db8ixqMTwa+zBHSzqsGzeC0nU7VvrPsKL8ySrGdrLXidS6fBHmhzLURON79
 y3rFPuYcGygw=
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

