Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53C48FF78
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583044; cv=none; b=CcifmLm6pdAfyg5WnIp9VaqkUUmTEYutZWk7NK56ZccP09nWUktrmsfGlvbh0rcKEH4I9nlpvCccvIHIH/49XgM8E8ukl8tLjxMyVXmIVhDvE6WeVym1Vk/q3s1AdWJ9UFFKdZ9MLhwnnerFMBlwMQQfezccP3QT2Ii6YDueTvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583044; c=relaxed/simple;
	bh=KMKNVuOAW0Z9B0dfNMAZqpWW9kArG1JxhhMxWlbb+eY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hqW0RW1Dgp12Xf/3R0OnxffWX7AECCnCSNIKAkMGxRAYFtBfadJT5ZCOrrD+ZttO+LU7Zx8v3374k/0Ui0ml5xqze4XG8BeSxgP9J+LVv++ZRt7IrKFFYK8pK89nuljLoSJyWCTeffUYdGmhfW2qECvbzE/nJ3JiW61dprRvo3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0/NTLWA; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0/NTLWA"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-86212a185dcso1166410b3a.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789583029; x=1790187829; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XwmBhfqFC/P9VqM5llI+u2jesxhJLESVjwTdpy7ERv8=;
        b=A0/NTLWAt4oxKc4KHiT8Pr12ZBBJWyWr6iWFKlTDo2Zme4rqe19jWrVud5gckE8fTW
         hsVYBEMutTwOORfizHbY7xpCjiLqu4HEB5S3e9YzfPmNqUcbg4gpFTZmipiyzRmoMIc8
         6PGzTq53sDFpb8QudUc8WlXgPyH1HGDvn7TotgnwhZdxW7qvgO6+ueN/xCzcmyCroVVJ
         Mjh0BWHuLR4OYAK5Kqf1RpBs5q5n1dQFOBW/7RhdcVW5C0un77NCkzuP0U6N/9ndytIQ
         2mc0zMy76K4nETp9pc1GKF2xldR0gbhfzuiCZC1RlpA2wkukyuu1XUXbrbv3qUYhJs1t
         RyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583029; x=1790187829;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XwmBhfqFC/P9VqM5llI+u2jesxhJLESVjwTdpy7ERv8=;
        b=C/tFEy4yMgLp5pLE50id7qY+kK+VFXI+OpTAYZsAGm9/XhBqPZlIHNlpNCFO0I5Glw
         75/sL/9p9jcSDFRGh9Y39vLgBBvNXv+PWE4bXx8LPua3y8IlLwUf6dwpxwtSN4qMcw7m
         643eX27JDv9bZWav1DO6UDLa99307nWfej20GcANGbVJN5wnWMxJKd+IyClujR0o2EKZ
         aAM7bVyJjEfvrCOG/ZziCkO6MIZc4PMzunIIQUvKa0/hgX0XeBkzxA1csOLz84qKqsKu
         0Pdjp6YARApMvTF3GUlnyYUDQoQl7L8P1k2q95S5vUU/A4+Jad5dxRx1ExmxS43aTFVq
         x+jw==
X-Forwarded-Encrypted: i=1; AKwUvBy23/I0bjEl8y1XrDW8Gj+ceL+2a2iejuDHhA6h8ZQw0qc/Wi9EEQxvWSKM1INca3GcOps=@vger.kernel.org
X-Gm-Message-State: AFuF++kZQqxkc3r0xWch3olo0DmAEiIwulyhGiSKma1upKz4XZIvTDbI
	vsZcxFBK5K3oL3UrwZ8haCMNbXquOwSURQy5Uuyo2UFjL0ASfWVfJwLg
