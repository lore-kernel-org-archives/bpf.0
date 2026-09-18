Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7588E4A5EB9
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736040; cv=pass; b=k82XqLlj7UTjZrmoZFX+dahJRWfEpUsjEByNl2uipJk9gs7AGg7KbCUwbQlCx5GDx7yVT6ATy4n/htWNaz5Cmc/MaTWmndebNE1nJ8mMbK3oIQ/9xpeQexWdf+8O/JBdmobnq6rW3j5q0N+So4ATD3bmtaBsYoeGKLUjgChVxdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736040; c=relaxed/simple;
	bh=g0xGWJcbRsZZHFalhoUE0XSvg2wVGfujRaCvlxyJNMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uK/YlxeOTrjJ2p2OWpLwC9jv9V7m2jShGoAEX4X2tQHzkHb5hvZ5ll6ooH2WaiwabPoLeZqmsjmtVYVZjRoFa72Uyi6RIYAH8klAkFWXurg9vN5UmAMKSQMbjR9ccW+w7/dtkqIcrLDqywo4D4uNDfc7o7Y3kgt3/L5XF2oqgeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M934UzvJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/RA79pt; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M934UzvJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/RA79pt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789736034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUqRO/qJNQsB7yIcuX23hH9gNKvjys5G72B/a/hJXMQ=;
	b=M934UzvJvVd/m9CRXzdopI2C9kNfHcUNtXYIeUAnXWw+Ie+bqCriJEASYzt+zJoikp0237
	wGGEn7ts4dQSSlM4kK2soqRids5MIs/NJVEfq9XidelhJIv1l7BsZuFily8QlwGImYwDz0
	Fcd8+rxnkNHWMbXU+QY3V1REDdSt2IA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-jdtXmBPpPHGRsCBlOZl6ZA-1; Fri, 18 Sep 2026 08:53:52 -0400
X-MC-Unique: jdtXmBPpPHGRsCBlOZl6ZA-1
X-Mimecast-MFC-AGG-ID: jdtXmBPpPHGRsCBlOZl6ZA_1789736020
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c29476212f1so67929066b.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789736020; cv=none;
        d=google.com; s=arc-20260327;
        b=DSDOf+Hxv8lAnU1sxkaNnNkk6OOXuLqeUjD8Tg0lvgULDOPpOV5cHKaOZ//PkygAqw
         YjhA9oL7DIjsEc/mIlsjGBzFntk5d4aVQaV2JCCoA+GuOF+vxm8hnI1rbA2ah7WOIzsA
         v9KGxEwGvLqN0UE9jXvKKRc3OjDB8oy5J0qJRAcatZ6mGsiTeELAGsO1+ikDoH40QhVC
         YHbz+YwplbC1OTX8uL3CPq8VhpiO35PpL3zLtbp4Gei4aEjkbvjsSYH5athxfq/Fg0fv
         WicuP0dkXxa7bnnZuvGOD5+Gy7OgCz7aE9liULGRz9BBdixYBelJlXcz2NoW2zLVHBtt
         o07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gUqRO/qJNQsB7yIcuX23hH9gNKvjys5G72B/a/hJXMQ=;
        fh=R9/1TSZRPX8mFngPa4hjLM4rQLcnbwgwQerDQ28VcAY=;
        b=mxUZeUtHHCI6lOlSo7vNpRrkDOZiDvIFxmODZ3//xlU8c9x4XBJ2pqLaJ8khohbst4
         8IbC3t1sZhFS4tiCYmKVuwMHKX1xWpyT/IGzD+LtTNB/YtmIMqTkHhlC7PQBrImf2tHM
         K2y+voXUfN+jz/SYEW4x587fmu4JqR8LKGFmcHs9QyAFoUqKC4xKVRQ/20+A5AEAx7qt
         Xemj7N5KFUG0Y73ye/wab6PVEUZVYNETolMnkX5mQmOXOMRRD1RPyE5uE8/qiO68DcSH
         1Gs2+Ib7l2x5akZAE1tI7taXmo3soevWeEGZEMN8MhIVxLbNnfsdqaSQbtIyTaQjrhsa
         AUfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789736020; x=1790340820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gUqRO/qJNQsB7yIcuX23hH9gNKvjys5G72B/a/hJXMQ=;
        b=G/RA79ptIDz10TF2iX1NuNWqiTWEGstQD1pueo7dFpL0qycE1+rNrbHyJ4KGCF4Q0M
         9ESLDmv/CV+vDQQvid5mG1zmy/L7xTerfBUCtDrl3nA+H21sRa8/jeEpYJIIPlJLQNPh
         YQkS7G3EvhCL80wkxkikI5C7/xR6NnJH2fGxYqDw79rMIy3Olr4NsbwhcbMuy3bJy8nl
         XZZWiTTrDJ34qSkve+Qb4juisSqcy4c7WNLRdDwYtF1IPGEAbAEfFLNWg80j4Uk2JpiE
         Ln9602FD/K8VcmowfEu2uxPYXPFZoDccltb+6LIHge/TbW6ufMbUb+8+cDMTzdyq5v0l
         2MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736020; x=1790340820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gUqRO/qJNQsB7yIcuX23hH9gNKvjys5G72B/a/hJXMQ=;
        b=HcyN/XPzXTDwq2cEp1ZZDtjLm00U24WhDnwNxBGpKoVDvzQMeiVC0ZPNZDty3+EJNC
         pGgdY6QZ4V3NPqzniCETUyGyNeIwimVUAzof8KSH8ZWZMUCeC+aZcT0Y6cctNvRMLTdl
         Wm5dFa1N9mnQbixmfVDp70FzdM5nwBbrl+f+ZjfSuu3StHNEXIRzEUqzpO2a7ouUCiae
         VCB2VU5rfaYzWRu/oMt4BQghpAKouq4yOViYMNkp+jjtThC2KXVhmBXxlFPFGtCEbUtX
         iYWYI0n7aNQ6hGJYyxlaX5qqOa4Pc3fkAz3Srj34zxcgAuEhLPFYQt18M+r6IhqOT8nS
         aSYw==
