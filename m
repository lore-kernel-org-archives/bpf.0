Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90464377A86
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101026; cv=none; b=hNicFWoRl0t/rOm1OAl5+bGRQJgiTxgPCfnkhnG6fEAEJWNSxcVAr7ZKycnVAUm28U+vYOjNlicHmkWR4SJcuHF97oa9yczuwIAhk5E+k1qLvGsHNxFk9ogxFtY3I2iMbEu7XtvDXvfjA9s8OFYxVXr+KlQ7aEVtILwypJ2EyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101026; c=relaxed/simple;
	bh=qkB7w9NOyJZt67X0u/FoT1xz/AU7jnhUL7ANnxRlu34=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tlZ4uavECdVZf5xl7UfQpW3945o6Hgk26EW9xCBWF2W9oYJD51c6diErkvTDX2xOEiUe6px2+73pDvnPtO+MdhTfuuLIcOO34sC+EBL7O0XzjIQmsGh11NkAh0LkYd2wkvsjdp4Y5l/sKMPPEFXKAgy+6MkpXusepOu4kDnx8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG4l4CdT; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG4l4CdT"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-493b4d3a635so12014625e9.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784101023; x=1784705823; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N1X5Q21InQJW5nko7LnIkJ8l+wxbc+pZrfHDC4/iHlc=;
        b=VG4l4CdTRFZ33/9UnnzBGhTcAtXaSVoAOSpglQyRyJ1mV1sUwvzUxoCV2mzDsDlwzv
         gYaSZn2Pn84XIhW0/DWsM8Ij7ADkGKCDY84c0h53qB+Wr+S8TEIBsQtwcoAlg4vTae55
         bdteBeuSE1Uob9nlyLA/Q/eCNIeoV2WfJ/hqm514fpz/vq82Gk+/UAVzwudCZB67dIF8
         tV5cPFGhoFOHEF/5wfMllVI645+ZCXweSMmTk8cb4sde4h8nPUMm5SwbFxo3Q4cbl0Yv
         YnS1fgprGwGVW6Lz1GReVpxjrZKEuEVOUnQR7LCVIB9A2nXeaoz2adDal20Wc3PoMZag
         1wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784101023; x=1784705823;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1X5Q21InQJW5nko7LnIkJ8l+wxbc+pZrfHDC4/iHlc=;
        b=fsPAJNSHlrSmkml43AJSTLNttlLcfq0uA3hPcy3wZaA9c5toptwsVJzWbCdgsJAz5R
         T0pezjVjZYYPixO4cD5tABDYPgetq0KxrF6GY27P8hFIvkmBsY2j80l8VK9SXUs58GpM
         fnK7W3XWYFn7tMUeshu6MKL5JYhWWN9OMjB3KnM/yu+1WDKc3QLYFM5eijVtel4S+8RW
         3lB1B87/bZzhkd3ulXJTnabMHY1ShQmnzQJrCyhwnHe8q9E9Bhx/Ns3h5+kreHobz7xe
         skx3u/SP7Y+ayz7AD0WJPyRzQXDmetl2QZ/jgadKnMlQFjzVuvo3e5TY0jIqVZzejGjn
         QOQw==
X-Forwarded-Encrypted: i=1; AHgh+Ro36868pnPhJBYSyZ/r588ZNaefb5SIfjvI6rklioSmoplqmeC+DE+7TN1V4iYej0STDSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8u4kkmZ9/Xjsq2yvvwUGgUKHEp8ueHDPbT0jeGMnfj1v5/VA
	uAw92hsqFSMogVC3lzFSgoSsy4VJLSY4jfj5ULp8c74B26gYtVHvi6r/
