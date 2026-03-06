Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC3B2D7393
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764449; cv=pass; b=YFbUz9Dw2EVzg2D4XTc5akQj9//JyFONaWznQ27mM+wM1pg0OYpqUW7T5e/orPC/4Qk7cEeKhraUTj1jWgsAKYj2+5pQOKKlaPcaT9+yBrTZIa3GdqcNraNkEvdLPYLlOm5VF9POol/j4mRv5ByviJOvp2MCRfkjxCnUE5GktEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764449; c=relaxed/simple;
	bh=XsprmjPwSUOmN0k9ofErnefj5ohgqOyDo5r3X01z8N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxKWCrXgx0rVEJsxx3MCiDVXcy9uHxqewig/XXuHAP4iMkGzDCsA/bYiFUBYdIpV8UOUYFmV+yBKILMPVsPlqIcnp9xJ+pSlDSswrqZ0jgT5N9M6f8ZjrZ0YJqwkqwt7cvUNhOpis72CnqCz0GzXUgFnt20j753+zg34DxeEzWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5uvKtJM; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5uvKtJM"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ad019bbd4so8001503d50.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 18:34:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772764447; cv=none;
        d=google.com; s=arc-20240605;
        b=AO3tXisxt7s/kxdEGN2BLniZy9S4wE/rFXm6fNV2VQG2dtX8lWx2ooWhZZVOdF+vtF
         TeHI3GHsBfk06SMVMmbZEFgDFnuNIYfjpmxEmu03fJR3DdZYFpFFpL2GqmUdondWySb2
         hyKDKGz0eqDqYs7m4irE21wpIhC2qK2SYd7i7J4MNdttABWkah+9uvdB/A3yxZCMh58U
         zLkXWZRhuD0v4uGyQQ3GILUmB6yMR9Jzcj7qBSkx3YUchEAoIOMsdyWSKDCouusE3ueO
         fO8qdlec42y2tevB+44+gSDVSCmJpJDPs9DWkYOfmkIraQNnE6wJpdarvXchFAsTcfKa
         TC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XsprmjPwSUOmN0k9ofErnefj5ohgqOyDo5r3X01z8N0=;
        fh=GZ/d3WFYj4ujq7ZltdenjvDudx7GnOJOycQoV+UJivo=;
        b=MZ2E5AtwJXi8YQ/n4pectFamgUMU8Hhj0sTvz/PUvOzfnD1YXq4EWSRLm1GT6r5BbD
         HbSieva4BBTcqw/8hMiOGbMcMt/6LRB1idR7rXiY5O/bbC8GLghggg0ewaHcw7AuwqD8
         2iwUI5aBjGPgl8rB5/P6BFpYSVAZ6pnePi7ZbR1kXCRracC2g5R6Mtk0F3YpW0nlalYm
         O2MVx1RtYs6258vN0VEBsHd0qR4i/R8n7tgQQTLJkkg5JnwWUIWdAlrT1nUxNDzJd5bG
         Bx4IhzNwMz1CUqH4pIZ8Wr7eWGsomkHOvrBfiuzu4m72bzeWFFsvPTILTapBH/bKQ5aU
         s+yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772764447; x=1773369247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsprmjPwSUOmN0k9ofErnefj5ohgqOyDo5r3X01z8N0=;
        b=l5uvKtJMFy6Klzy6UETiPdK7lJtMghAKmtB10NWxKDZUOHfkZ+rZc3tl9EjECFy1NC
         VUiAskk32+Ga5cpem+iOE9QcXQbrxRhYM/bG+xN5pYbLdAs50rb+Rasng/CtbulS9Z4o
         jMRx5/rKK7hQFEkovcOcxX24F/3TCAFK7FpFIZqjvl/td+mI0phJYlah1BWT3W87gJ/J
         iNN11XEh8+ABN1AKUP3M/O6V8JZAy5ywFX/C2LI8Di5reX+4EIVI8Mzk7xCd218eyzLu
         BxyIJ3/4mWrmofradpYKKiejywXB2ZiSwD+pgA2243tkgXcWHa4kT4d56yc4uv+Nw+52
         TVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772764447; x=1773369247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XsprmjPwSUOmN0k9ofErnefj5ohgqOyDo5r3X01z8N0=;
        b=pnLtRttV6HbLDGZDv+6iQWOhDrcQJEocVEiv0BE1WSG1H/frh6Jo/vanEX4ue9gcfF
         Gf59EraXih729EeGzL/Zfy8pn49wg+1PUf/mtX14zyAT5jetAMnZlz5c06NicgwH1lSd
         9/wzcroPezgc6vAhZXUpAVtSUAu/RBY+aZoUZwGpkdAnAgGPXVZpklmsdb7i81Kw6xQU
         DlAPkBORFEYRUl96s4/NQnlCpb36jYxELMomLmMP5gzc9+an2U2Ca5sCtMeRClaz9T/U
         CKLyuYz08AxFzeRjl4fx35CjHGRxqircM761BhBu4CTbioYKFUEbnbIP+Jep+mqjvNIQ
         jSSw==
X-Forwarded-Encrypted: i=1; AJvYcCUNpSgQtYd+57V189jbxtH/tCOVmvwxhDRSJIA6NHYInDHcyLK1Ob5CQjIOc7CPxWkVbjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+eU4m+4mPmbz0odgfdSvuMErBr2j5OSHvFte280r8ELxpbTD1
	mMRmZtHSPjSvf8Is85puwHnyLLgmisJzM16yYQ1a+/ZURm+7wQiKZKxP/aN7sZjgS4Q2K15f/cl
	xO1a3ZdCkyEztFFW56ON/+AAM/MSY9Z7lt45z
