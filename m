Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120922E4257
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 23:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909622; cv=pass; b=KureE5707dV37eRdCQkJDqQiARcQn07UWV7W94L/ZotnqrBTCv3V4qJsfRANx2Em0aWnYOUhF587Awvjs56prJYXZgwdAu8EReUM25vn2+MFzmMTOH1wsagJXztlDrm6CM6UqGYSBit4bXnbwkI9/fmG3pA4VuqunazJSdWoGE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909622; c=relaxed/simple;
	bh=0Nrc3/DTkgBOEhhTRfAXx65ByE3knApEhzU0G4j2nL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3AkGN3/xVErJ3K2a8+wMSa2zayxbzDtAyvdKB0cKIxXiOhVh12ZH39MAjwiyZ3Qnc/92vhdurSf+5qLiMIYXBTAW04D4eYGWOJ6fs/D88lhuJb2773QES2K0IwhU8qvIdDx1JkjS4Qr+uEDb35cijbVhpR9muNgVbLMUix2omU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYHtU82K; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYHtU82K"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso4815415ad.3
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 16:20:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788909620; cv=none;
        d=google.com; s=arc-20260327;
        b=kQ/J2AI94wwVbeXytw2Bt52q9ctNV7FObZJeioFsgq9JCdfvkCWoPUNJU/TZE8uAiT
         qrMPt9nM8Y3WwIah/SDQ++6CS+ruthU3km7WF9vZf0lsH3angLytPbsb66kDMbSppUI5
         3tRDnggCBs6Fk2J55bKcF5NF717g0GrTWsZRJ0ap1ju0NMYr3N3zuy6ASr1/Iuq/TzTR
         3NwtubAojEEFNbz87h9m0HnCWAt5C/AKCh1fa0o+EpLTcd08Af0JhGGGtncm4EJDwCvj
         N8d8mJjaNivHVrBRZpgAEV/YOBIp3aLlkD81QBcDylLKkTri8Kw3PT7X5LkTovisAtqj
         FApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UvsqcViZfrOHn4UJwhQEyvVX3zrtGwT7jq8HnfOLPfo=;
        fh=zec2PoaZqj1ukV8eqXgHC3JJYWl31/+MogOI1SQCJ+A=;
        b=IGYPKyNp/ReFQiFC0F4iYnkHXKfZdOMsGLmXCaorBPAqbMAty4pxiXbbtWf44id4/J
         et3uDCqvpMtQrCKOX2au49YgaK0ZTevBwHxsuEKgjbD3ZRmHJFvS8HQGknU9ji1V6Ioi
         c9a441Gs0oTNRK57sV4HlsLYMTPLeWhesKVlYutREFJFIQ1Oa+f3BLup0rXVx8FCced6
         bM+JDbC2czITuSwcG9K8NMP0QafRjFNp4ZTuod5ERtGFk9OrYFpjK/pHmkWDbGb9iADc
         /VTuztCMukUQ1VtwSlryNzrVzQDPtFsUKPZFVZ7NSoYNe7MnXhQtbiFTDfPVl5IUuiZp
         6a/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788909620; x=1789514420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UvsqcViZfrOHn4UJwhQEyvVX3zrtGwT7jq8HnfOLPfo=;
        b=bYHtU82Kup6GvVqE94hJeoD7zxleVsWNV1c4gd3m1NxB6PLa48qMkqZfDmADtOaYIK
         UCmGEpjh+NUr7qvVH0+h5PHCMTSObCofz5xc7UVVklO6K1baL0XOsWDF+C+VV4jX4A23
         xZ9rhvpte9eFiN8VUS24q2eJR1pWPBtcqmN2NFK5ZnOp4ipvlFPTrlM7HUYx9jmkB9+B
         JR7DXIfwnQjS6QaP06adpS4i545MCgbSE4CE95Ikx/F467OcN+NCzoEgJo7fVMLQrKNg
         914iXH2ltb7tdCFpcuHKLnDEsd68uS8P5JniRbLYOxOy4Dm+X/ovVXseuRU/cMYfh9GY
         vU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788909620; x=1789514420;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UvsqcViZfrOHn4UJwhQEyvVX3zrtGwT7jq8HnfOLPfo=;
        b=bqu1COMTt9qYbHQ7aXRmXHKdec7ODnzR0WD1Br2fG5D3tsrtrbjRdaEj7GXyCtfSLj
         u8b7rjAHg7IgET8VBwqXSWgZpMGJSee2wPxND/mT/PNxeI7Aa/UZLEJnVqqZYoH9z48X
         XC8gSWIF2OVoEhDhJfhYUN870+QwIU8Nr3B7zpQIGo9no7paMC3wpej/wZW8IlF26GbV
         2K6Q9W9ioRzgkIqwSH3gwejhli6O2tRWcqHdSOz+H04Iwq3QF/yVfTQ7Nnz5lrqCE/tZ
         S9JV2CFAnKcLXlb1Fj7ucXyUzdpH33db861NehWTHsc5qEqqmD4C9irU26DXojBzQRm4
         ZtFw==
