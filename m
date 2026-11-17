Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919643;
	b=yoNG9ODQKZInGF3EEs64GjnJOPu74XH/DzIe1t0DnTFXJN0UA6Kar+hPYv9BGRCN5gtY
	 XNQC9Ldtezh09D2qWpZxV4ECDvXkxd0LZiNDQ1JYae8ViO/SipIOgMlkSPrw705/jVP/R
	 g2SV74j1tpgF28NwSLOvDmRGIsbTtbI+7qwsgGGgRghwY7EM6DI7qAXb8/lLTgP8bsHiN
	 XxgU+WpOwxa8aOokXgGa9uHUlXrS+OQh25268P3cSPfbHVB4Qr9qh7353Kfl0hi3fZ8C/
	 s1dEimPFJoHex3sT6w4hcfFRgFR2PqdmWQRdFWz2LbE2+3btZZIze1JgMUtU55x6G+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919643;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=xPLY7t7bHKZomsKY+G59dgn7EtH6VF5+4KkiJGl79f0=;
	b=ZV7oHI1H7Wg3U4N9ZieLGCbGIFs4k/b2ugzqiL6JNuo9P0UagymaE3n9A69DB625Dj53
	 JNyvJ/nctPJJqLF8xr+WHg28z1MW5NC0egytQnVTYUtq/c16KKvWcdWma/oe4yqK7k5Ty
	 VLED5LAqsQo3KoT4Fm7/roJMh1oKc57lJKQCW2QYeMc51E98QPeDwT7uMnRvABS1qyYXI
	 J33nCEHqdlfgDPBdqjVEWovVDsbT0/NEKuQnQxDt4KZIxIJJvPfK3whePqwXDhGEe1K4k
	 R1CPYy+7CPOwsNKrfxH1TlFnFfVigvziMTbmXyqOokHJ/eQtBlr93KycyL6IT+Y37wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dS2L1iO4;
	arc=none smtp.remote-ip=209.85.222.72
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0857606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0857606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dS2L1iO4
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-99063f4065eso1193841241.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 04:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794919642; x=1795524442; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xPLY7t7bHKZomsKY+G59dgn7EtH6VF5+4KkiJGl79f0=;
        b=dS2L1iO4rOaMxm4v0JD+RkqQ8oAkda8BFIrZ3PLxJ/LIbESehE7PjZ7TaoZ7hRIf1v
         +x37Au0lh+8aAITx/tpJMBajQZyJzusSMx6o1r9JA94NGL7nnuF0I0VcP/xOEJBhoKIY
         bW0PeCpLDEsKbkNoVRCHciaDpyUEMtzAugCIIZhzh5QS/QJFY2VU7mKv1FUJo7ZKGir/
         qW1PF+VgUgXd4o8Ma7DGue55yfEXd3+AfYR/usy1dCLRpCslIAK1r4PPKGfK+WODt7Wh
         gy7YPalmZwi72Tk1bEZHAxjYtRcHYMErO88WaiODIzJ4PWRnQA9VQKWui7pIGStlQhXo
         OOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919642; x=1795524442;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xPLY7t7bHKZomsKY+G59dgn7EtH6VF5+4KkiJGl79f0=;
        b=Y8tuhZdBEqO9hu1EtEbWxkzodkmT+G6/GiXNa+6hUGFaH6VtVoCAeXeWYQ77Ac8HZt
         OjnLgpsf3V6/r8e5RZIRT0p3tq2hCG0ofnxgDI0uFODwaSthCRUzO2tl25pLVOm8S1po
         FcOrrp1K8SxGaUEQPZZBgeEqVhAs646ox/gelMh8ZORRx6d0p9pALlgFt/+5W9tFKPxg
         RUlqihhJUlsa/zhUML28nW9iCVn9f91mCDq+ikQsyXDsqEC7BSaAipmivo08F+E+lxH0
         LkdYUxkNd5G5UFQpM/U2sSWDQDL/xGbW8+zbv34OZtVQsACDSObLTlqYGUdaHMxInN8w
         57yA==
X-Forwarded-Encrypted: i=1; AL+hErEVFwTnO1dEdZJLtF9ncirOMIPAjKEyrdsCosxMZSk5B6rYlO4k32eClKrLxOdWwiWbQ2s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8v21BKqlKUKpytW5V/yyh9b/LdyrpiPmAcp9AHrGMYv9Rn7PoO
	tyJ79zB5errlkkaBZQiITwUKz7+3MN2EcER+QCHvXCmEWRkwSLe+7IpdVc825v1sl6Z5HRwc8oj
	ol0z9WORorfMiuKX9VWAxQx60Dw==
X-Received: from uapj19.prod.google.com ([2002:ab0:6453:0:b0:99e:daf:a436])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:6894:b0:7a7:5355:7fb6 with SMTP id ada2fe7eead31-7d64d82affcmr3760790137.24.1794919641586;
 Tue, 17 Nov 2026 04:47:21 -0800 (PST)
Date: Tue, 17 Nov 2026 12:47:08 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117124710.1338951-1-thaisonphan@google.com>
Subject: [PATCH net v3 0/2] tcp: initialize missing request_sock fields in
 syncookie path
From: Thaison Phan <thaisonphan@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, "=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ij@kernel.org>, 
	Olivier Tilmans <olivier.tilmans@nokia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, Stan Iliev <stani@google.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thaison Phan <thaisonphan@google.com>
Content-Type: text/plain; charset="UTF-8"

Initialize missing request_sock fields for TCP connections accepted via
SYN cookies, where cookie_tcp_reqsk_alloc() and
bpf_sk_assign_tcp_reqsk() allocate without __GFP_ZERO:

- Patch 1 initializes ireq->ir_rmt_addr and ireq->ir_loc_addr to
  LOOPBACK4_IPV6 in cookie_v6_check(), matching tcp_v6_init_req().
- Patch 2 initializes saw_accecn_opt, accecn_fail_mode, and syn_ect_rcv
  in cookie_tcp_reqsk_init() and sets syn_ect_snt in
  cookie_{v4,v6}_check(), matching tcp_openreq_init() and
  tcp_{v4,v6}_send_synack().

An AI coding assistant helped audit the request_sock initialization
paths, write the QEMU reproducer, and draft the changelogs.

v3:
  - Patch 2: clarify syn_ect_snt / tcp_accecn_third_ack() description
    for AccECN connections and reference RFC 9768 Table 4
    (Chia-Yu Chang)
v2: https://lore.kernel.org/netdev/20261116023709.132684-1-thaisonphan@google.com/
  - Patch 1: clarify how KASAN (via SLUB_RCU_DEBUG) exposed the bug,
    explain how it was observed, and include the inet_sock_set_state
    trace line (Eric Dumazet)
  - Patch 2: drop redundant treq->syn_ect_snt = 0 in
    cookie_tcp_reqsk_init() and clarify how the bug was found and
    observed via TCP_INFO (Eric Dumazet)
  - Add Eric Dumazet's Reviewed-by tags
v1: https://lore.kernel.org/netdev/20261114161248.3428695-1-thaisonphan@google.com/

Thaison Phan (2):
  tcp: initialize ir_rmt_addr and ir_loc_addr in cookie_v6_check()
  tcp: accecn: initialize AccECN fields in syncookie path

 net/ipv4/syncookies.c | 4 ++++
 net/ipv6/syncookies.c | 4 ++++
 2 files changed, 8 insertions(+)


base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
-- 
2.56.1.703.gf848ed807c-goog

