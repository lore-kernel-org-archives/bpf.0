Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577518;
	b=SzfkLsXlHC3Xr1mMAAvEnBsheuls8/0EG1lKXU/FTpfP9K9Sk1jOHAqVekKrZILKlLKl
	 68giqCZVrNX87+x+MQaRB49qPZNx31ZVqG0+a8doA+mWukrzLba4RvDKIlER2vMYZSkUk
	 EG/VbZinuKcr0o27pPfNxxUZv/QinOBgPe3g9LAjm7r0sjD4U8ifm9s2eWIfCjpqNSa3I
	 XQWt57pIL3B9gB5ONa/FNeOzhzeg65TJO228MjouRAHsHwPm8jU7IhTqBXtnuWSguCMqy
	 PmOSWVjvP0dyOUFitcsQ9nWALwjuiJMh+DxFXFl5zBFOEDX/Z9CDcgkfRGcQnFCQDPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D/nIbaLZOloWCvlYKuDBCu1mU8K2mXyxVYKfcv9rTwQ=;
	b=jdu8N4qGItTSkH1hAJJR7JWyDK8OpSOBEzZJtn19z7U7O98Mn9gUa0hBAj/X3/WXzegj
	 HB/q6jlrzKcIgLipqYWa1WG4qOGZwIT48VQsE2Vo6NVHW+SlDRC2HdofmsSyOtfJGKSJj
	 swjueZB1nkjQFyK496Ie4ZAFo73iapSmXMlprHtvinrQCoyiaPErRv9l0M5jHyDnlXwO3
	 C0xfsonKNoaSw1sYBBbUAV8Hi1ZOWJC/NH4lLPSik9uyK5cU/i7CvW9quzWByLlfZJ6y8
	 mqOuSxJZJiqd/r6DNLMjS0fTQVEEs0r4jvnDUp32IScPT6yme1Nbzk/tPDExSgD+vsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tE3eP36V;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC99606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FC99606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tE3eP36V
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso2067039b3a.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577518; x=1796182318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D/nIbaLZOloWCvlYKuDBCu1mU8K2mXyxVYKfcv9rTwQ=;
        b=tE3eP36VD+69MaECg8/pyWsOWAMoLMItzSbIWvHO4khefl0V3elU2TfYuV5bDt2zAI
         JeizgDVGT45rmtYWOUrHIEkjAJNqBnc2ycAVfZDzJrtbtR1Hkt7gfqpwvWqT8TyeY4bK
         2P47PSzoEcO81h+6NDZfaDqGbZMf+lavlIwMW2+YX2HPNsifmF018m5MgFwBC9dxWRGm
         GeWk7u8xFmkrsleQ592USxAeTizDgPqF8SHFuqmTlYCh328Zt5pRqWwR8/NpHWnFINZO
         SmgzdhYZC/xk6GxPlHSTY1Cr50dhDA/qfllXZII/3vfQb0l5U/TpfsdAUNVYPEJo2TRC
         xhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577518; x=1796182318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D/nIbaLZOloWCvlYKuDBCu1mU8K2mXyxVYKfcv9rTwQ=;
        b=1kFOBU0qVmn+xvTkscvTywgWEZKA8l6HNIwjZXs3K6Ws/WpD1E01zw6/ZPTIxgJSFG
         pYmTvrUuudj8AUHY5lCHoXdb9S4CXAu5Bx2qqDdm2hkVKszEq2uF0h2jUWRqEZl5xTNC
         tHZjzmTFojJ5R+Nq1Edf9TNaYlNJY82V8sKOGRFOnXY5oeOsekh8Z66Tbv0SmGkh3MRx
         RIwarYhJMFw5tHlR13oTsCl8uSWIsWXnTz3XTsOTSL3crULoM6DQsptNe/83wPvYpLrK
         3IbwzQE7QUZ5VrwMsIyVq9m8TDt/O1KNTBqu2uOhS4BDmYrVxSYMXgjXPsPyxB7T0xHa
         FYVA==
X-Gm-Message-State: APuU4Z98womqxVUyMRRPhS+5BonR3js7JZXDlcOrwY2YWVz0JflKQWWQ
	QPaU28nRcK3x/DRN6knEMGw0fHJP4srtkbVAOOV3/Gj2a1Zwutt4Ocxw5wz4ZeQa
