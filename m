Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF5EC3
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 01:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207481; cv=none; b=tXLmGRQ7JKxyITP1/flSht+ZpK1sa8avpinafzpYQqubXq8y6DZJYVCKepFYBevYBKhDi+WxCi5MqdTnLe3eoNHDQqeODEwPe3yshCTeK6iC40Ff8EigzufuivjEsuHk6b/OTKjCWc0sTDFve+GfER1cFqFOxMZZJulVpF1aVqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207481; c=relaxed/simple;
	bh=Gth2yK5QbaaqJPb9xY1j/jMIP8svhXdmallsBfMhWx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YUTP7fNvResCbQ8jVgnHW+6MTSH0nKOmxi4ZeC4BiBnK3NFi9LrEy8k0gM69eAxwgi8qo5wTT75YUtnrTpqPPBBlVDn8gc7qzdD6itHuAHtTDgupkT+8XRTcvA4guTSqOoAIU6GeabOVVMZT/hwjSUHnF6MlSQ8l3JbJq+ZZfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwX2uENB; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwX2uENB"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-609408d4b31so48704537b3.0
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 18:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710207478; x=1710812278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6pRRYIz8TVyVv/7ohCggCpkqCJ19KYzu+ILbJ++IJ4=;
        b=fwX2uENB+Bir4f/OpHBoqMeEOULuYgFmagHqhSVPPMTHqvqHM9FQUQQyFndBAPwkuj
         AA4FUVdyWWbK4NMp73ocw/TER/MrePbUhlefwxq6ipAdkXxjs1vwi0gicU9j7RySLmvQ
         p3iKk8hhcsDEFsm5fHRhksowXL4IjFjQlxcPEVHN8MbSoz+iG+Q8Yo4YZq7t3Xrj3wjl
         JmMXIb2vwW2eMPNsBgKYEJi3ng787/+k2wNnlUdWuKstDN8Qjp3Zr4XigvH4LiW+6glq
         rxvh+zW5NtK0TDmriSRPtEz87tHkFuT4I453GJvntKvmickUb2GBqHIWd9gUBB7Rg56y
         TFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710207478; x=1710812278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6pRRYIz8TVyVv/7ohCggCpkqCJ19KYzu+ILbJ++IJ4=;
        b=AI7OA5hdY/Uyiql5P7rUOZ/BY+t13vSpz24abOLp2ptoammcofG2U1TmZXlw1T+xRO
         k0ZC3G5DbCbaDgeWVmOqxOwBjJXm1sJlpzh7fB7SGGtQuPFB2DJoB90nR/ZvRKngHmju
         vhPYqbv4pKPXGXrJztRwXJwbQSZXqTEsxw9EdYGolKTM8UvMkY1+b88WpXNf6yN7GXS6
         QOPUxPEzqBLxgeK84iZ4XrgssFgH+nAZFOIuIt6szSYbGigkGIw/QwtXLBg1OIZcWLEn
         8HEyKHdxMBjhtNKITdOmmXHBpDdO16F+LL8DnFSc61A07ewGYpsMS4JG/HNMrksaBn3/
         NtXQ==
X-Gm-Message-State: AOJu0Yz8C5CFEK+/gLXtKjbPCRbVHyiwdbAEN0+XBdZuCLL7KfvZQCpm
	BT3v7+Tiis/NTkv4hSDDOpdJ+oHNZdnI4mXVAtF20tYjgJ4Ld18HJu4/HIMg
X-Google-Smtp-Source: AGHT+IEy/xt2cE/SfuTPTUWNK7rteISKPyuqZ5bcoVq80GC5Ln3Ixu4sXMkqgpfg0fQwWuMTWNoKTA==
X-Received: by 2002:a05:690c:2b85:b0:60a:1c9c:e00a with SMTP id en5-20020a05690c2b8500b0060a1c9ce00amr6178533ywb.45.1710207478454;
        Mon, 11 Mar 2024 18:37:58 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b383:9cb2:a45c:407f])
        by smtp.gmail.com with ESMTPSA id b14-20020a81bd0e000000b0060a0e42c6b0sm1614017ywi.93.2024.03.11.18.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 18:37:58 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	yhs@meta.com
Subject: [PATCH bpf-next] bpftool: cast pointers for shadow types explicitly.
Date: Mon, 11 Mar 2024 18:37:26 -0700
Message-Id: <20240312013726.1780720-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to a report, skeletons fail to assign shadow pointers when being
compiled with C++ programs. Unlike C doing implicit casting for void
pointers, C++ requires an explicit casting.

To support C++, we do explicit casting for each shadow pointer.

Cc: yhs@meta.com
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/bpf/bpftool/gen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 4fa4ade1ce74..dedafea0c127 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1131,7 +1131,7 @@ static void gen_st_ops_shadow_init(struct btf *btf, struct bpf_object *obj)
 			continue;
 		codegen("\
 			\n\
-				obj->struct_ops.%1$s = bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
+				obj->struct_ops.%1$s = (typeof(obj->struct_ops.%1$s))bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
 			\n\
 			", ident);
 	}
-- 
2.34.1

