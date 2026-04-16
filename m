Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA422F01
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350466; cv=pass; b=fxXzBP9M3HR7is7Z0fZqo774QWvc+wBsJh3FG1Udh686k5FU4cAyK3eRoYOzUPmpf6GQgvFHqAU4LKY/zZx+G8qAtMucPbGgXFUdSLOktMiEEsAnTuoZANRoaXJomeOze34yxa4gz7G4TFyRdpUxWZtdLWtsAsTMivHjxhEYjuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350466; c=relaxed/simple;
	bh=iFMInkULX3UZN25wGD9JiWJFC125zXpqFvpXch8Z7kQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhwhQ8wVMMpQIwgPx3GZLcN1yyDqqEHot0rhzMZy778Wi58/zP2fjzxIgTDPzmJTzMm3vfUTRFce13JTFih4FEl9ibRpVD3Do15aRCbwi39HF2diynqvbP7oipxrFA1nXgwVTXhVGNDDmy89rFNu1sm5tRuvrxloGPCJtff67R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEgnZiDc; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEgnZiDc"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso7386362f8f.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 07:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776350463; cv=none;
        d=google.com; s=arc-20240605;
        b=ZOLaE7rHw7ASDTCL9XmB7yVmY99T8uYv+zyeU4hKyhGJ+HV81kRn9ggs4gjQkQYAvO
         dqNf1+jKXoOil62v8PQs6RlazgYP20YUn3A4Y2ChvFqNAnVvsRs45FxgFKhwWfWrA7sv
         rt42h6d0pRJibK+/6hoXMoNf8LT1ViCpNCJONUYV91v8AB4KOA6utfXECwDOcH3Gu/kk
         +LdsdCpquopSRNykaDU0aX3hotOmWlhWq3Sit6gw9CWfrE+rRi/DPzga0drGZWMzcPcR
         NtXBIThKHiA7sSX4LVr52xOpWJuFcT4SQcPt+5REdZOfXUiyrckqpg/aPj9TcQwDQrHo
         btyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MO//303tSr4EotbIoVSwoRg4JD7Ew/ncX7VIhpkiHhk=;
        fh=2lGZXEzoh1zRwuS2Z7SKyIlaXPhHKhf70g3CimSGk94=;
        b=kywB57WAfBjgKCan6rfGyKbV9YfiVEBcVpus5QmGxUpuacs2YgU0bK38kIn0IuJPkS
         azJV4M/qXhpWH4zLwXS9kaoai4Tr/EdqE9mhSlRnccbHN8ureF9cPRjGjVg7vN0pO80V
         HsS02JFhJ7jMGHzZR0qD1HHYpx176X2Ys5wnlrlRu5yunOsDQDROpCLjBjfsDUHl6uFE
         utBQ4lCInZPisx5VomAIO5ghBFVpCFZ8ImwspF7KT6q2c2LuY5BWNBh2L0mab+fFJjMj
         BD1++cXG6ubkghBFLbb38mG7dSqJwDBLigtkGj6Oiedu+8xVULSRtsnsSA5qzLRasB7Q
         N9DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776350463; x=1776955263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO//303tSr4EotbIoVSwoRg4JD7Ew/ncX7VIhpkiHhk=;
        b=aEgnZiDcVvYzxPOMvv2hge1qkK2g5Ol4f41idycS7zgzDa6y/7JOD9qm9g5DeXNsHx
         LaDCXN7Q0NUnVPjx8dnfUR3TC61kdgO2itZVI0RbvBb+ynPduNVPCbELUFAg0ubH4U/X
         T5kMDkOTW5UUddo5AfK7TzhPfb7Mx9/Si5oR7oWnQ9ZgouWxVzeAg2YR7IGqXGp/kUn3
         aqAs76/OwkAhI2s4yWhkWYVN9aVkwz4xhO3mNlS4mQMP3awArSgL05suf3twJ/tHXU41
         VUvL26zdZvDjfUYIzAMGMo8AkibYfQMv88CE/1CmUsI1vPykHqjsxdRxvdQrHENtrHMP
         DFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350463; x=1776955263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MO//303tSr4EotbIoVSwoRg4JD7Ew/ncX7VIhpkiHhk=;
        b=lGYnEpSCiUWv+7o2J/1nIjIWngV+XICAc9hAZFCulFJ+NhonzkU7ezvOnw4bBIT+jd
         eOqiYBP4tSQE4goiFCa17meOYVddUMTpM27qGz5AxkzRsh8LCWhvAwoIwCcEKd0CXsv+
         PV27REvk9iKL9Zqtu5Kah0RsJtX4RNiYwD7e1VVzcRy5mGzmhjdcL2bm9tfMjAjXl6o8
         vKZfIBb3KeCWbHLqR01BG7yPWr2FfBcrpPzb6kgHjRj6ZHH4l6AT5PFdX2nhpqxIeeww
         uQ51yNDgdefoeQtPDIN94sFHvJVRSoYlJrxO4Gq51YEWn5EPyrHRWRp6cyu0v5H939Wg
         F10w==