X-Gm-Gg: AYBFou2nbs9JRtFUvNMdJXM2r2LeSjIDJg0uAQLzX3Z+nc3nkf9QRsvUfjFdjicQFA1
	w6rnTq6ODxhceYcPCI212TGtOHUHgZpnwvszs1Fr/99jjnG+QUDjFe9AuiXPJOFkskQY+Wnc8FK
	jtCkyY7t5z+9TGlEOEII0cJBT6J6ofarhD/6ONxJ39hXu3lClJEgq0pAlmXdKrODeOe5SiIg3La
	d/8+sKFWS4Pw57U6uNP4TE7LfV1W+5jrXn4Kav4qElGQU1tXZJXU5b8L+6n1GaauJymi0Cfuz81
	pdrnoC8itasNEZzS9lQD50ZvfT3N3uMkXitsA0EslPJ9s+nw9JrtOkKA7hF62fKmpODGZYtCLE4
	cw1KWU00SP4k88lA/AGsDOCfzZGAt26aCS07ance67smhy6CDi0WdX0tBnW8nCEMfWYXb0SgF2C
	DRXspzDq/mH7Im/yzm6NuqmLN4l2BDj5E/FfcLnk5TeqX34k6IGVNq1fiBwrI5tWr0J2LyGu0TY
	oXTxyFhZqu365LNd5jmxjRXBLDu
X-Received: by 2002:a05:6a00:10d0:b0:82f:50cd:e586 with SMTP id d2e1a72fcca58-8723cf31d94mr6520840b3a.13.1789583028587;
        Wed, 16 Sep 2026 11:23:48 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87200c581fcsm1753358b3a.12.2026.09.16.11.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 11:23:48 -0700 (PDT)
Message-ID: <91d077abd444c0941bc93260c7bc75b09fce7263.camel@gmail.com>
Subject: Re: [PATCH bpf v4 05/11] selftests/bpf: Test early in-kernel CO-RE
 relocation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Wed, 16 Sep 2026 11:23:45 -0700
In-Reply-To: <20260914222514.1635018-6-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
	 <20260914222514.1635018-6-memxor@gmail.com>
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
> Add a raw program load with CO-RE relocation metadata but no func_info or
> line_info. Place the relocation in dead code and require the poisoning lo=
g,
> proving that the kernel processes standalone CO-RE metadata instead of
> silently skipping it.
>=20
> Also poison a subprogram's terminal exit and require check_subprogs() to
> reject the resulting fall-through. This confirms that in-kernel CO-RE run=
s
> before the verifier validates the subprogram layout and before later CFG
> consumers rely on it.
>=20
> Load both instruction streams without relocation metadata first to ensure
> that CO-RE processing causes the rejection and diagnostic.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> +static void test_early_core_relo(void)
> +{
> +	struct bpf_insn core_only[] =3D {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	struct bpf_insn subprog[] =3D {
> +		BPF_CALL_REL(2),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	struct bpf_func_info funcs[2];
> +	const void *raw_btf;
> +	struct btf *btf;
> +	__u32 raw_btf_size;
> +	int access_str_off, btf_fd =3D -1, enum_id;
> +	int int_id, main_id, prog_fd =3D -1, proto_id, sub_id;
> +
> +	btf =3D btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "btf_new_empty"))
> +		return;
> +	int_id =3D btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	if (!ASSERT_GT(int_id, 0, "add_int"))
> +		goto cleanup;
> +	proto_id =3D btf__add_func_proto(btf, int_id);
> +	if (!ASSERT_GT(proto_id, 0, "add_func_proto"))
> +		goto cleanup;
> +	main_id =3D btf__add_func(btf, "main_fn", BTF_FUNC_STATIC, proto_id);
> +	if (!ASSERT_GT(main_id, 0, "add_main_func"))
> +		goto cleanup;
> +	sub_id =3D btf__add_func(btf, "sub_fn", BTF_FUNC_STATIC, proto_id);
> +	if (!ASSERT_GT(sub_id, 0, "add_sub_func"))
> +		goto cleanup;
> +	enum_id =3D btf__add_enum(btf, "core_relo_poison_missing", 4);
> +	if (!ASSERT_GT(enum_id, 0, "add_enum") ||
> +	=C2=A0=C2=A0=C2=A0 !ASSERT_OK(btf__add_enum_value(btf, "value", 0), "ad=
d_enum_value"))
> +		goto cleanup;
> +	access_str_off =3D btf__add_str(btf, "0");
> +	if (!ASSERT_GT(access_str_off, 0, "add_access_str"))
> +		goto cleanup;

I asked to update this to use utility macro, but if there are no other
nits let's land as-is.

...
