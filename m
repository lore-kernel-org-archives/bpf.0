Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524632;
	b=pwHiHSsiu67MyY5xPpHb3W4xrS08nS91N1MomVTBBBqDmQOjzsuFNyVLFjmCuwakGfH6
	 UrC8ro6KeeL84w9TEXqz5g+TieObDtP5Szs3p7WeX0ossAlS7wN4oDW/FBGv5S9mzwl2W
	 1+HLfkEuddhgJYDCXpp0a5783qtp43epKSPgDDUabfmhXWkRr9G0o1s7EWIwz4AodH+xB
	 qdUE4f1NR0igckExN1RMAnSiqUSoMswLNsp9NKcLqhbAzQhjjbKNSzHrVWwACeYtPyKqE
	 EMT4XiOtocKH3eM3JieiusXITYuZxCWp4xVIDQb3uapUaXd+reiVJZDXUQszQRiLGuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524632;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VtbXwkCIXbgyZunGhyG1HyvmWfkGMz8AqTPwweIhNfg=;
	b=Nl4IJ0L/QXFWPrMNYZ8XX4V7b0kaQhQS1nNSu1wo+cNKq7tatui6zOtWxlRaAaWr8GSa
	 HSuAKOYhU0yhUUjY3L0kFWSmcPMRk9KZDVcBOgQ6kldBlMbgeoLQ8QgAt1mZji05neLFN
	 2tW8lO/Hc4J74Tpj9mdssOQs0UE77GfqNylolb/2XXJRtxgwU8tXYkQcyLpiaMgdWyEqO
	 AaXSG78ZWp5h5zgIKRFTo+eOLi6Xoo8QhfYPwp4w6puhHizqzNo7tlhHXkccN5uNJWp6V
	 44cl7mHJ9CeFQtqvmsp8xDMrNJd+jYNDCnRYJQaRd5mzr/zGPhR3dSReblNgyFyZ7IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C68CymfH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62F9606A338;
	Tue, 20 Oct 2026 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C68CymfH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71791F000C9;
	Tue, 20 Oct 2026 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792524631;
	bh=VtbXwkCIXbgyZunGhyG1HyvmWfkGMz8AqTPwweIhNfg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C68CymfH9mOu+TN/37TzZAKejxsehcnKvn7mkibsNBQGdaIA4CA76an6Z4tDd5pzW
	 XuPQE3HbYtdL2CbFX6fSVeKxFRHvK1gvCkEDOp8o3YmPose5IPChq1Asmo9X1o+TXm
	 GUKm7u47lnyqfBqhaKwcA4S6GL36613vxegcvz3/f3uVZgTWKuzBr8M19csZ04lVTG
	 bBjoWFGhBYvwiHAo6DFcym4+gUGT10FguBZ6Dsj9XDQvgnrFJYud79n3fzoKOReZ/Y
	 r6ur+2pJJk6OgVICfSNlqZubcROJsNo1WqHiSOt4Y7lHuJ65w4FtiVjmOWyCDQCR+P
	 SZtUh3wZZvk2Q==
Subject:
 Re: [PATCH v4 net-next 13/15] selftests: xsk: list the hardware test cases
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Tue, 20 Oct 2026 19:30:30 +0000
Message-ID: <179252463022.3135.13583685372902273086@kernel.org>
In-Reply-To: <20261016174338.787135-14-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-14-maciej.fijalkowski@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new comment above the test tables in
  tools/testing/selftests/net/lib/xsk/test_xsk.h (lines 307-312) names…

--

selftests: xsk: list the hardware test cases

This splits tests[] in test_xsk.h into hw_rx_tx_tests[], hw_rx_tests[],
hw_tx_tests[] and generic_tests[], grouped in test_groups[], and test IDs
now follow the order of those arrays. It also adds a -L option to
xskxceiver, which lists each hardware test once per role it covers.

> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
> index 15534f4ec8f4b..a59b34b156d79 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
> @@ -304,49 +304,73 @@ int testapp_xdp_shared_umem(struct test_spec *test);
>  int worker_testapp_validate_rx(struct test_spec *test);
>  int worker_testapp_validate_tx(struct test_spec *test);
>  
> -static const struct test_spec tests[] = {
> +/* Tests by the role of the endpoint that they check. A hardware run, see
> + * xskxceiver -L, gives that role to its zero-copy endpoint. It does not do
> + * the generic tests: BIDIRECTIONAL swaps the directions, which
> + * drivers/net/hw/xsk.py sets up one at a time, and the others skip in
> + * zero-copy mode.
> + */

[Severity: Low]
This isn't a bug, but the comment above hw_rx_tx_tests[] points to
drivers/net/hw/xsk.py, and that file is not in the tree at this commit.

The only xsk script under tools/testing/selftests/drivers/net/hw/ here is
xsk_reconfig.py. Nothing reads the hw_rx/hw_tx fields of struct test_group
or the -L output yet. The in-tree runner, net/test_xsk.py, still uses -l.

The next patch in the series, "selftests: drv-net: test AF_XDP zero-copy
with an SKB peer", adds drivers/net/hw/xsk.py. Its _get_cases() runs
xskxceiver -L and parses the "ID: NAME rx|tx" lines. So the reference
is correct once the whole series is applied.

Could the comment be added in the patch that adds xsk.py instead, so it
is accurate at every point in the series?

> +static const struct test_spec hw_rx_tx_tests[] = {
>  	{.name = "SEND_RECEIVE", .test_func = testapp_send_receive},
>  	{.name = "SEND_RECEIVE_2K_FRAME", .test_func = testapp_send_receive_2k_frame},
>  	{.name = "SEND_RECEIVE_SINGLE_PKT", .test_func = testapp_single_pkt},

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016174338.787135-1-maciej.fijalkowski%40intel.com
