Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.248
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792856201;
	b=0AtjZqibXihhfhsCj6Ao10zJLknJCWVqir+LWwF0U/xoaQ6Bf2fzdhrmF/FF5DtYFDx3
	 m4l4Lh3xG8ZRIhpaB833HrhZ3Qk/CdeMnfi59Lxq6yytWpL6a+6WZ8FleQ0LcF29jUF/q
	 OiHazm+RmN+qjXWpDGYiQLt7SN1Q201Zbjo1615XsA1kT7t5YjigMlGerAJftdaJ09Aa4
	 guQorciR9pWyCGJoaOWjsMkUjvZ8Krg15DO8NV6ifuQBe28Fbh/eV6UC4UB3NhwD3r07w
	 UX+6FlRu4Yu0REeFmve79Fe/a95mbQaAvE1mH57oYg52IwgIf3bsjAt4WHYG036dgXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792856201;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a+nb5fMHNq3c0C2SV1PD8yo0NFxaM4tJ1l1GIBdS9vE=;
	b=4ZpX4BqCAtl8Q/tC4uFFuZAigQyhJW/IeDMMYfGfwBtRqJUvxsjlQjK3APxUB5ye33zZ
	 i3Dmq1UDDRwvc2Lq/M7e2Rx3ExPHse32PT83Eo/44/inIuKrn9+I4KW1FIobQww1ZdOLI
	 +isqJADWVDjP8N/A9OQ+usq/qe9jlUAK0H+TUf17bpuymQHYghI/uK221jGBkGhAR0vt6
	 hMwCNtT5I8Rw+dBr/0bvQqBUvSU8537VgeLb0MAwwWI/8vN0TghS+4/5Bv8Wk2K15CY/7
	 IFmnWY715MhDgFRbzuFs/nGWYzh3TWBhtD3f7UE0JJiSrMxsHmdQqgQswPisy5aOfxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=upualYhJ;
	arc=none smtp.remote-ip=95.215.58.248
Received: from mta1.migadu.com (out-248.mta1.migadu.com [95.215.58.248])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21353606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 15:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21353606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=upualYhJ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LccX4JzkfFezMRhne71qI67P5BNkJoGbmfyyRrKWpJ0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792856199; v=1; x=1793460999;
 b=upualYhJOeZAm/60amhY4g7o0IJhZ+puYGqE5WzSksIfLxUU5VRWudfb18yAiwZbSAuS6gR8
 O/eBIjTVxh7pY1mRBndFFwyb27cAIyUJM51N2wJMzsC9WkWPYMCUgWVqrfFZgZAmG/w1PM6RVp9
 OC0IbJzF9xqBneJ3ynN+aQiE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a73c5cda94f8f57e;
	Sat, 24 Oct 2026 15:36:39 +0000
X-Mizu-Trace-ID: a73c5cda94f8f57e
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
Subject: [PATCH bpf-next v4 2/6] bpf: Add syscall common attrs support for xdp link_create
Date: Sat, 24 Oct 2026 23:36:03 +0800
Message-ID: <20261024153608.58569-3-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024153608.58569-1-leon.hwang@linux.dev>
References: <20261024153608.58569-1-leon.hwang@linux.dev>
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

Instead of passing bpf log or extack to bpf_xdp_link_attach(), pass an
errmsg pointer to receive the kstrdup() error msg, because
1) passing bpf log will introduce bpf_verifier.h dependency for
   net/core/dev.c, which is not acceptable for maintainability.
2) passing extack will access underlying driver string out of dev_put()
   guard, which will crash kernel when the device is unloaded
   concurrently.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/netdevice.h | 3 ++-
 kernel/bpf/syscall.c      | 8 +++++++-
 net/core/dev.c            | 6 +++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c0ae442c4344..e07b740604c7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4440,7 +4440,8 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 				    struct netdev_queue *txq, int *ret);
 
-int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
+			char **errmsg);
 u8 dev_xdp_prog_count(struct net_device *dev);
 int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index db870e795d04..675bff4d7aab 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5868,6 +5868,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 	struct bpf_verifier_log *log;
 	struct bpf_log_attr attr_log;
 	struct bpf_prog *prog;
+	char *errmsg = NULL;
 	int ret;
 
 	if (CHECK_ATTR(BPF_LINK_CREATE))
@@ -5944,7 +5945,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 		break;
 #ifdef CONFIG_NET
 	case BPF_PROG_TYPE_XDP:
-		ret = bpf_xdp_link_attach(attr, prog);
+		ret = bpf_xdp_link_attach(attr, prog, &errmsg);
 		break;
 	case BPF_PROG_TYPE_SCHED_CLS:
 		if (attr->link_create.attach_type == BPF_TCX_INGRESS ||
@@ -5980,6 +5981,11 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 	if (ret < 0) {
 		int err;
 
+		if (errmsg) {
+			bpf_log(log, "%s\n", errmsg);
+			kfree(errmsg);
+		}
+
 		err = bpf_log_attr_finalize(&attr_log, log);
 		ret = err ? err : ret;
 		if (prog)
diff --git a/net/core/dev.c b/net/core/dev.c
index 1a09e7869118..da71c0d2120c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10882,7 +10882,8 @@ static const struct bpf_link_ops bpf_xdp_link_lops = {
 	.update_prog = bpf_xdp_link_update,
 };
 
-int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
+			char **errmsg)
 {
 	struct net *net = current->nsproxy->net_ns;
 	struct bpf_link_primer link_primer;
@@ -10895,6 +10896,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	dev = dev_get_by_index(net, attr->link_create.target_ifindex);
 	if (!dev) {
 		rtnl_unlock();
+		*errmsg = kstrdup("Invalid target_ifindex.", GFP_KERNEL);
 		return -EINVAL;
 	}
 
@@ -10923,6 +10925,8 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (err) {
 		link->dev = NULL;
 		bpf_link_cleanup(&link_primer);
+		if (extack._msg)
+			*errmsg = kstrdup(extack._msg, GFP_KERNEL);
 		trace_bpf_xdp_link_attach_failed(extack._msg);
 		goto out_put_dev;
 	}
-- 
2.55.0

