Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43742D7DE1
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775247573; cv=pass; b=AdhDLjA1B0JmYY9qU6/XWh7zJPwO8treQCsYPF5B3wmt1UioHnJsBavhcE4rS0cFoFKcaSP+EtW4njQX87jxl5TKyny1O23g9ollmHux1rtLNzEFYq5RIjG4wdQrjs4SzSkSIx5S/HjOEzkZbloToor1cZdpzgFodHOKatEN+Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775247573; c=relaxed/simple;
	bh=aWs+wbzB0GD25tebd4FwDmf5Dg3ElXT3opxb3THYiXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVm9Dms+xcLSVW5hsYokYNHV21DBop7ASoJ4uLzj7kfho7HfKY+NsDhXFQ3H3tf0mylgw6WOhw9jGeJh/EebWCSIoyuFa01/PZloAhsh7kOG15dTZw5mQKDeJxz/iPbF6GBdxPyw30/dLujFv8Idm4tVlZjmZv5lMDnQUfAYgBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMITC7ng; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMITC7ng"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so14105a12.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 13:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775247570; cv=none;
        d=google.com; s=arc-20240605;
        b=FEe2AsmAeJxR413UfcXtBdiyGeSPWGKcmQyI4Yp6aWiIH6I3QY6jgJQi/VXrAg/IRZ
         JCCc6ZWquKS3kOS2NANd6VB4fGdDYtU7tbaGShl+8DC8sL4EeF/I0g4HrQ1fogKrs2Ic
         wDgMjSEUPXq/LStJH0dAPUfiB6W5q7j4TwitwMQvAZ+cb+M38vCEF3j3cV3gUn1jZnnI
         xTpGigHZGUSCi+Ub4H6oEicQLxouo/MOxWy+bg4aYXpBRA//ucFJt710vJIIn7JD8+Ed
         u8pGb/LPp+oH3rCuiO4xG4vCtYyxG1Aqxb6mLQYfNIcL4s6ekc72UaHSU0NmdziTsMAx
         RpFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9idyuVEhOac6q8zDvEM+VotLSRRsMcPfEh8o3j5eQSY=;
        fh=o5UvEuMDTEagDu+1aJY8Bqsn6eJFIkxPZdgAyOvjVxk=;
        b=Cw7PpjYiplQVEJTJ5QpTl6G7CNmXee6ssmgrymHlhrVGkgHEergyHyp74HigbrC922
         wjk7G7hpVf8sJCd219HjmvHmYhLq4V7ESYjzqeHiH1bgH+jOJbBayy7dumPwtUs0hxnV
         aEV0fqf4EUu/heI1WZGQwVJqKZ39/mkTJaQkNzhRr1ugOG+5BBimdhz/tsq1FFlpoZNt
         jcAnSlQ+lJ71f/oeVqpyG74hcdOKg+l3jySiS4NHPu8vxGOAPadPlZ7t0EbpVC4GppIx
         4SdL1GQOwiE1B04JmR/XKm4aZKcOe9ecBXxtV9AfC86GYm8SZN9OY4RtqGP22lIu5fnR
         q/dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775247570; x=1775852370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9idyuVEhOac6q8zDvEM+VotLSRRsMcPfEh8o3j5eQSY=;
        b=lMITC7ngnCxJn7Eoyngp9Eu7a6i11eeqAZgeB/czbkMFntTjkZE9q170y4WUBaN7gq
         7kssQ5e1DV4WdyFB8KfpYhMLOkDt6XeWzwmY6N0gZ9UUmbM5OfL+bdb9JKEnTZilQD4J
         o1bsb/cYoQ/tfXybIMPETAvO3PFBnOtJ9hZ0qlPvOrn/1LMjGhjfFgSc/gHtoHbVSbYX
         XPuWj3zXeTseCbQFGd6If+9VEporzDotAqlzDpFH0x/rYN7Q/KbbHhUZn2CFNp/+3o3z
         81a9Po8PsTgBoiPwZGC9yv5VtOZBN/mIuicvNRDSYJ7aaqYTVzIbLvedrfiTPSt/V5j+
         vfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775247570; x=1775852370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9idyuVEhOac6q8zDvEM+VotLSRRsMcPfEh8o3j5eQSY=;
        b=tU4fojObOUtKcusdrKGE5uJKi1iubNUn+sqxG1K4sm8zx09ZqHFeF+wm/9JryaaGfK
         skd+F9DOFb/IhPP2Q9wsR7ZFyCBdCYDrKoWLEhTNbVpdDm2jVVh57CVkjgtiKyayBpsU
         91IPCqy3FIXOwJtUv8vCxioF9ujtUUdYr0Ma5jP6PBUwGG7muVsx0QP9/sqiFNZwyQYg
         hzIw0zHM/u2y2h3I3Q8l69IBkuOG2SX0vaddHZLABIE9dP5b/BQicBfARYMeaH9SQL8y
         ZxnMIBaFTrgH8/MpQjYD1PLPDd12jYQcta0IEysGvpoBSjOi/yvkCqmdUuscnEj01Li2
         P1sw==
