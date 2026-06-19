Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC63C10B3
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888981; cv=none; b=qEz1OUEVU5tzZZp7FuAMFeqcIpco7kprQUn1yq0WcC974kFcjHmBHU4oji7JVZRQWQv0fAJ6+seFzuSdMbWX5dyFJEVwqoFCn/ExiZ3PhE6kzpbEO/8mevrViqsLt1UFW0ins6HO0DnSTDv4ZbWr8VIvDl5edEhkmknndR1K/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888981; c=relaxed/simple;
	bh=5Cz8io4XwM9zbG2vzsMVHkkGxGSSG7G3Ylj1fihEjls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u2G7QGe9BVytHzrwRG8Yg1+PiOKDA80fGIN3wnWAE6Wo4avYH98sXFEvFyl/G8R9OlXZbqxq5cdjdtPdFhweup/bxRvTFUZEAhPniqCnNjQnND6emQ2Z9pivGJdigWgAyhKX4jjE0+UfvQI8D9GN4goALBJzzsSlpOn3OMN9gDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JV5cI6il; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JV5cI6il"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso2644915a12.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781888979; x=1782493779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npcHSxG0m/aHLbt4AL5sRlKVlIL+7/LCZnpoUwYXLuY=;
        b=JV5cI6ilwTtO1mxVCXbwS6wH2NR8NPypgPkB+l4v+gPyyjP2z65jBAFz4tXCQ3GutO
         oe923h7yZL0b4bTre7grWbNgPV2KMhpsmt3aLGDdQHkbISkCksmGADKq0WMGIlgTWAYR
         3IJ1oK+BwclohU6X2kv4i6GftD9Ta7sYPn7yHC+06fl3htByAAOTFfRunnGDB0vY27Vr
         PX619WRzoN8RWOTzCEyaLkoDASj9sTf3hcREE69HYOnKBkc3sUsJybCtAN+wbBd8nOql
         J8IDp/BGXNWEnvZPoMloKj0jD/TEffvmcn5+DAzJpkLGL7a2tWkC29ACOMT5vK0gY7f1
         vIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781888979; x=1782493779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=npcHSxG0m/aHLbt4AL5sRlKVlIL+7/LCZnpoUwYXLuY=;
        b=YGFeUBh2F+2DGy0zefDsns+fFpcKqN1OR9Rkm/CPn4R8xbLIMnIcFx0Ypzjhl8P05M
         jbpYYsDv1O9pMhoL9E+/+LIGQTUDWXBAbEzLHQ9JpvESkTXrt7RAc1X6guseRZ6RE4y9
         z++9imXm/3wCyzXO5fbwrou3N8Tv6xb5SnE0N3siqg/tJOyYZJVjjGvGx/qFJsXV+qHF
         BSNvQqhzWVrEqS04wae/UJ8h7WEuaQ4oCyP7N7DIfLiqpyjVENcKlSqVLdCusJ0ZwDnN
         S9PU28I8umewDpBy+aVa8Y9Mdh7O3SSe8TsdLVNRkuXDxrkLFplvNSZHGFPYspq0c47q
         C5xw==
X-Forwarded-Encrypted: i=1; AFNElJ+0C9vcRBnE5D7ZMxiT52JnsBDioeDkURyE1Fw0TtZwcDHIDu+uGzB33GUAwGhSXUf73d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDwb6mVF2LcidJm/lEp19oISGsA2ykhVCRDc41aEc+TgwdYLb
	CrljAU6hRoF3y4dnh+a2FdOH36QIF9yMQ88XQtA1JSG1qZAHvQIJow9+Xj0qGI84oHg=
X-Gm-Gg: AfdE7ckNePYyDVh3jcLHEmxiPXKE0Q6OaRW8Lr0wOrlWezWkRcNj58FAE2lKSyiKI/m
	FIA6DCB8/du0ebPWFFIhM9Ksb6RLRtFa3nBNvblSz/fGSu9/qq1nl4Xk+4yfmCxqR+Zd/xkOpCQ
	JuLNskSVX0y/cp9dWT0TGOo+NJ8P7kQp0xRwm4sNgDsHDPMLsyHX67nAXzsUXh+e7JMCdZyH5a5
	0rIzimSR6A04o0NOO13EZ9Fs4dxaUwMjXlqgSTMRgIRniS0GwnmXxaWn6msaM2/n9rXC+sWP7D7
	tFB2FfjMhFCJYy4xMsYHtHVoNXIf+K1u1mb++ZcByvKZCl2ThN21nbQkNZVH73HCJyhMMG+XCnT
	agEENV2hNSo/CO9b0hsIvYfwx0SsbVny9clCrRm3dkJVYbw2nx6eJfGARG9DF+C6PLD4n6w7+ON
	coH/nQrUY9qFyLunBDtSs0+BpcvqJZb1/IYlBVAdZph8HzPcIaFWjUac1BHjA=
X-Received: by 2002:a05:6402:5186:b0:697:649e:98a4 with SMTP id 4fb4d7f45d1cf-697649e9ac1mr1212285a12.13.1781888978862;
        Fri, 19 Jun 2026 10:09:38 -0700 (PDT)
