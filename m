Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CF403AED
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491732; cv=none; b=ckYUF113B+UX2Wyz09NPkIFK5XB6pgun74b2ozSKuEHEk114V0GyKFTHFYTwyyeV3ErvhJGjMksupRkdTaVw6y9x0a9vjgJeYuuX8RIMnelD4p2iKPBdoSQ11dShdvC34sEeXgMx6tFShA5m67o+Epgb6UAWmIfLfRSjuqc8og0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491732; c=relaxed/simple;
	bh=u4UFiko82A9oo6jDjjqR7lvD3n1v6npulk8uWYC3A9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=don6VngQ9yVxSZvL2vyZAMWVMOARtF2HUTd7Yv4iI4vpgp2LWUZBXJ+8t/s1I1L8vbtZQ28WsnqrfaVB2Pmyc4ntV860XRkJQnEk+Im7E/QrGC881Qzht8dsqdlnXM2vuaiGovwgKuqf6kx9cFABic6qPGGZzMhv1+7+g10XXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FL6BZ37p; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL6BZ37p"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso818555ad.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789491730; x=1790096530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TCDRZ9weVwG1Wz3S9zGQh/wTKxjjL9VQFaV4nXxX7Mw=;
        b=FL6BZ37popkupd+qSWbFcW0Y2TIWXGpD56kVYAxD1wYOxUJJPL8NyzQM4aPyKRK0Dt
         ddxUWztMOWgY8bQvPfJWjza/EVFhfXI2sb1LRLoxq4gpdfg3ylarMKzcv5/1zxKZcgo6
         xoA7L9pSsl00v2ILn7tdKpcFaQRZIXX6DnqUmxyjpSQJpyhd0wup/S20GA/9IeGYmuc0
         Xa8HJ3nKGMpgpeVYEfJxLp/VuJqSyijKU6qXHhrVrviP/SDEmB8RQD/JHNs34xv2VhYO
         vx6w98fO4jexhN0wcQOl9pFjaLZOAQNXOI1wIccSgi7rAhhys9o5/VKLTwClWQVZ9cit
         6t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789491730; x=1790096530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TCDRZ9weVwG1Wz3S9zGQh/wTKxjjL9VQFaV4nXxX7Mw=;
        b=UYcASNNeJt4rVSB9QWodoUhOndOEfDTHnvl2Fv0aDRa/LcWijwGoWC3f4MH/jzaxLX
         OefmzX9mZBDbaw5TAjLEGntbIz+2mOcng0XWJLwnyX3QME/oawZqTeDcapaAc5W9WnbW
         AfN1QatmS/VLqCtLyxr5/+vCl5ATI/wdiN99juwvvBMUg4lkoIbDOqQKLOtgTjWSofqw
         OeA4XddZ2KOLKTQmB4xWQBjj7wG25rFF7Lm1nQikjw9vyDy+fXaHy/lB64mHIVqWDMV4
         LsvjF599VdsX1wEp4EqfJpEZr5EvFQEf8ACALrRjTxZZUJ58qw/2vAu7hYvx14HDysa4
         7yBA==
X-Gm-Message-State: AFuF++lTNrvwQhOKa8J32198hbYU9cAtT/tu3k67Y0h4lTi0pOIfGwuB
	ogfHPeS6+7/hIVlT2LsJY7Q2NxzBLseFpa/Dx32tC0LjD2t0XDi83vGa
X-Gm-Gg: AYBFou2Rvxlho+Ptde1iuAWwdZcvCmn1iFF9MDbcnOQd7mjeiwfWsxf84KZvzuA0Pru
	Cef5lpxGURLtZrOpAMlYDhre+aOY+v1m026gjJf4jFJ1YE5pG+Jsta8mCi/BDCl/UGrIQc0eM+j
	LDE9IiModeV9v923zsyBgccwuLSjfAPxVPuRU/6y96xqwIdaAub77u+GdRtQ/RDw/iy8ly/nSMR
	qqjjWyfVCOlYPzVVJiPKDWRMq3PWU5VPNc7utH3PdSMtFLOgiWT84KihG2QWOWLTq8z8CmT8+I6
	qAl2NvuE45C0ZBFzN7fthKxVzgb803rYdMXuWHwILYVrYyFX1FcpztgONxAz9vRYToH7xdtYAiu
	h1simcEpOhRf5R5BTa/KSutn/HJWB6o+NsNSwYoIISSD1URbweTU7qJEpo8EWg+MZCKiHx7F9jZ
	z76EQvjcdFNt+wfoAKwiGEXGwRvVtngUK77Og7+U96ubBBewBbVEP7bUGhnFfyk4ba5oWga/knn
	bal/fhLifXlKfH9YYQ9rsRVm3W4tMQf
