Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E67271443
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779554965; cv=pass; b=pmvTGlkMiFDY8EjTyetowisCyf1APHmefPdmYWMhnpQsSCUhN9gn9TuwrmaC/+d+Hi/MjG700zM0H7oFLUO01X6NL37Q2ML670Pu0ZDRrI0UUw+RwIgRgig2QCZGiVYjObFXhY6rGVgzYuS2MF45hsS53nkEuXhiEZbX50mShc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779554965; c=relaxed/simple;
	bh=EIa8bm3wefqdftkj44KMQX6I0eapyj2RnpgMUVefGr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr+22rZCGRsILBEn0GuKwfv60nKgX8ROs/DI5bsUxp4dwjuA+rinsGj3VJ2QxiieKEjawdn2VjrZLrZRtj94DcCKdonoLuLF0xUG0xOSQJLlMkWDhtBGyOQSqgLmvKXdXo1HUCxVtvsOkzdTzDwkEo6EV/WfGFeSgE2437cdsrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMphvjga; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMphvjga"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so86519965e9.0
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 09:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779554962; cv=none;
        d=google.com; s=arc-20240605;
        b=gyxuoMxknvG+4BK10B9uKQBLbSiaxucK5tsf22kCzcdk2t0CbCt2bjYnkuEYk3HoxS
         kozCL6hhPW4vSPfNRcTCMCN4W3veEFAIYnO+Dkez4c4bogFpJpBPx15KAPAO86DbVT2i
         iFIvrgwr43FY6dQ25vEMuTZ8qFosMSVeSlmAE5Gv2uF3joGU5aOIN2ulnY+OZOB611cy
         YA4OxbFz1VKaPy9D2VnRwDkPTMcdFTLjhODefb78Y7P0QERoI3ujkD7kbhjiXDnAonan
         EYwmhcypF1+HMi/jUZbDTO//w8SMK6sKOYyBmb8D6O3ck3oAwHVZFZ9iYlXVOEyxvekj
         gGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EIa8bm3wefqdftkj44KMQX6I0eapyj2RnpgMUVefGr0=;
        fh=KBVwTRsj+r4gmWQpI9u7v4OUUGhRs3MfWcNLQEI9OoA=;
        b=SvRrhts5u0177BoTzcEo8Njlu7RMTZVndv6D5H7wTvW1ZyRAfEd5brJzBWZTBC9yIE
         SMki1GOBzTBodYhvaScnqQpT7kTrv6g9aHMF3bpj1MArqcavQBk6Uae/na3NkCcWYrja
         P/hEFsVM97WoWhaZ1Mjbx57m9ZFMujvgk3TkgbQqaFLBLZNnz204VDbPXvVQnGGThnZE
         ZVqpwg35qMuA/hhIvQO5m2qcsYmSnVRyrroPs0j8S1mHN7y8aNJRDHl/TjOS8whzkGmN
         7MH/pA85jWbQ1YQyLtWUCJ8KbzjDQythID1cKlyHTB2KFi+Xbal4QU4QAcmdV5mRemXW
         Sefg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779554962; x=1780159762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIa8bm3wefqdftkj44KMQX6I0eapyj2RnpgMUVefGr0=;
        b=gMphvjgaFstTp34uoGnV1dbF6GiURqLPxX3ljzQUDBuTARAIjVwi9w5U5KvFmyL1Ot
         6EHLL8E+307uPfMhVDZCX1Eqjd6Qa9yWExfIAvgIb1oDFo/xWETMPuGMhE3NKgtFiLjW
         FWe39RnLbl7wLT1ve/cAaWEpNTX+oRZVu/lzpPAPT8BdLDmfm1zuLJjyQKJv2qq/kXvx
         vDjCK3OeLLDq5hBgKzeYagVeVTYuC4U138PgmiJQYu9QWMG4RjMAZ5x37gaCkRpuxJ9+
         hldDUk9tcQmCsxGsHc5KkUoKpIyrUZy1Y+G3Flc79DRn+Je/ccF2sNkPE6nGWIcvBQIp
         Tjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779554962; x=1780159762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EIa8bm3wefqdftkj44KMQX6I0eapyj2RnpgMUVefGr0=;
        b=n39CsobAnQhG8CtZa3W36MTB/hlsRANpChECnbx0vNdOlsGmB/YjcZS010FdXqBFxl
         nlP+B9Qkf0KTlR8gKZX4uf55fNpSowQkOb312ZlHGPfHH2csAWWq8e5AMcyEo3uQtrKh
         aE4UULr+mJ1IdQ1zqPwQSNPahpztgAlnDUfbA6X3KPn4GthVrzuHJLF7lyI3HKBhevOn
         t9D/xzBjdAtEvkz01iHjx9S1RO2N2Yx0XDLndYJAflfaOKVJkn+MRzW3Y/2WtHaUM1Wt
         Ke2Ejlm46yvYZqtk6FfqAvsLtw92iidkFD08gVYWG1QY5l9YBOBrxeqUF2EBZSYAQqEQ
         AUjA==