X-Forwarded-Encrypted: i=1; AJvYcCXGuCAxxhS68V85dAx7qYbUL0itIjsr4pA7+PYoAnh128YtQTGDmEVfkVDGuYGDyUOR3Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1BdiF82O30FwtNthLrIjHrO0SLzcksmKeDDm/Hja3kH/MM6T
	5EHTL5P7KnmAcSl91eXauxjgEgc+Pdp7WTER7OKwwR/H0cAfI38MwzaR1uDI32TDY0TlUxYNYqL
	QaMRnlLwYCOaYsMYzwlh3ORnXhLAq89g1q8QHgM4d
X-Gm-Gg: AeBDiesz5Vrl1tutAH+DYnJX+TZFra8E0tQ/rpoLaTNJ817iLoKm/xmQ/k+uSHircbp
	jz3/k4p2aa7YplxTOgtKvXr9lwR4jGKF4GFqSL0w6QO1yhQCEWInCiB3x1X02Sop7kLQcjI5Cl/
	lscrP8jI/mfIqaKGcpO+5/WYd/mkyYMoKz9g4YrtJMhKQoUoPZPU9n+pKcbb9/UFu5+XwHEXUm8
	MOD9Kv5pjHxgueKAgLYLGRfRX56QeUSdwQyP+KmGxbeBv6mspVZ6BGqb9zdCf8lPQyuC4l1dcz8
	l4hqBAM=
X-Received: by 2002:a05:6402:20d5:10b0:660:efc9:900a with SMTP id
 4fb4d7f45d1cf-66e432e10demr28487a12.10.1775247569545; Fri, 03 Apr 2026
 13:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
 <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com> <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
 <20260403185236.sjgetnkha3o3a4d3@desk>
In-Reply-To: <20260403185236.sjgetnkha3o3a4d3@desk>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 3 Apr 2026 13:19:17 -0700
X-Gm-Features: AQROBzBN2T9-HOthaRcY0Ldmz0x4J6ZHvMaPV916MYhPQfL9BOlln2WWIsxXzW8
Message-ID: <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 11:52=E2=80=AFAM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2026 at 11:10:08AM -0700, Jim Mattson wrote:
> > On Thu, Apr 2, 2026 at 5:32=E2=80=AFPM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > As a mitigation for BHI, clear_bhb_loop() executes branches that over=
write
> > > the Branch History Buffer (BHB). On Alder Lake and newer parts this
> > > sequence is not sufficient because it doesn't clear enough entries. T=
his
> > > was not an issue because these CPUs use the BHI_DIS_S hardware mitiga=
tion
> > > in the kernel.
> > >
> > > Now with VMSCAPE (BHI variant) it is also required to isolate branch
> > > history between guests and userspace. Since BHI_DIS_S only protects t=
he
> > > kernel, the newer CPUs also use IBPB.
> > >
> > > A cheaper alternative to the current IBPB mitigation is clear_bhb_loo=
p().
> > > But it currently does not clear enough BHB entries to be effective on=
 newer
