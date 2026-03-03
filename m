Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56974370D42
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560551; cv=none; b=ifaIyoyan7mU7ODLiXBdT1r9XWG1iKv1U44M3h2V5tuMRWCCHCkGONPOmq1clwcOtZVBt3Aa64GJuh7yshHeISY5EDmCaY6rkUQA2f2CINm/1o8c0PkTzPQpVTgOBlkSnisuhb8uOuPYBJ7NMiEkR0KdL7Bx6P2hjbt8D0VbNH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560551; c=relaxed/simple;
	bh=iX1r/evUT5Ltt0UCxsWL2KW6uGAp85JkBQ665+m8YEU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=D0S3IEw2+0Upt13xe3nhubJp3z75/G3In6vxI2J5FPNwC5XadKuK3prPGNDbaA4KJHma0BiSnwYl9qApUDXQzdrqvkWcxhKCbuBzE2C0wWajyCpitUjXffgN5K4OsH/Mk2Y121T3E48xrhUXliys8H8mAZaM3lR1PnGZ95/hGPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=gHlOdbVr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="gHlOdbVr"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506989e8516so51903341cf.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 09:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772560548; x=1773165348; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yD4By+bH7WibSaFooaGX3ujJqPS3almPzjEzcBoMmD4=;
        b=gHlOdbVrxXMIfolN56opP/Wl1N81xjk1YLbltNsD68z9Dqj+W8DF1E7hS5yv24X8tu
         IZG11wXit5m9TiHppShPs2vtO4CoveSdxrwRofphNPYnzEfc7rPobTQs+29i/74twd5b
         7BL9EPnF7ve4whpTP76LYzciijyDtAL5NPybXEIvIAZts6DC44KRF9Tim940xUIhMavJ
         mUzoDcv6AG6N1Nbg1S4wGnjuED2g8ro1oSYcJd4IIduGRVc4vOYTbEejotth+alw7Gxs
         yazZi40bEDa1gNbCEllSXBY89ACubNcQs6Bq7zYACNZmPthsqT4QWMamA70kI/pyFCPM
         6uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772560548; x=1773165348;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yD4By+bH7WibSaFooaGX3ujJqPS3almPzjEzcBoMmD4=;
        b=h3mDaI84I8SIrzSAcacV3shSHYZ9iqfFqFD30ivUFkQ23gsJQ4L6zI6cl6dnjraq1t
         f2+t7tvRuBTqSCudPbP8T/hiRSPCokDtYPx9DEkh/JCTYjR/ULzEBMC3I2IL1Y3YS9gr
         0QzUsw6RM2Le0POJFsPPhuZIpLBrPs2gReqyxj3e3QS/LmstIXXW0EC7as7PeYUiujmA
         3cl8J18DjdvQvBl5xIWMzgG+5Uki0WEJfesZR0kXBVwG3zwMlwKIuGfNfavJttLf4Vuk
         x+IpTRZHXFj5moEEvZetMX4fv9jgWUqNRaOKCpBN2RCwdDr/mYqrZ2KzdomAU+BmsaXA
         RQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCX2/mzos5AKnmvKpNf9vspHm+NomR/n3h3qljCHM3wHbeGQDZQJC38O+5S/0R+Rv1HeWSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKNDyCjZDqY6Tbx+ibDi8t2QlUeJp8YkI1FzEkLDDeV+V9QquJ
	HVBGP9GlXfYcD2KVScqIeWYiUHHMiXpQ37yPPswA/mM37h0cDwH4Pgjx6/kSOg3qPcM=
X-Gm-Gg: ATEYQzwRaqobnj2cJn/gXGEkxk+5s6Vf9EG+uWpu9hQHqVrP/1XlnwWYHl08RVb1GBE
	/2uV9ewd1vCQv+Tg3HWu0d8JItSgB9psvpOL6uEx+LkGcf0iX336ut9ewSb4oxadP7kuisWy/DJ
	po45AfHgfQqlmjxwsjMvKZeRXX/Wv5BMjeR77/HdTWSG26yRjP6C8ceLDfKelZeU+N4QSuMCF3g
	qv06PvxfinjZh7gMsF9zjIVMqJe9DwiODpSPMrULFDqVaGDO/YyJbThbMWZ0bAIuPXTflYQcBwQ
	/vHdcLwW1wZIA2UkQ0vxGC7We1ew2Dr4DvJ2/FIQHArWAEr1vCCfWHEZ4D407G4+1S0eoIz9Zfn
	+Rpt9ZFQnkXIWo7tq4HbCrihOWaUcdFn1eQ81GIuD95GcpfcjSQPlq9fB53Rs8X0BbcXeD66k+V
	pm3VHuhQb7BXtTEgnn2s0tV7s=
