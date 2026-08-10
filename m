Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C5390987
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 05:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338465; cv=none; b=DIXlERbVqzrf4jEE9kzk+EM6K0TO0Hp494WRk/XvHVNzcP4eDBvO/9LO1wUH6iDjJCm1JnhLk9dgF/r5FERIYgiSp13jsGyEEczdFMQzp1mL0Z43bZqx7NvTGKe5NM1+WRssQO6YsKPfljiQpRP1KbUabGEAHO6F9TjNwtF1hy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338465; c=relaxed/simple;
	bh=Ui9SsfFQekv4D3PMLDmBSqH2s+xek2wcNfM1XNe2EMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mshwhAial6gnkYXxgkJfzvh8CC2BNc11UFMkv2C/b2MbILPkhHBNdjYMobV1cvrMmGaRFwi2qjuaOMIaucR/vEjbnGJcw+oc8li/75m5xMDy9NfZXgQIoGaqCbDSh/ygAjH8w0iaol4gAbQ+9NlYeesT7F9/iKTm0Ion0BChibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rt0WLn1B; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rt0WLn1B"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786338461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBMzrGZaWqigdG4JNXgvhCqZpYKHGFrqI+fmWZv1jqE=;
	b=Rt0WLn1BowPIcziiKjx0+jz9ngij1c0CGtQt14Yqkc1hTTV5yuT26O6/ug5s54HLrKR0FR
	rlkbLCZsfR3KJFklRRPLP6ZfD9wyjx0+6S0ylNc58WZN65Iy3q80LeAs7BP0SxwVPvgaR4
	z/69m2XQLnyvLH2gTrGqDHtNar8DCjg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/3] bpf, xdp: move offload check into dev_xdp_install()
Date: Mon, 10 Aug 2026 13:06:00 +0800
Message-ID: <20260810050621.82035-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260810050621.82035-1-jiayuan.chen@linux.dev>
References: <20260810050621.82035-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bpf_xdp_link_update() calls dev_xdp_install() directly and skips
dev_xdp_attach(), so the checks in dev_xdp_attach() do not run. A user can
make an XDP link with a normal program and then swap in an offloaded or
device-bound program with BPF_LINK_UPDATE, which puts it on the software
path.

Move the three program checks (offloaded, bound to another device, and
device-bound in generic mode) from dev_xdp_attach() into
dev_xdp_install(), so both the attach path and the link update path are
covered.

Fixes: 026a4c28e1db3 ("bpf, xdp: Implement LINK_UPDATE for BPF XDP link")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/dev.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index af260ff5462a..3281f226c1e5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10329,6 +10329,21 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 
 	netdev_assert_locked_ops_compat(dev);
 
+	if (prog) {
+		if (mode != XDP_MODE_HW && bpf_prog_is_offloaded(prog->aux)) {
+			NL_SET_ERR_MSG(extack, "Using offloaded program without HW_MODE flag is not supported");
+			return -EINVAL;
+		}
+		if (bpf_prog_is_dev_bound(prog->aux) && !bpf_offload_dev_match(prog, dev)) {
+			NL_SET_ERR_MSG(extack, "Program bound to different device");
+			return -EINVAL;
+		}
+		if (bpf_prog_is_dev_bound(prog->aux) && mode == XDP_MODE_SKB) {
+			NL_SET_ERR_MSG(extack, "Can't attach device-bound programs in generic mode");
+			return -EINVAL;
+		}
+	}
+
 	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    prog && !prog->aux->xdp_has_frags) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
@@ -10480,18 +10495,6 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 			NL_SET_ERR_MSG(extack, "Native and generic XDP can't be active at the same time");
 			return -EEXIST;
 		}
-		if (!offload && bpf_prog_is_offloaded(new_prog->aux)) {
-			NL_SET_ERR_MSG(extack, "Using offloaded program without HW_MODE flag is not supported");
-			return -EINVAL;
-		}
-		if (bpf_prog_is_dev_bound(new_prog->aux) && !bpf_offload_dev_match(new_prog, dev)) {
-			NL_SET_ERR_MSG(extack, "Program bound to different device");
-			return -EINVAL;
-		}
-		if (bpf_prog_is_dev_bound(new_prog->aux) && mode == XDP_MODE_SKB) {
-			NL_SET_ERR_MSG(extack, "Can't attach device-bound programs in generic mode");
-			return -EINVAL;
-		}
 		if (new_prog->expected_attach_type == BPF_XDP_DEVMAP) {
 			NL_SET_ERR_MSG(extack, "BPF_XDP_DEVMAP programs can not be attached to a device");
 			return -EINVAL;
-- 
2.43.0

