Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041D23EABC
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892843; cv=none; b=KD+6MlF4KkofuNefqf9uBN7n7bOx7qqYvmwTGn3Sps9N/PPdHkZ6Jg45HHUCbPkF4VUqqY49VYcTbiiRGg8BnCKZ5ZanQkFjrI7Thqye82smCbtd2Zb+J+cyGAJLxttIz/inpbFjOAwVl07Gom6ienXRtQoHLv7NM3jS491YPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892843; c=relaxed/simple;
	bh=1dZFqrqfBJMh9hjaqYdFWxaIIuSOz9LBW8Js1PqjMmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2HC58+Lud/u5JZ+g5ivPOEPQsTOohkrX0fd54Z/ZsB3yXr5YAdW+N4NtcC4iplr0PiDxmq7rgCUw9ZoW7JUF12lMngjLhMK9Cl51dbaeA+Hb3q4Rzu9ilGcWUunenN/j5/RyU63Qf2aFrgMlF75iwSsGDw56cLvKeq9I6Z71sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKuJBh3Q; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKuJBh3Q"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c742723c863so1780977a12.0
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775892842; x=1776497642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp0lQVz0Dq69waZFLDCSSR9NgYI7BZSMZLD8Yj+4BvA=;
        b=FKuJBh3Q88Qb4q6iFBnIGcU1G4AyqITiCgNeA/a1YUyskkZ2mTrPow4IQUHh+ivcBp
         yxE8+PE6/EPNG3HEvUjM3/Vby6RNUzYl/bPipmvtaZnhKrEzs/93aLQEtLtPuznIBUb3
         dK28IGBA1exp8h5ZuggBpVcZ5Nq0oRSfd8HFqytddJPZGZkHdraLwqOrkXaapLECTle7
         /XQoSz7klfMZsv2GP0qQygsvBK5S85JfZcRmf5MkpOrjYQ8y5jkxz9CqJOx457NjRDL2
         VcaINOLf485i8Ob0hHdQubvZI06iwz+SVFSMuh+29qAsbOlcSRs3bk7aARwasDCzzsgx
         ndkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775892842; x=1776497642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jp0lQVz0Dq69waZFLDCSSR9NgYI7BZSMZLD8Yj+4BvA=;
        b=WU806RIDfzfPZtijuahb/FFJ+QQuciVc5ZY2xH1rjxO5IXsCSFfSB66rD69/IlQngZ
         cGSYinAjGG3MnIJhNRwnPElF5vOvqBGZ1+FqpY+v6h1q9By76zgxXJVc5udS5kzv0ODn
         j3CVIiWUkHOQgP2BEa+zR9O+14CIc30Mt2APowRR8Yo+EBdWhK+ZZFBLTrDasiO8Lmp3
         s7+r+Q9KCvHR4xsHetfKQx8ab0yU7kW/zSNFCEY6t0Kj7vllCjlYjjgwltlqSOdgXw2C
         DdZhn+slnpwZtsV6uLIJRnGjz7ax57Nm4JLmVKIR0yjFSbUKm12Aoj7djP1KqccmtNVs
         tQ+Q==
X-Gm-Message-State: AOJu0Yx96+f6lvQqYLSckGd0hvO9Lr5hCD5pY2h9z63J0SQYjZfl30tE
	sLoCgTNniNmg9SWxhURNleW4Q/GdUx5FXLu5OWplCXKMKzzkGf9GF68QMde13w==
X-Gm-Gg: AeBDieuheznhV19so2WpiJyoHFyUWfboMR98MrcpUt6Ffhn34r/H5knGxs3I5HJkR0a
	mFyj0XikJ54YRyj9T6Y+0ZW2YhQGdRoUHiQvdT/s/XwNnKKzmlmqugpb8tVYTr1L4fG17B6q4HP
	b27EFPDvB3GvkkOzdl15ebyFldKdFKnUXzFnh1+r6efrmSAn6CbKoxXjy+py2oOMjRb9UcZwfrF
	wdyvlwYIfOVRKELBuc5Xxd5YegKw2J0ArWd2pXPxeCOjlqEa4vh5rEh+9J0voj/u356fEBRvbeD
	ByfRN2ywrL+pxlePSFwk5xIiSeaoVD9wDEjd4sY3deqpFMZhIsw+BHcx9zi5KD5Mc4yd9KwdNe3
	5f1/nQZQnAp7FaWjh45sLc614GmGKtH19XV5dBRhYBSzgySzT5+ZQQHdr8KLdSOG7S69b75wnAP
	zXv6aHGCgmBqXu5YJu5S2CPokxOPEjUcMzqdH6bPDJniAwbc15/7ffnQwZWc3Ly6iF2so=
X-Received: by 2002:a05:6a20:7486:b0:39f:d611:9ea0 with SMTP id adf61e73a8af0-39fe3f5983bmr7376795637.31.1775892841814;
        Sat, 11 Apr 2026 00:34:01 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30f5c3sm4965388b3a.3.2026.04.11.00.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 00:34:01 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	cupertino.miranda@oracle.com,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: fix __jited_unpriv tag name
Date: Sat, 11 Apr 2026 00:33:44 -0700
Message-ID: <20260410-selftests-global-tags-ordering-v2-1-c566ec9781bf@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-selftests-global-tags-ordering-v2-0-c566ec9781bf@gmail.com>
References: <20260410-selftests-global-tags-ordering-v2-0-c566ec9781bf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

__jited_unpriv was using "test_jited=" as its tag name, same as the
priv variant __jited. Fix by using "test_jited_unpriv=".

Fixes: 7d743e4c759c ("selftests/bpf: __jited test tag to check disassembly after jit")
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 4b313374c5f1..7e99fe8555e0 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -140,7 +140,7 @@
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __not_msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_not_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" XSTR(__COUNTER__) "=" msg)))
-#define __jited_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_jited=" XSTR(__COUNTER__) "=" msg)))
+#define __jited_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_jited_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))

-- 
2.53.0
