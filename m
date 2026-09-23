Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9B377A8F
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207464; cv=none; b=uv7yoEy3kzHiWc/jYbE0T+C/oxR3fJBWgOdQpYmblH/FkY7ld0LzOR5ojaefpAnpSqRad893gRlEJOXl8b99YKBI2MxuM2bERk68iX7DvPa5XABAUIi7vPqU7V0FkGywsFDnpVAfTSGbFxTZqnUSXoiwKmEXXZ1kYWD+MCmy75Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207464; c=relaxed/simple;
	bh=9kWmw2Jz24CY1KjuaIfjyjnRrVPY1ToFoiCAUGrxLvA=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=peynF+J2jvX3k5scS3JF5nsAIzjLmkZsVK1Mi48ZcQ/tjAx5tq1cjlh2HdS2LmQD7xe+siEZSXcertvU/frNWPwPEE/GfUrzNbxr327eRgCRPgyZXAsZs5kcSUt/I3V09bpl5oWxor7PfexMClITix2mnsVxyYVZt8iP16oN/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TinyKxBW; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TinyKxBW"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc745abb731so794357a12.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790207462; x=1790812262; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLyGQ/8NxP2mhwlSL5m8xZMVDJxC439BRzxLjIP57zI=;
        b=TinyKxBW3L33X9zPPd6D6724XMeuXPgnFfTzyj1dTQOBVJp0Kke/Xx3YlAc8B6ZnWv
         DLYrIXjTh0fKop78JPc/9dyBIusK9yZXtD1iqrzXo2kyok4G5S+P1nlVYsrBrjWT2U4W
         +vI3lD4c+NY4EotubNdctbBueD1DcdqJZF+xfBdFn6VpFnT5kErfCwTl4CxGXkMVavLM
         A548qtvl3ZfZ76Xn9XXtMXvDgyzFVfHOXuSceR+MXOaRZ7Kds8X3B4MmXnJ2ig0bkKLy
         FqY3nYfyimxyFkq77XqRXIQmPsq6eoLX5eOeGAbMd5zo0Ly/m6NlpN7/G/t/od8a1SOD
         Ri+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790207462; x=1790812262;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zLyGQ/8NxP2mhwlSL5m8xZMVDJxC439BRzxLjIP57zI=;
        b=yzYk2kFS6+jMVRTbGT0Td1a+uYmn3LjU+9A2cnaP+2pLQYzxpmXI1OgxcEWeO/vTlf
         f6DNZFkUspimXmgUtzeUyWLvwhspfXkCgdPetNYxM+wa7q9VFAgB9z9T2M/D6WYDtLwc
         CQNpSAQVGaVPDzeEST0si8Vxcs+j9xJjt70qaBCUlaUb3dSlkc0CIbvEtXBpSybaoXur
         4G8mWOcZbFHn8o0TsBQIfLFwFizXxoyKiZF91/yNa4NVeeo8UANN2EjkZ/irtn14Miug
         zPfELH5eJ5/kD21Nehwi6CJG0NoSvdTUwsYlWTGfd+H/qSrldBFUEb64amGItOtH6Y9N
         x5Og==
X-Forwarded-Encrypted: i=1; AKwUvBz8RADne2cnndgCpwSz1whXKTHfXyI0mqQBhjfEz8FLKiwRNomNe2pQ9lscbbLdGvjIn/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lkPBF3MNsWoH6ax1eIvSXCHKH8UMPs4pOdeLOWlwJ1yeiac9m7
	sU1fBpLSnofJapVPEcx/Pwjry8rrlNj7PAGLAkv1PCIxW3ulpm23wR+aE1ULEw==
X-Gm-Gg: AYBFou1o4MnaZcjqrBjs4cbNCLWReLc1uPz4l/KiHPF97P1vU1zLh7lvPF6KpL1t5uT
	DsT7t/KI1hD8Dba66J9h1brGjP4rXTPAGfWgtZ0BvWrijnmOY1wqSzk8AigkYGxnwO3BpKIFpIf
	AmuWE2+sPbpXo1nwjBl4vqSO7dXjyn6lDwOnYnk2yHCSIzIIISk++XZ6ACyfsmuZ6HIcoULA5qP
	QWQdE/yux1aq9i9hpBGTLTue7UCSfpJmI3pa38yUTmOkQ8k0Nbur4RwCBbkGBj8+D9W9laJ8v/p
	XIGP4tefkR/gccxTf8QvnDJl3wPuosjh7V/YrweLnPsFjdEDW99IG3uYpHcmls0yzDd+AJRIIxb
	aNl6vZ78ajqm/SbzehuC80Laa6a0SH8+T4QjVjUcsdSmd8DPuGB/tCUxspRRLYl8I023B/g4yL8
	bOfYHW7Cp90fdHa8B93rP/BDNSyP2UgjBWtG8xvZQIX1/udMUJmpnVpftnWH9xOIhxJlm7UUoX8
	G06xEdX7XECT7Gak4YPcD9XU/D/vPVqD/U/Ly3IAlXhbgFnFMsQfhMNDLPNv67AfFWGoLU081H4
	Q8cYPl0D3/3t9lw=
X-Received: by 2002:a05:6a20:6a0d:b0:3cf:a7a5:e310 with SMTP id adf61e73a8af0-3de0e725faemr697683637.9.1790207462499;
        Wed, 23 Sep 2026 16:51:02 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0f9b98sm2043526b3a.55.2026.09.23.16.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 16:51:02 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 23:51:01 +0000
Message-Id: <DLN3KYEZPIQR.30NJCCM978VV1@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
 <a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next 04/17] bpf: Prepare static analysis passes for
 callx instruction
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <7917b7dbfbc2d206b0b4c22d2352f5b4700125f0.camel@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com> <20260922011323.1298619-5-alexei.starovoitov@gmail.com> <7917b7dbfbc2d206b0b4c22d2352f5b4700125f0.camel@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 04:10 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> -		alive = bpf_calls_callback(env, callsite)
>> +		alive = callee_stack_access_at_callsite(env, callsite)
>>  			? is_live_before(instance, callsite, rel, half_spi)
>>  			: is_live_before(instance, callsite + 1, rel, half_spi);
>>  		if (alive)
>
> I don't understand this change.
> The original reasoning is that callback calling function can call the
> callback many times and the callback might access stack slots from
> outer frames. Hence is_live_before(... callsite ...).
> callx only calls target once.

It's not about the number of calls.
analyze_subprog() doesn't know the callee of callx and doesn't create
an instance for it at this callsite. While the verifier is in the
callee lookup_instance() finds its standalone depth 0 instance that
knows nothing about outer frames. What the callee may read in the
caller's stack is recorded as may_read of callx insn itself by
record_call_access(). That's in live_before(callsite), but not in
live_before(callsite + 1).

callx_callee_reads_caller_stack_ok in patch 15 is a test case for this.
Without this hunk fp-8 is dead.

