Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B363AD522;
	Mon, 31 Aug 2026 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788148191; cv=none; b=YYTjNoWoblbLM66VL03BEGyIUU3fVU4V56iFzmvv18RFerJlB7BR7gXS+FLLL+LVWM7aNYcfoNm7f3xTcbpnHbbe5btgGFBQHiI6aH/gmGMU6GIR83ura5AW7UcFGgjZx7Waj4tfsI8xLyfmpiLpuHck4gt9OpDQ4CBlfR8DuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788148191; c=relaxed/simple;
	bh=dSI1f+qb9WlgtIP4vofeY3OI6d2/fGGZliOCmqxzilo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PxTzX6iTfsKMWCR86t/0M3HRqoWRw9qObHYh4xnVPmIACjviOzLFsF6hHWp00Cku2GxS0DpcSuCRJlIR+huu0k7ZMAmYw2G8INz9E62nNM5zLmksVwbuNP4qhkhPqWwC0Bkxdb/A7CLyW4L4pjchjKFRIbQMlz9YCv+eyUlYsM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/B8iM0L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/B8iM0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701CD1F000E9;
	Mon, 31 Aug 2026 03:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788148187;
	bh=LJVEYJxFNZl+MXa6igNb+/braYQwf8ICpENEMAuFMyI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=J/B8iM0LGO4531gdtvthtLgx97MHWM+RklNTh+eQueSuJxYYQ7DEzbSPRDUVzuUoV
	 hQjH/TOELV94LjU5uDPKGueXOAERM+W9EuVFqcdn/DKSCLl1TDEts/At3me11qwRhN
	 Ju/0XZ6CWWb53U7zZM6jDTh5LxolYUlSFoXyaNvvSI/jNEKhIH0h0jIy86yASBvyCe
	 Hz7kdvY+UUzJYE2JjHwGw2WXGeEvIVd3gpZ89Qy5RwsDajBDTH/OXQzegOQu1Y4kdu
	 gOM3NiykIpIdskJxoE3TQENu1KMs/tqLlUd/r6kM1roWziqxw40vdHRd4M9VgAPHUi
	 oXZlGFTTADt+w==
Content-Type: multipart/mixed; boundary="===============5769949916082378003=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a3283f27b2a2d9d0d70cd58a8a7e03fc69efe460129a1aa0de1704ab0846496d@mail.kernel.org>
In-Reply-To: <20260831023918.1857658-2-sanghyun.park.cnu@gmail.com>
References: <20260831023918.1857658-2-sanghyun.park.cnu@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Cover attach type checks in link update
From: bot+bpf-ci@kernel.org
To: sanghyun.park.cnu@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,bpf@vger.kernel.org
Cc: sanghyun.park.cnu@gmail.com,leon.hwang@linux.dev,john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,sdf@fomichev.me,pulehui@huawei.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 03:49:46 +0000 (UTC)

--===============5769949916082378003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add regression coverage for link update compatibility. Verify that a UDP6
> sock_addr program cannot replace a UDP4 program and that an LSM_MAC
> program cannot replace an LSM_CGROUP program.
> Also verify that CGROUP_SKB attachment still requires CAP_NET_ADMIN, while
> an existing link can be updated after dropping CAP_NET_ADMIN and
> CAP_SYS_ADMIN.

This isn't a bug, but could the changelog say why this coverage is needed,
rather than restating what each assertion does? The tests appear to pin
down attach-type validation in link update (which didn't exist before the
companion patch) and the permission-check split for CGROUP_SKB (capability
at LINK_CREATE but not LINK_UPDATE).

> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> index 41e867467f6c6..85b0af4f486af 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> @@ -74,6 +74,7 @@ static void test_lsm_cgroup_functional(void)
>  	int bind_prog_fd = -1;
>  	int bind_link_fd = -1;
>  	int clone_prog_fd = -1;
> +	int mac_prog_fd;
>  	int err, fd, prio;
>  	socklen_t socklen;
>
> @@ -156,6 +157,15 @@ static void test_lsm_cgroup_functional(void)
>  	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_socket_bind"), 1, "prog count");
>  	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 4, "total prog count");
>
> +	fd = bpf_link_create(bpf_program__fd(skel->progs.socket_first),
> +			     cgroup_fd, BPF_LSM_CGROUP, NULL);
> +	if (!ASSERT_GE(fd, 0, "link create socket_first"))
> +		goto detach_cgroup;
> +	mac_prog_fd = bpf_program__fd(skel->progs.socket_create_lsm);
> +	err = bpf_link_update(fd, mac_prog_fd, NULL);
> +	ASSERT_EQ(err, -EINVAL, "reject lsm_mac link update");
> +	close(fd);
> +

This isn't a bug, but would it read more consistently to inline
bpf_program__fd(skel->progs.socket_create_lsm) into the bpf_link_update()
call? Every other '*_prog_fd' local in this function's declaration block is
initialised to -1, while mac_prog_fd is uninitialised and used exactly once
on the line after assignment; the bpf_link_create() call twelve lines above
already inlines the equivalent expression. Also, the new link fd is held in
the generic 'fd' variable, whereas the link created earlier uses the
descriptive 'bind_link_fd'.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33352119890
--===============5769949916082378003==--
