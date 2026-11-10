Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283071;
	b=o41Mk76kCwmH2b3PzvTh9VsM2mrTRec27MZ5rshl5kj35WSp5mtyPInIAtLvNShJyDf7
	 eE/ZfV4pbhgX8izqS8SgD866ILaQ1P3NAgPgmbSjT/ooGYbj3n70bh1k7GOxdfymh+5Qb
	 e8adQgziPzliGoPLVlcgYWy/zp4Fev79CNz1e45Z98iJFlhlKHQaf0OMumRUJpL8GcrUQ
	 ty79GUpgGP7ZlcqgVB+7KW2l+SVgWuS01DdE+TNsn61874d4W7LBuZ04T09Eac9F7aHOA
	 Ti4L7RR/vEiEgZsB2z8GGGZkySyRQTLbtKjWuAp2qSoWzPeZfoPuSUWUlf10dXzXrVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1Z04FeiSvWnBqM5P+I5Ei7EPBYnip49IgApkYzkotUE=;
	b=zlWAmuVE4RwE7CZRx9/n+IU0wK+FdpXfWTspBE6WE5vRlFwiCTmwp4zDDtxngdsU8cOB
	 JAVYXnTFvA+wrTqejlq/+x0suvZJdhWi8KkBP1OOK8KzEj6bK+GnZn1AF8ulH2wZSaY9I
	 7Par78ESLVHo7b1XYD/mBaCp0r0wOuDBxsbMH/+5OKXEpCqxK6egXf87lMBUqsnKgpMGj
	 PL1tyZbXWao/gstGjNOs36W3OxKt6PrGz8d2yImvfShvLYvixJilFj+subxBqD3PiDFL5
	 EW7FPYKEjlN4mXASEnUoPU5DpSsmv1I1JhYn10fvkvv5+Rw1OSyeoMCQJGE5zAuO6kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=TjGg4UuN;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E460A2627
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 03:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 890E460A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=TjGg4UuN
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b596569640so2509973a12.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 19:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794283069; x=1794887869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Z04FeiSvWnBqM5P+I5Ei7EPBYnip49IgApkYzkotUE=;
        b=TjGg4UuN1PoWFxb9BYHtVBeKMjchfFe7J7EBZ98+RrzresCmE5kSdnNaSH4ovP3d6Z
         a1LAy0llro9pK7SNVR9TiWk/qH6zvUwXCMropZfa7p5F8pOVj3K9MTYG8pSm5jhy4e7O
         S1cBs7OqAHpeyhC4nELIclUYRYgbTx9fy9tZSz37eyXYeXgGyurNUrbJtCQVQDaihfZo
         +BT2wVcmYJhdeLICAtIA9ZJzyXnenwPwE+/vFATFmA34qQn5g5U3xIiOBddGMwaYOoMW
         gZkSf8NMW1UX32A9YLwnts4Uz9ATFA4V/yUDf/fCN5huik2raOyHvIyAmRMaYlP91pWi
         X98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283069; x=1794887869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Z04FeiSvWnBqM5P+I5Ei7EPBYnip49IgApkYzkotUE=;
        b=XgTm2s/SvevxZ8CFXIukcZm0fE9gNWwu+GzpWl7T1hKNnF3PCawGA+fqkYIcLGGuNp
         fyrRCTEwdpzIyhSxlXDxT3Sz+zoJ6JqvjG/IWIow6KUdQDQNtL1eESYDRlPoesMixpUO
         NwDZS9r2NhVA/gjEy6JOAhh0QyJ0dPXqVDK/Wheb38dvIT+iF6DNXLRPR8wyZ47zX8E2
         W8Gsw8yCdHfO9JyQe6qs5wOSupyZkgOcApKrXGFWaedGROXeEGpQJT+F/p0pR3KP9NUC
         s4hB0BRokLFmQZncP1tdsgI597UHtr9EZ6EzwJEkXFQtu0kyv3cNfPVAsGyRL1c3RTA/
         KO4w==
