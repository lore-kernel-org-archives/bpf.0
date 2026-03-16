Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956B191F94
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681842; cv=none; b=JQYneLpFPbQ4fHtBK4hCD8gW8EKneTrIAEn2mc/e8GNvFVA5fJarF4OxiQ1B6QK+WY3J8La6nAvmGBOwB4qRdI6S3VXI78C1UXfma9p6cv+WjPti+mar/RkDw5IjYcebp4yeJdU8pmRTOw5gaNuCBe65Lv9bavj72GWHOP6SL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681842; c=relaxed/simple;
	bh=54ris6FMGBdgM36vkQkToPqFcUAOIpFMjIiwB5Ssw7g=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=VVFEpzlrSqdBzXsj4KqjtpOV8NW/zC2GWubfI625Iirm4urvomXJpF5IB5X7S3+fjlaynCm9RL2+TnukeBTiJ/cyHxML0+YW84U9WC7l5jwY4xH/gZIbBTohd5QSxQlEGx4guLJoSPuC6HUQF74eE91sbNEk7uPeZ323OQ3InvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=FF9BWDHx; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="FF9BWDHx"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cd73c4a827so486221485a.3
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773681840; x=1774286640; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNxNI5oqZZCN58U4yhKJPdXaA+RXMQMQGkHRh/g8B7E=;
        b=FF9BWDHxriSpivwDVlyBFeclWQSzhZHVqKCrTHVLAFTFA8ZJVtT5VdD7rAR2fHKuQ+
         fQgQ8i5F3nr0onPhTlO87K3NpQ9Zfdv7ZJCVHrLpomFZOJXPco90GvWqCmSBStNis9SH
         qFcTfUUzUFzDhvU9SCep8bzvYS+wne7AD+WyE6vPJw8CXQHpKfmqv+z8Vhrex0sa1Sao
         EPLsWYaKXk0SdcW0DWvb9K47KR2LNad9sc7Mu6OXPdlekwDXm2sYxgceas1J1lnkbWRq
         WiNOkkp8waoxmhS0+X1O9QE+4fTdFyUYN7iTZ6W7SvKqtsc6QAT0p1Vp52/m9QZs4xky
         8Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681840; x=1774286640;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNxNI5oqZZCN58U4yhKJPdXaA+RXMQMQGkHRh/g8B7E=;
        b=GT4LIykAtC1lfym3JJroREhtgPULmuji2GWEdlF74bClnWGGif/CPgYhXdj14mcD4+
         D0xvHncV/DCj7xooAnx+fsZOvnG/tdRFCL8nqaCbd/XK46IhxoeUGIwXEc2ki+SCpPmN
         jAcv5CLqV/zSj/uG9jzX6Ht2/MlCFfz+3QeAFMIqvUT/3lVNbrZPD+CbUVBmM9TFdJVz
         5RhcJd9kB9SGWrRcjQIhIM7ClEwyLPMFj+jiuSjUYwYgDn8VWw1JV3/sXe1CuXjO5Wro
         ZBByVprt9S0aILigYUdUKzPZ5EzcMPHROEW5Ci1fnpvZahHFVIBblEjAVkQcIXcpGcJ2
         vM0A==
X-Forwarded-Encrypted: i=1; AJvYcCWGtUX1vvRW0gScKtzWtHcBD+1zmV8TOpKYK3Kbh6/j1mzqVtBCR5fTNU/IaOOgz48UjF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOHIhP6tgBWZqiNHLfYAUWL/egt+wH4o3BK5V4ojI99YZEQRiz
	LLehDYt/GXPk1zqnrCmQ1I6+L+P23sLUEfAAZz9iHNL8BLNFW+eZQFVl1/6v9sJgqpw=
