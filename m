Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3213E7174
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756342; cv=none; b=CWw4Gb5CawWI1ONSU63XDnOLy3IwBk/I0OGdB6s1VKJeE17HOQkzlZJAj7wJNtepaSi8TscfH5c3hFZa7lnrG27yb+P4Xww+YPkf4J7HILOftnl1OUYKL1Ndriz7sOPB183a63E4uXF+YzJQtfYd7DQ8tjSO+z4Z7S8ArMCdqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756342; c=relaxed/simple;
	bh=Sv49XeCz+zvRsKncftIKHLkr4SWJDrNLElmC9AiNb6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMtKDGlVemfzSn0UbhixV6Aum0+saiLAhZHWhMsV2GUmlW/aoU6ClJgvRfMegp4cUotArzK1I9S5rHDvqgxb1lQ+L4T/nIIosyoUyOzoDnGuTQ8IfR9u3kEtSa7SdXhjoDAE+vZ6mMSzCOP6waFIL9k5Xsz219mTx5wtQeNRvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYBNDD59; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYBNDD59"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cee9b74ee1so24746485ad.3
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 04:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785756340; x=1786361140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8dm8iv1zOENNE2/4OPaqxGyIJkWC3+aS57l3uyF+i70=;
        b=UYBNDD59RB0/ZMKLGrbAoa8X927gIhnznrGMDSJQvehxOexQQrm43S55D4doc/HQDx
         7ZFAFDQ9iK9q5FAPvjIO+IGO3JuiUHs89+PH350XdcAiHlSB3Q1waWDK5iMuD4PrTbKc
         rLHXZ9v4SRjYB+c8ENTTCYKerLznLzUkd3GTdGFaH4aANxicirjDfWjlM7NpFBS+bJvQ
         5KtbqoV4dNfB3VGj2N3OtgFC1yVqRSTox9vxl1quHfRgKgFeS0oU4ZDjkCuBZ+2rBUS5
         rL7mwegTifc5DegPpSsDAqXXVH7R1E4rZaErwwTaD2JpH/ETcuyJeaYyf1QOxvS9GzBB
         wySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756340; x=1786361140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8dm8iv1zOENNE2/4OPaqxGyIJkWC3+aS57l3uyF+i70=;
        b=fDwxU94TIxbrvkKdTx/xG2eYnR/OvGHdV+SaNz0jUuWjcFsrrqv38R9IYChOLsgIat
         mP0dCzmvUW7UF2eR9xOJ6n6NBOI8auiVF6fSPUDCtBCov1QV8zTFdiM2im0hlN6TMz/3
         Rr6P5FSOVDUEV/kduWTZD9YTA78LvAUS+ficyOzZ8kHfnHsx09CXnjAs0At87B3rnp6l
         A7FXn+jVka6yYyX62NAwItjfNpBzV7iT4YwksVTuF60zeQrJw4pDvuw+fqCz/3IQ58BA
         aHqQtgiF01HhS0uDJ17jWS9G8VbETdjZrG73nDNT5RkCR+/AEvKg/xazkpPe3HRrzijH
         EIfQ==
X-Gm-Message-State: AOJu0YwwrB4vkAJcPC/b5YZeG38o8o64C54CdNa6gXhBcvWMf6oViaRi
	xWSmqy6igNk9+va8e43Av+pDRj+hbRXNJpb69QWr620l/FFCsoE7UkBNUJ9bLAmc
X-Gm-Gg: AR+sD10YRIdRfxADrEAX+iTlfRaQonrNr3l2CvsZcWFF5+J+9I5nyeUQi4NYHS9g6ut
	72lC2s6pE4GsdCwvRlGvceTKckHkN7MLPiU4Vd37TA5pehKGT1BeV9q28SsSRXfd7emNHz7AVf5
	vJgBukg8s4atcr40g7WrzxCuIs9ziy8GCQ75+p4DOGvdECeY7DkxL5k/i3M15NvU8UTXZC0fsvA
	B4yT/PIJx/dSYLIDvN5X8Hl2yhS1I/kEI+VpL+93w1Ao10OfBirLUxl5qds25TtL3N7XTISbGB7
	MP03dWfPOkkpr+8a7xNHyDpxu/tdKCGjySYMm/0QF60EZaBhHtL67h/ewQTqBJZ9cUUkzOgSmr5
	cpeuiVCsfJ+p9MugKJSuEKrDMLMOZVVGege++u6YBlcH0zNDGPw6/Q+Y5RU9f8MyroyXCmbO60y
	Q8UJlBVigoHFcBLmsmwEiE5jKiJcjMYFMgMmHgDjGAAbhLCvs2yVen//SlAjxScQESAzSmMZH6e
	xm12w3euaCddGcF
X-Received: by 2002:a17:903:2f0e:b0:2cc:fe03:dc75 with SMTP id d9443c01a7336-2d05246fd98mr93329845ad.27.1785756340137;
        Mon, 03 Aug 2026 04:25:40 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5a91asm36190685ad.21.2026.08.03.04.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:25:39 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	greg@kroah.com,
	Ning Ding <dingning04@gmail.com>,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
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
	Dave Marchevsky <davemarchevsky@fb.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 3/4] bpf: Reject untrusted allocated-object pointers
Date: Mon,  3 Aug 2026 04:22:10 -0700
Message-ID: <20260803112218.3361213-4-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803112218.3361213-1-dingning04@gmail.com>
References: <20260803112218.3361213-1-dingning04@gmail.com>
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
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 include/linux/bpf_verifier.h | 11 ++++++++++-
 kernel/bpf/verifier.c        |  8 +++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 39a851e690ec4..7014d62fe3d1c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1307,7 +1307,16 @@ static inline bool bpf_type_has_unsafe_modifiers(u32 type)
 
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
index c47328be2505e..8b35c63780798 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5809,7 +5809,13 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
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

