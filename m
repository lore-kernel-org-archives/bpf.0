Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD8565103
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999594; cv=none; b=fqgsh84ntjHmRQblcmjx+f5VftLsLdInTUtLLVAiYos48Rk1Q/0CnEWTrNQYMU70g8IVXancIHtdixP7411vhyNADwL9qrXvk70vgPTAcx2re3OKBeIunR6od8bMlI+2gA5R0fdY+1MzvPGGFrZqdA09EQbPLBBHmsucUyV9bWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999594; c=relaxed/simple;
	bh=hMv4iBxx6O92hM2zU/QK2E9aXxhMN43j6uu62715n2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TZsxWt/kk2ISNNfpNzQ4rMXNU2m3XIbvKwXIfhLF99FZZ6dxzpx+ZLZ3C1FTrNr3HbXiHJVuwG5IvURAx1d/0DJH3Gz6XjOXiwT+mvAif2xq6cHcAWsaG266m295HpxdRvcTiYjsdfmmaPArcWPRSL1llwcncBhTv/JBSeUeSyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXIK1prm; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXIK1prm"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14fed306427so3790941c88.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791999587; x=1792604387; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vaok2tbucgl2o15VmieqJKPHfx1IFv9p7RTK/Waa/Yk=;
        b=OXIK1prmxK7vgl1mwvSr1DnoC6m7Y4M05h1i8VlJsCGPzRq6dpRlDOue5Nhcay3UCm
         jI4L/6VvO6V2oLYR8R8Qon3N/rB3iSk07IF2KknNQJJ+germB22r7svi8dwzjHRAQGZm
         5O9ukzDQm00/1KuYisnGM6zX/r7Vd3/UH1h+rKSu1oVdLwyJCYv1kExo3CBh9hk5jZ6X
         Kg82XDCvR8D9F+FFL+NXjdwyDNCno4Vl1CIoxbPRXBxt2E2Z8uh2WL3UrsqL51iM82go
         VtwTKsVGUi5CMIeNtRsFSLNjYmE6RYZbaSOxHMXMpSQN4JkkXHcjX5HHEihMlHcg49Cq
         aGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999587; x=1792604387;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vaok2tbucgl2o15VmieqJKPHfx1IFv9p7RTK/Waa/Yk=;
        b=Nl0CBhkckzD0Gj5nj8AZhqTmPWwyYZMHUI1aGKKziH+GHMHT9LpRZhjtpbYvW8D3cG
         MLa/cq47Q8LSmi4zkoTTKKNSg13QUtQBGFniYnUZBAgVrBwuqCiNgw2JRwEGBIroYGTB
         mgkqh/AbHhiRMuzo9tBTN9bf9HTlbc2UZorZnRKeZhjY0Hp/4LUVyfeN5mSUVHRvQEdO
         VREhuq5X9EmkasZNz64mWbTW5fkiMW63/UF1b///+Jbds4WO6POK/owqwvOloRT6Nsap
         ZeX7LXn72wQOhP8CM9xMvRfgqRZGo8H470X9OPFRmxNvgelBvF0fUNuUW2Slgr1xM7Wb
         ee8w==
X-Forwarded-Encrypted: i=1; AKwUvBwWp2kN9luxZW22U51WuEB7sQVEBPAooCK2x/EwtfHIfyaf6OzST7W1XL/7jYSQK7slXKE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLF7of6jOcsGhoNWSCbBCDVzGCp+7WDZsv0gbnKMvP+V9cvr3W8
	feOyCbCfi4jNIG9rDRo8q8b2tWJknrpOWDrfVMhkyDgjFApnThQYSrQMWHJnlvSXQjf/QH8ouho
	SPQat/MZOutLC6xkzo5f3BIl7jg==
X-Received: from dldz19-n2.prod.google.com ([2002:a05:701b:4193:20b0:17e:6ff3:49a4])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2507:b0:16c:4eef:a526 with SMTP id a92af1059eb24-16c4eefb193mr22991853c88.15.1791999586939;
 Wed, 14 Oct 2026 10:39:46 -0700 (PDT)
Date: Wed, 14 Oct 2026 17:37:15 +0000
In-Reply-To: <20261014173945.373295-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261014173945.373295-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261014173945.373295-2-almasrymina@google.com>
Subject: [PATCH net-next v3 1/6] netmem: rename __get/__put_netmem() to get/put_net_iov()
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Petr Machata <petrm@nvidia.com>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=" <u.kleine-koenig@baylibre.com>, Jakub Raczynski <j.raczynski@samsung.com>, 
	Wang Zhan <wang.zhan@smartx.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

