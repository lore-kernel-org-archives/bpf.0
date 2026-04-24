Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A3B38B147
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027365; cv=none; b=dH1cOZ+Y6vC0xeBXTD4FHOJmkFeZOyQ5ZkQJ/O13wSDrogEKtKaxOyNRfG22I8Jzr/m+imK8PZhrWkbcFIkaSwc/gnbe9N1HIfPMxkq3mnJXPpHEFdGuhNEgn5QD6KZgwxThJWfOWSjsh0h6L6C5GJ/3YdTzFb6X3aWXtAAMemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027365; c=relaxed/simple;
	bh=wpabQn1ol/qItAAjOBPAvpNVjKrZhE/WdQTRvEr4a78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tepdzr96ZFMIXHGQLK3wLcSlbZRhFzQ+ybXot+YtIaqoXDG67bvWF4fge6HNDcOGBex3Nq1ecBnZpTidTYsaF3iON+JC3Zga2Bcuu9dig7FAfVVItYbJOClwqUh+FwkBBB/oMzQKpQl6XcS50gXkCnrYUjaWcT4pqzTTJmTVR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TJ2F6pv8; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TJ2F6pv8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777027361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jk7ozpk8BJdqj1K1xG4zup/ZZJh6Q5ZPNMKI0G/5YVU=;
	b=TJ2F6pv8tfnL3d8biVvAVVopk33/6mK7bR+gtjdDvF0cBiNmG9u+ahJPTZn934Ig7jbqWE
	An/JgFz9B4Mq6XI99mwkUdJs2KxvH9f17sMaz2lni0DvKZxZDnnyJoMq0gzvlePjsmVim1
	TdVkc0i7rlyroI+gnDdGNGddffpa/TY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 2/3] bpf, netkit: reject offloaded programs on attach
Date: Fri, 24 Apr 2026 18:41:41 +0800
Message-ID: <20260424104201.217604-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260424104201.217604-1-jiayuan.chen@linux.dev>
References: <20260424104201.217604-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Same issue as the tcx fix: netkit accepts SCHED_CLS programs but never
checks if they were loaded for hardware offload. If someone loads a
program with prog_ifindex pointing to an offload-capable device and then
attaches it to a netkit peer, the bpf_func is bpf_prog_warn_on_exec()
and the first packet triggers the WARN.

Reject offloaded programs in netkit_prog_attach(), netkit_link_attach()
and netkit_link_update().

Fixes: 35dfaad7188cd ("netkit, bpf: Add bpf programmable net device")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/net/netkit.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5c0e01396e064..dae4d7b24d80e 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -533,6 +533,9 @@ int netkit_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct net_device *dev;
 	int ret;
 
+	if (bpf_prog_is_offloaded(prog->aux))
+		return -EINVAL;
+
 	rtnl_lock();
 	dev = netkit_dev_fetch(current->nsproxy->net_ns, attr->target_ifindex,
 			       attr->attach_type);
@@ -683,6 +686,9 @@ static int netkit_link_update(struct bpf_link *link, struct bpf_prog *nprog,
 	struct net_device *dev;
 	int ret = 0;
 
+	if (bpf_prog_is_offloaded(nprog->aux))
+		return -EINVAL;
+
 	rtnl_lock();
 	dev = nkl->dev;
 	if (!dev) {
@@ -788,6 +794,9 @@ int netkit_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct net_device *dev;
 	int ret;
 
+	if (bpf_prog_is_offloaded(prog->aux))
+		return -EINVAL;
+
 	rtnl_lock();
 	dev = netkit_dev_fetch(current->nsproxy->net_ns,
 			       attr->link_create.target_ifindex,
-- 
2.43.0

