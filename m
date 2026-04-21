Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C881E2614
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786742; cv=none; b=Oh7FVYAB27YfgXqTCe4/edxmZOoCAUVY/gqNrpHGBkBh46xw63abei+JcnimiSb0D/UPoGpH+w3xY+2uaZcnXf1BhoUckaxF93owQpDl0pxMMbyAfgaJsw9YxJTCx5WMhXWAWwu3c7nwm3Vvofhy9AGrGNhQ1+g/ZUpE8qM5H90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786742; c=relaxed/simple;
	bh=5rJOMD2PEwPgKsY/Pomu1Z6FwKocBEb+ZZZlVkuvY8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NBYFu+qkoOqqQVIz54oR+JMkUIK2Wf3n/bzoMh2riLLgkHvCbZSwLBcrHmv34yxJxBxbR0TafKNRzmAmZNVgqqjHjcke1bVMX8e94QJCXbRBMbABs6UaFnpz/wMZqptjtsdEs/ovA9Rd0YgpCsNlmdvq2aDFF/wtITGO5RnbEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bykALty5; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bykALty5"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c19d23b19so5639539c88.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776786739; x=1777391539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45ymFIxphyJixlHGHv+r0Hhagbw0y8tExebfBXG9KLg=;
        b=bykALty5+dDl+lJ0FxYOONBVnf2BvBpHZ6lIbhBV09OR5RQJtxHE4B3IXLdx1bFv5S
         LCjb60Srb/AgKs4Rn7C+vviFQ4XVLhV4rn9OX1P2JnmD4Dd7jxTXY4F3Iavpw/wFgSm8
         4elYdm3PSEeP3gcgYJ5FdFJI0t5QhGKNR9e92Nn+YAfhQm/drk9O7cO0MJC7RFX+/KfB
         deP2242A+RC1/iCM40qkJRkMa79P5Aj1+IEv5A3AWhkKad2Nur3Lpp85VwO4fQs5ax9d
         /FE6dclR7xqGKftpGDGhEpkz4OyZqLYIuyh1EeQhOU//c18p6iImrK3b7B+xeiVqK5PO
         NDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776786739; x=1777391539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45ymFIxphyJixlHGHv+r0Hhagbw0y8tExebfBXG9KLg=;
        b=e/lPse/AFgAmRECrZVfJpaaSi0oGXUNOYz8JlEpv0r4tHVxuys9xJ/uG1cFbSg9498
         XCuwGYBt5CHPWYMgmfE8RMr+W0EzSaKjApHs021PDJKnT69/OGSHq9Qbd60iU/+skBZH
         AxBxlVXOTupNoUfk2JAs2Jin5MsOH1exa+wWcRP0zMShfu4JZ1slt3fCOiGJmuCEtEcG
         K1bGyajVqZGnuNJcpLA7LrUC7OPTbSp7mNZbkMbnYHjl3b/cUVF1jPl9Kl7f/+TV16wk
         3Je2FIv/ucwuFCPOd3dBgm44fiCFOwhRn9MeHznDrVuLVKRhxaY01ZPF/IAyvpEA6pym
         xwIg==
X-Forwarded-Encrypted: i=1; AFNElJ8JhrXeDpq89rwmKI2w7t2jMwJU+haAYfr11vRNVN4/6uqDNYp1u62E02XgtEbravqMa78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq2rGuOjRkkCb6FHTpASgeX6Te7/yQLEx4hEVTRaBWbyfx7iFH
	fIsMV8bVUkGZr3fKkat5l+mvVHlhOB+2tXH6NP2rIRBStNtBttlzNCDZWQgjFUMVFzk/BQ==
