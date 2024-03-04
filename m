Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40B7CF32
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592750; cv=none; b=hY3CrFB6dKnDIhyvKjwj/Lj4ZYuxZ3T2WMdDT4rFGzHF0PtnYyqY089j8+MuEyOEtk8hLfWRyWVlsU4KDhq5f2kRiOxZ+wFcRStz2wtfSql2P7b95RCTIbyumceyCg8NffTsNcdN3gvK82cq5ilT7ajuW3u90P7I73jEhUfpAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592750; c=relaxed/simple;
	bh=AYRFrFsme20cwtwcfp7bMqH+JFxsSxvqP14s1SLy364=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdJhThITDb4Kye2dJMLsmDhKzcsE7Owy6Jl6Pp45b8btk8Cnpj+p2okZqUtSEqp0JHgCOLuU9f3gR+T8PW6GhldLWVdzsnnlozmtqOxynJOq02gFWuJvEvCXIffiWhssyGOccCiaChoKZqDBDWByLc20nQj/gnJT6amGFOwpBoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpTqgob4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpTqgob4"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so852634866b.2
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592747; x=1710197547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUKVRagEjVbWTLTtfvO897pmVhBdhZlyN2rymNdpliI=;
        b=JpTqgob4ckRtOGPOYCnLuOqbLFQZ9UI48/ASPdxUXz04z2wROvhBIl3/sO5j2vRvoe
         xy9WZ2qnlBHzzQvwZABnV1HVBtCCS1v0C4sqMOeMnruLT+JWq3xQzwzNBFFGW7N9YDl6
         wsjDIvJD3nK9MoUzZZEk2h13hiy+OYGUXpLkPt05ae6WrHs8VyNJBDqi72UQa6rgTs9Y
         cCWILteAVqQG/ubi78scWmBnhnF617DmG1aAVJF81/NsUSbyHqnaY5AFzdIjirKPtF+S
         2vlQvETapdqilO364gCDQJSK7tN+LCvwdgZq6beGYbGIkXgp9vGEWuDyZ0x3X/Wkm05T
         TQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592747; x=1710197547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUKVRagEjVbWTLTtfvO897pmVhBdhZlyN2rymNdpliI=;
        b=aRK6e696l317/1++guT/aNtTH1+8B2e3JLh10QhnRdTyPwtiKfNOosdCHd+BQdnlIN
         l95keixHBNlvk55pmB2xZi2gVQy821+3cFmYDx6s8ko1nE0NCbX+Hro3sJXfTK5ywEUQ
         AxbjfiivtfZ/C3y4FOP2a+o2oy33fn44VrWjm2DFVX9VPst8emCD0tM1R3YkoomId1F4
         3/OSLfp2Jpk/jDT8obvgb18pReqNC4HmMo98bPeIOjHh0dL4nqNLZdAIp8eq4N9y+Ykp
         Kx2CQ+a5yRXe5g6VpxyPU/kfzrWxsMRJ2Po2LfhHwBNabshZgkkOemqVhb05SBIgBcC1
         7CTQ==
X-Gm-Message-State: AOJu0YzQmQ73qY0CbdZdLyCYrLEQDhDZi1GmDprrQYtfsA0iSYvfj4ot
	rL99QrxVDBX0wiIfJjNAlKAC9JE5wpJB1lg3EXMwZ3KtnC5gm/cC69LMpeqQ
X-Google-Smtp-Source: AGHT+IFGroyHKYBVrvjaM9mVMusS8Oiag0e7cXIIN9LyaWwEpaO71CtxoLynYeeGDr76Ptc1cKN/Lw==
X-Received: by 2002:a17:906:8411:b0:a45:817f:24fb with SMTP id n17-20020a170906841100b00a45817f24fbmr1625701ejx.10.1709592747325;
        Mon, 04 Mar 2024 14:52:27 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:26 -0800 (PST)
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
Subject: [PATCH bpf-next v3 15/15] selftests/bpf: test cases for '?' in BTF names
Date: Tue,  5 Mar 2024 00:51:56 +0200
Message-ID: <20240304225156.24765-16-eddyz87@gmail.com>
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

Three test cases to verify when '?' is allowed in BTF names:
- allowed as first character in DATASEC name;
- not allowed as non-first character in DATASEC name;
- not allowed in any position in non-DATASEC names.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 46 ++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 816145bcb647..88c71e3924b9 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3535,6 +3535,49 @@ static struct btf_raw_test raw_tests[] = {
 	.value_type_id = 1,
 	.max_entries = 1,
 },
+{
+	.descr = "datasec: name '?.foo' is ok",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* VAR x */                                     /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
+		BTF_VAR_STATIC,
+		/* DATASEC ?.data */                            /* [3] */
+		BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0x\0?.foo"),
+},
+{
+	.descr = "datasec: name '.?foo' is not ok",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* VAR x */                                     /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
+		BTF_VAR_STATIC,
+		/* DATASEC ?.data */                            /* [3] */
+		BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0x\0.?foo"),
+	.err_str = "Invalid name",
+	.btf_load_err = true,
+},
+{
+	.descr = "type name '?foo' is not ok",
+	.raw_types = {
+		/* union ?foo; */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FWD, 1, 0), 0), /* [1] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0?foo"),
+	.err_str = "Invalid name",
+	.btf_load_err = true,
+},
 
 {
 	.descr = "float test #1, well-formed",
@@ -4363,6 +4406,9 @@ static void do_test_raw(unsigned int test_num)
 	if (err || btf_fd < 0)
 		goto done;
 
+	if (!test->map_type)
+		goto done;
+
 	opts.btf_fd = btf_fd;
 	opts.btf_key_type_id = test->key_type_id;
 	opts.btf_value_type_id = test->value_type_id;
-- 
2.43.0

