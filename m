Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195944B666
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519872; cv=none; b=BQv0DwSc2Kd9Kjc3xkofds6L9pBw6btPEphSwm5fiyWkqJBRQVNwbviFfj9i0fZr8TQIICi3213y63mC6y/8syVmLTkDtlSvZ08gJku3f4jGNSJ+RxdPBq3gwCxujJPu/TKS+LvOqQvIFJv9vuBq7tNKdIHqhFP5g5ULiqwFdh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519872; c=relaxed/simple;
	bh=hFY7DZz2dPp8r+14dtw6/8VgSlUQgJuN+xeWAm4e7PI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RImbMwgsNkZirZ4zaLJhiw2Przu7gD3lkVFtO5z3kahZZOoVrsXQS7eHT+riCdD0xsRY0/T/Iq5KRCL7dB/nugzE++hVRyDPKv4UofbRE/28dwyLtTnKHG+zGDcMwxpOg7/ugVGnCztLUGf5P8sRSjLNepcIE7PvaIGfyQto8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8vvJHix; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8vvJHix"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-365cae89bf5so1961552a91.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519869; x=1779124669; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gPhuaAbxwetzboeNCx+LRxGrGydKpCVrVHpu2bOzJRk=;
        b=V8vvJHixYDaozBdFHVRbRexy5+YgceZn4o39xMH8WDAG3sASFiRz51Ic3CtQBIBohq
         jTp5/zb2onT4c5lpQY3jug0Kst33llla9yznQFMnC3ZrcA5R69S7asZ6q+FOxXWrTtNQ
         uScHNmZ13JZpQ95dmLmxHJM5bmgHOOHaFFL/ZGf68Nvtz7LUKFpEOhNEFIs4OrrKJWDt
         sPm723Y88tVyc9l0+6TtteTaSS497ZOuPUG3r4qrFZWoawMEgGR3xRNyCVjDAj57IfgL
         6QbQYLwElsLws3IwkaEEzmhmAqfu/tHG5nguh00ew2Z6AIsUXwrVNroidxy0T/JIWZ8Y
         lUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519869; x=1779124669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPhuaAbxwetzboeNCx+LRxGrGydKpCVrVHpu2bOzJRk=;
        b=IMHdOIkaY8a47vKmRPRgZ/kFPIJL6t+5UvsvdtpdfNJifa4+mBcj4MH+2bG/UKX/sc
         eEQx4ELy1vZbqU4HeEzilrMnDc9CoZoq+Wj/1hdcaQu6x04sZCEdeAzuPI6DUcV/Xn9d
         1XnTe3rwjOIURzVdAPYtYUruwHCyV0v1VAsId3GuGQmQQQFjNePLkdjI+UpAEWd38LPG
         3+lcVgZ0fonFvSlbABCPG6RRy1gy4Fft6DiY61i0zwCjg9ABqaL1qrCt048lELeP0j9h
         bylXue/pJlLaaKcCQDHpLW0PG5/W6n6Ut1PLUom0L+ATGo2xRWf3W6PbUV/Aojw9jL5v
         IzkA==
X-Forwarded-Encrypted: i=1; AFNElJ+hMLrK5tKMJba3YfxxpNtdUQ0icj125ERIOtug/19lIIEXAXZOu97C4FNUn9a7OfBVMHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwdOIAZaTW85YC2ixiKbtUjZBxIkNiwP3gHknHwLUM1uf5/d7P
	zSS0iHoOr+8gnKgOHvycvZG2mSuJQkwz0A2srA0KyLCsCndhs5SO2x54
X-Gm-Gg: Acq92OG2HapC4cp8pFHm9VFSADozjf6OVB3GfNqjI8KH0zYO5Lxrpfjru1ByRO7RPBV
	VYa+/y3uoEKXLBcQzXuFDyrIQLLlt88x7iJv4khzrxm0WBGbHcrCU09weRMy0PIO1Asdv15lENn
	79nbSe4IunYmoQQUUyMu6o0RSzYgEjZGqBuyZmgOzLLMYj9beQkGkaHRlp2Sep9Nyxuis2LtC9S
	8a+k5QYh5BbM4upiMbSpwjat5dO4shf79A6tow45HumTVh6Y1krF/LOJKT/5aOmxsR+RF0Db2Az
	u+gPEa029s3lJ5Lrk/0heOf7pQLb/ZzBvWtyOvrNJjsI4SQ1Uc3CCIqXsn8+zcb27WYC/a0Hzlm
	hu5kTRMjxhWT7QUsQVz/Mdry7jCmj+V5/JrZxys1k4SidrS/8rn0ZeW6EaXyeYOVDmTmwoCmjeG
	rh9y7zJNegQlHMBo5u6fkc5ILcYKpdq6UnVP9rNgsRt3L447REAZtt
X-Received: by 2002:a17:90b:1850:b0:368:6ff3:6678 with SMTP id 98e67ed59e1d1-3686ff36d15mr3942399a91.20.1778519869103;
        Mon, 11 May 2026 10:17:49 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d65ed459sm10983837a91.14.2026.05.11.10.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:17:48 -0700 (PDT)
Message-ID: <7f0d8cf18e3e0d60751b2453815a1f0ea62ca928.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 01/12] bpf: Simplify
 mark_stack_slot_obj_read() and callers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Mon, 11 May 2026 10:17:15 -0700
In-Reply-To: <20260506142709.2298255-2-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-06 at 07:26 -0700, Amery Hung wrote:
> Directly call mark_stack_slot_obj_read() from function processing
> iter, dynptr and irq_flag. To prepare for unifying dynptr handling,
> dynptr_get_spi() will be moved out of mark_dynptr_read(),
> As mark_dynptr_read() would join mark_iter_read() as a thin wrapper of
> mark_stack_slot_obj_read(), just open code the helpers.
>=20
> In addition, since 6762e3a0bce5 ("bpf: simplify liveness to use
> (callsite, depth) keyed func_instances") has made
> mark_stack_slot_obj_read() always succeed. Return void and drop the now
> unused bpf_reg_state argument.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +static void mark_stack_slot_obj_read(struct bpf_verifier_env *env,
> +				     int spi, int nr_slots)

Nit: this is probably a leftover from the stack liveness commit,
     but I think that a better name for this function would now be
     mark_stack_slots_scratched.

[...]
