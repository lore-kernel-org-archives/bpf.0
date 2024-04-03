Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA1B2BB02
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178970; cv=none; b=hyOqFgqQbU9ZCfqa8L0pXxbfUhYt5MkDoI4BSMXrn8IL41oyJZNj4vywz+VgmPOSxzsUbsPJol5ccfDawnVt63fO5vDb3r57/LrpYF65gdxDqgnTaHOaAZnQrf3JzCmkJ4Ufbpb0U9aTWzaULE+bhoKgP/CaelwtB0DDBtkn1xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178970; c=relaxed/simple;
	bh=RUX1BaM/K5uVUO0RZ2Ew3o7FhTl1q7d4g9fbBtE/y28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a10CVrNcwtSLTXCihXsdAgMx2I36sd2VArTl14nSCD+KxwA2/QzXG9yjcCt4libIxX/ZRbPrmXJZ8MjtEvYRe7Fks5ndRZVSQ0yUzyfPNW0T4iAgit+Sy80w91wuF6cUe/AbUiC7QWsdP9kt8IMyPE01oC1mgO699S7aC1e97LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDoBRybJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDoBRybJ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e782e955adso247398b3a.3
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712178968; x=1712783768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUX1BaM/K5uVUO0RZ2Ew3o7FhTl1q7d4g9fbBtE/y28=;
        b=dDoBRybJSPi/JQPejHZ7Q5NJSfHgY/j0ehCoZND6Ky2hSjCJr7kkuMTpOmfF5r7SYb
         whOubSTPVqgHyHh9lHwBP7WlrigVczz4eeo68MNRgTVvr1oRpjG8RSF5ChLVse5OcNnZ
         ym6daZeuflWvtB0i8QPS+2Xnv3s8M0JW3UO92+EnwB9p+yTROtxZIuS4bfoltl5fAmE/
         fKdzX8P3/sZv+AYlAXaQsQE7N0RkeqruNIvOI7SpeL4b0mdn2GE7vU9DjLsyHku5lESK
         MoZN/MZu9lNMDfLbe3aStFW8t7vihXJE+cvHDpaSsKdr5xJXuVN9hQHVgWsVThqM8QF7
         4cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712178968; x=1712783768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUX1BaM/K5uVUO0RZ2Ew3o7FhTl1q7d4g9fbBtE/y28=;
        b=hjHuW49s44A0on3y8ihwmylsbTZ10NLzEgZh0pLz+KyC7qBMqssXdpyEiyzba+KH/J
         OyjXJk0MQ7m+/amphXo8Dn7jC5yyImPw0wxbOrBCFI6gj9aKwEW/Zqm8NHP3uty3rVKG
         uhyO7y3/LfAnqxL/O5RXOeOJzuexsUtxP4YArl7Lx1bBPfFllnzo0mIz7JtZGXZ/7xJN
         z1nsYgnS4d9ghWKl/Dr8WQhsZ2aXqPE2MKlN05uKAaunLMLp684Ky9i+ox9r7n8S1dDv
         R7fH916IN8h4au4leR+Q2jVnOOh12AXQMmRSXY3981+Fl68vPDgRnkxoqVcOWJGZl7d0
         HKPA==
X-Forwarded-Encrypted: i=1; AJvYcCV3SXjOZWQ/XK2Y1vUZgYlcy+d7BiEYgpp1RJ0vT4c8sz3/UpINkLrDOcG8uEb/eRRv0jYv0cs6jY6vNAuWNkasFpUd
X-Gm-Message-State: AOJu0YwfhrEOe2+CVkx7LV30FH7CE0nzxrav26p2ueaolmOeiw/OANCR
	gTc9HOF77Iz6QsduJ3Bp5ESRHLDsYbqUiTySDvZ7t2EB1Q/JzTuquv6gyB44+wWoYPmlC4ZBiVo
	31lCB9PQedCNjIuJmzmEiHTb9qu4=
X-Google-Smtp-Source: AGHT+IHz16Icp7elZ0aHbus46JHunDyIqsAn60SBghF9ROOaWBZIwq4o9yMXyMSL7o0jQ0JFmASPeumrcfoNk5c7J1o=
X-Received: by 2002:a05:6a00:1493:b0:6ea:ad5e:f4b3 with SMTP id
 v19-20020a056a00149300b006eaad5ef4b3mr854904pfu.23.1712178968544; Wed, 03 Apr
 2024 14:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401223058.1503400-1-thinker.li@gmail.com>
 <660b62aed55f5_801520863@john.notmuch> <cf7c6aaa-123b-43b2-8c7b-2c1e2b2dcb67@gmail.com>
 <ed6929e4-cf8f-43cc-869a-d79b0158c9ea@linux.dev>
In-Reply-To: <ed6929e4-cf8f-43cc-869a-d79b0158c9ea@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 14:15:56 -0700
Message-ID: <CAEf4BzbOBE0pdmdGeZKM2FVjZ5Rii=kjYNENzWDs8obGtLENuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Make sure libbpf doesn't enforce
 the signature of a func pointer.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, kuifeng@meta.com, 
	John Fastabend <john.fastabend@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 1:52=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 4/2/24 10:00 AM, Kui-Feng Lee wrote:
> >
> >
> >
> > On 4/1/24 18:43, John Fastabend wrote:
> >> Kui-Feng Lee wrote:
> >>> The verifier in the kernel checks the signatures of struct_ops
> >>> operators. Libbpf should not verify it in order to allow flexibility =
in
>
> This description probably is not accurate. iirc, the verifier does not ch=
eck the
> function signature either. The verifier rejects only when the struct_ops =
prog
> tries to access something invalid. e.g. reading a function argument that =
does
> not exist in the running kernel.
>
> >>> loading different implementations of an operator with different signa=
tures
> >>> to try to comply with the kernel, even if the signature defined in th=
e BPF
> >>> programs does not match with the implementations and the kernel.
>
> >>> This feature enables user space applications to manage the variations
> >>> between different versions of the kernel by attempting various
> >>> implementations of an operator.
> >>
> >> What is the utility of this? I'm missing what difference it would be
> >> if libbpf rejected vs kernel rejecting it? For backwards compat the
> >> kernel will fail or libbpf might throw an error and user will have to
> >> fixup signature regardless right? Why not get the error as early as
> >> possible.
> >
> > The check described here is that libbpf compares BTF types of functions
> > and function pointers in struct_ops types in BPF programs, which may
> > differ from kernel definitions.
> >
> > A scenario here is a struct_ops type that includes an operator op_A wit=
h
> > different versions depending on the kernel. All other fields in the
> > struct_ops type have the same types. The application has only one
> > definition for this struct_ops type, but the implementation of op_A is
> > done separately for each version.
> >
> > The application can try variations by assigning implementations to the
> > op_A field until one is accepted by the kernel if libbpf doesn=E2=80=99=
t enforce
>
> It probably would be clearer if the test actually does the retry. e.g. Tr=
y to
> load a struct_ops prog which reads an extra arg that is not supported by =
the
> running kernel and gets rejected by verifier. Then assigns an older struc=
t_ops
> prog to the skel->struct_ops...->fn and loads successfully by the verifie=
r.
>

This is actually a discouraged practice. In practice in production
user-space logic does feature detection (using BTF or whatever else
necessary) and then decides on specific BPF program implementation. So
I wouldn't overstress this approach (trial-and-error one) in tests,
it's a bad and sloppy practice.