X-Gm-Message-State: APuU4Z/1a6t6Y8VijluEwDzOP3r5pMaoJstwh2VEvmmKdeuciNO6mwv0
	MC3FpAJF0X2b4ViZlZfjj23pzz61M7CVzn5QbLGaAWzMP3u6iLThS++5P6l0KWxupFB9iQYNgeA
	M2yfe+Js=
X-Gm-Gg: AYBFou0+7zrB629xC8np/3xKo5AZVHLuL103yBvRMJBK8+N+YaWHPxOKY97yC2qRKDU
	ZrPSZ6GQ8RT57WDX87wbygr0OufwKaceRDbaUhuABVD7UC5WlaXkep1p68v+6iZ1SgWjICgeBGO
	d+8I6RduYK9yej0BbreLGuhBMJgAiFIG87UaFa51o2MKDpovfp3QQFhOV3e0Noved8HGtwtE21f
	j9004Zey4VLCg9h4HLAVXqXj4J+NqqEFFQo7louawyp6HitwmmUXZ0IW1cG2DwM2+U+x09lmaxU
	SipId8j10t8ajBWTXgAkj0/5veklkWxetlDKdKShqDjHbSJ8BF8yqOdPVDB6ggNg2IxvEQAzoxV
	HaxWTU1LpIbHZHjAd62KmSwaqV0R/sFlDrUfLDq4jnLdMVc+QBzo39b1KS7VLy1msBvKmpCco7p
	UFhiZ52+JLpIeN42J3DK8EJzc3R8F40WbsaeFDVgjXw+V8pO4JkkRecZKcV8JyL1+CiVRQBha9I
	hTtIGTpw2vM7WJ4QC23L5U6gJ46/hFFPgHm+qFrNxJbn/Dzbr6eQDj+vc9r1m1XbSgoUIIepCNL
	EEBgNo80bcpnjITvku4d5b3BeXVq7FtGq8goBX0W12jp3BrBt+XQOrFuKP0hQDk=
X-Received: by 2002:a05:6402:460c:b0:6b4:7b32:eb48 with SMTP id 4fb4d7f45d1cf-6b7571d68cfmr857409a12.7.1794283068930;
        Mon, 09 Nov 2026 19:57:48 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:57:47 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	llvm@lists.linux.dev,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH bpf-next 08/15] selftests/bpf: Test RX metadata on skbs built from xdp_frames
Date: Tue, 10 Nov 2026 03:57:06 +0000
Message-ID: <dac7aac577495252a0c240629c708f2268417f9e.1794281983.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
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

Add the xdp_skb_ext_to_skb test. An XDP program stores entries and
passes the packet to the stack. A tc program on the receiving veth
device then reads the skb fields. Three paths pass the packet to the
stack: XDP_PASS in BPF_PROG_RUN with BPF_F_TEST_XDP_LIVE_FRAMES,
XDP_REDIRECT into a cpumap, and XDP_REDIRECT into a veth device. Each
path has ten test cases for the hash, VLAN and checksum entries.

The veth_skb subtest runs the same XDP program on a veth device that
receives an skb. The skb is not built from an xdp_frame, so its fields
do not change. The veth_skb_cpumap subtest redirects that packet into
the cpumap. veth turns it into an xdp_frame, so the cpumap sets the
stored values on the new skb.

GRO is off on both veth devices. Otherwise GRO on cpumap verifies the
UDP checksum of the packet and changes the checksum status.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 .../selftests/bpf/prog_tests/xdp_skb_ext.c    | 319 ++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_skb_ext.c    |  84 +++++
 tools/testing/selftests/bpf/xdp_skb_ext.h     |  38 +++
 3 files changed, 441 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c b/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
