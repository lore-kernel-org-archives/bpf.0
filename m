Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799975;
	b=TiNLrV6GtpJtdO0cJ0FM5Ox7u7feLohxAgPqvVhGnUi4iJehYmXu22e5k7CAUdUPOqZl
	 CUmTnfqShRFYsI/Gk2GVALElxqGFEV0EHuzmMBDijv43bIBJN0rjgkM2MZU9gL8e3OANb
	 G14gqAihErCsFYoS1YvzekC+PD81dbhW7yoTL3lLjPYqBnNUHZ3W3tw3mG4EtUCiv29Q7
	 t8Y/NtT3tnMCe/C2YokstT49934s1DDSA9s0QZ0zEAqUTz3xxcetDnlzF9JjHzYrZuhTZ
	 h6wawncOFpTYKpnagB1+0eZUM1TruGgM3hSWfXo1wyblL6NYk5XYMGAi2D7Gdmn1Khw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799975;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=SKF0/uaWNikezTJAECW0s0gDkjvFC0Feq7oP82grcTY=;
	b=TSMdiv8ZUF3eKtjoAck3WbXLYgFaqT+dRHcPEXdIgxNbIPMbgLkmxcGjR6r4pqtPxvLr
	 zkdF2LhPC4O7xk9vZfGw04gtFaRzFUIJgLe9vX8HMI6/uBxeAwYHilgIH/QfIT4QIzSuL
	 oRcp9HYYAnrDRbA3ASNlsaUEV79sPaOIlI7jOZHAuMk6S58vSdx/g0o56AUdQl3B36TTD
	 C3BVqIn9HyIVcmdKoNfhBKlAn4l/xAhCl3APwxZbRW3tR/QZ5daQOpID1DmvL8gUrbBfN
	 QgoZmHBJdCpQrosCVMSacNPVOJWEBg7D5nevobfZCEILsjenZpbl/yWDyIpBcuhN7ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HxVg08QF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0KI1DxYh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=08aQcmAz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Y64pY9bF;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A0B606A323;
	Fri, 27 Nov 2026 17:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03A0B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HxVg08QF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0KI1DxYh;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=08aQcmAz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Y64pY9bF
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0888229B0;
	Fri, 27 Nov 2026 17:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795799972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKF0/uaWNikezTJAECW0s0gDkjvFC0Feq7oP82grcTY=;
	b=HxVg08QFHlHiOp+5tdR89PdLoVnQdhs0b9GqwNWaSlVTCGfPmJzSiojsnpcfeaOy0sW9yT
	uKWope3x3myaJ2/12XVDV3fJ87yWkgffPovi2YREofaT4rj4Q8DQB3DRlG8REZZNmHMxRq
	WECkbq49CFYm7mw/sMdj82kO2SKqYl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795799972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKF0/uaWNikezTJAECW0s0gDkjvFC0Feq7oP82grcTY=;
	b=0KI1DxYhlUTIBzoedUDIg3Jy7IoW1ZgHaCV1DBsXE7EuVvH4Qi5m5HJ9RXjXDe6CPZfX6Z
	kx5p4Venb7eVS8BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795799971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKF0/uaWNikezTJAECW0s0gDkjvFC0Feq7oP82grcTY=;
	b=08aQcmAz+bekPQZoDOsN5CqsNV500OQ8/839GW485tbaQv7ESraCpqnj7MvES80XYNC4/K
	lKZ0PENbBKjQT3yeoDjCtZnuK11djX+sFjAnRRq7F97ULZckqPnb79mL/TWn6KBqTxq40t
	9bWpvBGFppCXVWiVgefP3cv5+ufeITc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795799971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKF0/uaWNikezTJAECW0s0gDkjvFC0Feq7oP82grcTY=;
	b=Y64pY9bFdbNi9a0s5zHNympf6BfdbszNgcKy/pes0PJseUQJ1HcelVLknp+2uU186rg03R
	fVKUzVpZ9afDohCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 537BC13432;
	Fri, 27 Nov 2026 17:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Yb1MH67CWuMAwAAD6G6ig:T3
	(envelope-from <fmancera@suse.de>); Fri, 27 Nov 2026 17:19:30 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Willem de Bruijn <willemb@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Nikolay Aleksandrov <razor@blackwall.org>,
	Petr Machata <petrm@nvidia.com>,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 02/16] net: core: add IPv4 fallback stubs and guards for CONFIG_IPV4=n
Date: Fri, 27 Nov 2026 18:17:47 +0100
Message-ID: <20261127171824.27362-3-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261127171824.27362-1-fmancera@suse.de>
References: <20261127171824.27362-1-fmancera@suse.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-14.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,suse.de,google.com,lunn.ch,nvidia.com,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,fomichev.me,blackwall.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkf9qki7bqia849eo4t4fjnpa)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -14.30

To enable compiling the core network stack without IPv4, generic
networking code must avoid referencing missing IPv4 symbols.

