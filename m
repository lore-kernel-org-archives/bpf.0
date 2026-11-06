Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989212;
	b=x3qWnUGiTq0bfGqWQQ/M2ri8Is0qeXYebrwOelBI6ZTSPUOFAPKsiPs5saqmvl95hr29
	 QNyZgiV65eIECoOZU8/WcYeKkT1hNrjrAizMj7+a/quGBMg5RVwoF2Brr1dsffXEgiUD9
	 tsmwAF3pS+XUEwFG1baSHMLQ6f1iSi/9aIfXBgQw5Gh/eBFvcZv23Kjs/k67twoclezlK
	 9nKER/d8g5DgionOwKNyavrLMfc8gJr2tc7SidenuOn0fIc/ndxq032a+gnlxwfz+hoYX
	 KMrWMoeK2blbrsYDDfYnlXeI5qpFRlZSc2UP5lPrCf7TXVdI6xQmFareD3KCZrD8Wxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=71V+AIGlLe9tGQsH861SMnNvz1v73B93HY2pNoIeulM=;
	b=Z2q3qjGZMvSY1r5D1TuAFAMmZbzoWvsa7hzaiXnB/B8YdVRin1Ur/NEY1dx9MZSXW8WN
	 i6vZbPG6ETm5gDqs9GWNpNXMam+M7whVLOdWL0HBPOFpzCUk/gUN3ohfnirmWbYN7UGMo
	 FIEYjgrlSRg417uYfsT/Igt7WtQqxQWAjSthJQjt3xHtz1/U8SVLb5cv9OImYMkQAmqf+
	 hUBCezMAZ0MHJ/oNtbIR/qMPrOCmrS5VnqKsky14p8cB+IKYg0ijyi1dz7SqaXyeC4YKk
	 m0z6xP56a+jv14DzzXI/qR/8cCp92VrQ9+jbXk9XxlMxs2/uJFACyvPGE6Xr9iuQM1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o9R8LNPX;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7999606A32D
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 18:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7999606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o9R8LNPX
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e8dd9b9743so9565705ad.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 10:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793989211; x=1794594011; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=71V+AIGlLe9tGQsH861SMnNvz1v73B93HY2pNoIeulM=;
        b=o9R8LNPXDoSkSXW8WPh7f/AW7td6ABkMNhmRoubPFNbzsbnFVhrDENiceq4Xf5oC4s
         ZZAVoa1CLfXOtqOqy3rIxWYPLvuywa5adD5y5xsokdCJGVw74+MkYiacMnBBnhEkl2xF
         QCfz5zH2ByBLXlXp6lzPknqlMs2MuM2SrdAIMT3uG0ySoI0/82T/GLF6fI/DH3LH5Xpd
         Y/EsM8R3aYaEKaysndTpHUQAjWWITShqbY2ccW+Us1u2QUA4voZNRVcCSC/4uGCAcvUB
         ul1+3PFMVhqCNfJmNUficMF5yYVW2MMeJkUVpbzdqr2oBsYap2Tao+4+onELr1pwQ5k9
         SH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989211; x=1794594011;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=71V+AIGlLe9tGQsH861SMnNvz1v73B93HY2pNoIeulM=;
        b=hDM9KGiYlnB5ZVca6C2gBt2VV0OT8Go4pXDovu9+0HD4/CPFIaYdy4QQikkbHsQil/
         m8sijBe/y9pZbRoKVvtstiIMQmHlQ7ziJoXAP97Of+8iKxHSIUscev1r8CAJrS6xjSyz
         0tMMoLMOQPmiM+x0HXpOKsx2QZKri4M5y1BHrp2GeS80zUs+E4LksRKSQ8tQ+KaBdvep
         CLymrQswMrlpNio9suFJIuLVpiMbiH04JSJGEkjvvMrbyczXOCdA/R1xa50jUXcbpq99
         JDZbsyRM5nW5N2XhXeSd0/RyQqsvnGB3rYLOEFIYkPuaFtcZ+1tgmTfkqheFj+69f8TG
         BLAQ==
