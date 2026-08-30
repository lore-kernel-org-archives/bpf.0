Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBAC8635D
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 01:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788054411; cv=none; b=E9jGTzEU+IOHXyiRW/ozVRzCtxTgaF03Ux99Pk2HqJv/U9r73Rq8rKIhYj+Iu/lgZpXyR25v7o5iCfVrsWRQTI56tDAvHlidQbISRTP6iud8GTrXGk0Pggfo7clU13+GgyBKDgdW8rNJAGSVMpguSiRXS+cxJr6JW257NKF0NuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788054411; c=relaxed/simple;
	bh=QM2jxYJvxilDMTefmjax2O9VyCgr0nOIsZolvMYW2C0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=imGYU6F1+qjGJTYe0LCqi7pkJrIY01xuu94BdktvjkDEC3WoKRvE27SicNJ9cEtjNL2zk//EhY1Kx62V9jd6jiDKHGx4J51jyROMJ78apeSboJq3mKxutpcLLmdxTde0wwDP1fkITic/kP5N+Ult3y8rbCl/EFpkdnJ1wP3YBq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leVRcA5J; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leVRcA5J"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484372811e5so35616f8f.0
        for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 18:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788054408; x=1788659208; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CtUZUG5479myEUIwKmrKmHPQvtvtyLa9hp4A2ascPYs=;
        b=leVRcA5J0it3SRC0hOSQdDYWC69ln6sDQHj+JooKQBrbhRNuFiX/a0pDNmQ4yA0ORe
         9I68bufR76Q19zNds1lyUCaSL7PQHODGiZADwrJdlK9tQYRyWywSYPO7zUBw5laDjObN
         E21GdrDOe9zIbt49tUYHUcs86BLujQEytXm6PZP42skURGoSPi+OQ8HmpBVGwZOoLMbF
         PYEzXe1sBNd7dMoBq1MLRQ/0Qyy74IdPfxn/rTGzBt306ja+BNu3vVhA3zbe+AiCsmxd
         NXFLXxGeEronnS8yj+jJH820J/lH55zcdypOKvZUyCRmV1PM2i7vZ05dNaXqNbYvk5b9
         /j+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788054408; x=1788659208;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CtUZUG5479myEUIwKmrKmHPQvtvtyLa9hp4A2ascPYs=;
        b=LZFch16sQZGOru1muFw6zLmqWKP0XG4TiLxiqlNbZDzuWgmr/5l55OEoKov1us0l+1
         0L6PvIAFoEqxiC+ivaFyNhPNvwclDEUPLidbNBYF4pDOAlhKD3gdxyOPFqSgD8PRLZX3
         RYQyNX8Mt+iHtOpmhGBVNhDs4laD6xKUWzNO4mg1MMWg6dq2SDH9I0/a6zVR2qudwqn6
         73iKnkXXaZ8oC2dNC/kavCfVWa6sJB3C7BNMne3v3KujAtMoVTbmEee6z7FLOV9iVcrw
         CpQ4bW0WTl7jT5a5tYZdAffsk1aE6HmgClinA6S9xTEfGn+PQsLVPGilguHhomcsT/5O
         dZ3Q==
X-Forwarded-Encrypted: i=1; AKwUvBycRuXsG0CaxO1BHWpMUyly7LuU3m4nKB/rUegh7rKh1kphoLOOQBDgj1eltS40bOO5jpE=@vger.kernel.org
X-Gm-Message-State: AFuF++mU1CIhYmBn6jvBNHS+UnWGC98Z0AqmfL3Rnj9SELNW0sLI7v1h
	QGCgxnH1kpSrNlddqaaKsW875eN+Vp9KDnyqf3lJq9n0gh80NYz3OAiS