X-Forwarded-Encrypted: i=1; AFNElJ/8nE4Oj98yBd2UdLtF5s2+W70wq5eOp2ENM9pmQ8s74RPgEi2g/xAthFLU5MaxmNwbwFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1RRejCpXWKqDz5f+VSGs8+7i6jy1jCaE2V9Guj4bCFS1v5vP
	9Wsi5kbG642gXQU2InthZF8C/mM8vq5LYxcwrJW7JmKBgJWtys3Dr9jW9sBg2I2/fAupZDhEWLY
	MWH1Np9gk0VfAyiJBEreRvQVQ0bPU3WU=
X-Gm-Gg: AeBDiesVFdKffOGRhbFOSXN96F2nKJ3Quf4xrDo3QcunGFs6Bh+EPeA8YCJUmwYDOlq
	rDeZW+FG+e1VuamQxZWmmVDRPIsoFKx9Be4BsJg5VOMicQui0Oc+gKbDosUI4L0nFbelXqT5OoY
	MLnCW1HVfW1/TEBaxN6DYhrzjAvSVgygCAji5WXD1oqQwO29uQygBMJ5Eh+OCU6A0Hn5JjcfJar
	Plx0iCg8PvxN4uSh9GKDCMwX4OLHf5GaifEHYgiWXC9b1/Lq3XNteZ8H3/om3sfROVfwHyUIxQk
	bJ5BGxFHM5kONyLMz8E64QXMmVoy+DvP80YsH1RUohY65yXdZzXvQRP6eHD4tlj0K1hI6wp1Nls
	bf7iajvvST3Xyv/9tw6PjaK1/9bEtKIBwpyMi
X-Received: by 2002:a5d:64e6:0:b0:43d:7b7b:ab76 with SMTP id
 ffacd0b85a97d-43d7b7bade0mr22728252f8f.10.1776350462839; Thu, 16 Apr 2026
 07:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
 <20260415-sleepable_tracepoints-v10-2-161f40b33dd7@meta.com> <DHU7408DLITK.2DC76VINL2F7K@gmail.com>
In-Reply-To: <DHU7408DLITK.2DC76VINL2F7K@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 16 Apr 2026 07:40:50 -0700
X-Gm-Features: AQROBzBqLbKs9qZ0cpirZPkwnvXOoOuZMXFmWb--SmncoEUw79AQQLGLbqnzlbA
Message-ID: <CAADnVQ+6udrUD-xW96ZJkz3UkEq8JZAdFiMgB=f5jfFaYVjJ5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 2/6] bpf: Add bpf_prog_run_array_sleepable()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 6:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed Apr 15, 2026 at 7:49 AM PDT, Mykyta Yatsenko wrote:
> > +     while ((prog =3D READ_ONCE(item->prog))) {
> > +             if (!prog->sleepable)
> > +                     rcu_read_lock();
> > +
> > +             /*
> > +              * Per-prog recursion check to enable private stack.
> > +              * Skip if prog->active is not allocated, e.g.
> > +              * for dummy_bpf_prog used as a fallback placeholder
> > +              * by bpf_prog_array_delete_safe().
> > +              */
> > +             if (likely(prog->active)) {
> > +                     if (unlikely(!bpf_prog_get_recursion_context(prog=
))) {
> > +                             bpf_prog_inc_misses_counter(prog);
> > +                             bpf_prog_put_recursion_context(prog);
> > +                             if (!prog->sleepable)
> > +                                     rcu_read_unlock();
> > +                             item++;
> > +                             continue;
> > +                     }
> > +             }
>
> What is the point of running dummy_bpf_prog ?
> You just checked that it's dummy and yet want it to burn cpu?
>
> Once again, please de-claude it.
> So much unnecessary indent.
> Focus on keeping indent minimal.
> Since claude cannot do it, it's on you.

One more thing..
Please go back to my 'do your homework' request from v9
and answer the question why it's not safe to do bpf_prog_run
on dummy prog like this patch does.
I missed it yesterday and only complained about the waste of cpu cycles.
It's more than that.

Do not send v11.
