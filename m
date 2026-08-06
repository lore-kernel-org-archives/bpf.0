Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D963DC4C8
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051223; cv=none; b=hdzQNj6+EY5G0OQU5BOWvcKUeCjjZL/ytNBi4/ENhH6iF4KjdNHW7OQ9Lmzdi0OPmNnd1WvbJJK8CIH3lrHiCpgxST9GMf1CldiFmI/VtWNklGRrvGkS4Sl/C+WX3BZOgQfrvFEVLzmff/PwN+xkC8jhLDO5T2WwXjzT4ygC4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051223; c=relaxed/simple;
	bh=5DmiLCus0BNJY2MQXZJ2HZ2f0K4BjefIRnIV5S5citM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qiLvbOPvMweeoNscr6wD3Czz7lOcgj8R6029z5tYtU1Prq5yMkqJsTEGtaSPUZ3PU+RcqSzqNlvKRR4/P9q2jkHJIFUgf0kp+MR2DgYsYq5e3IP0OM6T+Ik2m2BCugjohFbB/JcbPWiKq9FeWwDrtA10qzFCXcQnU+kHLWpSWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnbcwkUA; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnbcwkUA"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso8496955e9.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786051220; x=1786656020; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oniInG7avuS0mACAEWfRzgGy2j9eCubQhdrIXfLhVZo=;
        b=WnbcwkUA3ubs2zOU9mmCl3HWZUPnSYHoqRDZtQrYUCgWcRWNLui7ku6RhqpQ1+65SO
         muuAeI9LPHpSfzt+CxzPMZBMRHE7z9PD8B2aC63K4I5WNpu2tXULE/EeIECdK0M6hHTj
         5jHyhH/aoxR92+hqE7lSev+mzxc+5IErRDN/yNb7l8plSpVnK2lWw2UiNHgMH1vfjgw+
         r+pPsiM5kS3vtL01UvRhW+dwOZAkCzwVXr6wz5+xwvG7SR1qdwfJgquTgiZCohVZQ2/6
         SHThXeHAoX0dQ/OXFK/7GzUp6hmzpYY0qQ1z4rN7GDw3NbA23hzJRWv3UrDRTZtc+vzc
         z04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786051220; x=1786656020;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oniInG7avuS0mACAEWfRzgGy2j9eCubQhdrIXfLhVZo=;
        b=BVG99mn3/A/2WYwnA/AHWdlaBXSPRA47HEdOEMpHf13dGn98kIvZ4ZuoizZR8VoNeT
         F15DVQu6pKNpdnFYUo/yAAlT96lDWYfttV0GGe+NERkfgfoEoXnTi7yeG2l9xSNGA9tG
         T8eWfST6E/S71nQ0kUOL2YxZxYgFfRhTmSnETy8pnS2c6TJ2BNN6AkbOZZKI/UaldLqB
         dbmGhRddM3hgwkmySGXuQn7ktB8dYCZbBSGrirBhQs/CE71yW+qTmVJCxMCrBm/ULnM+
         W3rpzKK1wDFcM+lkUfMEUAoK1f/STG4kary2V0jCvC1DSS1cjVa89VtNOO8M8Y8nCPvm
         AeRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrzs++NIjEvItG/skv91x9tW0pxCGTmFuwJ/Sb4w3n13msLTLd0Mr9T5jssoenLbQQ0Ewo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXGsWR9nXCqa2YloJQcSnkzsFKldK8OEAPHnoBafdYkBK77A+G
	Rnj1hI8U5rGZIihjy19IKiNNOh9ZxclnZa/rhRhByFUkKAtGJ524wa6J
