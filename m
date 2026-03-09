Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC303290BA
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068564; cv=pass; b=GVHISKIwOqK4tvesPqVeN4HAeUcYQkX7Ne+TilJ3Wb7+JoEzXJlkiIrQx5FoQkJhY+/lCSrMfQEuEodWmKGMekFhasHBIe/sn1ChOXPst+Pgp1WiaIawZ+sr4bWP0KFLD42EbfJiLkYE4eD8HDuDJjTRxEeuIxwxC6U9+iv533E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068564; c=relaxed/simple;
	bh=eqfU6ul3moKHFv5Rt6DgTPzcTZjyCjZpdBnBV8hZ5So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4DOChqDm2pDA9+aiSzTDY+eOe9qNAc9ebOF9RW/1r75gcfn496AF7lSwZZkUPumV/U+mqZ0LIu6nwQA8lYtQB5pPlC0UQ/0mUQuIyXfAbdNfjr4z2PRIU2peFyVjgtPP0Lk75COF+RS+YMlCMa4SE0NQIG18tvZOii8nbjGiZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=H2IXjsgS; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="H2IXjsgS"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-41710377bf6so270048fac.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 08:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068562; cv=none;
        d=google.com; s=arc-20240605;
        b=IWd6AgI7xnMKcDhyjWUmw0pPn6r+SquqvbL4uGluadcV74zGKXC+5rB364MhcJKRif
         YDiQdFW/HE42L3Q095QY4W3gvI3PL2HIEno0RROKw5rCZggbQGN92YGm1z1Ti0mUSqlG
         EOvS+/Drf3jgqnknu5eMR5D5nuzWKegMgchl0zSyNssuac/xgr2xeIGvj9Sbik47QoIS
         nZR2oT+FJrwkfWzawWMT0qmfQitLgtJmpaDd0II+1T7n7x2K8Ji+IgfKAoaCCyDuAvjA
         n5/K3nKRaAZLW978oKMW+71YNKASN7K94h0/Y81pemAki55ycen7nARwP8aYNKqsA8wc
         Gm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NmkngJbnrPZ0QH13s7fieqKyIWpdpnQZouXymIBu37M=;
        fh=uRj0HrPGICdb3eOntaTDggdGxMRoJFqKr0XBxMySly0=;
        b=gtT3C/UwB5OK1hrNJanffDAvhtS1Op0L7Yn6JochxvFEV8aHigW6nrNTMyr2rMb48p
         UsE3OCjXL7BEcNoystXDQ9tNwSMtSWIWhgigtVqsFv3duocVKPtwOUsf8mKgO6E+sRnn
         2J4Iu1NLUbevVyR+eDjtCPadPKSAsvw/C/iN5cKSzF7pney4tD8Ag26Xx79nl0pg+ZAR
         gaVaI8meggpp9kKbjOoZtpdeJrkaXE+wEET9jjqjKRfUkfjbkBlX7J9W1JkfLosf2g0m
         ATJEdKg32EgrQEmeVdtPcTBMYO8YsL8MdaXZo/GyjO0fHJhSzudXxdl8mDsTn3gPW8hL
         kEFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773068562; x=1773673362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmkngJbnrPZ0QH13s7fieqKyIWpdpnQZouXymIBu37M=;
        b=H2IXjsgSanMBd+1aiZY6Xoph0fhDVHKw1qoU8Wtsa4iZOIowOi+WUQRMhId756vPXM
         9UZofN6WUs/I+F3ZiPNqbXNAzz/MylVDCvtTuVt0aFJSBW+HGhmlDRNmO2jZUdReoJFC
         dwQ1OY4Mov+GV9Qur4xkdMECT5TbKaFIxCl1nqgCuud1FCHhHG1e7sFXGZrBJP9sCFnN
         dK9XhUQORpE+dXECS2ACBoqYFyNL30UPyP9gSBVthvuYdU29ipKYGN60+xiU5yPnr3bx
         gDxEXiOh7yKM+91Gzjcx2/LTmybRyFjYf2ujo1H39o9K5pQAZ4bwCjXChfu2MaTiJIbG
         DNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068562; x=1773673362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NmkngJbnrPZ0QH13s7fieqKyIWpdpnQZouXymIBu37M=;
        b=QYXgX3oqaLs1Uj/wWMVAAyJ3w80a8ZV+uCOaaMWZDM85PFE7xNsRXbPBuWiKtroJMs
         B/w3NrDEIy07u00AedsVdWNo09dfj8f9XWuSVmnKcvYDfRbt7R1AvGTy1q8LFWVpL3OT
         tnRf4VpXLRAa0Tkl64xdvwiF5ESytDmDe+E6rkWFFcEgcmdkgLEuMJgzI6xH3iDWCZMM
         6SBvGkpVV6pK3UUUiJZUp7iEHycu9AGeYNFJtogXo7n1CbR1jsf8oHyeko32/AbAOvAv
         9Kzkxtbu2yRcXvodV/kDgIp2f5JzCaSmIjR+csvBMZIXEgxZJ/ZUSvwGkw4Ma4CQ42o0
         M/CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEJz8VPuqT+NOk0zZU4kiEW4+uqq1U4DBZqaLjAbwhXbhQqbYWc8wVNo6UhgZJsEJcy34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN5YEUdq5ag6sZjJMtRscmx36f5AusKeHrJbd06dNYkhygYRo2
	O0tg06kPPoVvFqGVS6m3xk2bU2ph5nczdPOYOUiZ960+GPrpGwxiN1ZvMy+ZbfOqItUzwLam8nX
	EflgRpHxIzDztoXkn6iZRGBU2uO9I/rrN3qfGr9hZz4wNFqBYTN4pLH4=
