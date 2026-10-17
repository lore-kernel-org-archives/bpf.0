Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE76B37A85E
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200341; cv=none; b=r7iz3mJtGeo/n9g3NfQW+Q3EvISvwRpXXtkJo0UWxpIpPCT+BsYQGnUPSmTq8wW7AgaDAapJt5MC0/WvOPdF+MFYD6HJiqreCIE8qBsdgNl4bX/dDBlwtOeBDtgsUXuJMAAqgoe0N0DQMvhh61P1zhkB23HNYYOtBq7l13gybOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200341; c=relaxed/simple;
	bh=UlbqOc6/7t4Q3Rv1OI56jrgQ8C6d+UlCYrOZt47zjcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d05R0mxHymECagUGd1BFe99h4z2+8DBvMclxgJ4VF34blzY0O4jqpWJ7gYubXbRp+LqjyA7X5/d427k1pAokD9fZFwkDLEwt5tSoAYU6WcGzKLYvhZNwmkUr2O12dY9JbPOS6528PEfSedbMCIiI2I38+5tjKogTHzqnyyPOqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBUE8Uer; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBUE8Uer"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd5e6f0a22bso257082a12.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200339; x=1792805139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnvXl0R2ZaP6oESQKq/Jn4JVsvE5tAcrzA9epQ1+wnY=;
        b=KBUE8UerP0YWZP0jc7flDtPcHLtXuumyeKUwzgd61oS7Zh0eeVHujWVXb66SGQGfFK
         VN6DhbWBzUsUQyJNkm5xO3Hp4FyVcts1XBFLm3PXT27bBWdTM1Rn78RlTFAVaIdCaCm9
         wwGDxvSvvul8y2Nj2PO2P/CGd98hOhLBaPCoxSvqTWr5JOwvrnlonEoaELZsQsilHi8X
         biZfNv11GjVBIEYGZJQF+iIhl4LuyXoeNxuzX4dWZ/HRdkBaJUKudvM4OxO15He2r9HK
         BghvLxBxwRD8IMc9GUa6MO9g3ENwYT5ShT6YROW7K9MpHGgyb/Fazu0MQ01XV6fyMUka
         BPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200339; x=1792805139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KnvXl0R2ZaP6oESQKq/Jn4JVsvE5tAcrzA9epQ1+wnY=;
        b=2bq/IncorChz3m4pwHNoyIu+GTraqWVm8qx1pp7twoh0MPcUQhGsVh8xqpdfBGG5xf
         zTpi3lB66OEJjYs/3dhRS6q9cc9ubaDH/scAfc8aVbnUSJc7OP/rQR7wi8+DtwYohmoU
         e56/YwWqGLMRkrUOJ/7PzlkYYVaQRQNjuKgW0iu7dXZXSrGc5c334zyYj1Jz+490kKj7
         YiJ8MHZopD20UTuu2x6r6lbQQcB8PqTdegbQzjZfR/7qG1YoKHvCH5M4GEkKjlt9j4f2
         cOGhxpfsmhqRBejIN/W2dg+0yBGj/CyFay9yn2/2JAdGb8ckoTyhIOZNB4RBKs5CrRvU
         gu3g==
X-Gm-Message-State: AFq9FYKapkGrdGhT83t6BoMUOCpdSYKcxsnA+fhxDR7sUzsMdAlu8/j3
	GNjAegOgcTxeLdffgdp9k5IlU2RkX/HhnE72+jDOQprz5BT/nbeQO2rcBTwQgIcb
