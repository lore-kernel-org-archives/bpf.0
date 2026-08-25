Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D31B3515DD
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682197; cv=pass; b=vDFYRZJ6mULKUaQw4ZQpdZhg49EPliaGlWGEqyVm7Sb5s9a1Gd1p5feekKeSvpotDvF8ShBDUu7aM7fHWmN3/DWrTN4cGOH2AxpPUjcD2OTRModPvY/GD6TcNEU4qU/7Y8P1EegBBaEXDfzcGk47EqekmZhaYbsbVKhjwKjTdVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682197; c=relaxed/simple;
	bh=LHECQk2R2yAF+nk9WlWCgcipuNKlvtb34YmL2PVFd6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfU/ONRcIFpk5HRvr5yYDRold+oyuVWw6ExlrWoEtletKZ05qOpXFaw/1x1NnTB/PtjPEpDzkDChV89ddr7L4VWomMvVVk/PcNPmjVoXOSQqNrDWQ2Sx84PofxeqSLDCtsQ+OI6rtQyJt+KZxZ4P11GCWN1ZByMz2JKW1ecz/Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9s8mMdM; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9s8mMdM"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8486672f03cso186424b3a.0
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 11:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787682195; cv=none;
        d=google.com; s=arc-20260327;
        b=Zi7sN3gXxJvZWBxcNyAr1gQjzFgRyUPxF46qbzmI44srMgmzc955Vu0FeH55loFB92
         fnuar7SxDeMAYA/vKNAS5Y0VW8+zbF8AZKy8l/PxggM9sDJkdmPKwB4tb9wwvFyUhSKn
         vLbjuX6U7Ij53/AHdnMC2P7XvqzVYi0jJ5K3T6fo21sacicFqFsBimmhAFkHvLe8YP0j
         KrgbFjXLcYMXO3H86ri4nVdouGMXBuALRmkullYUsmkQtjp9T728fZBF1FH5vEKfq4Xv
         OyxzaWRm4g96uWkBV7xVQrHQyijl40RRERvnxEM+Sb/tMhe7K2Ss8K2F8bxbE4rzcUqm
         F/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LHECQk2R2yAF+nk9WlWCgcipuNKlvtb34YmL2PVFd6s=;
        fh=qXdEJCmhaU/5iD2Zunuxk7yqwzkHs21LjcQynOwtmuk=;
        b=pP9zY32Z+Eupg9/W1KIRi42DY+XaHm+9iHzFpOT6FXUFk2LUg9q1Lk6A8dcP1tMX+6
         5hdNsJuFKlsQBiAXyMGlEifV/GwrC8CYrVQyyhL4L4lHc22P+aZ3CT5v3RJxp0UZLBYU
         bxw9TZMx0kNmSzh4wSr4m46g9ibFa/PAjQxxMFILcy8Z0HSHFtXerUcdhGwOxn235U1z
         RFik3NjGa4q14cn0dadAFNHJXIl1VGe8PNo4AxTb6RqQa12a2kOeP/M2q1K3oSWxDSk3
         7wD50/oOxmTE+gey2um7kSkm/rRXDDfmqgarjBHobNo9L3wNf3cjM1XgNEjXHTf1yJXo
         LEKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787682195; x=1788286995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LHECQk2R2yAF+nk9WlWCgcipuNKlvtb34YmL2PVFd6s=;
        b=b9s8mMdMb0VRVoqJznv08VeLt4PToGgletWyExMa1lP5IFAIeBmwqYNFV+hdPUdOXH
         W0etCbBn8DeFqAJpe8ymMDHh9xcF6RJrVoVSY1JA3Db3XusICHolTCyM7FKnGeTNGRig
         cDOuyxQ4xvPxtQa1x4qPY1mQxrF20YLKie2a4WGUr/AS9ee42wMNJ2wSB/ZhFK67fvZg
         cONZybIxdTHjD2TPUrM+XvmhYcpd5YwRzudF9i6OlcusGeOUnWc5neikPqd/Y1JZHc10
         iO5rtly9gSTwBI57RGNFQl10WXh46fIi6x02IuCM7YnwESOrZsqL2Su+mh+7Lt9+Q5ht
         gB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682195; x=1788286995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LHECQk2R2yAF+nk9WlWCgcipuNKlvtb34YmL2PVFd6s=;
        b=p/VFiXXVGqNjds6SXg/s789oLnUZUfDVqRtsilgX9pc8LGtylz1Gr0WypDHCtut84W
         usycEELQKpbcoWQ4nuqmHZDloTXLPrNyg9BtFsivmr174H2nBnGrZquv/8VZ/ThGEucV
         A7yNSlCgcizrJhX2WvC+3oag39JJOlzvhuf9PoR2Cln4mEJFdF/ar/oCFqooSCeA6pqX
         PxYuIWxtJxWczCKsyTZy6w1LOHMc/ZROx6nggq/12/BNUiExCaDMC6ZudWYKkYaU+a9N
         QOqkY00acXCF4kgu1MSQEahaJbbl8pl0MhN3Nju/u/uNhmxXmWOGmsYUdshorVBHivYx
         GoQQ==
X-Forwarded-Encrypted: i=1; AHgh+RoEX1EyoBf54AxCiK6mYWsejgAs5eWeDitG+cMnY2vnG2d1YGpNGrS1peQUGgqA9S3P+7M=@vger.kernel.org
X-Gm-Message-State: AFuF++kQUuttIlFY3GprI7rYMypoJLtjXujDeKKtUuDXyM/VVLQSSymX
	zu15qD4Eqjlg0N7KsuO4uwjNqBkCHTzirQGUtLUb7gjsfTN7qQ18wcV+wC1mJrSnMRR6kLjaBMf
	slcVDYHLTtBNEsbSQsdxfZ2FloqrY+Kw=
