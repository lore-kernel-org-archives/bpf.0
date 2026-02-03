Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A2367F5F
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770097970; cv=none; b=ea7YQ++gLv+m6K4xY/raJ8JIy9RekyV2EwLCYy36F1n8ONARxAZGuLmPaqArJleXvzMRg2KkhEqB7CBAUADzJbkmsvWuOBod8hbPYThRMZJ1q55UoG51sChpySUh8E6Ddacml4EUNyPMvZScgMa7U68QkwS/V49NXyzHUWjiZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770097970; c=relaxed/simple;
	bh=yzDizzITTQql65fTEubvbsJ5lpQnjt1QYEOYOAT7KQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StbZ5hByyZbjCAgk3pHslstfnyIPdqZ1DOa/83S7PQzZcIdXXXi+Hm2qZu+bNLiD9I4Dr/rql9vUgglMfFt++8n2wuFO3C8gCWNxVqkM3suu5bJvEOQOQNtbNGtaYY7/vRoABMh++9N03OMw1yF1LizUEkTFVFYHw5FO6jkoEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6MUTb8I; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6MUTb8I"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-894676e6863so61661656d6.2
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 21:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770097967; x=1770702767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBKc55eZpoTToABEyoP3jfOIFdx9NoLGQDjzruIsB0U=;
        b=i6MUTb8Ivp90NfT+slkVhnbosP3MQf4QBeObdPbWxcJ7RlFADeCXJdwdOWJRy1oEgb
         Blryy0Mfa+qwjmMta1Q7fEjMsw/QN67JEUi0X/qz/BXR45oYUi0XnnyqcPEGZWzT6TOs
         qlMFoPUyOfELmV7nG8cG7WAtKtxH/ik5yV1H3aThSE3JJZUt4ASgof3rvyiO5fnJ6MPD
         g1WJBmzwM29sRrq8N4+fMBz8mYz4BFGagh/DrPuXmxjBBjWtk+su8CNpeXpMll9GaKFn
         Tqh0K9SUGqIPhfLFhHrHj3QZCdDO4A4+yJvrdFWtPj7Me0+llfnRpacJWNQS7zcsjDqm
         lVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770097967; x=1770702767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBKc55eZpoTToABEyoP3jfOIFdx9NoLGQDjzruIsB0U=;
        b=eiBmc9uELYPMVWnHmvanOaYT9h9oABDFQxKUi4zD3t/X/oPGGI8PlVkmNsMcM9Omp1
         k7aqPBYfYsPUXrGeFPStYsJhn8smmgPsoEO1RCUY9kjWyikDtNNNs4XN2cli28FEGiVN
         Z8A4rfbDYeeFrFLxmXT1ddOjeuGg5erYnIgO9PToKMFlurTABoHfSMObqQzOJZ8Gtl6D
         f6DkoCZOi8Nh/iye4NL+R6kdY64vEsKB0u/mrBDVC899X7ilkLnLw+/G+hiuteZTKipb
         CqECtuHIiCEvXDebqT7jd/ZsTHle83hrjZGE+XwcuWHozOKQQAXmN7kZCi2eOuiwbrmL
         PymQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtfyQcnbfxSaN/Zddr587/cQ2PVn2eKIsvg7zBIDTCLwCVrZHfRoyyd/9AHRJFQYDN+lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDZHUvKQC/nLKBEzCRLNPcGHh+WvEy+mHD7Zum6pye27G4U+FJ
	a5Xrjj9eFdwY4sBAn+fQKeaeOedx4ez+omwXVcmCRvbeKA7pVZxVZLCH
X-Gm-Gg: AZuq6aIfApEJ7VuGjINduL7PP8kGjJT5+6I3FLwXlpWfcqTTE8HXtWij42CMXMvP/xw
	9X9MQijVSatJvgvpB7Nu0iQuDvi2z79uNpDBGER/u52d4jaQZLyujoYM2VD8ELVDP4m+MktpB16
	XwpJv4GmuY9MepHEcQ3IJXxnOG90mJvEVHOQtEtBtm57NvHioU8HMiN+xCozw+uIEI4bF59s+aN
	wjdJ7Sc+D6joTohUkF8oq81SELBRtEL8iGoZOpDzyMki1NSYL2qq8grBE07mzRMiAcWxC+dLVR4
	47piI8h1hclpjgvOUNqZQITEIkp8wydamFYvqM7msBNUKmoQo6fxxuWrrUqgfFb2PMYSAovt6uC
	7MmZOp/rO8YQpjRTNZGG0al/UU8Bv/aIAn8hfbponEJbWlLct1L54rMo9WlYtmCdCFwtkqK3WVL
	Z2wz7rLNc=
X-Received: by 2002:a05:6214:2467:b0:88a:2444:36e9 with SMTP id 6a1803df08f44-894ea0a7b75mr196311776d6.67.1770097967508;
        Mon, 02 Feb 2026 21:52:47 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376e65bsm129844996d6.55.2026.02.02.21.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:52:47 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
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
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/3] bpf: fsession support for riscv
Date: Tue,  3 Feb 2026 13:52:28 +0800
Message-ID: <20260203055231.1088479-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement bpf fsession for the riscv architecture.

Menglong Dong (3):
  bpf,riscv: introduce emit_store_stack_imm64() for trampoline
  bpf,riscv: add fsession support for trampolines
  selftests/bpf: enable fsession_test on riscv64

 arch/riscv/net/bpf_jit_comp64.c               | 92 +++++++++++++++----
 .../selftests/bpf/progs/get_func_args_test.c  |  2 +-
 .../selftests/bpf/progs/get_func_ip_test.c    |  2 +-
 3 files changed, 74 insertions(+), 22 deletions(-)

-- 
2.52.0

