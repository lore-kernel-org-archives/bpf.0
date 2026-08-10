Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B83563FB
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 05:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339427; cv=none; b=N21ei6o6lX/XNjkcEG06evVq9TGRfgutY8iKco5ECD8Axile4cSayvUTGl5liPhAxQRQO4GNzd1ts5gbP7+YUOw+TERml1cMTjYNWuLXVT3i+dc5yjg4Qk+OkTOBtWC6r/zqS1UfMb5IrHghfN1IxEmoIDVeKr2IBqIofYhum5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339427; c=relaxed/simple;
	bh=0Q9Q9xQhX7XdpCRQ7p1eCAaTA6FAkzMWxggAZigTrxI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=faMjBauNJxhzsis1S+WMENpl1LBVRDQYNw43b0VgWbb/4kJx9tHFUkCIdp0GwlWTL1ucgCVy/4GUo/TP947kHpCSVDwjGi5vsTqXZ0tvNXCKVLWo+h0sKR+SBRFXAUBvpmHYRUYukhu/7XyRlj5NCSGIVs8lmHurzARoNPCmtHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etP4z7Qs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etP4z7Qs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16C51F000E9;
	Mon, 10 Aug 2026 05:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786339426;
	bh=ppRsI5rixzRNEnwDD362HkCLtM724FbUnpfXEgpzjOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=etP4z7QsO9ir9wbpDEO4hxoieN0ntzEajyv4Xj3bOJT2N2slLCJaDEJTEajb9+Rlo
	 q9pkMtXGtaDf9xI+CadMsOPG8BeQWLeeAEuMvzDFcaABl7W2tg/zk4TDCIWFu3f/Om
	 41exO5wpXPzy3L4BqP2UF/Ssibr4c1ZbGZ8BvXbd7x6uL9wAUxw+8kyop0vgojehi2
	 bhLUu7CLzqxHcddT2WIEKYir/O66SJs2ypFDpkjxMyxbK1PmPnsua+TBVv2X+m/26F
	 YcRVW2rb1hzvCzv1Jd7Eb2RMcGtSF7I8zWcRcikWwgHsWsiLcxlGAZvq2ZdgdQL46l
	 GQC+cbIBh9z6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: xdp: test
 dev_xdp_install() rejects device-bound program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810050621.82035-4-jiayuan.chen@linux.dev>
References: <20260810050621.82035-1-jiayuan.chen@linux.dev>
 <20260810050621.82035-4-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 05:23:44 +0000
Message-Id: <20260810052345.E16C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment opening `/*` is not on its own line, violating B=
PF subsystem coding style.
--

--- Patch [3]: [PATCH bpf-next v4 3/3] selftests/bpf: xdp: test dev_xdp_ins=
tall() rejects device-bound program ---
commit b147dadba98d80bfb5e1c977447162a9b3e3bc29
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

selftests/bpf: xdp: test dev_xdp_install() rejects device-bound program

This commit adds a test to ensure that device-bound XDP programs cannot be
swapped into a generic XDP link via BPF_LINK_UPDATE, bypassing the original
checks in dev_xdp_attach().

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c =
b/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
> index 7dd18c6d06c60..4a13f8ec43009 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c

[ ... ]

> @@ -59,3 +61,50 @@ void test_xdp_dev_bound_only_offdev(void)
>  	 */
>  	SYS_NOFAIL("ip netns del " LOCAL_NETNS);
>  }
> +
> +/* A device-bound program must not run on the XDP software path.
> + * dev_xdp_attach() rejected such programs, but bpf_xdp_link_update() re=
aches
> + * dev_xdp_install() directly and bypasses it, so the check has to live =
in
> + * dev_xdp_install(). Create a generic (SKB) XDP link with a normal prog=
ram,
> + * then try to swap in a device-bound program via BPF_LINK_UPDATE.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem comment style?=20

The BPF subsystem guidelines prefer the opening /* to be on its own line for
multi-line comments, with the comment text starting on the next line.

> +void test_xdp_dev_bound_only_link_update(void)
> +{
> +	LIBBPF_OPTS(bpf_link_create_opts, lopts, .flags =3D XDP_FLAGS_SKB_MODE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810050621.8203=
5-1-jiayuan.chen@linux.dev?part=3D3
