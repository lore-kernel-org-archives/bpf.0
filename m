Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE93D5C26
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590270; cv=pass; b=fX2IJRSNhhjEZKDdzzsHsesV2ZfrmkFS0cZs9sHOXSeD94KRD8FfOHiUA28sk0LO/w+XhTUZh03THckIeiYYiQdn1v8jskq4v4qFdJlikmXc9f9ykAT5rOa9LbRkHaOjA63RHpnNe02p1/1+5F6H5JedmfprOlUPN+so9WYAirI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590270; c=relaxed/simple;
	bh=9BbCAufTONp6k0gKDYhIyRorCOfyEnjrJMpO4e5OyaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbtnQvJCB8McpinEB0khDsdVlFdRL/7mLrkXfmlf7DLvpqZAJUN33EckX2Kf7XuGGqMEEsvKltsMnQ3BI+YMlSK8lbqJp4auTDXhuQzy+EDjfo14cw1LXXtelRRQtjdykxjZBxpNbfeHmrSbyngdXAKvB2+H5khr/Hp2lcEmV3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTI3Uz8C; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTI3Uz8C"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so717541f8f.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 09:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780590265; cv=none;
        d=google.com; s=arc-20240605;
        b=WnnhSpFju+EM1bat9G+PLjoelCUuuMaT/KChw33FrQj/KwDTwwuawS0cvPZTmz7fTy
         l3OpgE8kWtiaxS3vCEQH8l/bxLfeeO1fYPLmMSNQj7ttUDkuUNykFTTnhirzQpMh34A8
         mExxkzhvau1L+ORrs+LBQgvLwc+uGsqfc486N51visjELV0nvsjIvzcWClzp3oTXBN2G
         Ptid+RQOAR9q2lD6SbXOQ/wJ1kxbUIF/QABpTwvfaasCu0Ef59IdD25mL9+yPmIuHtqc
         KCh6w8sZ3DRz+Lgu2t88EUYFF9SfiAqpz/lx6bH80hOPPmqAAU3QaFHgDGE+aqBQyeX2
         G55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a4lEt+snPaiqBXfi5ibFtER4qYIR0nIZwhaJTo5Gqco=;
        fh=/9z1/t/Ojm+8oNkL1n3gUk8lAxgGNr9fRJwvCOKrZIM=;
        b=NOqiH+9OZwmNE/nhZvVBTWxYeCBqUfNb52FIQq2269QfZD2ogxI2Anu9d8g43ZN0ZE
         Thpxwfi9qAGHeC0DtGiVN7DQdExbMEu3QuERTGB96A61LF4G+PaEeRcwz+uPfH374vzv
         E9CLWtS/xrSPJvObDlP55q3ecsJsKJY4TgVXrSjQcEDUmCCA2IFfQt1NxTIatPGX9TyV
         Ba78KnEzMI4PnWto+jDNWxNkWsKdsRj9RPsIGs/j3kZZbpljGY2SsNsnGtvFGXjaUUz1
         U1k4KSG83KuE1x8zW6QvSHA09/Maoa/Cl05/eQV4kvDTv8VVv5EV4c8r8gzDQiENTlBt
         dEyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780590265; x=1781195065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4lEt+snPaiqBXfi5ibFtER4qYIR0nIZwhaJTo5Gqco=;
        b=lTI3Uz8C8ZLX4Ual6g3Zyk0YBMTNzPyvZqyrSVr9z/ukq2SMUG9Pi3Yicg93Qx0bjS
         1GfzOAcEZwbdEqx8DFSeFSMw92WxTvxfgVKnxLVyxmGA68WTtcnmbHUaBPvNty+J9eRR
         lvpViySm8umKQmM7mKZdxM57aqrS3V5f6Rf3WfQTUWU2vHrsYwU6bzDMH8U7rovpfYIA
         MQvjZ3cWTiFOFipc/pPSPQ/UpwS89H4Iuu8z3Aaf05/K+6ct86KsVHLmE74QBXWWLajK
         Hhr06ZqwkTLfcVtx6iCgE/AXvBKkEgsrajZ4zvv9dIS0+wJ/m0Nz4Z1vPplvV6sMn5Ha
         X3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590265; x=1781195065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a4lEt+snPaiqBXfi5ibFtER4qYIR0nIZwhaJTo5Gqco=;
        b=aWsFDHHIGYtpsCwjHiCK5LYvQqMSqUx5NosXEVz5Sojq1O/QUbAtm7mxB6ZUxTD0C2
         78qnxDbcEvMg68IWwEaVhJIocXd1ryiS1gyxf6DYGo1hjsFma0UUHHqLl8fFF70+0cqt
         drVg8eTpuedWZuyXEJuOob88qtNbnhoafq9i88CmAl0X5ECzQwWDkQhHs5EyK2pn/F8e
         I3IJmnkJ/oY+pSAOdohU3GN40yzOameIEQn+yNhDQT5NrMg5cXSHiatWxclPsEFYlS4f
         MJkRMr+Ym4NYQzoAbFFhM+uXRaGvNRuqfSequkmgS22aD4JhQjBQoyYorz5ZSBymPr2r
         Pq/g==
