Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04BE2D9EFB;
	Fri, 24 Apr 2026 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027378; cv=none; b=O1E1dt41GJzX3RFa2TIzNO3UFUa527rkM/HjCyYAfgUgFo/Zb0a1WQXl8xKqlQarcCyWVeOVJLDUng3G20xnj4OzbJhSAoCET7QSXZXNWFqJbW15hMYySI/FTphO83H5jR+Uv+MQEX50pLva+KQ2+Hw3W0MkvxcVMoUqFPVO9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027378; c=relaxed/simple;
	bh=J6qvBnUnGRiCjvCO3qjwKnrny5t6sSycWD3gPp2ZMVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYegv+a11gw+XODyDYWHKHDL0HQM+0Sd7U2wCAugzlWMYRug+g/qrWKg0yEPVpPoKHGJRX68tjwTlGjb4YczlCyUt9t7FaLDkWsUKsGlbdhjFMeYICok5TW+OojphBVcGyNWzCi8ZE//CKsV87hMjqoq95JPJqrMR4+mhrltQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=skpCDb1F; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="skpCDb1F"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777027373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gmf5JLyBQRilWmxu/Ad4jSduwr5kfWqh68zcLQ0kQs=;
	b=skpCDb1FaAOVr4mBDpYBEGhYX/Edi8xM8T45kPJxvYawq/JTXP9aqyipHWmbjlB//UYh1b
	mZQFt9/IBgiB7SvtBLeBaqRXZryxVh5CvvqFkhSRWv3MgBHPfYneRQGjtp6/z287GYXvJv
	wgDC6WJKu9IN568nCXRQ9zCQlu/993s=
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
Subject: [PATCH bpf v2 3/3] bpf, xdp: reject offloaded programs on link update
Date: Fri, 24 Apr 2026 18:41:42 +0800
Message-ID: <20260424104201.217604-4-jiayuan.chen@linux.dev>
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

Same class of bug as the tcx/netkit fixes: bpf_xdp_link_update() calls
dev_xdp_install() directly and bypasses dev_xdp_attach(), so the offload
check in dev_xdp_attach() is skipped. A user can create an XDP link in
SKB or native mode with a regular program and then replace it via
BPF_LINK_UPDATE with an offloaded program, whose bpf_func is
bpf_prog_warn_on_exec(), tripping the WARN on the first packet.

Mirror the check from dev_xdp_attach(): reject when the link is not in
HW mode and the new program is offloaded.

Fixes: 026a4c28e1db3 ("bpf, xdp: Implement LINK_UPDATE for BPF XDP link")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 831129f2a69b5..984d44b2a626d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10648,6 +10648,11 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 
 	netdev_lock_ops(xdp_link->dev);
 	mode = dev_xdp_mode(xdp_link->dev, xdp_link->flags);
+	if (mode != XDP_MODE_HW && bpf_prog_is_offloaded(new_prog->aux)) {
+		netdev_unlock_ops(xdp_link->dev);
+		err = -EINVAL;
+		goto out_unlock;
+	}
 	bpf_op = dev_xdp_bpf_op(xdp_link->dev, mode);
 	err = dev_xdp_install(xdp_link->dev, mode, bpf_op, NULL,
 			      xdp_link->flags, new_prog);
-- 
2.43.0

