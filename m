Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43D382284
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119586; cv=none; b=cuMN/1oA9hBd7t9yYhjupr5g256m8gUtNoK7OBX4iW0koLWpJwRL1AY/W+WBY+klo6dAn4yhwdp7tOFQvcbAgfnGd1aEgD29+dBroDfwMM4JwfHnfw90/xgVkmavVgUWZh0cneAVLfuNqKOlUrkjBqzyr+kvP76LkCzfgde9Eeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119586; c=relaxed/simple;
	bh=jl90nXtUKlOiv+N5LNjswTh72eVBnbJpKdMd3tf4ONk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MfnT/c9AYAiJSeIiKvNXisspJWUn7+2U2/6b83nzhp0IJmgeXm8Ten9JnSKCegxdgf+qaN4CKye0aFfQeTzN/90AhRt0w7x0d3mJwwHKZRZxHkNvrFDi1Rx3sifDRVTVZbwZCZ2HWt0SrLFA1e1GRFvU5HkCmIJzMsNTI2yGxBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myZQmAWD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myZQmAWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762AB1F000FF;
	Fri, 11 Sep 2026 09:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789119583;
	bh=Jmkg1urZAx+vHR5X/Pk9P9OitQsgEkHroL2nIRCCwtk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=myZQmAWDlYCDc22gTLRke6TuppOqRdH0Lh0CB71OPF4LvZ7BjEoiN1YmiGSZDfY1Q
	 zHLDFEWj7FWaWUps6OwZkD1S3yA9mYYeJOCqDS6u8bEHkKXgG5CccqN5pFpj4V0bfm
	 4tv4Gyv4JfNBgswzP/BO0Q0C7+ngiFC/AQtrFDuaTpz2yfKyFyw3bQwt12OHCXm8m0
	 o7Rf+aYkqLllp/PI84ITQ+mfrap6Wlb8JCHBrvlVFnvfuUofZM0mXAGj+d9LoEGccn
	 RgCYpbBOkm4UNdB+/pWtECJmWPG81zax2FeHNAPZQ5EJ8X1pa6E8DzC7WlF8bYJ9Kt
	 /8jBkGq9hX0aw==
Content-Type: multipart/mixed; boundary="===============1260246229495050407=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <74c957a3200eb508bb44b0e0033a28d79a35e78a7d135e5067c85e69fb25b5f6@mail.kernel.org>
In-Reply-To: <20260911084209.3481285-3-xyx2021@mail.ustc.edu.cn>
References: <20260911084209.3481285-3-xyx2021@mail.ustc.edu.cn>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test dynptr teardown on subprog return
From: bot+bpf-ci@kernel.org
To: xyx2021@mail.ustc.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 09:39:42 +0000 (UTC)

--===============1260246229495050407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> index 6dbd1487343c..122ecb7e98e2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> @@ -11,6 +11,7 @@
>  #include "bpf_qdisc_fail__invalid_dynptr.skel.h"
>  #include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
>  #include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
> +#include "bpf_qdisc_fail__invalid_dynptr_returned_slice.skel.h"
>  #include "bpf_qdisc_fail__untrusted_write.skel.h"
>  #include "bpf_qdisc_dynptr_use_after_invalidate_clone.skel.h"

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index 1cd61d72c166..f57e6162dbf5 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -127,7 +127,7 @@ static int missing_release_callback_fn(__u32 index, void *data)
>
>  /* Any dynptr initialized within a callback must have bpf_dynptr_put called */
>  SEC("?raw_tp")
> -__failure __msg("Unreleased reference id")
> +__failure __msg("cannot overwrite referenced dynptr")
>  int ringbuf_missing_release_callback(void *ctx)
>  {
>  	bpf_loop(10, missing_release_callback_fn, NULL, 0);

Does this __msg() update break bisectability?

Looking at missing_release_callback_fn():

static int missing_release_callback_fn(__u32 index, void *data)
{
	struct bpf_dynptr ptr;

	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
	return 0;
}

The callback reserves into its own (frame 1) stack and returns without
releasing.

Before patch 1/2, prepare_func_exit() calls check_resource_leak(), but
check_reference_leak() bails immediately on 'if (!exception_exit &&
cur_func(env)->frameno) return 0;' at verifier.c:10611, so the lingering
entry in vstate->refs[] is only diagnosed later, at the frame-0 BPF_EXIT,
as "Unreleased reference id".

