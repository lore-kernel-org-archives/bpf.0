Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30040382392
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116328; cv=pass; b=rvfd53gkYZ2YCbaLZ5cU0oodE26wBziy6+0Bjkd+Q4kB2DOoQc/TducxkMd21gd7kjJpzaBVOhZktiYGppVvtF2k2iGZ64/35Jikfvn5lsz2NHcSuWxMk5HGaJvBI+vfqp4hEGmA51BoHtUHVAmuAAkWfVuU8Z+QZsb2SuMtdkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116328; c=relaxed/simple;
	bh=RvSlqOQSZukCTfHZ5R6+udcx9GlCy+uBqLrTdJAgRAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhvtMTVCC6i0nLCKbTeZTNsrMM+tcwqs+vx1XAhIddBNbF9AVB+5iYw+1QCMAPpNm2J7xClzEwDpEFJluxrhNy4CMdf6SON9utSIMrXeYgcxHRzW4jbbcUf0FVUZKd5b8KhTsPVRYVHpn9iTb5NsmUIQ4UZ42JQkDGtnsf9Ll+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyzaA7De; arc=pass smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyzaA7De"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-6501d242e3fso577435d50.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 00:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775116325; cv=none;
        d=google.com; s=arc-20240605;
        b=BdibyvBEyc7RPH+0TbSxFD+mxGuV69dvxRk6ErGyWHqmfx84NsUJLXGnMcI1YpUSYY
         il8aqBkRjCSonpitcDWcRoj0JZLIjtURcgGlQscWB0MffD+9GZwhakjDIfImFmyLD/hh
         wQhznnmw7z43p0uwcSMp+eqVpDAvSdyfY4fL8TVj+CtQb6u0LCkg9lfl42YkKcD5/wo1
         M0h5fBnrzr9rEIn3XIvSiHRtMbZnsYLiStFfPTkR1Uy2h6TGJ8ae9kodQZT6Hlzp2H78
         fsRNsmdns4/jUJ6QBT9UfEmZz3tRDSeE5Cp9YcQUJflWx7+8vZCpnLUMYcmIR0ne+wXG
         7nRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yyqzj2ci0pj2a+dzQTl8F1rVtzKEVbe+13yhnPyjMTM=;
        fh=DpeVgIMTg874aQvt/jB8Wq1FDldDXNNQP1tO703To6U=;
        b=LfpvSA5i9EtmmXRfwtLyBXQwUt/SGpQhutMGXj6RTLSZjjYtqKyecuFBv0e8N4GB8G
         V+PVFV6W0PFtiFQrJQLXTYqLh1Kx7NuWMg1pH1idf4kRvc41qhjp7tu0Ueso8GRsbTpy
         M7N6TKHqjfBr7fNUp8PYQDdirYxbffi7dlJRpu5VpTcDtKSRTe1loeoFR8X9GDTkh9mC
         gHPI6rlpTwUL5OflUGt+QEARRp7bTn/nnnlXS/A65a/yNnYrUBProw5JUdEKg6Y1fkhF
         uDzlcWIfn+NagZHSkvMFxS05Z6rAJOtfpmoU8b6GxjJGtpC13XS83byQ8L6XyhXSiewH
         9Atw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775116325; x=1775721125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yyqzj2ci0pj2a+dzQTl8F1rVtzKEVbe+13yhnPyjMTM=;
        b=NyzaA7De80PEFXTB7s8zteRVbCz1xla6Mu7uqpgxd930ZWnSZTBUwLkarlBkvJrhP7
         LLfU6JqwUC+94oF5Qsl0ce6kD36Cp42NB0XsLhks2ER6xgzx4xj/ZvyHcE0ON3UGm0/D
         NgZBoRzhPzGFO28JZNxALaqi80dVhhrA3nlm9lgpBIPKm/TSiVdU+Jgr+Q4C8Vh7GdYU
         GDH6Teglv5QmHypHt6Lr58ZovB7QSIJI7BpShaGtfn86KINAeQe5SVkAeAVE5dIcHm0Q
         X0JA5qGP5WSLHUjnDByFsKZKTlC7zSQuDDKv2rP6h5BM5OmaR/rWp0fD5bdlHPqbwik1
         oM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775116325; x=1775721125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yyqzj2ci0pj2a+dzQTl8F1rVtzKEVbe+13yhnPyjMTM=;
        b=SZnK+tg3YfJ6i6tePX4CGa5B4xR51zyThQxEv04ik/XVi40xn4vzEXG/1cd/dBBjlm
         E07yU1LPetNd6GfSpaJ+OYoauukzePGfqpWLv5ALlehiU1udC9CqY34Py2bkMNFKPW8B
         JirZzycxc4jKc/pMvucI+Mb4RgW6R4dQXCEeFv1/z2rnMmRAKgqOGUajxgomPtk7QVZA
         WlWFrTsRZ5j9Zu0rh4193vyKVtq98nqYm8a63SdoVyWXiu+3wq/xD0p3kwtg9D0MMRBH
         IuCpJIuGAvOt4sTGkPOEpCzHoz2a33Ce2PpTyJHaKe78u96USEXTLTHdWzBTNsCsTh4X
         YA+g==
