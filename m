Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8B45D1A4
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403979; cv=none; b=Ju1my9RGYlTSOhB+2UFCDsY3S9iTakWyYlTc3i9OYtcMXmsvpAvjif0QUiVZTG4mx8Kk0OaIgFQBGi4M+dpIJJAx+JraJsmdTndqCjl2pgrdOXNk9OMCeKZTEn+E60veM295twV+V1xVyQlG5qciPUE4Zyu8pOxxWIlhcpt4e+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403979; c=relaxed/simple;
	bh=FvRHPEM0Dz9wXtM9egb3lAIUY3KYwEQZ7fnWZumlGVk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZDb7MuqYLuhhw5F7fA5hKk2ei17rIo1eR6PuTTKZH8TL/tj4KandQmUjsifSHKqZff38OUMdn3wxItZ6m34135AK4/ejYvcV1ft/jNqxjBsL1MENR3YjAYUGu+NJ5mJtdMe6/CkINiUgjw1lJAIbpQXW2ab8oHj/j1MzCDqPAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiduK3tN; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiduK3tN"
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4b388697b03so535891b6e.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789403972; x=1790008772; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FvRHPEM0Dz9wXtM9egb3lAIUY3KYwEQZ7fnWZumlGVk=;
        b=aiduK3tNVBh5ljoTHIoM88Y/dht70s97/nZU5BhtLHk8bl/t4WAfDdw72yMScAMgPC
         Ukzi3LbGFnmxzvXJL/wTDBvhJTZacsaVuhbkx1iCs0yqXKljrS48ORjY0zS9GQAlNMpb
         qQ01oMeV6Wh3RP+M7TqIRjIlIhkQ2eeurtW4oWoJ1YnvdmBGT2z1USqbrwoQni6UjZm3
         DuMbR+yK0dcfr88Eyk10XJGDfImuiFhtRB/AsFV5x0i35WeuN7EURofc4Dw4xjHM/jSc
         laf4qWLsXLfpurgj047RiKUgJ03wnyPMwWJAjau/WQ/JRBpdWw6eJsPsWKmDPWOMSyip
         CtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789403972; x=1790008772;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FvRHPEM0Dz9wXtM9egb3lAIUY3KYwEQZ7fnWZumlGVk=;
        b=fampUe0gYbzb4T0Lvj27OwxPRpaR6WE0cckBIIbLhVg0/9Vxaa55J7oxJz9pg10Jnf
         vnkiMi+iFaNhwe+HRw5BLbRSKc+OpzptPQaNlF1sMOGuAd/wVlxcMiHp1OsrYDpLBd5S
         G1EU2efxIec2D1hrxsV1rqyBfBl3dTvivjxm5srR6ZCMrpa/KSTOsi0/z+aOR7AeqPyK
         cIx9rcwP04ydkj4nBjbOFB0fJc3W7FGkZWi1miktKheZOd3HUHrpBDK9vxcbbcOm8OBR
         yxH3Le47aivWV6X5JWku3SDIL2hgDVVfruJZ98fkcWPS44aN0/yJgdEq9U6FxTgYTpL7
         xOcQ==
X-Forwarded-Encrypted: i=1; AKwUvByRVQfxWDG+ITXfelpx9bnXI7qI9P66teszGZKGT13Fwe/Qty0DOK0vcOrR4brmCiSbejA=@vger.kernel.org
X-Gm-Message-State: AFuF++mEnX5nYWd709vyDuEU93kQS/V8zXi7n2qK+bWwXt9hhGixG/0h
	1S44QMJ4dy4IgpIBoobG6J9JOoK1Lv+xiY5WJ7eyCU3cPKbB7xsQhXyu
