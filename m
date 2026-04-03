Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B32E54A3
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253590; cv=pass; b=oCtx2GHfYYpzvGHmvCc9Rtl01UC+frQn54DLoGW9231xlYLhmS+QCtiunkNYZM8LMwU4fhy+ke34AUhE2Y05WBRnUrOLZJIrZxiVp+vuZjcMXp1AfaQl4Jw23xDYjT//+DC2J+Al+dGanLj3k/T2k+BUex9F9eMhYN28K4RRgk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253590; c=relaxed/simple;
	bh=OuHsJ0N8U4o8AF+Mf4uPjGJj7uKjFRFAftozElvC01g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srhAPVzBhWjWllcnTUxdZ7Fjm1k2zyD41w5AsZ1vkEYh4pS3LBe3vXM5zI8Q2F1g5hGuBVOhVg28M+bIA+KgFBZhn43Xk/kJEh32JR2Q/w03jlz5y4+yTBhGFmKnXB08T+CQYlyxg2tXqxIjTqTQyXUUPb12QthMWsXzQBt9iCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iq99ap1I; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iq99ap1I"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66baa7fdfd3so11099a12.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 14:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775253586; cv=none;
        d=google.com; s=arc-20240605;
        b=Yk4rYrKQdNejc4f3gxcPEVw1H0qB4Yxau4F3WiSZGlJ7dvQR3/CVwI+TqR7IFQwjNs
         4/AgoqhGDxAvbojcfJ2l9hAGMtRs0Rdr2XAPFr04vJGf5vW/lE+rp8Kb12UAAqSgZ+5p
         oqwWK9lszRLHFdBnD4jwxdN6JD2BlKVMwXcvtA/2FISaDJ3D6Y6JcCRaZcg+f4ikndl/
         Gqh16HYiqKSVVooKo0KOlad1N+d/rndLR2qXNIht0yM+c9h/CRHFfpOqOliHZ0dprC7+
         kEios7vtc/E11F8TTaBtaZta0aseamxE6DYJVPKQs13wS8GNgyHFgWZpvqz7vRvmz6Qn
         IeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4GkFSa2jrZzgbz/gqh1xwGH9rJ9K7aJcMA/+1N4wi5s=;
        fh=5WnyokqTb21Bp2QLkgTWPeVgWu4vjHSizUrAV3VZeVw=;
        b=QrE7kMgvyKdQ/HzcSEIHey2HMaWcDOAh4wVNDpJzVwhD7fNUh6cDGP8pXh7sCvfWPv
         fiNLWEhbhjVCOoLBGzMZJYf2ySsP4NYZJfjJNBeOZ8IGEwZX3hhyL9A3TIIlzqmRDh+7
         OQBGVzM0/955PD/932Ae3RzAAieQo8ZxNQrdK5Cg1T6aMXGJIfMUWHJTbpQHBQwF7aN6
         gxE8iNBcn9eD2fp+M8WHdVFCJNoDRugOOaVkf7MaGvpbKbohuZl1RJE7GuebmoTEDw/L
         ZoDypHKB+mfMFIItjba/EYMJTjppmxiYEMPbQi17MxpygaNufQ5HdfZESIpXfLa5wCqX
         QjYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775253586; x=1775858386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GkFSa2jrZzgbz/gqh1xwGH9rJ9K7aJcMA/+1N4wi5s=;
        b=iq99ap1IMXDPS1mgKbCPe5XiHYCPZXJf+TtBVlLBYdvWS3eiAXdoD0tQh+depgRoHG
         OLJ3R9z2Ci8iidTbXxWF3VDZdJsstT6s1rxVHUCw3/3/kbUZKFpePN7Vp6HGtB1aEp46
         HoVojKeLTWzRVYkCYtYLqPE+tW7E+EdzExyi3yeJPBBdV8L0sQteHPdegf20/qYoNqEc
         ZnwWetKO2guG6ik3613rRqO2pvoQ9Sl5AiP+cQt5ljvIhINXrmHDe61XPoHM/onVVovv
         WeZ3JtqgWniozHV2YhJTTNZkMZYdnCz+1lJkBXzbdXtG3Raz19dKajak+cNA8C8qoTju
         rCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775253586; x=1775858386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4GkFSa2jrZzgbz/gqh1xwGH9rJ9K7aJcMA/+1N4wi5s=;
        b=sbKKRjiZ8Faz8sT9gcucC9sGsFHFwIsefGtJVHbMj1rvVD99524qnPfsZsxkyOZsjy
         Xr8TDwNoBqmKxs/DkUfdzFdM0CpqwaY2xOskiDdlfXuFPCQtTq0gr9G694PV6Ewhc2gV
         tnOxm0nlZm2yqrh9ci/qZpHYb8shA/lnB4OjSwwjvqCayuYkMH2Xl9bb8yQBH1K1RPCd
         TDQhZZUCNJGtpVpjDK47GjTtJsi3NGAdrFd3lB1xJY1xz/4NfAxU/0KdFvGviY0X5Yc8
         k0B7ffl7rHi1W66uvMaURl5aqRG8As6wS6+Z+jHUedDOPdrMqWhDFSO7V8xCVCKE1mev
         sUSA==
