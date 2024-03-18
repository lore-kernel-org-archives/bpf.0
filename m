Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD7A5F569
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710804675; cv=none; b=SLzbf1FdBJtW5kg0sMytFhNHrC4t3miD6CzC/7xnT8BuI1XGmg/+FPVXGXAqg9Hel4dPbePjR4ZwrtT+LnEu8xvmISxW+loKyspDhNGcYqBiz2ZKSv7F39BqIKAHsGqiI+Sg26liiqvbf16YxoKxXO20Q/MxtnP5DSwk96QoN8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710804675; c=relaxed/simple;
	bh=bebfsA77h7dywYhas0L1F0aVIKuLLLLm8m8x/8R+2Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPIHXTmujCAL07LymZ95bzV7aP2neFEoWrmrFMlqnCHvB7i0gKSapvdY0fRkjnDFY37GxRcZin6QEsa45kCvozxQUpE+tTV3OJjxeAb5d6j93OUP06h8vzJ7g0nyx2yoSEC2szY2kXH1xFDJi6UWJsPdEbr+2RUSytbhPuEWlOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDElx56X; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDElx56X"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41464711dc8so643305e9.1
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 16:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710804672; x=1711409472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cevuCZiA43cSPrl3haKUNq0EKfs0OBOV7aMbm5imABs=;
        b=jDElx56X6AsBZKZH3Au4m7C4PHL1kkFvLuNN6RQ1hud20oup2OG/PWYLuFtpg9LI1d
         f4aLuSQk3c8zY44ND46OcbbKUgyGg0haao5Q0jptflOu9ZjzQP2cpmSbkRUDJBw8gi8H
         1VG2jcQ4hpquyB9opEDSyoyj0TXBKBDhgoeomFphrUhUuIl2yhJly1IPmbJ9rP8bF0Z+
         IEpgRCMnNYkUBPEmUJEjUxgcwjxvnPG7Z3qXRCAtGOJMO7cVm1Y6Iz8mRqwlYCV5iBdI
         OU0E3r+5toit0irHGFMTjZnooJlWA2eK+GoBZ87qEkrN0QgkSzYwS5OH2OkqXsPmjOcT
         2haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710804672; x=1711409472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cevuCZiA43cSPrl3haKUNq0EKfs0OBOV7aMbm5imABs=;
        b=IWGfXIfmy7h0CQ0QOCOmPM6m/LvA4S8rQuLzQUoNMijbqGHerKBAiaXzSAGx7zKfy4
         aZVoyK4kbablLzuVVoSWbjGC1rN0SG2UZuxL6Ykskclx5MNm8DlX0+G6YKhYSJAbrwtv
         f1E2YsHU+yX/y+HtRVJ216CnBYt6cY5cpk5IWgHo7sa+WGy7LYgBsZkkqgQ6B0SE7bzm
         CZOMvu8FTqK5UdLYSkUo+sajGpF+yB6jgveoFkpID4CrsOjNMDRbfj9L93QAUkrPQWxo
         4SJsQ3FDVRQSlGZzVoHXqSYrj27wM6YrsZBiOIokKDlknuTZOksJb+mliPY5dgwrypZK
         MIUA==
X-Forwarded-Encrypted: i=1; AJvYcCUe3ox0pk4QuWAFwORIy080PRTL/bCMsMecH5RKd6HCj+u2cuQjVslr78lMNcOsootdbzAkTaYm0n9s4yR5JBS4Xby3
X-Gm-Message-State: AOJu0Yx/IO4gmrgALsfVyL1PnAEzX4XfbaQ4cq43gSZg2oNXj3jqMLc0
	qfkFS0iPkOFUIBXTdAM7rpgR6UEnXEtW45Fo+27jVTDkfXUrJbQKW9zFQflYuWulQiMA5s+Ukys
	cJJ37FNJ7XkfToK4ngHr8onflVUw=
X-Google-Smtp-Source: AGHT+IEzkVpAxojo21cIGHkQJODxWaB9dpKry3InvkpkSF0z2qtJlnSpUDZUkL2GRkAK4JmPAOHgDhNkUFV5OnbzdaI=
X-Received: by 2002:a05:600c:4708:b0:413:38ee:69e7 with SMTP id
 v8-20020a05600c470800b0041338ee69e7mr563575wmo.36.1710804671609; Mon, 18 Mar
 2024 16:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c9923c1d-971d-4022-8dc8-1364e929d34c@gmail.com> <ig5bw37zznqrokjeyloobncubiy6bqxh6drszewjkby56y55by@o64a2x4zqo5v>
