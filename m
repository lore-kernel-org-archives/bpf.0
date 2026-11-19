Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052338;
	b=jC8XzW/YLLcRbULSAfkVimT+U0QTkFvaROSZ9txzPWVPTbOniHgE3X+tsI1o934cUpZB
	 JFvRu/onRrVLLbC/3JBNKv3R9dp0qtaEJmYzr7fFsKs754t1Wrf86e04XJTKvP1cbx6GU
	 oyn5YTa+j6fds6xe08uVXDEmk/zdVdo33fllBrwvv3/ScGUT5y40UPpFYfJYRqmISGRUI
	 /iqxBep6JXdCgo7X7sUy1g0LVyQb7Rw9Dsh28dRZQTNGKDrCQwHKxgV7jXrQVomdHb2Ut
	 sbUWsQL4yNeXGaD2P37vPeoJv3kKCTGyXEs2QU3Fk9MxnP7hb+bwrV9BZU7XG9nigFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=p9sCOQg/dMZ7Rd63VyRepYTcZSwbEdVG57pOIDANFoI=;
	b=FT7IPzaE3b3Uqs9XutUhZCwmbJzj5L0WWqVdj0lAwDSEEFM7jaS3lb+/NTUReWAEpugN
	 8ZSovtq9ALR2TGWoUdkvPh1Y0KJfzxYVLoB3sA0V0ev8RPSNB0RRJiTmLtCK3TCD154wj
	 lK/NST4bo5PYOUQf5WULcydDfiw3yaNF/OvrtVz7mcqbJJkmdbk2Q5PBwQdxZEwHmtfrD
	 1YyOWSNW/bQgyNIbn/kGNxJ5yo3lFINkzcIDPmX94wQURh8Efeo68JPdO1Mg3xgaJgSs5
	 /of583l7RqiVr8D76gdg5NxikAOnlqkEM1Q8kIkVZj1P8oCHqOqEIos7YXoyuK0DKgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Ia458sbm;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6C60A261B
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FA6C60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Ia458sbm
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c5127c7abd5so55191266b.3
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795052337; x=1795657137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p9sCOQg/dMZ7Rd63VyRepYTcZSwbEdVG57pOIDANFoI=;
        b=Ia458sbmC3cw15zUHGU3Ek5PJNQgl1oj0/shbnzbZtERMBbHlERJ6JbmrHHzAtPB26
         ju2xF8kKQ2xlaWRkMT6C2flExAscKJFGM719rFGh+gZULjQ+xh5VOr7tz6mGCYoMPohB
         5vexn3/4FLptCPy7wSfvAlynhREu6YHtLVp5cFvpt9oHYM5OYZhp+QV2BjKcCsW9laLD
         F5xpP+yTN4/32ESAqNDFKUk1IK/MajzJcb7dVb+H4BXQ+ErmTBl7M8EsvJoYFgWYnrsq
         llHiiBKUHz1Zm7i+TT47xgUUNX6KR4j84fYIzL5A8OnNvVDdm5yspQ/6u1lrYeaf/oyX
         mozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795052337; x=1795657137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p9sCOQg/dMZ7Rd63VyRepYTcZSwbEdVG57pOIDANFoI=;
        b=aug0gZC191AdXGifZ7+EwNyZdWIJFB84iZm+zSdogAbCelenmJVeedtdvbjMgzsT2B
         E1lyAg9XTzu3nVLxbWjlR5PqtLYIYAfir6HAPQH1v5PB+hEkoefwzrTa1CLAbRMaRdt1
         zHoqGontEyTIkDy4lIovki9GkF2Kbl0JV9ftcAtxUu6I14dlVwqqWHFH/KvjXLfg3d/s
         T1LCPuLG0vXWmaBlAh1PIE6aQ93gtnQIIKQ4+DjyHoKGp06pE6q2sD56Yy79smWCPIy+
         8/0qhh5AeYr9w8Dd147jbnCNVbHk1zPIjqFXG11SiercLTTTwfq5NyDxI1msi8aQ9awv
         YQUg==
