Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.90
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029842;
	b=0TWzek6b0rKT1JTKkwUzsl35QzzGlhWGrErcOIzOeJOJJ/NVMMOTH/dkDLehqG97QTo/
	 YBm3/kK17ej6GMDYiur4d1suINJUqkGvtvMx7H848jzCLlVTJBudRVxiAvkYbZhdBCwZG
	 voTBbYHpD5njVJutsKbrLOmnkc53pFkaGVbdcUsw0ubESlRcbGjOxiPEzvY/HzxOITipG
	 wh+t3+GYkfGV9NvAXh6Pk5GKPzOSP4n+/Diu2yuqVPRgzwTseEyhUSfI/E05DhQjYmKHH
	 miVv1lSu4dBLDUa2q/amdUUy1UoxU7qJQPGZFlk2hz9UsMr/qsHoRmKCfyNvftaVrrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029842;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0GgTwwPhxHKDJaxjp3ZsZQ2i5SCoinxggJ42Y8Wa7ww=;
	b=UBzYWG840w5TzwwAKyrRO3p0xAT9+x1izajopyLZODWO//3xuyl85Ohpp5jV0x15UvVS
	 fCiimCfh4sa64UuiAOQhWYREyYFqWTY2g3wOm/Z9qsTSaRsuTHYRmsa2eUZUb2SzLos3M
	 BFKPR5/SOEHW1/aAdwOzblJO1eReNfr9ZYkHMrQPfe3v2wfbP2+ex5OPl1jmKWPtszE47
	 ZKgEG6sHfOtNyCpJ6b64djfnfzH1/p354zf+pE4MwO34dhcfGONN/KKPJGkbO9Ipfjqgj
	 TDD0FaZF0NE6PGjHrO46gPx9GqKEcpV5sl4F5jjuLUsGWY2SY65HmDeY0QdLXicVntA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="xV+fCm/n";
	arc=none smtp.remote-ip=91.218.175.90
Received: from mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7AD606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 15:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA7AD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xV+fCm/n
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HU2bpjyoPB1h+oxYZZwxq+ebGFwnC2mOUeNtg2/lv7w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793029840; v=1; x=1793634640;
 b=xV+fCm/n/oq6kc6tkfgPsB0yslbYkOcvnhytKPy7wW74zcL7uY/jxzlmuwckKtVoU5QXJyhl
 yeE2Xgd6kN9JoikagUnt+NEhKt3X0UOcbGGkjGvMuMyRr595T5cazfnmYGHzX9PSygLdt4owTCU
 9JKW7lGcUTazzAOdCNacA1Ng=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6930a7365b8b169f;
	Mon, 26 Oct 2026 15:50:40 +0000
X-Mizu-Trace-ID: 6930a7365b8b169f
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Masashi Honma <masashi.honma@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v5 2/6] bpf: Add syscall common attrs support for xdp link_create
Date: Mon, 26 Oct 2026 23:49:43 +0800
Message-ID: <20261026154948.99408-3-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026154948.99408-1-leon.hwang@linux.dev>
References: <20261026154948.99408-1-leon.hwang@linux.dev>
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

With the syscall common attrs support for link_create, add syscall common
attrs support for xdp link_create in order to report the invalid target
ifindex error and the underlying driver's error.

Instead of passing bpf log to bpf_xdp_link_attach(), pass an extack to
receive the underlying driver's error message. If pass bpf log to
bpf_xdp_link_attach(), it will introduce bpf_verifier.h dependency for
net/core/dev.c, which is not acceptable for maintainability.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/netdevice.h | 3 ++-
 kernel/bpf/syscall.c      | 6 +++++-
 net/core/dev.c            | 9 +++++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c0ae442c4344..6f7fec24ca5f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4440,7 +4440,8 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 				    struct netdev_queue *txq, int *ret);
 
-int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
+			struct netlink_ext_ack *extack);
 u8 dev_xdp_prog_count(struct net_device *dev);
 int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index db870e795d04..ca72b35cdcc9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5865,6 +5865,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *attr_common,
 		       bpfptr_t uattr_common, u32 size_common)
 {
+	struct netlink_ext_ack extack = {};
 	struct bpf_verifier_log *log;
 	struct bpf_log_attr attr_log;
 	struct bpf_prog *prog;
@@ -5944,7 +5945,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 		break;
 #ifdef CONFIG_NET
 	case BPF_PROG_TYPE_XDP:
-		ret = bpf_xdp_link_attach(attr, prog);
+		ret = bpf_xdp_link_attach(attr, prog, &extack);
 		break;
 	case BPF_PROG_TYPE_SCHED_CLS:
 		if (attr->link_create.attach_type == BPF_TCX_INGRESS ||
@@ -5980,6 +5981,9 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 	if (ret < 0) {
 		int err;
 
+		if (extack._msg)
+			bpf_log(log, "%s\n", extack._msg);
+
 		err = bpf_log_attr_finalize(&attr_log, log);
 		ret = err ? err : ret;
 		if (prog)
diff --git a/net/core/dev.c b/net/core/dev.c
index 1a09e7869118..4aa55259d5eb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10882,11 +10882,11 @@ static const struct bpf_link_ops bpf_xdp_link_lops = {
 	.update_prog = bpf_xdp_link_update,
 };
 
-int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
+			struct netlink_ext_ack *extack)
 {
 	struct net *net = current->nsproxy->net_ns;
 	struct bpf_link_primer link_primer;
-	struct netlink_ext_ack extack = {};
 	struct bpf_xdp_link *link;
 	struct net_device *dev;
 	int err, fd;
@@ -10895,6 +10895,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	dev = dev_get_by_index(net, attr->link_create.target_ifindex);
 	if (!dev) {
 		rtnl_unlock();
+		NL_SET_ERR_MSG(extack, "Invalid target_ifindex.");
 		return -EINVAL;
 	}
 
@@ -10916,14 +10917,14 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	}
 
 	netdev_lock_ops(dev);
-	err = dev_xdp_attach_link(dev, &extack, link);
+	err = dev_xdp_attach_link(dev, extack, link);
 	netdev_unlock_ops(dev);
 	rtnl_unlock();
 
 	if (err) {
 		link->dev = NULL;
 		bpf_link_cleanup(&link_primer);
-		trace_bpf_xdp_link_attach_failed(extack._msg);
+		trace_bpf_xdp_link_attach_failed(extack->_msg);
 		goto out_put_dev;
 	}
 
-- 
2.55.0

