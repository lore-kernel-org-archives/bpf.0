Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1B4A2612;
	Thu, 10 Sep 2026 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051849; cv=none; b=DskGTAOUWfuMpZ5fh/BdPZIaPeU9GuAf2oYjv0NQgbKVs0HUIraeyUOqXJrDY/EaZY2yrluUovz4phVXW4uJzw1GsCt6BiCw/ZtGNDPJoXKJ1Uzpmq8mxCLuvPy04wVEnBgwF2sMQuNnuzQwMWBihSEd3xjEDeiHPqqhNwmHr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051849; c=relaxed/simple;
	bh=e+AJlWnamTkw+DNyBUc+OXurn2cOXXYiNh0ifNCxgK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWpXU9Oh2oYxKtUwSgZVEmEjCrjbTDMmFz1iFRTvoyeM6hSFYlAEff3gpBitD4nvF1xxMabdp5bMnUT28+5bH9A5v5IRzCQX/Bl8C8QIZ7h5SITzwzcAxACk6zBi+52I5aDIU7UDdgsZB2ExSZbulE87LLPECEwZpYJ7C1dZN2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E086F1FE13;
	Thu, 10 Sep 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1B2913180;
	Thu, 10 Sep 2026 14:50:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yCWGLMPDomogZwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 10 Sep 2026 14:50:43 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"yuan.gao" <yuan.gao@ucloud.cn>,
	Kees Cook <kees@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 08/13 net-next] net: ping: split IPv4 specific logic into ping_ipv4.c
Date: Thu, 10 Sep 2026 16:48:33 +0200
Message-ID: <20260910144914.8025-9-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910144914.8025-1-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
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
X-Rspamd-Queue-Id: E086F1FE13
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

To enable compiling INET subsystem withot IPv4, ping socket IPv4
specific functions must be isolated from the generic ping
infrastructure.

This patch creates ping_ipv4.c and move all the functions for packet
transmission and the AF_INET ping_prot definition from ping.c to the new
file. The Makefile is updated to compile ping_ipv4.c only when
CONFIG_IPV4 is enabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/Makefile    |   2 +-
 net/ipv4/ping.c      | 215 +++-------------------------------------
 net/ipv4/ping_ipv4.c | 228 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 241 insertions(+), 204 deletions(-)
 create mode 100644 net/ipv4/ping_ipv4.c

diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 651835073a29..83c25f52eb58 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -14,7 +14,7 @@ obj-y     := inetpeer.o protocol.o inet_hashtables.o inet_timewait_sock.o \
 obj-$(CONFIG_IPV4) += route.o ip_input.o ip_fragment.o ip_forward.o ip_options.o \
 		      ip_sockglue.o tcp_ipv4.o datagram.o arp.o devinet.o igmp.o \
 		      fib_notifier.o ip_output.o fib_frontend.o fib_semantics.o \
-		      fib_trie.o raw_ipv4.o udp_ipv4.o icmp_ipv4.o
+		      fib_trie.o raw_ipv4.o udp_ipv4.o icmp_ipv4.o ping_ipv4.o
 
 obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
 obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 223a0108b74c..4b953613b695 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -285,25 +285,13 @@ void ping_close(struct sock *sk, long timeout)
 	sk_common_release(sk);
 }
 
