Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE64738F956
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775258567; cv=pass; b=ad6PmjQzSU8X0QfImyd6UOoYacb/NNFAR/tIVHUfjjNSpln3wZvbdlioxE2MXEau7Gi602GL2zgQDuT2lUG6my+gwQdPQFjcfKmkDcHEaCtiZg6dkNZMMNSMwwkJbFIfYnDDpq7taObysYcbbyWhLTavTHcUO4MKW51/8ehIFJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775258567; c=relaxed/simple;
	bh=5ha26Itsrk1we0z4g/15zsHRq/Q6+Nd3OhVvBZghBLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTN/Cqg8iUmfeNWdDMCcQO/cb+Q3x3fL5GWZlmtd7PiVDgglVuIrZgrnYHYH9uwfwNzn5q5t6NaMaHuoZ6dqPHCIJzMNm4B5evaIfhyLLoWDP7jctA8s+166iWfTkFOFPj/s1TjSGhz+X7QAheaK7lLXPCE8pFB5yPLrBP/qAb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dwVdFK9u; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwVdFK9u"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so15346a12.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 16:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775258564; cv=none;
        d=google.com; s=arc-20240605;
        b=H2qvULI+fNDHOfwFagcwyu3p9Ho29HReJb5xX19Nz5hROpxPit7+XtSobV0i9+WtdA
         2lAkPOcaSozPMVZyXLaA37m9Z2fBysRkXLcAY6PhxZ60kM2tG2MuzFp5bp8AKyhMXipq
         qvs5EbpQlQ+FatdWMzLRpK7jc3eZxRu7jHx3nZzhQ0BtDt6BYYiem9fwKAONH/OPGpTX
         VhNTqevvo93txS48/mJgUDP3u9YlAUL6B41cZDaEZeMx+B0Pkm8KMxaVfsl3mecIWPLo
         NbBMT3LmC0BuEOGet5rNfIqY3RzU6b0QRsJdnUuSBlZAKeMf3acrfHdgxBS8OGDiRt8a
         IHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u3rtAvIvVBacn8fCtsxK6Q16SI3iclsRvlQKxK9ic18=;
        fh=jynsPFA9ydkQC6WCu8Y/A03GIKzdY2amWDP9XfG1mXI=;
        b=ZRzOJz4ceQO+10dkuD1UwE3lunkIwZ0vgmHAOc4F3b5vXVQRSa3MOkFFoXzEx1pVQv
         KuagOnCT4TyB1sk7EXZg4kMEz0gJANLZbAURkSuYPnl7sRbF5XBMhc7DcHsm4YGoqzd1
         l+qUX9qAE6BhR6R3Fm4A0C4ryDms3PyInECkZ6OgBKQtAYl7FJ75307SCaDWHzsiKwZw
         m79fOvAXefhpdYDzNZkQQbapZ8Dtmu4rWiEs4p6aqJ2BbhdLdaEX5Kd9UIh12A38hIQV
         GgzWhJQhk5gCtKOWWpkmhO/rUc8pcJkWUIYGjwUoLBf6cNb5P7vD9XMK3CxDc0pjoX5p
         q0YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775258564; x=1775863364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3rtAvIvVBacn8fCtsxK6Q16SI3iclsRvlQKxK9ic18=;
        b=dwVdFK9uGQM05UwOIVXgiEmwS7Gpwagus3F7nNsIWzjbkm3v1km3f3Ji8MHY3VHAPm
         TeiJQFiH7XxLbFgdd4oH1LG30PLyWSF5nZ1kKWsSO+oB+UPMoPknGoHhIns+Nh8+kszu
         /uTywAfN8r8SlmC6HGP2OBx/EGl93PR8QWMT4Fo4QHZighyFqHmK79nOVdlcdW69hioX
         IQ1KG+la9br0DKAqMErIYtshg3pa6pphA+YrVQYHHDHt9GrDO+URY3PuJdzRdFmJmLm8
         p04YDFusCpq+D2KBG1O8+4Bcmu7M7M1hXjb1ttwUem+gqDQyUrg+5Xu4V66ls8aVQOa/
         ougA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775258564; x=1775863364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u3rtAvIvVBacn8fCtsxK6Q16SI3iclsRvlQKxK9ic18=;
        b=Un//5ZZ9TqAq6oeF9loGSDohyY7rmr35i1YcTrl+0H8QW5IgrKho5wOfpcY5jEChqN
         7sQQvZdpVL1OrQ2PcWbPzNuLpAef4MLnOHzrQGgYk3F0+sDFBr4XHWf8MeiElsVDfENW
         HvT4eyC+1l6wHdLdhBlwkb2nxCvEVxG1H+7AzDQePGbzUTfLajhuXRsU+m9FFsx2pgI+
         NDhexdQUTVKSQLmp62xLruZhv5jrFFwi9j61WThOs8MUTRx6hwyCoqniEjku2LfqtzwY
         B/x5hKchI/mPmzGzRIg2bzp20aN+BIST+3+2k4bh7x1JMf+CW5l+LyPhtsz0j49SvrXA
         Xe/g==