In-Reply-To: <ig5bw37zznqrokjeyloobncubiy6bqxh6drszewjkby56y55by@o64a2x4zqo5v>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 18 Mar 2024 16:31:00 -0700
Message-ID: <CAADnVQJS=YkUVfLgGxVe7kH8x4i560Z1Zx7+cv1AiwMvspXWJQ@mail.gmail.com>
Subject: Re: Crash caused by 778666df60f0 ("s390: compile relocatable kernel
 without -fPIE")
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, bpf <bpf@vger.kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 1:38=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On Fri, Mar 15, 2024 at 09:59:52AM -0700, Kui-Feng Lee wrote:
> > Hi Josh, Sumath, and Heiko,
> >
> > Recently, all patches submitted to bpf have been failing the selftest
> > "dummy_st_ops/dummy_init_ptr_arg" on the s390x platform. Upon
> > investigation, it was determined that a specific patch, 778666df60f0
> > ("s390: compile relocatable kernel without -fPIE"), is causing the prob=
lem.
> > It is the first bad after bisecting. Please take a look.
> > Thank you!
> >
> > You can reproduce it by running the command
> >
> >     ./test_progs -a dummy_st_ops/dummy_init_ptr_arg
> >
> > in the tools/testing/selftests/bpf directory in the Linux source tree.
> > This command causes a kernel crash with the following messages. It
> > appears to be related to attaching a trace program at the fentry of a
> > struct_ops operator. The same operator works fine without the trace
> > program. For more details about the test case, please check
> > dummy_st_ops.c in tools/testing/selftests/bpf/prog_tests/.
> >
> > illegal operation: 0001 ilc:1 [#1] SMP
> > Modules linked in:
> > CPU: 0 PID: 82 Comm: test_progs Tainted: G           OE
> > 6.8.0-rc3-g778666df60f0 #34
> > Hardware name: QEMU 3906 QEMU (KVM/Linux)
> > Krnl PSW : 0704d00180000000 0000000000000002 (0x2)
> >            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> > Krnl GPRS: 000003ff800a4956 0000000000000000 0000038000a73d20
> > 0000000082a08b58
> >            0000000000000000 000000007083ede2 0000000000000000
> > 0000000000000001
> >            00000000009d580e 000000008286bc00 0000037f000000d8
> > 000003ff800b2000
> >            0000000081a43c00 00000000011bfe20 000003ff800b208e
> > 0000038000a73c68
> > Krnl Code:#0000000000000000: 0000               illegal
> >           >0000000000000002: 0000               illegal
> >            0000000000000004: 0000               illegal
> >            0000000000000006: 0000               illegal
> >            0000000000000008: 0000               illegal
> >            000000000000000a: 0000               illegal
> >            000000000000000c: 0000               illegal
> >            000000000000000e: 0000               illegal
> > Call Trace:
> >  [<0000000000000002>] 0x2
> >  [<00000000009d5cde>] bpf_struct_ops_test_run+0x156/0x250
> >  [<000000000033145a>] __sys_bpf+0xa1a/0xd00
> >  [<00000000003319dc>] __s390x_sys_bpf+0x44/0x50
> >  [<0000000000c4382c>] __do_syscall+0x244/0x300
> >  [<0000000000c59a40>] system_call+0x70/0x98
> > INFO: lockdep is turned off.
> > Last Breaking-Event-Address:
> >  [<000003ff800a49ac>] bpf_prog_83ebf4e90b071f2b_test_1+0x5c/0x70
> > Kernel panic - not syncing: Fatal exception: panic_on_oops
> >
> >
> > [1]
> > https://github.com/kernel-patches/bpf/actions/runs/8297891630/job/22710=
267571
>
> Hi,
>
> thanks for the report, I'm currently looking into it.
>
> The problem is that the following:
>
> static void bpf_jit_plt(void *plt, void *ret, void *target)
> {
>         memcpy(plt, bpf_plt, BPF_PLT_SIZE);
>         *(void **)((char *)plt + (bpf_plt_ret - bpf_plt)) =3D ret;
>         *(void **)((char *)plt + (bpf_plt_target - bpf_plt)) =3D target ?=
: ret;
> }
>
> is (mis)compiled to the following:
>
>    0x000000000017a26e <+238>:   stg     %r4,232(%r3,%r15)
>    0x000000000017a274 <+244>:   ltgr    %r11,%r11
>    0x000000000017a278 <+248>:   locgrne %r4,%r11
>    0x000000000017a27c <+252>:   stg     %r4,232(%r1,%r15)
>    0x000000000017a282 <+258>:   la      %r3,232(%r1,%r15)
>    0x000000000017a286 <+262>:   lghi    %r4,8
>    0x000000000017a28a <+266>:   mvc     232(16,%r15),0(%r2)
>    0x000000000017a290 <+272>:   mvc     248(16,%r15),16(%r2)
>
> Note that memcpy() and assignments are reordered, and this is causing
> the crash. The C code violates the strict aliasing rules, but this
> should be irrelevant for the kernel.
>
> The problem does not occur with the latest GCC. Bisect says that the
> following commit fixed it:
>
> commit 2e96b5f14e4025691b57d2301d71aa6092ed44bc
> Author: Aldy Hernandez <aldyh@redhat.com>
> Date:   Tue Jun 15 12:32:51 2021 +0200
>
>     Backwards jump threader rewrite with ranger.
>
> but I think that's accidental. The reordering is done by the sched1
> pass. I plan to find out why it thinks it's okay to reorder these
> memory accesses.

Wow. What a discovery.
Does this bug affect other architectures ?
Probably yes, since it's sched1 pass ?
Should we apply some workaround for now?

Also it's probably not strict aliasing related:
extern const char bpf_plt[];
extern const char bpf_plt_ret[];
extern const char bpf_plt_target[];
and bpf_jit_plt() casts the pointer to 'char *'.
The 'char *' was always special from GCC strict aliasing point of view.
iirc gcc used to treat such pointers as pointing anywhere.