X-Forwarded-Encrypted: i=1; AL+hErGyK4GeAjFch/eqF6s18bklK5nFF8CThwByj2mkFP1WtE/5pohhjwi3VSkD1H9rhugO3RQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8elLLVWP3U1hTLRcJ+NHjeP9nEZFenjWPn005xfz05/eR2B+4x
	dO9qsz5ydlix8uIwzx3vJO0z0MZ2SrZ4DyS+B+NKVP1M43gTlmSvNpPiwBLJpo1xZ4I=
X-Gm-Gg: AYBFou0X/XxMJFjzHeMLXqSePTmx88q64je4wazjWpiNToQC/1pWmZokdF9Yc+bYIZF
	ZA3Rnue15c5a4xYOWVn0Z2QIsjFgKeAsV80OoFLJn0tb7zgfKV6otzlzF5eEcJ42j00KnFnrg6q
	vRqjZFB5Uq1rUg/Wex+kzdKPtxhlxPrTjNKgEZz7RnTi4F38NTSWnVpGhpXC23uvE1PsZVEgFQ4
	2rqJ9ytxbe9ZhwvTJ9U9kVWRn906CMDV5mZanJwAyRwFN2SXQKbixxM/ll4JYQ7j1xQqDGsVk1D
	9AF5xP8xF3TFBUDOLTzKMbXh69Fgvdx0BMuHjFsq/BpYVGQgV7llzkxgF8b8YLB4udhUBSH6dlj
	XZKJlhagoxH4gz3JX90EyHsKhiBTeiwiF193RVWa0hUYlub1G1cSPuhYK1XverRbB1+71zhGPo7
	dFbUUjRJZSpfiF6QhyKFWjH5DiVgnsx3N/X9l3SDAo9h42OkE++L9ZsVsXr6HpJfsR48kMXBD5N
	W/c6lQChOLiAUXYushP9AMYBqXs9dYAaE4+g4uyTFIwYnWPhCSBS7Sg+gxX7wrfFIyx703j1XeA
	6Q2FJK7HiOAUj6IdbOG9kM6bvp6JyJAfQQGOhCmXDYU069KvFipLYknjuQ==
X-Received: by 2002:a17:907:7281:b0:c46:ca3a:10d5 with SMTP id a640c23a62f3a-c510e3b3d35mr427316266b.45.1795052336678;
        Wed, 18 Nov 2026 17:38:56 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4080sm59785966b.16.2026.11.18.17.38.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 17:38:55 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Danielle Ratson <danieller@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Anil Kaushik <anilkaushikwireless@gmail.com>,
	Demos Ra <demosthenes.ra@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Joe Damato <joe@dama.to>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Li RongQing <lirongqing@baidu.com>,
	Louis Scalbert <louis.scalbert@6wind.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Song Liu <song@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Wang Zhan <wang.zhan@smartx.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Zhou Qiuyue <n0ps1edzz@gmail.com>,
	Tianyi Gao <tianyi.gao@linux.dev>,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v2 06/11] bpf, tcx: Set tx_extra_headroom from a decl tag on egress programs
Date: Thu, 19 Nov 2026 01:38:25 +0000
Message-ID: <20261119013830.36935-7-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119013830.36935-1-tianyi@cloudflare.com>
References: <20261119013830.36935-1-tianyi@cloudflare.com>
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

A program at TC egress can push headers, for example to encapsulate a
packet. A locally generated packet gets only LL_RESERVED_SPACE() of
headroom, so bpf_skb_adjust_room() reallocates every such packet.

The kernel cannot know how many bytes a program pushes. Let the program
declare it with a BTF decl tag on its main function:

	SEC("tcx/egress")
	__attribute__((btf_decl_tag("tx_extra_headroom:64")))
	int prog(struct __sk_buff *skb)

The verifier parses the tag when the program is loaded, as it does for
"exception_callback:", and stores the value in struct bpf_prog_aux. The
new field fills a hole after freplace_link_cnt, so struct bpf_prog_aux
does not grow. The verifier rejects the program if the tag does not
parse or exceeds NETDEV_TX_EXTRA_HEADROOM_MAX (512 bytes).
tx_extra_headroom is then recalculated with
netdev_update_tx_extra_headroom() under RTNL whenever an egress program
is attached, detached or replaced.

The egress programs of a device run one after another, so the headers
that they push can add up. Their tags are summed and added to the
headroom for XDP on the veth peer. The total is capped at
NETDEV_TX_EXTRA_HEADROOM_MAX.

