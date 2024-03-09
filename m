Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE86185B
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710002299; cv=none; b=qS+UIHjJ8gs5wqmQZggSO5EgeO01ORkaaWVNMp9sA3oDRjBCRoxqAXnIhKBg7IgrL6jC88sKb7utx2R61QSON9RB1pBFpnLArq3E8SnnA/pC8sLQ5Y8GwyWhJX79tDxYOMbce0TdRmU2qVsjHSYEkZUaupRuLzKMMQwFM/8MSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710002299; c=relaxed/simple;
	bh=T4PvgJ8OPQW9qM9vJqNiv+idcsVw17CjXHD5CBk3G6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq98QyJGn1jvSTY1Zm8K3gRh7+ZcVOIAwgAoILORMaLi1yos69lr0wTE/Iz8/jvXva6AWMpU0cMRm6bJslGFPnG7UF0Qa2tE2MwYCy0hlfe6Nqlz66wqKdVLLf0PFmOeoEUQX7ddK12hdkrC5BGz8nGKsCJ2dZdxttS+BeIreuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmKDZeub; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmKDZeub"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e6aca1ca9so2499487f8f.2
        for <bpf@vger.kernel.org>; Sat, 09 Mar 2024 08:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710002296; x=1710607096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjzrBbJ3q1WHluCAGM0M2JzA/NUnA9jStCeKPFxC9Yc=;
        b=GmKDZeubsUvpSft1qUR16pdABYJ0w4+UHW7TfuPNPJJfYMHiEYbyoG3oZwVtD6ohAc
         MO3vUeGaXa0RoLdHtyz9/0Ev9T9j0cx4e42/afDjOrqeg/LopWLpbmelhh0/CJRXBP7u
         ECqNDUtBFGhVMlK4kwnVjcBN5eD9uFX86cq7vOJCR6zcSiSddt2zi6k2Dl5TdMtiikMo
         /3V1v+1XgVVNrq3Qb+jTsIDES3/fWwcIsv7WiJjamyUyl2V7ckFvmBc+0YMc7OJrHH6a
         vwCaDGzJmCasOgrv3+AxUkr6WGpKsxXFzLEmPkW3IALNjM7qKe8YGKxtGUewHFd+KYGp
         ZDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710002296; x=1710607096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjzrBbJ3q1WHluCAGM0M2JzA/NUnA9jStCeKPFxC9Yc=;
        b=NcVkUGfNzzYGM0Q5JdqODqH8GNgTCyweB9mHBrjwpBGkMjHeLU1df0exmU47TelE8V
         5FkTUbr/DCMsgWJ4kZl6E5oz06ipimxKwG5c5NcPTEJvP1gn4CwubQM4xB0+E1jppk9g
         fc4sUv/yHQIPzc4Ow0Ud/YN2mRqV5kX7S0I0Dx54vYnOYf0E59rDpMn8ke6MXhqSJ64w
         1QWI59OamsY0qqib1q7HOX9gL6iEZd/6OzSdCuvCxfuIjpJ0kiYR2Xs2T5yCvIIpOhq2
         RNwcvhi/j3T8HULsg9Zn9WOjUSmxQAj+jZ5a4eqjUMLLAtfjYHc8Fxq2VMNbdCTf/yCo
         Nr/g==
X-Forwarded-Encrypted: i=1; AJvYcCXh1jKo6Bzc0dsfBqbI+Ve1ZN1NVGygQ9Hp6h9hAy8c2A0FC2gIiFpsA8VJ31Ws3xMl8Sp2+7WQQJr5xhz4K2AIVWN2
X-Gm-Message-State: AOJu0YxizXM0V+8W757iRACXJKWku5iUy4Xg2RtNAVHdsknbwHo2txxy
	eTv/pknQFghi4T2NH50+0gdIQ/KhcxhCOW3fNL/kDNzM83Lf5pcT9MA9FrY/+duovgkn6gBXKcW
	SR4MPvgembVr2p+uvajpClAvgs+I=
X-Google-Smtp-Source: AGHT+IFjV+rvr7i2EnOF8AtRv8dFnwzYVN2YlnTMpQk1HId1lcnkfYoEwaXZtL4twfJDWVNJ170ZmaqvXcsf/jOtXBE=
X-Received: by 2002:adf:ef8f:0:b0:33e:7fcb:c0e with SMTP id
 d15-20020adfef8f000000b0033e7fcb0c0emr1215233wro.6.1710002295545; Sat, 09 Mar
 2024 08:38:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403092219.dhgcuz2G-lkp@intel.com>
In-Reply-To: <202403092219.dhgcuz2G-lkp@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Mar 2024 08:38:04 -0800
Message-ID: <CAADnVQJ+6mFs56fu+KEvumQ5uqM-oLpYx0hGxLJfE9XUCtEWEA@mail.gmail.com>
Subject: Re: [bpf-next:master 5/7] kernel/bpf/core.c:900:5: warning:
 '__pte_index_size' is not defined, evaluates to 0
