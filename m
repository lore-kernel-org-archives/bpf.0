Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389313D47A7
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266646; cv=none; b=GPPPQzM46RrFN08zU9gC7CG2Zjrkk8pPGxsNQe6ITdIXIgXfdp+lSIHS5NH6bJ4jC5Hu/AYjJUHUzWFaH/k/w7Em6QJN5+1yWeErv7bBymBCOppixt0aqZ/WcAuTaZyaw6L0L43t+J0Hoxk9WVqX6z1Thq5s4y1C7L4i/3AA/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266646; c=relaxed/simple;
	bh=OaWt/59FLL+1fxJWA5u5OARN+5pWkcXWEJOiuCATMuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XqNOqb6mCFsDLzEoMclaZDrq7ROMiDFymAmVUWmuIGrzpvBrgK9FGVlGZKD92Bqc8KyTfNO0jdewK0JQSUvk/fQ/q1+1TXtesLN6CuNI5VH/l945lWtENNwBV68L3ohpQ2tmxu/YLc//qRByFcdT9JfKkJTEIIf6k/4ZWO4eUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfPDTasz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfPDTasz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D501F000FF;
	Thu, 24 Sep 2026 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790266645;
	bh=67R8PXBZFSI0kmo4fSlH5tfRPbievfxZQ0Qg+hYyvok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cfPDTaszUySh1cCPmzLzawhbnUd6GB7k7uN0PYL/6DHSsMbMUFipqY+GCBz7RG5Rk
	 11Njt/251cekvKvXv+xK9cRx1k1hRxwe7fATdQBzYGxlxJJImAybRofzttGRKCI4lJ
	 suU6kbzXAGMd0y0lR3fDeOPpan+wvtArsLAaM8V/iHwHBIyxW1S7DnfMr/42oUKP6X
	 COrgP8QWs0EPYn/+gUWYTxY1vLArizD6RAh9LdZBKNkYZG910j6y/6lq1ROvdWdiY8
	 zqf7wuiiAeL2tq4PcYXJl1f97z9jC1adBIg/GLCtQ2G6ZwDwpMyfzG1dAo5B8LDGpr
	 wUkSYqlimI/Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Check that bpftool reports
 a map it can't dump
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Skokov" <skokovmaksimevg@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924160732.485650-3-skokovmaksimevg@gmail.com>
References: <20260924160732.485650-1-skokovmaksimevg@gmail.com>
 <20260924160732.485650-3-skokovmaksimevg@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:17:24 +0000
Message-Id: <20260924161724.E8D501F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: uninitialized output buffer in test_bpftool_map_dump()
--

commit 18cf283c6b4e8fb98efa7b6286ae3efd8620915d
Author: Maxim Skokov <skokovmaksimevg@gmail.com>

selftests/bpf: Check that bpftool reports a map it can't dump

This commit adds a new test to verify that bpftool map dump correctly
reports an error when trying to dump a socket storage map, rather than
exiting silently. It creates a BPF_MAP_TYPE_SK_STORAGE map, attaches
storage to a socket, pins it, and runs bpftool to check the output.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/=
tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
> new file mode 100644
> index 0000000000000..56283e3f1e602
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
[ ... ]
> +void test_bpftool_map_dump(void)
> +{
> +	int map_fd, sk_fd =3D -1, value =3D 42, ret;
> +	char output[1024];
[ ... ]
> +	/* Socket storage can not be iterated, so the dump must fail loudly
> +	 * rather than print an empty map that holds an element.
> +	 */
> +	ret =3D get_bpftool_command_output("-j map dump pinned " PIN_PATH,
> +					 output, sizeof(output));
> +	ASSERT_NEQ(ret, 0, "json dump fails");
> +	ASSERT_HAS_SUBSTR(output, "\"error\":", "json dump reports an error");

[Severity: Medium]
Could this result in an uninitialized memory read if get_bpftool_command_ou=
tput()
fails early?

If bpftool path detection fails or popen() fails inside run_command(),
it returns 1 without writing anything to the buffer:

tools/testing/selftests/bpf/bpftool_helpers.c:run_command() {
	if (bpftool_path[0] =3D=3D 0 && detect_bpftool_path(bpftool_path, sizeof(b=
pftool_path)))
		return 1;
	...
	f =3D popen(command, "r");
	if (!f)
		return 1;
	...
}

In this scenario, get_bpftool_command_output() will return 1, which satisfi=
es
ASSERT_NEQ(ret, 0). The test will then pass the uninitialized output array =
to
ASSERT_HAS_SUBSTR(), which calls strstr() and may cause undefined behavior =
or
crashes.

Should output be zero-initialized, or should the test verify that output was
actually populated before checking its contents?

> +
> +	ret =3D get_bpftool_command_output("map dump pinned " PIN_PATH " 2>&1",
> +					 output, sizeof(output));
> +	ASSERT_NEQ(ret, 0, "plain dump fails");
> +	ASSERT_HAS_SUBSTR(output, "does not support iteration",
> +			  "plain dump explains why");
> +
> +	unlink(PIN_PATH);
> +out:
> +	if (sk_fd >=3D 0)
> +		close(sk_fd);
> +	close(map_fd);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924160732.4856=
50-1-skokovmaksimevg@gmail.com?part=3D2
