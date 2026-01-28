Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA26322C73
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769627543; cv=pass; b=bwkYq8KBBkPjkrhcZOOX4yuSl1s8SbHgvv/VWe8OH6LmAZoQmXqLPWvPv7mg45VCfNxM8QlN9hcSdDTzRkPjP6yH1FWJQ6e1lhCGsfdggN2tzvfrZOzh9St1hia4yeUE57Lxj1YW1Ew8l54N2XJVI6cdqolQVG++QvbIdBvUZjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769627543; c=relaxed/simple;
	bh=VpoPbBGbz6mfdfJMvoYEQgQYYWq4Fn6yHjM4jwRMYpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kzx1D7/WR/FEn7NED/fQCbFX0IDQOX4t0a1ntcYqoJiUwXCVSVktktAYWMJypfdKBW6vFnu1eWE8hAqLZwNwZ95TIydkC/FXScGESnZuT4CPnL7YDAWl1Go0czuPYJCqWZA7oSqZNCrsc8UDcfNOItys3pDfZ+6B7TYvgaozUFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJW7z+Q+; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJW7z+Q+"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34abc7da414so90774a91.0
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 11:12:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769627542; cv=none;
        d=google.com; s=arc-20240605;
        b=BciIsYVeeCQLgwVTlGyGisZWmLbJ3Z/aGRN90RYwgeXU0E3x/luF6ub+KZyS1eL3FH
         qOgEQ6gBFve73P2N83JWBb4zqDLCayvh4dRl0aJr7EgTI5LLYw9gtXNsd0fR89xwc7gy
         EbfemS/FWuQ0xR+WpDUsWLyzvlTJBFfi7F8y/dD7J7WlrENutTWB/dn0kqHznNGIqSMx
         pEW36OcFxXXCGmEw8sxP4lDYWUUaN1doiaxgymCUXxp7J2Afsrc0lmvQko9BVlsPphAZ
         +shwcPLDFuSiYL5ruQVuS0B4W6c6W+yOGf0N2OCGf0Z7ktFJCad5t7FbpWTdoghVZVAx
         3bIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VpoPbBGbz6mfdfJMvoYEQgQYYWq4Fn6yHjM4jwRMYpI=;
        fh=4aRjsl6dtqiUvdCY+4J4Irod5YIy2SjPZQYkIPpf3ZQ=;
        b=PwNH22cbgOkLlKSiaCownHDyC385/cFEvidQJ64f9wZRX160NbJu6r4wSpJSy331oS
         t/vgdqZ7Rw7uguQIY6J/b4/200FcaSn2vaqgDtQG6HV/FC0gR4tmA2RziG+CpjfvCZzy
         9g5PWCuOazONaQZUBI2bypQHT9y63tZTMS2WjhQdBTVH3n1WIh0Eni24QElBFKbxOdiH
         83ac43r8qpV5nIB3vseQw+tvoHDWjvnu8nn6tgpakT59gxz8BznxLf6uFNLvoi93CBwV
         ZyRCuvsn6eFNDulwwMTvBDFxkD+dvejCQZi6/thauzDRVh/HjGRQOuV6CktVmIxo94IP
         ekbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769627542; x=1770232342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpoPbBGbz6mfdfJMvoYEQgQYYWq4Fn6yHjM4jwRMYpI=;
        b=bJW7z+Q+/KfY1gY+VvHGlcR2AIo/wIOoBp3VKb7rHUb6r5Y/fKbq8KPJbPl9KGtiUo
         MCJmIGlcjzX8h2q8kiEOgqs/Da/dBkZ7b3IFWIwzTGYO8IMMCnh4F6OWtYEiy+WWM3E7
         pPn4s2EaBeLPUZkrJnJct7ZvpYMeemTw2xIaVdaZiUA4NK7LA7qhItu8Sy/CaH8w56GL
         lG/JEac6wzUPkcjURiQept3cOVgNHQEOb77PaK6Yf0Py7Grv85vm8s78izgvL6RTbbCu
         5xhKa+dtO8O0CW68tsjmIRjIe4FmIr0CCigETI8ONihkMr18m8L0WzL0rBZfm5w6/tkM
         herg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769627542; x=1770232342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VpoPbBGbz6mfdfJMvoYEQgQYYWq4Fn6yHjM4jwRMYpI=;
        b=mr5F/XWO7QSJ5KEKuYw4lCJXVHoAUVwc00PAnhq8ApsWUMSTjE0iNujs3Zo5PdWjkA
         NUFNbrNpJHRUAn/aWYZE3IStOWNOCxvShYQbmOmctdRzPSpC4TrKUJixLcrJxk83hjLB
         BEzTta0w+puZHYzZWEEMdxYCA+ocRbCzY48Dk7TgIqU4VFu9dNi8DGTIp9bazps7v5qi
         uIWPqN67ELIo/sIBwWeXDUrMzhyDzeDGlPTLB+i0gqGKfqwPWKAjwzzxzBjEwqV+Pm0+
         cnHkjsMcttm6mbMFO3uuw39QoUk1dEBPquCuZ8T+jvwBOQB3HgljORN9Sin4qYr7O6pf
         EDyw==
