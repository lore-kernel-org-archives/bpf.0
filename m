Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89454705A
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790381324; cv=none; b=YmjSZZF0balpOvPZOXbTgfSG/tDTtFNHrBnnVV61Ul5QvIRTJy5FlInz1OjmryUxgI7R58Zt78eH6jzTNknUx9tbtRMNkLdRFWMRqYk83498Xy5gx4IKwNhgElnxq8+rSwOQ8OWWzPDpT0WdWzprTzVYFQVMyC443ALIIp3lts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790381324; c=relaxed/simple;
	bh=1nZdaqrATtTceCXUXxvP+GdiYRIWzU9sAOwWw5a5gMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V69lifqBkKfnU4uawip6X9zrZlnqF1LAWU/9YI7c6QMufPO74SACCj4iiKlrQ+oZJRvPMPdz7ibm7cBZimhDs2Db8KaeJe+7tu5C4JtiXZzEQmQ2M3rkw5UoMdO7SSUFXRC8s18eOiTM3mOQkJ/1Ynlu9v8mbeUJgKAuOeApces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCcioWl5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCcioWl5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134841F000FF;
	Sat, 26 Sep 2026 00:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790381323;
	bh=Tof3xIxOhMOzXAv15eR+a3duxNxoVjzeZbR/16Q2LZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MCcioWl5fM9OwpVnc1u1vgj0DQRVedWutk+AURaG335wWclE+SxXeVG9uCEDPCi0C
	 8itWV58mYR9NRWgJyWcnNtGqHvRkj3ssKrTGgovim/zuf9upV4uKzey2pbPi/mk3+Y
	 e6oOe8Hs7UhBXavevJrMd6ziSMnEvb1NcrmytWPCQg3+6AgfwFrXMSn2wXVCUP3KYY
	 xjIjWDGPVedVvooyltQr0dtP/A/Za9s+wkKQI/hNka7Xo3f5eO+jOXmI6wflJD8j4Z
	 8X4a5ERzHuaU+iEwv3hkOtUOyGPrFjoUXQ49g81eiZCEt49g08qWB/YwhjY+xctSkH
	 JLr/I7vRxePiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add linked_externs test
 for externs in allocated sections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrii Nakryiko" <andrii@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926000243.2830819-2-andrii@kernel.org>
References: <20260926000243.2830819-1-andrii@kernel.org>
 <20260926000243.2830819-2-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 00:08:42 +0000
Message-Id: <20260926000843.134841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: unhandled mkstemp() failure in test_relink()
--

commit e2fcaeeb4be58f57f9657902a9e400bc15e30412
Author: Andrii Nakryiko <andrii@kernel.org>

selftests/bpf: Add linked_externs test for externs in allocated sections

This commit adds a selftest to verify that the BPF linker correctly handles
extern variables in allocated sections (like arena and maps). It tests the
behavior both via the BPF skeleton and by directly driving the libbpf linker
API.

> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_externs.c b/to=
ols/testing/selftests/bpf/prog_tests/linked_externs.c
> new file mode 100644
> index 0000000000000..29358c82dc356
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_externs.c
[ ... ]
> +/* link in1 on its own first, then link the result with in2 */
> +static void test_relink(const char *in1, const char *in2, const char *se=
c_name)
> +{
> +	char out1[] =3D "/tmp/linked_externs.XXXXXX", out2[] =3D "/tmp/linked_e=
xterns.XXXXXX";
> +	const struct btf_var_secinfo *vi;
> +	struct bpf_object *obj =3D NULL;
> +	const struct btf_type *t;
> +	struct btf *btf;
> +	int i, id, n;
> +
> +	close(mkstemp(out1));
> +	close(mkstemp(out2));

[Severity: Medium]
What happens if mkstemp() fails here?

If it returns -1, it will be passed directly to close() which will just fai=
l,
but the template strings will remain undefined (typically unmodified). The
test would then continue using the predictable string
"/tmp/linked_externs.XXXXXX" for file operations.

Could this cause collisions with other concurrent test runs or leave leftov=
er
predictable files in /tmp?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926000243.2830=
819-1-andrii@kernel.org?part=3D2
