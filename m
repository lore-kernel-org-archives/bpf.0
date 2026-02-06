Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C239E6F6
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770380425; cv=none; b=hxQ8vymHrqArqrB9ISWAp43J++WsOZ88wDLb4YIk4+w0cx5PUU1vo63YmpoEi9m9ACbuCJi52O9HzejPPvAt1mT85jOKIYzg+pE4mMe9yLl6Lo/mrI8KC7MCBqx8sehi3Pid80e+1Q0xHkgpuEual6BeNUHTV3c2oVtve1zfc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770380425; c=relaxed/simple;
	bh=R4ccREAm7+fKUyP+L1WbpIPwhVDurY2Umx1VS77tRq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b4796MTLjVYf/OmVQlbij2IZhXhZiddKFMlNgSqF+/V9teqRkLld+VVyaPE74hVFAQPN0E34IGF8AuyxngON1p9LsPhi7gsBM1jtp4uiqIMt8/4KU3HlPZTuSakmZV/7jbZBfwdHMTmVncacej+x/YCgk24bn2F1Y5d9NjMDFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMDmf+1t; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMDmf+1t"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c551edc745eso950205a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 04:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770380424; x=1770985224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPUwOK0qT9Cn0VNf/dygSumLmGtU9fWTdZD3I+SEn5A=;
        b=iMDmf+1tfpR98aXEfjDK4Ts2IMMwfytCAcv3cKHhuaETVmQ3AJChrJIzKUibRbQtUa
         2+BDIxfzo/qDFqrD5ltgKchySf9ncttQAbribDBDQszqD+hzZIoLJ1i1SDsL/5+POx5y
         HZz0XLXzVtfjtC7pupwjvpgQ+61VTS4B40U48Nb7Blmc6pmOHjZb/461gElnolgKGgiV
         7Q6ULhxdBs4utPa2RBpTv334fQUEx+c2o3x5l5d8TkRk36uDu9eWyySHzb0o+fkJPaLL
         0foyWtLAsubSSMYRSLCg9tEfqMheMoJ62juFEBGoGTO1NBkwxMnVXFoDGmbrcoTzmscG
         SeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770380424; x=1770985224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPUwOK0qT9Cn0VNf/dygSumLmGtU9fWTdZD3I+SEn5A=;
        b=SsC1pjUYJmX3bgLueTwNyzwom9gHlTqwqdK28fjZD3EtcFF2AiwcN2jdBsaSEOxo6O
         4FXqPmtlydmi5lbdpDg4j0YWvPkcS1ivQB+8jw+8RkGiHzsNuzUU3ed/XUlHHCvaH6BN
         qeKKCMGEYn75N65VuB2c3nG9GUpjNFwJ4WBalXrXDDfDl3vnI+qvNEKwi3sIHC5ASPGv
         AFoYjXQZgxIRykLDE70nEhZttfonu7mAYKnHWTDEZ1ZpDG+XfDgJmlMzU9/D4EFL7N5G
         AhiD0wKgMzm0mQaG+9eOgJdzNb/RTQAwH1eQcxYgJ26FnvvGvHkSTjKpqb2TPpip3dQd
         xeYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIaytauPrrH/lZ43j9L2U4FlauAdzGHgV+q5fM6MDCHFtLBkYuv0xkj4d5TKTyxOTpVlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNoEsBko3/8ANIYv+F3ZItUmuJEBzgA3gU3Q1ZOqgpyWMOIIt3
	OFTmSahg5A4rGiDhCq3bMncEaXVhVM/ZjHmKkq13ZpFaNVxSL5lp+7Hl
X-Gm-Gg: AZuq6aLviLBiFz9oMCgY8cKWS3BrBUpufXF1LF0H/fBkaF16Hbl5taqwRVni0WMNMuW
	nwPyY2CdmztZRA1YRROW41d2xlIuwnVTvcF+NCjTPkFBWZgZTOUad8Z2oLztE2NbC1mXGuyz1bE
	25+ae/jG/mrgugLGS1xlan4s60wfw+9zq1gCtqeWmDLqFeDcGfw5h9ydYUGpepcAu3QE4tAnkRq
	YuznQS1SgUc4PBC+kFaIsQ869nAzrsFWC3ogTy+OTWlMsx0KII2NulbqBiXSerl7B6iUh3gzqVq
	AMh4ECQmDgDWGGQCXurhZ4k//FyMXJgE8/F8/oyo2RhoMJgxgksNIdu2poFR7eH3vAA+M9pJGY/
	Rhm1f55SeLP6lSJj9orKLlM8h/FTn6cqGPGZNdpyKQgcD5gtXo+LleeEu0Hg4ntdw8PllSzRbNx
	DXTjDksmHG
X-Received: by 2002:a17:90b:586b:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-354b3cad4acmr2416618a91.16.1770380424537;
        Fri, 06 Feb 2026 04:20:24 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b301d93bsm1528222a91.1.2026.02.06.04.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 04:20:24 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	bjorn@kernel.org
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
	pulehui@huawei.com,
	puranjay@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH bpf-next v3 0/3] bpf: fsession support for riscv
Date: Fri,  6 Feb 2026 20:19:59 +0800
Message-ID: <20260206122002.1494125-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement bpf fsession for the riscv architecture.

Changes v3 -> v2:
* fix some comments.
* v2: https://lore.kernel.org/bpf/20260206115823.1070354-1-dongml2@chinatelecom.cn/T/#t

Changes v2 -> v1:
* use bpf_prog_calls_session_cookie() in invoke_bpf() in the 2nd patch.
* v1: https://lore.kernel.org/bpf/20260203055231.1088479-1-dongml2@chinatelecom.cn/

Menglong Dong (3):
  bpf, riscv: introduce emit_store_stack_imm64() for trampoline
  bpf, riscv: add fsession support for trampolines
  selftests/bpf: enable fsession_test on riscv64

 arch/riscv/net/bpf_jit_comp64.c               | 97 +++++++++++++++----
 .../selftests/bpf/progs/get_func_args_test.c  |  2 +-
 .../selftests/bpf/progs/get_func_ip_test.c    |  2 +-
 3 files changed, 79 insertions(+), 22 deletions(-)

-- 
2.53.0

