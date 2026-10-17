Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69746303A04
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200384; cv=none; b=FmzLVRXy3J8onvSQrT4ayhiMcccj+ibau89W4n5iZw+lfp3T49sxOGBBmb4jFCF1edJfy97+veLUjVwEExa9t2OjnwfywV1KjlqBeqfGofR9FPDE0dP1uqOhTd7ZQC2z8HOhUGNTdKdURHu51T0Wx9i8J9Tx1ckv9G4ZnkEsKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200384; c=relaxed/simple;
	bh=08SBMlIPFZ4QqNwPVXontnnNyNqGBdZW7HWIVBvUBAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BavVKRNqk5RJN1uq+Y8el1jrqGx3TjcLujD93hmEixUt2wcyzuxPd/+jyGkhsgkUEpvAQZKPj31d0rwxoAFQL972BZuH0mmBNGvlfd2Ej1Kf31qTfWimoAXARVBvabXzMPvPjsYtUsxbEzYMV7dZxciwqJp/lvt51q64QXaw5OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci+/j4z9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci+/j4z9"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-398b3c37877so368768a91.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200383; x=1792805183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w65oifnN5/ENwAdNOCu2SExnEHx1+W+Nj3UBG9hGAvI=;
        b=ci+/j4z9Z0YmZFkWkpj/+6AiYsu/052r3me+s39Ma0eIRW7xLcrfQAbel1kL48t0lM
         BqfnpZBi9daVHiGCnG+OWWH91YWfPh4xq+QOG+ani3jjVW+AP1g9pGA1KTCxegLPFSXv
         wCkjzdFCFXFjsbOzCi2ebHj7IiVmT51MgdiWwE4rMZQ8PPV6Id1EZHYwZWfGU2NnUXi7
         KrYy390BVYmRwpAjnMaJE+/u3KJjdPIuLkycCxx9OQhrtD1Q705I1HfFErJBWof14N2U
         qM+LlUIL4KkIsHXGAv4HSXtEbHiiRteaBPBvhcRM+m2OI0e4W4XMv26uxIMEumrJaTGv
         DEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200383; x=1792805183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w65oifnN5/ENwAdNOCu2SExnEHx1+W+Nj3UBG9hGAvI=;
        b=LpADakFcKVO3Gc7qnDNhx+45Nz1MccZZHzRuPSdGjGNKSO0S2mkNK71OwZnksjmEKi
         uXIT3A+SGWskVhfw7vC4mZpBMR9Eq+HB057adqF9IyqLVW5ocqMrPmYMc+586c1+eH8n
         GxvKYpni/ObI/jjThrtukr5QjsfWOwUkmBUL087a8XtmjPzEr7jU6PYt2oDeVwZtrdBh
         XdTQQ/ZzhRQGBunkjttXm8AgOgNuxWN22su5+w05dB+5tjVGoPZn29TC5TtKD++kjROO
         o+VVcK2Yi4WwqZq0vaj5sAer/51d9wz58LxpEecwjcoJkcFNyGrGcnkpckFtx7t2nFQp
         M7IQ==
X-Gm-Message-State: AFq9FYI0G22R1l1y35gtFeOUg+urxkMofCj4k4doyP3Bt5QPYFuNINzD
	XlPPdnsAmDcmlgLq852dD/l8mywDHhHwpr6fX1rk0DeS0JoUiyMtzAupaZ8RR1qe
X-Gm-Gg: AYBFou3z6oe4wbojPtBNBT7EQCbbCoxMTsh7AdXuWRoQyR71285CaooZMQtB1bMPuVx
	sEGf2gk37pHCACkHmBprh+qIoXiPt+bWWxBCXVxpXNLA0es4NAPHvmakcrPhwZx8BTRme+hgo8v
	Jhmgj1fcH9JXjF3El9iy07e+ShFdr0tYWhcHMu2qoOW2DFhx74WGf10eFbvxtEwpZJfUdSsoeYt
	KMByhFgE9bOtk62N0+fLyJGmUS/LypM/ecWV73cqaUB+3V/ft3xhSRQ3mWhgPGoWVpWbiqTt5uA
	AwuHPSZW8JJD5GwwxF8YITlE1Em2S6nlO5kK2az1rAsTE7sxIe3klfTwhV37CqQRTttz6dLHRjj
	HzheXv0wnoPI2B378Z1gcLWtTppqMTUBLHtu6b3ukcZ0BQlRjePdigQaS24u9/1VGa/qx4blSTO
	6iVx31KAX58bmAzjwIzrkbZCEXYJ9DoXox41uBJvwUdtbt20yPE+E8MedgchsWykc2Re5m+XE1i
	BYsV2rz01nY/BNdx62HlwOboCiaGqZNpdIh+c3dVTDvygrvvp3CjHl6IQDaCj0hWWTiLkMKjbvf
	wXjkq+FVvAeRrSV6V4RgH2hB7HgW/I3alNjTPwFXoIU=
X-Received: by 2002:a17:90b:4cc6:b0:3a0:c85a:ee02 with SMTP id 98e67ed59e1d1-3aceefc4ee9mr1354763a91.17.1792200382627;
        Fri, 16 Oct 2026 18:26:22 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654850c61sm1886129a12.1.2026.10.16.18.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:26:21 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 13/38] bpf: Update the SRH state if End.B6 fails late
Date: Sat, 17 Oct 2026 01:24:26 +0000
Message-ID: <20261017012451.364800-5-alexei.starovoitov@gmail.com>
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

For SEG6_LOCAL_ACTION_END_B6 and END_B6_ENCAP bpf_lwt_seg6_action() looks
for the SRH again only if bpf_push_seg6_encap() has succeeded. That
function pushes the new header, for which the head of the skb is
reallocated if it has not got the room, and then looks up the route to the
first segment. If there is none, it returns an error, and the pointer to
the SRH in seg6_bpf_srh_states still points into the old head, which has
been freed.

The program goes on behind the error. bpf_lwt_seg6_store_bytes() and
bpf_lwt_seg6_adjust_srh() read the SRH through that pointer.

Look for the SRH whatever bpf_push_seg6_encap() says.

Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action helper")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index be792b160e18..bf01152d0cf9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7084,8 +7084,8 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 			return -EBADMSG;
 		err = bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6_INLINE,
 					  param, param_len);
-		if (!err)
-			bpf_update_srh_state(skb);
+		/* The header can be in place although err says otherwise */
+		bpf_update_srh_state(skb);
 
 		return err;
 	case SEG6_LOCAL_ACTION_END_B6_ENCAP:
@@ -7093,8 +7093,8 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 			return -EBADMSG;
 		err = bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6,
 					  param, param_len);
-		if (!err)
-			bpf_update_srh_state(skb);
+		/* The header can be in place although err says otherwise */
+		bpf_update_srh_state(skb);
 
 		return err;
 	default:
-- 
2.55.0