X-Gm-Gg: AYBFou0aLi0eEPD9/PZPezC1MKN9vwaFm+76wqGH7fCwRzeTMi/2jfc0UgOltkRHzKF
	rWpQVFpA6oIcEZLfi4sewcBQ3jJ8YPeXWOvUNY24eI6vw+rnAfH3cvHsNhdtSG/D8t76YIyafUt
	n68LPSio9xjpHtxrPmsPDZwOvU2WqLmrXFzfynCI04CzNtEt4GRX03KzE+cKcFyDRguZk6P3LRL
	6FOutkCPBc1AESsB+biYqSSg9wd3zh/ReQ+zsj7B1xeL+Bi4JETF1bG0VzoqDbNWCPUDvPx7wg2
	zIehCjN+Tb1sqICAlOX4ZP/5GGzvfFFmAtjvIuaamuLf8THWvqMcVUuwW9Lnnt0JizG/BfMC71s
	NHx1rk/gGBXa2+4Qcao5EJdF5V3cBwprjCrSq0hK1h2TBVFauRuS53k6qUY6CtjPjGjjgw+AKQc
	e1hq6lHSphEo3iiqRJtmoM51mv9VxiUukq0QLcmd4D3jRegBxUSH89ZmQDeCsxqnzQtjrqAAXYS
	MsnM7kmzv0ktf2crrFPwzqNshfNjb4Bzk98SkaSYOCSuD5fuL5z7KLk77KkcwIgJZ36wrGaKe1x
	x65ntuboGLyouJ4lFMrDFBOuKd2VDhuxSFFYPh9WHhQ=
X-Received: by 2002:a17:90b:5111:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3acee293889mr1411278a91.1.1792200338938;
        Fri, 16 Oct 2026 18:25:38 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4872861sm6792933a91.7.2026.10.16.18.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:25:38 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 11/38] bpf: Validate the SRH which End.DT6 uncovers in End.BPF
Date: Sat, 17 Oct 2026 01:24:24 +0000
Message-ID: <20261017012451.364800-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

input_action_end_bpf() validates the SRH of a packet and pulls it into the
head before the program runs. If the program decapsulates the packet with
bpf_lwt_seg6_action(SEG6_LOCAL_ACTION_END_DT6), bpf_update_srh_state()
looks for a routing header in the inner packet and takes it for the new
SRH as it is.

Nobody has looked at that header, and whoever has sent the packet has
written it. ipv6_find_hdr() finds it in a fragment of the skb as well, but
hdrlen is then read at that offset from skb->data, past the end of the
head. The header need not be an SRH, and its hdrlen need not fit into the
packet, but it is marked as valid, and bpf_lwt_seg6_adjust_srh() and
bpf_lwt_seg6_store_bytes() check their offsets against it.

A program which then adds a TLV at the end of the SRH, where hdrlen has it,
makes bpf_lwt_seg6_adjust_srh() move and write memory behind the head of
the skb, as far as the sender likes within the 2 KB that hdrlen can say:

  BUG: KASAN: slab-out-of-bounds in bpf_skb_net_hdr_push+0x185/0x240
  Read of size 2088 at addr ffff888107d6f09e by task srh/102
  BUG: KASAN: slab-out-of-bounds in bpf_skb_net_hdr_push+0x1b5/0x240
  Write of size 8 at addr ffff888107d6f8be by task srh/102

Use seg6_get_srh(), which pulls and validates the header. Without a valid
SRH the state says that there is none, and the packet goes its way as
before. The pull can move the head, so compute the data pointers behind
it.

Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action helper")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index a18702f89feb..6ac386dea4e8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7022,15 +7022,15 @@ static void bpf_update_srh_state(struct sk_buff *skb)
 {
 	struct seg6_bpf_srh_state *srh_state =
 		this_cpu_ptr(&seg6_bpf_srh_states);
-	int srhoff = 0;
 
-	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0) {
-		srh_state->srh = NULL;
-	} else {
-		srh_state->srh = (struct ipv6_sr_hdr *)(skb->data + srhoff);
+	/* Behind a decapsulation this is a header that nobody has looked at */
+	srh_state->srh = seg6_get_srh(skb, 0);
+	if (srh_state->srh) {
 		srh_state->hdrlen = srh_state->srh->hdrlen << 3;
 		srh_state->valid = true;
 	}
+	/* it may have been pulled into the head */
+	bpf_compute_data_pointers(skb);
 }
 
 BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
-- 
2.55.0

