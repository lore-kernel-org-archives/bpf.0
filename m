Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590AF4D0A12
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632388; cv=none; b=eTrgjmvagdE4FtfRA4MbDCochG+I7vc99PYbqKKcjV7InjnQBrWEIurD2orpr87Qr+KpvUj3DWH57oqc3/rJym2ajb5Zg+r64aK8adDq8KFyXibl+9rdTaREuNJWt53oh3s/GaHXLIq2QstDXAvMDwpjXDk6faPte+IiF0zc8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632388; c=relaxed/simple;
	bh=eXZI9d9vVUyEmzpz1g2CP4YMku19jekaprBzsuOMuqQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=d4jHx6egc3Smqse6Vohutq4g7emkhW6axI8PHDUq0cPivne92D0WSaUIYDPyvxzUgKNOKvi/ntL7fESEYF0LU7BYja17SYtEYrkqahlXlq9iMQTNdDQvHjOyzCyrqNz0O7oU6tX5Wx/59V3hBR9Atd166xX7CuY199wietufwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LDY+7J+P; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LDY+7J+P"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SLTU3Q062062
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 14:53:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=JS4y13hb6uJ3wHuFCzCSOoOkOOFEcVeZPXzNx
	yfyu80=; b=LDY+7J+PkFatQnOeRh6Ds6sY/bCF14bIWU/e40waVIDlfzXG2fEWV
	TtzUQ7kJtlcoDb43FMgqS3lJhhzlVRYwa6mJ+8ZfC9F76F/zN541vLc4OQ3YkU2o
	5W53J+iDRdr+H4Ws560326Wu97sMfx+66HjAqmptFlH7ULzxMP0Cv2VmUUClRBr0
	oiw0tLZ7WR3G3EsTnXCTgbsspvZMK2RyRtoSYzzLr9co32RksW2NCWL9AknCkvNf
	jE1NrfcB5kqxKVyd/grN7FljornwZwxIyEcfCgC6NfZBqRaudplCEHUnmvou0/Lc
	Wp+3j8qPUk/z2y4N4pWaJZFtCSs0PYmbg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gy2nm3xg4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 14:53:05 -0700 (PDT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1431ba79941so3298872c88.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 14:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790632385; x=1791237185;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:newsgroups:cc:to:subject:user-agent:mime-version:date
         :message-id:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JS4y13hb6uJ3wHuFCzCSOoOkOOFEcVeZPXzNxyfyu80=;
        b=lReUK84fDDD9HggEc/Iik3ikQJdiDFM/ikklfIAoVFwpX2cjKrtdteIgjMKCx62j9N
         kT6V+D/70V9EPapY63cBx6YYU1zKMLOaUnZI5E1aqV9UlIwKQ86XArQ0ZshHCGG4Azlq
         uQXC8G/c+tAaTNerRbwJpMO942nTWsKpmLmKE5Wj0DM2n0XiHQUYYmEDlgJkKNrGoZ5h
         Lv9cvOIVZdOSzzkw5JCfj7A+O69u3u12oxm84y0adzOLL3p/+YKdTIcwuyPU0gbAHaVU
         qQvzCogvn5H95Qx5kzzjRzzBM9/aH2EQtTlXkhfoKlYMaBQvO2RaMN3dLs2xb/PTpn2O
         aAMw==
X-Forwarded-Encrypted: i=1; AKwUvBwONx8HN8xSbI0APDoWbvjZHGlFKp/kbccLMInnwbTplQW+/YWIoBrwZbgtuBWX34KsSe0=@vger.kernel.org
X-Gm-Message-State: AFuF++kaRPZV+0e1iBF2MpZm8p/qI39sp+YvohMWYAZlEDPtSYEo0cN3
	rZreVwdC40d5pn23ExzAMzSitnFNWOrGCsUlmb1dahxkk0tM0juREFxoyQ1h0qehR/ecAwRO8F2
	OuuqRgytv1VdvEmBrrPGlxmwHXGICHZo6S9ADU2TQHbyyYryxoh+IhlAVr7mK
X-Gm-Gg: AYBFou12/wPX8MFTeyHRZwrxlptXJU9TQWc/H+V8R6eQkyPkisTyBtHEaAtsa13Awcg
	Nq6yae3dNC34fRIkErpgv3IGikF8K3kfg+LD/VWLzzIr01VB1wOHUAxHaEp2zicyYoJwvr82SFv
	i/vFSbg4Zny8wNNBq9jZDLIR3m2RkVhr2mFJwdtvyEFCKhwoIzA7LI2aQsqcqC+sVXQMQPOzGcT
	bOprSGIQ2GxorBnLD0f1/Uzh4RhdaRm/wnMYUAvjLecpn/I0RnBeQhdvOIhjval+Q/fDkg+bR9l
	uUv+wDqKXBCkyMBSJCnqtf8zOIegobBdAEUgq+K9etYJTcEeLOQ1RHFFd96iBm2pZorTe0QUlMg
	nvWqJuXXZSfvkwa0=
X-Received: by 2002:a05:701b:2504:b0:14a:e7be:7a38 with SMTP id a92af1059eb24-14ae7be88bamr1608643c88.4.1790632384471;
        Mon, 28 Sep 2026 14:53:04 -0700 (PDT)
X-Received: by 2002:a05:701b:2504:b0:14a:e7be:7a38 with SMTP id a92af1059eb24-14ae7be88bamr1608529c88.4.1790632382611;
        Mon, 28 Sep 2026 14:53:02 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21cf::10e3? ([2620:10d:c090:400::5:9746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3434958c3adsm38882252eec.22.2026.09.28.14.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 14:53:02 -0700 (PDT)
From: Vineet Gupta <gvineet@meta.com>
X-Google-Original-From: Vineet Gupta <vineet.gupta@linux.dev>
Message-ID: <6cadba40-10bb-4acf-9a32-d22a270ada8d@linux.dev>
Date: Mon, 28 Sep 2026 14:52:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add linked_externs test
 for externs in allocated sections
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc: kernel-team@meta.com, Ihor Solodrai <ihor.solodrai@linux.dev>
Newsgroups: gmane.linux.kernel.bpf
References: <20260926000243.2830819-1-andrii@kernel.org>
 <20260926000243.2830819-2-andrii@kernel.org>
Content-Language: en-US
In-Reply-To: <20260926000243.2830819-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fuNJ914f c=1 sm=1 tr=0 ts=6abae1c1 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=i-6TwEPlgW01CNtUTPMA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: TGfgGZ8TuKL0eg2ryZsHUOy3lcCyFP52
X-Proofpoint-GUID: TGfgGZ8TuKL0eg2ryZsHUOy3lcCyFP52
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA4NiBTYWx0ZWRfX1KUA4y7FwfnK
 j8W8eQWxXXw4GyXZHP1TyY7mJ+3W5FRdV8Fps0cjuLSHVkj2fUx3mIQeSzlwTChn3KZ39H3yjul
 6zguu4Dkt+EZv9R46+9nENYYINO4RDQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4NiBTYWx0ZWRfX/KBlKJBNJtDA
 LvVOn/R8P5fGmgx8GS6BnuOEV5B5TWYSb1ryNT2leopQD/CGb1271Vjw670epcw6wwp62H3PDTk
 ZHvufdrWtVQcfVlIjr21JRLr0ynxbnQ5dEQsbUSMAa7dqFRNMj2/bKYRz0NbjJiHWrMLKOOYcZN
 UkjKm/U86E1yJ0xeBMaxE91kXzfrqpaREclYTrE0x5Uj+lS892Bm2HUrCOuvCUzeenVyOMEQPP4
 4XvFCXWZxMRGKzQaCRJzwMwmp+xWmdYWr933L35V+uVjj3VWMcmjImgoFFP+t+arjbNRY/FzOUQ
 kdfeMVeDbpAHa72m3rDNYwLumigmCFlR9E2t+QomuyYnVDMQ1M+QkDJZc7EnExZtVpGkmMGAQQB
 XkF6vve5Lubrti6KZYz5+dAjKJQSOrSxkO1bH1T7eCgOZ3oIwuWmt5LFASH97+rx3xL9uyiYw4K
 C2645I9aIs810bnAHrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_06,2026-09-21_02,2025-10-01_01

Hi Andrii,

On 9/25/26 5:02 PM, Andrii Nakryiko wrote:
> Add two objects that define an arena global each and declare the
> other one's as extern, linked into a single skeleton with the
> extern-declaring object first.
> 
> The skeleton build relinks the linked object twice more, which fixes
> up DATASEC offsets from the ELF symbol table, so the test also drives
> the libbpf linker directly: it links linked_arena1.bpf.o on its own,
> links the result with linked_arena2.bpf.o, checks that no variable in
> the .addr_space.1 DATASEC is left extern, and loads the object. The
> same is done with linked_maps1/2.bpf.o, which have an extern map in
> .maps.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/testing/selftests/bpf/Makefile.skel     |   3 +-
>   .../selftests/bpf/prog_tests/linked_externs.c | 109 ++++++++++++++++++
>   .../selftests/bpf/progs/linked_arena1.c       |  22 ++++
>   .../selftests/bpf/progs/linked_arena2.c       |  18 +++
>   4 files changed, 151 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_externs.c
>   create mode 100644 tools/testing/selftests/bpf/progs/linked_arena1.c
>   create mode 100644 tools/testing/selftests/bpf/progs/linked_arena2.c

This is tripping up CI, fails with BPF_GCC [1] and some more (sched-ext)
Fix for gcc build failure is posted here [2]

[1] https://github.com/kernel-patches/bpf/actions/runs/36243003457
[2] 
https://lore.kernel.org/bpf/20260928215110.3966357-1-vineet.gupta@linux.dev/T/#u

Thx,
-Vineet

> 
> diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
> index 3d92cdca62ed..2e22bb901bf3 100644
> --- a/tools/testing/selftests/bpf/Makefile.skel
> +++ b/tools/testing/selftests/bpf/Makefile.skel
> @@ -23,7 +23,7 @@ BPF_OBJS := $(patsubst %.c,$(RDIR)/%.bpf.o,$(BPF_SRCS))
>   SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
>   
>   LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
> -		linked_vars.skel.h linked_maps.skel.h 			\
> +		linked_vars.skel.h linked_maps.skel.h linked_arena.skel.h \
>   		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
>   		test_usdt.skel.h tracing_multi.skel.h			\
>   		tracing_multi_module.skel.h				\
> @@ -46,6 +46,7 @@ test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.
>   linked_funcs.skel.h-deps := linked_funcs1.bpf.o linked_funcs2.bpf.o
>   linked_vars.skel.h-deps := linked_vars1.bpf.o linked_vars2.bpf.o
>   linked_maps.skel.h-deps := linked_maps1.bpf.o linked_maps2.bpf.o
> +linked_arena.skel.h-deps := linked_arena1.bpf.o linked_arena2.bpf.o
>   # In the subskeleton case, we want the test_subskeleton_lib.subskel.h file
>   # but that's created as a side-effect of the skel.h generation.
>   test_subskeleton.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o test_subskeleton.bpf.o
> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_externs.c b/tools/testing/selftests/bpf/prog_tests/linked_externs.c
> new file mode 100644
> index 000000000000..29358c82dc35
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_externs.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "linked_arena.skel.h"
> +
> +static void test_skel(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct linked_arena *skel;
> +	int err;
> +
> +	skel = linked_arena__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	ASSERT_EQ(skel->arena->a_val, 1, "a_val_init");
> +	ASSERT_EQ(skel->arena->b_val, 2, "b_val_init");
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.sum1), &opts);
> +	ASSERT_OK(err, "sum1_run");
> +	ASSERT_EQ(opts.retval, 1 + 2, "sum1_retval");
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.bump2), &opts);
> +	ASSERT_OK(err, "bump2_run");
> +	ASSERT_EQ(opts.retval, 11 + 22, "bump2_retval");
> +
> +	ASSERT_EQ(skel->arena->a_val, 11, "a_val");
> +	ASSERT_EQ(skel->arena->b_val, 22, "b_val");
> +
> +	linked_arena__destroy(skel);
> +}
> +
> +static int link_objs(const char *out, const char *in1, const char *in2)
> +{
> +	struct bpf_linker *linker;
> +	int err;
> +
> +	linker = bpf_linker__new(out, NULL);
> +	if (!ASSERT_OK_PTR(linker, "linker_new"))
> +		return -EINVAL;
> +
> +	err = bpf_linker__add_file(linker, in1, NULL);
> +	if (!ASSERT_OK(err, in1))
> +		goto cleanup;
> +	if (in2) {
> +		err = bpf_linker__add_file(linker, in2, NULL);
> +		if (!ASSERT_OK(err, in2))
> +			goto cleanup;
> +	}
> +	err = bpf_linker__finalize(linker);
> +	ASSERT_OK(err, "finalize");
> +
> +cleanup:
> +	bpf_linker__free(linker);
> +	return err;
> +}
> +
> +/* link in1 on its own first, then link the result with in2 */
> +static void test_relink(const char *in1, const char *in2, const char *sec_name)
> +{
> +	char out1[] = "/tmp/linked_externs.XXXXXX", out2[] = "/tmp/linked_externs.XXXXXX";
> +	const struct btf_var_secinfo *vi;
> +	struct bpf_object *obj = NULL;
> +	const struct btf_type *t;
> +	struct btf *btf;
> +	int i, id, n;
> +
> +	close(mkstemp(out1));
> +	close(mkstemp(out2));
> +
> +	if (!ASSERT_OK(link_objs(out1, in1, NULL), "link_stage1") ||
> +	    !ASSERT_OK(link_objs(out2, out1, in2), "link_stage2"))
> +		goto cleanup;
> +
> +	obj = bpf_object__open_file(out2, NULL);
> +	if (!ASSERT_OK_PTR(obj, "obj_open"))
> +		goto cleanup;
> +
> +	btf = bpf_object__btf(obj);
> +	id = btf__find_by_name_kind(btf, sec_name, BTF_KIND_DATASEC);
> +	if (!ASSERT_GT(id, 0, "find_datasec"))
> +		goto cleanup;
> +
> +	t = btf__type_by_id(btf, id);
> +	vi = btf_var_secinfos(t);
> +	n = btf_vlen(t);
> +	for (i = 0; i < n; i++) {
> +		t = btf__type_by_id(btf, vi[i].type);
> +		ASSERT_NEQ(btf_var(t)->linkage, BTF_VAR_GLOBAL_EXTERN, "var_resolved");
> +	}
> +
> +	ASSERT_OK(bpf_object__load(obj), "obj_load");
> +
> +cleanup:
> +	bpf_object__close(obj);
> +	unlink(out1);
> +	unlink(out2);
> +}
> +
> +void test_linked_externs(void)
> +{
> +	if (test__start_subtest("skel_arena"))
> +		test_skel();
> +	if (test__start_subtest("relink_arena"))
> +		test_relink("linked_arena1.bpf.o", "linked_arena2.bpf.o", ".addr_space.1");
> +	if (test__start_subtest("relink_maps"))
> +		test_relink("linked_maps1.bpf.o", "linked_maps2.bpf.o", ".maps");
> +}
> diff --git a/tools/testing/selftests/bpf/progs/linked_arena1.c b/tools/testing/selftests/bpf/progs/linked_arena1.c
> new file mode 100644
> index 000000000000..3e8788dec1d9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/linked_arena1.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_arena_common.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 1); /* number of pages */
> +} arena SEC(".maps");
> +
> +long __arena a_val = 1;
> +extern long __arena b_val; /* defined in linked_arena2.c */
> +
> +SEC("syscall")
> +int sum1(void *ctx)
> +{
> +	return a_val + b_val;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/linked_arena2.c b/tools/testing/selftests/bpf/progs/linked_arena2.c
> new file mode 100644
> index 000000000000..d0bcdf18a4b6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/linked_arena2.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_arena_common.h"
> +
> +long __arena b_val = 2;
> +extern long __arena a_val; /* defined in linked_arena1.c */
> +
> +SEC("syscall")
> +int bump2(void *ctx)
> +{
> +	a_val += 10;
> +	b_val += 20;
> +	return a_val + b_val;
> +}
> +
> +char _license[] SEC("license") = "GPL";

