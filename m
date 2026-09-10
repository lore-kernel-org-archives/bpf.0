Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473149F13A;
	Thu, 10 Sep 2026 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051864; cv=none; b=kPtdxaGIB6bp2cQsl9gLOHBtzDzex1QOaEcNP3q9ND0K0Zm1P5iVMrzff4uAnubTDoPBBKX+3zY0vnWcoKttXft8nDwVdKjAzxalhIxAqVz8N1moquwlwWxcD2X8rx/Cx44+4QeCe6AEWDK7piOChesCv1i5wnxzgamQmyPFIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051864; c=relaxed/simple;
	bh=dmWswzqIy9vGmcYmR6DL+UG+Kgn2RzKR/vtRqcY7ErY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9A1TBjT1B45fRNmONT2wfPdX2PDZv8vdpnClONN/YQbXdL1qe7A93xbS3eIusqX8qy64P3yLE9b0fWBMl7mupMc6IxmsWl45+6RMeCHiD3SogIFHImruiD4EDV5712IDzVnOAZ0XMl1EXNlxSfmkUXvlOK90s4fWQMUMYmvJi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=16ai0qGH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GJkQjFuf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o8Vpj4ed; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kog9FYB4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="16ai0qGH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GJkQjFuf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o8Vpj4ed";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kog9FYB4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 64FD11FE1D;
	Thu, 10 Sep 2026 14:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789051854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIwvT0g7Jb7e82bObj5YnBU8hf6PNmwYXc/vRu5o3lw=;
	b=16ai0qGHNwJ5jwz58WFrOxto4b7yz0xG+efLKDx8uDGBhAPn6b0j/KBtgyEToHuauAz2oR
	f/1jp1AjrWnvIHtfoXCyaOOFDHsfSUHe9j6ng/J3hSYea3esaSYNaUR83+iOCAOAQqZNcm
	MB2IrkkFseaceH4GEK0Vn6xUCUyeK2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789051854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIwvT0g7Jb7e82bObj5YnBU8hf6PNmwYXc/vRu5o3lw=;
	b=GJkQjFuf7w9NXw63uWSqQ5mUxD2JCCgbGwljoznH800uPb2Pd1Ttc5fMejVMV6qjrieZLT
	1MHf62eDQXb9gYBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789051850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIwvT0g7Jb7e82bObj5YnBU8hf6PNmwYXc/vRu5o3lw=;
	b=o8Vpj4edsfxcRQQinCDdIdEjITjRa/JGf28xI3RARWl6DJYLrEcmpBTMsojMBtN/jrR3DU
	TpKMJbyUgMLDjYg5u3F/4l5EbkQt66eGfwJItoMqCJdcrhaIwVDXP7DBoWgKvhwk+XeTWr
	HUYfvd2hAKrG0jCyx9GtbaxsHN57kWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789051850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIwvT0g7Jb7e82bObj5YnBU8hf6PNmwYXc/vRu5o3lw=;
	b=kog9FYB4crz3rUGcM4DPa/PVuqLKbOrgnD99cHag/oOkCcdaSjGKYwa7dNvKGDOKHWPaJd
	werKlUk981lF7iBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C933F13180;
	Thu, 10 Sep 2026 14:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uMpYLsjDomogZwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 10 Sep 2026 14:50:48 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Julian Anastasov <ja@ssi.bg>,
	Eric Biggers <ebiggers@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 09/13 net-next] net: fib: split common nexthop logic to fib_core.c