index bd36e22e22a6..64c6f0268d60 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
@@ -1,9 +1,139 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <network_helpers.h>
+#include <net/if.h>
+#include <linux/if_packet.h>
+#include "xdp_skb_ext.h"
 #include "test_xdp_skb_ext.skel.h"
 #include "xdp_skb_ext_success.skel.h"
 #include "xdp_skb_ext_failure.skel.h"
+#include "xdp_dummy.skel.h"
+
+#define XDP_RSS_TYPE_L3_IPV4 BIT(0)
+#define XDP_RSS_TYPE_L4 BIT(3)
+#define XDP_RSS_TYPE_L4_IPV4_TCP (BIT(0) | BIT(3) | BIT(4))
+
+#define XDP_CHECKSUM_NONE BIT(0)
+#define XDP_CHECKSUM_UNNECESSARY BIT(1)
+
+#define CHECKSUM_NONE 0
+#define CHECKSUM_UNNECESSARY 1
+
+#define RX_HASH 0x5a3c91e2
+#define RX_VLAN_TCI 1
+
+#define UDP_PAYLOAD_LEN 22
+
+static __u8 pkt_skb_ext[ETH_HLEN + sizeof(struct iphdr) +
+			sizeof(struct udphdr) + UDP_PAYLOAD_LEN];
+
+/* Valid checksums, as in real traffic */
+static void build_pkt(void)
+{
+	struct ethhdr *eth = (void *)pkt_skb_ext;
+	struct iphdr *iph = (void *)(eth + 1);
+	struct udphdr *udph = (void *)(iph + 1);
+
+	eth->h_proto = htons(ETH_P_IP);
+
+	iph->version = 4;
+	iph->ihl = 5;
+	iph->tot_len = htons(sizeof(pkt_skb_ext) - ETH_HLEN);
+	iph->ttl = 64;
+	iph->protocol = IPPROTO_UDP;
+	iph->saddr = htonl(0x0a000001);
+	iph->daddr = htonl(0x0a000002);
+	iph->check = build_ip_csum(iph);
+
+	udph->source = htons(4000);
+	udph->dest = htons(4001);
+	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_LEN);
+	udph->check = build_udp_v4_csum(iph, udph);
+}
+
+/* The case that test_veth_skb() uses */
+enum { CASE_ALL };
+
+static const struct skb_ext_case {
+	const char *name;
+	struct xdp_skb_ext_vals want;
+	bool del_hash;
+} skb_ext_cases[] = {
+	[CASE_ALL] = {
+		.name = "all",
+		.want = {
+			.rx_hash = RX_HASH,
+			.rx_hash_type = XDP_RSS_TYPE_L4_IPV4_TCP,
+			.rx_vlan_proto = __bpf_constant_htons(ETH_P_8021Q),
+			.rx_vlan_tci = RX_VLAN_TCI,
+			.ip_summed = XDP_CHECKSUM_UNNECESSARY,
+			.csum_level = 1,
+			.fields = SKB_EXT_FIELD_HASH | SKB_EXT_FIELD_VLAN |
+				  SKB_EXT_FIELD_CSUM,
+		},
+	},
+	{
+		.name = "none",
+	},
+	{
+		.name = "hash_l4",
+		.want = {
+			.rx_hash = RX_HASH,
+			.rx_hash_type = XDP_RSS_TYPE_L4_IPV4_TCP,
+			.fields = SKB_EXT_FIELD_HASH,
+		},
+	},
+	{
+		.name = "hash_l3",
+		.want = {
+			.rx_hash = RX_HASH,
+			.rx_hash_type = XDP_RSS_TYPE_L3_IPV4,
+			.fields = SKB_EXT_FIELD_HASH,
+		},
+	},
+	{
+		.name = "del_hash",
+		.del_hash = true,
+	},
+	{
+		.name = "vlan",
+		.want = {
+			.rx_vlan_proto = __bpf_constant_htons(ETH_P_8021Q),
+			.rx_vlan_tci = RX_VLAN_TCI,
+			.fields = SKB_EXT_FIELD_VLAN,
+		},
+	},
+	{
+		.name = "vlan_ad",
+		.want = {
+			.rx_vlan_proto = __bpf_constant_htons(ETH_P_8021AD),
+			.rx_vlan_tci = RX_VLAN_TCI,
+			.fields = SKB_EXT_FIELD_VLAN,
+		},
+	},
+	{
+		.name = "csum_none",
+		.want = {
+			.ip_summed = XDP_CHECKSUM_NONE,
+			.fields = SKB_EXT_FIELD_CSUM,
+		},
+	},
+	{
+		.name = "csum_level0",
+		.want = {
+			.ip_summed = XDP_CHECKSUM_UNNECESSARY,
+			.fields = SKB_EXT_FIELD_CSUM,
+		},
+	},
+	{
+		.name = "csum_level3",
+		.want = {
+			.ip_summed = XDP_CHECKSUM_UNNECESSARY,
+			.csum_level = 3,
+			.fields = SKB_EXT_FIELD_CSUM,
+		},
+	},
+};
 
 /* The area of a reused page is not valid for the next packet */
 static void test_live_frames(void)
