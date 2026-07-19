Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8DF39E162
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784476231; cv=none; b=ofnvdx8w6A3NNaMEMkRl7Bsf/xhQhPiIgFKCWfArzBPTNiyBa7e1ZLhfp58hDmvKXW/hB/OMR/RawMveBjEFUUfiKcHwZo2rhQzrfX9+3YMSoa3o1QjNppKmKORsso562kMxPE0scCgWORy7aqOIdVOCPMUiT8a3bhmYWp+W6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784476231; c=relaxed/simple;
	bh=7aSOI5EYULtzA++ySrn8SAJOMzpGwkicqJmliqx3tpU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=q9M3wbY5zw/HCBSy0Bgkja9xkyv6lweioD1vSDQViWWiizTxcWOd2bFo0LSv7gFHuZHhBLJtZBS/WHfgK+0mPgnUliTW0xJ+bLgvUEFoJiudwujWCXsEFsLPvdmJTdTj5cal7KpG/rZP+Y+EWo+EJtuMADAvjyB74T/MUG8mCcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbyAl5qn; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbyAl5qn"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4954b049503so3610745e9.0
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784476228; x=1785081028; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z4/BDi01G4d6omML5te3TMEqNCT4a4sL8UbQKe44Jho=;
        b=bbyAl5qnd82Rub4M61OcIJwSO2UxerOaUOOXnUkOc3sfnJ3+59U39XzEuLiy/QrRDA
         yM1/Uk1gUxRtof5+uIxV2NRXExLqJ5yyiOJGa970KWMJu8MSeOE74j/KrZgDPmttDeJl
         oQ2IbFf2DtCF0Wr4hPburrAZ2MzV/xWL7XEgxfloKEWSCIAF22JYZH08EMBjWKAPaTX+
         M5TQhp0lZal9mqO1orJ0ZdU7tBfl9poIwTV9lUF1225jLvJqA7589DSzfJgVXti3eaSc
         tLPRynUt+7Ssjm45KoXbe3eMOwxkZZAWj45v9jrxIRh8rfoPgiOF488L7zjt81cV31Ne
         Sing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784476228; x=1785081028;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z4/BDi01G4d6omML5te3TMEqNCT4a4sL8UbQKe44Jho=;
        b=MWOLNTqWiPSdecH1fRvbUGFudMHfv+4fNri2QaKxmLGPJSrRLRFXMCKzkNjmS0exx/
         BHo43gCa92fr9aVDdXssWK7jxvLxWFZIUHDRdwjBWox7yYRJiUA5tQcOWvVQgDgUDO/C
         ighCstG+AoSgOqRitDLvFCyjXQQMerVZ6hceRQUBPfyEY76Mnc1GcDIB78m+acX6GKVf
         OmZ31t4l3m2NAgpvhUyOgHMR3YzJGkTQschmOXgiwK2C7b4QL90OaxcEG9vcK1Wmvhh9
         HdsB/9vhjlPCbDHx6EujIdjvNp5d/Ftr4cPMWjF1q3UHteoVgqIxxKdPGeeXDxxq2jc0
         Gm3Q==
X-Gm-Message-State: AOJu0YxKZRAXb0fYUHuL8fBjaNcfGOcLnG92sLF3wDcRAybategVnzn5
	Hp4E7Dy9cyIl+AHyt0i2VfF4/t+lEBGgnGY5hJyIIZT/gUTkE+gaz1c/
