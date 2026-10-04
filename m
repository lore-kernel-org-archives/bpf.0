Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC309476056
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136374; cv=pass; b=uX7dTxSeGW4mu9rWZJbziKaKcE/ST7m4S74QeH9DnCpFJRkEgV10VgwVvJECGeTRYztFNirbdEwCEn9/9H1HXMnKz9vHU31qYswnmYx8CoevruP1zZ2VASu1+CHw1xfSxd0jBGRRLOA9GU8PHgaSIgiSQIEogwAaJb8qq4Sacl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136374; c=relaxed/simple;
	bh=eeYCgGHTFzo+FfXl1bPEgHkObEBq9XqafHlu3/JsXdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZHFgQaUkVU7U+Bq95jOA9OUyvANl8wsSfDGkcAy4WQVcLrgsih76A7vHnJOlpRajYZundd4mQrDXxqIfPY4Qu0uSq2KpQp/ZvZrWT2C4OW65D2kVy5e3I5JA6PaHxzdxy4xybWL7U6XOsTHda5OSzxekWIOC5AygwPqNTKeB3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kzwMZD3k; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kzwMZD3k"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5351f9dbfe0so97441cf.1
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 10:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791136366; cv=none;
        d=google.com; s=arc-20260327;
        b=pPTAfSjmHYNx9QQsO/rTn8TwtelizLVEOznJICD8IeVeEXtGt7p8qKDvac9+ZGsMYJ
         oc2ZaG1GvOjG1OkoUN4xgUOIWt3/3Y8P4a1HJF+iXaWTCyHGzTHIMFOYeJ1iamixEjnK
         a0H5Do5N/o7s+7t4h5N5XmUfNoBKxb5kX7xk0O2m2vkD0Bz32DoNJoierByCc+uVs6BH
         FyqjfDpWTRgisbbUht/dupu8FP7YXj4+CqxLnwWPc4QoeW1AiRvWENJj2eAZdiNKjADD
         qxdOIfDMq6yU5rw7hfN/CQSn95iFIWC/hftzPidzMGK9jOOnUD0fniFZzkVNr36Sabsc
         56SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hGuGLrOvm4LeUyfXJ5B4JaitM98XinzaQN/wjAvVcwQ=;
        fh=WQnrsrxteLuc1aOsK4KyDjB4ZjK6rurNs1jleoVfAtI=;
        b=ZAilcfbbMe3gP4lx7gsiwkndjrcTRpIEEahpUFwDwn+FM85IRx+flRw5NZmN7m6sIP
         ZSTRlB1DyK0r2i/0j9jnXT93HUXJlExEiX0t7e0YtD9JhMd/TiqzY+NiMZ99w2u5f+12
         yCidrj0ntKI/f887W01FQPLoUd0ylh1LqzmL9ONfyY7FP5hOtDYciBd2tpyaQWuWxCT7
         GiWApnuXLLATChRtYyl5+RrRtKBjJPWuso/krqjWey0BzeKGnVbDZh8KhZjI3L4Q91nK
         +TkaAOy7W+kTf6LX54PecCEMpxdr7MQwqCTcrd0ndVykjB8mHzlQDN8N1MJkQy07hyMv
         E3Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791136366; x=1791741166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hGuGLrOvm4LeUyfXJ5B4JaitM98XinzaQN/wjAvVcwQ=;
        b=kzwMZD3kfc4fIYHOruKXdKxO9jRjUjuKordjpj1PZF9jSbHJ5Ak/XWrWDguvla/xlM
         XNFM4sINFOvo+P0U1Xy9oatg/8C0iscWBPVbNpHiz/ErzUkz0SNjs8K/shPl0hbk4DQ+
         JWHbY3W8aB73mg5QT2DweBFkB6GPY6R8jbgx68ibnPnboUgk2FXOqi5cakvtvjI0OHM4
         2rELFRuWPvrUn/QeEgexG+8vqgvd2n/T2CGQ+g2g399H50imBV8T7QUS+GS04KCfT0SA
         6IEVS6skP+YyL2qhxAIVMVq+epcJr1WHuuQg7pra0aHkHO2DAY/mktRMTMNJmsjmOeOA
         NWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791136366; x=1791741166;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hGuGLrOvm4LeUyfXJ5B4JaitM98XinzaQN/wjAvVcwQ=;
        b=EfeNsPwadO28CSFeMPXsYTEGPlB+NWMMsCPmvC8FARXSVpCGa8iiDaL2AaJIDh0UK+
         CjpUrbZXQbBIcNWPeYGIvl8IMH78dtzCKYzC/OpiHgV/g6uOM2RuU/+A9ZJ9Vc/T2bkj
         vECM6jRaR/T9HieW9IaNbqiUwUYaHv5ZWtdnEi/IpmVXw2WIWhdmDgOHHzMHmWp2kOdB
         qyy9FJ+GPYzqwOHLNIigCByJJgXOZc/b3jEzEB+RKXuILbWLQ1XdbID1pV4iwwFqHcYO
         EZRMBOmuXGhuxOVi+II8C2wyP15lXbaQ1BSc/xUMCh5uGaClIz+mPBTh4X33ejYeWSW0
         rWEQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9Gewm0T5+8OGLzpcBVP5fpD64eXeBt9R912mY2lW7ECtdq8gT5OOIC+WTXyRHNHX7180=@vger.kernel.org