X-Gm-Gg: AeBDiescpUHczK34Rmm7+epiXeIm6VvcX6WOQqG21MYzivCGaF7+NAccIDLt0nadLXS
	7aixl+Aaea4ViEfO+TYTHSXJuyoYp+VHyoWUY752Aev0A+7B+VXbJ0SzKZuP9WoAd44jTDJJ643
	fsXP8QZV4cOEeU1Z/A/i2F2fz97WVs71/VPpytM+KDBgMjuDIQL+iZmLAsFfiNAxSy1wgyzFibJ
	p4xJ48Qy24Z1rnj28etzybAkuWMXeX8qoY1IEwCpCJojmhcmeNb0dQ46ls9kqwNpiOhybPRvTAT
	5VOr9G7XVIudTFrQxb5XLTLxBaZmwL4Ax7VlEGjJD2c+IAxfQJw5++c7uLumYIdnjdq8VTJgt61
	+Zrhjk96aL/XEAWAjrTBaHEsBVVdngysOiNHSjouvvHrT+e7xjYkTe40KJxkAp/P41W54v4MPFz
	pujQLI/ix3DS8EgiLXSY8tZfSKwS+YhCp64WyuueZAgXpYL4+k6tJv+sh4mLYC2xDkZMAkEG4GL
	14Tah520o4XY+n0Ei9kTej1KmDTntk=
X-Received: by 2002:a05:693c:2b04:b0:2e2:a4ba:84ae with SMTP id 5a478bee46e88-2e479017499mr10261853eec.25.1776786738589;
        Tue, 21 Apr 2026 08:52:18 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa3ce1sm18593484eec.4.2026.04.21.08.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:52:18 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v2] bpf: Fix NULL pointer dereference in bpf_sk_storage_clone and diag paths
Date: Tue, 21 Apr 2026 08:50:25 -0700
Message-ID: <20260421155024.997077-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_selem_unlink_nofail() sets SDATA(selem)->smap to NULL before
removing the selem from the storage hlist. A concurrent RCU reader in
bpf_sk_storage_clone() can observe the selem still on the list with
smap already NULL, causing a NULL pointer dereference.

 general protection fault, probably for non-canonical address 0xdffffc000000000a:
 KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
 RIP: 0010:bpf_sk_storage_clone+0x1cd/0xaa0 net/core/bpf_sk_storage.c:174
 Call Trace:
  <IRQ>
  sk_clone+0xfed/0x1980 net/core/sock.c:2591
  inet_csk_clone_lock+0x30/0x760 net/ipv4/inet_connection_sock.c:1222
  tcp_create_openreq_child+0x35/0x2680 net/ipv4/tcp_minisocks.c:571
  tcp_v4_syn_recv_sock+0x123/0xf90 net/ipv4/tcp_ipv4.c:1729
  tcp_check_req+0x8e1/0x2580 include/net/tcp.h:855
  tcp_v4_rcv+0x1845/0x3b80 net/ipv4/tcp_ipv4.c:2347

Add a NULL check for smap in bpf_sk_storage_clone().
bpf_sk_storage_diag_put_all() has the same unprotected dereference
pattern, add a NULL check there as well.

Fixes: 5d800f87d0a5 ("bpf: Support lockless unlink when freeing map or local storage")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
 drop the NULL check in diag_get(); The caller already checks smap for
NULL.

 net/core/bpf_sk_storage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index f8338acebf077..67901de5b9c65 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -172,7 +172,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		struct bpf_map *map;
 
 		smap = rcu_dereference(SDATA(selem)->smap);
-		if (!(smap->map.map_flags & BPF_F_CLONE))
+		if (!smap || !(smap->map.map_flags & BPF_F_CLONE))
 			continue;
 
 		/* Note that for lockless listeners adding new element
@@ -599,6 +599,8 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
 	saved_len = skb->len;
 	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
 		smap = rcu_dereference(SDATA(selem)->smap);
+		if (!smap)
+			continue;
 		diag_size += nla_value_size(smap->map.value_size);
 
 		if (nla_stgs && diag_get(SDATA(selem), skb))
-- 
2.43.0

