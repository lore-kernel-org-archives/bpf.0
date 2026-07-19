Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767439D6D9
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473706; cv=none; b=MHmi02y9bl5VLKI/aRfpxtV73mu6xNqtpxRJA8LxDfRVzuMcjyqaTC6eUZgNA8rExsYTU1U2B8NZhAbVwtMAie9NMk0rjEbWHbM57ojzavtUpmZFgr7qb20GWDpm0FRVXDqBmEXs96Te15bIw5hqNUe8KeNtibaeGLDW1hl5U+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473706; c=relaxed/simple;
	bh=g6LQqsrWXiY+7OUBAHp4kf8xGJBX3+UC8Sq0rfIkDHg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GWzlO0OWFEWjyfLKGxvmIrwc61zdq6qN2Tvi5JFz74eJIxdmgYC2/dTXGeuDYPrgjGHjHHCjbT2dWw/tNnUHx4eJo06+sRXTkytUG7N04ju3Pa5bjGkoskcuUIbY+M3xIjCjYaU6DKriTq2BCG/+lAqq5S/QxbC8KqYGWEvAAzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2eQPhwm; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2eQPhwm"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so37826465e9.0
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784473702; x=1785078502; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZQ1FlXHQOc6lZCsP6dU6XTD5qiNU+Uv/Pn0cEhz4kks=;
        b=Y2eQPhwmsZS0rJomuqwi0S70PkD3wdaTJrRv6e37skhHFQHv8AjEkygfCgWGg5QPLd
         YZzO2o4x5j2RpZ4nbIAStXbmrzIn0JXoJSGdRgls8gBHTM+EJ4a5mLa/UbfqySkzLgvR
         Gj4RT61s6ol7R+KyxKU/D+3FJ2zE5OugZaij1S7LzpFCBYhN+4zeypkNd4I9tW8lg/SO
         hsHgrugDMEz3Vmp+lb0uPPv0xg/xHZ6DWkWVf/1bKJNiNv9uEsN+O14kcHuFlfuhIe5Y
         /gZNihUf4ZU8Jk+6pUs2lp+pm4IL0fN7Yp74oW22aaEvw42UuFa690GJR3jyXYftznIl
         ScpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784473702; x=1785078502;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZQ1FlXHQOc6lZCsP6dU6XTD5qiNU+Uv/Pn0cEhz4kks=;
        b=iZsHimrjUZRR9N1e4QkkVj3/a4dWCAT7YAMrnQxr3zoT+QIWHc/gdmFOKxmnaV0OGr
         bvGJDXqehlmRYZFRXZC5Fc3/zZX9qmUUotYShMCyXJJie0g6W77AKoPZTGow9esk5czx
         Gzgw4NY4n+mKq19+vpqqqakdNBnt5DT4aSuzsAKEt67j/Y2SHUgqi/0Th6zEUylaE12P
         tjwgOdofips4KbGwQev9nQ7LYhH3FYv4EuMq8JhL9B+qXH4quaaOf9nwetyPLOFNMJKh
         bWwylxJjpZNi1D0PglwUIFi4TiexXDSA+327KIs/Pkvo5LG2olUxUkHf5b7MKv6AziH0
         6oEA==
X-Gm-Message-State: AOJu0Yy33BpROujpWGPtZj+f155de+yi7teHrEVHFRm0ZGhO7uB2nBDh
	HVczDaDh0I5i4WYZ5HLelFzDxaPD0rA36/UbUiP1YrXxLxbVkfU/3yPRmvvGB0C3
X-Gm-Gg: AfdE7cm+fAQxmHZP0zhfka2m/RwkdGimILaVtFbeECMXLRD38ZivO3QntVZIUZ7xqGf
	ku4lNqj2BRc6fUp3AgBqvPceFSYCCVPg1w1dbTv4Kf8X9UvhXAvGhvXdjev/nqCBseyRi89jeFr
	IgaXR4+hlrq+bcbRBKbO70u9sLXhf9ePJ1xUTze8UJSyOrzWI1Hb9ZTiBimFQosskoXfgFYivcb
	kuN4J9SRmBSb/Beq1OD5i0w9Dx632kS/iLUlTv0no9n0fppsqowJEZmLc8JOH6gUNp/W3YWBUlH
	2YcNtBAu67oF8UPpsd/XuhZfqpTdDllUyeZeMo/3AlK3frkE4A3xQVPnnpfcDlQ/kciOGT4lBgE
	2lM3DJorDykelodkii6tOAJpKeFADLZuV18GNnKqHo9HM0gZTiwZF2VTxFMo+688HaN1TxcAWDl
	RxbUxi8M+frMK5lOuKx6hnejurLF31mMjNpRURZjn/JHb5i41vwOViHDGEQ+Y0l5fbmjIiwz2kX
	K4zMUpPP8nLgVZNL0hWp+eVXyM8Vc4uDSlbJuSdIlPU
