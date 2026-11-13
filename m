Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794600902;
	b=1M5dxFFE/rRcto42nXOhtclCoCXJ/mo26Fyn36sEgxXEpwJKmB49w0sPbshogA2HhHHt
	 /Y+yh1hzotn6PCEHsXoAXlrfBpRWtIqaEDlmqvH+o2B0LlJNrX1fhwnp48YBN/Q6DMbpo
	 Oe/Wb/7m3ViuJ4JRQKUuATfhLJqrRsadZqH2ahv8fHfi14v5l6+UGchp+GJI52GfjOS9G
	 Kh/evnKK3jROnPDOag/78n1PPAjKTxhbk4ZopMNQC3bP+SNkUlbjt33Pgy52LT0eu7hFT
	 TOg6ebgFuGQhLM3cLEW84u4KnubTviTc9T9huBZ3+lQ2GN6VaG/NmgXW7rSUFc2SQGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600902;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AAo9Q3VQrLylyCTPQs8zy2hqWw0i0HrVtcUrV/cI8uQ=;
	b=WRVTjoGkiF5SKpi+4gs/sQ/zFy+gj0z2AdVRGNcs/5Uex/GtVAGojdMf64QZMf9l1k25
	 gZrEC/ohuAnEG9RghlhrbZ2MxzwzKapeK4NBvqH7uUtoBvnPdHU3LeXGKshp9HbxMWmjB
	 /jCpWspIAQQHd4czfiazDMb0+McmT1WkWirylhBMI1BAqrFLGDx0DIx3sf+bYlYRCG+fY
	 Xm/gYbe2nkYVQVcH6DldZglxA9aLSHt6rldS5k2yWIsU0CeGFkVxbIQMtZPfEhp/yLH3R
	 srqADJUWM7MIXHHq2+RyVGtWOdwjRbF/Z1AqxaI0SD8Kqe4FKb86VthONO8BRXPJt9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbTBSfVJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2E606A32E;
	Fri, 13 Nov 2026 20:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbTBSfVJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794600901;
	b=G7d88/hoUQPKQHsPSmfF/iiwHVkwG3HuNhNIhdMzzoKSvxz9i3wkhsJMVpDqpFjlAwGE
	 TM21QIVm+fl3eBwyRSWpIhHeJsE6xqPx4pGnbSkqMQUYaruiV7oPdhw9Kn1MD8TGgX936
	 agH8xfkh95pYwU+ukFO6c/vQ16GtdaELhhI20BD52Lh6Sv7BDH0+UeTvlEHJZERv9DidU
	 lL960vxIEn9VgwMZizwzUNpX6OHymCzqh1yHb8ASF1jZh8/CHHUuECNBHH88m9aBQ2vtU
	 AX6I4CIo3lDaa9AxxsN67iXnDpZPKcoXiDi8gOVRGNoaeHncYAY3ioIi57IxED/Aqaw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794600901;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AAo9Q3VQrLylyCTPQs8zy2hqWw0i0HrVtcUrV/cI8uQ=;
	b=nPIH4ThaHfeXVjsZJsfy6P6VhuFMB3WeEimlxbZyLLXCAkSmsAk934pQBsn1aPDT1jVb
	 dSyQ8En3SiO0ViVZwdCkGLO7ujA61yThAtJ+UQ2cef5VlnjLHS5Rz7ouZovYiOybyNN2/
	 XIdi7dWvW2ngEk5h3ge4fRmg+HUFkoi48IGdVPQJYH/2/yfULy3fqGXuOhFPYJPX+nPjY
	 a8MwjUnrQbXK6fKe423VQA7CtRWPOHpurRffBn2rXfZWvZb6KnBjhNXRvUKSDTXgqBxHt
	 OV8vt1gWml7psAXuJT0Yse5vls1vi1Gm0qgav4t7m10RXfXPcJVlH0W03xi2rKKsZ6g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3A0431F000C4;
	Fri, 13 Nov 2026 20:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600901;
	bh=AAo9Q3VQrLylyCTPQs8zy2hqWw0i0HrVtcUrV/cI8uQ=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=KbTBSfVJMDncH7HQ/yoQaH8rJov1C3+hQf1IZWXpgMvHtewFXsrDJWEbOZuZHzAND
	 UTsGtYrpCKl6xq67NNC30glNT+Ul5DU2i0r9jl1a7GUuhwWyhQEwXaJ/wEB3EK8Cjm
	 2E6PTLm2pQJBJQayOBFZewVuu29cJG2fmYLlbsJGPzgS5oknfW0m/hVjmSE1MBH/g8
	 ygdZtgeDaojidyKHBFM/+fBQ5AUtvGhbBQER+gmoRN1rJzW/joPv4Cvy0U+2Rc6k5P
	 1asAgJYAQ40cR+B4tN5u/QpN5Uq8BQFWpbrz+GJcJ3Me8KsPqqIDnpPWNy3xvmOmxP
	 1wqwzsAVOMGMg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8B36F49AA3;
	Fri, 13 Nov 2026 20:15:00 +0000 (UTC)