Received: from cloudflare.com (79.184.207.15.ipv4.supernova.orange.pl. [79.184.207.15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-696edc880b6sm1057088a12.7.2026.06.19.10.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 10:09:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 19 Jun 2026 19:09:28 +0200
Subject: [PATCH net v3 1/2] net: lwtunnel: Drop skb metadata before LWT
 encapsulation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-bpf-lwt-drop-skb-metadata-v3-1-71d6a33ab76b@cloudflare.com>
References: <20260619-bpf-lwt-drop-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com>
In-Reply-To: <20260619-bpf-lwt-drop-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2

skb metadata is meant for passing information between XDP and TC. It lives
in the skb headroom, immediately before skb->data. LWT programs cannot
access the __sk_buff->data_meta pseudo-pointer to metadata.

However, LWT encapsulation prepends outer headers, moving skb->data back
over the headroom where the metadata sits. On an RX-originated (forwarded)
packet that still carries XDP metadata this goes wrong in two different
ways, depending on the encap type:

1. Non-BPF LWT encaps (mpls, seg6, ioam6 ...) call skb_push()/skb_pull()
   and silently overwrite the metadata that sits in the headroom.

2) BPF LWT xmit calls bpf_skb_change_head(), which uses skb_data_move().
   That helper expects metadata immediately before skb->data. But since
   the IP output path runs LWT xmit before neighbour output has built
   the outgoing L2 header, for forwarded packets skb->data points at the
   L3 header while skb_mac_header() still points at the old L2 header.
   skb_data_move() sees metadata ending at skb_mac_header(), not before
   skb->data, warns and clears metadata:

  WARNING: CPU: 21 PID: 454557 at include/linux/skbuff.h:4609 skb_data_move+0x47/0x90
  CPU: 21 UID: 0 PID: 454557 Comm: napi/iconduit-g Tainted: G           O        6.18.21 #1
  RIP: 0010:skb_data_move+0x47/0x90
  Call Trace:
   <IRQ>
   bpf_skb_change_head+0xe6/0x1a0
   bpf_prog_...+0x213/0x2e3
   run_lwt_bpf.isra.0+0x1d3/0x360
   bpf_xmit+0x46/0xe0
   lwtunnel_xmit+0xa1/0xf0
   ip_finish_output2+0x1e7/0x5e0
   ip_output+0x63/0x100
   __netif_receive_skb_one_core+0x85/0xa0
   process_backlog+0x9c/0x150
   __napi_poll+0x2b/0x190
   net_rx_action+0x40b/0x7f0
   handle_softirqs+0xd2/0x270
   do_softirq+0x3f/0x60
   </IRQ>

That is what happens, as for how to fix it - a received packet that
carries metadata can reach an encap through any of the three LWT
redirect modes:

  LWTUNNEL_STATE_INPUT_REDIRECT
   ip6_rcv_finish
     dst_input
       lwtunnel_input

  LWTUNNEL_STATE_OUTPUT_REDIRECT
   ip6_rcv_finish
     dst_input
       ip6_forward
         ip6_forward_finish
           dst_output
             lwtunnel_output

  LWTUNNEL_STATE_XMIT_REDIRECT
   ip6_rcv_finish
     dst_input
       ip6_forward
         ip6_forward_finish
           dst_output
             ip6_output
               ip6_finish_output
                 ip6_finish_output2
                   lwtunnel_xmit

Every encap funnels through the three LWT dispatch helpers, so drop the
metadata there, right before handing the skb to the encap op. This
single chokepoint covers all encap types and all three redirect modes:

  - lwtunnel_input():  seg6, rpl, ila, seg6_local
  - lwtunnel_output(): ioam6
  - lwtunnel_xmit():   mpls, LWT BPF xmit

Alternatively, we could clear the metadata right after TC ingress hook.
That would require a compromise, however. Metadata would become
inaccessible from TC egress (in setups where it actually reaches the
hook it tact, that is without any L2 tunnels on path).

Fixes: 8989d328dfe7 ("net: Helper to move packet data and metadata after skb_push/pull")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/lwtunnel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index f9d76d85d04f..b01a395d9a96 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -350,6 +350,8 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
 	if (likely(ops && ops->output)) {
+		/* Encap pushes outer headers over the metadata; drop it. */
+		skb_metadata_clear(skb);
 		dev_xmit_recursion_inc();
 		ret = ops->output(net, sk, skb);
 		dev_xmit_recursion_dec();
@@ -404,6 +406,8 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
 	if (likely(ops && ops->xmit)) {
+		/* Encap pushes outer headers over the metadata; drop it. */
+		skb_metadata_clear(skb);
 		dev_xmit_recursion_inc();
 		ret = ops->xmit(skb);
 		dev_xmit_recursion_dec();
@@ -455,6 +459,8 @@ int lwtunnel_input(struct sk_buff *skb)
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
 	if (likely(ops && ops->input)) {
+		/* Encap pushes outer headers over the metadata; drop it. */
+		skb_metadata_clear(skb);
 		dev_xmit_recursion_inc();
 		ret = ops->input(skb);
 		dev_xmit_recursion_dec();

-- 
2.43.0