X-Forwarded-Encrypted: i=1; AL+hErHe7MP0G/9+R9S8kIsvWTefZ6lkmNZmE8mgllwHa5Kgv+ehp6tn5aYmVSoBE+s8KKPC8Mg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bKu580pVPLFpyyVHq+Ug30CUOCbtRANcRco0wvOlcQAMYOZKJ
	zVRjJcIRqM2m2wHDj/kpp2alpQQCFHJ2sTdoSeg6/JWbYPj+avL/99DjcUeSnlZ/nSZGb7ivl4p
	lhS+uFw==
X-Received: from pgq6.prod.google.com ([2002:a63:1046:0:b0:cc7:cad8:ada5])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52cf:b0:3b0:ae41:2706
 with SMTP id 98e67ed59e1d1-3b0db5f60efmr3709018a91.4.1793989210913; Fri, 06
 Nov 2026 10:20:10 -0800 (PST)
Date: Fri,  6 Nov 2026 18:20:05 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106182007.374660-1-weiwan@google.com>
Subject: [PATCH net v3 0/2] net: psp: preserve SKB_EXT_PSP across packet scrubbing
From: Wei Wang <weiwan@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"

When a virtual interface such as netkit is associated with a PSP device
in another network namespace via PSP_CMD_DEV_ASSOC, incoming PSP packets
decapsulated on the physical device lose their SKB_EXT_PSP extension
when scrubbed during redirection (e.g. skb_do_redirect() or
netkit_xmit() calling skb_scrub_packet()). As a result,
__psp_sk_rx_policy_check() rejects incoming PSP-encrypted TCP data
segments at the socket layer.

This gap slipped through the existing psp.py selftests because both
_data_basic_send() and _data_basic_send_netkit_psp_assoc() only sent a
unidirectional data stream from the test socket to psp_responder; the
returning pure TCP ACKs had SKB_EXT_PSP stripped by skb_scrub_packet(),
but were still accepted by __psp_sk_rx_policy_check() while peer_tx was
unset.

Patch 1 (originally from Jakub Sitnicki's BPF skb extension series [1])
introduces skb_ext_scrub() to selectively preserve SKB_EXT_PSP during
skb_scrub_packet().

Patch 2 updates the psp.py selftests to exercise bidirectional PSP data
transfer using psp_responder's "data echo" command in both direct and
netkit dev-assoc test cases.

Changes in v3:
- Patch 1: Move tmp = *pse; after the fast-path early return, just
  before skb_ext_reset(skb).
- Patch 1: Do not clear skb->decrypted if skb_ext_add() fails so
  sk_validate_xmit_skb() still drops socketless decrypted packets on
  egress.
- Patch 2: Replace s.settimeout() in _check_data_echo() with
  non-blocking _recv_careful() and _req_echo() helpers.

Changes in v2:
- Patch 1: Replace the skb_ext_del() loop in skb_ext_scrub() with
  skb_ext_reset() + skb_ext_add() (and a fast path when SKB_EXT_PSP is
  the only extension in the skb_ext buffer) so shared skb_ext buffers
  with refcounted extensions (SKB_EXT_SEC_PATH / SKB_EXT_MCTP) are not
  left half-deleted.
- Patch 1: Make skb_ext_scrub() static in net/core/skbuff.c and drop
  EXPORT_SYMBOL() / public header prototype.

Link: https://lore.kernel.org/netdev/20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com/ [1]

Wei Wang (2):
  net: Make PSP skb extension survive packet scrubbing
  selftests/net: psp: test bidirectional data transfer

 net/core/skbuff.c                          | 30 ++++++++++++++++++++--
 tools/testing/selftests/drivers/net/psp.py | 22 ++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

-- 
2.56.0.455.g6c5a503b38-goog

