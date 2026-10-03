Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A9137BE98
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791060357; cv=none; b=ORvmRz2XioMZYM+Uyj8W+5wwcGjWFXdAkO9Z79ai4/BN0t5TEVKMRvwDoX81pVwxwnYG/NYfvV6hul085NoSEQsDneiKmxdxI22nnMUQTCFLVjBFzdVFeFe3LUrs6o9Y9icoc4TceSbNxjaqFS+4YvfKaRwRr8GLwP3RIvX0Ijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791060357; c=relaxed/simple;
	bh=FRp4Cct50HXCeTViDVPkOvyv0qHQZnD+X0WubEU1Bpg=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=KmIbL+4gp3DX44ZPqzR2tuK8j3c9JpI1ywK8/56t+XshDPcCvlPfXiAM15/i+HK04J5eGBX3CEY+wORQw8H0JoFQjfVhuGjG6qmQUp4t4ERnWbiUpqFt/CcOnBNO+1mcpeM78X4hGfmd54fvM4MTqT4ZVa60xXEubV9l3FrTtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8Zkw1si; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8Zkw1si"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d90ba1d807so4245695ad.3
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791060355; x=1791665155; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FRp4Cct50HXCeTViDVPkOvyv0qHQZnD+X0WubEU1Bpg=;
        b=n8Zkw1sihXcl4/Pod6zhjI9skgCU8j8F1VKkIOWyX5CldojzAfWimmAks5nfi9OI3O
         LbN7M7jT2pSdPqOjAibpwHGhCfkmKEeJa16o1lM2yFRjyEhm4MeQNUwLEe02xZF4vbj4
         NeZadT6r48WSu8JRikuJCVsKoEhQMgAxyyGz7+cPMHDGRx2a07APhzA/cXMI5ZAkknsi
         +8Qoz0NWe0WKvKeW4oFLFGxdiBrgDzayaQPcO0bTL6xSS8av6YHG6ltu0YR4yjKo1gb2
         gbzTkclD39paWI8LoyivQfZbiFf+84u6SYhDpdYnX/ohVVesjMuxLL5xG1Uye/24m7/6
         Ta2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791060355; x=1791665155;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRp4Cct50HXCeTViDVPkOvyv0qHQZnD+X0WubEU1Bpg=;
        b=qcLWbGtguP1LYyaGvedl6AbibjFKcxdm7qeZ/U2t2boXUqcgEaCzsuHKJZXvDeOvdY
         kbgXMWeGyKi+2LUFMkSSyxr0vILXlFCRbKJ5Z+sM6RNDcITjm0LTjHBRvAi7v3IRrPr8
         /zR1VpSMo66fBvRldk94Eib8ItmRyvWNca65DcftBLS0B9xkXbzkHADytbHlH4VlKYD4
         163W4BeXy4tD5Yk6xWTIwo0C/0q4qAVGw4Jlx0uiCANYbUQLFQPR3Od20kveZA8NTGuf
         du/4Y5p47UKylFowQFErhzT411fS9AckutnbRwhmZwgrHt3kpHP1SjAv+iBPBmstRVjR
         qXrg==
X-Forwarded-Encrypted: i=1; AKwUvBx8tnGQxGgl0VjRfJJg8aknORBSKJz+GcfKf6EV3GkOwN8pcaN8U9raHd8Yl7fYGPTbFbQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWYk32eatkNPD+JZx0D1V/q4qiv2N0yy1eNfHp14rnYz3y5xh1
	tvtfZP9OSkMHp1MfwyhQZ+mG9g+QySqDlsyG10s3TxE9m4Otj9Q5gxaTWVfnEghk
X-Gm-Gg: AYBFou3ztgvfIvA6iHjsVR9UMXEeAc37N5MzLiUwjzOmAgThPrpglNAcb2ag1hXKLNV
	ODgnE7EJUprVYf6hsKwSIrqqlIbIkN8I41AnOX2qNfRZGlCe8llENwsrhgw8HzuajaF9ndW2gnA
	bDGmW5VEU2PncyInjb2RA7qY4RI5m6Cm5B8wD9/L0Abw3FsaGVxyoOuNUQ89toOwnUNBZNrxFGC
	ryRH9U0hWUjG0OTkRGSA7F+jMULdPid+tkvV50FO7GmaQXtwqPbveCwjihH4hhgB5lbgAfG/jMu
	EOGg78g5id1MxKAFVFo/Dc0isvmJSnkwE7ntmlyH79mZxbDivo5RJA8C/u+X/BNlSxHSHQnxl6H
	OK13nH/lX48NQirCSPPEnfjMGGcgFsqo3zNX7wK92LuNYLKVcaBsdqS4013fZEIWmAyR3bjeV3t
	Yzt27JbClbmKiMuu1FisRt3s4wasr5R8JpQvUyQZeO7GKVK2HVEauOp9YoimtX8AsXR9mZ2zmTd
	7ZEw2RGqbKvFs900WbrqHxj8/CnPVQIbqC5d7rDXtSBE350cu/cp30dkk32viPHCKJC5GeZ5GVZ
	ODC92NKMP017jg==
X-Received: by 2002:a17:902:da91:b0:2df:83ce:724f with SMTP id d9443c01a7336-2e49b615cf2mr61626695ad.30.1791060355061;
        Sat, 03 Oct 2026 13:45:55 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e533e8397bsm7343265ad.78.2026.10.03.13.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 13:45:54 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 20:45:53 +0000
Message-Id: <DLVHWNL0AVKU.NV007WEHWST8@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tao Cui" <cui.tao@linux.dev>, <tj@kernel.org>, <josef@toxicopanda.com>,
 <axboe@kernel.dk>
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <daniel@iogearbox.net>,
 <linux-kselftest@vger.kernel.org>, <cuitao@kylinos.cn>,
 <ameryhung@gmail.com>
Subject: Re: [RFC PATCH v10 1/4] blk-iocost: add BPF struct_ops cost model
 support
In-Reply-To: <20261003124045.1289305-2-cui.tao@linux.dev>
References: <20261003124045.1289305-1-cui.tao@linux.dev> <20261003124045.1289305-2-cui.tao@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 03, 2026 at 08:40 PM Tao Cui <cui.tao@linux.dev> wrote:

v10 was sent 11 hours after v9.
Patch 1 grew from 712 to 789 lines and device removal is still
not tested.
Pls slow down. Wait for Tejun before sending v11.

pw-bot: cr
