Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6240F3D3CF0;
	Wed, 15 Jul 2026 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151670; cv=none; b=nv9js/j1xdJZ/xtFWvO5uU/FXC3KOykvmLBZddwWMzaAB0GiE4w7T4XyBitTtRNciY9BnQ5nno63aTmlfziJCa2uqrhkD6fsDd8lbnRZAbPLvVKcb3jHMhzvG2Ssw5esE1rVJoou1Zt46+tLRWFuezNGCbjrPVY1AMtZhxMpj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151670; c=relaxed/simple;
	bh=hZcY9ci1Hpb4Qd5JvT5cOGcqU9FuuMaLWzWJg2yVj2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KkK237qs6w++iVpo9ZQ+a/psMWcS0xWhOjeEvhoD7UKO9MiG4kM9AMejOm2C6bN3BR1WeisNfxi3frY1X/vz6OW2jcWmb8sf0V9ZpN8DAghIY/gHS3jobO9w0fo4iSsg2O0yfFECzH0NsHerRQ4XEH4tdX59YaWmbm5WCvR2/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUOCxkHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUOCxkHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB3C1F00ACA;
	Wed, 15 Jul 2026 21:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151669;
	bh=JQ8p5mYtWA3i+I5cBoLmSPNPAhSP0HZCk2Kpee4AGAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jUOCxkHifOGgYxxJeVSPBvGbTVZqau9fN1EiYF+vVXwcnR7Mlaz6PXl4GdBJNBNyB
	 GAkdQ/Pm9hyhdVDRpYNgrW4gsultzAXDb6NM5LA8+a0O2biGC8Fq/Uj7LXwCCKWJsN
	 v0n6NpEMMwVWmPz1Uvz2DgpmltBoi+ZVQ4gfOsIDYWfaS0zPsg7IixbKSf/Dyy8hFE
	 1zmTb4GGW8hNXq7n2GhKuvysx2vSNTq8M7Idp865Y/StKT9JJiHZGOtwqkWFBsBTue
	 E9XAbIuKLcsZdRUIXRNbciahDtXzpFpHd4uFKU0WbnTgwk8y/SF/LmECTwZXWooqX8
	 HWChQtsKPddwQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Jul 2026 23:39:44 +0200
Subject: [PATCH bpf-next v5 4/8] selftests/bpf: add selftest support for
 bpf_xdp_metadata_rx_checksum
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-bpf-xdp-meta-rxcksum-v5-4-623d5c0d0ab7@kernel.org>
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
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

Introduce dedicated selftest for bpf_xdp_metadata_rx_checksum kfunc to
bpf selftest framework.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 9 +++++++++
 tools/testing/selftests/bpf/progs/xdp_metadata.c      | 2 ++
 tools/testing/selftests/bpf/xdp_metadata.h            | 9 +++++++++
 3 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 5c31054ad4a4..91de61c822f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -310,6 +310,15 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
 		return -1;
 
+	if (!ASSERT_EQ(meta->ip_summed, XDP_CHECKSUM_NONE, "rx_ip_summed"))
+		return -1;
+
+	if (!ASSERT_EQ(meta->cksum, 0, "rx_cksum"))
+		return -1;
+
+	if (!ASSERT_EQ(meta->cksum_level, 0, "rx_cksum_level"))
+		return -1;
+
 	if (!sent_from_af_xdp) {
 		if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
 			return -1;
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index 09bb8a038d52..af1e19d48d67 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -98,6 +98,8 @@ int rx(struct xdp_md *ctx)
 	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
 	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_proto,
 				     &meta->rx_vlan_tci);
+	bpf_xdp_metadata_rx_checksum(ctx, &meta->ip_summed, &meta->cksum,
+				     &meta->cksum_level);
 
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 87318ad1117a..bca09b94af26 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -30,6 +30,10 @@ enum xdp_meta_field {
 	XDP_META_FIELD_VLAN_TAG	= BIT(2),
 };
 
+#define XDP_CHECKSUM_NONE		BIT(0)
+#define XDP_CHECKSUM_UNNECESSARY	BIT(1)
+#define XDP_CHECKSUM_COMPLETE		BIT(2)
+
 struct xdp_meta {
 	union {
 		__u64 rx_timestamp;
@@ -48,5 +52,10 @@ struct xdp_meta {
 		};
 		__s32 rx_vlan_tag_err;
 	};
+	struct {
+		__u32 ip_summed;
+		__u32 cksum;
+		__u8 cksum_level;
+	};
 	enum xdp_meta_field hint_valid;
 };

-- 
2.55.0

