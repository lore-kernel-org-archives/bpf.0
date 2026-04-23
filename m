Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC013CBE66
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915426; cv=none; b=LnVV5j+icbKe3+6j4+PPONqB80DwTLt63fJZpcwPmrZ7LyDeK0wXHoISVnvSa2VGMP2CZZgWcSvTbYWTH3BoPPowV6phJOjxVXY9UtGS7/C7cwryz/sMbzAXhToBl8xvoo1mmzzmhJip/UhSjGvFVGBjJfipZAdgI7eKPkG3yZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915426; c=relaxed/simple;
	bh=wcnfMGdlHl60YQonnhOA2/GyjiNRwx0KjpNJTQ11zck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Quhrtq3wE2YKTkc3FhMhKK33bDiSnhkbJnyAznHHgzYWUq2nDVc8Qfja9VQqpgk45P6SrkITBH6LnEkTF7TSG/ygYbl9GGU+8r1GUEePo9jEqFqAdkr2la3vPHEhAgbRpvaeM7+gNxMDEaBsR/GKYdjt4EgxgOeEuhqoekilsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i3Wa/Zsw; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i3Wa/Zsw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776915423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CK6SO9dc9sk8qjoqLwVJS2El683rRIc5yQHGsCMuc18=;
	b=i3Wa/ZswpZtn/i6szG8ujNem28VGbb6dvu02GoNmzj9sBsAXs4t7hpuLd6Rho4AFUQhGJ/
	LrdXWScyjPB9K0n8tuEdZMh5YPDP6dQXVCij9SCXK33RIYi8AjNiZQouf+JkulHIm9V4bR
	1YcRjkNc5mP43BuLcOA5ZvIPn+j0+Dg=
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf 2/2] bpf, netkit: reject offloaded programs on attach
Date: Thu, 23 Apr 2026 11:36:06 +0800
Message-ID: <20260423033609.252464-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260423033609.252464-1-jiayuan.chen@linux.dev>
References: <20260423033609.252464-1-jiayuan.chen@linux.dev>
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

Reject offloaded programs in both netkit_prog_attach() and
netkit_link_attach().

Fixes: 35dfaad7188cd ("netkit, bpf: Add bpf programmable net device")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/net/netkit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5c0e01396e064..c4f764034c90f 100644
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
@@ -788,6 +791,9 @@ int netkit_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
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