X-Received: by 2002:a05:600c:1382:b0:495:699:5c8b with SMTP id 5b1f17b1804b1-4954a3e206dmr110350985e9.7.1784473701710;
        Sun, 19 Jul 2026 08:08:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm220178415e9.12.2026.07.19.08.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 17:08:19 +0200
Message-Id: <DK2N4SFI9HSJ.26TX2WCT67ZHY@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Preserve unique-field state across
 nested structs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260719142401.2420111-1-memxor@gmail.com>
 <20260719142401.2420111-2-memxor@gmail.com>
 <20260719143429.1BA8D1F000E9@smtp.kernel.org>
In-Reply-To: <20260719143429.1BA8D1F000E9@smtp.kernel.org>

On Sun Jul 19, 2026 at 4:34 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] BPF_REFCOUNT is incorrectly marked as non-unique, allowing users=
 to trigger a WARN_ON_ONCE via duplicate fields.
> - [High] Typo in BPF_RES_SPIN_LOCK parsing checks the wrong offset, allow=
ing users to trigger a WARN_ON_ONCE.
> --
>
> --- Patch [1]: [PATCH bpf-next v1 1/2] bpf: Preserve unique-field state a=
cross nested structs ---
> commit cc8eb6296aa42dface6bb303fbfdec9c1e0e7566
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Preserve unique-field state across nested structs
>
> This commit addresses an issue where btf_find_struct_field() initialized =
a
> fresh seen mask for every recursive descent. By sharing the seen_mask poi=
nter
> across the traversal, it properly detects duplicate unique fields to prev=
ent
> an invariant warning during map creation.
>
>> btf_find_struct_field() initializes a fresh seen mask for every recursiv=
e
>> descent. Unique special fields in different levels of the same aggregate
>> therefore do not see one another. The duplicate fields can reach
>> btf_parse_fields(), where they trigger an invariant WARN_ON_ONCE(). A
>> crafted user BTF can consequently trigger the warning before map creatio=
n
>> checks capabilities.
>
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at
> btf_get_field_type() in kernel/bpf/btf.c, BPF_REFCOUNT is defined as
> non-unique (is_unique =3D false).
>
> If a user creates a BPF map using a BTF struct containing two bpf_refcoun=
t
> fields, they bypass the uniqueness check. When btf_parse_fields() process=
es
> them, the second field triggers the invariant check:
>
> kernel/bpf/btf.c:btf_parse_fields() {
>     ...
>     case BPF_REFCOUNT:
>         WARN_ON_ONCE(rec->refcount_off >=3D 0);
>     ...
> }

Will fix and respin.

>
> Can a crafted user BTF still trigger this WARN_ON_ONCE() using duplicate
> refcount fields?
>
>
> [Severity: High]
> This is a pre-existing issue, but looking at the BPF_RES_SPIN_LOCK case i=
n
> btf_parse_fields(), it appears to check the wrong offset:
>
> kernel/bpf/btf.c:btf_parse_fields() {
>     ...
>     case BPF_RES_SPIN_LOCK:
>         WARN_ON_ONCE(rec->spin_lock_off >=3D 0);
>         /* Cache offset for faster lookup at runtime */
>         rec->res_spin_lock_off =3D rec->fields[i].offset;
>         break;
>     ...
> }
>
> If a user provides a BTF struct containing both a bpf_spin_lock and
> a bpf_res_spin_lock, wouldn't this trigger the WARN_ON_ONCE() before
> reaching the intended graceful rejection?
>
> kernel/bpf/btf.c:btf_parse_fields() {
>     ...
>     if (rec->spin_lock_off >=3D 0 && rec->res_spin_lock_off >=3D 0) {
>         ret =3D -EINVAL;
>         goto end;
>     }
>     ...
> }
>

Already sent, but will roll the fix for this in this series.

>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index cbb1e49b9bcbf..8d628552ef99e 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -3751,7 +3751,7 @@ static int btf_repeat_fields(struct btf_field_info=
 *info, int info_cnt,
>>  static int btf_find_struct_field(const struct btf *btf,
>>  				 const struct btf_type *t, u32 field_mask,
>>  				 struct btf_field_info *info, int info_cnt,
>> -				 u32 level);
>> +				 u32 level, u32 *seen_mask);
>>
> [ ... ]

