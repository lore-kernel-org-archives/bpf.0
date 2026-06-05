Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCD64C043E
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659697; cv=none; b=FLK2i/8Jr+ytcczYiobI7guZw0giGb84R9OxUUWkkVu1HCMLAvDZ4XnvTfX9Tw+TSa0lc1+RCCc/x1I/+sbmknYpftfbwV3J506z0Pq0j8xwHxobbmbxjOc4ANL3d+YPnr3XBHzqHLlYzoBXeuA4FkkvF30+kFMuRm4rV+RCjF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659697; c=relaxed/simple;
	bh=Cp1WB/m3rtO8azVoSOiNSQMMCKcEmawFdBQoOt0JcsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xr7vj1pQ1Hgv9Vb5uviRcZlsSnwaBerLJwfVrsqC8080LsKmazp9d5dShkihK3Xoi8h9fZFsIq1odOPTOl9daCndIRG71gMWq4wURnhXbnohldymezdCCZXHuJ1C2NsHFF/pab4tWGVZur4SBW+M0B9fBjJc2q9vG9J31YkHBU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUruteU2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUruteU2"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45efa80e0afso1444843f8f.2
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780659695; x=1781264495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRN2g7a7YrR9qzCZY++uS6qrHgIUV/qnTiRaQk38Pow=;
        b=QUruteU2ALW7abbDZ3/CAta/mDaAzAl6efBPWE56+GcoB86dMa23w8lMSKNaDe9XCZ
         H9o3iAHEMH1AickTN4rynDTkShg1QLeNiaHbg5ff37c52hVuHbz8v2z6r4i/z5SSg8Lz
         gwrsHC1YTttIWzMCrH/7QTIt2RWjRL92zXtJ6F5dRaWu4sgxYLDey8I594aFSFl1kODq
         +hsL0TloxQMPwRFd+KRyxthna5HUh2dbn3AghwCIArnNjPBeIMtT6xmF9eUwiTaUmWkI
         6Em3YZe/ImXY0H3rxi0jpxbdFlTc+4tWDCLiog90YIoyicplEzEo6ek+w4cig2P6ODM9
         5r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780659695; x=1781264495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rRN2g7a7YrR9qzCZY++uS6qrHgIUV/qnTiRaQk38Pow=;
        b=VsTYsTgDyDbpJdiSwgqTz6NHhYuxW58fZucSRZJu3rtsBjA5WoYvKtIHTa4Djz6QJl
         u8DFjdX4gqAbuEjeVHTzpuqO7CGMNBQnlAyOaY9SWDtXcPfLeB1qR42OJ81bonR184E+
         My8hSpiN8S3gOElxbjrJurQxGa9DLwC6jWzXsG3TRsS18E5zk0TGjIp7Pt/JFelTFKVz
         ++cL+PepF4/tg43arLXYZdIXJahKbPetzdbUlZEU3JFjFqrtfECz3G+YNMPRqOggSlaY
         GcJCvYJWjYv23bpmkc0yLkw6MzFTudX/2i+TBPCmE1811T6OmgFz0Bj0nTPv+RAhSt5z
         EEaA==
X-Gm-Message-State: AOJu0YzO9GzXQQVL6vnBPUKZjddEj58s+OdYoWOTtLOgw5VAku5kVzll
	bSTJ6aeTRwsGX5K7ErcMtiF6+G4AGpU302sJKdadjaOHWNw3051Wc8R5
X-Gm-Gg: Acq92OFeYDKgdPskBah8W83wB2cd0xiVgC1RTd7k+vF3l6hfoTTc6W5sRHvjyi29ULm
	sME4O+AdWyGBHBnjQQcnEuZakHWNG23NJRQcTTE/NNsn+gm23CIgQJyRbSldUM6Sl9sDHUS0sUN
	NgOnjzXNmkXQ65b9ZcTMPZnqjZc44XW2461D3gFi98X4FPTiOC7FeaQ1Umg5GMMF+wp675UPN8Y
	DiYpGL7GqJ95OdKCHZaoF9jATZiKvu+cI7/qvCbUhzFqvZiNZNAfYmfg+WbJIH1cWhnu+tGFVRY
	8EySYNUF5+3DhufoYU8BMdl7xIT9p+up9jyxfkv9Y7ERckJVLzmt/jfSV8Ni4zeDa2ZmqgidfcE
	AJdqty3iWNa2pMxQNr0q4QysPWfzSHWHbGcdHXhMO6edGVPy4RF+r0/X67wfRnYO76BX7LF0W7y
	N4xHS9Uxl+FY0TurM4F+vQ4W7w
X-Received: by 2002:a05:6000:54f:b0:45e:b21e:f840 with SMTP id ffacd0b85a97d-460304ec0e8mr4278193f8f.8.1780659694859;
        Fri, 05 Jun 2026 04:41:34 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344541sm23223348f8f.22.2026.06.05.04.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:41:34 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 05 Jun 2026 04:41:20 -0700
Subject: [PATCH bpf-next v7 03/12] rhashtable: Use irq work for shrinking
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rhash-v7-3-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
In-Reply-To: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780659688; l=775;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=igvaX2ukdxhhiY3exjIqK+nNSfrfMcS8PdUXLmY7X9Y=;
 b=tzgepmEQLj0myScIX/6zi/GGSzlbdyc1X71NNCw+fpo/lnfk3/XYJwAvS00OWn96jbh551w7F
 HHJ3vzdHsvwD4aulsmw6kTYS/d84JUfJbIZExoxQn/mGLZUzn37+is8
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Herbert Xu <herbert@gondor.apana.org.au>

Use irq work for automatic shrinking so that this may be called in NMI
context.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/rhashtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 6f3aea498515..3de3412d53c8 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -1157,7 +1157,7 @@ static __always_inline int __rhashtable_remove_fast_one(
 		atomic_dec(&ht->nelems);
 		if (unlikely(ht->p.automatic_shrinking &&
 			     rht_shrink_below_30(ht, tbl)))
-			schedule_work(&ht->run_work);
+			irq_work_queue(&ht->run_irq_work);
 		err = 0;
 	}
 

-- 
2.53.0-Meta

