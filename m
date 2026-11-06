Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998324;
	b=i35dgp0bGceS0sl/hGovzb+QTzmdiQiV9Jd5W1p3kTO2OjJH3/DWaJCx9bmnUGjejlK8
	 i2u7ByZlQ9jWtgUaUC5p6qTVTcGwNqbWY9cTCCqKvzbaNJ2B3xF0GV7mR7tAWgTSKgnt4
	 7ScLPKewgi/dSehJRGhv9t7gAK1J51S8AGf0SxJPWkQkl6YxJiCrh/6YtNBosckEB8eEK
	 sUAgpjw9I4wjXxQyeG1yNdujTO1NUm8nW5raYAloEiR5dCdeSNxl6jJ+fr3HsB38mejbO
	 O4JR2d9OBFq+uZCZNd7/Q9zNFe4Fv40W1mXFS/jooCBn8UOJuuhN2TNWhkeH+7ICabg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DLsTnaW3uXr9AC/QbRfpXuwiBDpvXM/nxSHrEfIP3lc=;
	b=KIRepvlJAE/r1oPu66n4wh8mE8AGTq2p+AYVmyQb29L5EpciIvSA+n9RTDJkxRYSTFSC
	 YS3Amk6d3Yoy36egBG1RUZRDOiycm3+bDLIbm9NfERc6LL4FhQB5/J4JXcPvp6WrxtfDz
	 diYezhGENAOrD/XN43M6NQV5BGBArEEdlqkMity2BU24QucDtFWhVCIQBXMENH7I8mAS1
	 L1EeutD5T/kBt6myNiqb4OpPhlH37TVdDMjpRdkR5u1MfQrCqvR82m+hUjWMBwVrf4WTD
	 DZksQCDjp+tQJH+ESxSBRhO0Ht+wwB4T97BPhRCPDQrXmAp+hMbymJYoW3v68rNADrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kZ/9YEQt";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2000606A331
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2000606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kZ/9YEQt
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so5938535e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793998322; x=1794603122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DLsTnaW3uXr9AC/QbRfpXuwiBDpvXM/nxSHrEfIP3lc=;
        b=kZ/9YEQt4LVDNfEOtC4RNvmA0TLiM7u1IFT/0BagujDUjsQtFTBVkcELr0nhfdxZAo
         2KbVMmDXeCuLOerWMXrDPbb/2zUzFvcvZiqj2OemKq5Ni8+DbPUnyJLVWLrKI9VjTRc4
         f+pTzfPBOA9GXoCdC0G1nnS8mqGbpXGDkxGKfEK5vkIiiYoEFqbEozVwfSy97VWZhayt
         WHRCcV44L5bOoE4Zr47y77Mdxw6rMl0lenLHTnUscKhv6ir4qyDV8KTpECIMfxmKOr4x
         Mb5MZniXHu2reTtPd8NGl1Gy1FBEw+tOX1KaQeWwL3FzZY4rU6Z8ykH+i1+nFbG5rc7s
         xB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998322; x=1794603122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DLsTnaW3uXr9AC/QbRfpXuwiBDpvXM/nxSHrEfIP3lc=;
        b=K1yTUPX4ZiCmwYRIjwMKBJl4tWpVJS9SNVgTsWl098ioyMqHTxCkcRbR35qzQBWMd9
         Y7hPi/ga0pkat3/m8q7/O8Gf8/SmoTeglFCRWsWsEVvbhuZKJDw/ohwGXHCMLFHjhfQR
         Kb142596R9hCaAaGrQ9RxJeUu2sbazR+IpkIW9ce0K3zn2xLwO6QQOnVaev01VU9uFkK
         aJlluaxxSsQ+pa4jLWe+Gdqh20tbIknw47eZ89hX+Aht0/qVA49Mjluqk4sV9O6UbE7L
         32xQilvD5Zs6duA5+uDN/EKLc/Yy9WY9pvlH0nNj/yMQafqoEaRMR309CxKg4K5PSdpd
         LCJw==
X-Forwarded-Encrypted: i=1; AKwUvBy3kjItDvAxo9EInxzCQwAL9AXih8Zeenjv8uTVrQRPZ59tXQnwOJUBFbMoQDlMJemGbjc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DjJJMsK5HqMBvm95fK59jpj2ntVyaFRN+H9ik+KdFtNPzhWX7
	q9fq9AUe+QpykzRf7i8+raQw6T/SPCoOh/v/Rw9XXr4/wYpnJiMyJx3Y
X-Gm-Gg: AYBFou1luAqVZ+BokDleyEkqJrXDCcO17NllZVUb7+5sIj5N4iMJl3LcC8h0T95OXPU
	HTTeGtu0tp3c2voZTzM3a8ONFfS0xw/ZuMeeVaX56GjXdWRUpgySQXnfRrAFWx2rUDmMXAfEmpr
	nj5egCkgEqazSn7OIMoad55pZQUgyRdN34l2A5MhuXF4KZJqdqr89D7NjuZsbGaqEwwaaiO1M+M
	zR6T65Fmj6Pcy36ExBJXPnD6F2cF7nq6lUIFj/eXtHaJdUzZUzhffrOHecgjulAbqQmORDCRl+A
	7spF8uhFa3PV0gge+gM30c8W7SMq4yb2yy5i0CsItDdkRc0Nj85qsGzEscVnXqianj95EY9+dEZ
	/J6jM1tKmg79KLG3F5e+YdwyfVpkPCwIpMIriWyRl+KAinj2WaOX5th6pmUoF828b0NHBGhEwg4
	Y1GBpJk8at4i4Mg80SvntKmKHhBaB1+BybplA50u7vcL4YVI7Ugr45/rqbT9h1fr2i5yywm5Yu2
	JgiAQ8u+dYK+PRRE1y/ycPyr5MkaRrR1XDmIpPYg5oVQvTIq6bpbNprrYsFooKG1TWII96psFFi
	3tXbueyx7SQnESzucu6uJdaEjFyBZrThO+Pnd3wQQ5gxbR4=
X-Received: by 2002:a05:600c:3e8f:b0:4a5:87b3:ddc1 with SMTP id 5b1f17b1804b1-4b6de4a6ba1mr60373025e9.13.1793998322031;
        Fri, 06 Nov 2026 12:52:02 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm9075425e9.1.2026.11.06.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:52:01 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 02/18] bpf: Add a btf_id_set8_entry helper
Date: Fri,  6 Nov 2026 21:02:51 +0000
Message-ID: <20261106210314.1767267-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20261106205523.1765622-1-a.s.protopopov@gmail.com
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
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