X-Forwarded-Encrypted: i=1; AKwUvBz5979Qzxk6hIKICDqDycgFMReeze+VHuzQwJ5GrmWRWUhsfxZMGS9y0HrloTfMnYBViJw=@vger.kernel.org
X-Gm-Message-State: AFuF++mdVjPf8ZJD6VvV57yA1W8tz5LzWZ5gFsZa+ywyxbJqMfSbZHFe
	ZUG4z0yj8ptYKhne8DZeaVnYn6iLRskRjw73+DzhwaK4OXjDSp9pv59Ts4kNVCCxYwydh8DQysv
	shKI3VRsY2L83/hCtiNYNy7qjXxf50NirJ+LgbiMEEcCBKBUmo2BbdqLx/09EBL1qwLUAH18V3K
	Q8U0DRB5sJ2+WL2os67yA4lLd29CS4
X-Gm-Gg: AYBFou38STMkknQTAW5SGg7MPGc7fKjLeUzn++o/RfPg6RdbRuNyG3ZRo05b0Ys+IHS
	W0lIBjb/G0X4H1P8F5Tni1LgGdAh6WDLQFPf6Lg2kATI4YZHOCV22BhqJOfmqDo26MVgvYJlzXv
	MW/47E9RWux058VPX0ZaFsbJWCP+TYq6nC8VGHfzAyMf+aTiJck7vBsmxnOWyMG+qxN6ry6fbH0
	Tu5JvRqyb3wGDRHUGY6m09fOP33x9v3LsXg7g4VDYJ6nB79Mm7hMD8TbvEQ4l3ts5p0qtp2eZ6H
	rV8=
X-Received: by 2002:a17:907:72cc:b0:c25:8c74:71e6 with SMTP id a640c23a62f3a-c2a1569a530mr277250166b.10.1789736020297;
        Fri, 18 Sep 2026 05:53:40 -0700 (PDT)
X-Received: by 2002:a17:907:72cc:b0:c25:8c74:71e6 with SMTP id
 a640c23a62f3a-c2a1569a530mr277247366b.10.1789736019888; Fri, 18 Sep 2026
 05:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ff563467-0bab-43ec-a46c-a4167bc12473@linux.ibm.com>
 <73701ffd-213e-4842-8b40-f719c1eeaed4@iogearbox.net> <1a0b01e5cd8.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <1a0b021e330.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com> <D5655235-89A8-43EF-8DC4-9DCE6FBC387C@linux.ibm.com>
In-Reply-To: <D5655235-89A8-43EF-8DC4-9DCE6FBC387C@linux.ibm.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 18 Sep 2026 09:53:28 -0300
X-Gm-Features: AcwNN1WCd2sEcqEKVCjkhdhtXdMEs14eyYo-vHbnVxc45osvsgf1ffcS0sP15O8
Message-ID: <CAABTaaB4j+Gr2-7vti6unCqKoRfYa9Cs22NH3HpxJo14r5jKcA@mail.gmail.com>
Subject: Re: [BUG] audit/powerpc: WARNING at kernel/auditsc.c:1995
 (__audit_syscall_entry) during BPF kselftests (test_progs)
