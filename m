Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856FA5111AD
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583840; cv=none; b=g30NWU8chwVgmPueVaTZiVonoJfWL0Bew6hQ1Ej3IemjNbhi4JM/TAD8BvmcHaI7TBa2JvQ7CKS606un70h59AxXPBJX5zir075NsAJizsQunys5DBXUECLgGgFRubx0gsT61z+2ujB6GBv7BHoSTExmnZq3FWn+1OCuLkvPPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583840; c=relaxed/simple;
	bh=RG4q6UJbEnonfve6J6esUiSuGUanU36xFxZwcOGnxCk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JFVxK1CsVHwdrP3tBnhflPfCdrHeoPo5hHLRRrky1+aAqWGBNSHxlntPg9NEr5BrXYfqdwyXDJEDu68lR4bKtickvvcKaFlR5xvuABUBC3iM9VQVPynzmQDyWyGlLyCD9osMQ2rXM2AurkqYvxg7paZfSGYr3aT20IEhyoGeFnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iY1YkxRl; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY1YkxRl"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8633a38df87so801094b3a.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 11:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789583833; x=1790188633; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A790NJ7tkPjvQRecbFNnEvUKBKLrMg73DaUpVz2+c/A=;
        b=iY1YkxRlZd3uB4TRVZsKsh7Ldhn2LfZtR6jreTOHw/2/m/urK2G8Aoub2OT0pn+87a
         SANl459Rd/xS5IzANayq8qjTWINtbHKPF+ZDVCXrmsWphv0fuJDGkRYmYcxgjgPUy0gY
         uw5eVX66lG44H9M8tSG/J2iWl/A0Vi8DFis/IKZdOGjE37bmIv9e5OjblvXWzjxqpN6q
         alOBCZTffdzhXyuKSQzc+tdXQlojBYOhUtvF13PVRk2OZVup1KI0ivPCppHy7RGymRMe
         gFnUNl//dqArN9WMDlshjvyt4syqD+YVZydPYdNPARSDtUY7gQQvVTKcgVhnwp1Os9JD
         X5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583833; x=1790188633;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A790NJ7tkPjvQRecbFNnEvUKBKLrMg73DaUpVz2+c/A=;
        b=jhmLNIEgBIJyJncnqA+EEGxa3J7+F/G7gPpgmVZyhp7OVbrDSV05Lb6x6M2ExOjGzv
         VwgDKxxfy6tZnE3bAud5wQBN5aKO/eym2Gxbnq96fxcjUEc+DFotYPAFYPG+YOC5LTem
         Jij6eaHN2MWW8tvMNfyK4oOXVvSgEhf5dO3aggZec6QYyM6t0qowsihmW7la+I+nfho2
         5eH7p/yF2QXH8NyxXFtu/aY3Zh3VieBJnZYIt79ZfeSpZCPkdzOqnFEuRqHWNymSlaVr
         UPRH+nxm18rUOUc5wjsturRUorT7+lkAghDgVBPI837rJ5Nn/XqbVjuYdzIOBuBGft6g
         Ugzg==
X-Forwarded-Encrypted: i=1; AKwUvBypy6uPeoKFtvAhjRM8cvAFRYZWNCa2ilEacz2RqHrdWrkfDNczV0U7Qt7haGfeWYnUuLQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kGmI2B6AvxnpHwKlSi4/UiFwHhHD3+3C5KNhiRLnKfgr/VoZwK
	oS5u533R6pcftPHJhQSCGRHWoPM2j2NroGDWmGYO6Oaf0Rwxt1uYYEBJ
X-Gm-Gg: AYBFou1itspqACuc9lJupf1xQdz/lyBEzpnUMWJn1XG1tzfAmlejPaMwlnzvCxu6MXC
	cojbYgLb9dWCNMLDgeGbXXezHbGFJiO4hTVsHbdgp1mrSG42QP0sfdFgguGji0LfqUwYef6WwZE
	qBe5XZM+yLl7pYY6EiCxkNc+IQUw+srcy7+C8uKjBUV2mE9iHpFOAYZyJpoa35MwT/ikU72sUeX
	gIN6ljzeVvnM9A4nSahHtmhEzTBwrlEw5FoOn8i+Stv8rbJctLaJWbEUHv7ATJVaMWlvD3XskyC
	PlCCZ7QrHdSS1jM9UqOlWiXBGfIAhqseJ1IHIcPH/RM4Jh5Xq/9WzSPwNxfI4Acb/mnrZkr9txr
	CHLzyVSu6OPJosIysik38bsiv36zeU7kwxRFNs+ahIZBMOhjP3SOTKuEdp3mGDPI65zYKwitxIV
	f8rV3H5nv7hYQkdZ2kB4IaXbI7TZcQumn7GYdeBG6Eb5IagJqUd59oSGEbJ6LKDTQI1PCgHul79
	LmvsZROHsPf3YKJdZG6/MqUz5g=
X-Received: by 2002:a05:6a21:b82:b0:3bf:7e2a:e874 with SMTP id adf61e73a8af0-3dd5f3d9417mr9124162637.1.1789583832955;
        Wed, 16 Sep 2026 11:37:12 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50aa986a5sm2120507a12.4.2026.09.16.11.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 11:37:12 -0700 (PDT)
Message-ID: <60814dea22492f927f6d16eb31f470e2d894fd74.camel@gmail.com>
Subject: Re: [PATCH bpf v4 10/11] libbpf: Reject truncated ldimm64 CO-RE
 relocations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>,  Nicholas
 Carlini	 <npc@anthropic.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 16 Sep 2026 11:37:09 -0700
In-Reply-To: <20260914222514.1635018-11-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
	 <20260914222514.1635018-11-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-15 at 00:25 +0200, Kumar Kartikeya Dwivedi wrote:
> CO-RE relocation of an ldimm64 instruction operates on two instruction
> slots. The original ldimm64 support checked that the second slot existed
> only on the resolved relocation path, leaving unresolved relocation
> poisoning able to write past the instruction allocation. When CO-RE logic
> was moved to the shared relocation implementation, even the resolved-path
> check was lost because bpf_core_patch_insn() no longer received the
> program length.
>=20
> A malformed BPF ELF can therefore end a function after the first ldimm64
> slot and attach a CO-RE relocation to it. libbpf allocates the instructio=
n
> array according to the function symbol size. bpf_core_patch_insn() then
> reads the absent second slot while validating a resolved relocation or
> writes a poison instruction past the allocation for an unresolved one.
>=20
> Pass the total instruction count to the shared patch helper and reject a
> terminal ldimm64 before either relocation result is handled. Thread the
> count through the in-kernel caller as well, since it compiles the same
> shared relocation implementation.
>=20
> Fixes: eacaaed784e2 ("libbpf: Implement enum value-based CO-RE relocation=
s")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/20260914140852.03DA21F0089B@smtp.kernel.org
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

It's a bit ugly to thread insn_cnt so deep only for this check.
When talking about verifier fix, the change could be as simple as:

  if (prog->insnsi[prog->len - 1].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)) =
{
	verbose(env, "invalid bpf_ld_imm64 insn\n");
	return -EINVAL;
  }

Somewhere at the beginning of bpf_check().
Wdyt?

...
