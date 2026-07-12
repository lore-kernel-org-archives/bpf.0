Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA521FF25
	for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820431; cv=none; b=gUN/9ev44rc0dhMuMLHufzXa4b3CpckzI5XN0YO6gAHAGtXon31izmrQRB5F65/W38uW1UsMca86PMlu9RZIVDF0IEbmZYiMJDFE+r4aaNFzct4SRbCIr4cgnullngCulaesaV6/t371gRZ2GzGqy2Ov6ZhRaTzyza2vyx06gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820431; c=relaxed/simple;
	bh=7c14f4GHs9XtsDjk2NKCEwsDtfk3TGj66PpBTfE17Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2DMsi4gFcL5ok390oPCm1nSsceA3JxS1fcrsabHH97j/kYOkDMDQw7iNGlG2/RNL6gFnvl/m2uJQUAxVqw13lG+GQDg/Ixgm2tkJ35id4NRSU4rrTEO9pA76waY/VvX5B5G0Z62QRlA+XOTfh/oC1ZXBJZCIBps1piU0nIPJLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76B1276DB7;
	Sun, 12 Jul 2026 01:40:25 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C121F779B5;
	Sun, 12 Jul 2026 01:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OLv0K4fwUmqRegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 12 Jul 2026 01:40:23 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Carolina Jubran <cjubran@nvidia.com>,
	Jiaming Zhang <r772577952@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 02/13 RFC net-next] net: core: add IPv4 fallback stubs and guards for CONFIG_IPV4=n
Date: Sun, 12 Jul 2026 03:39:00 +0200
Message-ID: <20260712013941.4570-3-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260712013941.4570-1-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 76B1276DB7
X-Rspamd-Action: no action

To enable compiling the core network stack without IPv4, generic
networking code must avoid referencing missing IPv4 symbols.

This patch provides static inline stubs in include/net/ip.h and
include/net/route.h that return a proper error code when IPv4 is
disabled. This behaves as IPv6 code does. In addition, it introduces
guards around IPv4 specific code in generic implementations to prevent
undefined reference errors while linking.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 include/linux/indirect_call_wrapper.h |   8 +-
 include/net/ip.h                      | 104 ++++++++++++++++++++++----
 include/net/route.h                   |   8 ++
 net/core/dev_ioctl.c                  |   4 +
 net/core/filter.c                     |  18 ++---
 net/core/neighbour.c                  |   4 +
 net/ipv4/inet_hashtables.c            |   4 +
 7 files changed, 122 insertions(+), 28 deletions(-)

diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
index 0e4340ecd857..583efbc03446 100644
--- a/include/linux/indirect_call_wrapper.h
+++ b/include/linux/indirect_call_wrapper.h
@@ -57,16 +57,18 @@
  * builtin, this macro simplify dealing with indirect calls with only ipv4/ipv6
  * alternatives
  */
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV4) && IS_ENABLED(CONFIG_IPV6)
 #define INDIRECT_CALL_INET(f, f2, f1, ...) \
 	INDIRECT_CALL_2(f, f2, f1, __VA_ARGS__)
-#elif IS_ENABLED(CONFIG_INET)
+#elif IS_ENABLED(CONFIG_IPV4)
 #define INDIRECT_CALL_INET(f, f2, f1, ...) INDIRECT_CALL_1(f, f1, __VA_ARGS__)
+#elif IS_ENABLED(CONFIG_IPV6)
+#define INDIRECT_CALL_INET(f, f2, f1, ...) INDIRECT_CALL_1(f, f2, __VA_ARGS__)
 #else
 #define INDIRECT_CALL_INET(f, f2, f1, ...) f(__VA_ARGS__)
 #endif
 
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 #define INDIRECT_CALL_INET_1(f, f1, ...) INDIRECT_CALL_1(f, f1, __VA_ARGS__)
 #else
 #define INDIRECT_CALL_INET_1(f, f1, ...) f(__VA_ARGS__)
diff --git a/include/net/ip.h b/include/net/ip.h
index 7f2fe1a8401b..aeac40d11c72 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -171,8 +171,17 @@ int ip_mr_input(struct sk_buff *skb);
 int ip_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb);
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb);
 int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb);
