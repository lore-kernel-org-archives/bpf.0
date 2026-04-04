Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6A17A30A
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332882; cv=pass; b=VMYpt1EiLPAovic1oK3I+wcJSbWSNbsn3CB8o1hKtdOIF/sbU6eWDdoar9o3DLmvWyu0a88oz85xPpOwf5dBxtXLvB6Bpi87jq0XCT55V59u8xLh0N6E1D3md/q+N1e5niuTDhQoNNB0D8e1cwfdrRnRv2ZhPAyqa2QMbaL1+3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332882; c=relaxed/simple;
	bh=vGtG3D2zp0AZSQJ/EIUiALQXro+H1oLZVHmLy1USXSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COtaKZGlLUWY6zIZVRyxYD224oykYrxHEyuewc2rJhBvm9bqjr3SCo25x2tsJJa8MHeUbKPUAvKjEz5Jw2emkNHGMvLJs+/Vucn2K26Oi7l8qPAMr2Hsh2xqT9Mmjx9eGkz8GZO4x9r07vh7P6hua+3EQFtuCsaQw/1qsEPX9rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTSkdQ9Z; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTSkdQ9Z"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d029f346eso2549427f8f.3
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 13:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775332879; cv=none;
        d=google.com; s=arc-20240605;
        b=Z7UtXq1rhf9roh6ND6jPABOX7UVq6eqFtqEfw1yHTAxnYJttWIWAhUHwpYbi4FpU/v
         ccnY4GUE/fN4q3hx1zK8uUhYNHa0IqcQClKnNGcEpevyi83GqsE8ZWihTRGCqapyeJOI
         Sb8+xV4DlhV0YWHfSYvxWmNd8d348NrJc6gmzSi+rTRgQLH4MJr3YcPb3SrsYdKz2O9m
         8AD1UK0XDOY9N0368NjhhYlSOyf6iJYbR/QskZcLJpUAE8yKc/w4KB4dsJpnG9dffMJr
         48b2ciM78wcOIfugDy27mm/amFaErAoToGj2wbHHJ15fEzgAjIN8i7sNaSYu9oN+Q3cc
         CayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kGIDH61WoEXtaRnZcs1sr5qJYYA+kDbIZde/Zd/nwhI=;
        fh=5K7LlmBDhJRYJ+zNVkHjN8Qzx0sx61+mt+UfNHVnWCo=;
        b=iJpSA+2aVeqghKChqvcPScpPFJecyIrOeN0UJJBUR6V8SQ5tKQBX+DihbWvmAdoT/e
         Y8E+wFf+gQXLg8CPJOZf+zfPirAk/jbU6HocBb/HmNIFNx7MbF8io5AXdtZCHOpeiznz
         P151Oj+5bQmQf5tGBJim5C+f0YsWNDRpUnX0hwCFpPIHQgiiCjWkRng5vRz7kqn0gzKI
         T10yiLvdmH7+od1h86MvobFnx/ZrtErCioS+H/fE2yXMOcD4RWtYmj8oJcxjo1nEMEVd
         50eb7RkY5F7cmpTJsc++9lUedNV6iP74gJwpnExYQMWbc+KulSknp1aqjKzsfI+WF5Pc
         g3hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332879; x=1775937679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGIDH61WoEXtaRnZcs1sr5qJYYA+kDbIZde/Zd/nwhI=;
        b=LTSkdQ9ZCOyQ8t/Q56e/SsqEnUkSywGc84hzsGs7Yf5Y1DWsOrlHno+Vb952l7K/38
         Gx0qx5wEsybsh3YEn6yWTETeiuXCtRlPrxJk6VHMmyVGuBFGlhk7xydzHbted93v8lVF
         LOqaTm2Vb3sAQz4Z5mBIMfoFUeV9fGi8u2skivHki/VLsnw+9fGGOF+aJuobU5HEkOXr
         hrcgBeD5uJUo4Zmp0ccSTZLuy54otOboKor2Uryfz3ZZAY2v3WpxqoL4rJdBn20/CIGl
         oCvyUqpZBb6XsCf+3TXkrL2p+0jhN/tHJbSxK2wLJnZ+qBK2o3LlWYPyL9CQlMvfoJHh
         hZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332879; x=1775937679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGIDH61WoEXtaRnZcs1sr5qJYYA+kDbIZde/Zd/nwhI=;
        b=J7KjWazcRcrH5RojoEqvKRXZe7QKP4gcw/6rHEq9gucVBFyeMv0V27eKsrYTc6F7A9
         5+cmtBktIgE2cGdU8FZW9dDwYXA4D55bhqwlk67sA/s0unWW6E4cBbVvJsx8vi2YXsE8
         7pPUK8+3T6qAxRjx9B1Pnrj4fSuviUpPkp6+aPsbzv12hDODVf1LpnxPVP0xUn7aYTDw
         s9uMohb46sq+3PK/oJpBOkHyMvPYJz15pROCIdfM+X1JR90tA+u5Me27UMryzk4XgSWJ
         N4UPNsjmDTJhemQKd7wzAULbBPMslLOPvjdzoZo6xSxKOd2zlflT18Pe+uITc/P2JrIC
         bWXQ==