X-Received: by 2002:a17:902:c942:b0:2d8:df44:a5c2 with SMTP id d9443c01a7336-2dd8387cbdbmr33512745ad.20.1789491730384;
        Tue, 15 Sep 2026 10:02:10 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd34c7f976sm68439925ad.81.2026.09.15.10.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:02:09 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Peter Oskolkov <posk@google.com>,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] bpf: clear stale IPv4 options after LWT encapsulation
Date: Wed, 16 Sep 2026 01:01:48 +0800
Message-ID: <20260915170147.3943392-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang Mei <xmei5@asu.edu>

bpf_lwt_push_ip_encap() rebases the network header after prepending an IP
header, but leaves IPCB(skb)->opt describing the inner IPv4 header.  An
ingress LWT route can consequently make an ICMP error interpret an
inner-header byte as an option length and copy 255 bytes into 40 bytes of
stack storage.  The trace decoded with scripts/decode_stacktrace.sh is:

  BUG: KASAN: stack-out-of-bounds in __ip_options_echo
  Write of size 255
  Call Trace:
   <IRQ>
   __asan_memcpy (mm/kasan/shadow.c:106)
   __ip_options_echo (net/ipv4/ip_options.c:96)
   __icmp_send (net/ipv4/icmp.c:949)
   ip_forward (net/ipv4/ip_forward.c:176)
   lwtunnel_input (net/core/lwtunnel.c:465)
   ip_rcv (net/ipv4/ip_input.c:612)
   __netif_receive_skb_one_core (net/core/dev.c:6264)
   process_backlog (net/core/dev.c:6728)
   __napi_poll (net/core/dev.c:7787)
   net_rx_action (net/core/dev.c:8007)
   handle_softirqs (kernel/softirq.c:645)
   do_softirq.part.0 (kernel/softirq.c:546)
   </IRQ>
   <TASK>
   __local_bh_enable_ip (kernel/softirq.c:473)
   __dev_queue_xmit (net/core/dev.c:4961)
   packet_sendmsg (net/packet/af_packet.c:3143)
   __sys_sendto (net/socket.c:2281)
   __x64_sys_sendto (net/socket.c:2288)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
   </TASK>