X-Gm-Message-State: AFuF++kIEmwvWjllD8V5MtwgoX09eix9q4CMbTfVB+ac9kFT8DOx2Yu1
	kERGhgMDRbWiU72mO+9bE6BU33xRPqaqx9hbcSP+d9qd9oJc/NGrf7+ETtOR/7I2DzmkTKKsoZ+
	8EegJfXhp47+wvoAqDfmTdm1H5gCyLFM8sDvzPT8G
X-Gm-Gg: AYBFou3PedOHXPFTiSH6DaCpjSQXbMHXXI1TY/uJot8a4aTCnx9mCVZ3AnJH3WPkwy+
	3kHXbMM4QlG1le6E0dMh3YQZcDL7eQedoDLkvXygRi9CyN9NMOUqWSC8pFv4EvQcLwMRQ51CLdR
	gOfuO/z+OXUjTfsxBzeiwtewFoft8ptX4Rw72qsu2ub0goCQ8e+iPYu64GRSU1t+1wc1KTFRaME
	KwJ9dsBzFM49JhMdhbabHKauxDWb2Uxpy2RSdz/YXS+L/9Nr1zRC62Gr+FBZu8AvPXNTdMYylzV
	AM9El4FLP+TEkXeHBSRD8Tx3Cx+GvZIphblwDwoUWkHNtY7O2yPUoieLjw==
X-Received: by 2002:ac8:7fd1:0:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-535143a7ee5mr16757211cf.0.1791136364655; Sun, 04 Oct 2026
 10:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-16-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-16-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:52:33 -0700
