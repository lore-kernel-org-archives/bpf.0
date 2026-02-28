Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5471D88A4
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238976; cv=none; b=VMKcW67iuxLm2RTkOH64hGreMzqg67L16D5HwPIjfunHNyea+esqt9SQddIdtdVqKGlS8V7ThJHSmzskkdjJiTTf3j4oD7Z7wiyI7V9LLJx2cigY6FIGbjnM4KsfiG15f9nwOkIcR8R446qCuEfI8jlxsMCDnt+ERfBTtIiOPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238976; c=relaxed/simple;
	bh=x0EKizt3MTs8DKvR5iGJ5ivOFMRdEsFtjmpu4YQ4fSU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BX3uM/H2m2kk1+IxUHLz1zz+BbHUYHgBQqNBQD1b2WAcFjoifA50RCxR+x5aZaBdua69HqSaF7z22Kr5nVOR9icFP1tKxv+693BfkYU2pNlpToCWesXpFldx/uZnSyKTpCi3ReShWNpTcl2fxYoYJGTdflM9a86eeuTtyQFa8iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=q/gFOuOG; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="q/gFOuOG"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a297c14bso24345811cf.2
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 16:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772238974; x=1772843774; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWbeSvJT6eB75qqFvwJ/M9Lqy2SaTnkQ5y54vsTVW18=;
        b=q/gFOuOGfYzIqHnuv9hd3ugwfUUkiFJ5UWV6Y9hdc+5LwIsuGprB6kyJ6OqWibseGq
         hAayZVKhHAJGAZnW8UPRzseetawwn9qiRTjWTHEOpsIDcPLJFyIL5mVdOXAwhl6jSWYU
         V2sTinye38cbBayOt+zhQfXUbpGS1vw4wpG6A4G5QEKijkP5zhFhnzl8m3etBqDYV1AG
         FQ0kQd6o4VjtHPugnupyX2OYNNS47gn8OwtNW5ZPnw9jESjZeOgXEcDS0Ygx8B0Ou5tA
         PiGKtvplp+DLgBraUZKuaWUVMalar4IAZUtefbbA2QCjBGCbXq9M3xpEm5kQ+obOooaW
         3gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772238974; x=1772843774;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWbeSvJT6eB75qqFvwJ/M9Lqy2SaTnkQ5y54vsTVW18=;
        b=Yvx2RFKQYJxMnS+3qWTiixveA3ZUvACiNOG5sqltpfBwfoS3CcliMsmhl2YyQPRIFx
         alm1OHJS2hEr8eB48buukau9khBopVbLMyVNgKHysLpWS4YgVQszDjizsQ1xU1TKcOEa
         8oe3kyLNByeN78HHKxbIk78pqHB0bjiizB9plbfNfa5DJa/k6I2zJ4ldSz+xpi1Vag/T
         6yyQUsAlOIOzzQXVho+Pk7r5VMvRuQmGQ+R0e8GI5rvGotAFcONM/s42PuC/IxlVC3lc
         Iv1gfQlfAtVTrp+uoG+oDLLT63PiKLbBP6lSaqvgm2JVvkufz+U45hDZeBJ82UKtlX1y
         bVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlgciA+57Um3yp8YSnPHyKFjhEmNxMcd/BfGAljbOWrEZhPr8nxe22pCdCXCk5w0fRWLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhvCIPtPkZyqicsnMXy9yRuWpyd0B90B3WeXpT6BMgtrtGGYSm
	kpXqLwnGMLaklxs9Oou5DAS3TQnaibbRYzgZroKORmdfzc3MACWP9CEaqlSI4LglyUM=
X-Gm-Gg: ATEYQzwL0ZapjAuZmrCkiqMbqyQWEKcNOtuTBmWU+U4D14YOR81whsRJbl+fWdYYud9
	dunKgMM0MXfbFUx1MPN0aAZ/WTaU59G+EKJtZeSdf5x7X64785q9nWPUi8zNqzkrHluYDfFB1iF
	KB/SfiXQcmPTEAfwEu6deLjGfdwMiW1s3M2KtZGqGstnkt1uZ3BsJCOH8S2cMhlm2LnP4vCL+CL
	yPBzp4Xqb5YoS2PWfvcMYxu9XT7Eu+LBM/ycpTrt3NmwSh6leYG+SH+18xu8QHoxk3L7FEemoBI
	xPMc3ND1fiwxe56XnhuPcGDtTtzRyG1WsXM1k0GXK4CZ1YSdNS8NNCqslH4GpQCpY+Q4hDZTT83
	mZOS1oBjcE3G6oBmvtK26/62Ho8CcxtQu3Uh6SQCXvU9K0PUkSY3fYkL4EzYCS5OPRBo/wRjufr
	rVSa/QtGgQKZAuHzWmQag0qQw=
X-Received: by 2002:a05:622a:15ca:b0:501:52a3:44bc with SMTP id d75a77b69052e-507528c6be5mr58223451cf.23.1772238973850;
        Fri, 27 Feb 2026 16:36:13 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449630absm57290101cf.5.2026.02.27.16.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 16:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 19:36:12 -0500
Message-Id: <DGQ6A8CCLDUC.8XRPLQGSQXN6@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@kernel.org>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 1/5] bpf: Factor out program return value
 calculation
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260227154616.6846-1-emil@etsalapatis.com>
 <20260227154616.6846-2-emil@etsalapatis.com>
 <b37f70d205a6d0f25c4665fa34f6700b6eb4a5fa.camel@gmail.com>
In-Reply-To: <b37f70d205a6d0f25c4665fa34f6700b6eb4a5fa.camel@gmail.com>

On Fri Feb 27, 2026 at 1:57 PM EST, Eduard Zingerman wrote:
> On Fri, 2026-02-27 at 10:46 -0500, Emil Tsalapatis wrote:
>> Factor the return value range calculation logic in check_return_code
>> out of the function in preparation for separating the return value
>> validation logic for BPF_EXIT and bpf_throw().
>>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>>  static int check_return_code(struct bpf_verifier_env *env, int regno, c=
onst char *reg_name)
>
> [...]
>
>> -	case BPF_PROG_TYPE_TRACING:
>> -		switch (env->prog->expected_attach_type) {
>> -		case BPF_TRACE_FENTRY:
>> -		case BPF_TRACE_FEXIT:
>> -		case BPF_TRACE_FSESSION:
>> -			range =3D retval_range(0, 0);
>> -			break;
>> -		case BPF_TRACE_RAW_TP:
>> -		case BPF_MODIFY_RETURN:
>> -			return 0;
>> -		case BPF_TRACE_ITER:
>> -			break;
>> -		default:
>> -			return -ENOTSUPP;
>> -		}
>> -		break;
>
> As Emil points out, this -ENOTSUPP is a bit of an outlier and this
> patch drops it. I double-checked the bpf_check_attach_target() and it
> covers all the cases above, with default being:
>
> 	bool prog_extension =3D prog->type =3D=3D BPF_PROG_TYPE_EXT;
> 	...
> 	default:
> 		if (!prog_extension)
> 			return -EINVAL;
> 		fallthrough;
>
> So, this -ENOTSUPP seem to be a dead branch and it is fine to drop it.
> Emil, did you have the same reasoning?
>

Yes, this was the case. the BPF_PROG_TYPE_TRACING there are places
elsewhere in the code that ensure the attach points are valid, so w the
switch statement above is in fact exhaustive. I will add a note on this
in the patch description to make it clear this isnt't a functional
change.

> [...]