@@ -31,6 +161,124 @@ static void test_live_frames(void)
 	test_xdp_skb_ext__destroy(skel);
 }
 
+static void set_case(struct test_xdp_skb_ext *skel,
+		     const struct skb_ext_case *c)
+{
+	skel->bss->want = c->want;
+	skel->bss->del_hash = c->del_hash;
+	memset(&skel->bss->have, 0, sizeof(skel->bss->have));
+	skel->bss->store_err = 0;
+	skel->bss->pkts_seen_tc = 0;
+}
+
+/* cpumap builds the skb in its kthread */
+static bool wait_pkt(struct test_xdp_skb_ext *skel)
+{
+	int i;
+
+	for (i = 0; i < 100; i++) {
+		if (__atomic_load_n(&skel->bss->pkts_seen_tc, __ATOMIC_ACQUIRE))
+			break;
+		usleep(10000);
+	}
+	return ASSERT_EQ(skel->bss->pkts_seen_tc, 1, "pkts_seen_tc");
+}
+
+static void check_have(struct test_xdp_skb_ext *skel)
+{
+	const struct xdp_skb_ext_vals *want = &skel->bss->want;
+	const struct xdp_skb_ext_have *have = &skel->bss->have;
+	bool unnecessary = (want->fields & SKB_EXT_FIELD_CSUM) &&
+			   want->ip_summed == XDP_CHECKSUM_UNNECESSARY;
+
+	if (!wait_pkt(skel))
+		return;
+	ASSERT_EQ(skel->bss->store_err, 0, "store_err");
+	ASSERT_EQ(have->hash, want->rx_hash, "hash");
+	ASSERT_EQ(have->l4_hash, !!(want->rx_hash_type & XDP_RSS_TYPE_L4),
+		  "l4_hash");
+	ASSERT_EQ(have->vlan_present, !!(want->fields & SKB_EXT_FIELD_VLAN),
+		  "vlan_present");
+	ASSERT_EQ(have->vlan_proto, want->rx_vlan_proto, "vlan_proto");
+	ASSERT_EQ(have->vlan_tci, want->rx_vlan_tci, "vlan_tci");
+	ASSERT_EQ(have->ip_summed,
+		  unnecessary ? CHECKSUM_UNNECESSARY : CHECKSUM_NONE,
+		  "ip_summed");
+	ASSERT_EQ(have->csum_level, unnecessary ? want->csum_level : 0,
+		  "csum_level");
+}
+
+static void test_frames(struct test_xdp_skb_ext *skel, const char *path,
+			enum xdp_skb_ext_deliver deliver, int ifindex)
+{
+	struct xdp_md ctx_in = { .data_end = sizeof(pkt_skb_ext),
+				 .ingress_ifindex = ifindex };
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = pkt_skb_ext,
+		    .data_size_in = sizeof(pkt_skb_ext),
+		    .ctx_in = &ctx_in,
+		    .ctx_size_in = sizeof(ctx_in),
+		    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
+		    .repeat = 1,
+	);
+	int prog_fd = bpf_program__fd(skel->progs.xdp_store);
+	char name[32];
+	int i;
+
+	skel->bss->deliver = deliver;
+	for (i = 0; i < ARRAY_SIZE(skb_ext_cases); i++) {
+		snprintf(name, sizeof(name), "%s_%s", path,
+			 skb_ext_cases[i].name);
+		if (!test__start_subtest(name))
+			continue;
+		set_case(skel, &skb_ext_cases[i]);
+		if (ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &opts),
+			      "test_run"))
+			check_have(skel);
+	}
+}
+
+/* The XDP program on the veth device gets an skb, not an xdp_frame */
+static void test_veth_skb(struct test_xdp_skb_ext *skel, struct bpf_link *link,
+			  int ifindex, enum xdp_skb_ext_deliver deliver)
+{
+	struct sockaddr_ll addr = {
+		.sll_family = PF_PACKET,
+		.sll_ifindex = ifindex,
+		.sll_halen = ETH_ALEN,
+	};
+	const struct xdp_skb_ext_have *have = &skel->bss->have;
+	int sock;
+
+	skel->bss->deliver = deliver;
+	if (!ASSERT_OK(bpf_link__update_program(link, skel->progs.xdp_store),
+		       "update xdp_store"))
+		return;
+
+	sock = socket(AF_PACKET, SOCK_RAW, IPPROTO_RAW);
+	if (!ASSERT_GE(sock, 0, "socket"))
+		return;
+	set_case(skel, &skb_ext_cases[CASE_ALL]);
+	if (!ASSERT_EQ(sendto(sock, pkt_skb_ext, sizeof(pkt_skb_ext), 0,
+			      (struct sockaddr *)&addr, sizeof(addr)),
+		       sizeof(pkt_skb_ext), "sendto") ||
+	    !wait_pkt(skel))
+		goto out;
+	if (deliver == DELIVER_CPUMAP) {
+		check_have(skel);
+		goto out;
+	}
+	ASSERT_EQ(skel->bss->store_err, 0, "store_err");
+	ASSERT_NEQ(have->hash, RX_HASH, "hash");
+	ASSERT_EQ(have->vlan_present, 0, "vlan_present");
+	ASSERT_EQ(have->vlan_proto, 0, "vlan_proto");
+	ASSERT_EQ(have->vlan_tci, 0, "vlan_tci");
+	ASSERT_EQ(have->ip_summed, CHECKSUM_NONE, "ip_summed");
+	ASSERT_EQ(have->csum_level, 0, "csum_level");
+out:
+	close(sock);
+}
+
 void test_xdp_skb_ext(void)
 {
 	RUN_TESTS(xdp_skb_ext_success);
@@ -39,3 +287,74 @@ void test_xdp_skb_ext(void)
 	if (test__start_subtest("live_frames"))
 		test_live_frames();
 }
