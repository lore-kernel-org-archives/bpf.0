Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860B2F7F02
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615355; cv=none; b=KOqNA6znMRkSExkPKM7VwTpOegjM++ApIx5pXjR+RrOqFp3QkCQZrGwk2FvxyR6XLu6cie1XxK4trc27ds3/dd8sWo2Grxj3Rvk80cCfbdXYcRKBH4SqA60a4cWw4jbxAtmImE0VaqtiPxJt46pt85UpCMrwNpCXJflPkYos2G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615355; c=relaxed/simple;
	bh=ZeBj54ggXsLdjqCMa1yT5KFc7o1ExZa5IiPgFr9KRUc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dLb4owGhzrGwcPjU/SHs5AwxjDnSnt+HcbRkJ592ZF0blYc0JLH3lQcePodgcwdQszHxwlMSdwoGf1oFk9LTxqERPZaU/hQs0Vehp2Ehoz/2+7HgFoze10orx6vdzcAly66vdahaR/R/KeykA7RLvz1+nJGI7f3YBbewuMuqMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNZ+T1+X; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNZ+T1+X"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84237c55ef9so665137b3a.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780615354; x=1781220154; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZeBj54ggXsLdjqCMa1yT5KFc7o1ExZa5IiPgFr9KRUc=;
        b=sNZ+T1+XAfeTyo/8oPQ5ryCSLhR82nTHPZaG0A5CzWy5PThDWB02JU3JrKlyi4j+oD
         6/VjInUXfaiwSJnX+2QuFgefgM+RRSalWzTP8FCCA7Yn0wGfeA/7Sfe+v1ksGF2r3ReP
         4dAyXyz2HPq+qwCXjibZuZbU6cH6mGt7DZmb1+a6jdy1Ebxp7KJMLfjvBt5X4Hfh1uEi
         s/8bwroTkvDEz3cvcH3Uy16SsMPWcD6d9I5Q/gwFuZtzj5L762IPVJVHavOVvL9KgX+y
         6KdjDEoqAmtRQ1qVNjf+omAY+R4C3EJSkjxn3s3C3KOpyxr9ykvZzK7x52g6ENbCRtIG
         +tPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780615354; x=1781220154;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeBj54ggXsLdjqCMa1yT5KFc7o1ExZa5IiPgFr9KRUc=;
        b=awTxaHbhR/rH+YuqVN0cv99rgnRwLO3BmKcjCEDLOjxrPbE5KXNp2Z31qkWw7wQExm
         ywgWO71tuj2qPXuv74WVvKq+k2cRK8XNiY5bNnOLSHbsIm6PROng8zWAF3W6gq6fLRdH
         tFV9I9VqYiZaWb/4JH5ht9X6qCqVSapOAZJAtGUwkya/BxN2KzRf1OFN1G+y3iVQ7kty
         kyAGS+SyoKDWrqZ3k+z1TNZ9RmjeVCFUOjpLhyygZxhjvMHxQLuunsOQ7Gbo4R3t7bZo
         0U2X3tciowudOu+6DkQCU69CgI1qVfnqLuIZ15I2qPy5tdPkX6dDL6+mgMUr8EhNnxWs
         rQJg==
X-Forwarded-Encrypted: i=1; AFNElJ9XLBT5mL7+k629uZaXQiqvJ2v1vZppo8xEKu8zLWoG9r8vzgR5QikQAKEnbft59Mfv0Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx74fuUQhmUUOHOkJHktRxrg8WZCqtPfDfNexD4F7HofFVJVG4x
	LvxuWa/DLoWWfNw3EJFFv10NwpZgG3jBOpSl+0yTxYhfLTdTXRqipTth
X-Gm-Gg: Acq92OHve0VwIaePOWEEprU6ISBQDBrEE6jpTa11xdeJMcftDyctplwOIZTS40BobvB
	K9n3396PRsllhGqXOUVK3kt63qcukKF9pK+n3zkC0ZnudIIwHiw0C4wsgAGAt5PY74sqiWxiLc3
	P/y8CT1B9uxXXhrJlSRFnTvLA+H9BlUAlQYR6d0/etHF1VKpEU5Ivr0HkwDd1CkezXzWvGuPlCC
	L8Cx2AX3btKP2ntG4XvyB85A2bvhqTNwdoaF3OsyPVZitN6l4PKpgawHUVIgjn2rEmKYoGFHqhx
	7uLir2GHu/ESUZT6i+r9cYs2arDS9NyOenQH9yTbojoG1GZgv9+3KO89M952gE/5raxvnMIrwok
	Ha4C3Rz72UPu4ac+qGaSF3ov5tOmBboB1Gt4DDo7LGheOvEPHmOiTZX42JfP91QAXGgRNkikl12
	XoYHL4F9H1tBxXYOL8P//6XimqfXEH8VoiQ9Y/fNV0KZyTahzARn4BMDePCfv2ZA==
X-Received: by 2002:a05:6a00:9088:b0:835:7c0e:b529 with SMTP id d2e1a72fcca58-842b0f6f467mr667964b3a.12.1780615353973;
        Thu, 04 Jun 2026 16:22:33 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828d6bd1sm8693864b3a.44.2026.06.04.16.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:22:33 -0700 (PDT)
Message-ID: <782e8b4738a5d8cf0d636149eb2bd87d9f21c425.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Use bpf_dynptr_slice()
 to read file dynptr in leak test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Thu, 04 Jun 2026 16:22:30 -0700
In-Reply-To: <20260604220904.1032145-4-ameryhung@gmail.com>
References: <20260604220904.1032145-1-ameryhung@gmail.com>
	 <20260604220904.1032145-4-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 15:09 -0700, Amery Hung wrote:
> use_file_dynptr_slice_after_put_file() reads the dynptr via
> bpf_dynptr_data(), which always returns NULL for a read-only file
> dynptr, making the example confusing. Switch to bpf_dynptr_slice(), the
> correct read API for file dynptrs, and read (rather than write) the slice
> since it is read-only. The test still fails as expected.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