X-Forwarded-Encrypted: i=1; AJvYcCVMf7k5y1wbbHvvYJtN30nfBk06DgzjuZ66PwqIK8/LtvjUU9i9i7mra4gIARiY/KYTia4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJuKhQwEhtJJv2sevx5l9kmEoUSG2chBgMigXMWRyO9gudaDBE
	VKych0ZbuT7myCFKzMZ1wHWgGQiYBjPfjNYsuuF764MOYHYDw1yjtjsZoXeTkcKp7Iid9rQfcMO
	MGxni2TNKMIn4yEsz6TMZ0jCN/fYAGvypdZig4wgp
X-Gm-Gg: AeBDieumU+cqELMJ2OiaSGM1GGC3F03/abFuEdm0z+PKE5D9lwlMgr+BgkMt9Gi8oUi
	G0exRWSFaUowAbXK/DOqpA25hoscaoglqDK852QmsY7Qpb+n5iFUVqnw7kIb9kwciSDScgp8tPH
	yUGDZFLt2EQ/KipoGeJITjRAciZl1j2ZeHcJT6BYKNwAVZRYy1jl1rPFrDUsL74OGZOXvf1CkvY
	Lclz4q8X8PF8h7pVSTi9L/BW37ukJqk4UEDjsnIbYSZOylWFyON+DCvwnomYej7K1GA1o4S+vVU
	G/eFqDA=
X-Received: by 2002:aa7:d44a:0:b0:66b:860f:3799 with SMTP id
 4fb4d7f45d1cf-66e43f30587mr33112a12.9.1775253585816; Fri, 03 Apr 2026
 14:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
 <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com> <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
 <20260403185236.sjgetnkha3o3a4d3@desk> <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
 <20260403213445.xzb4rxbfbg5un7li@desk>
In-Reply-To: <20260403213445.xzb4rxbfbg5un7li@desk>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 3 Apr 2026 14:59:33 -0700
X-Gm-Features: AQROBzD0pWuUvo6f_qTeW8GqTUWeF8BA-rGgdoyaTcRNJP0Ubn7CVfR-kLNpTZ0
Message-ID: <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
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

On Fri, Apr 3, 2026 at 2:34=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2026 at 01:19:17PM -0700, Jim Mattson wrote:
> > On Fri, Apr 3, 2026 at 11:52=E2=80=AFAM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > On Fri, Apr 03, 2026 at 11:10:08AM -0700, Jim Mattson wrote:
> > > > On Thu, Apr 2, 2026 at 5:32=E2=80=AFPM Pawan Gupta
> > > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > > >
> > > > > As a mitigation for BHI, clear_bhb_loop() executes branches that =
overwrite
> > > > > the Branch History Buffer (BHB). On Alder Lake and newer parts th=
is
> > > > > sequence is not sufficient because it doesn't clear enough entrie=
s. This
> > > > > was not an issue because these CPUs use the BHI_DIS_S hardware mi=
tigation
> > > > > in the kernel.
> > > > >
> > > > > Now with VMSCAPE (BHI variant) it is also required to isolate bra=
nch
> > > > > history between guests and userspace. Since BHI_DIS_S only protec=
ts the
> > > > > kernel, the newer CPUs also use IBPB.
> > > > >
> > > > > A cheaper alternative to the current IBPB mitigation is clear_bhb=
_loop().
> > > > > But it currently does not clear enough BHB entries to be effectiv=
e on newer
> > > > > CPUs with larger BHB. At boot, dynamically set the loop count of
> > > > > clear_bhb_loop() such that it is effective on newer CPUs too. Use=
 the
