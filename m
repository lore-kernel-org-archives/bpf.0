Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A122156B
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772239192; cv=none; b=mYb0Zxe33g2Oac1h59YuXavXd4phSdEMm5ZQG6VBAdcqgGAJQFwbicQNm47d5rtcP5jcHfhm+zgdRatr49KuqbCbWtQji+SlwR4bIeqGOtRQQgVWmWdpG2MdQSKUzEPJ4w2ooC4KykQlXCowELcZ0f3LzE5PuWuNWTEGR1r4rzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772239192; c=relaxed/simple;
	bh=xBehy4ODwyUHNzC3P2IfQNzMqEEQCOa/bPWJLiUEpJA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=m+Ht1cBRQCFj0+RiyRgn47YPx8npIcjaWyPzkY3XByL1JP82MOjlmxPZAvwE4pLSFKk/Axp6qasTAnGO8LoGsPStXduTiLn1UlwBUk6d1kbF6oRH/Z3+id7Rall5xwk/JImYjSqk0uzvhjmp+WUNInJ7LkX8zv8PVtVAY0QgOLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=WS886Su3; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="WS886Su3"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899c97c5afeso18463856d6.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 16:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772239190; x=1772843990; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFznE7hlsWHN6W2G4Qs4s4oJLY40W1s4OuO+ySU+NBQ=;
        b=WS886Su3hYWkc6Z+yXGAvbaBbRUVk81h7Iipe9Mt7VFSsFEoyhfGDPeEqOdaGOexOh
         D6Xvv33G+5IYaJe3wSBByHb6SdQaEcvRdDDolnQ6I69eFfgsAZQl+w118zIHszDxSO8C
         gKDZfl5wdl1+5lkwmFUwDBM5C4n+8AvIoL3HBYY20bovH/LsQb4DJT71pXALudT5utvU
         ytTkB0N85UhepA07ejzXM3nHdTdukhqzcZUT5p2sIe0aJU8FWgKxTYau4dY7zFSNG3iL
         Awop1Z5KSytR87ZWYRxCjwgMc1TaZMhdr/eAMtx0oBohr4UIs1kiqeyIZHn4LcybqtNs
         v9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772239190; x=1772843990;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PFznE7hlsWHN6W2G4Qs4s4oJLY40W1s4OuO+ySU+NBQ=;
        b=KqqIIPTx1njhPX3gIeDyIKB2v+FiatXhZuo0W/21Wmdvg9vhHQ2KchFMThjvN8YiAm
         VZ7fKeMlp0TpuxMYd+xssmCTJzhYfs43DXjICwpJLbw/RYKNnA1Wk+IEVhgpIpOXn9Qx
         eokUzGlN4nGyriZ8tui3PijF7YsiQWn0lJfmuEMc7I7CB9Nz1EQBiPDZfky9hKKyVTld
         dLjIXon7iNG2RleRheRY4qaeUW+v9Vn3m1pbr4xae9JnVmz8ZWIEY3PspuKpxyN9dSGB
         nZVXnpsWsAfjohTJCmJJkoUuITikJTTjNvz995jPvWm+BD1bAVUoMuaBnXfcaGNpp2to
         QI5g==
X-Forwarded-Encrypted: i=1; AJvYcCVpHWo9JEcHmykruk7/LO40mnm2VgldhiSRjtfWVXxl+5r2Co1ghK4/mmcx/DCUoEj8alE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAIpFnA47ALxzRr4x9tXZ1IaZSr6id9QOZRpBR5GNimM2hFIHc
	iYCTwJVctrRQ0+/guU+ikQfAbJzHA7nc82BHPvwCisjemjuI28/0l+WO3nu/mLO7PHM=
X-Gm-Gg: ATEYQzyLHz6DvBkU/mdGiF6YJbfXrmAo7UYP2ovsH3NeAdQM4eDusRE1rrG/yjQX1C9
	NFZPvycb39SfCjdbJBo1xrqLlB0uRHJIlJ1WxhrG5Zvb0YR2g7rWZjCUqkdo6P9GFMcVmFjoEd5
	UnqNhB2mPPhB2ljgsniTEE+9EZ6GO+jtq+mBpymj1q+QyXFEd9AuB5cqRPfpNq2KvQeRHWAo5ek
	4sPZ7bSTJHZhZk/ICx11MBarbaNCyGXr8n4GfTSvRvD6I0Y5C3yiMVs4/uEIATzXeeQBqkDwFbh
	YVhsKW2sBAvT6SEX5tqIaEem2wF3kjCQxMdF5SeaTcBV9974Jx29irTzvk0gaPg6JKRNNUqR6Pd
	nKkPrEL4Fo6/SIw+tz2EkQryz2y1MPFDqgYKyP2c60TH9donULlsPFhwOEAdxW+v1liBufY+1Wv
	cM57tITHPdZD+tsbP7B/7c7yE=
