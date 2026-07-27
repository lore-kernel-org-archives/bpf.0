Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468543128D4
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192512; cv=none; b=nEjHATIndpum54rKqZ1reIIoOaK+rGyH64y3xgaeQ0n5LRPAuNCucjpoLOHVKrDSqIDmwT03rtQuvHTWY4YnWqiUxaN7Wffee4zXLGG3Ozf0ybkzCuyqocBO/LqfPf5O+mgv642qmISvjHdIhjqQVMs8uX50k0kpLgg2VN7Ckiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192512; c=relaxed/simple;
	bh=gGp2aALlpHxoNCT3kEk+WEHESPpuM1sXBBq6yZC7vFU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mrVhJ0im19PzzSGIqT6PChCsvSk4pZpzOqa2Otg7tVpwYu8/btKOuRtpbwbE/3nSLuOZkz4FMM0eeSb+/L0ecUbDP9y6iIztUEWKPKpaBeBKcI0YwI21I3LxeBG2tv1jewjnp8/xYxndgMHjJhhISkWRvpq0z9r/YZAieCzdq/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCnGuWiQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCnGuWiQ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so2799934a91.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785192510; x=1785797310; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gGp2aALlpHxoNCT3kEk+WEHESPpuM1sXBBq6yZC7vFU=;
        b=VCnGuWiQCRt5fqiniyvPz3bkLmb40zITCRmE/wiZotU8FRzPbHfb6cKE6SbyIw4L22
         zgVHqaZhfGXmXQGLP45ARTMZm2U0EbbsrTAme4WXpKkstHVskGo1LtsqYJcHjeS+aWyJ
         Zcxo5urzpbrBJscNl0vQhIDyaepTIdTW0FBhT+1VIpFcK8QPq7WH8c5gSoRawtUtt+ED
         aWAHiMG4XI/qdFUvzE33KP3y3/dBSmPskP3mRORt42mqthZ7+kIYWYd+UHV699dQfi6E
         bN+k0YbmFJZET/3PgULdXJQy+bHuqMZ09BCoNx8Hq+LAs1r8daOs3KPwtIXBrRxa1bno
         HkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785192510; x=1785797310;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGp2aALlpHxoNCT3kEk+WEHESPpuM1sXBBq6yZC7vFU=;
        b=exVp3lQPzXtdfDDLkmDnk5MpQWy1HJbbb9QZSLrzD4rZPJoFp4RGTah0RWI4M/iN7v
         Aui+tvWpeiaeLpA8qiyQZGbM6zRmQVcSrQt9Gtpx2Zi/xl4SswGqd5GDdZXEbvGADj05
         wTjJ9N0PERZId1uEg/SPTTu+6FuGTdSkoL4ek5C+rBOT0sLUm0YS2wLVWlyLqNoYk8AA
         cJviVct0XuuStbwz7+g322r4iuE23WVlvNAn4/un5Ac60Zv0s+VD9Vh3a+NQbkaBkgTD
         3z4TujksI8Yduzc/sVjz0Raoh5M12RCPyp0FCZuXIZ+ByBhXvdNcEua2yipePjyU6V/5
         mrRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrbigYUp7H3doy9TAPmRimfgIrapg1YnHUDR70wpYCamRNZUjFUPLN1UXyOuOOWzGtLD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLL0Wm/4ViW9Zxe35egFzMQNimktNWqtMSsaX2zFPVPTnJrHGx
	ZpJ3xMmOJrfO3QKutcaaZ4Dc3VBhivb0zweUgTqHom9vht4yMVuFbFFc
X-Gm-Gg: AR+sD10ypTigvtofcGv5r9MQN03ihbQRwPEtlSpAcJqsrK6+eD0AqWzKV9PKZNdT2pn
	7bCE/EraZaXo5nsda3GlXPRIWMBo6g5hk45bvYAz6q2NFOVrT3iihY+vuJjN2mG/K/3jFi/B/bA
	XLkvgVw6OWy6x96n4x1zf2kpjZbW24GaLdUT6Q415JWtIx01iJafUSbbr/s8C3dFRo0tMcx/8jh
	W0yF9ks0IPl05HeTgOvaLyRM9akHXrnxso2hAo9HW1QMEp+V129ffIwCe1V3CM+xKmFKHbXGJdc
	bEuYiS1omwmtzT+i+UnniD08Zu+KbiAZOBAZgQa5XZMrqgEVkOW7VuLuY+Cm98IOBlEsjXU+hhu
	8SfWtoh2d/7GRI9PorcWMCa5Jb6V1tZdXPMuZ8wTXKVogYcLywqbTShZXJg6omq7IxBaN+nrvWI
	RxitDbAhAxx6NCpZcJt7Jtotnl6Y5ymBt94tDdKzHwYSozq/kxSbz+KregAwskQ09WMutvy4QIb
	oKQbe/ut4mLC6zh
X-Received: by 2002:a17:90b:270c:b0:37c:607b:2cd9 with SMTP id 98e67ed59e1d1-38f646e7d62mr1160061a91.0.1785192510595;
        Mon, 27 Jul 2026 15:48:30 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6410519fsm405244a91.2.2026.07.27.15.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 15:48:30 -0700 (PDT)
Message-ID: <efa06273caf10efacb096984b60a1d53c8eeb03b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 10/18] bpf: Fold __szk const size handling
 into the scalar arg path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 27 Jul 2026 15:48:27 -0700
In-Reply-To: <20260724190813.1458271-11-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-11-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:
> To align helper and kfunc pointer to memory argument handling, move
> kfunc constant memorry size argument handling to the kfunc scalar
> section. In addition, factor out constant scalar argument handling.
>=20
> The constant size argument (__szk) of a kfunc memory/size pair was
> recorded into meta->arg_constant by a dedicated block in the
> KF_ARG_PTR_TO_MEM_SIZE case, duplicating the "only one constant
> argument" and "must be a known constant" checks already in the generic
> scalar argument handling. That block also did an explicit i++ to skip
> the size argument.
>=20
> This also fixes a precision gap: the old dedicated block did not mark
> the size register precise, relying on check_mem_size_reg() for that. But
> check_mem_size_reg() is skipped when the buffer is a nullable arg passed
> as NULL (e.g. bpf_dynptr_slice(_rdwr) with a NULL buffer), so in that
> case the __szk value was recorded and used for regs[R0].mem_size without
> marking it precise. Routing the size through the scalar path marks it
> precise in all cases.

Could you please add a test case for this?

>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
