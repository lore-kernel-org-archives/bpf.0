Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96230CD95
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786423321; cv=none; b=lsSN2pwHgF0tu72edCNUi0FQtGCJoJdR/mBXh/vX7pUqf/yLEH6dvm2XjYPsaBEOzMQrqpp225aIKtO6GuXgSEs+efN29k3m8wWkGqHNQ0cWaYhA5U9sjUDpzM8AuiJ61zA5a5aSIpbOVZsZZySCkNEfhntB5CqqkimvygSuZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786423321; c=relaxed/simple;
	bh=TYI3Ir+BDCYQue/6lV2LLRIUm7csBMdcONzm9C74S5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKxo02T/d1tTc53Wz5+CSMgCxbDbGoWW7dMvALwWdytQCGZT2wUoNoVqd2LIMpup+ijNmNfdlu12sGe/1pLWaLsvhnkECH2i2YHgRGgSK5OjBHdVdSs7IMCb+E3wWCuJwzdEByW6NiuVXD21milqL7UWf+5/DsXnMrCXabkFLvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9cRgdUU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9cRgdUU"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf452def93so4857355ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 21:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786423319; x=1787028119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X0Vsk37rDICdvEWMiRd9zBNv8uzJbopsS53qS1DBua0=;
        b=M9cRgdUUtFZW/pLfW8vxdjUGiLHvzAqKdTAyvn10/mTb0JRD+KFFpiKwUf/NJ8aSWU
         OU6rVOIwaMYRocvGChZ43DO2nqxr58XEF7DCC5QbZTKjfeXIvPGvwgvbxSrNiAkNldgm
         jGtxfbnZZraEdLIrSH/GHWpmn7H/9Nel0PZ4taV57T1XssX9vwuId4ga5J5s9GuM2fCU
         WwqejTtJ72JnV0OZkJrb4Id99PeEch8YUV23oaPP3zeM9X0u9aezy9jhlkbFP34huFJS
         7CGgt+UJ1m55YUw3BvgqH0y/ThUKypsh5DhmTtupMESmsllxaaji8bb2v+DE4pIiTokF
         a1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786423319; x=1787028119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X0Vsk37rDICdvEWMiRd9zBNv8uzJbopsS53qS1DBua0=;
        b=AlEA5LoF+FnkTXO5PD+jww+if2UrfLEAupv5JMjt+rzzVTgrYRSYEGX6AoyFAu9XDz
         Xv2VY0AmqoZN5AHq+fqWif+PRqP1M9Da0Pz0Gg7U9Es/XxFEPQkJ3moFfF0D3Oq/IFh6
         0BNy2NdScaG+2n415uQPWQaB9pgQQHo5mL3gfjxN8VbIQEq0P7MB8m2NFb/uRIVgyHsp
         OyTQ3Mf75SIBxCko8IU0QqOXvV/d288hUxQSSpgVbyiLrUa0z2yErBAMBex7hYi1X/79
         iW/+yw54YZvPBoFfsCQrtF447G2uCwxgPrRbd7230X9GXqoWvY8jZ46QYj9nsj5kP9+2
         LNHw==
X-Forwarded-Encrypted: i=1; AHgh+RqyeLQ2jdinaXma3DMGggNDSWTbKO3UXlq0INFwIusFjPHk+Q1onucdmaoPvq4JTMEoYfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBvZDbZiFRU6eFXnbsn8lrrbKQkSlp/Jx6Va0DxerIqBJRt50
	U0MBdsoeZrEIiTmfAt15P0IgpxoMtpDn6JZP9QBZiOWt/N7BxTztlXGT
X-Gm-Gg: AR+sD10DlXVhsIFtmS9GhiGo1fpIDOCqQ4Zw9xcqlIUduPxJ2krGFmLPK1MXGGiAWSX
	UR4CY48YGtA6S3yOlBIvsY4nubHhJsRGtBppaRbzhRO/YpE72rcjimZVSuPZ1k+t1z5L6GNPTjg
	xiQtGGozBpMV/dEj8L4VHyRDxQPI6MErf5va1xN3BJLuPTftEVC1Heq+n73ySbR+n6x+JPhysIK
	XZzXamb1VNVGtMdWV/ePtgDQ1UlSbRAqe4Ncnaj5VR0EIS67fC89BspZe91OAZSeswJlxZWiWEb
	90v7F6Ty4VlY6B2psyBusMBKBSDu+kQujH25IgPPplAhaqlM///PWhVn4pqTETQl/0+Kj00HHrq
	qKJJmFz2Q/Q+ZNDrNNwj93a3KBPMe15IZLQZEvjlgK1Otb3qfp+fix42eNQkqYmPRdFQ8PHpYV3
	h05dpHHDw7Y5F4oPiWW1KG8flKKkKS8oF0HLOZU8XP8ZgJWcnvryPwpFU=
