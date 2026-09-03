Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6C4A3F25
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454040; cv=none; b=c824Tl/qEzUXtgrT/BIRp/of2+JlrF+x1BaVrheN9/ZOqiBWP6/9R7BNtPA2wqNM2Rdbf7Gxi3mQT/0h53xhTQuLk+yqQyjV9i3BNN4/ebDE2VH71k9OqHQ3/3JMNeToHRWgT+/qV/5q6htaiiHWu77dNe1/tJ9g20W20QGbT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454040; c=relaxed/simple;
	bh=tEQucAaZT52CWPbTQKMI2Fg6FXnrFdT4T8s8E5kE5cw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=qPBrV3oCJuTMqLfEEeK944OP7Zjx8fBm2gkKUsnNYaB4HAJO4sA+QXE0PagTf7eFFgOlw5bNM0wkhuNAClPQsH8DFBgbooVPfbgYfbUxoRDOdD5HFumutaoNwXV4R+2qAlJqv3T/arlVN0yIBAs2E7hp0H2KmMujQkpBCg+3kFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oH8n5zoW; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oH8n5zoW"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f6617c7536so15780a34.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788454032; x=1789058832; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/TkXGgy+0i+5QFLCBIOyAldSnOfkS5P1f7N6u5UDczE=;
        b=oH8n5zoWqfHM9fY5QrEn2JamG5jZIrVBbYihHlYXiTvLpn8aXolkoFfG01LXyZbaYq
         v6xRN7v4SUBH9egK9aOIc53XQEOdwig/9G4oq8+eKejsmo4I99f7DhURIXEwyqYnEQp3
         0LD0Qzz2Hmw1OQvbXVhKFpC+jfphyZ/mVpiXNweA0yKXo72wvbObgy8D4T+g0kL8ax0u
         M8x07jiBS8aI6GxIQvnHeXBd1g5TzeFpG9BXA4+/PF7uBI8IKXSVjS4LMHwubDyA3DVs
         jc6C558jclb4nAv24m9mHB+7eWy4qshpxtyxvoQvhAltX0VQEBNTTeCqtUxXavaoSEt/
         zHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788454032; x=1789058832;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/TkXGgy+0i+5QFLCBIOyAldSnOfkS5P1f7N6u5UDczE=;
        b=HeVg0Ypb/S0PWLsrDzq+uIgS+beW6ZwsIeuHFFMX9mu7CFKO5oyy4sMWSJSC0qlwwr
         i0sduSbLSIVthJnKEDa+1qUCcm50nnXaf7a6p1gDdih36cCSxmKlOBkBnNy5soKh1XiX
         QKaWVXq1t6kjoHIgOfXfbsOIZS1KRA27Y2W6V+Q3vhkubePln6U+9qh/cpPoDYr6rfn3
         oBhGftmHKXvD9izxZ0Z8/gYi+4I5SJffvgOLC3AEiopBg8o16xxlJ2q1iV5x2BbbIAIG
         hUl9wBF3UPHqIZxXBKi5sdd2pN8TKKOH3SHfBXmVEMuo/tuazOf5QIi+fwUoesfYoygD
         5kLg==
X-Forwarded-Encrypted: i=1; AKwUvByHvkrc77CGOYX/a0wnl9Xy3Ua5EBIf7I3tmom12/PJgYCWXRoe/+Kd1MiYSmY+4beJgUQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lQWoQQ8R/aGfdtDAHk22EgjFJLQibxBs0F1hrpYn0H0GOwCuKE
	YQVTLofKjh7ZIbsqlaSYvtuVnZLRGYvsinmFg191UFXb38znpwG+MLTUr/Kbvw==
