Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE6336AB49
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037392; cv=none; b=hb42tx8/IImvcN8ife05tLt+BHwdvBS69nh0Q3kLilg3W5MCVsxv6A66qnVa9hQdLq2d+fJbHIwaH4MgamlomqjpPIuBEWRnFo6xcMaYKAy9+AyL+paMMJ4oU36Cmg4vzHSYd/Kmi1wv+ancsgMLkfdhKK/8Ll9ZXM38JIGtt0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037392; c=relaxed/simple;
	bh=tF/DUNjCaWnqv08Qf+qUv0vX/27r3EsTPJAGUpMjg2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jqI4eCUPBP1WPGBw9quUsNSujdgHtZIqtTlzKp8S9ybb1rF+7M+vToNTdXXJO5zQl8h03O2tWsmJzvVgfCiJRHJQDX0fWcvtUlJj/dGGbUAT2rU2gwSL/6qDWqqArwsWW2aMtPEXJDuoZBTVrN5XAvqRfFK+ih9dXdkpHMlkYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrK0IDBQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrK0IDBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BF61F00893;
	Tue,  9 Jun 2026 20:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781037391;
	bh=VeLJqWnMVgi+4Yf7ASIaidKH1xOPzXxxFIh898SyWG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QrK0IDBQ9y/QInlhAzK1LWKCa3Kc6HZTmV3WmfGV4AHjV+dKHKB3rwA119koZjTqF
	 H2YGzfaROcrdOkZcoQ/BL8YN/WAD8kgv7V/GqrSEPwJPgQ8zqHJBTnqQz4zAV6Sq8K
	 jhAWsvO02YGNfz6uEdOljJbrfQrfUwhh6DS9Td6mFmMxQMEGFLdnzdlA1YRTjkbogC
	 TCI4LUnlKzHL1+SCmUrDWhSeZGftk7xwhfyAIQepFvYg2orlwMfWsHJHB4+/mXuoGu
	 L3sjqNdzB7C7DWCEJPP0aFLrXo9vOi/qpqPOcQdMgayBPLeIeZbFtj3Mux71e1URfA
	 Zz27qDnoMsv6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Exercise unsafe obj
 drops from tracing progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609202548.3571690-4-memxor@gmail.com>
References: <20260609202548.3571690-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 20:36:30 +0000
Message-Id: <20260609203630.E3BF61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test `task_kfunc_obj_drop_nmi_with_kptr` does not test NMI t=
racing programs as claimed by the commit message and its function name. Ins=
tead, it uses `SEC("tp_btf/task_newtask")`, which makes it a standard traci=
ng program. Furthermore, because it fails at load-time for the exact same v=
erifier reason as `task_kfunc_obj_drop_with_kptr`, the second test provides=
 redundant coverage and leaves the intended NMI tracing context (`BPF_PROG_=
TYPE_PERF_EVENT`) completely untested.
--

commit e2b410eb90d404473252178d121d1547bd924299
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Exercise unsafe obj drops from tracing progs

This commit adds task_kfunc failure cases for bpf_obj_drop on local
objects with referenced kptr fields. It intends to verify that the
verifier rejects these operations from both standard tracing and NMI
tracing programs.

> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/too=
ls/testing/selftests/bpf/progs/task_kfunc_failure.c
> --- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
[ ... ]
> +SEC("tp_btf/task_newtask")
> +__failure __msg("bpf_obj_drop cannot be used in tracing programs on type=
s with NMI unsafe fields")
> +int BPF_PROG(task_kfunc_obj_drop_with_kptr, struct task_struct *task, u6=
4 clone_flags)
> +{
[ ... ]
> +}
> +
> +SEC("tp_btf/task_newtask")
> +__failure __msg("bpf_obj_drop cannot be used in tracing programs on type=
s with NMI unsafe fields")
> +int BPF_PROG(task_kfunc_obj_drop_nmi_with_kptr, struct task_struct *task,
> +	     u64 clone_flags)

[Severity: Medium]
Does this test actually exercise the NMI tracing context as intended?

The function is named task_kfunc_obj_drop_nmi_with_kptr and the commit
message mentions NMI tracing programs, but the section used here is
SEC("tp_btf/task_newtask"). Should this be using an NMI-specific section
like SEC("perf_event") instead?

Because this uses the same tracing section as the previous test, it fails at
load-time for the exact same verifier reason as task_kfunc_obj_drop_with_kp=
tr,
providing redundant coverage and leaving the NMI context untested.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609202548.3571=
690-1-memxor@gmail.com?part=3D3
