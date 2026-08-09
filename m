Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BEC2DF12F
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786284487; cv=none; b=Ai5V5hHc9QTak2SX3+M1KMKUKQvxkAJbsmH4wMVTO41296+MO7jecetscQv6fDJk24Nue77h1uYQbOI/PhjxaiuwWYzP4QlmS39P+kk4nvK4n0h60r++jpLAYHJ+6jdVALuHHnnuvi1tbolvq41U1xp73FSHq2QceF/7LJ9zprw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786284487; c=relaxed/simple;
	bh=vgA316FlRt4n2ML7+gOF08cr3O1+t2Gu0mL93anA074=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=olzKUNoFf9WRfN06tb+ljIiNw0aZ75VhsIpVx3eYS1Epf5MkIlMZETWEFAqiBQJAG2inMUSVSxXDnA5WOSt7QAz6g5NGs4M6KwjbKJctCmXy93LEEhrMOL1/w4qNxC6bEmszdSNzjo3aGwTt0NxKWjKB8Z/OsLsFMCUgflzceiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOKvNoZ6; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOKvNoZ6"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47825ef4012so579424f8f.1
        for <bpf@vger.kernel.org>; Sun, 09 Aug 2026 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786284483; x=1786889283; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zNwOBISQ1zE0CxH8TSTHxLoRPoISqMofHQyW3ybTjDk=;
        b=pOKvNoZ6D8zC8FreuyTF4anjcM/OIlEQDSNjyLAH/96scCbsBcm0T5K8hqKs+uM4mv
         49fijHBy5TS/Eif7mUxx0QAHfFqZl9bhjDeoTJ7AxPQw5eZ/fw+48Cxriq9Ui4HxZjMK
         XJ8Q0bHDlYh86dex6UAo8r+EZjl/2KSDyxpwQcvdy/egsqAtguovzVipa0kUj2W4DOYt
         QX2j2JmSrGp8Kp1ultKjfTYHjUqtVS1NrT5QY+hZwFbvBe4bnUO1DA5ba9ykp1BC/XkI
         2OFp5eTFIl2pIybUUD7NFh+YeK/WuQqztp5RopmhpBJg1tt3k+pLcUu+8Gpc40EWVXuK
         tgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786284483; x=1786889283;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zNwOBISQ1zE0CxH8TSTHxLoRPoISqMofHQyW3ybTjDk=;
        b=hq+cI8bsQkdHb7FF6TL+NT7QiXDedOfCsj1C73/Ljkr934gfiEQOQx1UnGNLUmv6J7
         8X3D/C4FRbW16mRgsK4TzdF3mgQmUq0ForXZGL9e/HV6PHre+vNxn/3XeGGdV7K2tH4Y
         3kofQTzWb8jjWTWZgnz6NNc2boh1KChGpsokZELxaBj1YWZO1INx4KJx05e2vRjquYvk
         pS+kM4xRnnCQ8qd+k1sRThQntLLh52cs/KyZzlWWcMn4tc2vrpUM1PRSs/n3auL2r97C
         grv6QAr2glHZay8hSsduiqZJTsDgDYfijRsuPVbse39/VFgqDfIUgPjKQvPwoTkoxLLq
         992Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp9xFlXLvPhftWn1mQrcZbmzDMeNBUL4AOg6MKgNBB0pgoEO+6X00noJrEuEvGkViOR3j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiWba6+2grW0ahglWc63ldxGg8RdKTY1e9IF1gya6rnS1SmLhE
	h3CX1RAU5rSZ7C8Adrg6djuMw+XPBG9QQuWuKohgroKxAyltBRWJzYj8
X-Gm-Gg: AR+sD12X3YMGFXmiifsnwxsvW3dMlBQPFR0AievASW15n8EgYxWQKwBL9qeflEifP5F
	RCKkF3M0SVv1AoiT8Ig1Rm8AzwVxsLdezG0GYbkMogon7CIaxX5wZOqCbm2fonMli6ePJMToIck
	E7tWAW/5uCrinF7+MrHhzpuJyqbDuAMxu20qPCppeiEVE/SJvaFyuK8iEuWukV/hf5YDYG+D1de
	R76CEktylXigBlbD5OfzK04QmIfmTDPfyRH52p44HCufLol1cvsvLIyg8hiaP1l4CoxOYOLzbhe
	374gaQjYDgyXbaZ+Qp6VxNWLctzhVMDld7ZqvyCSepH9zp1A5qPrPXoAHwhAsGByyKabn13BMz5
	shVs1sRF1rm3ovCmka02E/BKglpNXGFI6qGF9JiEeIeXCqGxAMJLev5ujQ9aPZ8vr9+ydtXVTDW
	P+v8AWM/FMssiPOF10wCrJ7pTpZPcf/Dbf/hgS5TlOnfRdDp4ygULQelamM3LLifFaE4E1T+ZXt
	SAOc917u3roUAlkxjWz69Ylft9n8VA8U1vkPuI84ETNzLkeevlBB3owFrqyFLNfbehHsuTYbBkh
	dNbhc/AXgPFKa3pCvaYCdgrAaJI=