X-Forwarded-Encrypted: i=1; AJvYcCWMqdVcUTahUIlz1dcMpxNI3PcAIgb6iQjBYXKNhQZMnqdCOBLaGRrn2PdKlxPm9mRVLvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKiLC1k3OKbt90nbxSuw+ttkQBv9y7qb3nmQvu6IZF5uMwqudf
	TW4uMlo7PogTlaslKLMVMJTNkSEPVgUAeXqA2W8ZnuY7+FLBlHXRZsoWBD164dabWnTvB9MMhMB
	esmWOK5QCb7qkx7rI2SrzCMs/px6VJUIfDhJhkMA5
X-Gm-Gg: AeBDietWt16Rw99pTcSx5Rrt66Z9yutC1746cA+kkxeoni7bJFozGFhsMTRMRIibHh4
	q51VlrBtfN0jLJ5s9KDGN1V4uDFvQxRg5QgHzBnJwsUby30uDiA2g5AaX6pIc7CuRxS9FZbR9pP
	G51UXuq3SARn749An8OI3UV+d/x7tirkUpS5eC0j2qrwLzq/Ym0fdQjOIolK2VwZ9BI7S0OIIu6
	L+mgQZ0f/YjepqqZk+Azo6ICbXgWsJDOJ/VCpFCg8K6L73mPsk4B7U0U2E5uQGw99dhhElxAxR4
	33qUw5s=
X-Received: by 2002:aa7:cfc8:0:b0:66c:309b:243b with SMTP id
 4fb4d7f45d1cf-66e43ce15ddmr28797a12.1.1775258563658; Fri, 03 Apr 2026
 16:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
 <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com> <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
 <20260403185236.sjgetnkha3o3a4d3@desk> <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
 <20260403213445.xzb4rxbfbg5un7li@desk> <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
 <20260403231608.zopnhnypdclzqlx7@desk>
In-Reply-To: <20260403231608.zopnhnypdclzqlx7@desk>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 3 Apr 2026 16:22:28 -0700
X-Gm-Features: AQROBzDbM3KZyF-NHHTCgXNIMcFvHYIysNjC-tVAW-RoWsiBLJTzU6zFbRUlRWk
Message-ID: <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
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
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 4:16=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2026 at 02:59:33PM -0700, Jim Mattson wrote:
> > On Fri, Apr 3, 2026 at 2:34=E2=80=AFPM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > On Fri, Apr 03, 2026 at 01:19:17PM -0700, Jim Mattson wrote:
> > > > On Fri, Apr 3, 2026 at 11:52=E2=80=AFAM Pawan Gupta
> > > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > > >
> > > > > On Fri, Apr 03, 2026 at 11:10:08AM -0700, Jim Mattson wrote:
> > > > > > On Thu, Apr 2, 2026 at 5:32=E2=80=AFPM Pawan Gupta
> > > > > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > > > > >
> > > > > > > As a mitigation for BHI, clear_bhb_loop() executes branches t=
hat overwrite
> > > > > > > the Branch History Buffer (BHB). On Alder Lake and newer part=
s this
> > > > > > > sequence is not sufficient because it doesn't clear enough en=
tries. This
> > > > > > > was not an issue because these CPUs use the BHI_DIS_S hardwar=
e mitigation
> > > > > > > in the kernel.
> > > > > > >
> > > > > > > Now with VMSCAPE (BHI variant) it is also required to isolate=
 branch
