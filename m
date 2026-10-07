Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6283D955F
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394585; cv=none; b=eGwUz7/dXsBLRohuu1q4f5O02Lb9ArUfoeyQvUg3yDXPCht9irWBBpZOV43mUSa8Onwy+C5snj8hiumFL32UZyEknUyfJiLYNUJi8ZqDDY+R5YGHg9HYh2U0NFqMeFJAEYOgAzpWTjy9H+Q+bdOi+CTm39sbzRaGb+4WqDI7Ui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394585; c=relaxed/simple;
	bh=B15gC0G8av5+u2JOpKhJT4tl5WnKeh5OkEERBo/C/4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGQnOaLG4hhwLVy4W2f4WlbfKwo0Ler6L775f2i29iT02GB9A7/C9me+R533KvOVkEv3GhzofR2Iu8snjwg+Zot7gEup0x1HdkU8/+kxVbFQ0BnI8UodE97yXrX/04yA0Q2NY4344KfiO+YBo8IBqVua//UIlIvOxycLw2GJei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=FbSCfzw5; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="FbSCfzw5"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917d595138fso26208286d6.3
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791394581; x=1791999381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2rBDRuhB0SV/4ZUPFZzhwBK8Vu18OqxAueMew1Clks=;
        b=FbSCfzw5gGaGd/yR3UH1YVvBaMrH9xfx87h52LqWi/H0hvz1cE0h9PR+JuP/JmpE0e
         tBfCgHJbD1UfVsBmaHSMUoaMpDPUCQQiWtzPOgKDKt+gAEsF4ea2CN1otarqMUmEnV5v
         MtpliqU+j8be+ktFWGOu8ZVkihwIPflB9dfneVgj45FAUncDBh3uVWveyHIywb17WUQO
         C90Ui/QDNeYVU7NE3jL1jtJW3N6WMSXytHg0pnbyhHMHkVgrzoPe9MEsyF8vGn3TXQkQ
         xcLQ3vSNb7XO3PVUTOthG8pXT0Ag5V1V/rUxO31Fhf+H3VZpGRfnLlFCnJwbIjsoFzN/
         8MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394581; x=1791999381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u2rBDRuhB0SV/4ZUPFZzhwBK8Vu18OqxAueMew1Clks=;
        b=bO5+Vc0Acr1fF+5JlstTKVVo6lJh+hVmYZcTzgJpd/+wVQjHGb+rjzAettTLMYIfkA
         qEPFKPVy0p0WCzJ/R3YfSaqs2G55oS1EWuArLDPqmofFt5uNPfLXR1pRb4orvCsriwxx
         DAiK85XowzuCepox2H5ErM0Ich5zzFZIaGBuzkoZvEmb2H8pJ9Ij/Kg5D8+OzTjIsZmb
         9miEjXDlb1QaP1PtgX+yt2N52PjjUA1hO+e6Z6ibl+vyd36u7B0VltPeSYU4OjvFbHWx
         Syci5gicrJZ2tW56Auqw5pe1L6YBnZVy2EN+zSU6AvXyJ4oZFX/IS6U9YGG2rrAeL/BB
         wVAw==
X-Forwarded-Encrypted: i=1; AKwUvBy70m87Hx8BSNRKTNIodjkfRLw+YI+wVCFpcW5bT3f5eRn4OxRhQkS81GyLPAIns58FkDM=@vger.kernel.org
X-Gm-Message-State: AFuF++mJjct3SmclL+VQ1tPi6GrLyY48rthncTU/+7qRlIUuUjw8sVhJ
	9Y2Cdm/kFhPXFUHZ4NINCOFxM9BLZ+V2Ddf3XLT8g23IHqgjla0lSuqGgrT5h340oA4=
X-Gm-Gg: AYBFou0nNx87VnkWWWMI/1QQCSacHKegOZx4GVDOduzhKAEgMlpIeYyhBLk5GBpfTuG
	tL26+vCA58KRPBF4xepacmHC22dWtYU1rdsj1l9CeanT4WbZfMzH7cQ6m27z9k+7P+A26nFdZNk
	QnfRXzv5o6rB15/U5eDzZPM3Nk51eImbHqzwubqPSeul/P7u3lIijpvkEL0lQijULKoEKam7KLd
	sqwxPa18srFLUlXlQWc2pysNWuYtw0ro2I/T7jAmrKYUH5j++9/bSjoJQx7VkLD+JtqjFwpRDSE
	o7pogkWX2znM1puMNIGp5XAQVxYQYONWuSFhGolIhD9UTFGOBscAAadOd/QhjrPUrROA/9Wtgur
	LhBz2+wR4GOYq1A6DOOLCegCIvDQ163fd/WHA7KnUQ0hmtWm+nW+nu4NtHdyZXa3wd57sXryBn8
	rqHTqXcZ1TYC8Who19tI/p9GO+XkaO02A+F+f22uFu7Ac3a/JP7+OY9pvFtxcGU+aATRSStT3Uu
	1kXTflqj/rVkHQ=
X-Received: by 2002:a05:620a:4494:b0:93e:5e0a:c217 with SMTP id af79cd13be357-93e9b72196cmr609241985a.23.1791394581394;
        Wed, 07 Oct 2026 10:36:21 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e990ef6ddsm263104385a.15.2026.10.07.10.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:36:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:36:03 +0000
Subject: [PATCH net-next v2 4/8] net: skbuff: don't BUG() on leftover
 length in skb_checksum() and friends
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-skbuff-bug-on-v2-4-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791394570; l=2054;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=B15gC0G8av5+u2JOpKhJT4tl5WnKeh5OkEERBo/C/4Q=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKXfXz/IAEskgeE/nrg9pZDCAhIt+yBCzxlBtyLXPJmOGVqtnAMPiQM00LbNs/YR7NK/RLh2sv6
 m75CTHHigFAA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_checksum(), skb_crc32c() and __skb_to_sgvec() walk the head, frags
and frag_list and BUG() if they run out of skb before they run out of
@len.  By then nothing has been read past the end of the skb.  The walk
stopped at the end of the data, and the check only tells us the caller
asked for a range the skb doesn't have.  commit 06a0afcfe2f5 ("xfrm: do
pskb_pull properly in __xfrm_transport_prep") fixed one such caller that
crashed in __skb_to_sgvec().

Return what each function already returns when it can't do the work,
with a DEBUG_NET_WARN_ON_ONCE() for debug kernels:

 - __skb_to_sgvec() returns -EINVAL.  Every skb_to_sgvec() caller has
   checked for a negative return since it learned to return -EMSGSIZE.
 - skb_checksum() and skb_crc32c() return 0, as they already do for
   unreadable frags.  The resulting checksum is wrong, so the packet
   fails verification on receive or goes out with a bad checksum on
   transmit, rather than taking the machine down.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ffc78b1a8ab8..32d7f5ed25eb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3619,7 +3619,10 @@ __wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
 		}
 		start = end;
 	}
-	BUG_ON(len);
+	if (unlikely(len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return 0;
+	}
 
 	return csum;
 }
@@ -3780,7 +3783,10 @@ u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc)
 		}
 		start = end;
 	}
-	BUG_ON(len);
+	if (unlikely(len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return 0;
+	}
 
 	return crc;
 }
@@ -5339,7 +5345,10 @@ __skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len,
 		}
 		start = end;
 	}
-	BUG_ON(len);
+	if (unlikely(len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
 	return elt;
 }
 

-- 
2.55.0

