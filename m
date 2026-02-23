Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BED314A86
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864745; cv=pass; b=nYVd8YaXJ3sU/Uo391mSK9At2UV4DTDhcoEioBEdWKyJ95CIph8U1i5E8lXSeeiOt/0nf+DcSaRAzex4w9EtMI7UK3COueojQshWoALq5NfnQu3kk5KUq/PMt888t2wUbHrdtpyXjzGouAdx3/CYFKcOB14SaU65Zanqlb761YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864745; c=relaxed/simple;
	bh=6BMG4Aw9cTxQ9+0M97149ECEu9MA2fic37H9nokz5/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6FPa4F4WvYG9p2blpktdI1W0wxsLG8SKy+vyx+47FE/a3GiUMJ02uGvPXfroYo9WGvDJk/RFbUYMc/4l0YhxLgtZGUnUf0XghVsdCq7/4hsAKJmYNjcI14zn+XCAGnZKrWATX9paZnvicdJBU2oxmskafi2UT/jmsh2yaoMlK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vfg0mLJ1; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vfg0mLJ1"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so2917235f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 08:39:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771864742; cv=none;
        d=google.com; s=arc-20240605;
        b=MYA8GNxo2j4hJsmUyV3Itpo/VBnBS22hkr63fSc1NO0Bm0P0KXHG2mYnrdtdNv8PSc
         F0ptXzvz6eW96pCapsr1dY1EypPUAss/YG6xfw0yU2Xn/Su1wyIXwfWzPBb+9y6HKTp6
         dbnDkwu7D9KbyXigaiWorpi2HQkzPqK3K4evgTr2rOYo1b1hzPnZWdPjhYcE98PnXA2e
         vCuAOj9QTboj0NvQ+HAH7ZfIASOWdObsi/UPGi48begoCSNvdIQHaxpAGoxHosI0rRde
         pLoQlrpwoCxiDoyOFEn8AyoA1vIaE1CBRSpu58LiA6rYdllcmfChBfb/ub9Pzfmy4CvP
         PNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Btlg+v2s4Bj2eA79FYWO+v9doj0qL1zCyyDyKw2C9g=;
        fh=Zhu9xiyyMQ2fJTAAzFM6drWe7nq8bEMRsebSFj41zH8=;
        b=KUGI3+PZ2CCWS/TO5SNoJVGt+ryEHmSdsdmtRQ/V5+6W0x3lMjKBJ7+c+ra/5sS3y4
         /aS1RD53LxMUaR7gjXCQfoDKwMEGRZ4XN+FbY+VJdgqsoHERuxsVs/1mZISYatnQz5fh
         1fabpc8cvkhyry05e625VpLZC501Z7MXd5XAwyk11TUwJaY3EnYjKXbl7LO+ZFIXBLey
         6lvT7qV41ysaLJ37OgnwZx9RIAUuSRC/Dx7cKWBegAIO9e3dkHDRcnUQ2xhVLzc6UR/O
         XPZrNNgj3cEwwMdBUgceGUzZ4muLWKFNYQPD2kgQa4877qsMBzrSu5krNuyNcKx+hpy6
         m5fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771864742; x=1772469542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Btlg+v2s4Bj2eA79FYWO+v9doj0qL1zCyyDyKw2C9g=;
        b=Vfg0mLJ1k/XPortGSlRwBsGhmmDAiuwD3PfBM/gyQK4jkvK7qAhkbn0aFg5g/JydBU
         fEnl9USlhTpgCtkEOIkWLq/i8pEr3+08T3bm/joRgz8nOFux+JjDEEk0dVqiw9PhFpsT
         gk4P1pX4xd52gvTjnBxOcSVqL3kxi0VRSLGTDhUotprfHaI39n8NG30j+SRcvp5MbEWS
         mZK5Y+3h6lfxoz8hLmavGmCoH7AHkUal10iR9a64YpPuK+iR/rQqM9I1kSLcNXzWQN+9
         FlPT8cQ2mzzU7c+3vjLOS3TFrsGyCPBlpbusvsGxeP9Xq/tHf+b60dtMUMJ7Iy3OWOyK
         WRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771864742; x=1772469542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Btlg+v2s4Bj2eA79FYWO+v9doj0qL1zCyyDyKw2C9g=;
        b=qJRcj2UEEViwoTyUr+dpXFjwQN0TAOXzWdGmrHopFCgt9XqE5XXtTQHPK5WD7V+1Dv
         RXFTBolytfDa4vUky5p95OTKS2Hws1gIjAfUO/71a0Muqd86cyAhbtS6EFX/3Y8VQNFJ
         iNbBbPvE9msQ2wdKk6qnTCi+Z0S1ADXH1pszhvuOVqtEvZgI7g722Ndc5DoAj8HzLLfO
         gWf6As/L+Hd/gd5f7ShGGzVIkFWU6DQSsS7ml+GfRXkSI8y8RRxv+98bD/8ceCuEgbCW
         9zf264uXCXiZrlW4hSk/bjBb7RBPj8tHKfF3S5nd/YLkvnx3QvZVJBuELUfba9/GBous
         EMrw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Z09djHqnTXxYNTZ8Cki/VqqB/oUj8yWoptb6XhNIneyXfOSkUAFgilbULVOTendrh20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTuxHUivNL4i453lMx2LHFLRwrofj2U/bob6vMD10rHsPF5TSh
	dFtPRE8qOTv4ZnLIs14Gl2nt7hKO5xQOtlfaRByTVTED/FLt3EZcFjRQNeLbleL+iDZJHFlOmci
	3tT8O8NzpyolcXS/AQnVnTkr8sQQw11pqBFeq
