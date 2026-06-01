Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79530F7FB
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340839; cv=none; b=II42OKISzfBjuWTPFJBpW9+8wlfSgB+mzHut0cRs8X56uUosJ4TEuf9sNbAoISzzw2PgbLMnsYk5yCHjbaN2R20BOMccZt868uGdoEogHpgyPmBRCt7RLAXfq7t2ZdyJwMfVO/K+Up0j8w+cGmNQkljEiLcC1dOmz7pWll5LWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340839; c=relaxed/simple;
	bh=wmTg+enkBTPgSHLCgPOTtrd58hy4/kxB8vzCwfgboeA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NcmcikoxqYCQZnjoFH47zcSFiFSsxWgjfIjIok0Grd/Cj4lzMlUzQb/fdeYUYBAe808txe/3SheXkifBcJFETl+VHm/nk2NmiX8IdoAN5CfvcIIXAlXneRdEOZOO5y3b6UNUYjEue0wAsb0GSsN4Djzt6AIf1p/YcSJMs5vL0j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzUZovDM; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzUZovDM"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304545f5206so14515213eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780340838; x=1780945638; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wmTg+enkBTPgSHLCgPOTtrd58hy4/kxB8vzCwfgboeA=;
        b=XzUZovDM7iKl5NRfKHH92Du+16e+g7riCbviyqjHXQsQtrdsR+EE81UB30PVWh8y6e
         OCZMNz+c0j7YChUmSg8gaToxNrAFV5CY6cRyR9j6/olrE1U4Wg5YfywMg1xNeaPsg/vq
         tF0aMAN58xb6NxZYu0tHgzDuoKy0FxxUBEhdH7H0G9xiWA/O3iPG5wxOK1wPTJyHViRe
         2T6O7/j7jDhW+Eo9FJEkoUJUvoziHl9vqp/uQU9X98hBUExW9eMD217ONdwxrwhYDNxz
         G8sdG+PXLghfgj4Xq1pdiv7Ppt8FXcU5FxsUhXBMO3rpKaLM+EBEdRqczQuRPrjlyLEn
         k+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340838; x=1780945638;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmTg+enkBTPgSHLCgPOTtrd58hy4/kxB8vzCwfgboeA=;
        b=kS9yL2Jixlvil7nA36slSE1rieANtrrRZsAV+dMaTzD0SiDXs7VVTo+JNT5lw0XZE0
         8BUF9fz0LHuboS0xbnVokt+An7W+hjjlz5nmrHbedWDGN8G0J+Je+KEQYfC7uXxfQnTi
         LQLpN5UMKaljcsecZNvhfK9TbMDaSyJnx/vaBRAy0h28XQy8XNNFb1RVRK1ZB42QxBs2
         HyZm2DxNXNoOUgoANJTUBQyveP7GY3uskDmiyv+QYEmQ3JsRpahQIpUAA+rUB4KquFkI
         R9SoLrmcsleg3sdeboNT/jTdftH9IJAN0y6Z0sktaD3Et53YbzVIiGvfeURE1ixFJTVq
         KU6w==
X-Forwarded-Encrypted: i=1; AFNElJ/FladrkjC/CY9kvSslPxXn6NbrQG1+tXBcbk97ISmSHGPEH3/f3nrNhvB71cbS+M8GbII=@vger.kernel.org
X-Gm-Message-State: AOJu0YypgO+dbpFt2kaB+STBnQH5Dp5v/RTm+TEgUj5vfNPg1KNsGwR5
	Z8IQUgeB7xWzgWYg2TvlMcGL7abv6nUjZhl1vz7wdrNnoiG8wyW37W4y
X-Gm-Gg: Acq92OG1oj9lkLMn2qU5ofmc91AAjfV/7jiOTci/OzY1MV5DJLfexNyzieNIAKwMGyJ
	WHw+cDIXSU6vAHcZRppTgxf22dULMO5tTEYneD2ML4DQxi5qdMAREa8hFeafBB6isLHDzVtZv5t
	nYRvl0ApcfyfguAe87nS2ESdQPQqlyfcG4SYLiWbFK7tQe1ijUtKd3b7XsdW7QRaYWiaPzSrMPO
	iuPKf8Nf6NLcS03UxJyTHjAL6y5OfowH4xKDamcC0vO2X7a205V0i0E00+Ak5wcnqVcmG4HNJJc
	m1SKTWlakLqIultfTdm+kQb6S20vx29Mr++1EDvSI7ZmBctr1cgd6pUJC/mpNxr96trbo2VymsU
	iObdkBde4V+r8UbHDQ4otz6pQvB19Rfkl6XleFVI1/hz8Lu+XbAjvv3qieNH8GlLNTbFBiDdIyz
	+JGPECTvebC5qKsYTtVxZda7Z74poj7ABHQKjysRw9ZwDGjIHvqHGMc3L2CbW3VE0bi4jVJN9yL
	qd7jebnMqX2ZQ==
X-Received: by 2002:a05:693c:2c0e:b0:2cb:4b8f:b2bd with SMTP id 5a478bee46e88-304fa49b11fmr5749499eec.6.1780340837556;
        Mon, 01 Jun 2026 12:07:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:af92:b4b2:3f30:fe90? ([2620:10d:c090:500::96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a9d27sm9445908eec.25.2026.06.01.12.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:07:17 -0700 (PDT)
Message-ID: <ae49d4963761b8c13ae1897b2d89ed72695cb55f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: libarena: Directly
 return arena pointers from functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, 	song@kernel.org, mattbobrowski@google.com
Date: Mon, 01 Jun 2026 12:07:15 -0700
In-Reply-To: <20260530002259.4505-6-emil@etsalapatis.com>
References: <20260530002259.4505-1-emil@etsalapatis.com>
	 <20260530002259.4505-6-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 20:22 -0400, Emil Tsalapatis wrote:
> Now that the __arena annotation includes a BTF type tag, and the
> verifier can identify arena pointers at BTF loading time, return
> arena pointers as their true type instead of casting to u64. Remove the
> preprocessor typecast wrappers used to hide this from the caller.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
