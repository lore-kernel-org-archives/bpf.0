Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE6248883
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639172; cv=none; b=TROxTliGPSk/XTk6zykpQpCXeDvcvO5syWELbsUKuPEn6HJgLr0c4QKYhxCtQGFwHOPPMy2KaDOWFK5wRNgkJTh5SZWcymf16JMV27LMTzg648KIN+OCEjZfR5iyqRV2fVTqtIBp4sCF7VFpC867cmwdwxcuN2sWGU8iG8cHrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639172; c=relaxed/simple;
	bh=RuoHgyP75uD+QPKYdqYgDPi006nTiRuMKJ7+zmli09I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RHhnP6ZCBKLn4aKCu4VwaFOYJ2oLaSm2LoeGZfde+UVGuzPadk17vMks8KbADqywp68Vs52owIlxpI/JY6A2M+8GIoMvSIWGOLqD4n+Iecx4ZX4wT3/MuJSAtvIVV4s3KqFcLl0q2HlFuYBuMUYlFbsWA/ne/wFR22/UmWSUHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjIh0A0C; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjIh0A0C"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso22358665e9.3
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774639168; x=1775243968; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/T501JA5wTUNFEk/E8pUF4TijbVqI89xKr81COMejWo=;
        b=IjIh0A0CK75Hxg9cxDdUe1aRS2pXC766aZFSgDWVcUfC1qohYKKE3fpfmGuNSFOZ/v
         QExs1xp5V/vxT60PbW++Zrf2bVWZ8WM4jH/nStnfOIUdP+/S8kAeBwinqTL9fijtfQ8Y
         ZMc9RKnIXgwXWKtL5wADfVOZF6ryPyDxGbtx1qOAHcSlEhet2CSzP/P/1FMp56S4M0Dq
         rufdqRvaKzyeZGnAxAn4pvKdOH3ZRLy3ydYWnSxWG+LE3chlVozat9iNMIcOhn0oFbAK
         p0bZW4+SCdYq/phk2p2/8TFp3CsuDv4jMrA2/vIiIO1d0MxDJ+Geid9IOXrD2Jp5m6Eq
         kJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639168; x=1775243968;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/T501JA5wTUNFEk/E8pUF4TijbVqI89xKr81COMejWo=;
        b=DjpCyeAe9fWeKipdSTxx8+fzJNAD5+0ptb8cdGOv0gDKgFRUzYmP9I7AIHe6c/s5t0
         zgR7pgoZRv3cB/mEtlJIg0EKurbBaHexemh7ZSzVc6njwhvu78YJKPfvfhcv7in4Wtrp
         KNJhvGhUhgZMa/LFrbRrKERJUjEzJsRvQeKUI+bqJDxlCZ2M3Xky6eMx20i4iZQYXhT8
         QlBKjitI5BFMmtFuQVVZsrjcxKzjMIaPZVxwPQpz44Udq2ZycUP9bg7zttTxwZK37CZd
         zErKV2ZIFkM6bFLG9T6ZGT585zxUYBGVSad5hPNufDOfwZ5qDQDx+4sm6Ez4hpk7GHkX
         bPyQ==
X-Gm-Message-State: AOJu0YwVE4iwX491c1IK2NEt7Y9bRGBwii+T7OTyW5kNLXaNxrNIKjjQ
	pNpWd4qcJKaqlx5CXACuh8zCy19qkcTHS432JPAe8GgeJtovClIYL4tH
