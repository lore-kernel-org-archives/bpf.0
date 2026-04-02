Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE813C6A46
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122184; cv=none; b=S9OWsmC6+45UQFHMmR9LsUXN8HM9ZeTVV7slPtw1CzSZ5Ku4/jKlffL5qT2ocrljvkDoXQ55bghPKHZUIGYI5sZ2qsBfqFOOnZV2l+NcwdQejd8eO7YrbHxGkqUITAvh1DoypLqI2DcmcF3IGZAdsmdV9KwDigbhXHm5vPOprnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122184; c=relaxed/simple;
	bh=NQzJPPXCt5+UeT86cvf6VlSRMqEM0TkHz6efew6EHko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heZJE8WwwmBDJomM99kFPB0rFs4gDo5uBfgRIvTRJ3XAugd7RC5lYkVuEm2Cwh7lpOsa4b5Ag65pwZT+pbCYPjGxOo88VPe/3VUESnEocDzSozfXW8cZ6TgBkt51ClFbsgm9oIWuum14EDINTAy1/jC2pY5EMhAuM5tS3mvffsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxVKXOKr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxVKXOKr"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35c2fe0d90fso369753a91.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775122175; x=1775726975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLWT9ixBBvOqZjXhNxDMhtNXbVNBa82sg5oxSobPvYg=;
        b=hxVKXOKrQ6alGVkuY1jxV4SzPaMhPSy8WW9fFiiiXKdvxLVu6GnavDcK49wFcvERN1
         Wfman6YR3pEInpT8kz8xu8T0xBaLenuKQLpwXqIpMRhUn52/nXLmf6PGxA06vVbOhz5g
         Dthu5effQWN62E8rSaASzaX0SKnX0iNuSMNmsBgeB/tzBVnwKIAkGqrVHG0/VbULIc98
         N8fP9bFigTzhSi7DFqnIYm6hb7p04XaQXSgTLM2fZYDnZAQkeEO3eK8cef+gc8f5EsZW
         Uqtj6wbHkl6ZXajsDdgzT1hg4k4Q8adiKMCmjiIcauavJC/6Yt3m3glWSa73ChJvW1nU
         eHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775122175; x=1775726975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pLWT9ixBBvOqZjXhNxDMhtNXbVNBa82sg5oxSobPvYg=;
        b=kHvU1llTQqKAUM1r9qmgWaGfVGgj1wqe0nnFQYzPnN2EKFGfSQTDi6do95xLnFhrth
         CKQWhroGyDGKTvoUaQ8tJox5WIf6PAxvGW2kDJyKV2i7LbEQzEABTXPdz/Y1xLzdUWfr
         mL1vlLnKdtOMTwx8kY0foWbjkxrB2GEuIX/mgThb1NbmfIeKBKVsA9faNiMVmDmM3xCe
         nmOutOIyKvOwZe2riHSetqnQQ8jQ40/hU0eC30BbueGxylrUMA5eTWhnqclS73nYLewU
         EGD/NzMNsDLQ6DpCb5M7ag4FEMESQ+7K20N1OI/u7L1/+TLJLKBcR3dECSJNj80fU5ve
         UIDA==
X-Forwarded-Encrypted: i=1; AJvYcCVRJ7koPg5mltFpW9M78d9KWsTdjROlZPpst/SfMy0POijezdHD687YO/LV4mp7hjuENmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNW3cN2UwkuL7ksKuCC2uxap7SotP+Fz7HQE5YdDphZTZ44MKG
	WDg6pJ9SdYoE7hmaLgGk8okKfqfkmSjNnTUGSDGsmk1klhJi0l1kV9pF
X-Gm-Gg: AeBDiesAX0Qij3hcNwkgm85PdNflVmlsYUjqg6OGBgV5kuX5G/X/b1owIX3kRVljwUG
	lkLJs2CitbUjlpCm2YTxZDW/rNerJV5IhqzlbmU2jlPRBsv66RRJKJBIRLLoP+FbzsaGJ2oIpOC
	YZ6RVNoXX8FzDl0DO87ZIzRRaSQNsrZHe7r9LJY2dv+HyXL+H5vuEfY2nEH5AYGUinOc8nLaQk1
	0MliRktFrBudrBXvSMuIw9DsnWMyOPZQyN1TdYmA8ZdFpoe5DbQSQUvWkQK+gcaXJj0c+OF1NnA
	yotZWgTqxQ0v0juGUEp09T+9cZu1HvdblI8IwhzVJPnNWH/VaDA5JkXz/SRTrQ1quZdPuQClm5W
	b95p4dvrTeTDTmOixmkdC8d2OiE1NVA4EiUfsanpueehKGgBAmE+txiBMkQ+bpe5A4KpHGYD0db
	782EAwLNUF4qjWqRIjwLH3bcKWStFyAcfXVCg=
X-Received: by 2002:a17:90b:3811:b0:35d:982d:96c7 with SMTP id 98e67ed59e1d1-35dd40f5c91mr2486378a91.27.1775122174834;
        Thu, 02 Apr 2026 02:29:34 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cada2sm21176705ad.71.2026.04.02.02.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:29:34 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH bpf v3 1/2] bpf: reject direct access to nullable PTR_TO_BUF pointers
Date: Thu,  2 Apr 2026 17:29:22 +0800
Message-ID: <20260402092923.38357-2-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402092923.38357-1-tpluszz77@gmail.com>
References: <20260402092923.38357-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_mem_access() matches PTR_TO_BUF via base_type() which strips
PTR_MAYBE_NULL, allowing direct dereference without a null check.

Map iterator ctx->key and ctx->value are PTR_TO_BUF | PTR_MAYBE_NULL.
On stop callbacks these are NULL, causing a kernel NULL dereference.

Add a type_may_be_null() guard to the PTR_TO_BUF branch, matching the
existing PTR_TO_BTF_ID pattern.

Fixes: 20b2aff4bc15 ("bpf: Introduce MEM_RDONLY flag")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 937c9adf1b3d..17850836943b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7905,7 +7905,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	} else if (reg->type == CONST_PTR_TO_MAP) {
 		err = check_ptr_to_map_access(env, regs, regno, off, size, t,
 					      value_regno);
-	} else if (base_type(reg->type) == PTR_TO_BUF) {
+	} else if (base_type(reg->type) == PTR_TO_BUF &&
+		   !type_may_be_null(reg->type)) {
 		bool rdonly_mem = type_is_rdonly_mem(reg->type);
 		u32 *max_access;
 
-- 
2.43.0

