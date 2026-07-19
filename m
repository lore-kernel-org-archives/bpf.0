Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F22377A8C
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475399; cv=none; b=JTQdVknw95EJl6MFTyqWmQypuL9G9Txbtm0gmofrgqV54ZQ/rd6WrtqNJKJ9jMaupC5pFlzHVVTJTwZzGwxCLnAOteNxmfKK+mTuYDlXb/2+iLaf+YVGGO+uE0rWtrbMJpiiZI5bmkiYJyeSM3poGe3QeKPRiL6PNzyBcu4K9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475399; c=relaxed/simple;
	bh=zm4W59MnF4hZVW0rEaOc+7kT4d9pCVgl4uPD3ArWxgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uW+AA8yLISUgskITm8SncriGmj9oGSKoZn6VLByHdsoS+5Xp3BahfXO9UPti8DleHI6Kwq3fCwT+Eqq4C70HdiRUgv399/zF9Wex9rTDS3IPkb31scrhLPPqjC5UHXIo6Q3R0p9/0uNpdePjhlvIUPU5gTUNJqHjRwgvp28YLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miVoRE2a; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miVoRE2a"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so2596115e9.0
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 08:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784475396; x=1785080196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYnXPn3avxRWnhc4k6DlD3IoIMS2AMjoBhn7q5VbJ9s=;
        b=miVoRE2aPSwUYMHy2K6JNG9+H31HG6/c8uHIGjFqvogd5M+zw3wdg8iYsxbTb2ODzW
         /6bsfQ7C2GK+Ao83gZsZGydr8wz5/2j1FqLYyHyUs+KSfWhGGNomupD/75GcykHEBTaE
         XJlUgqSghEQtQgFtQQbetrux7CYZtf18HqZZbpdFsi+BqVAnUCqG5lz68FAcKstiesG9
         UEflb5BhwkbJtfVpVeT9beyTjPPM6WTR23zDi1dwAYkmu/EfCmKyNrdZtLUib3ktaIiq
         IBYPUSqP8402pHKWxqUlDGM9sQR9bSIo75JWyGY66pd4xyWYCBQW9lmfSRx3UbMkErh0
         VKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784475396; x=1785080196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mYnXPn3avxRWnhc4k6DlD3IoIMS2AMjoBhn7q5VbJ9s=;
        b=OvI5qlEUPglhkbZBagdO2B7zrZGB9VDWF6WtNuiK4HUrxvLVr/qi2zNmBQVtlliIMX
         je7kJwgvpj6zK3viLDY88pkwyl4FJwMkfomNgOYIj79hJBzJkqcN1H4WLmHjH/Ado9nS
         2A6js0KV3EcbkK5OqA9MezdRaTcz7BvO5Zv+WJ8pS7lzRPuIXLp1V3WpO8LEERWGTI6Z
         vSn1EBa6VQbweicPM22j8UQkZl5gA33sqf8YugOqpShQSeKMQmHLPY1zZ167TQubq7bI
         dn1oHOXOhHOY+1UKM7ZqttYb0FkG3qV2NBNZO9SWz7pLL5kntx3WEKdHlFP6QCl4TXoo
         jCMg==
X-Gm-Message-State: AOJu0Yypu2qf1LMjqm+yyfkXU+OCtgms8Z0c76D7uwZ1nefcRMU7UYtf
	kKoCkLBWixqZoEny+43yRt3jbnupI5XiGRILhd5iB6PFi1dqX9J60cBXB7t+RsRq
X-Gm-Gg: AfdE7cnBSfN5RjxucvK5wPtEvj0sG620JFGyvg7Z8UpM3kQTLCfNoONs6C6XX35GOuK
	l6nTzkcN26FW07b0IhaO3FESxPInAxvXXzPNISPw2Oqf0XYwPE1K7bWEdFjGW174nNY0UPlc5c9
	rEOQFAOlh9RBerKoLZdRuvPSLIbkKecqQyw7W7tKX1DuWYdwvUQ4plx6cHJgmFSF9eJRf2AMAue
	qiNlXDSvtUiRhLsCs2nXzEERQo7amHePMCHRcu8yhcp7JPaS+9RSgaOt23o7qJRVFhCj4JyoDfI
	Zxy9wPpzQcI4zJOmshhsKBSc4DHMP0V3IWkRH1vO7WF3m2MVmaNlwWXEdN/I2G6knTtKrSv4wYv
	JU14ywCu9RlcNopIC03eDARSw0rQh4WLDogEqtlMwyqRJ5/vS6hiipItXqaAgqVt08OizVDchc9
	Iaw07nQM7LuGWiMXR36i4inAShyBYi+IN7O37oiK/u6X8HYzXfiItq/m/rj1vRgR27ibWmmDoHA
	fsOsJpyGtYhuCeOsB1xKfl8FNIxNBWFYZ6DC2BoJkGs
X-Received: by 2002:a05:600c:1c04:b0:492:3e69:a86f with SMTP id 5b1f17b1804b1-4954a3cff64mr126601365e9.1.1784475396274;
        Sun, 19 Jul 2026 08:36:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96fecsm249720485e9.11.2026.07.19.08.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:36:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/5] bpf: Fix offset warn check for bpf_res_spin_lock
Date: Sun, 19 Jul 2026 17:36:28 +0200
Message-ID: <20260719153634.2908692-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719153634.2908692-1-memxor@gmail.com>
References: <20260719153634.2908692-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=memxor@gmail.com; h=from:subject; bh=zm4W59MnF4hZVW0rEaOc+7kT4d9pCVgl4uPD3ArWxgw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISvmlfg658vRm0I6Dl5ZLGJ0P+lA5tlNvyQfv2bUcV7Wd ef3hsclHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZhIjygjQ6uW8Jc+X4uWIyxZ R0InTa6VPX9D58bhyddPv8vsCNFdHMLI0D1Dbk/C5aQlDbMsEtuKWm12H+PVetE2Z+22yKhLrxO Z+AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Sashiko pointed out correctly that the case statement for
BPF_RES_SPIN_LOCK incorrectly checks offset for BPF_SPIN_LOCK.
Fix it by checking res_spin_lock_off instead.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index cbb1e49b9bcb..e7d4e9ba24e2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4168,7 +4168,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			rec->spin_lock_off = rec->fields[i].offset;
 			break;
 		case BPF_RES_SPIN_LOCK:
-			WARN_ON_ONCE(rec->spin_lock_off >= 0);
+			WARN_ON_ONCE(rec->res_spin_lock_off >= 0);
 			/* Cache offset for faster lookup at runtime */
 			rec->res_spin_lock_off = rec->fields[i].offset;
 			break;
-- 
2.53.0

