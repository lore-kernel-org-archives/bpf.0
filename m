Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6097468C16
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395398; cv=none; b=TEoOjte46zyR2boLY3Zhw45X9TbMO/RvptNJTN9sY/pz1u1HtWoaaKbfFz6C5x9mOH+b7ndyfJd/qHCoYNCpCg6NwRQ/2eNmRoXKW4yGLNw2xTmXUVzXUj1faELmHz77Rr8RLFbrkYS7ZngSoJ9MRX5VF6Pvz6FSVrcxFD1x274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395398; c=relaxed/simple;
	bh=gTMIdC+fXbHt7EeQjm+3KasWThNRhmNtcrgoTd0yHlc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kMc5RLfngGfJSTVkIXbh/D+Hpz/P1wf7Wa7l8VPvvR+0eifKbbNh9sL/M3uUY7hnpDR/fONzyZkByFNOTkNvl8z9UZsqbRy6/RHrnOcQrrBJyvhIuxro03iAonZFFlOUAI/CJQxKqyn+hiblpPcXwz4f0GSMx8F5+Niq+XVpDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej5/zpZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej5/zpZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3AC1F000FF;
	Mon, 14 Sep 2026 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395396;
	bh=v0EdLuTraZTfA9NwEzCzG57HySs+64knujTCx6TQYD4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ej5/zpZrdLzIjbGIXOkCoZQemxSqeupgSvcbNp9ILZv5xWfK5CUtDRL3KXvxtYbaa
	 FyIjYpOIsxdJ/NvBbYizN3XxUb4GBzr0Da6Y4dJ8vdgMpNGK6TGL+D31gAiPSgvOjY
	 BHNKWx40YMN4+V8W59ponbBntsgdj5/iVwT+7Me3xzrYp8UZysIAYRtCAO9Bh8T+KA
	 e3XhNxnTVyI+lnfUwEuP7Ca7OfJ9IXJgzTwfHblhJodVhKU/2jjdRIlLSQC4itqr0g
	 EiFKO3HGug3A/2KDCVzi/VmgQ+pChOTcq1IECSGtj0rvhelWbEQrIsl2n5VJ1G26lN
	 GD4tEUDHm+AWQ==
Content-Type: multipart/mixed; boundary="===============8521541796254080504=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <993a18643fec6bcc9e49a4e7a0565f8b28700e368cf8b713474671d8259c04ec@mail.kernel.org>
In-Reply-To: <20260914132444.2564218-3-memxor@gmail.com>
References: <20260914132444.2564218-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Check local object ownership depth
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 14:16:35 +0000 (UTC)

--===============8521541796254080504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c b/tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c
> new file mode 100644
> index 000000000000..a487aa68f2ee
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <bpf/btf.h>
> +#include <linux/btf.h>
> +#include <test_progs.h>
> +
> +#define SPIN_LOCK 2
> +#define LIST_HEAD 3
> +#define LIST_NODE 4
> +/* Keep in sync with BTF_MAX_OWNERSHIP_DEPTH. */
> +#define MAX_OWNERSHIP_DEPTH 8
> +
> +static struct btf *init_btf(void)
> +{
> +	struct btf *btf;
> +	int id;
> +
> +	btf = btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "btf__new_empty"))
> +		return NULL;
> +	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	if (!ASSERT_EQ(id, 1, "btf__add_int"))
> +		goto err_out;
> +	id = btf__add_struct(btf, "bpf_spin_lock", 4);
> +	if (!ASSERT_EQ(id, SPIN_LOCK, "btf__add_struct bpf_spin_lock"))
> +		goto err_out;
> +	id = btf__add_struct(btf, "bpf_list_head", 16);
> +	if (!ASSERT_EQ(id, LIST_HEAD, "btf__add_struct bpf_list_head"))
> +		goto err_out;
> +	id = btf__add_struct(btf, "bpf_list_node", 24);
> +	if (!ASSERT_EQ(id, LIST_NODE, "btf__add_struct bpf_list_node"))
> +		goto err_out;
> +	return btf;
> +
> +err_out:
> +	btf__free(btf);
> +	return NULL;
> +}

This isn't a bug, but init_btf() and the SPIN_LOCK/LIST_HEAD/LIST_NODE id
macros are a line-for-line copy of prog_tests/linked_list.c. Both copies
encode the same fixed id-to-type mapping, so any future change to that
prologue has to be made in two places or the two files silently disagree
about which id means what.

Would it be worth moving init_btf() and the SPIN_LOCK/LIST_HEAD/LIST_NODE
ids into test_btf.h (which linked_list.c already includes) so the two
BTF-construction tests share one prologue?