With patch 1/2 applied, prepare_func_exit() now calls
destroy_dynptrs_on_func_exit() -> destroy_if_dynptr_stack_slot(), where
dynptr_type_referenced(BPF_DYNPTR_TYPE_RINGBUF) is true and
dynptr_ref_cnt() == 1, so verification aborts at the callback return with
"cannot overwrite referenced dynptr" and never reaches the frame-0 leak
check.

So at commit 02912d1bbebc ("bpf: Destroy callee-local dynptrs on subprog
return") the old __msg() no longer matches and 'test_progs -t dynptr'
reports a failure at that intermediate commit.

Should the expectation update for this existing test move into patch 1/2,
since that's where the verifier output changes?

Also, the surviving comment "/* Any dynptr initialized within a callback
must have bpf_dynptr_put called */" and the test name 'missing_release'
still describe the old leak diagnostic that the verifier no longer emits
here. Should the comment be reworded to reflect that the program is now
rejected for losing the last dynptr that can release the reservation,
rather than for leaking it?

[ ... ]

> @@ -1892,6 +1892,101 @@ int clone_invalidate4(void *ctx)
>  	return 0;
>  }
>
> +static __noinline void clone_slice_in_subprog(struct bpf_dynptr *ptr, int **data)
> +{
> +	struct bpf_dynptr clone;
> +
> +	bpf_dynptr_clone(ptr, &clone);
> +	*data = bpf_dynptr_data(&clone, 0, sizeof(val));
> +}
> +
> +static __noinline void caller_slice_in_subprog(struct bpf_dynptr *ptr, int **data)
> +{
> +	struct bpf_dynptr clone;
> +
> +	*data = bpf_dynptr_data(ptr, 0, sizeof(val));
> +	bpf_dynptr_clone(ptr, &clone);
> +}
> +
> +static __noinline void reserve_dynptr_in_subprog(void)
> +{
> +	struct bpf_dynptr ptr;
> +
> +	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
> +}

[ ... ]

> +/*
> + * A slice that escapes a clone's call frame is invalid once the local
> + * clone is destroyed on return.
> + */
> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
> +int clone_slice_returned_frame_invalid(void *ctx)
> +{
> +	struct bpf_dynptr ptr;
> +	int *data = NULL;
> +
> +	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
> +	clone_slice_in_subprog(&ptr, &data);
> +	if (data)
> +		/* this should fail */
> +		*data = 123;
> +	bpf_ringbuf_submit_dynptr(&ptr, 0);
> +
> +	return 0;
> +}
> +
> +/*
> + * Releasing the shared reservation must invalidate a slice that escaped
> + * from a clone's call frame.
> + */
> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
> +int clone_slice_returned_frame_release_invalid(void *ctx)
> +{
> +	struct bpf_dynptr ptr;
> +	int *data = NULL;
> +
> +	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
> +	clone_slice_in_subprog(&ptr, &data);
> +	bpf_ringbuf_submit_dynptr(&ptr, 0);
> +	if (data)
> +		/* this should fail */
> +		*data = 123;
> +
> +	return 0;
> +}

Does clone_slice_returned_frame_release_invalid() actually test what the
comment claims?

The comment says "Releasing the shared reservation must invalidate a slice
that escaped from a clone's call frame", suggesting that
bpf_ringbuf_submit_dynptr(&ptr, 0) is what kills 'data'.

But with this series, 'data' is already dead one instruction earlier: when
clone_slice_in_subprog() returns, destroy_dynptrs_on_func_exit() calls
destroy_if_dynptr_stack_slot() which calls release_reference(clone.id).
That walks every frame (bpf_for_each_reg_in_vstate_mask, mask includes
STACK_SPILL) and marks the spilled slice in the caller's stack invalid,
because bpf_dynptr_data() set regs[R0].parent_id = clone's dynptr id
(verifier.c:11305).

So the verifier rejects '*data = 123' for exactly the same reason as
clone_slice_returned_frame_invalid(): the clone is destroyed at subprog
return. The position of bpf_ringbuf_submit_dynptr() doesn't matter and
this test can't distinguish a kernel where release-time invalidation of
escaped slices works from one where it does not.

The two functions differ only in where the submit is placed, making this
second test a copy of the first with a comment that overstates it. The
commit message also says "Cover immediate use of a ring buffer clone
slice, use after the shared reservation is released", but both fail at the
same point.

Would it make sense to either drop this test, or make it actually test
release-time invalidation? For example, deriving the escaping slice from
the caller-owned dynptr (as caller_slice_in_subprog() does) would let the
slice survive the subprog return, so only the submit can invalidate it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34582138838
--===============1260246229495050407==--