X-Received: by 2002:a17:903:1ce:b0:2cf:8aa7:7810 with SMTP id d9443c01a7336-2d318ed4f2fmr1383635ad.2.1786423319153;
        Mon, 10 Aug 2026 21:41:59 -0700 (PDT)
Received: from omen-arch ([147.46.124.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3160ce71csm1253695ad.52.2026.08.10.21.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 21:41:58 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Graf <tgraf@suug.ch>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2] lwt_bpf: restore reserved headroom after xmit program
Date: Tue, 11 Aug 2026 13:41:49 +0900
Message-ID: <20260811044149.118235-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_finish_output2() expands an skb to LL_RESERVED_SPACE(dev) before LWT
xmit. An LWT_XMIT BPF program can then modify the skb head and still
return BPF_OK, so bpf_xmit() rechecks the remaining headroom before the
skb continues to neighbour output.

That recheck uses dst->dev->hard_header_len. This is not enough for the
neighbour cached-header path: neigh_hh_output() copies the cached hardware
header using the aligned hh_cache size, HH_DATA_MOD for short headers or
HH_DATA_ALIGN(hh_len) otherwise.

On Ethernet, hard_header_len is 14 but the cached copy needs 16 bytes. If
an LWT_XMIT BPF program calls bpf_skb_change_head(skb, 1, 0), the skb can
still have 15 bytes of headroom after the program. The existing check
accepts that, after which neigh_hh_output() hits its headroom warning and
drops the skb.

Use LL_RESERVED_SPACE(dst->dev) in the post-BPF headroom check to match
the reservation made before LWT xmit.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
This issue was found by a custom fuzzer developed by
Sechang Lim <rhkrqnwk98@gmail.com>.

Changelog:
v1 -> v2:
- Use LL_RESERVED_SPACE() instead of HH_DATA_ALIGN() to match the
  reservation made before LWT xmit.
  (Daniel Borkmann)
- Add a Reported-by tag.

v1: https://lore.kernel.org/all/20260727103005.897983-1-zirajs7@gmail.com/T/

 net/core/lwt_bpf.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 652952d416f2..da49364ec63d 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -167,10 +167,10 @@ static int bpf_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	return dst->lwtstate->orig_output(net, sk, skb);
 }
 
-static int xmit_check_hhlen(struct sk_buff *skb, int hh_len)
+static int xmit_check_headroom(struct sk_buff *skb, int hroom)
 {
-	if (skb_headroom(skb) < hh_len) {
-		int nhead = HH_DATA_ALIGN(hh_len - skb_headroom(skb));
+	if (skb_headroom(skb) < hroom) {
+		int nhead = hroom - skb_headroom(skb);
 
 		if (pskb_expand_head(skb, nhead, 0, GFP_ATOMIC))
 			return -ENOMEM;
@@ -282,7 +282,7 @@ static int bpf_xmit(struct sk_buff *skb)
 
 	bpf = bpf_lwt_lwtunnel(dst->lwtstate);
 	if (bpf->xmit.prog) {
-		int hh_len = dst->dev->hard_header_len;
+		int hroom = LL_RESERVED_SPACE(dst->dev);
 		__be16 proto = skb->protocol;
 		int ret;
 
@@ -298,9 +298,12 @@ static int bpf_xmit(struct sk_buff *skb)
 				return -EINVAL;
 			}
 			/* If the header was expanded, headroom might be too
-			 * small for L2 header to come, expand as needed.
+			 * small for the L2 header to come, expand as needed.
+			 * neigh_hh_output() copies the cached header in
+			 * HH_DATA_MOD aligned chunks, so match the reservation
+			 * made before LWT xmit.
 			 */
-			ret = xmit_check_hhlen(skb, hh_len);
+			ret = xmit_check_headroom(skb, hroom);
 			if (unlikely(ret))
 				return ret;
 
-- 
2.55.0
