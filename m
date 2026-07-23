Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4341D12A
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798940; cv=none; b=T/qv5ivVaEhgyNJnbluqAqXwMLNHWBST/NlNk/X/tai760jydWpeien4L6cavt4d+gcanuiRWUM2Xxrha/Fgd8gnniol5wy3b0gytBt424Y8mqhSosC7qFZuKwdcUYt079LM0bybiKIdvRzoJdAqdOFColwwMDsMFEgkfL/LSZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798940; c=relaxed/simple;
	bh=n6dQemquddMKWqXFlfpepf1WoqrjL++uIWDANedMxFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oc43unhy7OApuiHf5UmNMJOoc8ytEwTupqTBzv4I4oDlngkyDRLHRi0j2GSqFSY7iKW2bm8FLGgAclZxQljP1iLwNeRW9FrrHatKzyuDo4hmwc93BP8CZru1lqTsKUWU621ds9hN8fGVIueUaNAjNo2/fhHch+4hcKavtqqcmag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAB01F00A3A;
	Thu, 23 Jul 2026 09:28:55 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 4/5] selftests/bpf: Use calloc to allocate
 subtest_states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Yang" <yangfeng59949@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723085100.482147-5-yangfeng59949@163.com>
References: <20260723085100.482147-1-yangfeng59949@163.com>
 <20260723085100.482147-5-yangfeng59949@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:28:47 +0000
Message-Id: <20260723092855.0EAB01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak and NULL pointer dereference in `test__start_subtest_w=
ith_desc()` on `realloc()` failure.
- [High] Protocol errors or worker crashes during log/subtest retrieval cau=
se tests to be falsely reported as successful.
--

--- Patch [4]: [PATCH v3 bpf-next 4/5] selftests/bpf: Use calloc to allocat=
e subtest_states ---
commit c27dc00f23d100647c7fe316391aa3eb9b2496b5
Author: Feng Yang <yangfeng@kylinos.cn>

selftests/bpf: Use calloc to allocate subtest_states
   =20
An early return triggered by read_prog_test_msg leaves uninitialized elemen=
ts,
which leads to memory corruption during free_test_states cleanup.

> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
> index 301c6e11ceafa..07da45230c4bf 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1516,7 +1516,7 @@ static int dispatch_thread_send_subtests(int sock_f=
d, struct test_state *state)
>  	struct subtest_state *subtest_state;
>  	int subtest_num =3D state->subtest_num;
> =20
> -	state->subtest_states =3D malloc(subtest_num * sizeof(*subtest_state));
> +	state->subtest_states =3D calloc(subtest_num, sizeof(*subtest_state));

[Severity: High]
This is a pre-existing issue, but is it possible to leak state->subtest_sta=
tes
and cause a NULL pointer dereference in test__start_subtest_with_desc() on a
realloc() failure?

If realloc() fails, it returns NULL which overwrites the only pointer to
the existing array, leaking the previously allocated memory:

tools/testing/selftests/bpf/test_progs.c:test__start_subtest_with_desc() {
...
	state->subtest_num++;
	state->subtest_states =3D
		realloc(state->subtest_states,
			state->subtest_num * sub_state_size);
...
}

Because state->subtest_num is incremented before the failure, the cleanup
code in free_test_states() will attempt to iterate over the now-NULL
subtest_states array:

tools/testing/selftests/bpf/test_progs.c:free_test_states() {
...
		for (j =3D 0; j < test_state->subtest_num; j++)
			free_subtest_state(&test_state->subtest_states[j]);
...
}

Can this compute an invalid address and cause a segmentation fault when try=
ing
to free the test states?

>  	if (!state->subtest_states) {
>  		state->subtest_num =3D 0;
>  		return -ENOMEM;
> @@ -1525,8 +1525,6 @@ static int dispatch_thread_send_subtests(int sock_f=
d, struct test_state *state)
>  	for (int i =3D 0; i < subtest_num; i++) {
>  		subtest_state =3D &state->subtest_states[i];
> =20
> -		memset(subtest_state, 0, sizeof(*subtest_state));
> -
>  		if (read_prog_test_msg(sock_fd, &msg, MSG_SUBTEST_DONE))
>  			return 1;

[Severity: High]
This isn't a bug introduced by this patch, but what happens if a protocol e=
rror
or a worker crash occurs during log or subtest retrieval?

In dispatch_thread(), the test is marked as successful before all of its
logs and subtest states are collected:

tools/testing/selftests/bpf/test_progs.c:dispatch_thread() {
...
			state =3D &test_states[test_to_run];
			state->tested =3D true;
			state->error_cnt =3D msg.test_done.error_cnt;
...
			if (dispatch_thread_send_subtests(sock_fd, state))
				goto error;
...
}

If dispatch_thread_send_subtests() returns 1 because read_prog_test_msg()
fails (e.g., due to a worker crash or a closed socket), the dispatcher thre=
ad
jumps to the error label and exits.

Because state->tested is already true and error_cnt is 0 (assuming the main
test passed before the crash), calculate_summary_and_print_errors() adds the
test to succ_cnt. Does this falsely report the incomplete or crashed test as
successful and mask test suite failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723085100.4821=
47-1-yangfeng59949@163.com?part=3D4
