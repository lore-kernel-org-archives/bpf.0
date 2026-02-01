Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0A2773CC
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769925563; cv=none; b=DYTZ2YSpowGsmKA2HneCkVCF31GFcGepAlysnj2+JbeVJ9MTDW4/ihPajgsQD7cYQrtgINWmQEc6dVnZ5FeP5DI0W9mHesj+iQ8rNN7oo3ZRyE2hmvKBEYAAAn8Clu/iwd82/C12B0IcfdTLS3mb4lyX7PHJXf+7PIvrvPd+kC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769925563; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=T2hPV8I5QBqlwBd9zlsnRzZytPUZufanSM/++gdgd8iIBBE/ZI4fzUEFumyMQ99Fz/LgpWHTUMOUDvIiR7iKLk5h8UdtXMTvzDVt9vVfYJoHNcaAVupnUlD5dhJCyyRvFZkmeeP7oJ/lC5KaC/dG4BTcUw6v15XJVJKRhK9YFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Roz4XfAG; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Roz4XfAG"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b740872a01so7232341eec.1
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 21:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769925561; x=1770530361; darn=vger.kernel.org;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Roz4XfAGPGKiLPqB88nddLb6zxtU/0clIfD2nFnUNa5wTYmshIV3ZrJiSZ8DbDD/ke
         pM7A0kX7RLwTl0e0ZPdh76z1ZPI2TUlgp9gyMFcM6gy2aZvTyZTq/zFyHFPw4esqcJwx
         PDBRIYwLr+NbZTwnc5IKYuBkOjonEASHTrgM2XT8pjNr1Ti0KooVBQ1erMyco5A49Y9u
         ddBcvfm8LG/fPmTYaP+P9CNK4UMOXX1/mgrXixsfgUPDMgZMeAkMFlqsEWFlnJFRlvFi
         xnWjKitibs6vE6DM6m6NFctUecyTrWcnROFWSAdUulLGldAMg2oBUmRdcRaQEpX5lLxw
         xRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769925561; x=1770530361;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=tghfBuhs+ZR75x0FWsf2XQxdqQn3awsMjpwzmAFYIL3IlqlszqlAxc1WB/B3bKmUoe
         dbz/P9QS/jr+N+FKe5VY7fbtlv4/rcqReIQh363fc1P2rUFtToPyA2Mgx3itWMUkoYpZ
         vByXUhgF58Agft2LSq1KGzgR7ve/oTBjVkyYDNfLBmp9XHz4CS6KSoe2hWXA7sITYlYO
         f5X2xTL8sbccX72duYi205rCcP8rc4hd6PKg1bO1ozTwTeWSuh4JUgH2hzvml57b8mJj
         26pzvPuPWVZHVXq+5YwNSM0GSQQMkwglcd06ASdclQrjMw8OFFMaBwZ41W6yyo6aD0oK
         O2Dw==
X-Gm-Message-State: AOJu0YzuecPwGHT6pTcxAhzJESDNieB91F6HSQ4rTzBlNPC4fwimLs+/
	pLT1mih5H1ARd7R62rDORGdvEiHTCiGs9B8rFffpxJUYYKqv8cpwV+J6qPt9Cw==
X-Gm-Gg: AZuq6aKi0iMIYn6CYQjT01Xb7suGIQiriAhdUztXW8dmcBd/tp2ls9cy2tbGlO1TkWj
	UR/2oLMN8mrKJVKdciH1vNF0Amj812Dg+COiiP68VX9ziCQBPQvgQc1lbPKit/cxV3hTMYFsoO4
	e/ZVb/V5nLlgPygFV9qZP3FDTorVRobKx5vj2IrWIih/3vEKJiCifFZVT8++cYV4XMNBAVRIXXa
	NO7sHcCY7GtzsZeRoi18Tk9HQ5EHqflfWE2UaF3bkf+PC4rDWo5/djnA/5IZP9pELEPOg0aNXxJ
	ZoD+J+EX6mBdftK10hn+7AsWgT1uYEmPQk8LPkKDZg73WJ2X5f5ASQVFiNfoiGFU5cJSWvST0EA
	lInfor2ldi4uRKkMz8loAuJwF5KMk+ZovN5N0LEvxjHnaaZOqCqjOy1FnPKFQWQrF1dUh9kn/Pm
	6U9Qqy9TGULM6t+Bg+iJF1u6VA35MC7FUJI2SKdPMToc0=
X-Received: by 2002:a05:693c:3944:b0:2b7:9934:c427 with SMTP id 5a478bee46e88-2b7c86daf7emr3826186eec.28.1769925561501;
        Sat, 31 Jan 2026 21:59:21 -0800 (PST)
Received: from smtpclient.apple ([2600:1702:7bd1:2ccf:d51a:7bd1:db9:5621])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af8a7bsm17425563eec.34.2026.01.31.21.59.20
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 21:59:20 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Aditi Ghag <aditivghag@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sat, 31 Jan 2026 21:59:10 -0800
Subject: Unsubscribe
Message-Id: <310426CC-CC31-42EC-B969-D8841436B266@gmail.com>
To: bpf@vger.kernel.org
X-Mailer: iPhone Mail (23C55)


