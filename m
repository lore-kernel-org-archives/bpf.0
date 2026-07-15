Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A223C2794;
	Wed, 15 Jul 2026 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151675; cv=none; b=KlPkuj953MtPfi0/Xpwct2CJcCdSlLlNVhlRP5ashR4MyyfnsNWKKi+4lyZ7/Fkx2HdKug8ETA9/O0Cn2vnKdDFVlnws95i8IfYvVOj0LDj7+Vb2n0CEHGaqBwupV6PMUofQ2K9KqmKGgMpqwXioMww71VYHB5CcL6IlkYqVal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151675; c=relaxed/simple;
	bh=XipKY9KI2EIUeUg7k8e/1eUYTXFOvRS/4aJ1X3s9Qhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bTowZOMujHuE+rLBpBLQVbibxtDxpYy+eoNKMMfHsra5kw9RoN5ORqxtcoN66i1MZhNypW8KTypiE2sl2fhhZKmwv1hco8iNHGZSJB0j5jgV/Ckojgs5TTkguRHGNblgfo3h0luQQGWbcwLkJBjjFSTrwE3YHkoeCje9ge7TM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4Y0KYpG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4Y0KYpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567711F00A3A;
	Wed, 15 Jul 2026 21:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151674;
	bh=wcL5Jyyc2LCR42Fchxsyy0ZYCYQvT9Y2EynlDJ3nTmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j4Y0KYpGYqBa+wfiFihFc08yijSPHZzLWZXhaqiuZIK43KVvpza8+tUKXeOgg+uXh
	 5EtB8hwgSg0lvmcXc13OySOH0CW88udpylDUSFf6mbhTtTxfkp0ZTfMiYZeVTXR9rR
	 WZzRbpHawdTyoImSBGi+qaEg5hu1p4OYk8OufUn5VFuQcmtFTnStaXHZocVZ4MfSgi
	 39KE3l+Qta6KS+qI87eEyxVqRyMa4v+CYOsaXTLB7s7Bz1JUbLldYQiTz9CXJK1Eqp
	 IwiIPhgWbpmx35dzc1OCItpVEArjewyYL7YZxqRDnfXAqk00czNAdniy1aro3pwpU8
	 SWDJusgruN2jg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Jul 2026 23:39:46 +0200
Subject: [PATCH bpf-next v5 6/8] net: add bpf_skb_rx_checksum kfunc to read
 skb checksum metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-bpf-xdp-meta-rxcksum-v5-6-623d5c0d0ab7@kernel.org>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Vladimir Vdovin <deliran@verdict.gg>, 
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

Add a new BPF kfunc, bpf_skb_rx_checksum(), that allows TC and other
skb-attached BPF programs to read the skb->ip_summed field and
associated checksum metadata. This is needed because the existing
bpf_csum_level() helper only distinguishes CHECKSUM_UNNECESSARY
from all other states, making it unsuitable when the caller needs
to differentiate CHECKSUM_NONE from CHECKSUM_COMPLETE (e.g. after
XDP_PASS where the driver may have set either).

The kfunc writes two output values:
  - ip_summed: the raw skb->ip_summed value
               (CHECKSUM_NONE=0, CHECKSUM_UNNECESSARY=1,
                CHECKSUM_COMPLETE=2, CHECKSUM_PARTIAL=3)
  - csum_meta: CHECKSUM_COMPLETE -> hardware checksum (skb->csum)
               CHECKSUM_UNNECESSARY -> checksum level (skb->csum_level)
               otherwise -> 0

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/core/filter.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index b446aa8be5c3..71d58ea53512 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12546,6 +12546,36 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 	return 0;
 }
 
+/**
+ * bpf_skb_rx_checksum() - Read skb RX checksum info.
+ * @skb_: socket buffer to read from
+ * @ip_summed: return value for skb->ip_summed
+ * @csum_meta: checksum metadata
+ *
+ * Reads the checksum-related fields from a socket buffer. For
+ * %CHECKSUM_COMPLETE, csum_meta reports the hardware checksum value.
+ * For %CHECKSUM_UNNECESSARY, csum_meta reports the checksum level.
+ * For %CHECKSUM_NONE, csum_meta is zero.
+ *
+ * Return:
+ * * %0 - success
+ */
+__bpf_kfunc int bpf_skb_rx_checksum(struct __sk_buff *skb_, u32 *ip_summed,
+				    u32 *csum_meta)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_;
+
+	*ip_summed = skb->ip_summed;
+	if (skb->ip_summed == CHECKSUM_COMPLETE)
+		*csum_meta = skb->csum;
+	else if (skb->ip_summed == CHECKSUM_UNNECESSARY)
+		*csum_meta = skb->csum_level;
+	else
+		*csum_meta = 0;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12565,6 +12595,7 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
+BTF_ID_FLAGS(func, bpf_skb_rx_checksum)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)

-- 
2.55.0

