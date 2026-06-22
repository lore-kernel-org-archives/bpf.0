Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D75474F
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782096409; cv=none; b=AtmWzqFTDKN8bXT20FYCdng0KpU0iqbiX3cZL0FCmxA/wmjeHcIYA/xV6yCWNyTPeK2B67ytiaV7RuGfZ4f9lU2qb5R/5310wX738Ns4hctLJzVmNceNzkK5ZJeV2IRWRQ5HnSdoS4vz4+yVdTpdEqSuEJ9AA+gSloIKwDisGP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782096409; c=relaxed/simple;
	bh=0Tymqw5OfBrwe9dRqPnErRphD+A/isTB1db351nLJ/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fk/s26y9vkcuSpjVPbdXHTc3hVGhSsdtbnnyEB6gA+PgfWJqY0ohbLFYZG8MbDu0DyCmN9xJC+S5tdHLjIe7Z/dp9Uggpl9cXQgXfPiJ35kkYhpZn/O+Ict6oR5+5anboSlUKXtqOD1ShPOZB8TmjYeM7hpw9otN3ueM7bj6Xuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHgOVBt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHgOVBt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC0D1F000E9;
	Mon, 22 Jun 2026 02:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782096408;
	bh=PzUfUMAt45/P6qYRKMNQA6D+L0cjNzq8ifpLnYabe04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aHgOVBt42y4iGkdkcnuycvUBDT6ejPg/7UdZWrWAxVR5CsLmr5tSoaeKBOiLgULf4
	 f/Y5LXCLMPHhexd03Ep7o3xCkYMI4peK2I8Z6DLjA9cNZCpndBTHAscwr89z1uQp8I
	 /uj22qhFlQMNCKxeIbsE+r1kWg3/Q8uIWS/l6PaSz6o438t3iCRO/Rh5ap7lpmZ0hW
	 xsDAjMfTMmKM65oyfYrBHR/s8jElXIYljr+w7UBqquGVcoPt068Uhc/hZoAaStFv0S
	 TOCp0Hh/40xCkwHhUTijBWC8IhcxRb1YV26Cnyq7Ch8k8eNT2FOSjAJq9p1YXmSwaB
	 Mm9T2dQoHE4UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tools/bpf/bpftool: Reset vmlinux BTF after
 struct_ops commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yichong Chen" <chenyichong@uniontech.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <507ECA61416703FC+20260622023345.1135373-3-chenyichong@uniontech.com>
References: <20260622023345.1135373-1-chenyichong@uniontech.com>
 <507ECA61416703FC+20260622023345.1135373-3-chenyichong@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 02:46:47 +0000
Message-Id: <20260622024647.DCC0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of `btf_vmlinux` in `map.c` during batch execution.
--

commit 39dc823c4a9209628a9e626b6a80fe537d15b79e
Author: Yichong Chen <chenyichong@uniontech.com>

tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands

This commit fixes a stale state reuse issue in batch mode by correctly
resetting the BTF pointer and cached map info state after struct_ops comman=
ds.

> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_op=
s.c
> index aa43dead249cb..4dba7c96e5f60 100644
> --- a/tools/bpf/bpftool/struct_ops.c
> +++ b/tools/bpf/bpftool/struct_ops.c

[ ... ]

> @@ -642,7 +651,7 @@ int do_struct_ops(int argc, char **argv)
> =20
>  	err =3D cmd_select(cmds, argc, argv, do_help);
> =20
> -	btf__free(btf_vmlinux);
> +	free_btf_vmlinux();

[Severity: High]
This is a pre-existing issue, but does a similar use-after-free exist in=20
tools/bpf/bpftool/map.c during batch execution?

Looking at map.c, get_map_kv_btf() can return the static btf_vmlinux pointer
without taking a reference:

tools/bpf/bpftool/map.c:get_map_kv_btf() {
    ...
        *btf =3D btf_vmlinux;
}

Then print_key_value() frees it unconditionally:

tools/bpf/bpftool/map.c:print_key_value() {
    ...
    btf__free(btf);
}

Since it doesn't NULL the static btf_vmlinux pointer (unlike what this patch
does for struct_ops.c), could a subsequent map command in batch mode bypass=
 the
(!btf_vmlinux) initialization check and reuse the freed pointer?

> =20
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622023345.1135=
373-1-chenyichong@uniontech.com?part=3D2