Tags on programs at tcx ingress, on tail call targets and on freplace
programs are ignored, like "exception_callback:" on subprogs. An ingress
program does not see transmitted packets. A tail call target or a
freplace program is never attached at tcx, so its tag is never added.
The tag on the attached program covers the whole chain.

Only tcx is supported. A cls_bpf filter is attached to a tc block,
which can be shared by several devices.

Suggested-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
v2:
- New patch, replaces IFLA_TX_EXTRA_HEADROOM for the TC egress case
  (Dragos, Willem, Stephen).
---
 Documentation/networking/netdevices.rst | 15 ++++++++++++
 include/linux/bpf.h                     |  1 +
 include/net/tcx.h                       |  6 +++++
 kernel/bpf/tcx.c                        | 24 +++++++++++++++++++
 kernel/bpf/verifier.c                   | 31 +++++++++++++++++++++++++
 net/core/dev.c                          |  4 +++-
 6 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 53ca8439f73b..128a93303a6d 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -459,12 +459,27 @@ values:
 
 * ``XDP_PACKET_HEADROOM`` (256 bytes) minus ``needed_headroom``, when the
   peer of a veth or netkit device has an XDP program
+* the headroom that the programs at tcx egress of the device declare
 
 When the peer has an XDP program, locally generated UDP, raw and
 AF_PACKET packets and AF_XDP packets in copy mode have enough headroom
 for it. ``tx_extra_headroom`` is not recalculated when a bridge or
 openvswitch changes ``needed_headroom`` later.
 
+A program at tcx egress declares its headroom with a BTF decl tag on its
+main function. The value is a decimal number of bytes:
+
+.. code-block:: c
+
+  SEC("tcx/egress")
+  __attribute__((btf_decl_tag("tx_extra_headroom:64")))
+  int prog(struct __sk_buff *skb)
+
+The tag of the attached program covers the whole tail call chain. Tags on
+tail call targets, freplace programs and programs at tcx ingress are
+ignored. Loading a program whose tag is above 512 or does not parse fails
+with ``-EINVAL``.
+
 NETDEV_INTERNAL symbol namespace
 ================================
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fdbf638300fc..bca6d0b960cb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1952,6 +1952,7 @@ struct bpf_prog_aux {
 	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
 	u16 stack_arg_sp_adjust;
 	u16 freplace_link_cnt; /* counts freplace links extending this prog */
+	u16 tx_extra_headroom; /* from the "tx_extra_headroom:" decl tag */
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
diff --git a/include/net/tcx.h b/include/net/tcx.h
index 23a61af13547..9ab299ecd902 100644
--- a/include/net/tcx.h
+++ b/include/net/tcx.h
@@ -164,6 +164,7 @@ int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int tcx_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int tcx_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog);
 void tcx_uninstall(struct net_device *dev, bool ingress);
+unsigned int tcx_tx_extra_headroom(struct net_device *dev);
 
 int tcx_prog_query(const union bpf_attr *attr,
 		   union bpf_attr __user *uattr);
@@ -193,6 +194,11 @@ static inline int tcx_prog_detach(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
+static inline unsigned int tcx_tx_extra_headroom(struct net_device *dev)
+{
+	return 0;
+}
+
 static inline int tcx_prog_query(const union bpf_attr *attr,
 				 union bpf_attr __user *uattr)
 {
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 02db0113b8e7..99da16e13981 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -46,6 +46,8 @@ int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 			tcx_skeys_inc(ingress);
 		}
 		bpf_mprog_commit(entry);
+		if (!ingress)
+			netdev_update_tx_extra_headroom(dev);
 	} else if (created) {
 		tcx_entry_free(entry);
 	}
@@ -86,6 +88,8 @@ int tcx_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog)
 		bpf_mprog_commit(entry);
 		if (!entry_new)
 			tcx_entry_free(entry);
+		if (!ingress)
+			netdev_update_tx_extra_headroom(dev);
 	}
 out:
 	rtnl_unlock();
@@ -119,6 +123,20 @@ void tcx_uninstall(struct net_device *dev, bool ingress)
 		tcx_entry_free(entry);
 }
 
