Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139A370D57
	for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783837744; cv=none; b=dn7FhmcQ7U8ZOS8ln1taFiPIpInwMPZK3NF8KTUOzx5W07HMHa+dMvzIWplWdQSixIhRseJu661Fbc7vggl0Mq3eEj/kLkt3fy5Q3eBzdUN3FTzPXzOwjNumeTUjNB77ftGItJ55qUXXsYOQ08/hV1FDtdqOalO0uTJCm8gy92M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783837744; c=relaxed/simple;
	bh=SzNSH/ApV+5phKmZ8GLch+beFTGjzpYgLQ2wZGt3BG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjpYmqYBu7l9iDfOjPe9ltLC+1GPhU6MZF3211bd4Df7tFk3zVLx9ruJ+AuKGOSFx6Xpmohk7Th7NejCn2exUhlOMUnOUBhgQ/VWkMrBEwcZNXh47JadKn9pKMBVobLrDskw6GXzZshPrpdHDq1CTC/ZFleNVAgr7Rb8GR/R8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N79kYKMp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N79kYKMp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cca0c5799eso21751375ad.0
        for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 23:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783837742; x=1784442542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hjwSzWHZkBaieWrPz4xe331bsRxr/TLAJPfCcfEtcQk=;
        b=N79kYKMpIcepykGnkITD30WpDHT5YyUMSGv4NtU3vGtPQ9Xt28J9mYTx3LjDXJmvLV
         v34jrZJY3mtvQgexxUHW8CBd2ZUcGMESXYmntZA//M9ZiqfwA0X//YLNeJntqqsX39W0
         /rWg2K/NBZpnwUKcCBj1+piK55iJfTLNdEogUOOoBEsZGSekMcCv6vFtH6AhwjO0tMc/
         LZVk0mfRXeOTM3xk8/kb7KhtoUFuffMbT3Euj/42+3sB5J0B4Z9KS4C/iLWcGlckPJtU
         Hs7jDQ5LExXw+6DgDHsd51ZkoEvBNQMrFe9CGEd7QdAwg2YnAYnnMQv4ZGu2ZunpcihP
         pjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783837742; x=1784442542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hjwSzWHZkBaieWrPz4xe331bsRxr/TLAJPfCcfEtcQk=;
        b=gDczmBsHXnkGv+D2ErD5b37A8SNLts4xmTZfO6Ia346cyJCfOoiSu9cJASQ6g8cgB1
         9SQhxQSsf3l1vtrZU8j4QZ3OxYlcZzZhvZzykw/F5ryewKnN7nBFHhORbN/e+qMCCfQC
         PGUHsF1cg68aYEuXVIR2eJhR9kUZWk1xFTLfHT6mDS02E7DZscAj1z7JEsMxmvuj328K
         q7CIc2NAVbvEOXVve88C3gl598o29UUCeB5RuIU5m3kJQqB2ir6aIsTcIu4b1J4nkok4
         7heKAxqNuPF7wbCcEN6xJnJNjN0QqmbLUIdzQxvWSwGRm1dnYp8cIL8opR323Q/DWaUo
         KT0g==
X-Forwarded-Encrypted: i=1; AHgh+RotoRFfilUlIb1fjMGRkQT1sYNUGcUquUDpN5EiCcFPD6WQoRz9Ttq/o2yztJpYR0U6dEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk2qyv9qvEB4Qv8FvYI+d1zbrXopPvcNf2birToYs1Q2Md+ttT
	rpfoTzRAWkN1dUmvj9ZaCD2CIiZuWx9RWkJbB+7kMQt6xaN1HQ7XWAc/
X-Gm-Gg: AfdE7clPyAQ71aW6XY7/FejEJt9MJ1gPl/GDaV1E6UrMleOc6K1ACYF9Pn8sEtKlq62
	yMLnP++t8xK+fcVbg76pphrEZFyjjkNXSsACtul29s1sB/A1Pubb2+4YGNriACd52JM8omfOl5a
	RO3ggxL8uoDTtminq7UpQN9xpqh0doWtb87++y07pVTgx87IyCGX5vNNv8NhNAzHyg/opu7Z3+4
	9stfydVPH6g01iYTRrOI4UoI3xxIDkim/wdgz2eNDO2YMldCdnmlzLEUa7aBMQr4/8GS0k7QX4Y
	VTwgMURjaHLwOhJMmqQplRlZm2I6iEdxLUwCOsgoMh6p1mcsKmfFGhpMbxqXbYR0SRqPw4131sx
	C4+efbsgi/vUMs2qae7fkGt/aNd/m1vGEnG/1BJ9mdcMCh1xBaKoWHhqJ3SShlFZXMb6r6b7Rgf
	9vgOkz8l0YRVXivKlaA1q8i/fChouiLVvNbqupvMonxRzpZp0GyKG46m/Um/+yliKjI4rus/dC5
	VeUwz/i
X-Received: by 2002:a17:903:b4f:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2ce9eae29c0mr52294255ad.9.1783837742311;
        Sat, 11 Jul 2026 23:29:02 -0700 (PDT)
Received: from localhost.localdomain ([240e:46c:a300:12ed:a5f4:d452:8dd:52e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf8f26sm83270835ad.27.2026.07.11.23.28.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 23:29:02 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: nathan@kernel.org,
	nsc@kernel.org
Cc: linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] kbuild: rpm-pkg: append %{?dist} macro to Release tag
Date: Sun, 12 Jul 2026 14:28:34 +0800
Message-ID: <20260712062834.77872-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260712062834.77872-1-laoar.shao@gmail.com>
References: <20260712062834.77872-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the %{?dist} macro in the kernel.spec file. This enables
building and releasing kernel RPMs with a custom distribution suffix
(e.g., via rpmbuild's --define option) to better match production
environment tracking.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 scripts/package/kernel.spec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index b3c956205af0..c732415662ef 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -6,7 +6,7 @@
 Name: kernel
 Summary: The Linux Kernel
 Version: %(echo %{KERNELRELEASE} | sed -e 's/-/_/g')
-Release: %{pkg_release}
+Release: %{pkg_release}%{?dist}
 License: GPL
 Group: System Environment/Kernel
 Vendor: The Linux Community
-- 
2.47.3

