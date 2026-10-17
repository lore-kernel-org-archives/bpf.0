Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB53A0E85
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255150; cv=none; b=cv0aLmZtlzkCzqHPVDcDwOiQaWsX+/Czo/XVVxnwkPHYW4Xgbmjfe+so9N/UuWqIiFUA52PXZp9HartJDXH9kyYRxT5Wt0RBWRqOyUkgPaclN6EbTObjyEvfKknRVS+CjS7w8MLHdTnDKQSHla22e0rHpcEeuefq4yXp8MEX6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255150; c=relaxed/simple;
	bh=15JM/mSud0IjBzpDoAVYXaH+6YiS5VMg16ugA8Itw4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHy7ZUY6IgDnnnrEH6b6sR2cQ1c9bPQ7SQotA0aBJduPkPy9CuBSXa5p24xD/eNkAjVYK1TDvVV0YHk2JkgppMgJIp+/kqAijKzbDw99XWcOlzszak0bAHeehBU9WS2j0dakjGPFFB6T1jLc3spgAzmhS4V+4FsHx4IUagQrKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itRlIWyE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itRlIWyE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e915887d9dso3794475ad.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255148; x=1792859948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zVW/Mvg/9zO8L5UsFw4/IZhgeVizToPaRZeVZDWENbo=;
        b=itRlIWyEhF50p+h2DIAt2sumoLdkL27yboCcrjqoGvzACVKzfO+yFQScfFRPt29qEI
         0hRxY4TICWx9eKO76erj35yBLAJ3Era+OCt3tzdPQFB3bMupVpnjHPHXv1dZ5DtaPE2c
         mWIdLAiguZ1QBPi22n2uGNnpFdaft/ZPKXfpX809V+SnJBkOe9Fpu7+4aTrC2RwKH9LQ
         9RxD+Zbg4j9cW60eWiKsyTRCaHwyvsVMu7M6judDZhsx/0oJjRR6sKimaVSS/VWeubrJ
         zoev6r/I+AElZdaMV7svvLRx4IkMd+IrlClsp2Xf0p+YhTdW3F2SUAC46P0/8BGL2zSQ
         up8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255148; x=1792859948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zVW/Mvg/9zO8L5UsFw4/IZhgeVizToPaRZeVZDWENbo=;
        b=THteFm1SPowG0Iy+r/GBpdR5LKCaGxzUfue4wVmaxcuaGWRwxc72Ss/U5oDiWY2KXs
         8lEL/cdFIsibcpDazPZOpgD+5GALSvbcLnLGEZMqsT462KQoQkfRtTdMXmMZ2eRpzIq5
         d/nFmxYOTPXkNfNu0qAOo/Wy98HDHpts1hVs99sIIpf5QfRdkbTiCPlCD9t9Esbe0dq7
         HEbTZgY7ePftueApQ4pSeOIuW+8J6HYOdtETZDZ2UzY5tx9u1D/zRvsGEOD7dZTNk9Lc
         PnYPwcZjb2eKUk95PRHSb8xZaEHFLxY8zkbiKI9BbnS8C7onTuVddBhWzoWB1fBWLK1+
         EORQ==
X-Gm-Message-State: AFq9FYJgJ4hcZhKRWvJcaMRe92r6euA75YHWMfQ/ARL2ie5TMdNRirOk
	ZiqhJrRie7ZJT2CiK1h4sJlqgvJHN+C9/AFKWK8aLliCNYpBDtvWu8gRPMd4JA==
X-Gm-Gg: AYBFou3WoRdhBkkZJFeUtBplXeWwBOjgzhrPc+30KTwFZ4/LkWhMp2JZkMX0+HBNsCF
	Yi4+mQTii4qgGTZpmfhkVDnhSEXNtmg5EkPfDzwQP3TLUwsfqUtJTEHKegyHaYYBQio2JtHilPF
	Yqs3O36r5hZUR+m1XvYe6x+kHD6QFYhCRPu4nqsg0K8kOw3OjzwksnPKEHqzrACsOFa27OE1GaX
	F21+NTb/36F89oXPHj4W1C8kcdsoNHahgzSL/ymLlqF4T0lSOcEpc/4H4XX04vqLswSIZvGBDin
	ilEX1q7yLzJAQxBOJlthDciTIfRh2oLgcj2DyJ57+IMG8cutx8kxaJJ+vhrl27sHXq1AtYeUFWp
	HUae+uFEzB1xCEi15qkC6rRDkt1bWFXnSmHJFJXDa7JfQEQj4ObUlap2GhKA+0j782rcGBt9jD5
	eBxZ4slxkOw+DFDvzU2gfaV9KVdJKqukelW8FQr1rrJFs+aB2OOX3dv8FKdV7F+5Xyz2rw83Q6t
	klbeNE/drWKP88djluKpdjhDXxhVSpymkQgYavQwTLxrlFEzBmqQXSBZkx+WvYpFZXth8kyvoVR
	QfgcI2sqgMJB0x16udmG/1E6ecSn6h9n4d96BMlXayzx
X-Received: by 2002:a17:90b:4b92:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3acef52acdbmr2740344a91.49.1792255148056;
        Sat, 17 Oct 2026 09:39:08 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4991b8asm8701822a91.16.2026.10.17.09.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:07 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 13/43] bpf: Update the SRH state if End.B6 fails late
Date: Sat, 17 Oct 2026 16:37:15 +0000
Message-ID: <20261017163745.3341787-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
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
index 6fbe0cea2140..15354134091a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7087,8 +7087,8 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 			return -EBADMSG;
 		err = bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6_INLINE,
 					  param, param_len);
-		if (!err)
-			bpf_update_srh_state(skb);
+		/* The header can be in place although err says otherwise */
+		bpf_update_srh_state(skb);
 
 		return err;
 	case SEG6_LOCAL_ACTION_END_B6_ENCAP:
@@ -7096,8 +7096,8 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
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

