Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649858E2C0
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886184; cv=none; b=IaPnOJitH4DH7CjaaAVrKyeS1wbq5eFTtePPLn5wEZa3CqI5O+XyonuTA3t2N/3CDX38/QowDh7jJ0yUD2I9ubCuv4XaagJHveh2ZJcDzh+DntV8cVI3E7Zz4s148SvZ/SK67GaYHjkqHnxH+o66FbZD2yIYEZbHbWBBt8qzBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886184; c=relaxed/simple;
	bh=RsIRhU3fuzQ1FzW3NLw2k4A8bkvzZvAZm5kiGkI7VmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJ447fX+r3cteOGuRlezbeNdJSS6zB33IOTDQtYr098onwoJISarFl+UJT0wrPNuAIEG7MjcZE3PJGssDu7qbvTnEMTk3vIqdGjcLjNUp399w6Si5Vl8CVPKFVdyOlkhN82/MwhDBPF1dS5Owl3UDubmrfFjbha3jErdJ/z6UBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqMwo6Q4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqMwo6Q4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d032846c95so56319255ad.1
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886182; x=1789490982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YbtunuovUXhQ3toZibAc74QEskqK9dBj5W16bCvaNz8=;
        b=EqMwo6Q48MHpxr7Hip3RmxStWI4TQrnSdj7RQ+9dCXr8WI+VV3qHvxuuqv5saQcYcz
         WvNPYNiGvBe/JcxJvkulPJGcIgjjp5vgqDvrrzXl2serkM9ihOg40T/2SdtstnwTLNLP
         AdMvPzVhlT157bngqN+f/LRCIT3+06kNw1yv3kAfoQct5dLTH62JvmuPC+627FaRLUba
         yuw9BNWBG8tMlZsa31iaqWuOwopJo4Ums9OHXz2VN9NqiZL9FQpiBR5eyGJSnL3oKVdQ
         ToSYhdBDPdcYME9D1Af/2fYD9otbXGtzQWC8M6eauPRiYrmONh1nJY/dZj8/Os4u49Xk
         ZoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886182; x=1789490982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YbtunuovUXhQ3toZibAc74QEskqK9dBj5W16bCvaNz8=;
        b=A3vFssAVdtliTdK/M1s6ExsJoa7F277xXmx5A3O9TuiiHBtapCWCxxEXtgim6m54Uy
         8p9Z9qqaeTQPFm6mafPf3J3i5idXETwHmMOwt4oXhJpH20y0K5b3AZLBTBixYeUyH5zz
         lfEWXgGriZZowX+NvNzEoHPsGYL/MIoxOcJHqwJoKOeBdUT3kxgiNPdJjPwh6pt8jzHg
         VbDTxzpIzx8/0bK2l0whhIj+0tsftivrd+hNIwbfDj0MDhWlT+jvgb8rndAwHPs6D1eF
         LzNCwlJVhoXIFvuafTXTybSd9s7so0XVpNTocAz6Qu+/dQIS6cFfw0B0/bEkrumEm2bB
         SXMg==
X-Gm-Message-State: AFuF++kOhuxhM6OQ1XML9ba9gMA/HOIy5KT07+ZNY5GUIvo/5//puqcw
	FwXCSyv5IUj86vHmlfXMCLDovMtQbIi1F5lRRaLu2Sj/QnUwiRhtmXT1U18rToBBycA7Ew==
X-Gm-Gg: AYBFou10YLm1a9AsYzXw8QVm4fNDEzFEi8tKyKKgdvbnzayALhWq7hTehb25ovYvHHq
	O5NfhZ34OjP5SKlmCbWMA6VYpolPuh3Sol7GaiiH/8gCd0gFfChLfX2QD+e1ddj4MDb/wNc6SMD
	bGZ59gUxadQJL6xjAl1NkTs8FJ1XDE2Vr+++/n57MFIwRDGW8I2m8nAMd8srZ2JnqyIia7N6Llo
	4xV5WvGmCThunXWhJsvLYdav8zd4a4oGryxx1t0o/6sXpxh0+2quo70GxMc+9ZhGyUrzLHD+LG+
	hrO5fHXd+3PIesRKHY6R+4Y8K/SLqAy5CEOtMxS7oD65r8/vPIrSxFTHvH4sgpMNDG9BUOOtWNc
	rAb5Vcz/8yQssG1HJMVHjBvrBExHEnMnsib9l4Vncfb1iY24u1TrfYQPJtFR7axCEMtbu17iasQ
	18mxh3F+6r9dRGCzGidbN6CqFwdyuMd+aQDoK0/bQ6I8318WTED3dCwsVQ4rhG6QZrp7VmZd/Bm
	gNNC1LfhX6sZOGoF/blBIxmJP8=
X-Received: by 2002:a17:903:200e:b0:2d9:43f6:59f0 with SMTP id d9443c01a7336-2db1267bc27mr294382775ad.22.1788886181700;
        Tue, 08 Sep 2026 09:49:41 -0700 (PDT)
Received: from HKG-A3-RJYWAR2VC4M5B7A1.. ([140.245.43.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db146b9691sm61354295ad.0.2026.09.08.09.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:49:41 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: Mingpei CAO <caomingpei@gmail.com>,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	alan.maguire@oracle.com
Subject: [PATCH bpf v2 1/2] libbpf: Fix array comparison in BTF dedup
Date: Tue,  8 Sep 2026 16:49:19 +0000
Message-ID: <20260908164920.108074-2-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908164920.108074-1-caomingpei@gmail.com>
References: <20260908164920.108074-1-caomingpei@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_dedup_identical_types() reads both array descriptors from t1,
skipping comparisons of their referenced types. This can incorrectly
merge distinct structs and corrupt CO-RE relocation metadata.

Read the second descriptor from t2.

Fixes: 62e23f183839 ("libbpf: Improve BTF dedup handling of "identical" BTF types")
Closes: https://lore.kernel.org/bpf/CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyWD4xmz3PuBycw@mail.gmail.com/
Assisted-by: LLM
Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8417de92d028..41cc3140925f 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4827,7 +4827,7 @@ static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1, __u32 id2,
 			return false;
 
 		a1 = btf_array(t1);
-		a2 = btf_array(t1);
+		a2 = btf_array(t2);
 
 		if (a1->index_type != a2->index_type &&
 		    !btf_dedup_identical_types(d, a1->index_type, a2->index_type, depth - 1))
-- 
2.43.0

