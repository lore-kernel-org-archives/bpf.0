Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336BC40DB4F
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798278; cv=none; b=Zb9crAdqWMOT8zu2n0RK3u984Ce0XKkQrhTMlaXsmIZAtRCdt1ClnSNDNmuxP72hUJKgUEC851YQcAI4E5r0mAh3xlvBREp97dqadRX9w+ILyN5BZr12619KZDr/Y25GQ4sFNGid91H6SWuA1biGIaM+0/EfbVDlgYeluC3mg9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798278; c=relaxed/simple;
	bh=4/mcN/EcCaIlm8d8QIHw2brid/uQNJKPCO93nTCtQqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DzwqL1jRoQx1QAD1bJmVbwpjeREx7v9DmGHszHIbKUiS07CRSHlyvoTKN5hx1rcJEqtpWI0O+ce+by345j+8vusVM/k72Y/pUypQ+bFroOaH7xVbW/DcpaU7VOcPVkX3qFRUuqOWJuOvhH1P+XrIPGA6N9cX66xkfCFa+guKOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8Hbsg8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8Hbsg8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C1F1F00A3A;
	Thu, 23 Jul 2026 09:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784798276;
	bh=A0EauC+UsliygWqKDwTRnhoHfWnuKfX0e/GfRofA9rY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C8Hbsg8KXSOeXc+e4eoCPUaDt2QdUqJZ3J85e8NRQ5WY17xmRZ/VTpoZ1jvnPUB8I
	 0bXIgA4pQN/e1ZqpTzb8USkgY9jyVzg3Iz8+4UWhtb4vKF8MbkMVq0K7sfL11Jtrmm
	 +gyAOwhEnx8id9ELE7TibERCk0Jo4MLcE4x0RKhqReUgvTxqvSCOQ5Z5D5GB3FIxFQ
	 hHaJVHWh4+ClhrXSS5tBYROOrB5NUo6EzVSbB1cLo8KKjbWSa65vk3RsxHc1vF7p84
	 o6qR+GvkLTIRjjmXzVK2CIqRV8dnT8ikpCfxvvo4ijmveaCfyh1/drt9/ec131JY2c
	 Jw2/k8VVH6Mmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 3/5] selftests/bpf: Fix missing allocation
 null checks in test_progs.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Yang" <yangfeng59949@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723085100.482147-4-yangfeng59949@163.com>
References: <20260723085100.482147-1-yangfeng59949@163.com>
 <20260723085100.482147-4-yangfeng59949@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:17:55 +0000
Message-Id: <20260723091756.78C1F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Early return from `dispatch_thread_send_subtests` leaves `subtest_=
states` partially uninitialized, leading to a crash during cleanup.
- [High] Missing NULL check for `strdup` in `dispatch_thread_send_subtests`=
 leads to a potential segmentation fault.
- [High] Updating `subtest_num` before allocating `subtest_states` leads to=
 a NULL pointer dereference during cleanup if an error occurs.
- [Medium] Failing `realloc` in `test__start_subtest_with_desc` overwrites =
the original pointer, leaking the array.
--

--- Patch [3]: [PATCH v3 bpf-next 3/5] selftests/bpf: Fix missing allocatio=
n null checks in test_progs.c ---
commit d01ffcd5c8b16e028e42c669b9b1234582456211
Author: Feng Yang <yangfeng@kylinos.cn>

selftests/bpf: Fix missing allocation null checks in test_progs.c

Add null checks after memory allocations to prevent potential segmentation =
faults.

