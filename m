Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229562DEA6E
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 05:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502681; cv=none; b=WuPsz+ZePuRvNuUiVcMw/NNxa1q+1MsGQebxlGwixij5YUPpHsMhpG16iR5XDaeS3wHc4+RsYQMwWHhKCaCLLJPZ2gDqfGlA8iZSGULTWWeQi3elwrwHnYSLIvREDFRoZD25duvrRoATXAMNVW5E+mUhTEMzp9+VW3GePA4azgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502681; c=relaxed/simple;
	bh=/7AsEUMa9upKVrr5vNvDQcfx0k3cC0UMUkcg0kzYvkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZxLn2eDdLOJVas35g8+9eVTa7tpF5JErb0JGUragTXZMdX0bNM8VLuEcaWehiFlnvETL4ixUmxfKx9sfZDL8liQ+qCEW+pH2DLY8RurT/QE0dNixNw7zDfVd9cM0YrWvnC/4ZSMWcAVyLKYo6okfl1/YtcCbgYQOu1NFqGiUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tEZYqSjD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEZYqSjD"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-829781b2b01so352387b3a.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 22:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774502679; x=1775107479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/S/pqds97SSYE9P+qlyyDLoL0WyHpSSQS41ZVb51Y0=;
        b=tEZYqSjDFWmizPb1urIoYMElvCVXrbnzU7FlIDjnuz2h28TmFbxHev43jFmiizjesU
         mGe9sjybYFbkA7w5AH9aPIDb9ng/1JD7PXZVwUTRArcqpC+ClAVBb+Z7v2XV5c7ZzS0M
         c6qgSHJmX7gTsJ1Zb5hek++0lu4pOYZHuArMAW7+yXvlCPo8v4bBbrKzzbuFutabkeIO
         vvBOEKqfegLXNkEcLA4B3JWmjcGDHblC+lkt9V1qgKNzUk+bMFeecZGHqD+Ecb7I4JaA
         H/ouggR6pi4NhrpmrShZCVpkzP8epKF5XplKKX2D9o6/AZ8jKszcQjA7S+Atg1cbIojq
         7euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774502679; x=1775107479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/S/pqds97SSYE9P+qlyyDLoL0WyHpSSQS41ZVb51Y0=;
        b=Wt5Cb/smuB38iyZRlGHsxpf8RBycTSiP6vUejcqVThC0K/iGNvilcswfwmLuj72BgW
         qL1FgQ7s8ICyctdxDl4Cf89e0AMtfIiRpadYORnWGNllKBUGYbyvMxzuBECVyLnTvxTk
         daEDmiz3KKGeBQDVG92bsCYUeP0P/ElPEJZ+eaJUv9XMzTeXTvKc9Rt4XtHl/prmrnw6
         ZaY0KlccqjIBkOWJl919j//Ss5AQjGOF7Jjx1CRVgt9QvMQfadT+7mldqLYaUgvbKLM6
         9YOL1NpBMcqaE9h+hjOb2IZSFueCPw+TziSslu+jtiUNWB/w4YisXeOFYO2DjFWKQUSc
         UzWw==
X-Gm-Message-State: AOJu0YxJjPdAxKYCdH+dJiLlY/j9iPw7wmhhN1Uxcdb1d8OXjVF4jqMy
	6I6cJ5z2rczZ+QPfEP+Ol+pPJUSLedzsMkKPyzqfSRaIEArXYp/l8tp1rjrB3Q==
X-Gm-Gg: ATEYQzy1iuzLeNbAOcnMvt3kv0zB2e+UpwUQ0yGlSzBKUS1rkOqCKZdcAba6NXz27yD
	u9nvBOQzaSJ/of8FoHGJXLAeyeIrZX+Mxwin7dxInDoGMWyYYPCMXGgq02Wk+Cu1uNDLmHFTk6f
	m5gP06c0S0I9H4KApTtMFFgcEs2BVtvxmLAoVJwm1IjdzbabyfPwPFeTR5v6/H/OoiUPp8fkYFd
	fDorJDN9U0lJoQFnZs30QDw7Vg2e99ckU/+70vit8i9Cr/F69Vcr+Hy/gt0/0nWEPUWaq8JSpC0
	M2y8+dkw8TZTr30V0b0E11tUu9qr/z0rubPNH/TzDVxEw7GS06qS8PmP2TGcZxLainKPoeblhW9
	6xvEFZWfSR2f6nMCcoeewAHaD2PhyShgjLmczZbu7FKab5gDTBok1vO8lm8XssyYmLLz5/YRIT5
	92C35pSiJnzw1nxA==
X-Received: by 2002:a05:6a00:1bcd:b0:82a:8873:4a24 with SMTP id d2e1a72fcca58-82c6e0cc266mr5600053b3a.42.1774502679153;
        Wed, 25 Mar 2026 22:24:39 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3888e8sm1406936b3a.39.2026.03.25.22.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:24:38 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/3] Task local data bug fixes and improvement
Date: Wed, 25 Mar 2026 22:24:34 -0700
Message-ID: <20260326052437.590158-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset fixed two task local data bugs and improved the
memory allocation code. Please find the detail in each patch's commit
msg.


Amery Hung (3):
  selftests/bpf: Fix task_local_data data allocation size
  selftests/bpf: Simplify task_local_data memory allocation
  selftests/bpf: Make sure TLD_DEFINE_KEY runs first

 .../bpf/prog_tests/task_local_data.h          | 66 ++++++++-----------
 1 file changed, 26 insertions(+), 40 deletions(-)

-- 
2.52.0