X-Gm-Gg: AZFdTZekWk/lLyfyfDLPQlvSmXysZL74oJBN2Qe24XWsM+EXt+UqQujon/balSIJAl7
	OZCFdP2pkqy8bv8wWdn/msRMz/1PrjhCkryKWnBeRiKZ1J2j6gaK7rGypBtbEFRdALpjKR4GFAT
	yCqiWTUqImVWVLQNNb5wc/Y0bTiLj+CfobWxpx4RwZqrRmLfJXuMa0ZoUgqpN5iEPLva1VugRKs
	GSJ8aqmt/bQ4gLmwK4Fo4NBCXUGLLyfTceq3eSXrAtlfNNG+IMdva2A6VnG8iH4bzapSzoEFp5n
	Ocb28Zk0aJ5+xbuXCAzFwQiit/ZU8Tilm7rf5qbGVXnAfwWZN7yNnf/Y/Z2P7PKlMHsn1I4R+IT
	eeQZBfxT+ijqL+Hf0LL8YSCnqcjuKsgypB+r2U6NzAgKCUYpqa3QKuxBZ2c9m5x8T8IYO9EXRp4
	FHyfKAX/vv48V107zWrgQbjeccnq5jry2V0cM4NHI9gA4LPPd2pXap8JC6lD6I5nKSLw6hQw48h
	WEC1VbmfPEolI15psGJjCdgfgA8SVe2RWfQ4yef2o2qfTlMY98cegKMfVCboKSwfjaQGwpSlYs+
	RJVXBdrwwPacwcpssol0aSXCEg23+EANP3J5VKevHVrqT1a0ghYM3ExeVF9fuDA+zg4al/1Fi/5
	J2h6xrJNATpL0sKaUTc782XZ58185kShuZ8OiZDqGzo7+9FK838JkAp9VJ8jHLhgNsdGAvHC6J2
	0=
X-Received: by 2002:a05:6a20:a10e:b0:3fb:2d3e:e602 with SMTP id adf61e73a8af0-4014db57a6bmr17829867637.33.1795577517833;
        Tue, 24 Nov 2026 19:31:57 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c86d821637sm8235719b3a.0.2026.11.24.19.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:31:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 23/47] bpf: Fix reads past an enum in prints of BTF data
Date: Wed, 25 Nov 2026 03:29:14 +0000
Message-ID: <20261125032938.670542-24-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

An enum has 1, 2, 4 or 8 bytes. It's read as int, enum64 as u64,
whatever the size is. The file of a map in bpffs shows what is behind
a key or a value that ends with a short enum.

Read as many bytes as the type has. The check of a member of a struct
with bitfields takes any enum for 4 bytes, so an enum of 8 bytes can
stick out of it. Use the size there too.

Short enums are printed by their names. BTF with an enum that sticks
out of its struct is refused, compilers don't make it.

Fixes: 9eea98497951 ("bpf: fix BTF verification of enums")
Fixes: 6089fb325cf7 ("bpf: Add btf enum64 support")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8c934aa8ad60..7b3291556e6e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4579,7 +4579,7 @@ static int btf_enum_check_kflag_member(struct btf_verifier_env *env,
 			return -EINVAL;
 		}
 
-		nr_bits = int_bitsize;
+		nr_bits = member_type->size * BITS_PER_BYTE;
 	} else if (nr_bits > int_bitsize) {
 		btf_verifier_log_member(env, struct_type, member,
 					"Invalid member bitfield_size");
@@ -4662,12 +4662,30 @@ static void btf_enum_log(struct btf_verifier_env *env,
 	btf_verifier_log(env, "size=%u vlen=%u", t->size, btf_type_vlen(t));
 }
 
+static s64 btf_enum_read(const struct btf_type *t, const void *data)
+{
+	bool sign = btf_type_kflag(t);
+
+	switch (t->size) {
+	case 1:
+		return sign ? *(s8 *)data : *(u8 *)data;
+	case 2:
+		return sign ? *(s16 *)data : *(u16 *)data;
+	case 4:
+		return sign ? (s64)*(s32 *)data : *(u32 *)data;
+	default:
+		return *(s64 *)data;
+	}
+}
+
 static void btf_enum_show(const struct btf *btf, const struct btf_type *t,
 			  u32 type_id, void *data, u8 bits_offset,
 			  struct btf_show *show)
 {
 	const struct btf_enum *enums = btf_type_enum(t);
 	u32 i, nr_enums = btf_type_vlen(t);
+	/* Old compilers don't set the flag for negative values */
+	u32 mask = t->size < 4 ? BIT(t->size * BITS_PER_BYTE) - 1 : U32_MAX;
 	void *safe_data;
 	int v;
 
@@ -4675,10 +4693,10 @@ static void btf_enum_show(const struct btf *btf, const struct btf_type *t,
 	if (!safe_data)
 		return;
 
-	v = *(int *)safe_data;
+	v = btf_enum_read(t, safe_data);
 
 	for (i = 0; i < nr_enums; i++) {
-		if (v != enums[i].val)
+		if ((v ^ enums[i].val) & mask)
 			continue;
 
 		btf_show_type_value(show, "%s",
@@ -4778,7 +4796,7 @@ static void btf_enum64_show(const struct btf *btf, const struct btf_type *t,
 	if (!safe_data)
 		return;
 
-	v = *(u64 *)safe_data;
+	v = btf_enum_read(t, safe_data);
 
 	for (i = 0; i < nr_enums; i++) {
 		if (v != btf_enum64_value(enums + i))
-- 
2.55.0

