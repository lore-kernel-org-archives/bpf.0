Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC22325485
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544025; cv=pass; b=jo3qsrfcIBU0k7XdNZtEr8ky9wp7mBtNd47WJ8tbs4TcHQF0lHF4C20l8IdkCJJc7t4tc0CF5jWlike40+rdD/r6z0FgM996P9W3alIig/ojRCxQCJVh/m/Vgt7KmUKW+KzIfXBMLf2Sn99Y1BYl48MYKS9c0CamGx6ss8gqxc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544025; c=relaxed/simple;
	bh=A3PqtdqzkiyzeZpHgFTpllG6L7qSAtCCqgipTPm/urM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roEQFqYYzQ2JGEx+bVMhW5AX6wJiuTIs/kgkLQjhXzwdNktJP7k5fJ3QEDGTmk0u8zYPqluxDkDrGfM8dy6aSrRSn+a7x0xz3dXpcIpjohH8umFbEc0DjRXWDWDV76zRON7x6dDVg5kM25kje9MaCNsqfjsWSpJfMDbyvh1LC4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzXE0vy1; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzXE0vy1"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43b40003d13so858680f8f.2
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774544023; cv=none;
        d=google.com; s=arc-20240605;
        b=P5PiDLeHZBjC02/bQE88hPGC7QnSrn8BHbUsiu/A+O8Xanzg43M26rSiP0wkuxYpen
         9NU2JUygnoCpLvuX+qov1Nqi2JJe5cdBXvFIFupN8CuK1cshQW5c6KjTitTWiKNhsn7Y
         XwRWxLXn2fZcXjPpqQ6Qud+Y5Uc/EosS3KkZt2Xht2e90SJDdHI6d8YPDeBmi+JMvyIE
         ukCqKOoFQH6ExCcsDk1CzymnZefenwAFM30WrtB03byRjtjOIGslwMNQ8fjTj9B/U7xV
         KOTO+DJSXJqjUv0n8HrKo0JcIScJlzxzMdC7KDe4p115tb0i8o03NhGWSR1zfSByMGw1
         ALiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=k04eIS2j1nJe9MtCSKxboEDXj2ttdan/54E20AyItdE=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=lCv1RbieFsMdNdDEDTHOW+OStdRDjM10Qck1p40P2jHbKe3enQIqDYhQpz0oVlcZOo
         jTT7vuW2oYMUKCOjZQNC+mDpNj/VAVgQ7lyVMVNmGp8uYtl+CUoE7CrCJ1rbiaFSshiu
         qe0N1Hdse8QKJ6NOiHAJmPX/3CBa93YhcU0C0sSvzWO3dSRl8oJDM6YYWL2/g4Kg5YxN
         XZyEXXeHdbk3wxfC6FHMzYgK88u9YZqP6R433kdK1TrC7yPCo8gUe3ipPjEvnpLXrVYh
         lJ4rlRm77HRcBJMw2fCfrmR5W9FQD+ngyr9a5WulSVLQAGW4rzMqwVayz6jk5ZNKH5G+
         S1cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544023; x=1775148823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k04eIS2j1nJe9MtCSKxboEDXj2ttdan/54E20AyItdE=;
        b=GzXE0vy18LXbqptjrepr/xVFDknhXh+dMadWo9/TVoNfPNQ3IDtZ2hLjo0Vb9H2uB1
         yMZQQF7PaI/eihskYD4eyAhaNRcVwPS06dpXIj+RyBPQsFXCzMAY4058HyFQmgflzo73
         93VLW9Ig90O05gC4wgPu+YZaniZClgMXtzM5zNjS98YfVt1Q9NSVugpd/0UqnswHJ03i
         DcJrqgG4G3v8uSRs5vtl7gJ3Ntm+7foH8DbgNF1QT4jSGFCLU/fslnx2MzmDvXbmkstR
         EkVLrY8sQTRRBCN/pCXItz6qpgV63x0C4MTp/ieOrmo0EqCyC7oI5QFAdjJB2+kV7zeu
         ovRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544023; x=1775148823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k04eIS2j1nJe9MtCSKxboEDXj2ttdan/54E20AyItdE=;
        b=mf0O6cTMQj+t9abUcjzp/kyV2En3rPnsprKuvg2j1I+KXV0Ux/wH+zxDiTAzCv0Z+/
         XUQIrG+lW86dUd4WWXRds7bziQ2p7l/W9A+o/SpHIR6QVZLzum6j88CY3QFAxQsVJrsd
         hOE3gUCy2kwbd04Ykt3+FKZXh4vbaztiEZTmpAoHrkWiVXsEyySjUbEGSeEjHXk76rVY
         7zjBLbQ1xV83lTzkO6xf0i6FNcOInTVRKP/8Hjml8LT9RaW2s3IcWHq2W6HrdzQVMq7t
         sCD75VyzYetfAtq9Dlec0orkLLUpAahylsuQ87vvMVt6EfLA5E3gvT1IwEnhHsuJXOu1
         W/eQ==
