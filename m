Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5547A15624B
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777035; cv=none; b=cicP5WlspcPqJ5mJw/LPn0AcsPr9/cj4FArgJOABwASqZixxEvn7Xk33XWkyJlkoQuWC9jBXGTK+pSGYccUgdziRNYxImmHg/sIlJ7KfrOanU37pbBkUVJ7aY04ucL9WYBX4g8L11Mk/CNsNUdZiKBPZgIovWhGhEBIIjkRduTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777035; c=relaxed/simple;
	bh=F6RooSCvXz96iHxaUvGqijjU/ytN9ldVQLLW/6eYjec=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=idvzfGi3rVrlZlsbsEvykiOXjzTeGHyB+0CGu5Z/0/7MsAax8vo6fEKfJLJhe5kE8eVV1+5NDgRfwTq93/rq5SfCX732cST7ZSQYoXKiZM73Yo27vLsdz+VdZK8vNUgDR7KnxwCoUDKwbmwkUaRgU5n0d63MrtWt3SOnioDwqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=kxLF3aEN; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="kxLF3aEN"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6f21c2d81so612593985a.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 12:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773777033; x=1774381833; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DajaV5a8MwAWjSuczM32oPkBheQKOfyQnLqKvkoyhOo=;
        b=kxLF3aEN+uRUy7S7ybwtLLWF9uVtDpNdaFVxsrvwcySujQrs2wDqnKPZtGopckaC1J
         64HQNMeVy1TUf4N6wlAyN/Sr+BXvs+LlGp4dZWLOq5DtUaC0GqnalyxKU0K6vgiEqZkG
         Tt+wrgptN2Oo9PXmbOLBR5IlvXwSG8uxob0u6nXS4TB08NYV2HgMLj5Dbz3EH23mTMzY
         Hr+9pSBD+b8jKidpA7/mh/55K3g2J7GNWzGv1jLNXMywmQgyfNsPWsMCfmKELO8hbPct
         ncN5/LH2jUwwtaco532NlTT6zdmMZ8YUQuCxU9CJkgO7kils1S6Oqdj9mWbI6k6/YU3r
         id/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773777033; x=1774381833;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DajaV5a8MwAWjSuczM32oPkBheQKOfyQnLqKvkoyhOo=;
        b=OeMZ+ATis8OhFd0Iz0R7H+Dj/VowjlTrBYLAi6ojf2DYdkHuHKu37JcC9H15dpt4dA
         ASyWC4fMBilpQL6Ay6E++lEOAxzRiP43y5VjFp0d/eqgcsmDLkemqCK+mNbbSEIPDeZC
         0sVoM6lOjWU8gu0VfUM2SwcR+RpAELg4J428aGxi5LqGdy9wRm1FM/xK72HfpI2yz5RJ
         tphxHrit4Qc955xuvmQaH6+NCJcS53icrGaVWr7d8nBm89u3U0I0l/wnt9nhWW2IFqGm
         jgxAyNTSRlfdmC3eLzQk4OITaqlluuYO4qT5eKBtTr+465pj88iYukMwB0H3fM5Hbz2U
         82eA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ5aIp14IFmUwpTxQIe2BmdY68ENXsnaPv9XDWuBB6pKKfoVwVZwCZ8XloKILhuNwB10M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN/EDsWRWNTt96y4Kl3wbSEvIngg147BOWXHpduYyzs9uWDcjD
	ah5aW3hRyZMTu8LN+MEWVkuZbXINtsuWNbqlmfxTy8NIyNj8rnfGTFjd+vugXGu+zgM=
X-Gm-Gg: ATEYQzwPd6hcrVssORooGyifxHFkXEM64SqrgiSCqmBfdHMv4HZSiSTtUNAx1ArrpGW
	gNyN9mAaariE5D8HaxEsO6Zph6qzEG+9baEifHUaoCivBPm9bQBOdmiu7OtE1aruMc/sIDq1Uhn
	ybnbFy+n5AluTIb79kCiEbqyYMXGAjA8XGhSJnm1DHwilbeA7LzrqPppETjNwgqq5URvp3Gb7iU
	tdRbkrJL6jLec604pQ04G3dmoflsWJxWLoo7iNdcdKEW0RA1I8gJvtGzb5I6vS4g3QjSgVCtgrA
	gst5kTCGbir5bNrlIlceZ11l3MthD9VdOGB8uwzZsXpdBdebaYPUjZDVaLcg2DuphnMmw/TBPRg
	V1l7AEe/Kcub5DXEKWCtYEaIDDk+Vkt0XJQJhYpGw1DQ0poXKqNV+gZ2IqDXHH1DO1AGENJ5tJY
	wEQc/fSD89ar5PaOEI40d8Ud4=
X-Received: by 2002:a05:620a:4512:b0:8cd:85e1:e20e with SMTP id af79cd13be357-8cfad1f85e0mr126570485a.12.1773777033009;
        Tue, 17 Mar 2026 12:50:33 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfad161f17sm64676085a.30.2026.03.17.12.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 12:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 15:50:31 -0400
