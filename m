Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ACF29ACF6
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772997; cv=none; b=MjidiGl7o2r6tmTCJGlXCVAKdRQC9SpP9rIEtGR+74PfLCbE9v3Nsuz3OYtAlUv38Zb/Va0RdWOnIiyl6uMOLIVXIr+Bv+Co+4MaVYYsUT3unrjn/NHdZnfbikbM933OJdZAMV0tBhHWlL1av/x3DIjTUc47BQNWLYzXn/LjHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772997; c=relaxed/simple;
	bh=fBe7nrzxAS059cIfrzlcUGAreUfX9E76MwClvNc72Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZDqrJqbv4AUJ8DOlD/D2eVnvMnUwoPWMKzu3MHLpuAtJ5bXw3TFfVecLsz8ghryrhBvt/nTEadP5heuapB+/um9kKZ6b1bL37v521oAaaMmg8cAugFVZ+dIxZQhjPO2dDQd4WXxkCdrTo/EyoLq6Cd7EDnBOAzZjcyi8R6XnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=zTM8NWK8; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="zTM8NWK8"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c88e3e82d81so356112a12.2
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781772996; x=1782377796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bn4psBWfXyA6jVPbanPW5inbyyxLTnUWTioxG2/PNo0=;
        b=zTM8NWK8DPbMW/hCCg9SomcRnlFcjQFEng5xqwskvUYbwEdcyKfACpxNGnjqyRbpds
         a/fvbZA49F8e4gYbUsWzCHd2coQd77O2FqowXslBYiKvwGUzXhWcci3xF8z4mFBWGpCJ
         AftnH98dc2gGl6kAKRRWVcqs7DECbnLlcSVX9xC857QqEJ4P5ac2m69WsSm/+3BxaK8P
         HOh5Ap75+HIGEWfg/kSLwjQ6eKbuKhN+TPbIyI9Ljv+DhLVJOwTSZQnPA+mzThE8lC1y
         CCzLrSTcEukOr2UCfK6RwMcVzDrIZesTndSpgIjic1O9ubwD86GRIudktJ31z5l3pMY7
         pElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772996; x=1782377796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bn4psBWfXyA6jVPbanPW5inbyyxLTnUWTioxG2/PNo0=;
        b=hheVgpVOf1OWhvXmuCs/v0dDOm/NFg5JIdpjhSjRAgvIPwXstSu/CB6uZmrnVsuF1M
         8XhSdcbNQ0xfMnCYkvDKfsgPP2P1MTgUPduzE5ohBUJBQl+b75yHzRuppeE0usQCVeNo
         iC9X6JNF3lahl4huvP5H0TRkxIfMwGcvR/jfGa0fWnmOsWI/skJpBzFtTY30v7oKOdMa
         uAV8sGx3S8LicvebYOA6z68jy136UPDVYaW10vwkBYaEyA0l4W7ogwxfTUVg/HyfDpIk
         imRjjLItbkLFAbMhFiaXwxGwjYkeZG1qWTymUANxvguA3ej/gqMYjxBNCKKrvr7XfYCj
         GCnw==
X-Gm-Message-State: AOJu0Yw/YPHcGKtyW2gFdB9Ii8lwVZmn/kQrKlgn5kyBGpLbRy/8COPB
	YOYIw72VgLcgJ+A4qyoiT3g3w6BHhnOC33ygiDfuhPU/POA6QdkGW+lA4Snzk+BtflM6aa1zsyg
	R6wFv0lBojw==
X-Gm-Gg: Acq92OGioyPETQbVtwb8yub+JxxgStCjLUa2lEsLwa6W3mxBqJ12f2JpITpWDCucrAZ
	P1fdWISqqDEVA8cT8aJ5n9z3PQqwhCH0VGhPFLmKoKd9BthJJJuEi46wKoOfSm/TJD9ofjJf6Mb
	5RI/97KjzlD2lr/I0WifhMaGoBO26CUJRp2MOZ+fQ46/HMe/q6cKfPduyQrt8+5eVv+D2LU48w1
	sNZ2bmOJvDLrDlljbyHY2WF5WNELlpswSqb7XQKwSwHgRtEDQdFZZFKdPYvHQI1Vz/cPPg3JoA7
	Xlwzmnhl42m4Y4b12vRViL+Orz+hUZZx1IYIfrgzMy0HZiePdgdZ7QIDwFT49qqlSAvZTX2sXdQ
	1CCPmL4JJcAu0kQCXr6L17qXlNr3qvLD0WzubHlWblY9+r4Uky9MoquF89X7xCHxPzI+7h1xdV9
	yX+gwz2UE5ybCG6SZrpNJYmkzEV/2JcnVNEurizzw=
X-Received: by 2002:a05:6a21:2d05:b0:3b4:7b2a:6a0a with SMTP id adf61e73a8af0-3b9e80fe580mr3406365637.35.1781772995789;
        Thu, 18 Jun 2026 01:56:35 -0700 (PDT)
Received: from krios (S0106d8b37028eeb5.vc.shawcable.net. [24.84.91.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c88c6c2b2easm2524404a12.27.2026.06.18.01.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:56:35 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mattbobrowski@google.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 1/5] libarena/selftests: Replace leftover st_ prefix with test_
Date: Thu, 18 Jun 2026 04:56:22 -0400
Message-ID: <20260618085626.19633-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618085626.19633-1-emil@etsalapatis.com>
References: <20260618085626.19633-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 .../selftests/{st_asan_buddy.bpf.c => test_asan_buddy.bpf.c}    | 2 +-
 .../libarena/selftests/{st_asan_common.h => test_asan_common.h} | 0
 .../bpf/libarena/selftests/{st_buddy.bpf.c => test_buddy.bpf.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/bpf/libarena/selftests/{st_asan_buddy.bpf.c => test_asan_buddy.bpf.c} (99%)
 rename tools/testing/selftests/bpf/libarena/selftests/{st_asan_common.h => test_asan_common.h} (100%)
 rename tools/testing/selftests/bpf/libarena/selftests/{st_buddy.bpf.c => test_buddy.bpf.c} (100%)

diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
similarity index 99%
rename from tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
rename to tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
index 686caba2c643..256d62a03ce7 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
@@ -12,7 +12,7 @@ extern struct buddy __arena buddy;
 
 #ifdef BPF_ARENA_ASAN
 
-#include "st_asan_common.h"
+#include "test_asan_common.h"
 
 static __always_inline int asan_test_buddy_oob_single(size_t alloc_size)
 {
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h b/tools/testing/selftests/bpf/libarena/selftests/test_asan_common.h
similarity index 100%
rename from tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
rename to tools/testing/selftests/bpf/libarena/selftests/test_asan_common.h
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
similarity index 100%
rename from tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
rename to tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
-- 
2.54.0

