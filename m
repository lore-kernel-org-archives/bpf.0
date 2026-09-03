Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37C3D171B
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472841; cv=none; b=ZesiCzUC0UJykKKUqV2+dmEIijGiy6HaLTA7vSkEgOZAG8/kpnPKspemFYxHuWAMDNN6/J3x222WHE327Mf5JZ8qdcWqBBSnQplvo6hoid8zBAVLwGre3+s+gik7jbWpyVC9QOm5VLcIzDm2fyHBujnjP6A5CDmaiVto1NIf99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472841; c=relaxed/simple;
	bh=0jt3+UfKEDnI2NW1dYnMBc/cRVjuFmgIqeS4gimSB0E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qdU6aSJblcjpMBLBSoU8zpIWe23Oz9ZKFeTrF1dEf+1egpXSaEQDpSjVJidzmHRkdf97DqUZ/uOxUQflT0uxrgGsZzK41+Br59+w0gcRQgTYpEaK1oX+IF/TUX1vgJvHPuw4UglClx5lXpA1Zs1d+SCU75jxjpb/A0b0DrrXzBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsPwuVMU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsPwuVMU"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c96c92c0980so289440a12.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788472839; x=1789077639; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0jt3+UfKEDnI2NW1dYnMBc/cRVjuFmgIqeS4gimSB0E=;
        b=SsPwuVMU5w1f9dEzidWFy5m31HDAwe+s69C9IluOSauiU9d5H5VIWKepl1l2Aa+VAE
         X7xWEMzNCgO5bKyQ3XtvR+NyRvrKUF9vHC8gpUxzY3umQ+irXwrCT3YisVGuG3RSYzy6
         gY+Qkxhne3CL57H5LOO7nrFZ/ymqyosuOJmuzOhaujk8AhsMj9JU6LD+VszUKjF0O/UF
         beOBdmiom0UAHtzPrmF2mIGZP8GdPoZD14EFk3J2fEJxeAfnluNs3vtv/94tM5EFrhjk
         9F00RnGtP0GFXsq9pxpI7bI8HNfTphLg8HXPF4EyPe+ZZHytYhIeIxqb1xEI5KzwJmue
         V8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472839; x=1789077639;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0jt3+UfKEDnI2NW1dYnMBc/cRVjuFmgIqeS4gimSB0E=;
        b=PEjgxrJl+nTqvRq0g2KBQDOqNfYu4uXwoiFfeLLUtXToLNTuN9NR3xZYmgwa91kU1w
         Oig45yndGCi2XjCIzdiwkGz45PlMXY+yV8OCkbve04EfOFKbUMzO1y87I6ispYj3VJdM
         ocf1zE+Xs/MjKvWmKFCD4wMCGZFQwTdB74LM8Poi1um2IDtntzcVhvK+jpaFj1qUKduz
         RpzH675/b0UkZ99paqhEspNTjbXUHrdaIzE4aAQnpTWZk28kAOw2CFzkFUr0t4y00Sv5
         Sv1/ImjHC7qvoLev2loSz+13U35oTCIdGe+8P1lcTx5xc0O8OELd8lUVzJcKVWHWcPh8
         G0hw==
X-Forwarded-Encrypted: i=1; AKwUvBzym2SoAmn4Rx8IwdO4+x6cDgh+6tYehg5wG8POCWc6eY64KQmoWDO4/UnQJJjsBf1BIYA=@vger.kernel.org
X-Gm-Message-State: AFuF++nZdyF/gmT2KLDgeKbnp4vehIvSL5696p8cDH+CIzNxQArmNS7i
	kJ6yZNaHheXHz8apj13jyKJY5l+y6VDp7o41YNbAPhX6+dP+RC9VQF36r7gP57Mypj8=
X-Gm-Gg: AYBFou0EiFe2uVas3CdZtm+f3pbc+JMKOuisJQOjDgRc/bw9sPlxgbaAtqW6/DSVS3J
	dIwUexLdNGxsOIw8l7nM905wL9IF1t/iLSJdc2tpSh2BtTpPMJjbUkixsMlcwWTrHeEVLe1Ct1q
	0ENsKVkwXfsHo5DorOBvdC6cC2MGszOyDU69dnzGpTpjIeuJbNE030x0a1AKWnli6jzxnElNYEF
	mZkqJExww+aCToAUwxGwSxY6oUWypkgOCywsxtmh5Bjqb2ZFF5oUsXEU6dIRXUvw+ogJd+wtr8a
	sOyWM1SBeqvXIb3MvNwtSVkmp7TUUoTpBvDItC8hVc2VxF9KI1UFGjXCbPbNKfAV1qraboz1OaI
	ZHd1v4s5Pj3rGSNLLW58xFmKWIxrZ+/EkexG3fbCK4ChnrG+e2CukfEiE4AVW6Yw17es+9bkkdf
	ItS07lVyh/Q0ArEu8EgnZ7sqoHJwmrcwj4R8z+hlUoJbOv6/iGVtSj5BIzsGkmrx4p6ZSKbudo2
	o9o4HQe21cIpLXZ12JWEo1o1uZdmUwdUCQaDYDhpgogig==
X-Received: by 2002:a17:90b:1b06:b0:398:9be9:ab8e with SMTP id 98e67ed59e1d1-39b2622ba26mr1584639a91.19.1788472839187;
        Thu, 03 Sep 2026 15:00:39 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fe3c:fb36:dc7c:5b5? ([2620:10d:c090:500::6:dba3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243a9388sm1933852c88.10.2026.09.03.15.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 15:00:38 -0700 (PDT)
Message-ID: <0315aef6b1dcd90696787b4e8859a6a65bfd3085.camel@gmail.com>
Subject: Re: [PATCH bpf v1 5/8] bpf: Mark faultable stack helpers as
 sleepable
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Thu, 03 Sep 2026 15:00:37 -0700
In-Reply-To: <20260903214758.2727663-6-memxor@gmail.com>
References: <20260903214758.2727663-1-memxor@gmail.com>
	 <20260903214758.2727663-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-03 at 23:47 +0200, Kumar Kartikeya Dwivedi wrote:
> The faultable variants of bpf_get_stack() and bpf_get_task_stack() pass
> may_fault=3Dtrue into the common stack collection code. Resolving user-sp=
ace
> build IDs may then call build_id_parse_file() and block on filesystem
> reads.

It's kinda in the helpers name.

> Neither helper prototype sets might_sleep. Since prototype selection uses
> the sleepability of the whole program, the verifier can still allow these
> helpers from a non-sleepable region within that program, such as an
> explicit RCU or preemption-disabled region. The task-stack helper can als=
o
> be called from a non-sleepable timer callback of a sleepable program.
>=20
> Mark both faultable prototypes as sleepable. The existing helper context
> check then rejects these calls while continuing to allow them in genuinel=
y
> sleepable contexts.
>=20
> Fixes: d4dd9775ec24 ("bpf: wire up sleepable bpf_get_stack() and bpf_get_=
task_stack() helpers")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
