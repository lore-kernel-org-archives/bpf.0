Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F0E3ED13B
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493916; cv=pass; b=XFiAtBGDynO4U29rxvYZTDuWZArCX0qU7mYfInJXVAFtzSIVtVpDkp7OhMaDbYmd03VRjvWfzMx/nsdDiDqgJ7jvp56xQ3JPYZqeTMYQiLh7KBEBfIoLbadcBLNIiEcskMj9UiojAR1JM/SjlQYdBIYwnUZcSmXfz7dXefR8sKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493916; c=relaxed/simple;
	bh=+3JOKZQTIXSiy7TPE+EiYNvh21Ntyyf/aSWG9sMXBzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tanvv05UWHE/1okNxv7UgjtGFnefjtnUeNp4mi5qN3SSKkWkIheXw4EwpxaO5ldslCR0ulWVLwm2lSFoM9GKGOjKiDx0jjjZ6sQL1cGpPGALEdlqxeN+G3TKYYlcnDTMpYt2Z7qQhSLvA6HthPBk0jwk+94YyionBHEh3VE+4Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGFnxJaG; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGFnxJaG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so21213935ad.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 23:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783493902; cv=none;
        d=google.com; s=arc-20260327;
        b=rZYy9/fs/lU5k/zkaY6kEfsMyPKSa8TsqlJPjODG6PcVKAtWAqr9PhkmiMIlW6sn6U
         sNZzKjawoiJcfoVBCL6GpIb4mf1mYgVWzjsN6PAvXpxjcad+8t/olQPs5M3oOlA7pyw2
         IpflqCh/0+S5jwEVY6nenQQBKgqFCAkMsPCIlcpBBrrgi0d+Oz+3YV8X73rxs53GUCAa
         mzIlBn1avvcpt5RJZJtj3rL9uR0R2Fh327PL/3qi/mKHY+XfkGL14MncjEScjZYPCvJb
         YTYgij05Mp83TXy0h2whXQcpVsyC2gDdu1A4Qi7uX+VhsVU8Gxeyzf32Djum1+B2jyie
         V9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=++Np+i7QbYkMJq7srOxofh9iDJgIYXe+19kl+BTYoIk=;
        fh=bjPGDqnYqLa6QgVexUsafdqt3fgz1j2cuP/SCJ5eFjw=;
        b=b08oa0eaj6IQJobiGXzs9WjSCBC7ZjZirUOh9kvaRZ1cH2/QK1Mi1iMPKOzFdSh6Ib
         AHTfcBOoHkc2zfe+IcD/QyE78Gsq5dlref9JbVAA8fX554RGreANUPKUPtmsx92rhF3h
         R1fVraItcWce3uyyxW/IjDcSi5tknLF/nudnFzHeFgmchDg7EUSeH+fG/xthRHAHTz8f
         FL0pT8/Im1bws/+nSFJqFJWpyLEmxyf27lrD7X4z/zJABItcI66Vg4s2cneftZBU27Lw
         w9IY+di4h+XH6eYQA1eYeql8mZTnmEvjmwbDiLKQkLWDROw0m4oudbDD1l/fOf3sKszU
         zLrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783493902; x=1784098702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=++Np+i7QbYkMJq7srOxofh9iDJgIYXe+19kl+BTYoIk=;
        b=aGFnxJaGdXEJyfLtpTUdLUyJk5N1u1+P/2rw05ZGkQxpAf4VHovfLWU4yFX1+NbSOL
         3Xrw5GgaplZ7EejfyImUBK3HlufkLob2EWeBXhSJReJzoxn0u4Fc4sY+dGdknvxcN1kd
         HnzWKknFgn6Flrlbgfv+VDV9/KStwVv/DYCXQykYEmqVnmfay8q1IiTEzGWp14TWETaS
         nyQYl/bNzFUB+xUnVqX6c9TfJjRM02803DY5uRni9GWlgd0Nrl/kVM/muv31EoeGEgiv
         51T9KfK7h0to8WphUG1TG4W52LGtmtGIyrQbOLKW+rLHtCuVkMVgQ2MYvn3Ffwrr9X7h
         vZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783493902; x=1784098702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=++Np+i7QbYkMJq7srOxofh9iDJgIYXe+19kl+BTYoIk=;
        b=SEue/ND2Pk9gkJ4dtmqY4DYe/dQkR2yB33bJwXvbIoS9gT52nnxAanQOWdV8mUeFRi
         54XdiuLIYnMtDnIU8yqPDAiWubw7Tydax7hqfU6e0BxJ9k00Nsh6HPjV7AU2PabuQiIM
         DTyuwR8LI2hHhPvFHsS17Mq6tKlgrrB2DCBoLs2Ma8bvuqirP9LcSS7iHu80X3HYUgVg
         oEt9JesVYh40uPsi8bn2C8jjQyMmltBoD9SfJpgi3GFOO99UQprqZMVMYp+knIdE+Wy4
         4NYp7oyGoWhZUtI34Ymigc8nOhvrNluCgaWpGlVoA+gzRiw0qFwcuNbTRQ6IPNymEiwU
         jD0g==
