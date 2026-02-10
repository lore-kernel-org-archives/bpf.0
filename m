Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C43358A3
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757254; cv=pass; b=SHWv3jmmmY8QAAzed2ScWYRWSpN9HoUEY0hTBurjyY/suYoM9Fm1Z5mFktR76mhiOLTsTHDdD//C6fh0vYGFXzEiN97Y4CD0zQNySg1lThXyO4emX8fGbnYWyGSZNlVQoFtozjxwnrJh0K3VHvxdaPi1x5I7BEAprMnmgpkf+u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757254; c=relaxed/simple;
	bh=grphoW444f7IPiw7D2CaOVQsjsq39gJqua7IdEO4/0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xbsc9/tOwXggChx9VGLUKZxP50Ye4X+7lY/m/wH0SLbuA0MUfOipJaKaxH0PDhSkM8dI7BRGdHuYA4DcjS+PRhNdyfdEMhjCALk6Y/hQjaCYnP9Ls1HHs4s8M5GM27WRmsPHgWdIYMMzoouaJGOLS6Tfsk7SNrcc4TYQxnNhI94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emwps/a4; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emwps/a4"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43622089851so1270717f8f.3
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 13:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770757252; cv=none;
        d=google.com; s=arc-20240605;
        b=FlSC3MJTcAuk5wOZ2Rza0/sDyrpG3qZB4PFZTBucbuMiTz1MVvcqCHnu2cAOqOzl9E
         FPBRbvAC9fYgEmzIM+zxSfNXDuNUJJ9x65xySRXOPyRtsU50amdWha4BZtSd2ZAiGjfL
         Qu6ehM9Dpptow+bhgPe5w7FTvqHm1XsgTWJ5iL5oezjwDF5fTGU4Gda7+y/EhJwvpXBU
         C9yQycfBA80Hx4Y04VMvCnGRxh7GvkQzUqGHvJ/JI7CMmDEeXxDWoEhGx+wNV7iBgILb
         09h3JkWlDRqMBIUvXADhym81zHm6R96ff6EgcgbioFeIOlECJtqU1XcITZFwr9kvWUYL
         sxxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3uD9XI3sB/bwSSzYSoZLmd7MtPXVWIjudtX8H7k4MPI=;
        fh=hDKplc219s3MK2SS2oFwldzQjaX48fuOLVfoTYPvFwg=;
        b=Cz8lgccMCcoJ5Liy4Pea3Vl6xR8ig5HrZAtvkOhK7wKLalrGl04Fy02xM+kA1ClVvu
         2ap0/TzNHyFndVMuiJxFGFK47hGt7aOq8XgQNz8p65TUvwyLp6m1OGlu0MUGro5uT+H4
         FbIC58SgpQtCxXm6SNInZeci5SYfp+34CqCK91Gpsj/Zs2qjSygX+D+3IUinr8D7YKzi
         DqewDgGfxxvti6z7/XH1ou3yX6vA/zDB450s42mLirZguttdCtlJsXAQy6jQwAyPCmSD
         nZgjyGJjYqreDpqSlwwtpGoPPbpqYSas4vYIH6OBuYIVhYq+PWGShxS9iQhm5xkZohGE
         r0cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770757252; x=1771362052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uD9XI3sB/bwSSzYSoZLmd7MtPXVWIjudtX8H7k4MPI=;
        b=emwps/a4gsyJMhLkbsicE1n+/2d8ecgDRVGzoF1S9QKnNvZk+ZH9+Q32aBzvnPHFSR
         aDrodCXs3Hyh7Z3FGeBYMSJ3TE6TYdHRbf9o3fpMul2wHaD0VZc18hamVIEJczWluGba
         xbKpLzGTwv7ZDZVm4twnI0mLOUrUHvl/ogNtyimC0H+OmNOkcq+2GnRbrLaOhWZSbJvV
         wu31LOERcVEXt01u1I+f15KrQLU4pF3wLS4NT5rrkWu45gXoyZOItBU67yWdvHSLIsT3
         1M8mA47Puw1jPZs0nkxLxxRRinmm9oS6WVKDdZSl1xWXf52T5G+9fyzste/bImDtGprS
         kpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770757252; x=1771362052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3uD9XI3sB/bwSSzYSoZLmd7MtPXVWIjudtX8H7k4MPI=;
        b=Z0/MPmXmqOtRr/16y10DqL7lQoAd/U5xVqn/BC4BP7D35xcqG9MmN7FAyBEX9Gl4ww
         OQbILaxPKu3JFn41OWm0KzdyGUYO+8UAjz3VPZExTRMQJ7JbYOFwQUhlBnmRr9Qv28vu
         iiQxhbb3ohOUOdK7U0i0RxQizpTnhmfRO2hUgdyKCe5LLhhZZRusClTUIJhlFr40cHw6
         lgc8gFpMM//w4lyUXz65AMwyFNc7Tl8dDmOFf2T7ojY/5a+TKiEXDdb2IdAxawVvPayp
         Ad6GG/uklvFuEOYLdEJV3XtjA4q54ag6ep4fU9687eqM6sHfrWwu0AZO/h4mF4weRVHJ
         c2Mw==
