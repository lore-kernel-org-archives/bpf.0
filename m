Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795560437;
	b=gdpT0to2yTvwQPmZM5blbWS1x+VV3/1Q4En+0I9+/tcChT5+wvIR0yQCCEr3TlWacohq
	 MwpI54MMt6aXuMTfIsX3VMEiE+Imf1rBHLRE60s+tc5WZ0Ge0QQAobcNuUygz6AR4CfIv
	 NDON+fozVhF6gNNmOftBCQK45+diHfIugJcdSDRNSn4+hN8+e/30jGL0CVNdQIyEtQujr
	 OuYWjzd7dO1iE9wCcO4bIOEAt63PDDL/Fd331iMbaYDnX+jzy6bCnN3KxG/lE3OoOk8HV
	 uQDRmCX240OJd/q6HHjrVBpbdwcAPhGuC5qBaZYLnNUQ6TCOd4WvfOx9E4cw71R7xFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GF9UzmSOZxINPRRDMCQdqLyqXkvSltKB8TQCTr+wUgg=;
	b=ofpbi6XEehRLk5SopLxcRVUcGjLIV/0aF4nJdl4bWx8VPuEPqNBJ6qrYLv1evmPgd+mF
	 TkZsHMLGIs42rv+UvO4b2Xz/w8PLrNBC9hvH8I4attW+fEIS/G12Ufc+7LlzswCb/U/uM
	 8j8wMD2JaV4vhpW5IFspZ8pZtbDzzyxw4ejm+6Z7FvAr4jf6skaqHjhBaSfUD+gpx3J5i
	 n/qrL0OS0bfLLXUUGQ8hNdHD+mjRYSQo6pBzQpTscvUczl2lfWEJz/4GAahxVU5O3lKmc
	 ohgZG7GFLDlQ3zdNuhQBswdpi94JmzMNXHveyFtQJd6aEKiF1gb2KLdtS0M7eAGUcZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDVYfjGl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB8606A329
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93FB8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDVYfjGl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso40715385e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:47:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795560436; cv=none;
        d=google.com; s=arc-20260327;
        b=bphNLxFaZyI0Uh4u1d04j6t6xoEgWglhBKEohzLo0eEjjBvMRqO1pwcwkf4aQLOFc3
         hIY6Mge5HKu0Ay8ExUyOuDVvgRR9mCGezgxYe9TISspIcP7AT9w0cEiZdpNgedMabyib
         v7nYT6XbYzNVwE675uTwoswd8LlIsHMiRLfaR81kbynGtCG3e5NMeaN+3hxL0TnzR3rG
         igDyZfTOeluMJnEdKVOuwI78EG8Y6WxlbH7Zt40XROVy7vDiPp+fjEro3Af2ODLvj4Q6
         nHc3BRoljZPyqORl1FKGz/yaQKcuba+LB3n5VKmFoEJNAG95rmhB/tt1fTM3lQ8/cpN6
         tquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GF9UzmSOZxINPRRDMCQdqLyqXkvSltKB8TQCTr+wUgg=;
        fh=xdfhsr0LeeHq6pzwoMEu9eXhVTEt7J+iMBC1Rl/E72I=;
        b=Pbal5GM2IN5sIURL0irwh7D0mCzsMe8N+zopw/AHuGondsXCHfbKSLVLUJhajimOsM
         hu/vcrm3na+TTjWmZiHeToDxkLRoAJFvIxW9klgwX5f24TfH7zFDVUAgDXDj1KwoKAHP
         IGCtZR7r46YQA1jzvEwlSzuNodc+S+3m+Rzcbwn6dPE1mkJ4Pik6P9a/vPkQLEh2U+XD
         za1tBc0y1wc4W5WbWm2szEQCKQYP6D3+5h8NzNwXw7XHPAfm1Jn+RzkEzpE8PuZEN607
         JsE6yPVqg+2zua9udX4veENkWeS5WRZ6Q4N0wOyDGoz/+tymlobD/O8rup2lCsKvrLvb
         If1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795560436; x=1796165236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GF9UzmSOZxINPRRDMCQdqLyqXkvSltKB8TQCTr+wUgg=;
        b=IDVYfjGlC847MomvevIBogV0vwwH2yd2UbYY5Cdba1WMU1IFjTL1zOVYezv7JfLPaL
         PEoqyv72xKtn6m6/PpgG3HD+F597WR+Lk4Kw6Ao5dbhfcgN/qOa0pF3ohOj+ju6tcKWv
         xmHbpuErkFM1Td9TuAkjzXq7scwkjlT3tecreogkpIBZirKgRy0UaJ5J+6ZZ0xG/H6tb
         h69dlYSWiOgugkyOJj7SlhGoDA6PBXqhF8NFuL4NgSD4uID64PVSpoTq8Z57tph/rQP6
         /YsFIn26b+AhrcnUJdzvD5gRy3rhZvce1QEXJTon3HeB81IlADuKdmg3HsiYIai6Y9Fu
         A9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560436; x=1796165236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GF9UzmSOZxINPRRDMCQdqLyqXkvSltKB8TQCTr+wUgg=;
        b=QdAEImWtCVE5N9n/C20q7tfK9h62mQu/yJ9dV4qWIGkUqqIV8FzSVfCZBBnN3AqQDE
         Ai4P1T5YlEcgForkzrjVVNPAWlRfQ7qao62JqScl6sjlOq4edKHejZev9LkEiQ+R2c7v
         wJDjDc2sABPw/r8qUk4BKpjWxw3GGNBRJf9TAgmA2ToYL5j+qFxbaNs+nKwY0xF8pn+3
         nqT6wJYW4/WBbQqAykx7VP62woqNdVN8zFjTq7HS2UXQDGSmgtAFZRBNWdmYuKlGwRVS
         YISDd5mbrq4yShUSK7rQECtBc6lrbc43O7zIivXzlhm0RpadYiHZUexNVHHoHhFq+lWn
         kIGQ==
