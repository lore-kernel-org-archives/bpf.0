Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D75318EFF
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793312; cv=none; b=dxLcbQyOlARIyH5Dkk/AJIsi3k+KDKtS5FVGCa11eDjY7lTQSLfqc/8BYN81GDc3jgAzU2W6BpxC3cBL3Ha4i5LVBwIm921q0ctIKcP+kYhL1u0VNXc5oRLU9qGi6V63Z5lGiif62dzBJ09lwTWwNlASC4U9SFv6jUmIF3fZAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793312; c=relaxed/simple;
	bh=v/y7NXaWbJ6lQjdzR8N8Ksy8XPIBfzpcBd6y5+X6xcY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CEvWvMapThqABlO7ZIsGC3nMNsj5rvq2rChtKl4k0KUmfyqVFq+7Xejv+xkzjxyCBbmMIgIgKLVULx0c/bhQ7RwFT/8/rqZRfg5xdlyOOIvUhxpDwc1Qz741xtg2QtxttdThG1m9ROEaz8wg5wNc/4zzCg7twWLVdqLF1HofhUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ptmtu0MC; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ptmtu0MC"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-147be78cd56so7364178c88.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 01:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791793310; x=1792398110; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j/HfGjAac+AZaYIKh17jKsISYIpx8gEa0S85wJAbcwk=;
        b=ptmtu0MC0FZf26nwNy1PD9LrKtxFJa1fop433HtVfZ46RM8ELyjokb62rQzGaUG7mq
         h9Wjpb558BDrWhL4/GeIjlITxTsHTC92Cy+c+M2fG3Et5toZlbDHjJcYPiTqTvR03sBT
         s4BhER54ZtFRbRnwp0UuBJPgzzmAn+fWvRih6FwHOpS+wfnN6E0uTYStCpyNfMWxMor9
         b+FzOpm5Hq8Cp3DYXlwKlxNB/1Ls+CLCEPJgmvxctN3LfmntZZeASR/c7i0WBQ+Y/BWx
         QsfmzArTLlFaMDIl3khB+5i9xpcSbH6AXLh4hQcExoNB0y3mgFgPrepby6v9ttnZ1ED1
         SMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791793310; x=1792398110;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j/HfGjAac+AZaYIKh17jKsISYIpx8gEa0S85wJAbcwk=;
        b=R7XFksAv0H9LeZxNYRk7ltahbdbInWimsdClC9ekbzwfxttuE4NYGnXSIU2imN308k
         IkezprQvGJle3KGEiU5Sg+H3hEN8rXBwgfTlo60P1TULfyOo5wOTFnxAnjhlT4nceC3q
         6y/ypSsybPS3FulXf5y/X0b9t3SUBySIOH6s35iXzNbhbZcVXAjjkXGKeSTc2U1LmKb3
         RmgVrTmdOgl0MzRTI97AAd3SJy++LwkI+USQj7KA4xFBH0MJmR2y6zNEsTSAC/SSi2uw
         qp9PqyOr+vTcL44OLxOOUYJw5hSGWyKBqL5hhyYQAwOzrjieO+IVVJg8RMzhgbTjW/Ch
         59OQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjetsvGNqZcHxzOt5o8sKpEvkYdzxVR0x4MIQCBLeC+4AIPaFpLX2ZAcx84cE5kNTLVrw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+1RVo8glF/2LmlmA5/uBFQ8kqoArl99Y57/yYnyuT+L0tY3xs
	QK6ohNsIr4m7DSOKCXlzjFlz6XmTTwDejPKLSFTVJyAiVtHlrKVKJJWbryfUK0dRPRDL3ZP5tTw
	K2SYepDc1eCnDYC+bEyPl+JY3Hw==
X-Received: from dybco9.prod.google.com ([2002:a05:7300:a189:b0:352:3bdd:a9d7])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2713:b0:168:6ad8:e8b0 with SMTP id a92af1059eb24-16a6187f095mr14622288c88.14.1791793309400;
 Mon, 12 Oct 2026 01:21:49 -0700 (PDT)
Date: Mon, 12 Oct 2026 08:21:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012082148.1698596-1-almasrymina@google.com>
Subject: [PATCH net-next v2 0/6] net: unify symmetric netmem and page_pool refcounting
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=" <u.kleine-koenig@baylibre.com>, Jijie Shao <shaojijie@huawei.com>, 
	Michael Grzeschik <mgr@kernel.org>, Jakub Raczynski <j.raczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"

