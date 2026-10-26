Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983658;
	b=5M93x0R37zXRNKQ5KnZGs6onhLbHn6aR1ZVhKVrdAtu0ILP4xgqMzOBtmxoZPJCM86XZ
	 X+upOxNEBWVPL7N0jE7SRtCcIZtK+aDNza7XOp+Dz6m41sbkroH3d8enQ9OJ/QEHLQTji
	 +aCj507ftEmWdZZX7Plc4NjOTYkTaVFJuTfUZpty8aYmpRhTrzEH1S40krsq13BjA2QUM
	 9gAWFyvbWDbEgVBMC71GLUMMz8Cjb7xZEONJ54VWz0pqFLyO7HGEX/SmmCqqp4IQplNFW
	 58DRL29GdKqGL6Vs66F05oLZ4XGqGQEBPUoAzWn1DMKs1hWyOlr4lrE231MXC49u3qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mhnpjz+VjUtv8RruZ2eKApayTeuASjV5rK8+FhxUGMs=;
	b=SqVr2mOSkyoMFnMvrdZvlqZoymUO4mBLYL4AbimI8z2icNe1pk3eUd4IR2Oe1x51BNAf
	 ewGWlFwJ1ADbVaIaIHPedfPgb98YseexDuiTj0IE4OGmpfxqrf2VHdbHnkmKmY14Zpj/+
	 644FOFq+e2eRu5+ErzbCFz7lz+LtyMBz06gaD66Nmt5SrvCRmICtOt9AJJfjju3JAZDXn
	 sKesWi0QXj226WqWisaQkVhTvprOhRJdiX3+6+jH81khj08qFN2hhY/++84YmIxsG/7aX
	 k3k9paequ9GcTFNR135Sw5oNtU7sAm4kuWyMTEk96x+LiueL7EsggU4K/wnOn6Icv2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i5tYZsyB;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104A1606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 104A1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i5tYZsyB
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd8ca57ef64so487575a12.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983657; x=1793588457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mhnpjz+VjUtv8RruZ2eKApayTeuASjV5rK8+FhxUGMs=;
        b=i5tYZsyBcZeQclj740FoxPtI6BeSAAnCmTOsoPnkptgmLIlOoRI0o//MKg7G6niHaR
         wFJHhwucRw8IIsyYoALFVj4/pTy4YgBLz9E+pGfiKRvkR80wqvCRP7tBj01pZsDRLW7s
         ARPBhNJXU3QKolp68vrN0gwr5GtTweujr2WUi3pYopJPSwRxDKGkTrLxGL+CTLSUYTfY
         ivz7/AYeuvLU7iFinTXPEuvvvYZRnTpPDLjXXafPRuozq1y8wssBuiKwSonKhTI+yTwG
         3AQO+Jd5Jp/HLgGtnJMZEo72sMNDbaN/E6cK/u+u7BCT4vrFCO8yzY7o6MmrXticW7sz
         5npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983657; x=1793588457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mhnpjz+VjUtv8RruZ2eKApayTeuASjV5rK8+FhxUGMs=;
        b=Eg2O3G838ZsbN85QgpaeDMFyKwKrtLTcRTrtDIUoFKSpOo9wgsUQsFQooVnYs9xZJP
         s4A/kFWgcS6MuQTqr1py65pER0BB77Ey3iTfDAU0SnGYtM/8R7T8Zlt1Ye0fuhF+Fvss
         ZhBno31vPXv7/939Jbul0MuNNC7lZQ7spkShaEFV+0eVNWTVbwv5gx9IsYpElQ//0JXP
         VyRaqDAyEeb7+tTK3FVBhh6AdQHxEd8xFkqvKNXglT8ezTr+GfXU2obdX+lsCy9Ptzo6
         xLGfeNxk9kv4PkIX14lQLY8Y71bMfR6lK2/6bd1kO+5YBo35JNG/OeqNXdC8597BEm8E
         zi+A==
X-Gm-Message-State: AFq9FYILvuQOMbSjJbjxeR4EZ4+LzgY0oYgfXFLbNnunh/AU1AT2kfVn
	4o548scd8EhA4W1CZiwSItVwgpUFry2nN4bboZr1yjeYftgBEjIfKVlAedBG/w==
