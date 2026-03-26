Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9833262A
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774564111; cv=none; b=mupAZeEB06o46TgoSEZOcfMay9dKjdD3vuDkIfQZYeU0YPki1kYA8kkuJlSA8kphCspU8AHmK32YMDvyH0sk2fY4Rixwy7t/53vVlWGo74SuNdAYPiLD1LUsSNndwHWFDWMkqLzt89vZSgmAn5cYz3n25XrEqYjGGDdl1G/zW8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774564111; c=relaxed/simple;
	bh=OdFau7ZPKZNrNf+z104fJybdiNYb/YBdk7LgGcxJ6AQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CEKYRSGoy9SGKUVJLI/dZdLqc/lmt+DCp3TlwhZCxOKhriAs0RTCUTw4W53LIQtrOF+MYIdzCeArnb+tlkD8vP6yXVsbpGGh7hF5+Xsu5vffGM+Tb7iYoECDxx894+Md1kTlZvk1uN6Ozpl9nMdsRWL8E2E/WXk/JJ+xHp0nj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWHJgJPr; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWHJgJPr"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c0c955a481so3323453eec.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774564109; x=1775168909; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OdFau7ZPKZNrNf+z104fJybdiNYb/YBdk7LgGcxJ6AQ=;
        b=AWHJgJPraaJxlJb4viZBOnWDnlu+F8YrROLoamOIgrZXHxMvzGPchRI0S0C0JMWh0z
         Y8DEOCX5+JWPYoE2f/ZMCusNoL2j4yViiCwNmModgJZrkPJXAPaEjLiWqQSfkcS/idFp
         c5/TcyzEisR+N6UjZdJQwczeBNfmvMF1PCktCNN0Js8AU0CuSOHdmE0sRu2Hu+Vy+wJl
         /ag7vqUlI9OLqbLcBrs0Dz/W52RX63A1qS03gXZEnH7/fKuCeD7NVbLKsrTkXDrHYnLt
         xmyZY5ceG8PH+iJOLtqeOafthbWee7EKIvekRFFBpBXWIg4AvTowSBq5OeAgPG+K+jEV
         OqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774564109; x=1775168909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdFau7ZPKZNrNf+z104fJybdiNYb/YBdk7LgGcxJ6AQ=;
        b=GHGXCbdJn/JRcjOy3tpMQtRcWbKJWhq1aeOtwvVqvuxAzEf+mxT3Bu2QCVbLc+wGAc
         6KqKBkW4J7rQFq59wG+8pK2fhgbTpisnfNJ7xfAojQ7uUNMa+EY+Ea4ZcmV8FdlyaR+E
         vy0a/hcXDuUTf8NsMXKEfDQPthCTqZEj5155O1CkOLqP/TQLuKmTrqswc99TXq/HLC0a
         9hdZpjYlTJUnsvdQJNlmREsjNpM1Kf8VvF1QvsTsR6bTWxx+Kr48yBlVkGMSggQth2dh
         SvIwLrehg2DXadAFruwZzcjSPa8AfFVTOSo0xo84z4Jsd4nqM6elyjvWPGqmLoV1Oezq
         hBuA==
X-Gm-Message-State: AOJu0Yx3cA7/CeI5IBxFmwaLSymA+u7xykMo5OCjoJmrUlwYrRy6r0NR
	XGvGbvDt35fYmcE5u53IqiSIqQiJ0VJOLHj9oFDLu0SJ5o3Si0NO/FITVucqG/i6
X-Gm-Gg: ATEYQzzPg7UtyUMXuSPvxJh4oi+W4fkwKwMMSKyRguqkjo1omYi3ADLToFj0l5MjmM/
	EdZ/yWxSvB24wksO3obWybxLh0noat9P/YUatVnEbj8Dd9xzb4bCWFLjuHuXX6PIJyisF2Xs0rO
	fiuU4EpIerGRQ2mLDO30QBSAoo2qISmuakZI+zgkAu6IogkhAlBvD56OzdQ/43hZdJTwk7dGxxb
	At2qZveg76OcgYN3R69Ka9t7B9Mxovqnoh0QU7iFLCGTuqcHoJ8w//pTWpHMz8ugNuLWY9Wf2h9
	AA+sOE9qI8lIDKWV78dGjZUF0CEXoiqUPmOSdZB2HltD2m6Zfo0A2lzbfirdkPCDzulTHUEuF6z
	JSN4Sd/JvbeoamCj1tKFSaHjAr1zmYNDbgrGsvOJnhIMi3yi2i5sKIMr+cZ8fS4ud9h7mkIPsPd
	J7MdCkB7fy79aMwhUkViB3k4hQlCQj1TcHmiBZogOApd1TRCDVcJ6SGC0bozVpuG5UPyHybj4aO
	k2yhe92jPf+VM93BXM=
X-Received: by 2002:a05:7300:aa8d:b0:2c1:2706:b41b with SMTP id 5a478bee46e88-2c185ca3a17mr241855eec.6.1774564108608;
        Thu, 26 Mar 2026 15:28:28 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:4a82:c020:f551:481c? ([2620:10d:c090:500::1:634a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16edc0436sm3501923eec.22.2026.03.26.15.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:28:28 -0700 (PDT)
Message-ID: <5bc26888270c2c4ac32489ad8cdc8e71fca7e2db.camel@gmail.com>
Subject: Re: [PATCH 0/4] selftests/bpf: impose global ordering for test
 decl_tags
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, cupertino.miranda@oracle.com
Date: Thu, 26 Mar 2026 15:28:26 -0700
In-Reply-To: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
References: 
	<20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-26 at 10:39 -0700, Eduard Zingerman wrote:
> Impose global ordering for all decl tags used by test_loader.c based
> tests: __success, __failure, __msg, etc. The tags are now sorted by
> testing framework to be processed in the same order they appear in the
> C source code of the test.
>=20
> The ordering is necessary for gcc-bpf. Neither GCC nor the C standard
> defines the order in which function attributes are consumed.
> While Clang tends to preserve tags definition order in the output BTF,
> GCC does not. This inconsistency causes BPF tests with multiple __msg
> entries to fail when compiled with GCC.
>=20
> This is based on a patch [1] from Cupertino Miranda (see patch #3) and
> includes some additional cleanups for test_loader.c decl tags
> declaration and processing (see patches #1, #2, #4).
>=20
> [1] https://lore.kernel.org/bpf/20260305130035.192080-1-cupertino.miranda=
@oracle.com/
>=20
> ---

I did not specify the bpf-next tag :(
Will wait a bit and resend.
