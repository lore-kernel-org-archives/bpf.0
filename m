Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792891159;
	b=m+RX4zws8CxkSV9fNSY7phX0zNYF/jMI9+2icXVjTYiMmZ81AD3rP2AcKrES2m8Uc3Sz
	 KvOX/uMVhcBFU+KTKCzizop1hZ9IJ3j1aG0jqTa1IwRZv5CBaoAQax7TbODS6zD1QDvS4
	 iFjrVS11ZVt8wVCiVo2uwcBulVJ9w1QabFk6LAup8aIO8mFLAoAL1Is4tcpk+zfLGVxas
	 cNDUdFtwhQBh4Q6E75bBBgN0Wa6P6MYce6992eZ4extVrJrWMIfdpoa0Ywa8YPagdc2DJ
	 dK+FQCQj+CCQsQ8a2Oug6sCO7FuYD2yCExjc7t6qDcE82G0XI0DMFCOv9hBwD9Osv2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792891159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=zZQiqU7HN1B6GTDcBYXT/sQqb91Q6ayBvJSvSKkioZE=;
	b=fME/ukGFK3QdHgyskSzb/qBGj9Z8EnemtdGUcXfC0n4pTuT6bnOdmBd11dZOg2TQe/Pr
	 /YK4ilwap7vBefj9Gkx6y3nAZI8A0xqcq4SbrFIUh70exuhoSNmHmBC0UXPSZm9JIVWvB
	 x3fUt/pmZTutMvE3lAfucKJ2nc16+mJ15DeJMlvYkA4DNd5I+uLqdNtA0okiwy4/jhVnV
	 4EZS/n//knBt/VsPY91AZkDxFrZYzjMUEPfJeLHZzWjhJ4rjPxegu1mPMvXAQVUqtDV76
	 MDa/7rY8uaRzZyz5i0cCzhqFIDT8zhZY3LJxm4oh5jSQpHLFHrxRK2B7bCzAYeUEksQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nyUFwVcj;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7537606A31F
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 01:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7537606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nyUFwVcj
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso1557529a91.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 18:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792891158; x=1793495958; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zZQiqU7HN1B6GTDcBYXT/sQqb91Q6ayBvJSvSKkioZE=;
        b=nyUFwVcjgd6g3xuNlSD/rMAoH+5rhnVhKVDNLCsK4WeHGC6W0qiL1ts8cv2tR1rrUV
         25HBD5SR+xxXKkJEZAgiBcwUwzFB/8BmOaZyQfXgksIEQPAA7hzt77jyYLP8tiOFUItI
         W9iZBfz9LCduMPMN5NGg4KhetNlKWFha5VYkZea131wCfXvhV3PdR6ebjUC9EoVAVyn2
         AH/Evm6Z7YrF7QQ6sOLK36AH4Sy4N30imPWThuGRMJQXCQD/m6QVbiS8UFrPoTvwbgoy
         C5oM7nXa3UKdOZ8ZAuZnhUnSXyuO1smqDpTLCqvs//S/k1X8Fb5g6Tk/wRdQk1gvuJ9F
         qGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792891158; x=1793495958;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZQiqU7HN1B6GTDcBYXT/sQqb91Q6ayBvJSvSKkioZE=;
        b=EG26BRRjG1zufptnuTbt+TptCDVGTjblbAfWnD3pgAZEPtEuovwyjAl29l+evSmg+Y
         ShU5JqlWEONhpgDEOW4t+CfebIaZZ2H6+JFktQYzdfCiRcBahiv4jOcFJnMJjF5tHpBV
         mpj9Njuwl4UgR29KaGe5TkvW+GA1BJn2paCgL7ZNkuPttVahnVGqvjQsf/Cs+QzabF0T
         wsSgWqUpr+iDhYyZt50wQlpYpAb/o7mB8bw+DOghR1nFls4Cvd7ehSWO0rs5ooJX8R4u
         HurPp5xnYXBs5Ib8RJ2btqbmBDiMviaowUhvj6zxMwO8EJbcUV9ckArp7wA3aYzZed7X
         R5bw==
X-Forwarded-Encrypted: i=1; AKwUvBwp8sFGaGmQa/3utBgU0B5fKD0CzpEuJz3ioLwCznRGQX27b8Itex4oN5f5ztWlNVtBqao=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpJ8g4qaxCjmLTHY06bx+pFi8qR+v3clum2O5PVwt/+jXntX54
	7dBRSbyX6tQYx5SxQFn9pcSr8kM7k7ygSkdjl52/fFKWFJkShljhZ4/zJDO1sQ==
X-Gm-Gg: AYBFou3g/sW1Du1wEAdzD4C4B8rZPB/CJPxd3qQUhvUUmKNPB1j7mJPPluIsd6N+gFv
	IpqzKQ5P0gB8Brax1wCv76X5aOYgQWu2+d3kxO81w2FIaQA7CMD0V+ryFsHmbVI5sapr/CvHRWL
	18dZSTrhdPi/r6blDy06FQs8oxLLtapaYXv7dTh1e17SP6XSScWQNoRsAxG2bhNL6OwY1GbkInx
	LYcSCd7LO4TIyaXsdbWDYYNwp2sNPBUT19GLn7tr4jswgT64oCCRCib9cJGm2Pp/G2snpfIA9UD
	gMKQMmIjOGAwUaQT227GDXes53qIw1wZiNl9z1hVwCj6t4F4vNWd8CFkKU8CLU6a/a31lnU+Lx7
	+lxXA6A3qRCfp2EIcjHaovyPkJX8iZSah9xZUD9kumjNY4DlcVLDkPc6x2AYGVMqPmvzpoJH6qm
	uDkclahE0MtsAj5SgQUS3E4/CD+XDbDAblOMy2yx2p2lsDaAN8IBLpnQ0zmUXgWxfKrAyhUbifo
	6KR1F1pBiIlUhmep8JuUbWB3rvSPB34Sct38NX0tjHc4qTEu56cKZ6Fanj/vCK1JD3XPVcBFnAr
	HAh86S7Trfz5Dihx9HADCz9xlr046WIcPiS7mj9Y6wTD+mXCM9x/UzhZc4ge
