Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E030E828
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 04:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789963348; cv=none; b=L9pvVPljFThEtrmrlsiEUjIk1HfDuNK7MibkSiRyfoUnLbDTDvdT3o+B5ZPpsuHj2lZiyZIzqv1+dG6RUNY9rnhHgpgyogpNMh/T5JiYuBvwejwD4EIeey0pAPSibdRcLOTuWFWVhKReGHK8sZ48Q6eVcbk8HbSbyRsLUHc1v8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789963348; c=relaxed/simple;
	bh=Ciwd+HjJpBnwHVYXNB2fo9MOUQS5c2QyhgXBMzQ6itE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DF7CvFdnHF+7prhCIYyk6HMSc/24z8YYNHCgmlPAAzLVqboL3OhEPLD1V9yQutK8d1YkFqwCPTbgFVNVlojcOgS2KGJOqm4t248C5Fv3tRekcfqdYGhuagUcUbFqncYKr9jDsF4yPXTmXEnn1lY4JNoKV95SIZ2GMMwxCfvFHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGGfpkxy; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGGfpkxy"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6e43b9d8so9413575e9.1
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 21:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789963345; x=1790568145; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0juRQzdf6nmFbDGjlJJGsvrFrjljT+sRU6VdT0gPqE8=;
        b=AGGfpkxy2yJECa7wo0zerf3UQtMdVQSC/L/dVWpobxeslrH1YbV39UmTgmSOACRAww
         UTjS4Z2AsjdTr4PEdxy7SJzAY9d4pJgfXp7ahxl17/e6wNf0ZZaqey3NZCf67yb7eiAE
         EhrbHmhrTUhh5xVRxXyh3473JTe/6c+ERa9WTE6TmWed4T4/8fL7FomyUVtDNS0QIU2E
         bepHgckQMmofBMdgXFtG5mmv71JcEUQVBp699mu+JA/93LBfmlYEZAdjPZt8sdvfxU9v
         QXlz4GSRexerwRdRQSDYeYi7Nz+qG+ZP6oSLDYyPsgyMYYwRu91YctJWhrpjvnGtrLKz
         vODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789963345; x=1790568145;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0juRQzdf6nmFbDGjlJJGsvrFrjljT+sRU6VdT0gPqE8=;
        b=yKnuQNZeOQ8J72c2G5Fbzj9UvpGS1wa3SD7wbMx9U948sl7jHs57UOcEeq5xQVurr4
         xudENtj7eYAJ3fUB9Tzv+d2TTfeSYijzng0M/A56PUOotobc0EeYQaDRnJ7hspc/KKQ9
         wTnS/erai37W4ccEwvGkQoyNcK9x2hQLp2giLywEs//0o65gFX1+OKipJaXiZMHCL0MH
         GiJ4Kzn19IsbnmCrB6XpKVOYuyLeC6v7YNzujK4+1/zBPzCS8naIbLooAVrUHJ9lJnrx
         WyWFVqlh/HyvGVzekOn0pTnYkXgDYuUweCujY2jjDLg2ufVhNrXtWm6hPAmU0Wp65x3G
         JPrw==
X-Forwarded-Encrypted: i=1; AKwUvBxD8ftK5gfZhVRZaCL4oUNenAIExGCqUcWOZmmSswj1WBIQ9JG2AtY8cph8A5aNqU6i2yQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nPKbcwUeBFrR7Pk8D+TzlvIOkAa1vOCsOZQL9Rtj0zXKvNV2cV
	348THz4l+2Hnd3je6TdZdaA6kyuROQcaOJP6ClReZ2MpGBxEjagv1dwQ
X-Gm-Gg: AYBFou1qcBs8uRQF5mJC0Fvtyhu3Jv7WS3I0jZJd6v3mEepRzH1lGpOPqhH0/W9bPd+
	dQrUVYwUYp9d5OJKw319jbaocHMowYVN6gCFgZnBijb+mQCX2rzzkSNp7ANCtgdMFOnzY+csTZF
	fF5giL8156xceNFA5HKITbzRednltjOSjjW2cH53Aj/7SSIh/jQDCfPyZInieDR7ZY09rwVPVdq
	LWW/fB3/k3bKZ192NFwK7bHqgSD5tJrMWcLb3dScmcgsSoQ9WpjvdXj/zUFp9RWaYyzi8HYk/Pl
	lyyItlS+u8Fq9xG13VBifEj3IrZzhyzRVOxDaHBARUwX3bJJ7NBAcaK1U3OT6DuUNnuWxPgFvyn
	oTXc475WnD6faeYCYtbQFQeJPxFSTwZ334XKwAx1jaYrCsN6xjFdcMQc4ajraieqntHuSpW1+6O
	Hy1vwSqgFkm0BGGU2oz1p70zFL1b5xGvTxDJnbXJWusYP/TvHxSfqDd3v8jJVPE2eAgrQrw8nsr
	dEHD02I37bXfPEtgMhZarTCwc6mnsf0e1OPZyWvTuVKL4yfgOEoKF/zd0R8bJh5Cpfd/nFEFLck
	MExFtM2laUYLx/2/hVNPH3GJ4CUdUCnZ79w/yWahZGLTlpxM
X-Received: by 2002:a05:600c:138b:b0:49c:f89b:f82 with SMTP id 5b1f17b1804b1-49fc568f8dcmr115799535e9.12.1789963345138;
        Sun, 20 Sep 2026 21:02:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc55cd8a8sm256725075e9.0.2026.09.20.21.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 21:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 06:02:24 +0200
Message-Id: <DLKP1SE3XQ41.2QNDF51ADS0ZT@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH 0/2] binfmt: fixes for kres reports
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Chris Mason"
 <mason@kernel.org>, <linux-fsdevel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260918-work-binfmt_misc-fixes-v1-0-647b24bc1c46@kernel.org>
In-Reply-To: <20260918-work-binfmt_misc-fixes-v1-0-647b24bc1c46@kernel.org>

On Fri Sep 18, 2026 at 11:19 AM CEST, Christian Brauner wrote:
> I asked Chris to run his kres tooling on the binfmt with bpf changes
> merged for this cycle. It found two issues that are fixed in this
> series. I reproduced both of them.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Chris Mason (2):
>       binfmt_misc: fix OOB read in bpf_binprm_select_interp()
>       binfmt_misc: fix racy checks in bpf set_interp kfuncs
>
>  fs/binfmt_misc_bpf.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> ---

For the set:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
