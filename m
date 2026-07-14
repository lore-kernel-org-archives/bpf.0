Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1A42BC28
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062332; cv=none; b=kOpPwMlleHPlyA+qcseK+VQOgTlzl/A9+C2xPf7lNMXYpnqsvC3kDgT5ROVIbGrxRWLgFE6yGWkLTfSUzsyajRba97TYUGPYXyUwxe/d/e2MmtzSGbRoTIxb+Tuv5ki4OeD/wcTOCW2ErQF25Opr+oNDtE88aRq1iewmpENefOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062332; c=relaxed/simple;
	bh=hOPBDPXR4bdNsrF9FmoLC3nlmFer9sFgQPSy83ogEtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lT57uJif6JlAtLbnIuMuoVKCKco7v2OC2oImZx3rEMxEBLiPpVDOBfhSir6jIpuCX3U6vTZvSzpcSVG9YJQkENtZM34IYtI/A3yBMWEcF8HuMu1vrdw41Z+cFC29lroAseKi0tcOMV0Z4MIsOKTww6zJX/EF90mF15NTYCcX5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCzbEzNa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCzbEzNa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF221F000E9;
	Tue, 14 Jul 2026 20:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784062331;
	bh=eRrwBHwJhXFeLFnfofEBRqsAv2LZIZ4h8rlhtGIVixk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fCzbEzNa+A5W2XH1OrUs7l4dewaX+1efCdfQuno2K1Yy4G3lyxYPpTm0jOMB85TBr
	 FLzMgvQhjCNRUDMlhxisP3LLyrAfAtz1AB9tx4VTiEh+XSoI/vY+pTwU3yLHUOu7tx
	 Z4WQJrocIhI7epqS3s/hFYZD11zK5Za3BjO/r2OwbaXGagnA6VQ+tUCJEi0uliIOB/
	 Y+8M6ezHzE2ckaH1/EeUzvhVMNQIMp3uZlCfiMtSxmnd2OgcZDq5lmG+DUSWLdtpXZ
	 EMlj7/fo4ogDbze75blRSBGl4I+SbU3UsdTfEiXIIEfGS+yj19X1DQDkk/rZF7+2L5
	 y/Wvq6FX/rsxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] bpf, sockmap: handle spurious
 tcp_msg_wait_data() wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nnamdi Onyeyiri" <nnamdio@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714203927.32289-3-nnamdio@gmail.com>
References: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
 <20260714203927.32289-1-nnamdio@gmail.com>
 <20260714203927.32289-3-nnamdio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 20:52:10 +0000
Message-Id: <20260714205210.EFF221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The test attaches its BPF cgroup program directly to the root cg=
roup (`/sys/fs/cgroup`), lacking isolation and risking system-wide side-eff=
ects.
- [Medium] Unchecked `pthread_create` failure causes the test suite to hang=
 indefinitely.
- [Medium] The test incorrectly validates the return values of libbpf attac=
h APIs using `ASSERT_NE(..., NULL)`, which fails to detect error pointers (=
`ERR_PTR`).
- [Medium] The assertion checking the elapsed time against `timeo.tv_usec *=
 1000` is flaky due to timer granularity and jiffy alignment.
--

--- Patch [2]: [PATCH v3 2/2] bpf, sockmap: handle spurious tcp_msg_wait_da=
ta() wakeup ---
commit b46e4566e9f7fd3ddd12a149005b03389686104c
Author: Nnamdi Onyeyiri <nnamdio@gmail.com>

bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup

This selftest exercises the tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser()
functions, to ensure that they are properly handling spurious wakeups in
tcp_msg_wait_data().

