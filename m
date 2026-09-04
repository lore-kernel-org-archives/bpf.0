Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667944CACA
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520271; cv=none; b=kHE/YC1f8a1I3J3VAsU3SFD3X8FuASL6/oE06SXeBFjVUTepu6mUgXOoTsSjviqvzHKmYtxzvmNKfWYL6vXebusRMjQRZ6X2qREh40TWhedgMLLk3lj723MxltFeXCpnBcNvVWtiZRH8o0J7mXJxlhu7Q+gJ1ckeJqUoXrAqIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520271; c=relaxed/simple;
	bh=Z5lIjwfXyvI/AAARw2b8cgSv7SSdEPHER/esN0f2++I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DlNF4RXLj5Uy+yTP2RWG0XkePlwKbtPG6H0UQaeYh5tC+9dfceLewyWoU2b4/ek3oHL5tS8aBeURNV4eYkHPqFtlA4DD5ij/AdcvdY+F4+1olrwCsGtQNMZfJMZN/AjjcKSLTzDlIU/yIa/OSgfgqt4a53Ts01LDTC3DUk9pbss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTOhe+P5; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTOhe+P5"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49add2a23e5so3671705e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520267; x=1789125067; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JqyYlzzJSLXn2Ht9uRHoB8nycGZ7qHQhQ0IIRMTHvS4=;
        b=BTOhe+P53CUgGTe3NMzZG8xJ3h8NCye+OTI+gfQxqIfBYqRfw5CIg8lnU7MkaZAWaO
         QD/1c8NUH9mFZ6YB8rc/n1JikAxSyyoFWoljKQ8saHRFcoHbQQTeA5vrNfx3NkRJw/6X
         jcQ9dmfG/kBKANUwDBlcXSCtrSolDRSD6hWpeWyRNdHR7oUUnuW02Xg8xPHBvrQYg31g
         daS6wSqFDcZXla3ShV6M8enV1nnCdy8HicK52slFTzHLUl194v7Kim0435NvduuW+dID
         4qxX12WFp65rfP4jHvReFaQoRBU7upPht4l1wNhNuZCHXLBsISdsAc3JmVG3bBMByeFA
         naSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520267; x=1789125067;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JqyYlzzJSLXn2Ht9uRHoB8nycGZ7qHQhQ0IIRMTHvS4=;
        b=fSPl73V4O8K5qWn5cxAucjEdCxte1me2u1B87UOTC9hymK+nfc6ZeEgk53MrYF4eTF
         V+yK1TPU3pWUbXxDpbnlGzRWDzPlB+hIKuwU/q/rjBhcg173AVBlvBegvLM4wFroOETX
         WntD3QHitImE2ghfR+mHgYWXCxvwQCEMN9odJ3Y75/wbBuowJRTD2d08BJ5zG2OtHDIv
         rH0pdpsQFsV4kMxsFo30yDba3Or3NirnOTJkQSLnnv3ojWqGCmh55guuO4UMlpMi7hEv
         eP4Og4MGJlYlo4u9Op0meBuzwkBHT5lyoV8/6i5yXj8mOvFmAN32mKFhfF8BZAAnnFsS
         W3zg==
X-Gm-Message-State: AFuF++lYC5OmCP/3Xo8ngKXb2M/oLnL/by4qyKaoicMVeYhZAaAIUN59
	Hi5aXDGSpONaKVT7/MQI6oyh2tVt33gxB16lqf4K9T3j6KAjzd6QmQR/
X-Gm-Gg: AYBFou2T0MNG+MTOrEQz2RnNUGmRcF+U5F2eUUInlCoc6OJYq0MwKS3/Ey9U/iRWqFF
	rivtWj00WpwPzDC5xpD2q0pgjTnpvOmjtQxsymvWkXaM4nEAjd57nKzIvp/ondjvpjM3R39ldYw
	vrlAuZuXaZabFYB9hxqWVfcchzJKvCeBD2TNMiVrtN8IisWHIETxSbbZXgYwx8cDSGxmDoaxRVD
	R0/Eo2jH4fHRggcqq8ZrjHBlIFXoj/Ni6C0dLbbh5lkdxotQfdXJtAKaTTBSwlLaMLgfHjJ7wrc
	SiYNXcsv+gT5R8ks3TJDYqr5Kje2uMaWWQmwCqcF1BGTKyMYpo6KKuDAmtLyJbEqxGs974BNXcY
	IKI82OZjsRqIE8KD805uKvGwbVI3XoFvYONlYbrTd5nDksCZL/nyzI9cKDZYDPu0XMoy11Aegag
	apv8gaO2f3HGifwnrXy+9tB1ZeddSDbQMLA19flElhsJZ9688yjIId5T9DTX0KM+At31rV3ujpp
	I9Ww9R05C4jFj9I7Skiq8e5cyLX8s3OjbrjBWBPanv0tPgNHMpu1iNZUW/Dwrf08v6qqWl3vTH8
	czWSb0iYQXs8Whdm3JidmX8QbxucLyCl9tdhgg==
