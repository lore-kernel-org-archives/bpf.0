Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61C3BED2D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291960; cv=pass; b=dpeePTG2MixefO0RX2klolJUae/S6U52Qf0IZt3nrtuclocRBHxwjZ3CUebGRG4PN/iRDqZV2UWPY5Kg3yB63kSfQDXFo/LFOIjwCWTPrcQL4bra2ri+l0PjvcEZWboD/aOBIDUduxDLs6BSndo5w0SkaHoCivsAT0M9XPjW2e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291960; c=relaxed/simple;
	bh=hAvyW7mntZ8gF1r5CIPOxW8yQh2xQo2NnBouag07/ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5dQSrves3sCvB3LssYsWbhUEnqBbD2WHCwXPFKpqOyfRldVU3EeP29CZ+VranQPN05//LYIYyJp6zAGa4yBUDaedNLVb2LeNbPU/NyCdUumQWmzr4KqJlD7Xp/1s6+ZJGJ5HMj7QBO6nf7hGj1Q5j9foEjMawO/9Q11oyyMINk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pd7Jk0jj; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pd7Jk0jj"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f7so1160675ad.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790291958; cv=none;
        d=google.com; s=arc-20260327;
        b=K9l8mOALbwZFEZZ2o7ba50X1d5tWkJ0EHYVGcQjW3bkcsfT6UfMkiQVjBRpAO1FaWR
         49l6XM5eL2zV7ziHymkuhALZwpgOtgl6BO7W0jrUXy6ttxw8/wz2LHb0P59UWBM4nFtU
         6I/J0hElWwWPNFhUDlLtOgSV1tK2aO3tt/SzRLa1AI+Uf/Rvcu5NaAjR6G1SC4+krTOv
         4fLzLBmRTtK+t2bIpIS1z4qTxgpPC8PeQqcMw04rlrVn9/dZuek9KUjTn87SxpKRYLso
         iYBHI8HTON9EDJ9btiZLv5hZOkXqgSxsmzRpXivQ7JPMRnMQikPv7r/6DivQVMqzDK8o
         N/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lEqKjK+kKIVdFGgWgPOwrXBb0zqHdCpXqdwBp5xz3ho=;
        fh=FLd6JgKJC78bvz9uUBQxoN4rjy641h97g+CnETlClq4=;
        b=SxAQHF4BnEZCGtnPwpoujwHGpIhXy76sU7xkiGESZinXIZh/OZidM70tGdXH8U2Hbr
         6SDejA4f89aiLQQiuiOknyxd+E4TDbwmwnVN+bcQU4sTQf/sGhxUjGzXYaY1jMc1lLh0
         /ZBDNmoxE3ZILauykMjUGqaQczIwpcCvwvzLmIMF6f5mClElI/ZOk7NQaYWIITTZl+y6
         NjeqTRt+ycx2bL35FMfvNeg8azlwgmq6EsNMztqfWiFyhJffBOoRfHbnOippl1IiQyU1
         ACJbEAoXyD0hN276b0SUSfxn7+u4CTDVW6PDCvzABwQia2fsjwakQhfgDncluwmBvpG3
         eqoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790291958; x=1790896758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lEqKjK+kKIVdFGgWgPOwrXBb0zqHdCpXqdwBp5xz3ho=;
        b=pd7Jk0jj9L8Lj8ZI3ejR0tUxX5vrAvatauJ233zFoKMgfz4cUNXRfX3O38QLr3tTDI
         yJTTrp2aa9RmmfUzSadUm2PPg17jS1v7cEPi2cyCVBaC+a2YGEebO/Dh8B0CCc41xw+G
         LGTNXNpBSlUEykgS0FmvLAib3huDi8EfFpsOXroogaDWYGm4XO87q9QlY5VX2Mg+0foU
         MU+I3JplFwLsh24UMaytL3CVT8aPP0khdiFytzNx6y1+Fvgi0uxXqBv1dEy3br9IqDu8
         eWDD/PK4uEmT+Bhiz4Qr/Q2ZnWWN+c3EbvqHsZel7hi6rVzk+ZDvlcbk9EX/rSTw9WjT
         L7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790291958; x=1790896758;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lEqKjK+kKIVdFGgWgPOwrXBb0zqHdCpXqdwBp5xz3ho=;
        b=0rEbfR6Aou2HksaWZ0Ewhg5Dps+trZX74sY1Z7i6RufvYQ4X1lo4JI3vJui+E+mu+U
         07/aO5TS7G5QOXpmqsoibZKtfxdeqOXu2Ej3ROgEidUASpJgf2uW5Gkup0mfXIk9XLVh
         I4rIhINJHExYpCeoAJ20HUJvLQhqnhDzhGJ6gw1zwuX5CBHtwF/463SpJN7JOuhz5hbq
         gaf/l3inPQPXObBxDbOHEJNZWnQViFn+vCP29giKZDN6nus42vg9FrsUDN6qURB+I8dJ
         8cTnQcG+B2/OJGb66oWVDYRUS2dXceDDZUEqypTzAfWgT5+unr09n4hJGgUaAzWozu8+
         RtfQ==