Fixes: 79b453501310 ("tools/bpf: add a test for bpf_get_stack with tracepoi=
nt prog")
Fixes: 0925225956bb ("bpf/selftests: Add granular subtest output for prog_t=
est")

> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
> index 312743c4337fd..301c6e11ceafa 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c

[ ... ]

> @@ -1514,6 +1517,10 @@ static int dispatch_thread_send_subtests(int sock_=
fd, struct test_state *state)
>  	int subtest_num =3D state->subtest_num;
> =20
>  	state->subtest_states =3D malloc(subtest_num * sizeof(*subtest_state));

[Severity: High]
This isn't a bug introduced by this patch, but because malloc() does not
zero-initialize memory, could the early return below cause a segmentation f=
ault
during test teardown?

If read_prog_test_msg() returns an error, dispatch_thread_send_subtests()
returns 1:

tools/testing/selftests/bpf/test_progs.c:dispatch_thread_send_subtests() {
    ...
	for (int i =3D 0; i < subtest_num; i++) {
		subtest_state =3D &state->subtest_states[i];
		memset(subtest_state, 0, sizeof(*subtest_state));

		if (read_prog_test_msg(sock_fd, &msg, MSG_SUBTEST_DONE))
			return 1;
    ...
}

Any elements after index 'i' are left containing uninitialized memory. Late=
r,
free_test_states() iterates through the entire array based on subtest_num a=
nd
attempts to free the pointers in each element:

tools/testing/selftests/bpf/test_progs.c:free_test_states() {
    ...
	for (j =3D 0; j < test_state->subtest_num; j++)
		free_subtest_state(&test_state->subtest_states[j]);
    ...
}

tools/testing/selftests/bpf/test_progs.c:free_subtest_state() {
    ...
	free(state->log_buf);
    ...
}

Would it be safer to use calloc() instead of malloc() here to guarantee the
entire array is zero-initialized?

> +	if (!state->subtest_states) {
> +		state->subtest_num =3D 0;
> +		return -ENOMEM;
> +	}
> =20
>  	for (int i =3D 0; i < subtest_num; i++) {
>  		subtest_state =3D &state->subtest_states[i];

[Severity: High]
This is a pre-existing issue, but does the strdup() call later in this
function need a NULL check?

tools/testing/selftests/bpf/test_progs.c:dispatch_thread_send_subtests() {
    ...
		if (read_prog_test_msg(sock_fd, &msg, MSG_SUBTEST_DONE))
			return 1;

		subtest_state->name =3D strdup(msg.subtest_done.name);
    ...
}

If memory allocation fails, subtest_state->name becomes NULL. When
dump_test_log() processes the results, it passes this to jsonw_string_field=
()
which eventually reaches jsonw_puts(). Since jsonw_puts() unconditionally l=
oops
over the string characters, passing it a NULL pointer leads to a segmentati=
on
fault.

[Severity: High]
This is also a pre-existing issue, but does updating state->subtest_num bef=
ore
allocating state->subtest_states lead to a NULL pointer dereference?

In dispatch_thread(), subtest_num is set before the array is allocated:

tools/testing/selftests/bpf/test_progs.c:dispatch_thread() {
    ...
			state->subtest_num =3D msg.test_done.subtest_num;

			/* collect all logs */
			if (msg.test_done.have_log) {
				if (dispatch_thread_read_log(sock_fd,
							     &state->log_buf,
							     &state->log_cnt))
					goto error;
			}
    ...
}

If dispatch_thread_read_log() fails, the thread exits on error. During
cleanup, free_test_states() iterates up to state->subtest_num:

tools/testing/selftests/bpf/test_progs.c:free_test_states() {
    ...
	for (j =3D 0; j < test_state->subtest_num; j++)
		free_subtest_state(&test_state->subtest_states[j]);
    ...
}

Because subtest_states is still NULL, free_subtest_state() receives a NULL
pointer (or near-NULL for j > 0) and attempts to free state->log_buf from i=
t,
resulting in a crash.

[Severity: Medium]
This is another pre-existing issue, but does this realloc() pattern leak the
subtest_states array on failure?

tools/testing/selftests/bpf/test_progs.c:test__start_subtest_with_desc() {
    ...
	state->subtest_states =3D
		realloc(state->subtest_states,
			state->subtest_num * sub_state_size);
    ...
}

If realloc() fails, it returns NULL and overwrites the original pointer, lo=
sing
the only reference to the previously allocated memory block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723085100.4821=
47-1-yangfeng59949@163.com?part=3D3
