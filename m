Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D86352C28
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017759; cv=pass; b=YIc3MCcUF3MEmob2/ejj7EHd1D2sb11IbQnr1J6UmjztiWtV484v0Ujaauy9IHqziAP9X/NqC2Uk2Y2fmTHjbc9ocyU3JMJFOiKZsTaNA4x292QVCf+OXZ6nCjHZ0aO1OoATAIR4MEGhX4P7BG1YhQQ0U7u9CSYxPpWTnw/fJCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017759; c=relaxed/simple;
	bh=bJFETVB/8s8S+qYtgcKAGSY8PzpZ48UQChgv+rtMJf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+E8sORXmiJlsqnaCCqlXBYejRpBQT++C4XLD8Kth+s8BWkp1FGhkO/vS89JsWx+rKWMvYV46dZFKBGOdvnuCM4MUu8HNJ3IWKAZuKz6zpqMrgFIgM26X+KtxEvYVfdF4X1WHnK19+pz/lbxk4TRxzWjjKghAD7rC7Qr8edFy4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS99YozO; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS99YozO"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5014db8e268so789311cf.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769017756; cv=none;
        d=google.com; s=arc-20240605;
        b=HbUrfNE8irGSc1ublJg6L8/9Mnb5BwsMsqsIDCI6bVX/g3dJVAc+1O7ocvNVd+VBMx
         PZJeWhh9dsLZmr7SM+zTG2lk6VcxMFGaT+URSqJp8S/5jleNpsgMqIypGvQoa9etGuAn
         x3yd0a7yuL4FDcZ5Og0V8+Rwy1YwKvMjJ/+g1naEW7SBik0N6dLhMwy7SdMYHHjtpfKD
         knEoM6XoTx24DXGshdfp/Z2RRMAUX6GNKNLq8OLXk7XCI5B0VYsjlyGXZ9q/SbBBHg5v
         n1IMRcWxqsVv062ndtLDm8AaNFN/iPjOMGMVHTtgJ88xGzqRMggiPJX9aDqFPymbFhir
         n50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bJFETVB/8s8S+qYtgcKAGSY8PzpZ48UQChgv+rtMJf4=;
        fh=dk4wZ+ry5KDS7K6AmBfoiueciaeqbt+RcoEgoKnM/4k=;
        b=P73HHxnWJFxP+WUlXeDI9Yl+0f8GOdhBBwF2ucUMORyrpiWZ4MUgsmn/jXyZhabCRz
         HF+Hji4QGGL5cEF1Vp3XWWZdx44JmG6CHNuYLK2NWCALmrl7bjMNpryPmytnlyaISy5w
         uTEeuaPL9cM9oPIO9IsH+RIbUBa0IN0wvvYyGpHoK5g2S6kvkz5zpQRPDvYSwvqoldUL
         87VWV+XMfhePyXR49A3h67cAjfqAuHOszq7gBISHmpnmOuXNkXy5JXPETUJrkAWNwWTV
         O9IEqwYYF2qmILq/WdIcxi4IjkbLUNcPXrfs1BzQZ2hV96P74Hs9zpKTNAb8vHS45Xca
         RLyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769017756; x=1769622556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJFETVB/8s8S+qYtgcKAGSY8PzpZ48UQChgv+rtMJf4=;
        b=bS99YozOfoJEhLuWH+S2Ufx17Dqd6EaKu0zsUKsj/G5YEfGKcvr0OYJXtfT8lNC69o
         m/+uZYWdBdrTKrL8QEpikf1epZgr0u98df1nW8cbo1g2JnT99K5sZ0tpzQaI23w0xv7D
         TG3zcc5qIqqcjwJ9bG3PYu/8JoqCD4cuIW2zHPMLs5wYjgj56H22gd3GEdg+SVt1HX32
         89x4MBhHLN7ZYXnArAb1GGwhysTKUesVbGmwmcbG0j0xUjGQ4eQw99fDGS34cRPhfLSw
         7mKagQDU9+yEFd69iTuO0NMcz7wEuUfY2XTEgrwlJsbvowgBNrRv+aSPaye0E+Msotlu
         9VoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769017756; x=1769622556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bJFETVB/8s8S+qYtgcKAGSY8PzpZ48UQChgv+rtMJf4=;
        b=QNdcA0Q2wzt3Fh6QX+ejtJjpi+JcTeIfNbOD++Fr5ps3L8azCJaNGRzgUl/2b+nS5g
         Qxj1w/9nAeKYdjEAxtj0J5h7MmNzzZXVdp+It9ONAftHyv+5y0IMozjoSvMZw1xdv8l2
         mzb2OEh2rNr3tA7pPpqQYIaSzQrbSne2GGqgKZf7EVxxgX+GCYNuitXXRRSODSG7uTXX
         bphabrhoDDKwfadYu7qkD4Cs23KK8ZPwf8KYwD2PFdM7p5PwzOtAkX39caDRaKUBH0LR
         cVPppuDYsaoQfi/9FONZoVJwEhoO+WMZREfLQQfPCX4pmXv/TdqVmPWIdihYLMMJYo22
         aNyw==
