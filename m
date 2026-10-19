Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960278F3A
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378624; cv=none; b=YVHOwdlZBvLbiAK2tbUJlhPLIWSUdhM2o3u6/kt+H0xot3QHz5goPjbIKFtrkLZywAgMqknRAnoH4Im6g1lTj+k0Km8wYDhlMsrLOuRt5qy+1zZEefHjmiOzVhiafwVTOGwR4zjXiK7R+Uf3OiWTJUYNrLsvHiwCw5fOqz2+JpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378624; c=relaxed/simple;
	bh=3NAqWW71J7SDnu+ttrhfE2lynCgJz547lkEgELB7ig8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=naJk8zzg8hzGH4DTHGA/7yRdNSB+xRem8WLOhkzzzIxzgr8EEfzGOLTWJZGXtFE0vRv4U9Ho217PV4NzGaLvxIKWPRtBgWzKaAfQD8yH9pcAiBIW8T3k56LcIue6szYLeqeMUTOLQYsFbu4WBmZxfU5WphBhhbRiF8RvpVDKKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbcDb+lF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbcDb+lF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97241F000C4;
	Mon, 19 Oct 2026 02:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792378623;
	bh=r0pVKksXHlf38tKA89/DIApguarFGGhcM4vuK/ApZWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AbcDb+lFO2YMcghfFG7OgjFPUbfJ+iJppz0FHtc4ZWQnek9tgVOLGwZS/3EK9kxnh
	 ZTYGJQrsCkuv9RkyDVL0KG+9n32AfT41d+QYyLnznXA5l/lrx4x2HAIKdVZEdfbHEX
	 oRPaXhfftOn+HrTXgsk6EjE4UlcW+4Xv5XFuBsIED7BC0rkKUT9EOMdDlpUffqn4N1
	 aWOkwHjC9QJrMIFTdz5ZaxJtK7EgwcVTXFPHr55wQqQiVXmFvRNXkyhV15IqAAfWBU
	 akHcdvmNLl1/OV1TV+NN75hqNPX0yJn1z37wolN1NtkvNSXhTyez41RpVR6IgFk1Ax
	 GQTvxvL6w1KeA==
Message-ID: <sashiko-outbox-176554@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Run the enable_stats program
 with BPF_PROG_TEST_RUN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261019-selftests-bpf-enable-stats-inflight-v3-1-e7728f5b061a@gmail.com>
References: <20261019-selftests-bpf-enable-stats-inflight-v3-1-e7728f5b061a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 02:57:02 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: deprecated CHECK() macro used in test_enable_stats()
--

commit 149e144806feffc72e780046d3d7759e157ee137
Author: Qiliang Yuan <odys.yuan@gmail.com>

selftests/bpf: Run the enable_stats program with BPF_PROG_TEST_RUN

This commit replaces attaching the enable_stats BPF program to sys_enter
with running it 1000 times via BPF_PROG_TEST_RUN so that concurrent
syscalls on other CPUs do not race with reading run_cnt and count.

> diff --git a/tools/testing/selftests/bpf/prog_tests/enable_stats.c b/tool=
s/testing/selftests/bpf/prog_tests/enable_stats.c
> index 75f85d0fe74a4..5b9cc119d072d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/enable_stats.c
> +++ b/tools/testing/selftests/bpf/prog_tests/enable_stats.c
> @@ -5,10 +5,11 @@
>  void test_enable_stats(void)
>  {
>  	struct test_enable_stats *skel;
> -	int stats_fd, err, prog_fd;
> +	int stats_fd, err, prog_fd, i;
>  	struct bpf_prog_info info;
>  	__u32 info_len =3D sizeof(info);
>  	int duration =3D 0;
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> =20
>  	skel =3D test_enable_stats__open_and_load();
>  	if (CHECK(!skel, "skel_open_and_load", "skeleton open/load failed\n"))
> @@ -20,13 +21,15 @@ void test_enable_stats(void)
>  		return;
>  	}
> =20
> -	err =3D test_enable_stats__attach(skel);
> -	if (CHECK(err, "attach_raw_tp", "err %d\n", err))
> +	prog_fd =3D bpf_program__fd(skel->progs.test_enable_stats);
> +	for (i =3D 0; i < 1000; i++) {
> +		err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +		if (err)
> +			break;
> +	}
> +	if (CHECK(err, "test_run", "err %d\n", err))
>  		goto cleanup;

[Severity: Low]
Since CHECK() is deprecated in BPF selftests, should this new check in
test_enable_stats() (and perhaps the surrounding checks in this function)
use ASSERT_OK(err, "test_run") instead?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-selftests-=
bpf-enable-stats-inflight-v3-1-e7728f5b061a@gmail.com?part=3D1