X-Gm-Message-State: AOJu0Yy5i2ma4aSdZQ6psaGYlWRDE2ZVHFymdCMIkcn1EOFCy4mVI/Xc
	OW73HETlYtCSx//SbBS9/H8k6eKVrDgBhDQl4EBMZMlKFHlHxAb/Hcly9w2OuSc/8Jjyk4CSIrw
	Li8wX60gsbgRaCRoqTCuhXtgWAzJQLedH/9oYwQI=
X-Gm-Gg: ATEYQzx4nZkB2axqZj824QBvU9jNZOhzuWz1OhQ3mYd8QbJz69bd/Rc0iHaTksDtj/Q
	WpyszKjmIE/iX06SK9y3fuffMGWmMeKO+LWMF5e6jhNHvtjbeGaSXLRv2WNXPb34efbrc3eIXTy
	hRNLm82xOTrzoYa7KszeZVEELur6bbKpNNSTguiaEuFUQ8iX845mA3tYo4LEFGrG9SsjC/yd7lk
	VxDm6082BksrDfNBGsan6MSKhnIEDQejdxP3S6o7WjrfoUAmytDSLIQiFfIScf4WsgxIW+dhHhB
	+HgjRpnoVNy8g04MvX4ecrXdGT3CM+RvTK+kJ6NTlJXtd97elUIBn1aFSlZrASaA5nRl+yc=
X-Received: by 2002:a5d:5d02:0:b0:439:c9e0:83a5 with SMTP id
 ffacd0b85a97d-43b88a41347mr12674364f8f.54.1774544022538; Thu, 26 Mar 2026
 09:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com> <20260325-sleepable_tracepoints-v6-6-2b182dacea13@meta.com>
In-Reply-To: <20260325-sleepable_tracepoints-v6-6-2b182dacea13@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 26 Mar 2026 17:53:06 +0100
X-Gm-Features: AQROBzBPfHyFm2Gd6rlYwZ0z2pvboAMpyF7usmbcytRkkMuHuc8QEF-uMGXrLsM
Message-ID: <CAP01T761uVV=xizguceH7A7+r8V-W-tb=bXGzHp+B=T7=Q2LUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 6/6] selftests/bpf: Add tests for sleepable
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 19:56, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add functional tests for sleepable tracepoint programs that attach to
> the nanosleep syscall and use bpf_copy_from_user() to read user memory:
>
>   - tp_btf: BTF-based raw tracepoint using SEC("tp_btf.s/sys_enter")
>     with PT_REGS_PARM1_SYSCALL (non-CO-RE macro for BTF programs).
>
>   - classic: Classic raw tracepoint using SEC("raw_tp.s/sys_enter")
>     with PT_REGS_PARM1_CORE_SYSCALL (CO-RE macro needed for classic).
>
>   - tracepoint: Classic tracepoint using
>     SEC("tp.s/syscalls/sys_enter_nanosleep") receiving
>     struct syscall_trace_enter with direct access to args[].
>
> Add a negative test (handle_sched_switch) that verifies sleepable
> programs are rejected on non-faultable tracepoints (sched_switch).
>
> Update verifier/sleepable.c tests:
>   - Add "sleepable raw tracepoint accept" test for sys_enter.
>   - Rename reject test and update error message to match the new
>     descriptive "Sleepable program cannot attach to non-faultable
>     tracepoint" message.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
