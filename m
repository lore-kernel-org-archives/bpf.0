Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793885021;
	b=FU4Y0yq8yvZv11BHLSeiyGatLLYNRdclq7l+cut59EXQNNkSkd48Avp4BYv3nLDRWvWE
	 XJVDSE3KpI/zkMC2heAp2I4UqVhVkGT49e5IoB1gXxzWRqhGYzNE7AR2hQ4GCxDw81XaB
	 hyG/03nZt6dL6xUWWJPlVcrw3EDyopr5ermHcIIFWAquTzIIPCP2FBquJo2UJW5zEk7vB
	 fHNHMpv7oITUqq3tRx4LCyDmcvIWKP6+mn34w/F26ifFxBbKH0E9WTiP1MUbyvypGVjah
	 +er7CirCKKqULWof7XA6DWU/MmXJLcmZ78D2R2jYPd3Pfltb16U9AnhmbW6eGmopbOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885021;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2ua7Bl/SxFvqtBTFEESa8UN4vML+ZCDbnn4HUs1QQKc=;
	b=NQHQqA6YYDJDuDG3mkMIhI97rkseZX4HzcWb3elnmeDhihrC6N6rwD/sKS4r8rRiBSN8
	 UEdAGirCxzgUfmgqnv5GORtYFlXhG8wvcmNKyvDKV5Aqm6CUCM7E/8uy2PiR3ta3kVLmD
	 O52RBgRxlRbz8zlcmpeMEbqMwylD0zOIPCv0pn0qaZ6nUhyxyElTT46Ll0fEPGIqQKwoW
	 fahUzVWmsYHm2gIKpDy7T8WIO9O38cmfhh83gknJJtK2Ja7a5zTvelJUynUVgagT++icm
	 qRJWI3fzmA8hdDoENoBICQMtWlssCoo7WyUmqyPaO7C8S/KL1LGzG1dfnZd/Ncki75Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNw5jfof;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0922F606A32F;
	Thu,  5 Nov 2026 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNw5jfof
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793885020;
	b=K8s5VNqSsyqljpKwYaikGDm3WwkSV3NCi7cNAN/Dxv7Z/aY1lk2gifn0EgHlu20zkQz3
	 0g7UJcWeWXR9JDRCHgf9wf7e4B2Bu4y2oDMWS6hLGN4ZRrZE6jKYFsg9hRbLMALeDvm7Z
	 lnKm2odaOVVMEoKReb1zO0vzAlaiHJymceWvqcOzh41xttyHu2mnpV8NgtWCFho9OaBGj
	 7AIWw/8iHfreVlkh1TnjlIq2ExkKJQwQPYlQ8fgLehxovjJH8omLQgTiTchMStOfrpop+
	 WHdildjQ3Psix7ZlHMFoGrVYUiUWEEOlecSFamJoOJtVdfoRWOMZnaQOS5kY9Re39Pg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793885020;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2ua7Bl/SxFvqtBTFEESa8UN4vML+ZCDbnn4HUs1QQKc=;
	b=cVYojnZVzv0nnVZn/KNZomCLXv8JTwt1n5Batlhb0/p22LwONSYNwtiNjrgkob/fZPLy
	 pv27Z/91UYajyNQ+2/X8QmbjfOnmSRiREBLwnzu6y7necI22FAIjGJokHwd1te7veXG+X
	 oMwpqhF7l4ZWVZLRknCcHWUUVAS0O0YRJsOg6h6QJWZyJuWBOcopSxiYxKNO3xm0PoO5T
	 O6XcWooEGbARzNA5is7Jd80MhoVrAedJwPrti7OF811X7zx/hTU7yRZZGhRtqsth+Z5lS
	 NBzhy/3nXgu9ZKi3Dghw64s+/Fh5KeNcd8GBgFXTFDIW/c0Rdy3NyXwWqCktVS/EhkA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 12F651F00919;
	Thu,  5 Nov 2026 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793885020;
	bh=2ua7Bl/SxFvqtBTFEESa8UN4vML+ZCDbnn4HUs1QQKc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=jNw5jfofkzqdUgPFA73++VYVdZ9jAy2xCA1UH6JAHEPoUgto/u67v5zs+S1d80wpN
	 B+vu8dlDa6awjx/J8EtXxHWC9F4n44f57uhh1rrrtdNCXTINV1X1H/f5pcV5nPlp3e
	 aUCngYNh6S6Rpyg+yiOp/yXqBNi1awruNP1sMNgmz6LLuEW1e1VFah5hI2TGIUHs5x
	 P7c2/rs3Bz4z+8uAwWrI9e3b9kZdjIJqyEutRCv0o/Y7DJKDTNfWzXbj7skTLKRFAS
	 8Jj7Kdb2kI6xE7bWLTNGYaFftZ30hbZF31QMWaFObcT4xrX5Q5A34KU6JV6wz4D1Vq
	 /U5JduPW3iqng==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9026547262;
	Thu,  5 Nov 2026 13:23:39 +0000 (UTC)