X-Received: by 2002:a05:600d:8499:10b0:49c:ff3c:973f with SMTP id 5b1f17b1804b1-49cff3c977fmr4086005e9.24.1788520267220;
        Fri, 04 Sep 2026 04:11:07 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885cb03asm5483852f8f.37.2026.09.04.04.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 04:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 13:11:05 +0200
Message-Id: <DL6HIRCS6H45.1323PCUH1EB9T@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf 7/8] bpf: mark the zero register precise for a
 register-form NULL check
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260904083325.2083493-1-eddyz87@gmail.com>
 <20260904083325.2083493-7-eddyz87@gmail.com>
 <20260904085722.7BF111F00A3D@smtp.kernel.org>
In-Reply-To: <20260904085722.7BF111F00A3D@smtp.kernel.org>

On Fri Sep 4, 2026 at 10:57 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] The verifier fails to mark scalar registers precise when `bp=
f_register_is_null()` is used to satisfy a nullable pointer argument or kpt=
r store.
> --
>
> commit c721af04f2965a6636b3260c058c2531da5526e0
> Author: Eduard Zingerman <eddyz87@gmail.com>
>
> bpf: mark the zero register precise for a register-form NULL check
>
> This patch fixes a bug in check_cond_jmp_op() where comparing a nullable
> pointer to a scalar known to be zero fails to mark the scalar register
> precise. This prevents malicious state pruning where an imprecise scalar
> could bypass safety checks and lead to a forged pointer dereference.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 303368460ec10..fde5d046b6e32 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -17052,6 +17052,15 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
>>  	    type_may_be_null(dst_reg->type) &&
>>  	    ((BPF_SRC(insn->code) =3D=3D BPF_K && insn->imm =3D=3D 0) ||
>>  	     (BPF_SRC(insn->code) =3D=3D BPF_X && bpf_register_is_null(src_reg=
)))) {
>> +		/*
>> +		 * For BPF_X the zero is a property of this execution path,
>> +		 * hence src_reg has to be precise.
>> +		 */
>> +		if (BPF_SRC(insn->code) =3D=3D BPF_X) {
>> +			err =3D mark_chain_precision(env, insn->src_reg);
>> +			if (err)
>> +				return err;
>> +		}
>
> [Severity: Critical]
> This is a pre-existing issue and not a bug introduced by this patch, but
> since this change addresses missing precision tracking for zero-valued
> scalar registers, do we need similar mark_chain_precision() calls in
> other places that use bpf_register_is_null() to satisfy pointer checks?
>
> For example, in check_map_kptr_access(), we bypass type checking when the
> register is a scalar zero:
>
> kernel/bpf/verifier.c:check_map_kptr_access() {
>     ...
>     if (!bpf_register_is_null(val_reg) &&
>         map_kptr_match_type(env, kptr_field, val_reg, value_regno))
>     ...
> }

This should be addressed by the following fix:
https://lore.kernel.org/bpf/20260904104203.345917-6-memxor@gmail.com.

>
> Similar bypasses without precision marking appear in several other argume=
nt
> checkers:
>
> kernel/bpf/verifier.c:check_func_arg() {
>     ...
>     if (bpf_register_is_null(reg) && type_may_be_null(arg_type))
>         /* A NULL register has a SCALAR_VALUE type, so skip
>          * type checking.
>          */
>         goto skip_type_check;
>     ...
>     if (type_may_be_null(arg_type) && bpf_register_is_null(reg))
>         return 0;
>     ...
> }
>
> kernel/bpf/verifier.c:check_kfunc_args() {
>     ...
>     if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type))
>         continue;
>     ...
> }
>
> kernel/bpf/verifier.c:check_mem_reg() {
>     ...
>     if (bpf_register_is_null(reg))
>         return 0;
>     ...
> }
>

The rest need investigation...

> Could an attacker use these paths in a similar way to the vulnerability
> described in your commit message?
>
> If a branch assigns a scalar 0, passes it to one of these functions
> (leaving it imprecise), and another branch merges with an arbitrary kerne=
l
> address, wouldn't states_equal() incorrectly prune the malicious branch
> because regsafe() returns true for imprecise scalars?
>
>>  		/* Mark all identical registers in each branch as either
>>  		 * safe or unknown depending R =3D=3D 0 or R !=3D 0 conditional.
>>  		 */

