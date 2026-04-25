Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4591509AB
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 04:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777091506; cv=none; b=CzJWlZviJseBHbI1HTpjc/lM0AYJ2PTTIygQI46ayLPWzwkZiqbNeJk4T7UoWf6a41XlMd2gevHAdmZL+EZ0Dof5q58WkyMkEoQFqGUfDJ7jV08CQPc3wVSdWl9+PqSofVd577lbJmr05PQo6ZxzJocDoYH1/cOeAdVk/oUKmj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777091506; c=relaxed/simple;
	bh=kLik9mOEuc+c03e5F3qTuQ2Iz9uDz2w90cibOlen4Zk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Epif9sbCthE2iZOXqet10T+HOS48o+GAJwaCL8JG45ot2Lc3akBXCLQvyNWMEveWPfVjRqLFWy4jTpSD7DcNuYJ8BZSxiuJZpGDxnntjX4W2q3gkr3lLwMR3fws3Na2RxLbB9i5aFvKFzLwjRCbUdnKcYdpbqbzg77qVgDq2PR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9novl/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9novl/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91098C2BCB2;
	Sat, 25 Apr 2026 04:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777091505;
	bh=kLik9mOEuc+c03e5F3qTuQ2Iz9uDz2w90cibOlen4Zk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=R9novl/QJaj3WZe6pUTTSO2UxGoERUkpD2H3pJIv4zHH/V2SlFF+oBjy75OSwKPLF
	 Fxu0jtbF6yrt/5saYs5oh3hBfZg/5W3Z5/5pbe1R1CXCvyrowd5Ib2x5Om4H31yJIA
	 Ys8zVild9dDPabEc0LQkkI4W3KXaIUJ8kAITiJYoaWmFv9YTGvG9aONrzJcPNCxdoW
	 +n4WXGkMXIkLf7qyGdRGYVjmKTlHtEfq8UFDXUpcG3nvMXEskFuzQZOmVaqfBL0RGi
	 3QcoQeVScxI22ssy8H317b6reVyoZqoqk6j6nWyt9s42d42FWmMB1GT5n+Gb1lsOQF
	 M43FVYuzl4xpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 4/4] selftests/bpf: Ensure dst addr/port are
 preserved after socket abort
Reply-To: sashiko@lists.linux.dev
To: "Jordan Rife" <jrife@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260330215707.2374657-5-jrife@google.com>
References: <20260330215707.2374657-5-jrife@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 04:31:44 +0000
Message-Id: <20260425043145.91098C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The test silently passes if the socket abort mechanism fails or if=
 the target socket is not found, rendering it ineffective.
- [Medium] Uninitialized variable `out` is read and evaluated if `read()` r=
eturns an error.
- [Low] Passing a NULL pointer to the `%s` format specifier in `snprintf` c=
auses undefined behavior.
--

commit 8c3285f5a0be84b220c0ac15975fdc9d109ad136
Author: Jordan Rife <jrife@google.com>

selftests/bpf: Ensure dst addr/port are preserved after socket abort

This commit adds a test to ensure that sock_release hooks see the original
dst_ip4, dst_ip6, and dst_port values for connected UDP and TCP sockets
following a socket abort.

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c =
b/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
new file mode 100644
index 0000000000000..022031332b839
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
[ ... ]
> +static void destroy(struct sock_destroy_release *skel, int fd, int sock_=
type)
> +{
[ ... ]
> +	/* Delete matching socket. */
> +	nread =3D read(iter_fd, &out, sizeof(out));
> +	ASSERT_GE(nread, 0, "nread");
> +	if (nread)
> +		ASSERT_EQ(out, cookie, "cookie matches");

If the iterator fails to find the target socket, read() returns 0. The test
tolerates this because ASSERT_GE(0, 0) passes and if (nread) simply skips
the ASSERT_EQ.

Since the test then proceeds to call close(connect_fd), which performs a
normal socket closure, won't the sock_release hook naturally see the intact
dst_ip and dst_port values, causing the test to silently pass without the
socket ever being aborted? Should this assert that nread =3D=3D sizeof(out)?

Additionally, if read() fails and returns -1, the ASSERT_GE() macro logs a
test failure but does not return early.

Because -1 evaluates to true in C, could this lead to executing
ASSERT_EQ(out, cookie, ...) where out is an uninitialized stack variable?

[ ... ]
> +static void do_tests(struct sock_destroy_release *skel, int sock_type,
> +		     int family, const char * const *bind_addrs,
> +		     size_t bind_addrs_len, const int *bind_ports,
> +		     size_t bind_ports_len)
> +{
> +	const char *protocol_name =3D sock_type =3D=3D SOCK_STREAM ? "tcp" : "u=
dp";
> +	const char *family_name =3D family =3D=3D AF_INET ? "ipv4" : "ipv6";
> +	char name[256];
> +
> +	for (size_t i =3D 0; i < bind_addrs_len; i++) {
> +		for (size_t j =3D 0; j < bind_ports_len; j++) {
> +			snprintf(name, sizeof(name), "%s/%s/destroy/%s:%d",
> +				 protocol_name, family_name, bind_addrs[i],
> +				 bind_ports[j]);

Looking at test_sock_destroy_release(), the bind4_addresses and
bind6_addresses arrays contain NULL as their first element.

Could passing a NULL pointer to the %s format specifier cause undefined
behavior here?

While some libc implementations like glibc gracefully handle this by
outputting (null), others might crash or trigger sanitizer warnings.
Would it be safer to explicitly guard the argument, such as checking for
NULL and substituting it with a placeholder string?

diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_release.c b/too=
ls/testing/selftests/bpf/progs/sock_destroy_release.c
new file mode 100644
index 0000000000000..5389f79226f99
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_release.c
[ ... ]
> +void maybe_abort(struct sock_common *sk, struct seq_file *seq)
> +{
> +	__u64 sock_cookie;
> +
> +	if (!sk)
> +		return;
> +
> +	sock_cookie =3D bpf_get_socket_cookie(sk);
> +	if (sock_cookie !=3D abort_cookie)
> +		return;
> +
> +	bpf_sock_destroy(sk);
> +	bpf_seq_write(seq, &sock_cookie, sizeof(sock_cookie));
> +}

Is it possible for bpf_sock_destroy() to fail and return an error code?

If it does, the iterator will still return the cookie to userspace, which
will receive it and incorrectly assume the socket was aborted.

Would it make sense to only call bpf_seq_write() if bpf_sock_destroy()
succeeds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260330215707.2374=
657-1-jrife@google.com?part=3D4