X-Gm-Gg: AYBFou0vtZP9vcnrPHzHXJr/c4p9xehaBtMIIyE52TD9QpzEUar2iHbCLBjaYiaIOur
	v12J2h0wlc9FVsHmwgTL0g4j5UdKDJlHgh3Yz/6gOuOiNnA8sMURX2szJjV7h1SrWZTYVmk6/Uf
	HzPtQjkDi2f3fOMSFNcwBIB5dXQ/T3nNs2UHDoA6dcA0xu+ZqXV5s/OdqIVTyoo0K1wAAoBxze0
	OyzGKC66h9sBxG2WFwgzhOjAR9hmXm3dDkMwSC5RGl9GBpf2wl5Fd/ual5TPZNsfPFul9Lg/FiX
	tu0z8dk8fyvmeZFVD3Jl7GW5U4cTYaBNRRzp4Wh0bA+RcErt6rdx5FsVekiRmxttSI1FnaI0M9S
	UiI2/akFHg+jSXUK5iH6wSPEpKJCiBFIWFFpAw5eo9d4Bj1NLsTtMMvDa3TLcIG3mxpvULAdI3F
	+jYTuBqAmwA9dHH8LqGepfxnn8oX5uQJfuejHcfS+wjurYPk5tYMggoGkiJ/FTE4CZmiFzMuPPx
	WJNpIOUjoAwqDa/GXv1b9loQddSUVeBHCvyGUAPWQWdahU4JlndxPwQLfWQvXNexefcr4iOwwRG
	1BszEpZTpppwctC+dqRxcgX3Z/lIK7yYlQDWLw==
X-Received: by 2002:a05:6000:2287:b0:484:3310:f399 with SMTP id ffacd0b85a97d-4843310f41cmr6549348f8f.26.1788054407564;
        Sat, 29 Aug 2026 18:46:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb2794dsm13697009f8f.25.2026.08.29.18.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2026 18:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 30 Aug 2026 03:46:46 +0200
Message-Id: <DL1WDYI57AAF.Q8T6RDYE04J2@gmail.com>
Cc: "Huacai Chen" <chenhuacai@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <kkd@meta.com>, <kernel-team@meta.com>,
 <loongarch@lists.linux.dev>, "Hengqi Chen" <hengqi.chen@gmail.com>
Subject: Re: [PATCH bpf-next v1 07/14] bpf, loongarch: Fix stack arguments
 for indirect trampolines
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-8-memxor@gmail.com>
 <a5d4c26c-6735-8af1-1d3f-fe7f1898b285@loongson.cn>
 <DL0B54EEQXAL.FL6Z0UXMR3SX@gmail.com>
 <2bc45d20-d08f-e5c1-9da3-699d22959f98@loongson.cn>
In-Reply-To: <2bc45d20-d08f-e5c1-9da3-699d22959f98@loongson.cn>

On Fri Aug 28, 2026 at 10:19 AM CEST, Tiezhu Yang wrote:
> On 2026/8/28 =E4=B8=8B=E5=8D=8812:55, Kumar Kartikeya Dwivedi wrote:
>> On Fri Aug 28, 2026 at 6:33 AM CEST, Tiezhu Yang wrote:
>
> ...
>
>>> With this patch:
>>>
>>>     $ sudo ./test_progs -t struct_ops_trampoline
>>>     #471     struct_ops_trampoline:OK
>>>     Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>>
>>> Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>
>> Thanks a lot for the test. Please also take a look at the argument rebas=
e
>> patches once you folks have more cycles. Will definitely need your help =
and
>> reviews since they are mostly vibe coded.
>
> Hi Kumar,
>
> I have sent a standalone prerequisite fix for the pre-existing
> issue:
>
> LoongArch: BPF: Fix off-by-one error for insn_is_cast_user
> https://lore.kernel.org/loongarch/20260828075100.24776-1-yangtiezhu@loong=
son.cn/
>
> IMO, when you respin, please rebase your patches 07, 08, and 09
> on top of this fix for your v2 series.
>
> Additionally, please send the v2 as a standalone series to the
> loongarch mailing list loongarch@lists.linux.dev and the reviewer
> Hengqi Chen <hengqi.chen@gmail.com> too, as the LoongArch BPF JIT
> patches are typically routed through the loongarch-next tree.
>
> https://lore.kernel.org/loongarch/CAAhV-H55YcyXRewC+0YzTHXb1jab0GkAV13EF9=
nFbTx=3DUkX4ww@mail.gmail.com/
>

Ok, I will send v2 without loongarch changes and then split out and send th=
em
separately later on (or let me know if you'd like to commandeer them, I'm h=
appy
to do it either way).

Thanks