+
+void test_xdp_skb_ext_to_skb(void)
+{
+	struct bpf_cpumap_val val = { .qsize = 192 };
+	int ifindex_src, ifindex_dst, tc_prog_fd;
+	struct xdp_dummy *skel_dummy = NULL;
+	struct test_xdp_skb_ext *skel = NULL;
+	struct bpf_link *link = NULL;
+	struct netns_obj *ns = NULL;
+	__u32 key = 0;
+
+	build_pkt();
+
+	ns = netns_new("xdp_skb_ext", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	SYS(out, "ip link add veth_src type veth peer name veth_dst");
+	SYS(out, "ip link set dev veth_src up");
+	SYS(out, "ip link set dev veth_dst up");
+	/* GRO would verify the UDP checksum and change ip_summed */
+	SYS(out, "ethtool -K veth_src gro off");
+	SYS(out, "ethtool -K veth_dst gro off");
+
+	ifindex_src = if_nametoindex("veth_src");
+	ifindex_dst = if_nametoindex("veth_dst");
+	if (!ASSERT_NEQ(ifindex_src, 0, "ifindex_src") ||
+	    !ASSERT_NEQ(ifindex_dst, 0, "ifindex_dst"))
+		goto out;
+
+	skel = test_xdp_skb_ext__open();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_skb_ext__open"))
+		goto out;
+	skel->rodata->ifindex_out = ifindex_src;
+	if (!ASSERT_OK(test_xdp_skb_ext__load(skel), "test_xdp_skb_ext__load"))
+		goto out;
+
+	/* pass and cpumap build the skb on veth_src, veth on veth_dst */
+	tc_prog_fd = bpf_program__fd(skel->progs.tc_read_skb);
+	if (tc_prog_attach("veth_src", tc_prog_fd, -1) ||
+	    tc_prog_attach("veth_dst", tc_prog_fd, -1))
+		goto out;
+
+	if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.cpu_map),
+					   &key, &val, 0), "add cpumap entry"))
+		goto out;
+
+	skel_dummy = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(skel_dummy, "xdp_dummy__open_and_load"))
+		goto out;
+
+	/* veth_dst takes xdp_frames only with an XDP program */
+	link = bpf_program__attach_xdp(skel_dummy->progs.xdp_dummy_prog,
+				       ifindex_dst);
+	if (!ASSERT_OK_PTR(link, "attach xdp_dummy"))
+		goto out;
+
+	test_frames(skel, "pass", DELIVER_PASS, ifindex_src);
+	test_frames(skel, "cpumap", DELIVER_CPUMAP, ifindex_src);
+	test_frames(skel, "veth", DELIVER_VETH, ifindex_src);
+	if (test__start_subtest("veth_skb"))
+		test_veth_skb(skel, link, ifindex_src, DELIVER_PASS);
+	if (test__start_subtest("veth_skb_cpumap"))
+		test_veth_skb(skel, link, ifindex_src, DELIVER_CPUMAP);
+
+out:
+	bpf_link__destroy(link);
+	xdp_dummy__destroy(skel_dummy);
+	test_xdp_skb_ext__destroy(skel);
+	netns_free(ns);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c b/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
index e072e051af48..a63206ff993d 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
@@ -3,6 +3,7 @@
 #include "xdp_skb_ext.h"
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_tracing_net.h"
 
 /* Written to the first byte of the packet. A reused page keeps it. */
 #define MARK_STORED 0xaa