X-Forwarded-Encrypted: i=1; AFNElJ8ysnJoQutmLk1YSQMTT4BEfcVdEl2RwknLvmOTl+5bpqa84Rr+3DK5MCgo77wgpTUpKSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/G3+jpzyjeQHWyfiDU+JMBLcc10azV8NpUmNakUUDh2cdStA+
	6xvbGzbdb1Y1BiVfQkYlkJETrkI9e0fctxlHby7B4Mp/Ht/T5V37D9QlzD47jhmpbK22bTEvfl5
	76JJ93+DwafyonkqTmqQ1n9DONEDMm4l/TjFEmdQ=
X-Gm-Gg: Acq92OGPHLgXHpyQVbIMx7Mn+LeH+XkEdu6RiN0QJlbZGgs29S5pVi9Iv+frW0YPgGP
	m1mlv6U7R6ubjcaiTbdROM/P7QG1vbubM0EgW4OhhL4OnAHadYYDeGZod5sEdbxODs0OLjneBRl
	XhyNrI4Dcl5UhBgDcNvxSxphi7dQtXOTo8Cj/Lj14DMokv7x6Vm/vnaB4vpiIC7bvLYhwoMud+Q
	Js6WsSMqiwB1coftp0Ziedi7tnWgUXlxUtwCgzvvsmVgZhzVbk0lrcA4O/AMjL+XZiE04oC0KdT
	ht57zqUdIfb+ZSRbVLzuqmvNMZsrg+CzQAmnCAS1W0gPG/nSCFvFTWcUHnkyi2TIY2LU
X-Received: by 2002:a05:600c:4e0c:b0:489:1a63:509c with SMTP id
 5b1f17b1804b1-490422608cemr136597435e9.0.1779554962257; Sat, 23 May 2026
 09:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <20260522023234.3778588-6-kpsingh@kernel.org>
In-Reply-To: <20260522023234.3778588-6-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 18:49:11 +0200
X-Gm-Features: AVHnY4LErFJSCm8vXvIVuhSpX1QDsKcWsBatlBn4YeIC0InaTOnQJ0A0Ch0pTNM
Message-ID: <CAADnVQL4ZXwGwxBb-Z6W1m3K8+Vs8HYUZQa5-dvpqpy-8p0cgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/13] bpf: compute prog->digest at BPF_PROG_LOAD entry
To: KP Singh <kpsingh@kernel.org>
Cc: LSM List <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 4:32=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
>
> add_subprog_and_kfunc relocates kfunc CALLs by patching insn->imm
> and src_reg, and bpf_prog_calc_tag has no rule to mask kfunc CALL
> fields.

add_subprog_and_kfunc() doesn't modify the insn stream afaict.
Do you mean that bpf_check_btf_info() resolves CO-RE relos?
but loader prog doesn't use CO-RE.
I don't quite see the point of the patch.