netmems carry both a non-pp backing refcount and a page_pool
pp_ref_count. Make the non-pp layer explicit and symmetric across both
netmem types: get/put_netmem() dispatches to get/put_page() for pages
and get/put_net_iov() for net_iovs, always acquiring or releasing a
non-pp reference regardless of page_pool membership.

Warn via DEBUG_NET_WARN_ON_ONCE() for net_iov types that do not support
non-pp references.

Assisted-by: LLM
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 24 ++++++++++++++++++++----
 net/core/skbuff.c    | 36 ++++++++++++++++++++++++++----------
 2 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 0cc8572f62caf..697d50c51a5ee 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -399,21 +399,37 @@ static inline bool net_is_devmem_iov(const struct net_iov *niov)
 }
 #endif
 
-void __get_netmem(netmem_ref netmem);
-void __put_netmem(netmem_ref netmem);
+void get_net_iov(struct net_iov *niov);
+void put_net_iov(struct net_iov *niov);
 
+/**
+ * get_netmem - acquire a non-page_pool reference on a netmem
+ * @netmem: netmem to reference
+ *
+ * Acquires a non-pp backing reference (page._refcount via get_page() or
+ * binding->ref via get_net_iov()) regardless of page_pool membership.
+ * Counterpart to put_netmem().
+ */
 static __always_inline void get_netmem(netmem_ref netmem)
 {
 	if (netmem_is_net_iov(netmem))
-		__get_netmem(netmem);
+		get_net_iov(netmem_to_net_iov(netmem));
 	else
 		get_page(netmem_to_page(netmem));
 }
 
+/**
+ * put_netmem - release a non-page_pool reference on a netmem
+ * @netmem: netmem to unreference
+ *
+ * Drops a non-pp backing reference (page._refcount via put_page() or
+ * binding->ref via put_net_iov()) regardless of page_pool membership.
+ * Counterpart to get_netmem().
+ */
 static __always_inline void put_netmem(netmem_ref netmem)
 {
 	if (netmem_is_net_iov(netmem))
-		__put_netmem(netmem);
+		put_net_iov(netmem_to_net_iov(netmem));
 	else
 		put_page(netmem_to_page(netmem));
 }
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b25d8e2c9aafe..23a40e1ec2b15 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7555,23 +7555,39 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
 }
 EXPORT_SYMBOL(csum_and_copy_from_iter_full);
 
-void __get_netmem(netmem_ref netmem)
+/**
+ * get_net_iov - acquire a non-page_pool reference on a net_iov
+ * @niov: net_iov to reference
+ *
+ * Acquires a non-pp backing reference (binding->ref) on @niov regardless of
+ * page_pool membership, warning if @niov does not support non-pp references.
+ * Counterpart to put_net_iov().
+ */
+void get_net_iov(struct net_iov *niov)
 {
-	struct net_iov *niov = netmem_to_net_iov(netmem);
-
 	if (net_is_devmem_iov(niov))
-		net_devmem_get_net_iov(netmem_to_net_iov(netmem));
+		net_devmem_get_net_iov(niov);
+	else
+		DEBUG_NET_WARN_ON_ONCE(true);
 }
-EXPORT_SYMBOL(__get_netmem);
+EXPORT_SYMBOL(get_net_iov);
 
-void __put_netmem(netmem_ref netmem)
+/**
+ * put_net_iov - release a non-page_pool reference on a net_iov
+ * @niov: net_iov to unreference
+ *
+ * Drops a non-pp backing reference (binding->ref) on @niov regardless of
+ * page_pool membership, warning if @niov does not support non-pp references.
+ * Counterpart to get_net_iov().
+ */
+void put_net_iov(struct net_iov *niov)
 {
-	struct net_iov *niov = netmem_to_net_iov(netmem);
-
 	if (net_is_devmem_iov(niov))
-		net_devmem_put_net_iov(netmem_to_net_iov(netmem));
+		net_devmem_put_net_iov(niov);
+	else
+		DEBUG_NET_WARN_ON_ONCE(true);
 }
-EXPORT_SYMBOL(__put_netmem);
+EXPORT_SYMBOL(put_net_iov);
 
 struct vlan_type_depth __vlan_get_protocol_offset(const struct sk_buff *skb,
 						  __be16 type,
-- 
2.56.0.212.g129ede20d9-goog