X-Gm-Message-State: AOJu0YztakWqPhWnVOU3eI4qRv5FvQySbdfyHk2JWgaZ4UpPZ2bZgrnU
	b6GlEgx2irAxNJNFSKF3KcwFfAsCl5j+wRloNyIEpmXWrgYQr7iLCswPXmvxXk4Oy9VJMhlmAAv
	i1TlUuQejIGn0iW1GckE1O2KVcYnB1Rw=
X-Gm-Gg: AeBDiet43wiXfBehATB41e5b+BQTlcF8m2qyPP7DPMnXeKz5MS9OKE6iQo0Uj9+sqlj
	SWiityd9jwHd4UPnsngYoMo/HPB6mzUUNTK50hkh5kiu1CBXhGB+ienWCxhblGrbN3YgQOm2sRi
	crrK8xVawAyde4zQlW4o22oVcxj7SqWXtdfvSe9EmQV4ffgVeDDKiJf3mgJAIqzaSW8FT2ksBO+
	wvd0TTOI6xCu57dh8D4lTaKjJsKokq5sf3ra9SlsbQ7+hYC7gvnh0XEerrDqrORiHtV2XT0TkBn
	p0m1feQOwyNJ6PtPf77xg6BASt3KR1s5iZtuY2sUX87FuBHQXdUamiEJrz1A8IaJnx9gcwnjFz9
	cEM0shs/YOUPlBNl14cLroGXcHg==
X-Received: by 2002:a05:6000:144f:b0:43d:1e97:d638 with SMTP id
 ffacd0b85a97d-43d293019cdmr9759459f8f.50.1775332879361; Sat, 04 Apr 2026
 13:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403042720.18862-1-emil@etsalapatis.com> <20260403042720.18862-3-emil@etsalapatis.com>
 <CAADnVQLGfsEsMp=yhn6wk03AwXkWgGf3KF9UL6U0-SbuhtbzJw@mail.gmail.com> <DHKLOPTK8IW9.KVASSDNT9UQJ@etsalapatis.com>
In-Reply-To: <DHKLOPTK8IW9.KVASSDNT9UQJ@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 4 Apr 2026 13:01:07 -0700
X-Gm-Features: AQROBzCnkFdfqe5JPewZTusmTu1BJidK4Bw9MhwwMPllzkAGFgswqm5M3V-Z56o
Message-ID: <CAADnVQ+FQ0eJHmf3apd7bQGYECTkTiUpG8JNfxdxt84APZiU2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] selftests/bpf: Add test for scalar/arena
 pointer addition
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 12:00=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Fri Apr 3, 2026 at 4:25 PM EDT, Alexei Starovoitov wrote:
> > On Thu, Apr 2, 2026 at 9:27=E2=80=AFPM Emil Tsalapatis <emil@etsalapati=
s.com> wrote:
> >>
> >> From: Emil Tsalapatis <etsal@meta.com>
> >>
> >> Add a selftest that ensures scalar +=3D ptr_to_arena instructions
> >> are accepted by the verifier.
> >>
> >> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> >> ---
> >>  .../selftests/bpf/progs/verifier_arena.c      | 29 ++++++++++++++++++=
+
> >>  1 file changed, 29 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tool=
s/testing/selftests/bpf/progs/verifier_arena.c
> >> index c4b8daac4388..450e8f1181cd 100644
> >> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> >> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> >> @@ -477,4 +477,33 @@ int arena_kfuncs_under_bpf_lock(void *ctx)
> >>
> >>         return 0;
> >>  }
> >> +/*
> >> + * Test that scalar +=3D PTR_TO_ARENA correctly upgrades the
> >> + * destination register to a PTR_TO_ARENA.
> >> + */
> >> +SEC("syscall")
> >> +__success __retval(0)
> >> +int scalar_add_arena_ptr(void *ctx)
> >> +{
> >> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> >
> > I think the #if can be removed, since the whole test is in asm?
>
> With Clang 18 the assembly fails to load for me with "Invalid operand for
> instruction". AFAICT this is because addr_space_cast is only recognized a=
s a
> valid instruction from the BPF backend starting Clang >=3D 19, which is
> also the first version that defines the feature flag.

Replace the whole thing with hard coded registers
and hex representation for addr_space_cast ?
See define bpf_addr_space_cast

maybe it's overkill just to test it.
I'm ok keeping it as-is.
