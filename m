Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342314A8B
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780292573; cv=none; b=q1gh14A2kveDhIRTF42XjNny9bgTgICgTtN8fw8uOED7ZEj/6V7Xz9T9UvGbavov8Yk3wbMta3q2rskXPfdfBqyO7aDGccL7LYEeejPfCwzhUXswe1ue/yEOqAO03QD+vUc+oNiKD1wYpIIbHvZcpa8nS8QIQKcmOpB1aE+YENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780292573; c=relaxed/simple;
	bh=gAGuC7mgz3cTmFY2p5Z4NrMXwl4G6tnbtkwL5iJWcKY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sXvvrj9UcX9SjyERj0yLg4LBFjE7DJd+I4y2KqGuJbJPPH4/y0hDr40mqvnJzIJhy85EKOfPqBoelOJ034AKPwJ0N5nYxj1WBSIAw0CbXYtEVHWJVpAj5M3LOsCoLGPO5A45+C4CctBQ6fJiVHliGvHVrTwf3T8MqPzpWxPi7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=HE1mrbGj; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="HE1mrbGj"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-36b903567fdso3410625a91.1
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 22:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780292571; x=1780897371; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHvGYuplz5QC4FAZEE77//dWf1JalWwiXwaCA2SHLeA=;
        b=HE1mrbGj9mUkLDWNYt2peYpGynpW6K6PwnP44n5W9gCf0+gwdOGpAWVsKTrpgySOp2
         hVjUJhB0T5GlbDEFDN+9FawpoE+igaWr/lqvnT/YQWzvV1mFPKaDoEjGptCRXD/Eb/4/
         f7ziCwWbJmE9670FBWLAW3NcShFmQCU8oWN7wCiO9UV2smMRYQ2tfbAHG7ASseCZAwNe
         ntDTdOiJHCrKvRy6+zo6waS+YWbVWJ0Bfu3mY27S/N5pPiiCaNqV17w2Laaf5tZCiK8u
         wmPPkiv2MWvYZhrcP/QE/LG0u5lbNixVE5uewiaR6Td/EsJMBPTrozDxqB5VycaHpi1N
         37tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780292571; x=1780897371;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHvGYuplz5QC4FAZEE77//dWf1JalWwiXwaCA2SHLeA=;
        b=rZl3QLT5z+4EXY1dqE4ptTUANZOQcrpPq61XCqEo8e0weN+Qqk2HRRZRdVx/YT23iE
         QMmLuRZAzRzIle9FuQnIxdEUsNy3pPQbiVXBwAJZUh2NhC3X9ieWCVm1daoftm/CLfV3
         0vjDgnv0OsIXcTnt7X7hiytNNMqgRev7T7qLqdKG8pr02oXD69WHz8ouk55qKDfdbiTJ
         UHN+yjWz2WW1hqzL2uB01Pk3b4dsJXYzj5rkIztqpg/BkWWm+qq119vr0VdI09iQmx42
         LkBmc7akb51nj8+QNetmXa2QaJhJiod3CJXzcUgQeqPnNia762KvUKO6pyloUdZ4JPeR
         lgtg==
X-Gm-Message-State: AOJu0Yw7AuVTJcLNxP2bzcF+QIdMS27Ql+bIq1ZM6goEXaXrEPb/3MXO
	2u1QDflSsP0DkdRPVYEhRC8Z/aMax3WXvk3BpHXMtGOX9htYwv5HCM5kEhSrY1dhNLUiWpRvkal
	4Py4MhNmn1WDp
X-Gm-Gg: Acq92OHFTtKIRJdv9fER48tZXihRsZLMYJs9B40nAzgcn2g5fXIXVW40KjGgnzJZtig
	epDbRbiqDyOl7/PXfOI7zQ+RgVh9AA6UJvGf612YdTh1a1bZId+iNgtNDh6BkVwNmZphCN2lMlB
	olUSVsYAwRvUhN7brf8G29QjNNdUSbLckJlY3FqXBJU/xFfvzIC49CMoIi/AZWkcC58ZyeJukK5
	9fdMN58SPswm0aA2tzsQR/yOQI015+HKhB/3T5052nM/aivU0YbS9W58t157bL/eMAXWp2TIxJC
	JDltSVE79yzbmXoXI5wEZt3McosNJu/woI9nDrYMnAdNKlqCUMHrq4pImhGMsVY4d7FpYKaE3uu
	EviYrUU5XiTQY/2iqb1Ewwdm8SGtuNqkdiX2p4nnJH1AYkzoF+l+Sb+iG9ZEcQK1c7Yf4u6UwK9
	QIN6F410Su+cB5mUB2ki9BpbU7qRMafZ4v5iI=
