Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C32157487
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676032; cv=pass; b=B4L81TtdPlDPWO/7tOIfe2KreRK+4HwOnhoqSADU6WGiO7i7TNfUgOK0l1ZTRrW2lDiw/6Zl098OwSxcna2mF3Q7A+DByDt4+eouNgAii+Cvk9vad8pZkzIfhR9GpIZEKsw/IzOLtleZVp/fSeqj4sTMX8Q2BGk54kMlhi+Wvl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676032; c=relaxed/simple;
	bh=5K2OqdFd2CdOe5790BPFhI9mbz5gkNhXbnkaiIAeHac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mch9xwln+5jI2faJkMfjs/RjoMcZJ6wUEV/ccl907teJp8L/6NkiI37wyUzVN7txDvg8BJ2eloWvrg3IJ6ObP6L6La6brD+Ozct7PPjEtwBRSqm2ARPbltF90ELJOMZ6MrO8m8TuMGLYeKXEHlghCJY4HhLBYlCzuoBCpMHg38s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqPXMfXc; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqPXMfXc"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a10d130b37so1054053e87.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 18:00:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772676029; cv=none;
        d=google.com; s=arc-20240605;
        b=PfyLvywbCt0I/jbbQuD5kvf4ZBf2zqDKMutXXh/am4YA2/MK0LmixLS62vB9uBiVTx
         JszFHTs5Q4coSTt/cb0QZuvJbKU0WTJw0zV1HiT1M80Q3oySoVxNrpED2jiv2+RwLh+h
         vxZO8GKDLX0Alp/6z7opf1M/zkiilGUFdLDrQX0K5E2CBSqkUfO96D/J7OKF1hCXdqKt
         5YVpdXZCgSvcFTeFpCqI4ltPwl8xqlcLj2BQ84U9P0FuLxi0nwsnOyLSxDKF6zDCltFs
         gHlzfCEIT8Qc3DjUCvTT2bA7a6gVmhAZkXMnlYGG3H/h/AdKVEJVyNB+WolLb+I0SCVZ
         a1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5K2OqdFd2CdOe5790BPFhI9mbz5gkNhXbnkaiIAeHac=;
        fh=J+G8LbaBUJAcpLVu4OMUDFi37gXStVkzKZ31UcBrPxo=;
        b=PJPRnwkG8WbPilM6a2UWZnOWqG1dFo7cQHeJmNaH/mLT8altOAZuVHflVc20BL3TdY
         6KI4fC2z0Am5xcTnQmu3pZbA1UcDtttFpp2xp3uLixsGMn2fFT6c0NJovZxSMzqE7d/E
         vPcR/GWOttmzMlD9j3cC0110AZBTptAy+PUmFlv8fOmG1dUGOSpPnnUXEnESzhB+vxFD
         3YHf6YRtuQnM3o1/kzYThLYWsXATgiaXY88mfXwUKtuWFc+MFViJY1blhQ6lvRoHyqjT
         cIRtuGRhOyvqZm6uoyueenIyo7nAGda8GLtjDGSE0JaeNJPr1v/8Iv4ErsMkanlTysyY
         D6LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772676029; x=1773280829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K2OqdFd2CdOe5790BPFhI9mbz5gkNhXbnkaiIAeHac=;
        b=EqPXMfXcmhf3iqRPJvWRnIFKP5WxB20xlZWRdbLFWQoVEEZvnBi4SwuruQoJKBvcmB
         ln8++fwiqjAviVyGF0+DOIeWm7W4aAI/GawTdh2GVcjiJz4PDM43Xj4qTJrOH3iMKjdL
         d6gF63EEr1VAEBn99kPKKTtCMgAp5MICeRgWBQvRmljc4m6IOCIgVjdkWxzFmLklagbU
         3zvQi/rYBZFzAJ4at0k7q4g9aQYdEHri1RwmgTl22jlFTl8ogRITEVGoA/Zn9ozhp+wv
         UM3NHgz9r/CJwegFaPmp5wUF88lgZdpt6BpgaJzNMR2gvUa1r8KjKro7bgoNBhJnzJRx
         Xj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772676029; x=1773280829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5K2OqdFd2CdOe5790BPFhI9mbz5gkNhXbnkaiIAeHac=;
        b=f15i7iVe/sgDEhq2UVyejOgoWmYIZNhujEmeMtodiRJmSpJQWjxhHqmIghYatbvUP4
         fiAaIUvSixRnD/JGKmQWihx5v6ZNsLxIb9Ud4I44C8cCoDkexYn5B6m71XIWiPJkVnD2
         H3UJ60rymgEG43m8fP+05nRaRii1GlO0YY3jyzN1ajxmFsjChAadmy9J49V1asUyJc0O
         ZlKAn4+TY0jJKBKSI8O1l2grSpbMhSufOkT4RY1SK6fLvERdm9OmIeMGvVIh/srDDu/e
         VxNzMZXLQZ9fqwdIjAlQvT0baQ600MtItLSSKkQJ3dxk3raf2bncxMljk2OkaMylEcOR
         kzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCpJBRwVde31Cd0wN6CQWbMJnGMMopxNFlJMkFLHhKT3gk5eOFhEXESoPwzP9joAPw97k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0QEQst2JbsZC2OXmVXxCdV67Up77liTLMoZjqKf3FXmwCKthF
	bpNnfoNw1vBRbHV7zRQ164s/lW9XF33ug3QPvSmU1FBwIxxWoYbPWnnNGgSp17169FvKYP+/dpA
	3WlTAYevuSCUVmGN6j3bjE8uJANEbPGA=
