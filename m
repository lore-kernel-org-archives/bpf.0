Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61834D4CA
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836036; cv=none; b=StTRnGiOPHqp9QtUfgl0mSgqmL5VvX9Vy+vLxIoGSn/hHIgA665tsT9woof4zZu5UHPAI4tvLwblcAFzaXrfr3RfxEssAfoh+Dg2ZeOiBL8YtUd/9hTwv64yueHF5es22QNF1RykdGAsKSdGJMZfu29LPlfD6X/pewdFyBW1Km0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836036; c=relaxed/simple;
	bh=dsGJfsX/lCAwZRvqmeMK/TH1AGNiHGT2CsWkKbbh2Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lxou5N2i/Yl6cyKh7porDDkhJDfYMBVN2NWwowh0Cni/SgjLp71UuPaHuC+7RQLrbMlPeobl5hkd+bO4ecQOBMN8Odu2h5F4EpBf3VdCkipngK4DQXSgVgD6gTV/BVBzdOrJFy+ooDV2dnLR2rCIjJoaSM25Mh9kZcSWqwJw/RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqnCFg0p; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqnCFg0p"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2aaf9191da3so25930565ad.2
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 00:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771836035; x=1772440835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pl7yMndGbyVFIY7fGiOCgU/GCIceKT3c7JUljTjpt6Y=;
        b=WqnCFg0ppH8VvtpPnRbwJdj81NVtBvMrb+W8vI5bq5OMPvKkJgyPrIuRm4OBUdABq+
         Az5JpuJOei2RzFChY1pg7nT0JYjj07PX1Bn7ShnWWontK+vyI+R+ljej4dKAZD4Pb0zm
         VEMf9NaqwgbIW+jNOUdqjFnjvSW/dpH1jpbs7KvsDAVG6xyfRfL7QBgaftB25YUCXU5B
         uaM1XI4C60r5P8rHyDp5rFg64xl6kh9dUtrnSpXDTfbAKB7L7Qdt+ew41LPMCU0/yTLn
         sKdwuhg+KFNEFCpM/n+RjzzxfhWdVuvCXTcqoHpQyI6tNErbMQ98wHaO/mL4nrYqq4SP
         F5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836035; x=1772440835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl7yMndGbyVFIY7fGiOCgU/GCIceKT3c7JUljTjpt6Y=;
        b=URb3gidG2/IpJYhAAg2IvDGO0HkSH2IBNuJEFEYla+XMezwdQT7VTQSFQBhMyPBVP1
         k/76tXxVJF1BW7ldybz4FcG78avW5L2aK8DnCm+U7fncEN6pZ0fk1hwYM3GAbmkG+g2b
         8cTiLqELgGdcKGzBUn4WSOQfFOTe+ECr+RrIwNWUOkfSwcM6KUn+zCtA7VIegiG4vr8J
         sG+11lTxWqZT1v7EpSRbUdChV4Utu7f5viSGj0OUS3CJzrlhgnOamZx68nwvCbEavJXL
         pPYK0cI1RgZ4FBfIlWRMBkp1ez0C0cfQF7qNqUI8Wo8Jdg2B5timGUesim86Eq5KZxmm
         00PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrJdLnLnI7JgXds9AwDdtoMGgU6BavdIxIRlVL0/KFyzbymHcA70/PC+eAByW+Y+J5zxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRaeO5cx8zJAQALntN37Y+huqg0v5yx2kCOFmc92hOEK/D3v9q
	JChNVYYhN7LPmSvamt0JCKD9NrnQCNZdtQj24T6Y5IyKrvUbs1ou9kBP
X-Gm-Gg: ATEYQzzfnex5Nvx9iqF5vNg7nv/UtzqtffRf4wgvSmgtdhHzlMExLekCBUnxo6cWC3a
	vct0abV9PJkHJa6EGN/LvgoXw7CHIRXBCW4E60X2oYRgQKY4hVWAvJgYtTWjRt0mOeZlrXaJvJV
	wk0YDZ43tjPSG93sl/bh9YZt6DOK9wKEe2d25hII/maL40xGMSj+UE1XtKKU7ooSWAWFax6t26M
	WVwoJvk4CVkF9C+RgWumhhTOUQImAY9aaWd7XUuHQtZdjVo+tqL1K3QlBLpnpPEoylb/8tKBEQV
	+wd12Jz5dKAIvd69ZcpIYKiBeMxGNaIFhQalAyDg91pxyFukr9dSJsNzgFpCSK1KFLiy5L7PLVQ
	ixMkAC2jYJjAyakrEbRqY3k9HxRm3e0T0WJZSaeE7qM8apUnL7Zx7XUiasRivyI+V2LIPz2jNIz
	5nXXPzrgmgsClmIEZfWu6l
X-Received: by 2002:a17:903:191:b0:2aa:ea8d:a0f9 with SMTP id d9443c01a7336-2ad7455ed01mr62685085ad.51.1771836035021;
        Mon, 23 Feb 2026 00:40:35 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad750591e2sm65725405ad.91.2026.02.23.00.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:40:34 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	iii@linux.ibm.com
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	bpf@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/3] bpf: fsession support for s390
Date: Mon, 23 Feb 2026 16:40:19 +0800
Message-ID: <20260223084022.653186-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement bpf fsession for the s390 architecture.

Menglong Dong (3):
  bpf,s390: introduce emit_store_stack_imm64() for trampoline
  bpf,s390: add fsession support for trampolines
  selftests/bpf: enable fsession_test on s390

 arch/s390/net/bpf_jit_comp.c                  | 97 ++++++++++++++-----
 .../selftests/bpf/progs/get_func_args_test.c  |  2 +-
 .../selftests/bpf/progs/get_func_ip_test.c    |  2 +-
 3 files changed, 75 insertions(+), 26 deletions(-)

-- 
2.53.0