X-Received: by 2002:a17:90a:d604:b0:369:69f8:ad6b with SMTP id 98e67ed59e1d1-36c2eb88bd7mr8758527a91.0.1780292571400;
        Sun, 31 May 2026 22:42:51 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0c1ab21sm9430416a91.14.2026.05.31.22.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 22:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 01:42:50 -0400
Message-Id: <DIXH1O3E96VX.EYFDM9QIT6AD@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v3 1/3] bpf: Add validation for bpf_set_retval
 argument
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Xu Kuohai"
 <xukuohai@huaweicloud.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260530101239.590395-2-xukuohai@huaweicloud.com>
 <20260530105334.8E8BA1F00893@smtp.kernel.org>
In-Reply-To: <20260530105334.8E8BA1F00893@smtp.kernel.org>

On Sat May 30, 2026 at 6:53 AM EDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] The strict bounds check added to `bpf_set_retval()` unconditiona=
lly rejects programs that pass unconstrained variables, such as the output =
of `bpf_get_retval()`, breaking backward compatibility for existing user pr=
ograms.
> - [High] Restricting `bpf_set_retval()` to `[-MAX_ERRNO, 0]` breaks `BPF_=
CGROUP_GETSOCKOPT` programs that legitimately return positive values.
> --
>
> commit 822adc8377df563ad6f9bfabc65c87c7f98aaf52
> Author: Xu Kuohai <xukuohai@huawei.com>
>
> bpf: Add validation for bpf_set_retval argument
>
> This commit adds validation to the bpf_set_retval helper to prevent
> cgroup BPF programs from returning unexpected positive values, which can
> cause wild pointer dereferences or bypass error checks. For BPF_LSM_CGROU=
P,
> it enforces LSM-specific ranges. For other cgroup types, it restricts the
> argument to [-MAX_ERRNO, 0].
>
> Link: https://lore.kernel.org/all/567d3206-74a5-44e5-99c6-779c425f399e@st=
d.uestc.edu.cn
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 7fb88e1cd7c4d..4948bd4bf9e16 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -10460,6 +10460,19 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
>>  		}
>>  		break;
>>  	case BPF_FUNC_set_retval:
>> +	{
>> +		struct bpf_retval_range range =3D {
>> +			.minval =3D -MAX_ERRNO,
>> +			.maxval =3D 0,
>> +			.return_32bit =3D true
>> +		};
>
> [Severity: High]
> Does this blanket restriction to 0 break BPF_CGROUP_GETSOCKOPT programs?
>
> Commit c4dcfdd406aa2167 ("bpf: Move getsockopt retval to struct
> bpf_cg_run_ctx") removed the restriction that getsockopt filters must
> return <=3D 0, noting that valid getsockopt handlers often return positiv=
e
> values for the option length.=20
>
> Could this maxval =3D 0 limit prevent BPF_CGROUP_GETSOCKOPT programs from=
=20
> legitimately returning positive lengths via bpf_set_retval?
>

AFAICT the getsockopt manpage corroborates the issue, should be possible to
account for this.

>> +		struct bpf_reg_state *r1 =3D &regs[BPF_REG_1];
>> +
>> +		if (r1->type !=3D SCALAR_VALUE) {
>> +			verbose(env, "R1 is not a scalar\n");
>> +			return -EINVAL;
>> +		}
>> +
>
> [ ... ]
>
>> @@ -10469,8 +10482,20 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
>> +		err =3D mark_chain_precision(env, BPF_REG_1);
>> +		if (err)
>> +			return err;
>> +
>> +		if (!retval_range_within(range, r1)) {
>> +			verbose_invalid_scalar(env, r1, range, "At bpf_set_retval", "R1");
>> +			return -EINVAL;
>> +		}
>
> [Severity: High]
> Will this strict bounds check unconditionally reject programs that pass=
=20
> unconstrained variables, such as the output of bpf_get_retval?
>
> The helper bpf_get_retval returns an int which is tracked by the verifier=
=20
> as an unknown scalar. If this unconstrained scalar is passed directly to=
=20
> bpf_set_retval, it is checked against the newly hardcoded [-MAX_ERRNO, 0]=
=20
> range.=20
>
> Since the unknown bounds fall outside this narrow range, the verifier wil=
l=20
> reject the program at load time.=20
>
> Could this break backward compatibility for existing user programs relyin=
g=20
> on the bpf_set_retval(bpf_get_retval()) pattern?

"Backward compatibility" is definitely the wrong way to put this
considering past behavior was buggy. The only alternative I can see is
checking the return value dynamically in the helper itself and returning
failure if the attempted value is illegal, and that is an even bigger
change in behavior. Programs can add bounds checking to get_retval to
handle this.
