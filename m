Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E229D28F
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259611; cv=pass; b=bImGDltN9t7I7yEAP8VrIekzVsqNsmVejjbTnk+VcmThMhjQALE2VQfqzP8PeQ8ebkrz/ywDAkaPWzVSGbUyLJKOLRF12mOjvC0N6+XuZsEB3DPOxluCXZjfWAqCWLWSYi/gVGSGR7Zbl5i2XLDWRHUvRO19fh8zzz5Hz1pVIVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259611; c=relaxed/simple;
	bh=HcrCXVEhPGMRQ1VVj2TU6WqtVF29jKazA7i8frKk+vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXRjSLOKkuqdUxMT6VV3K5btAun180+vattiGBlgA0uga398r9hecfS8Jyu+bTT77KJxMqMIGfVAet+JcS+PLfXNEdrFi0tradD2ms1zJjT3geNvcHKSZ6FIjbUVVQe3Qj1wQ/Meuw+2wqC3f+nMrM2JXosVzIh5fZlDi+5BIG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPanP8/W; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPanP8/W"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso12160a12.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 16:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775259608; cv=none;
        d=google.com; s=arc-20240605;
        b=IC57/MPrMrbPx7RuJLBnHpyUkanRcssRabaCk4AsdSuy7v8t7xgWrgEc7m2+p1vR/E
         MYoyRCicaThM8qup6itjoTxVFjk2mVT70EUz/pALKAfqK/gUveyzPW1VLOYu2Z9+1iSM
         CGCMMLJzkjuaKSGPvwHxCaslhnVYCKDgYNgobSBMFF4P6CcikGIADG/7m3SsxgHLDxZC
         87m3REsLlSQ9nKosNgMw4ROoZwzypfi9/5SfaPToPwVYG4ptHwktgUrP8YkrOG8BtsvH
         taeh6V7m5dpYvuYheBgHy93upumsX54eQ5GFtx70cOrDIsUaEubYgSXHNU5pqpLkDjPs
         Qjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hcQ7pBBGQdT00MFQFDOu6XZRzM8maojAqkD2FxkveKM=;
        fh=QhqEhpZXI++Bs9eGI5lEbyBewJEY/hKo5jBqlkQ96AM=;
        b=RpR9gwPkAn3/fhtHMi7Ya56qk8KDYl0MoU+0IuCptXGuDDlybq/pMgdUOFKocjbS1v
         bK1GwsVx0Lq1Z6xcb3SD1lqfS5nIcEYgpeepDyHkvXuMgrys1PvMpDlsOP+EktnWqMH7
         oZJ4c2YSiRYs5699osgOzwyyOMRxxR7egdOYWSplnXLjKRVy1u2m6a72oLXjLYONgNzR
         CzoYc90GKPKIPq6En9Q3RnCW7rugXFSq2k5pwzUTT6Ea+6Gg+iNkxdpyCN0Yz7iezVaq
         FYwsN/Sv/FDH1ueYLspmPfs+Bgpp+tLeItgqQiYxXH6eXqYItbVwvPDACSb4Jix1mRJk
         aHTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775259608; x=1775864408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcQ7pBBGQdT00MFQFDOu6XZRzM8maojAqkD2FxkveKM=;
        b=tPanP8/Wku52brNPPJwPSZ7ayet4DtoZHU8ZMSUVvGWK4hbJ2OtYnX/WzSppIgy3Kb
         3v9I0XshJpQT0WvAU884LYUDA9Jk8RhvCfWUX+WDHPg6RedVYkHYGULMlSJn0/7swctc
         ogwj2rlrk16nZK5TZmRc4h/NeipJ3+xUF7FuUxQ9K2sa8R4CG1QaAbkryFPosDChlvpY
         /F6RI9WJPvIVYmPsuvGXsJDiMNLkCAf0A84C6eamnhBohLUwJ5uMqSXssJBxjYDMWxTO
         igSkphxX1OBLfajl6P53c0eWv6T+D7f+1e7FcCQJZGxD4xl4XRCDvzNBsBpBtBak0nVu
         q+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775259608; x=1775864408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hcQ7pBBGQdT00MFQFDOu6XZRzM8maojAqkD2FxkveKM=;
        b=R+LvvmkBIfY63cEBh8ciMhvE2qeBzg41BFpBVdyG1rYp+ShZvL8d6sE/DUTMhL07dK
         vYXKbrISwRbl9VSQ75V31Sun7RLBinYZFxpls6Rff2qJ1/rja6e2YIZAPNZAN1qu9W5K
         ynrFMeEkCyiwbpPyXt0AsN1ebyWa8IlOAil+6MwWhzya66r6+xVd7UbhFv4WuBjM0WGL
         5MJK4zYFUUA1hBMYRb46F2ai2x2ff/rjjGqyDWN28aCp/izEoKtIpqhXvUPU702DUO30
         mW1Qban+hAb74M2VIzXUXKafI3q+lqOPTiM+muyum/KojNlIS4klKqaMcsKsg5Sxoou4
         a3vA==
