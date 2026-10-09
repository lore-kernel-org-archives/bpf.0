Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6536D4E0B82
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550235; cv=none; b=FccgK+i7lDU/KKp6hPNFg9A5GZeGrusiLv6MIMN2EGqNinjskVOPg+Uw+Lqb8X9VL7F7G7fnoUP88VlfnS4wBYvgyzFSxsQOAx94yteswIzfKkbMlLkEdRboNmuYkTeH2JZv15h4zQBJyyETOH5lm55TIIu+v673zXzP+zEBVO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550235; c=relaxed/simple;
	bh=qIeGH6KNuZXahCMFRD4mJz4spN3F7dpCdSqlav/C7ug=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ah5LpemyJL+hYieyRqA7yiS4t/SVv7xVSjqTK3ElZam6u+1Xmu4/Dhparj3p2b1E4/9ihan/sy3XmQKRwxxZGhROYA5TVYkb80G++6VHJm4qfaGiJyHuEC2gDmDVd5YtthKTTsji+YcL9vSul8GNhRorZcu8n8gev45XqzmWP8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB+Yl/7h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB+Yl/7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD061F000FF;
	Fri,  9 Oct 2026 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791550229;
	bh=k0mOQsQPgLxI4/XhCcY/YDpZMYYz1G00YJ7OmyzlWw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fB+Yl/7hw9ehNzY96972ph6Wa+FHsdoUegDQenHmgDlqPbHrQ9H0CZ333tyLPvT/a
	 mcbMhrrDSHD3BQysj/q7O33QeOslVbnWGVIBYdXeyGlf+CbBLaEuhI/A7oEb/V9+GF
	 +u4QRljdkATdw7zsyRI5kvq74Qhvfvd7kc4AWGmH/d6FcBgRhZlLtwQ/nWnbZhd0bd
	 zOlAdr9qIkbNMqFVc9CDNaU4wAZoO8m2hhI8SB3Gkms3etL/XLk75oUdZ8i7N6fZDp
	 IuNhOByho0W0pwW6ur1WUy5sXEeUkEKCeHH+slLRTX0EC7gmlKNlOFKFBHkfqEkQ0k
	 xdG9DPMzhXrIA==
Message-ID: <sashiko-outbox-165565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] selftests/bpf: add tests for the page_owner
 bpf_iter target
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhen Ni" <zhen.ni@easystack.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009112308.240769-7-zhen.ni@easystack.cn>
References: <20261009112308.240769-1-zhen.ni@easystack.cn>
 <20261009112308.240769-7-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:50:29 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: missing __sz suffix in kfunc buffer size parameters bypasses =
verifier bounds check
--

commit 40eb734de063d435912cf0b8932fbb912e64be44
Author: Zhen Ni <zhen.ni@easystack.cn>

selftests/bpf: add tests for the page_owner bpf_iter target

This commit adds a sleepable BPF program and a userspace runner to test the
page_owner BPF iterator. It exercises the seq_file and open-coded iterator
paths and verifies the contracts of the get_nid, stack_snprint, and
get_memcg_info kfuncs.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_page_owner.c b/to=
ols/testing/selftests/bpf/progs/bpf_iter_page_owner.c
> new file mode 100644
> index 0000000000000..fada6a314a157
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_page_owner.c

[ ... ]

> +extern int bpf_iter_page_owner_new(struct bpf_iter_page_owner *it) __ksy=
m;
> +extern struct page_owner_scan *
> +bpf_iter_page_owner_next(struct bpf_iter_page_owner *it) __ksym;
> +extern void bpf_iter_page_owner_destroy(struct bpf_iter_page_owner *it) =
__ksym;
> +extern int bpf_page_owner_stack_snprint(depot_stack_handle_t handle,
> +					char *buf, u32 buf_size) __ksym;
> +extern int bpf_page_owner_get_nid(struct page_owner_scan *scan) __ksym;
> +extern int bpf_page_owner_get_memcg_info(struct page_owner_scan *scan,
> +					 struct memcg_info *info,
> +					 char *buf, u32 size) __ksym;

[Severity: High]
Does the kfunc ABI exercised here bypass verifier memory bounds checking?

The BPF verifier requires size parameters for memory buffers in kfuncs to be
explicitly annotated with a __sz or __szk suffix (e.g., buf__sz). Without t=
his
suffix, the verifier treats the size parameter as an independent scalar and
enforces no relationship between it and the buffer pointer.

In mm/page_owner_iter.c (which this newly added test relies upon), the kfun=
cs
bpf_page_owner_stack_snprint and bpf_page_owner_get_memcg_info define
buffer size arguments as u32 buf_size and u32 size, respectively, omitting
the required suffix:

mm/page_owner_iter.c:bpf_page_owner_stack_snprint()
    __bpf_kfunc int bpf_page_owner_stack_snprint(depot_stack_handle_t handl=
e,
                                                 char *buf, u32 buf_size)

mm/page_owner_iter.c:bpf_page_owner_get_memcg_info()
    __bpf_kfunc int bpf_page_owner_get_memcg_info(struct page_owner_scan *s=
can,
                                                  struct memcg_info *info,
                                                  char *buf, u32 size)

Consequently, the verifier only validates that buf points to a 1-byte valid
memory region (based on the char type) while allowing arbitrarily large sca=
lar
values to be passed as the size.

A BPF program could exploit this by providing a small buffer alongside a la=
rge
size argument, causing the underlying kernel functions (stack_depot_snprint
and get_page_memcg_info) to write past the bounds of the provided buffer,
potentially leading to kernel memory corruption.

Could these kfunc size arguments in the kernel be renamed to include the __=
sz
suffix to ensure proper verifier bounds checking?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009112308.2407=
69-1-zhen.ni@easystack.cn?part=3D6