X-Forwarded-Encrypted: i=1; AKwUvBwZ8mfzLNKnxh3YTKteaMwl5MYPrHREVE3CmKpo44SuiQq4szlGls/Tr+PwftE7Wvyj5kE=@vger.kernel.org
X-Gm-Message-State: AFuF++nhODmBWbxxtZ7phTEGnNKQ86NGqo0o3pDhj2kMYHR/zJK6qgzR
	rWHNGQXW7Xacq5V2QGiI1nsijY3MTlQ1MdZYa5edBLYCIrQD3QNk2TN94W8anMelTSgAuETnIBG
	mZJaSXnyIeQUzYZrLqmTeigdLBVfGGFI=
X-Gm-Gg: AYBFou2VUZbabTckENRFZX11JjoUCxmPAf6Ay825UyZ3GL5MymwmUNpu7UdItP5vtQR
	9gazVLTZNQLQcJEgPH6X8lWLQe3vidrIxKBNKJqEo8mri1Pt9d49D+OIY/VS+R6o9e7iofcQeBx
	buTlcbVmhy/OI6+eRwX3NgZbmPgffKjsro6aziM5rC52VR8q2QIVohkGMHaqeUu2J5fdv1eQMxV
	Jo45Iu1jVEW7oNPfO/wsdVN7MUhMyUUda1ALYJ7jQbQQCUXg0ts4ueNKG3hYSeou+5uemVMSJUR
	fwMljyTkV+aHFYmgANZTDqX5JIGTy6VP28bXSxoetX0JXfxi0hxfLGspFvqgE7Xp7zCO33V97lS
	G1BigkGtierjAJqyPsda44fcgygTXYhDwmmKXVgIS+wgepoPAnOGH
X-Received: by 2002:a17:90b:5705:b0:398:9be8:ea66 with SMTP id
 98e67ed59e1d1-39bac3f1dc2mr3163325a91.19.1788909620153; Tue, 08 Sep 2026
 16:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819124324.43162-1-adi.sharma@zohomail.in>
 <CAEf4BzZY6uWdobXVyS1WrdtmRw_SLJsodm7d_c+Bhsw=chpJ+A@mail.gmail.com> <a3314523-7ab6-4f1d-b411-be980b964079@linux.dev>
In-Reply-To: <a3314523-7ab6-4f1d-b411-be980b964079@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 8 Sep 2026 16:20:05 -0700
X-Gm-Features: AcwNN1XMWu4LAnaBEd40O4avTCpDLvOPiihFxZCe1gtGo1Ibx6Pmoec1cAuFAzM
Message-ID: <CAEf4BzYMNTgyEBhfuTKb-Ug_THGyVxbBajE4NRQLtaNerFJdOQ@mail.gmail.com>
Subject: Re: bpf: Is the nmi_uaccess_okay() check needed for bpf_send_signal_task()?
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Aditya Sharma <adi.sharma@zohomail.in>, bpf@vger.kernel.org, song@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, puranjay@kernel.org, 
	jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 8:40=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 8/21/26 11:21 AM, Andrii Nakryiko wrote:
> > On Wed, Aug 19, 2026 at 5:44=E2=80=AFAM Aditya Sharma <adi.sharma@zohom=
ail.in> wrote:
> >> Hi,
> >>
> >> I hit this from a bpf_timer callback that signals a userspace task: th=
e
> >> signal was not delivered some of the time. It turned out that
> >> bpf_send_signal_task() was returning -EPERM depending on which task th=
e
> >> softirq happened to interrupt, and the source is this check in
> >> bpf_send_signal_common():
> >>
> >> bpf_trace.c:872:        if (unlikely(task->flags & (PF_KTHREAD | PF_EX=
ITING)))
> >> bpf_trace.c:873:                return -EPERM;
> >> bpf_trace.c:874:        if (unlikely(!nmi_uaccess_okay()))
> >> bpf_trace.c:875:                return -EPERM;
> >>
> >> Is the nmi_uaccess_okay() check necessary in the bpf_send_signal_task(=
)
> >> case?
> >>
> >> When commit 6280cf7 ("bpf: Implement bpf_send_signal_task() kfunc")
> >> made the function take a task, the PF_KTHREAD and is_global_init()
> >> started testing task, while nmi_uaccess_okay() kept testing current.
> > Yeah, this is weird, at the very least it should be checking it for
> > the provided task. But I also am not sure why we have to check this...
> >
> > Yonghong, do you remember why this was necessary? Can we just drop this=
?
>
> I went through the history.
> In 5.3: we have bpf_send_signal() helper:
>
> BPF_CALL_1(bpf_send_signal, u32, sig)
> {
>         ...
>          /* Similar to bpf_probe_write_user, task needs to be
>           * in a sound condition and kernel memory access be
>           * permitted in order to send signal to the current
>           * task.
>           */
>          if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
>                  return -EPERM;
>          if (unlikely(uaccess_kernel()))
>                  return -EPERM;
>          if (unlikely(!nmi_uaccess_okay()))
>                  return -EPERM;
>         ...
> }
>
> nmi_uaccess_okay() is needed for *current* task.

