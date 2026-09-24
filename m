Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F0646AA9E
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265651; cv=none; b=ZhKL5vbRI+TVecEA4x3ZgulNcYsFudqH0KVz7IosfjHEeKpjCeiKkj9bRJ01a3IjSl8RU7bYIsxXin8/ukQptUMtINyaV7pdqLWPrbqPO+BxrNYzihR41dRotqfpTI4qtu1PTydfAKZrxJv2WJC2CLI2PVlg3+xX/ajByM4FogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265651; c=relaxed/simple;
	bh=fWaHIyGdGkaL2exNAFTc0ka5FHQuCrvVozIJLfHuzxI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=eD1sEy8827gHzDrGO+PzjJLvT1QXZ+WHfIj5amIGLE60NWfOb2FHD7gXzF79cFjEj+pauT3aNH/39xrjz3yWd1sbjpkGH37WIdqH7oXeLaKQpTP4syx76ItIdYqt06zXD3K4XW9pIkhHMLu1Gshp2KsEqCk/CYoX5+b8B7DCG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpEBHQWT; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpEBHQWT"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5121bcf1aso1676683a12.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790265649; x=1790870449; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w3k4RqeHFKIaWIEmDK7rN40hKKfbvnES8Mvv5gU8zUk=;
        b=TpEBHQWTTGwtcZgTsDkFS0gDRfpBP8QL+q6U+osoPMru26pfWjetPjdDja7VpjJ9iy
         VS7ZT68QdNvrkUTw4beKkVurefY7LoTqpM9e4AZivFflPOqoOq0svtIkA92G/XMacYzn
         uVRLsx4htlm1TOT52VBKbV4vZBUUnl8NwhDj5Icu8zMHoXeIUraCy7EQ4YXampIHIsPM
         kuyFqu/LABlYAWzKcwSrfJdBsfKx7Z4Mhbzaz/20Gci2diZ+wqQPl4J3RypapLMl7UOC
         B0OLPhj0w7g/2rZLu8Iy4rkth0Ka6RO8bfsI47cAg/qp2nMfSungBmdHfsx9QyKxV02D
         3njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265649; x=1790870449;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w3k4RqeHFKIaWIEmDK7rN40hKKfbvnES8Mvv5gU8zUk=;
        b=nYkihdJW0Fq33B4syl4yZuveCh9C6roaVD8GOWyA+gujxccndQ4+ex4yvphAkjJJek
         GbT+XDlM5YYpGWG1RMPPP4F3qy2HHjJ73Jf9OAE1MdfwNp4+UG+6NbTz7xZOR2DvnNaH
         PTEO/OalGnNWyf0kpYPRRWxY5VIShkxXQ3gqkOIaeLTv6Kv/qWlfpKxUyzTTfAMQZyYo
         mJWxOQFkzAl8pDUXRt6EYwv+vE5L6XCVYC3HnhABBXyYpCZQd/x48bKRbwGKMTdwRix3
         UdMRlHidgX65K9Ce3Git+A6cHv+6xDHTGwgzmftLkRTDuN7hQYaFGt5w1uDN1sHmw5/t
         XtMg==
X-Forwarded-Encrypted: i=1; AKwUvBy5acyiZCbV+OF9GkMWO2MpuVVz7jRTtdE+ozjrGUY8gdKb7kCnQ9e9jh+YN/hgOENBMB0=@vger.kernel.org
X-Gm-Message-State: AFuF++ni6YAnWi8o5g5FFyb7dxdxE5fB+LIEvI8upm6OtLB6qAkwPEEu
	R7RB+Qq9nl2/K4TzR2ol+C8NPA6QRN1qicoM3tqHkUxPbCVCzJd9pV72
X-Gm-Gg: AYBFou3oxxTlX5dXtCgPdZp144yQtAEk91X+R+lFqNJZeeKemtaXExEkVRGGdOudK/1
	8FnmjbFAcC5lNxDTY7q5jELbdGQ5oOB1EnEiXak9KSIXIUw9c7BJMlTq9tfDxVmJk59p17DNI/r
	JWFgFcScntjm53jm7RGw0BTAZ4kKwjP4k1DZsWzCO4cnsuPznraYe7D+Komw7f5nKRsMU+g8pnV
	oqZzkrmi1+3+F5YAYW93Ef4P+sICA7aibckIbjzvRTK8Xg/7O3xLGiEm6fuePpPQ3jfTRXSjzR+
	hoFttMgQ1U1j9hspCYtojI9oVujWB+0E6duNaFJTn1yk7lKd9SyUAZhAcx0xapHhIGyznUFWRT8
	iRNe/j47AyE12yYvQ2Kb69w4OhgiLe2iDKQ/Kd9XZW0J26hdwgQ4Phz52hVJUiIVQXuMeh5j+oY
	3bxjDaZI4VAfPIcvmjDOYfqYWoqPG8adPMDYA0EypaNbO/QqmrIoJQcih2BPoAmUUNZ1iGByHO6
	G7meGHTRr5/qGsMKqTQrdEXtIbUVGIUbqXrVw3nrXtVFPljzTSKUUXAwJnA47SowjhxcjtXF0G7
	QW4=
X-Received: by 2002:a05:6a20:3d82:b0:3d7:b90:acba with SMTP id adf61e73a8af0-3de0e703d77mr3010684637.6.1790265648783;
        Thu, 24 Sep 2026 09:00:48 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1cfbfd11sm3432227b3a.11.2026.09.24.09.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:00:48 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 16:00:47 +0000
Message-Id: <DLNO7GO4QMNE.23673O3BC9B7@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan"
 <shuah@kernel.org>
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Replace %pK output with 0
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
In-Reply-To: <20260924153153.tlErkAb5@linutronix.de>
References: <20260924153153.tlErkAb5@linutronix.de>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 05:31 PM Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> v2…v3: https://lore.kernel.org/all/20260918102610.gxA3km8_@linutronix.de/
>   - correct the subject line
>   - correct grammar error in the commit description
>   - Pickup a reviewed-by tag from Emil which was sent for v1

v2 was applied to bpf-next two days ago.
See commit 79dc258c9392 ("selftests/bpf: Replace %pK output with 0").
The code in v3 is the same. Nothing to apply.
