Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D032BF22
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323232; cv=none; b=XkgwtIqeqxOZpI7y9o6uVxNRQoBORpsMIcjGyCd5942LmdSwVKquq+/cCXAMuNwaeQA0dw5HIsY3wFCnCIri9/g1fNqklOJHSezm1cg4JOVjIa8HARqQCR3a9Siwds6nLZPVqSa+BOdyTRCciQMkxYhxFtbuNNi0nMgMMpi1vnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323232; c=relaxed/simple;
	bh=CT00W335s6rG2aLFSNwmtzthPBpvyvpB46lWynG/9nI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mCD75gXCXD2oTpgGxO9krxypNgJASlVNjzsx9cnzrMidBZK8gATTE5mp6fURVgRWHQGpwhadunQoszgwS0w4tM3j0MVJ5Ko+PrpyqANC8JDtERsvHM0RCYWbprB+e0I64sYxO1BhkRtEEceai1jWo841CnURhstSPJlSXURUNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4K3BZJm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4K3BZJm"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so14715105e9.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 12:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323230; x=1770928030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHVFCl+WGeWE3Ed31YuQDFxlS+tKO5+cr1Pf3HGxk2M=;
        b=c4K3BZJm3z2aXp4tOVJzvnCnZLtp0BJUsYVIDqsGHUnNALK5XyLc6E4LkdIDfMI21a
         CJ304beMLNRU/drG4t1fN0KaHWcwOTj+yOqZ0mC6e8KraI/ERRv8i5N97gzoi9022ivs
         D5Nwpk6et1/Zo0VkPYtXsn7BL8XnmjidRzbeeoOiPV8G3jICz9EMImwllV7FjiIS8Ta4
         w5Aun9K4s+gjyUZcr4IQipBN6pUScX8Ri4nbzaW1zh9SVDKS4QpgadRWQNM3sQYAKelg
         sZyz/j5wngm6lqEv2VjBtXPopGZlIg+vQhFTyPf8hnVrfZnXtr23pq687mgPHQ03JDtO
         fXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323230; x=1770928030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oHVFCl+WGeWE3Ed31YuQDFxlS+tKO5+cr1Pf3HGxk2M=;
        b=HWywq8IJYWSdlc+bVnKX6bZWaLHZFB3olxZOw2wODXZ55f6WnBXJqcsKU1N9Hqd1xF
         BVNvxtvaC3Jj9n/3JxSLuyJjcLVG67vPrTvclO7cLXR0A2xd+OOBx+3fkSkB2/tu9K1X
         RmrRmuHWRj5DrDNoAkZrw2me82diSYbzg5IUP0EcFPIK0E6OmpqC6yAPqmzdxAqJOlBV
         gKDjhX2WOwWJzuQDGFv4IxtOwK64LlVXlsBJcW3CCWMutBvfR1zL3A3UnDzb/yPXljUz
         3/iuIgG/CWC8QxllR4rCfY6Cq+OyftNIf3cPkCIdkWWdQ1ukeb2OenF2SU5ne+uL/kh7
         IlVQ==
X-Gm-Message-State: AOJu0YxtYrihmNniCJfwzyfKdMoDozCg3nsd0dtfmNr/0K3ZvOso+Gk2
	Gbwz4FoYWott+SzrnmWpvYX1ElAs+efdpPcHCmYcMqcV0Znc8hJgJcT/
X-Gm-Gg: AZuq6aL8ExdvZCilR1kqDMpTmMq0u6SY/reM/QNc7cJ9Oob/pblLBFhPe9+7Z85jfMW
	VrJ18zqdjjHyYvebC6cudDOirPzOebtQy9bkY7xeGH1yP9m8d8JTIFAENTBGyUnW3bE/mFqmiGO
	YNdt4U1SVVWQnqhT1f5es1PicPjmg9IjzYSv3t/roEagYgyT1Z7K4Jk/YUClurEzRRQeR413uR/
	7Aq1DH1oSulAmvOwzPQ+gbpj3JPnzozmh4ibeafDQ2RE7svlT1KZ+atOExZm14ZrHxHIWVPRCyV
	IdDpW8KnnJmztctMixW1EjkaKO1GQQBO4mpcy4DWhyiSEs/xRvGp63N+v7jg6g4wgXXv5W/Zzbv
	avzaPC7xVw3THVJwLALfbyevXFFSFN09y3/2nD8GcAViWqOCpa14MCcwZLRtwxfSCAXeNvPI=
X-Received: by 2002:a05:600c:4450:b0:480:699c:abe9 with SMTP id 5b1f17b1804b1-483203398a7mr8211455e9.37.1770323230381;
        Thu, 05 Feb 2026 12:27:10 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:1325])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974b176sm812648f8f.37.2026.02.05.12.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:27:10 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 05 Feb 2026 20:24:34 +0000
Subject: [PATCH RFC bpf-next 04/12] bpf: Reject resizable hash map in
 tracing progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rhash-v1-4-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, memxor@gmail.com, 
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770323224; l=986;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=xaatO9hrmP9y4+E8bYwK/Eb+KdWqaOYZ+35bj8IY5tc=;
 b=6d6NOnHFmvtPibpotdXySUu80l/uwCxFOMxmmRkwALblg8cSAgkGsMMEz67VY0PHsCHHbJk7o
 H370pC1/y9VCdaCxIEnm/FJ19xVZCpVI0Rg1hKF36OnozX1cFLhVauL
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Resizable hash map uses spin lock per bucket, which makes it not
possible to use in NMI or IRQ contexts. Reject in verifier.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0803dca3d93f9e912824aa89951cb5b65e961af9..a5560ce436fc75237536b17fa845b9f7a278de30 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21544,6 +21544,13 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		}
 	}
 
+	if (map->map_type == BPF_MAP_TYPE_RHASH) {
+		if (is_tracing_prog_type(prog_type)) {
+			verbose(env, "tracing progs cannot use resizable hash maps yet\n");
+			return -EINVAL;
+		}
+	}
+
 	if ((bpf_prog_is_offloaded(prog->aux) || bpf_map_is_offloaded(map)) &&
 	    !bpf_offload_prog_map_match(prog, map)) {
 		verbose(env, "offload device mismatch between prog and map\n");

-- 
2.53.0

