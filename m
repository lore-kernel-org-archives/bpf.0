Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421712;
	b=iv5lj8JrmXhIkwciFKjdJKa3yyISttTqnQnRCfgiSZRouPiL+8gTwJZca9czLRyIi0+l
	 JeM/aEV8UxuLxJ/uytbbW8rVFq2pKAB+QNmmmqHc3Ub3dLbNKvq6/+3o9hi2U9shrqwWy
	 V/cCMSr46XjeHKknMdTI4v3IlFWboC2r5VR6TjdglpJn1on+R+FJEUhTTuYpncXT6f9u4
	 vz6Ph1vgddNEKRPPYrwCYvPqzgfz7dHjlv7rWMBgqItmq3wyX2LgF+GiuG09mJ0JWfn++
	 WScyRWsPj3GwpIw6ue29SCzeUI7ADybGOCCDg4QytlV60nlzckfvoWaGmbFxPZsEMAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421712;
	h=Received:Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WQrKvC0O7qmerhfnG9M3z27SqPcXxJWgtPiJ3mb6oJE=;
	b=Pr11EhuxDk6k7p+5tCMX6PpfQg7XFHF5BgPMIuxcH8czsYGVg4nBY75VUvfosqFnEwLX
	 jSK/bkXqZ43ywgfzqJOmDlwfibtTNqLxCxj3zoiarIo2az2mkOHVEWUG/6bDv9ChiBJHJ
	 D+lTtpZ1JDTnwwNhCIhTavtXxeS/cdd3FyytW7xuownstiiuCpUKDVVAUJyPdoYsr2lYO
	 0q79aGxQ7Qz5WehmF+s9asqL8DKrsRVk0/s+kxyP1jW2PSq/gk90urr1x/OsguF2W79iU
	 SQMTOK18xrMB0z6osBa/1UkoHwR6Arywg1QLHbAxurmVD/MQXCobkRuu24z9uaGXfPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0PvmOnD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E799606EFEE;
	Mon, 19 Oct 2026 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0PvmOnD
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F6F533D6;
	Mon, 19 Oct 2026 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421712; cv=none; b=m//qWIo4iGvRgXdICscJopzosP8/UCnjM/bAn7klrTVpQNnofTfULB5Ccfs5TE3YNEeu6JKTBiyPhOoIRfbmiD6APs36DY1LTVq6GT/Fj5/mDdbsh5n36wU7DE1OyGF2p1Bhs7pdhc2MjFkWADRGm4Yv3CpQcrQ2tEd2UDK3H70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421712; c=relaxed/simple;
	bh=VivAJRvivSKrkuPz0VaDEUS9jDA46EwfrqY6W31PGFQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DF9uDU2T/drNSV4d2VGwMnZhgzlj+80J5PkQkaRuSi0XIdcPcL846B016bWirzUTD7UX81EMySPp5/jrqV5kDT1yZLR8GVIBRNCMcTUEA/5LTiDQYZbEBYZtsTWvSr7DjRUAIrFx/4fL7G7BCFMTBsgrVHYoXDizrHVlydKO+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0PvmOnD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CF81F000C4;
	Mon, 19 Oct 2026 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421710;
	bh=WQrKvC0O7qmerhfnG9M3z27SqPcXxJWgtPiJ3mb6oJE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J0PvmOnDAo5flEbgEBdcb40YpvrJbbRjjWvSW/Pinv/I+iHZuPGuRiwmC2Lw/xj/j
	 qGq0EQmOtuZUsIGSiQdUa3U8IPXD0bLzwwsdYTp1ljbnObhJZKIygsj7kBIKWhF0KD
	 btzWRp3sWKK5eo+opls6Doclu3K1dLYx7LlmMBk37bPCK6oaD2trZI7Rk0JJw6EDqA
	 6QPCvzWQXG9WK1mGCyzxUUaG1qeJbkUJM/c/1dmGOnRc7Qiu3ivb29GfR1biiAvNjV
	 e5OcVCUuzUCfU4nUigBexE3DxiqHJJuQjcg2bytAUiwEUR7EZ+nCPoQ/KR7ksBH6K4
	 rxe7RhusGxVGw==
