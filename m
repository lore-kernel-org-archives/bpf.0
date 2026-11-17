Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794946543;
	b=1fAZYtnZe02UVBjuNUEtaU4bBYSpHGSPc1ZtzyUzdKRpjj5vjHPLD0TURLOWluhNS5S/
	 2uF8PJTpG7xSV3PkVykwbpzTK5LZ9ANouiKxt86R0ckGOqPLBFpMdTusED303tSbi/KnH
	 VSQBgAU3sF5f0o9snHD3ltk+CeXzqZ1KT8Q+uKbIxVzL83Z5DNjr3VzrtO1GezvM6Rt/A
	 dvdDFAyr2n5DPC/lATqbSMsK2K0bX5j8WccrSdWptgf1SbnNZQstEaNU92i5zXnllEPmj
	 Wyud7sv7+FxAzSknRx1Xvgtrx8ZBygSNXmKERbIYk8z0y67aG8E3BWK9T11y541ZgRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=clPNgZkjmWsVADufLQtasEEbh+a/M/KW3hZCKiraLcY=;
	b=1yHJ9eJ8tuDHATu8ISs+oyTzh3mz5f6PeLi02nyS/8mZFAiI0keLXoXqdW/WCep2NrmJ
	 Wsffrq6mTpMAuUiFVbokbuiNZWlzsqiIKW+bcYEvxNga4hCLNlE7aniB/5TJxbtZf7P6N
	 cWHTk4vNOZhS55/qvLC1OBvAN1rmui6OcUR+jgFg5VuVRK27+Mgd7IL2wTaE/LuSpmjjH
	 AOhJJVbkuXWjwH+1jeEtEnhjRAOIWmawrqpgfhMDPnpjibX4xBoaJdzTfNedP1x/fpTQK
	 lGu6bkXrU+u4rga4WezSoWqggLgd8flnBRy/c5oDXjrSgHYzsEFsA0543n/TKxrvPHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=scarletmail.rutgers.edu;
	spf=pass smtp.mailfrom=scarletmail.rutgers.edu;
	dkim=pass header.d=scarletmail.rutgers.edu header.i=@scarletmail.rutgers.edu header.a=rsa-sha256 header.s=google-20180529 header.b=S6Orh83Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4C4606A334
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 20:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF4C4606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=scarletmail.rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scarletmail.rutgers.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scarletmail.rutgers.edu header.i=@scarletmail.rutgers.edu header.a=rsa-sha256 header.s=google-20180529 header.b=S6Orh83Y
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91f0ab17747so943766d6.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:15:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794946542; cv=none;
        d=google.com; s=arc-20260327;
        b=H10t0rYKF3R1pcDmv/CMah7cddW37oEn0FytQ1bF6/A3dMPTMvqSd4+7zsP0P7gw4D
         kNb2M7iRZHFBK51CVYQXJqhB7G1qDum5XLyILaC3mZWZAh9/pBrKLAw51jwl9YSpNl80
         IPhyhGryQIdTVc6Tst4WeULjRJbeeGoG5W3O5RLsUpISqbsLalg+g/8z6zEezvgYq2EX
         7ThOnzSs+q1tKnniT6pPH98TpNW66pkd3+RrJSp3Gr5tbl5G9YLyxyjY+z0Jm3XEfcAe
         7QK4UC3PSBjK/HgpYpBQ48vDCukgoxd0xDH0z+SGmp5c51ZjkNzhXKvJZYU3rTct0kNV
         3jug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=clPNgZkjmWsVADufLQtasEEbh+a/M/KW3hZCKiraLcY=;
        fh=DqhOB8lQHxI3q6wYNOr6LHF8yQPDnI9XYsvS0GgV9Yo=;
        b=s29tSjBCwA5GS8hKYJ0GZTWxgME5cKPDM3z0rbnJjzpGG5zJMUYvzWaS8rEPvnfDry
         uPUqX1/uPFFQSkaKrlCj3zFGkvjzB1cDQssnL/6+shMWe7PM9oHtrGTbZ0/x/4fbPLLF
         ZHJMhfUBKgy6Imu80V5erdSxdoc8CaKeImCDa469uuoN6KICj4SisGDuJtuAPdmt8SlU
         O+Gd5D/XmwKi8IGzsHDKUXNvawHU/F5s2ooLqptusgL6LaQ3GYgWDzHNwJwZlnPpfBt6
         5VPnxHPnspw52dN6wKidfLSPXsRoCnTp7XqugXgziN67PFsu1sAXx9AJ3JY4G8IQXrUg
         PAlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scarletmail.rutgers.edu; s=google-20180529; t=1794946542; x=1795551342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=clPNgZkjmWsVADufLQtasEEbh+a/M/KW3hZCKiraLcY=;
        b=S6Orh83YUoWfTJfzhZC5Fe8mDR1kYWjZKS87rws1VYLwltuIZ3U6Dl6ThubN1SSMO4
         7ecH+ryBc7IxCR4WPuGGIuPfZyxfeDHgWmiXImzGe62BrZUJAJAOCqY9Fg3oLV0D+QSy
         v6in9gNPO4EnXzcFe7HSlBdGQpFaacyzhVZvZ9aC/NcYfM1lGuGVmbSQn4oK6PIDygch
         CQI1xsWPyHXcpF4Utq69MZQb6ZIui+XfaUENuzgjsxKLaNLI0OPTPBHEUJL28BWn+AOR
         a6RQfsk7Ab2MgzuvVa+N6XWqMi19Rn/AN4Jd0yFqQB0BXyaDnKAmvbU1prrjqufmJi+w
         iJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946542; x=1795551342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clPNgZkjmWsVADufLQtasEEbh+a/M/KW3hZCKiraLcY=;
        b=osWhwjWRvbXNM/JBkIaQmCDCJmiHpbDEjYTLaukCk+yEHFKYf/HamwlH1a83/UOcAn
         AyKMfN1XTIUkNMlnvUte95t/A7WPm4OjwLY6IkhY2Afceilh8bbZPJde4+utb+K085U9
         BCKWLTxPp/dmUs7BPETyv6VmSYo5obqWez+nhAjAUeHxHIH4YN+t2jxMphFO+NapYH2V
         wdrNfZyd8rzm+pa9AAvZt+6zvfU5DZNfIaH98F4VKoAtgGg4LDUZMf3vX5JbpE1a/1kN
         PMolnPwbXDb+bVXrsqziHPdqTVGvle+qRiBF7cUF4cQgM3f+iqQuUmV6c37PTve+zaaT
         ooiA==
