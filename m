Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B412E55
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507387; cv=none; b=RmxpWHdOUBg7jmKLnpZmDwMI2x6v9xJq2+y5825rPz13pASwH4oaRMOEjxrqmrFmjFdUsaXF8YkYJP2WtaQDj9jZbEuQhrR/TqtzyR6d/d49+/f7e2g99pjT3uHwQfmxjCLRpWQ4FWICiFj/2UwdI1+oJ4Rnj9Rx7Xj/9lYXS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507387; c=relaxed/simple;
	bh=TXJT9iyYUzdg6QTZljtzvQS/aIL49N9bifgSNpj1If8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZGmI3A6gG+GbNYykg55Tb15/8dUDhNwpbZVDOd1l7jFCepd26UjmNYwVrQG9Xh3+rMwIu2kDWWvCw3NSUm9vmZ5Hn6hRWXj+0Hr26mHvt+RmXHfU2K+PZt2BG+1+OBD+UGHeUxH5eLYAIvHZq27LimzAfI/5nB937e6dDrgpuIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mtx+roGG; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mtx+roGG"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6969388c36fso11801456d6.1
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 19:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711507384; x=1712112184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YaSw80nR0PPSgnGWkJ5o4QR/A7DyNmxtU4VaPHWDl/Q=;
        b=Mtx+roGGzo77fefiCvkbDhLLi/sfj3kVQYfqlTSsEh0OSvIC9Xdq4nXoacSB50aPuJ
         OMj9OGxjyQToM7K5sKJ+TIHBFupN8+cyNt2rMaWb0bj3xeEf2OfVUTzNnCK4aNzf3wxT
         l5MIGoT5KDFdly8mxXfMO9/kW72g6gPyyuH2Y+4qSDy5j2FHVlkajMfpTlQjAbldXCxn
         KCuM8cAcTGRTamEw62xJ23+ZLj5yH94aBQ1uKLDhGvPSOPAzKBzv6OC4PICl2D7b22j2
         XINA+CGICor8zRCRO3oJ298jRYzNWvvpVeeEAWgPVVVHnFJt3FIwBU2/VfgP1zYiriQ9
         oS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711507384; x=1712112184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaSw80nR0PPSgnGWkJ5o4QR/A7DyNmxtU4VaPHWDl/Q=;
        b=UQ9M4kjl2rwTxmls89tc7ajIlDm61m7+3iahfuLLfCasA7uqiPfSobxjUhTWRuicnK
         lRbhs6PTpGOn2Ix3TFQiClWvkAg/3iBAfldalEPNIAmXtJoYxQBALtfxkOfCF2De2XuT
         n0m95OfVtzskLLIby73gtIOEqfTuyxsxYXX0AC547a8hpdP8/LB2cwL9BAVOkgdiIiJr
         pYpi5BPwzefAT8yRqyBq7mSqvJleLk1cR5lfkNhVKtE9a3lTFua0hxC1vNk4ZWysgW4u
         Wrm/u26SApnISA856P5KhWb/6EqHOdiKnYSQJE5Z0P3K98XAIG0tZbNMW7iGRtCTD2IT
         IT4w==
X-Gm-Message-State: AOJu0YwRIzjBtjgkPZxYf9UsrMHtXAVkTmMzOjylpif9EMnD13pclx5E
	utYRT/G3UUlM8UEdp5zMzh4uoresrRVnjgrmW5adrHE9EAh1B9GdFBWsiXk40wGBGA==
X-Google-Smtp-Source: AGHT+IEGBzcbL4V/hOobwsUr7MKsnMtZAu459mhK+r6Tw2Pd760R9IYfbBJNrYAi6EMgQwabG8bYlg==
X-Received: by 2002:a05:6214:76f:b0:696:7751:8f1f with SMTP id f15-20020a056214076f00b0069677518f1fmr2765511qvz.38.1711507384579;
        Tue, 26 Mar 2024 19:43:04 -0700 (PDT)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:fb35:c49f:ff96:dfb0])
        by smtp.gmail.com with ESMTPSA id e2-20020a0cf742000000b006967565c827sm4742324qvo.141.2024.03.26.19.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:43:04 -0700 (PDT)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH V2 bpf 0/2] Check bloom filter map value size
Date: Tue, 26 Mar 2024 22:42:43 -0400
Message-Id: <20240327024245.318299-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1->v2:
- prepend a patch addressing the bloom map specifically
- change low-level rejection error to EFAULT, to indicate a bug

Andrei Matei (2):
  bpf: Check bloom filter map value size
  bpf: Protect against int overflow for stack access size

 kernel/bpf/bloom_filter.c                           | 13 +++++++++++++
 kernel/bpf/verifier.c                               |  5 +++++
 .../selftests/bpf/prog_tests/bloom_filter_map.c     |  6 ++++++
 3 files changed, 24 insertions(+)

-- 
2.40.1