X-Gm-Message-State: AOJu0YxyicV0NpMSz2z5BNeMFLXXl9Oy0+3Jkl7PzFvX0WuDgC0Rbay8
	QujJ4ILgjKO8jkIjKJKA/gxjULPXgma0tRsmk3WBYNTmtVdK11xH70CqXc60UFWi37GwyZWgXuO
	9xBSk7MqXKyoR9JpQsZgkYtXtIJkyFzUxtw==
X-Gm-Gg: AZuq6aKrGf/2oBiwB3l1cCEd/H/j2lVCEGMF0WE8h0c8fArfFPjA0pEIMUP87GFlG4e
	nz/JXTh0x+OGscExqxYIoqj/bCTDWlTY2MIxNA5ZbAwSBSC7DQXhMRdIW6iQjxFBxjvXLA+Fi+K
	r67nBrk4z9DOE1kli1YAi90cSRR9B7DnnDw7bU4UsFt5AbovnqpUYq86MDt4ecfaeLvJNJCj59V
	2dgCetps19r9iYvuRXYMZSbun52/8DhZ4UuoCyevITM2+mYydLeIwpwGUXio2cElCDZ8/Qi6kRH
	VdFrh2Ctn4dIemghuj+06AmO2N/NK3BiSJSrEiNKa8oraMMfLB7bZ794BCuEALaIwWj+7AfP1t2
	tYvWZnwCQ
X-Received: by 2002:a5d:5f86:0:b0:436:8061:7f8f with SMTP id
 ffacd0b85a97d-43680618081mr18214387f8f.19.1770757251658; Tue, 10 Feb 2026
 13:00:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <djwjf2vfb7gro3rfag666bojod6ytcectahnb5z6hx2hawimtj@sx47ghzjg4lw>
In-Reply-To: <djwjf2vfb7gro3rfag666bojod6ytcectahnb5z6hx2hawimtj@sx47ghzjg4lw>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Feb 2026 13:00:40 -0800
X-Gm-Features: AZwV_QgybzsSPlvTzR8ITzdajmcMImZhb4m23PZIgHTMdAkIOqzEsGK8qbH0t4Q
Message-ID: <CAADnVQKpvpg+m_XazY8tYyk+aGyw7dJRBB7+zPF8P1HJy78-Fw@mail.gmail.com>
Subject: Re: Mainline BPF selftests failure due to rcu_tasks_trace and
 do_filp_open changes
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 11:34=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> Testing with Linus' tree (4adc13ed7c28), BPF selftests in failing in the
> following cases across test_progs{,-no_alu32,-cpuv4}:
>
> 1. map_kptr: failed to create kprobe 'rcu_tasks_trace_postgp+0x0'
>
>    rcu_tasks_trace_postgp() no longer exists with commit c27cea4416a3
>    ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")[2]
>
> 2. test_profiler: failed to create kretprobe 'do_filp_open+0x0'
>
>    renamed to do_file_open() in commit 541003b576c3 ("rename
>    do_filp_open() to do_file_open()")[3]
>
> Not familiar with when fix for these are usually done/sent. I suppose
> after 7.0-rc1?

These failures are typical for every merge window.
Since you've discovered them first please send the fixes :)
Targeting bpf tree...