X-Gm-Features: AclHuK97kMRDYoB6lQW3TrcrLHtwyxFXHppfod8Uz1hqyRH7vKfp8a9EoRVxxRQ
Message-ID: <CAJuCfpHQwLZiXqsC2BsC6tUACJOMFfyLp9KC2w22NnzM5Ncrmg@mail.gmail.com>
Subject: Re: [PATCH v4 16/38] mm/vma: add and use vma_[flags]_is_fixed_mapping
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:38=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> This determines whether a VMA cannot be expanded or merged because what
> they mapped was determined to be a set size at mmap time.
>
> This typically refers to mappings not managed by core mm, however
> VMA_DONTEXPAND_BIT
> is not reliably set alongside VMA_PFNMAP_BIT or VMA_MIXEDMAP_BIT, so we
> must explicitly test for this for now.
>
> We also explicitly test for VMA_PFNMAP_BIT as VMA_DONTEXPAND_BIT may not =
be
> set for VMA_PFNMAP_BIT's despite the one implying the other.
>
> Use this predicate in vma_flags_can_merge() and in check_prep_vma() in th=
e
> mremap logic testing to see if mremap() can expand the VMA. The criteria
> for khugepaged and MADV_COLLAPSE eligibility in
> __thp_vma_allowable_orders() are precisely those for mergeability, so use
> vma_can_merge() there (with an expanded comment).
>
> This obviates the need for the VM_NO_KHUGEPAGED mask, so remove it.
>
> Hugetlb VMAs remain excluded from khugepaged as hugetlbfs always sets
> VMA_DONTEXPAND_BIT.
>
> Also update the userland VMA tests to reflect the change.
>
> No functional change intended.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  include/linux/mm.h              | 39 +++++++++++++++++++++++++++++++++++=
----
>  mm/huge_memory.c                | 11 +++++++----
>  mm/mremap.c                     |  5 ++---
>  tools/testing/vma/include/dup.h | 16 +++++++++++++++-
>  4 files changed, 59 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 83953757735a..6b5f06cd174a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -600,9 +600,6 @@ enum {
>  #define VMA_REMAP_FLAGS mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT,       \
>                                      VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT=
)
>
> -/* This mask prevents VMA from being scanned with khugepaged */
> -#define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
> -
>  /* This mask defines which mm->def_flags a process can inherit its paren=
t */
>  #define VM_INIT_DEF_MASK       VM_NOHUGEPAGE
>
> @@ -1647,6 +1644,40 @@ static inline bool vma_is_mm_managed(const struct =
vm_area_struct *vma)
>         return vma_flags_is_mm_managed(&vma->flags);
>  }
>
> +/**
> + * vma_flags_is_fixed_mapping() - Do the specified VMA flags indicate th=
at this
> + * is a fixed mapping that cannot be expanded or merged?
> + * @flags: The VMA flags to test.
> + *
> + * Fixed mappings are those whose size is set at the point of mmap (for
> + * instance, a mapping of a fixed range of memory established by a drive=
r),
> + * and thus cannot be expanded or merged.
> + *
> + * Returns: true if the flags indicate a fixed mapping.
> + */
> +static inline bool vma_flags_is_fixed_mapping(const vma_flags_t *flags)
> +{
> +       /*
> +        * VMA_PFNMAP_BIT should imply VMA_DONTEXPAND_BIT, but some calle=
rs set
> +        * only the former.
> +        */
> +       return vma_flags_test_any(flags, VMA_PFNMAP_BIT, VMA_DONTEXPAND_B=
IT);
> +}
> +
> +/**
> + * vma_is_fixed_mapping() - Is this VMA a fixed mapping that cannot be
> + * expanded or merged?
> + * @vma: The VMA to test.
> + *
> + * See vma_flags_is_fixed_mapping() for a description of this property.
> + *
> + * Returns: true if the VMA maps a fixed mapping.
> + */
> +static inline bool vma_is_fixed_mapping(const struct vm_area_struct *vma=
)
> +{
> +       return vma_flags_is_fixed_mapping(&vma->flags);
> +}
> +
>  /**
>   * vma_flags_can_merge() - Do the specified VMA flags permit the VMA to =
be
>   * merged with another?
> @@ -1668,7 +1699,7 @@ static inline bool vma_flags_can_merge(const vma_fl=
ags_t *flags)
>         if (!vma_flags_is_mm_managed(flags))
>                 return false;
>         /* VMA explicitly marked as being unmergeable. */
> -       if (vma_flags_test(flags, VMA_DONTEXPAND_BIT))
> +       if (vma_flags_is_fixed_mapping(flags))
>                 return false;
>
>         return true;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4cd917f77f3f..87e8bf8029ab 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -212,11 +212,14 @@ unsigned long __thp_vma_allowable_orders(struct vm_=
area_struct *vma,
>                 return in_pf ? orders : 0;
>
>         /*
> -        * khugepaged special VMA and hugetlb VMA.
> -        * Must be checked after dax since some dax mappings may have
> -        * VM_MIXEDMAP set.
> +        * khugepaged moves data from VMAs once collapsed, after they hav=
e been
> +        * faulted in, relying on refaulting for file-backed memory.
> +        *
> +        * Mappings not managed by core mm cannot be reliably reconstruct=
ed from
> +        * page faults, and fixed mappings (including hugetlb) may well b=
e
> +        * mm-managed - precisely the mappings which cannot be merged.
>          */
> -       if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
> +       if (!in_pf && !smaps && !vma_can_merge(vma))
>                 return 0;
>
>         /*
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 7c368440fafe..ed19b47c2caf 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1788,8 +1788,7 @@ static int check_prep_vma(struct vma_remap_struct *=
vrm)
>                 return -EINVAL;
>         }
>
> -       if ((vrm->flags & MREMAP_DONTUNMAP) &&
> -           vma_test_any(vma, VMA_DONTEXPAND_BIT, VMA_PFNMAP_BIT))
> +       if ((vrm->flags & MREMAP_DONTUNMAP) && vma_is_fixed_mapping(vma))
>                 return -EINVAL;
>
>         /*
> @@ -1827,7 +1826,7 @@ static int check_prep_vma(struct vma_remap_struct *=
vrm)
>         if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
>                 return -EINVAL;
>
> -       if (vma_test_any(vma, VMA_DONTEXPAND_BIT, VMA_PFNMAP_BIT))
> +       if (vma_is_fixed_mapping(vma))
>                 return -EFAULT;
>
>         if (!mlock_future_ok(mm, vma_test(vma, VMA_LOCKED_BIT), vrm->delt=
a))
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 89c645a6ad60..442ea9eb098d 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -1676,6 +1676,20 @@ static inline bool vma_is_mm_managed(const struct =
vm_area_struct *vma)
>         return vma_flags_is_mm_managed(&vma->flags);
>  }
>
> +static inline bool vma_flags_is_fixed_mapping(const vma_flags_t *flags)
> +{
> +       /*
> +        * VMA_PFNMAP_BIT should imply VMA_DONTEXPAND_BIT, but some calle=
rs set
> +        * only the former.
> +        */
> +       return vma_flags_test_any(flags, VMA_PFNMAP_BIT, VMA_DONTEXPAND_B=
IT);
> +}
> +
> +static inline bool vma_is_fixed_mapping(const struct vm_area_struct *vma=
)
> +{
> +       return vma_flags_is_fixed_mapping(&vma->flags);
> +}
> +
>  static inline bool vma_flags_can_merge(const vma_flags_t *flags)
>  {
>         /*
> @@ -1691,7 +1705,7 @@ static inline bool vma_flags_can_merge(const vma_fl=
ags_t *flags)
>         if (!vma_flags_is_mm_managed(flags))
>                 return false;
>         /* VMA explicitly marked as being unmergeable. */
> -       if (vma_flags_test(flags, VMA_DONTEXPAND_BIT))
> +       if (vma_flags_is_fixed_mapping(flags))
>                 return false;
>
>         return true;
>
> --
> 2.55.0
>
