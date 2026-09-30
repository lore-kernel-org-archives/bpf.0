Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C501D5CFE;
	Wed, 30 Sep 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776464; cv=none; b=M4rBsQ4DAeVId27BCKXcZ4TyXcKMIRI7Adq5no47s7Hd5j7tX54FU8STu2SRUCXyngKvcvhLAO2oiuGT5hl2F5v1F9MlXTLgLtM1KqGJWZ0FKnzoXun4sXEP/8+FADaJioCIbzWIXJF+7HVGwirwifREpIZlkCBe3b8Sz4FrRi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776464; c=relaxed/simple;
	bh=/6zWI33GDKS7Lcbxs671d+r0KIE+G9GvXvjJqA+kYmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4x40X/H+sSX2CuhJgIlEgfOTe7Rar6bddB3q4dMUi334uXKEldBXbztHaSK42LmUoIIt8xoE0uKMGc7eTyWm/6jhWzI7JUt+qJk4UK+eTOAbDW7b8r7x5DAQWwo7s2IWCn5Z+UsHlRFPjP6VieXGJL8Jq3LUdHmMYTe2E/wMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TMfpxuaG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JDMzKQ0m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZBP5XPOb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g9ZZdd3Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TMfpxuaG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JDMzKQ0m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZBP5XPOb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g9ZZdd3Z"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E54F81FACF;
	Wed, 30 Sep 2026 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790776446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBQt5FZ3PztA2JtZhGd6hjOW2kZMD8lYQ7oO51kEBus=;
	b=TMfpxuaGsx78hP+ZJOL9xaKyvhutSFw//5cEz3cioPJmWc1AoUbJX6Ui3hoQElBgPhSWPf
	Tg6YNpY2A6qN2CWkKJ8oMLDFv5eSW7xzT994X/8slXW1Mr3mdHHdsKt3wnE/sf09ipOMn4
	DTGpRJfwPkRownbdAWrhiuWJIwi7LZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790776446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBQt5FZ3PztA2JtZhGd6hjOW2kZMD8lYQ7oO51kEBus=;
	b=JDMzKQ0mUIysCg1fPUuEeroP9w552Ys4vDiHkoApcugbCgSuowmcyJrHQhFsmUUh1oNbZ/
	WtSNBiLrIDiKYsBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790776441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBQt5FZ3PztA2JtZhGd6hjOW2kZMD8lYQ7oO51kEBus=;
	b=ZBP5XPObZkxJoT1VmFznADk7hTOJVU4Ut/WScT/8xIfHx34ESewrGAueqyn1BNPWKaXkEw
	VWJJVGfxDQwz3ETWJO+Y998qpRW4ufhNlu93yuK23o22c9TLoMOMkKQzrgF6IdGCoxOYKz
	Ec5HHfZcwCQvQLyb9ECg+ayoE3i0/nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790776441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBQt5FZ3PztA2JtZhGd6hjOW2kZMD8lYQ7oO51kEBus=;
	b=g9ZZdd3ZfN0qLxd/WBjKI59LZ9WO0D/n0609zWJcndKfNQbO9cyeZsvUyKr2i6DRRl4sWg
	cki7jNDf4JkKR6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20D7313722;
	Wed, 30 Sep 2026 13:54:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJXpHGIUvWqUTwAAD6G6ig:T3
	(envelope-from <fmancera@suse.de>); Wed, 30 Sep 2026 13:54:00 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
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
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jiaming Zhang <r772577952@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 02/16 net-next v3] net: core: add IPv4 fallback stubs and guards for CONFIG_IPV4=n
Date: Wed, 30 Sep 2026 15:52:45 +0200
Message-ID: <20260930135334.4739-3-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260930135334.4739-1-fmancera@suse.de>
References: <20260930135334.4739-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,davemloft.net,suse.de,google.com,nvidia.com,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,fomichev.me,bootlin.com,tipi-net.de,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLbo5b1jsy3xjwgr4n7o1ogab1)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 

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
 include/net/ip.h                      | 111 ++++++++++++++++++++++----
 include/net/route.h                   |   8 ++
 net/core/dev_ioctl.c                  |   3 +
 net/core/filter.c                     |  20 ++---
 net/core/neighbour.c                  |   4 +
 net/ipv4/inet_hashtables.c            |   3 +
 7 files changed, 127 insertions(+), 30 deletions(-)

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
index 6f602df72ee6..194a464c443a 100644
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
@@ -768,7 +809,7 @@ static inline bool ip_defrag_user_in_between(u32 user,
 }
 
 int ip_defrag(struct net *net, struct sk_buff *skb, u32 user);
-#ifdef CONFIG_INET
+#if IS_ENABLED(CONFIG_IPV4)
 struct sk_buff *ip_check_defrag(struct net *net, struct sk_buff *skb, u32 user);
 #else
 static inline struct sk_buff *ip_check_defrag(struct net *net, struct sk_buff *skb, u32 user)
@@ -813,24 +854,60 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev);
  *	Functions provided by ip_sockglue.c
  */
 
-void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb, bool drop_dst);
+#if IS_ENABLED(CONFIG_IPV4)
 void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
 			 struct sk_buff *skb, int tlen, int offset);
+void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb, bool drop_dst);
 int ip_cmsg_send(struct sock *sk, struct msghdr *msg,
 		 struct ipcm_cookie *ipc, bool allow_ipv6);
