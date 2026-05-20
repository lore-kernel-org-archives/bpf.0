Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7171833CE9A
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310391; cv=pass; b=OW9yoEBPUVevsp3huY5gCZskDO1erOXva8R8txO/ohwvfJc7MjC7ydp92IlfqPRaWIAqwpkMAU50omntGkxlrghVlpkgN/nHSFD9wLLaBgTRMY8xYKLcOnYNRYF7/7I4zFrI/dhwsbtuf9CoEbox2ANtZ7IWTPsasVF/Ya9/YJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310391; c=relaxed/simple;
	bh=epPRNW+DTeChnt2vYOd2BtSWp2xcqq/u4GOdfh4R0AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyzLRYyh/BxlQTS/GUfGxaICr1Aj/rYPAHEk/qMWBb+LaOkWbfqpyS7+6xcgoeICqPsXS7k/kv45B8Bz3YIAe+ALUsy7zvpliUrGlCD/kBxQER7i2Ta0lph1kULfNDEA28kVSrGvYflAZ23PR054/BgwTxW/acKNsRHNTCNACLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNwymQTy; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNwymQTy"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso1059894066b.1
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 13:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779310389; cv=none;
        d=google.com; s=arc-20240605;
        b=Z0+rVBRtaD+boiH1JP6Zqa1AQWa3veesf/V3ZVQa0+ytbSJQ4rMOT4dcBrnPggtvU8
         CGaldHculxre+te9xVlz1WXzF3Va6KR6yyGOxKikGm8jOAf9a0NrSjrmfo/ZfQVSODEA
         Xp3ImOux6Dgj1wTIHk/CfAbvk+iIh1dt0rnl9ihOwG+GETv/P8+YkPq/D7o1P/0KKdUR
         hxtU0XsBOLFSxTzNF1hFDh2qcbTi0ubt0MD6phI8osO3Cc0lKeggs/gl+vV1107vTVO+
         IUuTyi4d7r7K+kse4vZIcCNhRIyUP/CcW5JAOWun9HnyqIacVHwhCo6cdSNeio3sPgM3
         f0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AgrHWFxpEFUsmkWDSh9F3ht6uMtkuODwzZ9hpGxEM4k=;
        fh=VxaHefHNfxrqR+Ef3AaHXImQTc9EJsfEAty4yme7MwU=;
        b=gYtFBpCdk4YBqJDCS6c1pfuCamMh0+ggRRA8EXaGepY/hce3+SmnPyeswbHmJ1R/Mj
         XC4Uc6Tw2IBU/CepH3/aGjNJyA9j5u/d9ZD9B1MKM6x5T1TD1jKYkFQbZ8aAhYKJmUc0
         tSV1eHQNLPfMZ4KoAtOG19CiQ3hS4k4e9orZZLdpYmzTrla5P0cq1Tgn54KhytdoJ8x1
         IfmybexTANaC6pu/ad1EgBQQB/QRJ9A7weXpZBkyXOZxLA3Zkix5Hckw6Sw0tJvirB/f
         +e3CICA+0ymP08I25ypNQOcuj1efeza/+vIHASm4jsycxXDFIVBGIOpR8kPFPbngak2b
         grIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779310389; x=1779915189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgrHWFxpEFUsmkWDSh9F3ht6uMtkuODwzZ9hpGxEM4k=;
        b=VNwymQTyJ9ygqXbsFITzfaBZhuQ40mkz9QfgY0DPribKSO4MhKQNIBJtBSYFNt2KWg
         v6ml4TxGzChodOPpCbEUhCaaBOLjnzmtbjuRZzeEbfWwY3azeK8vydOhDI4ZThKdmW1G
         6mRgxk9YC54690i1w3hi7iQqTHHWMFLuq8ru6QxGwWORtwTa4FG5rDbH4Dwgc7Jscvxr
         8uma9JCsmiAq/bPFO/RBT2W2ARB66K3kGmTTZ/9313TezEMun9VaR/roFjSQMFIEKGms
         lxFJsLcliNbiqmhKeou3UBPQ13qYyzhQyCeHvtfFy+3ooOSJS9YFnO2OK0ts9zaEJO0K
         bQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310389; x=1779915189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AgrHWFxpEFUsmkWDSh9F3ht6uMtkuODwzZ9hpGxEM4k=;
        b=eXCmlCnbaoQyyHfIIL0WGA1/BTa3xzUphvvm3Y5j0G/82jrI/O2M2YPGygpEXqZljy
         XAhKyU/x5HCYDWhKtHONIRyfYQqqe1JdjmGF3w/OXEpg+igXmMJIgl/5oVdcVBT1xARE
         s7mm3HIHFGqmznnW8STPUqFuqUSkl409c8HjnctyKCxtFm0oz68giQdJI30pxu3LCSql
         qfA2gjpGPY6X3kWfDJVmiWlD9cTobQsoGH6z3knkrFQi0aOL7E5dKH88bIHXmGbjA8OV
         SzXZGm7W+uGuZaxTEyaMMzAVn/GJRPyELpSWuxduCkq6lVnVVQJj6jfXKSU3lKRV8Q9k
         N57g==