X-Gm-Gg: ATEYQzyg3kP/M3c9rz9gPVD91RA3GfDhZa17g3YJjJxCY96z8WCd9RW32g4x4lXKmfI
	2UwWqHesTkNJAbl/ewr2+WiIuVv1OR6OGvMJyRX/lSbl3tGLNOvYu4tj8Y0qo87im3TGdKpG/sL
	Z6VyVGqZrKnp3atzaAvZyR3zwOrf5Ofd8j+7yO8dRJW8oZ9bUDNOQ+O1FKIBNK3cpFROr8xVWiP
	1wJE1KeVhoqhCBRycIrqFfzJ84zS8v5T5tgpQEF8WUWyAqmh23JIpDy3EVgw7EPhIum4diu1ccS
	XFk/7Pwc
X-Received: by 2002:a53:b465:0:b0:649:cf3f:b318 with SMTP id
 956f58d0204a3-64d14280ef0mr534531d50.54.1772764447184; Thu, 05 Mar 2026
 18:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <20260304095415.4d5f2528@pumpkin>
 <20260304155742.7b4de2d1@gandalf.local.home> <20260304214447.3e5817ea@pumpkin>
 <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
 <20260304212802.458b878e@fedora> <CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
 <20260304220019.3efa12ab@robin> <CALOAHbA4Dtc3cXs2JiQ=kxES3kT+Acb=amUxkOvQ22fns-Mqgw@mail.gmail.com>
 <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com> <20260305093254.61facfb6@pumpkin>
 <d161ea96-8023-4a5e-a4eb-3e17780c8308@redhat.com>
In-Reply-To: <d161ea96-8023-4a5e-a4eb-3e17780c8308@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 6 Mar 2026 10:33:31 +0800
X-Gm-Features: AaiRm51g6v9S1i2W6an56fo2JJwlLhr-3uILfFxDkrGsMtVSRH2Heri_rvDMBdM
Message-ID: <CALOAHbBnmFjauN0V3L4xCiyJFBDnGOo3_qF302iXWcWp_fqw5w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Waiman Long <longman@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org, boqun@kernel.org, 
	mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 3:00=E2=80=AFAM Waiman Long <longman@redhat.com> wro=
te:
>
> On 3/5/26 4:32 AM, David Laight wrote:
> > On Wed, 4 Mar 2026 23:30:40 -0500
> > Waiman Long <longman@redhat.com> wrote:
> >
> >> On 3/4/26 10:08 PM, Yafang Shao wrote:
> >>> On Thu, Mar 5, 2026 at 11:00=E2=80=AFAM Steven Rostedt <rostedt@goodm=
is.org> wrote:
> >>>> On Thu, 5 Mar 2026 10:33:00 +0800
> >>>> Yafang Shao <laoar.shao@gmail.com> wrote:
> >>>>
> >>>>> Other tools may also read available_filter_functions, requiring eac=
h
> >>>>> one to be patched individually to avoid this flaw=E2=80=94a clearly
> >>>>> impractical solution.
> >>>> What exactly is the issue?
> >>> It makes no sense to spin unnecessarily when it can be avoided. We
> >>> continuously improve the kernel to do the right thing=E2=80=94and unn=
ecessary
> >>> spinning is certainly not the right thing.
> >>>
> >>>> If a task does a while 1 in user space, it
> >>>> wouldn't be much different.
> >>> The while loop in user space performs actual work, whereas useless
> >>> spinning does nothing but burn CPU cycles. My point is simple: if thi=
s
> >>> unnecessary spinning isn't already considered an issue, it should
> >>> be=E2=80=94it's something that clearly needs improvement.
> >> The whole point of optimistic spinning is to reduce the lock acquisiti=
on
> >> latency. If the waiter sleeps, the unlock operation will have to wake =
up
> >> the waiter which can have a variable latency depending on how busy the
> >> system is at the time. Yes, it is burning CPU cycles while spinning,
> >> Most workloads will gain performance with this optimistic spinning
> >> feature. You do have a point that for system monitoring tools that
> >> observe the system behavior, they shouldn't burn that much CPU times
> >> that affect performance of real workload that the tools are monitoring=
.
> >>
> >> BTW, you should expand the commit log of patch 1 to include the
> >> rationale of why we should add this feature to mutex as the informatio=
n
> >> in the cover letter won't get included in the git log if this patch
> >> series is merged. You should also elaborate in comment on under what
> >> conditions should this this new mutex API be used.
> > Isn't changing mutex_lock() the wrong place anyway?
> > What you need is for the code holding the lock to indicate that
> > it isn't worth waiters spinning because the lock will be held
> > for a long time.
>
> I have actually thought about having a flag somewhere in the mutex
> itself to indicate that optimistic spinning isn't needed. However the
> owner field is running out of usable flag bits.

True. Introducing a new MUTEX_FLAGS would likely require a substantial
refactor of the mutex code, which may not be worth it.

> The other option is to
> add it to osq as it doesn't really need to use the full 32 bits for the
> tail. In this case, we can just initialize the mutex to say that we
> don't need optimistic spinning and no new mutex_lock() API will be needed=
.

I believe a new mutex_lock() variant would be clearer and easier to
understand. It also has the advantage of requiring minimal changes to
the existing mutex code.

--=20
Regards
Yafang
