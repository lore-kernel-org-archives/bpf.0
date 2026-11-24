Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515470;
	b=pRsj+qWoBzAL3CGvS64JjyY5jmSm39wyQRXomEB89lpVdp6R+6qQZeMVpcyNcfBIwmoX
	 rKLvGduoFGBN5shmrtp3Af1JaUa2HBOpXLrb1OnGjy3IDSQsI05wil/iTr5/L+GvAhub0
	 Y30jgTwQiLVKJ5CePFqtHdDCQk4UowZtInvCBbNZRSb0clTR+Occ4bNGHy+cQa0le+mjB
	 UfT2ZXo8OjHZPeDUD/o240MLy8uDOf5GMkAr1Rps7Bnd9DGNmgR5V9m5DamY4R1Zuvqzb
	 FAUYeyxmIdQ0JmWmBzZr1dCk8zwdl4hCi1QUwhiHBcWUEs5mj2GeCe5mUFDmNSdAEHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cDR7cjV4IRioJgp9xWXyZAeSRy7CXHNvvQiffZPND/Q=;
	b=WWtKNauba2LA+AXmDTS3qzH1lLZiJ1Glk43W7FI6Ba+gFDr8sJOkVffleSO8l/FtPlq2
	 S07QJTQXPjVCJOpoJCBl7HFsW3tvrrNXuhg7XHSF2kXX0r3BSMdWleqc746PueOVNXFxP
	 0gMbhkjlferjLA0BI7GY3q0GyGVIPgjYmKZE3g31uP7otmmri42Q80WhXLGq4ykembZkR
	 O3R20mDobhnxjIZ0L5a4JFifZQR+oJ+tyV1MIL67eTzs7xuGauk5PO3j9ij0mqNefrssM
	 etYsodbX9NyyUjZpjXESivk9np6O8jzx2D7a0OGQaibtllOU1CDmn48eeuHL2fq2kNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=boQDOESY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD824606A33F
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 10:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD824606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=boQDOESY
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so1879790b3a.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 02:17:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795515469; cv=none;
        d=google.com; s=arc-20260327;
        b=KJidU7bLqpTOxyLkYEhP7uV0jnDDMwVUjzUMCz9P/iTFjWP/QuFCRP/1pX6U3swNUl
         dHygY3fECRVD8xk+KF3fOL9YZqc1BDtoJrz1kBcj2d1vdnbF4aAzIu8H1lK0TJ9vJF+n
         +QeBw4LHEuLboS5eYv2f3LEBrslOHNa7MtKXZ5f8vTzc+NCPRL89nQN7KCEaJrIB9CW9
         zEUEFOCyfSuAAp/BOMDIXR6ScJOFQ6Ke7Z/cecPAtx5cdSvOaC1wFknPN2EmQh7O0F7r
         dP5XZjq84b1UR2R5a5962hYpvWsh5rWt2IncRRNWzJQorgx5+uf0fMLmJ8EsjfGwshXF
         HU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cDR7cjV4IRioJgp9xWXyZAeSRy7CXHNvvQiffZPND/Q=;
        fh=3DZZrAEPsr6xEykE9GWUsOIMdVgv7bcRHqn3uBDTrZM=;
        b=kBXmugJb3sCvzkvhD4EXsMKfjPMWsl1ZrreWARQzE3l/0DdXiOr0q1MvJJDjtDXZ3S
         c0XUYvS102SpEKCfS/WRUo4SyAuUSKij4eZCM5qMBJjYom2NraNprKNdZvWhgjgqeFtB
         QkSOVv0d4D+xerkhSDSC1cqdXQugBPh3rVS/OLmSOawc3biWe5qAkDGxE+A+Zov3rcmJ
         d/4rxkEoN2cEEtjeGnEbktFvm8aV451c2DHg/WDELPywvVOrOghu0EKkbq/zrrYYxVGp
         dqDioRXQweXIMduuLGsLjYwpCaXOOAnTYGdB3Ex/HmmABYlzA4v3FJWZNot9+lvQaKfw
         We7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795515469; x=1796120269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cDR7cjV4IRioJgp9xWXyZAeSRy7CXHNvvQiffZPND/Q=;
        b=boQDOESYfuu+ei6nPbUoODpl/Ek47OYUgvhVk99ETOZyiaz2nZqCLusCouY2MPVsrf
         Lmi4VNPNuXk5gN0d8V16BfTeGNVTHqfHv8lmY2KZWvPzn/MwZzGSASY+bMZQ5SWPoW91
         4pw6s5nM+6RqviziclgIXLw7PFOAQx7tuzf3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795515469; x=1796120269;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cDR7cjV4IRioJgp9xWXyZAeSRy7CXHNvvQiffZPND/Q=;
        b=wOo+pIrtr8Ao+1FgXEx7Dm31hHIU6lnuUW9ORlLd2Ltn5oyEdw0i6KPjXXymgvXaPE
         bR4e/Kulfz3VLHBc3aqry38ZDKLGRToWgnAXh68y0SMVAaGSB0nddvZY5RkmYkETIvwc
         TRKkUrHwKYB6Pz/B8cS1SgOri+x6vXvLIqDe+J4rnkJgNwaXFdMOdTA/QJlSaGuD5i9A
         RGPnUx0I7c+xFHaIDH7Igc7BAlCmGyPCVHiskNp+4jterj1KaJZjgHbIeq+JeUbXmWPv
         0ZnWq9tUxDlDx9SVLpodFKmDG2tTcm2PjSa2Mn2gUg8r2VifBG/LU6WmJwnU2KHgZCPx
         49ng==