> > > > > > > history between guests and userspace. Since BHI_DIS_S only pr=
otects the
> > > > > > > kernel, the newer CPUs also use IBPB.
> > > > > > >
> > > > > > > A cheaper alternative to the current IBPB mitigation is clear=
_bhb_loop().
> > > > > > > But it currently does not clear enough BHB entries to be effe=
ctive on newer
> > > > > > > CPUs with larger BHB. At boot, dynamically set the loop count=
 of
> > > > > > > clear_bhb_loop() such that it is effective on newer CPUs too.=
 Use the
> > > > > > > X86_FEATURE_BHI_CTRL feature flag to select the appropriate l=
oop count.
> > > > > > >
> > > > > > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com=
>
> > > > > > > ---
> > > > > > >  arch/x86/entry/entry_64.S            |  8 +++++---
> > > > > > >  arch/x86/include/asm/nospec-branch.h |  2 ++
> > > > > > >  arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
> > > > > > >  3 files changed, 20 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry=
_64.S
> > > > > > > index 3a180a36ca0e..bbd4b1c7ec04 100644
> > > > > > > --- a/arch/x86/entry/entry_64.S
> > > > > > > +++ b/arch/x86/entry/entry_64.S
> > > > > > > @@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
> > > > > > >         ANNOTATE_NOENDBR
> > > > > > >         push    %rbp
> > > > > > >         mov     %rsp, %rbp
> > > > > > > -       movl    $5, %ecx
> > > > > > > +
> > > > > > > +       movzbl    bhb_seq_outer_loop(%rip), %ecx
> > > > > > > +
> > > > > > >         ANNOTATE_INTRA_FUNCTION_CALL
> > > > > > >         call    1f
> > > > > > >         jmp     5f
> > > > > > > @@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
> > > > > > >          * This should be ideally be: .skip 32 - (.Lret2 - 2f=
), 0xcc
> > > > > > >          * but some Clang versions (e.g. 18) don't like this.
> > > > > > >          */
> > > > > > > -       .skip 32 - 18, 0xcc
> > > > > > > -2:     movl    $5, %eax
> > > > > > > +       .skip 32 - 20, 0xcc
> > > > > > > +2:     movzbl  bhb_seq_inner_loop(%rip), %eax
> > > > > > >  3:     jmp     4f
> > > > > > >         nop
> > > > > > >  4:     sub     $1, %eax
> > > > > > > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/=
include/asm/nospec-branch.h
> > > > > > > index 70b377fcbc1c..87b83ae7c97f 100644
> > > > > > > --- a/arch/x86/include/asm/nospec-branch.h
> > > > > > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > > > > > @@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_curren=
t);
> > > > > > >  extern void update_spec_ctrl_cond(u64 val);
> > > > > > >  extern u64 spec_ctrl_current(void);
> > > > > > >
> > > > > > > +extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
> > > > > > > +
> > > > > > >  /*
> > > > > > >   * With retpoline, we must use IBRS to restrict branch predi=
ction
> > > > > > >   * before calling into firmware.
> > > > > > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu=
/bugs.c
> > > > > > > index 83f51cab0b1e..2cb4a96247d8 100644
> > > > > > > --- a/arch/x86/kernel/cpu/bugs.c
> > > > > > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > > > > > @@ -2047,6 +2047,10 @@ enum bhi_mitigations {
> > > > > > >  static enum bhi_mitigations bhi_mitigation __ro_after_init =
=3D
> > > > > > >         IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIG=
ATION_AUTO : BHI_MITIGATION_OFF;
> > > > > > >
> > > > > > > +/* Default to short BHB sequence values */
> > > > > > > +u8 bhb_seq_outer_loop __ro_after_init =3D 5;
> > > > > > > +u8 bhb_seq_inner_loop __ro_after_init =3D 5;
> > > > > > > +
> > > > > > >  static int __init spectre_bhi_parse_cmdline(char *str)
> > > > > > >  {
> > > > > > >         if (!str)
> > > > > > > @@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations(voi=
d)
> > > > > > >                 x86_spec_ctrl_base &=3D ~SPEC_CTRL_MITIGATION=
S_MASK;
> > > > > > >         }
> > > > > > >
> > > > > > > +       /*
> > > > > > > +        * Switch to long BHB clear sequence on newer CPUs (w=
ith BHI_CTRL
> > > > > > > +        * support), see Intel's BHI guidance.
> > > > > > > +        */
> > > > > > > +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > > > > > > +               bhb_seq_outer_loop =3D 12;
> > > > > > > +               bhb_seq_inner_loop =3D 7;
> > > > > > > +       }
> > > > > > > +
> > > > > >
> > > > > > How does this work for VMs in a heterogeneous migration pool th=
at
> > > > > > spans the Alder Lake boundary? They can't advertise BHI_CTRL, b=
ecause
> > > > > > it isn't available on all hosts in the migration pool, but they=
 need