> > > > > X86_FEATURE_BHI_CTRL feature flag to select the appropriate loop =
count.
> > > > >
> > > > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > > > ---
> > > > >  arch/x86/entry/entry_64.S            |  8 +++++---
> > > > >  arch/x86/include/asm/nospec-branch.h |  2 ++
> > > > >  arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
> > > > >  3 files changed, 20 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.=
S
> > > > > index 3a180a36ca0e..bbd4b1c7ec04 100644
> > > > > --- a/arch/x86/entry/entry_64.S
> > > > > +++ b/arch/x86/entry/entry_64.S
> > > > > @@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
> > > > >         ANNOTATE_NOENDBR
> > > > >         push    %rbp
> > > > >         mov     %rsp, %rbp
> > > > > -       movl    $5, %ecx
> > > > > +
> > > > > +       movzbl    bhb_seq_outer_loop(%rip), %ecx
> > > > > +
> > > > >         ANNOTATE_INTRA_FUNCTION_CALL
> > > > >         call    1f
> > > > >         jmp     5f
> > > > > @@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
> > > > >          * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0=
xcc
> > > > >          * but some Clang versions (e.g. 18) don't like this.
> > > > >          */
> > > > > -       .skip 32 - 18, 0xcc
> > > > > -2:     movl    $5, %eax
> > > > > +       .skip 32 - 20, 0xcc
> > > > > +2:     movzbl  bhb_seq_inner_loop(%rip), %eax
> > > > >  3:     jmp     4f
> > > > >         nop
> > > > >  4:     sub     $1, %eax
> > > > > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/incl=
ude/asm/nospec-branch.h
> > > > > index 70b377fcbc1c..87b83ae7c97f 100644
> > > > > --- a/arch/x86/include/asm/nospec-branch.h
> > > > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > > > @@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
> > > > >  extern void update_spec_ctrl_cond(u64 val);
> > > > >  extern u64 spec_ctrl_current(void);
> > > > >
> > > > > +extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
> > > > > +
> > > > >  /*
> > > > >   * With retpoline, we must use IBRS to restrict branch predictio=
n
> > > > >   * before calling into firmware.
> > > > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bug=
s.c
> > > > > index 83f51cab0b1e..2cb4a96247d8 100644
> > > > > --- a/arch/x86/kernel/cpu/bugs.c
> > > > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > > > @@ -2047,6 +2047,10 @@ enum bhi_mitigations {
> > > > >  static enum bhi_mitigations bhi_mitigation __ro_after_init =3D
> > > > >         IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATIO=
N_AUTO : BHI_MITIGATION_OFF;
> > > > >
> > > > > +/* Default to short BHB sequence values */
> > > > > +u8 bhb_seq_outer_loop __ro_after_init =3D 5;
> > > > > +u8 bhb_seq_inner_loop __ro_after_init =3D 5;
> > > > > +
> > > > >  static int __init spectre_bhi_parse_cmdline(char *str)
> > > > >  {
> > > > >         if (!str)
> > > > > @@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations(void)
> > > > >                 x86_spec_ctrl_base &=3D ~SPEC_CTRL_MITIGATIONS_MA=
SK;
> > > > >         }
> > > > >
> > > > > +       /*
> > > > > +        * Switch to long BHB clear sequence on newer CPUs (with =
BHI_CTRL
> > > > > +        * support), see Intel's BHI guidance.
> > > > > +        */
> > > > > +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > > > > +               bhb_seq_outer_loop =3D 12;
> > > > > +               bhb_seq_inner_loop =3D 7;
> > > > > +       }
> > > > > +
> > > >
> > > > How does this work for VMs in a heterogeneous migration pool that
> > > > spans the Alder Lake boundary? They can't advertise BHI_CTRL, becau=
se
> > > > it isn't available on all hosts in the migration pool, but they nee=
d
> > > > the long sequence when running on Alder Lake or newer.
> > >
> > > As we discussed elsewhere, support for migration pool is much more
> > > involved. It should be dealt in a separate QEMU/KVM focused series.
> > >
> > > A quickfix could be adding support for spectre_bhi=3Dlong that guests=
 in a
> > > migration pool can use?
> >
> > The simplest solution is to add "|
> > cpu_feature_enabled(X86_FEATURE_HYPERVISOR)" to the condition above.
> > If that is unacceptable for the performance of pre-Alder Lake
>
> Yes, that would be unnecessary overhead.
>
> > migration pools, you could define a CPUID or MSR bit that says
> > explicitly, "long BHB flush sequence needed," rather than trying to
> > intuit that property from the presence of BHI_CTRL. Like
> > IA32_ARCH_CAPABILITIES.SKIP_L1DFL_VMENTRY, the bit would only be set
> > by a hypervisor.
>
> I will think about this more.
>
> > I am still skeptical of the need for MSR_VIRTUAL_ENUMERATION and
> > friends, unless there is a major guest OS out there that relies on
> > them.
>
> If we forget about MSR_VIRTUAL_ENUMERATION for a moment, userspace VMM is
> in the best position to decide whether a guest needs
> virtual.SPEC_CTRL[BHI_DIS_S]. Via a KVM interface userspace VMM can get
> BHI_DIS_S for the guests that are in migration pool?

That is not possible today, since KVM does not implement Intel's
IA32_SPEC_CTRL virtualization, and cedes the hardware IA32_SPEC_CTRL
to the guest after the first non-zero write to the guest's MSR.