To: Venkat <venkat88@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, audit@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Ritesh Harjani <riteshh@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, 
	Saket Kumar Bhaskar <skb99@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, andrii@kernel.org, Eduard Zingerman <eddyz87@gmail.com>, 
	yonghong.song@linux.dev, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 4:42=E2=80=AFAM Venkat <venkat88@linux.ibm.com> wro=
te:
>
> Hi Daniel, Paul
>
> Hope all is well with your family, Paul, please take care.
>
> > On 17 Sep 2026, at 9:40=E2=80=AFPM, Paul Moore <paul@paul-moore.com> wr=
ote:
> >
> > [NOTE: correcting the audit mailing list address to audit@vger ...]
> >
> > On September 17, 2026 12:06:18 PM Paul Moore <paul@paul-moore.com> wrot=
e:
> >> On September 17, 2026 10:03:59 AM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
> >>> Hi Venkat,
> >>>
> >>> On 9/17/26 3:01 PM, Venkat Rao Bagalkote wrote:
> >>>> Hi all,
> >>>>
> >>>> IBM CI has reported a kernel warning triggered in __audit_syscall_en=
try()
> >>>> on a PowerPC 64 (ppc64le, POWER9 pSeries guest) system while running=
 the
> >>>> BPF kselftest suite (test_progs).
> >>>>
> >>>> Environment:
> >>>>
> >>>>
> >>>> Kernel version: 7.3.0-rc3-g238650ef6c7c (PREEMPT)
> >>>> Architecture: ppc64le (POWER9 - IBM,8375-42A pSeries / phyp)
> >>>> Workload: BPF selftests (tools/testing/selftests/bpf/test_progs)
> >>>>
> >>>>
> >>>> Problem Description:
> >>>>
> >>>>
> >>>> During syscall entry processing (system_call_exception ->
> >>>> syscall_enter_audit -> __audit_syscall_entry), the kernel hit
> >>>> WARN_ON(context->context !=3D AUDIT_CTX_UNUSED) at kernel/auditsc.c:=
1995,
> >>>> indicating that the task's audit context was not reset to AUDIT_CTX_=
UNUSED
> >>>> prior to entering the new syscall.
> >>>
> >>> Hm, based on the trace feels somewhat unrelated to bpf, but were you =
able
> >>> to bisect in
> >>> case it can be reliably reproduced? Which tree is this, linux-next or
> >>> bpf/bpf-next?
>
> This was tested on the mainline Linux tree (Linus' tree, commit 238650ef6=
c7c).
>
> Regarding bisection and reproducibility: the warning does not reproduce w=
hen running individual tests in isolation (e.g. running kfunc_module_order =
alone is clean). It is only observed intermittently during the full BPF sel=
ftests suite run (test_progs / test_progs-no_alu32), so I haven't been able=
 to bisect it to a specific commit yet.
>
> >>
> >> Thanks for the report Venkat.
> >>
> >> Unfortunately due to some unexpected family medical issues I'm not abl=
e to
> >> look into this very closely at the moment (triaging mail on my phone),=
 but
> >> the related audit code has been fairly stable lately so it seems a bit=
 odd.
