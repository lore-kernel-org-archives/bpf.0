Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E8836657F
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885276; cv=pass; b=RojNPXYGe51IoWuy2l0XeYhiMHWxGUENH/8lJykR9ZAYGmtY1tAwevWwiIDZ1PSxzxYGpqT0e6ea+JX7OV+KHNkr2Exb3cPImb5gw0NkUaG3A7B4NMWH+KhcmyvqoIDu+C8bjhQyxEF9MymE4FQqeXIyUQNHnSY6KXBVUclVULU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885276; c=relaxed/simple;
	bh=01NcniRWk73RX7UWSG45TL3VMgsq2VHUVlBj2/LT2S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSSepf5Ny6HSuqrCVuyF6M3uuFniMGF6HFpDetMI9ugUM6JIRNRqG6ihF4UUPPrEmrsZ0QZ/3z9HccVp1CoXvo7HA97ilHHHYkzFx1bh3sa5kI24CNLB1Ddw1k6YzCzvruJho6F1fmngX2SqY4z6Y1a/cABWQ6O/rGHlO3sJc/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MICfNkkz; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MICfNkkz"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6481bd173c0so2797554d50.2
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 10:47:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769885274; cv=none;
        d=google.com; s=arc-20240605;
        b=bb9XUsJRjPh0+PaSA0l8c6aL4RNS/TjhjT+LNKC+Wa337O4pp+nE8WTIf2SC7T0ibC
         hJoL4/WrIMgzP622vLmxY8b1Aj4SJk7AQo/ouTKrEhZ3/bnmB2IqrQJSp2g10Qw6Zm2T
         6q9xvsRXASk5uRTYhJxYv3FPMchBnC7Nj6TKcyQocEwLcun76mZ6K09ryAVsF2gw7hXj
         JiAnFUD2kHPaFm68AHzgG1/YyRG3HEzxbs0r5B4J8SkuQ2JgyDVd7Yari2rre7m2OGP0
         7YRCF14O/d+GXShPKgE+5FJalPOro8vuX/1NXhktMXmJBNMxrjhJRenZ5eekEHe210D6
         ER+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hq6gglAydMNz6LDEt0GsAhlm/k2RMlxREitLZ+elzRc=;
        fh=NTV76uWbumciG3jeF60otY9u4fM38o9+fxTjJFdrb4E=;
        b=MxLd5iAK5qL43xi2Wp7Nx6jk/d92AwDHHzZEfDmraxEzvz9UYxrjJyc33YS17aHQmI
         8UVXs7Ro0hDNdQc496hA754xCy90lrIp8MWMpQuKJfjPIpS3azUVX6MUVXpsUY/1Cc+9
         36y1xQWT4Cb59MEV8AeARBJjmGIh+le02Km7wzP24Z5ZtyhAR/ZEfGMpjOR7dLnw5OXF
         70AbYbi5bgtz0k4AEZ0HBZu2cJcnLKbwjReBeAS7DfbDUN7yvmyV5x7qjdDYTaFAoe/G
         ynWfcNc8YIV6BPB2c/B8M/CGNSdd+qAUlNM46Tt4bXtZBqpGpDDJHsitJ6IzHhdC44m0
         1V2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769885274; x=1770490074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq6gglAydMNz6LDEt0GsAhlm/k2RMlxREitLZ+elzRc=;
        b=MICfNkkzfJIRUG4hLQVjE8eTBQdCBdXQU6oNsvSaG0O1OWPgC2T9/N2c3YCb1GzYSL
         50mJSfaKRHjT1xrbuhF89RqzzuNPMMfG6/kqApiUB/uDp14uWd15UhL6besBs0dkq6Qj
         Vb4QrMKsvKSy+lXqn8msrcdwwp7L5Cw6WThAGI//G0vK5bF/sI+tHuVGDk/BqCgWQ7Rd
         IYM24ikCSwqgxDzELiP6fgLpRpgklByGGNPFEegxBIkeXsN+Irbr9OjcoxEvcMowM2un
         43jTk0KtRDRUd56bqG6x1zYX8CGPCzg0Mel0PM54QF1ZGJYXPXI/F299Ow6TNInxgbhG
         ELzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769885274; x=1770490074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hq6gglAydMNz6LDEt0GsAhlm/k2RMlxREitLZ+elzRc=;
        b=S0a2QE2XQDvFbM+w8CgeQrXhVRnnL8zrE0LpN8maw7U+EIzKBYpX78yFUNufEHlR7Z
         XEvMmlPsSTRZNesHMsCPw0R1+Dy2AXzNyEor+5bIFHvWWAoPMxrhx/t5AmVEtD3aKBVJ
         GYvDA2mMP9M4++MMFScqHc6+aaPpCBrgUVcKjte5cZcasJTxS1ycgQIkzDmCKJbivZv6
         WMEtq0bMDJHLoyTlHZ1Kbxn0EEp5vQMkHAgRNH0+bj10J6+9IwsPuXG0pz7+IkgPymFN
         TAWHE8+H+6UV0D0NCfybHV629MZnlO9MlEI5TIEk1RXZb4vja4s2zSQEcswUUbZgtM6y
         W/Vg==
