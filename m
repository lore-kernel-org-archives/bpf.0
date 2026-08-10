Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8825DB0D
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786382806; cv=none; b=PPokAe960bjyalNUymtm25t7dp6qoHqNw2BIQqCFzuPN4I8bAeppKVlJ+b7pzjIiMKKrlEbIS1R8gcfK3nZZ+arzU1aCnBAew6g62j+h2VOw8kYXqxBrXrNqfePbuKQxdKZjSGm8ZKrHS8GFBUgPwmDBv3oJyPSnC7sne1E7e90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786382806; c=relaxed/simple;
	bh=r94N9irZXM6SFX0j8UioRP5U09wcRQST+dSAwmuNL9g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UH4WNuc1yXBO2mZXTpiOe3VShfa9BFZTi9+9l2+A5w84v+dS7YJvUhc61jUMR0PiXCYP4oO6QUeE2wqitWSCJkmu5au1idFfTvlI6sgHe0+UKuvYNHD/xsZBgZM1fmBWx97Xy/Y1To4yynVzDZ1WebR/qch2gcAxhMgdnPUyKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpE/Pinn; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpE/Pinn"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38511175ad3so2037383a91.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786382804; x=1786987604; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=r94N9irZXM6SFX0j8UioRP5U09wcRQST+dSAwmuNL9g=;
        b=lpE/PinnLoU4h3d02ZuD1wX21+wdlGCLYmw98k29vMNcnIHFHGVJd+uHAXqShOreVN
         hwZtBZrtrfhcYroSApblJydAGFePpEWkDiaCR4bejwqZqWn+YxJDgs4SeYTAgptVbN67
         XKA12Q8AMaqX+0xxCNZ0NtWyEYrFcLdL8TalX8CBardNlH/DfOPzWv2P9lyf2e8GZuqW
         fnNfzkvkjFlAOJq2/n+OxZm0lTUl4YaN4rfeK9iN4pgfb0uqKwrkruBv2bBpqafUVran
         ZYzmQBVtAhkcXP2lA6ncTo5SWUCKa/lbnxYSHnX+nEc+t7HcetfyTv8GqlpYinMm3OmM
         BKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786382804; x=1786987604;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r94N9irZXM6SFX0j8UioRP5U09wcRQST+dSAwmuNL9g=;
        b=R135hG2wNwiDwoM2Dg1KHJI8Svw/qRVjRoeMZzrmk56W+h4/MIbXx3gUdn+NuOzqAI
         +Kr1IeE05aGQ7p5/qSbqrQAzkVUiEpNTM1/hRTaaA+Y0ZO2FQBjiL06dNltO8xpD0jXr
         zDjhegKF6uOpXoax8H4w1EwOza7qgCgbN3YyFUEui5F8nZEdVCXd4XPG6QYzI1v5s1ZM
         ShYC22+9cNhN8FrCwQQwsf2Kse7NWFyYypu8Cc7GG05fSEn+wxenpYQTiFfyH6w3RdFV
         6ho4izCQ/S/eJQihwKGN7GZSbD+iTTpPXIz2LpFUwYhEf6BGwJos8ETO/0ZL5Bf/VwLU
         52wQ==
X-Forwarded-Encrypted: i=1; AHgh+RqhNok8JmTBupLsLDppl5dF49i5NVAoo05eLqYijCp24okYapxhFd1huzPcmWn0hW7tnyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwolhxnnqOlopudeUyqWRaE9q5cW6qIRzW1xHfgYVS4s58c6pT8
	VkrpvdKiUxAIN6K3nnmmhgordqQVPvbWW/7YjMvMhOL96t6TwByW79WaKcDyBA==
X-Gm-Gg: AR+sD11vy1+fonoonuuT0Ywk0xhwtYOZMy2eiU/q/TnfZdxr13NbdyCkk1RUsEZewFF
	+7JPgBSf2HmAt39AA1E02wrGuVWCoxV/ScZ2Hjfr554mejeoR5olIo6YcSLQOhz1eIqdwnUOAz+
	wtGnYEHs3J7Xmhywua7rD0rMmL6JGJIyg+PPHDQQMqXiQzwpnhIO5ePSbwkDkrMrTrDzGg28rqy
	TXdXR5zRE/yzv/HUULgjQXvsIU84u5fhWmFd+bqOQ5sWoeZqS1LKl2+qqhaGqsdbuTegy/1FDH8
	QhWgkmiRjvaSVYZvF1ANTg34mmLi/pfdJ8VxD2/9GzKT4TIncCUkuB4MvckAp7gRuRJa7xcz7zv
	dqkPRqZ2D+/yJVE9tpulLS3u6ZKT7cWZPzODxU4SgKznoKUl77/XfQFrwAvqn3R/Pu7cZLbsySt
	jxv9rr9/BY85D7f8wBrfJ+MW4jC12nMT7r0atvCy3RvrE6y23Qoala6Z8GVh0MzgQm7UvTK8ISQ
	qhebyFGkxv3OVQZ
X-Received: by 2002:a17:90b:58c6:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-392cc9bbe81mr3503867a91.9.1786382804007;
        Mon, 10 Aug 2026 10:26:44 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d51bf886sm379530a91.7.2026.08.10.10.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:26:43 -0700 (PDT)
Message-ID: <ffed9789081d97a5ce75fdff27c60b1b627a5e86.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf, x86: Clear fetch destination on
 faulting arena atomic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, memxor@gmail.com
Cc: puranjay@kernel.org, bpf@vger.kernel.org
Date: Mon, 10 Aug 2026 10:26:39 -0700
In-Reply-To: <20260810134346.466004-3-daniel@iogearbox.net>
References: <20260810134346.466004-1-daniel@iogearbox.net>
	 <20260810134346.466004-3-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 15:43 +0200, Daniel Borkmann wrote:
> populate_extable() encodes "there is no destination register to clear" as
> DONT_CLEAR in the DST_REG field of the exception table metadata, and late=
r
> ex_handler_bpf() then reuses that very value to derive the direction it
> reports the fault with is_write =3D (reg =3D=3D DONT_CLEAR). The two coin=
cide
> for a plain load or store, but not for a RMW carrying BPF_FETCH. Such an
> atomic writes memory, so it has to be reported as a WRITE, and it also re=
ads
> the old value into a register, src_reg for BPF_ADD | BPF_FETCH and BPF_XC=
HG,
> r0 for BPF_CMPXCHG, so that register has to be cleared on fault. A single
> DONT_CLEAR cannot say both, and the store branch picks it unconditionally=
:
>=20
> =C2=A0 [...]
> =C2=A0 } else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arena_reg =3D reg2=
pt_regs[dst_reg];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fixup_reg =3D DONT=
_CLEAR;
> =C2=A0 }
> =C2=A0 [...]
>=20
> The reported direction is therefore right, but on a fault over an unmappe=
d
> arena page the fetch destination keeps whatever it held before the atomic=
,
> where every other BPF_PROBE_* access delivers 0. Give the metadata its ow=
n
> ARENA_WRITE bit so that the reported direction no longer depends on wheth=
er
> there is a register to clear, and fill DST_REG in from bpf_atomic_load_re=
g().
> BPF_{AND,OR,XOR} | BPF_FETCH need no handling here, bpf_jit_supports_insn=
()
> already rejects those in the arena.
>=20
> Fixes: d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena t=
o x86 JIT")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
