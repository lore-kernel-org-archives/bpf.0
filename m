Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143E19046E
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786063449; cv=none; b=QgAoLKSPFpecNguxawA9c7x7qbcMGNlx+6khQpJ3Vymx28gx9eMVceZh/J86Xhd+tmQz2h5IfU5hL8U4iYOOUoqiMliYZ5QxPV7YRLR7ApH1zzf1zGftHtM3Br/IMyOupr4FAHTofJNGTQ8SbDvD8a5o6DRBozrgF+q7M90uZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786063449; c=relaxed/simple;
	bh=7F0WO47YLDdnH3Bto1WbI3izeTqoMoCzy8FLEzEym8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOQEIMTXhv5WkBemxXfW3eLEUTZrmA2BSw60eYGCaPeS6OBkFJTftl0S0t8d5FTq/AaSuIjn3qh5HeYDrxGQFu/UJhR7homINSx7MyvY7GmpvsoS1Ynp0DUQECYdxwBuQrnILdWuqoe041iWl6Adcaf+f44B4rbvscZYo8xqLCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tou5L8Q9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tou5L8Q9"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1720215b3a.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 17:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786063447; x=1786668247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QjMghYk7h9CcanBnTxm5ojK1G8l4mis4T01GbEO+9sA=;
        b=Tou5L8Q9LUqH2wngf+3gaz1B5QPJ14+Hzw7wCAfp26KmA6GZiOrl0IDH7uT+/pijr9
         BqHplvAPehycnEAxWfn6MEK6Koaq4ICgw+usKABNSdW6RjklEv4HAl0jXQwx5KwELJyc
         uOaYqMHgasJopHSHs1/i5zzCiZ143pXZOoAXW/r6jtAfmezsvpNawa2rmBGFtnKW09YK
         MPnPi2INIuLGK/U/ARSj1UzKmQChMYQCt0eV9fMThgoQOgR5/0JHfJ6pdzMYjMVi1CSa
         xssADrp8VuBJaxDA8XrWPqxg77yL2l08Osu1ujTX1pthluIjpFORAJHOe+QYqSqLTj/c
         uANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786063447; x=1786668247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QjMghYk7h9CcanBnTxm5ojK1G8l4mis4T01GbEO+9sA=;
        b=kuXXizGjp7AP5HNXESnRVp46RKwZRIhnxCB3/3QpKjbtR3N4oBCrpLAEvuL/mgqLQ7
         HcISjdhuGBbPOTHcmo9/kwUt08tWPcgwrxuCws7i820YOrdyf4LhgU3GJwTTfyiXXCia
         pTbMn8/a0ODjUY/ozIAsGJXIHtY7gNo4WGAELZXb7Rmu26+ECt88knP8mfOPZ7y7Q6qU
         /N4n+mDNcvmdjRWEi0yoToRW6aLlhnvYAmKgvTD1Si6ML4QbNAV4LtRyq0guUPzn1S5c
         VoeWnXOqu0OcsqA/EbceKFk/Bj7bnhJeAP1pPtBrBwltbBwminoLqEpctG7SIzK9EkfZ
         JYog==
X-Gm-Message-State: AOJu0YwBgzLZXvRMPjZWjcyVhZdumFY0JJITUMgh7ZZJHzmI8Tavg3j6
	O6XrmEMmc+yS0p5zWpsRtLxkf6NXEYzBdBGfyGkgo65GcNj1wALRzxCuET+tHw==
X-Gm-Gg: AR+sD13n1rgCfQrj4iFLQD1CQZQogs8uPKKIYz5ScdfXUCVBe86J/zkakNy5Gb3PDM5
	AVvUsCvxayL1TwJe5dYdrrpPJrgBSXD0QjbgSNbCS2vSvUKFTuDY2AG+PzbR3DhJbsMXokHAjA5
	H0TadRM5y95syUks5epAxtVKykTAitFD6Rx8efW3VGqEh37qDPQwgA4pxk1cACFr5Y1sjRy76iY
	56U+A8jt+Eue1qf3vuxu734rD3kCUa+TkJUCC/p7Z/zIDSwMZM6+Xe/cSJjf6uy77+5M8psgO7Q
	daymO7a1KSgvhCko1Gd+VmNKEVA1OvjsV3OR7Dl7T1OrCYDBUiXCvljX6xDjVRbREp9Z71Ws9M8
	fkflNnCeK+Vp7fojaGB//fYVxvq/cstLHfNb1uh2dAjFH8H4DKRtp+GV51lA/OWpkBqTK/9ujZx
	zxc/vZ1AL4i2Yi3jWFb43WHMWovMFu10Ax90O1VuVRhQX9YQ0yZqPgALXMN+a8vXCUOfW0Ptpv/
	PEFyv6bJW9ZRkjy
X-Received: by 2002:a05:6a00:1798:b0:84c:2d22:7307 with SMTP id d2e1a72fcca58-84f47dd0acamr7705941b3a.13.1786063447425;
        Thu, 06 Aug 2026 17:44:07 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a552859sm172922b3a.42.2026.08.06.17.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 17:44:07 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Ning Ding <dingning04@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: Compare iterator types during state pruning
Date: Thu,  6 Aug 2026 17:43:18 -0700
Message-ID: <20260807004320.134069-1-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterator stack slots can be marked MEM_RCU or PTR_UNTRUSTED. The
STACK_ITER check in stacksafe() does not compare this type, so state
pruning can treat these states as equal and prune an unsafe path.

Compare the type and add a test where RCU protection has a gap.

Ning Ding (2):
  bpf: Compare iterator types during state pruning
  selftests/bpf: Test RCU iterator state pruning

 kernel/bpf/states.c                           |  3 ++-
 .../selftests/bpf/progs/iters_task_failure.c  | 27 +++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.43.0
