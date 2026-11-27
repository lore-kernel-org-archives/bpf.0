Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800003;
	b=r6Zq8kcst5tMVUR/xBM126+roVRfevVtA8SZeNx+tXz2jOVuF93xgAqJLWZ18bVZenpa
	 gz2dzaozTrYAHown7TZGNyrv7LNuoap8+XAH9Jgd39vwU6SiXR8zVcdK7VcJmZKmvLS77
	 GQ+YfW8VuxGn5kM6+r2D7IISyxTZRh/5VW9nGTWxU3lCBd+aEzmb5TFCU3Uc+fxObmpzI
	 JgIt0M84f8A4pg163zkjWeW1+mbqlb5C4A2Wrg/5LivyYhTv1gjB39+2dWWUS0sGk24gf
	 A5DAiVNeM7A+yqF+vN+YXhb0yyvWjEYBBPO24oktCGjS7SHuhPU/ScoZgPqsEZ9sEtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800003;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Queue-Id:
	 X-Rspamd-Pre-Result:X-Rspamd-Action:X-Rspamd-Server:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=md4zOHy3bDDcPEFgZhWYE6ZYjPtsCFfujx3F5ZA2e8I=;
	b=5KbrFoIzds4vuyLiNHUytKOwtwdX6RHXoXLcCDdT69lnmKtasdPPAn3bJCk/l+VtTMiY
	 CZGTqui280LHQvS7Uske/K7Lab4hoICtgnN49x6ru73TVDfnYnaGoV6HjLfyLxX8Ott54
	 GT1MAzRTvn/8V83mFxv9V3B2oUYyOJAQmCRP+vSnj0r+SkrxfVPNLNqBeS4P5LlNwFR/o
	 BvMXVMJQNRFl92uBuYqtj2nLsyiz2nZk73nz8MX0IaMivngOtqTKA2cPX9HxF+Hs65zky
	 ynGyKj9mIJgsDJ2/pRzGVFRld8W0llw5msCeCtB7SQLrXsNA34okCFg3bLjgvAiEuhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C9606A331;
	Fri, 27 Nov 2026 17:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B27C9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21FAC2295D;
	Fri, 27 Nov 2026 17:20:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D209313432;
	Fri, 27 Nov 2026 17:19:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Yb1MH67CWuMAwAAD6G6ig:T9
	(envelope-from <fmancera@suse.de>); Fri, 27 Nov 2026 17:19:59 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Willem de Bruijn <willemb@google.com>,
	Julian Anastasov <ja@ssi.bg>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Tim Fuechsel <t.fuechsel@gmx.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"yuan.gao" <yuan.gao@ucloud.cn>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 08/16] ipv4: ping: split IPv4 specific logic into ping_ipv4.c
Date: Fri, 27 Nov 2026 18:17:53 +0100
Message-ID: <20261127171824.27362-9-fmancera@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 21FAC2295D
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

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
 net/ipv4/ping.c      | 210 +--------------------------------------
 net/ipv4/ping_ipv4.c | 228 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+), 206 deletions(-)
 create mode 100644 net/ipv4/ping_ipv4.c

diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 80e5c67bae52..003ad176d6ee 100644
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
index ceb0af8c70a3..1289304d9f3d 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -285,19 +285,6 @@ void ping_close(struct sock *sk, long timeout)
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
@@ -308,6 +295,9 @@ static int ping_check_bind_addr(struct sock *sk, struct inet_sock *isk,
 		u32 tb_id = RT_TABLE_LOCAL;
 		int chk_addr_ret;
 
+		if (!IS_ENABLED(CONFIG_IPV4))
+			return -EAFNOSUPPORT;
+
 		if (addr_len < sizeof(*addr))
 			return -EINVAL;
 
@@ -523,7 +513,7 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 	harderr = 0;
 	inet_sock = inet_sk(sk);
 
-	if (skb->protocol == htons(ETH_P_IP)) {
+	if (IS_ENABLED(CONFIG_IPV4) && skb->protocol == htons(ETH_P_IP)) {
 		switch (type) {
 		default:
 		case ICMP_TIME_EXCEEDED:
@@ -576,7 +566,7 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 		if (!harderr || sk->sk_state != TCP_ESTABLISHED)
 			goto out;
 	} else {
-		if (family == AF_INET) {
+		if (IS_ENABLED(CONFIG_IPV4) && family == AF_INET) {
 			ip_icmp_error(sk, skb, err, 0 /* no remote port */,
 				      info, (u8 *)icmph);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -621,21 +611,6 @@ int ping_getfrag(void *from, char *to,
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
@@ -681,160 +656,6 @@ int ping_common_sendmsg(int family, struct msghdr *msg, size_t len,
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
@@ -972,27 +793,6 @@ enum skb_drop_reason ping_rcv(struct sk_buff *skb)
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
2.56.1

