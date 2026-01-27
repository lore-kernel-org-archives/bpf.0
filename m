Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1EC2F0C76
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769557697; cv=none; b=PsXmmNa1NuoM3wDq/c4hKV1xrK48YWyiM9zq2pTG+lUP/T6I7teWRGTm4KWyxvpa0zcZWzyajRFewLHeyC7Ca7cP2en+SvvefCZbwjFBwU2PPbGbG3xJylUSBTN2OcoshDXno/ZqLTepq9n8t4MpowgtQQe++KXSFWRPpiO+LDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769557697; c=relaxed/simple;
	bh=8R1Vy4GKGWW4jVcuULtfJmDM/ixBjOiEj1pjMw/Podg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oo+bjUA9SfoNsV988TWYzzaZJbUbZJXvlQRL2lpVgmxt60AJ5U58fntJFXU6F6+jQG8qqUalvRvH1JIcvdqQCmmRgI0jL3IlzHaJ1vHqyv8snF20v4oW+PQ0JUPdMpV3m/bAJ8QawjYEI3CVKKz8bzyznj5ggFID6XKg1QcEDDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=sZoen21b; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="sZoen21b"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-894638da330so70929366d6.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 15:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769557694; x=1770162494; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro9HWdlavxbsey67GTjs5SWzW8LVfPFPAQJQA6a85w8=;
        b=sZoen21bs6in6M2RtJ3aSmOCDEAfBByUM6UE+uTYSmQd9SVdgOaWUtKVtwrLoi2skE
         5yD2SSqtky2MqQ3ACIUVCE9v5a3cZ95XSbNGy5dzovuzbvhJkuNXWMpGqL9hhgfKDIdp
         5d8ABgRuINqd/PPOUw6DFik0+bWCfNSPkDO9tnflqjLJkgb39b3UMewljASj107tsUBN
         vr6w49/3UFGMYVJr/uj6mZURnorWPH53pg1tWwMNX8L+sXeQt3umJ3QsD1ZiuOG8xyqx
         3nDlOyStoCPD8JSspVfDipd6NJJ8J04uGhyTJrFsGYJbPKLYrNKX6Ih+ZRtmfIQ7f+GE
         Hijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769557694; x=1770162494;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ro9HWdlavxbsey67GTjs5SWzW8LVfPFPAQJQA6a85w8=;
        b=oyUzjR9DfD4Vr+zrrpVxuuXEO06PrvwaebzLJ/apif4Sgj508KWXPaMjU58I/GeBUg
         FZT3HCQi8n8LJOPwE4ROnJxUW6FO1f3q9AXtgVFr0ykUo+xlmpIgiIGEY4h/Rw01yhna
         KDr64fDoJ+a9MY7tEDlcOR5ttMCypjv74LKSBfDmK9v+z7RQTbvNS/XXNinCcr4obZE7
         7EmDBJnq16J5C+RD7y4xGvTyKVV/BjfLpKVF86FxOElzsZnxOesKOGAo1spyf3nlvHlu
         dv2bb1pVQ4YwhwokCYp5NATynEMsSSlGj2147cyqHSAstKZFbEV9EU3Dou53ChL1blNV
         GdKA==
X-Forwarded-Encrypted: i=1; AJvYcCUwKc5JminmNOdzWhssIlTtcYw+sv7KsFAatrAyjoerT+xPIoNYf38l+m0y/9S71cQbQAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxysgpzWGUKUi90EzNcK+xPYPX5ItrcQ29MjusrHNO3fPRDvQV0
	XPQY7jZt/v3I1PNMh/XcZlt8LmI0/7tMAKv7ZpkF7uaCdgOrfAA4FM53QEHvSw3jVIU=
X-Gm-Gg: AZuq6aIlAkOZi/QOW414GtsAC3pPvITxCCPi8N2CrAGXGO8vMqjSD7wJ0XfpxWakKF6
	Xm660Eek1zZjV3u5Q1I+No9EvLy18W9CwjAdEBqNv+xna5dNCqKWY2gUARsKp/BN4jq9zOf9jtd
	5cKPkzrxSCwORYHtfyt5MZZTM9Np9w0Vu1cx1BsBMY4gXOcAg0X96N9LWojA4IpvCzW3YeRVVyi
	l4/qVxr73+tR+BglK7+LIITgxIy4rixX2GRo5ni0inO1IyWDTl/0gaSaGnx/WrOoM/n4PbN0KT4
	qAGe+pquK10vMqYdsouu2CWBOTFlT3k5khNpK583r4nFU8mSfZDgD6Z6Q29qkOG/Ki2rMSorQY2
	qHzrmHBsfDaKjucjdjjaGVOf9uvyOZae840byf45eJB0TxKnF9kylhWOBjoHizNaJhn3+P3xkNj
	YvaaWAiizhipY=
X-Received: by 2002:ad4:5cc3:0:b0:87d:e2b:cdf7 with SMTP id 6a1803df08f44-894cc94c1c3mr47059446d6.66.1769557694218;
        Tue, 27 Jan 2026 15:48:14 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7c670sm70371385a.6.2026.01.27.15.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 15:48:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 18:48:12 -0500
Message-Id: <DFZRULJI9RA6.EAYA8GNER4RY@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <martin.lau@kernel.org>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next] bpf: Allow void return type for global
 subprogs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260127231414.359283-1-emil@etsalapatis.com>
 <85a0ec6ff812bfcd7e648a36edb28517817fe05a0b5b164d4b3c269d365e1562@mail.kernel.org>
In-Reply-To: <85a0ec6ff812bfcd7e648a36edb28517817fe05a0b5b164d4b3c269d365e1562@mail.kernel.org>

On Tue Jan 27, 2026 at 6:45 PM EST, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index c2f2650db9..2cc7404954 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
>> @@ -10875,7 +10898,7 @@ static int check_func_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>>  		subprog_aux(env, subprog)->called =3D true;
>>  		clear_caller_saved_regs(env, caller->regs);
>>
>> -		/* All global functions return a 64-bit SCALAR_VALUE */
>> +		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
>>  		mark_reg_unknown(env, caller->regs, BPF_REG_0);
>>  		caller->regs[BPF_REG_0].subreg_def =3D DEF_NOT_SUBREG;
>
> The comment was updated to say "non-void" but mark_reg_unknown() is still
> called unconditionally for all global functions.  Should this skip markin=
g
> R0 as SCALAR_VALUE when the callee is a void function?
>
> As written, after calling a void global function, R0 is marked as a valid
> scalar that the caller can use, even though the callee never set it.
>
> The new subprog_is_void() helper is used in check_return_code() to bypass
> the R0 validation at the callee's exit, but check_func_call() does not us=
e
> it to avoid marking R0 at the call site.
>
> Something like this might be needed here:
>
>     if (!subprog_is_void(env, subprog)) {
>         mark_reg_unknown(env, caller->regs, BPF_REG_0);
>         caller->regs[BPF_REG_0].subreg_def =3D DEF_NOT_SUBREG;
>     }
>

The comment update is inaccurate, will undo the change.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/214183=
26339
>
> AI-authorship-score: low
> AI-authorship-explanation: The code follows standard kernel conventions w=
ith appropriate use of existing patterns and helper functions, showing fami=
liarity with the BPF verifier internals.
> issues-found: 1
> issue-severity-score: medium
> issue-severity-explanation: The verifier incorrectly marks R0 as a valid =
scalar after calling a void global function, allowing programs to use an un=
defined value, though it does not directly cause crashes or security issues=
.