X-Gm-Gg: AR+sD12kp49qF6gBcM7F6AebOaqogF6q9cIu25oIENh+LK/BExveGkMIWD7+VoQiSzp
	r9DD39tUJ4ZHl3aOo/vD4xTkTo6rMqaxC3zlo5lzip5roy26PfUUqSxBy795mRZCk1/siFTTItg
	xAfnMF9wJd1X51OWUlQdUyycyLxaTFwhUAn0nWTVJ372xaZBn/afajCq1HezjOaZ7Z0fUoYg4+H
	WbzJVG//H+k5eEUn0wFVD+IgqfvMdHeN/rT9OS+6IZZnvrsRAWrct2TQ4BMlxWPxw8qZ9/jD1CX
	o9mUX+TFN1As3e0w7ALURnOYQWqk+te3IaaTAw5Q+8jo27W/Y1ktmD8YiZFHvf29x1oxVWVoe9K
	g4OBgInQ1UfA4oXt1r+i5szzX2GcCJcBZjzDF0b/Wh3xkIy/3id0nVlet9aqhFy+fKNlnwx/Wbp
	K3hGSVwSNWbtvS9ZLVWAtJ9VflWHXPNxZ0eNu0VfHeXu05/zxlYFe9Pp34mEQl7mEH9rmlJmERa
	34u0RNzIE0ncSSB/0z1RVeIcSYsbpw+rhiyt5PUY+64NbI0qnomF4IvVIehC9P6+Nc4FemGhDbM
	rcyQxxg9waCFYAlgnQEPG1bLiyVYMs4iKNl52w==
X-Received: by 2002:a05:600c:620e:b0:495:6274:56c2 with SMTP id 5b1f17b1804b1-4994e70a6f5mr283992355e9.2.1786051220247;
        Thu, 06 Aug 2026 14:20:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954206d72sm132720975e9.1.2026.08.06.14.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 23:20:19 +0200
Message-Id: <DKI6BEY44SYI.1SASQ9TSOCCG9@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix sleepable context checks and
 remove in_sleepable helper
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260806164049.3158887-1-memxor@gmail.com>
 <20260806164049.3158887-2-memxor@gmail.com>
 <8818323417f335355e02d7e10d220ef2ff370c0e.camel@gmail.com>
In-Reply-To: <8818323417f335355e02d7e10d220ef2ff370c0e.camel@gmail.com>

On Thu Aug 6, 2026 at 11:10 PM CEST, Eduard Zingerman wrote:
> On Thu, 2026-08-06 at 18:40 +0200, Kumar Kartikeya Dwivedi wrote:
>
> ...
>
>> Several call sites incorrectly used in_sleepable() where
>> in_sleepable_context() is required. This allowed sleepable programs
>> in non-sleepable contexts (e.g., inside bpf_rcu_read_lock()) to
>> incorrectly use sleepable iterators and kfuncs:
>>
>> =C2=A0 - check_css_task_iter_allowlist() returned in_sleepable() and
>> =C2=A0=C2=A0=C2=A0 therefore allowed css_task iterator in any sleepable =
program,
>> =C2=A0=C2=A0=C2=A0 even inside RCU/preempt/lock/IRQ-disabled regions. Fi=
x it to
>> =C2=A0=C2=A0=C2=A0 use in_sleepable_context().
>
> ...
>
>> @@ -12083,7 +12078,7 @@ static bool check_css_task_iter_allowlist(struct=
 bpf_verifier_env *env)
>> =C2=A0			return true;
>> =C2=A0		fallthrough;
>> =C2=A0	default:
>> -		return in_sleepable(env);
>> +		return in_sleepable_context(env);
>> =C2=A0	}
>> =C2=A0}
>
> I don't understand this change. The comment on top of the
> check_css_task_iter_allowlist() says that it is about
> cgroup.c:css_set_lock, not the current context per se.

I haven't looked deeply into this on whether this should change, that said =
the
usage of in_sleepable() is obviously wrong here, in that it is not enough.

>
> The flags on bpf_iter_css_task_new() and bpf_iter_css_task_next()
> is what should govern the decision regarding whether the function is
> allowed within some kind of a critical section.
>
>   BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
>   BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>
> Should these wield a KF_SLEEPABLE?
>
> Looking at the bpf_iter_css_task_new() body, it uses bpf_mem_alloc()
> which does not sleep and css_task_iter_start() which takes and
> releases a spin lock.
>
> Please elaborate.
>

Going back to
https://lore.kernel.org/all/272de0e9-539c-4d89-9b9c-0652b0826cdd@bytedance.=
com,
the reasoning certainly seems a bit dubious, esp. with changes since.  In a=
ny
case I will take a look at it tomorrow, but I think the conversion is ok. W=
e
might also want to use a filter instead of hardcoding this into the verifie=
r.

> ...