X-Gm-Gg: ATEYQzxBteEolBRVDkQIwG3SSFzxfveka8NhkyKzVXoRaIvkdHBU4G72rfR4hUOqHl8
	zXrs1GUYr5UIoT4tW3j1OAOuygqKkgxSQs7iqjjw846d/dkM9CRplFXrO+B4EeXstZ5xRw3UKLM
	z+AGIsLEgvMWylBvw5Jwc9CCNJotWpwUf+o3DvIGaO3Jmv/XR5S9N7thH0e1FqNJ6yMLs8S0pCI
	LhetHzuESGkufRem2YoNA38hbpqRtOlV6ICcG9Qj7STn8yEZrBb5O+NKNMummC5jqjGaNWPkvVx
	3Sex0KNFKwJ15RSPNvKJHKYPUSGAkS+c78q2LxyGVgZULh9GMJ/LjKp/HtHezIbsRetKeBMKgnw
	/cTpqjv3F
X-Received: by 2002:a05:6000:40ca:b0:437:73a2:2d4c with SMTP id
 ffacd0b85a97d-4396f15a735mr16101979f8f.13.1771864742055; Mon, 23 Feb 2026
 08:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223083120.23776-1-slava.imameev@crowdstrike.com> <20260223083120.23776-3-slava.imameev@crowdstrike.com>
