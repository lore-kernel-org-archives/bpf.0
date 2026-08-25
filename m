Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA7301486
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621919; cv=pass; b=lHkOutTeQ++LTk7cyQouhE6JnfLt9ckMtovlgq0iofYC8mwQ+wmHasAbpmaMXNiqDTcC7FAugo5RgmEckgolTrbR9d2n4FGJlc3X/zcit/QhuDsihD5QRi0eCUIi3fdm2yy3X/wKFVheJ9cc4lHYVv0fXHffL5fpx3HWRiBiQ5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621919; c=relaxed/simple;
	bh=Dl1pNxz0/A2V30oF3MiIT/1xyFZzJWr2p2E5a2231MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byM5bqRbSauwhs01AtwJWFkYMg0ksg4yKQa+xhGlALsa2GQHeuaM/RrQyvlo5JZPABz0/5a5CE/kcKky3r1rH/58yst3FWZrOd3ake1fVF/lIS5tzVoqohqd5jkDbeogb7WyAzQteqXsEjTVdvmx6g9PGeYy2/zBBaQ97y5O3bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcpWmiK8; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcpWmiK8"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66d0c8d0d6eso1210811d50.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 18:38:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787621917; cv=none;
        d=google.com; s=arc-20260327;
        b=MuInFcEVBp9isLqHZokCLdCrA2wdKAxdwp3ZFgOfNpwm4NZsqtPvL1mvpWc+Nau5Rw
         OWCV1b1s2/lsCBJWXnrl55riLQ6iqDrnHBL/YY4HLcmVnZX1pJ6b50TLrn77MBeYDnTE
         c506CIf1F+4dtlqvRZLiDS3Fbz184EnmKD0nTlFvV3LCgnhuJgyQ0hnSOjc5kSB+gpXZ
         AsJAyzVypXOE137Y7ATvYkqQ8m6DCW0P9Z1Lo5fFWgJ1BatLOEw6C+R2PGXNKG6OkkPZ
         vX5Bhko9eMhwjCbD9PHGRpMEnzpINW2gWdhmG7FEXPoSZN+iyfiLkBN2//0dDumbWAQX
         vwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dl1pNxz0/A2V30oF3MiIT/1xyFZzJWr2p2E5a2231MY=;
        fh=WmqFvQTuKqimol9e6bMHRdyZ64KXEf+aaxw4V2ZEatg=;
        b=MhaCjg2YNpeqiilcVqJjmnaiutWifW4jXnJ+rtVcNTdvsn6L6SAVEoiRh5CNYgdU7T
         3Y7tpnU9N+/DNzOc8rjL32qXvl1CNC37XAS9eVJmY5kbmlL4HJxmUMLGzmvDXmh5I6L7
         J1bt9Tkw/K/foOhiwZDWzSakDW0gR7SJr1tJTv49Osoj/VoZux9sIUij6+K4OMy4A4j6
         J90WAEK4mwi2b8PwKzqen2PzD15XvKpbi9vu7+g7iZbE7j2LF5cvuvqOf9vEyJjsANLT
         J8prsYGxXAhNB6YKNZyYkYIKS0B1653sLzOm8GgiRjxEXhQlqqPa8CHOXwRtsba4ZKlm
         116w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787621917; x=1788226717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dl1pNxz0/A2V30oF3MiIT/1xyFZzJWr2p2E5a2231MY=;
        b=RcpWmiK8D6TXy8SeKasN3A0DZYwOfxBRVcB8htDEIll1rHrnI6lELCV5zqfa7hqRIU
         rEtXhQwWzLhCxVjqmaqiPTZ5z0dJcxPhJuB+w/2g+ZIvxA9AA7wp1nCUmi/Lx3BT7V/D
         ix6ekhi8ZBI5IfxzW0LEJW0lhdkZsJx2MxnwWBni2MPKVcGdd8ABIe0GT3XfKGApfkV5
         94uglqgNOv4yjFi7HXESZnyitoC9C18fLhT4/Qfuilf4PgC3Dq1ZbPc5PRBpzoDcd/MI
         IZqnD5RIjFJMBR6ogU+eumXbmPPa8+C4epLSIHNwNtfwpjDlK2p3AxRoHpFvQWAoEL3b
         j4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787621917; x=1788226717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dl1pNxz0/A2V30oF3MiIT/1xyFZzJWr2p2E5a2231MY=;
        b=KKbtkRBOdvyM04Eo86A+ZISm/9uz1/vwZHEPqOIAVr7hhdJ+IoSlhqZVHWs4B1lfSS
         GZNID6Y6Xc5CKOP972JFV69lD6Wv/E+StFW8U0jzvekS4ECwRGRxGnCWQ8BJxmmSP/au
         u3JDqT7/EnZwn7a1Luw/rXS2+Ma67wGqsIbMlQulWkFCw4cOhKk2GVGGHAi5fPBIJhDB
         vi3BPFthJWq8Vuj2v+5FETQ2kkAL3/GqNsrUTdnOTgXrEmRpOqMvxPzCEzy1Hrqc7bzE
         /d59nt2di04D4Jtgne8yRsI+10V2cGrhCNTRY7b+RF1b/mdmd1lsnBnnFa9Vvcf7iRHf
         GHAg==