X-Gm-Gg: ATEYQzzVAY+M+GSqSbim3gRqrksf7FVSiGrKLAWpPydRXAxGbdG14cok1Io6bIDCjoI
	lnjPJ7JiH1oVYNrPYEdEffAcxKK4DYEZut9tQjwtL4qNNazW2HnY4MqQp1iFJaTL/OsxL0gv/Gt
	bHIcCMKBjWlcNRyorTYwpGp8JeEurIZT7M9Wsxclb34u7biYSKr28ayqwM5JYEwBs5brSA+k3c0
	lxCgCzK5vmIzf4yi2NwuPgxVQNrTJpQCVA50c2gUSs/zD1TQUx4wHVoFywvi/jQbcGUMxAF7hFP
	5cdbOI0=
X-Received: by 2002:a05:6870:d6a3:b0:417:43d7:bb8a with SMTP id
 586e51a60fabf-41743e71e1amr1002002fac.4.1773068560198; Mon, 09 Mar 2026
 08:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772109579.git.asml.silence@gmail.com> <d8c8748a-4b13-4097-bdeb-495e6410a0df@gmail.com>
In-Reply-To: <d8c8748a-4b13-4097-bdeb-495e6410a0df@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 9 Mar 2026 08:02:28 -0700
X-Gm-Features: AaiRm52-inccUBaxMPpcEWgeJN28TwhjPTVhGI2-_ae4ZFa1Q4Gj4m52EswA1NQ
Message-ID: <CADUfDZoBTwnCo-f_st9-jdgNhHLWUCjZQFpGdowGUA5BoJ836w@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] BPF controlled io_uring
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, bpf@vger.kernel.org, axboe@kernel.dk, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 6:24=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 2/26/26 12:48, Pavel Begunkov wrote:
> > Introduces a way to override the standard io_uring_enter syscall
> > execution with an extendible event loop, which can be controlled
> > by BPF via new io_uring struct_ops or from within the kernel.
> >
> > There are multiple use cases I want to cover with this:
> >
> > - Syscall avoidance. Instead of returning to the userspace for
> >    CQE processing, a part of the logic can be moved into BPF to
> >    avoid excessive number of syscalls.
> >
> > - Access to in-kernel io_uring resources. For example, there are
> >    registered buffers that can't be directly accessed by the userspace,
> >    however we can give BPF the ability to peek at them. It can be used
> >    to take a look at in-buffer app level headers to decide what to do
> >    with data next and issuing IO using it.
> >
> > - Smarter request ordering and linking. Request links are pretty
> >    limited and inflexible as they can't pass information from one
> >    request to another. With BPF we can peek at CQEs and memory and
> >    compile a subsequent request.
> >
> > - Feature semi-deprecation. It can be used to simplify handling
> >    of deprecated features by moving it into the callback out core
> >    io_uring. For example, it should be trivial to simulate
> >    IOSQE_IO_DRAIN. Another target could be request linking logic.
> >
> > - It can serve as a base for custom algorithms and fine tuning.
> >    Often, it'd be impractical to introduce a generic feature because
> >    it's either niche or requires a lot of configuration. For example,
> >    there is support min-wait, however BPF can help to further fine tune
> >    it by doing it in multiple steps with different number of CQEs /
> >    timeouts. Another feature people were asking about is allowing
> >    to over queue SQEs but make the kernel to maintain a given QD.
> >
> > - Smarter polling. Napi polling is performed only once per syscall
> >    and then it switches to waiting. We can do smarter and intermix
> >    polling with waiting using the hook.
>
> Any comments for the patch set?

I'm not opposed to this feature, but I agree with Ming that it seems
largely orthogonal to his patchset allowing BPF programs to access
io_uring registered buffers[1]. This patchset doesn't provide any
kfuncs for interacting with registered buffers, so we would still need
something like the kfuncs implemented by Ming's patchset to allow BPF
programs to access registered buffers directly. Although either the
->loop_step() or ->prep()/->issue() interface could allow userspace to
run a BPF program in the context of the io_uring, I wouldn't be keen
on reimplementing the entire io_uring_enter() loop logic just to
intercept a few requests to run BPF programs. The ->prep()/->issue()
abstraction seems more straightforward to me, though I understand that
it's not as general as the ability to modify the behavior of the
entire io_uring_enter() syscall.

Best,
Caleb

[1]: https://lore.kernel.org/io-uring/20260106101126.4064990-1-ming.lei@red=
hat.com/T/#u