+int ip_recv_error(struct sock *sk, struct msghdr *msg, int len);
+int ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+		  unsigned int optlen);
+int ip_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
+		  int __user *optlen);
+#else
+static inline void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
+				       struct sk_buff *skb, int tlen, int offset)
+{
+}
+
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
index 6b55de2e4df8..8c21881eb5f4 100644
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
index 164643140a52..a10921aa3e23 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -44,6 +44,9 @@ int dev_ifconf(struct net *net, struct ifconf __user *uifc)
 	size_t size;
 	int len, total = 0, done;
 
+	if (!IS_ENABLED(CONFIG_IPV4))
+		return -EAFNOSUPPORT;
+
 	/* both the ifconf and the ifreq structures are slightly different */
 	if (in_compat_syscall()) {
 		struct compat_ifconf ifc32;
diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..86d531c63683 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2318,7 +2318,7 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 }
 #endif /* CONFIG_IPV6 */
 
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 			    struct net_device *dev, struct bpf_nh_params *nh)
 {
@@ -2427,7 +2427,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
 }
-#endif /* CONFIG_INET */
+#endif /* CONFIG_IPV4 */
 
 static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 				struct bpf_nh_params *nh)
@@ -5781,7 +5781,7 @@ static int __bpf_setsockopt(struct sock *sk, int level, int optname,
 
 	if (level == SOL_SOCKET)
 		return sol_socket_sockopt(sk, optname, optval, &optlen, false);
-	else if (IS_ENABLED(CONFIG_INET) && level == SOL_IP)
+	else if (IS_ENABLED(CONFIG_IPV4) && level == SOL_IP)
 		return sol_ip_sockopt(sk, optname, optval, &optlen, false);
 	else if (IS_ENABLED(CONFIG_IPV6) && level == SOL_IPV6)
 		return sol_ipv6_sockopt(sk, optname, optval, &optlen, false);
@@ -5818,7 +5818,7 @@ static int __bpf_getsockopt(struct sock *sk, int level, int optname,
 		err = sol_socket_sockopt(sk, optname, optval, &optlen, true);
 	else if (IS_ENABLED(CONFIG_INET) && level == SOL_TCP)
 		err = sol_tcp_sockopt(sk, optname, optval, &optlen, true);
-	else if (IS_ENABLED(CONFIG_INET) && level == SOL_IP)
+	else if (IS_ENABLED(CONFIG_IPV4) && level == SOL_IP)
 		err = sol_ip_sockopt(sk, optname, optval, &optlen, true);
 	else if (IS_ENABLED(CONFIG_IPV6) && level == SOL_IPV6)
 		err = sol_ipv6_sockopt(sk, optname, optval, &optlen, true);
@@ -6346,7 +6346,7 @@ static struct net_device *bpf_fib_vlan_input_dev(struct net_device *dev,
 }
 #endif
 
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 			       u32 flags, bool check_mtu)
 {
@@ -6678,7 +6678,7 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 		return -EINVAL;
 
 	switch (params->family) {
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 	case AF_INET:
 		return bpf_ipv4_fib_lookup(dev_net(ctx->rxq->dev), params,
 					   flags, true);
@@ -6722,7 +6722,7 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 		check_mtu = true;
 
 	switch (params->family) {
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 	case AF_INET:
 		rc = bpf_ipv4_fib_lookup(net, params, flags, check_mtu);
 		break;
@@ -12231,7 +12231,7 @@ BPF_CALL_1(bpf_skc_to_tcp_timewait_sock, struct sock *, sk)
 	BTF_TYPE_EMIT(struct inet_timewait_sock);
 	BTF_TYPE_EMIT(struct tcp_timewait_sock);
 
-#ifdef CONFIG_INET
+#ifdef CONFIG_IPV4
 	if (sk && sk->sk_prot == &tcp_prot && sk->sk_state == TCP_TIME_WAIT)
 		return (unsigned long)sk;
 #endif
@@ -12254,7 +12254,7 @@ const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto = {
 
 BPF_CALL_1(bpf_skc_to_tcp_request_sock, struct sock *, sk)
 {
-#ifdef CONFIG_INET
+#ifdef CONFIG_IPV4
 	if (sk && sk->sk_prot == &tcp_prot && sk->sk_state == TCP_NEW_SYN_RECV)
 		return (unsigned long)sk;
 #endif
@@ -12736,7 +12736,7 @@ __bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
 		return -ENETUNREACH;
 
 	switch (skb->protocol) {
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 	case htons(ETH_P_IP): {
 		struct sk_buff *nskb;
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 6ed8eb075146..63c2a1b86118 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3241,6 +3241,10 @@ int neigh_xmit(int index, struct net_device *dev,
 		if (index == NEIGH_ARP_TABLE) {
 			u32 key = *((u32 *)addr);
 
+			if (!IS_ENABLED(CONFIG_IPV4)) {
+				rcu_read_unlock();
+				goto out_kfree_skb;
+			}
 			neigh = __ipv4_neigh_lookup_noref(dev, key);
 		} else {
 			neigh = __neigh_lookup_noref(tbl, addr, dev);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 5abcb0debb27..ae9f45368571 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -596,6 +596,9 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 	struct sock *sk2;
 	spinlock_t *lock;
 
+	if (!IS_ENABLED(CONFIG_IPV4))
+		return -EAFNOSUPPORT;
+
 	if (rcu_lookup) {
 		sk_nulls_for_each(sk2, node, &head->chain) {
 			if (sk2->sk_hash != hash ||
-- 
2.55.0

