Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503036B90C
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485283; cv=none; b=kMhezy9NP1GmQ+MU19TO3A+t2w0hgyp0PNabukMEtoKPHmY+RddFpct0GycjH2eZBK3UxMdHp+mxdoG9ZQmfrPvm47evffJFvjAy0YBpCGZQkfn/QjK0NoAPtFEPoz0R8cMotfcXkrAAlvA/eQIR+Lq6c/BCyoQfVam+9oMnaqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485283; c=relaxed/simple;
	bh=Eo5ZdLgjrqeDo2gVZoFLUwCXUebOx8SuLJqladOV2lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYH5vryqIm2OGt7c3o8Tq6vj292jL/nsJpWPwRQ0LU4TayjOcwZWGwWg6tiKCB1M8cX6QC4S98HcdWfGMwvPuCqNh3za9RbXiqy0xr22T2HnGrO8whNMJ53J5neWIuS7czWazNhWbTCXlY2ImevhNlSfnKLSXNlQBgOTwTyecew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px7/RVtS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px7/RVtS"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ceb096e675so5539985ad.0
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786485281; x=1787090081; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Eo5ZdLgjrqeDo2gVZoFLUwCXUebOx8SuLJqladOV2lw=;
        b=Px7/RVtSRqOGYIF0Q3u4br2bul4Sjhy7rB/QPGwi8mAj+qk5eM3OjGwN4cmcM17Ntx
         G9gr+01CPLptAFPL1nUrD+09G2BMmVOnSWKAKI+mTrXrHlLsI74X8MmkaDdHrBMAUwiF
         P6A/RWHrhFdm7expOLmRJFIt6pkLFR6k2htlmiTxtZPNfBG1l5opGU7iZtgridhxgWpR
         sPkAemUviKp+o2+no4Nm7aGAQOVv+03b2C9v+zKbAjsVkEX4mtqfhyu/l28abMu3CPQ7
         JdnelbFVx+Ziqx8Cj4gtzFX9/l5Q4WwI/8b+lwWRxEbOGkZnlxwmOwEi/oET24dpUOdF
         K9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786485281; x=1787090081;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eo5ZdLgjrqeDo2gVZoFLUwCXUebOx8SuLJqladOV2lw=;
        b=qoWj0FcgpabKH4heeRpXeJOGsj+xEG94sCRugvGb7ufek8BDKbfX4XRC+DulN8cA8U
         QO5WbbvdR5eG/Q46iV6X7dEchwD6NnzEyQ6340tTQLmvnzfHj1hboniasQOUlsH+SvlC
         hQax8UPQyRDAMIqCRb5Z65m+4AjGzkedXauAldAEgLXgrMpDVKEFf6nyDrMdcgxdShfI
         eMFucL9aJMFEaZrDQaV9QF5adA9jedTuYKstGd7ucPmf1xUOL8X88w1driekM7WCVdwa
         Sk+T+LJpniPsXwY9xb9XTe9ygakkxge6BM8F3pZglBnGnTT+8eAYblWthLg1kJSpJljM
         QEqw==
X-Forwarded-Encrypted: i=1; AHgh+RoBgz7/nJY/bWGgsv+7FXgs+FUwy8+UqJLO4orqTSLvwKbxk18tDnfJqbS9OL5nrnzcuic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9cIkBcJ0BtyLS38PCewow1ymPL6GgWhNunthB3xhgXCgbPuN
	AjRypGYgnmszn4G+je+vDKeHJzl0Ul/CzR9jA1CgEIiBYWt7/bxNQpGS
X-Gm-Gg: AR+sD13m3m1TDte9buUi5LS4hbFlclb5CHdNmRzeaZIpWnw33g5iYe/nw8lZHRq3nLd
	4z0zDvGz7DarfWNxGiKVt84/Hh67KY0NzYbCzIWt36OP7q36+jLIGQfJuyN3J5NMONXa9Nw6Q5+
	sdunT41FzLnYKYArJ7Lc7NIoE6jBluKC6AZLiaTeA0LnuMQ9x3rRlAlBk+DTskzd70WKR1oMXKo
	E2k2Fs63irstOFCboAdsvracGpNDXI3zed0I7el7FvV/gc92rHPIR0iAUDNTeKVw9Zx+MD/Xp0+
	tx5gxx6T9jnFlTG5rIOepFR4tGHe3ScHFKNyn+pwsETL3dbxgwgFTd5y7Lo6XNJ4H/DVQNu9uZx
	SP2tbl6ZbyG2cxiMSqcadp7Hljbzz1u+AzqYbAW7fAbUIu3X5QDxCW+4hUmns+JYiyYTG32+EbK
	Pi0whZhLR1D4kY1QeOQ0PYDbkrtEcRFjJhm98zmKZ/BQzS3DvbjGnf3dlyneBaV9ezon7hemFi9
	F3E8C/kr3vjHCAmjLGjDjWEEeW+TKdZDzijTqjYods23VbQZvM=
X-Received: by 2002:a05:6a20:4309:b0:3b4:75c0:3ec0 with SMTP id adf61e73a8af0-3cc2bac4ddamr7631836637.30.1786485281298;
        Tue, 11 Aug 2026 14:54:41 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cd18:dfe8:e39c:4123? ([2620:10d:c090:500::4:f345])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141244734f3sm2964718c88.5.2026.08.11.14.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:54:40 -0700 (PDT)
Message-ID: <4e74beb4682c478982fd4a00f5d805bf63bba0c1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test RCU iterator state
 pruning
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ning Ding <dingning04@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan
	 <shuah@kernel.org>, Chuyi Zhou <zhouchuyi@bytedance.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 11 Aug 2026 14:54:38 -0700
In-Reply-To: <20260811035955.132989-3-dingning04@gmail.com>
References: <20260811035955.132989-1-dingning04@gmail.com>
	 <20260811035955.132989-3-dingning04@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 20:59 -0700, Ning Ding wrote:
> Add a path where RCU protection reaches zero and then starts again.
> The iterator is untrusted after this gap and must be rejected.
>=20
> Signed-off-by: Ning Ding <dingning04@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
