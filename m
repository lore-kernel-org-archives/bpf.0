Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBE67CF0B
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592749; cv=none; b=VVqOr1VqDaBO66nGjFXm0WS+Vw+saviRr9c7XDaZs/OFp0xSFZQFEQ0hB9/AOPPXKH88kKKSatP2G5ySVQoh050/Vk21yhmMsyjIR7SggTRBRvWk1Hdgntq2Kh1jFAabBeWJ/ZAPUYlqbXRbHjzU2LYowntYY2ryOv1rHfPOTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592749; c=relaxed/simple;
	bh=vY2eM0UqjsJ93XnGPnegnfX6oPS8A/CrHw+0bW+dkTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5P+hIoZZw4qydyQ/H89R+mKBlcJHGvbu39k1SQjCsSCzpUiwoblcb1ESHhS99pSt+O3Dd7Fq48j9CSve/NnJtPLSmFfBTiyRZ2szz4H1qvVOXH75oOzmgsrE7YYLvNcB6n5jClF8mVRMp/qporIgFyAx4A1kkFJloUC0vtUc3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZjxDwaO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZjxDwaO"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4515f8e13cso213941166b.3
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592746; x=1710197546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYMlnF4l/D4ErZPFlA4ND9mYkMopZNVa5Qwk1lR+k2Q=;
        b=LZjxDwaOsZ5+UHW2sU1Sk5Ir4++opuzwJljE08nm9cgzKiJzTAr8/L7mgeEHy2QNkd
         mQl4HwKXNIKd+S1vB/CCTjEwXLodcfN+784QoHgC4rdk3tZVLPN3hDdSlGjUbRhk0jyf
         e0C3tD72Im7zG/BoLmTq8NV11zjMUEIUPIKd7skP8OZAQGujI/Rch/Fivc6TDTWIoLpm
         ZnaJayD+vFdB5889gnHiYe0+BeHfmPCPeTIyx/WjeG3xJoW51Knv+vGMa2omu2DMorl/
         nifDR6AUR8nm/ltcLYfd0wZFWxhnWvm9cqMtk1LUe0YEZWWwc2Ll7UdlyTbyOU5XFJvg
         EIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592746; x=1710197546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYMlnF4l/D4ErZPFlA4ND9mYkMopZNVa5Qwk1lR+k2Q=;
        b=eMOvz5E4gcC1qV0NT8sSnAMfvf7xplRzzI5uWg4GGK60tDu3EURu1jO4SCQILcjbK/
         JDA/2AbJouLWWW7fjovXHQMrHFRY9QfEbjMUGL8K5eTieuqHF2RsMVXlDxthD+goMLCz
         7Tb9x100URnMXQHt6I6iZbMmjwAtviVKG5RgLqrp/0ChTxp7l+3n8pX+JIqmhpJamhVz
         4im1NGmd5jaViPoKTcz5XchL08/ORyQ/czoYcMdcmQ3dPwCqVjmJYB/qeDqpKAC1n+C9
         2LJw7L1zdS7h4uTE9Eg2EIH9HvVIva9QkPB7VDlWnN0f58G7r/uQSXOJucMQB32I1DCZ
         LN8g==
X-Gm-Message-State: AOJu0Yx+SdbiKZ+ktQDoe3fzciV9i2e2dEc+rbYSjEPmp0/8AJCrkr0a
	46OKvWBSLWq1TfU622ChfsQ14spakm3lCrxe9RvCeNm8D/KYSsTGI8d67hSd
X-Google-Smtp-Source: AGHT+IFy6Y0iy4gitInwjXletrvgSd4FHUeuDj35qTM+IHilt7A48ZCuixemtUKDYsT2V6DglzMUhQ==
X-Received: by 2002:a17:906:240a:b0:a44:2b1a:e257 with SMTP id z10-20020a170906240a00b00a442b1ae257mr7132256eja.55.1709592745927;
        Mon, 04 Mar 2024 14:52:25 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:25 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 14/15] bpf: allow '?' at the beginning of DATASEC names
Date: Tue,  5 Mar 2024 00:51:55 +0200
Message-ID: <20240304225156.24765-15-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304225156.24765-1-eddyz87@gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently kernel does not allow question marks in BTF names.
This commit makes an exception, allowing first character of the
DATASEC name to be a question mark.

The intent is to allow libbpf to use SEC("?.struct_ops") to identify
struct_ops maps that are optional, e.g. like in the following BPF code:

    SEC("?.struct_ops")
    struct test_ops optional_map = { ... };

Which yields the following BTF:

    ...
    [13] DATASEC '?.struct_ops' size=0 vlen=...
    ...

To load such BTF libbpf rewrites DATASEC name before load.
After this patch the rewrite won't be necessary.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/btf.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6ff0bd1a91d5..a25fb6bce808 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -761,12 +761,13 @@ static bool btf_name_offset_valid(const struct btf *btf, u32 offset)
 	return offset < btf->hdr.str_len;
 }
 
-static bool __btf_name_char_ok(char c, bool first)
+static bool __btf_name_char_ok(char c, bool first, bool allow_qmark)
 {
 	if ((first ? !isalpha(c) :
 		     !isalnum(c)) &&
 	    c != '_' &&
-	    c != '.')
+	    c != '.' &&
+	    (allow_qmark && first ? c != '?' : true))
 		return false;
 	return true;
 }
@@ -783,20 +784,20 @@ static const char *btf_str_by_offset(const struct btf *btf, u32 offset)
 	return NULL;
 }
 
-static bool __btf_name_valid(const struct btf *btf, u32 offset)
+static bool __btf_name_valid(const struct btf *btf, u32 offset, bool allow_qmark)
 {
 	/* offset must be valid */
 	const char *src = btf_str_by_offset(btf, offset);
 	const char *src_limit;
 
-	if (!__btf_name_char_ok(*src, true))
+	if (!__btf_name_char_ok(*src, true, allow_qmark))
 		return false;
 
 	/* set a limit on identifier length */
 	src_limit = src + KSYM_NAME_LEN;
 	src++;
 	while (*src && src < src_limit) {
-		if (!__btf_name_char_ok(*src, false))
+		if (!__btf_name_char_ok(*src, false, false))
 			return false;
 		src++;
 	}
@@ -806,12 +807,12 @@ static bool __btf_name_valid(const struct btf *btf, u32 offset)
 
 static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
 {
-	return __btf_name_valid(btf, offset);
+	return __btf_name_valid(btf, offset, false);
 }
 
 static bool btf_name_valid_section(const struct btf *btf, u32 offset)
 {
-	return __btf_name_valid(btf, offset);
+	return __btf_name_valid(btf, offset, true);
 }
 
 static const char *__btf_name_by_offset(const struct btf *btf, u32 offset)
@@ -4481,7 +4482,7 @@ static s32 btf_var_check_meta(struct btf_verifier_env *env,
 	}
 
 	if (!t->name_off ||
-	    !__btf_name_valid(env->btf, t->name_off)) {
+	    !btf_name_valid_identifier(env->btf, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
-- 
2.43.0