X-Forwarded-Encrypted: i=1; AJvYcCWLwcbjiU4dEn5fwekcpIvoapFyES87N7vxRXj0gi8hfDoC3MbEciSF1Mid+ANrDV3Mlnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrSMbgi7JszGB0ybdZa4qBcRf6lJ3qjYI2QJUhKU44qm2JFkJO
	+kdcCTGxJ92MYNPffTZTUGjYZ5PMAXTgySQHdLA1/GL5nOtFTYaR2XtvzssvWWMurhSYe1oP23c
	OcHey9qZHRyb8oieqgJHL5y4lGCRsNA==
X-Gm-Gg: AZuq6aKJqi51l4LRN1C7kJxgtuIB6S7BDzCGrLm9Vsu57o1q7NK+L0Z2UhFJSz1jKCf
	PBX3zxXhpnoFhbn9PoI6jhEYxtzH6HT0ywoarD72iFSBAmDwKtKOYFo8RhEEPcvgKL6JW1SQcrI
	PH+fbSXWu3dLRGkJlOor+tw10UHtOklUCz5RItGhfbuvArJbGz1fNUP1RO8z9Wz7Ht6emnOcqEh
	rlqKhtIETX7s6hgsmsGs9RyWv7N6Q+wOq0GVRVo+Ai372Oaj+BB8i0z9pDOoK3/p3M4YQ==
X-Received: by 2002:a05:622a:138e:b0:4f4:df23:ab5d with SMTP id
 d75a77b69052e-502a1fb819bmr246174781cf.75.1769017756125; Wed, 21 Jan 2026
 09:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121094114.1801-3-qikeyu2017@gmail.com> <214f9680-b4ce-4c20-85f1-3560624fb49c@linux.dev>
In-Reply-To: <214f9680-b4ce-4c20-85f1-3560624fb49c@linux.dev>
From: Kery Qi <qikeyu2017@gmail.com>
Date: Thu, 22 Jan 2026 01:49:06 +0800
X-Gm-Features: AZwV_QjH6BXPXrkEVHqbCx-mJw09CMFyRNHihec20xuFw-uHKCUvM1lTXAVPTr8
Message-ID: <CALEuBam-2=QcXHH81RPdEcQ6zguY8EjzUt-Rh3BW=fn4F7vi_Q@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix resource leak in serial_test_wq on
 attach failure
To: Yonghong Song <yonghong.song@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, shuah@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, yatsenko@meta.com, bentiss@kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the review.

You are completely right regarding wq__open_and_load(): if it fails,
it returns NULL and performs its own cleanup, so an immediate return
is correct there.

However, my concern is about the next step: wq__attach(wq_skel).

If wq__open_and_load() succeeds, wq_skel is allocated. If wq__attach()
subsequently fails, the original code returns immediately without
calling wq__destroy(wq_skel), which causes a memory leak of the
skeleton object.

The proposed goto clean_up is intended to ensure wq__destroy(wq_skel)
is called specifically when wq__attach() fails.

Does that make sense?

Best regards,

Kery

Yonghong Song <yonghong.song@linux.dev> =E4=BA=8E2026=E5=B9=B41=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=B8=89 23:45=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 1/21/26 1:41 AM, Kery Qi wrote:
> > When wq__attach() fails, serial_test_wq() returns early without calling
> > wq__destroy(), leaking the skeleton resources allocated by
> > wq__open_and_load(). This causes ASAN leak reports in selftests runs.
> >
> > Fix this by jumping to a common clean_up label that calls wq__destroy()
> > on all exit paths after successful open_and_load.
> >
> > Note that the early return after wq__open_and_load() failure is correct
> > and doesn't need fixing, since that function returns NULL on failure
> > (after internally cleaning up any partial allocations).
> >
> > Fixes: 8290dba51910 ("selftests/bpf: wq: add bpf_wq_start() checks")
> > Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