From: =?utf-8?q?Orkun_Emin_Sar=C4=B1_via_B4_Relay?= <devnull+sariorkunemin.gmail.com@kernel.org>
Date: Thu, 05 Nov 2026 16:23:39 +0300
Subject: [PATCH bpf] bpf: lwt: Don't let bpf_lwt_push_encap() wrap gso_size
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-bpf-lwt-gso-v1-1-cda5e19d321a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywqDMBBFf0Xu2oFE8IG/Ii5MOtEpRSWjbUH8d
 2O7PJd7zgHlKKxoswOR36KyzAlsnsFPwzwyySMxClNU1pqS3Bro9dlo1IXqUBrHjfU+NEjGGjn
 I91frkI7o/6Pu7sl+uzs4zws8SA9ndAAAAA==
X-Change-ID: 20261105-bpf-lwt-gso-7f50be81ccf8
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Orkun_Emin_Sar=C4=B1?= <sariorkunemin@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793885019; l=2284;
 i=sariorkunemin@gmail.com; s=20261103; h=from:subject:message-id;
 bh=OabHy4jnG0JqeGBm2zFBbMq6JrHCZ6mnFb/ssUZq31s=;
 b=K2qToYY0e5rmJnMHod+0n8EB4eoKafi6TKBoscUn3C31d2HEhO1ZE/pBsMB1wPy7F6BOte3nQ
 YYMEJq5s6NiBkjZ4bIH0qOlhvacrby6haOzjeA/5z0oGKjvi3PtL6s6
X-Developer-Key: i=sariorkunemin@gmail.com; a=ed25519;
 pk=MJ3Y3somkGDQVAXOSR189QAqWOcfzYCRkL1cSQgJXnE=
X-Endpoint-Received: by B4 Relay for sariorkunemin@gmail.com/20261103 with
 auth_id=1408
X-Original-From: =?utf-8?q?Orkun_Emin_Sar=C4=B1?= <sariorkunemin@gmail.com>
Reply-To: sariorkunemin@gmail.com
Content-Transfer-Encoding: 8bit

From: Orkun Emin Sarı <sariorkunemin@gmail.com>

When bpf_lwt_push_encap() adds an IP header to a TCP GSO skb in
BPF_LWT_ENCAP_IP mode, handle_gso_type() lowers gso_size by the length
of the header. Nothing checks the result. gso_size has 16 bits, so a
gso_size smaller than the header wraps, and one less than the header
length gives GSO_BY_FRAGS. skb_segment() then takes the segment lengths
from a frag_list that the skb does not have.

This is the problem that commit 12d07c38e1b0 ("bpf: Don't let
bpf_skb_adjust_room() use up the MSS") fixed for bpf_skb_adjust_room().
As there, gso_size comes from the peer if GRO built the skb, or from the
virtio header if it came from a tun device or a packet socket, so it can
be as small as TCP_MIN_GSO_SIZE.

Refuse the encap if less than TCP_MIN_GSO_SIZE would be left, before the
skb is changed. Return -ENOTSUPP, as handle_gso_encap() does for GSO
skbs it cannot handle.

Found with AI-assisted code review (Claude Code).

Fixes: ca78801a81e0 ("bpf: handle GSO in bpf_lwt_push_encap")
Signed-off-by: Orkun Emin Sarı <sariorkunemin@gmail.com>
---
No reproducer was run and the fix is not runtime-tested. Build-tested
with LLVM=1 W=1 and CONFIG_LWTUNNEL_BPF=y. checkpatch prefers
EOPNOTSUPP; ENOTSUPP is kept to match the other errors of this helper.
---
 net/core/lwt_bpf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec6..c151a013a8 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -13,6 +13,7 @@
 #include <net/gre.h>
 #include <net/ip.h>
 #include <net/ip6_route.h>
+#include <net/tcp.h>
 
 struct bpf_lwt_prog {
 	struct bpf_prog *prog;
@@ -632,6 +633,14 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 		return -EINVAL;
 	}
 
+	/*
+	 * The MSS is lowered by len. Leave the least that the stack lets a
+	 * TCP GSO packet have, or gso_size can wrap.
+	 */
+	if (skb_is_gso(skb) &&
+	    skb_shinfo(skb)->gso_size < len + TCP_MIN_GSO_SIZE)
+		return -ENOTSUPP;
+
 	if (ingress)
 		err = skb_cow_head(skb, len + skb->mac_len);
 	else

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261105-bpf-lwt-gso-7f50be81ccf8

Best regards,
--  
Orkun Emin Sarı <sariorkunemin@gmail.com>


