Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579716;
	b=RooIWrG3T57OGJt7rrpR3AZmKAqvWQvy8p6tPKy/FfhP1oV1kKp6Tm7h6TUS5GrBN5IL
	 ZjjDJi4j0p/wiI9cYdI6og1Aaxh+lTsH/mSH9Upqe15sAY+c/VwDSl4vgrEChXoy7RgwD
	 7Jy+CR0KzjtZU8k0+yy9/jpGA13BF7wvwxXbFoXnCXZo+gHoYni3mbxQMosLsDz0Pylg+
	 jRpPqgGV7FTecik4W6j2X+iGVwuUSlWioFCA7tiiv9uN0QzGq86QY+qafocSgryOKxEGF
	 I982V8FyQI5IJt35uibR8hdkzIuqH3lmyqgFFrR269458VsEw7oHjmeFaVkvFCweH+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yZcOGFLE5Qixi6M866PvnoL3ffZc/0jJ7gWqXVYZ3og=;
	b=f8uzfzOXQAvs/c/Vfad3UAKBklxnRAfk642IRe9YZWW5iTckwzuAd6iRl71LBgLL54zc
	 RE9LVZziBYnQLdUfr8IQZ4JSrqy+MiIZa9xFywjyOrxWjW8NZZKO0Bd8x2weaOx1bAIcE
	 xsPJDiaNwwQb2HoJvYkxZJtx6awO79u4kU2XjV7K+l1Q+mnoVEcB+hKoNhw4h/T1Suyhr
	 v++5PxaQaLdq3cNnMhrmIgryOCN3qHqWFgLRXTHWMeT8v7PCnJMRvyyDeJ035Ny1VnZfi
	 byW+DrvBZyYf+SgRCDefir/Ezf/sPGfqDVOcZnpk+klrMM8tpaffLz36h9LCSFC+R7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oorZQN9n;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88461606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88461606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oorZQN9n
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f0918f9e6cso12498455ad.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579716; x=1796184516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZcOGFLE5Qixi6M866PvnoL3ffZc/0jJ7gWqXVYZ3og=;
        b=oorZQN9nNbC+2NzfMHfLoAbeoVp5m44bY2f2AV0RJjo2xgIqnfdcHxUbag9EdPL328
         bmA9thUZ4JeS0XtNVJzsvxES3wTJFuTKHBnD+BFQkewuT5r5tVOR+PDL9mtI7lmPn1xD
         AoRAzjIuw2FlU29lUNngG66swcDKxbxpdNI1/x9UDzk0erg84bZXkA8Sn8ISkD73OcMV
         72d/qKC+8le/Qnntk1BbQm+AIXGYwnuqsgkgE7r50JApZ/aald8ESEY2KpZFH9Pu35Z9
         7BH7RpGR91yYoT49chmJw8Pq6PHAudGVUbGa11PzaJqjMLSXKwnaR05RW1zdpFnj05Na
         uCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579716; x=1796184516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yZcOGFLE5Qixi6M866PvnoL3ffZc/0jJ7gWqXVYZ3og=;
        b=1N+t53AS5dDWlp7OzyF5ja81HQvioeUHXglDmg37mQV32vDdjy8XoXWMkuex2qPoPX
         QMrcTt9oM620o6ysosb0af/5udEeVUkI0lb0FlRUPibjqrfUv6VtvhfZGthjX8AFNsJa
         uiDyX7DbsR7mfYDyRngs0C1iPVxcUYIkMqVeLa+dm4O4xK1h2srpYfQh4DJ1l1pZvnBb
         FjyqCWg7Xwf+AzaxBzZJoTSaAUX5WV2MIogGx0JY19l3i3TG7ExJXRSgUyLOY40E2875
         EibtuwHoh7e3nYDaGprlxRF9VXuEQO6IZAXatgfWJ+RR0n59rOPUcmG4HBHUBe87b155
         tMIQ==
X-Gm-Message-State: APuU4Z9hc3ISU9omffcQT3nOid9gHPOe/YhTJMrRf9YfTf/qGd76mWiN
	DL8jDzI7ELYIYR6+yv/4bdalIvXCFyEfbAvsGK8/e1N3kYC9UwVQbOgsCvLFU7TT
X-Gm-Gg: AZFdTZct0RYtMh36Mcwl1BVWh/mgmb1+yJxMCYVsmdb76R+gR4vKGHqcuxbVMbjbNmT
	ygMD2YKafVHN1AT7RGCoSkZNd266QuYZQ/NRv4pEK8khUwXS8NJq4mmxNjIf2wbKuDHI3uw00F2
	Y204OQvrE1lFG6TCs7magVRcGJ7tA9U6D9tjuvt7Cg5Zla0SE+357Hg7s9+PU2B16TEwr6wnUDV
	Jcm7RpgE3fj6rp5tvtr0efIkfQrzVMmU9Le4IRZptILWKQj5Yamv9BItXtgeua3ThZ4l/hEZ1Zo
	QcQQJ5WTPe96CiLEbrzNZPVh/dIyleGmJ4DvvKNLuXzjdrsBcChYxGbQFHHGK6neUjrXYbj0y7w
	KsJv8CllfxxghyktXH3qDbL5ZHoZULNtoP1/xY8NG3eZBXqM1WyI0nwfBZ0C3kqoz9J1vVftvSg
	LjWHN3W/MI5BkdX6Mo4vWkWATEbV7nfBnlh9l4pAbljyf+n5Y/Wr1L8Q2gNz4dzcEBtsYOwxqp8
	+L85dAIIJR/WlWDhRG46dX5/YIAq98gdtcv0yH13kUT5NwHDlsHL6WRWlbB6zJHwV997HLiyixc
	nrwdMUOvlbiHuRzGSIg1zpl0tuQAIQbikMr/7Y3yvURyFqUzYF1ynoN+CPUtCt635Z1XIDZB7TZ
	/uY5XsvCWrickGrdUKjlGBEwmHJamH5sx8xOCyEQx4s0XQwnFARbCEx1/8YIGm0RgPuhqNn3F6g
	o=
X-Received: by 2002:a17:903:b0e:b0:2ef:eaa8:9b55 with SMTP id d9443c01a7336-2f03f246dd0mr145734805ad.53.1795579715843;
        Tue, 24 Nov 2026 20:08:35 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0457fd68dsm69589955ad.39.2026.11.24.20.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:08:35 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luis.gerhorst@fau.de
Subject: [PATCH bpf 2/5] bpf: Treat NOT_INIT as a pointer in __is_pointer_value()
Date: Wed, 25 Nov 2026 04:08:17 +0000
Message-ID: <20261125040820.947816-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125040820.947816-1-alexei.starovoitov@gmail.com>
References: <20261125040820.947816-1-alexei.starovoitov@gmail.com>
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

The blamed commit made __is_pointer_value() use is_pointer_regtype(),
which is false for NOT_INIT. mark_reg_invalid() can set a spilled
register to NOT_INIT, and check_stack_read_fixed_off() must not handle
such a spill like a spilled scalar.

Go back to the check for SCALAR_VALUE.

Fixes: 1f737e46ca6a ("bpf: Remove artificial limitations on pointer types eligible for spilling")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dbd9a21977fb..219173a46110 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3825,7 +3825,7 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 	if (allow_ptr_leaks)
 		return false;
 
-	return is_pointer_regtype(reg->type);
+	return reg->type != SCALAR_VALUE;
 }
 
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
-- 
2.55.0

