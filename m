Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A04395AFB
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790451625; cv=none; b=rkLVtaDP+HtNAa+Y+l3xLp+jW2jdd7w9BleoriOaAQwWwuM6H8mh5NN54mEiFXQRoixtYgPNE/J0AoKOQxEGQ7O01DDnBU4Pa983LskdlMC4xpaf5cGPWDFNGReTA81bfLdZCtpmYwLJ1+W4vtMyqel74XJ/yWiXL8E6OeU2UgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790451625; c=relaxed/simple;
	bh=LVYPylbZu3M6VrXkQZcoyGu2621tAs/rWNxgexduWm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrTn4cBCAHHPuSCJt/dBXFh+tEzmvzcEB6EK44f5Prv5VQ/XHLyLW+ilb8aW9HKaN6h+hAIPsoCAYVxWNx5nHCJx4zR9GbaEj1vLqynTfw1MolnvCAExFDwATWMIPDVPjKAkK1tixW+VAI2GTH2ecMpQgLDAFtspeBdqFtXjTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pq1Vd1xr; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq1Vd1xr"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c4bf3dedf3so1255508b6e.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790451622; x=1791056422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YKtZQLrJoNL1FhGmGKsD48Cotqxaqos8u7jP6s8F5bk=;
        b=Pq1Vd1xrlDVKr9Yn1Up9HGTyGRvbsWvMRw9jhJlv8NQw/PaNDhs2NIuSSYi0G4h2bU
         vocK3hlTkLVsq/Xpk/Fgltk4MGjDTlzBz4DCduXIyfdIoZYho1liY0oENr53wSksf9Gl
         auh6aPisnXLVsuTNzv/wIpSVFhDaLBfQZYmsV98YbW3mKncFwmiPSxIUzJLlzmYaFkcd
         BpdvvdxBlT1PkSIbhyj42/L281Q7+9bTRW7+51dZPsw80IbSQqvYyrO0NTmXFzofPxn7
         dpeGcCLC7Gno+LcYIaqM6Ba21u2auck1wCGK6BC5Z+sAJOJNug5ZE8ezhiO8l5uiKDHM
         b+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790451622; x=1791056422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKtZQLrJoNL1FhGmGKsD48Cotqxaqos8u7jP6s8F5bk=;
        b=M72Sx2/7/F1sLejFEpT3KVPb1ryHRKzXTLqY2X9THywVB13Ig9hzuxibbA8g1CaSvl
         7TRz7dxVnSMQl416YlKt4hpDGQ2yQO8fVJ+aEIzKMsB4cG0tuReobbWoZvkmm/h+IB+Y
         uIIb/cLOjdW5+uCg7XZ+ZzXDBPeTQO2wjOBdybDz9syEuFFS3ONY/zr67Dn8+qrtPwqE
         EKhdZwj/1rIeq2nfGxg2Lw/sI/OMQCHq75WYZe5uMfWYLUIYZUYGHjgAWd23D2XJ4qp8
         0V8yTR51kivWfVQFT9k7UmD/3DvCTCHsWcZJdgBCMIeEXSLtAdvAmh55A1ZuaJ5glLvL
         FJbg==
X-Forwarded-Encrypted: i=1; AKwUvBwk9jyKRDkcuZrW7nUPeA0eIvpg5UDWRT3zQvgyFiaqvSRGFMQsOBuaw2WLiwiwzAr1ufU=@vger.kernel.org
X-Gm-Message-State: AFuF++kyBdsdYw15qqoeF62OZGM4f+DPpyBx8Jz9X1YSIxaU6bb8Ytr1
	IbRqA3ijK6gZm/N2zftHga8SI2icqlgTqnNPLRJUfZOpyMhraJS3S3aA
