Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE533EFD13
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214598; cv=pass; b=ZQr9l72i6r/97DB4sVSYSUKdR7ci/81DwVamXElxyifQVhNmWy9N6WBwIgTMN+16Bxqa/Zc1wjcB0iv0pNxRp1Hek7v3xpwj3lwBii046eIHQ+/5/250esn0O6Q37IPf1tO5cR7nLWf65y0f/ANieWTheweUotSFdg6hWVAc3rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214598; c=relaxed/simple;
	bh=/uvihP7EvEzxoRD1cG5Jc59Kwrn80ZYeZsAstsc84E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3EwJBE//IdWIClQKUlgq33knpYBmHKBgOL3Wb8QP99t7vAanUnSnkyPiaUk4WyfrAX8TEALbdN6p2ZD8N7jwom27k0sbFB+w+PlPYPTyNCyetc+/9pWYVsiphbL1glqRn0ZYrVstn/kGilZPartn7i2Y3DfbihzXdLWgOk45Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XScs5C4D; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XScs5C4D"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8e9f89a8e3so133602466b.1
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 06:16:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770214596; cv=none;
        d=google.com; s=arc-20240605;
        b=jLfYnW/y42XJc49tnDlEsBZxcrwUeFls1ShVCDgl/hGwyZ0hRAgNZ5JQbAIkrl6Tv8
         eMY4kyzze7QvnnF6UNWAPPWpDDrMjYVn1lY1uqWCDdlxJiFS8MiFMr3Ld00aRh5URsot
         r4Gt6EdlQDbYTEGhxz+Kh8IjpWgeg/Hz+FnkfrFfyhGhjzke8wO6vqignJQFKfvltd84
         BL6emqqZSsFxvDcXn6v+I6iPNjaE4VBq/FA5LIp29vmP2RwjmbjkkcIVKJN3rS2YwcYs
         hnVnI5Qzq4oFLa0NDpIh0FLS5aQCawV4CejtzW7s59Dc1A+xoG9nYdlgnDnIL+CjaDyz
         xCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yTQ0Zw2atCii3hmVPHoxAgrwrXp98mhcfcvjK7OLeoU=;
        fh=lW0ktH6II8XKsa8ljMHuEd7LoXJFnSvpDKRN1joQxMw=;
        b=hwdeW4oZ6eOrbyWLtqyKCq8xTs6EXihjVgChHaCgRpDsWIg2AhSq8Qwq5nfPUbt+Ih
         J5AyaVi4Ziq9Q+iKiMIoqSCyrm4s1j81+vtq9RKEwJF5nd+xSOe1SBtPm9wkIJ/o+dW5
         sR9zNlmyMKygP0aOUCYB1+fUmSfveNN3ViZMmEbx04d7uPwhubq+lvmcPCN3EexqnfIS
         dH57JceCgCyLshDDrKiLw+w4UtntVD7UkCd2/ousD7mFFeoO0iZJM5WaX60YaLiWRgwQ
         Y19z+adRjQSc8Qtwn/4S1+9X7/AkFUWF++zAiJECfyK8+O8gf+SF4ti5OdN2IjfQX9DP
         i4qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214596; x=1770819396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTQ0Zw2atCii3hmVPHoxAgrwrXp98mhcfcvjK7OLeoU=;
        b=XScs5C4DwTKr8Z7HHkXFnz1Ghu/0/vedqKny0908DhNzJihLnodLUvVK5g908xQxfE
         ZtpUGttTBoBoiKohCit2SCwQN2UQNQCeFB55Alvxu7Mk/Y9H14SSpqk6rB87XRRudxoE
         JIu36pjwlZ8Jm/kq3uQbDmi+lmId+wEOfY6A1VaSuIkZ4yZNk3qlXMtgw/whF0DDViv5
         N+vLDtI9tAX63UAndJyOGNoE9MgUcxSXM+wylIkIhRUI1v2jx87DoJzsxbcwFMgCvqRT
         YufAEdPTsUdmgZy/cd1uBkb3tAAl21T9UJI+NxDV9o+bwhG9bIdonzlhdWphLPpHOGsJ
         ep7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214596; x=1770819396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTQ0Zw2atCii3hmVPHoxAgrwrXp98mhcfcvjK7OLeoU=;
        b=vN+Die5Yhl6t6O+PHLjwTazR4ivuQHWB28H20Vgi6QSbsTdRy8HiALx7rgM6QShZCJ
         TYHJdU980IieCJ5pOWTa097BReXSVn39M8UHXmCqy32qB3dVs9HnsrBkL84B4GquVESP
         D1ZmAXN79xRxLgn7k3ua/T84/tstmU6hmrjdgOZlQ+8UcR+Dj3wBiP6b7JjLWUNAMHzj
         e4Yv8c0p3V0T0pH8+JbHWkaNwp774tJnqgGoRkXECxTFoGmdGVnbYA5BMh77ybvjiIgh
         bdquUh/fAe4wa4/EqvkT59O+VqKShZLuBFtRLJJ2Cf1O8Uqf6kC4vt2mIheZmkbn3haM
         rbOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnzeXPLn2eBFbtEtqh8N93mZ7pmHvPrNou8HHSgiiF2F+iRIu2ROg/Da+cWh09MBPGsLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyflofspW9gkrlaOCQqaBpWRoF4HfmQiXNdvhNkrWeSkyFIIL+Y
	oViOnSmpXJlZA7nc1OF+apXT4IaDIiGv2VCSUw3rdjvGNvsIXkb4jA7dFNJ0dQZ93wqozVHCLjE
	Y0VRO2oL4dYsaEtw06ldTrmJTYbWHWyU=
