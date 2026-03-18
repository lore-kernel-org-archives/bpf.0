Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FF4393DD4
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843358; cv=none; b=bLUDXrcJ8b9FLVM8Ref9hCRxNBNtj/8WAAiI9mFkkTTONLU/9fkPEiNlQAbwxQT+Y927Hkc0qC330Xd/OuQhZJ1qq9yI7LVrbF0aNDvURXywPwh9bNBdQayy8LGCmjKbqpt2rHjgS0Er/r6Iz+RbptiY9jUQWCE5OansygxL9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843358; c=relaxed/simple;
	bh=qPXI7YPTmUKpStE6fm8di0boystY87ZA0kTJF8QXJ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLqxaCNvPbSW3ArM6Cw2e2tob+3/6nPZktdjMseyh/re2jc5CUi3/6f65MZ0l9CZiaimBFfE3Clr7EVPVQ+lPcls7qpjZKZMucJXEc8qBpSjjY8g/3D+jNfXp+ncSDB/S197VMJyUxuaUskpF3jhT14lGHKD6seGduTyB+EozSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO+OsVJ3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO+OsVJ3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso62410405e9.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773843355; x=1774448155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGFXe0XrDXFVwHGvsgCIqTOlVVluXByUL6lncWYywBc=;
        b=fO+OsVJ35KnKWw478aEsFMlxC3wfrxZdq8cRQoGGgYK64MzMZg159/HjEVduqGfpIZ
         stQ85udj37jHYDiv0s494IDYRCf4xNIKEzMMA8LWzmII0/BwV9mmOiq7BYsquHVC6Ivb
         30qAc4uGrJFrRehZ7zDCY3P8DZ5L1fTZC2rBBr7j3cUoBbvpcbBgBb/qC8bsxSanvI8k
         g7Ybvzic3xxXNKXdjuTNxy0SFVDd+tlUW9VO9qQuV5vWbiBIhCvWtFabx1ORODydcxSQ
         d1JJtkVdlZzQo+q8vo3p/t84PKPLjE4LtEZiIEY9VfnThNd4dlbuC5bKgO1Cf9xcu3xZ
         hBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773843355; x=1774448155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGFXe0XrDXFVwHGvsgCIqTOlVVluXByUL6lncWYywBc=;
        b=RjirzY9PJLS/80nob1MM85uYNu35Je7hVRoh9Ws7kPr4nK98rtSnpWmQhJ3zhAdvwn
         baGeAr0rKWBnmRRmog7e8fbI/hG28Ou3g/Bb4xPVR8YJG+GAXuiqxY2ngtySToLhZvHk
         PzOlutGX2YL22MH/PVHwwtRR3Dwj3yNxmeLsrti/HNuDEkgZuxbVIU1yvpONe3xqYyXV
         lYQAebkjV6slb4VZyPmb/i0tNv8K/C7jcvJF9S5e+C/anhs7kCZ75HYPdKQ2jG3EeHQU
         HPt8MYxGiWZo49Howi5P73G3MQCpHf4asqP5W0l3IgNsOjymiaKzZmZEtaxyfBmCgZbU
         k29A==
X-Gm-Message-State: AOJu0Yw0dnD5pEr7bed7zRuvJhJmkZVzNys+ywCmsy2VF4sDYfmbw3uK
	SDby33y9T47kJ/x44mtyuFeGENa/umCv1Sww8lxAyzcM7WI9Heisgw2i8tPyndo=
X-Gm-Gg: ATEYQzwcknX1mDB8XLJFUAolDllC93p5AoNYF4fM/ezdx3e10o1IPxIlhCpTLhV6GDj
	hC9Zs1nAGzaXWumW52pmB4N8GEA9oklvD2LzmOL7IQViyDm6gTaXjbi/Ue5kYrude/hvgoBvwCi
	cT+CAo52x2XGZVeRoYUWZ3TfU8sd/sjZq8MaXl2TdvJ3/yeLkOeIXQ77OxU0004GYmaTUBYDpMM
	HA/PUmd8Aeap9kB8DNrWWeT40ALa02/ITVYwkyYEBHuVCjN3k65vBlogwGeD9CHTJibEvmCtUNG
	DTJAQcYOpmZavlBXzN68FhXzlBuDUwX5pjW6qmIWaRZGQAkulV97waY2QhKWMajbIwIf8/RZy7x
	yrpkUIYdNSK8KYPoV4Rt7m87cmL1CgrkqaRyQo24qJv9lR6aSaFtOyH4FkyE/Y/YgTS2kuz9gD/
	Qj3rgHZkPW/XfEQ92utj6KvzIi
X-Received: by 2002:a05:600c:3b25:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-486f4579889mr58753415e9.26.1773843355133;
        Wed, 18 Mar 2026 07:15:55 -0700 (PDT)
Received: from jacks ([197.38.173.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4214664sm60101945e9.4.2026.03.18.07.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:15:54 -0700 (PDT)
From: Ibrahim Zein <zeroxjacks@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	Ibrahim Zein <zeroxjacks@gmail.com>
Subject: [PATCH] bpf/btf: fix u32 subtraction overflow in btf_sec_info_cmp
Date: Wed, 18 Mar 2026 10:15:46 -0400
Message-ID: <20260318141546.1893776-1-zeroxjacks@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comparison function btf_sec_info_cmp() uses direct subtraction
of u32 values cast to int, which can produce incorrect results due
to integer overflow when values exceed 0x7FFFFFFF.

Replace with explicit comparisons to guarantee correct behavior
across all u32 value ranges.

Reported-by: Ibrahim Zein <zeroxjacks@gmail.com>
Signed-off-by: Ibrahim Zein <zeroxjacks@gmail.com>
---
 kernel/bpf/btf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a..5b3e1af 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5548,7 +5548,11 @@ static int btf_sec_info_cmp(const void *a, const void *b)
 	const struct btf_sec_info *x = a;
 	const struct btf_sec_info *y = b;
 
-	return (int)(x->off - y->off) ? : (int)(x->len - y->len);
+	if (x->off != y->off)
+		return x->off < y->off ? -1 : 1;
+	if (x->len != y->len)
+		return x->len < y->len ? -1 : 1;
+	return 0;
 }
 
 static int btf_check_sec_info(struct btf_verifier_env *env,
-- 
2.51.0

