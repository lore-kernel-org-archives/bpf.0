Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A675330BF4F
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778556308; cv=none; b=kD9+q3uehXuTLqjky7q7l9wjErcbcbd8rXUmxDrfuKxyEk9UIPHNBp066ItOLQbf0/CCKBu06dZS4/05lBt5ln0515oj9h21FM2ks9zqnlAGeAXPK6yovtb5d2AAb+q3MO1DkVsOUdPGWjrVh72MtXQV7138gBvE5N45FbF0VU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778556308; c=relaxed/simple;
	bh=lUvCSX7+f/zvgszpi8kv9Vx76od+XjPpIa3nZHTbWlk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HKSRx+VdQlQ6e1UWwNOOTtFLnm1rFiUDJGD4/aMR7MRwjGBrqOzBdyGPfMato5KL36TggRVirxe2uSUxARGxXFz9cNDj+MhELzYw+haQn+mvdB9JAr7aqN3lQZ83CfuOsV8EVgNBhypORgmNivJ/+lchaSQ2Ukq5F8V5hWtS+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMe15h3K; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMe15h3K"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-439acb393f7so64428fac.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 20:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778556306; x=1779161106; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUvCSX7+f/zvgszpi8kv9Vx76od+XjPpIa3nZHTbWlk=;
        b=nMe15h3Kt/F1xKQNjMUk6LObJ5LuFYo5QiY/NkyxxEYuylqMPZx/SkvmaIJKbxPEmV
         gxr0XYumy5XuLF+ehZB9xiddLFaH2qhNa7U354IFnA117426oG8AwEzC2pMirc2Y7L2U
         P2Co3+7XzwLll1Hk0ebQ/OuJo1UYTtiL5RmumQTAGEeQ0d+ef0Rc+QRFI+XI+wQiNUKw
         M3dbFrplInf4HzFVPf3y6YGpGIHOOIBcZ6zlwSR5vfPjo1y+znvrchAJ6yj1b/CHzB2W
         +BgDDl1pmSvNW3kbqE6mfROqUbceJS1NeeahDOFNU+CWe5RHenud7XDUAHp0ejel65Bl
         mAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778556306; x=1779161106;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUvCSX7+f/zvgszpi8kv9Vx76od+XjPpIa3nZHTbWlk=;
        b=rJKRcQ7ayyXcupFlzSe45OJY58CLabH++W1ziuHk/RsFgpFbnInMvbT5fOLHYfTV5r
         EQwZldj0qhnI9z2oNZ6+Sl12qQOzAXYilCU/xUQlLx9NJAlXwX63mciqUbC3VuLhg7/H
         6PQ7k1L7TqMOTUwPjZgzqh9phIVGL1XJRwaILoUf7wgK9oz6GU5i8c+29S47Ifhoi6Be
         1mnH9N9c+o8i3NKnl99mhedR7Be1PrMgM7vInxD4oPViiQAOy4qFSkfVp7SFheJss8PS
         PZImbFUyxuDe9QWJQTrLtGd8U6Fn3oQXczhHW8duZVJazUtezSI38HYwBLjujV5686W6
         9+HA==
X-Forwarded-Encrypted: i=1; AFNElJ8HWlqwkPy37jVseZY3p0LdbAwjz4FhDOqkQkdkDLczGl+06KDVrxLaaFpaJFKhArLSuHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYSjkTnSYaNyPRiy+Yhf/lcI63+aTzQWwOOfeWDE9w7NTncjbV
	ARaylts2sUHrC0CXQRyTA4JPmmj/PF664FEhG1NuISlcabJnTmsrTcIF
X-Gm-Gg: Acq92OGKMh0a8LwPBLm/7mA9XNpo0VgFUU4aAl5kIH2s7xz7i8U1j06JY2HgM44W+mB
	6tl5f1cCtM1j0oahSthy3lhrRu3kyRuFxvrl1ZGvYcnLCo55/Mug7L7mn4AFLpbzxGiY2YkcyYt
	xfeeCQELDMqQpM4fVJXbCQTtZ4kQbWjFxFuOHrVwRytOXufgyM6RLCiaxhZEReSPIZRy16x3iJp
	gQVDdKVhbQ47DrV1QqZLoWCexaE4eBOXS2EvNeIVCWT3EW0VIMMsPQKtI4xfM4cHeXP875yCXAF
	HnuYNvGpbhOffHp21XiNT9bA07PsQyYNtWzsDZD2nYU/z9QF8Rlh6XudfW876w27Vz3lEvUG9rA
	QJVxJkIOiboNyhuPaoXMK0BNQQQaOdSEH3BjScL3Dv3659f1w22ph+BDMq1YbSYPbmKQ90nmxAL
	xcimYW1QwMLMM5+JQoSrTsNKcI0GMVzZOp2GV9CJRUlIeOZh9HmJMI3C/6DFvjxEeMsyQutns1o
	tFqESCG5+7xfaztqA==
X-Received: by 2002:a05:6820:2212:b0:694:8bfa:7819 with SMTP id 006d021491bc7-69998cafb9emr14905097eaf.13.1778556306125;
        Mon, 11 May 2026 20:25:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435570ad92dsm11696175fac.2.2026.05.11.20.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 20:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 20:25:03 -0700
Message-Id: <DIGDLA5275AR.128FTQMU7Z8S3@gmail.com>
Cc: "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "David Vernet" <void@manifault.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for
 direct kernel access
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc
References: <20260427105109.2554518-1-tj@kernel.org>
 <20260427105109.2554518-3-tj@kernel.org>
 <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
 <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com>
 <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>
In-Reply-To: <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>

On Mon May 11, 2026 at 7:43 PM PDT, Kumar Kartikeya Dwivedi wrote:
>
> If not, the best course to me seems to be to make the flag behavior
> default, and just rely on ASan (and Rust in the future) to prevent any
> memory safety issues, and drop the stream based feedback on fault,
> etc.

Agree that this needs to be new default without new uapi flags.
How about we tweak the idea further.
Let all arena pages be unmapped initially. bpf progs will fault
on them and will be reported via bpf_streams.
But we also prepare one "scratch page". Let's use this name,
since "garbage page" reads too dirty.
When kernel faults we populate pte with that scratch page
and let the kernel code retry.
To implement it the page_fault_oops() can have a callback
into bpf/arena helper similar to kfence_handle_page_fault.
If fault address is in arena, do kfence_unprotect()-like.