X-Forwarded-Encrypted: i=1; AJvYcCXhjMNwy1y50ML6dgma+fWCqNMYoxELBTPALEVcUtDmcYfOzV653uO2wfU3Ugdi24/EjB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv29nfxjsQoxsmNU+/BOssD90lBOJMLmW67kyWYjnB06VIzy3R
	62nwuThwYAVilbbNGx1HVVH2UajsgMYESaGsxuTQVKC36X2Zr+NE0QyRzIu4fuv2VUH8k9iUrmW
	ub3M4mdPgfIPMueFJdyyKqirtDwAjUs7KexOJDvpE
X-Gm-Gg: AeBDiesE1iLRhUxYT+AxSCyk66/LRDoPOZ364Br13ABiQ8qks2+MXsdas+dZtHsCkG5
	NLvZMuTqBwQ8lGSw3YY4YKIu0LHRSa2ewca3NNn/hef/XirCd2DRsoDjYEiqWVyIOtZYtVHXrBy
	ppYzqL2GLlr8G8ELgRJM4BrIxXmFuV257KdcO80zC4ACIF5zqTWSGEp2pNZJ54quywSMHX/wA6Y
	evf41Ku/pXxdOvjhauetAJIT6Bd6FqY2HX6IMuwoO0nBwnl/0R8V5lAp+f0uuR+d8Aw8VZb6rcs
	BMb7foSCy/mB2NBGWg==
X-Received: by 2002:a50:fa85:0:b0:66b:b4da:a8b0 with SMTP id
 4fb4d7f45d1cf-66e4136b3b3mr57100a12.8.1775259607451; Fri, 03 Apr 2026
 16:40:07 -0700 (PDT)
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
 <20260403231608.zopnhnypdclzqlx7@desk> <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk>
In-Reply-To: <20260403233329.fb2ppifgwm3um6ny@desk>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 3 Apr 2026 16:39:54 -0700
X-Gm-Features: AQROBzBwB-MmiVC9qntaiDO7zONP8-AQ5DjQ5a_dZ86oZYEi-UAJgB7XA5W8Af0
Message-ID: <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
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

