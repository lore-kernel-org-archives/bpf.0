Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F3397935
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632395; cv=none; b=ca5QOEnMbh2ZwvjQO1ENkRppbcp3/nt4N+LOu9TcTFkz42NlewuUHjJzDnCNBfj5J52rFNEFc8b6hZpeR8W2wjV+RaPqSNEn09vdu8Xvn45/C/ht05/N+ZHyve395+aoOHjh8hLOB/xqZk0zTbBK9I0vfjauiYtcbI0o4d7SZmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632395; c=relaxed/simple;
	bh=eXZI9d9vVUyEmzpz1g2CP4YMku19jekaprBzsuOMuqQ=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:Cc:In-Reply-To; b=FbSNiWZ4aFVybPYvGLaNqQNmGH0q+46IwTa6eqHPHwYBARx/ypiCanzVKdlqyzEZUOg4V6IZUjqFvzSd6amZolv3bKbCz1zZ1fQ4DG8x2G1aCXN78h3hUFtoSVmxZPwkzMkTU+ECj0KWP0VsaAQAysq5Iifow8loYaorGC0t0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glkb-bpf@m.gmane-mx.org>)
	id 1xBJHV-000AQ9-KM
	for bpf@vger.kernel.org; Mon, 28 Sep 2026 23:53:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: bpf@vger.kernel.org
From: Vineet Gupta <vineet.gupta@linux.dev>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add linked_externs test
 for externs in allocated sections
Date: Mon, 28 Sep 2026 14:52:59 -0700
Message-ID: <6cadba40-10bb-4acf-9a32-d22a270ada8d@linux.dev>
References: <20260926000243.2830819-1-andrii@kernel.org>
 <20260926000243.2830819-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Cc: kernel-team@meta.com, Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20260926000243.2830819-2-andrii@kernel.org>
Message-ID: <20260928215259.79HZdS5cr3XmU_Wrc6t2XMLDh4PKme5_iz3tc8_xFpo@z>

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


