Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B743B5850
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394591; cv=none; b=YWRz5rR04pL7VApnOaOh1ois/N4QNtVkMEYjF+O7wbGD7tkrjhifsM34BQtefwNnSYzaoBkgbtvQf99JUgoZqCdXDrwDysbhavIgK3WmJXSstV+Nk/eFeZITxK8wdtbzkzZRsB/ADz0ro4FDiE/oluFbSQFJPeyGad4c7E7b8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394591; c=relaxed/simple;
	bh=KbWyKGSxjhF5GejC0AxphlWLzf470Pn66p11+I61qxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OOeZFnmBGfy6JAlpP/KxoSvMtN7/TzSbYkeWAcaMBPDtBdgiDxmZAhCZfh17MrdmCjDUbAK+xW3n40aOHnp/kbyd+8Z8IcGYPzFQhAYIIzP+mxAtljOho9vY0YVYm7oDpF/EQer7P9a3jneSIV+eQwNuFV7NtOBaBlXAr6Sx2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=VwglqFwm; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="VwglqFwm"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-917a9f42283so47969536d6.0
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791394588; x=1791999388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhgCXPltKa4ugKSRt7TE6+dyJRKxsCYuMAHN+j14pAQ=;
        b=VwglqFwmTqSFngVk+qRbOBNF0DRsJPUEVp/3Yn615xomdKHFJJiqziPd3CJVjhAs03
         k1aXZDhOTIv46SxSO+1YaDdfseFcLFeCPtLyQCMDUlyMMgFOu5mqTSwKVlhOpxDeaUSK
         okwDQhMk9CIvLeAGtIKT6oy0kg48PUnptobw71R5tWjsJeDfVdzRK8Ghj8QNcTg2n/PZ
         lUvStgujOlpIhiv+k8HlphYRGk3f0Xsc6xR54yKvlzEFfrsWtUJJGzPJu4jfVBuNUHOr
         1hnTR2WEoyEZoej4KhshFAwZ4tCm3S8yp1b1jQOXPQ5w69FCBr2lBGmpR95WtdepPSb3
         EnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394588; x=1791999388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lhgCXPltKa4ugKSRt7TE6+dyJRKxsCYuMAHN+j14pAQ=;
        b=whzPD+kWZeevLfaHMlSNXQq9rHzMSMIGwtaTtWvTKM1HEQxRftxM8kCBnc5gmLAMnl
         REISHmy5PIAH7XCA9gBqQQ+pvZcW43IUI7eV/2fCHl/OFuIE6N/HHJo3SWKq+nPHJa0S
         niBxmAB6q0LCxNHvXFig6u/0j0NtPhIyAht8GzLocq3G7St5VIon023F3fvqkp7bOIJC
         XHck/icXnjkF55ZsiqP2JZJzABHDLOT9rzh6MWEHtUlpVwQolaiF1fFCXdthjtq6cnfV
         Yy9jGaK5rrtTXi09No04dvrPDLlKh5MkeyY8TJyV7w1okQbsriBsaQTrOZcHIkOmYeW0
         EbsQ==
X-Forwarded-Encrypted: i=1; AKwUvBysFj52jkzfyVSYRlv4pJ/Rf8lmzh1EHBvzIB0RIxPe3mUkq9IKToDz1VV5wZM28M9kp7c=@vger.kernel.org
X-Gm-Message-State: AFuF++nD+arYRmX+K//Fhow2UgE7VeOkM2GPZn4XZHSM+hG2BJXHmgbY
	MtzE4qebB2lXGFfuqLNpU2Nr3dnijQ1c1MtNY5GirHSTPhvnPcxIf3aJLgP1wBFLKuSZNmIuBPI
	LjiTxQI8=
X-Gm-Gg: AYBFou04tZmE48mQoVkY/arAT15S6jDR3Us8FDx9Lh7SeSb/fqd6DDAIhDkZzgNmw1v
	pK6om+QdKA4aHjItU38ygD4MLSu7ahR9gW9LLM6KvA0JDQ2TNtam5qPeb6ijiv4qj11inbslw7L
	NyR68r2URPnn0+kfmIAKymy3fq6l0XwtMqgTP+EybDMp4cZzi/RmhY+h6oO00qwtGE8hGOabpLW
	19ntd7IqeC7GBEnkeBcLB+cKwKnuw5deTJHYQD83rNGDQxSkmwoGYQKcIDUldjjODXIfo9duJNO
	EwMzBhoaRmEsneKxDtTLQy1s9uQLYPgRE6MuVfKPnAalNv1zoR6G50d3e/e/qy9vsyEMwlT0+kn
	qYE4vQQmNNG0k8FHAnldlUSvpIPmAT2fBLM7eGBvtDjugI5ZTTuwI+UStwCl+CNxk8qmUH6hIPF
	1Bi0vwosN2emi7kuMV1/xlN6qbel516JeaXc7JUyLffOLUxdfmrJRdJwMq23tmzodCU9omEWWku
	lNc1eZ0i+dXDww=
X-Received: by 2002:a05:6214:29cd:b0:917:70d7:980d with SMTP id 6a1803df08f44-919978a2b9cmr54768766d6.42.1791394588468;
        Wed, 07 Oct 2026 10:36:28 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996d55534sm24883916d6.35.2026.10.07.10.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:36:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:36:06 +0000
Subject: [PATCH net-next v2 7/8] net: skbuff: don't BUG() on a missing
 head_frag in skb_zerocopy()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-skbuff-bug-on-v2-7-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791394570; l=1048;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=KbWyKGSxjhF5GejC0AxphlWLzf470Pn66p11+I61qxQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFtUcSnkhBjEUw8XnUzw4gXlovZPDbuxbbpSLWy7vpytOS4USmgR+A1/4ZSStagI1sQaqZeQzzt
 +rMkHZGEDZgQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_zerocopy() BUG()s if @from has no head_frag and the caller passed
hlen == 0, meaning the caller didn't ask for the head to be copied and
the head can't be referenced as a page either.  The check runs before
anything is touched, and skb_zerocopy() already documents -EFAULT for
bad skb geometry.  Return that, with a DEBUG_NET_WARN_ON_ONCE() for
debug kernels.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7fd2f8142cc4..629de22d98e4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3913,7 +3913,10 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	struct page *page;
 	unsigned int offset;
 
-	BUG_ON(!from->head_frag && !hlen);
+	if (unlikely(!from->head_frag && !hlen)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EFAULT;
+	}
 
 	/* dont bother with small payloads */
 	if (len <= skb_tailroom(to))

-- 
2.55.0

