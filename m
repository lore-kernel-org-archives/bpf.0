Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998E9475
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770256265; cv=pass; b=lsb0Tbq0MbiBJ0WTt6W6sBdrRJNqlo8ND9G/Fr+o7X51wkr9pamroVVM1NXEm+IflaLdtbo/oy2Enohk3NIkRrFtDhg8je3J2ejz1xBnsxgc/rJqeO7kPOLEiOqSDFGQs4ZZi0ExmGuaYjhlDexyrWP0fkjof5TGOKn1TdufrrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770256265; c=relaxed/simple;
	bh=YU7m/Q2nu0/g8LLNDROsn5pc6xeT/l4hEMs3m/tuTgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhsGc3qvNRA06KzBdBDdD6/Oq2z4pfZXCQ22iGp3BVftb08udtv0Spq2ofOvV9ubKRXUF/pnOvIHCsZL5wK3xhtwkWs0W43vFekE8ACy+gCl1ZyOPUbyzy/op+JEmlnPAIY3phMvdFBrEqEPAInDYAFZUA+rfYq7sAxhpuSx3tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+8JZ1J3; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+8JZ1J3"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5663724e4daso293878e0c.3
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 17:51:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770256264; cv=none;
        d=google.com; s=arc-20240605;
        b=HPBcJVDosBYRgb4Au/6QB+kCcAEr8r4ukRW1wFz1I6Tx7my438x4D2eRPUuekJ7bMe
         rgu5nO+lG4LCKEuXw3DWTcx3c0eS97jAoIKtnkz/hWrg8QvoMwtoybgSCYAr/Lla7mWA
         lzSofCII/Lec4oQlnq5JyoHE+wNPSkPgpr9uMfQo7lq5v9ixgR72tpzYReibINoFlxH0
         75OQidfEKMZ/JhqliB3le3Enu4PcK+D3+J/Ls0U0TlERlMisQovc86vYAV+098XLBMWV
         34cfVcK+cw1qP3XIH8qBKF+VUAC+QUvJYrFkdEG7HsQ4TkXyLo6mLEduK7NlXNkqrSkV
         ihvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YU7m/Q2nu0/g8LLNDROsn5pc6xeT/l4hEMs3m/tuTgE=;
        fh=8fHpFRLXM8m3kXq20pU54xJn6We8gREve2VdUh0pAbw=;
        b=bu8NsM4c2G1B6CAOWzqt/RM0OomgyJTIVDgX++qlPJal2UJh4GdRs4tJ1NBbuRr9/h
         IK1FbKWv4t+b4hzumwxUhZwvQ21Ah9lfg8rir8vReJblWXCCwAAiYy/dsDQHIu3dKoRL
         L4B7O/XYaVvPdsjhEKNmJ58x0P/Cv4GVdIrElOQIXHuNNjdrhBoT2Ia5imP/mRHKqFcZ
         JbAL0dvwvLU/ktkTKMDSTiRPQ6+2aymRWeAD/UMa9A2jPy+52kKKXQwop1TGY6cMGqVg
         zpyjoMUy8LZvtHly4NoBZXayy0O0gKQXDuy0eqk++OwVbLvO1idiRbKeVc6KUafNR8R1
         ifmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770256264; x=1770861064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU7m/Q2nu0/g8LLNDROsn5pc6xeT/l4hEMs3m/tuTgE=;
        b=0+8JZ1J3VDvu3tTVcym37eXgWw9jx4ZcICDUt6GP/rxLUNDV7Idv9xSB2CHAGA9SUy
         Tmn5EbHtsMVyBret+kk7aT9jcquigIMe38ZC6ZV10FQiDGdWVp/9p4ehBlo7moZ9olac
         Hmxh+bvb84Q1Nyl/xzCyMBh0aoK4WOEdSqJS0+EWxeiwKslUEDqMGEa9JFX/jwcz6RQP
         DLs5udoF5Ze/dxgR9gp48np7YdSl/e2aV3U11Y9RquKJz15+G2Z0uHr34BVUpaouPWvD
         ueQCFyyJftHPV1xMxKkVBrBkVjSeK+IJllo/uWpHtdKIk9/V84YUoUL3HO6hzhYN8sZw
         EoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770256264; x=1770861064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YU7m/Q2nu0/g8LLNDROsn5pc6xeT/l4hEMs3m/tuTgE=;
        b=hZEK27ptaL5w3lC3+R3xysulwjMduqr+KtfWBPhIw12zf2Z2mq0vuJC9F2zaMLDSF4
         NTiVJAguy0WFZi+YJKQ1KOdYeZjtgzhv1hLW78lDrYc2wm++odNzyJM4lWXV/3gtvfrd
         qpXiKkhbUmQtG7J9+jgxl6Hrb9VcrRP5B6EXA3C19c89fqIwfDItfxySMPychBtEO0Yd
         rP9X9evreK8bHwc9+PghgfkipRWB7GY7YKLeV09T5RpBhAgLyS2LuzPl0JnQn/4sQZ7M
         XajKGpxx8RKF3bsniDOU8OGrU6e/N6MNa4n5BmQ4Aane0bgpPK/03yICGYD/r+9/IxUW
         x7iA==