X-Received: by 2002:a17:90b:1a92:b0:3a0:bbd8:5ba7 with SMTP id 98e67ed59e1d1-3adeafd7770mr2867415a91.62.1792891158057;
        Sat, 24 Oct 2026 18:19:18 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32f70sm3963081a91.1.2026.10.24.18.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 18:19:17 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Oct 2026 01:19:16 +0000
Message-Id: <DMDIVEW7P9QN.1TB58XDPD7V3A@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Shuah Khan" <shuah@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Hangbin Liu"
 <liuhangbin@gmail.com>, "Martin Karsten" <mkarsten@uwaterloo.ca>, "Masashi
 Honma" <masashi.honma@gmail.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add syscall common attrs support
 for xdp link_create
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261024153608.58569-3-leon.hwang@linux.dev>
References: <20261024153608.58569-1-leon.hwang@linux.dev> <20261024153608.58569-3-leon.hwang@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Oct 24, 2026 at 08:36 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> Instead of passing bpf log or extack to bpf_xdp_link_attach(), pass an
> errmsg pointer to receive the kstrdup() error msg, because

[...]

> 2) passing extack will access underlying driver string out of dev_put()
>    guard, which will crash kernel when the device is unloaded
>    concurrently.

Netlink does exactly that.
rtnl_setlink() looks up the dev with __dev_get_by_index(), so no refcnt,
do_setlink() -> dev_change_xdp_fd(dev, extack, ...) calls into the same
drivers that set the same strings, rtnl is unlocked, and only then
netlink_rcv_skb() -> netlink_ack() does strlen(extack->_msg).
All extack users work this way. kstrdup() in one of them fixes nothing.

Instead of patches 1 and 2:

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c0ae442..6f7fec2 100644
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
index 90bc723..0ce75ee 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5862,8 +5862,12 @@ err_put:
 }

 #define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.path_fd
-static int link_create(union bpf_attr *attr, bpfptr_t uattr)
+static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *attr_common,
+		       bpfptr_t uattr_common, u32 size_common)
 {
+	struct netlink_ext_ack extack = {};
+	struct bpf_verifier_log *log;
+	struct bpf_log_attr attr_log;
 	struct bpf_prog *prog;
 	int ret;

@@ -5873,14 +5877,24 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	if (attr->link_create.attach_type == BPF_STRUCT_OPS)
 		return bpf_struct_ops_link_create(attr);

+	log = bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common, size_common);
+	if (IS_ERR(log))
+		return PTR_ERR(log);
+
 	prog = bpf_prog_get(attr->link_create.prog_fd);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
+	if (IS_ERR(prog)) {
+		bpf_log(log, "Invalid prog_fd.\n");
+		ret = PTR_ERR(prog);
+		prog = NULL;
+		goto out;
+	}

 	ret = bpf_prog_attach_check_attach_type(prog,
 						attr->link_create.attach_type);
-	if (ret)
+	if (ret) {
+		bpf_log(log, "Invalid attach_type.\n");
 		goto out;
+	}

 	switch (prog->type) {
 	case BPF_PROG_TYPE_CGROUP_SKB:
@@ -5931,7 +5945,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		break;
 #ifdef CONFIG_NET
 	case BPF_PROG_TYPE_XDP:
-		ret = bpf_xdp_link_attach(attr, prog);
+		ret = bpf_xdp_link_attach(attr, prog, &extack);
 		break;
 	case BPF_PROG_TYPE_SCHED_CLS:
 		if (attr->link_create.attach_type == BPF_TCX_INGRESS ||
@@ -5959,12 +5973,22 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = bpf_uprobe_multi_link_attach(attr, prog);
 		break;
 	default:
+		bpf_log(log, "Invalid prog type.\n");
 		ret = -EINVAL;
 	}

 out:
-	if (ret < 0)
-		bpf_prog_put(prog);
+	if (ret < 0) {
+		int err;
+
+		if (extack._msg)
+			bpf_log(log, "%s\n", extack._msg);
+		err = bpf_log_attr_finalize(&attr_log, log);
+		ret = err ? err : ret;
+		if (prog)
+			bpf_prog_put(prog);
+	}
+	kfree(log);
 	return ret;
 }

@@ -6536,7 +6560,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_map_do_batch(&attr, uattr.user, BPF_MAP_DELETE_BATCH);
 		break;
 	case BPF_LINK_CREATE:
-		err = link_create(&attr, uattr);
+		err = link_create(&attr, uattr, &attr_common, uattr_common, size_common);
 		break;
 	case BPF_LINK_UPDATE:
 		err = link_update(&attr);
diff --git a/net/core/dev.c b/net/core/dev.c
index 1a09e78..4aa5525 100644
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

I'm think I gave this suggestion earlier. Why did you go with strdup()?

pw-bot: cr
