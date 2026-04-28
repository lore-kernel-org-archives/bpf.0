Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8917404E
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335138; cv=none; b=D8cm4S19/evf4inIA6PgkFbGnMCzBI0cWrcD76eDdHPbZHRe2g6q2khuWdUHPTULzflBa1rs0gaCYvCQbM7jA/KBPkCFVyfUJHxPpBuZBe7sG7yGfFG0IoQv49B4tE9Cb4tpTxqklhTzs8tDkCNqu92s0J3OUTQQJiuq/oHcCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335138; c=relaxed/simple;
	bh=ZMu1aSAgdmCZioM1EmVZHkzCZgrBCpaxaiwCEN/Qzoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EUMuklmMfJ1eVnHt81zfhbpP7AdwJDAXbrk7E7x9BGJ7v3pSb2rOWp5mDm21V6L6mUYe45PiN4xQvCXcEKPBmJ/4MbmILq+C23KnkHTPI9Ld6PKv8UFV4ahYu/hLU8BARyj+a9ZkSLudGAr+StNnPVuX8ccJBYhi7znQo6Xkuvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ16D0Ml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ16D0Ml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1045C2BCB6;
	Tue, 28 Apr 2026 00:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335137;
	bh=ZMu1aSAgdmCZioM1EmVZHkzCZgrBCpaxaiwCEN/Qzoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NQ16D0MltgsFEj/fX7NxW8ILP82sYRBb5HVAvUGtc55faChPIh7CuhN6BguF/FBcs
	 DHk4SvNbceABYBwFDp7z6gzEgvBnxCUVSSqIEkXzFcSQsP464SBYurEBn/NPTic/yP
	 BenvL3c7Ln9hZwU/DucDkoJXnWbJHBj8xkqsg6T9EMhTFTzYsxwf33tcV8nOXx8uSj
	 gwF+pTxrsIIvZFTDbHptws5RgIIDCr6QgzzR0GX9WwZC+Gu+SoZbZIhPWaWXx5rdGL
	 lCF3rj8pIdTm5vfHvfF94eYQcy4d9ZFvrx+D63jU/yKI8PF76pa65lFCAmPF9zsywn
	 e2g9ilnOtZr+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: verify syncookie
 statistics in tcp_custom_syncookie
Reply-To: sashiko@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260427001006.14465-3-jiayuan.chen@linux.dev>
References: <20260427001006.14465-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 00:12:17 +0000
Message-Id: <20260428001217.D1045C2BCB6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] nstat command in read_tcpext_snmp() clobbers global history file=
 due to missing -s flag
--

commit 6d6b9a4b92f87f759fc396b394eb46513c637ea5
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

selftests/bpf: verify syncookie statistics in tcp_custom_syncookie

This commit adds a read_tcpext_snmp() helper to network_helpers.c to read
TcpExt SNMP counters via nstat. It uses this helper in the tcp_custom_synco=
okie
test to verify that LINUX_MIB_SYNCOOKIESRECV increments appropriately.

> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c

[ ... ]

> @@ -621,6 +621,28 @@ int get_socket_local_port(int sock_fd)
>  	return -1;
>  }
> =20
> +int read_tcpext_snmp(const char *name, unsigned long *val)
> +{
> +	char cmd[128], buf[128];
> +	int ret =3D 0;
> +	FILE *f;
> +
> +	snprintf(cmd, sizeof(cmd),
> +		 "nstat -az TcpExt%s | awk '/TcpExt/ {print $2}'", name);

Does invoking nstat without the -s flag clobber the global history file?

By default, nstat writes its state to a shared history file in the
temporary directory. Because BPF selftests run in parallel and share the
/tmp filesystem, multiple threads executing read_tcpext_snmp() might race
to write to this file.

Can this also corrupt the baseline for any concurrent networking tests that
rely on nstat delta calculations?

Would it be safer to invoke this as nstat -asz instead?

> +	f =3D popen(cmd, "r");
> +	if (!f)
> +		return -errno;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427001006.1446=
5-1-jiayuan.chen@linux.dev?part=3D2
