Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F013B6371
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719256; cv=none; b=nF6T7GlpPLO+VKvOFH+1IioBoHMBgHUkJvRgXhTSvW/AumVT9IokHjh5yew7+E0JUp2q0CLo7GcYFyi0/Fm4SA5POxw3JpZHsqigvRefmaRSBhMGGUryQ/Aag9oDwbLVapMNzN/8pXXbhtFQvVs5pzMbSaNnO8hBb76gzxkMloM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719256; c=relaxed/simple;
	bh=/8CfMHUVqDlKZaPpnLfMOHrnGJaH/A8Ty2++7iM9Sdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5wKxIXlF3xAmLPe37aXO76SM4v2xRzDSH8AOM0sKskFD4RNfrUzNu5AcgpTqRH2UUT9xtA2hzrRaKX7oIqzKSWmcfUJbeMRlp+PHrM6mH8hSS2JwUU1KQHxHTeb2gasudS0oFh+BpHWaE5/6onrDDnJWoRjW8vkPI7M+0fyzz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g1/cZyue; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g1/cZyue"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779719253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVqBrLP1RUXJkR4SA5s0ok0HBQDMsTLfVjo0fhZP/dQ=;
	b=g1/cZyuezPzqsbssCu/xgITL1YfTKnjABsxhKcbQ3WnWaJIW6A33I0aHCxduuFMEesJoR+
	VUrTlc7Ehtqa8ZavvcL6mYZOCcoATqX9XoWdRMLIT/Lvl0am0csEJtevaDtS5ihG2CnCZo
	5qVyB+FetsuDkXg4QqN9eeChf+W1mQg=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Ido Schimmel <idosch@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Peter Oskolkov <posk@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: [PATCH bpf 1/2] bpf: Update transport_header when encapsulating UDP tunnel in lwt
Date: Mon, 25 May 2026 22:26:49 +0800
Message-ID: <20260525142650.2569-2-leon.hwang@linux.dev>
In-Reply-To: <20260525142650.2569-1-leon.hwang@linux.dev>
References: <20260525142650.2569-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, bpf_lwt_push_ip_encap() does not update skb->transport_header.
When a driver, e.g. ice, reuses the stale skb->transport_header to
offload checksum computation to NIC hardware, VxLAN packets encapsulated
by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum.

Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
encapsulated packet uses UDP, so checksum offload works correctly.

Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Cc: Leon Hwang <leon.huangfu@shopee.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 net/core/lwt_bpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index f71ef82a5f3d..cbb2803367c6 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -637,6 +637,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 	if (ingress)
 		skb_postpush_rcsum(skb, iph, len);
 	skb_reset_network_header(skb);
+	if (ipv4 && iph->protocol == IPPROTO_UDP /* UDP tunnel */)
+		skb_set_transport_header(skb, skb_network_offset(skb) + iph->ihl * 4);
+	else if (!ipv4 && ((struct ipv6hdr *)hdr)->nexthdr == NEXTHDR_UDP /* UDP tunnel */)
+		skb_set_transport_header(skb, skb_network_offset(skb) + sizeof(struct ipv6hdr));
 	memcpy(skb_network_header(skb), hdr, len);
 	bpf_compute_data_pointers(skb);
 	skb_clear_hash(skb);
-- 
2.54.0

