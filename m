Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454702D6E75
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635283; cv=pass; b=ujusfUHTj1D8SPFybcRglRcPo/rK0XSndARyab+8zpe2DPsJZyvKDOBaMFVvq2GAexdJrQwFtp31Zsx45lyEsaVvWDGYySIPE4Qzw9+XNidzFx/DNhjNQN3dMZNfoTog7s61iyMKS76s5Q2InCEGoGqd01QlEQWBieJ4BETzeiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635283; c=relaxed/simple;
	bh=RiEUyryCNCgmcAfjLaHtNU6XwkHNt9BsmDMYA3iglvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4r+2kQGNZ6egjgntq8e01DWVsvtH/fmfVgfKAwfgS1ASevbMleBc+6S/5BVKC9qCMo2kyJnz9FACNKqMawPjWoRNhxOxss87apAHEy441pwm4lm8uIfChvpf34qpe8TatwaGWi/fFV2HP3u/O/66r/sSSkFWQ2utgPVDqnmUks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ1injQj; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ1injQj"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a78e381fc1so995905ad.3
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 13:21:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769635282; cv=none;
        d=google.com; s=arc-20240605;
        b=TwMp5qPl7xht7TgRkg3L9LhWWWsiKT2DvM0uP83pubeArtyCFX83mAeX8SfXBiVQ1e
         xkclv1jHOCwTdbt4FXHlFA0rJ58U7t78JJxrtlRjP44lb/O2SqWeWUJLlD8yKQvSa/iU
         9UEET516v3NYkkjqCkvQBLJ6manJ7JPgPvzWxywE26M3ZrGCtAJfjfEG22u5ztLUQaa1
         RR9EfiDvWnkopYRYx+Kmhq+HOnTCJV0Vfdp3VvNENqKlUOSoNIzeY5Dxhp3TdSQjB2cb
         bsF13nfH+DKpZPN9ePlHiBZNvjkZPnD0kbrdPbZuseNBG/UpHc4poT53AtWyATCNafiV
         rK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YUxsUwiwHLJ7h2PHZIHXYH7O5sVwAXQBXu2QSLj8pl8=;
        fh=1xaDYgGC0KEgllRTntMgSWyxXdaUUtFGDr42lqbwEGI=;
        b=SREc1/aJujcCYqOa43YFyeuVwvNtgeMTJqIROcsrUM64thDmJsZ5MrBdKgpfq15MPe
         mcY1auCVxR5wRbCeM16iBDJXP/P9XcF9YVUWjfJgAs8H1f/6bawqQD/UQRumiHZZicg9
         jspWnFOKNIJiVWJrA79QTmMZdAe+6AxuclMdi9yijzpa2TOgtT5ZJr5BuKsA6rDTJzgX
         hno0wnIcu+tN10h/b4jFj+pjQQjaiK/7wvCTFc0pPjLWmUhuSHppoe3et1QXIvMSaNvN
         nKLvK/yQ0NmZLd+xXLT9xLRVZ7su0eQ04AozoFO4KdRgh/Jo3OuqWILJbwecxGLIHQ3K
         GyiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769635282; x=1770240082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUxsUwiwHLJ7h2PHZIHXYH7O5sVwAXQBXu2QSLj8pl8=;
        b=TZ1injQjsprw+FsFSvd07YU5fvt/ZeNnDGf/1BZCPdM64LL8FeOz2atWpFQXaS8GlH
         37/IEigeXsbW+pusDPPrsQi57SQkB12StymEqEgnYPLSZZqP1Lq21GnIJPVhTol9ygmc
         zfLyX9HuCscfjgpXJuUPpydyeCZgJpXr7l5NuwM04HXCcmOFPYF5TQlqCmmcd9Cz3CFa
         INv4Tj9Ya5xvbxNdVPuoefYN8qJmun3Q4Mjp7K9SP06tX8DbgtDlxl5ZgClXVewy+Zmw
         Pr6+peA9WHSvt3JmBAkt3ybqcOjir5U/jQ6S5iwmqGJJa7QVy82r8vfHdfX0ia3mFsrT
         QdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769635282; x=1770240082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YUxsUwiwHLJ7h2PHZIHXYH7O5sVwAXQBXu2QSLj8pl8=;
        b=o26iOm4ye/lwQVNknXAlo79MtbjtGEKmBLjqF2pOegy18IFAmiEZOfHWK3/8RM5jRl
         UvKvYV2MGaUDrc+volnk5i8gakXX+PXunX1sdIXRlk/etazFFiKN/tpxNG795cSzY4pL
         uKkRFL+16pbXr5xN0APUOqgzsEuklrmg1ka1XH6A7eHkurV6FpNNf2cMK6jMDDD/CHQN
         58Iz4ZUuHd75BAP4OD55kYMPja0uQi84GzQHphmm1GgFIW3nv7RPSqtz2jt7l1S70Ci0
         S+/5bSbk8BRlkVuChHAMtgE4rrN5x5tHnSM/k3c4BbsquhybPg0VDXpXlxM52hFEH0vZ
         1gMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHeJQGqgkeFLqn7S056N4zFSC/wdx7NMO+Mko4KgAm+/z14gnEQveI+pJdCBcA7s+eHa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9t3sFPFhBTQjHnthXGreZzIsOBoivIqywwb07waCzHJZH6hSR
	H9m0glkXF3vHNmWBvsKYO+zHqr1dWODkoQtcUTuNw3NFs9CrImUS8tBmbzD07flujnL+33HYjgl
	kwRkKerHYKvj3idY55f5/6xdr2BZxF5I=
