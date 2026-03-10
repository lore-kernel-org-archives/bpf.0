Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B23537FD
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149104; cv=pass; b=A8Gzqo3z33KJgcb1EWmzfqUEZv0aqMQPgZ2yv3pSyzyVd8EJcFpKYw7ho2ZW260sW/6UOSUBsyJ2XAhL551dClNtWazSrLILvMkUgxk65tF7qtwjt0gJR8ht2baRDxGtN5w5dl3vZ2uUo1U760LmCH5+E6BXInKNsJoNIrefiCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149104; c=relaxed/simple;
	bh=0J1oU1eZ/G2C8shiXa/TV85nKwqsp7/o9q6W7EIdKMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+vnpMPi7KDLxS9YACFzZmKPkZQGRMBGjbwtz9SomdLD+Hl9YEDvKKkCWY7slwMB0VKltf8uOa0DUEQeUTXRDeEdL8oh0iMnORdL3ZYEZcxbEa9Vk3r8zzO2qDBQLYnNWU1ilZ0vFnH0G2XyCCWbIBQD3ZHhHs6O44Y8NrNOCJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsC1uHQS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uOa00rIr; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsC1uHQS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uOa00rIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773149101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mRiZHd3hjy9wYbcMzg1z2YcvSrUrPgvmFfUtqm16Gs=;
	b=YsC1uHQSycanBy/TpWW114jdVzDx2tLzkVG/JfhfhFVfkQVkp5E15VVEvdmWtkHghsMytS
	EKclehxdSJnFRPi79Ud9e9WV0mXOSAJpxmoETxTrV7yjknud8ROBp26SbwiItUCdzXTIeC
	+oL4dxX73xbcc2M6N06xwiLpNOxhsEI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-hBk-HBzaPI6yy13xUYrUaA-1; Tue, 10 Mar 2026 09:25:00 -0400
