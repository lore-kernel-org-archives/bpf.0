Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DE13128D4
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192640; cv=none; b=s4x0L8ndBb74plMIZE4o8iJ9XFxcpxjQF7y8qMTthZO9WMKDBfppxaPsFgmu227/fUDUOr8NsMlKvqR3oqsRahdr+EVNYdUfPb7sHzFMzxmIYfhhJldr9VuoR9bBPGL1vqmSlzIiol9eOlV+U9qh73kHJMYMV456lBPBMZlEFyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192640; c=relaxed/simple;
	bh=OPiTBdF4yWHdgQdfXGPoMqJ7KLb7hYW28MiiJEj/g4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=am7Vv7+4NavMeAUGcYTo3RYR+pbS9BK5rf/vqn8BjjbOx59TB6bPetb9CIOCfKwUJk+/bo3wtRjO/PquMRrrOFKo9AggLOa/usW2Sn4j2qCpBucVGAwYUUNRpq+/03qoUiM4WaVQQ1TrpXELRfDRaB4YnOMCWiI3zpVfJMEaW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jagPufGH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jagPufGH"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-848643382fcso3193902b3a.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 15:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785192639; x=1785797439; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OPiTBdF4yWHdgQdfXGPoMqJ7KLb7hYW28MiiJEj/g4w=;
        b=jagPufGHOMEUP0Uzl2NL7WZYyWOpGSd1FlwqE9SGW0JbdaPTg8UiGB9flPihwNPXzC
         1YWeIkMDP6T+XBEUIEldNxAcYcRW+XqC/KPfA4adBhTdHJNpyGkX2LMQuto8n3UG7ZqZ
         IN1TCdCaBiqtUctCpN8EN2AyQ4j2wlGO2Jpzn4q22RRceWCXKwgXSe64daYz610zrUrB
         1qyjlFxH/vYekdYBAtw3DOukfr4KHcrjXlb+CYGagHtrr+JahLfc6MCqcZ1MQs8q0Tvn
         XVjlTXlwF9dtyVCCXQcA5W+S/8MA+J/vca1716r6r+CGm8LL/svy30Gmw2sWeU8shycq
         Pu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785192639; x=1785797439;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OPiTBdF4yWHdgQdfXGPoMqJ7KLb7hYW28MiiJEj/g4w=;
        b=H2UIMHsZarpMgF6Btp2r/sLXxGEWWiCQWiYdlYCsYC9iJ9UKV1GfqvhOQ4ScYgL9yl
         zkq65GIPM6udJG3sa41ojECz3T7Z4wkg5tvvxlnCVwzZPuc7n5cm7DMOI0xcLV7Tsh0n
         rxlaPgaHkJ5YyXL/TN14CR5IZwa4rt5DO/pe1SmQNIH5joA4E7zMp2v0fRbQTi01YoiO
         cMlUgHgR4+lDTIznFyOrq+Z0VQAq5M34G+R3YrTddrT25dZ/CH19VxouWlYRvtlHxnwC
         Mq9KJikTyzVLXvqyq+Nm9z09mAOpo21EiU7UAPi0hl+ebiqKegho9yG+DXD05rbmyVH7
         s9+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpRDTeuFC6tynYX1fLrsxTCa9Sl/Ue4AO4aZhk6pIRKNnRL8HU3YyCbNItfPG6Z0j8oj/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNbZu0d6zCwpqS8LOwUKee3HF5wsOGKXfEt1RhTV2bwsbndxG+
	5miOmhHMVHaQ/eWOLWliXOZ3iHiPysUYegxK5UAVTC9YgvudELFDJsRH
X-Gm-Gg: AR+sD12Eo4bmz7LdH+Rt0kFK0Tmnoy9YVPlsOqnwu6CeBCoahu7YtoOsjBQ6X1RQPJg
	N7qtyUtlJkZlIB1J7ZkKL9RjP0gjWLF7HP2yyWFiiZTZ4a+o6APT+96OjS8k7EOMDHD0zEJD80z
	DmHUoHhRkNogf/9RVH2OnHFT50MUfi3WhtwYVa80RfOi/EkqyqDm2H6dITn/D+5lDdS8eYT9zOy
	golkinThD3RMOVEhGS7DsQVKhr9LGL00FfZFMxV+ADLsajIlNTFHPM4kXMwg4TYkKHD/v25eT3I
	wDf56t8buvb14taLDvHHCXJy2+pYEvVuXnw3iPPziOBvdpPwJQFYpQUojOPxc7wE+gkI2A2CafQ
	8eFdMtNirZm95Cw1/ruFLB2n8uGIOooP+dJcBy8hBaPxEcC6PZwcvUh3NTFjK39xtkvBIc9q5gN
	D0VKailYu/5YF9c3HX8/p0PfZ6G0fyLg==
X-Received: by 2002:a05:6a00:438e:b0:848:3f91:da82 with SMTP id d2e1a72fcca58-84e8d1233a1mr1107816b3a.32.1785192638898;
        Mon, 27 Jul 2026 15:50:38 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66dc15asm3707653a12.30.2026.07.27.15.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 15:50:38 -0700 (PDT)
Message-ID: <4f1acebe808aa2e12dc949fb8e2910a5f60b95ba.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 11/18] bpf: Classify kfunc mem_size args
 from BTF without register state
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 27 Jul 2026 15:50:35 -0700
In-Reply-To: <20260724190813.1458271-12-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-12-ameryhung@gmail.com>
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
> check_kfunc_args() already makes sure a scalar value is passed to a
> scalar kfunc argument. Drop the check in is_kfunc_arg_mem_size() and
> is_kfunc_arg_const_mem_size() to further decouple
> get_kfunc_ptr_arg_type() from register state (a prerequisite for
> generating a helper-like prototype from kfunc's BTF).
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
