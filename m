Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C2558B6BF
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886181; cv=none; b=anTYH5ko0aJGfAjO+1AcAVCuQX5yKHZ/CfpwQJ8edHXRY+UR3Dpia29FE3ZafU7QlQGRs1dD6uijxybDZU/15o07sOxiIwjP0Rz2fFXlSiXws85p19bZ60ayp6GT2QXs1RCA/tAoSb+qsTkkgHDbYJsuxaVCJUSXn3zn828pYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886181; c=relaxed/simple;
	bh=fu74/u0dSZzmmVuE4Zi7gyrbWZSwbBdfUg4MAJGk0EA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5oUghFFtjnX8SdxQjpU/kmukHpKgGvcyUx3uePKmjfy25wKfpapcxgRZ1F7Po9Mgo5ixYegChcrYdnPvaBzJcu8QHgdbtjNrorf6uffKX0i4BkRsoNxCapcc/5iwdPUXLmQzGX+6pnCCKLSclELPNWttDKkcP8Uc5LIl6FFZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ3/2R3R; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ3/2R3R"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d91ded8174so38411175ad.1
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886179; x=1789490979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z4O9WPP44EubZI+3XSo+/62wHSud0mIiGdqe1RxU46c=;
        b=KZ3/2R3R0ko5jMJD6GhzlGPmkGZUolXkh8Y+klqPkZaBIz6S/w0SKYR4TFVyFoJPRG
         ZzMsUezvw0Fk8G9BpqqKf178bNnHbsDn/711WR56o1PrGAh0rKFOV++TYsnS0z/2S6rZ
         3i/YygP60jRJMTOrllWp1wi9haL32QUsHdQNnIUmYaoxCebp6YnJSuD9f7D7t27MaRx9
         5/NdDpyNak6t88kK303VIULNzjh5KflAEoid9hD43LcyGI2RxfrQ93896soQpGNGEKmp
         RfyQs4TycN8BQNhNBOHvkYwYzpcvIiwijb1XDkNPwFQcD/EEqn0nV/R8pkImGozzV5tU
         3hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886179; x=1789490979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4O9WPP44EubZI+3XSo+/62wHSud0mIiGdqe1RxU46c=;
        b=kEUVaN/vXC3LRAUVPARPiV0hhobTb4RHIuxRigxzBUUswK/aqzNmee4joCcMoWAl/z
         FhYYcmWA/gp/Ei/3c2kivmlHwbkWLJeSSYM5ZrLlb1nEljOh6ypluMmK4SRDI5fVXUg5
         nwpmuMJjEjd6fpViKWpIclTJ90wlUByv5QpX6bR4gV3lE2RK+9yNtVFTgIJGdGUCnF7k
         7pqRAKT10hxkSdMZUk8mJa59OfdGaQ23tiNNXIp+0vIL0SeewZZcER38EGK6bNMGOrZ9
         ChEjN8qbe+spluB/WGTvqaB0ovDAjeGYWKZno3vZ7RQIUJiEvgHk00dYGWC0wN9TKQbd
         zesg==
X-Gm-Message-State: AFuF++lGf/joElRo0WXwzbO7bcPmvsiv7P2tCpcV1zvqWTZpZDZaw3ld
	/4QM/UzQOn1ufnDCAWIrq8ZjATClHo42fRePRL7bQAm/zrDbPHGEvXIjRP/xO5qLKrFj0g==
X-Gm-Gg: AYBFou2va3F1or1ln45EzBGztJZpYNHKPZXId8f8T9on79mtuxC3TgVwHTprp8O4Bn1
	3u4rTIEOZxWWem+GlAJIcZkXnnV3kQrT8ynUKGa/edDMxYQKWqpHCAaZWakcwVml4YyoPoiSzze
	got20UCwS0ge2MGByeCY9hI9OO6lPojHS9SJ6+0BTWyKZ319AHYz1+3pG7CQHpfFOOwLp4QHGVZ
	wcD48JOreL75Io+7m5LUQWuL0KhBYZLUhse4yEfjaBvLDfqdEMqGrnHjPn9C11jp84WrdEoHniJ
	TSfT6CNwmwEJ3FYABwh4NKLe7UYboz8cspcBh2ABpU+577yafgm34G9FO2adTOiaDUJXsyHNpsf
	2T5ejcYmydfck5Efi1p+qfRLAmYH8rime7T7837IiDjEqnQ89eBBOGM3a94HNu+ZQnECQ71ppci
	H7wWxQ+Nguc1iHxzjSu4RwJkRTlKXTXkMlB0/ZCH7YyxqCBt4QnwBHf2sqzhuHMtg9CjBiOPJbH
	t8hVEew3/cgZIYCkBVIyr1kLlpGvOh84PrcgQ==
X-Received: by 2002:a17:902:d586:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2db125f0cf2mr447180695ad.10.1788886178644;
        Tue, 08 Sep 2026 09:49:38 -0700 (PDT)
Received: from HKG-A3-RJYWAR2VC4M5B7A1.. ([140.245.43.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db146b9691sm61354295ad.0.2026.09.08.09.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:49:37 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: Mingpei CAO <caomingpei@gmail.com>,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	alan.maguire@oracle.com
Subject: [PATCH bpf v2 0/2] libbpf: Fix array comparison in BTF dedup
Date: Tue,  8 Sep 2026 16:49:18 +0000
Message-ID: <20260908164920.108074-1-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recursive array comparison in BTF dedup reads both descriptors from
the first type. This can merge distinct structures and corrupt CO-RE
relocation metadata. Fix the comparison and add three regression cases to
the existing BTF dedup tests.

Changes in v2:
- Move the tests into prog_tests/btf.c using Alan Maguire's two cases.
- Add a separate negative case with the same index type to isolate
  element-type comparison.
- Keep patch 1 unchanged.

v1: https://lore.kernel.org/bpf/20260907131021.34343-1-caomingpei@gmail.com/
Report: https://lore.kernel.org/bpf/CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyWD4xmz3PuBycw@mail.gmail.com/

Validation with a focused runner using the existing selftest sources and
assertions:
- 52 existing BTF cases passed before and after the fix.
- Both negative cases failed before the fix and passed afterwards.
- The positive case passed before and after the fix.

Mingpei CAO (2):
  libbpf: Fix array comparison in BTF dedup
  selftests/bpf: Test array element comparison in BTF dedup

 tools/lib/bpf/btf.c                          |   2 +-
 tools/testing/selftests/bpf/prog_tests/btf.c | 126 +++++++++++++++++++
 2 files changed, 127 insertions(+), 1 deletion(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.43.0