X-Forwarded-Encrypted: i=1; AL+hErG6LIiyygJYStga8S8EuhFG6quv7CQ89aqm1Cbz5m2M9IDzSETIFYXgwtk1pQsChAphyVM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PLuwzFi1IKJonBpwL3Nmg5dOOA2rPvKxDr59feSIROp+WjkYB
	uh65juJSAn/x2wRAxOdqbYlQZZfqeWK0C1eP8YNk4Pj0KygeAJoevSYkn/3LEI/6ZDPQofiZJ0b
	JawjMLDOS66N428Tat0jTbaXIPU8XSOs=
X-Gm-Gg: AZFdTZfNiVai/r5YRW+YXUizX6cPD5alqfXcOqElDpKcg1th+KRvEh8SIuQryBJ5owp
	B9UBJnOcyPkZaByEYkSmkYWtnIhypCcEFGil4ujFlCr9+yz//YEmcUOXXyccNwwLIUt72IqyEmm
	O6Q34UqUvz87fQzfRDCN8Zoe+BflRGPyLl5fC+IubHNCvVtHyudUVhl7DYbucw7C06muhiynvid
	UiVC7aon9pw8d9dC3A6m1W8ZCi3N+axAgIhIN8Ydmtg2qzDoxC8alE/lWAxKCAIlIWy+o2wE9qP
	W9YdY3e39ISCmgdLAwncb+P/4zpVRFQ+ozoWyBRBs4GoapXJbp1P1t3KerldThWV0FCb3DChNEV
	N3OTgJQ+pC52tszZMtkwnvaDGioIlvy102QGzAEiPuOM3fG6jmYuYgmsyRVN3YRwy8mEhNUX6aR
	s3vzQiKMBNKzu9FIr1fHA=
X-Received: by 2002:a05:600c:6748:b0:4bb:6a2d:b42d with SMTP id
 5b1f17b1804b1-4bb88824e64mr318116355e9.31.1795560435685; Tue, 24 Nov 2026
 14:47:15 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121003403.2928928-1-ihor.solodrai@linux.dev>
 <20261121003403.2928928-2-ihor.solodrai@linux.dev> <adf5a84b-5d80-4c02-91f5-12def2c37304@kernel.org>
 <faecfef3-ac9f-41be-8bc3-83a66572066a@linux.dev>
In-Reply-To: <faecfef3-ac9f-41be-8bc3-83a66572066a@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 14:47:04 -0800
X-Gm-Features: Aa3M54oiG4dsSQL3PSHqOX4KocU7vtpa91-MEZLJQ-xarDHbD7m4NESmq_n90Qo
Message-ID: <CAEf4Bza6oDkY=mfa4PedrQYtjYnkefTs2m-wVatK9BGoNLd-wA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] libbpf: Separate interfaces shared with
 in-tree tools
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:44=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 2026-11-23 7:55 a.m., Quentin Monnet wrote:
> > 2026-11-20 17:33 UTC-0700 ~ Ihor Solodrai <ihor.solodrai@linux.dev>
> >> resolve_btfids links libbpf statically and uses its BTF header
> >> accessor, field iterator and SHA-256 helper. libbpf_internal.h
> >> also defines logging macros and poisons kernel integer typedefs,
> >> so resolve_btfids wraps the hash helper in a separate source file.
> >>
> >> Move the shared declarations to libbpf_tools.h and use them
> >> directly in resolve_btfids. The header is for in-tree tools and
> >> stays uninstalled. No shared-library symbols change.
> >
> >
> > Hi Ihor, the change in bpftool's Makefile looks OK and I understand the
> > motivation for libbpf_tools.h for resolve_btfids. But I find it a bit
> > confusing to move away from libbpf_internal.h only partially for
> > bpftool, and to have a split dependency on both libbpf_internal.h and
> > libbpf_tools.h. Have you considered moving the other objects that
> > bpftool requires from libbpf_internal.h to libbpf_tools.h as well?
>
> Hi Quentin, thank you for taking a look.
>
> I haven't considered that, and it seems like a good idea to me.
>
> The way I thought about this is that in practice libbpf has at least
> three levels of (userspace, non-BPF) API:
>    - public API defined in the symbols map
>    - internal API, shared helpers and such
>    - API for the in-tree users, that doesn't make sense to make
>      public

well, I don't think encouraging this with extra "libbpf_tools.h" is a
good thing. I'd prefer to keep stuff like that in libbpf_internal.h
(because it is meant to be internal to libbpf, with bpftool and
resolve_btfids being a special case)

Do I understand correctly that the problem is mostly in poisoning?
should we just guard those pragmas with #ifdef check and let
resolve_btfids disable that, if desired?

>
> I felt like the last one needs a header to reduce the amount of
> copy-paste. I don't like "libbpf_tools.h", it gives me "10k loc
> utils file" vibes, but I couldn't come up with a better name. Open
> to suggestions.
>
> I need to look into bots' feedback, and I expect there will be a v3,
> so I'll see what bpftool parts can be moved to the new header as well.
>
> Thanks!
>
> >
> > Thanks,
> > Quentin
>
>