On Fri, Apr 3, 2026 at 4:33=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2026 at 04:22:28PM -0700, Jim Mattson wrote:
> > On Fri, Apr 3, 2026 at 4:16=E2=80=AFPM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > On Fri, Apr 03, 2026 at 02:59:33PM -0700, Jim Mattson wrote:
> > > > On Fri, Apr 3, 2026 at 2:34=E2=80=AFPM Pawan Gupta
> > > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > > >
> > > > > On Fri, Apr 03, 2026 at 01:19:17PM -0700, Jim Mattson wrote:
> > > > > > On Fri, Apr 3, 2026 at 11:52=E2=80=AFAM Pawan Gupta
> > > > > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 03, 2026 at 11:10:08AM -0700, Jim Mattson wrote:
> > > > > > > > On Thu, Apr 2, 2026 at 5:32=E2=80=AFPM Pawan Gupta
> > > > > > > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > > > > > > >
> > > > > > > > > As a mitigation for BHI, clear_bhb_loop() executes branch=
es that overwrite
> > > > > > > > > the Branch History Buffer (BHB). On Alder Lake and newer =
parts this
> > > > > > > > > sequence is not sufficient because it doesn't clear enoug=
h entries. This
> > > > > > > > > was not an issue because these CPUs use the BHI_DIS_S har=
dware mitigation
> > > > > > > > > in the kernel.
> > > > > > > > >
> > > > > > > > > Now with VMSCAPE (BHI variant) it is also required to iso=
late branch
> > > > > > > > > history between guests and userspace. Since BHI_DIS_S onl=
y protects the
> > > > > > > > > kernel, the newer CPUs also use IBPB.
> > > > > > > > >
> > > > > > > > > A cheaper alternative to the current IBPB mitigation is c=
lear_bhb_loop().
> > > > > > > > > But it currently does not clear enough BHB entries to be =
effective on newer
> > > > > > > > > CPUs with larger BHB. At boot, dynamically set the loop c=
ount of
> > > > > > > > > clear_bhb_loop() such that it is effective on newer CPUs =
too. Use the
> > > > > > > > > X86_FEATURE_BHI_CTRL feature flag to select the appropria=
te loop count.
> > > > > > > > >
> > > > > > > > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > > > > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel=
.com>
> > > > > > > > > ---
> > > > > > > > >  arch/x86/entry/entry_64.S            |  8 +++++---
> > > > > > > > >  arch/x86/include/asm/nospec-branch.h |  2 ++
> > > > > > > > >  arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
> > > > > > > > >  3 files changed, 20 insertions(+), 3 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/e=
ntry_64.S
> > > > > > > > > index 3a180a36ca0e..bbd4b1c7ec04 100644
> > > > > > > > > --- a/arch/x86/entry/entry_64.S
> > > > > > > > > +++ b/arch/x86/entry/entry_64.S
> > > > > > > > > @@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
> > > > > > > > >         ANNOTATE_NOENDBR
> > > > > > > > >         push    %rbp
> > > > > > > > >         mov     %rsp, %rbp
> > > > > > > > > -       movl    $5, %ecx
> > > > > > > > > +
> > > > > > > > > +       movzbl    bhb_seq_outer_loop(%rip), %ecx
> > > > > > > > > +
> > > > > > > > >         ANNOTATE_INTRA_FUNCTION_CALL
> > > > > > > > >         call    1f
> > > > > > > > >         jmp     5f
> > > > > > > > > @@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
> > > > > > > > >          * This should be ideally be: .skip 32 - (.Lret2 =
- 2f), 0xcc
> > > > > > > > >          * but some Clang versions (e.g. 18) don't like t=
his.
> > > > > > > > >          */
> > > > > > > > > -       .skip 32 - 18, 0xcc
> > > > > > > > > -2:     movl    $5, %eax
> > > > > > > > > +       .skip 32 - 20, 0xcc
> > > > > > > > > +2:     movzbl  bhb_seq_inner_loop(%rip), %eax
> > > > > > > > >  3:     jmp     4f
> > > > > > > > >         nop
> > > > > > > > >  4:     sub     $1, %eax
> > > > > > > > > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/=
x86/include/asm/nospec-branch.h
> > > > > > > > > index 70b377fcbc1c..87b83ae7c97f 100644
> > > > > > > > > --- a/arch/x86/include/asm/nospec-branch.h
> > > > > > > > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > > > > > > > @@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_cu=
rrent);
> > > > > > > > >  extern void update_spec_ctrl_cond(u64 val);
> > > > > > > > >  extern u64 spec_ctrl_current(void);
> > > > > > > > >
> > > > > > > > > +extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
> > > > > > > > > +
> > > > > > > > >  /*
> > > > > > > > >   * With retpoline, we must use IBRS to restrict branch p=
rediction
> > > > > > > > >   * before calling into firmware.
> > > > > > > > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel=
/cpu/bugs.c
> > > > > > > > > index 83f51cab0b1e..2cb4a96247d8 100644
> > > > > > > > > --- a/arch/x86/kernel/cpu/bugs.c
> > > > > > > > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > > > > > > > @@ -2047,6 +2047,10 @@ enum bhi_mitigations {
> > > > > > > > >  static enum bhi_mitigations bhi_mitigation __ro_after_in=
it =3D
> > > > > > > > >         IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_M=
ITIGATION_AUTO : BHI_MITIGATION_OFF;
> > > > > > > > >
> > > > > > > > > +/* Default to short BHB sequence values */
> > > > > > > > > +u8 bhb_seq_outer_loop __ro_after_init =3D 5;
> > > > > > > > > +u8 bhb_seq_inner_loop __ro_after_init =3D 5;
> > > > > > > > > +
> > > > > > > > >  static int __init spectre_bhi_parse_cmdline(char *str)
> > > > > > > > >  {
> > > > > > > > >         if (!str)
> > > > > > > > > @@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations=
(void)
> > > > > > > > >                 x86_spec_ctrl_base &=3D ~SPEC_CTRL_MITIGA=
TIONS_MASK;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > +       /*
> > > > > > > > > +        * Switch to long BHB clear sequence on newer CPU=
s (with BHI_CTRL
> > > > > > > > > +        * support), see Intel's BHI guidance.
> > > > > > > > > +        */
> > > > > > > > > +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > > > > > > > > +               bhb_seq_outer_loop =3D 12;
> > > > > > > > > +               bhb_seq_inner_loop =3D 7;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > >
> > > > > > > > How does this work for VMs in a heterogeneous migration poo=
l that
> > > > > > > > spans the Alder Lake boundary? They can't advertise BHI_CTR=
L, because
> > > > > > > > it isn't available on all hosts in the migration pool, but =
they need
> > > > > > > > the long sequence when running on Alder Lake or newer.
> > > > > > >
> > > > > > > As we discussed elsewhere, support for migration pool is much=
 more
> > > > > > > involved. It should be dealt in a separate QEMU/KVM focused s=
eries.
> > > > > > >
> > > > > > > A quickfix could be adding support for spectre_bhi=3Dlong tha=
t guests in a
> > > > > > > migration pool can use?
> > > > > >
> > > > > > The simplest solution is to add "|
> > > > > > cpu_feature_enabled(X86_FEATURE_HYPERVISOR)" to the condition a=
bove.
> > > > > > If that is unacceptable for the performance of pre-Alder Lake
> > > > >
> > > > > Yes, that would be unnecessary overhead.
> > > > >
> > > > > > migration pools, you could define a CPUID or MSR bit that says
> > > > > > explicitly, "long BHB flush sequence needed," rather than tryin=
g to
> > > > > > intuit that property from the presence of BHI_CTRL. Like
> > > > > > IA32_ARCH_CAPABILITIES.SKIP_L1DFL_VMENTRY, the bit would only b=
e set
> > > > > > by a hypervisor.
> > > > >
> > > > > I will think about this more.
> > > > >
> > > > > > I am still skeptical of the need for MSR_VIRTUAL_ENUMERATION an=
d
> > > > > > friends, unless there is a major guest OS out there that relies=
 on
> > > > > > them.
> > > > >
> > > > > If we forget about MSR_VIRTUAL_ENUMERATION for a moment, userspac=
e VMM is
> > > > > in the best position to decide whether a guest needs
> > > > > virtual.SPEC_CTRL[BHI_DIS_S]. Via a KVM interface userspace VMM c=
an get
> > > > > BHI_DIS_S for the guests that are in migration pool?
> > > >
> > > > That is not possible today, since KVM does not implement Intel's
> > > > IA32_SPEC_CTRL virtualization, and cedes the hardware IA32_SPEC_CTR=
L
> > > > to the guest after the first non-zero write to the guest's MSR.
> > >
> > > Yes, KVM doesn't support it yet. But, adding that support to give mor=
e
> > > control to userspace VMM helps this case, and probably many other in
> > > the future.
> >
> > But didn't you tell me that Windows doesn't want the hypervisor to set
> > BHI_DIS_S behind their back?
>
> Since cloud providers have greater control over userspace, the decision t=
o
> use BHI_DIS_S or not can be left to them. KVM would simply follow what it
> is asked to do by the userspace.

I feel like we've gone over this before, but if userspace tells KVM
not to enable BHI_DIS_S, how do we inform Windows that it needs to do
the longer clearing sequence, despite the fact that the virtual CPU is
masquerading as Ice Lake?

I don't think the virtual mitigation MSRs address that issue.

> > > I will check with Chao if he can prepare the next version of virtual
> > > SPEC_CTRL series (leaving out virtual mitigation MSRs).
> >
> > Excellent.