X-Gm-Message-State: AOJu0YwZTI2RCcp5xSD4uv8u+f0zRUHiStelhG6JG0IDP29U3naYZRwH
	6afprYxSc54jzQk7lOfVeSC7L0XihWjhN8+BQepcil7MW7KAM8VhLbRpVgowMcJCHJY2A3kIMjd
	qcM1AIRgV6YashAXXqkPfXNN1fRbXSdo=
X-Gm-Gg: Acq92OEGveRvojJUBLQhIyDBkdIpsgXADj1ZyAeU6ViDJyT6+Yk9pmdfatca6QSEW01
	0tteRIZ1ra4X1Lpe5UEzQjb/0K9DVWC4z4n67L7PAMjHVAE4p0DOc+nJmxgjhzRyQ+TwX6Ld5lG
	Ke8WDK9exLj9ol3Gd+KsMcaQdMrRmo4lN+peqox+SU+5mGrrZmyTJyLRaBthFM4j0BRm2zI2gBi
	xcMW/oo/EOJzaPZzJanDUoLyxJNGeAMf3RAg96WRVlGivmq0lrp3mPTWtUMoaQGdzriBj3GnpH1
	lHq93+Lw6PlNnZ4S+4SuJ1+P/++KlTlfEyPCsX+9/KmfcWsYTKg2
X-Received: by 2002:a17:907:a68b:b0:bda:2928:ff9a with SMTP id
 a640c23a62f3a-bda292920a3mr427430366b.39.1779310388764; Wed, 20 May 2026
 13:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520203318.31939-1-meatuni001@gmail.com>
In-Reply-To: <20260520203318.31939-1-meatuni001@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 20 May 2026 21:52:57 +0100
X-Gm-Features: AVHnY4LU9xhe_WiCvwDW3nY1nWmi2hDUZU0Ao5i8OnvITc6c-64a6IJubqmavh8
Message-ID: <CANk7y0jzV9RSa0KwM0xuyPc0egSrMFD+CaG1j_6NY4NZn1waJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix zero batch_hash on CPU 0
 after batch_gen wraparound
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 9:34=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> commit fa747e9f843b ("selftests/bpf: Fix cold_lru producing zero
> batch_hash in XDP LB benchmark") claims the addition ensures the
> multiplier input is "always >=3D 1". This invariant does not hold after
> wraparound.
> batch_gen is __u32. After 2^32 increments it wraps to 0. On CPU 0,
> bpf_get_smp_processor_id() returns 0:
>
>     batch_gen =3D 0  (after u32 wraparound)
>     batch_hash =3D (0 + 0) * KNUTH_HASH_MULT =3D 0
>     *saddr ^=3D 0  ->  no-op, cold_lru miss counter stays 0
>
> Setting bit 0 before multiplying guarantees a non-zero odd result for
> all possible values of batch_gen and cpu_id, including after wraparound:
>
>     (any_value | 1) >=3D 1  always, since bit 0 is always set

You say - batch_gen is __u32. After 2^32 increments it wraps to 0

A single batch runs for 10ms, and batch_gen is incremented for every
batch, so for it to wrap we need to run the benchmark for 1000+ years
with a single producer.

and even if we want to benchmark for 1000 years and want to fix this,
then doing " | 1 " is not the correct way because:

On CPU 0, consecutive batches with | 1:
  batch_gen=3D2:  (2 + 0) | 1 =3D 3,  batch_hash =3D 3 * KNUTH
  batch_gen=3D3:  (3 + 0) | 1 =3D 3,  batch_hash =3D 3 * KNUTH
  batch_gen=3D4:  (4 + 0) | 1 =3D 5,  batch_hash =3D 5 * KNUTH
  batch_gen=3D5:  (5 + 0) | 1 =3D 5,  batch_hash =3D 5 * KNUTH

Each even/odd pair of batch_gen values collapses to the same
batch_hash, so half the batches reuse the previous batch's cold
address which is already warm in the LRU.