X-Gm-Gg: AYBFou0yCf4Sg+Uka85rBbeCcm2j24e+fr7CTar6725pixnLwFmy1+jShMAfFF0h6c/
	JmVoDv3GhM4xpltfXSaJ7PMbMHMoyCNuKdQntT6uzbZDsOBK2p0biF8arAuj9EaUPqKIbEGG0nT
	9/9unlIVOjhS7t/FLVA09RHAHayif45MEe6N7vR4+2mQOAodZ/H9lthtDKcWv4k2AiNloMLxbBo
	l8fj9xDmDIP4lYXJ9/KraE6F4Mm1CU/4f8H6n7SFzqOBp5n5Voglbd97zqePmswr6qnpIbyh35n
	QIWLRwfZwsfDKWgwC2nnljhGGtqafC4tLo5Gi0x9S1KX+uABhVRoOKK/7kTWFfofUQ9mDDkdZdA
	DvFwKSNrMT17bsg7UtJH0u4yc61UkDtLoDhV4gvbu5CWHZ/oaHzUTDoSE/G3HIK+kST7k5rCgr3
	YG2iRQI7wVroFfN/LiR1lS7mq4ypUDF/c2b0YtL0cEBZZJi6c0JfY5NlXzWBLDtl7LbF4eHppP4
	747gRHTID94n4jO2c1KnwAuKmTlxthNWEhyBODNgVMFGnFL1h26VsY=
X-Received: by 2002:a05:6830:838c:b0:7e9:5022:3639 with SMTP id 46e09a7af769-7f781cc26f6mr14846141a34.15.1788454031780;
        Thu, 03 Sep 2026 09:47:11 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6db9169sm356008a34.15.2026.09.03.09.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 09:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 09:47:10 -0700
Message-Id: <DL5U1J24X5VF.C5RA24WYQ4VO@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: <npc@anthropic.com>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v1 01/10] bpf: Mark signal tracepoint siginfo
 arguments as scalar
X-Mailer: aerc
References: <20260903144433.1716731-2-memxor@gmail.com>
 <dbc8b63e44e2fc3abc511f5659cb50c4b42db63d1738afc81dd007a527e436cf@mail.kernel.org>
In-Reply-To: <dbc8b63e44e2fc3abc511f5659cb50c4b42db63d1738afc81dd007a527e436cf@mail.kernel.org>

On Thu Sep 3, 2026 at 8:52 AM PDT, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index da36d4b9d31ab..d6d243c262ea5 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -6717,6 +6717,9 @@ static const struct bpf_raw_tp_null_args raw_tp_nu=
ll_args[] =3D {
>>  	{ "rxrpc_resend", 0x10 },
>>  	{ "rxrpc_tq", 0x10 },
>>  	{ "rxrpc_client", 0x1 },
>> +	/* signal */
>> +	{ "signal_generate", 0x20 },
>> +	{ "signal_deliver", 0x20 },
>                                    ^^^^
>
> Is signal_deliver's 0x20 mask too strict for its actual call sites?
>
> Looking at the two call sites for trace_signal_deliver():
>
>   kernel/signal.c (do_coredump):
>     trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
>                          &sighand->action[SIGKILL-1]);
>
>   kernel/signal.c (get_signal):
>     trace_signal_deliver(signr, &ksig->info, ka);
>
> SEND_SIG_PRIV is never passed to this tracepoint. SEND_SIG_NOINFO is
> zero (NULL), and &ksig->info is always a real pointer filled by
> dequeue_synchronous_signal() or dequeue_signal() just above the call.
>
> SEND_SIG_PRIV =3D=3D 1 only reaches trace_signal_generate() from
> kernel/signal.c:__send_signal_locked().
>
> If that's the case, would 0x10 (PTR_MAYBE_NULL) be both sufficient and
> less restrictive for signal_deliver? With 0x10 the verifier would still
> force a NULL check to catch SEND_SIG_NOINFO, but after the check a
> tp_btf program could read info->si_code and other fields. With 0x20 the
> register becomes SCALAR_VALUE immediately and check_mem_access() rejects
> all dereferencing with "R1 invalid mem access 'scalar'".

Though AI is correct today the callers of trace_signal_deliver() may change
in the future without cc-ing bpf mailing list and raw_tp_null_args[]
won't be correct anymore. It's better to be strict by default.
Hence, I applied the series as-is.

