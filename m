Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D53B8130
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251550; cv=none; b=npQquFt4VeVj8c8A7EIXHt31Sj800kpvotUJfEhvA5aauYwRiHCc1cUcxnqITminielQw35UPyEhfNV7c7XU6wkIuDRn5m/LEqYLG6Qu2M1TKsIYJY5QfNmfPfTdcRNoP2R0o93GML//EpCReaIjWIGwB3qBI4fCxKr7haEXJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251550; c=relaxed/simple;
	bh=DEcLyTmhwS+RlC8yglBZkBjdWRmROimrD2+mka7sjzw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=aCEAmrDMTkllHTx6DZxpdqlvnYQmg4SWZFp8IW3fsKKWnky5lv29hfsDoW8UzvkGXwK+Co2rMCvD3F42Y+wiaxvh7vWo3Bj+yHEMdvmsmZyI4abKdnFRw4+NHk9TfeFCC+0rus2eA5a+8+O8NrSp5ikeo1aBPVfQ+wSFUzhOrgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=wVPOfHJ8; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="wVPOfHJ8"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13986d61b4fso560787c88.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782251548; x=1782856348; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFlyRL2o4sdMxWc71sn5UWmBL09Nr89DIg0wWzeHTvA=;
        b=wVPOfHJ8GFlKHbzbrbCUAocTF2i11vPx6ZLMqBWzdCl2UNW4s109kduJYQj7REuCcb
         9eBOdO28GUeCLE8dzzLdfYBwWuaslwMSktvoN7jqQmtEbATK32rb3g9x+5KFSgfxnIek
         cvlAtt5iAjzuYGqWfgQYViKWe/MwUdF8LPR8Mre3nWDepAC8tpvf3JjHhsQdYRZfu+dz
         Jcm1RGPiGGBNSBD/6QKCU9uGix+Uz1t4zbUvO5yQTfSdf8q9qCl01pND+kdP8suzx+l2
         qxrrZR8n7LN72KFVZS1UBHs20lRa3892d6OEeDzDGz+dVmHIzclb4kOO9CjD6r1OtKlr
         UKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782251548; x=1782856348;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFlyRL2o4sdMxWc71sn5UWmBL09Nr89DIg0wWzeHTvA=;
        b=qRghTEL/yX99V93jNrVVGhGeEdjSGFL1l+X83xb38hbwdU8rB94HxKiZDeEg2H5ZvB
         CdOzSveK5HQQye2l148X25gUn9vpfyTtqrhkDrG7k5zQDU5orGLGcYOC5jFG7zIYAaDJ
         1RdoyH8/dDofqUEEuRaIHRuWzPMRVhlrcyYcLtO2KFLvSmQWeaUXKk+xl5GKXlFGIXHZ
         qKvT1LqkKFi0oYVn/UqSM03BqaOVv+vyRfJot0rw8ZYOTKvzRLDpe6TqAtBTwp1Q1K78
         y8OvqILeYLG5/7FCpM59fQScvnzixpWgeTDEUU4jDtDAvAEBTSTyAfW/iwupymOM9pfJ
         njpA==
X-Forwarded-Encrypted: i=1; AFNElJ8cKgrLIXIwMIN+aRDFwgGvkGenLlFhAc7zcVuzeB2i7pLgR08nDCd+cySIj6Vp8LZR46s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfuKndA39eqCiK0TZCb2/nx8Gko6gyjafqm3aeLhohv3DnbwfS
	D9N0dWdZdARd4cMr4xbl+fu3m3ZGll1GoMXuXpFdeCiCjYHN9nZGsY8+8t+6e/M2Tjc=
X-Gm-Gg: AfdE7cl6kflx1NOzrfXlCHQ1wbd8W1g11q14rMII8sPxXAdAMjTj/GF8zi3rseVqUdl
	qC1hJmtZWDCaKvQPpIXVyNax2EGOwLG51XiARgNYVojz1Rr1FInYpvmQlM2LEa0AccM4jCK8BRZ
	wUzhYx5B5cDyBqyKUYVzLhRx6cHG68rvSpywBnUcedJkvjH77FgJ08CjzU5Apn+jv3V63PzfQs6
	/96U6J6i2PFplAoJdbGYlpJ26WJcO3BzhM1UVjMHrHbodV6cmFRpdRJD9mZso+nocxDBVX9hDZ2
	mPHLwyE7bTz0to4a1pqwSgEujIKwIkzW9D5eLLFq7nljMi0qXCAtZ6cv3RKqK6NvsNqjaDty62x
	g417LsHYKI/mvYktV4lsqRW2GGoiewjQchwaTQXcFVZsTh6bfgbGleh3eH4K5TC7fzrBfNQ==
X-Received: by 2002:a05:7022:410:b0:11a:342e:8a98 with SMTP id a92af1059eb24-139d0b58d17mr456804c88.0.1782251548209;
        Tue, 23 Jun 2026 14:52:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2526])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adcce488sm14516255c88.8.2026.06.23.14.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 14:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 17:52:25 -0400
Message-Id: <DJGRG0VRFCK4.KCEHW637D645@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Reject offset refcount acquire
 arguments
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <chenyy23@mails.tsinghua.edu.cn>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
Cc: <john.fastabend@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <shuah@kernel.org>, <vmalik@redhat.com>, <leon.hwang@linux.dev>,
 <davemarchevsky@fb.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <martin.lau@kernel.org>, <clm@meta.com>, <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <2f894647f56f71838fdddeb97a3e057ed35ea92e.1782192383.git.chenyy23@mails.tsinghua.edu.cn> <2c2797dac0dc56bf183087ed97aed819d1184568d2249b11439ab542afa43b4a@mail.kernel.org>
In-Reply-To: <2c2797dac0dc56bf183087ed97aed819d1184568d2249b11439ab542afa43b4a@mail.kernel.org>

On Tue Jun 23, 2026 at 3:01 AM EDT, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 2abc79dbf281..f65eff28ecd2 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
>> @@ -12135,7 +12146,8 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>>
>>  		if (regno =3D=3D meta->release_regno)
>>  			arg_type |=3D OBJ_RELEASE;
>> -		ret =3D check_func_arg_reg_off(env, reg, argno, arg_type);
>> +		ret =3D __check_func_arg_reg_off(env, reg, argno, arg_type,
>> +					       btf_id_fixed_off_ok);
>
> This isn't a bug, but does this call need to be split across two lines?
> The line length limit is 100 characters, and it looks like it would fit
> on a single line:

Bot is right, we don't split diagnostics across lines.

>
> 		ret =3D __check_func_arg_reg_off(env, reg, argno, arg_type, btf_id_fixe=
d_off_ok);
>
>>  		if (ret < 0)
>>  			return ret;
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/280072=
09948