netmems (pages and net_iovs) have two independent refcounts: a non-pp
refcount (page._refcount or binding->ref) governing backing memory
lifetime, and pp_ref_count governing recycling within a page_pool while
page_pool holds a single backing non-pp reference. SKBs with
pp_recycle=1 own pp_ref_count references on page_pool fragments; SKBs
with pp_recycle=0 own non-pp references.

Core helpers currently mix these two refcounts asymmetrically:
skb_frag_ref() always increments the non-pp refcount via get_netmem(),
whereas skb_frag_unref() decrements pp_ref_count when skb->pp_recycle
is set. Any path that refs a fragment on a pp_recycle=1 SKB (or unrefs
with a hardcoded recycle=false) increments one counter and decrements
the other, leaking the backing memory while underflowing pp_ref_count
(e.g., IP-TFS [1], skb_split(), skb_shift(), and cloned SKB uncloning).
Unclear core APIs also led drivers and ULPs to open-code pp_ref_count
manipulations or add one-off helpers like skb_pp_frag_ref().

Unify fragment refcounting into symmetric pairs where each layer clearly
specifies which refcount it touches:

- Non-PP refcount: get/put_page(), get/put_net_iov(), get/put_netmem()
- PP refcount:     napi_pp_get/put_page()
- SKB netmem:      skb_netmem_ref/unref(netmem, recycle)
- SKB fragment:    skb_frag_ref/unref(skb, f)

Found by code inspection while reviewing [1] and confirmed with the KUnit
tests in patch 6; not observed in production. Driver and ULP call-site
changes are compile-tested only.

Link: https://lore.kernel.org/netdev/xfrm-iptfs-pp_ref_count-underflow-v4-1-912fa72106f0@secunet.com/ [1]

---
v2:
- Clear NETIF_F_SG in skb_segment() when frag_list SKBs mix pp_recycle
  flags (patch 4).
- Export skb_shift() via EXPORT_SYMBOL_IF_KUNIT() to fix the
  CONFIG_NET_TEST=m modpost error reported by NIPA (patch 6).
- Reset mac_header before skb_segment() and check skb_clone() results in
  KUnit (Sashiko), and extend KUnit coverage to compound tail pages,
  skb_try_coalesce(), TCP devmem recvmsg, skb_zerocopy() rollbacks,
  skb_split()/skb_shift() edge cases, and mixed pp_recycle frag_list GSO.
- Note how the issues were found and tested (netdev-bot), and add
  Assisted-by tags.
- Link to v1: https://lore.kernel.org/netdev/20261010083935.3274178-1-almasrymina@google.com/

Mina Almasry (6):
  netmem: rename __get/__put_netmem() to get/put_net_iov()
  net: skbuff: add napi_pp_get_page() and use it in tcp_recvmsg_dmabuf()
  net: skbuff: replace skb_page_unref() and __skb_frag_unref() with
    skb_netmem_unref()
  net: skbuff: replace __skb_frag_ref() with symmetric skb_netmem_ref()
  net: skbuff: use skb_frag_ref() in skb_try_coalesce()
  net: kunit: test netmem, page_pool, and skb frag refcounting

 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |    2 +-
 drivers/net/ethernet/marvell/sky2.c           |    2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |    2 +-
 drivers/net/ethernet/sun/cassini.c            |    4 +-
 drivers/net/veth.c                            |    2 +-
 include/linux/skbuff_ref.h                    |   64 +-
 include/net/netmem.h                          |   24 +-
 net/core/net_test.c                           | 1204 +++++++++++++++++
 net/core/skbuff.c                             |  161 ++-
 net/ipv4/esp4.c                               |    4 +-
 net/ipv4/tcp.c                                |    6 +-
 net/ipv6/esp6.c                               |    4 +-
 net/tls/tls_device.c                          |    2 +-
 net/tls/tls_device_fallback.c                 |    2 +-
 net/tls/tls_strp.c                            |    2 +-
 net/xfrm/xfrm_iptfs.c                         |    3 +-
 16 files changed, 1373 insertions(+), 115 deletions(-)


base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
-- 
2.56.0.385.gd3acb90ef8-goog

