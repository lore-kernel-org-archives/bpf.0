Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4468B1514FC
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576764; cv=none; b=EgQvN8/aWptoviOfxEJC26z0n8T0XfCsDj9a87u3RrRruqdZzWqByvzPNm74u9L6+UvwcCjsmAmx5+0AQAdXzIB22Bf8aukHvYImQlBwlEmViH85ZbWVAp2OSjw8tEDxANt2DBEY6OLb5q28cFcHOfvvw7RW5djeWnvzYyxsIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576764; c=relaxed/simple;
	bh=aAILbGFFjkLieLipcdcuQ3smAjtxlzegMLeiyRL8j6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbTn8EsryI7hSBnLfUiD8kEKkx6sZ+uDcGQLh49dIX/+djHaOSTScewXkHnxr8V+VUZyoZtB5r79pp8X9TdUiyhN87Dg7njIM3nUeJO3drEsHcORiY0nLAnsU66Xluxs3qb8fEFt0qHKVJMibMiwDR7sFIp7rysho+d83bxpE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aha3eVMU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aha3eVMU"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a45f257b81fso34509966b.0
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 14:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711576761; x=1712181561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWC2JBtqoUh8sv4+sbxBOmngiXoo3lvxOSttbJOftf0=;
        b=aha3eVMUzYmu05/kzGlhhKbB6bWVts/RnBN6qXOgBSuIvYD7YKDzvTzu5JiYq3hRhR
         mR/kblgXrBrAf0jpsphlQMtb3l9pdKXDkZhicO9amEWwchFnMa/lsRGGYJqFIgKGSkso
         fHzxeW3I2yMXh6XFs9y/AIv7rLAafjuCqMORp3no2BUFKJFFgg9mz+eC4YkrqDj3i2ZP
         reBF/55Dxv+IVRu1lXlsS3+T0hsiq2G2k7u7+rfEdGHh3qYnwumjwsHt2aVM31VWT21D
         0mXdnJmUkpMFjP2jOsFquGXGJVMPdJqkbZkpABLyGUMzQ49pmfJfiQpgsRCr9f6VmlqF
         QBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711576761; x=1712181561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWC2JBtqoUh8sv4+sbxBOmngiXoo3lvxOSttbJOftf0=;
        b=SbUhci4ud+eDqUHunnd7XTb7paUfF35v0vkJn7vx7DMzNE48Em1cNfkmpreV73LwDK
         +TRUm35HwHxPg5tQVetgQfu3FxAglzErbEd4p8x3LW/64wS4OGMVOhINpQ7rGXxJcaVt
         cCwD9N/VLosMUh1PaRw+faOu+MzlWrp6a71Wygebf+79enaFb/DG7DE+GJ02Vq0VJrSX
         3OxIdLR9pw/GpSNVGMsg5XI0NGlm3WZziZyZ9EzpwMFV8BQSQynYJVsogxUV9vRzjzhz
         6pJdyi0ay8DO2d0fL/veDPLtkXa1+C9ecjrt33sttEDIiwRAeew2c9tt7Cn4smJs+4F5
         9KGA==
X-Forwarded-Encrypted: i=1; AJvYcCX4T0MjdE8BVKha11PiitE0JAQoCL5e9qfs99jpqnedoFrmXmVEybhWZWaoCj9WnKxzmFMYHi0z72xFFQeSkqCEl1pz
X-Gm-Message-State: AOJu0YzPB6PJOluXyyMMjJ1gl9h+6fQ0rYZKKLAofGMqfoonvVqY/5vq
	gWxNhZGbDR/+WR7BHenPnApR+k42eMr3V3b1Rd4KOLbScdD1WtZXBub9zwpbq69d2hgrg0gTe0O
	7L5tkBNEctIPo5UpscnpwlLJ6UAk=
X-Google-Smtp-Source: AGHT+IG/dWBxkBxfUuWlBVO6c4YY4qHlLpRZlYxs81wQ3IXwOKZ6HXVqE+qHQDOzijUrlcaHidB/yJKUYsnjaNFK2QM=
X-Received: by 2002:a17:906:40ce:b0:a4e:ed5:e02d with SMTP id
 a14-20020a17090640ce00b00a4e0ed5e02dmr555114ejk.31.1711576761468; Wed, 27 Mar
 2024 14:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <CAADnVQJqnLnv4AUvCaefP13CDcJOXM=kJpSOv33t-u-OTzb0UQ@mail.gmail.com>
 <CAEf4BzYFc1b-OAXWf4WN_vM2evZgsW7reJqo8iwKP80EXBJMKw@mail.gmail.com>
 <CAADnVQ+zT8C=rHtTbbsdoPVw-n7PPufPp0CC+jt2PUn9bB5gxw@mail.gmail.com>
 <CAEf4BzZqem6OQX=LHwz7cfvCGXmbFVHzSgD-9i6C8dfMJTMT3Q@mail.gmail.com>
 <CAADnVQLUVEWZB2WgkdCGkyh3T7ocZf1SkqWLAz6jGK+9LU_MYw@mail.gmail.com> <CAEf4BzZXYmDCP5WJ786UN+zBS4d9TrZM=cLQCZ9QihRjbriyUw@mail.gmail.com>
In-Reply-To: <CAEf4BzZXYmDCP5WJ786UN+zBS4d9TrZM=cLQCZ9QihRjbriyUw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 14:59:09 -0700
Message-ID: <CAADnVQJKdwz0n207qV0LJeGyjbht4S=mme92RjwJfhCS4_dF2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Inline two LBR-related helpers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 9:50=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Fix in the sense to adjust or add another generic
> PERF_SAMPLE_BRANCH_xxx value? Or you mean stop using --lbr=3Dany mode?
>
> > I suspect retsnoop quality won't suffer if ARCH_LBR_REL_JMP is disabled=
.
> > To figure out the path to return in the code
> > ARCH_LBR_JCC      |
> > ARCH_LBR_REL_CALL |
> > ARCH_LBR_IND_CALL |
> > ARCH_LBR_RETURN
> >
> > might be good enough and there won't be a need to do
> > inling in odd places just to avoid tail jmp.
>
> retsnoop supports all modes perf exposes generically (see [0]), I
> believe I tried all of them and keep gravitating back to --lbr=3Dany as
> most useful, unfortunately.

I mean to use PERF_SAMPLE_BRANCH_ANY_CALL | PERF_SAMPLE_BRANCH_COND
which I suspect will exclude ARCH_LBR_REL_JMP
and will avoid counting normal goto-s.

> I'm missing how we can get away from having a per-CPU buffer. LBRs on
> different CPU cores are completely independent and one BPF prog
> attachment can be simultaneously running on many CPUs.
>
> Or do you mean per-CPU allocation for each attach point?
>
> We can do LBR capture before migrate_disable calls and still have
> correct data most of the time (hopefully), though, so yeah, it can be
> another improvement (but with inlining of those two BPF helpers I'm
> not sure we have to do this just yet).

I meant 32*24 buffer per attachment.
Doing per-attachment per-cpu might not scale?
It's certainly cleaner with per-cpu though.
With a single per-attach buffer the assumption was that the different
cpus will likely take the same path towards that kprobe.
retsnoop doesn't care which cpu it collected that stack trace from.
It cares about the code path and it will be there.
We can make the whole thing configurable.
bpf_link_attach would specify a buffer or per-cpu or
a buffer right in the bpf map array that should be used
to store the lbr trace.
