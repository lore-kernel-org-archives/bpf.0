Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72429219EB
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860123; cv=none; b=pPORjaIWc5eqNOxW1CMOxznNYYv0GtTvD11sT5CPsdKZfZ/al00p+1/vN26GlxeTFEUFNVfQU+OG385miBibzD2Ux01oE90HXHeNb+PKUMbQ6/jrw4DDzCEs6qUdmZlb8ZAhVyxYcxGN+/Rq6pN111ICtT7BFlCrpi4gH5BsKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860123; c=relaxed/simple;
	bh=epsoEZRF0RW6WgcJ1A1H1Ww2bQ+6Xg0sBBLVbokg2hY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fjVUmkL57S29gQL4yDxAo1izzRO0hKpVsAcDhbsTCPY9+KKq16TCA1hHlYJyCYpGqjvHr5CSueAfxb9nnfM0rBhl5agx/wbLc1RvOhWUfnezwdcDIKE1xV9rDbjifxZQZ+TQ3uK7yLXZp+oM0yPbxHCSGGvDTocvaioDBihSdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If9syzMv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If9syzMv"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dd5df90170so7897565ad.0
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860121; x=1710464921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NuXXLmnAE+q/Qh+E4xFDGQkYW6zqeJ+lfkCjeDFQWQ=;
        b=If9syzMvCoYrk78jlkEF044bEEVIeoI5DAC84bbtlHaWxDY+vhQA+XECiXFMispgZj
         9ugRGUBVw7vI8uh1g3AZ0rlGNDpsLMnMKh3l7GJQtrSbtVjVqnF93OJCM9wUV4kSNpgP
         MRviE8PnYg8/esWkf01ov5JFyUUwpU8FvLbV6oJ+R0rmhI7qEl7rX24QOzF/Z7xazxEb
         QfD/z7cjebbwCncRfL2ZMXuV3giWzAyE3QTQIIogfgau/QETStsrq6MYX5gp4GiXpT8y
         pNiNj9J4xSPe8QIX2FGScZrX9vIpoGAUpt3mdLUk0+YU8z/kXThTs95mX087TWRWpepd
         uiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860121; x=1710464921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NuXXLmnAE+q/Qh+E4xFDGQkYW6zqeJ+lfkCjeDFQWQ=;
        b=XcZ4SF5IvWkBAFQqH31VfTMiT4J19oxIMBPfHSwjcuSQroHS8y7t5wz2ZNjR7NtEtP
         9ex4CdkzOhSxCGxQaFmaLUVChV0eyi1eXC/qXsi1NjHMqqy0SeerGNMDUA6V13pXlzFW
         UG9PlGmGbimhRimT+e3OUw63B3moDNr7LXFgUYV9XqvFGKYXQm2GtvMMV0H0Frd1ycGS
         Tn/0+WQ5zoxJ4rNgvqi2hruZRPSEcKV8klwmnnBjN2re0E66G5MHZr5cCfHAA4YxFKnF
         RTvimwPEkvFV+j9TdG2aLNM345m4YhKNhFfPHWTcy546KEAU8uzyVXu1tLE0CuvHUW8c
         IbCw==
X-Gm-Message-State: AOJu0YygLwktxAm1G8bYMtduDuuwBVrSouITJlzmBQi1iFGkbDGgOmZ0
	tavbeDdM6W7nHDpxs/2Ljh0yIXJ+yvb9svXDs1ocIpNI9QY8fHkZ/S/vDw55
X-Google-Smtp-Source: AGHT+IE/rVJyHyDH3twq3B5ImHa+7qQMzSrhjptd/jCeFWpmF9E5EuD8MZdBtTv8pdWPHrdvIyjM/g==
X-Received: by 2002:a17:903:228b:b0:1db:c649:cff0 with SMTP id b11-20020a170903228b00b001dbc649cff0mr4824335plh.25.1709860121047;
        Thu, 07 Mar 2024 17:08:41 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b001dd66642652sm360604plk.190.2024.03.07.17.08.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:08:40 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 07/14] libbpf: Add __arg_arena to bpf_helpers.h
Date: Thu,  7 Mar 2024 17:08:05 -0800
Message-Id: <20240308010812.89848-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add __arg_arena to bpf_helpers.h

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 112b1504e072..cd17f6d0791f 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -193,6 +193,7 @@ enum libbpf_tristate {
 #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
 #define __arg_nullable __attribute((btf_decl_tag("arg:nullable")))
 #define __arg_trusted __attribute((btf_decl_tag("arg:trusted")))
+#define __arg_arena __attribute((btf_decl_tag("arg:arena")))
 
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
-- 
2.43.0