X-Forwarded-Encrypted: i=1; AJvYcCU3PxTrAa3bvXx9xZzDjsxuLNnrcZcXlTh5ZhIz4vjvaHpJHBbPTrfsz0BCqlVcOgyVQa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuQCfadeG/mchN0egILJyN9ygyuLiDBL3VZQhnzOkX14ciEFNj
	l8bDH7Rn2p625v+AZPZjXPWZBIQRXbLs1i0iE9aGAOkVqWWU7tH97GDksI5aEIXwd3+ADF6Mb/O
	SQcqNYZQF8407P9w2MTleIZi3LGsDMNzc+odsniRp
X-Gm-Gg: AZuq6aJBk0DQJASDDlvGzcztAXcBEKpFqv6IQoRbJ1seizehzLaNlf0PRxeM4B/Gf9V
	Hcz8JO+DXtlGlktiLmaXe0VMaJ6iaIEuLdrgw3/xFe41c3i2aTncDRB1RGOcSk2ZRfmCf4TgaRI
	56qJSsdzBCFZtCHx5TZgqO/UIStDzJRyf1F7pWKnnWzFIompT/Zlz302CSKYKNObCdjDmGMs7NR
	UOHYgv1O5ZHSKl52BLGGg9RvTyIhTljMp+IezX504O82jlmhgVkGNH+YoOrmh6ciimcDESGBRad
	yCYIHg1/XcIlL9I+MUMDA0R+y6BeUrvzMT7icxk=
X-Received: by 2002:a05:6122:d13:b0:566:25a6:7979 with SMTP id
 71dfb90a1353d-566e816a997mr2005450e0c.19.1770256264093; Wed, 04 Feb 2026
 17:51:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126142118.2ea3cf13@gandalf.local.home> <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
 <20260126192010.4f14bcb9@gandalf.local.home> <CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
 <CAP_z_CgozbHejsuKeLRQHN-bz5jPA+C+c0GBNitgEvwOucm8TQ@mail.gmail.com>
 <CAEf4Bza91wTWzESxAyz5qP4e8siwGn=rvm-Few6xT_VpW9oJzw@mail.gmail.com>
 <CAP_z_ChhkA1W_5Bd0GQYpo2Vb-p-zP+Lbdp1cZw8Fr_WHQ=TcQ@mail.gmail.com>
 <CAEf4BzaSgmgzqfjToDx-O3BRKNZECJeeLpN81yNNWGF+N_uMNQ@mail.gmail.com>
 <CAP_z_Choy4Pe_VgdxwFzkUo4P71+TA=xAM8kov8QacGpRS5irg@mail.gmail.com>
 <CAEf4BzaEiQ8FApp1KMrCvsBVs+xLrk_mtQFUCfXZ3co2D6Oayg@mail.gmail.com>
 <20260130152400.6a71abb8@gandalf.local.home> <CAP_z_CjZWFqyKAti_NLtq7QhiJfwVXhohakQh2yEFS_vLsb4zw@mail.gmail.com>
 <CAEf4BzYq117=EbJ1ovpr0YBQr=myvxwF4uetO5umL4P27yAcDw@mail.gmail.com>
In-Reply-To: <CAEf4BzYq117=EbJ1ovpr0YBQr=myvxwF4uetO5umL4P27yAcDw@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 4 Feb 2026 17:50:53 -0800
X-Gm-Features: AZwV_Qi_gxPyuDeZsuqCI0qAuTRDaOMnQJittc1R3YrjK5E6ZVvxPhZHcBidQo4
Message-ID: <CAP_z_Cj9Z0q-UrJUKgrb4vQ_sTQbyN-aN2GM-ZvPLNsvcS9k-w@mail.gmail.com>
Subject: Re: BPF with deferred stacktrace and sframes?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrii,

On Fri, Jan 30, 2026 at 2:03=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > Yep Steve, your explanation sounds correct to me. If there was a way
> > of storing a non-constant amount of metadata in something like
> > task-local storage, I would have a solution.
>
> There isn't (AFAIA), but you can approximate that with a global
> hashmap keyed by task's pid + whatever the original per-task key you
> needed.

My original per-task key did include the kernel stack trace ID, as
stored in a global hash map by bpf_get_stackid(); if I understood you
right, that's what you suggested in your reply to Steve as well. But I
don't see how the task_work handler that gets the user stack trace
would be able to find any hash map entries stored under that key,
since it would be operating from a different location (and thus also
from different stack traces) than the profiler. Could you help me
understand this, please?

Regarding the rest of the discussion - what I'm hearing is that the
need to handle asynchronous user stack traces is just part and parcel
of any decision to switch to SFrames, and it's up to each user to
decide how that cost/benefit tradeoff works for them. That makes sense
to me.

Blake