X-Gm-Gg: AYBFou3iJyZL4hBx+QuyDKpA/j9JBpa7u2hRVt4VGvBl+3onInZhQv04ZRCwNwGuHWL
	GJ+4nIrTu2NfE0SgP4OJsXnWjwYTtTq92/EXkmUKYo2FFaPU0DAVtUGIBNGE2OmwVPRm8beMXym
	mOkjitZmWCbjRviLvsTicGHov/NKytrhBSBrkrVgVlelO10ADgejfGJEQq8CUvAQ7wDmm2ylEV9
	usdTj7b0KkpztW4Tx0J6gkmjnDkf4MMk13X0b3ss8WPUCM+M9L4gHbaHHBQqE5Cxkec8nXwpkVS
	o6jlZGO5+h+fWTjh4TJqui4Evfor9gId4SqT2eJBW01lZV/aWWHoD4D/c67lj0KqWj3e2Yh3YfU
	CxP2aQ+nuy1Qv9pYLD3nMndBaXoOErL6kzr1i8PqT6ahabgMo9ra+ggpvrbCrd/ut6DptSHIhzf
	f2HklbBMmitcahGiM+r08UWdCy+6/aJRrsKd1i6UBNXVSMHNOvanJM7fa9kUfIpvspeZ5KzknnQ
	pyJALFVD3VqjumuJ/vAA0iXPFXx5a7+6z7tOiJ+4Pz7KzdMjs2GgSW6xWu0i2ltgC0yrV4SFMSR
	9Q0Zow==
X-Received: by 2002:a05:6820:217:b0:6aa:ed21:6c95 with SMTP id 006d021491bc7-6c53c6f60abmr1772361eaf.0.1789403971611;
        Mon, 14 Sep 2026 09:39:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:38::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c0996e0f19sm12733735eaf.7.2026.09.14.09.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 09:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 18:39:30 +0200
Message-Id: <DLF6RNI22PV3.3DMVBHPB0BR8E@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Nicholas Carlini" <npc@anthropic.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Compare stack frames in regs_exact()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260914161340.3419141-1-memxor@gmail.com>
 <20260914161340.3419141-2-memxor@gmail.com>
 <9c64f514a0afb6a491ff316246ec6cefa4adeff7.camel@gmail.com>
In-Reply-To: <9c64f514a0afb6a491ff316246ec6cefa4adeff7.camel@gmail.com>

On Mon Sep 14, 2026 at 6:33 PM CEST, Eduard Zingerman wrote:
> On Mon, 2026-09-14 at 18:13 +0200, Kumar Kartikeya Dwivedi wrote:
>> regs_exact() compares the register state up to id, followed by the ID
>> mappings, but does not compare frameno. The PTR_TO_STACK case in regsafe=
()
>> checks frameno separately, which is bypassed when exact comparison is
>> requested. Consequently, infinite-loop detection can treat pointers to
>> different stack frames as the same pointer and reject a finite loop.
>>
>> For example, initialize fp-8 to zero in the caller and to one in the
>> callee, then pass the caller's fp-8 to the callee as r1:
>>
>> =C2=A0=C2=A0=C2=A0 loop:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r0 =3D *(u64 *)(r1 + 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if r0 !=3D 0 goto done;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r1 =3D r10;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r1 +=3D -8;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto loop;
>> =C2=A0=C2=A0=C2=A0 done:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit;
>>
>> The loop terminates after reading the callee's slot on its second
>> iteration. At the loop header, however, the only relevant difference is
>> r1's frameno, so exact comparison incorrectly reports an infinite loop.
>> The same problem occurs when the pointer is spilled to the stack.
>>
>> Include frameno in regs_exact() so both exact and ordinary stack-pointer
>> comparisons enforce it. The field stays zero for other register types.
>>
>> Continue to ignore precise. Precision marks control whether pruning may
>> ignore scalar ranges; they do not change the represented values, and exa=
ct
>> comparison already compares those ranges unconditionally. Marks can also
>> change through backtracking while an ancestor state is still being
>> explored.
>>
>> Fixes: d5b892fd607a ("bpf: make infinite loop detection in is_state_visi=
ted() exact")
>> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>
> I'm going to land '[PATCH bpf v3 0/7] Misc bug fixes - part 5',
> which would be in conflict with this one.
> After that, could you please respin, but try to move frameno inside
> the bpf_reg_state's union or near the delta field?
>
> ...

Makes sense, will do.
