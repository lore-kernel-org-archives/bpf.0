Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976CE131BDE
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258368; cv=none; b=isyloW3M9H5REmPVn0sEzYzaxRgW/vZtFQYRWehDrf4P+VP9BqqlGEJ196grAcr2FmEnfr2Rxj8M1dHKR6pNg7Q1yjfdThezg2HFptbintsFj1bZayD9BQUGnfeu6ATuebZfFZJ/5w78ezVXKaKmvOPW5hP/bYPTggCzK3UYUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258368; c=relaxed/simple;
	bh=EdMsmkBd1uIq7JA1QwYKzCntyjMZrsCcsybik5kstKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i48YFgL2rWiaoA0YwzqnzDZmw19rGz48LezMQ17crFgR2NV4Y26a/JB4Dc8/zSDzNEXZyZjduHssVtc1oLqzy9XAW+Nu/hTb7o51FvV0sg/Z4GzAOUudDYTzcHi8ea/fUql9k/lKSBcCLOhBZkc84bQTKIWIzHCRLeIKIezJ84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gfa/2Mo3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfa/2Mo3"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e28856ed7aso10318235ad.0
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712258367; x=1712863167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdMsmkBd1uIq7JA1QwYKzCntyjMZrsCcsybik5kstKU=;
        b=Gfa/2Mo3Bvfa1AbWVtkOKaWCK/wdDv9SVOa+HxhVl0m6xDiwIC3BYlE7fwLzuXS/2S
         5c5Wzx053xMX/qVh7rvmjfxFeZYHeSQ6kitbGTcgVHqIhe+xPwopuTjtlzm58exohkqr
         lbiW23X6dYAlMzljgHY6uX2+To6uOkPy9s7h+1zmMNxuAP4OMzj2N4zwL0I+S8JDInn7
         I7k/jIoKJdY9qbQ26okYkrlNQRoMBAT7kFNGD5b2DzHIYMbXFP8v/2EJKEtD0HAtAIGP
         1mo6/NbYiSqddKvxejTXuMfh2PH6lo4L7YglALmr+juJ/5pyrym6Oav09VARDIrcLoF5
         xV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712258367; x=1712863167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdMsmkBd1uIq7JA1QwYKzCntyjMZrsCcsybik5kstKU=;
        b=aUw7rSDtNzTrU/4vDe26jp7gNQ9pUMzwgYc7APa94MZn4b/4jVrf/Z5Orgk3dDD0FL
         z55LycLYS4d6hr6Iso2ryP5ICmYZnwUJGiZLl4Gg3OB+5lngeU29MBobBZX6j+ijyDD8
         zLsKnpFuqhrRqCVJdl+8R7Yhe6tpzst2/8tciZEd80kOXhEYKGECt5gIy7jl2vUL9xPz
         +wp1qNIgtahacIBkOtYLgJ5UoBEJVeFUeYF6J075FCEhfiTMNASXEo3pcBvoIB/i3qIr
         vX11PIEFWrwPXz0kQeMA6cM3l28mk02sRiEtNbooUZujTJ2IGK/W1i94AnKC1h7p4NQJ
         qBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWEuqr/gADgHF5pSZjhMzUGh0VGBCaMlmE4uL0rf/MVUiNWZbnCPjcKRqBgpbbDz1zsE3RCMrnVcbJZndEq26K74Nx
X-Gm-Message-State: AOJu0YwfumwfWNN6dkZYcSoL4Wa86yObIAUL9Y2wbSlAyPMVaMeeYHLH
	013E9pPV6Y7dtHg0/gIeVlI1uO4uMXMxGJ/HcW5T04VzXL9wClhG
X-Google-Smtp-Source: AGHT+IE/PWCMmwA7I8L/KyY833wlqOO9UZj5FpGaKjXFQ6xIMVSVDf8BKgxivpt695LgD8QZbLuuiA==
X-Received: by 2002:a17:902:6b45:b0:1e2:7ea0:c1f2 with SMTP id g5-20020a1709026b4500b001e27ea0c1f2mr2873688plt.58.1712258366974;
        Thu, 04 Apr 2024 12:19:26 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.80.57])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001e2a479954dsm2468838plt.181.2024.04.04.12.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 12:19:26 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, andrii@kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v4] bpftool: Mount bpffs on provided dir instead of
 parent dir
Date: Fri, 05 Apr 2024 00:49:22 +0530
Message-ID: <3323014.44csPzL39Z@valdaarhun>
In-Reply-To: <092b49b2-ca2d-117f-1fa1-dac8c713a9d2@iogearbox.net>
References:
 <20240401190407.20363-1-icegambit91@gmail.com>
 <45c72ae1-ab0d-439b-8237-80a38e15f571@kernel.org>
 <092b49b2-ca2d-117f-1fa1-dac8c713a9d2@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Thank you for both your reviews. I have made the
suggested changes and have submitted v5.

Thanks,
Sahil


