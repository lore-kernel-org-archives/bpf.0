Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824E146A66
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776191546; cv=none; b=r2RA+rdODRP4zl2J96eLFe22ibqdZ7770gjvvngHKl7J/VaH+lPJysOqzce/edc/lzdjphIHbEyh3B25MMLm79nsEAgZAB+E4nC2Vz/No0QuEKBe6LsuxIiBsLp24NbOWpd6CjyBEA0BvVGrfEa8Pv1XDD7ZLsyf5BuOC7K7dMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776191546; c=relaxed/simple;
	bh=pqSJ63Uro0ixE/GwGtXJZgkMG1Um7tkSp2VgdgcIe5E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pm/8dfJZeu3M1rohHhuNXz2xLEFS/xE9IYVApp47umWJ4tVYdubT+iSCG6/7tA20CsGv+yPangIYhvMf8pzoaq3TbaTKa2V3jDixtTUqlEOu0I/BXkLR4T23rn4lrBlIW/m98xE3gFHBD2msQluxnNsfpJc0Fa1KJPp1mAXhZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4hIWdNZ; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4hIWdNZ"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c287eb77fso8743776c88.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776191545; x=1776796345; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ly3nPoYLyh6amf7MJAsQye0KMsL7fp9Ld2f0OrnDJXg=;
        b=c4hIWdNZQXvPkaA+aOm9MrcQfTNTLYiI96rknMvoIxwVCjU1C5H7uneotnyHkP8Q0+
         b4yPR3KwyGNlX0ovrD1dv/zCHUzDfOp/dqbUCcnCXAlgB1GTQSUHNksxQIJHejxnAnTO
         N0dSqLoeNvzrPKxgNYdC+n6toCBvuzv1/bKrU3uOcnZqeDtB6947lkKsBWCdaANyrB4v
         X5lXX+bmJoiizHm1rgJg2UF/vT5octX34BVZFvxxMYewIAyZD6/qZ58ctFF1lt7yiKoK
         ys36Rqj+Gu2zn82EfT9eOLL/KcY6Vq2tmzHAnv8yGcRr50zp7VQsX2GCjBnAMnVhI8rj
         orBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776191545; x=1776796345;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ly3nPoYLyh6amf7MJAsQye0KMsL7fp9Ld2f0OrnDJXg=;
        b=SEfDqL1/EQxAzwUsgyYAnSrvpmtyDB81YB+lo2fPf/TCw1H0HCVw14/+9IfjtsDbKH
         GTJ991jW8Dvq1skWDNU3w9fz4iLTYLjqX7jGSNIGm1NtrSoZfLlWNhADrycp4DlTZX6R
         SjzwlIVYTQTRvvsMvqwSVVipwwVXi+PtlOpGy+dI7yxjamgMD/9oAq0WRKStEQUGVCVb
         0f9d0uq12A5O4XPxWoImjC3a01QGuUhvYThKl8Sjg/Cb4XMTYxRVVeXVs51i/utFQzd2
         1azOJS+j2bkN76EfU92fwHsx5dHLSXYYQfE8sbWxmmWGDHWO54UZvjgTx8ZZaBwixxQj
         40CA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZGE/n0RYFXlY08EAZcIgJpO93kvrr8GM0D8WRfcJ0zFSpYTGEBRI3J4LpuJt40tz0CPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSfBdu8zaMja7Mf+v1OKs/NXF9OrKUB0d0n6yMMcLH98QZjsO
	WKaby15zG35d5t7gjOmh+7BtcO14CNXG/jgMFp4eT4bQ1eZU1SzO+egv
X-Gm-Gg: AeBDiesNHGEgthzn1cMbuoQlnEOAlShsYB7sG25a+kdOukhgoHpz/Y96QaSxzlBQco4
	qzI25uBHX9pLKpt4D2GbHViXcAwOYVwzOOA6OQAIjHB+FuCLADal0buNRqNTiZB/zY3wzICoUz4
	JcV33nFxcq5aQDMVupcgnWId8nw84UCxRJq98BMOp0XlnnLJwn6TcRs3Dwz1l/C5dN0a9EOoHdB
	Ul5PU335AcjPY8JZHBrrJYN6yHSTlR6QKojXT0ghlljn6vO+QNrL7TYBvAvzEy24WXWUsoCB3j6
	nvvddNNLefb2F/VFd+aQPCvkDzxNwTuCS6PCb6NtGy/UIsuVjU9lXCtFWBjbhJWyc1bqJu9UnWy
	5VfgE/tBokudrpLiT9y39pHuuQuGGLOodBKMxP/2vprOpSX6hQw2tQ7X0+wlbLjAaWTzecMR4BK
	xS1B2RvIB+dqccgyxOYYBfwovE0RGjxYs/uTqCNJFXCbaheG5OPoP8GKtAFxPj5FwDwuw+1pmvk
	7iWQg==
X-Received: by 2002:a05:7022:6099:b0:12c:22be:385b with SMTP id a92af1059eb24-12c34e92ee6mr10867313c88.4.1776191544439;
        Tue, 14 Apr 2026 11:32:24 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b98e:bd6b:f141:e7ab? ([2620:10d:c090:500::d8d4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c4b323428sm12395806c88.4.2026.04.14.11.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 11:32:23 -0700 (PDT)
Message-ID: <2aaf049fdd735f642f470ca6b0822bddf07a5eff.camel@gmail.com>
Subject: Re: [PATCH 1/2] bpf: deduce_bounds_64_from_32 tightening with
 circular range logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Helen Koike <koike@igalia.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: andrii@kernel.org, yonghong.song@linux.dev, ast@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Date: Tue, 14 Apr 2026 11:32:20 -0700
In-Reply-To: <aa97dc1f-02d2-4da6-aa17-9619e2b6f999@igalia.com>
References: <20260410124035.297632-1-koike@igalia.com>
	 <zeqb2e3d67as3an4u6h6dgvqymchgiyvx2p7mu5u7ns5rx66xf@j5flwnwsud6b>
	 <aa97dc1f-02d2-4da6-aa17-9619e2b6f999@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-14 at 13:25 -0300, Helen Koike wrote:
> Hi Shung-Hsi Yu,
>=20
>=20
> Thanks for your reply,
>=20
> On 4/14/26 5:26 AM, Shung-Hsi Yu wrote:
> > Hi Helen,
> >=20
> > On Fri, Apr 10, 2026 at 09:40:27AM -0300, Helen Koike wrote:
> > ...
> > > This is a follow-up from discussion:
> > >    https://lore.kernel.org/all/7fb97184-baaa-4639-a0b9-ac289bf2e54d@i=
galia.com/
> >=20
> > Base on the original thread, I see that motivation of the patchset came
> > from a Syzkaller reported issue[1]. Can you try to run the reproducer
> > again and see if you can still get it to reproduce on the bpf-next tree=
?
>=20
> I just tested on bpf-next/master ("71b500afd2f7") and I couldn't=20
> reproduce the issue from Syzbot anymore. It seems that the branch=20
> causing the issue is pruned now, fixing the error in that case.
>=20
> But I still get the failures of the kselftests from patch 2/2:
>=20
>      * verifier_bounds/deduce64_from_32_block_change:FAIL
>      * verifier_bounds/deduce64_from_32_block_change_signed:FAIL
>      *=20
> verifier_bounds/deduce64_from_32_block_change_conservative_signed:FAIL
>      * verifier_bounds/deduce64_from_32_wrapping_32bit:FAIL
>=20
>=20
> How do you suggest we should proceed?
>=20

I still want this for the sake of improved value tracking.
Please give me a bit more time for review.