but why did we have that nmi_uaccess_okay() check in the first
place?... that seems to be something useful for bpf_probe_read_user(),
but for sending signals, assuming we have CAP_PERFMON/CAP_BPF, we
should just allow it.


>
> In 5.6, bpf_send_signal_thread() is added, but still for the same task,
> so we still have:
>
> static int bpf_send_signal_common(u32 sig, enum pid_type type)
> {
>         ...
>          /* Similar to bpf_probe_write_user, task needs to be
>           * in a sound condition and kernel memory access be
>           * permitted in order to send signal to the current
>           * task.
>           */
>          if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
>                  return -EPERM;
>          if (unlikely(uaccess_kernel()))
>                  return -EPERM;
>          if (unlikely(!nmi_uaccess_okay()))
>                  return -EPERM;
>         ...
> }
>
> In the current master:
>
> __bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, e=
num pid_type type,
>                                       u64 value)
> {
>          if (type !=3D PIDTYPE_PID && type !=3D PIDTYPE_TGID)
>                  return -EINVAL;
>
>          return bpf_send_signal_common(sig, type, task, value);
> }
>
> static int bpf_send_signal_common(u32 sig, enum pid_type type, struct tas=
k_struct *task, u64 value)
> {
>         ...
>          /* Similar to bpf_probe_write_user, task needs to be
>           * in a sound condition and kernel memory access be
>           * permitted in order to send signal to the current
>           * task.
>           */
>          if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
>                  return -EPERM;
>          if (unlikely(!nmi_uaccess_okay()))
>                  return -EPERM;
>          /* Task should not be pid=3D1 to avoid kernel panic. */
>          if (unlikely(is_global_init(task)))
>                  return -EPERM;
>         ...
> }
>
> We probably cannot remove
>          if (unlikely(!nmi_uaccess_okay()))
>                  return -EPERM;
> unconditionally. The above 'if' statement should be guarded
> with *current* task if it is different from parameter "task"
> since nmi_uaccess_okay() is only for the *current* task.
>
> >
> >> As far as I can tell the path here does no user memory access, so
> >> there is nothing for the check to guard.
> >>
> >> Also, it compiles to true outside x86 (include/asm-generic/tlb.h:26),
> >> so if it were necessary here the kfunc would be broken on every other
> >> architecture.
> >>
> >> Thus, whether a signal can be sent depends on the caller's context,
> >> rather than the task it is to be sent to. And at the bpf_timer callbac=
k,
> >> we never know deterministically whether the signal would go through,
> >> or it would get rejected here.
> >>
> >> A quick reproducibility test by Claude Opus 5 (the issue I was facing
> >> from the timer callback context was not reproducible deterministically=
):
> >>
> >> SEC("tp_btf/workqueue_execute_start")   /* current is a kworker   */
> >> SEC("tp_btf/sys_enter")                 /* current is a user task */
> >>
> >> static __always_inline int probe(void)
> >> {
> >> struct task_struct *t;
> >> int ret;
> >>
> >> t =3D bpf_task_from_pid(target_pid);
> >> if (!t)
> >>    return -ESRCH;
> >> /* sig =3D=3D 0: permission check only, nothing is delivered */
> >> ret =3D bpf_send_signal_task(t, 0, PIDTYPE_TGID, 0);
> >> bpf_task_release(t);
> >> return ret;
> >> }
> >>
> >> On bpf-next commit f79066c7 (selftests/bpf: Add tests for a store
> >> on a fault prone qdisc pointer), x86_64 under qemu:
> >>
> >> bpf_send_signal_task() from kworker context : -1  (-EPERM)
> >> bpf_send_signal_task() from syscall context :  0
> >>
> >> Same result on v6.18.29, x86_64, bare metal.
> >>
> >> I may be missing the reason for it to be there as well. If this check
> >> is intentional, what is it protecting in the _task case?
> >>
> >> Thanks,
> >> Aditya Sharma
>