+#if IS_ENABLED(CONFIG_IPV4)
 int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		   int (*output)(struct net *, struct sock *, struct sk_buff *));
+#else
+static inline int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
+				 int (*output)(struct net *, struct sock *, struct sk_buff *))
+{
+	kfree_skb(skb);
+	return -EAFNOSUPPORT;
+}
+#endif
 
 struct ip_fraglist_iter {
 	struct sk_buff	*frag;
@@ -218,6 +227,7 @@ int ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb);
 int __ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl,
 		    __u8 tos);
 void ip_init(void);
+#if IS_ENABLED(CONFIG_IPV4)
 int ip_append_data(struct sock *sk, struct flowi4 *fl4,
 		   int getfrag(void *from, char *to, int offset, int len,
 			       int odd, struct sk_buff *skb),
@@ -225,27 +235,58 @@ int ip_append_data(struct sock *sk, struct flowi4 *fl4,
 		   struct ipcm_cookie *ipc,
 		   struct rtable **rt,
 		   unsigned int flags);
-int ip_generic_getfrag(void *from, char *to, int offset, int len, int odd,
-		       struct sk_buff *skb);
-struct sk_buff *__ip_make_skb(struct sock *sk, struct flowi4 *fl4,
-			      struct sk_buff_head *queue,
-			      struct inet_cork *cork);
-int ip_send_skb(struct net *net, struct sk_buff *skb);
-int ip_push_pending_frames(struct sock *sk, struct flowi4 *fl4);
-void ip_flush_pending_frames(struct sock *sk);
 struct sk_buff *ip_make_skb(struct sock *sk, struct flowi4 *fl4,
 			    int getfrag(void *from, char *to, int offset,
 					int len, int odd, struct sk_buff *skb),
 			    void *from, int length, int transhdrlen,
 			    struct ipcm_cookie *ipc, struct rtable **rtp,
 			    struct inet_cork *cork, unsigned int flags);
-
-int ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl);
+struct sk_buff *__ip_make_skb(struct sock *sk, struct flowi4 *fl4,
+			      struct sk_buff_head *queue,
+			      struct inet_cork *cork);
+void ip_flush_pending_frames(struct sock *sk);
 
 static inline struct sk_buff *ip_finish_skb(struct sock *sk, struct flowi4 *fl4)
 {
 	return __ip_make_skb(sk, fl4, &sk->sk_write_queue, &inet_sk(sk)->cork.base);
 }
+#else
+static inline int ip_append_data(struct sock *sk, struct flowi4 *fl4,
+				 int getfrag(void *from, char *to, int offset, int len,
+					     int odd, struct sk_buff *skb),
+				 void *from, int len, int protolen,
+				 struct ipcm_cookie *ipc,
+				 struct rtable **rt,
+				 unsigned int flags)
+{
+	return -EAFNOSUPPORT;
+}
+
+static inline struct sk_buff *ip_make_skb(struct sock *sk, struct flowi4 *fl4,
+					  int getfrag(void *from, char *to, int offset,
+						      int len, int odd, struct sk_buff *skb),
+					  void *from, int length, int transhdrlen,
+					  struct ipcm_cookie *ipc, struct rtable **rtp,
+					  struct inet_cork *cork, unsigned int flags)
+{
+	return ERR_PTR(-EAFNOSUPPORT);
+}
+
+static inline struct sk_buff *ip_finish_skb(struct sock *sk, struct flowi4 *fl4)
+{
+	return ERR_PTR(-EAFNOSUPPORT);
+}
+
+static inline void ip_flush_pending_frames(struct sock *sk)
+{
+}
+#endif
+
+int ip_generic_getfrag(void *from, char *to, int offset, int len, int odd,
+		       struct sk_buff *skb);
+int ip_send_skb(struct net *net, struct sk_buff *skb);
+int ip_push_pending_frames(struct sock *sk, struct flowi4 *fl4);
+int ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl);
 
 /* Get the route scope that should be used when sending a packet. */
 static inline u8 ip_sendmsg_scope(const struct inet_sock *inet,
@@ -787,24 +828,55 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev);
  *	Functions provided by ip_sockglue.c
  */
 