Message-Id: <DH5BHB49LSWW.2K0INW3EFP8Z0@etsalapatis.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Test
 bpf_program__clone() attach_btf_id override
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260317-veristat_prepare-v4-0-74193d4cc9d9@meta.com>
 <20260317-veristat_prepare-v4-3-74193d4cc9d9@meta.com>
In-Reply-To: <20260317-veristat_prepare-v4-3-74193d4cc9d9@meta.com>

On Tue Mar 17, 2026 at 1:39 PM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add a test that verifies bpf_program__clone() respects caller-provided
> attach_btf_id in bpf_prog_load_opts.
>
> The BPF program has SEC("fentry/bpf_fentry_test1"). It is cloned twice
> from the same prepared object: first with no opts, verifying the
> callback resolves attach_btf_id from sec_name to bpf_fentry_test1;
> then with attach_btf_id overridden to bpf_fentry_test2, verifying the
> loaded program is actually attached to bpf_fentry_test2. Both results
> are checked via bpf_prog_get_info_by_fd().
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/prog_tests/clone_attach_btf_id.c | 78 ++++++++++++++++=
++++++
>  .../selftests/bpf/progs/clone_attach_btf_id.c      | 13 ++++
>  2 files changed, 91 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/clone_attach_btf_id.c=
 b/tools/testing/selftests/bpf/prog_tests/clone_attach_btf_id.c
> new file mode 100644
> index 000000000000..1c3e28e74606
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/clone_attach_btf_id.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta */
> +#include <test_progs.h>
> +#include "clone_attach_btf_id.skel.h"
> +
> +/*
> + * Test that bpf_program__clone() respects caller-provided attach_btf_id
> + * override via bpf_prog_load_opts.
> + *
> + * The BPF program has SEC("fentry/bpf_fentry_test1"). Clone it twice
> + * from the same prepared object: first with no opts (callback resolves
> + * attach_btf_id from sec_name), then with attach_btf_id overridden to
> + * bpf_fentry_test2. Verify each loaded program's attach_btf_id via
> + * bpf_prog_get_info_by_fd().
> + */
> +
> +static int get_prog_attach_btf_id(int prog_fd)
> +{
> +	struct bpf_prog_info info =3D {};
Nit: I think this is not necessary because the fields are populated in
the kernel in bpf_prog_get_info_by_fd().
> +	__u32 info_len =3D sizeof(info);
> +	int err;
> +
> +	err =3D bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
> +	if (err)
> +		return err;
> +	return info.attach_btf_id;
> +}
> +
> +void test_clone_attach_btf_id(void)
> +{
> +	struct clone_attach_btf_id *skel;
> +	int fd1 =3D -1, fd2 =3D -1, err;
> +	int btf_id_test1, btf_id_test2;
> +
> +	btf_id_test1 =3D libbpf_find_vmlinux_btf_id("bpf_fentry_test1", BPF_TRA=
CE_FENTRY);
> +	if (!ASSERT_GT(btf_id_test1, 0, "find_btf_id_test1"))
> +		return;
> +
> +	btf_id_test2 =3D libbpf_find_vmlinux_btf_id("bpf_fentry_test2", BPF_TRA=
CE_FENTRY);
> +	if (!ASSERT_GT(btf_id_test2, 0, "find_btf_id_test2"))
> +		return;
> +
> +	skel =3D clone_attach_btf_id__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	err =3D bpf_object__prepare(skel->obj);
> +	if (!ASSERT_OK(err, "obj_prepare"))
> +		goto out;
> +
> +	/* Clone with no opts =E2=80=94 callback resolves BTF from sec_name */
> +	fd1 =3D bpf_program__clone(skel->progs.fentry_handler, NULL);
> +	if (!ASSERT_GE(fd1, 0, "clone_default"))
> +		goto out;
> +	ASSERT_EQ(get_prog_attach_btf_id(fd1), btf_id_test1,
> +		  "attach_btf_id_default");
> +
> +	/*
> +	 * Clone with attach_btf_id override pointing to a different
> +	 * function. The BPF program never accesses arguments, so the
> +	 * load succeeds regardless of signature mismatch.
> +	 */
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts,
> +		    .attach_btf_id =3D btf_id_test2,
> +	);
> +	fd2 =3D bpf_program__clone(skel->progs.fentry_handler, &opts);
> +	if (!ASSERT_GE(fd2, 0, "clone_override"))
> +		goto out;
> +	ASSERT_EQ(get_prog_attach_btf_id(fd2), btf_id_test2,
> +		  "attach_btf_id_override");
> +
> +out:
> +	if (fd1 >=3D 0)
> +		close(fd1);
> +	if (fd2 >=3D 0)
> +		close(fd2);
> +	clone_attach_btf_id__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/clone_attach_btf_id.c b/to=
ols/testing/selftests/bpf/progs/clone_attach_btf_id.c
> new file mode 100644
> index 000000000000..0ffa3ec3e1a0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/clone_attach_btf_id.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(fentry_handler, int a)
> +{
> +	return 0;
> +}

