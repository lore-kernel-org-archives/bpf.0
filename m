Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379462F069E
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312890; cv=pass; b=LrimXBi6BwN3euv6WT27PeTgNCSa3973sfsSzvm3sff+2J8bu6J9HPxZdBS6jRHhkemXxdkWBLxyQlMILq/eZt4lb/jkWDeuDaiOyvU9esWXTx7mqc7eqh5vWlEaeIB3I1DF3pdU0uq/4+ZuyFNfy22wdcPbvnsY2Y5WdqAnZoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312890; c=relaxed/simple;
	bh=tiPBdJU8rqA5vz1AM2s+q8CIEl6BnwyA+J7QRWGMVtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iW6LwZkPBkVgfckkLRjIqZheJN9XJTd2gNjhAhkxJ9OkxITc/hDgAfGA5mU1NygxMJevuOiIlyrkdEgiBh66xM2XoEj7zxJjBxWwOWaSWaDE/GtCwXvYJzIOpDeXQTY8kZQKTJJD1Cv0m0fdytMptTzssdGd6oTNqdzCa3+/SLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ocg/bHhn; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ocg/bHhn"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-823f9f81da5so683792b3a.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 09:34:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770312889; cv=none;
        d=google.com; s=arc-20240605;
        b=Cqmj4Hjbbkpp8BDFWG/eoUj5cWYnP6PWmjHOQ7RQh/xnVY/xBV3fW9BbEywIDEHTVn
         fr+lFTeKHbUibURI4q1MMmJJj0GhAwmMRNBJTFqpltKA5PRn72IiMjJOm3YFQDPUdJsw
         687l466mXGt3EOaLyHc5K4vOqj8LxursZvAfeuc5w50ERX7JCCDpsD0WUmgoExkPHyk5
         +vnNUzyvefgK7pywcN5OExJHbnTGHyFAUzObzC4ZJ4wc0R81ZUVcN/RO0yY2fP9K0RpI
         SVKrx3W/cxgxLPa99JbM7JBEGYMKPQaL3idPoHk1WVmNBvQ3TxK07UbLtF0THec8SsPa
         FYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tUGmD83/1M22wWiyFrGsa2SWt3EM/PQmAOxBE61Ssdw=;
        fh=gOXGb+58cfdwPNJy2SrDmLIMbk4S2C6Ot75FygDolEQ=;
        b=k4WloXOgHgVYxviIG7eFAPNloGCUeIfrSp1a9h7yAoCDVAa5MDdCNUaRO+MrkdAMKR
         W2yq6kxebJ0MxFedgRqI5PoBDR9eCGs1szY2LADOpCYLg4bIJ6C1QPPvB/plsH8lC5zR
         inX462nKV2WxL0iCv8IyOuVFm7Q2sSiRz/JbNqYQIyyz/G6El8JGtWJdy3eniyEfvULc
         uQZO9hPLyLXCcIQZt0pathYmzCrkCnXb7ipVPOj8OWGCliXnyJvlqIZtCRn65NzT4O4l
         tOlp89HT/goj/9dAATvOP3ofMGj+xpt76i4Bew0tYI33pvgfunZ8mlV7ttLbmzVb3o/U
         sztA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770312889; x=1770917689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUGmD83/1M22wWiyFrGsa2SWt3EM/PQmAOxBE61Ssdw=;
        b=Ocg/bHhnoKTo4P3gVzeFf69ZOhmtx+AXD3Iwqfsk37JgRt84jBKdelAR9lbysPj6e6
         ALrneHaD64/fXASv0+DvapeaMEFC5sPDNf7C7O65XqPOJrrSLiBJNaCei1WrdeEFVPyI
         rQg69M4CJjt8Xd4M57u4p/cGXvh/tAERcBjoiznAWWlqJDWX3PZGH83H/NsG+TuASsd2
         qsA37caEOvkjmJ+uou9sB73EeSr+GkSap4JY8E8y2CRgEKoYLH2AJl22v5PXcqpIgYip
         I9gQQkeX6pM8xs+9wStwQo5tPthh9SruPoJrdgGH8jcpe21TyEf0aiTA9VJzgXzgHSXn
         wK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770312889; x=1770917689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tUGmD83/1M22wWiyFrGsa2SWt3EM/PQmAOxBE61Ssdw=;
        b=dKq1Brot+HejWoWPX4zwk8KxzpJNXP43eBAVDD6wCLz+zQ+ZZFttT3PeBsObepRXOr
         /84iE/SE+W+ZxK30p7OxgItC+PQ5nEMSnUrCcczTxSyy6Xea5uxDda6b9NLT/X4C0ays
         ADuoe2jzXtlnOyC4MLF4rZ0VMV89rv/Xr2A2LkEGfSUE1BXeL+meJzCyi+ddIOyArvvb
         dvszf17KpWnCW1GNTgpYhPYgNDUjAEmp+IM4QuyIS02osT3bZAvWK+AAB5Ywp7wilE0r
         AXY89s936SmDw2yXl1AyDI89AB6L+Ias1+D4doM4VZRtWRVqLz39kht86HCG+SXaf2xc
         d6hw==