X-Gm-Gg: AfdE7ckYAWJJNFCHaVeiaAM2C1w524tEpYjDG4nwkIy9+DmRxvdWnSWgS14LaE7aRid
	/usKM7+StVrwnRaJ4luKUqOHRECeQXzpcA1UcWCBD4f9r0kdCJplr5gIrMCXdAWBKM/XdzR7Zbt
	+yOa7S/2CBEeH+K2/lsklGftUGcXc9MxfnWjejhYGXcBvS2wfqcoIiaopeyPl6wHnw64IbBMlF+
	/DK8g3xPg8GjK/UUQxpEnvosXndd3CTsH074aSN66CoXjNRdcIf/Rcz5ioeVISa2j92/ZJMGLC1
	MAnZLGeDo5lRmuMZr3qkzEbXr90IJaQnVKcXM7KmectG+aDdEMWmSDDc9eZ0/gsdGmOKxUSSD74
	2tfXKoZmJFsn3vCuyk7xCAchuQoAxwkopLARVbGCwgNF0+SRGNH6yqzgrNE7yU8gYwwfpBuG8kn
	oQbDxqV6Orw+L0jV9U3mWkvXfBe3lasi7jMS2Eut+YzRpGuPY1E1a/azLvn3WNRzK3zi6nlDM7S
	K0OAQxuTG1oaUixjuZs3mbRfS3VRUXjqG/ZGD5d15y2RGmX90TMb+s=
X-Received: by 2002:a05:600c:4ed2:b0:495:3f5e:e7a with SMTP id 5b1f17b1804b1-4953f5e0e80mr165505e9.34.1784101022476;
        Wed, 15 Jul 2026 00:37:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f635dsm137767845e9.12.2026.07.15.00.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 00:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 09:37:01 +0200
Message-Id: <DJYZ12G29BZ8.2JBXPFCGEQGJL@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 13/17] bpf: Report Program Structure CFG
 errors
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260713153910.2556007-1-memxor@gmail.com>
 <20260713153910.2556007-14-memxor@gmail.com>
 <9d9ec72059ef2855c3e2a47982e44cff9dd1165a.camel@gmail.com>
In-Reply-To: <9d9ec72059ef2855c3e2a47982e44cff9dd1165a.camel@gmail.com>

On Tue Jul 14, 2026 at 10:00 PM CEST, Eduard Zingerman wrote:
> On Mon, 2026-07-13 at 17:39 +0200, Kumar Kartikeya Dwivedi wrote:
>> Augment selected subprogram CFG validation failures with Program Structu=
re
>> reports. These errors are structural rather than path-dependent, so the =
report
>> focuses on source and instruction context instead of causal history.
>>
>> Cover jumps that leave the current subprogram, subprograms whose last
>> instruction can fall through into the next subprogram, and recursive bpf=
2bpf
>> call graph edges.
>>
>> Format long jump-range reasons directly in diagnostics.c, and keep the
>> fallthrough suggestion aligned with the verifier check by suggesting exi=
t or
>> explicit jumps.
>>
>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>  kernel/bpf/cfg.c         | 55 ++++++++++++++++++++++++++++++++++++++++
>>  kernel/bpf/diagnostics.c | 19 ++++++++++++++
>>  kernel/bpf/diagnostics.h |  3 +++
>>  kernel/bpf/verifier.c    | 32 +++++++++++++++++++++++
>>  4 files changed, 109 insertions(+)
>>
>> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
>> index 26d37066465f..376f6b6d469c 100644
>> --- a/kernel/bpf/cfg.c
>> +++ b/kernel/bpf/cfg.c
>> @@ -5,6 +5,8 @@
>>  #include <linux/filter.h>
>>  #include <linux/sort.h>
>>
>> +#include "diagnostics.h"
>> +
>>  #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##a=
rgs)
>>
>>  /* non-recursive DFS pseudo code
>> @@ -113,6 +115,12 @@ static int push_insn(int t, int w, int e, struct bp=
f_verifier_env *env)
>>  	if (w < 0 || w >=3D env->prog->len) {
>>  		verbose_linfo(env, t, "%d: ", t);
>>  		verbose(env, "jump out of range from insn %d to %d\n", t, w);
>> +		bpf_diag_report_program_structure(env, t, "jump out of range",
>> +						  "Keep branch targets inside the program.",
>> +						  "Instruction %d jumps to instruction %d, but the "
>> +						  "program only contains instructions 0 through "
>> +						  "%d.",
>> +						  t, w, env->prog->len - 1);
>
> Nit: I'd forgo the formatting rules and just write the above like:
>
> 		bpf_diag_report_program_structure(
> 		  env, t, "jump out of range",
> 		  "Keep branch targets inside the program.",
> 		  "Instruction %d jumps to instruction %d, but the program only contain=
s instructions 0 through %d.",
> 		   t, w, env->prog->len - 1);
>
>      Easier to read and easier to grep.
>
>>  		return -EINVAL;
>>  	}
>>
>

Ack, will change throughout the series.

> [...]

