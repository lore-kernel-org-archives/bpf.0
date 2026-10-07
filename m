Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291463EDE7C
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394591; cv=none; b=BzHaqSex9I3BWveU5/O22YYrWQGKBCmm5dhvSRmvMdnJTUaFykCm/8+BxPkSrzskmuP4qhKaGOpUJ17k9xjm0Ya/jodo/oKsojmhMGIpjqbC1vHEnSC9qj93YUpUALSBMjEVBNnMQl82DCJo2vIP/nnmgE1Q2Z4aY8i6bm02a8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394591; c=relaxed/simple;
	bh=UfAWlPGQqg3RDuKRzGCzaCnGMtK7225kxdogm7euAY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGzFIkMvaxU6DGQveQlHELrMhERCyZFghQ0fWTH08ZUup9F9sJX1Oz4ui0gSqk0K08PbyzNLuZejnF1PEnda4JttkaXIzTt2GW8a02ft5Mchw8EoVqftv5qNDB7vqlLnBZ1c9DQY1omYOQ1mo2d2TuG5Ag8s8OWB3YEcKXTwmIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Ty1RiHM+; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Ty1RiHM+"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53391786e55so28255591cf.2
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791394586; x=1791999386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UCkGJ8vEAFX9qhjd5vmdoyoQrJArzIQbzoHlWynEGpM=;
        b=Ty1RiHM+7f74KFnI318YzqaGSvQqlaXbHDcrNXg+wsEgexR4VB+Y/cbWGMTMtDBsNL
         kjrJhLl7Gae5/Afdj6kvhrCZNGma1m12M5DzbH0MH9yh3X+OOsMIwe5acH3vdSR0fq5N
         EkJky3XJswS0e0ojjwtU1ixfyMILfVVUlMRUAmXGFk/+9osyq6YdPrbb9Q6+7r9YI62U
         oRNwLd5tiOcIaD6G9YSnb/eCIFeQFOksZ1HvK5cK4ToRjbgJPKuVchWTcAk1WJOXXzK4
         A1mfbqlTyvUa6ekWaNV+IOzk7v8tnsTMdCuNuDkFffK6hnON9BevXC0PxT6/h1tU1wxs
         z/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394586; x=1791999386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCkGJ8vEAFX9qhjd5vmdoyoQrJArzIQbzoHlWynEGpM=;
        b=dDcdFaahLKCWHngmACj0SPwpJ6Qf3ccQyc8hJ6/zAWFdZkAIvP6EgZMC1n2cjfYuyM
         JjtklL8PkIzyQxxvyG93NG7kRVXqusyhDzjLuSveK5urPNYwLPSSH+hLRhYo2PiQWnHo
         9Q/03GKcdH5XwwVkuF4TjybWj7wYVij63MP4KqGzIZPl/Zbim/CWI6120G4wPKoVbhrb
         vO7EanQn0LDe5enIo9BoOxgviDqoJkEfsdDBO8PbFNQPCRT2AxoJDyMYzMLseftkARwc
         +eGq4v3OJPL+oR/VwB6KDim0jQD371f1p3rppgQQXmoDR0VflH/uBIECqjjE4xtcny4L
         O0eg==
X-Forwarded-Encrypted: i=1; AKwUvBwCJTEA8QbDNkcJq9Iaszdnxm/ZMXAAg9xgTo4pUiSEB3LSROmH3m/vIe/GpxgWKHy+FDU=@vger.kernel.org
X-Gm-Message-State: AFuF++kg7Oja4JpaJ6VXHEY9kCUoXtxzy7H57JFGbw73Dee9qd8xJdyY
	O9HtMUkKbftBgpWIGjjVBzwgqOaROrnpjpxnUvJpoHcKnR1ZzPWxJumjHOKJDOL3xyE=
X-Gm-Gg: AYBFou3vf1KwBZAO5UgFNLsh7ZZldqMiz0q1FmTt2a81e97XGqgt+9xwAEwuL903tEV
	8uvkZkaTrTg0S0rBE/3LlWK09Qu8eBYCGWdGLu/H/6W/9L4w8vTvF/LHXqpuxm03KVd1EWFEpvY
	mlR/BIHyCXa7okl30ZXpFcMbLJslICRtbZdHKGZrXkYnSX+CfhqWhq70EQ7iG2EID3H/n9rkAA0
	zuXIbfysFh46KQ1lRNweAvdd89cdHcvjo1ITz/nlpjzxD5rLYNeRiZp0ih1vTdVju0Kz+Ej3T8e
	T9bygTA5okCCl2lYl1UdebwUUNS0eh4/h65vmUuIDOcI6FK9r6YeRi/UTQn+jeJzVUXEWxI/7n3
	/Om9MIUFi5KlK+7jVuInHrpx0QgrJaNkUBeRkUCji3qjsl0MxrSV+MlAhtupTmWdpKO9fC62tIk
	wMLvERkJpMYA3BQ6C0A66iEgKtJizqS8Q4kqClzUA/oafaqde+OoOEMPRHIHEqAbVKTdEXs8fkP
	yEReFHO8ou7zVk=
X-Received: by 2002:a05:622a:4106:b0:531:164:fa73 with SMTP id d75a77b69052e-53575540ec0mr56191091cf.32.1791394585976;
        Wed, 07 Oct 2026 10:36:25 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357218df11sm24570571cf.23.2026.10.07.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:36:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:36:05 +0000
Subject: [PATCH net-next v2 6/8] net: skbuff: don't BUG() on leftover
 length in skb_copy_and_csum_bits()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-skbuff-bug-on-v2-6-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791394570; l=1690;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=UfAWlPGQqg3RDuKRzGCzaCnGMtK7225kxdogm7euAY4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHwUBafMKBimgYVVN+bXxgSlOD25sS8QoKd5vmQha27+BivjekrTHnSxba4rwvfVesma/zXcoJX
 shX51TQQ+jwA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_copy_and_csum_bits() has the same check as skb_checksum(): it BUG()s
if it runs out of skb before it runs out of @len.  This one gets hit:
commit 7d63b6712538 ("icmp: guard against too small mtu") and commit
f99cd56230f5 ("net: Remove acked SYN flag from packet in the transmit
queue correctly") each fixed a crash here from icmp_glue_bits().

It can't just return, though.  Its callers copy into a buffer that is
about to go out on the wire, an ICMP error quoting the offending packet
for example, so bailing out early would send whatever was left in the
rest of that buffer.

Zero the part of the buffer we didn't fill and return 0, with a
DEBUG_NET_WARN_ON_ONCE() for debug kernels.  As with skb_checksum(), the
checksum usually won't match the data, so the receiver will usually drop
the packet, but either way it carries nothing it shouldn't.  @len is an
int, so only zero when it is positive; a negative @len from a broken
caller must not turn into a huge memset().

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c896770203f7..7fd2f8142cc4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3713,7 +3713,13 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		}
 		start = end;
 	}
-	BUG_ON(len);
+	if (unlikely(len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		/* Don't hand the caller a buffer with stale bytes in it. */
+		if (len > 0)
+			memset(to, 0, len);
+		return 0;
+	}
 	return csum;
 }
 EXPORT_SYMBOL(skb_copy_and_csum_bits);

-- 
2.55.0

