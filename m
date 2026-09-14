Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC19331EC7
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373046; cv=none; b=BfjqYNh+0Ky4onrbyDpZrcHkAOoxdRbIIUTIbZi6YDGKDCp3IdHAms7kpUQh+rdqsVFrpSappnjXDmRDFC6wOTdCMtWpCgNsLsgMtRSlY3WmHiilqfKof5qlniLpguEVkXZLSbSR22JAVg/mnHcYTNFfRMoaJkDlf54RsyE963Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373046; c=relaxed/simple;
	bh=XF96A6qcrqKXndSv/XxZGp7N1fnoi1huM7jmpxURo40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D4Q9CtsALz+UggiAGnCOutP6vsY6v8YiSWRpTWx2jR+24BJPs0UpKV5jkrQMRK1PcunNxj+iUGhNdrnrAlqU1SIMjhgFE9rQscll9Q2cC/PUsb7vB59OhLIoPba3r4zQbBR6VZQq+PLIC6prcICpDIzyMT0qR+RYWQexWxCoRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUDACHvU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUDACHvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF031F00893;
	Mon, 14 Sep 2026 08:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789373044;
	bh=GlM+5yiX0WMSIr0PYQ2g66awestSLY5v1RqK2Ii1HRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AUDACHvUBweEBO6obF0KFALlVxUtXhyu4cetSEpAteOsW9XGY4uGcqPQMplPiTlnn
	 FPIAL68fymeOrDajIYBkdKyCh4RpLEL0FCTYiFNq+bkUPwdV8ohzit/yApjYuED7NO
	 VtByz3nkjLvbTPyoWHOidf+BsaDLBhlvri5l1wQkupKbAVS1XOZVvZ7/rWWB4uDYi7
	 T4Dr3YVZTBBWFEC7UCBXkYUjDz/Ll0ipsNVC8flqgupJORxE1tVcdKrt68+rP3/mD8
	 wmVY6gljdRgeX09mRkLuqw6P/80xK5cCra1SBj7DBN7AGiSCBsKPd32lsVdukEuUzY
	 53TEkowsTsIgQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/5] selftests/bpf: add iocost cost model test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20260914073356.791518-3-cui.tao@linux.dev>
References: <20260914073356.791518-1-cui.tao@linux.dev>
 <20260914073356.791518-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 08:04:03 +0000
Message-Id: <20260914080404.5BF031F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Error path for cgroup storage allocation failure skips IOCOST_CO=
ST_F_MERGE adjustment.
- [Low] Multi-line comments do not follow the BPF subsystem strict guidelin=
es.
- [Low] IOC_PAGE_SHIFT is undeclared in the BPF program, causing a compilat=
ion failure.
--

commit 1e892fcbbd8ad235ee3890cec52bb54f2b43ddb9
Author: Tao Cui <cuitao@kylinos.cn>

selftests/bpf: add iocost cost model test

This commit adds an example cost model test implementing the builtin linear
HDD formula at double cost. It registers the model via struct_ops and binds
it to a device using io.cost.model, verifying the readback and testing write
errors during restoration.

