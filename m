Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4F309F1B
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537791; cv=none; b=s+/UR9lc2+Vfk5l+YnVJz6LbX46dmMPhcgWf+CHZoRomZsQxtdEAxz5A9TVXHUlX+J0DBqKMgf+sAUMXZMwa51+wzD1SlFe6A0BVBCAbxXOADrG2DfgPI1x+2wLhcTHHGrfmai3qE32hLu2t9JzJEsdv52S5n7gE9B/o0XkvACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537791; c=relaxed/simple;
	bh=ghPmD8GgjAwRtDOxDBNUkJKDFG/xaafztQsutLa4gxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1yYZ+f87iUG73e6e/DkwWF7xgoXH4xRNxkZJQvQnE4Whhirr41X50kOQ8BQTdnrhKqsr4NJZVIuBcW7jH3iQ807UBBEV+J9NWtnHk2nUKb6vbc3YlFa2n0Z3W7IBJfKGZmtAtxmlifgaLV+fU6/a/Eixm4epM8JN3ieHIolQPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=1BEKDhp2; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="1BEKDhp2"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-894770e34afso99636886d6.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537789; x=1770142589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0DBzHUK982E+T5YVoHJXumJlhN2/Z7MNEuOxJjgCTo=;
        b=1BEKDhp2av4Lm5T3ufN8fdaVh1tS5Bb48JjF+wnDyPFKhefn2Y0A6eslmR8NyTMcGd
         sYwJC4PqDUDySio3NHDGf0cq82TYuxYJUqhb/xi8EmLWbs9WrzMfqVGLEXQ+7Ivkia+x
         xasRZHBuPHgw1i/IKNhUPWYCtqHBPjc/VvnoH3LZEp0gWVPtmn6pWH3Pu3FkFfuCk3v7
         AbpdJxeDWkzO4HoUD29DNR12yJ9t7j5h7BFZT1dGWOHCVYNoRmrwJua3AbgDpKtRvbb+
         cgPn9B5h7MC9a3R5YSbZMgoemnZQfAG8tKwuwO2Bw9Jm5lmWuFAxNk2AOuPgUYAMWlse
         /xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537789; x=1770142589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0DBzHUK982E+T5YVoHJXumJlhN2/Z7MNEuOxJjgCTo=;
        b=QLwuHXjMyWkXn7M/LzsEGQek7wuxd1QLJVOdwxZ5urIG/FI1EL13D7t5E8vZBjfebj
         Aw6G87zIK8I1Q6hviyFX+Dd3VWWYtykEO0eFNjCQu2ubWU+VPhkD/1r/yQctz/bd1Ilw
         mkACFmwe2MMstKOkZ29ijj2nJgMiaNp5HRYM1QRD7rZFi2BV0B2IFLlDv1QLF3tO6i8X
         Y/3OczQXTcVQ7eCXFNzknsshfigNCI7MIRbvRfczpAd8Vmnp0pC1UaVyGyGLAJZW2fFG
         wpIFL+CLr/pfqxPHyjUoi5yJhe5yq5pbSLxUlx8IuM+pojKLwWZsokBhGlgsbMKX/Pz5
         92xg==
X-Gm-Message-State: AOJu0YzcpiW0j0C5Giv3QqPdQQton1NCLQ92fq7SdFxPW52HecvM8PYv
	CYERwGp9E1jlxhgSkrMoXq6HmnptmTBztVyHYvEo75hH20irlS/oPTMN4x+RkVyD15kYaS9BnNg
	N0D8Q
X-Gm-Gg: AZuq6aKTvDiXlj0QJn4JRLOdzA/o6ZwiH2JtK2xe5Sbo660/K+HP31TUOI488YAfa49
	aqfNuMcUZT0ZA7W2JfVmgd6fcJAgL8ZGq/joow7IiUzFcpyuGQPNDuOMbesHCWkHAmz/P1TEfaQ
	0K9JP/63GTgLrXlrVyBSDyAVCQ0JsLzJ8QaBYhIUHZN/Jq6CwGwU9Ddp6OU6eYe4qAdvaQjOVmu
	SISOdtAeLka3DFVUFyN9a1qJnqoEOOothgOT3jwA338zkEyE8oC+JwAX5qihPCnYO2O2YZBwX4M
	jlxqHbQAm34kX6wS4cj2k/nVw3k8tIkSRmTnORxu2RyGY30Ajkw7ZyH81YBgPVqEAxF3mbibr6e
	MbPQdk98O2Zn83Z1qOjQh35JFltE3uKNdchAThWr4zCsXS5L/eK/Qna48e1HgE3o5qD1wPSVBNp
	jRwlho0PrzEw==
X-Received: by 2002:a05:6214:21e3:b0:880:4eac:8689 with SMTP id 6a1803df08f44-894cc956056mr39602076d6.57.1769537788581;
        Tue, 27 Jan 2026 10:16:28 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:28 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	etsal@meta.com,
	ihor.solodrai@linux.dev,
	martin.lau@kernel.org,
	memxor@gmail.com,
	puranjay@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v2 04/13] selftests: bpf: Make WRITE_ONCE macro in bpf_atomic.h conditional
Date: Tue, 27 Jan 2026 13:16:00 -0500
Message-ID: <20260127181610.86376-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127181610.86376-1-emil@etsalapatis.com>
References: <20260127181610.86376-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis <etsal@meta.com>

The WRITE_ONCE macro is identically defined both in bpf_atomic.h
and in bpf_arena_common.h. The bpf_arena_common.h definition is
guarded with an ifndef to allow for inclusion after bpf_atomic.h,
but the opposite does not hold. Add an extra guard to avoid requiring
a specific order for the headers.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/bpf_atomic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/selftests/bpf/bpf_atomic.h
index c550e5711967..d89a22d63c1c 100644
--- a/tools/testing/selftests/bpf/bpf_atomic.h
+++ b/tools/testing/selftests/bpf/bpf_atomic.h
@@ -42,7 +42,9 @@ extern bool CONFIG_X86_64 __kconfig __weak;
 
 #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
 
+#ifndef WRITE_ONCE
 #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
+#endif
 
 #define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
 
-- 
2.49.0

