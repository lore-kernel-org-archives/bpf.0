Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFAE35202B
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940068; cv=none; b=FQXv54K0B2DJHjQCJ2aVmH6aG8xFoLrJIaMfxkuiK8E25WokDpsoB7ybXA/UjrDQaNvGRgQfLTjFPwUgMBJzHV3UeIEw7qcoXp07Zx+ThGJkpYHWxVi4duS9aap0DILtUuEoFnWsv61+DQ/SdGYCkBqoSfvGixPq60dMrkNIn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940068; c=relaxed/simple;
	bh=M44WDjBUvC/ZsVomsBqohG9o8RUxy7HCPDaveXOC0PQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vBzDhLKxB8yXwSWwuDZqeNEHi4Ju247+7PgD1AQS/ioDJ5ORgv0F1P3KTevoA5oEIBN6586fxpKr6AzrzV9cohKkyANvwztaieqGsS4KZtpljz2uVVse0Lh750M7QNgsGU2OaTNrhT96wALOKrwMXs1apk2A9MwyJ4rnlQgfIts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cH5QIu/e; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH5QIu/e"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-306f36df4feso2975013eec.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780940067; x=1781544867; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M44WDjBUvC/ZsVomsBqohG9o8RUxy7HCPDaveXOC0PQ=;
        b=cH5QIu/efiBZLnTrG1WC1d5HxukNxc53qAQ3A/JPkMt8fOVN6WemqpgncxURwj70Bb
         tZdYP7TPycnsyETTceXE6g410heIqpqv2au8dSsMEUNuZJ/p8Q+Ywl35Sjv9TFvqZoZA
         kf/SrMEKO/x/B5LaVPT2W3pXYPHVNFv13z0zYq81IevyUp91ozNrVXgMN8mQYPhaQi3n
         4qYNMoq7yPhS/ryYz7XsA9FUrgGopH8pNi05vPMSM34M/0aRK/eD8CbuZQhasNN78ggv
         p311Jv4N6bdf/2em4pK3/yimuFkQ0nEa7HwQKljxjpHFi+WVscbp2ibLIFRPnCEMCmdL
         DlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780940067; x=1781544867;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M44WDjBUvC/ZsVomsBqohG9o8RUxy7HCPDaveXOC0PQ=;
        b=CYLBIx2f/ApsS/sbXSbdP/qjpZqoxAMhkubi9cntE97mlR6gP27MUhyQ1OZqa3ldCc
         YBF9LBzIio+Zyx5r5xy7TbivIp+7oZjJ5MZmcyRWG6Lrl1QbqhSKwFzy3HdbsU294TbT
         5ys9w5qtGXUEJGE4oPxbZVAGrhYuLHTozF2/0vz505Cfeicja0/4f9LG0EVRQwhfJYJ3
         ZjfEe8peSTtKG9kRaJL5sFWV2+U7VUV3KR6UiNhRPUxJ0w3x1n6pz2xtlmsXRD4KChvC
         P3uQHyEoBeI1Yt/OqOOed+7q4YmuJCpSGN80KhTKd+DV6WUeiPeGsS1t++Hs0/17HraJ
         CWvA==
X-Forwarded-Encrypted: i=1; AFNElJ+dWJtMKNOYhxYjp8hqcfVVf73RfidCz2cR+Rw8pUwMwo9QhvSteTTGiiO4/0yJli+nYQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxye1U1Pv58jBwHYFi57RPFIpz+7RPrPrhOTago+VIYYZRfwLW
	rtfY0gkyTrzPonlltskepF1rcRgm8/rox7/abwlUtb6p63eemAHdnElU
X-Gm-Gg: Acq92OHGkLnQYA08RhELkQBP7hdNFt4uio31PP/hFhz3leCvdON2k/yzwKHtb4RdP5j
	2HlQgqvIE47orh9YbFkL2KSvQda8OClJWjMHOflDV5a28wVNPHmQtuHogvN3J3mDvPLLx+baOj0
	5US/vHJG7OASCusMLdJ+3MHc+m2XjgQnxu2hYJQcSydNgvWrdexeCxKRZ4S/vZsZwQHvIEXcCAK
	4cTBVIOMkcbkUY71JYC+GeNuX6fDy4j1dU/A5jDztUFIPzvrgOWWSUdD5vpfYzG+cdRypYxrgol
	gvaB3lSmcePzLsifUOtvkrrgafLtDgoob37ZeT6H41feiSognXptZka1DVNZGR3Gilr1VS7cSt3
	PEwdVy6nr1yLD0ipmibnNWJp/vqtjGjhf+HNSX8xgNsilq35JEjcFqbTqM++Y70pdPBNhPRep6/
	t5mVHk7Y6rkWqeD39ggswLGWAlgpRc8n5EyerMr9F6AHxVy0q45FI+sUVMarEwnzlwGfLtEtCVS
	/RbVmQycUe75ddjFA==
X-Received: by 2002:a05:7301:da0d:b0:2f4:d190:37bf with SMTP id 5a478bee46e88-3077fff1973mr4855271eec.16.1780940066480;
        Mon, 08 Jun 2026 10:34:26 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:83b6:a2e7:fe0b:431? ([2620:10d:c090:500::1:6687])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db85f60sm21776276eec.8.2026.06.08.10.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:34:25 -0700 (PDT)
Message-ID: <0ee82cb99aace79407131e181c2bdd8ad55017ab.camel@gmail.com>
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: strengthen
 bpf_kfunc_implicit_arg to verify aux injection
From: Eduard Zingerman <eddyz87@gmail.com>
To: chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, 	chenyuan@kylinos.cn, clm@meta.com,
 daniel@iogearbox.net, ihor.solodrai@linux.dev, 	jolsa@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, 	martin.lau@linux.dev,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev
Date: Mon, 08 Jun 2026 10:34:23 -0700
In-Reply-To: <20260608142618.3064380-3-chenyuan_fl@163.com>
References: <20260602093836.2632714-1-chenyuan_fl@163.com>
	 <20260608142618.3064380-1-chenyuan_fl@163.com>
	 <20260608142618.3064380-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-08 at 22:26 +0800, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>=20
> Verify that the KF_IMPLICIT_ARGS injection path correctly passes
> the bpf_prog_aux pointer by checking aux->name in
> bpf_kfunc_implicit_arg() for the expected program name prefix.
> If the verifier incorrectly skipped injection (as could happen
> with pahole 1.30's BTF mismatch), the stale register would not
> contain a valid aux pointer and the name check would fail.
>=20
> This is a positive test exercised by the existing kfunc_implicit_args
> selftest, which calls bpf_kfunc_implicit_arg(5) and expects a return
> value of 5.
>=20
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
