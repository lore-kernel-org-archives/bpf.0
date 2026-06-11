Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B730D3F6
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178744; cv=none; b=JfQUFa7h/ehX4n3Msuqk3cIiqnvyK0HxiSWNX1RQm+ohkoKa+6LdrmkfO4GHBlMm5C1d5bDCgDbHiLfME1RfM0AUtxN+BJAMAqLdfUjFPUan5vDwtMCWxbvaDFwShrbM7Cw0jWjAF4L/OSDkeAgQIfmAlCyxBcm6yoO/bNp/9dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178744; c=relaxed/simple;
	bh=2cQv485m/45CbAwAZo6HrXVV3Heb5cP3yfKelt/s0DE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fIJ9rVcx6w/h20sWICgbXspWKmpumlE0p3aNtdbuVq/OtRNHQwteAhwlH+DAsNB86HG5qyYZdiAL+XMUc+bTLpOtBEPzECoaSRX9BKbkGuW02ForIh7aG8zNMwYSxD1FmFZeY1wixpmlwiXSNK01QKKUaZenc4p+1AwFM9Kqcfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6R5o5vq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6R5o5vq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A9E1F00893;
	Thu, 11 Jun 2026 11:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178743;
	bh=8wzXV7sF5to+vbyWgx2ehDkd/9VetNpiwJ5fPc9G4rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U6R5o5vqAfZ9wVF92ttvNk1mWoNbuosAOUY4hb/wEcD751r13xwJaXyba6o9vYfEW
	 8ij8D25o2lAsBV9X1sSLsrRAO6am+IPBLfXwAJv1Yx2z7AnUo2C+OCi75Kc3QkCDKa
	 MBGOw9IekJoBBGv71jr3g9lGACoBWlVFGSn6whFGUI2LWzMQ7Co/Dw1bpIxzUlHFSZ
	 dU5C9JNGK7k8WzSkCcQpuAuHY8n3U9MrjqkQs1XKbH2q33A7VIUUcvP48XRAEjooYo
	 WW9ZZqVqQl9pwoLcAq/UDhaPAl0INUmqTD4Bye5Vzc/5MA9um1WNBCB9HDW64hKvHO
	 sD7rd1U7Bcpng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 bpf-next 5/7] selftests/bpf: Add uprobe_multi path_fd
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611114230.950379-6-jolsa@kernel.org>
References: <20260611114230.950379-6-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 11:52:22 +0000
Message-Id: <20260611115223.35A9E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The selftest uses a non-existent structure member `opts.uprobe_mult=
i.path_fd` and an undefined macro `BPF_F_UPROBE_MULTI_PATH_FD`, which will =
cause a build failure.
--

commit 7f1afda8cdc452975b891e8563b1e8e01d191c3a
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Add uprobe_multi path_fd test

This patch adds a uprobe_multi link API selftest. The test opens
/proc/self/exe and passes the descriptor through opts.uprobe_multi.path_fd
using the BPF_F_UPROBE_MULTI_PATH_FD flag.

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 56cbea280fbd2..ffcf3c92f0474 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c

[ ... ]

> @@ -757,6 +758,65 @@ static void test_link_api(void)
>  	__test_link_api(&child);
>  }
> =20
> +static void test_link_api_path_fd(void)
> +{
> +	LIBBPF_OPTS(bpf_link_create_opts, opts);
> +	const char *resolve_path =3D "/proc/self/exe";
> +	int prog_fd, link_fd =3D -1, path_fd =3D -1;
> +	struct uprobe_multi *skel =3D NULL;

[ ... ]

> +	path_fd =3D open(resolve_path, O_RDONLY);
> +	if (!ASSERT_GE(path_fd, 0, "path_fd"))
> +		goto cleanup;
> +
> +	opts.uprobe_multi.path_fd =3D path_fd;
> +	opts.uprobe_multi.offsets =3D offsets;
> +	opts.uprobe_multi.cnt =3D ARRAY_SIZE(syms);
> +	opts.uprobe_multi.flags =3D BPF_F_UPROBE_MULTI_PATH_FD;

[Severity: Low]
Does the uprobe_multi structure in bpf_link_create_opts actually have a
path_fd member? It appears this code references an undefined struct member
along with an undefined macro BPF_F_UPROBE_MULTI_PATH_FD. Will this cause
a build failure?

> +
> +	skel =3D uprobe_multi__open_and_load();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611114230.9503=
79-6-jolsa@kernel.org?part=3D1
