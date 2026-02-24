Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C864D22D7B0
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958787; cv=none; b=ep1p3q8iSnYhaRe+H5FdMrq9PD2BlL6rG2DqQdPoCbrBP1jtOBropTt2yq3PjLz0mpmgiYsFjrvBfdz24dwQCGav5pm5EImLZVZFnabnpEAFP/TU4Fh9uj09Ci9mhf+FX7cdZnJ4jBvIFrDLTNfvtzHI+QjRo5Mj4UOymTTRkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958787; c=relaxed/simple;
	bh=ECak5HlvJxS8btND1ndL0y6LK2WQaVF7+YLjFVzPF+w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rgMwDKU2x8POaD9yQSNgp/AQdM1DG8VPLN4p5bKnD8VY9hETWJKxdyaNEWHw5r790yL4RywOOXvMogw41t3F8k4t31w5sO1JgVckeEVEcJODt9ozTleUkgFFKZkxvUtXxJfTk3s4NhrijtxjnuEGm67xdqKlbnqOX6FrZ/6iyHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=IGiyUCoV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="IGiyUCoV"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506aa685d62so34366481cf.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 10:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771958785; x=1772563585; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZB9VlyQcAyrglNJajs4zhdlqEOwLxBfKRZ6wlKqf0HU=;
        b=IGiyUCoVN2d7UsU1dsf/uNKVNCJ9+LyWwaI/WCyxSvRNMPzKwI5ZkEZAoxIziOcDfZ
         JsMfnDv1zE5lOVfBA4ljwcCVN4vMpLlLRihhco4GlsUovDAcZCjxRB5OstD8+R+22th/
         knj2/1FUhY0Wk1M4etBH2aM8LaaOPjEP2Jka8UkmJlAIVYqPWbaTEwCrSWMFrRQpe1M3
         AUzWP3xJeHifsvYWMwm79wj6irbndpkwXs/eClR+zuW9pAU6uWnHtuKt2lVdJPVmLdHm
         Whx7g92BpkDg2/TVoKjaJiDD56Myge73SN13xqssGgONAV68QoC5C4yx+uoC1dGvuPg8
         5U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771958785; x=1772563585;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZB9VlyQcAyrglNJajs4zhdlqEOwLxBfKRZ6wlKqf0HU=;
        b=s9++RJ0a43p2/tbTBPs5uwwo3eWfSUJYcW6YORHEf+u0QewwDJpcm6TDZvOjdCoDgt
         S9AFS/uEYHeLDCkf38WPpRk1a0DI8JJoijklUr3WvCyPHHK0kyWHU0si08pH0shkwWMc
         fBs+3hHb/GwF91rMZuJ0A3FiKf9jX5sO0CI4sQJUCIOe/T10G4KuiMIr3aXER9gp1MFE
         gkRUU2dTxmE/rVL0ZIfzIP6ciD50WJH61Klf9yrdSppiikWhznyF5Sr9p016jPt8fRIL
         itY2Y5OGws3MuQPR4MVp8JonuQGl/Vk+wvZPi6Wh+UoJDAHF+APoE/NrOkSzXFxEUc5S
         H7uA==
X-Forwarded-Encrypted: i=1; AJvYcCVDSKZXNJK+Jy+CCgL0V5yLKsZ9T03jHuEaD6ns+9L3melhooYF4JaV6EYSG3KlxBKvw+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwiy9dSqwASObGbunI8hl+2YBEde/na6KNdjUrYtbRc/iwgaFZ
	5c731MuaZ8gB2rxmtRaOdbMLuJtsbxdILUEcQo5ozWui9eOczJ+XMRJBnH08Xk5t83ehRBX9hkq
	lGyXqua4=
X-Gm-Gg: AZuq6aJ2aMybAgdmwjjyWslj3ZRs/3YRH7fQkZCb8/hzXIXzNRG2df7Ot92PWkKUWXM
	a5+JUY7fWj77uZh4UIyZj3txTzmhPmEA2p3gX7Nl2leclMBWVSborHYamkI95fotIyD0kQm1VTa
	IHCMjeGfDZMHa+dCBQKkCUDugNr9BL2bckudn2Cr6U+YJNGibmldxM+OMySYi7+gnEjp8kC+lo6
	GL1JvRQEvhhcbCLm/OvnHE5dsoAlrgpaCZbjhnHqxgWAgCeNhe+R4wNMoGuRKbOa9OjuP8j7Jm9
	2BLHAV1r3CI1fxxvwU/G4hcjlmEyjgYBXHpM7nSGu9jxjaXm5qYxe5muOWTU/HhqlYoEhZqCTDM
	6R+zGWw7UCCSQnCdnXhme5r2zZoX0QQCTBfcLQiReD3x3TiBYSpJvpsmlsfLnG/hwUYZ+64NhDr
	lJD+15abe0QPdOuDmDmFfksuM=