-void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb, bool drop_dst);
 void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
 			 struct sk_buff *skb, int tlen, int offset);
+#if IS_ENABLED(CONFIG_IPV4)
+void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb, bool drop_dst);
 int ip_cmsg_send(struct sock *sk, struct msghdr *msg,
 		 struct ipcm_cookie *ipc, bool allow_ipv6);
+int ip_recv_error(struct sock *sk, struct msghdr *msg, int len);
+int ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+		  unsigned int optlen);
+int ip_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
+		  int __user *optlen);
+#else
+static inline void ipv4_pktinfo_prepare(const struct sock *sk,
+					struct sk_buff *skb,
+					bool drop_dst)
+{
+}
+
+static inline int ip_cmsg_send(struct sock *sk, struct msghdr *msg,
+			       struct ipcm_cookie *ipc, bool allow_ipv6)
+{
+	return 0;
+}
+
+static inline int ip_recv_error(struct sock *sk, struct msghdr *msg, int len)
+{
+	return -EAFNOSUPPORT;
+}
+
+static inline int ip_setsockopt(struct sock *sk, int level, int optname,
+				sockptr_t optval, unsigned int optlen)
+{
+	return -EAFNOSUPPORT;
+}
+
+static inline int ip_getsockopt(struct sock *sk, int level, int optname,
+				char __user *optval, int __user *optlen)
+{
+	return -EAFNOSUPPORT;
+}
+#endif
 DECLARE_STATIC_KEY_FALSE(ip4_min_ttl);
 int do_ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		     unsigned int optlen);
-int ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
-		  unsigned int optlen);
 int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		     sockptr_t optval, sockptr_t optlen);
-int ip_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
-		  int __user *optlen);
 int ip_ra_control(struct sock *sk, unsigned char on,
 		  void (*destructor)(struct sock *));
 
-int ip_recv_error(struct sock *sk, struct msghdr *msg, int len);
 void ip_icmp_error(struct sock *sk, struct sk_buff *skb, int err, __be16 port,
 		   u32 info, u8 *payload);
 void ip_local_error(struct sock *sk, int err, __be32 daddr, __be16 dport,
diff --git a/include/net/route.h b/include/net/route.h
index f90106f383c5..08adb14224a9 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -169,8 +169,16 @@ static inline struct rtable *__ip_route_output_key(struct net *net,
 	return ip_route_output_key_hash(net, flp, NULL);
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
 struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
 				    const struct sock *sk);
+#else
+static inline struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
+						  const struct sock *sk)
+{
+	return ERR_PTR(-EAFNOSUPPORT);
+}
+#endif
 struct dst_entry *ipv4_blackhole_route(struct net *net,
 				       struct dst_entry *dst_orig);
 
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index a320e264eaaf..f7ca3701b6bd 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -39,6 +39,7 @@ static int dev_ifname(struct net *net, struct ifreq *ifr)
  */
 int dev_ifconf(struct net *net, struct ifconf __user *uifc)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	struct net_device *dev;
 	void __user *pos;
 	size_t size;
@@ -82,6 +83,9 @@ int dev_ifconf(struct net *net, struct ifconf __user *uifc)
 	rtnl_net_unlock(net);
 
 	return put_user(total, &uifc->ifc_len);
+#else
+	return -EAFNOSUPPORT;
+#endif
 }
 
 static int dev_getifmap(struct net_device *dev, struct ifreq *ifr)
diff --git a/net/core/filter.c b/net/core/filter.c
index b446aa8be5c3..55c2466c32ae 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2314,7 +2314,7 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 }
 #endif /* CONFIG_IPV6 */
 
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 			    struct net_device *dev, struct bpf_nh_params *nh)
 {
@@ -2423,7 +2423,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
 }
-#endif /* CONFIG_INET */
+#endif /* CONFIG_IPV4 */
 
 static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 				struct bpf_nh_params *nh)