X-Gm-Gg: AfdE7cma7aFcRZ9HbDQJ/Mo6B/aY7VUmCRHyQC93O2BdMrfDlOWsVtIAfIh/e3tFUIi
	7aK4TGzFNFTWZFSnC2WfIp+MSceRJEcFtnAGukjNQrFeMuMCRhZpVDLybOdl/aFxVn8gj/avu73
	mO7psARbsiRzwhbR2llJp5cPnKH7Y7W9G2uHucg/N7xwLex/fNl/ncPlqFtkJwOYrEP+mPkngTc
	VCUH5Rwx1gV2rCq6tkyT4+vQ2moOYB2IKcmFzUaCdo3LcLAMybUgd68+Kmlf/y7dBvNrmJ4mCqS
	lFtrl+MK5DgYmiTm2tAcpMo3lUYPabdql/VBoZNQsCYrgy3YaeTKjKqqHqCzZ0hmZiLicUNyLfN
	5DnzIb0/5HxRNswm9dvQFvx2JdoeOLBNOQg5wus1ehvRUqf12xeu+Wc7syqp5d4ar7OI57+TI13
	ohWrYGZoxip93gwi76pZ4ohgYRM1jWoKwKKL04i4sOgR8GOgOZQ/9kY7/oQyUP9nPOHPJClfgRy
	kklasSK3GS5EyNxAXjFXV1TmCpKneSowyOelVlh99rA
X-Received: by 2002:a05:600c:190b:b0:493:c77c:108a with SMTP id 5b1f17b1804b1-4954aa1a10amr110737575e9.36.1784476227713;
        Sun, 19 Jul 2026 08:50:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2aa698sm191898255e9.4.2026.07.19.08.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 17:50:25 +0200
Message-Id: <DK2O112CXTEQ.1DTPFZ5ZF4B66@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Preserve unique-field state across
 nested structs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260719153634.2908692-1-memxor@gmail.com>
 <20260719153634.2908692-3-memxor@gmail.com>
 <20260719154924.5C3C31F000E9@smtp.kernel.org>
In-Reply-To: <20260719154924.5C3C31F000E9@smtp.kernel.org>

On Sun Jul 19, 2026 at 5:49 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Multiple BPF_REFCOUNT fields in a BTF struct bypass the seen_mas=
k uniqueness check because is_unique =3D false, allowing them to trigger a =
reachable WARN_ON_ONCE() in btf_parse_fields().
> --
>
> --- Patch [2]: [PATCH bpf-next v2 2/5] bpf: Preserve unique-field state a=
cross nested structs ---
> commit f8de1a7879c048283531a81778eac42891723a9d
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Preserve unique-field state across nested structs
>
> btf_find_struct_field() initializes a fresh seen mask for every recursive
> descent. This commit passes a shared seen mask pointer through the entire
> field traversal to ensure unique special fields in different levels of th=
e
> same aggregate properly see one another.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index e7d4e9ba24e26..c577f00e9d885 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>
> [ ... ]
>
>> @@ -3947,10 +3947,12 @@ static int btf_find_field(const struct btf *btf,=
 const struct btf_type *t,
>>  			  u32 field_mask, struct btf_field_info *info,
>>  			  int info_cnt)
>>  {
>> +	u32 seen_mask =3D 0;
>> +
>>  	if (__btf_type_is_struct(t))
>> -		return btf_find_struct_field(btf, t, field_mask, info, info_cnt, 0);
>> +		return btf_find_struct_field(btf, t, field_mask, info, info_cnt, 0, &=
seen_mask);
>
> [Severity: High]
> This is a pre-existing issue, but since this patch improves the uniquenes=
s
> tracking via seen_mask, should BPF_REFCOUNT also be treated as a unique f=
ield?
>
> In btf_get_field_type(), BPF_REFCOUNT is currently defined with
> is_unique =3D false:
>
>     { BPF_REFCOUNT, "bpf_refcount", false },
>
> Because it bypasses the uniqueness validation, a user could load a BTF st=
ruct
> containing multiple bpf_refcount fields. If this happens, does it eventua=
lly
> reach btf_parse_fields() and intentionally trigger the WARN_ON_ONCE there=
?
>
>     case BPF_REFCOUNT:
>         WARN_ON_ONCE(rec->refcount_off >=3D 0);
>         /* Cache offset for faster lookup at runtime */
>         rec->refcount_off =3D rec->fields[i].offset;
>         break;
>
> Could a crafted user BTF cause a kernel panic here if panic_on_warn is
> enabled?

Yes, but exactly what next commit fixes.