> >>
> >> I do know that Thomas Gleixner (CC'd) did some work recently on the sy=
scall
> >> entry code (audit related commit below), perhaps that may be a place t=
o start?
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D6f25517010ddd3f8080d7e06b9b1cb1b64b73772
> >>
> >> FWIW, I haven't seen this in any of my testing on x86 or ARM, have you=
 seen
> >> this on other arches besides Power? Also, as Daniel already mentioned,=
 more
> >> information on the tree would be helpful.
>
> We have only tested and observed this on PowerPC (ppc64le, POWER9 pSeries=
 guest).
>
> Attached is the .config file.
>
>
> Regards,
> Venkat.
> >>
> >> While I don't have access to a Power system, I'm CC'ing Ricardo Robain=
a who
> >> also works at IBM/RH and has experience with the audit kernel code. If=
 this
> >> appears to be specific to Power, he might be a good resource to help
> >> diagnose and develop a patch.
> >>
> >>>
> >>>> Trace:
> >>>>
> >>>>
> >>>> [ 1371.387510] ------------[ cut here ]------------
> >>>> [ 1371.387528] WARNING: kernel/auditsc.c:1995 at
> >>>> __audit_syscall_entry+0x50/0x1b0, CPU#17: test_progs/49616
> >>>> [ 1371.387539] Modules linked in: dm_verity(E) dm_bufio(E) reed_solo=
mon(E)
> >>>> livepatch_sample(EK) tun(E) vrf(E) 8021q(E) garp(E) mrp(E) stp(E) ll=
c(E)
> >>>> veth(E) bonding(E) tls(E) rfkill(E) nft_fib_inet(E) nft_fib_ipv4(E)
> >>>> nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E)
> >>>> nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) hvcs(E)
> >>>> hvcserver(E) pseries_rng(E) vmx_crypto(E) sg(E) drm(E) fuse(E)
> >>>> drm_panel_orientation_quirks(E) xfs(E) sr_mod(E) nvme_tcp(E) sd_mod(=
E)
> >>>> cdrom(E) nvme_fabrics(E) nvme_core(E) ibmvscsi(E) ibmveth(E)
> >>>> scsi_transport_srp(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mo=
d(E)
> >>>> [last unloaded: bpf_test_modorder_x(OE)]
> >>>> [ 1371.387607] CPU: 17 UID: 0 PID: 49616 Comm: test_progs Tainted: G
> >>>> OE K     7.3.0-rc3-g238650ef6c7c #1 PREEMPT
> >>>> [ 1371.387616] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [K]=
=3DLIVEPATCH
> >>>> [ 1371.387620] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e=
0202
> >>>> 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
> >>>> [ 1371.387626] NIP:  c0000000003e70d0 LR: c000000000352080 CTR:
> >>>> c00000000000cf00
> >>>> [ 1371.387631] REGS: c00000000beafaa0 TRAP: 0700   Tainted: G      O=
E K
> >>>> (7.3.0-rc3-g238650ef6c7c)
> >>>> [ 1371.387637] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 48=
002824
> >>>> XER: 20040084
> >>>> [ 1371.387650] CFAR: c00000000035207c IRQMASK: 0
> >>>>      GPR00: c000000000034958 c00000000beafd40 c0000000020eb200 c0000=
000345f4800
> >>>>      GPR04: 00007fffe2a31184 0000000000000081 000000007fffffff 00000=
00000000000
> >>>>      GPR08: 0000000000000000 0000000000000001 0000000000000001 00000=
000000000dd
> >>>>      GPR12: 0000000000000000 c00000002e99b300 0000000000000000 00000=
00000000000
> >>>>      GPR16: 0000000000000000 0000000000000000 0000000000000000 00000=
00000000000
> >>>>      GPR20: 0000000000000000 0000000000000000 0000000000000000 00000=
00000000000
> >>>>      GPR24: 0000000000000000 0000000000000000 0000000000000000 c0000=
000345f4800
> >>>>      GPR28: 0000000000000000 00000000000000dd 00000000000000dd c0000=
00138e0c000
> >>>> [ 1371.387710] NIP [c0000000003e70d0] __audit_syscall_entry+0x50/0x1=
b0
> >>>> [ 1371.387715] LR [c000000000352080] syscall_enter_audit+0x90/0xd0
> >>>> [ 1371.387722] Call Trace:
> >>>> [ 1371.387725] [c00000000beafd40] [c000000000937050]
> >>>> selinux_task_getpgid+0x80/0xa0 (unreliable)
> >>>> [ 1371.387735] [c00000000beafda0] [c00000000beafde0] 0xc00000000beaf=
de0
> >>>> [ 1371.387741] [c00000000beafe00] [c000000000034958]
> >>>> system_call_exception+0x448/0x480
> >>>> [ 1371.387749] [c00000000beafe50] [c00000000000d05c]
> >>>> system_call_vectored_common+0x15c/0x2ec
> >>>> [ 1371.387757] ---- interrupt: 3000 at 0x7fffab74cbf0
> >>>>
> >>>>
> >>>> Please let me know if additional logs, config, or repro details are =
needed.
> >>>>
> >>>> Regards,
> >>>>
> >>>> Venkat.
> >
> > --
> > paul-moore.com
> >
> >
> >
>
Hello eveyone!

Thanks for looping me in, Paul and for sharing more details, Venkat.

At first glance it seems that the audit_context, for some reason, has
not been cleared. I'll reserve a ppc64le machine and look into this
over the next week.

-Ricardo