X-Received: by 2002:a05:622a:1921:b0:4e7:2dac:95b7 with SMTP id d75a77b69052e-507528fb924mr201054501cf.37.1772560548076;
        Tue, 03 Mar 2026 09:55:48 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449a66f1sm150802551cf.12.2026.03.03.09.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 09:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Mar 2026 12:55:46 -0500
Message-Id: <DGTC9T9RDS7A.1SDL5SFC9SKZQ@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <martin.lau@kernel.org>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Only enforce 8 frame call stack
 limit for all-static stacks
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260303043106.406099-2-emil@etsalapatis.com>
 <ad397307a9cd76c9739ee05f4642c7b6a881b7dfb8a2facefa6b2062ffe328ea@mail.kernel.org>
In-Reply-To: <ad397307a9cd76c9739ee05f4642c7b6a881b7dfb8a2facefa6b2062ffe328ea@mail.kernel.org>

On Tue Mar 3, 2026 at 12:13 AM EST, bot+bpf-ci wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -650,6 +650,8 @@ enum priv_stack_mode {
>>  	PRIV_STACK_ADAPTIVE,
>>  };
>>
>> +struct bpf_subprog_info;
>> +
>>  struct bpf_subprog_info {
>
> This isn't a bug, but the forward declaration above the struct
> definition appears unnecessary.  The new fields (ret_insn, frame,
> cidx) are all plain int types, not self-referential pointers that
> would require forward declaration.  Is there a reason for it?
>

Ack, it _used_ to be self referential and I forgot to remove it.
Will fix.

>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
>> @@ -6799,7 +6808,7 @@
>>  		if (subprog[idx].has_tail_call)
>>  			tail_call_reachable =3D true;
>>
>> -		frame++;
>> +		frame =3D subprog_is_global(env, idx) ? 0 : frame + 1;
>>  		if (frame >=3D MAX_CALL_FRAMES) {
>>  			verbose(env, "the call stack of %d frames is too deep !\n",
>>  				frame);
>
> In the selftest below, the expected error message was changed to
> "the call stack of 9 frames", but this verbose() call still prints
> the raw frame counter.
>
> With 9 static functions in the chain (global_func3 + f1 through f8),
> frame reaches 8 when entering f1, and the verifier outputs "the call
> stack of 8 frames is too deep !" -- which does not contain "9 frames".
>
> The MAX_BPF_STACK error path was updated from frame + 1 to a cidx
> chain walk for total count:
>
>     for (total =3D 1; subprog[idx].cidx >=3D 0 ; total++)
>         idx =3D subprog[idx].cidx;
>     verbose(env, "combined stack size of %d calls ...\n", total, depth);
>
> Was a similar update intended here?  Changing frame to frame + 1 in the
> verbose() call would match the selftest expectation and be consistent
> with how the stack overflow message now reports total count.
>

No, that one should still be either 8 or 9 (see below) because it's the=20
actual limit - including the global frames in the tally would be confusing.=
=20
Maybe the right thing is to adjust the commit message.

>> diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/too=
ls/testing/selftests/bpf/progs/test_global_func3.c
>> --- a/tools/testing/selftests/bpf/progs/test_global_func3.c
>> +++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
>
> [ ... ]
>
>> @@ -5,56 +5,56 @@
>>  SEC("tc")
>> -__failure __msg("the call stack of 8 frames")
>> +__failure __msg("the call stack of 9 frames")
>>  int global_func3(struct __sk_buff *skb)
>>  {
>>  	return f8(skb);
>
> This expected message does not match the verifier output as described
> above.
>
> Also, the function header comment for check_max_stack_depth_subprog()
> currently reads:
>
>     Since recursion is prevented by check_cfg() this algorithm
>     only needs a local stack of MAX_CALL_FRAMES to remember callsites
>
> The local arrays ret_insn[] and ret_prog[] have been removed in favor
> of struct fields (subprog[].cidx, subprog[].frame, subprog[].ret_insn).
> Should this comment be updated to reflect the new approach?  The v2
> patch did update this comment for its design.
>

It does though, all tests are passing: There are two almost identical messa=
ges=20
in the verifier that report off-by-one different numbers:=20

"the call stack of %d frames is too deep",  (setup_func_entry)
"the call stack of %d frames is too deep !" (check_max_stack_depth_subprog)

The one triggering now is in setup_func_entry inside do_check_{main,
subprogs}, so the number of frames reported has changed. Expecting 9
frames is consistent with other selftests.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/226086=
83847

