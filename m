Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3FD430BBA
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772312821; cv=none; b=iqOi0rvwuL1zy8J9zv87A+wMqNgb46kYDSKqLLn4xheNxCP5kFALHmYtjZ6Gat6k5K2tmBbkSjDQ2DhaL1s/81Taz7tLKnvuR/aBs7yRMOkjlBtyrhNrVyQFJmJiaX8Qju6ZZ0aZEfywQ6kTiIAzLiMVgMlyecVeoNWTT6eo8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772312821; c=relaxed/simple;
	bh=FB4DHMBKNXxMWt+FvJS1CsV3wmp5anuqM2ntvuK0hmE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=mbLHMQqh7qv81UVHlz6JHER9ewbMnZOxxoNfGYY8NPdM4RPwNo0+yyk3mCoZXw26/5+mrQYx90Te9aY/gKFOgS4mxOBcRzxTJtY/l6L5LHCf1sxQUlGWmmydwwyXdtP4/vk0CJxvDRjBeZmKfc+vjAFPE3sbH0TILoXBw/gtnR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=XfT5l2rV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="XfT5l2rV"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506362ac5f7so30197861cf.1
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 13:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772312819; x=1772917619; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1oev8RBR8czBMQBlCf2VPs0jAd/1vkuUYtA53PVss8=;
        b=XfT5l2rVPdhXlhAh2HRXog99Q0SklhKtnv/XDTwuWFrx0T02j5K0GII3/CAPEA+WrE
         TAmKbQsIdcnrMbTYk8IRUOdFNZMrsHZHw662N5TsNcOGS7Mo5+o0HDo6vFiOO9xSUoX1
         Z0IsKwIur9PzmEGDKJ+cXeEfi+0g7t/KC5b/vvUsD5uYt0WhDfEU9Noh/a9TiTWqUmMY
         anroNxGebXjwe1idsvyLJTz6fP8CabS8EMyBJRGmOsMYPaNmxfW3QnzHugqh4nQG3yMD
         KruZRGLxQnXNsfznYFIDFLQYAWlNGq+Z9UYs9nsToksTNE608/Tx92L344ptp4+Gdfha
         CIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772312819; x=1772917619;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x1oev8RBR8czBMQBlCf2VPs0jAd/1vkuUYtA53PVss8=;
        b=ZT3kh5CfPuo0gTNOZmslTcuIIA9KOaxrGOK/ySuAIMJAuUNrOjwewpolDwelHMNhvC
         GNj32BXRNaWvECfPSfc4EOsWkCR1CLlh0+k6kb4LKGOmgh9hg8xJusf4tdpiml1oFU7m
         kpRAYE8fkAi70Jxj1xC0PqkTf20RMeP3v3SWEqN/i3L9mREXWJPrh2/v64GL0loxePiT
         tT1Gcrzt1MRx/NuWT6zGHApl191OmzBZPPp4WFhF6932zUQWzQ5IU4F6CB6aXvHhpdaX
         YPjNZlE9zC/KvDPEGt7s6D2QfJzKx7PQQTbwqgwaoeGJ6X2SP3/G+y/VgQynOWgQhgB7
         d40Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCJFZmEG0MZg857DOk84vPMTrRWXi0Xk4yD1VhKSeE4iYD3lpEg+tFzZL49Db4uiexZm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQotcYKniMQNNu+pZvkOvdbqgHfrKIVLB+GsRZvLvEqkKNMG1X
	j17h6h7Ywuv0u9C0KU3ssFAyzxv+rKg/Zii0E5DQDqj9oREL2McWX2oDg9yRcU+sGVU=
X-Gm-Gg: ATEYQzxFZkYUzZ+vArGzjZk7eVNhTsGaNPPkQvV+fqOSOdhSGVsqi/z4ew4Co+7qtoZ
	Y59neMwBK/3O/RTJJmU8vycdWoUnfm/Y2IQ1vCegGEtKANpFtCoRjE04wyZx1koiPXMnwwXXHTi
	6nH+GUrSc96GRwdVcva/fnjlE+Bl+Ppxy+p0wLXi+uvuho1V3AYvVy/c1lrHdgWILXV07RH53rr
	QwvdzDCXBQAunF08ssMxsbyPkibC0iA7rMluIKZrU0WvKDVREjARIB6YjzyaEi0VkSeoVxXvjp5
	NCPEvev/EZeZ7dr2PdHMi1stKiRiOHSu+2qq7PYxvykv1uFEPjMmipghOoidCatU1IZAWzOi9oo
	oBBaXXw2rhKCpYwEVXZdA95HanzTmYU6A0p0Ekyq5Q/tubObNJJVyRNoGsm5rhomwFpX356t9SI
	oehvbzBS7ytdWQRRSfTJVI9pg=