-static int ping_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
-			    int addr_len)
-{
-	/* This check is replicated from __ip4_datagram_connect() and
-	 * intended to prevent BPF program called below from accessing bytes
-	 * that are out of the bound specified by user in addr_len.
-	 */
-	if (addr_len < sizeof(struct sockaddr_in))
-		return -EINVAL;
-
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, &addr_len);
-}
-
 /* Checks the bind address and possibly modifies sk->sk_bound_dev_if. */
 static int ping_check_bind_addr(struct sock *sk, struct inet_sock *isk,
 				struct sockaddr_unsized *uaddr, int addr_len)
 {
 	struct net *net = sock_net(sk);
 	if (sk->sk_family == AF_INET) {
+#if IS_ENABLED(CONFIG_IPV4)
 		struct sockaddr_in *addr = (struct sockaddr_in *) uaddr;
 		u32 tb_id = RT_TABLE_LOCAL;
 		int chk_addr_ret;
@@ -331,6 +319,9 @@ static int ping_check_bind_addr(struct sock *sk, struct inet_sock *isk,
 		     !inet_can_nonlocal_bind(net, isk)))
 			return -EADDRNOTAVAIL;
 
+#else
+		return -EAFNOSUPPORT;
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (sk->sk_family == AF_INET6) {
 		struct sockaddr_in6 *addr = (struct sockaddr_in6 *) uaddr;
@@ -528,6 +519,7 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 	inet_sock = inet_sk(sk);
 
 	if (skb->protocol == htons(ETH_P_IP)) {
+#if IS_ENABLED(CONFIG_IPV4)
 		switch (type) {
 		default:
 		case ICMP_TIME_EXCEEDED:
@@ -565,6 +557,7 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 			err = EREMOTEIO;
 			break;
 		}
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		harderr = pingv6_ops.icmpv6_err_convert(type, code, &err);
@@ -581,8 +574,10 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 			goto out;
 	} else {
 		if (family == AF_INET) {
+#if IS_ENABLED(CONFIG_IPV4)
 			ip_icmp_error(sk, skb, err, 0 /* no remote port */,
 				      info, (u8 *)icmph);
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 		} else if (family == AF_INET6) {
 			pingv6_ops.ipv6_icmp_error(sk, skb, err, 0,
@@ -625,21 +620,6 @@ int ping_getfrag(void *from, char *to,
 	return 0;
 }
 
-static int ping_v4_push_pending_frames(struct sock *sk, struct pingfakehdr *pfh,
-				       struct flowi4 *fl4)
-{
-	struct sk_buff *skb = skb_peek(&sk->sk_write_queue);
-
-	if (!skb)
-		return 0;
-	pfh->wcheck = csum_partial((char *)&pfh->icmph,
-		sizeof(struct icmphdr), pfh->wcheck);
-	pfh->icmph.checksum = csum_fold(pfh->wcheck);
-	memcpy(icmp_hdr(skb), &pfh->icmph, sizeof(struct icmphdr));
-	skb->ip_summed = CHECKSUM_NONE;
-	return ip_push_pending_frames(sk, fl4);
-}
-
 int ping_common_sendmsg(int family, struct msghdr *msg, size_t len,
 			void *user_icmph, size_t icmph_len)
 {
@@ -685,160 +665,6 @@ int ping_common_sendmsg(int family, struct msghdr *msg, size_t len,
 	return 0;
 }
 
-static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
-{
-	DEFINE_RAW_FLEX(struct ip_options_rcu, opt_copy, opt.__data,
-			IP_OPTIONS_DATA_FIXED_SIZE);
-	struct net *net = sock_net(sk);
-	struct flowi4 fl4;
-	struct inet_sock *inet = inet_sk(sk);
-	struct ipcm_cookie ipc;
-	struct icmphdr user_icmph;
-	struct pingfakehdr pfh;
-	struct rtable *rt = NULL;
-	int free = 0;
-	__be32 saddr, daddr, faddr;
-	u8 scope;
-	int err;
-
-	pr_debug("ping_v4_sendmsg(sk=%p,sk->num=%u)\n", inet, inet->inet_num);
-
-	err = ping_common_sendmsg(AF_INET, msg, len, &user_icmph,
-				  sizeof(user_icmph));
-	if (err)
-		return err;
-
-	/*
-	 *	Get and verify the address.
-	 */
-
-	if (msg->msg_name) {
-		DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
-		if (msg->msg_namelen < sizeof(*usin))
-			return -EINVAL;
-		if (usin->sin_family != AF_INET)
-			return -EAFNOSUPPORT;
-		daddr = usin->sin_addr.s_addr;
-		/* no remote port */
-	} else {
-		if (sk->sk_state != TCP_ESTABLISHED)
-			return -EDESTADDRREQ;
-		daddr = inet->inet_daddr;
-		/* no remote port */
-	}
-
-	ipcm_init_sk(&ipc, inet);
-
-	if (msg->msg_controllen) {
-		err = ip_cmsg_send(sk, msg, &ipc, false);
-		if (unlikely(err)) {
-			kfree(ipc.opt);
-			return err;
-		}
-		if (ipc.opt)
-			free = 1;
-	}
-	if (!ipc.opt) {
-		struct ip_options_rcu *inet_opt;
-
-		rcu_read_lock();
-		inet_opt = rcu_dereference(inet->inet_opt);
-		if (inet_opt) {
-			memcpy(opt_copy, inet_opt,
-			       sizeof(*inet_opt) + inet_opt->opt.optlen);
-			ipc.opt = opt_copy;
-		}
-		rcu_read_unlock();
-	}
-
-	saddr = ipc.addr;
-	ipc.addr = faddr = daddr;
-
-	if (ipc.opt && ipc.opt->opt.srr) {
-		if (!daddr) {
-			err = -EINVAL;
-			goto out_free;
-		}
-		faddr = ipc.opt->opt.faddr;
-	}
-	scope = ip_sendmsg_scope(inet, &ipc, msg);
-
-	if (ipv4_is_multicast(daddr)) {
-		if (!ipc.oif || netif_index_is_l3_master(sock_net(sk), ipc.oif))
-			ipc.oif = READ_ONCE(inet->mc_index);
-		if (!saddr)
-			saddr = READ_ONCE(inet->mc_addr);
-	} else if (!ipc.oif)
-		ipc.oif = READ_ONCE(inet->uc_index);
-
-	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark,
-			   ipc.tos & INET_DSCP_MASK, scope,
-			   sk->sk_protocol, inet_sk_flowi_flags(sk), faddr,
-			   saddr, 0, 0, sk_uid(sk));
-
-	fl4.fl4_icmp_type = user_icmph.type;
-	fl4.fl4_icmp_code = user_icmph.code;
-
-	security_sk_classify_flow(sk, flowi4_to_flowi_common(&fl4));
-	rt = ip_route_output_flow(net, &fl4, sk);
-	if (IS_ERR(rt)) {
-		err = PTR_ERR(rt);
-		rt = NULL;
-		if (err == -ENETUNREACH)
-			IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
-		goto out;
-	}
-
-	err = -EACCES;
-	if ((rt->rt_flags & RTCF_BROADCAST) &&
-	    !sock_flag(sk, SOCK_BROADCAST))
-		goto out;
-
-	if (msg->msg_flags & MSG_CONFIRM)
-		goto do_confirm;
-back_from_confirm:
-
-	if (!ipc.addr)
-		ipc.addr = fl4.daddr;
-
-	lock_sock(sk);
-
-	pfh.icmph.type = user_icmph.type; /* already checked */
-	pfh.icmph.code = user_icmph.code; /* ditto */
-	pfh.icmph.checksum = 0;
-	pfh.icmph.un.echo.id = inet->inet_sport;
-	pfh.icmph.un.echo.sequence = user_icmph.un.echo.sequence;
-	pfh.msg = msg;
-	pfh.wcheck = 0;
-	pfh.family = AF_INET;
-
-	err = ip_append_data(sk, &fl4, ping_getfrag, &pfh, len,
-			     sizeof(struct icmphdr), &ipc, &rt,
-			     msg->msg_flags);
-	if (err)
-		ip_flush_pending_frames(sk);
-	else
-		err = ping_v4_push_pending_frames(sk, &pfh, &fl4);
-	release_sock(sk);
-
-out:
-	ip_rt_put(rt);
-out_free:
-	if (free)
-		kfree(ipc.opt);
-	if (!err)
-		return len;
-	return err;
-
-do_confirm:
-	if (msg->msg_flags & MSG_PROBE)
-		dst_confirm_neigh(&rt->dst, &fl4.daddr);
-	if (!(msg->msg_flags & MSG_PROBE) || len)
-		goto back_from_confirm;
-	err = 0;
-	goto out;
-}
-
 int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 {
 	struct inet_sock *isk = inet_sk(sk);
@@ -875,6 +701,7 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 
 	/* Copy the address and add cmsg data. */
 	if (family == AF_INET) {
+#if IS_ENABLED(CONFIG_IPV4)
 		DECLARE_SOCKADDR(struct sockaddr_in *, sin, msg->msg_name);
 
 		if (sin) {
@@ -888,6 +715,7 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 		if (inet_cmsg_flags(isk))
 			ip_cmsg_recv(msg, skb);
 
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (family == AF_INET6) {
 		struct ipv6hdr *ip6 = ipv6_hdr(skb);
@@ -911,9 +739,11 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 		if (skb->protocol == htons(ETH_P_IPV6) &&
 		    inet6_sk(sk)->rxopt.all)
 			pingv6_ops.ip6_datagram_recv_specific_ctl(sk, msg, skb);
+#if IS_ENABLED(CONFIG_IPV4)
 		else if (skb->protocol == htons(ETH_P_IP) &&
 			 inet_cmsg_flags(isk))
 			ip_cmsg_recv(msg, skb);
+#endif
 #endif
 	} else {
 		BUG();
@@ -976,27 +806,6 @@ enum skb_drop_reason ping_rcv(struct sk_buff *skb)
 	return SKB_DROP_REASON_NO_SOCKET;
 }
 
-struct proto ping_prot = {
-	.name =		"PING",
-	.owner =	THIS_MODULE,
-	.init =		ping_init_sock,
-	.close =	ping_close,
-	.pre_connect =	ping_pre_connect,
-	.connect =	ip4_datagram_connect,
-	.disconnect =	__udp_disconnect,
-	.setsockopt =	ip_setsockopt,
-	.getsockopt =	ip_getsockopt,
-	.sendmsg =	ping_v4_sendmsg,
-	.recvmsg =	ping_recvmsg,
-	.bind =		ping_bind,
-	.backlog_rcv =	ping_queue_rcv_skb,
-	.release_cb =	ip4_datagram_release_cb,
-	.unhash =	ping_unhash,
-	.get_port =	ping_get_port,
-	.put_port =	ping_unhash,
-	.obj_size =	sizeof(struct inet_sock),
-};
-
 #ifdef CONFIG_PROC_FS
 
 static struct sock *ping_get_first(struct seq_file *seq, int start)
diff --git a/net/ipv4/ping_ipv4.c b/net/ipv4/ping_ipv4.c
new file mode 100644
index 000000000000..4489aa292a4e
--- /dev/null
+++ b/net/ipv4/ping_ipv4.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * INET		An implementation of the TCP/IP protocol suite for the LINUX
+ *		operating system.  INET is implemented using the  BSD Socket
+ *		interface as the means of communication with the user level.
+ *
+ *		"Ping" sockets
+ *
+ *		IPv4 specific functions
+ *
+ *		code split from:
+ *		net/ipv4/ping.c
+ *
+ *		See ping.c for author information
+ */
+
+#include <linux/bpf-cgroup.h>
+#include <linux/in.h>
+#include <linux/socket.h>
+#include <linux/types.h>
+#include <net/ping.h>
+#include <net/udp.h>
+
+static int ping_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
+			    int addr_len)
+{
+	/* This check is replicated from __ip4_datagram_connect() and
+	 * intended to prevent BPF program called below from accessing bytes
+	 * that are out of the bound specified by user in addr_len.
+	 */
+	if (addr_len < sizeof(struct sockaddr_in))
+		return -EINVAL;
+
+	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, &addr_len);
+}
+
+static int ping_v4_push_pending_frames(struct sock *sk, struct pingfakehdr *pfh,
+				       struct flowi4 *fl4)
+{
+	struct sk_buff *skb = skb_peek(&sk->sk_write_queue);
+
+	if (!skb)
+		return 0;
+	pfh->wcheck = csum_partial((char *)&pfh->icmph,
+				   sizeof(struct icmphdr), pfh->wcheck);
+	pfh->icmph.checksum = csum_fold(pfh->wcheck);
+	memcpy(icmp_hdr(skb), &pfh->icmph, sizeof(struct icmphdr));
+	skb->ip_summed = CHECKSUM_NONE;
+	return ip_push_pending_frames(sk, fl4);
+}
+
+static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	DEFINE_RAW_FLEX(struct ip_options_rcu, opt_copy, opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
+	struct net *net = sock_net(sk);
+	struct flowi4 fl4;
+	struct inet_sock *inet = inet_sk(sk);
+	struct ipcm_cookie ipc;
+	struct icmphdr user_icmph;
+	struct pingfakehdr pfh;
+	struct rtable *rt = NULL;
+	int free = 0;
+	__be32 saddr, daddr, faddr;
+	u8 scope;
+	int err;
+
+	pr_debug("ping_v4_sendmsg(sk=%p,sk->num=%u)\n", inet, inet->inet_num);
+
+	err = ping_common_sendmsg(AF_INET, msg, len, &user_icmph,
+				  sizeof(user_icmph));
+	if (err)
+		return err;
+
+	/*
+	 *	Get and verify the address.
+	 */
+
+	if (msg->msg_name) {
+		DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
+
+		if (msg->msg_namelen < sizeof(*usin))
+			return -EINVAL;
+		if (usin->sin_family != AF_INET)
+			return -EAFNOSUPPORT;
+		daddr = usin->sin_addr.s_addr;
+		/* no remote port */
+	} else {
+		if (sk->sk_state != TCP_ESTABLISHED)
+			return -EDESTADDRREQ;
+		daddr = inet->inet_daddr;
+		/* no remote port */
+	}
+
+	ipcm_init_sk(&ipc, inet);
+
+	if (msg->msg_controllen) {
+		err = ip_cmsg_send(sk, msg, &ipc, false);
+		if (unlikely(err)) {
+			kfree(ipc.opt);
+			return err;
+		}
+		if (ipc.opt)
+			free = 1;
+	}
+	if (!ipc.opt) {
+		struct ip_options_rcu *inet_opt;
+
+		rcu_read_lock();
+		inet_opt = rcu_dereference(inet->inet_opt);
+		if (inet_opt) {
+			memcpy(opt_copy, inet_opt,
+			       sizeof(*inet_opt) + inet_opt->opt.optlen);
+			ipc.opt = opt_copy;
+		}
+		rcu_read_unlock();
+	}
+
+	saddr = ipc.addr;
+	ipc.addr = daddr;
+	faddr = daddr;
+
+	if (ipc.opt && ipc.opt->opt.srr) {
+		if (!daddr) {
+			err = -EINVAL;
+			goto out_free;
+		}
+		faddr = ipc.opt->opt.faddr;
+	}
+	scope = ip_sendmsg_scope(inet, &ipc, msg);
+
+	if (ipv4_is_multicast(daddr)) {
+		if (!ipc.oif || netif_index_is_l3_master(sock_net(sk), ipc.oif))
+			ipc.oif = READ_ONCE(inet->mc_index);
+		if (!saddr)
+			saddr = READ_ONCE(inet->mc_addr);
+	} else if (!ipc.oif) {
+		ipc.oif = READ_ONCE(inet->uc_index);
+	}
+
+	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark,
+			   ipc.tos & INET_DSCP_MASK, scope,
+			   sk->sk_protocol, inet_sk_flowi_flags(sk), faddr,
+			   saddr, 0, 0, sk_uid(sk));
+
+	fl4.fl4_icmp_type = user_icmph.type;
+	fl4.fl4_icmp_code = user_icmph.code;
+
+	security_sk_classify_flow(sk, flowi4_to_flowi_common(&fl4));
+	rt = ip_route_output_flow(net, &fl4, sk);
+	if (IS_ERR(rt)) {
+		err = PTR_ERR(rt);
+		rt = NULL;
+		if (err == -ENETUNREACH)
+			IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
+		goto out;
+	}
+
+	err = -EACCES;
+	if ((rt->rt_flags & RTCF_BROADCAST) &&
+	    !sock_flag(sk, SOCK_BROADCAST))
+		goto out;
+
+	if (msg->msg_flags & MSG_CONFIRM)
+		goto do_confirm;
+back_from_confirm:
+
+	if (!ipc.addr)
+		ipc.addr = fl4.daddr;
+
+	lock_sock(sk);
+
+	pfh.icmph.type = user_icmph.type; /* already checked */
+	pfh.icmph.code = user_icmph.code; /* ditto */
+	pfh.icmph.checksum = 0;
+	pfh.icmph.un.echo.id = inet->inet_sport;
+	pfh.icmph.un.echo.sequence = user_icmph.un.echo.sequence;
+	pfh.msg = msg;
+	pfh.wcheck = 0;
+	pfh.family = AF_INET;
+
+	err = ip_append_data(sk, &fl4, ping_getfrag, &pfh, len,
+			     sizeof(struct icmphdr), &ipc, &rt,
+			     msg->msg_flags);
+	if (err)
+		ip_flush_pending_frames(sk);
+	else
+		err = ping_v4_push_pending_frames(sk, &pfh, &fl4);
+	release_sock(sk);
+
+out:
+	ip_rt_put(rt);
+out_free:
+	if (free)
+		kfree(ipc.opt);
+	if (!err)
+		return len;
+	return err;
+
+do_confirm:
+	if (msg->msg_flags & MSG_PROBE)
+		dst_confirm_neigh(&rt->dst, &fl4.daddr);
+	if (!(msg->msg_flags & MSG_PROBE) || len)
+		goto back_from_confirm;
+	err = 0;
+	goto out;
+}
+
+struct proto ping_prot = {
+	.name =		"PING",
+	.owner =	THIS_MODULE,
+	.init =		ping_init_sock,
+	.close =	ping_close,
+	.pre_connect =	ping_pre_connect,
+	.connect =	ip4_datagram_connect,
+	.disconnect =	__udp_disconnect,
+	.setsockopt =	ip_setsockopt,
+	.getsockopt =	ip_getsockopt,
+	.sendmsg =	ping_v4_sendmsg,
+	.recvmsg =	ping_recvmsg,
+	.bind =		ping_bind,
+	.backlog_rcv =	ping_queue_rcv_skb,
+	.release_cb =	ip4_datagram_release_cb,
+	.unhash =	ping_unhash,
+	.get_port =	ping_get_port,
+	.put_port =	ping_unhash,
+	.obj_size =	sizeof(struct inet_sock),
+};
-- 
2.55.0