This patch provides static inline stubs in include/net/ip.h and
include/net/route.h that return an error code when IPv4 is disabled.
IPv4 socket options are not supported without IPv4, including on
AF_INET6 sockets, so ip_setsockopt() and ip_getsockopt() fail with
-ENOPROTOOPT. In addition, it introduces guards around IPv4 specific
code in generic implementations to prevent undefined reference errors
while linking.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 include/linux/indirect_call_wrapper.h |   6 +-
 include/linux/inetdevice.h            |   2 +-
 include/net/ip.h                      | 111 ++++++++++++++++++++++----
 include/net/route.h                   |   8 ++
 net/core/filter.c                     |  20 ++---
 net/core/neighbour.c                  |   4 +
 net/ipv4/inet_hashtables.c            |   3 +
 7 files changed, 124 insertions(+), 30 deletions(-)

diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
index 0e4340ecd857..edb97427164f 100644
--- a/include/linux/indirect_call_wrapper.h
+++ b/include/linux/indirect_call_wrapper.h
@@ -57,11 +57,13 @@
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
diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index 6032eea2539a..2fa1ea4e1128 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -185,7 +185,7 @@ static inline struct net_device *ip_dev_find(struct net *net, __be32 addr)
 
 int inet_addr_onlink(struct in_device *in_dev, __be32 a, __be32 b);
 int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *);
-#ifdef CONFIG_INET
+#if IS_ENABLED(CONFIG_IPV4)
 int inet_gifconf(struct net_device *dev, char __user *buf, int len, int size);
 #else
 static inline int inet_gifconf(struct net_device *dev, char __user *buf,
diff --git a/include/net/ip.h b/include/net/ip.h
index 5035b313a26b..6f4ae2e7e3b2 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -178,8 +178,17 @@ int ip_mr_input(struct sk_buff *skb);
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
@@ -225,6 +234,7 @@ int ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb);
 int __ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl,
 		    __u8 tos);
 void ip_init(void);
+#if IS_ENABLED(CONFIG_IPV4)
 int ip_append_data(struct sock *sk, struct flowi4 *fl4,
 		   int getfrag(void *from, char *to, int offset, int len,
 			       int odd, struct sk_buff *skb),
@@ -232,27 +242,58 @@ int ip_append_data(struct sock *sk, struct flowi4 *fl4,
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
+	return NULL;
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
@@ -753,7 +794,7 @@ static inline bool ip_defrag_user_in_between(u32 user,
 }
 
 int ip_defrag(struct net *net, struct sk_buff *skb, u32 user);
-#ifdef CONFIG_INET
+#if IS_ENABLED(CONFIG_IPV4)
 struct sk_buff *ip_check_defrag(struct net *net, struct sk_buff *skb, u32 user);
 #else
 static inline struct sk_buff *ip_check_defrag(struct net *net, struct sk_buff *skb, u32 user)
@@ -798,23 +839,59 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev);
  *	Functions provided by ip_sockglue.c
  */
 
-void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb, bool drop_dst);
+#if IS_ENABLED(CONFIG_IPV4)
 void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
 			 struct sk_buff *skb, int tlen, int offset);
+void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb, bool drop_dst);
 int ip_cmsg_send(struct sock *sk, struct msghdr *msg,
 		 struct ipcm_cookie *ipc, bool allow_ipv6);
-DECLARE_STATIC_KEY_FALSE(ip4_min_ttl);
-int do_ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
-		     unsigned int optlen);
+int ip_recv_error(struct sock *sk, struct msghdr *msg, int len);
 int ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		  unsigned int optlen);
-int do_ip_getsockopt(struct sock *sk, int level, int optname, sockopt_t *sopt);
 int ip_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 		  int __user *optlen);
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
+	return -ENOPROTOOPT;
+}
+
+static inline int ip_getsockopt(struct sock *sk, int level, int optname,
+				char __user *optval, int __user *optlen)
+{
+	return -ENOPROTOOPT;
+}
+#endif
+DECLARE_STATIC_KEY_FALSE(ip4_min_ttl);
+int do_ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+		     unsigned int optlen);
+int do_ip_getsockopt(struct sock *sk, int level, int optname, sockopt_t *sopt);
 int ip_ra_control(struct sock *sk, unsigned char on,
 		  void (*destructor)(struct sock *));
 
-int ip_recv_error(struct sock *sk, struct msghdr *msg, int len);
 void ip_icmp_error(struct sock *sk, struct sk_buff *skb, int err, __be16 port,
 		   u32 info, u8 *payload);
 void ip_local_error(struct sock *sk, int err, __be32 daddr, __be16 dport,
diff --git a/include/net/route.h b/include/net/route.h
index 3fccd31eb74d..fb326f7e4266 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -175,8 +175,16 @@ static inline struct rtable *__ip_route_output_key(struct net *net,
 	return ip_route_output_key_hash(net, flp, NULL);
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
 struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
 				    const struct sock *sk);
+#else
+static inline struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp,
+						  const struct sock *sk)
+{
+	return ERR_PTR(-EAFNOSUPPORT);
+}
+#endif
 struct dst_entry *ipv4_blackhole_route(struct net *net,
 				       struct dst_entry *dst_orig);
 