X-Forwarded-Encrypted: i=1; AJvYcCURalzpXCR1t/q77EdifA2ghT/TbwxQSV5Qrc0wc4b/35mUc+KLJHNCc/f1Hs4boxIB+7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzijD4i6cjbtBg3stvGn1fn5dzg9Ysgzu1AG4ZFk/xE5W1e++bz
	tkLK5mzRB7MMkbZ6ZAEVhQS2wo4Y5XcU3/tFl4ScpP59THUPuXMPlt//3fRPIDe6gZs4KELehjl
	NrGf3WoWffwJp7wY4uvnhz+p1mmhZMw4=
X-Gm-Gg: AZuq6aIcfsXsCmUUWGNyrRQVifoI4N8IibXVrxMRLohbbkkkm+H9Egp40BMig90tdmp
	rFLZPz7i89gv5YpvlCCoZqLpdVasvCn689U/4hL4ExvF4ilYEoz5L5LGsbeNJJ8zbRO39N2BJjz
	nu+8Vgck77r7jIAWE5EZGfgzxxHKCwKqjWPr+U8W2e7nfOc/Ld8+fKMpm4fOE/AXhSGqlWQVfD+
	0cunafuqmLs/KN+lUtWXszMcaAMfvZ6KOC93Ij+k7uq90JRo734lUf0E/vW44xPW+jM7rrLOh2C
	0vE1j5HT56Y=
X-Received: by 2002:a05:6a20:ce47:b0:366:14af:9bbb with SMTP id
 adf61e73a8af0-393ad3a3e2cmr116924637.69.1770312889503; Thu, 05 Feb 2026
 09:34:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-3-chen.dylane@linux.dev> <CAEf4BzYMJfQN+0SwzBM-DhREHwZ54TwA6GUtFv9=xret9pzXrQ@mail.gmail.com>
 <bb62bd4f-199e-4907-817f-bc820c9198c9@linux.dev>
In-Reply-To: <bb62bd4f-199e-4907-817f-bc820c9198c9@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Feb 2026 09:34:35 -0800
X-Gm-Features: AZwV_Qj3jY8w4GJmu6lbjxat_AMSsnStGDk7UPuuWob8Qge5D8J9zZs3xeUra9A
Message-ID: <CAEf4BzZun3amXMpYdBPEy=qZwrY3ZjrKf_qc6tG-b4NJ=-AC7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
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

On Wed, Feb 4, 2026 at 10:16=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2026/2/4 09:08, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Sun, Jan 25, 2026 at 11:45=E2=80=AFPM Tao Chen <chen.dylane@linux.de=
v> wrote:
> >>
> >>  From BPF stack map, we want to ensure that the callchain buffer
> >> will not be overwritten by other preemptive tasks and we also aim
> >> to reduce the preempt disable interval, Based on the suggestions from =
Peter
> >> and Andrrii, export new API __get_perf_callchain and the usage scenari=
os
> >> are as follows from BPF side:
> >>
> >> preempt_disable()
> >> entry =3D get_callchain_entry()
> >> preempt_enable()
> >> __get_perf_callchain(entry)
> >> put_callchain_entry(entry)
> >>
> >> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >> ---
> >>   include/linux/perf_event.h |  5 +++++
> >>   kernel/events/callchain.c  | 34 ++++++++++++++++++++++------------
> >>   2 files changed, 27 insertions(+), 12 deletions(-)
> >>
> >
> > Looking at the whole __bpf_get_stack() logic again, why didn't we just
> > do something like this:
> >
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index da3d328f5c15..80364561611c 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -460,8 +460,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
> > struct task_struct *task,
> >
> >          max_depth =3D stack_map_calculate_max_depth(size, elem_size, f=
lags);
> >
> > -       if (may_fault)
> > -               rcu_read_lock(); /* need RCU for perf's callchain below=
 */
> > +       if (!trace_in)
> > +               preempt_disable();
> >
> >          if (trace_in) {
> >                  trace =3D trace_in;
> > @@ -474,8 +474,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
> > struct task_struct *task,
> >          }
> >
> >          if (unlikely(!trace) || trace->nr < skip) {
> > -               if (may_fault)
> > -                       rcu_read_unlock();
> > +               if (!trace_in)
> > +                       preempt_enable();
> >                  goto err_fault;
> >          }
> >
> > @@ -494,8 +494,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
> > struct task_struct *task,
> >          }
> >
> >          /* trace/ips should not be dereferenced after this point */
> > -       if (may_fault)
> > -               rcu_read_unlock();
> > +       if (!trace_in)
> > +               preempt_enable();
> >
> >          if (user_build_id)
> >                  stack_map_get_build_id_offset(buf, trace_nr, user, may=
_fault);
> >
> >
> > ?
> >
> > Build ID parsing is happening after we copied data from perf's
> > callchain_entry into user-provided memory, so raw callchain retrieval
> > can be done with preemption disabled, as it's supposed to be brief.
> > Build ID parsing part which indeed might fault and be much slower will
> > be done well after that (we even have a comment there saying that
> > trace/ips should not be touched).
> >
> > Am I missing something?
>
> Yes it looks good for bpf_get_stack, and I also proposed a similar
> change previously. But Alexei suggested that we should reduce the
> preemption-disabled section protected in bpf_get_stackid if we do like
> bpf_get_stack. Maybe we can change it first for bpf_get_stack?
>
> https://lore.kernel.org/bpf/20250922075333.1452803-1-chen.dylane@linux.de=
v/

This is broken because we are still using trace after you re-enabled
preemption. We need to keep preemption disabled until we copy captured
stack trace data from ips into our own memory.

>
> >
> > [...]
>
>
> --
> Best Regards
> Tao Chen
