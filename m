Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734462D29C8
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 03:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495142; cv=pass; b=OI4hCzFSrGLykJD982RjAde/3OvWRiuPDgEhlyusXHjWygaZ3GuCxk6nESJSGKOnCl08yFd+osvuTKTKi4SzPFw6eLOH0ym3hxmveFhREIltO1KBb3PEmrsVeblJcWrd7Y16M6Nh98QKdlWyBKJQAT3VmcKs3BH0i6wtRnx3AcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495142; c=relaxed/simple;
	bh=d5a3LPOnYYTA8cGNB2cCIBaXlzkJq3L4AMUVgwKsjqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZcLrVjjP89jCRi27y+WbSwHFnSJXRAym88VDLhtoAIaIdCwfdk6xwsdUiYRXiRATr55V4o18geZ5nRs4u7q8EcV3tklfgshqZ3KRDkd8MtOSJcWkeLLitLgZrFD2ZZkLtzlsJ0Xq1xEuUnhaOYOCo/6mVV1cjiMHbkeTkgkrhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwwfpCEA; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwwfpCEA"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8589498839so1080872a12.2
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 20:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781495141; cv=none;
        d=google.com; s=arc-20240605;
        b=RPagm05+NapcGP58hArNHll2IaW4JPn3UgJ0/PW8VmyOvyO3YEVdHufqTl6UTKEazv
         5HMlnttllwRi9Vb/Z17wLSMCIazfG29kblq02tFiUjKjK9mv0OwoXec/ln0R6cnKWEvO
         X+oyH5PPInJ9cW5/Thmx7QO/d1LcTcHu1nePNCBbevTiCgI7fmx8BofwvhSV/G8v09W4
         hGGjnCeSZHUcV0AOUxLAWlXLP/+rAwDBA+votqZYbEH+FpkKuzyRecsnvU6bpZXupPLz
         XY1085HFOrDpkPEL3MUxHLrOeHY/mLniNYxe0iSMoaQnTBUvsSrQy6zEjdTaUS+egLoI
         LHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d5a3LPOnYYTA8cGNB2cCIBaXlzkJq3L4AMUVgwKsjqY=;
        fh=flobZ47PjbRsnTF3AK8Oal5JK8c/ynzxVxrw9rZrD4Y=;
        b=OcXsSGmXys75gLSoHbfn3VSNz9T5FybGKKnMYh7pB231+IaOETxog5jbJQQorvjrOZ
         VLyhbJ4ztjfjMyBjUio3Q0XmlOdTK3GF35vgg0TyOO9QpzxaSnafSMkjfidhMDKUC4DE
         4+vtM+qOD0qte3zPZQUkeYvsBQELSYLRi7j2LNSSHMMrVF8Uw7gVNAJeV2/E/i+3opI8
         98S3mTk1bhIw7xAApPg9gcO9bFUEC0sPTCdS5z8oJuey0cBAsjWqiV6sphlzloK1+CsZ
         esHkEgI2N8D5/RYbXLh4JCrzmHG3SoFe1i25Vpm/NVzeRTbT2hpKM8xHuJsB3GIkNi0b
         nxUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781495141; x=1782099941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5a3LPOnYYTA8cGNB2cCIBaXlzkJq3L4AMUVgwKsjqY=;
        b=GwwfpCEA7ahr8nO4OcXZfazJyIb7F+chyDlwRUJ4mn/ZahNSMZeznks1gJMQ4G0Yez
         fPJ3Tuu+9IuGRhqc4mpLKL3QQWErUQyCw/l8ulvo5vJd6AuipiQ2Ko6JX3knHRfid7md
         qt+ThTHaZaejO93r+KWh/sPSbP6VdSt/SyE/PUR6CorkjWkWp38r4L5Yfjhj0YwrfT5k
         xZXJsikihVIOr4HRx8GRu29FDfxQx0gSdrDZwjoK7dbQXWuzkGi4two0kbmLWmfalKnP
         CwB7iHQ7/Au9/xLwnLhN8Pa3XefPrYKVjqM53lofhkiLYvW7BLqUa08TPlYcvLaOrFh5
         Zhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781495141; x=1782099941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d5a3LPOnYYTA8cGNB2cCIBaXlzkJq3L4AMUVgwKsjqY=;
        b=ivvTyFb8lSZXTLQ5pQONPwBVbTi99xWniHyeqeX0rE9FHiyfsbf7QceOKtg4AfhVdS
         nj5s8Ra7Tx8BHpJgBFDdRhmMiOcNFtNQHzLxfeBVdcPKu+Two5s9fjXbipGiKvvYXcDo
         2kam8OG5fNlGtN9rrKhL2benqAbo4SBME2Znomj/Fgl/p/hriQfFRJgqJWnepAQtMy8g
         cpcpXjMMFcWKTK2sCHSUih9wkpP6bCZ5peT3rq3wJ8hwoT+TIqDfDsrSlEplVo1YoOk6
         E7L6GV7kAnHvWqZsB0T8dm0CF3L+EvIaT/36CKNJ73iBRFQcXysrz11F3/engcbJeiYl
         0n9g==
X-Forwarded-Encrypted: i=1; AFNElJ9gO+gC6CY4jRTs2ar+f+a6PWO+/bPome2WHjg7omXb6qU3NY+gCUNSETYO7RjDtWCEuuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUQhONqPM51EJZUibnRFN37aCl2/OOOAELLqvbwxTncRkoRd6E
	mgCmVpzxRU45Us/blpsabYehFV9/XbwYMPtTTVfo4MlarCMO84OjEtIgo2YK4SBH37KLc8iAf6q
	xq9YX+6UXPv0u7sptAxacGX6uZSy/p5w=