X-Received: by 2002:ac8:5cd2:0:b0:506:a075:b247 with SMTP id d75a77b69052e-5070bba0e35mr178492931cf.14.1771958784599;
        Tue, 24 Feb 2026 10:46:24 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6a1ddasm104320921cf.21.2026.02.24.10.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 10:46:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 13:46:22 -0500
Message-Id: <DGNEYQZUKR83.25MVGRAQ05NSU@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@kernel.org>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Allow void global functions in the
 verifier
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260223215046.1706110-1-emil@etsalapatis.com>
 <20260223215046.1706110-2-emil@etsalapatis.com>
 <7fcfdf81aa76d816f7b5032d5b8a85302621fe64.camel@gmail.com>
In-Reply-To: <7fcfdf81aa76d816f7b5032d5b8a85302621fe64.camel@gmail.com>

On Mon Feb 23, 2026 at 7:09 PM EST, Eduard Zingerman wrote:
> On Mon, 2026-02-23 at 16:50 -0500, Emil Tsalapatis wrote:

Ack on the comments for 2/2. For here:
>
> [...]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 0162f946032f..e997c3776fa7 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -444,6 +444,29 @@ static bool subprog_is_global(const struct bpf_veri=
fier_env *env, int subprog)
>>  	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
>>  }
>> =20
>> +static bool subprog_returns_void(struct bpf_verifier_env *env, int subp=
rog)
>> +{
>> +	const struct btf_type *type, *func, *func_proto;
>> +	const struct btf *btf =3D env->prog->aux->btf;
>> +	u32 btf_id;
>> +
>> +	btf_id =3D env->prog->aux->func_info[subprog].type_id;
>> +
>> +	func =3D btf_type_by_id(btf, btf_id);
>> +	if (verifier_bug_if(!func, env, "btf_id %u not found", btf_id))
>> +		return false;
>> +
>> +	func_proto =3D btf_type_by_id(btf, func->type);
>> +	if (verifier_bug_if(!func_proto, env, "btf_id %u not found", func->typ=
e))
>> +		return false;
>> +
>> +	type =3D btf_type_skip_modifiers(btf, func_proto->type, NULL);
>> +	if (verifier_bug_if(!type, env, "btf_id %u not found", func_proto->typ=
e))
>> +		return false;
>> +
>
> Nit: I there there are a few unnecessary 'verifier_bug_if()' checks here,
>      e.g. btf.c:btf_check_all_types() guarantees that func->type and func=
_proto->type
>      would be valid.
>

Ack, just to make sure I got it right at all the verifier_bug_if() are
unnecessary. unnecessary because the BTF is already checked. There's no way=
 we
have an existing type with invalid fields. We also know the subprog btf
ID is valid from check_btf_func_early that happens way before
do_check_subprogs where subprog_returns_void is used.


>> +	return btf_type_is_void(type);
>> +}
>> +
>>  static const char *subprog_name(const struct bpf_verifier_env *env, int=
 subprog)
>>  {
>>  	struct bpf_func_info *info;
>
> [...]
>
>> @@ -17812,6 +17837,16 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
>> =20
>>  	/* LSM and struct_ops func-ptr's return type could be "void" */
>>  	if (!is_subprog || frame->in_exception_callback_fn) {
>> +
>> +		/*
>> +		 * If the actual program is an extension, let it
>> +		 * return void - attaching will succeed only if the
>> +		 * program being replaced also returns void, and since
>> +		 * it has passed verification its actual type doesn't matter.
>> +		 */
>> +		if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT && subprog_returns_void(=
env, frame->subprogno))
>> +			return 0;
>> +
>>  		switch (prog_type) {
>>  		case BPF_PROG_TYPE_LSM:
>>  			if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
>> @@ -17841,6 +17876,10 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
>>  		default:
>>  			break;
>>  		}
>> +	} else {
>> +		/* If this is a void global subprog, there is no return value. */
>> +		if (subprog_is_global(env, frame->subprogno) && subprog_returns_void(=
env, frame->subprogno))
>> +			return 0;
>
> Suppose a global subprogram is verified and it calls bpf_throw().
> check_return_code() is called from check_kfunc_call() in such case
> with R1 as a parameter.  This check acts on the return type of the
> program, will it miss proper return value check for the program?
>

Due to the short-circuiting herea a void global program can bpf_throw()=20
with no issue. This is what we want, correct? The return type we check=20
in that case would always be that of the u64 cookie AFAICT.=20

>>  	}
>> =20
>>  	/* eBPF calling convention is such that R0 is used
>
> [...]

