Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF163264C1
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921628; cv=none; b=RZy/cpJgZu52QKKsd72ezw3snqVnWIVod7uK174ihz1E6GrL6jnZ5DJPHPxRCMTJ7dzAw06LAfh+6vwf50Ftlvp6jqtDwxd5veNihtmyUoCmatApYqwNyl7Feh6finHYwx/D2fu8jyHMpnann1ttmJYoUICiWJOdqYVooHy/KaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921628; c=relaxed/simple;
	bh=X1Xh75puVEIf2AgK7qiR8Iu8yQ2Qw0GXyTIhKX5ee8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H59e9mtN3JD8nuom6oo09+Hl/8UnyHfSNKdGfMwAXLOJeT9boqXhWoPMopOvb5Jc61XYzcSLVDp2gU8MiOLzbiEiac8eqljt77j6aZIV5iIRsl1dNN6otJKX30akTsMQqQSEYC7dtzZzuvHCqHBYRAyzE96cZnY+uMZe4m4XSSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlGPVekw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlGPVekw"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8541875f596so2585308b3a.0
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 19:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788921626; x=1789526426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/fZqpQBGjzjI/DxAL3lk605xnvz1wTJmXUd/sLpFD+Q=;
        b=HlGPVekw2RyG3wytO5zN/19Es33hbLKy0WSnXvb1Q841eId/oLFiGJPDTt+RZzssg+
         YOzXaI2NVXX+kGMo2yyL7i8SpFHfD87TYNEfV+wlalWYmn3I682+KqJXaLK+gCBGrvn0
         zM5OwWEtjYNyRu2WgFO7wuMjqnwPZAdVEDI56k4C8JiJfCMjVxb07qzjQ1a0AlaodsKk
         7J8tUnu9CIdi0P6bd0c4p5AssSA9+OkTxOmRqi5cAOqt2IiVLQ1358AxqzM9usZVaCLE
         ohSFyh3LRXqnHqLWAYnz0CkuuyXEdSTDh858WaPgf3UPeS49bysVo7zk9PAa08/MFDi2
         ZYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788921626; x=1789526426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/fZqpQBGjzjI/DxAL3lk605xnvz1wTJmXUd/sLpFD+Q=;
        b=H1QoB3jAetcSFb+jJFlOjSsPZLAUr7HZCIqep3phtVJn/vzSg0ALPpJgJmvha3wh/5
         Kat8he1DbohP2A2BpI6oyg9EWPRXx/Vk+2uc/LMyAxQxB5UiMZle1vu0kBAlTGKEMpjZ
         ncExxEjYikzA0caEA5kYOgp7SSDNwKZWbyZNecZWPN3pf6T4cPGXvN3mTnhChDPEekCr
         8HsQKB0hR4yY5OsaqEqOX0HbU/jmoT00Rg4AvGBDQOJbs1gofxe99ht1JGXf1NrLYmwt
         YKPXSKWdF5Wzpl3ZuL3DRfGuwjGTaXZbJnaura/7dh8gLnYyaDw0WiGZlg3W053CrqRY
         2JeQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyxsYvE8Z+nxyaeZ8f3/JURtZQMJ0B4MYp4ZcMuiMSK6IR6yt1jITeiLwNjh9qBcwvCZA=@vger.kernel.org
X-Gm-Message-State: AFuF++k8uYISvwVGJjcWIFWmGY+oDfbz+CUbFJ43lFmOTivv3tSxzU3b
	xfSEJR6UE/JmNpJUoTknOYYmFJw63PyyaoSk7OgTsgjRjXuE/98f+GbQ
X-Gm-Gg: AYBFou0TxtomI47dpKEjikSx/+k/ppZ1hZlfsBI8/qB1W4bHh/Fc2iPvT07aXVzcZs+
	9eglTlo+qVBVvyywEKe5/gdBMNoPCEL7UUi+2kWmd1N7a/L2c8oTLXp+qs3NH36wOYjfMwjxP/+
	iE65jt299oVLhcdaTA5EIWT4yaWBpZUJOZigAW/3kl9x5FoXDhZeZsicvjdQP/XR9v3KRKfl7yS
	bDjRTQ7Nz1B0LsqHZhnJ5PdrDS/N0U3IXuf3F38rMl+wPU11tCnQaILxZIr567l0lmVmE1GGh9f
	zwkI02HWhLSTKAmswqbHN0eNXo2MJ3LxU2VVFI0Azv1tVVff+HjpETgfi8+LEVRQDLxuyRmzuAP
	8YCjWji2T4tQsJACTUf9uWGwNFX4/3Bo8P2bQCPZP5nsXR37RH3bqoVJJBu6UeEc6fXBRJxygPj
	XsiZaZB51F6I6BRoWrhBWz+Y+9ygIp+dtWwOCkqExQYmQh4Ecg8Em1YaSNPcBu08h1lWRmjK8fe
	0lhfEEhalFpGtsq+wt4Vxh1ZwKm7YNtItcYAoyOWEgBSEdQQwNKPP4sXpxeDFQPWVFE/uvnXTLP
	FFob6VysHMyKhRb4atizD75sniCPuF3hFExrnzyqR0nEcQ3vs84N8NBSC5z9yBMoBlnSk+OFX5T
	w5n/fpOE1ndMS