X-Gm-Message-State: AFuF++l1xOtawrV+sCXvrtsE+UfrmoFWjCHe/+smjzAl6Fn55MA0W4mT
	m32ybzV/btSu8y03w0cH355NZfsKLmZNehMN4Jqmo0h20XP9fyb5DOapBI6az8OZhbQ9yi4NoKo
	X0VPGqyueBxZbUeeI+AsZioT3+ry868M=
X-Gm-Gg: AYBFou14HgMDErKmVBV0yxdqWERqVgJ/KdTc02XN2QGKkX07cee1v1UWzRSuaX4ZHUO
	h2ogOGNiy/J49zRB7mlOBIpHsFXKlsqPs1Sh5GkWKkoW4oqwjFhT3S2cnhTc6rYxNMB8pIpMDBr
	iKuT9vwuy6BHuNiCv3qKxemhDxNMfWkV3BrSW9uIAmC8IXMNn78zCteobEVlpkXDGckG7EOoV/G
	LPivVr+9nBtuktP4gX4t+j+z8uRpzmJJ1MxgEjMBsRmVXcYpZkfsXidVMPjaBaT2cSSPxQSXlSr
	cs04EcidN2IuKWsELinx1mHjR/g3WTplEC6HOsbmPcNtWUVFsCBxxQ8VK21JYoKUDpXAJdutzoz
	2ptnpqoZmv1G6bQR//WWuOUxHfL57DtSIzQ5h
X-Received: by 2002:a17:902:d983:b0:2dd:ad73:c97f with SMTP id
 d9443c01a7336-2df7dc40989mr31008245ad.23.1790291957741; Thu, 24 Sep 2026
 16:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com> <20260923232939.1886328-6-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260923232939.1886328-6-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Sep 2026 16:19:02 -0700
X-Gm-Features: AclHuK8-_nr3nFeaC20-YrV4gKvSQjcJfceENJcoTBtHp-6K0FoV4K322Nmwv08
Message-ID: <CAEf4BzbgkghzOfHJh-A9z=kMn=NaHgr04_DUUrQ63bvHaAsqTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/8] libbpf: Version bpf_program__set_autoattach()
 ABI change
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com, 
	linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:29=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> bpf_program__set_autoattach()'s return type changed from void to int to
