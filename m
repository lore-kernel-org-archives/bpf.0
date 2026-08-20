Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1ED30D3E8
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192972; cv=none; b=SnhuK7KWv3vlrx+KRxD9vurRayDarO2KCRKjx4bgauO79n+2+jDYlriYSON8UoakyxwRdFSp7bjdqM/fv11W1rPfWzJcGL6ihqHQIJbkMWHjXAbRdCfQzN6sHlY8M3+qmUaS5a1mVC4GccDbXHzdN786TAKBGr02aHR62omTbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192972; c=relaxed/simple;
	bh=IAnSTxiu+n1Jbcww1jG+ZGQ+aSqKiCfBQJyelUqaHZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4wPD0/WZSYword5aBfYmohlSKIl1z+L49Nru03Acw4BX1YdSakNf+52E2C+6LIZEhJqCSk1yqdeGK5EsfwFNbYXXRa5GqVAsZlDYqQISKsJuAknHjdEv5dSmbUdbty2dyiMn/TChDFryBGEQ5E87fRULjkC3u2EyTAB+t407IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=wuu7Daq4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="wuu7Daq4"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so21519705ad.1
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 19:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1787192968; x=1787797768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IAnSTxiu+n1Jbcww1jG+ZGQ+aSqKiCfBQJyelUqaHZ8=;
        b=wuu7Daq4R9qF2abUc97Pety3pvA7bVrzHozL7gO02dAZ6Bg+fuRzCF7PAuRFbtehQK
         6GesbJJ8azDRknpWlJTNZ52mr8dxcP2VqZud3preTtRSdMpt6hNSyZjeq5fWut5bX8/v
         ykn8UzrE3ZESpn+n8uDVf1P3wxZD4PNp+8FPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787192968; x=1787797768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IAnSTxiu+n1Jbcww1jG+ZGQ+aSqKiCfBQJyelUqaHZ8=;
        b=SciJUEIVR53t3sEdXAykPTKAVmmxEGilNrNWUz0/22SY6OAu+encEPTrm2YyfxY0W7
         HlnxuJzygLDdcp4j6t12e6ebYgxW/k6LFthZEby8Gu5mFrgUh6fjR0f744IktXErtX5v
         /eStUNxsuRWf9id943wPwHzGIqdwohdf4yFoJdP4U6NMUJ0JnG0WDroMA4h42leMYSDa
         41l5NJTCJc+t5jrqLAEx1UyRaXlId2UOjWeFwS9TWzc25YDeUK+hdRRwnKQwoIiJSUJP
         +9OMtKeoXYlka5t1lBaBSkYHusTWbtlnO8MkkFF4dwgYS6ID1IOfZ/93MW98wRsfVte5
         b0xA==
X-Forwarded-Encrypted: i=1; AHgh+RrAHX2Z2NGmOvMz+/DfIg58IHNFAyg5DhNKJ9rBCUhOwrRh6tZHdMW7tE/OiCJjpaaS0Tw=@vger.kernel.org
X-Gm-Message-State: AFuF++nFsOzHFmh4sa/njYMQtFZKSEcCHpeMr0vrOaovSuoqoFSzPEJ9
	GNoX0q4XZixJ1e+afcnjOSzZEUv/aq+JK20vpvF9zw4qf6THsoDjQoSXJayI/hO6kxo=
X-Gm-Gg: AR+sD12x1U8H0rggyDsOQItRqYFSe7izj3WgDGyWt5PIJJAJYI7EwcHg96FWDReNGeo
	g5cB4fLj+2y/cNEVQUDmJhYUeuXMXS+uY5XqDTASDXkCk+6So6L7CXMks/M6crf8XZ/+GBH0b2d
	G/NuERuxt3EmdlvoP5gET6QRou7R/4sKmECIICoLI+tQkw61fKRjrm2bsxhJMRG1d1dhDt8vtn9
	H7ZxsphoUcqzKAUsvWMNxCHmL5VNqvKyh1Q8STh6vNDNmCY39nltHvtKVnGDlnzSJwP3ejweBgK
	HVCu4H4zamqx1T6dVKdm1DewG6yN+xIMQzn5477qTd62eRrTJ5+MrP5whCEwM2TPAQaa9Q2rAnF
	57T5h8O4if4/Rhik8THUCUF4APnKlTWOn2dq1am/D6dMJFxuZiQ6Hbv7xRIeOvIMagmxj09aGIk
	tyBAOAT8H2xqCFxdyi77a4pscF+mIRilppSJ2uVeR4F1qpO9mA71l0EdfP8O4=
X-Received: by 2002:a17:90b:3945:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-39580eafaa7mr18294546a91.6.1787192968268;
        Wed, 19 Aug 2026 19:29:28 -0700 (PDT)
Received: from desktop ([147.46.174.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb5127csm4534321a91.8.2026.08.19.19.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 19:29:27 -0700 (PDT)
From: Kenneth Lee <kennethbwlee@snu.ac.kr>
To: kennethbwlee@snu.ac.kr
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	rhkrqnwk98@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: BUG: bpf: task hung in lock_sock_nested during sockmap free
Date: Thu, 20 Aug 2026 11:28:48 +0900
Message-ID: <20260820022848.1408056-1-kennethbwlee@snu.ac.kr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812050758.813489-1-kennethbwlee@snu.ac.kr>
References: <20260812050758.813489-1-kennethbwlee@snu.ac.kr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

After further analysis, we found that this report is triggered by an
SK_MSG BPF program repeatedly calling bpf_msg_apply_bytes(msg, 1).

For a message of about 557 KiB, this results in approximately 557,000
one-byte verdict and push iterations. The TCP BPF send path keeps the
socket lock while processing these iterations, so deferred
sock_map_free() waits for the same socket lock.

This appears to be a long lock-held processing path triggered by a valid
but very unrealistic msg_apply_bytes(1) workload. We believe this behavior
is benign, but let us know if other behavior is expected.

Thanks,
Kenneth Lee
