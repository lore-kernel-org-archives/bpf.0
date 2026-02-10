Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3F83128A3;
	Tue, 10 Feb 2026 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744137; cv=none; b=f53y6tGu6hj0UofiFVOu23Cge1v8CKJ0hcaXrkh7EGjRaY8POt3yBGEk8SJojJMAk8L8725g151haK+hvHRDfhYASYeIK5ez0YYZ+jtajHZIylptvlCe3p/fv3k8tNPg+WjseEu6dPH8G1j08YEI1CnNNzUlvUDGG5IIwh1OifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744137; c=relaxed/simple;
	bh=yBBOEuRACrTrU3mNxgRQgQe/fJ3wQzfx+UORh+ruz5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hgKW/vUMLXGnvrLx55CskmjBVOXVhASEYAjhPkV/Uslsy0lHP8f4RmXW1NuOyJb18doaBPZZhMyEIvqRr1sVrs8FltxE6sQWJxS4Bbxc07MZX42AtFNrvXJEfZ3wbP100Rua7zob/SkqwXXL5stBoAa8Q+y4GGQdx5iE9NE63Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrzHLwud; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrzHLwud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D85C116C6;
	Tue, 10 Feb 2026 17:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770744135;
	bh=yBBOEuRACrTrU3mNxgRQgQe/fJ3wQzfx+UORh+ruz5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XrzHLwudb2DoS4C0sUx7B1zOK7yZVOGy4Q0fDvuOPuKQUamX08/FnoVPX0+5zt2rt
	 w2q+LDjKAmVqoiVomGvk5ILg1gJI0lB+AelHBiD/Zrp9zGx8w1FJdLxNYffey/bKTx
	 31LCzPfqhIn+fvUubkD4s0jUIHJwzvcCRTa4tGYilSrQUiuzqoQ3vJtrXohL2oRlMl
	 dQmxuPMFNny6xKOojrYsmh90yG3LbQsN7ORNbVERpVjUjZ8VRuAxfFo0KXuuvcygwU
	 LpAVjFkc0sTHxL2lAh1YJ7ABRPjVA2nvIaJmzMzqrz3CHkbDUhDlWbl8MaxtmuII8U
	 rpUlfDnoCuZ5g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 10 Feb 2026 18:21:50 +0100
Subject: [PATCH bpf-next 4/5] selftests/bpf: Add selftest support for
 bpf_xdp_metadata_rx_checksum
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-bpf-xdp-meta-rxcksum-v1-4-e5d55caa0541@kernel.org>
References: <20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org>
In-Reply-To: <20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org>
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
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce support to xdp_metadata selftest for bpf_xdp_metadata_rx_checksum
kfunc.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 7 +++++++
 tools/testing/selftests/bpf/progs/xdp_metadata.c      | 1 +
 tools/testing/selftests/bpf/xdp_metadata.h            | 9 +++++++++
 3 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 19f92affc2daa23fdd869554e7a0475b86350a4f..707c98e664745763b01b638a537a797211ded4e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -258,6 +258,7 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
 
 static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 {
+	__u8 ip_summed = sent_from_af_xdp ? XDP_CHECKSUM_NONE : XDP_CHECKSUM_PARTIAL;
 	const struct xdp_desc *rx_desc;
 	struct pollfd fds = {};
 	struct xdp_meta *meta;
@@ -310,6 +311,12 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
 		return -1;
 
+	if (!ASSERT_EQ(meta->ip_summed, ip_summed, "rx_ip_summed"))
+		return -1;
+
+	if (!ASSERT_EQ(meta->cksum_meta, 0, "rx_cksum_meta"))
+		return -1;
+
 	if (!sent_from_af_xdp) {
 		if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
 			return -1;
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index 09bb8a038d528cf26c5b314cc927915ac2796bf0..ef6a5584a1876a3c47440f21dca927ec783469dc 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -98,6 +98,7 @@ int rx(struct xdp_md *ctx)
 	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
 	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_proto,
 				     &meta->rx_vlan_tci);
+	bpf_xdp_metadata_rx_checksum(ctx, &meta->ip_summed, &meta->cksum_meta);
 
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 87318ad1117a1d677af121f11778178532e2a562..a16f71488a34e6df23fec6dd7dde7b7989774618 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -30,6 +30,11 @@ enum xdp_meta_field {
 	XDP_META_FIELD_VLAN_TAG	= BIT(2),
 };
 
+#define XDP_CHECKSUM_NONE		0
+#define XDP_CHECKSUM_UNNECESSARY	1
+#define XDP_CHECKSUM_COMPLETE		2
+#define XDP_CHECKSUM_PARTIAL		3
+
 struct xdp_meta {
 	union {
 		__u64 rx_timestamp;
@@ -48,5 +53,9 @@ struct xdp_meta {
 		};
 		__s32 rx_vlan_tag_err;
 	};
+	struct {
+		__u8 ip_summed;
+		__u32 cksum_meta;
+	};
 	enum xdp_meta_field hint_valid;
 };

-- 
2.53.0

