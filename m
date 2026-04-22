Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E319D08F
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776882430; cv=none; b=PRjMMe7v0a50+r7EBq8K6JJL6yKSnMUi4uD0yAMFWqCpdIRHpoYjh8ya2gLEBYvu7zr3Rbw7xAeIdTZzVNOdb12+bc9chTU9uDBOT8w6+R1OoP86iIEY5nHi+lHlYEwLYOf1+LFzDZNdlnAU5rgMXGJaAB55u0pn/JGSs5OzdHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776882430; c=relaxed/simple;
	bh=5i2jgyn8+H5ItIPYGOriTgiCq7SJQy/IXEUyM2QB4jM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rl3YKlK6JOLZ0HNTOeNXac6s+NhvtEEY3ptQgPLpH9YUscL1q++e5Q1X1iqhRHZTw+m+PSk6jL5aet0OkPucDj7bHm9NmX1SpeOqDR4LTvfjPFOpxOagix/QOMwTfFniEGPtXcLB7I2jYCZUhHM8gEKexBxRk6w/ppbE42VUKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxPh8xoj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxPh8xoj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so35415135e9.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 11:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776882428; x=1777487228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rdg/mBlGSjdjcInWkDl20JbJcnIqcRiqtUPqMFTsdAA=;
        b=KxPh8xojKBYd+aJlssysA1fJJikBC0ku9MBdi4RV9cNIqLhQYxnE7b7+GoptdPFUvS
         n7GXRnXJzv5DcOf3AYSoMAub5JNyVP8U3HisO0TrzqqdIKw1KFCcdN7agu9OJ2YQBiXu
         ahBJ5uLDlvtV6T98nJh5NINohMUnh9nMzV30jEow12MugyNpOeNtheg2ViDsvaXt56ub
         s5su9L8jNhYwaAFsOMF9GZTC1zvv/PHCcm2ezKjADlqp+FlKunLZcX0bxVb9fpV+JfLD
         YqXLlM3xW67aZRgXgIgkw9dxOsv0JjaOaUM5t8GiFOqaRKxX2Z2RzvRb/eBriHv0B51l
         TXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776882428; x=1777487228;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rdg/mBlGSjdjcInWkDl20JbJcnIqcRiqtUPqMFTsdAA=;
        b=dxA/XBBnBlx5AcIKOatuA2qJs2AAEYc8Ld7X3V/U84NnWSBf/rU+H0gNgx22QTHaBq
         ZutNm1dN8M64XpHHjPwHR2gdMmdaViZRqUKDxvuqC8sye/GJeiOam6EDjhcWbKf1vdfJ
         x9xe6L4JWhqKKaThfJo1ISySOKbWz+SIXVRsJ4G1fhcJpKrkQdQnVoke5DTqWErP+Hwo
         cCTB+90us3EmWJaae3eKYU/dp91PcdLzJRb6TSbHoFSkCDYxfN3SNoHt1fnloh6ROC5h
         8QupdgYLcRq0BqkIJiRHuzy+MtssiR5kxreO3pgvpYN82QqDN2Nxr53dCU/mkEy7aQDY
         HzVg==
X-Forwarded-Encrypted: i=1; AFNElJ/++ilYLWH8yzK11tqMW5YeFsjrS5nOknaoBNrLRe5KfGSL/0LQVtXmq509utXpuahd7Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykQ7hFI6b9G/MauAN4i13Ms4xLLcYVDZd6IUYGRHkuWidYwfjs
	i5hXeqKJFxJ6v0PUGo6Bjy0j2pKMn02zeNwgtrtIkI5Z4qHNgjdcZmwV
X-Gm-Gg: AeBDieudMQY7Q7/Ky6eVppt3tMeEn2bi1QdAAXQOsBn1vtHP3qKBDCKkIl8sDjR/CrK
	VcOgmxcc9UlTrrm9hCZ1eUAxzQqPFt6XJNO5ylHTT8DD6YIJVl9iSB4KtMixu6/CF8vVkZjJw0z
	rmbDvWjlH6kxrYCFwOM8KFRnUg7F1UcKcxr9FOqEnljoSDdtQAbvWNpsQw/8y+E5H3qSagBrIO4
	Z7dluOvBRVLlAdfmNIu+CFAmOmshWjYWz6xQ3uzlIf5nYxwZWPB7iVUs4xyRhtHve1wYi7XIvXg
	QTJ6EDq+Jd/YJkvZ+6vcTv5SGU7Ofzh35SavDcljw60cL2bsBQG5ZS15pD4aqjD1vpNFZuRxIUE
	4UOflSJWDE871gkIR5tu08Daz1TBz4ePWVaB/0m23QRjNt4ffH5KktBT68rj/E0olVa17tqYFVr
	Vjr5jfYtCgf35jZ8k+2fYgxy6WJA==
