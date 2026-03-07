Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712837A488
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916676; cv=none; b=tjsd9R0YVqwp46GlPW426MAcdgNJHF4qjrJPOgeBbRhpw6Qd9cn9EuwgOa6Z0wsxejrTk9BNSsMeFf9wzJEv+WTb8vwVOLKYguWXeJSYo9f6nHJjxh2zha5rprbCJREl83STba48Xq3Pkkmh8otmibMqgGitpXo+AQX3vkZ4Tbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916676; c=relaxed/simple;
	bh=6ZQFRvZdst5dX9ooPrNy2xeyWgmUkbigP/SKL7rpSfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGcOvt0186PSl/agIoihrQj60/pXjdukzM2QCs/waysKm19UfxAya3TgEtTdA1mpi8JAx2upoo0Lm8rnnMm8yQyunFNZE4GhjiLmDMCeyfkcsmmoO3TMXn58jx/v+Hurq5HT5aUqTuOF5sUD7KjtVLs51yTYkY2b6P/iuewlg5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EFEbyQPF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EFEbyQPF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48534237460so2570685e9.3
        for <bpf@vger.kernel.org>; Sat, 07 Mar 2026 12:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772916673; x=1773521473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sq24Ds5yyXWvt9Wqdyycsxol0O37NiUOJjceeuBF7w=;
        b=EFEbyQPFVkdmEbXFHIgdKb6x3PV1GD0BiLS3VK+Ae0oOoMgWWt9IK459EoE7UNWUTL
         s+Ppow+1Q626SoErzf1a2Nsq9DWo0F9O/9eNR0kd/CjHpBKip2E37eW44rVeWr65qEYC
         yBHeK1RObfgiEXjWTBsLHyWLxtkeYuXypbD8tRM+G/uwzhC/rst3sxJZEHSc5pO2Msj0
         oYEEtF7eEbdwPGKDB1ki+vdo/5utNBUKILHVhDhZw0mrtT6iSURoXBr+LzPJPflXh15d
         c/vZ48gUK9LtUl9mpO3zMQlGQVM6AHoPhL8zKVynmESjGZqEVWlMxn3k87MgvFWzPwkv
         WZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772916673; x=1773521473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/sq24Ds5yyXWvt9Wqdyycsxol0O37NiUOJjceeuBF7w=;
        b=CQU+TkQ3T7aSAqzmyL8g4qyqgBdKUqQ5mGOy5Zqvykn+RkEy/VMARdhGbzK58vOg1Q
         Aihj05hvc14T0XV47PA0FFDagPrsZ54DJxmp5qmsYj7R+8UV10f2uGgsGM39UOIJPsKG
         r5cQmGZmM3zp30XLYl5ekzp0TFvs13Dn9hkWNYhP+DODE5WwFN9UdDATf2orF0yV/jUT
         PswqbX9ie5ei3sdfd+XH3lNaFxNSTLUf1ENDDV0xFnrBAl/tILWXqCL0BOF2ejX+bL+v
         HjdIaIq2PlJkMO0wuN01wlk3tHInIYTmM2UgICd2zYB5Qwmto0jdYIcMPtO5IwbhkRXp
         oayA==
X-Forwarded-Encrypted: i=1; AJvYcCXYkgRcDC0iHeaROVX7btnafPnIR4lTEGeBksZxHn/+5TACbttt3Z0jSZOFyWF0QF2ouHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YysWNzT9bXn+95qVdILOjEdSHD+l9VO0MD8MfVZqnUaGtLAhoXU
	lecaQiwE4rX/f46UGmYqRPQYkGvwP8p35s0D4RvS323Y/ZQU21WhcL79OAnjtOk4f/o=
X-Gm-Gg: ATEYQzzQcBOuxiGFQ3E1BdZQskjL6Fnnu7FvhEJGzsQc2nS6+sMx8cTjFb8XQjHNeqi
	xmk2WNthZ7pKmzb76jgUML0a+YiuJ4lAm7uSgnIb6g8YCZn2f1mPh/9yxAuMVP4GDIrO/vaausZ
	7aDdarIRxxFanNEaweuqhBISSF2yWl72zATscjOevhUe+0wgxIWsip+9HTMBrMGixMQnZm3E1bc
	s/AI00+kqCzDeg/rpIgq/TuRKXQW+l6yx2ZKULPWplowuQTKhvEvlOEX6WVHfnRp3TaOq+b/wN2
	ZL/uOc+KOrDslKE73Y0xg1iVsv15HoVYCfPNQyy20zBv/lzkuCsWi6glIIptNFGJYPso2lpSvPP
	22C/MoFpr/vY7ehrBpUILwIq4p4S6YvDxToH11pNR4dsNo/Dt4lxXNWl5Wenx/IhaQXNnOn3evW
	4PMlxqdwbAYgSaExg7WI45
X-Received: by 2002:a05:600c:1908:b0:480:3a72:524a with SMTP id 5b1f17b1804b1-4852695943emr115413335e9.19.1772916673054;
        Sat, 07 Mar 2026 12:51:13 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b0f889ed2sm4065923e0c.13.2026.03.07.12.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 12:51:12 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Sat, 07 Mar 2026 17:50:55 -0300
Subject: [PATCH net v4 3/4] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260307-net-nd_tbl_fixes-v4-3-e2677e85628c@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772916658; l=2183;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=6ZQFRvZdst5dX9ooPrNy2xeyWgmUkbigP/SKL7rpSfM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFAMmuB9+HutmVwUmvb/O9FdutNnLHcZjnU2Jh0edZO9SUOTlxUABv8/vgtIANoEqc5Nwx84eFZ
 jg0AOfjJVqwg=
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
bpf_out_neigh_v4(). If IPv6 is disabled, unlock RCU and drop the packet.

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

