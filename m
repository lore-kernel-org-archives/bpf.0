Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9738DC4C
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671447; cv=none; b=jkTdMJZHfGRLGOAgxiByLnNMEpRRlFtO5DBY961zyVWDN5ufaAInG7zZa+NT0aTmirpb/dk1oFC2GTsQzbGQx8shITUEDNnm0kZp5pOuB3Js+uS8eGZc/vaIsOqQGXu3ZfGanX4RSGppYNGybteDlZL2jDpu0k1pQDJP8BQ6TUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671447; c=relaxed/simple;
	bh=J4Let7bApZs3+/vhkQJu5zXR60CByLbcCWT/omaRoyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vALvtpS00O5PMjySWGMWnE8NwF0sJ4gZe9pjYe0nG0Q4jhh6t8o+BOQveQdFM5GrqmUiI/wGs6cpy7oVDcuWIzhxJLkCExtvhFnlYNTqX8jbZcDkNDClYIiyVae8TcwiEwoV6kOHZoRmEo1uTtOx9v5NfwpHgie1b0e8Y65dVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYlGFkdW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYlGFkdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DB11F0089C;
	Tue, 29 Sep 2026 08:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671440;
	bh=zb+Jr4ovUhNNZRI24KuyQxsUTOQ0rBBYqdY/SPkm7G0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bYlGFkdWcUfs1O1tX7WLxaTsSeZegJ0cJDjWUqjKR/pEsRWagoLaRxWOgR7ccCXGH
	 F1ArLB1nEiw3EOi/gDa43yT810IMZPhXNCoIu3g/nvBoThBm1ypn4yjU43bF9wjMqF
	 rzLL0xYAW50+rf/K8Y2kX2jIFYp25IXLXcWAJeltaB+u/n/TLhBM7vjktvc4mPvP5f
	 DnNuSMmptm3T6Ek2o+o682p42zNFLWT/ABUQtSxmSwTXK80SnEmAgZmSQATPVXXB7L
	 RUZRSCUTu6DP06HXcw+fFB3Pp5JyzON49Pa8aV5sWd8Sr/xJPujOfTrcCL1IYP9vl1
	 wjGI0cfM04sdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a test for
 udp_bpf_recvmsg() with a stuck backlog
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260929083447.558818-3-chenyuan_fl@163.com>
References: <20260929083447.558818-1-chenyuan_fl@163.com>
 <20260929083447.558818-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:43:59 +0000
Message-Id: <20260929084359.C2DB11F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: out-of-bounds stack read in bpf_map_update_elem() due to si=
ze mismatch
--

commit b1443b15549bc27b1d37fdde6146f87e16092cd2
Author: Yuan Chen <chenyuan@kylinos.cn>
Subject: selftests/bpf: Add a test for udp_bpf_recvmsg() with a stuck backl=
og

This commit adds a BPF selftest for udp_bpf_recvmsg(). It verifies that rea=
ding
from a socket where a verdict program redirects every skb back to the socket
itself falls back to the plain UDP receive path and correctly handles timeo=
uts.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_udp_backlog.c=
 b/tools/testing/selftests/bpf/prog_tests/sockmap_udp_backlog.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_udp_backlog.c
[ ... ]
> +static int run_child(void)
> +{
> +	struct test_sockmap_udp_backlog *skel;
> +	struct timeval tv =3D { .tv_sec =3D RCV_TIMEOUT_MS / 1000 };
> +	struct sockaddr_in addr =3D {};
> +	struct timespec t0, t1;
> +	socklen_t addrlen =3D sizeof(addr);
> +	int zero =3D 0, sfd, ret, err, exit_code =3D 1;
[ ... ]
> +	err =3D bpf_prog_attach(bpf_program__fd(skel->progs.redir_to_self),
> +			      bpf_map__fd(skel->maps.sock_map),
> +			      BPF_SK_SKB_VERDICT, 0);
> +	if (!ASSERT_OK(err, "prog_attach"))
> +		goto close;
> +
> +	err =3D bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
> +				  &zero, &sfd, BPF_ANY);

[Severity: Medium]
Will this cause an out-of-bounds stack read?

The map is defined to expect an 8-byte value:

tools/testing/selftests/bpf/progs/test_sockmap_udp_backlog.c:sock_map:
    struct {
        __uint(type, BPF_MAP_TYPE_SOCKMAP);
        __uint(max_entries, 1);
        __type(key, __u32);
        __type(value, __u64);
    } sock_map SEC(".maps");

Since sfd is declared as a 4-byte integer in run_child(), passing it as the=
=20
value pointer to bpf_map_update_elem() will cause the kernel to read past=20
the bounds of the variable.=20

If the 4 bytes of adjacent stack memory cause the 64-bit value to exceed
S32_MAX, the map update can be rejected by sock_map_update_elem_sys(),=20
leading to random test failures with -EINVAL.

> +	if (!ASSERT_OK(err, "map_update"))
> +		goto close;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929083447.5588=
18-1-chenyuan_fl@163.com?part=3D2