X-Received: by 2002:a05:6a00:f0e:b0:847:770f:da4c with SMTP id d2e1a72fcca58-8616b17644bmr44258694b3a.16.1788921625629;
        Tue, 08 Sep 2026 19:40:25 -0700 (PDT)
Received: from bad.. ([43.227.225.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152045f74sm6270814b3a.10.2026.09.08.19.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:40:25 -0700 (PDT)
From: Nikhil <nikhilljatt@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org,
	dsahern@gmail.com,
	hawk@kernel.org,
	razor@blackwall.org,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: fix reading neigh ha in bpf_fib_lookup()
Date: Wed,  9 Sep 2026 08:10:11 +0530
Message-ID: <20260909024011.1252694-1-nikhilljatt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() copy the neighbour's
link layer address into params->dmac without any synchronisation, but
neigh_update() writes neigh->ha under write_seqlock(&neigh->ha_lock)
exactly because there are lockless readers.  A BPF program calling
bpf_fib_lookup() while the neighbour is being updated can therefore be
handed a torn address, and XDP/tc then forwards the packet to a bogus
L2 destination.

neigh_ha_snapshot() cannot be used here because it copies dev->addr_len
bytes while params->dmac is only ETH_ALEN long (an IPoIB egress device
has addr_len 20 and would overflow into params->smac), so open-code the
seqlock loop around the ETH_ALEN copy.

Same problem and same fix as commit 57549ab90791 ("net: bridge: arp/nd
proxy: fix reading neigh ha") and commit b824059a673b ("vxlan: fix
reading neigh ha").

Reproduced on x86_64 under qemu: a dummy device holds a permanent
neighbour whose lladdr is flipped between aa:aa:aa:aa:aa:aa and
bb:bb:bb:bb:bb:bb with RTM_NEWNEIGH, while an XDP program driven by
BPF_PROG_TEST_RUN calls bpf_fib_lookup() in a loop and checks that all
six bytes of the returned dmac are equal.  Before this patch: 211 torn
addresses out of 16300000 lookups (last one aa:aa:aa:aa:bb:bb).  After
this patch: 0 out of 38060000 lookups.

Fixes: 87f5fc7e48dd ("bpf: Provide helper to do forwarding lookups in kernel FIB table")
Cc: stable@vger.kernel.org
Signed-off-by: Nikhil <nikhilljatt@gmail.com>
---
 net/core/filter.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..6fdb85c9af44 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6298,6 +6298,20 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
 #endif
 
 #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
+/* Take a stable snapshot of the neighbour's link layer address.
+ * neigh_ha_snapshot() can not be used here because it copies dev->addr_len
+ * bytes while params->dmac is only ETH_ALEN long.
+ */
+static void bpf_fib_dmac_snapshot(u8 *dmac, const struct neighbour *neigh)
+{
+	unsigned int seq;
+
+	do {
+		seq = read_seqbegin(&neigh->ha_lock);
+		memcpy(dmac, neigh->ha, ETH_ALEN);
+	} while (read_seqretry(&neigh->ha_lock, seq));
+}
+
 static int bpf_fib_set_fwd_params(struct net_device *dev,
 				  struct bpf_fib_lookup *params,
 				  u32 flags, u32 mtu, u32 in_ifindex)
@@ -6491,7 +6505,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 
 	if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
 		return BPF_FIB_LKUP_RET_NO_NEIGH;
-	memcpy(params->dmac, neigh->ha, ETH_ALEN);
+	bpf_fib_dmac_snapshot(params->dmac, neigh);
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
@@ -6644,7 +6658,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	neigh = __ipv6_neigh_lookup_noref(dev, dst);
 	if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
 		return BPF_FIB_LKUP_RET_NO_NEIGH;
-	memcpy(params->dmac, neigh->ha, ETH_ALEN);
+	bpf_fib_dmac_snapshot(params->dmac, neigh);
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-- 
2.43.0