+unsigned int tcx_tx_extra_headroom(struct net_device *dev)
+{
+	struct bpf_mprog_entry *entry = tcx_entry_fetch(dev, false);
+	unsigned int headroom = 0;
+	struct bpf_mprog_fp *fp;
+	struct bpf_prog *prog;
+
+	if (!entry)
+		return 0;
+	bpf_mprog_foreach_prog(entry, fp, prog)
+		headroom += prog->aux->tx_extra_headroom;
+	return headroom;
+}
+
 int tcx_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
 {
 	bool ingress = attr->query.attach_type == BPF_TCX_INGRESS;
@@ -160,6 +178,8 @@ static int tcx_link_prog_attach(struct bpf_link *link, u32 flags, u32 id_or_fd,
 			tcx_skeys_inc(ingress);
 		}
 		bpf_mprog_commit(entry);
+		if (!ingress)
+			netdev_update_tx_extra_headroom(dev);
 	} else if (created) {
 		tcx_entry_free(entry);
 	}
@@ -193,6 +213,8 @@ static void tcx_link_release(struct bpf_link *link)
 		bpf_mprog_commit(entry);
 		if (!entry_new)
 			tcx_entry_free(entry);
+		if (!ingress)
+			netdev_update_tx_extra_headroom(dev);
 		tcx->dev = NULL;
 	}
 out:
@@ -237,6 +259,8 @@ static int tcx_link_update(struct bpf_link *link, struct bpf_prog *nprog,
 		oprog = xchg(&link->prog, nprog);
 		bpf_prog_put(oprog);
 		bpf_mprog_commit(entry);
+		if (!ingress)
+			netdev_update_tx_extra_headroom(dev);
 	}
 out:
 	rtnl_unlock();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e4700fda66b..e241ee20927a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2683,6 +2683,33 @@ static int add_subprog(struct bpf_verifier_env *env, int off)
 	return i;
 }
 
+static int bpf_find_tx_extra_headroom(struct bpf_verifier_env *env)
+{
+	struct bpf_prog_aux *aux = env->prog->aux;
+	const struct btf_type *t;
+	const char *value;
+	u16 headroom;
+
+	if (!aux->func_info_cnt)
+		return 0;
+	t = btf_type_by_id(aux->btf, aux->func_info[0].type_id);
+	value = btf_find_decl_tag_value(aux->btf, t, -1, "tx_extra_headroom:");
+	if (IS_ERR(value)) {
+		if (PTR_ERR(value) == -ENOENT)
+			return 0;
+		verbose(env,
+			"multiple tx_extra_headroom tags for main subprog\n");
+		return PTR_ERR(value);
+	}
+	if (!isdigit(*value) || kstrtou16(value, 10, &headroom) ||
+	    headroom > NETDEV_TX_EXTRA_HEADROOM_MAX) {
+		verbose(env, "invalid tx_extra_headroom tag '%s'\n", value);
+		return -EINVAL;
+	}
+	aux->tx_extra_headroom = headroom;
+	return 0;
+}
+
 static int bpf_find_exception_callback_insn_off(struct bpf_verifier_env *env)
 {
 	struct bpf_prog_aux *aux = env->prog->aux;
@@ -3264,6 +3291,10 @@ static int add_subprogs(struct bpf_verifier_env *env)
 		}
 	}
 
+	ret = bpf_find_tx_extra_headroom(env);
+	if (ret < 0)
+		return ret;
+
 	ret = bpf_find_exception_callback_insn_off(env);
 	if (ret < 0)
 		return ret;
diff --git a/net/core/dev.c b/net/core/dev.c
index 6e053f612d72..6d11d5ad13e1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10687,8 +10687,10 @@ static void __netdev_update_tx_extra_headroom(struct net_device *dev,
 	if (peer && dev_xdp_prog_count(peer) &&
 	    needed_headroom < XDP_PACKET_HEADROOM)
 		tx_extra_headroom = XDP_PACKET_HEADROOM - needed_headroom;
+	tx_extra_headroom += tcx_tx_extra_headroom(dev);
 
-	WRITE_ONCE(dev->tx_extra_headroom, tx_extra_headroom);
+	WRITE_ONCE(dev->tx_extra_headroom,
+		   min(tx_extra_headroom, NETDEV_TX_EXTRA_HEADROOM_MAX));
 }
 
 /**
-- 
2.56.0