X-Gm-Message-State: APuU4Z9ZOR+IXkmZZPsg3fEhJMca7Ci25ck4VIGP5pUSvCwn4Hm0JLOR
	cWzReumPm6ZRXEY5yamksg1AHQ2sdp13RvyDfHyLEM8Dm0z/CsMQUOTNdJ4ZDWBXZqrNX5/dduz
	2tJz3nOdMYXD/c+Ljlx5hzHAGZquEzN2jS62Dtae3xQ==
X-Gm-Gg: AZFdTZfg6zQgqBL4+QyCepuSLu1DwheAgBu8ax/Tslq6mg7Th0XzKvxCrVE9PD9VRLz
	TUbtaVJWR5LbIXACSjLm/4ZhWtBETHjQG9mO3UonvRuyahe89v+WzCB/stkv2Naa/0BGwcfDqax
	ZjHJEhx666neOOySLBO5UJJTgsVTo6x8cMaQs9j/1DyEuFa2THfjE1LrlhYE4lr+2x58EdoYXAU
	cMZ+7zPagYLf/JjrUqWUkhwl1Hu12mur+wPwpvQN6YxR9kw8LOAf7/CXThSBhd5rkm0G765yPqx
	h+lptAZOIWkqsMviiQ1xz7npeRRc6WVUlxVTqi6yIg/+HT633KOajWjZ8eu9kyGzL8dMjk4E/4I
	N8RYAHb8Uy9FVeCeNXkqdJ+D11Z3VhDe44AOVtP9oxFcaiYFodb5Bw6yl4jra3oCXO878gSw=
X-Received: by 2002:a05:6214:310c:b0:91f:280c:d44a with SMTP id
 6a1803df08f44-92114d3f1ffmr5431436d6.8.1794946541245; Tue, 17 Nov 2026
 12:15:41 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAPUfTJOD==vidMeytY5vo4h2qZPdM=n5CRUtJttZ5N4oD6Fo1A@mail.gmail.com>
 <CAP01T74NiVAzW_vczZaOSniFh+=ddta2ThbXM_NB+mtv82pGaQ@mail.gmail.com> <CAP01T75djbZ4vzwbHMV3sfKa+tScqQqiOfAHDbRAaW48J7DMQg@mail.gmail.com>
