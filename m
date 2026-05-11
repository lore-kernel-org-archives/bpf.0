Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47D3D6463
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519240; cv=none; b=rln1hrErJ0Kaz9p8kSr+3h/53gFBt/jAgDtQJEvTcCwS1bM2v//wneaypRj6Rcp4zjHRLDQEIg8VRuFnNF8zAt0VH/ICyFZdXz7mzbtWOlYqMWvMm9ocln76J0tsEk9h1PTfRvGO06FdmGGoIhvcKYS6r49PZ0KbeO+M8rD5Jh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519240; c=relaxed/simple;
	bh=ttyzlAsQV2LCBXMCefThV0JUVjJzRehzxN0uxmPQx3k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mldctw5e2YycF0Q0OjwO5qixBPb9Uy1QNbJjwJ0XI5pvdaRh3MYk9cYpKs735UCdBiPbgtivspBdPQzTIdxrwT6K0DD+HcdU6arw0Tr6T1xo5yrFSMkouLeGchABOf73svFlC/PTh4MR/yltsD8bzYQ4eUMdgsdZDqS5lSvtKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=an9J+f36; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an9J+f36"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43496e6a964so3380427fac.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519238; x=1779124038; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuqFpulg8Nqo7DOFhcbTfsrDVhgNxZLwGvrCkArInQA=;
        b=an9J+f36HD8PwfYW0Ir4GuH815hrAhaeL6N8MUZKQiDRqK1vWyenuvvAXwPim0PZUX
         PBGKfNzNNBuaByPVVsAgiKV2Iuyh2GBFweD7xiIjZwYf0d9KyrYHlS6J57w5vYXDTx6+
         12z/Y/6KYr1LbyL10cW94Qgn+XfnavmdAZEk+dmJRwZPmRoK/IkqLPNsiRi63hGkahEU
         H+iG9SUlhESH4uWHmtiJxuFSygMP2N+Sa4u0Xb7M3MnmpDcaeGqrm7LvvMtgX25rv43J
         F/uJARN3hjZVeQV2R6cVawNxlerQ1J0qfGDXX5cyqN39vNnuDC7taPrEiKmMuEkFcOS3
         /5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519238; x=1779124038;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuqFpulg8Nqo7DOFhcbTfsrDVhgNxZLwGvrCkArInQA=;
        b=JWGFCmeU1U2mis/1gzQsYosQ1vMpFwYHbESmi+ZYOhkGxPDVK38zlFsScp/+T7k53L
         NkPJaofenXkiuOxZsgYQs9XpKfTjxKA7foOpjkCK71ZDJNseHWNmjLbyy141Yhb0sutd
         VI5JZGeROLG5VpaF+/Q5tHVD6UaxNhnUFtZWUFbTkDSOtVFq8Rd+QITM68bbr/WM1ibV
         j/QqMiIuAaSj3Wb5DTfOclBlKmf8uS3IjIJbvKTsdXTAqUOmd8dwzCkgZuVKEQ3NZIbv
         sMSh8YUaL+oYO7gVwQ8/C7flTULowEIQvcuxd6uzi6Z6vVkzWgR+Ippe5MclnC4P6xhK
         BzxA==
X-Forwarded-Encrypted: i=1; AFNElJ/QQairtGzLPvwP2UA4fVYpgr9286b7Gv9Sbo6eqJnuEmb5Ut6rpTjzDk9YkjlL7hMGW5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWG0uI4kjqe/2vIZOI/x+FOKa2mn6C7WGNdeHO65+98Mg8XWZv
	ETgV7tYYXDKghKdAdHINSDjYxx8+qUvJ1X8GCjg4FLj4WgbmMSh6qo+j
X-Gm-Gg: Acq92OF+cbm8smF/3itbaNPtVBrk0+5A7zXlRsB4+je5VQ4zhSb9P+x4Cdcu0v02aKa
	53wdCLIVnXARlXLLlBqS4YhTFAAEXj+hithaJAh3/rWGUvjycg7p+7qHo4LYn4tjZuJ/+wo9kc5
	teDkMjiKKPSpQsN8FQYzNKpe+Ji+FCTwdY35/6w/yO2/yTKKYCyC0rv6rjtx/n8+VqbEBl1/k7y
	1Tcgnb2FNg27a03RwOSvFvP5qGj0dluXw/it0kGOEeTV4Te9E2Bx3XQroAxCQPDfXbcEk1Iu+Co
	BeLA28aVe7S3Ll1TeyPNEobWvMSMM20+d7Zh67M2q5v+3NRVT3QbLA75vouFb7gVRovfSAH4KZj
	oEUVeBT2pK+MgQLSJDlbjREpzmzT+wAF4ytnONWUTDRtOanTaVRXXMIjgT3AgbE7CJ9Hoz7PekX
	C2wb8oF+njsF3BW0xDHKzjUXWLBR6Ibc6hA2aaO6+qUN1tsKfifznn0W/bBvLgyjoIq2LezJBN4
	O/p8MWxb0uh244d1pHGe848dG4=
