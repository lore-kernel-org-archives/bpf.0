Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8772560893
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721959; cv=none; b=jBjK3wxrhbTzF2+pmbmZ3VDMG4ynIApYpyfYoX9B/OgAODz5DI1U71O6LzkUKsAfEXVOlX+JEV16Msy/Jdf7yfZyFTJj8iJlXIa1e2/mpCH4gr6luZMbx/OMfnXBU4dT2p4y0lJScerIkl0d+XY9lh9U7JoBXsab48+9Ru+MoFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721959; c=relaxed/simple;
	bh=c626uGZGz6bvkWSfIGAs2RDjqVJ0je76+hAvK5HHS2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+DLhznQowsIVzl0dTS9ux6aOwZdqZFnwiywRSS9I1FYVzzce/cGWqoloTzjaTJmJJosD3RMxEEJU11pT3Y0ouywoDSzMAsa7QM/Ssl6tPXZW2uqbWqD7m0wbBsIuQu8/eRK1i+QnvFt5ZulMr3twdQDtJUoe1etyDu03nOUfzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=couvARLh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="couvARLh"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so1254578a12.1
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721956; x=1710326756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzOUaWEMM76cWVANb2OxVF5f/AqcuB1wbqQNTxjWF78=;
        b=couvARLhQgH4jfg5nrb7ho6pCvqaU7/c6p3ikE8hnkgK13EzPV6k1REYvlBK129il6
         A+zwWOWTLgZhcYtGADNjRsTwg1P+ChZUta0WPn1cLnBF7c7ROI/fxIK+uy8kUpiqnSwi
         UHoKhGccTQgMW5J4BVGZT9hH38XSPBJCdeOfpD0L3R7nCNWMSzICspgAGixT0Iz9/BTN
         xvvfQLLpkucyuouDwiTbjXB/KkSrNOq1kmujCW+taENOx3r8adwO3uTqpLyRepCX7FjW
         2xizIyTjzHg24Sl4DLiYoeHRrVjAxYszcYGJGiSFYqYhSL5RMzk5T08CbJlH9wd2MlRz
         aljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721956; x=1710326756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzOUaWEMM76cWVANb2OxVF5f/AqcuB1wbqQNTxjWF78=;
        b=g6ED5n06l68ldcPLUs9Aum/K89Ww0Ch6i2y6VU2uRh8mJOPwfOKYRtRqY46K+3PQG6
         IxSuoY9Bro3QmvzuIKxilRn3IyX8kdj4Otw2MyHYlqnwHTr9h3HFVnabA8C6kb69J8h3
         xbb55tT81dI4++e24zdNZxVf97y0Fknb5LaPY+XjwmojtfVEqc39nY+1YJFok/FhQbsM
         c9bICPrJ4X4xG2CMtdqaIZGEz3yTXVJn5DWI3iNyT8ZxwW5lVBj8B+V5Z63jVe9Ji7Jp
         9wHevl3iQkF5bVSnVU+IsqZPJBFOyhYtqAi43+NK2N2+26FYC3dSEXB+3HZKDXV/eGM1
         IisQ==
X-Gm-Message-State: AOJu0Yxypi2sC4XJw5od5Vfg6gwawvGAEsxHMiKD04pvcUmpVUW+s5jn
	WXIHXpSIcN7KXVJ1VmmdoMr/C7VhC4iHY87wUU/XAxtBlQWWllj8zdU2hKQy
X-Google-Smtp-Source: AGHT+IF8mFF9vKid5Auy4JklvLlGMlW7SPTJbEzRGbCJoKOMNX4oLz/caOOMXIvLkhFjG+QqmW3TOQ==
X-Received: by 2002:a17:906:793:b0:a43:75ad:6d56 with SMTP id l19-20020a170906079300b00a4375ad6d56mr5995575ejc.18.1709721955869;
        Wed, 06 Mar 2024 02:45:55 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:55 -0800 (PST)
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
Subject: [PATCH bpf-next v4 14/15] bpf: allow all printable characters in BTF DATASEC names
Date: Wed,  6 Mar 2024 12:45:28 +0200
Message-ID: <20240306104529.6453-15-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306104529.6453-1-eddyz87@gmail.com>
References: <20240306104529.6453-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 kernel/bpf/btf.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6ff0bd1a91d5..170d017e8e4a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -809,9 +809,23 @@ static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
 	return __btf_name_valid(btf, offset);
 }
 
+/* Allow any printable character in DATASEC names */
 static bool btf_name_valid_section(const struct btf *btf, u32 offset)
 {
-	return __btf_name_valid(btf, offset);
+	/* offset must be valid */
+	const char *src = btf_str_by_offset(btf, offset);
+	const char *src_limit;
+
+	/* set a limit on identifier length */
+	src_limit = src + KSYM_NAME_LEN;
+	src++;
+	while (*src && src < src_limit) {
+		if (!isprint(*src))
+			return false;
+		src++;
+	}
+
+	return !*src;
 }
 
 static const char *__btf_name_by_offset(const struct btf *btf, u32 offset)
-- 
2.43.0