X-Gm-Gg: Acq92OH46iXspOqqcqN25hI2uhU1RX9Ueu0kh6ttTjPyYYpevLUc73j+DCyAdfb5vpI
	HSmp2jedD75wJ4iijhPKYjW6+3nAAd2Puv6Nc2hrAeb5dBw5np+cuMuX8jiCz78CBdXIAZGxHB/
	P5PW8C/rZ36CCPeKBdVL4dwHJAZOQJXrQ0yCyTB/dTHRbujykCcEjMWABsClAme6Za8wkb7R0dW
	UilgI3OEvA/g1r7y9xeNo/+ybIazRldRpo/1hOvdLAku99KhsKeLiMjigrtEXjV3w+446jMeRth
	0lCgs1luJKhnGl1LnYphjUbCa8G8VyhA1lOoHuzxFSd0V2xKwsN+EELCjt1jMHh6W8jSQy2B/cG
	MekgRYIAVGocEJZLecf3PCfFq
X-Received: by 2002:a05:6a21:e90:b0:3b3:bf7f:efeb with SMTP id
 adf61e73a8af0-3b79642ca5bmr9972447637.45.1781495140527; Sun, 14 Jun 2026
 20:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612011616.27771-1-yangtiezhu@loongson.cn>
 <CAAhV-H4daHGFoAiXrwcNXj=T1kZm5jRRwd_sCiv7ksjR2ynHgw@mail.gmail.com>
 <e23e6781-d39d-d7fa-10ec-8d09349103ed@loongson.cn> <CAAhV-H6jJpEnNTUF0CF60fDB5ShNT+C59NEH=YodJtepFQgrKQ@mail.gmail.com>
 <833e2fca-6a41-786c-356d-6480ca168e44@loongson.cn> <CAAhV-H5LORpNeTycjmHFobOZEA5w=spSkxJuOajuizz-941zQg@mail.gmail.com>
In-Reply-To: <CAAhV-H5LORpNeTycjmHFobOZEA5w=spSkxJuOajuizz-941zQg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 14 Jun 2026 20:45:27 -0700
X-Gm-Features: AVVi8CcYECDOKLuQY2giVgMR7JGvSRDaM6DUgHhLWQSnV3DyRu5vz97XLuuibZc
Message-ID: <CAADnVQLAgYFQ=BRi+hKwt5pp7fffqsvD0rXzn6Nk9jJQ=6uUZA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Move thread_info into task_struct for LoongArch
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
	loongarch@lists.linux.dev, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 8:31=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> On Mon, Jun 15, 2026 at 11:16=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson=
.cn> wrote:
> >
> > On 2026/6/15 =E4=B8=8A=E5=8D=8810:23, Huacai Chen wrote:
> > > On Mon, Jun 15, 2026 at 9:41=E2=80=AFAM Tiezhu Yang <yangtiezhu@loong=
son.cn> wrote:
> > >>
> > >> On 2026/6/14 =E4=B8=8A=E5=8D=8810:51, Huacai Chen wrote:
> > >>> Hi, Tiezhu,
> > >>>
> > >>> I have queued this series for 7.2, does the below series depend on =
this one?
> > >>>
> > >>> https://lore.kernel.org/loongarch/20260521125636.26744-1-yangtiezhu=
@loongson.cn/T/#t
> > >>
> > >> This is independent on CONFIG_THREAD_INFO_IN_TASK.
> > >>
> > >>> https://lore.kernel.org/loongarch/20260428080051.20938-1-yangtiezhu=
@loongson.cn/T/#t
> > >>
> > >> This is dependent on CONFIG_THREAD_INFO_IN_TASK.
> > >>
> > >> But anyway, I plan to send new version for the above two series of
> > >> selftests once this "Move thread_info into task_struct for LoongArch=
"
> > >> series is merged into the mainline, maybe after 7.2-rc1.
> > >>
> > >> Because the code under selftests need to be updated, for example,
> > >> it can use bpf_get_current_task_btf()->thread_info.preempt_count
> > >> for get_preempt_count(), and it should use ld.wu rather than ld.w
> > >> for bpf_get_smp_processor_id().
> > > You can update new versions now, then they can be merged together.
> >
> > Thanks for your suggestion.
> >
> > However, considering that these selftest patches need to be
> > routed through the BPF tree (rather than the LoongArch tree),
> > updating them right now during the active merge window might
> > be inappropriate and risky.
> >
> > Given that these selftests strictly depend on the "move
> > thread_info into task_struct" core changes, sending them to
> > the BPF list now could cause cross-tree dependency issues and
> > potential build breakages if the core series undergoes any late
> > adjustments before hitting mainline.
> >
> > Moreover, because these are selftest adaptations rather than
> > urgent bug fixes, they aren't high-priority for this immediate
> > window. I will rebase and submit the new version to the BPF tree
> > right after 7.2-rc1, once the LoongArch base infrastructure is
> > securely merged into the mainline.
> In history most arch-specific selftests are merged via arch trees,
> including perf, bpf, ftrace, kvm and so on.

This is not true at all.
All bpf selftests are going through bpf-next tree.
For example, x86 and arm64 bpf JIT changes always go
through bpf-next.
loongarch is causing problems this way by taking bpf JIT changes
into the loongarch tree.