X-Forwarded-Encrypted: i=1; AL+hErEyw5NMGnq0zisYiltSlPaOTUBUWqWL+wMzHc9wM2zRpe6Vg1MlOrG1aoS176UgDFma5Lw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cTe38EdQqm1mX1dEUD/USe+2cFBihKt3Lpwk8Gew+GK0wg5j4
	U4OWMnZhcK834m6Knh28++LxYdILwDk4o5U0vIdu9YI0wkauxybg+uKTvDvqoUdhZgEDus/RTJK
	26bRDS8e8+vm9wqPKYmx55SPGr45Ep95GGCw9Nx7g
X-Gm-Gg: AZFdTZd9i182cIb+NzKk/lIcn9ZfNILO00mJQ6SSDMZLJU7MurqEvmDM1aLCSJmtgN8
	a9lk7rTtPGcGE+exT+yMi1HA/zZNe+1aJlquCXxCJg+jWSEsP7Nmys9N8ugUmknyt/cbxg51X6k
	5Ig++LDdX4Zjp/mfHry2yNgYf6HYQEtt10EO0nJDNakOfMbKluhbiAWKqSqvAlq0WIzsvLUx5tm
	eguB2Dt3X27g1sZ1B6gueMcarpxXJRvYD2uoeh0NiomiNk8TcMHRC7w+7UmGpN4KIlYgz39bgmI
	SErwJwE2vXxGbrCxQlP1Al8ahEnzEsIyCMW7mpzmV7GVLWhLw/L5qSfmcqZFrA+SFfHWrNmBV4K
	EO6jf7lnNdOoPHW+e6NtGK6bGrk5MAq4Nfq1D/mQt1UNQJd1Cjpf8iluDcwYQei+sYBJb8yBDQj
	p7wr5wgjKe94dfgdW3vepD
X-Received: by 2002:a05:6a21:4a8c:b0:3f2:acd9:132e with SMTP id
 adf61e73a8af0-4014db57e24mr12442219637.61.1795515469040; Tue, 24 Nov 2026
 02:17:49 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6b051681.58b41460.7037.0590.GAE@google.com> <DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com>
 <CAM0EoMnVa=xGD3uiZKuzMfFL6oZNd=Umb0U7+_QUrTK7Ej-BYg@mail.gmail.com>
In-Reply-To: <CAM0EoMnVa=xGD3uiZKuzMfFL6oZNd=Umb0U7+_QUrTK7Ej-BYg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 24 Nov 2026 05:17:38 -0500
X-Gm-Features: Aa3M54oAhgDu4a3QN-cUvm8ntTPorq0ToGdV6xzEFC1H8I-IekXAnPLMj4fFDqA
Message-ID: <CAM0EoMn=ZghG5KFu2Nc=W-=KjDv=epspFHZVDY4ww5a9GBUaHQ@mail.gmail.com>
Subject: Re: net: act_gate bug. was: [syzbot] [tomoyo?] [mm?] INFO: rcu
 detected stall in security_file_ioctl (9)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, andrii@kernel.org, bpf@vger.kernel.org, 
	brauner@kernel.org, daniel@iogearbox.net, jack@suse.cz, jmorris@namei.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@i-love.sakura.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-users_en@lists.sourceforge.net, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 5:03=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Nov 24, 2026 at 1:00=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Nov 23, 2026 at 08:45 PM syzbot <syzbot+b6f8640465bdf47ca708@sy=