X-Gm-Gg: AYBFou1NnKXYKaXeRT3J7nXc1zLExDmjl/iJNBC4lq836YSnLe+YXaTyn+2YVky0Ta7
	ciRffVAI8Dr5kJo+jwajQ+xA9M5UvG6v8Tr9c8pqKDCFFofpN8ZkLrx62CkE/3HEaeNVeGiosBE
	IdPiELs5P52VYdywdkeg77SsITOIP9PlZXEt3QX+q6KCY/6RGaA8honk2NuorbutiTatoUNysbs
	sK9vcBWBEHvrCwaoN/GImDLWlY3aVPIWB/EYxPjZz364RLVguIfotmQj14XptuQCLEr2aS5QxGK
	DPzdl/Py+Nzqe2Gm7Ic2ScnEPUyZbPg8vT6OKmks7VrTu5k6nJepRF29aEfX4LCwLfM2YEdBZWg
	rIT8+2PjQD5JqoAd1Txt9S+9LCUZruKgiPGg17Hql5hYW7TNxef5DVtidA0HT3YlJkDy3/3xUF3
	tMrEb9F4PVaGWK5Sx1zJZgbAnShzBEu1IjUKNcDAcgTBG0rfVn9pmzgNunZtlQdsYylJN4xaCwo
	w4efP3Tl0O45CgwTfrB5P1NFwbWTmz8xJ2tJe8jnQ7i/nQPzociqf4WgTSJyRMOJ6KaDwm5cr9b
	dwrxi5HpGo24P9Ay6gI=
X-Received: by 2002:a05:6808:f03:b0:4d6:9222:99f9 with SMTP id 5614622812f47-4d72ea5f257mr10775845b6e.57.1790451622482;
        Sat, 26 Sep 2026 12:40:22 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-49335011458sm5955595fac.4.2026.09.26.12.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:40:21 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 26 Sep 2026 13:40:14 -0600
Subject: [PATCH v6 3/3] kallsyms: Unroll 24-bit sequence reconstruction in
 get_symbol_seq()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-ksyms-tune-v6-3-236620c65e98@gmail.com>
References: <20260926-ksyms-tune-v6-0-236620c65e98@gmail.com>
In-Reply-To: <20260926-ksyms-tune-v6-0-236620c65e98@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 bpf@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790451613; l=1647;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=LVYPylbZu3M6VrXkQZcoyGu2621tAs/rWNxgexduWm0=;
 b=dNUj7m5vUOsr5ayzqUGXa8mCtan7WqpvOb8CSFdlf7x9KECVTvRON81QIFDLKFz2EcF6imX17
 u3cQQFthy5FAaXBk1SogPOhRT8cnneAmJILB8JSWnHkrLe97OdyfQm5
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

kallsyms_seqs_of_names[] stores 3-byte big-endian sequence indices that
map alphabetical symbol positions to address-ordered symbol records.
Currently, get_symbol_seq() reconstructs each 24-bit integer using a
3-iteration for-loop that shifts and bitwise-ORs each byte sequentially.
During binary search in kallsyms_lookup_names() and duplicate boundary
scans, this loop introduces branch and loop overhead on the hot lookup
path.

Mark get_symbol_seq() as static inline and unroll the 3-byte extraction
into direct byte shifts: (p[0] << 16) | (p[1] << 8) | p[2]. This
eliminates loop induction variable maintenance and allows the compiler
to generate direct loads and constant shifts.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v3:
- Added as a standalone micro-optimization patch (addresses David
  Laight review).
---
 kernel/kallsyms.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 91ced7aa797e..52e41879c24b 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -185,14 +185,11 @@ unsigned long kallsyms_sym_address(int idx)
 	return (unsigned long)offset_to_ptr(kallsyms_offsets + idx);
 }
 
-static unsigned int get_symbol_seq(int index)
+static inline unsigned int get_symbol_seq(int index)
 {
-	unsigned int i, seq = 0;
+	const u8 *p = &kallsyms_seqs_of_names[3 * index];
 
-	for (i = 0; i < 3; i++)
-		seq = (seq << 8) | kallsyms_seqs_of_names[3 * index + i];
-
-	return seq;
+	return (p[0] << 16) | (p[1] << 8) | p[2];
 }
 
 static int kallsyms_lookup_names(const char *name,

-- 
2.55.0

