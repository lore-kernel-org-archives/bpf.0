Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00B84301CC
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300821; cv=none; b=oAMgAZeklngl7W0iQT0jwc0Lf20GD66DhCTGsUpXFn4sisYdZt/6je9IZJyme0HPPVY2jK5umwh7UlYiiZ9IDWtsHnb1vn8pmHiAhxwV3b+plkDfQC6pkmj3IC63IO/xnVxbVX6Ubr9R5VvIKKi6Mb0H/K1RC1RwxvxrE8C/Lc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300821; c=relaxed/simple;
	bh=C4KUZeK1Hi7rfQcTxVhmRP3plJWRRKSRXeRWRjZLG2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ixkDjI9Izw6eQEZAQBCXb8AHCG5DhEW0ljJlAeyErFTTiOFavRT3kaOq2Sx+F12rA7mZ6YLs+oj092/P6L6k2Qr/Vm2WiM7PcLizxzfZmlpfXFaWKELs/5lgeD5D2WaBCPD5EVYSYbfd0arEiZEznaSGBQmontXuZc3yfi4FkXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WR0rMLVu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WR0rMLVu"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-482f454be5bso37114215e9.0
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 09:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772300818; x=1772905618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esHyrvwDztyurGcqLZ4eAcc1uKLaDOcfnZVfPZ9eJ00=;
        b=WR0rMLVug6/retEeZ4mzTXnn48o25xqKGLiwjHPqvlo/kX6PJFxYflXgFbqKAxK7Uz
         nDFbJ6jfmTx/RDGzFEWUsVI3LyK+m/5u5Xax9Mjn64OkrfEQ7vAxlbyg9Z050PlQZ1MW
         VJCS/WrcxrGaQApnxGsgcL5eWGCxkDnr1bazWQ5TWDy7EJnO90OTpHgQNbDAqY/OgrwP
         IXrfAC5D4DKp0g+cjLshIeeBI95KEUmN8X1DdcORpp5v72437Kowxxw9uxg3QNxS0+Ze
         0/IwQacxxCOTOW+0k7S6ZMdSZA+hziLhsC4HMCp1/JO/mJwHEMwSXMhdEYGQoIBP9ec9
         dL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772300818; x=1772905618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=esHyrvwDztyurGcqLZ4eAcc1uKLaDOcfnZVfPZ9eJ00=;
        b=pyVs05GfP1I9yhJLw84+AiJWr30/fVVT2NJasiVNEGn9A0Gd0ic+QJo94g7j+DRN9l
         HsFsE3UHCfCg8c0HXK6J7V00sjqo5XYiZHkSD1gkAaAuLWwJ2FaLgQuk0eLx6bJsXwJV
         kEiUkgdAfUslp/Zz810UnjVbxG7qMFxZYNRxya4XyF2hwUNcnLDbKR8iEYl6EifkLApv
         Lj3CnRnvAyjulR3uZNDkLwZ3rPON5S+t6aogcTlvhK+dV0gYOhoaq3ad5EVZa5UYLYrg
         +WKVB/qEXsKxDP+Pb2uK6j2F9+aJ8eJLdvi6Ci55p98TNBoZFOT0tQUf+8kDdY2b/0z9
         nGLw==
X-Forwarded-Encrypted: i=1; AJvYcCX8IOPC6GOG8jhjNmuTeLwtVj67ZcacaMyKQ/wsx3/UO8uG0SON46wT5xs32xrNYTtuYp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylq1VvGFF6/56xvAQVFePPJ6Tdj53Z4t+LOlQsF6vxcnjMpIM0
	dTflGsWSF5u+c8pEM9LP6EZLkOEz6Qa/+jIsRgwRNirRwZO0/3bZQlhyzrTmEKrcv/NCjSZO1BK
	qybYbVgU=
X-Gm-Gg: ATEYQzzw3YvGGD7h/Ue0xTBeSltcQ43r5737DEFnwEmDLdRPYA461g0PjrXcV9lYUqZ
	028lwApiQ46ujrewo9cd9R4oO+cp9aLXuyXtnTX+I5MwVszInyOqbbRc9Z4BoXYGJU3wW3esrA3
	7753LZfBatDAHvt4macavg5Ckld8XK3IsPX3zEO9UnT5b5HPhfQ9dHerm9mWWeCI9HF+pOyMbOB
	v2FE8uooA7lDtk+qqU1giItzXgZ886F9m+P7HeVWX2Kca0ALjUMCmfT7ADooHFjIC0eTPy7J4/N
	iJzHWu/9Of/3Llp2DNN3wPRKxXSp8h2Q22jvl4r7tyQHFBtGNvZovzX11tOOk4ym7Im8t9QF7tj
	8673VEcNcqa/kqQ4c+0uM/533Rwy8RZqfiRAOL5EdP7DvRRYkdZXvaOkVzlKP29CBoqC5oPXRlL
	pcez4yMKYG
X-Received: by 2002:a05:600c:4256:b0:483:6fe3:bb49 with SMTP id 5b1f17b1804b1-483c3192683mr117862785e9.0.1772300818191;
        Sat, 28 Feb 2026 09:46:58 -0800 (PST)
Received: from localhost ([189.99.238.12])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df65782f4sm7474139241.11.2026.02.28.09.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 09:46:57 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Sat, 28 Feb 2026 14:46:27 -0300
Subject: [PATCH net 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference
 when IPv6 is disabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260228-net-nd_tbl_fixes-v1-2-2b2a274df9bb@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772300803; l=1989;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=C4KUZeK1Hi7rfQcTxVhmRP3plJWRRKSRXeRWRjZLG2E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QATSOt0MBqXmmfLN1fQuQPIpcZOIRw0awhFQgAxRXUZGNukQbfeMMEZkMUFe6uV+SU1Bf5CQenM
 12cyI8o7mnAQ=
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
index 9ab2fae3a0d9..ad87c40f1393 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2228,6 +2228,9 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
 			return -ENOMEM;
 	}
 
+	if (!ipv6_stub->nd_tbl)
+		goto out_drop;
+
 	rcu_read_lock();
 	if (!nh) {
 		dst = skb_dst(skb);

-- 
2.53.0

