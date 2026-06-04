Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9A12D8DBB
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591912; cv=pass; b=BECvs96I4Hfwl/6/4e7J9iwz+16ClKT78xjVatHCo8VJzDdLBP8hRbA2/VAzV5VILO0KaJHi4tS107ohYI63lL956nZYkkBBfHEYQ7tG4qdWJXM7piNR3m4bVE8drn+IsZxMQLJryK6RLEykUNMsMLLwcuyzpCikffegW/OAYlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591912; c=relaxed/simple;
	bh=hvmbtAQewEtmy47tuFtSIfBRVRJObH8hS/3Xnn/dhI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBX4VBiGXMsKEyA9sEhMCp7u2l6MZABlNcfyJTSn94NzThSHhRCPu2/bugIa5p17grkAvkPgEZ1lDVOcYeD1CF9xsvrdh0Dc/wLMA7sm3FOh91QQ50TBJAZS4MS+LWTugSHgiFxWuK09zlOn3imwaJX3/QfEq+XrfSE6zGG5sgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBV6aYSL; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBV6aYSL"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso488306f8f.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 09:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780591909; cv=none;
        d=google.com; s=arc-20240605;
        b=I0l2MXxZ4FVVXbDYSyH/OIvc5KZNKuowShu3cvUDj/SY26xNzXX3aO2oGfzseUzd4x
         KHSoWZxpI1755Z8CwI+T+D0ZEDVOOZG1V0A/G6SYHxOG1pNnQsLidIPjleOsjQwHZqJp
         2Xta6vjoRW1MrIJJctfqNdThphLcuBNs9m5WM34/EweKKWcDMTz6OzaTD+1yUy4OGQP5
         97ht0SkRCo1sAgRp3D18kkmyVEKFIGQ0eOzW2zhvnyGEx+ztZJkJXk+RWgu8wCsPoqon
         pNjN0lu8PW+qQnaW/0tqV9Ezv396e++gUaOZZfN2XdQK8/92uRX9TVQsfSCZ0foeh4x3
         DVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xmx8c4BW3E5JOzBtVNjv0BrlaSsHghmEQByujmEqBqo=;
        fh=c8FSve0WQUwVgWasT7SrWo+ftl266GREaz4/QFzLmqY=;
        b=RjC4edANgW2t763IA/7pIjk+Omh1nSGyqik6f111wqGObwW0aTzw5H5VC9CyyHSOi/
         84xB3dD440k4r8GHpY/OSjjl63LjIl2JADG9IpCURX0RxStuh9MMg0JAhFisS395jX1i
         ElT+mndtIXW9fji2ILwPJTYDTE/r2E4R5gLnk5kRBNo1gEHxikX0OZ5Gf1K70Y5xjMyS
         LR7IOTO0lz3wQCaedCVzA3ZREGlNuJPVFfhg5rwzDDO9r/hYr8vHRUkdSznYG4icgYSj
         LMqkYyBQWqvf+rWcoG4CYc2+H8ZwQedV/UoOX5rHmpcwwkw5c17QgZnIJZrxqkU2nej+
         5m4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780591909; x=1781196709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmx8c4BW3E5JOzBtVNjv0BrlaSsHghmEQByujmEqBqo=;
        b=jBV6aYSL5BOQm9Hp76zweTjugdJf9Zzh7u3qyQKVqoQhyem4rNbnEXstrLMJlCCR58
         gRY333Wco743EP/s4iDc7hQaM1MPvd0pp8IE30ZFA4KovABPdaIjJDzMvWJp3NAueAAT
         /z2I78Vx1fUIeJU+ogw/lMtz541ckV9FmUrAVokdjzJ0XI7o0uVy7DvKIEx41U7uFFfi
         Krk5qU9DjMfZ97k0Z84zkIKZgJqENL7KFjTEMjpcyKZ2lrgeOY0Q2qgFBSrVLqlYSf32
         5S9RCRf1faCyWjXpfSRb+r02S9fyhCjxK9ThW0rIDs0pd21RtmWHmv1PvvXIAE9P68ln
         TVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780591909; x=1781196709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xmx8c4BW3E5JOzBtVNjv0BrlaSsHghmEQByujmEqBqo=;
        b=H3stPphB2av/PxAbe2uEdugFMNBEGzDHFToDtGQygpzF+EHyoR+EF6ybBaobxvd8SA
         5AHzNcszoDFz/Eohrqyo9qZJ6gWOYaiGnfXkZ+v3pGjzPxGjWi8K/Nwtt43vh+OgMAkE
         hEllyTUmuDPAJs1k5pBZ9AtKdYYXqmGSiOBwzhh1/EAJACeBVgu0binqNUoejiPE2StB
         ktN//siQV1VceyOmxBcCK+l10kDEfc1Heoyc4M6ej1KplpsgcJ8oIIEgCfmRizUg6tD4
         bf9R6IP7kxa+ZxMRqV2g5TXMlnY3nT73ht9BwrIi12e/LkLBCehhOpw+SbNjdN9w8Tm9
         zD5g==