X-Gm-Message-State: AOJu0YzmC2/js7tKVdI6JhUA3UBEjMyVJHz5frBKJxYe61sas3iZJVGT
	mhgQBEYtKDI9ta+wuC5w2rZptyVRY/fTUGf7U/eqRcZsRN3CaWbNd5hR6EKJG8CUg08EOhckRyI
	DUbLBtDZTNCr8pW1CD/xZtgTNkMP4Z4q2lA==
X-Gm-Gg: AZuq6aITt40AVicDXMM7XGGWTCKEyEQt87mIjwtJPjI+zfe/BVwvxr8s7mGQYY8K8es
	TiIlkA8rvy5wQDvSWP0jFmBK/L0L19ypTMb6PexG0lA3Nh1hBAEuNigZtJmw5ngIdSLtz309sXb
	TZzvxyUEkEVv6whhxfDdyrTIYAQaFR9VZv3IdR4qQ5YaWWKetgBEFA9AW6YKWrXGUnc+abpsSNW
	NSEgsQPUI61nTkvPOK+bEElWYNmnO64a6s9sgf1w7qj8QZeYplLoHrJPfKQ4uA8kANte54=
X-Received: by 2002:a05:690e:d07:b0:641:f5bc:698b with SMTP id
 956f58d0204a3-649a84ef9c4mr5293993d50.71.1769885274122; Sat, 31 Jan 2026
 10:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-15-ameryhung@gmail.com> <bc860132eed39c90ac3599a9db86e80c781cce157f7edf455826d46260905a7f@mail.kernel.org>
In-Reply-To: <bc860132eed39c90ac3599a9db86e80c781cce157f7edf455826d46260905a7f@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 10:47:43 -0800
X-Gm-Features: AZwV_QjeI9z4V6kjV9l0CrQHNZtAvmOJlSNJxtI-nJ5LEEqpQRjioTMUKxnFaBo
Message-ID: <CAMB2axMmbZWgY96miTwmvOL_a4pGMdHUOR81ofeQCCq7iqmAHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 14/16] selftests/bpf: Update
 task_local_storage/task_storage_nodeadlock test
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, haoluo@google.com, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 9:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
>
> commit d58597062a783f7c4b2997c007bb7178b268dd14
> Author: Amery Hung <ameryhung@gmail.com>
>
> selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
>
> This commit updates the task_storage_nodeadlock test to check for the new
> error codes (-EDEADLK or -ETIMEDOUT) that bpf_task_storage_delete() retur=
ns
> after the rqspinlock conversion, replacing the previous -EBUSY check.
>
> > Adjsut the error code we are checking against as bpf_task_storage_get()
>   ^^^^^^
>
> There's a typo here: "Adjsut" should be "Adjust".
>
> > Adjsut the error code we are checking against as bpf_task_storage_get()
> >                                                  ^^^^^^^^^^^^^^^^^^^^^^
> > now returns -EDEADLK or -ETIMEDOUT when deadlock happens.
>
> Should this say bpf_task_storage_delete() instead of bpf_task_storage_get=
()?

Yes. I will change the commit message.

>
> The test code checks the return value of bpf_task_storage_delete():
>
>     ret =3D bpf_task_storage_delete(&task_storage,
>                                   bpf_get_current_task_btf());
>     if (ret =3D=3D -EDEADLK || ret =3D=3D -ETIMEDOUT)
>
> Looking at the kernel implementation, bpf_task_storage_get() returns NULL=
 on
> failure (not error codes), while bpf_task_storage_delete() propagates int=
eger
> error codes from bpf_selem_unlink() which can return -EDEADLK or -ETIMEDO=
UT
> from the rqspinlock.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/215393=
40647
>
> AI-authorship-score: low
> AI-authorship-explanation: The typo 'Adjsut' and incorrect function name =
reference suggest human error rather than AI generation, which typically pr=
oduces more precise but sometimes generic content.
> issues-found: 2
> issue-severity-score: low
> issue-severity-explanation: Both issues are commit message errors (typo a=
nd wrong function name) that do not affect functionality of the selftest co=
de.
