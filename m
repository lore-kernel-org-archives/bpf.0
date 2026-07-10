Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0DB352C4F
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721399; cv=none; b=B+LhdfcniMwuqL8tC9juoRAQnQVialr2D9mBo489/8yc+cEgIn7wOkK328n26ElqEbJ6eBLM6d/EaMSQYRoWAItbA0bcyPL/XTDgdMnQldzyL06G+snC/eZyW2A6ap1RZoOK3+vgH/geFhJNovnzvZYfw5ql/qo9cZETLGNTsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721399; c=relaxed/simple;
	bh=f05H4JgOmbhEYXXX8Z0Y7d01SUGo0o/0ABGAyfPSepI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SzM3+yEZ8J9Izu7skBKuFMSzZvu/fnLkuZMsMGEvy1sL+9bzPWUXUTpHatxtU8w53sT1fvKmYxsJvoX4IkH5eIW+l/eczh0eITSOh24gS6cPNHEvYbWZisE5plBLFVxmrVV5YjcmtE0m/7meTVuDp1ezOfYQULDnjf8z/naUrz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CjJHoRJD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CjJHoRJD"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493f431e317so10162765e9.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783721397; x=1784326197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hA74mvd7Ic2z/4GThgvYnbro3vSktJd2+P0D2B2Oj9g=;
        b=CjJHoRJDDDTPXyo8CPwzft246hEkD5UouJcknBSbOyg13WA4Nx0QpZ2l0pOU66gRol
         jcrihkkIspaVmtUWM5XOpCDbENajpB7s3i4mD1c9scLDAYLpIkGY6oiTbONVnuCttAWF
         LaB4cHPsBx4XDCh4Fd6SZDJEFp0DY2qkU5u86edZUaGkWRxYSzfKCnXfFX5LP+dRpWGJ
         X1EdKLSSFgCg6k+aWAq4pcNudG8UZlZBrfRsGo9NzADbkZbgCsfsw0yQXJ7nbrDWFAW7
         2CiUjy4T8lypSPsvbJtMYiGvqZT3GxIvgAY8RFiFtlC+kx8kizYT+xFUFI9NLswzq6pi
         9ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721397; x=1784326197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hA74mvd7Ic2z/4GThgvYnbro3vSktJd2+P0D2B2Oj9g=;
        b=K1syqaemC78rJTUo5osLc/NGBaiytMP978fhCNUzbrkttzAIqv+cc813FDVe1pYqWl
         33ZyWPWt/UllMqy4BjDRYB75/MwhXm3OQG5uiQVTr0Lx8lh2GU5CiFDbEbPXenLwe8RC
         YNiD5hHBaSaGei2+YpbZQuXw06sOkBDtvzzZaSIIuyABY9hZeOm+kXjjaak7QOt30H6P
         G3zfyszDRKTnJjKHNibYQQ4pDjRnG7vl5pscUoz2l5BdUHkZWcQClso15OMIv6pa6m9Y
         0C2xiPtqNjAYEJVzs0agVoe/LrIYzdUIqwCWRQMepkPny+MyxeQfvjPmX7bmhfGtsegR
         qPkA==
X-Gm-Message-State: AOJu0YzC4O61ZUdl35kgqMnoPgm03ZHqwoIxn0HhxOjpIEJbxgmNaVNI
	Wy+K+98AH7+qk7P8r7flKKJNAzn2Nv3KaQN/28XtRLq1SzLF4GRtqtforIf55xjLSyk=
X-Gm-Gg: AfdE7cnV22TsnnSMUOdUNlFr7jG8HQPW3Ra5+ikdHunqtf9vlyKqjX7vPC5T76DUNrW
	nGSvnrppGq5nTXEwbyA7cffpKC6q74EFeE87luzni0t1Iat5JPuerRDiDoyKq8MEbldfVkMVM6S
	Ob6cozAzwCnH68y07VXpy5tj3e8KxL2i78rbQZvoeN+AU9hDo4MWNReREjsyUvzLxA8Nhy6uoOT
	k65moo2BRJPYeyOnli5fAKs85B6wV9aSWFZ6peFbLSGUxJewsn3IBFkS7r7h80s7PjsQElQXOx/
	fWgV4Zha0yEyK1hLuBAp8xI13s+qGk5Jt3hdIPFu5IqEgY6grTJZxn4lkl/HZ8qpWicP79slFef
	10ZDTTX2tfi+WOgAl96Wla6TKRidMw8wt6WH8qlS/gbR7s/7ojR7JgTOYtPo/dWQss+/7EXhRgP
	5wwcZ1LFhCxHnH
X-Received: by 2002:a7b:c451:0:b0:490:e974:e006 with SMTP id 5b1f17b1804b1-493f8826b54mr3341195e9.29.1783721396665;
        Fri, 10 Jul 2026 15:09:56 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:157e:cc5f:6c4b:db0a:5d2a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e7795988dsm42916457b3.26.2026.07.10.15.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:09:55 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Fri, 10 Jul 2026 19:09:39 -0300
Subject: [PATCH 3/4] selftests/bpf: Fix lsm_bdev dev_t encoding mismatch
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-selftests-bpf_fixes-v1-3-aa24dfd6f4f9@suse.com>
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
In-Reply-To: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1783721384; l=1866;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=f05H4JgOmbhEYXXX8Z0Y7d01SUGo0o/0ABGAyfPSepI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBHdoSs4EuJtTmR1szH00KPhORysRcykJ4Jo0E9lJ8vOSwROBozJlwD6i6XXZ47uePpVwIOOwBg
 AEbfntPGrzgc=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

progs/lsm_bdev.c keys its verity_devices hashmap with the raw kernel dev_t
read straight off bdev->bd_dev, i.e. MKDEV(major, minor) = (major << 20) |
minor. prog_tests/lsm_bdev.c instead builds its lookup key with dev_key =
(__u32)st.st_rdev from stat(2), but the stat(2) syscall fills st_rdev via
the kernel's new_encode_dev(), a different bit layout: (minor & 0xff) |
(major << 8) | ((minor & ~0xff) << 12).

For any device with a non-trivial major these two values differ, so the
lookup can never find what the BPF program stored, and test_lsm_bdev()
always fails with:

  test_lsm_bdev:FAIL:map lookup unexpected error: -2 (errno 2)

Reconstruct the raw kernel dev_t from the decoded major/minor instead of
casting st_rdev directly, restoring the layout the BPF program actually
reads.

Fixes: 96f4c251a087 ("selftests/bpf: add block device management selftests")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/lsm_bdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c b/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c
index a970798e1173..28bc4b117f41 100644
--- a/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include "lsm_bdev.skel.h"
@@ -172,7 +173,7 @@ void test_lsm_bdev(void)
 	if (!ASSERT_OK(stat(DM_DEV_PATH, &st), "stat dm dev"))
 		goto remove_dm;
 
-	dev_key = (__u32)st.st_rdev;
+	dev_key = (major(st.st_rdev) << 20) | minor(st.st_rdev);
 
 	/* Look up the device in the BPF map and verify. */
 	err = bpf_map__lookup_elem(skel->maps.verity_devices,

-- 
2.54.0