To: kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>, Song Liu <song@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>, clang-built-linux <llvm@lists.linux.dev>, 
	oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Puranjay,

Looks like I have to drop this patch for now,
since PMD_SIZE is not a constant on all archs
that can be evaluated by a preprocessor.

We need to find a different way.


On Sat, Mar 9, 2024 at 7:04=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> head:   d0d131e3b655fd267d14bb1bed49e3f990a1465e
> commit: 643714ff18301f41bded2489e8f1f9d1b4782094 [5/7] bpf: cap BPF_PROG_=
PACK_SIZE to 2MB * num_possible_nodes()
> config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/202=
40309/202403092219.dhgcuz2G-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 5=
03c55e17037436dcd45ac69dea8967e67e3f5e8)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240309/202403092219.dhgcuz2G-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403092219.dhgcuz2G-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from kernel/bpf/core.c:21:
>    In file included from include/linux/filter.h:9:
>    In file included from include/linux/bpf.h:21:
>    In file included from include/linux/kallsyms.h:13:
>    In file included from include/linux/mm.h:2188:
>    include/linux/vmstat.h:508:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      509 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:515:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      516 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:522:36: warning: arithmetic between different e=
numeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-c=
onversion]
>      522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip =
"nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>    include/linux/vmstat.h:527:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      528 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:536:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      537 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    In file included from kernel/bpf/core.c:21:
>    In file included from include/linux/filter.h:9:
>    include/linux/bpf.h:739:48: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum=
-enum-conversion]
>      739 |         ARG_PTR_TO_MAP_VALUE_OR_NULL    =3D PTR_MAYBE_NULL | A=
RG_PTR_TO_MAP_VALUE,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~~~~~~~
>    include/linux/bpf.h:740:43: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum=
-enum-conversion]
>      740 |         ARG_PTR_TO_MEM_OR_NULL          =3D PTR_MAYBE_NULL | A=
RG_PTR_TO_MEM,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~
>    include/linux/bpf.h:741:43: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum=
-enum-conversion]
>      741 |         ARG_PTR_TO_CTX_OR_NULL          =3D PTR_MAYBE_NULL | A=
RG_PTR_TO_CTX,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~
>    include/linux/bpf.h:742:45: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum=
-enum-conversion]
>      742 |         ARG_PTR_TO_SOCKET_OR_NULL       =3D PTR_MAYBE_NULL | A=
RG_PTR_TO_SOCKET,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~~~~
>    include/linux/bpf.h:743:44: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum=
-enum-conversion]
>      743 |         ARG_PTR_TO_STACK_OR_NULL        =3D PTR_MAYBE_NULL | A=
RG_PTR_TO_STACK,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~~~
>    include/linux/bpf.h:744:45: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum=
-enum-conversion]
>      744 |         ARG_PTR_TO_BTF_ID_OR_NULL       =3D PTR_MAYBE_NULL | A=
RG_PTR_TO_BTF_ID,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~~~~
>    include/linux/bpf.h:748:38: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum=
-enum-conversion]
>      748 |         ARG_PTR_TO_UNINIT_MEM           =3D MEM_UNINIT | ARG_P=
TR_TO_MEM,
>          |                                           ~~~~~~~~~~ ^ ~~~~~~~=
~~~~~~~
>    include/linux/bpf.h:750:45: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum=
-enum-conversion]
>      750 |         ARG_PTR_TO_FIXED_SIZE_MEM       =3D MEM_FIXED_SIZE | A=
RG_PTR_TO_MEM,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~
>    include/linux/bpf.h:773:48: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-We=
num-enum-conversion]
>      773 |         RET_PTR_TO_MAP_VALUE_OR_NULL    =3D PTR_MAYBE_NULL | R=
ET_PTR_TO_MAP_VALUE,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~~~~~~~
>    include/linux/bpf.h:774:45: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-We=
num-enum-conversion]
>      774 |         RET_PTR_TO_SOCKET_OR_NULL       =3D PTR_MAYBE_NULL | R=
ET_PTR_TO_SOCKET,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~~~~
>    include/linux/bpf.h:775:47: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-We=
num-enum-conversion]
>      775 |         RET_PTR_TO_TCP_SOCK_OR_NULL     =3D PTR_MAYBE_NULL | R=
ET_PTR_TO_TCP_SOCK,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~~~~~~
>    include/linux/bpf.h:776:50: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-We=
num-enum-conversion]
>      776 |         RET_PTR_TO_SOCK_COMMON_OR_NULL  =3D PTR_MAYBE_NULL | R=
ET_PTR_TO_SOCK_COMMON,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~~~~~~~~~
>    include/linux/bpf.h:778:49: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-We=
num-enum-conversion]
>      778 |         RET_PTR_TO_DYNPTR_MEM_OR_NULL   =3D PTR_MAYBE_NULL | R=
ET_PTR_TO_MEM,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~
>    include/linux/bpf.h:779:45: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-We=
num-enum-conversion]
>      779 |         RET_PTR_TO_BTF_ID_OR_NULL       =3D PTR_MAYBE_NULL | R=
ET_PTR_TO_BTF_ID,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~~~~
>    include/linux/bpf.h:780:43: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-We=
num-enum-conversion]
>      780 |         RET_PTR_TO_BTF_ID_TRUSTED       =3D PTR_TRUSTED    | R=
ET_PTR_TO_BTF_ID,
>          |                                           ~~~~~~~~~~~    ^ ~~~=
~~~~~~~~~~~~~~
>    include/linux/bpf.h:891:44: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum=
-enum-conversion]
>      891 |         PTR_TO_MAP_VALUE_OR_NULL        =3D PTR_MAYBE_NULL | P=
TR_TO_MAP_VALUE,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~~~
>    include/linux/bpf.h:892:42: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum=
-enum-conversion]
>      892 |         PTR_TO_SOCKET_OR_NULL           =3D PTR_MAYBE_NULL | P=
TR_TO_SOCKET,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~
>    include/linux/bpf.h:893:46: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum=
-enum-conversion]
>      893 |         PTR_TO_SOCK_COMMON_OR_NULL      =3D PTR_MAYBE_NULL | P=
TR_TO_SOCK_COMMON,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~~~~~
>    include/linux/bpf.h:894:44: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum=
-enum-conversion]
>      894 |         PTR_TO_TCP_SOCK_OR_NULL         =3D PTR_MAYBE_NULL | P=
TR_TO_TCP_SOCK,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~~~
>    include/linux/bpf.h:895:42: warning: bitwise operation between differe=
nt enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum=
-enum-conversion]
>      895 |         PTR_TO_BTF_ID_OR_NULL           =3D PTR_MAYBE_NULL | P=
TR_TO_BTF_ID,
>          |                                           ~~~~~~~~~~~~~~ ^ ~~~=
~~~~~~~~~~
> >> kernel/bpf/core.c:900:5: warning: '__pte_index_size' is not defined, e=
valuates to 0 [-Wundef]
>      900 | #if PMD_SIZE <=3D (1 << 21)
>          |     ^
>    arch/powerpc/include/asm/book3s/64/pgtable.h:208:26: note: expanded fr=
om macro 'PMD_SIZE'
>      208 | #define PMD_SIZE        (1UL << PMD_SHIFT)
>          |                                 ^
>    arch/powerpc/include/asm/book3s/64/pgtable.h:207:33: note: expanded fr=
om macro 'PMD_SHIFT'
>      207 | #define PMD_SHIFT       (PAGE_SHIFT + PTE_INDEX_SIZE)
>          |                                       ^
>    arch/powerpc/include/asm/book3s/64/pgtable.h:156:25: note: expanded fr=
om macro 'PTE_INDEX_SIZE'
>      156 | #define PTE_INDEX_SIZE  __pte_index_size
>          |                         ^
>    26 warnings generated.
> --
> >> kernel/bpf/core.c:900:5: warning: '__pte_index_size' is not defined, e=
valuates to 0 [-Wundef]
>      900 | #if PMD_SIZE <=3D (1 << 21)
>          |     ^
>    arch/powerpc/include/asm/book3s/64/pgtable.h:208:26: note: expanded fr=
om macro 'PMD_SIZE'
>      208 | #define PMD_SIZE        (1UL << PMD_SHIFT)
>          |                                 ^
>    arch/powerpc/include/asm/book3s/64/pgtable.h:207:33: note: expanded fr=
om macro 'PMD_SHIFT'
>      207 | #define PMD_SHIFT       (PAGE_SHIFT + PTE_INDEX_SIZE)
>          |                                       ^
>    arch/powerpc/include/asm/book3s/64/pgtable.h:156:25: note: expanded fr=
om macro 'PTE_INDEX_SIZE'
>      156 | #define PTE_INDEX_SIZE  __pte_index_size
>          |                         ^
>    1 warning generated.
>
>
> vim +/__pte_index_size +900 kernel/bpf/core.c
>
>    891
>    892  /* PMD_SIZE is not available in some special config, e.g. ARCH=3D=
arm with
>    893   * CONFIG_MMU=3Dn. Use PAGE_SIZE in these cases.
>    894   */
>    895  #ifdef PMD_SIZE
>    896  /* PMD_SIZE is really big for some archs. It doesn't make sense t=
o
>    897   * reserve too much memory in one allocation. Cap BPF_PROG_PACK_S=
IZE to
>    898   * 2MiB * num_possible_nodes().
>    899   */
>  > 900  #if PMD_SIZE <=3D (1 << 21)
>    901  #define BPF_PROG_PACK_SIZE (PMD_SIZE * num_possible_nodes())
>    902  #else
>    903  #define BPF_PROG_PACK_SIZE ((1 << 21) * num_possible_nodes())
>    904  #endif
>    905  #else
>    906  #define BPF_PROG_PACK_SIZE PAGE_SIZE
>    907  #endif
>    908
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
