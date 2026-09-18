Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424151EE12
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757180; cv=none; b=NL78iE0btVCRVCCvSPncFbsHUAgFoMqnvPpUxoOcch2y5Aft9EOu3MA48u/B1k8WOZmS3RfRJqg29GDj7OhZp31m+ix5yiEjmVxrKKUV++igvHvqgbYWFtzGImGPRz8T9sx8DeyTq5axvjH7HpRULtPgbVsLEMlr+ATMibC87HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757180; c=relaxed/simple;
	bh=UUNFU2HviO7KKaPpG3PytRz+1XdJ+FTKwYu0Lk5oxK8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c74sIFoXL9YlaHPaXb6tHgH3sL3u/89Os2Gnnulc/8STX5IBh12Tx8qyDwIZmg2AAZ8xvKOiab2tI+gEC9ecfMsEai9ssau+d3l7vujVCtuJ8Hg73pDwnlL8s5+kBKXh7kzD1ns6X4/pg2/iqX+n1+LkCwbxKzdN4Q6Iq3tZ6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9SEf86V; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9SEf86V"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0b25dso11986855ad.2
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789757169; x=1790361969; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UUNFU2HviO7KKaPpG3PytRz+1XdJ+FTKwYu0Lk5oxK8=;
        b=e9SEf86VqIf+kIeZRqh4W/zd0kGuS7sPShs9ot7rqDmj+J6NiQycjgM08obP54sGZ3
         67SWmODoQfnYCOQtIZsdc+WBwvctDPksLp/dz78bUq5rQnGZy9WrDYYkoUB3hkHFGtjM
         AFuFTY7qgr1ivoIsQjiXtrtujB3c6PZf1oIIry9i5qT619MfuzWS+LLkTRPKztKobnT4
         SLoCgGiNxjeoNtmtXzPyZ5eGiLgjM16ChaeDkQQAFvVGjnX0evLWQd0NK8L6wjkVf7iU
         cNSqzeMeVgPf8MSa1yHHkMRFJL6VUKjnCEuZS6dbah76c0sI0kICqap83ACHXO/WfCNT
         je1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789757169; x=1790361969;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UUNFU2HviO7KKaPpG3PytRz+1XdJ+FTKwYu0Lk5oxK8=;
        b=fM9JkRiJCcRFHZ7VOFgXxNmqZtkfIy2x3gkdPc4gbvb1UR8nJWuOtVwwKaZUlPP5WZ
         QCrMwj3AWTnkcCquZS306dp7/ZlTmTRIHMf7JfWqhRko/oYYWuPEagN09FaeyvNa6W8K
         XsGwsIcSJg3rq0TS8TD223W29Brd5mUafvEXQb1aBp8wSlgJqRyFXwEGIdw0AJJ5+szb
         6XPuCWHmyKxXVzMAmvVXQyzfeasXSeY3eR+bKWOpYpbXpaGNBTMryNy7M21IqspGOWxh
         Z/vXZbjSWHIawp/piBNSY1O/TqyZZe375AkeYiH0beudUeMEos4Za0lMdOyzDnGBP1WQ
         wWAw==
X-Forwarded-Encrypted: i=1; AKwUvByqBpiuQy526ooiG87D+w/6Z+YENEk72wiF9ugA344yCQDJQhKwmTdboUEbcpezP+TBX+o=@vger.kernel.org
X-Gm-Message-State: AFuF++kuPHnIpWMGpGQq3yGc7Di+vxWbbRMDNXDsyGbnjmibwWkVDvKq
	du3AD8mRT1o4MMZEtZzSopfUCXR0/4T/3zMcQAfrx60WB6fQVVedN8Lb
X-Gm-Gg: AYBFou1aqZq12dc5gqAyVlkP+zi6vaFcofy3xbkCjzPp34WOtmIpecNJnQqAPsWO7ZD
	E0CZle1N9nqW6kN9XVeZo4c764VN6VgObUZh6KW8cSlFJRbxs1cYR2ga3xJZxHEEdcGm38SpwpQ
	bjoEEWl30xXUrYwKPLOiOcGBp3vodF3iusaV4YLT/8WwsBGvqUIEkocc1C+TVfiHg59DYPMshK3
	rgZl0MrPxK2eH+BImArw9bgrMSycynQ6ASdtIex66nvKGqVydjTpa8e6FHkd98yGTwA9Gg+Ppea
	fvYJZa1ifPAfDQ3zP9Qecd+7IsWHN89DzhVy5OwkAnymaXF66aZ7DdDe3/cGzpdgy+pem3YMMdH
	JUXvHLYFk92i7PEONCf8DCO7JydUVeO0OZgG3L8K72YJqNntk9GYBU3px5uvzKQbI+a3t7RzSZg
	Red365Qow7Jab6pz+RutpRLlyX6xRFMPrCxHYVJK8rzyskwICL9cOMM276ebZPdHMLH4gskg+Wa
	T57WbdRi6I1dN2cwPpo2NZwnihIFtqYsE2nc64RkAxnivWimuT8jT633CtmpJ+A+dIW
X-Received: by 2002:a17:903:388b:b0:2db:5f00:ff52 with SMTP id d9443c01a7336-2ddb1b9c159mr73653045ad.22.1789757168686;
        Fri, 18 Sep 2026 11:46:08 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:e136:8952:772a:93a4? ([2620:10d:c090:500::4:e681])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c32da4960sm677717eec.0.2026.09.18.11.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:46:08 -0700 (PDT)
Message-ID: <6df2f04998f838fbe287c207ea7bad9a9925e719.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/11] selftests/bpf: Add LOC_PARAM,
 LOC_PROTO, LOCSEC to dedup split tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 andrii@kernel.org, 	jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev, 
	song@kernel.org, qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
 puranjay@kernel.org, 	yatsenko@meta.com
Date: Fri, 18 Sep 2026 11:46:06 -0700
In-Reply-To: <20260916074118.1007116-6-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
	 <20260916074118.1007116-6-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 08:41 +0100, Alan Maguire wrote:
> Ensure that location params/protos are deduplicated and location
> sections are not, and that references to deduplicated locations within
> location prototypes and sections are updated after deduplication.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