X-Received: by 2002:a05:6870:5119:b0:433:ffeb:4525 with SMTP id 586e51a60fabf-434f66bae6emr15403715fac.26.1778519237637;
        Mon, 11 May 2026 10:07:17 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43557109b7dsm9702493fac.5.2026.05.11.10.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 10:07:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 10:07:15 -0700
Message-Id: <DIG0G9IFXF42.3O4K6XV8RGQBG@gmail.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
 <andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
 <sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>,
 <shuah@kernel.org>, <brauner@kernel.org>, <sforshee@kernel.org>,
 <yuichtsu@amazon.com>, <aalbersh@redhat.com>, <willemb@google.com>,
 <kerneljasonxing@gmail.com>, <chen.dylane@linux.dev>, <yatsenko@meta.com>,
 <memxor@gmail.com>, <a.s.protopopov@gmail.com>, <ameryhung@gmail.com>,
 <rongtao@cestc.cn>, <linux-kernel@vger.kernel.org>,
 <linux-api@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>, <martin.lau@kernel.org>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v13 6/8] bpf: Add syscall common attributes
 support for map_create
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260511152817.89191-7-leon.hwang@linux.dev>
 <fad54bcc2f9363f61cda44680e7189ad7a510d81dc52f444a4c30a3fcd37df1d@mail.kernel.org>
In-Reply-To: <fad54bcc2f9363f61cda44680e7189ad7a510d81dc52f444a4c30a3fcd37df1d@mail.kernel.org>

On Mon May 11, 2026 at 9:19 AM PDT, bot+bpf-ci wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 8433430dedb7..c15a4c26a43b 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>
> [ ... ]
>
>> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
>> index fd12ad5a0338..62fe6ed18374 100644
>> --- a/kernel/bpf/log.c
>> +++ b/kernel/bpf/log.c
>
> [ ... ]
>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 2fa05ba8f161..54b43e16848a 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>
> [ ... ]
>
>> @@ -1611,6 +1632,31 @@ static int map_create(union bpf_attr *attr, bpfpt=
r_t uattr)
>>  	return err;
>>  }
>>
>> +static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_=
common_attr *attr_common,
>> +		      bpfptr_t uattr_common, u32 size_common)
>> +{
>> +	struct bpf_verifier_log *log;
>> +	struct bpf_log_attr attr_log;
>> +	int err, ret;
>> +
>> +	log =3D bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common,=
 size_common);
>> +	if (IS_ERR(log))
>> +		return PTR_ERR(log);
>> +
>> +	err =3D __map_create(attr, uattr, log);
>> +
>> +	ret =3D bpf_log_attr_finalize(&attr_log, log);
>> +	if (ret) {
>> +		if (err >=3D 0)
>> +			close_fd(err);
>> +		err =3D ret;
>
> When bpf_log_attr_finalize() returns an error (say -ENOSPC for log buffer
> truncation or -EFAULT for copy_to_user failure) after __map_create() alre=
ady
> returned a negative error (for example -EINVAL from CHECK_ATTR or -EPERM =
from
> security checks), does it make sense to overwrite the original map creati=
on
> error with the log finalization error?
>
> The result is that userspace receives -ENOSPC or -EFAULT instead of the
> actual reason the map creation failed. A user with an undersized log buff=
er
> might retry with a larger buffer expecting success, when the real issue i=
s
> that the map creation itself was rejected for a different reason.
>
> Looking at bpf_check() in kernel/bpf/verifier.c (around the verifier log
> finalization), it uses similar logic with 'err =3D ret;' reassignment. Ho=
wever,
> that doesn't appear to have the preserve-original-error comment that woul=
d
> clarify the intended behavior for this scenario.

I guess sinle line comment wouldn't hurt.

>
>> +	}
>> +
>> +free:
>
> Does anything use this free: label? The only exit path before it is the e=
arly
> return for IS_ERR(log), which correctly returns directly since log is an =
error
> pointer and doesn't need cleanup. There doesn't seem to be any 'goto free=
;'
> statement in the function.
>
> With -Wunused-label enabled by default in the kernel build (part of -Wall=
),
> this will generate a compiler warning. When building with -Werror (common=
 in
> CI configurations and allmodconfig builds), this would break the build.

good point. pls fix.