X-Gm-Gg: AR+sD11ULiBhcXMEXqtAlblPEMbhUb9wU4bxyJ5Ra8MPxZYWBOGu4A43yZdNiITpJjP
	foIsHcIH/fL65cTcoLDxNq5sUhLMlrpFOMxZJDFaDOy0n9aSX24+upZc+Aa6331iEQVHXNQaoDN
	fvFMi2hYzzc6STP1Z1vcBOfqDoMayLW8M+9W2YXZIOotbOJmX7CH2npBuAzHJlT1pNgr4rRjJIs
	VQ8SuerDhXpKKHrh/6Yam+2GSku02cE0W61fFn9p8T0OHMnkWVO5NkEI+LqkqOzcgGdkz/Ke4cH
	Zee7OJsKF4VCjPm+wLS/N68keTHNu/nvMop2sOV9jEVpAbUyySGuUh3Ymb58pnbQR1Q+tnadu8B
	yB8sBL28u8VdLW5hpGk43oLwOul01MB/HzdyKRQWq6w==
X-Received: by 2002:a05:6a20:6f03:b0:3cd:9f0b:f788 with SMTP id
 adf61e73a8af0-3cf83d1ef40mr670754637.12.1787682195222; Tue, 25 Aug 2026
 11:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822054620.452262-1-ming.jvle@gmail.com> <aosT4H14zcowzU_7@redhat.com>
 <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com>
 <aotM6tRUHI9Bo7gW@redhat.com> <CABbwK50istUW_xnFsjCA+MMgFCuBbY-Zs3QmJU=Fg7heqKdF6A@mail.gmail.com>
 <aoxp3Rcbp3fUuqS8@redhat.com> <CAEf4BzbUQWAB0JuEdXu32v4S_zMuv4de+kYv0mcY4tDPu8CA2Q@mail.gmail.com>
 <ao2KDQuBMNtONu0K@redhat.com> <CAEf4Bza0Hy_a4BpFBrsP2F5wvEDOyL6n2jK5FK8r-QyRFwvBPw@mail.gmail.com>
In-Reply-To: <CAEf4Bza0Hy_a4BpFBrsP2F5wvEDOyL6n2jK5FK8r-QyRFwvBPw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Aug 2026 11:23:00 -0700
X-Gm-Features: AcwNN1Ukv0tOVPmP2iBOudSXuYwiMIHO7YcnLC1DX5MhYH6wLfCTEN94bKtfCOE
Message-ID: <CAEf4BzZGQ50=B4S2NBZnqWN29YBgthMX8LsYGLq5rOsdGzpS3w@mail.gmail.com>
Subject: SIGILL and uretprobes, WAS: [PATCH] uprobes: Free utask on
 dup_return_instance() failure
To: Oleg Nesterov <oleg@redhat.com>
Cc: Keke Ming <ming.jvle@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 9:38=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 25, 2026 at 5:27=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> w=
rote:
> >
> > On 08/24, Andrii Nakryiko wrote:
> > >
> > > On Mon, Aug 24, 2026 at 8:57=E2=80=AFAM Oleg Nesterov <oleg@redhat.co=
m> wrote:
> > > >
> > > > force_exit_sig(SIGILL) can't be ignored too. But I am fine either w=
ay.
> > >
> > > Current SIGILL sending is already pretty bad behavior that bites us
> > > periodically, instead of doubling down on killing the user space
> > > process because something about installing uprobe goes wrong, let's
> > > think about a bit less destructive way to do this. Mark uprobe for a
> > > particular process as defunct or "detaching it", or something along
> > > those lines. But not just kill innocent processes.
> >
> > Well. Yes, SIGILL sending acts as BUG_ON(), this is not nice and
>
> The problem is that this is actually not a bug but a very real and
> expected behavior with user-space using fibers or coroutines. Any
> suggestions how we can make this less violent, as it's actually quite
> dangerous and kills production applications when someone (unknowingly)
> tries to uretprobe trace them...
>

IIUC, this SIGILL and coroutines/fibers issue is due to
uprobe_handle_trampoline not finding utrask->return_instances, because
a bit earlier we threw out pending uretprobes due to
arch_uretprobe_is_alive() returned false due to that `regs->sp <=3D
ret->stack` check (for x86-64).

So the question I hope you can help reason about is a) should we just
ignore utask->return_instances =3D=3D NULL case and count it as uretprobe
miss and b) should we flip it around, and just not add a new pending
uretprobe if current stack doesn't satisfy this invariant.

In practice this would mean that with fibers we'll get some uretprobes
matched, others dropped, but at least this will be discoverable due to
misses and it won't be killing innocent applications.

And at any rate, we have a per-process limit on number of pending
uretprobes, so there is no risk of having unbounded amount of memory
taken by erratically behaving application breaking uretprobes.

WDYT?

> > probably we can improve the current code. And, just in case, as for
> > uprobe_copy_process() in particular I agree that Option B (make fork()
> > fail) is better.
> >
> > But what, say, uprobe_handle_trampoline() can do if ->return_instances
> > is NULL? Either we have a kernel bug, or the probed task does something
> > wrong. In both cases it is better to kill the task with pr_warn() and
> > generate the core dump.
>
> I don't remember all the code paths, but just shooting in the dark
> there, we can always poison a pointer to distinguish or something? or
> just assume kernel bugs do not happen and ignore NULL. Or something
> along those lines.
>
> >
> > Oleg.
> >