X-Gm-Message-State: AOJu0Yx5DG1kS24udQI1cP3ynYg0b5GuRVW4seGLbMytO3waoTH/tMIn
	P6aIuKY20svXWhBN92Kle2F9RFSdoN21alQJyN14/9NaoFHYZiC0PukmVGe4kQleMdLKHxgh2up
	rGhQ0vylspKPK/b7P6TtoRc/jXa/sW0M=
X-Gm-Gg: Acq92OEc57pxuWz1VHXY1qfV29F3DW/ULI57ECyvvVOdYrbgWE6E9fto7LtyGpVOI5m
	o+y3G2ZUu6LeQ5dn/1pvkk4Iie2EyQzZNoOGk4wbF4HJe1j2wbq5An/NA6ZbnsXFzODIz5SCx5N
	H+HlhPkXmGvnO8L0weNYkEAjv70UwcvZ7azpVY8WZINXIOriSY4Rm+xXA9t1w9Gl8ODdtBvEBA9
	f9cyDA5KovVn3tg6VLxN0Z13D4/WbXVRN4MY6PwHl0j74q2B9DllYvo7LYx7RdiCutP72/tc18z
	3rdb4oCDVGL99EtwMp3MBa75eilcAw4j3R4zKfpPwx9rLV3iJvQYcjmfDtdL6BTl+bEtLLtJdLD
	WvH1Syf+I9zuT00BVPuqETpHBj3AWUMyTFQ==
X-Received: by 2002:adf:e004:0:10b0:45e:f798:5531 with SMTP id
 ffacd0b85a97d-460218263a7mr10016849f8f.23.1780591909041; Thu, 04 Jun 2026
 09:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603182727.3922-1-emil@etsalapatis.com>
In-Reply-To: <20260603182727.3922-1-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jun 2026 09:51:35 -0700
X-Gm-Features: AVVi8CfqvJZD4ZcfJmB9tUZ7A-1VWihBPgNFThWQ9x9hVquMDrROHT41IuSiL64
Message-ID: <CAADnVQLCk1gVt6XOcZnuvsULx+R+T0DaJBQ7-sYHFSaEKPW=ZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] selftests/bpf: libarena: Add initial data structures
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 11:27=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> Add two new data structures to libarena. These data structures initially
> resided in the sched-ext repo (https://github.com/sched-ext/scx) and
> have been adapted to the internal libarena build system. The data
> structures are:
>
> - Red black tree: Fundamental tree data structure that can also serve
>   as a base for more domain-specific data structures.
>
> - Lev-Chase deque: Queue data structure that allows efficient work
>   stealing, useful in scheduling scenarios.
>
> The data structures are accompanied by selftests that are automatically
> discovered by the existing libarena test_progs selftest and incorporated
> in the CI.

bpf CI says libarena tests are failing.
