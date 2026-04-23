Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A43AF67A
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969594; cv=none; b=aKdsv0/w5ka/4jXx0bdk8NRLyJO/pvSWtxpGM4H+MbYTsV7K7DqJw/iUoORJITjgeFJnZfzRLk5iotoV3zNFlQR8haKlXy91rsk8qB+y6YqBw+4EI+X5niAClpQUm7jtwkdAyPSxPJ6n5bZFlE56+Z0Hj0eiDfyVjyAh9hqx5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969594; c=relaxed/simple;
	bh=1FwyqCGRN4HjLKuDH3bqgzzS/Yl5LPQZ4J52Uyty7T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMCoP3gt455CJeuVk9IqDoJ8VjAhyD+fuYjZ9UO3987WJ5U7zWDXOhEkI0irVrALed4XAQrhM+2amebz7o3cF7bxi8TE5otmtyPAAvjyMTUi0Vh132WeE1BhaEcjZomAnUwNyXubdplnWu1+FGz2YPYEw/8XMdjLKDmwO1Aoybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7Z29wgc; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7Z29wgc"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso7429704eec.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776969590; x=1777574390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kO91trHtfz2ojIIwhMZveBPj5V7DEEylyXcbXYUhb0Q=;
        b=m7Z29wgc84t+CwDGIixYpNbVk4gwneOLajfRR6mG5JmUoV+Zun8ZWL5H7MwwzjcpwA
         ttmf6G0DtpKSCJmy5DzGrJ3IQL/p3wdefX2MSu4jonD0kT+HIzjatYmTwyBELtv/l+Tp
         rOU9L/p3xc2wzVdDPKT1+ArS8qa9wB68zetBlanVkRtRQIxIQ/LKyHRjZPHTOE3cTxAb
         q0xEPQTHo2FEktndWSu1BzzyfNsUyU03ZHMrUebyRM4hRziMR++mAgjfM0V3J1xAkANN
         vqICepgN/oeL2RSA/3hJq1ZCxIuqgVTFBOTVzyzb8AuyCfLFCKrPeZNOwo/0MmzlLTGC
         rdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776969590; x=1777574390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kO91trHtfz2ojIIwhMZveBPj5V7DEEylyXcbXYUhb0Q=;
        b=S8oP3iH6NzkYNMBAp0yvq05sfrwdV0HKPrze738i+ZRedPajv8jzggQAHFjImWpJu7
         sn4ZhJ0gGSrgUaHYqrj9XSLZMKEScqy9ptRTra9MNHb0XoovCgiyuCQcbwhDkCoWwzWr
         +baNhQj6o5uW+ytfZqXkkaVUg552nbD8k2YqvYYH0B5sZYw+0oRbC2wY8YpJ0s7qzHb8
         mDqC7bflnwoZP2DE2YZBFXMVJ6TrFa3T/9qVf6AEUwrsy9unPj7BGsivvWIi3XIJ0PI7
         28tGXYk8jMVIBHnhTBu+QKASwFLNkVuD0oXJT4s2LdPWDOqTwx03WZsLg1wOGuR6bpt6
         sOsA==
X-Forwarded-Encrypted: i=1; AFNElJ/lOlHkyXaD4GqyosK5a9DeVDKqIbzzHtf/vjixGjqNdE7THXQ1c/EDLUjaL+kKJuLnI2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+v+mhfozyQZukEWakzET7iwvWAhysc9XgCPSamCq3kC50a5sG
	FGIQ7MBW/4JgEBuWh4ArFl7ZUhJginU0aVNL5zRBL0phkNj7lv7FPLOd
X-Gm-Gg: AeBDietwqeG2PRoLZybwNnHfCw0pyCNWAmCR582tEQKOoYxSsW24JADrsBc3k9jlTBr
	UcSCq11kpK07AkHJOzB1GH+lEXRNYO2NKgfSrFe7nkValbvC4rY2sXFqWAlptjfmPKHvmccU4MD
	k+/BVePtn0L/2zlvIRGfh+vn99ChSj7jpZ+f1YA6vxGSVj6D5GtQ1T8OcgrXw6r/Z/QR8adh+EA
	t0rPdNQfekoIN0Pzc9W4WiwSfOAXZ6Kx2Ssr2CRTT0eVUEiCkidFgdluzJqnv1PlAbT3YbY/2Ef
	4qNM+xDWrLXvWxEkUEmMpfuUgAbOwc3sQ8rm3bmGdpfSvHSawPdV3/r1SSq53oY9kexLzQdIZ0M
	Zrcgwp1NO83yGx61YdEat7Ruousb7VTl+cLGm2/EZgP25lN/1xr1vIccla1gK9eF4tuqbevKr5P
	NwoVThIlKo8WohIWZxl7JasLhd1iEkEsgyMDmvcmuK7g9TQetfOPD6bG3Xat0OYn4zn0DrI3ShH
	aqyDxmoLXS40Bxc0682
X-Received: by 2002:a05:7300:6413:b0:2da:a813:a60c with SMTP id 5a478bee46e88-2e4786462fdmr15387478eec.20.1776969590172;
        Thu, 23 Apr 2026 11:39:50 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53dcb487bsm29283790eec.31.2026.04.23.11.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:39:49 -0700 (PDT)
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
	Weiming Shi <bestswngs@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: [PATCH bpf v2] bpf: Fix NULL pointer dereference in bpf_skb_fib_lookup()
Date: Thu, 23 Apr 2026 11:38:32 -0700
Message-ID: <20260423183831.1325480-2-bestswngs@gmail.com>
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

Fixes: 4f74fede40df ("bpf: Add mtu checking to FIB forwarding helper")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Acked-by: Paul Chaignon <paul.chaignon@gmail.com>
---
v2:
  Fix Fixes tag: 4f74fede40df, not e1850ea9bd9e (Jiayuan Chen)
  Add unlikely() to match bpf_ipv{4,6}_fib_lookup() style (Paul Chaignon)

 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb0..5b4aa9faa707 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6450,6 +6450,8 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 		 * against MTU of FIB lookup resulting net_device
 		 */
 		dev = dev_get_by_index_rcu(net, params->ifindex);
+		if (unlikely(!dev))
+			return -ENODEV;
 		if (!is_skb_forwardable(dev, skb))
 			rc = BPF_FIB_LKUP_RET_FRAG_NEEDED;
 
-- 
2.43.0

