Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D9047DFBD
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655807; cv=none; b=QMVrnNrDIsLvH6Rk2zdgcPcMxMvLoti5rCBJa2toBh3Rs6GAsmu/egrkox1GThv1vfrSDDDBhjoMG9bXtSKhHLc3rzKGIKgTvMmwAtjg5G9/ZfvE1d0K23zMQJ83kwAT0Iys7BdMOMogNBnwl08AZCIBVU83GfhDEdP860nLhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655807; c=relaxed/simple;
	bh=w45m0VNF5Uf8+j350TYz8zJo1MuxvnK/HCXDK5CiZ08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6kwNo3mqBt6eQLAp+7tGH16Hn5p+5ju6pTQ5Vz3ZJvU8ldQxlBdeJXpMTWhlLvtZdCbb81f5kFprqrvHKBkC5kCYug+rlVbQ5a4SvUa+sNSwzkszIt5j6F25ZlDpIOtW0oNqr1j9ei3SOPJZ5IgwwNl2VCOsAa5W2fChtwzP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDtz+rmE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDtz+rmE"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so338304a91.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786655797; x=1787260597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ww3gNAYbZCYlPca0Huv8ZGVtJX4fMyNTAxRFW4a4o4Y=;
        b=VDtz+rmEOpzG/ePJF1GBz7h18arWZh6+PbzB9R7mPAfiMa+lZkuRkADMoza2c8pEpi
         bbDvjT0Vd67ALjcryxo+WVxye5HpCADsFDb7loVyE4lVKkw/dplqixrb9kyzQIEGje62
         YIa8TWS/lJs1PuzPfmsBIJmnpiQ6ottS2VOZYWHq0LgG+1ZVtpu+7yFBw1T2GG54kP9Q
         uEuZdE/Mr8UKojfQDmdhcpSeSQz8bsPmY0fbLTEE8+tvaboIeH7vk90HqzLkD46V9EH5
         qMpEGt+9uW2FinSCin1zLFbG4DWYf9IGL0+Czz/vjFsAjBr+mDfSGLC5k+KlfBZBmfd9
         IJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786655797; x=1787260597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ww3gNAYbZCYlPca0Huv8ZGVtJX4fMyNTAxRFW4a4o4Y=;
        b=hW9rGDaOAAHmaTdcB8O6wNj+sA4Do9W32qQZFaC0JpTWZpokfyduB4pA9/xkIDeVXe
         O6rXhH+hoSKP2gt/KuxJRg3Mekv8kfPpKmpMy0oM5xiSi2uzE8yIKtwRBv4T1PuqeX5X
         MkxIMrZuBYC34+xRUM6pW0OB+Lrk1u0VbKcu6AYSFNvbaWPlBWRw75SW1n/WXetVSA9R
         RECTFhYpbqbDKqyti3le8FA5MJQp5ZIt60X7d3Q4DSbkOyn9hpkRMhqgGBSsk9dnMI0j
         aEH9T4WY8BiSMk/7is9gaJ1wASwmwggtEnWdKn38Rce3lW2OLsCvYFZCBX2iot/mTqUy
         Nj2w==
X-Gm-Message-State: AOJu0YyvVVukpdL3MdsN8WscJ/3syflThIMbkxCQHnEkP7UaG41bbiA/
	bKJLEzm64gowHtm2VQzqKHdZO/ppmsS5WKtPcJk+2wWyA7rODo1yrQfNs++gxg==