@@ -5685,7 +5685,7 @@ static int __bpf_setsockopt(struct sock *sk, int level, int optname,
 
 	if (level == SOL_SOCKET)
 		return sol_socket_sockopt(sk, optname, optval, &optlen, false);
-	else if (IS_ENABLED(CONFIG_INET) && level == SOL_IP)
+	else if (IS_ENABLED(CONFIG_IPV4) && level == SOL_IP)
 		return sol_ip_sockopt(sk, optname, optval, &optlen, false);
 	else if (IS_ENABLED(CONFIG_IPV6) && level == SOL_IPV6)
 		return sol_ipv6_sockopt(sk, optname, optval, &optlen, false);
@@ -5722,7 +5722,7 @@ static int __bpf_getsockopt(struct sock *sk, int level, int optname,
 		err = sol_socket_sockopt(sk, optname, optval, &optlen, true);
 	else if (IS_ENABLED(CONFIG_INET) && level == SOL_TCP)
 		err = sol_tcp_sockopt(sk, optname, optval, &optlen, true);
-	else if (IS_ENABLED(CONFIG_INET) && level == SOL_IP)
+	else if (IS_ENABLED(CONFIG_IPV4) && level == SOL_IP)
 		err = sol_ip_sockopt(sk, optname, optval, &optlen, true);
 	else if (IS_ENABLED(CONFIG_IPV6) && level == SOL_IPV6)
 		err = sol_ipv6_sockopt(sk, optname, optval, &optlen, true);
@@ -6212,7 +6212,7 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 			       u32 flags, bool check_mtu)
 {
@@ -6504,7 +6504,7 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 		return -EINVAL;
 
 	switch (params->family) {
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 	case AF_INET:
 		return bpf_ipv4_fib_lookup(dev_net(ctx->rxq->dev), params,
 					   flags, true);
@@ -6545,7 +6545,7 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 		check_mtu = true;
 
 	switch (params->family) {
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 	case AF_INET:
 		rc = bpf_ipv4_fib_lookup(net, params, flags, check_mtu);
 		break;
@@ -12076,7 +12076,7 @@ BPF_CALL_1(bpf_skc_to_tcp_timewait_sock, struct sock *, sk)
 	BTF_TYPE_EMIT(struct inet_timewait_sock);
 	BTF_TYPE_EMIT(struct tcp_timewait_sock);
 
-#ifdef CONFIG_INET
+#ifdef CONFIG_IPV4
 	if (sk && sk->sk_prot == &tcp_prot && sk->sk_state == TCP_TIME_WAIT)
 		return (unsigned long)sk;
 #endif
@@ -12099,7 +12099,7 @@ const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto = {
 
 BPF_CALL_1(bpf_skc_to_tcp_request_sock, struct sock *, sk)
 {
-#ifdef CONFIG_INET
+#ifdef CONFIG_IPV4
 	if (sk && sk->sk_prot == &tcp_prot && sk->sk_state == TCP_NEW_SYN_RECV)
 		return (unsigned long)sk;
 #endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eedb64..1a40a0ab041b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3208,9 +3208,13 @@ int neigh_xmit(int index, struct net_device *dev,
 			goto out_kfree_skb;
 		}
 		if (index == NEIGH_ARP_TABLE) {
+#if IS_ENABLED(CONFIG_IPV4)
 			u32 key = *((u32 *)addr);
 
 			neigh = __ipv4_neigh_lookup_noref(dev, key);
+#else
+			goto out_kfree_skb;
+#endif
 		} else {
 			neigh = __neigh_lookup_noref(tbl, addr, dev);
 		}
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ba0faa9ae2bb..47228ff6fa00 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -581,6 +581,7 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 				    bool rcu_lookup,
 				    u32 hash)
 {
+#if IS_ENABLED(CONFIG_IPV4) //TODO: should this be moved out of here?
 	struct inet_hashinfo *hinfo = death_row->hashinfo;
 	struct inet_sock *inet = inet_sk(sk);
 	__be32 daddr = inet->inet_rcv_saddr;
@@ -651,6 +652,9 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 not_unique:
 	spin_unlock(lock);
 	return -EADDRNOTAVAIL;
+#else
+	return -EAFNOSUPPORT;
+#endif
 }
 
 static u64 inet_sk_port_offset(const struct sock *sk)
-- 
2.54.0

