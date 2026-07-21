Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B7444E045
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627745; cv=none; b=m9KZH+ImqIAL/xwjljnLAzpe5mMmZPhFmRKOTxBqgjN1ZwmJxq98a52s66XQQ3rqOFkghdo87AS/3JTc8jFEkrZFh2b+lSZFouparvP9QlB+siwlw4P2ZSZIGi1Qr1LqTNL41ZT160XQWMeG3HhbFu8sGcA8OOjMheEKhToZbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627745; c=relaxed/simple;
	bh=Gi9KqnjpAyBuYlm0a4nPgu0S9Rw0bYXr90RdSf/zhm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UPkT3rim9oeUXjDM/AqzeP/0Xlcbvav27Ht1RSuNOYhefpJYiLr6v/cC44DzodJprHSDUcalAggwx2aZKthpp7tjaTSib6SXMakZbMIlftYFXaqgOAZtqesurDf4/k3RsQ8nsTB+0qO5xeDlNU1SWtUe9LfRUTBVoeGgPan1eFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8BZhxHd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8BZhxHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63A41F00A3A;
	Tue, 21 Jul 2026 09:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627743;
	bh=w8XIX1H1fk19bS580F1wtmzuDlHuW3gUe0CIUuFqRJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8BZhxHdCVQqVF/fzZP2pLxv7U1PChm0k2ZaRBd5p5Oz2Vl9PB4vr3aY86uN/Qv0p
	 F0BLV6VQYBODqAUhyB9azhOlDWUd4Vc3fxNXb6ltpTZd2Wpny/J+AFGnk99SQ1Yunq
	 medWa/XsD0fRmv+ri12MxT439khkVVETYVLYatdE7GVvsxPJJfx9TbIzZhlChGGU/A
	 cD3Uf00D8Xcj7rpAJugqr3CuyjZpkKqwGm5+e3j6kyDf/tf7SDZzHCcyzXZ5TNRKCT
	 15cbNP6Y0HOLiNeAc5pK0UA6jeEMMdNen0W0TrLOmmBv95ujbQi9vF6cZm1tYIk+vi
	 VTQX8WX7TTjDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix double free of name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Yang" <yangfeng59949@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721094404.593127-1-yangfeng59949@163.com>
References: <20260721094404.593127-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 09:55:42 +0000
Message-Id: <20260721095543.C63A41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing NULL check for `malloc()` return value when allocating `=
subtest_states` array in `dispatch_thread_send_subtests()`.
- [Medium] Early return in `dispatch_thread_send_subtests()` leaves array e=
lements uninitialized, leading to memory corruption when freed.
- [Medium] `realloc()` failure in `test__start_subtest_with_desc` causes a =
memory leak and subsequent NULL pointer dereference.
- [Medium] Missing checks for NULL subtest name in `test__start_subtest_wit=
h_desc()` lead to a segfault via `strscpy()`.
--

--- Patch [1]: [PATCH bpf-next] selftests/bpf: Fix double free of name ---
commit 297db6a341af110e628f3b4e73b2087ba183e417
Author: Feng Yang <yangfeng@kylinos.cn>
selftests/bpf: Fix double free of name

This commit removes an unnecessary free of subtest_state->name in
worker_main_send_subtests to fix a double-free issue, since it is
already handled by free_subtest_state.

> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
> index 7ba82974ee784..1d3caf9969717 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1886,7 +1886,6 @@ static int worker_main_send_subtests(int sock, stru=
ct test_state *state)
>  			worker_main_send_log(sock, subtest_state->log_buf, subtest_state->log=
_cnt);
> =20
>  		free_subtest_state(subtest_state);
> -		free(subtest_state->name);
>  	}
> =20
>  out:

This is a pre-existing issue, but looking at dispatch_thread_send_subtests,
there doesn't seem to be a NULL check after allocating subtest_states:

tools/testing/selftests/bpf/test_progs.c:dispatch_thread_send_subtests() {
    ...
    state->subtest_states =3D malloc(subtest_num * sizeof(*subtest_state));

    for (int i =3D 0; i < subtest_num; i++) {
        subtest_state =3D &state->subtest_states[i];

        memset(subtest_state, 0, sizeof(*subtest_state));
    ...
}

[Severity: Medium]
If malloc fails, could this cause a segmentation fault when the loop attemp=
ts
to memset the address relative to NULL?

Additionally, if read_prog_test_msg returns early:

tools/testing/selftests/bpf/test_progs.c:dispatch_thread_send_subtests() {
    ...
        memset(subtest_state, 0, sizeof(*subtest_state));

        if (read_prog_test_msg(sock_fd, &msg, MSG_SUBTEST_DONE))
            return 1;
    ...
}

[Severity: Medium]
This is a pre-existing issue, but since the array was allocated with malloc
rather than calloc, does this early return leave the remaining array elemen=
ts
uninitialized? If so, when free_test_states iterates up to subtest_num and
calls free on state->name or state->log_buf, could it cause memory corrupti=
on
by freeing garbage pointers?

This isn't a bug introduced by this patch, but looking at
test__start_subtest_with_desc, the realloc pattern appears to overwrite
the pointer on failure:

tools/testing/selftests/bpf/test_progs.c:test__start_subtest_with_desc() {
    ...
    state->subtest_states =3D
        realloc(state->subtest_states,
            state->subtest_num * sub_state_size);
    if (!state->subtest_states) {
        fprintf(stderr, "Not enough memory to allocate subtest result\n");
        return false;
    }
    ...
}

[Severity: Medium]
If realloc fails, does this overwrite the only pointer to the allocated
memory, causing a leak? Furthermore, since state->subtest_num was already
incremented without being rolled back, could the loop in
worker_main_send_subtests later dereference the NULL array?

This is a pre-existing issue, but if strdup fails or an empty name is
provided in test__start_subtest_with_desc, it returns early:

tools/testing/selftests/bpf/test_progs.c:test__start_subtest_with_desc() {
    ...
    subtest_state->name =3D strdup(subtest_display_name);
    if (!subtest_state->name) {
        fprintf(env.stderr_saved,
            "Subtest #%d: failed to copy subtest name!\n",
            state->subtest_num);
        return false;
    }
    ...
}

[Severity: Medium]
Because state->subtest_num is already incremented before this early return,
the subtest state is left partially initialized with name as NULL. When
worker_main_send_subtests later unconditionally copies the name:

tools/testing/selftests/bpf/test_progs.c:worker_main_send_subtests() {
    ...
        strscpy(msg.subtest_done.name, subtest_state->name, MAX_SUBTEST_NAM=
E);
    ...
}

Could this result in a NULL pointer dereference, as strscpy does not
validate the source pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721094404.5931=
27-1-yangfeng59949@163.com?part=3D1
