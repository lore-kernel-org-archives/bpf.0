Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334711;
	b=VH4cBbr/RITTyGSwSOjDWLld4rWzHqKLCQpiDsaJHcLPVkur31JWGTVvQrDZ/VIoNpAB
	 mqpFDTjdBqU5vgDeHjwjKLy9J0FF1ShAzYDwor05P5K+d/lq5wvQFZsJSqVuWQA4Kzcv+
	 K8mWinQ9YY2FceB1w545njdrSUQcgBaAxYUPQuLT8R9cLNtgoePZbSM2lumHzuT1xg5Zz
	 tJ+EXZ09XAmV4wbGXftEvEJmGO7V/R7ieTHMe7PJd0vPlddIQLX77dCulZEKCaJNIyqWf
	 /pCZTcRQ9IGXZeGXo1FnQBxsiQHss7w9N6DnJbmutq2f6PApXDUFttnkpw1unWjN3xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=io8JORXoJvhQnQrjoZCgz8Xcl3owpfnw9TmdubvOgOw=;
	b=H0OFezIS3XqaRzDX8nEYJYLYJdYEaTz/JhH/2tik3ApcG8igamG2p0OpKqJ19eJAAGpt
	 Xsnw0RjDN5Me0c2LOThLS8c1wK4mLF27M/qZgIf6OaYQqAMhmrdb3UZ2FKJV2IseW5Wdp
	 d/sO9V0oUtPykTNOQ/9nxKCN1+/J9mxqBRDUUsXs0Wybd116V+jEipKzz+iFcuko1Qjtk
	 jIlH9E64nWMk1YB0mYB8vgZGNlDRO9HJ8GmGJs5PPTkRo3v4ZH6z3AxvAeySd9cqqYYYq
	 tqjHoQ2R6y0wiCDdRiLbHkPEz6H1AOcxIRk6sJAwfBXiLt2ReX4ougX5gI28wSEN+9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CowTEKHI;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CE8606A31F
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94CE8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CowTEKHI
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a01ea9e318so348505b3a.2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793334710; x=1793939510; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=io8JORXoJvhQnQrjoZCgz8Xcl3owpfnw9TmdubvOgOw=;
        b=CowTEKHI5sIJmXyky4r4dCX5ALZx+ZPyS2q31kY/7bqpb4J9Zz7Ughg5k72s0+J36w
         Cq11T3mUm2547HQfWuIYeoKdMgvfsqLj1loT02IERNVfLsOvlUyEIGJPoSjLtz/JRX7N
         astphQmvFEQ0DSlB4U5k1bB6sdv9PVwkREyxWZNWOzlHc+UdD2vOZDyrNwFlLKwx9hZH
         2JN3wc9IU0MbqWs2Uni+n5f1Vz8q2hLiD3s0ysUdMMADtkES2SSsgeNXDH/t6SY4jKEY
         XAXOF/1EV+LIQc1v5AHXwY7osxiEnRLSEFpHsTrgP7713lPIn/kCUcarlS6d/lwx/U2b
         HZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334710; x=1793939510;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=io8JORXoJvhQnQrjoZCgz8Xcl3owpfnw9TmdubvOgOw=;
        b=AJPIAq54NlFTFAFnQEKLxOSsG07Cb+nKKiQcz4uyXhe6DyxA7znJlDa+fgAJrwmSiz
         0fNbArtdFrfrnHaQ/VlFf2wsUH88XZMTItHINRaGqVRGte0mHvPO6SDfu7RBGUPCU3ui
         fzuCz6z7TDqjBQHg9HEGznVeyxFfcYS/Oz6LUE5SUkcWKBVWdKLnse7D+OVC4zAEv3J0
         6qg8qFH6KhusiioA26CQYmGfTODemJYpzIOxVmvPAZiML2UGy0Et4DUzvmkZG+9AKWDF
         s9Lk+FPToRK/B71A/qJsEtuTB3E0anIzKPoyN4ttKE1iBHrtV5R5oPUJSA/SArUj+QCw
         6vQQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+97Gs23vRoVFzzJbvcf2yAY2MoUOG9qgOsif2V1gtS7DsVDlHfSkvQuGXZkqW/9qmBMQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvKrZyrEo3J21ZerLEMX6cZZtMBDf+wdaqPXIbEhzw3BZVMA3g
	ZpD1yr9K5nEliHQ9Z1CmbsVExaakK7Tc8LxYkY6hOSL/Sh0ytHLnTjtowzKy7plUnpMV1A/9YUa
	p++zX+g==
X-Received: from pfbdr6.prod.google.com ([2002:a05:6a00:4a86:b0:8a6:c8f0:ec6d])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2388:b0:899:13ee:1bd7
 with SMTP id d2e1a72fcca58-8a9bf04faecmr1031284b3a.35.1793334709539; Thu, 29
 Oct 2026 21:31:49 -0700 (PDT)
Date: Fri, 30 Oct 2026 04:31:43 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030043145.2185700-1-weiwan@google.com>
Subject: [PATCH net v2 0/2] net: psp: preserve SKB_EXT_PSP across packet scrubbing
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

Changes in v2:
- Patch 1: Replace the skb_ext_del() loop in skb_ext_scrub() with
  skb_ext_reset() + skb_ext_add() (and a fast path when SKB_EXT_PSP is
  the only extension in the skb_ext buffer) so shared skb_ext buffers
  with refcounted extensions (SKB_EXT_SEC_PATH / SKB_EXT_MCTP) are not
  left half-deleted; clear skb->decrypted if skb_ext_add() fails.
- Patch 1: Make skb_ext_scrub() static in net/core/skbuff.c and drop
  EXPORT_SYMBOL() / public header prototype.

Link: https://lore.kernel.org/netdev/20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com/ [1]

Wei Wang (2):
  net: Make PSP skb extension survive packet scrubbing
  selftests/net: psp: test bidirectional data transfer

 net/core/skbuff.c                          | 31 ++++++++++++++++++++--
 tools/testing/selftests/drivers/net/psp.py |  8 ++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.56.0.317.g454f8302e1-goog