X-Forwarded-Encrypted: i=1; AJvYcCU1ZRyYuI1tKIynVXWK1VdPXL7oox+goucLsGv3tLjiEpu5rjc5w+NYdj1MARRAetwU82Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZoFykI3tRytZyCEvv+0BJRNOQcSuflny/cc1t6iCgigMCmiw
	5oWft70V/TkP4Jl+PRIVTTeWV/Lbhv77mM4XZj9JfqHgR1PL91lYNxP1rIlhRIY0yauxVk93Pni
	74DIlkK6Hb8HD2BHhdpv9HPQx+Tq2uRI=
X-Gm-Gg: AeBDieuB+OUvr4VQIdzPzO/CzFBtRIi6JPI+LZecrepFuonDNOxWgq8UvgfeCD/9YNn
	0yR0PsYt1BL/GGvaacgFlpbCtOWu/DqXsEFHO3I8Gj+6CkVVDSEg/E7hDSzROyPXYuqVqLD1vl8
	QldWMoW1bqjYZv5nAMuV0kqU3n37FGLFP5gXlWhz8R7pfbNjTR5dptQK/byfMwXQUfe71+NI6+y
	mpS6ezofAy+rqmaQ5layfFnZz7K9Kt1ONVyRgn9Pl2AvBeZZ6x5Y1yddj/eJiRhAspq2hP+3K8W
	VHXwkLPLag==
X-Received: by 2002:a05:690e:2550:b0:64e:f106:60e6 with SMTP id
 956f58d0204a3-6502fe6a29amr4650514d50.57.1775116325153; Thu, 02 Apr 2026
 00:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118123639.688444-1-dongml2@chinatelecom.cn> <20260402061251.273705-1-leon.hwang@linux.dev>
In-Reply-To: <20260402061251.273705-1-leon.hwang@linux.dev>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 2 Apr 2026 15:51:51 +0800
X-Gm-Features: AQROBzBHmTyM7mG6aiqVl7652RBU8GMP1j57JJF9F1xGYP4p9m1mpS4hJciVsSg
Message-ID: <CADxym3acSo0gXO-K+=ZJvcT+ne-He06S8QcOwCKyzNDHQHRBQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] bpf trampoline support "jmp" mode
To: Leon Hwang <leon.hwang@linux.dev>, ast@kernel.org
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, jiang.biao@linux.dev, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, sdf@fomichev.me, song@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 2:13=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> On Tue, Nov 18, 2025 at 08:36:28PM +0800, Menglong Dong wrote:
> >For now, the bpf trampoline is called by the "call" instruction. However=
,
> >it break the RSB and introduce extra overhead in x86_64 arch.
> >
[...]
> >
> >Therefore, we introduce the "jmp" mode for bpf trampoline, as advised by
> >Alexei in [1]. And the logic will become this:
> >  call foo -> jmp trampoline -> call foo-body ->
> >  return foo-body -> return foo
> >
> >As we can see above, the RSB is totally balanced after this series.
> >
>
> Hi, this is a late footnote for this optimization.
>
> As this optimization landed in the 6.19 kernel, the function graph featur=
e
> of bpfsnoop [1] cannot work because of the missing tracee's FP/IP for
> fexit.
>
> Before this optimization,
>
> caller
> -> call icmp_rcv                caller IP/FP
>    -> call trampoline           icmp_rcv IP/FP
>       -> call icmp_rcv body     trampoline IP/FP
>       <- return to trampoline
>    <- return to caller
>
> After this optimization,
>
> caller
> -> call icmp_rcv                caller IP/FP
>    -> jump to trampoline
>       -> call icmp_rcv body     trampoline IP/FP
>       <- return to trampoline
>    <- return to caller

Ah, you are right. The target symbol will disappear in
the stack backtrace in BPF prog, as we jump to the trampoline
directly.

We can pretend a RIP in the stack for the address of the
"function body", therefore the target symbol can show in
the stack backtrace. I have not tried it yet, but I think it should
work.

However, I'm not sure if it is worth it.

Thanks!
Menglong Dong

>
> As a result, the function call stack entry for icmp_rcv has gone.
>
> It can be confirmed by bpf_get_stack*() helpers.
>
> $ sudo bpfsnoop -k icmp_rcv --output-stack -v
>
> In 6.14,
>
> 0xffff8000802bda44:bpfsnoop_fn+0x6a4
> 0xffff8000802bda44:bpfsnoop_fn+0x6a4
> 0xffff8000802bd064:bpf_trampoline_6442573163+0xa4
> 0xffffc7825c984df0:icmp_rcv+0x8
> 0xffffc7825c91bcb8:ip_protocol_deliver_rcu+0x48
> 0xffffc7825c91bfd4:ip_local_deliver_finish+0x8c
> 0xffffc7825c91c0d0:ip_local_deliver+0x88
>
> In 6.19,
>
> 0xffffffffc0209069:bpfsnoop_fn+0x449
> 0xffffffffc01ef2a4:bpf_trampoline_6442568724+0x64
> 0xffffffffb1085cda:ip_protocol_deliver_rcu+0x1ea
> 0xffffffffb1085d96:ip_local_deliver_finish+0x86
> 0xffffffffb1085e95:ip_local_deliver+0x65
>
> So, it would surprise users who care about the tracee entry.
>
> [1] https://github.com/bpfsnoop/bpfsnoop
>
> Thanks,
> Leon
>
> [...]
