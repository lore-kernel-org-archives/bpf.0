Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961089;
	b=vcVB8k0m7kSibYTTwbKYncRKTvc6PYGafhzc6E2ZSEyR0PJvrbMhaUD3fiN1zJClimgH
	 q2MvZGJMRaNqEsGxI63Whkw/dDLWEvB5NX7gIji3o9iH0AVgOnlXt5kzaVd6iqJnq7SSx
	 wdkxp4b+I0EQ7mWQJBlJn2NoWspd2qHOuvJvA4p7rwYlo8RDgL9rn9REdXvlY5hP3RDy8
	 YV6QOqaFstt41Ytbt39t0ailsZ02/6QecWA+GxGXHwwC+9wXBGFJA/UHB3jYiXMbgceiy
	 C+7eK5OnQRuB1qGba/zyJUA6FPJ1cGN2hqn0U7o8B4VaUEclYvCp1O44/djI0pEQJ6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961089;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ERIsxXnToKJjPsYdUFNi3i65e2yRcLhyRnRcNHkaRyw=;
	b=SsKVZ+7dCFTz9Dmwhcy4qpOnenXAm0iNiU4NIwznRUVdesEjB2oQkKlYiDgVyMP3fl0d
	 VE7OsTKQsHhiDZGhOB/a/r+Hwt2/dgfoi8XnP5muHkLodiZuj9rzYgiIdBDbItvK5/WoY
	 4ECZdHeeaDn00zkSqt/ApSrnEZgjuOQAWL+tiqjtrWqsHEwZFw4DgjTEN96ydgVO5gW46
	 3q6uHKZ3qILQ6IsWsHsjCyJOLL8mpGBPlLx4reYV6xMAXsCc6PQMpE8zEqZsys99zMTdB
	 +IJWjhauGkYi/7hvcFK3OblnqiWYBFDVLDm5O6g/tPFKAgYaD82Ad37VAsrmAt8eKgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpbLuzHX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55937606A334
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpbLuzHX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC6F1F008A1;
	Fri,  6 Nov 2026 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793961088;
	bh=ERIsxXnToKJjPsYdUFNi3i65e2yRcLhyRnRcNHkaRyw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YpbLuzHXo+JgeFRtENkFZhUFl06/2blItGbQoWUK6AWxITP6mreUGx4GYxGSQeEzb
	 ju0gEmRm6kNNA1rx073YoshQKyb2uRKI+zZap+lCG//q7SRMojrqdcVh4bmPVPNf69
	 TQN29Wa8/zhCET6y5LZ1D6IBmr+i1wwQGj0fAu91OmF6ZBQIoGnVltaZsJPM/fyvj9
	 v4dhn5B32aeYWqf4w7KAl8rmRRci7TisUZPhSBcDpokoZjyfe3lqOjunCO6jqyKss6
	 y2Udz0VwLVlcXhJrUHVJvU3hlVxu2wIp3bhDLXW7WSnJBcqgbXctTxsbWQWSphzcZt
	 2eVQrPjpVnHPg==
Content-Type: multipart/mixed; boundary="===============4186881813985110582=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7cac6014eda1beb0bffef7cff25838a118608be41fb77cca81a645795fecfaf2@mail.kernel.org>
In-Reply-To: <20261106095747.471718-9-luyun_611@163.com>
References: <20261106095747.471718-9-luyun_611@163.com>
Subject: Re: [PATCH bpf-next v2 8/8] selftests/bpf: Check bpf_timer value membership
From: bot+bpf-ci@kernel.org
To: luyun_611@163.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 10:31:28 +0000 (UTC)

--===============4186881813985110582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Check bpf_timer value membership

TL;DR: Test-only nits, no bug found: the new bpf_timer membership selftest
nearly duplicates the bpf_wq one, and its single-use macros could be plain
functions or shared code.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_timer_membership.c b/tools/testing/selftests/bpf/prog_tests/bpf_timer_membership.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_timer_membership.c

[ ... ]

> +struct timer_case {
> +	struct bpf_timer_membership *skel;
> +	struct bpf_map *map;
> +	struct bpf_program *prog;
> +	bool array;
> +	int fd;
> +};
> +
> +static struct timer_case open_case(enum bpf_map_type type, __u32 flags)
> +{
> +	struct timer_case c = {};
> +	int err;
> +
> +	c.skel = bpf_timer_membership__open();

This isn't a bug, but this file matches prog_tests/bpf_wq_membership.c
except for the renames (wq_case/timer_case, the skeleton names and the
test entry point).  open_case(), run_cmd(), cb_count(), wait_cb(), seed(),
drop_elem(), check_init_start(), subtest_live(), subtest_delete() and
subtest_replace() are the same in both.

Could the two tests share one host-side driver, for example one skeleton
with a timer map and a wq map, or a shared header, instead of two copies?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/bpf_timer_membership.c b/tools/testing/selftests/bpf/progs/bpf_timer_membership.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_timer_membership.c

[ ... ]

> +#define DEFINE_TIMER_MAP(map_sym, value_type)				\
> +static int map_sym##_cb(void *map, int *key, void *value)		\
> +{									\
> +	value_type *v = value;						\
> +									\
> +	__sync_fetch_and_add(&cb_count[v->cookie & (CB_SLOTS - 1)], 1);	\
> +	return 0;							\
> +}									\
> +									\
> +SEC("syscall")								\
> +int map_sym##_run(void *ctx)						\

[ ... ]

This isn't a bug, but DEFINE_TIMER_MAP is expanded only once, as
DEFINE_TIMER_MAP(values, struct timer_value), and TIMER_DELETE_INIT is
also used only once.  The userspace side switches the map type with
bpf_map__set_type(), so a single map is all the program needs.

The result is a program body of about 75 lines of backslash-continued
macro text, and TIMER_DELETE_INIT quietly depends on a local named key in
the caller.  The file is also nearly line-for-line the same as
progs/bpf_wq_membership.c.

Since DEFINE_TIMER_MAP is expanded only once, could values_cb() and
values_run() be ordinary functions?  Alternatively, could the shared
delete/replace logic go in a header used by both this file and
bpf_wq_membership.c?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42200504781
--===============4186881813985110582==--