X-Received: by 2002:a05:6214:c2d:b0:88a:2d3d:7c30 with SMTP id 6a1803df08f44-899d1e6e77bmr87127056d6.55.1772239190039;
        Fri, 27 Feb 2026 16:39:50 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf746fc5sm589918385a.51.2026.02.27.16.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 16:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 19:39:48 -0500
Message-Id: <DGQ6CZP3ZRKP.2R2HXXIS8XW82@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@kernel.org>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Allow void global functions in the
 verifier
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260227154616.6846-1-emil@etsalapatis.com>
 <20260227154616.6846-5-emil@etsalapatis.com>
 <706fc0b28de247fdaf302a5156d5d5cf7f0e6993.camel@gmail.com>
In-Reply-To: <706fc0b28de247fdaf302a5156d5d5cf7f0e6993.camel@gmail.com>

On Fri Feb 27, 2026 at 2:32 PM EST, Eduard Zingerman wrote:
> On Fri, 2026-02-27 at 10:46 -0500, Emil Tsalapatis wrote:
>> Global subprogs are currently not allowed to return void. Adjust
>> verifier logic to allow global functions with a void return type.
>>=20
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index fb4d14516043..702b3583cd78 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>
> [...]
>
>> @@ -17952,7 +17977,7 @@ static bool return_retval_range(struct bpf_verif=
ier_env *env, struct bpf_retval_
>>  static bool program_returns_void(struct bpf_verifier_env *env)
>>  {
>>  	const struct bpf_prog *prog =3D env->prog;
>> -	enum bpf_prog_type prog_type =3D resolve_prog_type(prog);
>> +	enum bpf_prog_type prog_type =3D prog->type;
>> =20
>>  	switch (prog_type) {
>>  	case BPF_PROG_TYPE_LSM:
>> @@ -17965,6 +17990,16 @@ static bool program_returns_void(struct bpf_ver=
ifier_env *env)
>>  		if (!prog->aux->attach_func_proto->type)
>>  			return true;
>>  		break;
>> +	case BPF_PROG_TYPE_EXT:
>> +		/*
>> +		 * If the actual program is an extension, let it
>> +		 * return void - attaching will succeed only if the
>> +		 * program being replaced also returns void, and since
>> +		 * it has passed verification its actual type doesn't matter.
>> +		 */
>> +		if (subprog_returns_void(env, 0))
>> +			return true;
>> +		break;
>>  	default:
>>  		break;
>>  	}
>
> Agree with above two hunks because of what bpf_check_attach_target() does=
.
>
> [...]
>
>> @@ -18059,8 +18094,13 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
>>  static int check_subprogram_return_code(struct bpf_verifier_env *env)
>>  {
>>  	struct bpf_reg_state *reg =3D reg_state(env, BPF_REG_0);
>> +	struct bpf_func_state *cur_frame =3D cur_func(env);
>>  	int err;
>> =20
>> +	if (subprog_is_global(env, cur_frame->subprogno) &&
>    	    ^^^^^^^^^^^^^^^^^
> Nit:	    This check is now redundant, right?
> 	    check_return_code() is called from process_bpf_exit_full()
> 	    only when env->cur_state->curframe =3D=3D 0 and cur_frame->subprogno=
 > 0,
> 	    meaning that it only applies to global subprogs.
> 	    (Maybe even rename the func to check_global_subprog_return_code() to=
 avoid confusion?)
>

Ack, yes that makes sense. I'll also rename the function.

>> +	    subprog_returns_void(env, cur_frame->subprogno))
>> +			return 0;
>> +
>>  	err =3D check_reg_arg(env, BPF_REG_0, SRC_OP);
>>  	if (err)
>>  		return err;
>
> [...]