> diff --git a/tools/testing/selftests/net/sockmap_recvfrom.c b/tools/testi=
ng/selftests/net/sockmap_recvfrom.c
> new file mode 100644
> index 0000000000000..f96b4673c977c
> --- /dev/null
> +++ b/tools/testing/selftests/net/sockmap_recvfrom.c
[ ... ]
> +static void setup_bpf(struct __test_metadata *_metadata, const char *pat=
h, bool recv,
> +						struct bpf_t *bpf)
> +{
[ ... ]
> +	cgroup =3D open("/sys/fs/cgroup", O_RDONLY);
> +	ASSERT_NE(cgroup, -1);
> +
> +	bpf->on_sockops =3D bpf_program__attach_cgroup(prog, cgroup);

[Severity: Medium]
Is it safe to attach the BPF program directly to the global root cgroup her=
e?

Since this is a test, attaching globally to /sys/fs/cgroup impacts the
entire system and subjects unrelated background connections to the test's
stream verdict logic. This could disrupt host networking and easily
overflow the 1024 max_entries of map_socks.

Should the test create and attach to an isolated test cgroup instead?

> +	close(cgroup);
> +
> +	ASSERT_NE(bpf->on_sockops, NULL);

[Severity: Medium]
Does ASSERT_NE() properly handle libbpf error pointers here?

Modern libbpf functions like bpf_program__attach_cgroup() return an ERR_PTR,
not NULL, on failure.

If the attachment fails, ASSERT_NE(link, NULL) evaluates to true, masking
the failure. The test will proceed without the BPF programs attached and
pass vacuously.

Would ASSERT_OK_PTR() be more appropriate for checking this return value?

> +
> +	if (recv) {
> +		struct bpf_map *map =3D bpf_object__find_map_by_name(bpf->obj, "map_so=
cks");
> +
> +		ASSERT_NE(map, NULL);
> +
> +		prog =3D bpf_object__find_program_by_name(bpf->obj, "on_recv");
> +		ASSERT_NE(prog, NULL);
> +
> +		bpf->on_recv =3D bpf_program__attach_sockmap(prog, bpf_map__fd(map));
> +		ASSERT_NE(bpf->on_recv, NULL);

[Severity: Medium]
Will this assertion correctly catch a failure in bpf_program__attach_sockma=
p()?

Like bpf_program__attach_cgroup(), this function returns an ERR_PTR on
failure, so checking against NULL will allow error pointers to bypass
this check.

> +	}
> +}
[ ... ]
> +FIXTURE_SETUP(sockmap_recvfrom)
> +{
> +	memset(&self->addr, 0, sizeof(self->addr));
> +
> +	self->payload_len =3D 1024 * 1024 * 25;
> +	self->payload =3D malloc(self->payload_len);
> +	ASSERT_NE(self->payload, NULL);
> +
> +	memset(self->payload, 0, self->payload_len);
> +	self->payload[self->payload_len - 1] =3D PAYLOAD_END;
> +
> +	setup_bpf(_metadata, "sockmap_recvfrom.bpf.o", variant->with_recv, &sel=
f->bpf);
> +	atomic_store(&self->server.running, 1);
> +	self->server.fd =3D start_listening(_metadata, &self->addr.sin_port);
> +	self->server.metadata =3D _metadata;
> +
> +	self->addr.sin_family =3D AF_INET;
> +	self->addr.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
> +
> +	pthread_create(&self->server.thread, NULL, &run_server, &self->server);

[Severity: Medium]
What happens if pthread_create() fails here?

If the server thread fails to start, it looks like the main thread will
subsequently call send_payload() with a 25MB payload. Because no server
thread is calling accept() or reading the data, the TCP receive window
will fill up and the main thread's write() will block forever.

Should we check the return value of pthread_create() to prevent the
test suite from hanging indefinitely on resource limits?

> +}
[ ... ]
> +TEST_F(sockmap_recvfrom, with_timeout)
> +{
[ ... ]
> +		ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo=
)), 0);
> +
> +		clock_gettime(CLOCK_MONOTONIC, &beg);
> +		ASSERT_EQ(recvfrom(fd, ignored, sizeof(ignored), 0, NULL, NULL), -1);
> +		err =3D errno;
> +		clock_gettime(CLOCK_MONOTONIC, &end);
> +
> +		ASSERT_EQ(err, EAGAIN);
> +		ASSERT_GE(to_nanos(&end) - to_nanos(&beg), timeo.tv_usec * 1000);

[Severity: Medium]
Is this strict time assertion susceptible to jiffy alignment flakiness?

The kernel handles SO_RCVTIMEO timeouts in units of jiffies. When
requesting a 5000us timeout on a system with HZ=3D1000, it converts to 5
ticks. Because the sleep can start just prior to a tick boundary, the
actual elapsed time can be slightly less than the absolute 5000us requested.

Could this cause intermittent test failures where the elapsed time is just
under the requested 5000000ns?

> +
> +		close(fd);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714203927.3228=
9-1-nnamdio@gmail.com?part=3D2