X-Gm-Gg: ATEYQzzaXXouwNUXd/hZ5HHAJctja3HfDGdykxF32ZTqS+WkV1QczLswYoEHFtBXGZV
	Xfl04HhksZu/1sAQAorPsGjC1HoFuIlSzVv6Sfu5+VV0rHjHVZUF363fZfQGnCQx3aM/w+AX2M4
	WyaqtKFN+ZTHjJTST1ccQpNdTR19IQ8asYkzXsGSuf8p2RpG0FnlWlje89j5sv6vTZk6/wqpyT9
	m6jffElCiGp3u1yTY6gyx2BqgNO8m/cjM2c807yQZPLT2oRqKPJXIKtqCCEd0z0SP0lhL3KbPE9
	gArv6POfzjGwlaigOAdBQC+De/QiN9lNkFgPS2jfPznnhsp8ID0hSD/oap+KHO8fOlxagleOBVi
	t//2cVu0HQzQbiCAm9zlG9Rt9PCnov/p6+oH2Kw00UUQmuMqKA+c5vy+OMoFSdZb+p+pOrSx3Ru
	LxjVIRC4RE6gZ/fFfKYQHlG2s=
X-Received: by 2002:a05:620a:a494:b0:8cd:b90f:fc16 with SMTP id af79cd13be357-8cdb90ffcfbmr1276866385a.68.1773681839500;
        Mon, 16 Mar 2026 10:23:59 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fddfe8sm1250715985a.12.2026.03.16.10.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 10:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 13:23:55 -0400
Message-Id: <DH4DQIKUEV42.3U48LSI803G6L@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <martin.lau@kernel.org>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <yatsenko@meta.com>,
 <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Only enforce 8 frame call stack
 limit for all-static stacks
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260316161225.128011-2-emil@etsalapatis.com>
 <65e11260b42493b1261ff79a8d2c408cdbe8a68038bea605e1794f75ff406594@mail.kernel.org>
In-Reply-To: <65e11260b42493b1261ff79a8d2c408cdbe8a68038bea605e1794f75ff406594@mail.kernel.org>

On Mon Mar 16, 2026 at 1:01 PM EDT, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e29f15419fcb..01c18f4268de 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
>> @@ -6854,7 +6854,16 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>
> [ ... ]
>
>> -		frame++;
>> +		frame =3D subprog_is_global(env, idx) ? 0 : frame + 1;
>>  		if (frame >=3D MAX_CALL_FRAMES) {
>>  			verbose(env, "the call stack of %d frames is too deep !\n",
>>  				frame);
>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/too=
ls/testing/selftests/bpf/progs/test_global_func3.c
>> index 142b682d3c2f..974fd8c19561 100644
>> --- a/tools/testing/selftests/bpf/progs/test_global_func3.c
>> +++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
>
> [ ... ]
>
>>  SEC("tc")
>> -__failure __msg("the call stack of 8 frames")
>> +__failure __msg("the call stack of 9 frames")
>>  int global_func3(struct __sk_buff *skb)
>>  {
>>  	return f8(skb);
>
> Should the expected message here be "the call stack of 8 frames"
> rather than 9?
>
> The test has 9 functions total (global_func3 plus f1 through f8),
> but only 8 call transitions, and frame starts at 0. Each static
> call increments frame by one:
>
>     frame =3D subprog_is_global(env, idx) ? 0 : frame + 1;
>     if (frame >=3D MAX_CALL_FRAMES) {
>         verbose(env, "the call stack of %d frames is too deep !\n",
>             frame);
>
> With 8 static calls (global_func3 -> f8 -> f7 -> ... -> f1),
> frame reaches 8 which triggers the check since MAX_CALL_FRAMES
> is 8. The verifier would print "the call stack of 8 frames is
> too deep" and the __msg substring match for "9 frames" would not
> match, causing the test to fail.
>
> The old test with global functions also had 8 call transitions
> and expected "8 frames", since frame++ produced the same value
> of 8 at the limit.
>

Same answer as in the previous version, the test passes fine.=20

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/231546=
16737

