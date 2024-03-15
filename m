Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C134D11737
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710477905; cv=none; b=Igv2nFjwtZpXLpAyFSH14WT8hH2/nAFCQXr5PAb1hpeNveasNsVNTSriptbHIble9qyEEjY5QhoZhpfkk2twbqo85gvOvDE8S0akrOxuXqeCme2O1YV8E/8s6h4W5XNHxbntSUcbYhwWztzcg0RhdYkNBelolG2ik8Lxyow7zog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710477905; c=relaxed/simple;
	bh=/PyWIUXxaLMz2KVi/YjIJxN39czF3ar+mdnZSKDgAno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JE9xkaMq1xkXPdtR+k38U6U6LJ5ShSextVUkUfhL3g7ESUPmtu1S3VoZyqIt+fiFifYzdecdGwwoZnrbm0CdVfAlQ2BPcGR9r2mPLTGvxeYuT8QFw9wnvOhrejVgk+9ij3j8nvJTxk8STufZOgQyFWO2APxLjFl8PHR8pwe20wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/bdnBxJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/bdnBxJ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ed4d8e9edso19617f8f.2
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 21:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710477902; x=1711082702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERezzMYOxc5344VP4JPhA41YPiFtNMpa8Qmjc91Q9Gs=;
        b=H/bdnBxJ2Zh3DRakh7uJc6+eWLQTtkCSNNfDP6UYh97KkiJN8REEA6Zc0vLYAtSnIE
         M+lFGNb6OLLWQUrLSRpiGxc28clTq42TgEoKsS9tP/Sgk1agDLFPv9Br2nRg/LY5A35y
         VYa4OOTakY9gdxCoXTK+QPAnZx3I3NHNnM/JzPPYFm2/h73NEaoopscwlwBk/eqqaQ5U
         UQGWHXntPqbVdk2k4ikHsncKemsiW6Q4PlclpGUUfp3PN9wKzOx51ISfnrQ96oJntMM3
         hvMVh7ykYo7hH9m4YDoh9W2xX9g3WJCEfkEW86T93zYnYuj5BOob5Kih/CqnoYoO+wMG
         kdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710477902; x=1711082702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERezzMYOxc5344VP4JPhA41YPiFtNMpa8Qmjc91Q9Gs=;
        b=fbK8nKSJLz7jOuFXiMoLTBFQNt08kqTOSHJQSHSsAJpI5z2pzKFmUGRi3+5MwAUDEM
         sIooyjfvsxVlmn0cQP1Q+t8f5+eW/unNEGxLtgjiA5dvTQiXuf98P7nMyDgkKu9L8Qyq
         G48EWzsjZEiSLn1vQYG1SDi2N8rzibz4kGqToSvuFRGlZpfJi92iLnA302XGc1ljjju2
         ffg3vg++Ee8gk0i96CraTO+wrb60ooWVw/L9/1/Zj9yP0vZVy4zu1WBIOrXdOGqeXhMl
         750J2i2uruu9HAInq0ZH64/MYyTN7m8xJOdVa6us8pdofrHe8KoYLSUzVl0gGsZ+hNyk
         ekTQ==
X-Gm-Message-State: AOJu0YyJjcN7jx243zph1u6TYW1MnAk3M7kZ+gZav9ii4ejh2cibmP2X
	+uQ8aBAuFuOo8H9j3a/VU0NYMNT/eD97PghJcjibFYCIQK055kXu6ZN1W35IU4q2Wvi5GzWvF01
	JAZuqxi6KYDT95VXsJoGliy7yxFQ=
X-Google-Smtp-Source: AGHT+IGzJCXoUX32FqiuLyaaSHpOfMNz35Qkrj+7hzobaKLFMfUYrD9w4F+KOJoC9lrqYM62PSRvvtPaZAMRAAowWOI=
X-Received: by 2002:adf:eb11:0:b0:33e:bb74:ac0c with SMTP id
 s17-20020adfeb11000000b0033ebb74ac0cmr2899896wrn.6.1710477901921; Thu, 14 Mar
 2024 21:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
 <20240315021834.62988-3-alexei.starovoitov@gmail.com> <CAEf4BzYpEz=XGwYaG8_YBRU6WbDp_23ybVLC1aEy1bYMJ77hVg@mail.gmail.com>
In-Reply-To: <CAEf4BzYpEz=XGwYaG8_YBRU6WbDp_23ybVLC1aEy1bYMJ77hVg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Mar 2024 21:44:50 -0700
Message-ID: <CAADnVQLX0=aKArQoxZt8sc_TgnNNz9+4Ycxvhnpo+AixwRK=Fg@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] libbpf, selftests/bpf: Adjust libbpf, bpftool,
 selftests to match LLVM
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 8:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 14, 2024 at 7:18=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The selftests use
> > to tell LLVM about special pointers. For LLVM there is nothing "arena"
> > about them. They are simply pointers in a different address space.
> > Hence LLVM diff https://github.com/llvm/llvm-project/pull/85161 renamed=
:
> > . macro __BPF_FEATURE_ARENA_CAST -> __BPF_FEATURE_ADDR_SPACE_CAST
> > . global variables in __attribute__((address_space(N))) are now
> >   placed in section named ".address_space.N" instead of ".arena.N".
>
> .addr_space.N, according to code below

yes. subject typo.