X-MC-Unique: hBk-HBzaPI6yy13xUYrUaA-1
X-Mimecast-MFC-AGG-ID: hBk-HBzaPI6yy13xUYrUaA_1773149100
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67bb2273d42so31767576eaf.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 06:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773149099; cv=none;
        d=google.com; s=arc-20240605;
        b=ijl8mmmuG4d2Qb1bkqahrZ8waXtxpk+nCFQqmGob8zzrdzgEL3b9Gmyc3lWUJZaYaN
         NLZgYQfEvUqsuf+pCUKJMHzvOekeyj6ikxLXUagYYdA7O+dDmRo0zRmNz8QQYAxecYYD
         qfTUazphPEhy6YY0rrKkTVaSh4UkZTE8rvNG/U+/m0UahTKNdZbGFcU75GYtPRrk2I2d
         MqAPZQlUqoZpABEwOqmcSb+VYdx8KTOP4IQG3WwEvlgD74GWwoJslA6Cm7En3sZ9x4PC
         /aTOWBCKIOs27WpS+JNGDYo9q0viO6hbxbY0UyWAjFEnH7MMD9P0nUoHasJOuto8E1xe
         WW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+mRiZHd3hjy9wYbcMzg1z2YcvSrUrPgvmFfUtqm16Gs=;
        fh=8v9qQigWx/U1YFWg5HkPPHDA1GhnAlB2HAX94dSxnac=;
        b=WgZoN1oZdNFEW3dfHRsbrNEq4lJiO51vPfcuByxfJb14LI2/3hqkv9CNXlIQJuRNM1
         G1ZyDdxLUCeK2J/QYEjB7ir7tYj5Uzjq1bGDajQJrobYcEeR6K5tFv5Z/Pe/Nn5j6VQ5
         rvj7J6txVHZZCwpJUJl1hNKBezFfJW26KDXWZ+eJyI/t/pAHmSnUARFzi51+T7kPy3MY
         Zu5syztjWsIJteLD45BxCmhggtEG7dQJdvKzp4TIExxonAs+KQ8kinguAAULs8isXT+d
         S8c3zFA3JmgC6zmFszK8iwtura/hgnFjcGzU1VSoilRE5w1LGoxRPfTwf8nFMfpc5BTs
         8dtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773149099; x=1773753899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mRiZHd3hjy9wYbcMzg1z2YcvSrUrPgvmFfUtqm16Gs=;
        b=uOa00rIrG1AcXdriAvon/+RLwTKEDCNGIzIqDlUN5LW7kRgmcWH3c/kcxnXLF6kKq/
         x4Ase1h+tPCvwSsKYC18+v9Cj0exn0uAjA4S0DTsq8kXBcmMTPpSBQ2DpckP66FtFm2v
         U86jyOgsJQzNK8ANYlYBfCVYwTodDQYDKLr0cS3OiPnUfBs5QrjLzSU88D3rLc37rsMj
         7XbM1rFjhtZe9NDZfbyOM+vKUzX5lqtJJUExiR0vZToaBa4ovt2jEb9CIJWdG0T3LqES
         v8dFolYbOo8OZxKAkWVrsMOP0OMbQnv2B+jdOriMxIHfV4/JSK+uxHBaZjQxtaD2qh0u
         wzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149099; x=1773753899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+mRiZHd3hjy9wYbcMzg1z2YcvSrUrPgvmFfUtqm16Gs=;
        b=uIRGqwGVMHljbugBAokApZcgDLwQ3GcIJPLaqXkPRY165IGUHdntOnmOHKSnb+pZ/D
         yfIyC5uUUaijc5+EMeJR5H6EyXfaJtkDDCVNmsFTYP8T0LqFRCpzRHheWsEg9QAcLbNz
         uvDDUxstzQQUEmwM/xfY7GIKvL1yRKpGE5NWYsqRtRjDp376f8wFt5A285GhKddxjRBC
         Qq6Ltu4DRCHg79Gu9JibQHloyyW/EQAZoeQxj7l/mZRm/tJSwTmYSZnUE/d0PedXNqct
         i4Ky7JfApQN389onp2gG5khQkwRht786hD5vw7i6whG2kyQQ3ycyTvcD4Gc+22Y6n7sC
         DLDg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ3DF6mK3/tjj1qSZJwWGctwCJ7KXP0OEM+CGV0NF5Zgx7M+PSvKK7evJ98kT2DmQp/Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybj750vQD2YDt5/6RBpxPErBMCHGmEh3hPY6udhAYk0/i/VDRj
	ZYKZlKO0bO69kBE0WyFmuOdMz3qCRNRlFmqtk5PVNW2xMM4T3YSJeLtgcEMf0Z4rMQYLepUHTgY
	VbWBg8mQ2QXDB7gEW/eDUrd99VRZ5SjVXyeaQVZWS3LBWuvHpNj4W4WfIkMVNj1aFRv7Oon0faQ
	ZLqBnGciUhgA7XRs7YVlUzFlj1luO/
X-Gm-Gg: ATEYQzyAIPq1WsiYyg9zW/L+QdQ2ZZ8u2O33LRSmrpzx13/WKaoExTz09bNPVzeOa6O
	WKEwVHq0lgvE0B2++ODxKiGhhFm1akXN/iapq+RnXN2TdmuLa7vLLuctUNHZMxYXBYRWtuVz7+M
	atLNCq9emR+3k0zJW5SMV4pDY4rXcElK1gQgU8EbLErQpuxc9BpAEdF8L7ebKcL3JolKtj1eoKY
	WQCZMs=
X-Received: by 2002:a05:6820:2188:b0:67b:c08f:c646 with SMTP id 006d021491bc7-67bc08fc867mr800205eaf.45.1773149099366;
        Tue, 10 Mar 2026 06:24:59 -0700 (PDT)
X-Received: by 2002:a05:6820:2188:b0:67b:c08f:c646 with SMTP id
 006d021491bc7-67bc08fc867mr800178eaf.45.1773149098970; Tue, 10 Mar 2026
 06:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309144045.169427-1-vmalik@redhat.com>
In-Reply-To: <20260309144045.169427-1-vmalik@redhat.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Tue, 10 Mar 2026 21:24:47 +0800
X-Gm-Features: AaiRm52us4L_x-yzPwkJaPK73H8lBCzWxkyJHukmqBE4DeWQ1HyAoAtPgAw11Ks
Message-ID: <CAATMXfmc8VAGh3d1D2MYPvZQiUpwua8o7FyRngSw4CmyRPZkrQ@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc, perf: Check that current->mm is alive before
 getting user callchain