X-Gm-Gg: ATEYQzxgXXoLiKFtWnIzPrN4I9qZeyS2SxLEmRc/xV3+NVL6kJazlfrqIs3U5h+wcBI
	/dFA1v8DXInwzjR+4+/GRIL8ufa9we66pjS5G121kF4XyOlvNbLJxk22CgpO/Ki4+jKdV1J4Jis
	rTcsIy3pbh5CTRANg4GOaPJM3ovDqOBw6VyU9C+SwOUOpDuU88CJx4pzF0Qcw9KKpUKGeHQQOxm
	GI0fElrtGPtI/m15IwyrZ+iQsg2tGIfPpwTg80TktaAS5h/3u7PFrqv3VLLItLSkMJ8a4wLUmYg
	vfMoRME=
X-Received: by 2002:a05:6512:224c:b0:5a1:1cd2:571e with SMTP id
 2adb3069b0e04-5a131f31742mr169683e87.19.1772676029143; Wed, 04 Mar 2026
 18:00:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABjJbFJO+p3jA1r0gjUZrCepQb1Fab3kqxYhc_PSfoqo21ypeQ@mail.gmail.com>
 <DEEAE764-41EA-4760-9606-341317E9FDC2@kernel.org>
In-Reply-To: <DEEAE764-41EA-4760-9606-341317E9FDC2@kernel.org>
From: Max Ver <dudududumaxver@gmail.com>
Date: Thu, 5 Mar 2026 10:00:17 +0800
X-Gm-Features: AaiRm520Wv1nm2lAU8QWLV6Crma97R3cpDBPxFyChT3g5fsWJ8tnyFZNENkHwbk
Message-ID: <CABjJbFJSYjQ+spicPrTnxkpcLWqSZ3aF-+b5DMKMXqcVU3mKwQ@mail.gmail.com>
Subject: Re: Process killed by seccomp looks live by tracer
To: Kees Cook <kees@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>, Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>This is expected; PTRACE_GET_SYSCALL_INFO is at syscall entry before secco=
mp filtering has run.

It also happens at the syscall exit. Take a look at the result, it
shows 'exit ok' twice.
If we can agree on this is a bug, I suggest the kernel give a hint
about tracee exit in waitpid return value, what do you think?

Kees Cook <kees@kernel.org> =E4=BA=8E2026=E5=B9=B43=E6=9C=885=E6=97=A5=E5=
=91=A8=E5=9B=9B 02:05=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On March 4, 2026 2:51:38 AM PST, Max Ver <dudududumaxver@gmail.com> wrote=
:
> >I was using ptrace to trace a tracee status, using
> >`PTRACE_GET_SYSCALL_INFO` and `PTRACE_SYSCALL`
> >to get its syscall arguments and results. When a tracee killed by its
> >seccomp, the tracer can't know immediately,
> >instead, the `PTRACE_GET_SYSCALL_INFO` tell tracer that tracee exit
> >with no error. The syscall wasn't actually
> >executed, it was captured by seccomp, even the tracee was killed by secc=
omp.
> >
> >Here is a poc explaining what I said.
> >I was expecting to aware the death of tracee at the fourth
> >`PTRACE_GET_SYSCALL_INFO`,
> >at least `PTRACE_GET_SYSCALL_INFO` should tell that the syscall
> >failed, or get some different message from waitpid.
> >But the result are below. Tracer can only get the death of tracee at
> >the fifth loop.
>
> This is expected; PTRACE_GET_SYSCALL_INFO is at syscall entry before secc=
omp filtering has run.
>
> --
> Kees Cook
