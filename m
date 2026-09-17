Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B07385D82
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662887; cv=none; b=ZzZwq34lvMV1i9lf/BI0heNbCRCR9BQBMYr/xQxHUGcsMo6s3K2wiuhZ8uUWutAkEGL6ygNBjS+K4USfTLCQYd3M4TSY+NVCaX2HVzLltsNYobSK1S2p8LATzcQU/PiOLV2igYFz3x/ISFy9SwiusEJO2FtPoH7YqkQqzdNAiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662887; c=relaxed/simple;
	bh=7o9JwuldElGWG7RmBJcaqaaX2Cx85WG6qiS9aJ1Bxv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vmzqq9C7bd8jcsjKuSv1gRzs6gtvA4Xd81CtapoHhQ5/v4ms2vmMy7imO4hOkUmTwjAtUcOlK8xHcgoQBHi+jNrQeo7oQxbilU2J1avpkMb9VR6A+YZpv456PIPstYz9ixlUrdai3qzOGjKcfBLONmMENGMCW3dvUEULdMBozVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=NiPNIRpm; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="NiPNIRpm"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b35611so733221b3a.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789662885; x=1790267685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=auNP+ct9RIw9lrR/ZAwJ+MIFmWOSTqiGaQWeBWzAEDs=;
        b=NiPNIRpmy3fr4EnuReKP56AVFuh1edOGtGFYDgK7WXJ3VGM56aFoe31SAhvqgmI+tw
         3BMH3Hf28leJ31rTH+JAwTkg6H8Ag9pz4zlv1BAG73RKHfmWfbd/tIxWJ2H4SRJ0ncEX
         7bv+pXIa3t9XVI9BM2VWaVZYW+ZKLXtI3naYGmzj9hHm6Jj/jDfcioj+lkLJuf4HAzag
         sNAuRg5pua4ax48EYC5mPwDePRezv5Oat9SodfhUaL8hYNd45Pa9XrKVAXUdV/xgV8c6
         qxKd2t1vN2CvKSjk8LvMMgaOX9MvE0fXHiCw/P/lQmaL+RlGrYeuxS3LeVoffw8K3XGr
         XxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789662885; x=1790267685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=auNP+ct9RIw9lrR/ZAwJ+MIFmWOSTqiGaQWeBWzAEDs=;
        b=grnx6bkj/BY/KhuUZwMALUfiTr+QFPLR+U+ywrWN3zK+oyVL/J5QNGwM0JbhvXzEHl
         9m/AKrFlfZQU9e+XSFhQ2Fy+mHghZigBfanrd3xcp32U91+HrlUVhDMcvXgbwxwz1z0R
         A+P5Ko4Q+qi7ax0lKIXoX8oZI7prVrrtLL4rMcC3tzJVtQKdvJYinDKQIaMkWg6ZRW1o
         XshSOQH2JgemPzg2cJSiRfiDT7boFGXSGpx1iGISCzVGRP11ukujgsbOOGdkE6G0GRZf
         ymho+yfsnbYF/nDPFuSO++XfXA8qhuAWM7lgpW0uEbH3qCTzagsygKRJkLAfD5/y9tSg
         jQQA==
X-Gm-Message-State: AFuF++nGIIAQKTXpg1SftUkvuVC/yc1FoYWWaaiD2aZL4moBSBD+rE3n
	MEfoll5RmI97eehWJnzV5oCU7PEoBbMeWdUU/fxaoqPanL8BTEDMAbejyIoMTaB6XVbIoqBMsB1
	SIhIm1A==
