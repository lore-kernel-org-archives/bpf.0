Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328165;
	b=UBnsCbA0vcxqZm4HCHH9mgBzcbo3QhtnOgt5W+8oi+J3KPBXcWlTrIKt3NNgA/0kFmG/
	 kG+pd4+Inr0bvfFcUN7qPv3BlneiNYbkE1Rzy++83nDnJk0hdL0+mTJjs+3dhx01Hd932
	 b5i9jo8cNl6PqlgvSu6Nx9rTnkUkaV7bgueUlxeFHMUj1shEtp+vQQn4ejO9hMZvEBmW3
	 SXSdhY076qlFh8VS8nDFxsDCn0NRuc6yZNGyn777ItRUHQhkLfivJ4Lt6RgvF/jk/Rpro
	 58IkMiPDD9285NzLithOVvT5HPBLRHOnPsGVOpF4/Gx5+hC7eu4wF0FbahF9bY456EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DLsTnaW3uXr9AC/QbRfpXuwiBDpvXM/nxSHrEfIP3lc=;
	b=l6LxmLWWEdKXSjWl8oe2gXQjowl6T2AErdLLNCjek7TOsTwwbNZ4w60kmy5cxtcKpWF7
	 EbiCX+8cve1hmhnw0OnukjDq/kX9nLWme3Q7raOsucQSIrEr3lSHU6wUKCowdU1UJd+Y0
	 5f4eb2YgIuhDTKGFlC12eiOlcl1dsmFbAcBELTGt51fRV2p7f79vEgiCTK7+CqCmTml+J
	 DJXWKq/kgxwlrXc4mJs3A9odjyp8vPSp0s78lYhxXLwpO2LUxk8lxlTCw2qQW9eQZPu+C
	 9KC2l7J4qlymmfR/xjXI7xEpEh+dgT/GM6Ba9o2QWPOV+pyS7olCz4dpUeAwgZe/k6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vZ1RReU+;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB2606A335
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 16:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FFB2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vZ1RReU+
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so23657415e9.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328163; x=1794932963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DLsTnaW3uXr9AC/QbRfpXuwiBDpvXM/nxSHrEfIP3lc=;
        b=vZ1RReU+7oUC/2FVAIkerBd9DuaXp0BA8s+XGa4zggwl50JQDETD+PipCAaWdCw0VO
         Am1mOIOa+zlEUvGLPFtUoD7MBJph9LFhog3NJlUfCnf70GkgDacTqNYrDGIEXW6Q0NS8
         QLCayZijcVItUK/6VVJuZS+wiZ9eU7d93b8/ER/kDjZK5c38Vz1RruWu4BDvdhX2Ux6s
         FzTX193Qr07gQoGI/QLlorYuLYW2btDvgElTBByQCTQXP5Y4dLjDGQ5oSlzwUE1PeJlw
         z7uGzptU8YpfeXanWgR8sRiTmq7s22fqCO9GwfFomxrridjp5AFv4QrOKZxLn8UwNN/t
         7XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328163; x=1794932963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DLsTnaW3uXr9AC/QbRfpXuwiBDpvXM/nxSHrEfIP3lc=;
        b=Q8rAQkfqXp7XsVb3yZH0hbVBnaoaxJt8a5CJuuz6UNoMHhRjZzkGdDw3nXxxej5lvk
         g4YG30IuPKe33M+lvkGaA69Vtz4qk60cu/737gqVtdQAO5BFPTlccRCc4pHWTFRS7cyK
         SwJPkQ6hJvezFiyU6XGCnFZYM5WkxtSlqSjV5e2od7YEGXPtr1kg99tFLjl8/dw7RE1y
         8C4ZNgczwx4+HOlya4dK6CCelFejUquUZM7TI6XBF7Y34cKHwAuft5VdYBIFmtovqkyx
         ZAvbGFzyPhb/aheXnGerg5E9BGiwfqvcvi1YMS0T+WCO+DX56oXa4mQ1CKSZNG5h4qSH
         gN3w==
X-Forwarded-Encrypted: i=1; AL+hErHUFi9galY1gdODdzUIVc8TgZHdZd4sMMMInd9kGyXKN2e0l4+V3afB6xHDUhhmDZHrEFU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8E3BNvOZ2LsUzyPVz16FNLGbiZXmVV8n/1OlJ/XqsghewZGEDX
	H1l6CjTnxa3ua2Ui9vUfRWR9OtgyrGfWbatkXomXhr3Wy4Dm+DvtYXai
