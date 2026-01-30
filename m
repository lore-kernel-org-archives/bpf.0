Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748822541C
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805739; cv=none; b=KH9tVlRWF9HqgmG7/WNQxNHzPXH96wniJWE06FsFBYmIF/cAiB6UacQ+YcDZ1OkJsrSqDVqdSPUDeGWK/ryOYNKsKzZSLNzFCsp0EGXrI31JfhOI6pMy1/3DnRfpQevC14nF1Fd1FgUrQ7V08pyfjh8mx7XU2nz25wLNqBWVGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805739; c=relaxed/simple;
	bh=heop3e02D3WwqdV18qZVB53RgPLFjY/zLT5IadK00iU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tutmU5hP8NzaKnAQ7LEWWj8ETYFuDSLjTFREiJOzQwdOZbzhhQzNMfX48NPvos0t3HhPhnlmPdtJFRPkrLSURvioCf7rs8RLIaM0M3JEcmBH0fPqNHV5rVM7nNbCE8I2gFpv3yO82GMXlVQ1P6L6YmJKFYz5N9jvDpwJLLGmop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPlILszW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPlILszW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4801bc32725so19040345e9.0
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 12:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769805737; x=1770410537; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Wvl+Qwo0lcAVioOPUxtXowU0xZw1HSD1xI9yNJSQWY=;
        b=kPlILszWxEY4w/p2uQlALiMQl5HnApLasi6uVBE+eI6s2yxIWaDx6V4H1z5FZ38+ne
         3Y2xcXr4/LdL9p06dMtwsTKsmPMNaIQCH8ZXa6FP/9InLVz9LAyMwok2kr++dCAj914y
         c5kh6l1izC6Het5GZth0D6vWDtsxr6n3xR7RpWpNfGu2cOPWQ15Uye1Prz7twUuCia6k
         THnfapqEn0/F4TA023ENDPU5+iLTTgHWgnz3Jfg8oJfpozRVW92LybqVvEwOEkYxskgR
         9DlL0o8E55DXisb3G+g0rOExSHUJvhJM0iB+5or26H/mGUAlvSEu2rApEp9iei/uK03j
         4X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769805737; x=1770410537;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Wvl+Qwo0lcAVioOPUxtXowU0xZw1HSD1xI9yNJSQWY=;
        b=EB9Ef9eSr/ZYft4n661ssJA5OAofnoeIIaLCsgQEeVJIeHdvKRtmokgPlAEH+kMS2N
         TxVY0J9vYNDSJey5LgRO+TKLU8o3tcsgsEXnGKH6qjNQQdTNdRdgc/PA2Y1OsBgrfbVu
         rh376oLBcBHEBv29IB38eYx5PhMCrpMTrHINGi1yyVaIl3IL9cWXheRz7UiO+0RbkoGz
         dbQSgycokO/GLEoiFe1CLfciv6sI+meojJJd+Th/6qAcbAZNa+Bbck79aDdJGo8ZLx9k
         uCJFV81VRjT4CAG92ryblnFiquZI5tUqWttEa+ZEl4F46c0b2FoDpO1e4lB5/qNRh4PR
         Upyw==
X-Gm-Message-State: AOJu0YxoIMqTNElPT+FnnispdRgCcuW9BT+jT6ZzJsmXvykrpJ5KNIjN
	f1OXVGpb2vuUW+mZOCrezXcxTDeeSnxt5y5QZAPSp/uiWv0lBrCsXjKu
X-Gm-Gg: AZuq6aJplWWymwPM3FsV893VzXpwOrt3FN/4E9VmvFAXa4KVesY+PhvGlP4BXRmpzZb
	pFazZqKDcgGu2RYaOOSsVNAhoTm+bL6WSs70FTeYzH0oWIcCBgqOs+Iu33LVP+kMqYHS0poDgW7
	vW4zIHapxNt6OE1yIsewf0dVpaQiyYIdI2ydAl1ZCVAi/d7iwR+mSvncL/MgPjORyzKOx8DbMWI
	Z7e+W6h7aCzimjrIQCPhoNhclwJ1kDF/rIil9nUnxG5DYEA0pbWxPGoJXmLKZwBpPTvYYkmF2Ls
	GzEgKhfsYWW0GwKf3slRyvWs4oRn5CDtv0PB7zeKeOVT/yzVu3QmezVZpZLgmardM6FJ8qRkXxq
	UrT8vyCBvGtoI6O97F2L8rMKexq8Hknq6ugnKxb1YnGsqVj6fOYkgN8fO52WiYiudTOkofA==
X-Received: by 2002:a05:600c:3b13:b0:480:4d38:7abc with SMTP id 5b1f17b1804b1-482db45f1ccmr47428365e9.11.1769805736373;
        Fri, 30 Jan 2026 12:42:16 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:cab1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee040sm24498955f8f.11.2026.01.30.12.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 12:42:16 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v2 0/2] bpf: Unify special map field validation in
 verifier
Date: Fri, 30 Jan 2026 20:42:09 +0000
Message-Id: <20260130-verif_special_fields-v2-0-2c59e637da7d@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NWwqDMBREtyL3uylJqrH61X0UkZjc1Au+SCRYJ
 HtvcAH9HM7MmRMCesIAbXGCx0iB1iUHeSvAjHr5ICObM0guFReyYTH3XR82NKSn3hFONrCqabS
 qreClrCBPN4+Ojkv7hmFzbMFjhy6TkcK++u/1F8XF/6ujYJzZh+BD7USpzPM1467vZp2hSyn9A
 EzLE1jBAAAA
X-Change-ID: 20260129-verif_special_fields-599a67d10425
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769805735; l=1743;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=heop3e02D3WwqdV18qZVB53RgPLFjY/zLT5IadK00iU=;
 b=c7m+C1jY7ycLNVKt7K+ijvfJV+WTNBGengPYcoUgIS/GUxlhXidwbWk3R9tjyekwewej9orms
 xKYfq0qzAQzDkFs91Zad5SxzPnG087KZgm7/QUETnj6J33Shgapsolo
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

The BPF verifier validates pointers to special map fields (timers,
workqueues, task_work) through separate functions that share nearly
identical logic. This creates code duplication because of the
inconsistent data structure layout in struct bpf_call_arg_meta struct
bpf_kfunc_call_arg_meta.

This series contains 2 commits:

1. Introduces struct bpf_map_desc to provide a unified representation
for map pointer and uid tracking. Previously, bpf_call_arg_meta used
separate map_ptr and map_uid fields while bpf_kfunc_call_arg_metaused an
anonymous inline struct. This inconsistency made it harder to share
validation code between the two paths.

2. Consolidates the validation logic for BPF_TIMER, BPF_WORKQUEUE, and
BPF_TASK_WORK field types into a single check_map_field_pointer()
function. This eliminates process_wq_func() and process_task_work_func()
entirely, and simplifies process_timer_func() to just the PREEMPT_RT
check before calling the unified validation. The result is fewer
lines of code with clearer structure for future maintenance.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v2:
- Added Signed-off-by to the top commit.
- Link to v1: https://lore.kernel.org/r/20260129-verif_special_fields-v1-0-d310b7f146c8@meta.com

---
Mykyta Yatsenko (2):
      bpf: Introduce struct bpf_map_desc in verifier
      bpf: Consolidate special map field validation in verifier

 kernel/bpf/verifier.c | 143 +++++++++++++++++---------------------------------
 1 file changed, 48 insertions(+), 95 deletions(-)
---
base-commit: ae23bc81ddf7c17b663c4ed1b21e35527b0a7131
change-id: 20260129-verif_special_fields-599a67d10425

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