X-Forwarded-Encrypted: i=1; AHgh+Ro5Sf7K1Hhcf2WUjMj7whL3YbAm6lEDCutgGtHMJzM0F8BLWt56UOWFKM02znd8q8Rn6J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKV7VCHzS2gnb8DfJKh7QfomsieqTkQZkRRzkxumCrcbITUwk
	USMw5Tdr8yiuVx1ENyClhbbz82cVFQE/geuWwu7+OVeo87tnKBHs1/VZKHNxXWfOnwX3JYO4POX
	jsOARkNnluoICh+eP+V8utddLRH8a0nI=
X-Gm-Gg: AfdE7ckWjslCPUH+ma/Bjy4xzH2jGxJoMbGnhGf3L+C/NBUnH1HjXMt3pP9ybagxUz/
	tonl3Wv7Q3mpR7cSaivx5F/BayoY9/wG2G22g+/gi48PzxPqrC7Wt3dGixBhpMC/VFlKU8ZDJ/6
	V4tPFnqJome3Og0zg9kN2vB0KLicotx1sIWqjUUiAca0iMiQANM0chdacQYnGRCwHqT/5thsWGA
	V14fRBqjdEgltNWpv4CXTVL0NeQG2rxjsodQS3nb1GltzlVUaqwaBysg7zkE0FjYS0XF016
X-Received: by 2002:a05:6a21:168b:b0:3b4:8c67:51d4 with SMTP id
 adf61e73a8af0-3c09b4ab238mr8981970637.39.1783493901839; Tue, 07 Jul 2026
 23:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org>
 <CAJM55Z-hiNDuu5UwoBe7m0wq+_WJrRY0cwopALUgpG+r3ixj8g@mail.gmail.com>
 <ajQPAk_ALP-84obp@MacBook-0RXW5> <CAJM55Z_15U7GssTOims1=J34CYSj=8CDE_di1kJYs5hE3=J53w@mail.gmail.com>
 <ajlW4oSzEqav6gxc@MacBook-0RXW5> <CAJM55Z_7N40ARWGoZg04p-NnAy-w10v4=Em-e4Bx4+oNYMGBLg@mail.gmail.com>
 <80773b89-f333-4c82-99b5-3fca44ea93b3@sifive.com> <CAJM55Z_aUzPieiGKPgr_iETovgyGB0EUFau+=tLxZksT9CkpYQ@mail.gmail.com>
 <1a9a672d-914d-43c2-b1da-6a0deede4dac@leemhuis.info>
In-Reply-To: <1a9a672d-914d-43c2-b1da-6a0deede4dac@leemhuis.info>
From: Indrek Kruusa <indrek.kruusa@gmail.com>
Date: Wed, 8 Jul 2026 09:58:08 +0300
X-Gm-Features: AVVi8CcDPihGLFO6KDd2QFz3SBo9Xu3AC0vfTDbgAUFDI1HQZllfyXn0bskFxwc
Message-ID: <CA+fTLhissp1Vrezd73iEzjrO808W1hrOF4ry-Tc0VrbqDsRKQw@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start process_srcu()
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>, Boqun Feng <boqun@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org, neeraj.iitr10@gmail.com, 
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>, 
	linux-riscv@lists.infradead.org, Sarah Emery <sarah.emery@canonical.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kontakt Thorsten Leemhuis (<regressions@leemhuis.info>) kirjutas