Subject: Re: [PATCH net-next v6 3/5] selftests/bpf: Send XDP feature probes
 with AF_PACKET
From: netdev-bot+sashiko@kernel.org
To: bochaolucky@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 andrew+netdev@lunn.ch, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 alexis.lothore@bootlin.com, lorenzo@kernel.org, tiozhang@didiglobal.com,
 willemdebruijn.kernel@gmail.com, petrm@nvidia.com
Date: Mon, 19 Oct 2026 14:55:07 +0000
Message-ID: <179242170743.3135.13335465558311529562@kernel.org>
In-Reply-To: <20261018-xdp-v5-send-20261008-v6-3-7336e1282ca3@gmail.com>
References: <20261018-xdp-v5-send-20261008-v6-3-7336e1282ca3@gmail.com>
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

- [Low] The hand-written usage line in argp_program_doc still reads
  `USAGE: ./xdp-features [-vt] [-f <xdp-feature>] ...` and does not…

--

selftests/bpf: Send XDP feature probes with AF_PACKET

The tester now uses AF_PACKET to send echo probes and count the replies,
so it no longer needs XDP support. The DUT now attaches through an XDP
link, and the patch adds a -q option that queries native XDP support.
The network_helpers dependency is dropped and veth XDP_TX is skipped.

> diff --git a/tools/testing/selftests/bpf/xdp_features.c b/tools/testing/selftests/bpf/xdp_features.c
> index 97c0e871c5b65..be4acb768e0a2 100644
> --- a/tools/testing/selftests/bpf/xdp_features.c
> +++ b/tools/testing/selftests/bpf/xdp_features.c

[ ... ]

> @@ -78,6 +156,7 @@ const char argp_program_doc[] =
>  static const struct argp_option opts[] = {
>  	{ "verbose", 'v', NULL, 0, "Verbose debug output" },
>  	{ "tester", 't', NULL, 0, "Tester mode" },
> +	{ "query", 'q', NULL, 0, "Check native XDP support without attaching" },

[Severity: Low]
This isn't a bug, but should the usage line in argp_program_doc also
list the new option? It still reads:

"USAGE: ./xdp-features [-vt] [-f <xdp-feature>] [-D <dut-data-ip>] [-T <tester-data-ip>] [-C <dut-ctrl-ip>] <iface-name>\n"

The -q, --query entry shows up in the argp-generated option list, but
the hand-written usage summary leaves it out. The usage line is still
unchanged at the end of the series.

>  	{ "feature", 'f', "XDP-FEATURE", 0, "XDP feature to test" },
>  	{ "dut_data_ip", 'D', "DUT-DATA-IP", 0, "DUT IP data channel" },
>  	{ "dut_ctrl_ip", 'C', "DUT-CTRL-IP", 0, "DUT IP control channel" },

[ ... ]

> @@ -719,6 +969,20 @@ int main(int argc, char **argv)
>  		return -ENODEV;
>  	}
>  
> +	if (env.query_only) {
> +		LIBBPF_OPTS(bpf_xdp_query_opts, opts);
> +
> +		err = bpf_xdp_query(env.ifindex, XDP_FLAGS_DRV_MODE, &opts);
> +		if (err)
> +			return 1;
> +		return opts.feature_flags & NETDEV_XDP_ACT_BASIC ? 0 : 4;
> +	}

[Severity: Low]
Could the exit codes for query mode be documented somewhere, such as in
argp_program_doc or the -q help text?

Here 0 means NETDEV_XDP_ACT_BASIC is advertised, 4 means it is not, and
1 means bpf_xdp_query() failed. None of this is described in the tool.

Later in the series, run_feature() in drivers/net/hw/xdp_features.py
treats probe.ret == 4 as a skip, so the contract is already in use.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018-xdp-v5-send-20261008-v6-0-7336e1282ca3%40gmail.com