A helper-only reset can be restored by bpf_prog_run_save_cb(), while a
program without ctx->cb[] access can clone-redirect the skb before a
return-only reset.  Track active LWT runs and their control-block family
in the BPF network context.  Reset it immediately when the control block
is not BPF scratch space, and after bpf_prog_run_save_cb() restores it.
Preserve the state across nested runs and retain the ingress interface and
L3-slave state when the protocol family changes.

Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: LLM
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 include/linux/filter.h | 10 ++++++
 net/core/lwt_bpf.c     | 81 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 39decde7fc730..0edd3e6ce563f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -848,6 +848,15 @@ struct bpf_nh_params {
 #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
 #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
 #define BPF_RI_F_XSK_MAP_INIT	BIT(4)
+#define BPF_RI_F_LWT_IP_ENCAP	BIT(5)
+#define BPF_RI_F_LWT_RUN	BIT(6)
+
+struct bpf_lwt_ip_encap_state {
+	int iif;
+	__be16 cb_proto;
+	bool l3slave;
+	bool cb_access;
+};
 
 struct bpf_redirect_info {
 	u64 tgt_index;
@@ -858,6 +867,7 @@ struct bpf_redirect_info {
 	enum bpf_map_type map_type;
 	struct bpf_nh_params nh;
 	u32 kern_flags;
+	struct bpf_lwt_ip_encap_state lwt_ip_encap;
 };
 
 struct bpf_net_context {
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63de..762d62c959f9f 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -36,19 +36,88 @@ static inline struct bpf_lwt *bpf_lwt_lwtunnel(struct lwtunnel_state *lwt)
 #define NO_REDIRECT false
 #define CAN_REDIRECT true
 
+static void bpf_lwt_reset_ip_cb(struct sk_buff *skb, __be16 orig_proto,
+				int iif, bool l3slave, bool use_new_proto)
+{
+	__be16 cb_proto = orig_proto;
+
+	if (use_new_proto)
+		cb_proto = skb->protocol;
+
+	if (cb_proto == htons(ETH_P_IP)) {
+		if (orig_proto == htons(ETH_P_IP)) {
+			memset(&IPCB(skb)->opt, 0, sizeof(IPCB(skb)->opt));
+		} else {
+			memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+			IPCB(skb)->iif = iif;
+			if (l3slave)
+				IPCB(skb)->flags |= IPSKB_L3SLAVE;
+		}
+	} else if (cb_proto == htons(ETH_P_IPV6)) {
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		IP6CB(skb)->iif = iif;
+		IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
+		if (l3slave)
+			IP6CB(skb)->flags |= IP6SKB_L3SLAVE;
+	} else if (orig_proto == htons(ETH_P_IP)) {
+		memset(&IPCB(skb)->opt, 0, sizeof(IPCB(skb)->opt));
+	}
+}
+
 static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		       struct dst_entry *dst, bool can_redirect)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+	struct bpf_lwt_ip_encap_state nested_lwt_ip_encap_state;
+	struct bpf_redirect_info *ri;
+	bool lwt_ip_encap, nested_lwt_ip_encap, nested_lwt_run;
+	__be16 orig_proto = skb->protocol;
+	bool l3slave = false;
+	int iif = 0;
 	int ret;
 
+	if (orig_proto == htons(ETH_P_IP)) {
+		iif = IPCB(skb)->iif;
+		l3slave = ipv4_l3mdev_skb(IPCB(skb)->flags);
+	} else if (orig_proto == htons(ETH_P_IPV6)) {
+		iif = IP6CB(skb)->iif;
+		l3slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
+	}
+
 	/* Disabling BH is needed to protect per-CPU bpf_redirect_info between
 	 * BPF prog and skb_do_redirect().
 	 */
 	local_bh_disable();
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+	ri = bpf_net_ctx_get_ri();
+	nested_lwt_run = ri->kern_flags & BPF_RI_F_LWT_RUN;
+	nested_lwt_ip_encap = ri->kern_flags & BPF_RI_F_LWT_IP_ENCAP;
+	if (nested_lwt_run)
+		nested_lwt_ip_encap_state = ri->lwt_ip_encap;
+	ri->kern_flags &= ~BPF_RI_F_LWT_IP_ENCAP;
+	ri->kern_flags |= BPF_RI_F_LWT_RUN;
+	ri->lwt_ip_encap.iif = iif;
+	ri->lwt_ip_encap.cb_proto = orig_proto;
+	ri->lwt_ip_encap.l3slave = l3slave;
+	ri->lwt_ip_encap.cb_access = lwt->prog->cb_access;
 	bpf_compute_data_pointers(skb);
 	ret = bpf_prog_run_save_cb(lwt->prog, skb);
+	lwt_ip_encap = ri->kern_flags & BPF_RI_F_LWT_IP_ENCAP;
+	ri->kern_flags &= ~BPF_RI_F_LWT_IP_ENCAP;
+
+	if (lwt_ip_encap && ri->lwt_ip_encap.cb_access)
+		bpf_lwt_reset_ip_cb(skb, ri->lwt_ip_encap.cb_proto,
+				    ri->lwt_ip_encap.iif,
+				    ri->lwt_ip_encap.l3slave,
+				    (ret == BPF_LWT_REROUTE &&
+				     lwt->prog->type != BPF_PROG_TYPE_LWT_OUT) ||
+				    (ret == BPF_REDIRECT && can_redirect));
+	if (nested_lwt_run)
+		ri->lwt_ip_encap = nested_lwt_ip_encap_state;
+	else
+		ri->kern_flags &= ~BPF_RI_F_LWT_RUN;
+	if (nested_lwt_ip_encap)
+		ri->kern_flags |= BPF_RI_F_LWT_IP_ENCAP;
 
 	switch (ret) {
 	case BPF_OK:
@@ -604,6 +673,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool ipv4, int encap_len)
 
 int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 {
+	struct bpf_redirect_info *ri;
 	bool is_udp_tunnel;
 	struct iphdr *iph;
 	bool ipv4;
@@ -657,6 +727,7 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 	memcpy(skb_network_header(skb), hdr, len);
 	bpf_compute_data_pointers(skb);
 	skb_clear_hash(skb);
+	ri = bpf_net_ctx_get_ri();
 
 	if (ipv4) {
 		skb->protocol = htons(ETH_P_IP);
@@ -669,6 +740,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 		skb->protocol = htons(ETH_P_IPV6);
 	}
 
+	if (ri->kern_flags & BPF_RI_F_LWT_RUN) {
+		ri->kern_flags |= BPF_RI_F_LWT_IP_ENCAP;
+		if (!ri->lwt_ip_encap.cb_access) {
+			bpf_lwt_reset_ip_cb(skb, ri->lwt_ip_encap.cb_proto,
+					    ri->lwt_ip_encap.iif,
+					    ri->lwt_ip_encap.l3slave, true);
+			ri->lwt_ip_encap.cb_proto = skb->protocol;
+		}
+	}
+
 	if (skb_is_gso(skb))
 		return handle_gso_encap(skb, ipv4, len);
 
