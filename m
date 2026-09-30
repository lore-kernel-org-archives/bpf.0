Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0104E9C05;
	Wed, 30 Sep 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776496; cv=none; b=EDkQhjejdFRcKp7T1eVXjeACBtMSqSG3GAgY1IuGEXmZNTOzEwoGVKIl02veoeMMUmxdwf9dhbtlHcRmeb8FbfjMSAtrhfPfsPBzK3iPzEBWsAV1KYQXV4f89wftCeT5mnp063rL3m4Q+4o6RkDB1bhbw8YXE45FRbmTdmWj67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776496; c=relaxed/simple;
	bh=Oy8emGMafkX3hUGwJxmGx9clEer2z3YTLGZT42AoAd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nksl/T4SCEdqM9EEIzSX/JY6KpPtYpC4WQXh6Cj/iY10AH79nzSdpE2MWxbSTE08lal88ACRqTXAIvI46sCMALzLaNYIUxp1rglyUK9u/W7JafDZkf2rhGFjmi/ru536OIMOvfw62FsjZbyVV7dWXBmLRafjkvcnh0Fgposdfg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7694A21CFC;
	Wed, 30 Sep 2026 13:54:37 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06A4313ABC;
	Wed, 30 Sep 2026 13:54:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJXpHGIUvWqUTwAAD6G6ig:T10
	(envelope-from <fmancera@suse.de>); Wed, 30 Sep 2026 13:54:35 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 09/16 net-next v3] ipv4: fib: split common nexthop logic to fib_core.c
Date: Wed, 30 Sep 2026 15:52:52 +0200
Message-ID: <20260930135334.4739-10-fmancera@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 7694A21CFC
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

To enable compiling INET subsystem without IPv4, shared FIB and nexthop
logic must be accessible to IPv6 when IPv4 routing stack is omitted.

This patch creates fib_core.c and move all the functions for common
nexthop initialization and release from fib_semantics.c to fib_core.c.
Note that fib_core.c is under net/core.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 include/net/ip_fib.h       |  27 +++-
 include/net/route.h        |   6 +
 net/core/Makefile          |   2 +-
 net/core/fib_core.c        | 307 +++++++++++++++++++++++++++++++++++++
 net/ipv4/fib_frontend.c    |  96 ------------
 net/ipv4/fib_semantics.c   | 205 -------------------------
 net/ipv4/nexthop.c         |   5 +-
 net/ipv4/sysctl_net_ipv4.c |   2 +
 8 files changed, 345 insertions(+), 305 deletions(-)
 create mode 100644 net/core/fib_core.c

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 0a35355fb0f3..6058e53fa3de 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -250,7 +250,13 @@ int call_fib4_notifiers(struct net *net, enum fib_event_type event_type,
 int __net_init fib4_notifier_init(struct net *net);
 void __net_exit fib4_notifier_exit(struct net *net);
 
+#if IS_ENABLED(CONFIG_IPV4)
 void fib_info_notify_update(struct net *net, struct nl_info *info);
+#else
+static inline void fib_info_notify_update(struct net *net, struct nl_info *info)
+{
+}
+#endif
 int fib_notify(struct net *net, struct notifier_block *nb,
 	       struct netlink_ext_ack *extack);
 
@@ -442,7 +448,7 @@ static inline bool fib_dscp_masked_match(dscp_t dscp, const struct flowi4 *fl4)
 	return dscp == (fl4->flowi4_dscp & INET_DSCP_LEGACY_TOS_MASK);
 }
 
