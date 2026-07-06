Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A73B27F3
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361857; cv=none; b=qTzzxgMFhK2fzZeGGsS+3lCqto4mg6ZQB1w3OrgUovLBdyOe8NdcAcpNVLzIztrU6BYT4txhXJRoLv4Y5mX4/VOOxYjX9lqeAMvnUyXlWgw3aAaKS4uVDxxYwqmf19h84g1qu61O3n8oT2Pu/Howd2ZiTHEdlbjzYGGPCVLTww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361857; c=relaxed/simple;
	bh=ViGs/NFGnGGD+xR6nTYav9ZwHqqtrsDL0CUJBuuIFnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/4WvdrDzAfhsIyw8EpohHHNcQVmQhVhTpjBm25vsNVgw8byA0RbB9twqS369WIz+uRtYsJAvQgMdePvEEUbUSdPPmicu05OLU0Xvk0KzibXoQyVa6R8Usw3X6jeWN5Fjt73gP4NjLJVOElApkhr/ncoCv8rDH83A3arK5hmHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=cg6esNK0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="cg6esNK0"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84783bce476so2282324b3a.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783361855; x=1783966655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/amI9OCsL+BtzMBTmCfAN5gheYkbvxHg0Qf6eT0XQF4=;
        b=cg6esNK0WU9z/8wxBn8fFPo54/o36ShTIc0Da2FzOKPt8CcTHB1ge7YFZEiMHLFPvv
         XrWxeWSd5recnWPrT4MxFp4GuSTvI0rhVpDOlh9GDdJk8cr63g0FqANzPVyZVuEy1xt8
         9x9dssyeFw5tf1R6D4F/EE/352dWAj80+vDJQp0/eC6XG0VrkL7YP1L3+eIv1S3SDKZZ
         wgY6lrlN4W2NUa+NVjSitHmSHI4AG9mjocqzQupRT9s7Tcmnp4qipskaBJdHYek1VEAH
         Nx36f6U4FXChmuQDnS8SHG2hu33LDBuyo4oVsP476WptKPyTvSe4V4Iv+/wMYyLINB10
         KGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361855; x=1783966655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/amI9OCsL+BtzMBTmCfAN5gheYkbvxHg0Qf6eT0XQF4=;
        b=FtchdxRgufOVom+3trekGuldXv1Cvel0UEYlKp3fO1DnEgF3Jf7jMqEKQwyXopKa0Q
         qms+0GQhI6q0LlMjGXdd+qDAwpXLDE0mvLc5+gmf/iA8NA9iNPcuARnr/KncTsIS+d/f
         OCwyumoA74E01rT4ytNzQQL7/FuAVoBkWQ38Gz4btzaQiHuJ6mn+O07hryrw/rkvPaVb
         +UAMJrVw09ySjHL1TJllb2nhxgdrI779u68GXsIUNeoRanfOOlLUjWwMpUIJkDVsLtfi
         nB7FllspZUAtUfNvX1xoD8egkZHmJrBimEbo4l+ziP4IOgFpmTnX43C87tq6AjaWmXxr
         dGtA==
X-Gm-Message-State: AOJu0Yz799BIaj7WfXDBABOWSZUCnlSQlPO3tSkWXNolxT1APMxpw+cA
	kn7AKUKWQiG3SHFKWktXW/g/BTpexTj9W7RB8LgNekJYmjg2HbljCa6gzUDsai5wxAEts6ZspK2
	dyPjl7OA=
X-Gm-Gg: AfdE7cmJ/9pFPtIZq55vQFKrLyFy5fS7nkZHdPRH8jyXp/kbgfFEZzgh7V9PwhUbksI
	RHhe2oiIwJocn2JwhG5wBZbSMlI0EUmxX3T7voAY19KAzCFfoSVt96mzktebfQYZiGR1yfoXCFI
	UJpoZOw8PxgHN2W+zAXtD1WR57tKL4EzVcJ/fsHAwHDEpOokuY7FLnYf7L9vkJHyR6BWCnJP1oT
	KeTKtbFNdSIn8eaMf9G1wFNlhnv2gn7mW63JJNtZbMaFiww3Iv3peN5TETKaOZjqRqWowwFGeLv
	JDSPVGsJlvDJoZXyTk/zNeQiYTPH0mUCRC0TQK0i7iA75+kW3n9qscnEYe8jcl5aiiCXClAYo21
	D3v5FO9lQeIyVDanByr1950Z2wqqegRpnD/SUiBdpBbBGZSfW9iqzifzBFhYjYEtCzlbyy3nJyy
	IuDJJ6I83Y0i4QRPidyLKOOAgxu7ibDKtpYtLeqxcWnfIk1vg=
X-Received: by 2002:a05:6a00:2e2a:b0:847:9518:a6fc with SMTP id d2e1a72fcca58-84826e83fc6mr1681617b3a.33.1783361855590;
        Mon, 06 Jul 2026 11:17:35 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d498dcsm4192997b3a.30.2026.07.06.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:17:35 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mattbobrowski@google.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: [PATCH RESEND bpf-next v3 1/6] selftests/bpf: libarena: Replace leftover st_ prefix with test_
Date: Mon,  6 Jul 2026 14:17:25 -0400
Message-ID: <20260706181730.21731-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706181730.21731-1-emil@etsalapatis.com>
References: <20260706181730.21731-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The st_ (selftests_) prefix is confusing and has been replaced
with the more descriptive test_. However, last patch did not
properly move all files to the new prefix. Rename the existing
files to complete the move.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
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