X-Forwarded-Encrypted: i=1; AHgh+RrkLrKJDTCAcoJOmIYdLAwNtD71ckUu6fe+zf7R1IWtQEDhspfd5ANbUAZcUw37vlymqP4=@vger.kernel.org
X-Gm-Message-State: AFuF++nVjJypCbeadt1KWKWJun23CguR9F0FumW9t1pzDNbm0wkOJQWe
	xig3zmJ+LQo/vU6xNCJF1n2MRx9YHPy/oIoRZDz7jGJTkcnAf8qNmVkbwH/T9kGLM86VuDasdFe
	setTS+Ay97lEZjR4nu/aqGbtimDwGx0k=
X-Gm-Gg: AR+sD11Wcxes3pl0Ouu8yzgDVa20TQnJcUotQlnvA/zQSCTEHkAVNgLJflbVCoWlSOI
	DW6yZcEGx94ThxcYeO7Kmq91HV1pT296S3DjXne9Ava9mRfi8EN4xpsdS5w+scW20j3js0k9zSs
	s7PT+0V70DV2alLble8FycYQRWn1NRH7nUOitgWZ3R/fwa5eFCa8J/PItchrxjUsW+umHSRx5dG
	6+a/6wvSkgEkqHznHXUyomx2Nx78Rz9JQWg/WPJz+iiYt2mOmBKUxzLXXLJwUVEFtcnSq8t+uNS
	mODfcrVh0DXneGci29fOgyZsLhKGSchqXLbGYGSgMj10IAJkQtxfaH1Qsh7LIf/x1w6tbIx80er
	B81/uBWB+PMamA68lAbc2FBbjxF5c6JCkxJz6bE61Voc=
X-Received: by 2002:a53:a5d1:0:b0:66c:76e6:2d01 with SMTP id
 956f58d0204a3-66d14a21801mr845428d50.9.1787621916851; Mon, 24 Aug 2026
 18:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821014210.18681-1-kartikey406@gmail.com> <CAEf4BzazKkRiOCAAERt6YueeVYnnYeNEPmxH+EW3F4CR_YVjsQ@mail.gmail.com>
In-Reply-To: <CAEf4BzazKkRiOCAAERt6YueeVYnnYeNEPmxH+EW3F4CR_YVjsQ@mail.gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 25 Aug 2026 07:08:25 +0530
X-Gm-Features: AcwNN1U0LHGolhM0a7k05nKFQh1Imv-RibXkGJMcsIUuJJbyEfcSMIuHp8mjcg0
Message-ID: <CADhLXY7_Dpzwuqdq84scYObut=DTTqfZgG_U9f-fP6GFeRVT-Q@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, olsajiri@gmail.com, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, kpsingh@kernel.org, 
	matt@bobrowski.net, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 12:04=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>

> exposing this mutex like that is definitely a smell.
>
> AI tells me that this perf event inheritance case can happen for
> non-tracing (i.e., BPF_PROG_TYPE_PERF_EVENT) events, which are
> attached while holding perf_event_ctx_lock, not the bpf_event_mutex
> (this one is held for tracepoint/kprobe/uprobe programs).
>
> Please validate and adjust the fix.
>

Thank you! You are correct.

perf_event_set_bpf_handler() is called
via two paths:
1. perf_event_set_bpf_prog() with ctx_lock
2. _perf_ioctl() with no lock

I will investigate the correct fix.

Thanks

Deepanshu
