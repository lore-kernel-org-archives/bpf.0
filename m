Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662D33AD88
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742705; cv=none; b=ZulLw8AzpJqEodk2qJkRMUZce0r6TCNsGOGyjglZEuB1KgnGJfqFrYnF/iehcUW8FPtmhLU39OzswLXNygoMRJLJb0Jmi/z6zVxX1q9aX3BXtNB6zp3ZGv0g6hNLdct8Goj3kTdGwImzQz5zqodnIjmZXcsCnEn+CWCNlG6a5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742705; c=relaxed/simple;
	bh=ooTmPRZxpk7aw0fD1cdLLlcdhvwbB++LWvhfewUGhhU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hagIGHT9wemkJBESrSKOzBZVw0ehHJCrAtZfQMGxBK5s9zWS8GyzigFt37ylVbuEf/gMBKS6FfE8yyTV5TxQlcotL0gc6PNzymwJIjyc7UO5cJuEPR1HThEs7folG7J2Vn8itO6Udb9XwdcUOsguLTtB6+BEcDzNmBlvfHBLGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUMe0OM8; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUMe0OM8"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a06bc2f1bso69859176d6.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 12:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772742703; x=1773347503; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3EwXPsm3d/l6eOfyR2jDGSq5LoWBnaUTUZr7vrI23lY=;
        b=XUMe0OM8fVqKAk2tihhHEZZqXyaHHSageQzBIBQnLG5BHYiqTbmSlQw2yYg4vtNWns
         qrW/2oBIxEBfHpjMgBw9INWyPRrIbcbr3NEhFw3E2sD0S7bq9lVNDb1g/8qxyUXm5cCd
         uiUJ2q+i3c6nHYp7JTxmdyZVBYyIIu6XnLsCGfGP3RVFVmUFaNRto1nGlNDZ8JE9DBP3
         cw5wp2TzPLEJQg/yfrVusdVMH4SuWpxfysbJrHyzjG0SP2hNHGpg3WXq9gMKkAQph65Y
         yvIPN3hhy58gBiQQFH2uubzqsbJHY2rOcbLCotHN4ncxmGOpPAiUn7DwzdSbIsmV9PH8
         Bh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772742703; x=1773347503;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EwXPsm3d/l6eOfyR2jDGSq5LoWBnaUTUZr7vrI23lY=;
        b=qmcDw/GY6yYFXk+6hWzxS2GQDcUKzRtY50DtvQEBOORDnGpVwaOczBUCakbn7AIzqQ
         U3QOMnIjuzsoTGam81HkJ3xCP554+RnbPhrd1GRoZd1pnstkKNXl/W4ic6g/A/+7+MDh
         X7lDbuGHUDfRLLlIQZEI5c2QnHYwPQidoE3bfEgXsHEM6uCZjp0poO09/iN5+I/OTADf
         Ylikp4D6iPA0P9zTYxJhs/pfCOPvgqOCWMsmMEZNNJXbFhx6s27K5juFjzlQXTrjxMOC
         IrKhIK6l+pq6glBLGVsYPS/PiJdoB/4VpQLnDZ//S0jm1MHfKXw7YTIoDuA3VBS2CnHy
         t2wA==
X-Forwarded-Encrypted: i=1; AJvYcCV2YUTyqc+NbnGROp/aiNzUl3tBbVCs75IVggBo5UZ7MdTqRrRlFLncvcqTQB0triLoZRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXxx5/yrAe3hjqj7age9ANbYSyjEywZVsq4L9Negs1nliKgRW
	xiwhcsPJr0rlXRLhNNAOnq2onYgyHOhPPI63x3A546DhB0sEfBwPMBfS
X-Gm-Gg: ATEYQzxmMviDbvqPq2bdM4+WykdhIMABuyUTBAIhJvftcpJJ0umS7jpnF5IW5q0/473
	9Arh4NGU6ALXN3A2xHsn85NxvwdjphWvw59CBy9Ng197ahM51GlUHQtGZgBAiR076uXMUGtp0fc
	xdVKcmfqadHsGhJZYDUIFqx0V/ggtPas7SCvjKFwzXvXhjY7WUUxfhXwjh4decgXNZyN/Apsjry
	3UphwJZqA3hSxmEtqOkDzLYIGfdpfxLUhHSVBPyTC26fKWVixcL+DrWxeE6MzGCI61/MDBiSOpP
	sV+AJHba1iOOnZe6Pa1aEDHnc22DFw0bkY7ino4Ho59I/DAxZ6tUz2GoYUao89CuvBxCiqjgd3X
	rlYhicEVkgrNX6k0gZU+hCPcsfbw6p9gY/cLQCBhIr2WhVGJ6jCAy3FuVAyVuwrOsyxa5PGh1wW
	2Py+vVWIFfj/5KTXpYDTryRc8SUATWvQz0gP6mx1CiiS5VdVcIAbnS
X-Received: by 2002:a05:6214:3004:b0:89a:216:6c45 with SMTP id 6a1803df08f44-89a19d22e0fmr99687706d6.62.1772742703341;
        Thu, 05 Mar 2026 12:31:43 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507512559b2sm161802831cf.17.2026.03.05.12.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:31:42 -0800 (PST)
Message-ID: <719ca2cd30376b1e477edf9e3b222202be7b3235.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: refine u32/s32 bounds when ranges cross
 min/max boundary
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, emil@etsalapatis.com, arighi@nvidia.com, 
	shung-hsi.yu@suse.com, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Thu, 05 Mar 2026 12:31:38 -0800
In-Reply-To: <0c49825f6d0ae413ca101a5004a2e33ff1d979f2121180e9654957fe6121f9cc@mail.kernel.org>
References: <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>
	 <0c49825f6d0ae413ca101a5004a2e33ff1d979f2121180e9654957fe6121f9cc@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-05 at 20:28 +0000, bot+bpf-ci@kernel.org wrote:
> > Reported-by: Andrea Righi <arighi@nvidia.com>
> > Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
> > Closes: https://lore.kernel.org/bpf/aakqucg4vcujVwif@gpd4/T/
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> This commit fixes a missing refinement that was noted as a known gap
> when the 64-bit version was added.  Paul Chaignon's commit message for
> 00bf8d0c6c9b stated: "The same logic can probably apply to the s32/u32
> ranges, but this patch doesn't implement that change."
>=20
> Should a Fixes: tag be included to reference that commit?  The
> suggested tag would be:
>=20
> Fixes: 00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign boundary"=
)

I disagree with this assessment, there is nothing wrong with 00bf8d0c6c9b.
