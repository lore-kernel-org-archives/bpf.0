Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D7381EA7
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787597179; cv=none; b=cSHjgI01fwGep3/aA3WnO1oAZNm6mAjiaG4SvTQhrz+5RsTaA+4AhnaMsvpak3lIEXp/SvGh66xpxQpef3acmZq2ER5bRuo5vyg3/GDJV8wtNSP4DdbcBIWlhxjL3RVmRpSae0hJzvWzwUPZaIEujXMi/X236kvCAhlhgt84Z3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787597179; c=relaxed/simple;
	bh=hFlisPcov7OHDuouIps3HhL1FyS6IGvS24RllpVrcuw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+O9e7uONqQ7tqK+sz8Gxv4K6lG9u7ZHchsKRH7hi6Xf0EBhzjd6veQVT9dBAa8/vSZUj1w6FuW63kME8P9QYqlJAQRQfaNQG1SlVEOYX7zvKFNmZiL4D8bEj1uYYi/gNdwX+B0DXiIkthhcjcjKCh9RmHUPF9MmA+Oo5ihISxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vrzbezsq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrzbezsq"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso4765276a91.2
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787597177; x=1788201977; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hFlisPcov7OHDuouIps3HhL1FyS6IGvS24RllpVrcuw=;
        b=Vrzbezsqj4TMiZeTPryZFU8fU2xZxNIjFKh3jV7u0M8M6d89/58kHQ9VKzq+xvc/VI
         QrVIh+uXV8fdkNvoQpK3Z+VjesH6lTiL0GwSmfBi3LY8F9tl53obbl92GTv36wtfW0D4
         nGMkdbQBKvuy/RagDDdrMM7I7J3QKDi14raCaP+kXN2KMmuURuhHQNBuJThJFUZJH3ic
         16J7tSkCITNAexLcqrUxVGhx4d+ja7Shw4tAEtNuN47dy54w3qpOu1vuNMcvK8OHG+XV
         WY7YLfATx9RuSeJpwRFV1gV09tKSaZZ6IN9YxqVYMGVwcJhlNO09vOzMBKSh4e/1SYI0
         7p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787597177; x=1788201977;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hFlisPcov7OHDuouIps3HhL1FyS6IGvS24RllpVrcuw=;
        b=YqQp+xa/jpReN82lE5HB+dPGqG4+hf0WvAJbHf4xpQpxn+tRUNunYzgBQl2dxidFoC
         myx44BNur7p2F1+T5+mxxcpqbG7t6yIi7fjWA3igLVZeJWkv3/dP1L39kJI+sh1bblxs
         cM9cqbNwzg+lm7CHzxyLvTz/dklpRqnb6xWN7Y6ONa4DJ9djneeVElK2Udzc6oaF2aaR
         fyM+w+ZzWs3KXOxhNEw7XOuq3aVPkBlxbevEf6HpOEFWzApeYc8+2ZkOEMgLoS89IthH
         dgjNq+9+uOt8rFrNU2FNASGAnPfsWfqWoPDNruBGB63inKARfKWn/0KXiSqZkXjzQuL8
         /x1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp2RyaAflpFotkeut8/nlrKGUp4S1ZEM0jUKeIvbzfcjXBOrdTE+MMD8/eiu/c9/jcdDWE=@vger.kernel.org
X-Gm-Message-State: AFuF++k5lYYIoPulQU0E3NzKll5yYxtloA4SeXgXsPRkU0h4zwM63Ftd
	5MFSOUTdOosBomFnYm1G8gRWKut+DxRQXOgaGepQSMoRX8ilFL4yoAsL63fJcVz2frM=
X-Gm-Gg: AR+sD10fWUsAKgCp/leiQhezFt0p9zMjz80Hf0YDOJxb7fR6uQ5xbg6fiF9olvAsv8X
	cSTiF1iCHgDpJkyMA4WZtEetGOPXKEgmkgavtIVbUw+3H9tBczofQTwIKGzRR8yjiHEwNhTdZRX
	wjw14N2hp4f3fsQ1weiSlOHkjj5BlyC6dLngGL/r11YeFr9OBz/aITptBeQLUTGhjX22elJzD/i
	VCOuruuS7JYgd3d1b3YBhjb80O6THP7LdssUaAa4x02nN4eDS16CHEHol2gQSZ5DO9s5Ne0bUqv
	THWHCWwgkGoaVVj7s8FHRt/jOzEzONAW603e64hzCwyHdXWc4x6l4N5I68DczIwsmtGFN0Q931U
	5qe9th2SXGSOJmHFDpUjEmZ5E4xwm6WoWx6aP6/iQCJ3s7KHvUP/MM2SnRbX3RrRbkf6KYCnPfU
	sIQQaxGd1gsDSQ7HtHapRM4tXaON+t2XC6mtPv/vr6pG9+AqLIP0b+kso9dU4sMutFKudEcIMvg
	YvjcuEpvaKjyjT8UTly1F3WNH+JRQqdEe+81M0osRNmXg==
X-Received: by 2002:a17:90b:4a82:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-395dee5610fmr32906627a91.2.1787597177390;
        Mon, 24 Aug 2026 11:46:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21a6:ad3f:64a7:7661? ([2620:10d:c090:500::5:ef40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f909c6c9sm32958787eec.6.2026.08.24.11.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:46:16 -0700 (PDT)
Message-ID: <12fa2710ff8650bb8cd89b9ffc128b419f43a254.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: name the remaining
 placeholder programs dummy_test [NFC]
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org
Date: Mon, 24 Aug 2026 11:46:15 -0700
In-Reply-To: <20260821201316.1059129-2-vineet.gupta@linux.dev>
References: <20260821201316.1059129-1-vineet.gupta@linux.dev>
	 <20260821201316.1059129-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-21 at 13:13 -0700, Vineet Gupta wrote:
> Eleven of the thirteen feature-gated placeholder programs are called
> dummy_test. Two are not: hence this patch.
>=20
> This is purely cosmetic as nothing depends on those names.
> The non-complaint setups use RUN_TESTS(skel) which does thru all
> programs normally. This is just more consistent and grep friendly.
>=20
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
