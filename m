Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1306372ECA
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870222; cv=none; b=f48oEGauurmYOmJIvXKIwyXs8RQdkGxr2v7j9oJXsnG+40EwXMdFOkAYwIupX/ZmVVj4dyulWLKlrQvkdxQRpsFzqw03y1dLe4H4BJQdqAWf2cXeu5W6OqmTJiEklbA90wjrTy6CYOVU41mJsBPyFSFHk72kfMFRFJzmOOqosfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870222; c=relaxed/simple;
	bh=As3Bd82gvjHtodWsTzHPp9Extcr9z/5CC1jfsZrsDSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RW7kWVaNuxBG4TXgXNvec9p88887yYeGRhhRBqPPunohG2nBgH28h7eyUAY2nWf3EdvtnJOC1POK4JwDdhaAc6GK9iv+jw/p556SXVqouqlgHtE1liokHTazxFKSeU08KYIkLRCAzs4owhCphwnfFvqT3tEub2yp7DiRdClc5sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttJDozRS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttJDozRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31941C2BCB0;
	Fri, 15 May 2026 18:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778870219;
	bh=As3Bd82gvjHtodWsTzHPp9Extcr9z/5CC1jfsZrsDSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ttJDozRSN5Zs8RZlsgfPVOMs3IJPbaENddGB6UcsxsuZS8hpjyLUYAebMGZ+JxTbB
	 t91Gp8V24W/2GW8KHkl7WpWOMR3BL4YUH7lUtlvvebMK0rH9oA3/uCsQAxlekeJ2mp
	 jEIbRqSRuU3qrmIhk4B6ixTo2s1TuDGXJQ3/ejqWaMURxrLNkK9tGQXaZYRXVqYj0L
	 G1EGdrgLaqZoLbhnBbX7ZagPAcgbVHA5c6MdtHjimPYFDeOUiWPGdUaqwhYgmKK4pG
	 MEnAlDNP2wPjmNrnbVeW7loBZuIytY5Lvu6jmG6Dv6uqMOAyPdTs/jdr20ZfxRcLVY
	 7+9/gVJY+/f1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add test for tracepoint
 btf_ids tracefs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515-generic_tracepoint-v1-3-aa619fa94132@meta.com>
References: <20260515-generic_tracepoint-v1-3-aa619fa94132@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 18:36:58 +0000
Message-Id: <20260515183659.31941C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing test environment check for `bpf_testmod` module causes s=
purious test failures.
- [Medium] Out-of-bounds array reads and cascading failures due to non-abor=
ting assertions and missing length checks.
--

commit 1c2fbe8e9b6c6c1082b4ae630c67ceb3b5db79b5
Author: Mykyta Yatsenko <yatsenko@meta.com>

selftests/bpf: Add test for tracepoint btf_ids tracefs file

This commit adds a selftest to verify that the BTF IDs exposed in the
tracefs btf_ids file for a module tracepoint match the expected FUNC_PROTO
and STRUCT representations. It uses the bpf_testmod_test_read tracepoint
to exercise the module/split-BTF path.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c b/tools/=
testing/selftests/bpf/prog_tests/tp_btf_ids.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c

[ ... ]

> +void test_tp_btf_ids(void)
> +{
> +	const struct btf_type *proto_t, *rec_t;
> +	const struct btf_param *params;
> +	const struct btf_member *members;
> +	struct btf_ids_info info;
> +	struct btf *vmlinux_btf, *btf;
> +	const char *name;
> +	int err;
> +

Since this test relies on bpf_testmod_test_read from the bpf_testmod.ko
kernel module, should there be a check for env.has_testmod here?=20

Without it, if the module is not loaded, the test might fail with a missing
tracefs directory instead of gracefully skipping via test__skip().

> +	err =3D read_btf_ids(&info);
> +	if (!ASSERT_OK(err, "read btf_ids"))
> +		return;

[ ... ]

> +	/*
> +	 * raw_btf_id should be the FUNC_PROTO of __bpf_trace_<call>:
> +	 *   void *__data, struct task_struct *task,
> +	 *   struct bpf_testmod_test_read_ctx *ctx
> +	 */
> +	proto_t =3D btf__type_by_id(btf, info.raw_id);
> +	if (!ASSERT_OK_PTR(proto_t, "raw type_by_id"))
> +		goto out;
> +	if (!ASSERT_TRUE(btf_is_func_proto(proto_t), "raw is FUNC_PROTO"))
> +		goto out;
> +	ASSERT_EQ(btf_vlen(proto_t), 3, "func_proto arg count");
> +
> +	params =3D btf_params(proto_t);
> +	ASSERT_STREQ(param_name(btf, &params[0]), "__data", "arg0 name");
> +	ASSERT_STREQ(param_name(btf, &params[1]), "task", "arg1 name");
> +	ASSERT_STREQ(param_name(btf, &params[2]), "ctx", "arg2 name");

Does this code risk reading out of bounds if btf_vlen(proto_t) is less than=
 3?

The ASSERT_EQ macro logs a failure but does not inherently abort the
function execution. Should this be wrapped in a conditional check, such as
if (!ASSERT_EQ(...)) goto out, to prevent accessing params[2] if the length
is too small?

> +
> +	/*
> +	 * tp_btf_id should be STRUCT trace_event_raw_<call> with the
> +	 * fields declared by TP_STRUCT__entry plus the common header.
> +	 */
> +	rec_t =3D btf__type_by_id(btf, info.tp_id);
> +	if (!ASSERT_OK_PTR(rec_t, "tp type_by_id"))
> +		goto out;
> +	if (!ASSERT_TRUE(btf_is_struct(rec_t), "tp is STRUCT"))
> +		goto out;
> +	name =3D btf__name_by_offset(btf, rec_t->name_off);
> +	ASSERT_STREQ(name, "trace_event_raw_bpf_testmod_test_read",
> +		     "tp struct name");
> +
> +	members =3D btf_members(rec_t);
> +	ASSERT_STREQ(member_name(btf, &members[0]), "ent", "field0 name");
> +	ASSERT_STREQ(member_name(btf, &members[1]), "pid", "field1 name");
> +	ASSERT_STREQ(member_name(btf, &members[2]), "comm", "field2 name");
> +	ASSERT_STREQ(member_name(btf, &members[3]), "off", "field3 name");
> +	ASSERT_STREQ(member_name(btf, &members[4]), "len", "field4 name");

Similarly, is it necessary to assert btf_vlen(rec_t) and conditionally jump
to out if it is too small before accessing members[0] through members[4]?

If the structure layout changes or is malformed, this might read adjacent
BTF data.

> +out:
> +	btf__free(btf);
> +	btf__free(vmlinux_btf);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515-generic_tr=
acepoint-v1-0-aa619fa94132@meta.com?part=3D3