X-Received: by 2002:a05:6000:29d7:b0:47f:8cf9:a12b with SMTP id ffacd0b85a97d-47ffd203ed1mr26219032f8f.6.1786284482730;
        Sun, 09 Aug 2026 07:08:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021501bcsm23552299f8f.9.2026.08.09.07.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 07:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Aug 2026 16:08:01 +0200
Message-Id: <DKKH029BDMUE.ZRUN10UFRGLP@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <ihor.solodrai@linux.dev>, <kkd@meta.com>, <kernel-team@meta.com>,
 <martin.lau@kernel.org>, <yonghong.song@linux.dev>, <clm@meta.com>
Subject: Re: [PATCH bpf-next v1 1/2] resolve_btfids: Emit arena attributes
 from kfunc parameter suffixes
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260809085155.3305519-2-memxor@gmail.com>
 <dc4f01fc137a1c4c66bb2eb39f721654bf539f065a623af7dd05b90c32b6f569@mail.kernel.org>
In-Reply-To: <dc4f01fc137a1c4c66bb2eb39f721654bf539f065a623af7dd05b90c32b6f569@mail.kernel.org>

On Sun Aug 9, 2026 at 12:10 PM CEST, bot+bpf-ci wrote:
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/=
main.c
>> index d2e4176339da..3c88ea192f7b 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
>
> [ ... ]
>
>> @@ -1067,6 +1070,22 @@ static int collect_decl_tags(struct btf2btf_conte=
xt *ctx)
>>  	return 0;
>>  }
>>
>> +static bool param_name_has_suffix(const char *name, const char *suffix)
>> +{
>> +	size_t name_len =3D strlen(name);
>> +	size_t suffix_len =3D strlen(suffix);
>> +
>> +	return name_len >=3D suffix_len && !strcmp(name + name_len - suffix_le=
n, suffix);
>> +}
>
> Should this be `name_len > suffix_len` instead of `name_len >=3D suffix_l=
en`?
>
> The kernel's btf_param_match_suffix() in kernel/bpf/btf.c rejects a param=
eter
> whose name is exactly equal to the suffix:
>
> kernel/bpf/btf.c:btf_param_match_suffix() {
>     ...
>     len =3D strlen(param_name);
>     if (len <=3D suffix_len)
>         return false;
>     param_name +=3D len - suffix_len;
>     return !strncmp(param_name, suffix, suffix_len);
> }
>
> That `len <=3D suffix_len` early return is what both is_kfunc_arg_arena()=
 in
> kernel/bpf/verifier.c and btf_func_model_flags() in kernel/bpf/btf.c rely=
 on.
> The same helper is also used by kernel/bpf/bpf_struct_ops.c for arena suf=
fix
> matching.
>
> With the current implementation, a parameter named exactly "__arena" woul=
d be
> treated as an arena pointer by resolve_btfids (causing address_space(1) t=
o be
> emitted in vmlinux.h), but would be treated as an ordinary kernel pointer=
 by
> the verifier's is_kfunc_arg_arena().
>
> No in-tree kfunc currently uses a parameter named exactly "__arena" or
> "__arena__nullable" (checked kernel/bpf/arena.c, test_kmods/bpf_testmod.c=
,
> and btf_data.c), and the selftests added by commit 52b915d08490 only use
> names like "a__arena", so this would be a latent inconsistency rather tha=
n a
> currently-firing failure.
>

I think it's fine, won't matter in practice.

>> +
>> +static bool is_arena_param(const struct btf *btf, const struct btf_para=
m *param)
>> +{
>> +	const char *name =3D btf__name_by_offset(btf, param->name_off);
>> +
>> +	return param_name_has_suffix(name, PARAM_SUFFIX_ARENA) ||
>> +	       param_name_has_suffix(name, PARAM_SUFFIX_ARENA_NULLABLE);
>> +}
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/313052=
17088