kuup=C3=A4eval E, 6. juuli 2026 kell 14:33:
>
> On 6/24/26 10:55, Emil Renner Berthing wrote:
> > Quoting Samuel Holland (2026-06-23 17:53:19)
> >> On 2026-06-23 4:34 AM, Emil Renner Berthing wrote:
> >>> Quoting Boqun Feng (2026-06-22 17:38:10)
> >>>> On Sat, Jun 20, 2026 at 05:25:25AM -0400, Emil Renner Berthing wrote=
:
> >>>>> Quoting Boqun Feng (2026-06-18 17:30:10)
> >>>>>> On Thu, Jun 18, 2026 at 08:11:36AM -0500, Emil Renner Berthing wro=
te:
> >>>>>>> Quoting Boqun Feng (2026-03-20 23:29:16)
> >>>>>>>> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in=
 terms
> >>>>>>>> of SRCU-fast") we switched to SRCU in BPF. However as BPF instru=
ment can
> >>>>>>>> happen basically everywhere (including where a scheduler lock is=
 held),
> >>>>>>>> call_srcu() now needs to avoid acquiring scheduler lock because
> >>>>>>>> otherwise it could cause deadlock [1]. Fix this by following wha=
t the
> >>>>>>>> previous RCU Tasks Trace did: using an irq_work to delay the que=
uing of
> >>>>>>>> the work to start process_srcu().
> >>>>>>>>
> >>>>>>>> [boqun: Apply Joel's feedback]
> >>>>>>>> [boqun: Apply Andrea's test feedback]
> >>>>>>>>
> >>>>>>>> Reported-by: Andrea Righi <arighi@nvidia.com>
> >>>>>>>> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> >>>>>>>> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace i=
n terms of SRCU-fast")
> >>>>>>>> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d960=
5b4183@nvidia.com/ [1]
> >>>>>>>> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> >>>>>>>> Tested-by: Andrea Righi <arighi@nvidia.com>
> >>>>>>>> Signed-off-by: Boqun Feng <boqun@kernel.org>
> >>>>>>>
> >>>>>>> Thanks for the patch, which is now upstream as
> >>>>>>> 7c405fb3279b ("rcu: Use an intermediate irq_work to start process=
_srcu()")
> >>>>>>>
> >>>>>>> Unfortunately it seems to halt booting on the Allwinner D1 single=
-core RISC-V
> >>>>>>> SoC both on the 7.0 and 7.1 kernels:
> >>>>>>>
> >>>>>>
> >>>>>> By "single-core", is it only one CPU in that system?
> >>>>>>
> >>>>>>> https://esmil.dk/d1-7.0.txt
> >>>>>>> https://esmil.dk/d1-7.1.txt
> >>>>>>>
> >>>>>
> >>>>> Yes, the SoC only has one CPU core capable of running Linux at leas=
t.
> >>>>>
> >>>>>> From the callstack,
> >>>>>>
> >>>>>> [  243.002818] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
> >>>>>> [  243.010681] task:kworker/0:0     state:D stack:0     pid:9     =
tgid:9     ppid:2      task_flags:0x4208060 flags:0x00000000
> >>>>>> [  243.021858] Workqueue: device_link_wq device_link_release_fn
> >>>>>> [  243.027587] Call Trace:
> >>>>>> [  243.030079] [<ffffffff80745b66>] __schedule+0x232/0x530
> >>>>>> [  243.035365] [<ffffffff80745e82>] schedule+0x1e/0x94
> >>>>>> [  243.040298] [<ffffffff8074aa7a>] schedule_timeout+0x6e/0xa8
> >>>>>> [  243.045929] [<ffffffff8004d6a0>] wakeup_preempt+0x8c/0x98
> >>>>>> [  243.051380] [<ffffffff80746aee>] wait_for_completion+0x3a/0xb0
> >>>>>> [  243.057267] [<ffffffff80087226>] __synchronize_srcu.part.0+0x4e=
/0x60
> >>>>>> [  243.063712] [<ffffffff80084414>] rcu_tasks_get_gp_data+0xc/0x10
> >>>>>> [  243.069699] [<ffffffff80490898>] device_link_release_fn+0x14/0x=
80
> >>>>>> [  243.075850] [<ffffffff8003dbd0>] process_one_work+0xf8/0x1c8
> >>>>>> [  243.081583] [<ffffffff8003e282>] worker_thread+0x11a/0x254
> >>>>>> [  243.087127] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
> >>>>>> [  243.092755] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
> >>>>>> [  243.098381] [<ffffffff8004499e>] kthread+0xbe/0xe4
> >>>>>> [  243.103231] [<ffffffff8001349e>] ret_from_fork_kernel+0x6/0xd0
> >>>>>> [  243.109127] [<ffffffff800517a8>] schedule_tail+0x8/0xac
> >>>>>> [  243.114410] [<ffffffff800448dc>] kthreads_online_cpu+0x0/0x4
> >>>>>> [  243.120121] [<ffffffff8074be0a>] ret_from_fork_kernel_asm+0x12/=
0x18
> >>>>>>
> >>>>>> I will guess for some reasons the irq_work was missed or the IPI n=
ever
> >>>>>> happened. Is it possible for you to enable trace points ipi_send_c=
pu and
> >>>>>> ipi_entry to get more information?
> >>>>>
> >>>>> I have to admit I've not used tracepoints before, but it seems like=
 only
> >>>>> ipi_send_cpu and ipi_send_cpumask is available on RISC-V.
> >>>>> I've now added trace_event=3Dipi:* and tp_printk to the command lin=
e, and this
> >>>>
> >>>> Thank you! Yeah, this is what I meant ;-)
> >>>>
> >>>>> is what I get:
> >>>>> https://esmil.dk/d1-7.0-2.txt
> >>>>>
> >>>>
> >>>>
> >>>> [    0.071132] rcu:     Max phase no-delay instances is 1000.
> >>>> [    0.077837] ipi_send_cpu: cpu=3D0 callsite=3Dirq_work_queue+0x22/=
0x4c callback=3Dsrcu_irq_work+0x0/0x58
> >>>>
> >>>> Is this the last line you can see from your (serial?) console, or we=
 are
> >>>> missing a few more lines? Maybe it'll should the same hung task
> >>>> messages?
> >>>
> >>> Yes, sorry for not being clear about that. This is the exact same bin=
ary booted
> >>> without the two extra command line parametrs:
> >>> https://esmil.dk/d1-7.0-3.txt
> >>>
> >>> But with the two parameters added the board reboots before getting to=
 the hung
> >>> task messages. The bootloader enables the watchdog, so I think what h=
appens is
> >>> that the kernel halts earlier with the tracepoints enabled, and doesn=
't get to
> >>> load the watchdog driver to keep the machine from rebooting.
> >>>
> >>> The same happens with just trace_event=3Dipi:* added, just without th=
e last
> >>> message above.
> >>>
> >>>>
> >>>> The ipi_send_cpu message means RCU was able to send an IPI, now if t=
here
> >>>> is no ipi_handler between the send and the hung task, that would mea=
n
> >>>> the IPI was missed.
> >>
> >> Assuming that your OpenSBI version is exactly v1.3 per the boot log, a=
nd not
> >> "v1.3 + patches", then you would indeed not be receiving IPIs. You nee=
d at least
> >> this commit: https://github.com/riscv-software-src/opensbi/commit/446f=
a65eb579
> >> (included in v1.4) or alternatively to add the CLINT to the M-mode dev=
icetree.
> >
> > So then we're in a situation similar to [1], where upgrading the kernel=
 from
> > 6.19 to 7.0 requires you to update the firmware first.
>
> Which normally should never happen to ensure users feel save to update
> the kernel. But I wonder if that is relevant, as Indrek Kruusa reported
> problems with that board, too -- and there is a fix that fixes it:
> https://lore.kernel.org/linux-riscv/20260624220434.4183732-1-felixonmars@=
archlinux.org/
>
> Does that maybe fix your problem, too (even if it was bisected to a
> different commit, it might be related somehow, that's why I'm asking)?
>
> Ciao, Thorsten
>

I tend to think we have two different situations here. I am using
newer OpenSBI (v1.8) and an experimental u-boot based on newer
v2026.07-rc1 [1].
So, my firmware is different, also the context Emil is pointing to is diffe=
rent.

Best regards,
Indrek

[1] https://github.com/ikruusa/u-boot/tree/v2026-07-rc1-thead-base-b1


> > To me and from the thread
> > that seems like a really obvious regression. So the question is, how ca=
n we make
> > the current kernel work like < 7.0 kernels worked?
> >
> > [1]: https://lore.kernel.org/all/87jzgjnh9z.ffs@tglx/#t
>
>
