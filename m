Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D43644BE
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375894; cv=none; b=BoKFDCsdPo9ggzgKstWgmahBq0qgWl+Z3HFGNJ90UrA85jU8hH5HShZbfJA/RBTSind+t6Dwc75BU37vDwpoOFunTaWdxnKNt8vepP2O203uYVQgIe825BYQy+VkJvELJO5CvpqTFVIdcXwBEZtH+4pCwozzA6B9YvoG5/9EPK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375894; c=relaxed/simple;
	bh=//y/MIu9uR/LXkr1muCyOtxg09cxnF6FAzBp8EMUteQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WYJaokZa2+F9CxOA1iqaLbcC+LpOF0WT33j/WtQywFw7p7ZeW8STnsH6BWh927dakBBSF0z3UjjPPxICWgSMwwlecka89TTqoLIvCbHSVHAX5EaslPanVrupkcdcpoX1DSGmWYT+GhVl80usnaJjG6syDhyS8m7VuIvtKv5Ee5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRhRV8UT; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRhRV8UT"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48db8366c3aso781082f8f.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 19:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375890; x=1792980690; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yq8r18auL3kyxH5XJ1eYj6G//xk8iEfWZvNxcHJYvp8=;
        b=cRhRV8UTKjp0aYhPh1u41Vx0vtHfj8nnQMOwrr1O98qJVE6BD2eB74ttimU14GGMr8
         9jEf38B6P9xA1Waf96Xut3ba/WCZfQuG0Tq9wEA9ziVdo2RtCtFbnxCRet4SaHsnE/TD
         NXQqiR+FFTdGpujKNSXyXFnSwigeXBLn5rgsMxNdTPGVa1i72pkolKhHUzA40PA7YTmZ
         aK94AgsBw9RA/bFCfFLRSDH4/4t8RdVqQ7+8HLxH+wV9rJMtCgo/5cw+JrbwHqkOykbz
         ctOoeJUUd7G8cOGMDkG0XKjTJ+rLnTge/0FtQ/fInCyeBUTeNBGy6jqfVWxLUsrPJhEQ
         Y1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375890; x=1792980690;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yq8r18auL3kyxH5XJ1eYj6G//xk8iEfWZvNxcHJYvp8=;
        b=Ww8XNXNXhJ/SNL2kyxhHuHAVSUwE3kpn8R5AHCANvJ1Fuocj5TH/+ttNJ/a81N3TIo
         GzyjGKZ0AV1F+OQgsPERiK3PYEje5idMOKhDTiLf3ijIeKSeCRJ0ywVbUKCnhVojAqyG
         4oWLML0VV8Hs76UIvByTGNS3kvDE0Zh6yGCNae4UDdIEgfNIgYJ6RZVHqSEsEUI4NlHn
         fGrZy4tt3ENP/MmFz3bvVyuoR+w0kmDoZpxYDDv9ihuI7t13/h6P4PIpQHb9djn5WUbp
         XTpuHQ3Vy7Ci9fYQ7xdyXWKDOqoFOYFRaXtX2e2ym/vCEpqAfzIWratm8A+Q5+bdvfgw
         VI5A==
X-Gm-Message-State: AFq9FYK0Hzgt5dgzJMT4NYcrVjZYr+W7l+3eBGBrN/PwgLrQCFeiIq9p
	53umy9neJslb/UDqszkbYTIjKvVT0c2g6M86X1O5UjS3XQqsofybT8c+
X-Gm-Gg: AYBFou1UCTOn49Hnf+QJq/5NmjeqI+qCcYNghZl/23crURklMJlAMdMgBSLQEEXweIx
	7CLG9j103ovDaP+eaV0q1M1ZlY1e3SAqf/6mB0C4cThgs7gY5D2JVPsW3l6Tj9nG0poUF0L8l4Z
	1V4XR4LJWg76hXOiwTJtDweukT+Id6m8pdTV7HzZkDY1s8UpX2MecwMcWM6lw5hggsj/vtVkoji
	SKlPtr0gebNCsv0BZDUrzULlFI4Nw8B0OFwR5HlvHfNXswHYH8G/v9+Btsnp50JtngCttJloMo4
	Gv04Xgbk3bgi8BCLRvEo6zJHSRFLpWBri/IR6MN1WclCbDgHrtIOwQODRbfRPAlvd0i5q+9Vx/r
	5DNY3/QN6zIrm5hE6pHrWVF59KZBH3TPhj0INPy78W8scDzYgTcQlxDM6xCezUzKVnloQqzsWTA
	RWcTruobnZ6Vakuhak1cBAxr8z9mRuqAwlrPobeomRSB+Y2RnJy8AVDLpuUPSSmHuhvLJ96MISP
	AX4TEsKMOMcriXXIEMXeWquUHWohMFGP1Ig5dUiKLui7qrWiMz36Fyxq7vNo1k4rt3M6HMQ1XMX
	FXi5yjI2Y455MSLQQITDvm6EZnyTnZ22zier5KFdbJKNiVCG