X-Gm-Gg: AZuq6aLmLrkIf3NMHd69UrUwjszdTLkOCrKPtROc5xIcsxmmiPh/J4jB+0zPQ1qog9a
	rjE4xAvfmxWuazY8kZDeDpuQjo5ZyG6VZNuzSMorZsEChPajA01fq3wlTefqIlMuN0pRsVT8XhP
	Zu5S3Xde2Xv5w0rFOlFRO/MjjljSWuD5izFH2O5GG4SPJp7BJEEJWrigLcl47gD0fQhUyA0MT9N
	g2dL58GtwAscshzKgpdg4Qekx7BDvUfDFsrfjWL951QKrL+2hZgGA/mrZ5gR7puI4E0EKNF
X-Received: by 2002:a17:906:6a26:b0:b86:ef1f:6d19 with SMTP id
 a640c23a62f3a-b8eaa105212mr109290166b.59.1770214595769; Wed, 04 Feb 2026
 06:16:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
 <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
 <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com> <20260203101707.52965eb0@gandalf.local.home>
In-Reply-To: <20260203101707.52965eb0@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 4 Feb 2026 22:16:24 +0800
X-Gm-Features: AZwV_QgWGCvg8g2Ns9vomUQYUfDH4ZiKmkw9hkMOoT3Tdq5N5y2-5kD4RLk-iJ0
Message-ID: <CAErzpmsjt7=EsLZfSMALRTM9ZBKPDYWGWE9__w49OTk_VL+4hA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Steven Rostedt <rostedt@goodmis.org>
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 11:16=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 3 Feb 2026 21:50:47 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > Testing revealed that sorting within resolve_btfids introduces issues w=
ith
> > btf__dedup. Therefore, I plan to move the sorting logic directly into
> > btf__add_enum_value and btf__add_enum64_value in libbpf, which are
> > invoked by pahole. However, it means that we need a newer pahole
> > version.
>
> Sorting isn't a requirement just something I wanted to bring up. If it's
> too complex and doesn't achieve much benefit then let's not do it.

Thanks for clarifying. Analysis shows most enum-type btf_type have
small vlen (78% =E2=89=A4 10, 95% =E2=89=A450), so I think that  linear sea=
rch could
be acceptable.

>
> My worry is because "cat trace" takes quite a long time just reading the
> BTF arguments. I'm worried it will just get worse with enums as well.

The delay stems from `btf_find_by_name_kind`=E2=80=99s linear search over
vmlinux BTF (10k+ types). This was resolved by adding binary search
to `btf_find_by_name_kind` [1].

Performance tests [2] confirm the improvement:
1. Original funcgraph-retval:
# time cat trace | wc -l
101024

real    0m0.682s
user    0m0.000s
sys     0m0.695s

2. Enhanced funcgraph-retval:
# time cat trace | wc -l
99326

real    0m12.886s
user    0m0.010s
sys     0m12.680s

3. Enhanced funcgraph-retval + optimizined btf_find_by_name_kind:
# time cat trace | wc -l
102922

real    0m0.794s
user    0m0.000s
sys     0m0.810s

Binary search reduces overhead to near-negligible levels (0.794s vs. 12.886=
s).

[1] https://lore.kernel.org/bpf/20260109130003.3313716-1-dolinux.peng@gmail=
.com/
[2] https://lore.kernel.org/lkml/20251209121349.525641-1-dolinux.peng@gmail=
.com/

>
> I have trace-cmd reading BTF now (just haven't officially released it) an=
d
> doing an extract and reading the trace.dat file is much faster than readi=
ng
> the trace file with arguments. I'll need to implement the enum logic too =
in
> libtraceevent.
>
> -- Steve
