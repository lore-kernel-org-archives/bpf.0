Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE0154BF0
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174495; cv=none; b=fLCpO6SYWnNj0HwfoyHkTYT59F1GjDFMYSxg+PEESlvENdkM0adNuokQtoxXbH4h9CHoVdwqD7GNVRTlgtxbSMS4JPlsUzKOcea89nQyjxqBXrfqNN5lUD5vJsTqGbCOSijq5I8Zd6bD5XXwAjggGazVHZGaJjn5sRfN2YqjdOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174495; c=relaxed/simple;
	bh=KyKyqHiWDfKWUtW5lpVDQeDTQpvkiIFeVslBI78VwBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHeKi6bgpNg9r96D9JzDfASe77VVlpuENbN97f8i+3zUv97MYXt7jrryXEBFyHNaHXiidnjcrzMyWSUiz1rs/EUFsi7GPxCqaahC5bdDAcE9HVTZCwTO7utyXoe9eZXZaeDLoADB+8nEbUrPoJl1duXcV5RQElUrp3il2tnHSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAvBNWx4; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAvBNWx4"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so217099a12.0
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 13:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712174493; x=1712779293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEAH4kALaVHWiPMxIwHcDDArnoMH44O7lA1ND6twnq8=;
        b=bAvBNWx4vgM9HMAeVX/cecbv54sEualhcZcW2psMecP98+SPg9t5dMiNHIGcQnJKdw
         FtzkEnBRbx5PsZZMw3Zi+nA3uFv6nNVB7dI08FPKqUb/PZZa1egJHErwBnOyaM1QBp81
         eSaRWvWDv5x37Zp48aSnWoeliUVu5xMinXo6+UcrX1/3z+LP1O7qN5R5KWNGCnTDSI2I
         Vi+Pom4OBEIcTUDjcHN/ScS1WakPl4/UUC1QBBA9L9HzVUn2Gz4bbvfijRWYb62vTeAR
         trqA7bLH0rCtnPD00m4iWn3yfaK/+4qsXGkpUhvGZGw9ayGszm5ZH2eQlcOnnQ5RmfL6
         lV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174493; x=1712779293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEAH4kALaVHWiPMxIwHcDDArnoMH44O7lA1ND6twnq8=;
        b=oAC6G/NaqspVUzsAemxZ7knNIX71SjDvOMT2NCMtdeKuYwPlTydkbbRUSICIgzRM9R
         Xj2g68Z0JBot3crJ/1OeVt3BcWyXe0WJNFdv0nahAn/6e0XAjtj80iUzHpFT5eg9+7Zf
         RlFnR0mJ4RXrgmB45SmKzNuWcrq6J2olbqCkjwF2eVdaLt8cUb9LWSMFLZQK7QJqmnMa
         KoDf74A2RaCbt6AQJlfXtoNx5KyUVq/rooLtkvOwC6IyHxMcv31mXyQbtdnViEyUt0Xb
         OPeW8Bmed9i0LJpPwEOtLv8tXq2ibfSfXorWM7xmmbibuchFlXJiFsZn3W/LxocC+hxA
         k1eg==
X-Gm-Message-State: AOJu0Yzh07QZoNntSirHQ1fPYXhYeGCzLrCdpL39p+DbKJ7N1zfxKERt
	IFyED9klgUwpTQW5/TbCfxd8aeNS9QSdRbaLTvef7yH7uM1lnSQYeMmxgliMS4y92wCcnB1lL/P
	GIG4QpP/ARtEruxqbgAwpYDX3FtE=
X-Google-Smtp-Source: AGHT+IE66IE52nzNS8mxyBngURaVxMBSnB2RiMzDDAAhCO6v1HpgCIpsnbGh3cxWiMtUYyjT0QQtS/kIB8U9wn3gnJU=
X-Received: by 2002:a17:90a:eb13:b0:2a2:13ec:fc6 with SMTP id
 j19-20020a17090aeb1300b002a213ec0fc6mr561942pjz.10.1712174492861; Wed, 03 Apr
 2024 13:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <874jci5l3f.fsf@taipei.mail-host-address-is-not-set>
