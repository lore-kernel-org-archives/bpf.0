Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAC20FAA4
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776618262; cv=none; b=WPdpqqe91t+zNvX4JhbkrPVbuawIvL7qZ7n/GToA6NxQ56Q36rD+ziUSDk6bKw2obWWba/ahZlU4ScSl4upUoxDgX0q7KC15XM34a/HrkmJ0/DqbZxD+JA38gMIgle1gPc5TepRdZHmT1a1Q9ApxUmvWOLNqWZAEhSFz82aZc7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776618262; c=relaxed/simple;
	bh=d5uXQdHDSM5WNibQe7sItqY/lEY5kkJ+ZBgbfvz3YiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MM+e0LOhZeuEetpaJzVrycn/PinpR7yCAl3I6mvK7UClY4YV2AjB5Hb3F8qgkeoAphtMd6wqnJmHn9fpaOWmaQbAb5KU+08v1bSlrqwbWl7R+oCknHJh7WwanqiIXy/Mnj2fc5v8anqG+J7VUspaxv1ER+ZLBZGUYTgMLINniS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNmRi1eH; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNmRi1eH"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso2084929eec.1
        for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776618260; x=1777223060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mUhl+edUoBWXUMxF/sQgsZhHZE1YE75i6Jn1QoeaBM8=;
        b=NNmRi1eHgEdiANQIzI+XZ5ampofS1nwBD0hd+HsHac0R7v2CoxnZ2bi5cxeYBfJ9Xb
         x2dYCXaB7WxNXYz7yxzxmRLNTvbjSANF/ZcBpDmYhu/lVfvG0S2YtEhsaP34JBDDbZ5V
         0WuK4mm6hXwHkaOJYByxB9ZWwi2+2lSetlXdDvep6IJIKnKLoKjUKFnKbcGMFqjC+RnS
         6izh//x45TDTf3P0m5MACYIYk3HvdDp4Bz+kYRJt6j83LZdmWYDZRh1CLZvXMAnAbjIL
         i+0aVeTexydCDulgdcElqbj3VofTvOVLqj4Wf4zjeukcNEvIY6cePNkAoyp6wxE4WGny
         A7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776618260; x=1777223060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUhl+edUoBWXUMxF/sQgsZhHZE1YE75i6Jn1QoeaBM8=;
        b=sCM0PTOZap/kkRPmOQedoVX0qbIYE04XHtaQwQedEIypUyf2CDMAP9GBXpr5RpxR2w
         dPCSAcoInik/Z6LQfud4qreNDgyScBED2tG2YiJ/vA1b9Whw8TLxB06+xXsvnyeohIkg
         YpN3hgRu46cSHpci8/O5U5/76YkmZj08hB3+1fJL2hsvFYYcdd92I6M4q8rq3e8uMgF8
         TP+sELJY5jEvyY2S9vzPvtJ/A/vGSTMn/y73Tg7izup5HCG66C9EV0Zq97pSxj3GO355
         mL3hvwcY047OaJUa5Aeg2zGCqKGnAWe4UMH5b5iDkPK+TBTPhxLHI3OA5FY0TCNi8e5g
         jSsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JfQkXepfB/f/8c1BGxMjFHxfwnxt93NKfyzlRVEQUHgfSt2U/0BYXlKhjnI5MB992wLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz1llhDheREPvPbH93Bc2RAE2xhKoU4+KZRC2tSpPXUeP+CFPJ
	H1nlLCXZ8fymwm0EYOq4RVBGeCJcDqkWHT3L1mmKY7iy4bdPDFrzOAYy
X-Gm-Gg: AeBDieuzat7EhM9s7UuTZmP+ti2Y3BFaUcpboYln4/N7hAZxWmib0gwdB1Rdteo6flr
	eFdWcY3DPz94P8LSZydbOwx7GmnPj5dMdO5bVJBHJXCilRIWLohrZO5LTLGPezE/oJA3KqSYRjD
	wtIH+gW9JJKXnoHvQlhRxIFADnPJ7GTsvNKAFc69c8H5BW4ONOcseKNm7ukguQr4vk9zAKD5sy5
	HQ5BAVf2V6lxgiWs2ExeI4sMWGNe1rgh9+aLnfZ1oEyvxrwdr2HZoP5mJRmOqCz17k8sh7b3tKt
	68pVaAl5je21RL2gKL1LlpJ7NGQu9AoC6q9gRWtug0r9zC9rEHRLhr4ZiAo5PuBD3Bvo/xEbt4O
	oXQ1N3n3RNALMb593tehX3bO6Vq3/xaoZ+n4/WTpcUaCslgP4+R4eeZBm5NwkTKagG66e1UHe8a
	LnlIMSdwfLKWhi4S20sQVOvSWXIZHcDB/e+79erEBIK8Eujs0z0qZxyNSVYskWlNmH6X8mgddbO
	2Y/q05cxL2ej5eG+ETF
X-Received: by 2002:a05:7300:6413:b0:2da:a813:a60c with SMTP id 5a478bee46e88-2e4786462fdmr5212056eec.20.1776618260270;
        Sun, 19 Apr 2026 10:04:20 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d4bdaf7sm10129672eec.25.2026.04.19.10.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 10:04:19 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf] bpf: Fix NULL pointer dereference in bpf_skb_fib_lookup()
Date: Sun, 19 Apr 2026 10:01:32 -0700
Message-ID: <20260419170131.3899757-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tot_len is not provided by the user, bpf_skb_fib_lookup()
resolves the FIB result's output device via dev_get_by_index_rcu()
to check skb forwardability and fill in mtu_result. The returned
pointer is dereferenced without a NULL check. If the device is
concurrently unregistered, dev_get_by_index_rcu() returns NULL and
is_skb_forwardable() crashes at dev->flags:

 KASAN: null-ptr-deref in range
  [0x00000000000000b0-0x00000000000000b7]
 Call Trace:
  is_skb_forwardable (include/linux/netdevice.h:4365)
  bpf_skb_fib_lookup (net/core/filter.c:6446)
  bpf_prog_test_run_skb (net/bpf/test_run.c)
  __sys_bpf (kernel/bpf/syscall.c)

Add the missing NULL check, returning -ENODEV to be consistent
with how bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() handle
the same condition.

Fixes: e1850ea9bd9e ("bpf: bpf_fib_lookup return MTU value as output when looked up")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb0..3e56b567bd18 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6450,6 +6450,8 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 		 * against MTU of FIB lookup resulting net_device
 		 */
 		dev = dev_get_by_index_rcu(net, params->ifindex);
+		if (!dev)
+			return -ENODEV;
 		if (!is_skb_forwardable(dev, skb))
 			rc = BPF_FIB_LKUP_RET_FRAG_NEEDED;
 
-- 
2.43.0