> diff --git a/tools/testing/selftests/bpf/prog_tests/iocost_model.c b/tool=
s/testing/selftests/bpf/prog_tests/iocost_model.c
> new file mode 100644
> index 0000000000000..bf9f245e29a52
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
[ ... ]
> +static int bind_model(const char *dev, const char *name)
> +{
> +	char buf[300], got[64];
> +	int err;
> +
> +	snprintf(buf, sizeof(buf), "%s model=3D%s\n", dev, name);
> +	err =3D write_cost_model(buf);
> +	if (err)
> +		return err > 0 ? -err : -EIO;
> +	err =3D readback_model(dev, got, sizeof(got));
> +	if (!err && !strcmp(got, name)) {
> +		/* restore the builtin linear model on every path so the
> +		 * device is not left bound to a model the caller may
> +		 * unregister right after; the write is checked too */

[Severity: Low]
This isn't a bug, but does this violate the BPF subsystem comment style
guidelines? The BPF subsystem strict guidelines require multi-line comments
to have the opening /* on its own line.

> +		snprintf(buf, sizeof(buf), "%s model=3Dlinear\n", dev);
> +		err =3D write_cost_model(buf);
> +		return err > 0 ? -err : (err ? -EIO : 0);
> +	}
> +
> +	/* bind failed or does not read back: still restore; prefer
> +	 * the original failure, but surface the restore error too */

[Severity: Low]
This isn't a bug, but this comment also places the opening /* on the same
line as the text, which doesn't match the required BPF multi-line comment
style.

> +	snprintf(buf, sizeof(buf), "%s model=3Dlinear\n", dev);
> +	{
> +		int rerr =3D write_cost_model(buf);
> +
> +		return err ? (err > 0 ? -err : -EIO)
> +			   : (rerr > 0 ? -rerr : -EIO);
> +	}
> +}
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/iocost_model.c b/tools/tes=
ting/selftests/bpf/progs/iocost_model.c
> new file mode 100644
> index 0000000000000..81928f897297c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iocost_model.c
[ ... ]
> +#define IOC_PAGE_SIZE		4096
> +#define IOC_SECT_TO_PAGE_SHIFT	3	/* 512B sectors to 4kB pages */
> +#define LCOEF_RANDIO_PAGES	4096	/* 16MB seek threshold */
> +#define IOCOST_COST_F_MERGE	(1ULL << 0)	/* not in BTF: a plain macro */
> +#define IOCOST_REQ_OP_MASK	0xff		/* REQ_OP_MASK, not in BTF */

[Severity: Low]
Is IOC_PAGE_SHIFT missing from these manual constant definitions?

> +
> +/*
> + * DIV64_U64_ROUND_UP / DIV_ROUND_UP_ULL equivalents, folded at
> + * compile time
> + */
[ ... ]
> +SEC("struct_ops")
> +u64 BPF_PROG(iocost_2x_calc_cost, u64 opf, u64 nbytes, u64 sector,
> +	     struct blkcg *blkcg, u64 model_flags)
> +{
> +	u64 pages, seek_pages =3D 0, base, coef_page, randio, cost;
> +
> +	/* builtin truncates: max(sectors >> IOC_SECT_TO_PAGE_SHIFT, 1) */
> +	pages =3D nbytes >> IOC_PAGE_SHIFT;

[Severity: Low]
Does this code compile? IOC_PAGE_SHIFT is defined in an anonymous enum with=
in
block/blk-iocost.c and is not exported to vmlinux.h. Attempting to use it
here directly seems like it would cause a build error.

> +	if (!pages)
> +		pages =3D 1;
> +
> +	if ((opf & IOCOST_REQ_OP_MASK) =3D=3D REQ_OP_READ) {
[ ... ]
> +	{
> +		__u64 *cursor, cur;
> +		int priced =3D (opf & IOCOST_REQ_OP_MASK) =3D=3D REQ_OP_READ ||
> +			     (opf & IOCOST_REQ_OP_MASK) =3D=3D REQ_OP_WRITE;
> +
> +		cursor =3D bpf_cgrp_storage_get(&cursor_store,
> +					      blkcg->css.cgroup, NULL,
> +					      BPF_LOCAL_STORAGE_GET_F_CREATE);
> +		if (!cursor)
> +			return 2 * (base + pages * coef_page);

[Severity: Medium]
Does this early return miss the IOCOST_COST_F_MERGE adjustment?

If bpf_cgrp_storage_get() returns NULL, we return immediately here, which
skips the subsequent logic that zeros out base when model_flags has
IOCOST_COST_F_MERGE set. Could this result in merged operations being
incorrectly charged a base cost under failure conditions?

> +		cur =3D *cursor;
> +		if (cur && priced) {
> +			seek_pages =3D sector > cur ? sector - cur
> +						   : cur - sector;
> +			seek_pages >>=3D IOC_SECT_TO_PAGE_SHIFT;
> +			if (seek_pages > LCOEF_RANDIO_PAGES)
> +				base =3D randio;
> +		}
> +		if (priced && nbytes &&
> +		    !(model_flags & IOCOST_COST_F_MERGE))
> +			*cursor =3D sector + (nbytes >> 9);
> +	}
> +
> +	if (model_flags & IOCOST_COST_F_MERGE)
> +		base =3D 0;
> +
> +	cost =3D 2 * (base + pages * coef_page);
> +	return cost;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914073356.7915=
18-1-cui.tao@linux.dev?part=3D2