@@ -38,4 +39,87 @@ int live_frames(struct xdp_md *ctx)
 	return XDP_DROP;
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_CPUMAP);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_cpumap_val));
+	__uint(max_entries, 1);
+} cpu_map SEC(".maps");
+
+const volatile int ifindex_out;
+enum xdp_skb_ext_deliver deliver;
+struct xdp_skb_ext_vals want;
+bool del_hash;
+struct xdp_skb_ext_have have;
+int pkts_seen_tc;
+
+SEC("xdp")
+int xdp_store(struct xdp_md *ctx)
+{
+	int err;
+
+	if (want.fields & SKB_EXT_FIELD_HASH) {
+		err = bpf_xdp_skb_ext_store_rx_hash(ctx, want.rx_hash,
+						    want.rx_hash_type);
+		if (err)
+			store_err++;
+	}
+	/* A deleted entry must not reach the skb */
+	if (del_hash) {
+		err = bpf_xdp_skb_ext_store_rx_hash(ctx, 1,
+						    XDP_RSS_TYPE_L4_IPV4_TCP);
+		if (!err)
+			err = bpf_xdp_skb_ext_del(ctx, XDP_SKB_EXT_HASH);
+		if (err)
+			store_err++;
+	}
+	if (want.fields & SKB_EXT_FIELD_VLAN) {
+		err = bpf_xdp_skb_ext_store_rx_vlan(ctx, want.rx_vlan_proto,
+						    want.rx_vlan_tci);
+		if (err)
+			store_err++;
+	}
+	/* NONE must replace an earlier status */
+	if ((want.fields & SKB_EXT_FIELD_CSUM) &&
+	    want.ip_summed == XDP_CHECKSUM_NONE) {
+		err = bpf_xdp_skb_ext_store_rx_csum(ctx,
+						    XDP_CHECKSUM_UNNECESSARY,
+						    SKB_MAX_CSUM_LEVEL);
+		if (err)
+			store_err++;
+	}
+	if (want.fields & SKB_EXT_FIELD_CSUM) {
+		err = bpf_xdp_skb_ext_store_rx_csum(ctx, want.ip_summed,
+						    want.csum_level);
+		if (err)
+			store_err++;
+	}
+
+	if (deliver == DELIVER_CPUMAP)
+		return bpf_redirect_map(&cpu_map, 0, 0);
+	if (deliver == DELIVER_VETH)
+		return bpf_redirect(ifindex_out, 0);
+	return XDP_PASS;
+}
+
+SEC("tc")
+int tc_read_skb(struct __sk_buff *skb)
+{
+	struct sk_buff *kskb;
+
+	if (skb->protocol != bpf_htons(ETH_P_IP))
+		return TC_ACT_OK;
+
+	kskb = bpf_cast_to_kern_ctx(skb);
+	have.hash = skb->hash;
+	have.l4_hash = kskb->l4_hash;
+	have.vlan_present = skb->vlan_present;
+	have.vlan_proto = skb->vlan_proto;
+	have.vlan_tci = skb->vlan_tci;
+	have.ip_summed = kskb->ip_summed;
+	have.csum_level = kskb->csum_level;
+	__sync_fetch_and_add(&pkts_seen_tc, 1);
+	return TC_ACT_SHOT;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/xdp_skb_ext.h b/tools/testing/selftests/bpf/xdp_skb_ext.h
index 540ba7c6aa1b..11feee2fa31c 100644
--- a/tools/testing/selftests/bpf/xdp_skb_ext.h
+++ b/tools/testing/selftests/bpf/xdp_skb_ext.h
@@ -13,3 +13,41 @@
 #define MAX_META_LEN (XDP_PACKET_HEADROOM - (int)sizeof(struct xdp_frame))
 
 #define SKB_MAX_CSUM_LEVEL 3
+
+#ifndef BIT
+#define BIT(nr)			(1 << (nr))
+#endif
+
+enum xdp_skb_ext_field {
+	SKB_EXT_FIELD_HASH = BIT(0),
+	SKB_EXT_FIELD_VLAN = BIT(1),
+	SKB_EXT_FIELD_CSUM = BIT(2),
+};
+
+enum xdp_skb_ext_deliver {
+	DELIVER_PASS,
+	DELIVER_CPUMAP,
+	DELIVER_VETH,
+};
+
+/* The entries that the XDP program stores */
+struct xdp_skb_ext_vals {
+	__u32 rx_hash;
+	__u32 rx_hash_type;
+	__be16 rx_vlan_proto;
+	__u16 rx_vlan_tci;
+	__u32 ip_summed;
+	__u8 csum_level;
+	enum xdp_skb_ext_field fields;
+};
+
+/* The skb fields that the tc program reads */
+struct xdp_skb_ext_have {
+	__u32 hash;
+	__u32 l4_hash;
+	__u32 vlan_present;
+	__u32 vlan_proto;
+	__u32 vlan_tci;
+	__u32 ip_summed;
+	__u32 csum_level;
+};
-- 
2.56.0