-/* Exported by fib_frontend.c */
+/* Exported by net/core/fib_core.c */
 extern const struct nla_policy rtm_ipv4_policy[];
 void ip_fib_init(void);
 int fib_gw_from_via(struct fib_config *cfg, struct nlattr *nla,
@@ -578,10 +584,23 @@ void fib_select_multipath(struct fib_result *res, int hash,
 void fib_select_path(struct net *net, struct fib_result *res,
 		     struct flowi4 *fl4, const struct sk_buff *skb);
 
+#if IS_ENABLED(CONFIG_IPV4)
 int fib_nh_init(struct net *net, struct fib_nh *fib_nh,
 		struct fib_config *cfg, int nh_weight,
 		struct netlink_ext_ack *extack);
 void fib_nh_release(struct net *net, struct fib_nh *fib_nh);
+#else
+static inline int fib_nh_init(struct net *net, struct fib_nh *fib_nh,
+			      struct fib_config *cfg, int nh_weight,
+			      struct netlink_ext_ack *extack)
+{
+	return -EAFNOSUPPORT;
+}
+
+static inline void fib_nh_release(struct net *net, struct fib_nh *fib_nh)
+{
+}
+#endif
 int fib_nh_common_init(struct net *net, struct fib_nh_common *nhc,
 		       struct nlattr *fc_encap, u16 fc_encap_type,
 		       void *cfg, gfp_t gfp_flags,
@@ -620,7 +639,13 @@ static inline void fib_combine_itag(u32 *itag, const struct fib_result *res)
 #endif
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
 void fib_flush(struct net *net);
+#else
+static inline void fib_flush(struct net *net)
+{
+}
+#endif
 void free_fib_info(struct fib_info *fi);
 
 static inline void fib_info_hold(struct fib_info *fi)
diff --git a/include/net/route.h b/include/net/route.h
index 8c21881eb5f4..8788bf096c15 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -128,7 +128,13 @@ extern struct ip_rt_acct __percpu *ip_rt_acct;
 struct in_device;
 
 int ip_rt_init(void);
+#if IS_ENABLED(CONFIG_IPV4)
 void rt_cache_flush(struct net *net);
+#else
+static inline void rt_cache_flush(struct net *net)
+{
+}
+#endif
 void rt_flush_dev(struct net_device *dev);
 
 static inline void inet_sk_init_flowi4(const struct inet_sock *inet,
diff --git a/net/core/Makefile b/net/core/Makefile
index c20e520358b8..315e437a49d8 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 obj-y		     += dev.o dev_api.o dev_addr_lists.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
 			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
-			fib_notifier.o xdp.o flow_offload.o gro.o \
+			fib_notifier.o fib_core.o xdp.o flow_offload.o gro.o \
 			netdev-genl.o netdev-genl-gen.o netdev_work.o gso.o
 
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
diff --git a/net/core/fib_core.c b/net/core/fib_core.c
new file mode 100644
index 000000000000..6f59ee43ccbb
--- /dev/null
+++ b/net/core/fib_core.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/inetdevice.h>
+#include <linux/types.h>
+#include <net/addrconf.h>
+#include <net/lwtunnel.h>
+#include <net/route.h>
+
+static void rt_fibinfo_free(struct rtable __rcu **rtp)
+{
+	struct rtable *rt = rcu_dereference_protected(*rtp, 1);
+
+	if (!rt)
+		return;
+
+	/* Not even needed : RCU_INIT_POINTER(*rtp, NULL);
+	 * because we waited an RCU grace period before calling
+	 * free_fib_info_rcu()
+	 */
+
+	dst_dev_put(&rt->dst);
+	dst_release_immediate(&rt->dst);
+}
+
+static void free_nh_exceptions(struct fib_nh_common *nhc)
+{
+	struct fnhe_hash_bucket *hash;
+	int i;
+
+	hash = rcu_dereference_protected(nhc->nhc_exceptions, 1);
+	if (!hash)
+		return;
+	for (i = 0; i < FNHE_HASH_SIZE; i++) {
+		struct fib_nh_exception *fnhe;
+
+		fnhe = rcu_dereference_protected(hash[i].chain, 1);
+		while (fnhe) {
+			struct fib_nh_exception *next;
+
+			next = rcu_dereference_protected(fnhe->fnhe_next, 1);
+
+			rt_fibinfo_free(&fnhe->fnhe_rth_input);
+			rt_fibinfo_free(&fnhe->fnhe_rth_output);
+
+			kfree(fnhe);
+
+			fnhe = next;
+		}
+	}
+	kfree(hash);
+}
+
+static void rt_fibinfo_free_cpus(struct rtable __rcu * __percpu *rtp)
+{
+	int cpu;
+
+	if (!rtp)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct rtable *rt;
+
+		rt = rcu_dereference_protected(*per_cpu_ptr(rtp, cpu), 1);
+		if (rt) {
+			dst_dev_put(&rt->dst);
+			dst_release_immediate(&rt->dst);
+		}
+	}
+	free_percpu(rtp);
+}
+
+void fib_nh_common_release(struct fib_nh_common *nhc)
+{
+	netdev_put(nhc->nhc_dev, &nhc->nhc_dev_tracker);
+	lwtstate_put(nhc->nhc_lwtstate);
+	rt_fibinfo_free_cpus(nhc->nhc_pcpu_rth_output);
+	rt_fibinfo_free(&nhc->nhc_rth_input);
+	free_nh_exceptions(nhc);
+}
+
+int fib_nh_common_init(struct net *net, struct fib_nh_common *nhc,
+		       struct nlattr *encap, u16 encap_type,
+		       void *cfg, gfp_t gfp_flags,
+		       struct netlink_ext_ack *extack)
+{
+	int err;
+
+	nhc->nhc_pcpu_rth_output = alloc_percpu_gfp(struct rtable __rcu *,
+						    gfp_flags);
+	if (!nhc->nhc_pcpu_rth_output)
+		return -ENOMEM;
+
+	if (encap) {
+		struct lwtunnel_state *lwtstate;
+
+		err = lwtunnel_build_state(net, encap_type, encap,
+					   nhc->nhc_family, cfg, &lwtstate,
+					   extack);
+		if (err)
+			goto lwt_failure;
+
+		nhc->nhc_lwtstate = lwtstate_get(lwtstate);
+	}
+
+	return 0;
+
+lwt_failure:
+	rt_fibinfo_free_cpus(nhc->nhc_pcpu_rth_output);
+	nhc->nhc_pcpu_rth_output = NULL;
+	return err;
+}
+
+int fib_nexthop_info(struct sk_buff *skb, const struct fib_nh_common *nhc,
+		     u8 rt_family, unsigned char *flags, bool skip_oif)
+{
+	if (nhc->nhc_flags & RTNH_F_DEAD)
+		*flags |= RTNH_F_DEAD;
+
+	if (nhc->nhc_flags & RTNH_F_LINKDOWN) {
+		*flags |= RTNH_F_LINKDOWN;
+
+		rcu_read_lock();
+		switch (nhc->nhc_family) {
+		case AF_INET:
+			if (ip_ignore_linkdown(nhc->nhc_dev))
+				*flags |= RTNH_F_DEAD;
+			break;
+		case AF_INET6:
+			if (ip6_ignore_linkdown(nhc->nhc_dev))
+				*flags |= RTNH_F_DEAD;
+			break;
+		}
+		rcu_read_unlock();
+	}
+
+	switch (nhc->nhc_gw_family) {
+	case AF_INET:
+		if (nla_put_in_addr(skb, RTA_GATEWAY, nhc->nhc_gw.ipv4))
+			goto nla_put_failure;
+		break;
+	case AF_INET6:
+		/* if gateway family does not match nexthop family
+		 * gateway is encoded as RTA_VIA
+		 */
+		if (rt_family != nhc->nhc_gw_family) {
+			int alen = sizeof(struct in6_addr);
+			struct nlattr *nla;
+			struct rtvia *via;
+
+			nla = nla_reserve(skb, RTA_VIA, alen + 2);
+			if (!nla)
+				goto nla_put_failure;
+
+			via = nla_data(nla);
+			via->rtvia_family = AF_INET6;
+			memcpy(via->rtvia_addr, &nhc->nhc_gw.ipv6, alen);
+		} else if (nla_put_in6_addr(skb, RTA_GATEWAY,
+					    &nhc->nhc_gw.ipv6) < 0) {
+			goto nla_put_failure;
+		}
+		break;
+	}
+
+	*flags |= (nhc->nhc_flags &
+		   (RTNH_F_ONLINK | RTNH_F_OFFLOAD | RTNH_F_TRAP));
+
+	if (!skip_oif && nhc->nhc_dev &&
+	    nla_put_u32(skb, RTA_OIF, nhc->nhc_dev->ifindex))
+		goto nla_put_failure;
+
+	if (lwtunnel_fill_encap(skb, nhc->nhc_lwtstate,
+				RTA_ENCAP, RTA_ENCAP_TYPE) < 0)
+		goto nla_put_failure;
+
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
+#if IS_ENABLED(CONFIG_IP_ROUTE_MULTIPATH) || IS_ENABLED(CONFIG_IPV6)
+int fib_add_nexthop(struct sk_buff *skb, const struct fib_nh_common *nhc,
+		    int nh_weight, u8 rt_family, u32 nh_tclassid)
+{
+	const struct net_device *dev = nhc->nhc_dev;
+	struct rtnexthop *rtnh;
+	unsigned char flags = 0;
+
+	rtnh = nla_reserve_nohdr(skb, sizeof(*rtnh));
+	if (!rtnh)
+		goto nla_put_failure;
+
+	rtnh->rtnh_hops = nh_weight - 1;
+	rtnh->rtnh_ifindex = dev ? dev->ifindex : 0;
+
+	if (fib_nexthop_info(skb, nhc, rt_family, &flags, true) < 0)
+		goto nla_put_failure;
+
+	rtnh->rtnh_flags = flags;
+
+	if (nh_tclassid && nla_put_u32(skb, RTA_FLOW, nh_tclassid))
+		goto nla_put_failure;
+
+	/* length of rtnetlink header + attributes */
+	rtnh->rtnh_len = nlmsg_get_pos(skb) - (void *)rtnh;
+
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+#endif
+
+const struct nla_policy rtm_ipv4_policy[RTA_MAX + 1] = {
+	[RTA_UNSPEC]		= { .strict_start_type = RTA_DPORT + 1 },
+	[RTA_DST]		= { .type = NLA_U32 },
+	[RTA_SRC]		= { .type = NLA_U32 },
+	[RTA_IIF]		= { .type = NLA_U32 },
+	[RTA_OIF]		= { .type = NLA_U32 },
+	[RTA_GATEWAY]		= { .type = NLA_U32 },
+	[RTA_PRIORITY]		= { .type = NLA_U32 },
+	[RTA_PREFSRC]		= { .type = NLA_U32 },
+	[RTA_METRICS]		= { .type = NLA_NESTED },
+	[RTA_MULTIPATH]		= { .len = sizeof(struct rtnexthop) },
+	[RTA_FLOW]		= { .type = NLA_U32 },
+	[RTA_ENCAP_TYPE]	= { .type = NLA_U16 },
+	[RTA_ENCAP]		= { .type = NLA_NESTED },
+	[RTA_UID]		= { .type = NLA_U32 },
+	[RTA_MARK]		= { .type = NLA_U32 },
+	[RTA_TABLE]		= { .type = NLA_U32 },
+	[RTA_IP_PROTO]		= { .type = NLA_U8 },
+	[RTA_SPORT]		= { .type = NLA_U16 },
+	[RTA_DPORT]		= { .type = NLA_U16 },
+	[RTA_NH_ID]		= { .type = NLA_U32 },
+};
+
+int ip_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
+			  struct fib_dump_filter *filter,
+			  struct netlink_callback *cb)
+{
+	struct netlink_ext_ack *extack = cb->extack;
+	struct nlattr *tb[RTA_MAX + 1];
+	struct rtmsg *rtm;
+	int err, i;
+
+	rtm = nlmsg_payload(nlh, sizeof(*rtm));
+	if (!rtm) {
+		NL_SET_ERR_MSG(extack, "Invalid header for FIB dump request");
+		return -EINVAL;
+	}
+
+	if (rtm->rtm_dst_len || rtm->rtm_src_len  || rtm->rtm_tos   ||
+	    rtm->rtm_scope) {
+		NL_SET_ERR_MSG(extack, "Invalid values in header for FIB dump request");
+		return -EINVAL;
+	}
+
+	if (rtm->rtm_flags & ~(RTM_F_CLONED | RTM_F_PREFIX)) {
+		NL_SET_ERR_MSG(extack, "Invalid flags for FIB dump request");
+		return -EINVAL;
+	}
+	if (rtm->rtm_flags & RTM_F_CLONED)
+		filter->dump_routes = false;
+	else
+		filter->dump_exceptions = false;
+
+	filter->flags    = rtm->rtm_flags;
+	filter->protocol = rtm->rtm_protocol;
+	filter->rt_type  = rtm->rtm_type;
+	filter->table_id = rtm->rtm_table;
+
+	err = nlmsg_parse_deprecated_strict(nlh, sizeof(*rtm), tb, RTA_MAX,
+					    rtm_ipv4_policy, extack);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i <= RTA_MAX; ++i) {
+		int ifindex;
+
+		if (!tb[i])
+			continue;
+
+		switch (i) {
+		case RTA_TABLE:
+			filter->table_id = nla_get_u32(tb[i]);
+			break;
+		case RTA_OIF:
+			ifindex = nla_get_u32(tb[i]);
+
+			filter->dev = dev_get_by_index_rcu(net, ifindex);
+			if (!filter->dev)
+				return -ENODEV;
+			break;
+		default:
+			NL_SET_ERR_MSG(extack, "Unsupported attribute in dump request");
+			return -EINVAL;
+		}
+	}
+
+	if (filter->flags || filter->protocol || filter->rt_type ||
+	    filter->table_id || filter->dev) {
+		filter->filter_set = 1;
+		cb->answer_flags = NLM_F_DUMP_FILTERED;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ip_valid_fib_dump_req);
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 8a3dc04e8cac..c507d53c6da6 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -684,29 +684,6 @@ int ip_rt_ioctl(struct net *net, unsigned int cmd, struct rtentry *rt)
 	return -EINVAL;
 }
 
-const struct nla_policy rtm_ipv4_policy[RTA_MAX + 1] = {
-	[RTA_UNSPEC]		= { .strict_start_type = RTA_DPORT + 1 },
-	[RTA_DST]		= { .type = NLA_U32 },
-	[RTA_SRC]		= { .type = NLA_U32 },
-	[RTA_IIF]		= { .type = NLA_U32 },
-	[RTA_OIF]		= { .type = NLA_U32 },
-	[RTA_GATEWAY]		= { .type = NLA_U32 },
-	[RTA_PRIORITY]		= { .type = NLA_U32 },
-	[RTA_PREFSRC]		= { .type = NLA_U32 },
-	[RTA_METRICS]		= { .type = NLA_NESTED },
-	[RTA_MULTIPATH]		= { .len = sizeof(struct rtnexthop) },
-	[RTA_FLOW]		= { .type = NLA_U32 },
-	[RTA_ENCAP_TYPE]	= { .type = NLA_U16 },
-	[RTA_ENCAP]		= { .type = NLA_NESTED },
-	[RTA_UID]		= { .type = NLA_U32 },
-	[RTA_MARK]		= { .type = NLA_U32 },
-	[RTA_TABLE]		= { .type = NLA_U32 },
-	[RTA_IP_PROTO]		= { .type = NLA_U8 },
-	[RTA_SPORT]		= { .type = NLA_U16 },
-	[RTA_DPORT]		= { .type = NLA_U16 },
-	[RTA_NH_ID]		= { .type = NLA_U32 },
-};
-
 int fib_gw_from_via(struct fib_config *cfg, struct nlattr *nla,
 		    struct netlink_ext_ack *extack)
 {
@@ -957,79 +934,6 @@ static int inet_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-int ip_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
-			  struct fib_dump_filter *filter,
-			  struct netlink_callback *cb)
-{
-	struct netlink_ext_ack *extack = cb->extack;
-	struct nlattr *tb[RTA_MAX + 1];
-	struct rtmsg *rtm;
-	int err, i;
-
-	rtm = nlmsg_payload(nlh, sizeof(*rtm));
-	if (!rtm) {
-		NL_SET_ERR_MSG(extack, "Invalid header for FIB dump request");
-		return -EINVAL;
-	}
-
-	if (rtm->rtm_dst_len || rtm->rtm_src_len  || rtm->rtm_tos   ||
-	    rtm->rtm_scope) {
-		NL_SET_ERR_MSG(extack, "Invalid values in header for FIB dump request");
-		return -EINVAL;
-	}
-
-	if (rtm->rtm_flags & ~(RTM_F_CLONED | RTM_F_PREFIX)) {
-		NL_SET_ERR_MSG(extack, "Invalid flags for FIB dump request");
-		return -EINVAL;
-	}
-	if (rtm->rtm_flags & RTM_F_CLONED)
-		filter->dump_routes = false;
-	else
-		filter->dump_exceptions = false;
-
-	filter->flags    = rtm->rtm_flags;
-	filter->protocol = rtm->rtm_protocol;
-	filter->rt_type  = rtm->rtm_type;
-	filter->table_id = rtm->rtm_table;
-
-	err = nlmsg_parse_deprecated_strict(nlh, sizeof(*rtm), tb, RTA_MAX,
-					    rtm_ipv4_policy, extack);
-	if (err < 0)
-		return err;
-
-	for (i = 0; i <= RTA_MAX; ++i) {
-		int ifindex;
-
-		if (!tb[i])
-			continue;
-
-		switch (i) {
-		case RTA_TABLE:
-			filter->table_id = nla_get_u32(tb[i]);
-			break;
-		case RTA_OIF:
-			ifindex = nla_get_u32(tb[i]);
-
-			filter->dev = dev_get_by_index_rcu(net, ifindex);
-			if (!filter->dev)
-				return -ENODEV;
-			break;
-		default:
-			NL_SET_ERR_MSG(extack, "Unsupported attribute in dump request");
-			return -EINVAL;
-		}
-	}
-
-	if (filter->flags || filter->protocol || filter->rt_type ||
-	    filter->table_id || filter->dev) {
-		filter->filter_set = 1;
-		cb->answer_flags = NLM_F_DUMP_FILTERED;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ip_valid_fib_dump_req);
-
 static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index e3bcc25229b0..3ce0f2611e69 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -136,78 +136,6 @@ const struct fib_prop fib_props[RTN_MAX + 1] = {
 	},
 };
 
-static void rt_fibinfo_free(struct rtable __rcu **rtp)
-{
-	struct rtable *rt = rcu_dereference_protected(*rtp, 1);
-
-	if (!rt)
-		return;
-
-	/* Not even needed : RCU_INIT_POINTER(*rtp, NULL);
-	 * because we waited an RCU grace period before calling
-	 * free_fib_info_rcu()
-	 */
-
-	dst_dev_put(&rt->dst);
-	dst_release_immediate(&rt->dst);
-}
-
-static void free_nh_exceptions(struct fib_nh_common *nhc)
-{
-	struct fnhe_hash_bucket *hash;
-	int i;
-
-	hash = rcu_dereference_protected(nhc->nhc_exceptions, 1);
-	if (!hash)
-		return;
-	for (i = 0; i < FNHE_HASH_SIZE; i++) {
-		struct fib_nh_exception *fnhe;
-
-		fnhe = rcu_dereference_protected(hash[i].chain, 1);
-		while (fnhe) {
-			struct fib_nh_exception *next;
-
-			next = rcu_dereference_protected(fnhe->fnhe_next, 1);
-
-			rt_fibinfo_free(&fnhe->fnhe_rth_input);
-			rt_fibinfo_free(&fnhe->fnhe_rth_output);
-
-			kfree(fnhe);
-
-			fnhe = next;
-		}
-	}
-	kfree(hash);
-}
-
-static void rt_fibinfo_free_cpus(struct rtable __rcu * __percpu *rtp)
-{
-	int cpu;
-
-	if (!rtp)
-		return;
-
-	for_each_possible_cpu(cpu) {
-		struct rtable *rt;
-
-		rt = rcu_dereference_protected(*per_cpu_ptr(rtp, cpu), 1);
-		if (rt) {
-			dst_dev_put(&rt->dst);
-			dst_release_immediate(&rt->dst);
-		}
-	}
-	free_percpu(rtp);
-}
-
-void fib_nh_common_release(struct fib_nh_common *nhc)
-{
-	netdev_put(nhc->nhc_dev, &nhc->nhc_dev_tracker);
-	lwtstate_put(nhc->nhc_lwtstate);
-	rt_fibinfo_free_cpus(nhc->nhc_pcpu_rth_output);
-	rt_fibinfo_free(&nhc->nhc_rth_input);
-	free_nh_exceptions(nhc);
-}
-
 void fib_nh_release(struct net *net, struct fib_nh *fib_nh)
 {
 #ifdef CONFIG_IP_ROUTE_CLASSID
@@ -639,38 +567,6 @@ static int fib_detect_death(struct fib_info *fi, int order,
 	return 1;
 }
 
-int fib_nh_common_init(struct net *net, struct fib_nh_common *nhc,
-		       struct nlattr *encap, u16 encap_type,
-		       void *cfg, gfp_t gfp_flags,
-		       struct netlink_ext_ack *extack)
-{
-	int err;
-
-	nhc->nhc_pcpu_rth_output = alloc_percpu_gfp(struct rtable __rcu *,
-						    gfp_flags);
-	if (!nhc->nhc_pcpu_rth_output)
-		return -ENOMEM;
-
-	if (encap) {
-		struct lwtunnel_state *lwtstate;
-
-		err = lwtunnel_build_state(net, encap_type, encap,
-					   nhc->nhc_family, cfg, &lwtstate,
-					   extack);
-		if (err)
-			goto lwt_failure;
-
-		nhc->nhc_lwtstate = lwtstate_get(lwtstate);
-	}
-
-	return 0;
-
-lwt_failure:
-	rt_fibinfo_free_cpus(nhc->nhc_pcpu_rth_output);
-	nhc->nhc_pcpu_rth_output = NULL;
-	return err;
-}
-
 int fib_nh_init(struct net *net, struct fib_nh *nh,
 		struct fib_config *cfg, int nh_weight,
 		struct netlink_ext_ack *extack)
@@ -1605,107 +1501,6 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 	return ERR_PTR(err);
 }
 
-int fib_nexthop_info(struct sk_buff *skb, const struct fib_nh_common *nhc,
-		     u8 rt_family, unsigned char *flags, bool skip_oif)
-{
-	if (nhc->nhc_flags & RTNH_F_DEAD)
-		*flags |= RTNH_F_DEAD;
-
-	if (nhc->nhc_flags & RTNH_F_LINKDOWN) {
-		*flags |= RTNH_F_LINKDOWN;
-
-		rcu_read_lock();
-		switch (nhc->nhc_family) {
-		case AF_INET:
-			if (ip_ignore_linkdown(nhc->nhc_dev))
-				*flags |= RTNH_F_DEAD;
-			break;
-		case AF_INET6:
-			if (ip6_ignore_linkdown(nhc->nhc_dev))
-				*flags |= RTNH_F_DEAD;
-			break;
-		}
-		rcu_read_unlock();
-	}
-
-	switch (nhc->nhc_gw_family) {
-	case AF_INET:
-		if (nla_put_in_addr(skb, RTA_GATEWAY, nhc->nhc_gw.ipv4))
-			goto nla_put_failure;
-		break;
-	case AF_INET6:
-		/* if gateway family does not match nexthop family
-		 * gateway is encoded as RTA_VIA
-		 */
-		if (rt_family != nhc->nhc_gw_family) {
-			int alen = sizeof(struct in6_addr);
-			struct nlattr *nla;
-			struct rtvia *via;
-
-			nla = nla_reserve(skb, RTA_VIA, alen + 2);
-			if (!nla)
-				goto nla_put_failure;
-
-			via = nla_data(nla);
-			via->rtvia_family = AF_INET6;
-			memcpy(via->rtvia_addr, &nhc->nhc_gw.ipv6, alen);
-		} else if (nla_put_in6_addr(skb, RTA_GATEWAY,
-					    &nhc->nhc_gw.ipv6) < 0) {
-			goto nla_put_failure;
-		}
-		break;
-	}
-
-	*flags |= (nhc->nhc_flags &
-		   (RTNH_F_ONLINK | RTNH_F_OFFLOAD | RTNH_F_TRAP));
-
-	if (!skip_oif && nhc->nhc_dev &&
-	    nla_put_u32(skb, RTA_OIF, nhc->nhc_dev->ifindex))
-		goto nla_put_failure;
-
-	if (lwtunnel_fill_encap(skb, nhc->nhc_lwtstate,
-				RTA_ENCAP, RTA_ENCAP_TYPE) < 0)
-		goto nla_put_failure;
-
-	return 0;
-
-nla_put_failure:
-	return -EMSGSIZE;
-}
-
-#if IS_ENABLED(CONFIG_IP_ROUTE_MULTIPATH) || IS_ENABLED(CONFIG_IPV6)
-int fib_add_nexthop(struct sk_buff *skb, const struct fib_nh_common *nhc,
-		    int nh_weight, u8 rt_family, u32 nh_tclassid)
-{
-	const struct net_device *dev = nhc->nhc_dev;
-	struct rtnexthop *rtnh;
-	unsigned char flags = 0;
-
-	rtnh = nla_reserve_nohdr(skb, sizeof(*rtnh));
-	if (!rtnh)
-		goto nla_put_failure;
-
-	rtnh->rtnh_hops = nh_weight - 1;
-	rtnh->rtnh_ifindex = dev ? dev->ifindex : 0;
-
-	if (fib_nexthop_info(skb, nhc, rt_family, &flags, true) < 0)
-		goto nla_put_failure;
-
-	rtnh->rtnh_flags = flags;
-
-	if (nh_tclassid && nla_put_u32(skb, RTA_FLOW, nh_tclassid))
-		goto nla_put_failure;
-
-	/* length of rtnetlink header + attributes */
-	rtnh->rtnh_len = nlmsg_get_pos(skb) - (void *)rtnh;
-
-	return 0;
-
-nla_put_failure:
-	return -EMSGSIZE;
-}
-#endif
-
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 static int fib_add_multipath(struct sk_buff *skb, struct fib_info *fi)
 {
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 42e55b5a755e..ad79943376c5 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -1421,7 +1421,7 @@ static bool nexthop_is_good_nh(const struct nexthop *nh)
 
 	switch (nhi->family) {
 	case AF_INET:
-		return ipv4_good_nh(&nhi->fib_nh);
+		return IS_ENABLED(CONFIG_IPV4) && ipv4_good_nh(&nhi->fib_nh);
 	case AF_INET6:
 		return IS_ENABLED(CONFIG_IPV6) && ipv6_good_nh(&nhi->fib6_nh);
 	}
@@ -4005,7 +4005,8 @@ static int nh_netdev_event(struct notifier_block *this,
 		break;
 	case NETDEV_CHANGEMTU:
 		info_ext = ptr;
-		nexthop_sync_mtu(dev, info_ext->ext.mtu);
+		if (IS_ENABLED(CONFIG_IPV4))
+			nexthop_sync_mtu(dev, info_ext->ext.mtu);
 		rt_cache_flush(dev_net(dev));
 		break;
 	}
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index e3760daa3470..0e7fef5973db 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -615,6 +615,7 @@ static struct ctl_table ipv4_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
+#if IS_ENABLED(CONFIG_IPV4)
 	{
 		.procname	= "fib_sync_mem",
 		.data		= &sysctl_fib_sync_mem,
@@ -624,6 +625,7 @@ static struct ctl_table ipv4_table[] = {
 		.extra1		= &sysctl_fib_sync_mem_min,
 		.extra2		= &sysctl_fib_sync_mem_max,
 	},
+#endif
 };
 
 static const struct ctl_table ipv4_net_table[] = {
-- 
2.55.0