X-Received: by 2002:a05:6000:1050:b0:48d:ecba:3cf8 with SMTP id ffacd0b85a97d-48e07fa82f3mr8841415f8f.43.1792375890233;
        Sun, 18 Oct 2026 19:11:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5b2dsm21520294f8f.31.2026.10.18.19.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 19:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 04:11:29 +0200
Message-Id: <DM8G84CGPV1M.24HT5CS3KKB9F@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Enforce trusted BTF ID argument
 provenance
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Yiyang Chen"
 <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: aerc 0.21.0
References: <20261007-a3-arg-trusted-v4-v4-0-253ef3a1a69a@mails.tsinghua.edu.cn> <20261007-a3-arg-trusted-v4-v4-1-253ef3a1a69a@mails.tsinghua.edu.cn> <sashiko-outbox-163202@kernel.org>
In-Reply-To: <sashiko-outbox-163202@kernel.org>

On Wed Oct 7, 2026 at 6:43 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf: check_func_arg() allows PTR_UNTRUSTED | MEM_RCU into KF_RCU=
 kfuncs
> --
>
> commit 1e71cf476e59d8805f3765efcab69f9c9d9bba4a
> Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
>
> bpf: Enforce trusted BTF ID argument provenance
>
> This commit modifies the verifier to make the provenance check contract-d=
riven
> by marking generated BTF ID kfunc argument types with PTR_TRUSTED and exp=
licitly
> adding MEM_RCU only for KF_RCU kfuncs. It uses the normalized type for mo=
difier
> checks while reference lookup uses the original register.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 353bde9ae2274..a0ab793f041d8 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -9605,8 +9614,10 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg, u32 slot, u32 p
>>  			}
>>  		}
>>
>> -		if (is_kfunc(meta) && (!is_trusted_reg(env, reg) ||
>> -				       bpf_type_has_unsafe_modifiers(reg->type))) {
>> +		reg_type =3D reg->type & ~(arg_type & PTR_MAYBE_NULL);
>> +		if ((arg_type & PTR_TRUSTED) &&
>> +		    (!is_trusted_reg_type(env, reg, reg_type) ||
>> +		     bpf_type_has_unsafe_modifiers(reg_type))) {
>>  			if (!(arg_type & MEM_RCU)) {
> [ ... ]
>>  				return -EINVAL;
>>  			}
>>  			if (!is_rcu_reg(reg)) {
> [ ... ]
>>  				return -EINVAL;
>>  			}
>>  		}
>
> [Severity: High]
> Does this allow a register with both MEM_RCU and PTR_UNTRUSTED modifiers =
to be
> passed into KF_RCU kfuncs?
>
> If a BPF program loads a pointer that is marked as PTR_UNTRUSTED | MEM_RC=
U (for
> example, when loading an __rcu pointer embedded in a union) inside an RCU
> critical section, and passes it to a KF_RCU kfunc:
>
> 1. The arg_type has MEM_RCU, so the first inner check !(arg_type & MEM_RC=
U) is
>    false.
> 2. The register has MEM_RCU, so the second inner check !is_rcu_reg(reg) i=
s
>    false.
> 3. The validation falls through and succeeds, even though the register ha=
s the
>    PTR_UNTRUSTED modifier.
>
> Since check_reg_type() bypasses the strict compatible_reg_types check for=
 kfunc
> BTF_ID arguments, this appears to leave the verifier without any checks t=
hat
> would reject the untrusted modifier here. Can this result in untrusted ga=
rbage
> pointers being used as valid RCU pointers?

Yiyang, could you please follow up with a fix for this corner case as well?
Thanks a lot for the existing fix.