> > > CPUs with larger BHB. At boot, dynamically set the loop count of
> > > clear_bhb_loop() such that it is effective on newer CPUs too. Use the
> > > X86_FEATURE_BHI_CTRL feature flag to select the appropriate loop coun=
t.
> > >
> > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > ---
> > >  arch/x86/entry/entry_64.S            |  8 +++++---
> > >  arch/x86/include/asm/nospec-branch.h |  2 ++
> > >  arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
> > >  3 files changed, 20 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > > index 3a180a36ca0e..bbd4b1c7ec04 100644
> > > --- a/arch/x86/entry/entry_64.S
> > > +++ b/arch/x86/entry/entry_64.S
> > > @@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
> > >         ANNOTATE_NOENDBR
> > >         push    %rbp
> > >         mov     %rsp, %rbp
> > > -       movl    $5, %ecx
> > > +
> > > +       movzbl    bhb_seq_outer_loop(%rip), %ecx
> > > +
> > >         ANNOTATE_INTRA_FUNCTION_CALL
> > >         call    1f
> > >         jmp     5f
> > > @@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
> > >          * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
> > >          * but some Clang versions (e.g. 18) don't like this.
> > >          */
> > > -       .skip 32 - 18, 0xcc
> > > -2:     movl    $5, %eax
> > > +       .skip 32 - 20, 0xcc
> > > +2:     movzbl  bhb_seq_inner_loop(%rip), %eax
> > >  3:     jmp     4f
> > >         nop
> > >  4:     sub     $1, %eax
> > > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/=
asm/nospec-branch.h
> > > index 70b377fcbc1c..87b83ae7c97f 100644
> > > --- a/arch/x86/include/asm/nospec-branch.h
> > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > @@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
> > >  extern void update_spec_ctrl_cond(u64 val);
> > >  extern u64 spec_ctrl_current(void);
> > >
> > > +extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
> > > +
> > >  /*
> > >   * With retpoline, we must use IBRS to restrict branch prediction
> > >   * before calling into firmware.
> > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > > index 83f51cab0b1e..2cb4a96247d8 100644
> > > --- a/arch/x86/kernel/cpu/bugs.c
> > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > @@ -2047,6 +2047,10 @@ enum bhi_mitigations {
> > >  static enum bhi_mitigations bhi_mitigation __ro_after_init =3D
> > >         IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_AU=
TO : BHI_MITIGATION_OFF;
> > >
> > > +/* Default to short BHB sequence values */
> > > +u8 bhb_seq_outer_loop __ro_after_init =3D 5;
> > > +u8 bhb_seq_inner_loop __ro_after_init =3D 5;
> > > +
> > >  static int __init spectre_bhi_parse_cmdline(char *str)
> > >  {
> > >         if (!str)
> > > @@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations(void)
> > >                 x86_spec_ctrl_base &=3D ~SPEC_CTRL_MITIGATIONS_MASK;
> > >         }
> > >
> > > +       /*
> > > +        * Switch to long BHB clear sequence on newer CPUs (with BHI_=
CTRL
> > > +        * support), see Intel's BHI guidance.
> > > +        */
> > > +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > > +               bhb_seq_outer_loop =3D 12;
> > > +               bhb_seq_inner_loop =3D 7;
> > > +       }
> > > +
> >
> > How does this work for VMs in a heterogeneous migration pool that
> > spans the Alder Lake boundary? They can't advertise BHI_CTRL, because
> > it isn't available on all hosts in the migration pool, but they need
> > the long sequence when running on Alder Lake or newer.
>
> As we discussed elsewhere, support for migration pool is much more
> involved. It should be dealt in a separate QEMU/KVM focused series.
>
> A quickfix could be adding support for spectre_bhi=3Dlong that guests in =
a
> migration pool can use?

The simplest solution is to add "|
cpu_feature_enabled(X86_FEATURE_HYPERVISOR)" to the condition above.
If that is unacceptable for the performance of pre-Alder Lake
migration pools, you could define a CPUID or MSR bit that says
explicitly, "long BHB flush sequence needed," rather than trying to
intuit that property from the presence of BHI_CTRL. Like
IA32_ARCH_CAPABILITIES.SKIP_L1DFL_VMENTRY, the bit would only be set
by a hypervisor.

I am still skeptical of the need for MSR_VIRTUAL_ENUMERATION and
friends, unless there is a major guest OS out there that relies on
them.