To: Viktor Malik <vmalik@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Paul Mackerras <paulus@ozlabs.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Saket Kumar Bhaskar <skb99@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Run the BPF profiling program (profile.py from bcc-tools) on a ppc64le
machine and passed.

Tested-by: Qiao Zhao <qzhao@redhat.com>

Thanks,
Qiao

On Mon, Mar 9, 2026 at 10:43=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> It may happen that mm is already released, which leads to kernel panic.
> This adds the NULL check for current->mm, similarly to 20afc60f892d
> ("x86, perf: Check that current->mm is alive before getting user
> callchain").
>
> I was getting this panic when running a profiling BPF program
> (profile.py from bcc-tools):
>
>     [26215.051935] Kernel attempted to read user page (588) - exploit att=
empt? (uid: 0)
>     [26215.051950] BUG: Kernel NULL pointer dereference on read at 0x0000=
0588
>     [26215.051952] Faulting instruction address: 0xc00000000020fac0
>     [26215.051957] Oops: Kernel access of bad area, sig: 11 [#1]
>     [...]
>     [26215.052049] Call Trace:
>     [26215.052050] [c000000061da6d30] [c00000000020fc10] perf_callchain_u=
ser_64+0x2d0/0x490 (unreliable)
>     [26215.052054] [c000000061da6dc0] [c00000000020f92c] perf_callchain_u=
ser+0x1c/0x30
>     [26215.052057] [c000000061da6de0] [c0000000005ab2a0] get_perf_callcha=
in+0x100/0x360
>     [26215.052063] [c000000061da6e70] [c000000000573bc8] bpf_get_stackid+=
0x88/0xf0
>     [26215.052067] [c000000061da6ea0] [c008000000042258] bpf_prog_16d4ab9=
ab662f669_do_perf_event+0xf8/0x274
>     [...]
>
> In addition, move storing the top-level stack entry to generic
> perf_callchain_user to make sure the top-evel entry is always captured,
> even if current->mm is NULL.
>
> Fixes: 20002ded4d93 ("perf_counter: powerpc: Add callchain support")
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
> Changes in v2:
> - Move call to perf_callchain_store() for the top-level stack entry to
>   common perf_callchain_user (Saket)
>
>  arch/powerpc/perf/callchain.c    | 5 +++++
>  arch/powerpc/perf/callchain_32.c | 1 -
>  arch/powerpc/perf/callchain_64.c | 1 -
>  3 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.=
c
> index 26aa26482c9a..992cc5c98214 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -103,6 +103,11 @@ perf_callchain_kernel(struct perf_callchain_entry_ct=
x *entry, struct pt_regs *re
>  void
>  perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_re=
gs *regs)
>  {
> +       perf_callchain_store(entry, perf_arch_instruction_pointer(regs));
> +
> +       if (!current->mm)
> +               return;
> +
>         if (!is_32bit_task())
>                 perf_callchain_user_64(entry, regs);
>         else
> diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callcha=
in_32.c
> index ddcc2d8aa64a..0de21c5d272c 100644
> --- a/arch/powerpc/perf/callchain_32.c
> +++ b/arch/powerpc/perf/callchain_32.c
> @@ -142,7 +142,6 @@ void perf_callchain_user_32(struct perf_callchain_ent=
ry_ctx *entry,
>         next_ip =3D perf_arch_instruction_pointer(regs);
>         lr =3D regs->link;
>         sp =3D regs->gpr[1];
> -       perf_callchain_store(entry, next_ip);
>
>         while (entry->nr < entry->max_stack) {
>                 fp =3D (unsigned int __user *) (unsigned long) sp;
> diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callcha=
in_64.c
> index 115d1c105e8a..30fb61c5f0cb 100644
> --- a/arch/powerpc/perf/callchain_64.c
> +++ b/arch/powerpc/perf/callchain_64.c
> @@ -77,7 +77,6 @@ void perf_callchain_user_64(struct perf_callchain_entry=
_ctx *entry,
>         next_ip =3D perf_arch_instruction_pointer(regs);
>         lr =3D regs->link;
>         sp =3D regs->gpr[1];
> -       perf_callchain_store(entry, next_ip);
>
>         while (entry->nr < entry->max_stack) {
>                 fp =3D (unsigned long __user *) sp;
> --
> 2.53.0
>
>