> > > > > > the long sequence when running on Alder Lake or newer.
> > > > >
> > > > > As we discussed elsewhere, support for migration pool is much mor=
e
> > > > > involved. It should be dealt in a separate QEMU/KVM focused serie=
s.
> > > > >
> > > > > A quickfix could be adding support for spectre_bhi=3Dlong that gu=
ests in a
> > > > > migration pool can use?
> > > >
> > > > The simplest solution is to add "|
> > > > cpu_feature_enabled(X86_FEATURE_HYPERVISOR)" to the condition above=
.
> > > > If that is unacceptable for the performance of pre-Alder Lake
> > >
> > > Yes, that would be unnecessary overhead.
> > >
> > > > migration pools, you could define a CPUID or MSR bit that says
> > > > explicitly, "long BHB flush sequence needed," rather than trying to
> > > > intuit that property from the presence of BHI_CTRL. Like
> > > > IA32_ARCH_CAPABILITIES.SKIP_L1DFL_VMENTRY, the bit would only be se=
t
> > > > by a hypervisor.
> > >
> > > I will think about this more.
> > >
> > > > I am still skeptical of the need for MSR_VIRTUAL_ENUMERATION and
> > > > friends, unless there is a major guest OS out there that relies on
> > > > them.
> > >
> > > If we forget about MSR_VIRTUAL_ENUMERATION for a moment, userspace VM=
M is
> > > in the best position to decide whether a guest needs
> > > virtual.SPEC_CTRL[BHI_DIS_S]. Via a KVM interface userspace VMM can g=
et
> > > BHI_DIS_S for the guests that are in migration pool?
> >
> > That is not possible today, since KVM does not implement Intel's
> > IA32_SPEC_CTRL virtualization, and cedes the hardware IA32_SPEC_CTRL
> > to the guest after the first non-zero write to the guest's MSR.
>
> Yes, KVM doesn't support it yet. But, adding that support to give more
> control to userspace VMM helps this case, and probably many other in
> the future.

But didn't you tell me that Windows doesn't want the hypervisor to set
BHI_DIS_S behind their back?

> I will check with Chao if he can prepare the next version of virtual
> SPEC_CTRL series (leaving out virtual mitigation MSRs).

Excellent.