In-Reply-To: <20260223083120.23776-3-slava.imameev@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Feb 2026 08:38:51 -0800
X-Gm-Features: AaiRm51gzgi525_wFRB9fptLy63BCDSKPCaqKcQyhmb9W89_jXdbtCdsK1J7NFE
Message-ID: <CAADnVQ+50cMbAiTPEuPT_LZgPu3SuMDhemX9EpMLoqdCHvAXbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add trampolines
 multi-level pointer params test coverage
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 12:32=E2=80=AFAM Slava Imameev
<slava.imameev@crowdstrike.com> wrote:
>
> Multi-level pointer params and return value test coverage for BPF
> trampolines:
> - fentry/fexit programs covering struct and void double/triple
>   pointer parameters and returned values
> - verifier context tests covering multi-level pointers as parameters
> - verifier context tests covering multi-level pointers as returned
>   values
> - verifier context tests for lsm to check trusted parameters handling
> - verifier context tests covering out-of-bound access after cast
> - verifier BPF helper tests to validate no change in verifier
>   behaviour
>
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> ---
>  net/bpf/test_run.c                            | 130 ++++++
>  .../prog_tests/fentry_fexit_multi_level_ptr.c | 206 +++++++++
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../progs/fentry_fexit_pptr_nullable_test.c   |  56 +++
>  .../bpf/progs/fentry_fexit_pptr_test.c        |  67 +++
>  .../bpf/progs/fentry_fexit_void_ppptr_test.c  |  38 ++
>  .../bpf/progs/fentry_fexit_void_pptr_test.c   |  71 +++
>  .../bpf/progs/verifier_ctx_multilevel_ptr.c   | 435 ++++++++++++++++++
>  8 files changed, 1005 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_fexit_m=
ulti_level_ptr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_n=
ullable_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_pptr_t=
est.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_p=
pptr_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_fexit_void_p=
ptr_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_multil=
evel_ptr.c
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 178c4738e63b..9f6ee2eb01cd 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -24,6 +24,9 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/xdp.h>
>  #include <net/netfilter/nf_bpf_link.h>
> +#include <linux/set_memory.h>
> +#include <linux/string.h>
> +#include <asm/tlbflush.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/bpf_test_run.h>
> @@ -563,6 +566,42 @@ noinline int bpf_fentry_test10(const void *a)
>         return (long)a;
>  }
>
> +struct bpf_fentry_test_pptr_t {
> +       u32 value1;
> +       u32 value2;
> +};
> +
> +noinline int bpf_fentry_test11_pptr_nullable(struct bpf_fentry_test_pptr=
_t **pptr__nullable)
> +{
> +       if (!pptr__nullable)
> +               return -1;
> +
> +       return (*pptr__nullable)->value1;
> +}
> +
> +noinline u32 **bpf_fentry_test12_pptr(u32 id, u32 **pptr)
> +{
> +       /* prevent DCE */
> +       asm volatile("" : "+r"(id));
> +       asm volatile("" : "+r"(pptr));
> +       return pptr;
> +}
> +
> +noinline u8 bpf_fentry_test13_pptr(void **pptr)
> +{
> +       void *ptr;
> +
> +       return copy_from_kernel_nofault(&ptr, pptr, sizeof(pptr)) =3D=3D =
0;
> +}
> +
> +/* Test the verifier can handle multi-level pointer types with qualifier=
s. */
> +noinline void ***bpf_fentry_test14_ppptr(void **volatile *const ppptr)
> +{
> +       /* prevent DCE */
> +       asm volatile("" :: "r"(ppptr) : "memory");
> +       return (void ***)ppptr;
> +}
> +
>  noinline void bpf_fentry_test_sinfo(struct skb_shared_info *sinfo)
>  {
>  }
> @@ -670,20 +709,110 @@ static void *bpf_test_init(const union bpf_attr *k=
attr, u32 user_size,
>         return data;
>  }
>
> +static void *create_bad_kaddr(void)
> +{
> +       /*
> +        * Try to get an address that passes kernel range checks but caus=
es
> +        * a page fault handler invocation if accessed from a BPF program=
.
> +        */
> +#if defined(CONFIG_ARCH_HAS_SET_MEMORY) && defined(CONFIG_X86)
> +       void *addr =3D vmalloc(PAGE_SIZE);
> +
> +       if (!addr)
> +               return NULL;
> +       /* Make it non-present - any access will fault */
> +       if (set_memory_np((unsigned long)addr, 1)) {
> +               vfree(addr);
> +               return NULL;
> +       }
> +       return addr;
> +#elif defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
> +       struct page *page =3D alloc_page(GFP_KERNEL);
> +
> +       if (!page)
> +               return NULL;
> +       /* Remove from direct map - any access will fault */
> +       if (set_direct_map_invalid_noflush(page)) {
> +               __free_page(page);
> +               return NULL;
> +       }
> +       flush_tlb_kernel_range((unsigned long)page_address(page),
> +                              (unsigned long)page_address(page) + PAGE_S=
IZE);
> +       return page_address(page);
> +#endif

This is serious overkill for a test.
See how bpf_testmod_return_ptr() does it.

pw-bot: cr