zkaller.appspotmail.com> wrote:
> > > rcu:           hardirqs   softirqs   csw/system
> > > rcu:   number:     5264          0            0
> > > rcu:  cputime:      138      52351           25   =3D=3D> 52490(ms)
> >
> > It's not tomoyo, mm or bpf. Looks like act_gate.
> > Zero new softirqs in 52 sec, so one hrtimer_run_softirq() doesn't retur=
n.
> >
> > > RBP: ffff88807ed35538 R08: ffffffff91be1bbf R09: 1ffffffff237c377
> > > R10: dffffc0000000000 R11: fffffbfff237c378 R12: ffff8880b8228600
> > > R13: ffffffff89fd0480 R14: ffff8880b8228600 R15: 1ffff1101704514a
> >
> > The registers with lockdep struct sizes:
> >
> >   reg       value             points to
> >   --------  ----------------  --------------------------------------
> >   R14       ffff8880b8228600  cpu_base
> >   R15 << 3  ffff8880b8228a50  clock_base[HRTIMER_BASE_TAI_SOFT].seq
> >   RBP       ffff88807ed35538  kmalloc-512 + 0x138, tcf_gate->hitimer
> >
> > act_gate has the only soft hrtimer that can be on CLOCK_TAI.
> > bpf_timer_init() rejects that clock.
> >
> > TCA_GATE_CYCLE_TIME is an unchecked u64. In gate_timer_func():
> >
> >   n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> >   close_time =3D ktime_add_ns(base, (n + 1) * cycle);
> >
> > With base =3D 0 and cycle =3D U64_MAX, n is 0 and close_time is -1.
> > The timer restarts in the past and __hrtimer_run_queues() runs it again=
.
> > It's there since
> > commit a51c328df310 ("net: qos: introduce a gate control flow action").
> >
> > Jamal,
> > taprio's INT_MAX limit doesn't fit. tdc uses cycle-time of 600 sec.
> > The diff saturates the sum instead.
>
> Looks familiar - i will take a look.

Ok, found an abandoned related thread in my list:
https://lore.kernel.org/netdev/tencent_FAEDEECDD478AE6DFC2DE96D389440E96A0A=
@qq.com/
I will take it from here; it looks like your patch is still needed and
requires a fixup to the abandoned one as well. I need to reproduce
this first.

cheers,
jamal

> cheers,
> jamal
> > Here is a potential fix:
> >
> > diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> > index 711cf24..5422d60 100644
> > --- a/net/sched/act_gate.c
> > +++ b/net/sched/act_gate.c
> > @@ -45,8 +45,9 @@ static void gate_get_start_time(struct tcf_gate *gact=
,
> >                                 const struct tcf_gate_params *param,
> >                                 ktime_t *start)
> >  {
> > -       ktime_t now, base, cycle;
> > -       u64 n;
> > +       u64 cycle =3D param->tcfg_cycletime;
> > +       ktime_t now, base;
> > +       u64 rem;
> >
> >         base =3D ns_to_ktime(param->tcfg_basetime);
> >         now =3D gate_get_time(gact);
> > @@ -56,10 +57,9 @@ static void gate_get_start_time(struct tcf_gate *gac=
t,
> >                 return;
> >         }
> >
> > -       cycle =3D param->tcfg_cycletime;
> > -
> > -       n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> > -       *start =3D ktime_add_ns(base, (n + 1) * cycle);
> > +       /* cycle is an unchecked u64, the sum must not wrap into the pa=
st */
> > +       div64_u64_rem(ktime_sub(now, base), cycle, &rem);
> > +       *start =3D ktime_add_safe(now, cycle - rem);
> >  }
> >
> >  static void gate_start_timer(struct tcf_gate *gact, ktime_t start)
> > @@ -107,15 +107,8 @@ static enum hrtimer_restart gate_timer_func(struct=
 hrtimer *timer)
> >
> >         now =3D gate_get_time(gact);
> >
> > -       if (ktime_after(now, close_time)) {
> > -               ktime_t cycle, base;
> > -               u64 n;
> > -
> > -               cycle =3D p->tcfg_cycletime;
> > -               base =3D ns_to_ktime(p->tcfg_basetime);
> > -               n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> > -               close_time =3D ktime_add_ns(base, (n + 1) * cycle);
> > -       }
> > +       if (ktime_after(now, close_time))
> > +               gate_get_start_time(gact, p, &close_time);
> >
> >         gact->next_entry =3D next;
> >