X-Forwarded-Encrypted: i=1; AJvYcCXHSUbywDm8xgtY+7/49tT5vXE5Ocj48IqMwWHhT1L33dZNDvZQ0dWVu8UJzURS+9uvgU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSnutS9m0+GkGoyoWw9alxYZ0zC7WwAX+BgZq1EXZWRjyYwpzq
	hwlRWRkpf2nz4gevi1sw5pdo3CjJtOulK1CtWXW+xDogUEA5j0O4/+682fd/1AT5SxWIA6JqFLK
	gAlvuox3aGP4WyKmcAjuUzfddpZuDtac=
X-Gm-Gg: AZuq6aIKFiNru8qYMALh5efDhP8rd8WdbIEwCMlnat2xgsSIV6KDdYVo71KBXRBXLWw
	JnCqheBWMNRkK3EAN/bo0rjQ0gIuPndBajNyDXh/TTEM1pPZKf7P9RiWHE/nLwMX6WPjPt3gkqg
	1bQ97raOByt802GCNO04RY42bfwMH4nWEk9Ufjbhh62dWxJ60QBpKxjHUCTG7W1uuSsYMiK6xIY
	istSP+bVQMMZtFTtazALams4hAiSsDDratTmlPUWZHyI5icChEqmiNkiWiMDVgHaW4/Qvuh/ytn
	qdmdJZszBZA=
X-Received: by 2002:a17:90a:c2cb:b0:34c:3cbc:db8e with SMTP id
 98e67ed59e1d1-353feda7219mr5415955a91.25.1769627541653; Wed, 28 Jan 2026
 11:12:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-3-chen.dylane@linux.dev> <20260128091033.GG3372621@noisy.programming.kicks-ass.net>
In-Reply-To: <20260128091033.GG3372621@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Jan 2026 11:12:09 -0800
X-Gm-Features: AZwV_QgQnbf0pZwpt-k9lWK7o7z11VRyXzgeBmNVjegplmNSLZ0igAY-ZPB3AHM
Message-ID: <CAEf4BzYpcgC0Pi0f_ScUavJ_Tw74PKULsbPdexKsWmb8RmxLKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tao Chen <chen.dylane@linux.dev>, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 1:10=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jan 26, 2026 at 03:43:30PM +0800, Tao Chen wrote:
> > From BPF stack map, we want to ensure that the callchain buffer
> > will not be overwritten by other preemptive tasks and we also aim
> > to reduce the preempt disable interval, Based on the suggestions from P=
eter
> > and Andrrii, export new API __get_perf_callchain and the usage scenario=
s
> > are as follows from BPF side:
> >
> > preempt_disable()
> > entry =3D get_callchain_entry()
> > preempt_enable()
> > __get_perf_callchain(entry)
> > put_callchain_entry(entry)
>
> That makes no sense, this means any other task on that CPU is getting
> screwed over.

Yes, unfortunately, but unless we dynamically allocate new entry each
time and/or keep per-current entry cached there isn't much choice we
have here, no?

Maybe that's what we have to do, honestly, because
get_perf_callchain() usage we have right now from sleepable BPF isn't
great no matter with or without changes in this patch set.

>
> Why are you worried about the preempt_disable() here? If this were an
> interrupt context we'd still do that unwind -- but then with IRQs
> disabled.

Because __bpf_get_stack() from kernel/bpf/stackmap.c can be called
from sleepable/faultable context and also we can do a rather expensive
build ID resolution (either in sleepable or not, which only changes if
build ID parsing logic waits for file backed pages to be paged in or
not).
