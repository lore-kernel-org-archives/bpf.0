Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC6329E4D
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771541933; cv=none; b=PC7czB8aJ0tBzMmJPiPWRAvD4PfCM0E5mF9jsS6RnoVFO1mQW/DVAz4M+TorNCAg0vTYawhB3EWsduK1LkvwG8DovItgDaP0Xcz7EkROK5glxYtWo/UfNNPqSAcZQ8rD4gLE1mJnPcGSzKyoMNpzp1hhbFn7LdSIAz/Lad72v08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771541933; c=relaxed/simple;
	bh=+fmL2hnvMOGQECYwZKoazIdyGcgxGx3G6cg+I74SA8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D8wbsnUX2bRLqb7bcs8AkcHGaD4fiP0AqSaQ+8eSOAaWz3ONTksj1E7O2TvqakcKmVZMX73pAeD4g4YwatcQp/bxbz0J7J4ba4Pd8AvE4z4Kv2QPVJZ0xBwhzROfqahuEP6LrBsDT9lJMzPp+VY10HpGh7IyIvrcOyqeIcNsFp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF6CeThy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF6CeThy"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82418b0178cso880825b3a.1
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 14:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771541931; x=1772146731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bvc/w3vwrKRRThkocodt50I3xdPGIFrYWWu+Wd3osyA=;
        b=IF6CeThy4Lrzlt41GEocFI6/ooJN+Fd0ilbPg8ekX+Nqu8EIhPy1i8uMWy9Cy+Q4cL
         9ly/CzlhvGhaafGZ9rz6KD6pq/d+ZKscTjw/tPKkWHZJyAnqocty/1c7SAUnpE6sBAi0
         xtkBeoPPFqXUICR2GF6Wj1no971XCd6jBjZZ0HKvVh4HFzNpuh493mmBWVyWsmgVfFXA
         uEIOpNlwIhC/TuovQh1w4nymOHpquMrBoEfERfd7F3eBhUZNvKkidz7W2h8NYV/0WqkU
         UmvzDA90c3jl87TVCuCeOJy/M4w3iC5D+ZOeH7YZVDw3kp198v7MG81PP+qInrmMgVzk
         fuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771541931; x=1772146731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvc/w3vwrKRRThkocodt50I3xdPGIFrYWWu+Wd3osyA=;
        b=eRZC7kQTBYIRmsnlIw6iMDtv1MvCX6NZ8oNfUKih9P1zMJ+IVMGGXapJwozFW0AaaQ
         HWBSULjILL7Bwvjo7QT7Gg4H36+e0XwdTs3o1Y8VhcPNT5M1EGTweYDsZzF3hKcrCF2/
         mQ+KTHApd2YZshssDuaAUMgHDbFh1D7Nq1g20vGCVsZquc6mGQ+S21oG4y8562QQm5E2
         ovJKDvlJyHUEXN1mw/8jEvJlfIIZrXClR8XbF4doBq8KJHhI2cLQH+C103dhM7r4l48G
         IX3LRVOcyCJ2U9kBaPFxkmboQw3CJD59Y5THku8rKbVwK4BPOImZwLdZudTWoqBchFbc
         9xrA==
X-Gm-Message-State: AOJu0YwBGhSjQS4+nu195mnQjRVADJfMDA0QqzlbJ/dfXMtzo7/6qPr1
	uMXcIVXYOxHtcFuOCX/FeHAFPLbP1iG/P2UmvI4rdmRq/TWDK0mnDUYPq2EPkQ==
X-Gm-Gg: AZuq6aIgoH/Ju11sma4UCmsjw0cOvmhsQJi51W3o4asS7J74h1V6BgDYhvqJiTKGbe+
	D1TTJA/9plrkzcb339Kcn6ERrkIPRYMjTLx/TWFAh1cdXd3m6O8gdNFyLO8XGalKtlc1cj8hTQ/
	nm15lI4Rq6KWpYweK5/zbmPnWSRD3ZUbmtfPLn49Q30XgjEAG0fmN2wDOx3NGkiuh3XbmFO/OGQ
	s2tldwdKmnAWKOiH1kNzB15zc95IQ4/JqX8+89RwfTqd89SZ/OgHobaQBun1JnL6sbNCzRR9yCd
	B4A+BWPD3Mj3eb1vsXTzdFIjiDkJiX4BOeZ/6Phu/vW3ZoDWw4PlDrau6eX3mPvDMjlFuP5MgY9
	pPscx7GlBkFU4Iu82jlEgsDjkWWmGzYF1zm58Fb8GyuU0JXqVh4DF7t4r6+axO9bHkYTYhly+RW
	N0Ja28+i1GkKGUk2cZH4+GTbB5
X-Received: by 2002:a05:6a00:218b:b0:81f:44bb:8aa with SMTP id d2e1a72fcca58-8252748906amr5527383b3a.8.1771541931203;
        Thu, 19 Feb 2026 14:58:51 -0800 (PST)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2ac83sm19196160b3a.12.2026.02.19.14.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 14:58:50 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/1] selftests/bpf: Change task local data library license
Date: Thu, 19 Feb 2026 14:58:49 -0800
Message-ID: <20260219225849.2426421-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the license of task local data library to LGPL-2.1 or
BSD-2-Clause to allow it being in a wider range of projects.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/task_local_data.h | 2 +-
 tools/testing/selftests/bpf/progs/task_local_data.bpf.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 0f86b9275cf9..b91fd3bc4d4d 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 #ifndef __TASK_LOCAL_DATA_H
 #define __TASK_LOCAL_DATA_H
 
diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
index fed53d63a7e5..8b6f7af43648 100644
--- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
+++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 #ifndef __TASK_LOCAL_DATA_BPF_H
 #define __TASK_LOCAL_DATA_BPF_H
 
-- 
2.47.3

