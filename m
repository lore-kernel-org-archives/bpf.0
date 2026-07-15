Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A07481AA9
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136091; cv=none; b=QV8XAD/wSwaeeurdaIOt8k7IAMRaTAT0qKYI4sa9epEK2W29am1X/CipAaJSoiQDP3yeCaInzI73k8VaDqTf+vJ2pidraflepuoRDYTLEumkAhe9bnCaXxS7i+3fuvHBAspZ7GC6w1XrSrvmbsbXrRJ4NyH43bq79kyPYCwxHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136091; c=relaxed/simple;
	bh=wsYTLrbCZ87kQv+XN+KAJuwmoT90JHm48XwWx5Yi9Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gub2vavwyyjt3kt2YV1UgLxJXswKsPUIVOdyE8qlc4Smz4b6oBEnoXsJ3aUNbqVPjJj0g1OLicEbSt9On0opfe7Fxqx0bHoWLlMbD1Ervu192u7LptUARuLVseeWllx6daUAUk9Cis11G91zxoGKkgcrHn0sega5aszAtJqebBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7XJpAJP; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7XJpAJP"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb5a9f02e8so2804130a34.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784136089; x=1784740889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Id0CqLJxFJX88Ub/nshLlHP5th7Oap7dln+TDlsGB8=;
        b=h7XJpAJPFOPDV6BWXkM0fpehpwSfJPLXF88bY5g5actPUf31ZNypGci8bYQ5lYFIlC
         ro4rifFQj0ORjtqyQuuqZJML5a+sumXPKxjb/m604QIHbJsAU2Vks1q9BJV0S3bQbAXf
         HviYYLAnFiYQzJfCrCNd1qSrlx8a0xVGX3piqTe8dK87ZLp1L5GdTiFCcczIoHQ2zLMz
         alpdf50U3WDqdulot1WzeYjDl6xQLWUBYxwK5MJfuZKdBM9qmyM322kC4ofBO7jqyhPs
         +r+Ns472AR23F7UF4UeWBO11maZ7NeEP3sbVaew9jf9bidpcfgxRxu9SUgeTT7XA90jE
         2xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784136089; x=1784740889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Id0CqLJxFJX88Ub/nshLlHP5th7Oap7dln+TDlsGB8=;
        b=Gja5DFjKdlLFKgp0uLzl7Jm8PVcyGELYTE94hjxSKqme2u+dj/AVeKz9sxd8pSObfe
         BNVeVT2lZ5BcTmUVEnZsdAkVbA6IWoZ9cd+lsGJ1Esf51Qn5u/Hw0WCZLraSO/v4mqeD
         eNyanfjXmzqHIb45SclyzGW/eXljTCwEsuLBMjJGHuM3ZoUpSpIfv4nFoYDkKaEdEyn8
         wT6SVvqNmvfyn5Pdtcgzyfl8YjSQACuSaFQNcg2prSAiP84QIEWqoSLNFl2ZwzW9kjIP
         mdIaG9eGhxJ6LImL758WVw2cWpuBdvHAiOQufUYrAHC9m46O6Y/M/Om3Ma8Bbp+Qgu/S
         BBIw==
X-Gm-Message-State: AOJu0YxqJWnmhChGR4nlU4K+cSzlZmSiiIHWPafPiI+VIv89zRIyRx4L
	sTCJaKUwKzameXInmlhdUMHkglUcAl5qutH4rBUmMmRIYxco89SRQQ7NgMihEQ==
X-Gm-Gg: AfdE7cm/LhjnyTqBdsoVWLrPVko2MBssg9bNpsIafuYzUUZel2emzWz0spOpKNDGjzf
	7ob8YS2FEDgqf6EzKw4WB24GwVN80nmNfgp2FoslHA+l0aZKqRloxnxV2krEIbxp4gkLOD6x40n
	9w7Q4j98yzspx4CHBtsU56njTr9kFmrkB6Fwa+iTUnE2e4s8UA8z4xcKmKpe8+FOAzvuIc7Gnd4
	gx0q14t2o9YlVv3DH47UDIvdQg0Joipg9aNJZNwCLVMvJxJEOKpKvwNZmqcejyJfR+joGpQ50Tx
	YBuCk21juSphC+kGel8JdesiB1rKsprGthh3dQYpZaWXTgijIfzYfLIueDv6zWROGAzXFmzUvWb
	pXNjQ1ZY1tb/Yz14DW3r+AXm0kOAYueC0TKYpuXA1fXejVWGbM+CJfAmxpVoDCNcUFtNcR5GIVE
	ls18k=
X-Received: by 2002:a05:6830:6082:b0:7e6:d54e:8fe3 with SMTP id 46e09a7af769-7ec59b4d88cmr1892417a34.9.1784136088771;
        Wed, 15 Jul 2026 10:21:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f6826sm17779766a34.27.2026.07.15.10.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 10:21:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Fix leftover issues of the unify bpf_call_arg_meta patchset
Date: Wed, 15 Jul 2026 10:21:25 -0700
Message-ID: <20260715172127.2416388-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset fixes preexisting issues flagged by Sashiko when reviewing
the patchset unifying bpf_call_arg_meta [0].

[0] https://lore.kernel.org/bpf/20260715064047.1793790-1-ameryhung@gmail.com/

Amery Hung (2):
  bpf: Disable raw mdoe for bloom filter map_peek
  bpf: Zero kfunc arg meta before error paths can read it

 kernel/bpf/verifier.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.52.0