X-Received: by 2002:a05:600c:3b14:b0:48a:52d9:54ab with SMTP id 5b1f17b1804b1-48a52d95604mr170394485e9.30.1776882427271;
        Wed, 22 Apr 2026 11:27:07 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:1502])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc177dafsm567810855e9.4.2026.04.22.11.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:27:06 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, Kernel Team
 <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Mykyta
 Yatsenko <yatsenko@meta.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>
Subject: Re: [PATCH bpf-next v12 2/6] bpf: Add bpf_prog_run_array_sleepable()
In-Reply-To: <CAP01T76iSk-nBUsjpD2QEZWme+crwD9W1_A-=EQSgrLq9x8jZA@mail.gmail.com>
References: <20260422-sleepable_tracepoints-v12-2-744bf0e3b311@meta.com>
 <e93b3ecc3e3406ac70466f8083544d896295f6fbb3f07c8e5a059fa25f8f19b2@mail.kernel.org>
 <5e93b4e4-12db-454f-b900-68ebad02ba5b@gmail.com>
 <CAADnVQLBk8oARVE9vZoM8Cabtov3RVr3Ezp3tG3NahoU5=6ktQ@mail.gmail.com>
 <CAP01T76Ck1u5Cj-H81ipWvMXy=O=MzZk14cMZzTOL4YK=38EeA@mail.gmail.com>
 <CAP01T76iSk-nBUsjpD2QEZWme+crwD9W1_A-=EQSgrLq9x8jZA@mail.gmail.com>
Date: Wed, 22 Apr 2026 19:27:05 +0100
Message-ID: <877bpy6ebq.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Wed, 22 Apr 2026 at 19:57, Kumar Kartikeya Dwivedi <memxor@gmail.com> =
wrote:
>>
>> On Wed, 22 Apr 2026 at 19:00, Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> >
>> > On Wed, Apr 22, 2026 at 9:36=E2=80=AFAM Mykyta Yatsenko
>> > <mykyta.yatsenko5@gmail.com> wrote:
>> > >
>> > > >> +
>> > > >> +            if (prog->sleepable) {
>> > > >> +                    guard(rcu)();
>> > > >> +                    ret &=3D run_prog(prog, ctx);
>> > > >> +            } else {
>> > > >> +                    ret &=3D run_prog(prog, ctx);
>> > > >> +            }
>> > > >
>> > >
>> > > Yep, this one should be inverted.
>> >
>> > Ohh and CI was green. Looks like there is a gap in test coverage.
>> > I thought you added a test that does something like bpf_copy_from_user.
>> > We should have seen the splat with config_debug_atomic_sleep.
>> > What happened?
>>
>> CI will likely be green even with splat, since it may not be
>> registered as test failure?
>
> I can see the warning here:
> https://github.com/kernel-patches/bpf/actions/runs/24787752184/job/725393=
72270#step:7:8176
> We likely need to add some post processing step on dmesg that errors
> out on new BUG/WARNING lines in dmesg.

I remember some discussions about adding check for splats.