X-Gm-Gg: AR+sD13WoobLA48NeQfEjuvDQ9GJbs0mcRKKgS8hwmMY3ZZiggxZqkVIP65G3eksXHm
	Wirw53cb1hYA0gFDBxj9WFZnQOUq9TniCyipuOzNm3FDUkTkEyCK+Q8M4JNK9IELETEi+fU+uNy
	jqEN4/D5F59/Q/0zN1H88UXFiCEJQS06h7h+wNEEvYemjfEyi1wC+az7P+k0xB1SIm0EZrPk2hP
	cyVIlKBTBL/fNMS8rDu6V7mKc+P0OuS5dMWUZumD36GFhFB3zgDJOHVVnvfakP7S6ZkEKdKnO7D
	4faH0mS8KpNV+5eDE7rEcJ/2UVylOqFrJOAVC/xAEGfiGUJ5Ta2Kijehrt7EWPg9yZreNo4Tai8
	xXXQUPuZyJh+bJgZZKf8gfFQV4fBoGd02AdBvtSqL7WgU7trQMVEal/G5aJ1A4P1NbSoET3STRf
	ODbku1K5j0mwLOfcSjef2mRj9lU4YzqzK9bwZdJBpWSU8NPoVBxXQMzmGx9IcQZOz9NDAlIxxtz
	9NX9Y7BM5iZGQWrFvZoYeLXpJc=
X-Received: by 2002:a17:90b:2f0d:b0:38e:7268:220d with SMTP id 98e67ed59e1d1-3933ed5e238mr829987a91.20.1786655797150;
        Thu, 13 Aug 2026 14:16:37 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933a03e288sm853985a91.17.2026.08.13.14.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 14:16:36 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	greg@kroah.com,
	dingning04@gmail.com,
	sashiko-bot@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 3/4] bpf: Reject untrusted allocated-object pointers
Date: Thu, 13 Aug 2026 14:15:25 -0700
Message-ID: <20260813211533.290256-4-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813211533.290256-1-dingning04@gmail.com>
References: <20260813211533.290256-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

type_is_ptr_alloc_obj() currently treats PTR_UNTRUSTED pointers as valid
allocated objects. This allows a pointer that is no longer protected by
RCU to be passed to bpf_refcount_acquire(). If the object was freed and
its address reused, the verifier may acquire a reference through stale
memory.

Make type_is_ptr_alloc_obj() reject PTR_UNTRUSTED. Add
type_is_untrusted_ptr_alloc_obj() for the read path, where these pointers
are still allowed for BPF_PROBE_MEM reads. This keeps checks strict
without breaking safe reads.

Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/20260726021304.97ED91F000E9@smtp.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 include/linux/bpf_verifier.h | 11 ++++++++++-
 kernel/bpf/verifier.c        |  8 +++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 27b43fda9b17..22fcd01c3cce 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1341,7 +1341,16 @@ static inline bool bpf_type_has_unsafe_modifiers(u32 type)
 
 static inline bool type_is_ptr_alloc_obj(u32 type)
 {
-	return base_type(type) == PTR_TO_BTF_ID && type_flag(type) & MEM_ALLOC;
+	return base_type(type) == PTR_TO_BTF_ID &&
+	       type_flag(type) & MEM_ALLOC &&
+	       !(type_flag(type) & PTR_UNTRUSTED);
+}
+
+static inline bool type_is_untrusted_ptr_alloc_obj(u32 type)
+{
+	return base_type(type) == PTR_TO_BTF_ID &&
+	       type_flag(type) & MEM_ALLOC &&
+	       type_flag(type) & PTR_UNTRUSTED;
 }
 
 static inline bool type_is_non_owning_ref(u32 type)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bc021c8c8fbf..c3a11c98cd45 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5820,7 +5820,13 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 			return -EACCES;
 		}
 
-		if (type_is_alloc(reg->type) && !type_is_non_owning_ref(reg->type) &&
+		/*
+		 * Skip this referenced-ID sanity check for untrusted allocated objects;
+		 * the access check above already rejects writes through them.
+		 */
+		if (type_is_alloc(reg->type) &&
+		    !type_is_untrusted_ptr_alloc_obj(reg->type) &&
+		    !type_is_non_owning_ref(reg->type) &&
 		    !(reg->type & MEM_RCU) && !reg_is_referenced(env, reg)) {
 			verifier_bug(env, "allocated object must have a referenced id");
 			return -EFAULT;
-- 
2.43.0