X-Gm-Gg: AZuq6aIjVR4Wzo51GQZCTyo2rprBtyTaskEx60qp1mUYDf+9cliLIUWEJ61H/sxFytc
	SAf/U3XxEqD5ZyjiOTZ7Wrc2Nih3zMSg8rz8dnpOOd06UGHYWqejfRoqwd/eQJ7cQk5Wdd3MU4g
	lD1XY5oXBmu+kYB4P/radUZLdESkLOV9q/B/EU2MZaWtRJPMde9mgNnJUm/bS+8vt/PfTr6Q6GH
	AAAi6aMdPUUoDla5CCueNkTPP/0giG4AHTpKXP8U6F+7bzQIpUba2rxkgpHof3t1iFlPZpkTM26
	2dCPcg6agCzrKizXpnEPHg==
X-Received: by 2002:a17:902:f785:b0:2a8:7814:47c9 with SMTP id
 d9443c01a7336-2a8781448d0mr62824625ad.36.1769635281550; Wed, 28 Jan 2026
 13:21:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126142118.2ea3cf13@gandalf.local.home> <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
 <20260126192010.4f14bcb9@gandalf.local.home> <CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
 <CAP_z_CgozbHejsuKeLRQHN-bz5jPA+C+c0GBNitgEvwOucm8TQ@mail.gmail.com>
 <CAEf4Bza91wTWzESxAyz5qP4e8siwGn=rvm-Few6xT_VpW9oJzw@mail.gmail.com> <CAP_z_ChhkA1W_5Bd0GQYpo2Vb-p-zP+Lbdp1cZw8Fr_WHQ=TcQ@mail.gmail.com>
In-Reply-To: <CAP_z_ChhkA1W_5Bd0GQYpo2Vb-p-zP+Lbdp1cZw8Fr_WHQ=TcQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Jan 2026 13:21:08 -0800
X-Gm-Features: AZwV_QjzhDklQbvJbIr9RodXz80hyqrlOAeOn6p0mFntta5pbcLIXH0IXKWKCxs
Message-ID: <CAEf4BzaSgmgzqfjToDx-O3BRKNZECJeeLpN81yNNWGF+N_uMNQ@mail.gmail.com>
Subject: Re: BPF with deferred stacktrace and sframes?
To: Blake Jones <blakejones@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 12:36=E2=80=AFPM Blake Jones <blakejones@google.com=
> wrote:
>
> On Wed, Jan 28, 2026 at 10:56=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > I'm not quite clear on why blocking 53 times in the kernel before
> > returning to user space matters for capturing user space stack trace?
> > Given we haven't returned to user space, its stack trace will remain
> > the same. You'll need to schedule task_work (see
> > bpf_task_work_schedule_resume()) just once and capture stack trace
> > just once. How you join that asynchronously (from the perspective of
> > the point where you called bpf_task_work_schedule_resume()) captured
> > stack traces will be up to you. You can send it through ringbuf, or
> > store in some map, or whatever makes most sense for how exactly you
> > structured your BPF logic.
>
> Yeah, it's exactly this async joining that I'm referring to.
>
> If the thread blocked just once before returning to userland, I could
> capture a synchronous kernel stack trace and store its ID (along with
> the amount of time blocked there and the number of times it blocked
> there) in a simple structure in task-local storage, e.g.:
>
> struct block_info {
>     __u32 kstackid;
>     __u64 sleep_nsec;
>     __u64 sleep_count;
> };
>
> and then once the user stack trace ID had been captured via task_work,
> I could merge it along with the data from "block_info" into the final
> BPF map. The final BPF map's key is { kstackid, ustackid }, and its
> value is { sleep_nsec, sleep_count }.

I'd probably pre-generate some unique ID (using atomic counters from
the BPF side) that will be sent along with the async user stack trace
eventually. And then join everything after the fact in user space.

>
> But a thread that blocks multiple times before returning to userland
> would have to track multiple distinct kernel stack trace IDs and
> multiple distinct blocking durations before it can join them with the
> user stack trace ID. And the fixed-size structure used with task-local
> storage wouldn't be ... up to the task, as it were.
>
> Blake
