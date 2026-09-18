Received: from mail-pj2-f31.google.com (mail-pj2-f31.google.com [74.125.227.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423A41D11E
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757036; cv=none; b=gGNXIJPuNyvH1prRuOUXQJcavOGSbHSWhNIIyz4wM66pBz0xIGzKpoIYw9/G+5z/TCWFsZCYNMpTg3z9HvJzPUT16DvzdwsM+AT2NRwremMweCfr7GfRjG7Dt7OnxnnOsGiQpFY7KLEYaA8V6ZWVWOeiNRbzg6ZmMpkdmXs7cBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757036; c=relaxed/simple;
	bh=GGX7Fmo/mlUGinS0kwTdlAM262ILdns1fKb84eDFqtM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LhMGe4jKEvhHsI4uTyxiNV5d4Aim3NqO09vdD+2HMubEHy2ifSwmn3oth/BnxCIPK9V8LVjMxujCaHAG4avCHuBpSUAcT9UBbQPYi6Q1ktGsVIKGr20QwYDNEaeWEmz1o2eDewX2CHkoGEM9DmfkZdV3MHlzpFMeklGl6WNnrR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iih7/qmb; arc=none smtp.client-ip=74.125.227.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iih7/qmb"
Received: by mail-pj2-f31.google.com with SMTP id d9443c01a7336-2dd53691be5so10145805ad.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 11:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789757030; x=1790361830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GGX7Fmo/mlUGinS0kwTdlAM262ILdns1fKb84eDFqtM=;
        b=iih7/qmb4irc4KgU4lN1Ir4a+NAAu4tAnwb21dOlNQJ+HFKXXcCVqJncS0ZO3IxtsE
         3FumU8i8UjKjlaDYtrsYrGTNcNX2q+E1vQ5EqyRYZowuPv0Wp8OFrjXqoODmeCPwbbSQ
         BskkxQEkDqFxDDFLpdfIDgI4mGl/TuaItHm4Xf1X9ll2FQ73u3mj4NeuxBvXHqZhAOsi
         XP4e2QSqWEICkKhivnHSGDuIVEUW1tqAm64EyDc8Lti1xZIZ56mfa62SuUjRG1qo5pFa
         2nSjW2yWPtZF6cWyHXYdOOCJkGtQj1bXOsv1woGoj3fvD4mQ13jekDgyy/3QZHW3B92o
         L4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789757030; x=1790361830;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GGX7Fmo/mlUGinS0kwTdlAM262ILdns1fKb84eDFqtM=;
        b=eJbwp0a4wGAmm3N3cl/IwJWBKua0QZznadaQEubNPCRNpKMMVtIoWA7htijDYH3/HL
         exoGJOHUp/vCPM6rWCOVua4sZQhdTiyyjzKMpJhZNVenOUaUiu8ZxAjsY2P1A1qHDnH3
         WU6UD9uQ2FhpJeQ5U7zCVGqQv2NZxImShdI2a8JuiCn/8z918JJLyfQP05O53RDSqZhe
         mvzComEngrJYxpjD9SH2+EdMKKmWwzMxvBkkAj1gECZ73IuqJWJE/q8qcPJG4HVVsA30
         vUu5BUw3Iwqeplzk+bxYc1KfUPt9KbK7+tRCy/+k4NPOCv1AxXPc8sediZzNlprcidkT
         eSYg==
X-Forwarded-Encrypted: i=1; AKwUvBxG3kXrqvTj8JtwRpkbadmvC2av0ptfnttInlTr7QJpo0rJF0ZJJ6a5h60A7g4Zfdx/L90=@vger.kernel.org
X-Gm-Message-State: AFuF++lwbk3KOiKZ+AWKgpwZ+mmyVqfpqcHEwg6j2hDje6DZJeUkTqtD
	Wtj0UtjQ3FzroyL+58W+ewNvCdkz3leTLKhCRvbQH5wAvUIpKp5RJWpyXkctJ0yi
X-Gm-Gg: AYBFou27Jz9//K7aDVfZi8qwT093yaJYC9QGE5GemBGMj6K7MdI8TJa7pRcZzfudBm6
	QI6hojE6aMdX5SZiOW0hg5dzITFQgUkooLCfeHe+bSuEiB8wZr2w9FXSUS35PD1CBFZlvJhr++Y
	kmszZHC3bLuw8hQAhYyLjRPOd+hiS6LFia4NGMYaO7rZgnJCH5xSvnJ+VbK+fbdDepmPzBnlhvX
	M4oep21WVNBPMyLudRg6GOM70Wf9UyYba7Kddu7A1pZKgacl0pRkhlQdMywm15n1QndFwm1O1Fp
	1GAHpLO4ZST9VqW3M3l/WTX46wAbc4R942F7+8lkY5DqiqNFeLD1T3G8psfn0TRQY9Dnrl7r3Ou
	/4N55Yu12R++U+8FZ0M1ek5L59XdzKs/A/DRb4xTa4G/qcNq2UId/Oak4LrnMwnBlye1bKEFyLV
	VwO/Td6oqjojuyv5JeaUU4seUqPDcTGRyhDbDTWCDn58U8zU4ntm8G5LmAPzE1EFci2zABScRM/
	pC/UUpLuuwboaFnB0mS18RePdOZ1OXlXw+bo4OWm+b8tG4sEVtFzhbWkA==
X-Received: by 2002:a17:903:1844:b0:2dd:c100:942f with SMTP id d9443c01a7336-2ddc1009bf7mr8811015ad.45.1789757029540;
        Fri, 18 Sep 2026 11:43:49 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:e136:8952:772a:93a4? ([2620:10d:c090:500::4:e681])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3314313esm508411eec.14.2026.09.18.11.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:43:49 -0700 (PDT)
Message-ID: <2945d5154fbae03190d3c9d2e67be3279042e1eb.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 04/11] selftests/bpf: Add LOC_PARAM,
 LOC_PROTO, LOCSEC to field iter tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 andrii@kernel.org, 	jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev, 
	song@kernel.org, qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
 puranjay@kernel.org, 	yatsenko@meta.com
Date: Fri, 18 Sep 2026 11:43:47 -0700
In-Reply-To: <20260916074118.1007116-5-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
	 <20260916074118.1007116-5-alan.maguire@oracle.com>
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
> BTF_KIND_LOC[_PARAM|_PROTO|SEC] need to work with field iteration, so
> extend the selftest to cover these and ensure iteration over all types
> and names succeeds.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