In-Reply-To: <874jci5l3f.fsf@taipei.mail-host-address-is-not-set>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 13:01:20 -0700
Message-ID: <CAEf4BzYN-seVkwb0ddGce0EAMWs3kYq1LtpUMmRz6cBtvOXLrw@mail.gmail.com>
Subject: Re: 10x regression in processed instructions after recent verifier change
To: Brennan Vincent <brennan.vincent@polarsignals.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:59=E2=80=AFAM Brennan Vincent
<brennan.vincent@polarsignals.com> wrote:
>
> Hello,
>
> I am working on Parca, a continuous CPU time profiler which works by
> doing DWARF-based stack unwinding in an eBPF program. In 6.8 series
> kernels, our unwinder can no longer be loaded, as it exceeds the
> verifier's limit of 1M instructions processed.
>
> I was eventually able to get it working, so this is not exactly a
> support request, but rather a report of an issue that might affect other
> people.
>
> The issue is 100% reproducible and bisects to
> 67420501e8681ae18f9f0ea0a69cd2f432100e70. Hacking the kernel a bit to
> increase the instructions processed limit, I found that it successfully
> verifies after ~3M instructions, whereas previously it took ~250k, so
> more than a 10x regression.
>
> In case it matters, I'm on arm64.
>
> I am not an expert on the internal details of the verifier, but I have a
> vague theory on what can be causing this behavior. Our unwinder has a
> few places where it needs to do binary search on an array, which look
> similar to this:
>
> #define MAX_UNWIND_INFO_BINARY_SEARCH_DEPTH 19
> #define MAX_UNWIND_TABLE_SIZE 250 * 1000
>
> static u64 find_offset_for_pc(stack_unwind_table_t *table, u64 pc, u64 le=
ft, u64 right) {
>     u64 found =3D BINARY_SEARCH_DEFAULT;
>
>     for (int i =3D 0; i < MAX_UNWIND_INFO_BINARY_SEARCH_DEPTH; i++) {
>         if (left >=3D right) {
>             LOG("\t.done");
>             return found;
>         }
>
>         u32 mid =3D (left + right) / 2;
>
>         // Appease the verifier.
>         if (mid < 0 || mid >=3D MAX_UNWIND_TABLE_SIZE) {
>             bump_unwind_error_should_never_happen();
>             return BINARY_SEARCH_SHOULD_NEVER_HAPPEN;
>         }
>
>         if (table->rows[mid].pc <=3D pc) {
>             found =3D mid;
>             left =3D mid + 1;
>         } else {
>             right =3D mid;
>         }
>     }
>     return BINARY_SEARCH_EXHAUSTED_ITERATIONS;
> }
>
> (For more examples see
> https://github.com/parca-dev/parca-agent/blob/main/bpf/unwinders/native.b=
pf.c
> .)
>
> Note that as I said, I'm not an expert on the verifier, so my theory
> could be totally wrong. Please assume I put qualifiers like "I
> think...", "I suspect...", etc. in the proper places in what
> follows.
>
> The commit in question made the verifier track the bounds of variables
> more precisely, which might allow it to verify more programs. This,
> however, has a downside which is that it causes an explosion in the
> state space. In previous versions of the kernel, we could just verify
> this snippet once because the verifier did not precisely track the
> bounds of `mid`. In the new version, we have different bounds for `mid`
> in the different branches of the main `if` statement, and the set of
> different bounds multiplies in size by 2 each time through the loop,
> causing this huge explosion.
>
> Now, if I intentionally confuse the verifier and prevent it from knowing
> the bounds of `mid`, e.g.:
>
> static u32 __attribute__((optnone)) scramble(u32 val) {
>         return val ^ 0xFFFFFFFF;
> }
>
> then, in the main binary search loop:
>
>         u32 mid =3D (left + right) / 2;
>         mid =3D scramble(scramble(mid));
>
> then the program verifies fine, as it did before the commit in question.

Yep, I think your analysis is correct, and your obfuscation workaround
is "sane" :)

Having said that, I think it would benefit your BPF programs from
thinking a bit more carefully about scaling your BPF verification
process by using various features and techniques that keep
verification complexity more bounded.

Specifically, I think you can benefit from making find_offset_for_pc a
global function, in which case it will be validated just once,
separately, and then not re-validated.

Also, if you can rely on that, using bpf_for() loops (based on
open-coded iterators) or bpf_loop() helper would also help minimize
verification complexity of your loops.

>
> I am not sure what, if anything, should be done about this in the kernel,
> as it seems there's a fundamental tradeoff between precision of the
> verifier and performance in terms of instructions processed.
>
> --
> Brennan (he/him)
> Staff Software Engineer | Polar Signals Inc.
> E: brennan.vincent@polarsignals.com
> W: umanwizard.com
> TZ: America/New_York