Date: Thu, 10 Sep 2026 16:48:34 +0200
Message-ID: <20260910144914.8025-10-fmancera@suse.de>
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
X-Spam-Level: 
X-Spam-Score: -5.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.30 / 50.00];
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,suse.de,nvidia.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,ssi.bg,strlen.de,nokia-bell-labs.com,icloud.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLrr9ek4ud4f4qwi71m7motjzt)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,icloud.com]

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
 net/ipv4/Makefile          |   2 +
 net/ipv4/fib_frontend.c    |  96 ------------
 net/ipv4/fib_semantics.c   | 205 -------------------------
 net/ipv4/netlink.c         |   2 +
 net/ipv4/nexthop.c         |   9 +-
 net/ipv4/sysctl_net_ipv4.c |   2 +
 10 files changed, 353 insertions(+), 305 deletions(-)
 create mode 100644 net/core/fib_core.c

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 0a35355fb0f3..4bbafb7b723f 100644
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
+			      struct fib_config *cfg, int gfp,
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
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 83c25f52eb58..b540d549f25a 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -19,7 +19,9 @@ obj-$(CONFIG_IPV4) += route.o ip_input.o ip_fragment.o ip_forward.o ip_options.o
 obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
 obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o
 obj-$(CONFIG_PROC_FS) += proc.o
+ifeq ($(CONFIG_IPV4),y)
 obj-$(CONFIG_IP_MULTIPLE_TABLES) += fib_rules.o
+endif
 obj-$(CONFIG_IP_MROUTE) += ipmr.o
 obj-$(CONFIG_IP_MROUTE_COMMON) += ipmr_base.o
 obj-$(CONFIG_NET_IPIP) += ipip.o
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
index 50e96f86ca59..2e4f8dc3d2ef 100644
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
diff --git a/net/ipv4/netlink.c b/net/ipv4/netlink.c
index b920e1bdcf58..57d4dca16d3e 100644
--- a/net/ipv4/netlink.c
+++ b/net/ipv4/netlink.c
@@ -16,10 +16,12 @@ int rtm_getroute_parse_ip_proto(struct nlattr *attr, u8 *ip_proto, u8 family,
 	case IPPROTO_TCP:
 	case IPPROTO_UDP:
 		return 0;
+#if IS_ENABLED(CONFIG_IPV4)
 	case IPPROTO_ICMP:
 		if (family != AF_INET)
 			break;
 		return 0;
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 	case IPPROTO_ICMPV6:
 		if (family != AF_INET6)
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index a7c2b8dced4e..ea747fc2223c 100644
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
@@ -3970,6 +3970,7 @@ static int rtm_get_nexthop_bucket(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	return err;
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
 static void nexthop_sync_mtu(struct net_device *dev, u32 orig_mtu)
 {
 	unsigned int hash = nh_dev_hashfn(dev->ifindex);
@@ -3986,13 +3987,13 @@ static void nexthop_sync_mtu(struct net_device *dev, u32 orig_mtu)
 		}
 	}
 }
+#endif
 
 /* rtnl */
 static int nh_netdev_event(struct notifier_block *this,
 			   unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct netdev_notifier_info_ext *info_ext;
 
 	switch (event) {
 	case NETDEV_DOWN:
@@ -4004,8 +4005,12 @@ static int nh_netdev_event(struct notifier_block *this,
 			nexthop_flush_dev(dev, event);
 		break;
 	case NETDEV_CHANGEMTU:
+#if IS_ENABLED(CONFIG_IPV4)
+		struct netdev_notifier_info_ext *info_ext;
+
 		info_ext = ptr;
 		nexthop_sync_mtu(dev, info_ext->ext.mtu);
+#endif
 		rt_cache_flush(dev_net(dev));
 		break;
 	}
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 2f0363bca2a8..f6c7b755fa7e 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -613,6 +613,7 @@ static struct ctl_table ipv4_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
+#if IS_ENABLED(CONFIG_IPV4)
 	{
 		.procname	= "fib_sync_mem",
 		.data		= &sysctl_fib_sync_mem,
@@ -622,6 +623,7 @@ static struct ctl_table ipv4_table[] = {
 		.extra1		= &sysctl_fib_sync_mem_min,
 		.extra2		= &sysctl_fib_sync_mem_max,
 	},
+#endif
 };
 
 static const struct ctl_table ipv4_net_table[] = {
-- 
2.55.0