> +
> +static int add_local_kptr(struct btf *btf, int pointee_id, const char *tag)
> +{
> +	int id;
> +
> +	id = btf__add_type_tag(btf, tag, pointee_id);
> +	if (!ASSERT_GT(id, 0, "btf__add_type_tag"))
> +		return id;
> +	id = btf__add_ptr(btf, id);
> +	ASSERT_GT(id, 0, "btf__add_ptr");
> +	return id;
> +}
> +
> +static void test_self_cycle(const char *tag, int expected_err)
> +{
> +	struct btf *btf;
> +	int id, err;
> +
> +	btf = init_btf();
> +	if (!ASSERT_OK_PTR(btf, "init_btf"))
> +		return;
> +	id = add_local_kptr(btf, 7, tag);
> +	if (id <= 0)
> +		goto out;
> +	id = btf__add_struct(btf, "self_cycle", 8);
> +	if (!ASSERT_EQ(id, 7, "btf__add_struct self_cycle"))
> +		goto out;
> +	err = btf__add_field(btf, "next", 6, 0, 0);
                                          ^
This isn't a bug, but add_local_kptr() returns the id of the pointer type
it just created. test_self_cycle(), test_aba_cycle() and test_mixed_cycle()
use the return value only for the id <= 0 error check and then hardcode
that same id as a literal in btf__add_field() (6 in test_self_cycle and
test_mixed_cycle; 6 and 8 in test_aba_cycle). The literals are correct
today only because init_btf() ends at id 4 and add_local_kptr() adds
exactly two types. test_acyclic_depth() in this same file keeps the
returned ids in ptr_id[], so the two styles sit side by side.

Could the cycle tests keep the value add_local_kptr() returns (as
test_acyclic_depth already does) instead of re-spelling it as 6/8, so the
field type cannot drift from the pointer that was actually added?

> +	if (!ASSERT_OK(err, "btf__add_field self_cycle::next"))
> +		goto out;
> +
> +	err = btf__load_into_kernel(btf);
> +	ASSERT_EQ(err, expected_err, "check btf");
> +out:
> +	btf__free(btf);
> +}

[ ... ]

> +static void test_graph_depth(bool rbtree, int depth, int expected_err)
> +{
> +	int root_type = LIST_HEAD, node_type = LIST_NODE, node_size = 24;
> +	int id, err, i, lock_off, root_off, size;
> +	struct btf *btf;
> +
> +	btf = init_btf();
> +	if (!ASSERT_OK_PTR(btf, "init_btf"))
> +		return;
> +	if (rbtree) {
> +		root_type = btf__add_struct(btf, "bpf_rb_root", 16);
> +		if (!ASSERT_GT(root_type, 0, "btf__add_struct bpf_rb_root"))
> +			goto out;
> +		node_type = btf__add_struct(btf, "bpf_rb_node", 32);
> +		if (!ASSERT_GT(node_type, 0, "btf__add_struct bpf_rb_node"))
> +			goto out;
> +		node_size = 32;
> +	}
> +
> +	for (i = 0; i < depth; i++) {
> +		char name[32], tag[64];
> +
> +		lock_off = i ? node_size : 0;
> +		root_off = lock_off + 8;
> +		size = i == depth - 1 ? node_size : root_off + 16;
> +		snprintf(name, sizeof(name), "graph_owner_%d", i);
> +		id = btf__add_struct(btf, name, size);
> +		if (!ASSERT_GT(id, 0, "btf__add_struct graph_owner"))
> +			goto out;
> +		if (i) {
> +			err = btf__add_field(btf, "node", node_type, 0, 0);
> +			if (!ASSERT_OK(err, "btf__add_field graph_owner::node"))
> +				goto out;
> +		}
> +		if (i == depth - 1)
> +			continue;
> +		err = btf__add_field(btf, "lock", SPIN_LOCK, lock_off * 8, 0);
> +		if (!ASSERT_OK(err, "btf__add_field graph_owner::lock"))
> +			goto out;
> +		err = btf__add_field(btf, "root", root_type, root_off * 8, 0);
> +		if (!ASSERT_OK(err, "btf__add_field graph_owner::root"))
> +			goto out;
> +		snprintf(tag, sizeof(tag), "contains:graph_owner_%d:node", i + 1);
> +		err = btf__add_decl_tag(btf, tag, id, i ? 2 : 1);
                ^^^

This isn't a bug, but btf__add_decl_tag() returns a BTF type id, yet here
it is stored in err and checked with ASSERT_GT(err, 0). The same call in
test_mixed_cycle() uses id (id = btf__add_decl_tag(...); ASSERT_EQ(id, 8,
...)). id is already declared in test_graph_depth and every other
btf__add_* id in the function goes through it, so this one assignment
reads like an error code when it is not.

Since id is already in scope here, would using it for the decl-tag id keep
the id/err split consistent with the rest of the file?

> +		if (!ASSERT_GT(err, 0, "btf__add_decl_tag graph_owner"))
> +			goto out;
> +	}
> +
> +	err = btf__load_into_kernel(btf);
> +	ASSERT_EQ(err, expected_err, "check btf");
> +out:
> +	btf__free(btf);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34850327177
--===============8521541796254080504==--