X-Gm-Gg: ATEYQzyjiYNjoLvsph4DeN8Auuw4RcJfA7QyWSKcLTjCJhRGQPflQYeDqObQDAHB86b
	/Zr2hw043XDP8WCkEjcEesI+pJjRqF7OuML6M4NdUX6o++abGzBbmWQu/H02sfF1N7crrGgkj4R
	e8vv7/KMN6QCVWeyOA24Q8Rd5IbYnsGz4Vm5BMqFrc85KM9Sb5v+AiKatBC53sW98d2S8mOu0YQ
	3U1ZQdHaMrGXkHHMKe6R+G7D10oSFdBOusSjTMP1HDOGPD8jb7WdoI2TQHAoFAgldWM12Q34hI7
	IkQEO9/rkfokpkPn383t0Ru80zAfVExY1PO+tWkqB4ltde4shs5gY4D3Xzgw9NpjWH3ZRCAcapz
	EOc1QS1gHfO2AsbTqc8bbcS3OwlmFuU7ss8EaWYRG4eVZXExT18C9FLYQm2ZfTmob17/Tx8p+FG
	trXOaZef+33pN6JdnkzGQHQ2+Z/DQBtOn/eQ==
X-Received: by 2002:a05:600c:8b2a:b0:485:3dfc:57c with SMTP id 5b1f17b1804b1-48727f5fe97mr60687025e9.21.1774639167848;
        Fri, 27 Mar 2026 12:19:27 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487270c3393sm34397805e9.4.2026.03.27.12.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:19:27 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
In-Reply-To: <44cfca58-e524-43e2-9560-2bfb52d7fb44@linux.dev>
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <87tsuajyak.fsf@gmail.com>
 <44cfca58-e524-43e2-9560-2bfb52d7fb44@linux.dev>
Date: Fri, 27 Mar 2026 19:19:26 +0000
Message-ID: <87y0jdgjwh.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ihor Solodrai <ihor.solodrai@linux.dev> writes:

> On 3/20/26 8:49 AM, Mykyta Yatsenko wrote:
>> Ihor Solodrai <ihor.solodrai@linux.dev> writes:
>> 
>>> [...]
>>> +/*
>>> + * A kfunc with KF_IMPLICIT_ARGS has two prototypes in BTF:
>>> + *   - the _impl prototype with full arg list (this is meta->func_proto)
>>> + *   - the BPF API prototype w/o implicit args (func->type in BTF)
>>> + * To determine whether an argument is implicit, we compare its position
>>> + * against the number of arguments of both prototypes.
>>> + */
>>> +static bool is_kfunc_arg_implicit(const struct bpf_kfunc_call_arg_meta *meta, u32 arg_idx)
>>> +{
>>> +	const struct btf_type *func, *func_proto;
>>> +	u32 argn, full_argn;
>>> +
>>> +	if (!(meta->kfunc_flags & KF_IMPLICIT_ARGS))
>>> +		return false;
>>> +
>>> +	full_argn = btf_type_vlen(meta->func_proto);
>>> +
>>> +	func = btf_type_by_id(meta->btf, meta->func_id);
>>> +	func_proto = btf_type_by_id(meta->btf, func->type);
>>> +	argn = btf_type_vlen(func_proto);
>>> +
>>> +	return argn <= arg_idx && arg_idx < full_argn;
>> The `arg_idx < full_argn` condition is not necessary, is it?
>> arg_idx is always less than full_argn because full_argn is the number of
>> arguments in the _impl variant of the function, which is supposed to be
>> greater than non-_impl variant that arg_idx tracks.
>> arg_idx >= full_argn is an invariant violation, not the implicit
>> argument condition, if I understand this right.
>
> Hi Mykyta, thanks for the review.
>
> Yes, I think you're right.
>
> I don't think this helper should error out on arg_idx >= full_argn,
> since that would be an error caught in check_kfunc_call(). And returning
> an error will make the helper a little more complicated.
>
> At the same time, it seems logical to me that the answer to
> "is arg 6 implicit for kfunc with 5 args in _impl proto?" 
> should be false.
>
> Do you have a specific suggestion?
>
Sorry for the delayed reply, just noticed it. I would drop the check, as
you mentioned it should be caught earlier, so it's there just as
a defensive programming artifact. Argument index is never greater than
the number of arguments in the function.
>> 
>> The rest of the refactoring looks good to me.
>>> +}
>>> +
>>>  [...]
>>> -- 
>>> 2.53.0
