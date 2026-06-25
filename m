Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40B3CDBC3
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383172; cv=none; b=WJH5MFpz8h/LXl/T91STirLuAyVu92Epal1s6XWuLiGPeWAEjpnHghOAiqKktYiXgdOtU7+gHj8TJ+nKFQXLIwRLXMs5CQC3Dpt7J98Vt8yXmQzSWWUeZGcq3JZMcD+GG3XJDwFu0tg5MZ559wdVCc2Rl1JQpPGTjB23pKRvZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383172; c=relaxed/simple;
	bh=aHVy72cnaTQWBvDo57yCjWU084YZmq2VtcfiGWHBIXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCBU8SK1nAxn0Fr/lUmOYeSAnT0/XFs6p+8e7HFvjyo8iUYZf57RR/56sA4/rYZyntCvK9iLuSiuL3No9Q6Ly+29aZ7XlVYIqr3LuVo5VaeT58uFREKzTqPmkfSJAtPFKoESyvmmuT/wH1/yn7QcEZ/C1qco16T+813VyyJsiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2HbKSTT; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2HbKSTT"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso1573921a91.3
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782383170; x=1782987970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHVy72cnaTQWBvDo57yCjWU084YZmq2VtcfiGWHBIXE=;
        b=X2HbKSTTMw1PAw37i2UNhwth0EPY6QMn9ZAPhgaHPL9zKnm3ZPmjNRtQFvVS8nxWt8
         VGxwph/Cl8JeSl8N3jG7dDuH1l3XKehPhW0dh8speDPVhnHCo8tY9Dkz5H9VuibD5LoY
         zqtfi9JcxAOl5UNNHsOydm9cGIUXJ2vu07yV7wbqmS+p4s+dEIViZTTuDavZAk8c42PX
         f8JiMayN2ggPDjWCwkTb2TduuwYidccrmW+7pvUCwFSaoOFhg1jO1w8b6b1nKlz/giMg
         rmSyjo28uboOy9S3gosn1oYUShLkTL2LK1stZNDQrhbvE1vjTgBvq0D10PRdhYBiefhM
         g2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782383170; x=1782987970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHVy72cnaTQWBvDo57yCjWU084YZmq2VtcfiGWHBIXE=;
        b=sAiR3eJsQtO8WeJPScONU7tSmqvXR6ZLFzYWlvBbX1Hx5N4VujnlC7QsYA3gX6mAK6
         7D02yq+lKwIFdmjVQkOnB2UogNUSsRrv1jCbf1wTZkbR+n3xTZWaY8AFZIs8bLiPeyS6
         D8oTY3HyG8ljjLeVrXdJUUV8By/e+htYEi5f6lsZ6PJuufIwqBSou7RqdE+O0gQqn599
         4INeKT9VS3WLwKayHoHyWcJRjBbhuJKcienR7Vt+HglKyitkDm/DQSHc+sEtD13HUzt5
         G73ez5rWEXi87lJ1EmSISR/sA+82Ndq3pA4BdRCakUg0c+wlZh2u9CBIrnDtataeheQD
         rsSg==
X-Forwarded-Encrypted: i=1; AHgh+RrMbPyqsJ+vQrL6yGXafy7PVlNdfNu8DIImYSMVCbwYGLcKOUmFmx/hnTRIKE8lQ6srR4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEabZwl70SXDmYMKWSnIw9aGTlCbmA0zkcKtMm7G1PKv8+FAp/
	vjeWAbSZVskI+DWQyuY9DpAa34UVuEJqYSWBU1sbpwj+XxcazJGMOzcU
X-Gm-Gg: AfdE7ck/oQCzuWTGg2bzBM1X36hKOh4HTek4QcVJv/rCBAE2oM9M1WDZ26hN334yces
	LMvGhBU6uoZPoDTkcB8N3zxHzCnaMm7ve0j0h3ttzkCVpDrBsjrlvJ5qaFlz5B7vbhwj5UwktS2
	T1yQMF+tlQaJ4697ZMN115G8Xr1KVvURKTtvjDYq/ghSTYvTEFT4TrRZhBgz5TbsVvlWafPll0L
	5vmVYVvsNWZU3GpSlmQ38bnpiQUR4vaAMxSeN7zDZ1RrH1vtCViyl2o+1B6mta3Gwg4dkUr/5vQ
	OOh8sD2v317RcE1ojNomggQydU4p0ztiOYCkFymOvz7r+dJwnttVdJfk+iV23EzxHtU97/FHtAf
	riEFcI44xfxX/GRxdFI23xxeAjr2npxQ3qI2lP0B+/x34Fpydqe4k96/TpOyD6XzX9/Fge/Dx9k
	F1JQ==
X-Received: by 2002:a17:90b:1848:b0:37d:f737:d05e with SMTP id 98e67ed59e1d1-37dfa1a8b0emr1990181a91.9.1782383169817;
        Thu, 25 Jun 2026 03:26:09 -0700 (PDT)
Received: from laptop ([59.6.68.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df3dfdb99sm1605505a91.11.2026.06.25.03.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 03:26:09 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Cover var-offset stack reads from zero spills
Date: Thu, 25 Jun 2026 19:26:05 +0900
Message-ID: <20260625102605.231140-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <8a14129295fdbcfe16e811455317108b7b029884.camel@gmail.com>
References: <20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com> <20260613-bpf-stack-var-off-zero-v1-v2-2-a324af0f00ea@gmail.com> <8a14129295fdbcfe16e811455317108b7b029884.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks, fixed these in v3.

I dropped the extra unpriv checks from the new tests, matched the existing asm
formatting in the file, and removed the pruning-sensitive test.

I also added fixed-offset mixed zero/spill-zero coverage after Alexei's
comment on patch 1.

Thanks,
Woojin
