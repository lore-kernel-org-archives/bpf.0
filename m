Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048492F8EAC
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778981575; cv=none; b=u6y640ozFuHODL98zLaoaatNhq6yLgiWDLvx2UFihga80jAzOyiES1+tXNZ5i5I3zqBH7GtaNrgbTg3L3jmlxx92881Q/La7i/fkb1FHVtarMEcJtVTsVOjmACTMkeJLH61JfNjhfulseX0FKjaQdcbNgASALRHOzNI8IGGuie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778981575; c=relaxed/simple;
	bh=vM7dpFsn5ov8F0liu1dS7ratbNckjDrhOhCUfYNjLzI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VLmNzhzP9SWUgZzWXjquBLQtTgN8hx9ioCFquWAkabEJ0YOV7RhT7avPKwYx0cME1CKvrbMXH0j+yYSD03CNxr6Yg58zVRofZ8OAwYyOMsXy+ByMyRyybnCabZ0j84nZBXH0gvIDy/fWSP2/cLPM2IhzsLZqhG5uwrfbQsy9DKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj6R3vDy; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj6R3vDy"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7bf02533706so5671147b3.0
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 18:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778981573; x=1779586373; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM7dpFsn5ov8F0liu1dS7ratbNckjDrhOhCUfYNjLzI=;
        b=jj6R3vDyElkhUFmgAsP82ArSxFYXiHoXyJKfcX+mXYPzqp2smQgMmHWNmAxCNiTcm/
         472A9ueEexelywvD2r2/mnrhVM3U8n2zokAMivIOuMho0cQL8zBcw8tJ+HHXZXtbFE3Z
         lh7UFD4xzoBmB55bWfn0c8trye0NaWzUedfsLfT0KaY275tB9ZP52kASbA8cG0I2raeA
         IyNsHEV7iCXH3w2LclSgJntWq79OGneewy1CmLD3V4sBgZbwAdrORzQKSEUZY3h4nqUv
         6NkHHidkZhtkkcvnuZ3Rpl5X/1in0HP+5DWbdHQkQ4OJwD5Opt+wufLbob9CP/4ZYDVT
         4l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778981573; x=1779586373;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vM7dpFsn5ov8F0liu1dS7ratbNckjDrhOhCUfYNjLzI=;
        b=Vim3Zjzp8MNahR8SksiOOMKV8EYmHnROARia6lx1mDHi74FpfEiZpA1Yfr2Qelgizv
         UPmW24uuGKqDkT6PWT+wFweNAiNE2loqDCOeyQFvW3y7RP7nDpXCbfeaB186jcA+BqHv
         FOFhBU5XKfiIh8dL8Nli9zfFbMmGQqEeC3EhZDR9ZVTHviE24vEhQH9k/XZy/QNxHfv3
         /v42EU0Gh9QCRYVa+LKEuZOINVpEY0VHbGKen8hXNi7RQyy2thglmPpDxPbJru96FSIp
         YfwdhK8NLCc3A3bafSSEGPDmsDAyIK0VbE2MApSRcBi8TewGExqBg6HYmbd5dTqiPxhJ
         quSg==
X-Gm-Message-State: AOJu0YyB2aWsL4dwVqlT4kB1/iSoaMXtP4UENtrVKkNHXyrQ8ElXK+Cs
	ZGD9NV7px+S9LRQ24PVKFoGVYeDoW2FR2eQwQ0E98fp5jjgeJOm+XEwM
X-Gm-Gg: Acq92OGi5I2QCGSSegnCUmdlOzoUQMs+Bj60Bdq9/ZT/5jAW9kOvY8Fsn9W1JD27jPQ
	oNpwLC9mfhb+1yyy1D2ELSZEA79bn3bZM+u41A5S5Cc288Eem/INV0eHveOdL6nEuilc5kcXEFu
	2HisEXKCczKWCLtUGIXBL2R4J5UI+Jzrc6pl98SQpw/cLhvNjuR08kG+sepiHISzyoMIDdbcEcz
	5TSQo0Ptw6CYshixMJyDGoR/iDesriS0c1F5P23337wcxHp0p8u3kZsvyqMwPJw2ttcIop5tl8j
	7g/DcIq9ZS8JNFyaaEy96TD5C4yLkaEqMG2po17an6Ml4ddWcbB4LZKBx/dGiM4DcwmpvJzcHj7
	s7lcxaNFwmvwlIpVQSzYtQ9qOwVxkaS/Mo0ApSZ6Oaij6lxz+zjiyZ7tCGdaeDglsehPevHKwww
	z1HAGYOio305AbMt53rVZZHUOfaKqTY6MON1jAwI0JegFbPQExuHmh5s+ogq/880v1L/5vDFauC
	qfPoUFg8aAwIq2kXA==
X-Received: by 2002:a05:690c:f09:b0:79a:b9cc:2100 with SMTP id 00721157ae682-7c95c00dc67mr115014067b3.35.1778981572872;
        Sat, 16 May 2026 18:32:52 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:4f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0dab3sm2342547b3.24.2026.05.16.18.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 18:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 16 May 2026 18:32:51 -0700
Message-Id: <DIKKC3RENM6O.24MCCPOVFAVZ6@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [PATCH bpf-next v11 00/11] selftests/bpf: Tolerate partial
 builds across kernel configs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Alexei
 Starovoitov" <ast@kernel.org>
X-Mailer: aerc
References: <20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com>
 <DIJ8QPTPH61Q.6NT4DT90K5F9@suse.com>
In-Reply-To: <DIJ8QPTPH61Q.6NT4DT90K5F9@suse.com>

On Fri May 15, 2026 at 5:15 AM PDT, Ricardo B. Marli=C3=A8re wrote:
> Hi Alexei,
>
> Just a gentle ping, please let me know if there's anything else that coul=
d
> be done in order to move this one forward. I believe everything has been
> addressed.

Conceptually the series make sense, but I'm not a makefile expert, so
waiting for human to review them.