X-Gm-Gg: AYBFou3QKFTaIrxgbU8sxljkwN0FT/0XWWGkJurX1aCfU58DVhwLJrRW9bteMpXxK5i
	DZ5vMp+hFloAHAHhAsvUGNlS1MYlaIRcFn1zP2yLPOYKCej7LzixUi8lcHQY9QCdxTYJLnsHcWr
	AW26/Dq/5WnoHERQylFLLbQxH0j4mGPAmwuvjKP2kt5gjoWjSwyG81rXMRWXY6zju/Yo19J4t5G
	aDsyvlt8GBCMXU5mYpLrS8NTiLRsLTgqqHxlZoAuaXUTlm/+0wdonoPHQ+t9EhiIVJsgiB4ydPp
	uyEuGV0SDPuvUGnOiDvvri1uEahVyujTVzZr3dKP4os5mzVQPiq+j3gOERncOg62PDNOz74/RUp
	R1ANyqh5DavbsC+x0uUSpkVcy/ga/NKHzlr7O5/lM8OMnyHfP9K3FQQQG1NapqPKFyRhq+GYM+i
	2nwp2WGmtrFrVI5ijKz6CbE0xPDHeKya6kEdqW7zEjlzqWGK0L9M00GXmrXvxwyugEWOSXmZyTv
	f5ILU2Lmo8haDE/QTkB
X-Received: by 2002:a05:6a00:6caa:b0:856:30dd:91ba with SMTP id d2e1a72fcca58-87236ae8236mr15335218b3a.2.1789662884910;
        Thu, 17 Sep 2026 09:34:44 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-872024e6a39sm3240251b3a.56.2026.09.17.09.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:34:44 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	m.xhonneux@gmail.com,
	dlebrun@google.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH 1/1] bpf: fix TOCTOU in IPv6 SRH encapsulation
Date: Fri, 18 Sep 2026 00:33:51 +0800
Message-ID: <20260917163408.252431-1-weir@nebusec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789646866.git.rakukuip@gmail.com>
References: <cover.1789646866.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

BPF helper SRH arguments may reference shared array-map values.
bpf_push_seg6_encap() validates the buffer using the constant
verifier-approved length, but target functions later reread hdrlen
and first_segment without snapshotting the validated bytes.

Another CPU or userspace can update the array-map value concurrently
between validation and use, changing hdrlen to request up to 2048 bytes
from a much smaller map allocation or changing the segment index.
The resulting memcpy and segment access can read beyond the map bounds,
potentially leaking adjacent kernel memory into transmitted packets or
triggering a kernel panic.

Fix this by duplicating the user-supplied SRH into a private buffer
with kmemdup() before validation and encapsulation, ensuring that
concurrent map updates cannot alter the header while in use, and
freeing the buffer on all return paths.

Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/core/filter.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 11bb0d236822..3587f4ba0511 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6706,16 +6706,22 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
 #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
 static int bpf_push_seg6_encap(struct sk_buff *skb, u32 type, void *hdr, u32 len)
 {
-	int err;
-	struct ipv6_sr_hdr *srh = (struct ipv6_sr_hdr *)hdr;
+	struct ipv6_sr_hdr *srh;
+	int err = -EINVAL;
+
+	srh = kmemdup(hdr, len, GFP_ATOMIC);
+	if (!srh)
+		return -ENOMEM;
 
 	if (!seg6_validate_srh(srh, len, false))
-		return -EINVAL;
+		goto out;
 
 	switch (type) {
 	case BPF_LWT_ENCAP_SEG6_INLINE:
-		if (skb->protocol != htons(ETH_P_IPV6))
-			return -EBADMSG;
+		if (skb->protocol != htons(ETH_P_IPV6)) {
+			err = -EBADMSG;
+			goto out;
+		}
 
 		err = seg6_do_srh_inline(skb, srh);
 		break;
@@ -6725,16 +6731,19 @@ static int bpf_push_seg6_encap(struct sk_buff *skb, u32 type, void *hdr, u32 len
 		err = seg6_do_srh_encap(skb, srh, IPPROTO_IPV6);
 		break;
 	default:
-		return -EINVAL;
+		goto out;
 	}
 
 	bpf_compute_data_pointers(skb);
 	if (err)
-		return err;
+		goto out;
 
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
 
-	return seg6_lookup_nexthop(skb, NULL, 0);
+	err = seg6_lookup_nexthop(skb, NULL, 0);
+out:
+	kfree(srh);
+	return err;
 }
 #endif /* CONFIG_IPV6_SEG6_BPF */
 
-- 
2.43.0