X-Gm-Gg: AYBFou1Gu6qn1KB5tBTQKHisQalVCxkD+WlO3/a8DvIfKjXjCWymp+4af687fpFlvGC
	VQsr9tDxlHaBiz6SmEKeMYifeiaZkpPEAqyYmx4kwhoXpoije9RMx7UU5Zcz7Tj2WSnoIVMv9hK
	dUOXD1YI22VyKbfFrmD4H+Kldsxl3L3O+ndTymn6226bmSBtNMGbhZkB76NVIOxrKlxYigoF9wV
	WXJzdszio3E4GInDgFaX1b3Xp3CFLjfDJ4sxHmoyKg/S6PzGD+lGj4S0qZ16ZFpzsYULCba4VDB
	voZF12SH00safl4l9/CEPzSNAvQLafZ4FFHj2jx5jE4Gf5Q95RCeMKgadw4Pdr+bX/oJxC5VsKr
	Jwv8fIsMA6Q/g2yvH+Xgo+Tw4w+OSf7YLt4/ntS3SuIUz45kxc7UEVJPyft7XJ4jHQ3KtDf1vMC
	GiIdwvzcxatwDHxjUtaPrRy4lmn3/RkYKcjMTQQz0GD/Sxo82PYA8hjjUx017jWQi9qNtD5ijF+
	HqaTmt1oG27W9DAXeJQwk85gBRJPoTQZVHv7Se4MGFBctshqaF7DcWjOSHUEp6NMuwif+DCk/LU
	RVrrDoBp9PzMa/1LcZhDPQXXCzUb2xm+/jy1HrdAxyybHbVgH6d0z193JBLSGjEQaHltBvqlVRc
	U2qFVcHdl+eSIZyDNwnoMYkMf
X-Received: by 2002:a17:90b:3bcf:b0:3a6:e159:a229 with SMTP id 98e67ed59e1d1-3adeb130d99mr3063234a91.49.1792983657332;
        Sun, 25 Oct 2026 20:00:57 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb18sm6335989a91.15.2026.10.25.20.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:00:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 12/81] bpf: Don't widen a pointer to a buffer in scalar evolution
Date: Mon, 26 Oct 2026 02:58:33 +0000
Message-ID: <20261026025943.404450-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Scalar evolution widens counted loops. Since that change the verifier
rejects a loop over the per-cpu values of a map element:

  SEC("iter/bpf_map_elem")
  ...
  for (i = 0; i < n; i++) {
          out[i] = *(__u32 *)pptr;
          pptr += 8;
  }

  loop header at 12, widening r2 to 0..56 step 8
  R2 invalid variable buffer offset: off=0, var_off=(0x0; 0x38)

pptr is a pointer to a buffer (PTR_TO_BUF). Scalar evolution replaces its
offset with the range over all iterations. But __check_buffer_access()
accepts only a constant offset. Thus a prog cannot use a widened
PTR_TO_BUF.

Do not widen it. Then the verifier verifies the loop one iteration at a
time, as it did before.

  loop                              before SCEV  with SCEV   this patch
  --------------------------------  -----------  ----------  ----------
  counts in i, reads through pptr   loads        rejected    loads
  counts in p ('p < end'), no read  1M insns     loads       1M insns
  counts in p, reads through p      1M insns     rejected    1M insns

The verifier cannot decide a comparison of two pointers to a buffer. Thus
it follows 'p < end' until the limit of 1M insns.

bpf_iter_bpf_percpu_array_map.c and bpf_iter_bpf_percpu_hash_map.c have the
first loop. They load today only because they also add up the values.
Scalar evolution has no formula for the sum, and in that case it widens
nothing.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index b321bfee36c5..4266651e3fe4 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2377,7 +2377,6 @@ static bool is_widenable_reg_type(const struct bpf_reg_state *reg)
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
 	case PTR_TO_MEM:
-	case PTR_TO_BUF:
 	case PTR_TO_BTF_ID:
 		return true;
 	default:
-- 
2.55.0