From: =?utf-8?q?Dani=C3=ABl_Trujillo_via_B4_Relay?= <devnull+datrujillo.nvidia.com@kernel.org>
Date: Fri, 13 Nov 2026 20:15:43 +0000
Subject: [PATCH bpf] bpf: mask speculative out-of-bounds skb helper loads
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
Message-Id: <20261113-cbpf-ind-nospec-v1-bpf-v1-1-764ac4c14573@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAO5v92oC/yWMSw7CMAwFr1K9NZZwi8rnKohF6zhgFmkUQ4VU9
 e6ksJzRe7PAtZg6Ls2CorO5TakC7xrIY0h3JQuV0e7bnpk7kjFHshQoTZ5VaGbaTNefQzgco5y
 GiHrORaN9fuEr6gC3v/T3+FR5bUms6xcJrs+sfwAAAA==
X-Change-ID: 20261113-cbpf-ind-nospec-v1-bpf-369dd47fc8af
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Dani=C3=ABl_Trujillo?= <datrujillo@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794600943; l=4789;
 i=datrujillo@nvidia.com; s=20261008; h=from:subject:message-id;
 bh=IrkM3A5rzY7Lrf7aX7/eWswOO8MwkLehIVbqhgYc0eI=;
 b=yv1ifv5IFVTISmKtkoz2U0m3t/XpoQQNbWEsj72vF7o4NyVJgZqZGb9+Jk1Dx1T8OPQ5NulY8
 IoTM7o5LAd7DiMUQTNIeNKu5gXHCV6pYBrPOvcO/d26dnI5SmenVi9K
X-Developer-Key: i=datrujillo@nvidia.com; a=ed25519;
 pk=AP24zUwENFy2geglpKJAA8oaT41tkteCL9hTWGd88rs=
X-Endpoint-Received: by B4 Relay for datrujillo@nvidia.com/20261008 with
 auth_id=1128
X-Original-From: =?utf-8?q?Dani=C3=ABl_Trujillo?= <datrujillo@nvidia.com>
Reply-To: datrujillo@nvidia.com
Content-Transfer-Encoding: 8bit

From: Daniël Trujillo <datrujillo@nvidia.com>

The fast paths in bpf_skb_load_helper_{8,16,32}() check whether the
requested bytes fit before loading from data + offset. For indirect loads,
packet data can determine the offset. A mispredicted check can cause a
transient out-of-bounds load, as Jin et al. independently demonstrated
for bpf_skb_load_helper_32() in BeeBox (USENIX Security 2024).

A classic BPF filter can shift the loaded value and use it as another
indirect load’s offset (BPF_LSH, BPF_TAX, then BPF_IND),
creating a data-dependent cache footprint.

