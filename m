Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795366983;
	b=XAT1PjwSyG3ZooUUTG7z3r8iO6h4AluJ5IhLspPY7DyZ1RrCU+/YqbQeNp+2YYwAI/eM
	 b2IkSy5dOtOICt1B8irRF2goP1vPiH2hKTFEiHrTK2bEix4wRcga82uB4Uhw5nv2BeTLi
	 lsszhQYHSdUv28d19zo5Qkap8oCGzi1QdPJyLJHt3MjpJprPGsjpiOZA+nMi6KgAs76Nl
	 Ff92j37qqhVoPyk7pgcU2SVdioAmGZP+ziiL3G4IfOlNHT6UVj06HGR00vU4QeNR8NKrL
	 MK5AxG1j+jJzeqgVf9g8nPDwWFUQDGe65xwtSsjthHYPxUN+QxBAq5c7scMRq1XR1Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795366983;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vvzwh5GY5QMNLLzQ84AaKr2G99TlKd4xQAgrpeGbXeM=;
	b=VonyeTH2N5xm+2BUQyuI0jgTL7hRlEVooPKGFiwua6fbfuZPQi0nv6amCHiqdPjkFKn2
	 ldD6j//hpn9JU32/Z+PdV3W1AjCl7mN32anG25Qsya+cM9qTL5B58SLBPPqNBL/fUVamp
	 dBabrg6gnNV7tWuzPJ88ur04TbIWLYpiE8uHh5yACwhB4UDsGsU6ZJVDjltE8GCeRP2Dc
	 I4ZY8YRIEEk2LEj82FSYfInCHI6ylJCFMMhvQiAk9kDOHS2cadNYxblA1zKml0h9YW7b2
	 FXYPqXmMeqv0SqjpoyPIOUi8u9rOJCrRJzoQXNT633q3a7NiezIKmyM2C5SkC965HHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcXx6K5K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79412606A33B;
	Sun, 22 Nov 2026 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcXx6K5K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9E11F000C0;
	Sun, 22 Nov 2026 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795366983;
	bh=vvzwh5GY5QMNLLzQ84AaKr2G99TlKd4xQAgrpeGbXeM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kcXx6K5KOPBdgnXvlGlK1lb4eveQeZ8a7Vzna+DmaOotwEfCqFIKxcpoAbRusRO4Y
	 2gSE65DdxsCx4noedpBmi/U+fdqDUmTgdGwbqX7uE4GEQJNMb+lFUXgAXC/mgyb99e
	 QeuvsdoRYfTt+skZwJbpWOCwF9k0t8PmaqQn89t8TxNf7jyl7ZbCvAxZD91vuRKUMt
	 D6lybYWuPm2QsHkz6Km0DfotRLjps1iqkAA4oyLtJH7WHE/bOnNvO0C2OlVLXqn3tF
	 KakIIHqkR5ZH+jQ7BgITIvsSV0LLz6q7qOUbIcImhVl6fdRu/efnayQUpQFmpgsSQY
	 L7SsEvMUyD1wg==
Subject: Re: [PATCH net-next 2/8] selftests: drv-net: drop the generic XDP
 hack from the HW GRO setup
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com,
 hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com,
 daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com,
 przemyslaw.kitszel@intel.com, bpf@vger.kernel.org
Date: Sun, 22 Nov 2026 17:03:01 +0000
Message-ID: <179536698167.3135.988717812075290728@kernel.org>
In-Reply-To: <20261118232315.3593731-3-kuba@kernel.org>
References: <20261118232315.3593731-3-kuba@kernel.org>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch, nothing in
  tools/testing/selftests/drivers/net/hw/gro_stats.py checks that rx-…

--

selftests: drv-net: drop the generic XDP hack from the HW GRO setup

This commit removes the generic XDP fallback from the HW GRO setup in
gro_lib.py and hw/gro_stats.py. Drivers no longer tie HW GRO to
NETIF_F_GRO, so the setup now asks ethtool for SW GRO off and rx-gro-hw
on directly.

> diff --git a/tools/testing/selftests/drivers/net/gro_lib.py b/tools/testing/selftests/drivers/net/gro_lib.py
> index 875a715b2ae1c..6eff19db3541f 100644
> --- a/tools/testing/selftests/drivers/net/gro_lib.py
> +++ b/tools/testing/selftests/drivers/net/gro_lib.py
> @@ -263,26 +263,7 @@ def _setup(cfg, mode, test_name):
>          set_ethtool_feat(cfg.ifname, cfg.feat,
>                           {"generic-receive-offload": False,
>                            "rx-gro-hw": True,
> -                          "large-receive-offload": False},
> -                          check=False)

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/hw/gro_stats.py b/tools/testing/selftests/drivers/net/hw/gro_stats.py
> index 70e76e3888bdb..569ca81368e69 100755
> --- a/tools/testing/selftests/drivers/net/hw/gro_stats.py
> +++ b/tools/testing/selftests/drivers/net/hw/gro_stats.py
> @@ -173,24 +173,6 @@ def _setup_hw_gro(cfg):
>                         "rx-gro-hw": True,
>                         "large-receive-offload": False})
>  
> -    # Some NICs treat HW GRO as a GRO sub-feature so disabling GRO
> -    # will also clear HW GRO. Use a hack of installing XDP generic
> -    # to skip SW GRO, even when enabled.
> -    feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
> -    if not feat["rx-gro-hw"]["active"]:

[ ... ]

> -        _set_ethtool_feat(cfg, feat,
> -                          {"generic-receive-offload": True,
> -                           "rx-gro-hw": True,
> -                           "large-receive-offload": False})
> -

[Severity: Medium]
Now that this read-back is gone, does anything in gro_stats.py still check
that rx-gro-hw is actually active after _setup_hw_gro() runs?

_setup_hw_gro() calls the file-local _set_ethtool_feat(). That helper only
raises KsftSkipEx when a feature is marked fixed. It never re-reads the
features after running ethtool -K:

tools/testing/selftests/drivers/net/hw/gro_stats.py:_set_ethtool_feat() {
    ...
    eth_cmd = ethtool(" ".join(new))
    defer(ethtool, " ".join(old))

    # If ethtool printed something kernel must have modified some features
    if eth_cmd.stdout:
        ksft_pr(eth_cmd)
}

In the same patch, _setup() in gro_lib.py drops check=False. It now relies
on the read-back in the shared helper:

tools/testing/selftests/drivers/net/lib/py/feat.py:set_ethtool_feat() {
    ...
    current = ethtool(f"-k {dev}", json=True, host=host)[0]
    for name, state in feats.items():
        if current[name]["active"] != state:
            raise KsftXfailEx(f"{name} was not set to {s2n[state]}")
}

The kernel can still clear rx-gro-hw even when the feature is not fixed:

- netdev_fix_features() drops NETIF_F_GRO_HW when RXCSUM is off or RX-FCS
  is on.
- A driver's ndo_fix_features can clear it.
- The tests may run on a kernel without "net: stop making HW-GRO depend
  on SW GRO".

In those cases, would gro_stats.py go on to run with both SW and HW GRO
disabled?

If so, test_gro_stats_full would fail its ksft_ge(gro_coalesced, 1) and
rx-hw-gro-* checks with misleading messages. Meanwhile test_gro_stats_single
and test_gro_order could pass without HW GRO ever having run.

Would it make sense to switch _setup_hw_gro() to the shared
set_ethtool_feat()? Another option is to re-read ethtool -k after the set
and skip or xfail when rx-gro-hw is not active.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118232315.3593731-1-kuba%40kernel.org