X-Forwarded-Encrypted: i=1; AFNElJ/8tV5zAtW//+9dbh4fwz+FbCwMZ2m2ZrSqlKwGJtXK9EtR7fXNsqh+4De33IqGS8vRORo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMAXBYXQwKfEeh9KaARZABmYfVihnsECkwS/kZ2hEtMkj1rxfX
	BV3g4nzk74Rl8TOJD1JGU9lYlPA/++v2JMmxesiUDTmRhVItzWkep3E6pJQswMiicOgvQy93uoV
	/eNRMzuegcUMaAdR6LUKpk0l8MuiWrZg=
X-Gm-Gg: Acq92OFls2Aoi41wxet+UaBK3V2+JErG4UO5Ql3md+LvnErYu+vhR9Cnj8oSL2Mrl9v
	Kq+rqy4CnDcUTTKDh/yueGbN181maoMTTggC3GHhTA+iG5MeWioqpsjZ8cyx0+pj0jsP6HzVbgl
	M10GMpMdPc2w07MCxIQgE1RZR/A+7DFABFgyWZ37OPxWbed9B65Lzrkw3NkujA2bbmCqN+fIIDd
	qs6i1K3zuAXrIstxNgjHbelVQl1b7EbsxEP+qK5yDtuU86gr1nR5OZsSONORPzlnGSxXYWeDpc8
	skz4n9shKWoQq+cvTxTTykZwvLHRzgw34bcg/+y6jwnbIPUPkoafgwwTW7RwAo3F3Eccz71vfnm
	JYO/R4IeKEHCnRENowHdjH5LpJEfPlfprcw==
X-Received: by 2002:a05:6000:299c:20b0:460:1223:a044 with SMTP id
 ffacd0b85a97d-46021612545mr10027497f8f.0.1780590264624; Thu, 04 Jun 2026
 09:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-2-1a5831230821@bootlin.com> <20260425050557.827F3C2BCB2@smtp.kernel.org>
 <DJ094TM6SLCC.2FU5ZV435P1UK@bootlin.com>
In-Reply-To: <DJ094TM6SLCC.2FU5ZV435P1UK@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jun 2026 09:24:13 -0700
X-Gm-Features: AVVi8Cerra9gLZfjdDMPc-sPd_x4iMjZ6lRtDdyXJ-33JBVXtaVlx7eCj0KWN3g
Message-ID: <CAADnVQ+u=pCMcB1=K_WQ3Ae5ML92of+DA1Z-sKRhHq2KoUJbnw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/8] bpf: mark instructions accessing program stack
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: sashiko@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 5:23=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> On Sat Apr 25, 2026 at 7:05 AM CEST, sashiko-bot wrote:
>
> [...]
>
> >>  #define LR_FRAMENO_BITS     3
> >>  #define LR_SPI_BITS 6
> > [ ... ]
> >> @@ -6493,6 +6498,8 @@ static int check_mem_access(struct bpf_verifier_=
env *env, int insn_idx, u32 regn
> >>              else
> >>                      err =3D check_stack_write(env, regno, off, size,
> >>                                              value_regno, insn_idx);
> >> +
> >> +            mark_insn_accesses_stack(env, insn_idx);
> >
> > Global subprograms are verified independently of their call sites, and =
pointer
> > arguments are tracked as PTR_TO_MEM rather than PTR_TO_STACK. Inside th=
e
> > subprogram, check_mem_access() evaluates loads and stores under the
> > PTR_TO_MEM branch, which does not invoke mark_insn_accesses_stack().
> >
> > If a BPF caller dynamically passes a pointer to its stack as an argumen=
t to
> > the global subprogram, will the JIT-compiled global subprogram execute =
with
> > KASAN checks enabled for those accesses?
> >
> > Does this erroneously monitor the BPF stack, bypassing the intended
> > suppression mechanism?
>
> After having thought about this one for quite some time, I see no
> simple way to correctly distinguish stack accesses hidden behing a
> PTR_TO_MEM passed to a global subprog, as those are verified separately.
>
> I can either:
> 1. skip PTR_TO_MEM memory instrumentation when we are in global
> subprograms, at the risk of missing instrumentation on passed memory
> accesses that _need_ to be instrumented
> 2. systematically instrument passed PTR_TO_MEM memory accesses in global
> subprog, at the risk of inserting unneeded instrumentation when the
> passed memory comes in fact from caller memory.
>
> I then propose to be conservative and apply 2:  the only downside I can
> think of is that a few alwasy-passing kasan checks will be inserted, but
> we are at least sure not to miss any instrumentation.

Isn't it the other way around? Replacing LDX with asan_load() will
check stack access, but it doesn't have shadow memory behind it?
Or you mean to assume kasan_vmalloc and vmalloced_stack kconfig?