Leakage was demonstrated with instrumentation that delays branch
resolution with a CLFLUSH before the mispredicted branch and makes the
leaked location deterministic for reproducible measurement. In that
setup, an unprivileged process that attached a classic BPF socket filter
was able to recover kernel values from userspace using Prime+Probe. A
real-world attacker would likely need to delay branch resolution, which
was not demonstrated end-to-end without the added CLFLUSH.

Mask the load address when the converted offset falls outside the
permitted range. This removed the leakage in the described setup.
Derive the lower bound from the network and MAC header
positions. An out-of-bounds transient offset dereferences NULL instead
of a potential secret.

Masking increased the time for a filter with
64 indirect byte loads by roughly 36% in a direct in-kernel test
(280% with LFENCE). In a loopback UDP test with the same filter, the
overhead was roughly 6% (21% with LFENCE).

Fixes: e0cea7ce988c ("bpf: implement ld_abs/ld_ind in native bpf")
Signed-off-by: Daniël Trujillo <datrujillo@nvidia.com>
---
Requesting fix for stable.
---
 net/core/filter.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 1a60a2a70e2d..c50e94df79b3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -28,6 +28,7 @@
 #include <linux/in.h>
 #include <linux/inet.h>
 #include <linux/netdevice.h>
+#include <linux/nospec.h>
 #include <linux/if_packet.h>
 #include <linux/if_arp.h>
 #include <linux/gfp.h>
@@ -240,6 +241,32 @@ static int bpf_skb_load_helper_convert_offset(const struct sk_buff *skb, int off
 	return INT_MIN;
 }
 
+static __always_inline const void *
+bpf_skb_load_nospec(const struct sk_buff *skb, const void *data,
+		    int headlen, int offset, int len)
+{
+	/* An unset mac_header is maximal and cannot lower the bound. */
+	int header = min(skb->network_header, skb->mac_header);
+	int lower = min(0, header - (int)skb_headroom(skb));
+	unsigned long index, size, mask;
+
+	/* Normalize [lower, headlen) to a zero-based range. */
+	index = (unsigned long)(long)offset - (unsigned long)(long)lower;
+	size = (unsigned long)(long)headlen - (unsigned long)(long)lower;
+
+	OPTIMIZER_HIDE_VAR(index);
+	OPTIMIZER_HIDE_VAR(size);
+
+	/* Check the start and the number of bytes remaining. */
+	mask = array_index_mask_nospec(index, size);
+	/* Each caller passes a constant width, so inlining eliminates this branch. */
+	if (len > 1)
+		mask &= array_index_mask_nospec(len - 1, size - index);
+
+	/* Out-of-bounds transient offsets select NULL as the load address. */
+	return (const void *)(((unsigned long)data + (long)offset) & mask);
+}
+
 BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
@@ -251,7 +278,8 @@ BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void *,
 		return -EFAULT;
 
 	if (headlen - offset >= len)
-		return *(u8 *)(data + offset);
+		return *(const u8 *)bpf_skb_load_nospec(skb, data, headlen,
+							  offset, len);
 	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
 		return tmp;
 	else
@@ -276,7 +304,8 @@ BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, const void *,
 		return -EFAULT;
 
 	if (headlen - offset >= len)
-		return get_unaligned_be16(data + offset);
+		return get_unaligned_be16(bpf_skb_load_nospec(skb, data,
+							 headlen, offset, len));
 	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
 		return be16_to_cpu(tmp);
 	else
@@ -301,7 +330,8 @@ BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, const void *,
 		return -EFAULT;
 
 	if (headlen - offset >= len)
-		return get_unaligned_be32(data + offset);
+		return get_unaligned_be32(bpf_skb_load_nospec(skb, data,
+							 headlen, offset, len));
 	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
 		return be32_to_cpu(tmp);
 	else

---
base-commit: 7f1e33230b7c7a55318765862b255b41e5c97cfb
change-id: 20261113-cbpf-ind-nospec-v1-bpf-369dd47fc8af

Best regards,
--  
Daniël Trujillo <datrujillo@nvidia.com>