> let callers observe the new -EINVAL rejection for MANUAL-strategy
> programs, but the symbol stayed under its original LIBBPF_1.0.0 node in
> libbpf.map. Binaries already linked against the old void-returning ABI
> recorded a request for exactly that symbol@version pair at link time;
> without a version bump they would silently start hitting the new
> rejection behavior underneath them after a libbpf upgrade.
>
> Split the symbol via ELF symbol versioning:
>
>   - bpf_program__set_autoattach_deprecated() keeps the original
>     unconditional behavior, bound via COMPAT_VERSION() to the existing
>     LIBBPF_1.0.0 node.
>   - bpf_program__set_autoattach_v1_8_0() carries the new MANUAL-rejecting
>     behavior, bound via DEFAULT_VERSION() to the new LIBBPF_1.8.0 node.
>
> Old binaries keep resolving bpf_program__set_autoattach() to the old
> behavior at runtime; anything linked against the current headers/map
> gets the new int-returning, MANUAL-rejecting behavior. Also adds the
> missing __LIBBPF_MARK_DEPRECATED_1_8 gate to libbpf_common.h (only the
> 1.0 gate existed) so LIBBPF_DEPRECATED_SINCE(1, 8, ...) can mark the
> deprecated variant.
>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c        | 9 ++++++++-
>  tools/lib/bpf/libbpf.h        | 6 ++++++
>  tools/lib/bpf/libbpf.map      | 2 ++
>  tools/lib/bpf/libbpf_common.h | 6 ++++++
>  4 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 85e1d9c775ab..224fb0247a39 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9974,7 +9974,14 @@ bool bpf_program__autoattach(const struct bpf_prog=
ram *prog)
>         return prog->autoattach;
>  }
>
> -int bpf_program__set_autoattach(struct bpf_program *prog, bool autoattac=
h)
> +COMPAT_VERSION(bpf_program__set_autoattach_deprecated, bpf_program__set_=
autoattach, LIBBPF_1.0.0)

no compat stuff, it should be backwards compatible to change return
from void to int


> +void bpf_program__set_autoattach_deprecated(struct bpf_program *prog, bo=
ol autoattach)
> +{
> +       prog->autoattach =3D autoattach;
> +}
> +
> +DEFAULT_VERSION(bpf_program__set_autoattach_v1_8_0, bpf_program__set_aut=
oattach, LIBBPF_1.8.0)
> +int bpf_program__set_autoattach_v1_8_0(struct bpf_program *prog, bool au=
toattach)
>  {
>         if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL)
>                 return libbpf_err(-EINVAL);
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index faea42f75847..d172c137cc37 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -393,6 +393,12 @@ LIBBPF_API bool bpf_program__autoload(const struct b=
pf_program *prog);
>  LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool =
autoload);
>  LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_autoattach(struct bpf_program *prog, boo=
l autoattach);
> +/* this "specialization" should go away once the deprecation window for
> + * bpf_program__set_autoattach_deprecated() closes
> + */
> +LIBBPF_API int bpf_program__set_autoattach_v1_8_0(struct bpf_program *pr=
og, bool autoattach);
> +LIBBPF_DEPRECATED_SINCE(1, 8, "use int-returning bpf_program__set_autoat=
tach() instead")
> +LIBBPF_API void bpf_program__set_autoattach_deprecated(struct bpf_progra=
m *prog, bool autoattach);
>
>  struct bpf_insn;
>
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 8def5474885a..999e791d9887 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -465,6 +465,8 @@ LIBBPF_1.8.0 {
>                 bpf_program__clone;
>                 bpf_program__load;
>                 bpf_program__load_strategy;
> +               bpf_program__set_autoattach;
> +               bpf_program__set_autoattach_deprecated;
>                 bpf_program__set_load_strategy;
>                 btf__find_by_name_kind_own;
>                 btf__new_empty_opts;
> diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.=
h
> index 8fe248e14eb6..12ad4f5f558f 100644
> --- a/tools/lib/bpf/libbpf_common.h
> +++ b/tools/lib/bpf/libbpf_common.h
> @@ -36,6 +36,12 @@
>  #define __LIBBPF_MARK_DEPRECATED_1_0(X)
>  #endif
>
> +#if __LIBBPF_CURRENT_VERSION_GEQ(1, 8)
> +#define __LIBBPF_MARK_DEPRECATED_1_8(X) X
> +#else
> +#define __LIBBPF_MARK_DEPRECATED_1_8(X)
> +#endif
> +
>  /* This set of internal macros allows to do "function overloading" based=
 on
>   * number of arguments provided by used in backwards-compatible way duri=
ng the
>   * transition to libbpf 1.0
> --
> 2.34.1
>