diff --git a/net/core/filter.c b/net/core/filter.c
index d6a6dd9c9547..884e0171b1c4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2341,7 +2341,7 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 }
 #endif /* CONFIG_IPV6 */
 
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 			    struct net_device *dev, struct bpf_nh_params *nh)
 {
@@ -2454,7 +2454,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
 }
-#endif /* CONFIG_INET */
+#endif /* CONFIG_IPV4 */
 
 static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 				struct bpf_nh_params *nh)
@@ -5881,7 +5881,7 @@ static int __bpf_setsockopt(struct sock *sk, int level, int optname,
 
 	if (level == SOL_SOCKET)
 		return sol_socket_sockopt(sk, optname, optval, &optlen, false);
-	else if (IS_ENABLED(CONFIG_INET) && level == SOL_IP)
+	else if (IS_ENABLED(CONFIG_IPV4) && level == SOL_IP)
 		return sol_ip_sockopt(sk, optname, optval, &optlen, false);
 	else if (IS_ENABLED(CONFIG_IPV6) && level == SOL_IPV6)
 		return sol_ipv6_sockopt(sk, optname, optval, &optlen, false);
@@ -5918,7 +5918,7 @@ static int __bpf_getsockopt(struct sock *sk, int level, int optname,
 		err = sol_socket_sockopt(sk, optname, optval, &optlen, true);
 	else if (IS_ENABLED(CONFIG_INET) && level == SOL_TCP)
 		err = sol_tcp_sockopt(sk, optname, optval, &optlen, true);
-	else if (IS_ENABLED(CONFIG_INET) && level == SOL_IP)
+	else if (IS_ENABLED(CONFIG_IPV4) && level == SOL_IP)
 		err = sol_ip_sockopt(sk, optname, optval, &optlen, true);
 	else if (IS_ENABLED(CONFIG_IPV6) && level == SOL_IPV6)
 		err = sol_ipv6_sockopt(sk, optname, optval, &optlen, true);
@@ -6446,7 +6446,7 @@ static struct net_device *bpf_fib_vlan_input_dev(struct net_device *dev,
 }
 #endif
 
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 			       u32 flags, bool check_mtu)
 {
@@ -6778,7 +6778,7 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 		return -EINVAL;
 
 	switch (params->family) {
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 	case AF_INET:
 		return bpf_ipv4_fib_lookup(dev_net(ctx->rxq->dev), params,
 					   flags, true);
@@ -6822,7 +6822,7 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 		check_mtu = true;
 
 	switch (params->family) {
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 	case AF_INET:
 		rc = bpf_ipv4_fib_lookup(net, params, flags, check_mtu);
 		break;
@@ -12384,7 +12384,7 @@ BPF_CALL_1(bpf_skc_to_tcp_timewait_sock, struct sock *, sk)
 	BTF_TYPE_EMIT(struct inet_timewait_sock);
 	BTF_TYPE_EMIT(struct tcp_timewait_sock);
 
-#ifdef CONFIG_INET
+#ifdef CONFIG_IPV4
 	if (sk && sk->sk_prot == &tcp_prot && sk->sk_state == TCP_TIME_WAIT)
 		return (unsigned long)sk;
 #endif
@@ -12411,7 +12411,7 @@ BPF_CALL_1(bpf_skc_to_tcp_request_sock, struct sock *, sk)
 	BTF_TYPE_EMIT(struct inet_request_sock);
 	BTF_TYPE_EMIT(struct tcp_request_sock);
 
-#ifdef CONFIG_INET
+#ifdef CONFIG_IPV4
 	if (sk && sk->sk_prot == &tcp_prot && sk->sk_state == TCP_NEW_SYN_RECV)
 		return (unsigned long)sk;
 #endif
@@ -12893,7 +12893,7 @@ __bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
 		return -ENETUNREACH;
 
 	switch (skb->protocol) {
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 	case htons(ETH_P_IP): {
 		struct sk_buff *nskb;
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 887d2e35cd04..bb4473ffce51 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3262,6 +3262,10 @@ int neigh_xmit(int index, struct net_device *dev,
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
index 860145d810ed..2b406d9662a5 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -597,6 +597,9 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 	struct sock *sk2;
 	spinlock_t *lock;
 
+	if (!IS_ENABLED(CONFIG_IPV4))
+		return -EAFNOSUPPORT;
+
 	if (rcu_lookup) {
 		sk_nulls_for_each(sk2, node, &head->chain) {
 			if (sk2->sk_hash != hash ||
-- 
2.56.1

