Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62F3FF891
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546004; cv=none; b=XcXihVo9t5E1C/q/9A4SJeMjCmhVNAz1Nr0Ngcs9Be1wjA0u0BzDtxYpCD6aSL/ASBndntoeBlrFQj2M0Po4x6Cg8jZ9p35DidzGeUsUA6KRTuFyhXTR568vKzuH0wAdXqBCv6pLaRAddsJHkIxBAgNfycc7Mjg8w877uJoDY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546004; c=relaxed/simple;
	bh=fDUCloBgZ3h50EKFxHyA26VB0Ps+hh7q6obHHsVQWEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqpOXZoFBMi9rZxR7mgj1eaW4GhoOXU98eMSoWH5JLAALNHYqqKBpyxIlwEX0Xdys8bZJUMjpgAzANl54NeshaQNCIUvb/3pErIj7P4ezsiMFhzDdj3D4N3GuZBpvOraYQsYIvQxuaEATv2IBLQQVHptmudM0M9Abc6PVxsZfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=feu8cK1R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="feu8cK1R"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f6de72faso25396125e9.0
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784546000; x=1785150800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H1NFMcKXYuzXaxaQU8El91JgTYMgKu+lW/CgUv6Tnew=;
        b=feu8cK1RF5wnb03lmA81rxW0RFiaVorwZiHDD6rVuIn3yf3lBevFC6DBSIVTgEq+AO
         eDCyd8mytBKwj4OEP33PZE9oknJiGonNs8zEA4mDRk86PfmxmlI1Lg4H5xdMpJ6keSjl
         y7yvEp5MxKnPWOUu/mX0I8NSoOGqRgy7Jm2jwehDaSOpqkKJ7oJUpcyEJV/jNebwdrZm
         jAD0S+4wv1USk+gBZgJ44A7nlmvb4+kFagJvUsQ1HUHwatO7K/8U/ooIpn/w7eGM6XNk
         eG/xwSKG5jN8l+aOSvgfU9fWZcnMkh7rFZ/bwU4oINDZTRdMBwKBO04fAlPALRhzHjlE
         0zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784546000; x=1785150800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1NFMcKXYuzXaxaQU8El91JgTYMgKu+lW/CgUv6Tnew=;
        b=UUM7oKTwurNB9zXt2gU/XENy/Tz1Dw8Qnxj/tXtw2wspOooYy2T/PBIBLuBYThd6l2
         aYysWSihsSVWz6OcNguceJzpZ/byajE+2Usm70+7YD2MCnmygEPxGTo38KZP/eLrPlOD
         pULiLRsq65bGBMMweljIVLN9yzQk2SCDvdziqJeH14yGI9kpvG7Kp2vIk154tB8hQvbw
         hjcwqqrcANTyR1kMqvyEqDJ4LlN40FjrVmZ67b6yglBhOzkzwzGcPjK9pS6IwYT+5Aol
         rjCQzrIzHpkTI3lq6WHjMcRVaX0dK17TMCbrs25IJ8oVKI8jJ6WeKpwZeeGZUEwGaCB0
         OFkQ==
X-Gm-Message-State: AOJu0YwmCM9uN/iH1GK5DLIi2TC2e0F2YnNf9rgTpAms0n6vygDBYzWu
	o7pJdrVLCOk/PFMllDdAe8SQHoM4LKODXAkwZObEtNvEm0ZdQXxYBckK0nZE2BIQWBU=
X-Gm-Gg: AfdE7ck8lT51QfyicYEkBqEUJ29Ydp/CegNQJKEgEepMttuFyliHIV5j8iDLc614OE0
	X/QcWvc2W97DJ7T1IkNyKfk9wQZRlcu7g1ATCICan61Weo1KTli6hXO+gnYglQ6/xNn7sm4LkJI
	Rd0ovS4WdMybfrIV3v2pUXrG2/cEEy2GXpZeVM7PotO85KeDeq6WEWYA1fswcJ2pA2C7C71BufJ
	+5C4pYuyCgm/emJKFcDd9tt7MR5qh0j0NPnoudtsUnhq4uODALSEYbNm9RuPgcxnJdWhyZKYp27
	EGEM8rirrkZY0HZnZZSzbRllzE9AzkqEHj0Lw6cYG9C7/k1LQ6DHQc56hjtu2NOqGjGZxEFMQP+
	gvOt80msMXUSSb+1MQFQeBiR+pinvenlAnWds2WC8hatrYnPuQxvnRNbs8dAwKn4lAA==
X-Received: by 2002:a05:600c:c1d7:20b0:493:72d2:e96f with SMTP id 5b1f17b1804b1-4954288df5cmr171932965e9.5.1784546000471;
        Mon, 20 Jul 2026 04:13:20 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:c3e:cc5f:6c4b:db0a:5d2a])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-74757fadbf6sm7460338137.6.2026.07.20.04.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:13:18 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 20 Jul 2026 08:13:08 -0300
Subject: [PATCH v2 2/3] selftests/bpf: Fix lsm_bdev dev_t encoding mismatch
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-selftests-bpf_fixes-v2-2-b450eda93dfe@suse.com>
References: <20260720-selftests-bpf_fixes-v2-0-b450eda93dfe@suse.com>
In-Reply-To: <20260720-selftests-bpf_fixes-v2-0-b450eda93dfe@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1784545988; l=1917;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=fDUCloBgZ3h50EKFxHyA26VB0Ps+hh7q6obHHsVQWEs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QD695Q3bxFCY0uVIShY99FerYeiIhnmO1vB3cAjTjpuWOQF5T6LwO9iIHhz/9gAQKnSqXo86600
 bkdUSNqC7fAc=
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
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
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
2.55.0