X-Gm-Gg: AYBFou2l9sCqVFXBQld+M1qPMivdaLzy4dRLVlzkKTm2gOvNfnHQEOaAWsSWfRLFBAV
	9J3lINIU73UJgcuWXCN5442RPp4ovppv8gX16eW/DX4j8M9ZdGrdMzJ/cKHxpCjmYF/8/FrqltI
	CQg9l/5OzLgX0PapcZiFlGzUGUFDNltzGFF6MpfJYl/Jgyvkm9voDmk6O4ZPEg5YQ1QKGettdwU
	2+RwKyYDivTLeh64ca+3hbq4cNynAGNW0DLSSeF835g/xMHlaDvNWTHlARBl3zQzC4xAExd0POA
	MUScYVaDt0ggS0ne+OoF/uo3AvrOUM+VkJ9tB5iA5wDLg+kWCl5M32jCyqyU3tfDNC/IAH0902+
	oDYp0XNtAhBJdrlD7UB0pNdNMvMH6eDvZhgVVeUFcwxLDrsoOY94jOvFtG6oLYdZIO/Zssi8HKI
	2BX0Z/I37jmmlA5oaF/pLWCo5NEHCmN6TWkDnUB94bf3O90megibgvTb8Iq/gruiQvVNwFJZFlK
	NYY2ifK2T3zfIC1DvastZsT0eCO2EBTSyDI5d6YFP1E4WjBPmH+6X//i8ENIGXte3GwQutBnyaQ
	CZR74/4QECF/JXiL5vXWF3ATamZlUqTtbbKYJqHE8IGeJKs=
X-Received: by 2002:a05:600c:6306:b0:4af:c210:5b3f with SMTP id 5b1f17b1804b1-4ba0234eddcmr57289025e9.24.1794328162866;
        Tue, 10 Nov 2026 08:29:22 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea745sm71287485e9.10.2026.11.10.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:29:21 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v3 bpf-next 02/18] bpf: Add a btf_id_set8_entry helper
Date: Tue, 10 Nov 2026 16:40:22 +0000
Message-ID: <20261110164046.454431-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110164046.454431-1-a.s.protopopov@gmail.com>
References: <20261110164046.454431-1-a.s.protopopov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pairs of a struct btf_id_set8 have an anonymous type, and the
btf_id_set8_contains() helper returns a void pointer to the pair it
finds. All its users but one only check if a set contains an ID. The
one which needs the flags, btf_kfunc_id_set_contains(), finds them as
the word next to the ID.

Name the type struct btf_id_set8_pair, and add a btf_id_set8_entry()
helper which returns a pointer to it. Make btf_id_set8_contains()
return bool, like btf_id_set_contains() does, and use the new helper
in btf_kfunc_id_set_contains().

The layout of the set doesn't change. Update the tools copy of
btf_ids.h as well. A later patch uses the new helper to set the flags
of a pair.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/btf.h           |  8 +++++++-
 include/linux/btf_ids.h       | 10 ++++++----
 kernel/bpf/btf.c              |  9 ++++-----
 tools/include/linux/btf_ids.h | 10 ++++++----
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 87fad4076f0e..00495e7833b6 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -558,11 +558,17 @@ static inline bool btf_id_set_contains(const struct btf_id_set *set, u32 id)
 	return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
 }
 
-static inline void *btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
+static inline struct btf_id_set8_pair *
+btf_id_set8_entry(const struct btf_id_set8 *set, u32 id)
 {
 	return bsearch(&id, set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func);
 }
 
+static inline bool btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
+{
+	return btf_id_set8_entry(set, id) != NULL;
+}
+
 bool btf_param_match_suffix(const struct btf *btf,
 			    const struct btf_param *arg,
 			    const char *suffix);
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index f27b7db81100..f5985acf661b 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -19,13 +19,15 @@ struct btf_id_set {
  */
 #define BTF_SET8_FMODRET	(1 << 1)
 
+struct btf_id_set8_pair {
+	u32 id;
+	u32 flags;
+};
+
 struct btf_id_set8 {
 	u32 cnt;
 	u32 flags;
-	struct {
-		u32 id;
-		u32 flags;
-	} pairs[];
+	struct btf_id_set8_pair pairs[];
 };
 
 #ifdef CONFIG_DEBUG_INFO_BTF
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 228b93d4f8c9..61d2df6776a9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9973,8 +9973,8 @@ static u32 *btf_kfunc_id_set_contains(const struct btf *btf,
 				      enum btf_kfunc_hook hook,
 				      u32 kfunc_btf_id)
 {
+	struct btf_id_set8_pair *pair;
 	struct btf_id_set8 *set;
-	u32 *id;
 
 	if (hook >= BTF_KFUNC_HOOK_MAX)
 		return NULL;
@@ -9983,11 +9983,10 @@ static u32 *btf_kfunc_id_set_contains(const struct btf *btf,
 	set = btf->kfunc_set_tab->sets[hook];
 	if (!set)
 		return NULL;
-	id = btf_id_set8_contains(set, kfunc_btf_id);
-	if (!id)
+	pair = btf_id_set8_entry(set, kfunc_btf_id);
+	if (!pair)
 		return NULL;
-	/* The flags for BTF ID are located next to it */
-	return id + 1;
+	return &pair->flags;
 }
 
 static bool __btf_kfunc_is_allowed(const struct btf *btf,
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index b371ef7241b9..3b5b2856c628 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -19,13 +19,15 @@ struct btf_id_set {
  */
 #define BTF_SET8_FMODRET	(1 << 1)
 
+struct btf_id_set8_pair {
+	u32 id;
+	u32 flags;
+};
+
 struct btf_id_set8 {
 	u32 cnt;
 	u32 flags;
-	struct {
-		u32 id;
-		u32 flags;
-	} pairs[];
+	struct btf_id_set8_pair pairs[];
 };
 
 #ifdef CONFIG_DEBUG_INFO_BTF
-- 
2.43.0