In-Reply-To: <CAP01T75djbZ4vzwbHMV3sfKa+tScqQqiOfAHDbRAaW48J7DMQg@mail.gmail.com>
From: Yalu Cai <yc1795@scarletmail.rutgers.edu>
Date: Tue, 17 Nov 2026 15:15:30 -0500
X-Gm-Features: Aa3M54rf4_Kd5oXvU0mymC6UgxXCspJtvYK4rjCQG8EWb66TIvz1neycRGaH13E
Message-ID: <CAPUfTJPSWTZuM0oiBSs0uf-C6LLxtoOyqGp1YaXrshFq85fzQQ@mail.gmail.com>
Subject: Re: tracing progs can take a bpf_spin_lock in an inner map -> NMI deadlock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, santosh.nagarakatte@cs.rutgers.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sounds good! We will work on this and the other bugs we reported today.

On Tue, Nov 17, 2026 at 3:06=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 17 Nov 2026 at 21:02, Kumar Kartikeya Dwivedi <memxor@gmail.com> =
wrote:
> >
> > On Tue, 17 Nov 2026 at 20:50, Yalu Cai <yc1795@scarletmail.rutgers.edu>=
 wrote:
> > >
> > > Hi,
> > >
> > > As part of a research project, we have been trying to formally verify
> > > parts of the eBPF verifier. We found a bug that deadlocks the machine=
.
> > > Below is the concrete description of the bug:
> > >
> > > A perf_event program can take a bpf_spin_lock in a map-in-map's inner=
 map,
> > > even though the verifier rejects the same lock in a directly referenc=
ed map.
> > > bpf_spin_lock disables IRQs but not NMIs (local_irq_save()). A cycles=
 NMI can
> > > interrupt the lock holder on the same CPU and spin forever.
> > > Reproduced on 7.4-rc3 and bpf-next (ea80d2afd285), x86_64.
> > >
> > > check_map_prog_compatibility() rejects a bpf_spin_lock in a tracing p=
rogram.
> > >
> > > if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
> > > if (is_tracing_prog_type(prog_type)) {
> > > verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
> > > return -EINVAL;
> > >
> > > This check only sees maps referenced directly by the program. It runs=
 from
> > > __add_used_map() while resolving pseudo_ldimm64 references. The inner=
 map of
> > > an ARRAY_OF_MAPS or HASH_OF_MAPS is not on this path. A lookup throug=
h the
> > > outer map gets the inner-map metadata from inner_map_meta, so the che=
ck never
> > > examines the inner map. A perf_event program can therefore lock it.
> > >
> > > The reproducer has two programs sharing one inner map:
> > >
> > >   - hold_lock, SEC("tc"), takes inner0's lock directly in a loop unde=
r
> > >     BPF_PROG_TEST_RUN.
> > >   - lock_inner_nmi, SEC("perf_event") on PERF_COUNT_HW_CPU_CYCLES on =
every
> > >     CPU, reaches the same lock through the ARRAY_OF_MAPS and takes it=
.
> > >
> > > With the lock in a plain array, the perf_event program is rejected. T=
hrough
> > > the map-in-map, it is accepted. Either program runs alone, but togeth=
er
> > > they deadlock the machine.
> > >
> > > There is no console output. On a 4-CPU QEMU guest, the monitor shows =
all four
> > > vCPUs stuck in the same lock path:
> > >
> > > __pv_queued_spin_lock_slowpath
> > > __bpf_spin_lock_irqsave
> > > bpf_spin_lock
> > > bpf_prog_...lock_inner_nmi
> > > __perf_event_overflow
> > > perf_event_overflow
> > > handle_pmi_common
> > >
> > > It needs a PMU that delivers cycles NMIs (kvm -cpu host here). Loadin=
g the
> > > programs requires CAP_BPF and CAP_PERFMON.
> > >
> > > The inner-map lock was enabled by b7ff97925b55 ("bpf: Allow locking
> > > bpf_spin_lock in inner map values", 2022), without carrying over the
> > > program-type restriction.
> > >
> > > The program-type check needs to cover the inner map when a map-in-map=
 is
> > > used.
> >
> > Thanks for the report. We are planning to make some changes to allow
> > aborting a program at any point. Once that is in, a follow up will be
> > to rewrite bpf_spin_lock(...) as follows:
> >
> > unsigned flags; // extra 8 bytes on stack inserted by verifier
> > if (bpf_res_spin_lock(&lock, &flags)) bpf_throw(...); // abort if
> > deadlock is detected
> >
> > Then we can fix this and remove the restriction on calling
> > bpf_spin_lock() from anywhere. If a user needs to handle AA deadlocks
> > etc. they can use the kfunc that returns an error instead and handle
> > it in the program.
>
> In the mean time, it might still make sense to fix this, so like the
> other one, it would be useful to send a fix + test, which passes in
> absence of the fix and fails with the fix present.
>
> >
> > >
> > > Thanks,
> > > Yalu Cai