One of the tests produced this:
2026-04-22T15:58:06.3608335Z [  339.347712] BUG: sleeping function called f=
rom invalid context at include/linux/uaccess.h:169
2026-04-22T15:58:06.3610984Z [  339.348335] in_atomic(): 0, irqs_disabled()=
: 0, non_block: 0, pid: 125, name: new_name
2026-04-22T15:58:06.3613195Z [  339.348895] preempt_count: 0, expected: 0
2026-04-22T15:58:06.3616372Z [  339.349178] RCU nest depth: 1, expected: 0
2026-04-22T15:58:06.3618726Z [  339.349472] INFO: lockdep is turned off.
2026-04-22T15:58:06.3631799Z [  339.349760] CPU: 3 UID: 0 PID: 125 Comm: ne=
w_name Tainted: G           OE K     7.0.0-g633419d54537 #1 PREEMPT(full)
2026-04-22T15:58:06.3634411Z [  339.349766] Tainted: [O]=3DOOT_MODULE, [E]=
=3DUNSIGNED_MODULE, [K]=3DLIVEPATCH
2026-04-22T15:58:06.3642066Z [  339.349768] Hardware name: QEMU Ubuntu 24.0=
4 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 0=
4/01/2014
2026-04-22T15:58:06.3643327Z [  339.349771] Call Trace:
2026-04-22T15:58:06.3644813Z [  339.349774]  <TASK>
2026-04-22T15:58:06.3647734Z [  339.349776]  dump_stack_lvl+0x5d/0x80
2026-04-22T15:58:06.3650841Z [  339.349788]  __might_resched.cold+0x1a7/0x2=
1f
2026-04-22T15:58:06.3653880Z [  339.349793]  ? __pfx___might_resched+0x10/0=
x10
2026-04-22T15:58:06.3657586Z [  339.349797]  ? __pfx___mutex_unlock_slowpat=
h+0x10/0x10
2026-04-22T15:58:06.3661044Z [  339.349805]  ? perf_event_attach_bpf_prog+0=
x14b/0x3e0
2026-04-22T15:58:06.3663190Z [  339.349811]  __might_fault+0x66/0x140
2026-04-22T15:58:06.3666611Z [  339.349818]  ? __pfx___might_resched+0x10/0=
x10
2026-04-22T15:58:06.3669065Z [  339.349821]  _copy_from_user+0x26/0xa0
2026-04-22T15:58:06.3672032Z [  339.349826]  bpf_copy_from_user+0x29/0x60
2026-04-22T15:58:06.3676593Z [  339.349834]  bpf_prog_6d749d25945227f7_hand=
le_sys_enter_tp+0x5d/0x88
2026-04-22T15:58:06.3679583Z [  339.349837]  trace_call_bpf_faultable+0x460=
/0xa60
2026-04-22T15:58:06.3682800Z [  339.349841]  ? perf_event_ctx_lock_nested+0=
x193/0x360
2026-04-22T15:58:06.3686442Z [  339.349847]  ? __pfx_trace_call_bpf_faultab=
le+0x10/0x10
2026-04-22T15:58:06.3689643Z [  339.349849]  ? __pfx__perf_ioctl+0x10/0x10
2026-04-22T15:58:06.3692583Z [  339.349856]  perf_call_bpf_enter+0x167/0x2b0
2026-04-22T15:58:06.3695171Z [  339.349862]  ? lock_release+0x256/0x2f0
2026-04-22T15:58:06.3698222Z [  339.349868]  ? __pfx_perf_call_bpf_enter+0x=
10/0x10
2026-04-22T15:58:06.3701676Z [  339.349874]  ? perf_syscall_enter+0x2a9/0x7=
d0
2026-04-22T15:58:06.3704200Z [  339.349877]  ? __fget_files+0x1b4/0x2f0
2026-04-22T15:58:06.3706543Z [  339.349883]  ? put_ctx+0x20/0x180
2026-04-22T15:58:06.3709243Z [  339.349885]  ? lock_acquire+0x2b6/0x2f0
2026-04-22T15:58:06.3711654Z [  339.349890]  ? lock_release+0x256/0x2f0
2026-04-22T15:58:06.3714661Z [  339.349894]  ? __might_fault+0xc5/0x140
2026-04-22T15:58:06.3717508Z [  339.349897]  perf_syscall_enter+0x2a9/0x7d0
2026-04-22T15:58:06.3720433Z [  339.349902]  ? __pfx_perf_syscall_enter+0x1=
0/0x10
2026-04-22T15:58:06.3723889Z [  339.349907]  ? __pfx___might_resched+0x10/0=
x10
2026-04-22T15:58:06.3726935Z [  339.349909]  ? __pfx_fput_close_sync+0x10/0=
x10
2026-04-22T15:58:06.3729429Z [  339.349916]  trace_syscall_enter+0xb5/0x110
2026-04-22T15:58:06.3732027Z [  339.349921]  do_syscall_64+0x524/0x5f0
2026-04-22T15:58:06.3735196Z [  339.349927]  ? __irq_exit_rcu+0x40/0x1e0
2026-04-22T15:58:06.3738744Z [  339.349933]  entry_SYSCALL_64_after_hwframe=
+0x76/0x7e
2026-04-22T15:58:06.3740690Z [  339.349937] RIP: 0033:0x7f47209ae28d
2026-04-22T15:58:06.3755178Z [  339.349940] Code: ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 8=
9 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5b bb 0d 00=
 f7 d8 64 89 01 48
2026-04-22T15:58:06.3758736Z [  339.349944] RSP: 002b:00007ffd43505848 EFLA=
GS: 00000206 ORIG_RAX: 000000000000004f
2026-04-22T15:58:06.3763493Z [  339.349949] RAX: ffffffffffffffda RBX: 0000=
7f4720f75000 RCX: 00007f47209ae28d
2026-04-22T15:58:06.3768294Z [  339.349951] RDX: 00007f472097ca9b RSI: 0000=
000000001000 RDI: 00007ffd43505860
2026-04-22T15:58:06.3773718Z [  339.349954] RBP: 00007ffd435068c0 R08: 0000=
000000000000 R09: 0000000000000000
2026-04-22T15:58:06.3778607Z [  339.349956] R10: 0000000000000064 R11: 0000=
000000000206 R12: 0000000000000008
2026-04-22T15:58:06.3783368Z [  339.349958] R13: 0000000000000000 R14: 0000=
5648b9bf8550 R15: 00007f4720fb8000
2026-04-22T15:58:06.3784686Z [  339.349963]  </TASK>
