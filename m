Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771460;
	b=kRbk83AssOc/+i7ZvP4T5yFEPUYln657GkUHpPT9rtLks16Jf2NnvD+rI7HJdlIzNxYV
	 4mIhBZbyU9AIhJ/w3t2imuy8h3ujhqXbbvGBdGjSAz4lyBZskfX4lm84dGrjN8KY2+LOL
	 7YtjV7MXbrzoeBBSkoWKQa8jlgqF15EOCcq+jdIyNJECJluF+X/EzbpnUVNhQ3e+0YvPs
	 bv9XNLF3c/sH0gxMqbQIzi73QPIxi1khhaqGwP85OQU6ZnLOnbstLFKrAxDskzRq/I1XB
	 SW/80yYAEl3J7Xt/vm01OEnxa8OtIxtVWS3vx6UMggHnOYZwJ3ZRr42BbgF0Oe0RWdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=EcU6RfKr4ZzY1Q/TbJYZK1jW/7NnBQPjgUilPcVqQc8=;
	b=cjQACs7W/BY0UV94J8CbeV5Gjvrdpch0KY9e7c6I1Ov6jGKErsIdCeVXnvUsV+0iwdNQ
	 5tHFZt9KlTg1ErybSc4nvJtE9oQVrePMD0oJpRCMFlLsQlN0Ok+WjWqYsNO4cC+Kr0qlq
	 /swqJ0tV4y3yXWLsrDYX8DKLR5CiwnCfhGQvE/MhejXItQYqX5pRzoL7AAhX8+IN53gFt
	 hWl5oHtnaUwIBTa22nrAO4Ti1KB2/lrt+8zVVdpic9+u1LKezXt0KzG5pBbXV8xFqGK1H
	 cpFZTe13V8wWOoAVcadEUIz2SdKGamPv1D2FiMyAIDMuaCojFVuWCDrGLL5+FKbg5Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F7eRWv8L;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76773606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 16:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76773606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F7eRWv8L
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a070781f63so510950b3a.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792771460; x=1793376260; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EcU6RfKr4ZzY1Q/TbJYZK1jW/7NnBQPjgUilPcVqQc8=;
        b=F7eRWv8LDdWj1TmIyy6wRG7ZEbN3aBGk/y+JCwl3JEZH7XAH1SrDdldqBgtqPo+iW7
         lQDCRWi63YCNnKtIgefVtWO0rB6dq6VBTrAJEbZ8YBrdo8kgBlYda6dEigJPamdFKB7d
         4DgaIeX6cK/nbWY2aGRxYqmFV6EJxTLRWaKBoRtxPpRax9BY4G8Q5wtwJbI4qDAt6Wii
         rrAQ+H2E8RsIPHWhDwVp+673WIyz1Z2PmZY0DXO1ki8JQtTK0VlUV0fMaJLX4kcVZCVe
         80jCl39Kli1qLij9fOzHlZVlZsvv7lyqTVQG5RiM2JinzFBA6KLT7+mlT3BPcf0YxbjQ
         GzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771460; x=1793376260;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EcU6RfKr4ZzY1Q/TbJYZK1jW/7NnBQPjgUilPcVqQc8=;
        b=M0wZuwLgbOVQkod6qWDO55a+eMC4po2+zsFB4+Um3ui84H4/ohTFk9ASUY1+1Ks71i
         NB7p0tA8L3vfdYpIvLeNPpg+8IlHz1S8P+1eBOjoLs8qFj6NZPPagTy/pkvySHYXJLW3
         kddMggT4nE795NUillu9oCvJ51ZtjgfqjG+mTk81aipqkMhvNBq0XppSUi44GYfalCyh
         UgZqu367PhCyDCq/Z8sFIuY0JpfkjsBEGP15Ares0A+kJry5XnzRKkqJBK5dq/gpNUAf
         bjT3of9JOM8Qc7xzXlceqwcrCs1fEJSdpk/WVVMynvcRtMGtaWHW28pwW7wWF0FARY6Q
         rm3A==
X-Forwarded-Encrypted: i=1; AKwUvByY4JmAk61T+X09KcVI2BqN0/2k7a5T9TC4SmLF1qCjljMShZbsobUoO76BEJcFK3E4bz0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIICw8GvpwXt20+4QQlgWGBcFjgL2NNo12/AUZFuJvLPzxT7RY+
	W10OEFtNrsLndsL0i3KlQY7j7FBZcbavWVcVMvlzkxA6zoouBXYOfvMN
X-Gm-Gg: AYBFou3I0SiL1zHu1j4dbzdzK1m1F/lY6GCPlVR8RO6TpG/NzMfkd1z5mO57xf7MQpU
	GVxDBKX+Eqo5AC0OQw9p6Io2WY4Z85XVZeXt+qnuWHCKy7FFGwEvgZklwsH6hg/f2n4x+/5CmuJ
	W6rwRLdj1G12aRj4Y2rDZGRkKhO/A7Q4o8g+BnXChUib/Vn8d0chNBS9CzWwEDYIkVGlUFmjF8D
	5H1IRO2GyhIQICxVO1ehjDvqC5iPda2KNaRQ18ydvgRZXooUjL3ywEkO/tIgnLD+s9sNiKNrmHJ
	PUQvy+F7evKZYakkmT1LUv0MyLnGYyAsR9OgcPTgTuOkxf+2g2Rm6MutYA5M4iNVJYEU3NIoiOJ
	F2IrqrfI8rnp/0Ad/FbXrwPiyf73qSBCemz4DGP87usdD5/WlerCAfVM/4AiZ2gNbxATk/V4eS3
	oqN+sQbThkUzcYcSiF1H4H5rgV4kPQbAbV20AxCzSLbql9ZhR+2Ns4hy3i5+8AypuKPdvv+L+8T
	i/cQtNrAFer52l0Xyz+iCUGQnv0UedgFVb2+9q380UCYUBtUwSvypUt5qF86W5VsZ/0+RKxbsXt
	jtIcPhw7QFzaILlHfUZT1z8J+3L4e7KsC9QM66YIUPVB7vt0FvFOuHsZytmSiw==
X-Received: by 2002:a05:6300:618d:b0:3cc:45cc:c401 with SMTP id adf61e73a8af0-3e36923d731mr2426629637.13.1792771459736;
        Fri, 23 Oct 2026 09:04:19 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cb00a17fsm18537a12.18.2026.10.23.09.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 09:04:19 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 16:04:18 +0000
Message-Id: <DMCCFYFSY28Z.2BL8TJ1R2QZ1F@gmail.com>
Cc: <zhoujinghao24b@gmail.com>, <rafael@kernel.org>,
 <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH] cpufreq: ext: serialize BPF registration with
 governor teardown
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hungyu Lin" <dennylin0707@gmail.com>, <zouyipeng@huawei.com>
In-Reply-To: <20261023083131.58291-1-dennylin0707@gmail.com>
References: <20240927101342.3240263-2-zouyipeng@huawei.com> <20261023083131.58291-1-dennylin0707@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Oct 23, 2026 at 01:31 AM Hungyu Lin <dennylin0707@gmail.com> wrote:
> The 2025 fix addresses a separate policy-state lookup error. This
> teardown bug is present in the original, unmerged RFC as well.

Your bot is going nuts.
drivers/cpufreq/cpufreq_ext.c doesn't exist.
Stop sending slop. This is how you get blocked.

pw-bot: cr