X-Received: by 2002:ac8:5d0e:0:b0:4ec:eecf:66e4 with SMTP id d75a77b69052e-50752714848mr96149201cf.7.1772312818863;
        Sat, 28 Feb 2026 13:06:58 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744afa7d7sm73072031cf.32.2026.02.28.13.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 13:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Feb 2026 16:06:56 -0500
Message-Id: <DGQWGJOKPUN9.2N53YPANBDJ8Q@etsalapatis.com>
Subject: Re: [PATCH bpf-next v6 3/5] bpf: extract
 check_global_subprog_return_code() for clarity
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <martin.lau@kernel.org>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.20.1
References: <20260228184759.108145-4-emil@etsalapatis.com>
 <9014655d9498ca02086847eec5b1f50737bc3de06999b3fecd9aa67345b98cae@mail.kernel.org>
In-Reply-To: <9014655d9498ca02086847eec5b1f50737bc3de06999b3fecd9aa67345b98cae@mail.kernel.org>

On Sat Feb 28, 2026 at 2:45 PM EST, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 80b6fb821456..ebcca81ccdaf 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
>> @@ -17987,15 +17984,6 @@ static int check_return_code(...)
>>  		goto enforce_retval;
>>  	}
>>
>> -	if (is_subprog && !frame->in_exception_callback_fn) {
>> -		if (reg->type !=3D SCALAR_VALUE) {
>> -			verbose(env, "At subprogram exit the register R%d is not a scalar va=
lue (%s)\n",
>> -				regno, reg_type_str(env, reg->type));
>> -			return -EINVAL;
>> -		}
>> -		return 0;
>> -	}
>
> check_return_code() has two callers: process_bpf_exit_full() and
> check_kfunc_call(). The new dispatch in process_bpf_exit_full()
> correctly routes global subprogs to the new function, but
> check_kfunc_call() still calls check_return_code() directly
> when validating bpf_throw() arguments:
>
>     check_kfunc_call() {
>         ...
>         if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_throw]) {
>             ...
>             if (!env->exception_callback_subprog) {
>                 err =3D check_return_code(env, BPF_REG_1, "R1");
>
> When verifying a global subprog (frame[0]->subprogno !=3D 0), the
> removed block would have accepted any scalar R1 and returned
> early. With it gone, R1 now falls through to full return value
> range validation.
>
> Could this reject previously accepted programs? For instance, in
> a struct_ops program where return_retval_range() returns (0, 0),
> calling bpf_throw(1) from a global subprog would now fail
> verification where it previously succeeded.
>

This is accurate, but this change of behavior is actually a bugfix,
not a regression. Eduard, can you confirm?


> The cover letter for this series indicates patches 4-5 may
> complete the bpf_throw refactoring, but they are outside the
> provided range.
>
> [ ... ]
>
>> Both main progs and subprogs use the same function in the verifier,
>> check_return_code, to verify the type and value range of the register
>> being returned. However, subprogs only need a subset of the logic in
>> check_return_code. this also goes the way - check_return_code explicitly
>
> "this also goes the way" -- should this read "this also goes the
> other way"?
>

Ack, this is a typo (my typo, to be exact). I can fix it in a next version=
=20
if necessary.=20

>> checks whether it is handling a subprogram in multiple places, complicat=
ing
>> the logic. Separate the handling of the two into separate functions.
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/225270=
94257
>
> AI-authorship-score: low
> AI-authorship-explanation: Grammar error in commit message and iterative =
human review process across v1-v6 suggest human authorship, though the cove=
r letter notes AI assistance on a different patch in the series.
> issues-found: 2
> issue-severity-score: low
> issue-severity-explanation: Behavioral change in check_kfunc_call bpf_thr=
ow path could reject previously accepted programs, but the impact is limite=
d to an unusual code pattern (global subprogs calling bpf_throw without exc=
eption callback) and is likely addressed in subsequent patches outside the =
provided range.

