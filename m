Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6746D2E63C
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701780; cv=none; b=cr+A+mEhatBPodCMSVsQgmJyeASlenBkI7+/drTybD2gb06ThYEsvXP74unpd6+TBukWccyEnAMx/aSmcxm9zyLWPNJmxedoMe3Xrd8Kg5hu3+TCIwSMsKcqy9Hyrav0hyEPdfLZKxSk8r4UbcHMSIil4TXEuKtcE0vxn+/k1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701780; c=relaxed/simple;
	bh=0RO+cn4XOSgeN0aZfQM5DIrCmQQEiJfa8/NprR8hbfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSZEqE3zuAuVCu5tFi9e7nuZEYQL/k3fHmedEFDD37XA2fAfzGq/xWjtOOU3PVeCtJVZDiOvzZf2eP7NErY6kKPoIAucPklYsEKQBp6PP13/RmQ0tAn3GLQYh2ZnVVZYq2/tkRkBW5siiJERG2DLf5aQFTJ/EaJPTsnZGCsO1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G19AvS1o; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G19AvS1o"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2e622a9da9cso157753eec.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776701778; x=1777306578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uqz6eVdmKi0qqROGlvTqXQYPBPAP8XJ0Rhi2kMv7Qfw=;
        b=G19AvS1oXw/nd00CD7GU8sgo9vcldiD3AyZ/oOKMeMYbMYhLIiCn2WmJgUoqQ4I5P7
         wApYJjYt3qHrQc2eQ38F4E7xJfMlsqbELLBy4dvf6VXZrV5WNUeDo40a+mCTyMPMeNVS
         2AKkoMpqMHF2dUbjH7eYVjFTy2/+rdIm9ZDZftms1jSqNEKKxfwryMx8GR1qGvWvhIe7
         UgRSAKYdjGR34LaC3g4PiRUN7bu50YhEJLAVQCtRNHYUtHwJNrTuxwP9g95Dwd1LF2be
         YPjsnSK21bCysvOMKIktsET8oSw/9d+2sk+3aJpmkIui7m8wON/o3G49pnNgzW/sO8SQ
         65yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776701778; x=1777306578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqz6eVdmKi0qqROGlvTqXQYPBPAP8XJ0Rhi2kMv7Qfw=;
        b=e7bdfXseXIKZa0ULxfT+0QHjysyoRBQfD1RTGb3EeM/cSMm+0WS8g+hk/Q9+KgkYt0
         pK0kKUZbcADAn0MkhcN9jplUeDuKAWRb2QM3W4fbfpurzQRE78pXv6ZoNj+dIcRB1AQw
         RHeVveCLeNci0aWl9lXZR41rezB+izwlyrngcAcPv5SFX+wamFAGiwI7gC3mH03iASg8
         1fNrprkJPPSnP65Y/YviWckMvYrVBtmZuS8xD/63tsJEO7JAmLpkQ/SLkyV3fs+VMT6c
         d7JTm08SC94Bsz1Ppgic5hY5Z4KKSrQEY1D00r3EJFcqJNZnRbDf32p/kliZ9P6So6Vy
         edQg==
X-Forwarded-Encrypted: i=1; AFNElJ+McEmGMNbXVRScOW73DGh4N7pH1j5g+VFNXiPueCDkuEZSUY5z9dMVAZ1fH2/b0NZAVmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjXAGyKP0zMGUAiUZIRLRpEw46//o9nQe7JxEOdIMnktbhnOPK
	RLTsInpOcIldALEafA2CPkBIrbODp8mJQpy/4HPFdrQlT2xBQoLz+EX7
X-Gm-Gg: AeBDieudOZehtIIwj42GkbSCOZyP9wswxibNpfOsMQAGAYnZ4Ojg9hDE9crhC8mUKGO
	YrV0PVNCqBYMGsUHldkvNqp07Eh3KCdqQWiNtgsjooQT1Nyy1Hfh9KB/EajCOB5jzbTpv6CtJsS
	R0oRJOKF42Lmercv/fwtkv0biPI8Z8r2zZ4tJ8lYp0ehxiDUSsFE8Jl/tIb/TMdLijJwYJqPHdD
	WAQObcGHLvTFM3zlhyNBmsr0HS466QozVUZSQb/LJRd0Bu/27HqVt9ijewNFFXWFilMjtBh/Fj4
	BWSoqzBkO/bjh/DvD6JxK8OYtQDvGOXiq4tytNEVnNR6I/SEYEUZpySAqoAOG93Am6tkdrw0zTG
	5fpz6TlFqR4OQJzywggvU/6nggIah0A4aD+QuilZDgrmNK9Z1QRBqS9NdJwysJQSEz+csn6FO4z
	FqUtE7ptnOhJuBIjgkHsGlWy0yr8gruSpPh0KcRv9y/zv7wv43drb/WDRmHiQtgrf4mijfrZS4X
	GBBf33XwPfOHM+EniyT
X-Received: by 2002:a05:7301:6085:b0:2e2:4979:eba with SMTP id 5a478bee46e88-2e465770d9fmr7343990eec.7.1776701778367;
        Mon, 20 Apr 2026 09:16:18 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfd3esm14914111eec.21.2026.04.20.09.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:16:17 -0700 (PDT)
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
Subject: [PATCH bpf] bpf: Fix NULL pointer dereference in bpf_sk_storage_clone and diag paths
Date: Mon, 20 Apr 2026 09:14:33 -0700
Message-ID: <20260420161432.3919396-2-bestswngs@gmail.com>
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

While at it, also add NULL checks in bpf_sk_storage_diag_put_all() and
diag_get() which have the same unprotected dereference pattern and could
theoretically hit the same race during an inet_diag dump.

Fixes: 5d800f87d0a5 ("bpf: Support lockless unlink when freeing map or local storage")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/bpf_sk_storage.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index f8338acebf077..3b487280f50fa 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -172,7 +172,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		struct bpf_map *map;
 
 		smap = rcu_dereference(SDATA(selem)->smap);
-		if (!(smap->map.map_flags & BPF_F_CLONE))
+		if (!smap || !(smap->map.map_flags & BPF_F_CLONE))
 			continue;
 
 		/* Note that for lockless listeners adding new element
@@ -547,6 +547,8 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
 		return -EMSGSIZE;
 
 	smap = rcu_dereference(sdata->smap);
+	if (!smap)
+		goto errout;
 	if (nla_put_u32(skb, SK_DIAG_BPF_STORAGE_MAP_ID, smap->map.id))
 		goto errout;
 
@@ -599,6 +601,8 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
 	saved_len = skb->len;
 	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
 		smap = rcu_dereference(SDATA(selem)->smap);
+		if (!smap)
+			continue;
 		diag_size += nla_value_size(smap->map.value_size);
 
 		if (nla_stgs && diag_get(SDATA(selem), skb))
-- 
2.43.0

