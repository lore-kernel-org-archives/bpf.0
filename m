Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124437;
	b=kwTZaTqfB0WA+UMphXNJ7uohbdo50lhCcmcfUrsDIJpC7oFdZENcTY+ulyOMPxbZ9I1C
	 gabUTWm0dduNX1FUSHBwS8u5AFVhYwg6Png80YoMh2wcgoTnFCEpx4iFoUAh8cdzDMeQl
	 Bg9XxcOqPeAQQ8E9sC7y7wNvljEtqIXYeCDswf5OsF32m2nWLJGM9LOF7E6WSJxCWdhip
	 pIHD11zPQqg+6mnGbK6Zgi5nyVCegpj8l71NtI2ZplRN5ysQWNU3HK6Nfm+v8O3lXn/7z
	 s+g2U5vfxeGcBa0V0EuIrUvgbV1aEmbo4TB0jOp70ki6Y5xeMHhPoiWT8UYO2uHA4aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4e/orZcwN4ehEBe5iuQi3ZYyUYANhKYXfnH4tTDCJYY=;
	b=uCEDj9J0BLHJf1sVLzQUAV2GStFqvNTRfkYdhc0yCy6BSfNceQ5969sT2RS1FneI7Rbf
	 GaQx24rUs4iXlN3jTt3fRKH1isJJGNo7BY0bAe0KZkWwUMWiFisLwPD7QyvZW5cS2HLGV
	 akllJRDvUguI5LNFLNUESkygYJA1714qXAJ8QQMS4wPC9l1dCFOhuuJzIr+hLjK+HHClx
	 mdglPoYyc/AzZjdpfshbd6p+F8G4kF/omTVd4ghPajh9WLVkFz1526gnakF99H4B5DfeW
	 kE9JF+rkei6obJZWlqsJuRrRm6B8fmROpcZlq0lb18NtCtuW6Ughz/bGQTbk2xF+R1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KmPOrhDQ;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2B60A260F
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 21:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2D2B60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KmPOrhDQ
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-921159376efso3600216d6.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 13:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795124436; x=1795729236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4e/orZcwN4ehEBe5iuQi3ZYyUYANhKYXfnH4tTDCJYY=;
        b=KmPOrhDQ6Lw4s+NrReazzyihUq8KfNjnn9XwodUbB+B5p7OD24gq4mRolS8MDKeXkU
         E3lNoiGav+nKXAY9lEqYoRVO3l09upGuiK8V9EmFsJxflDxAfZdn36RLMs9TqjmSVegx
         ObD++d/HteAD8lSw0DczdlWsMpbs8JRJtNtlcxtn4QhCg+i5B7mOyni7z+p658i1GzjX
         sB19dVyqm30sEiCLJqoBrCiaaTdYTVXnnhq7TiETzvj+BjBN2VgZN3szvW6uXm+IyaLf
         XLGTLXOTt0v8fT7E4AFy7cfYSYgipVvBrd7RhYnMNwjRkPD+OZhjNGeVLwoyc2+4Uddv
         EQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795124436; x=1795729236;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4e/orZcwN4ehEBe5iuQi3ZYyUYANhKYXfnH4tTDCJYY=;
        b=c2+J+2HK3UPxRTVW6l1LE934ktiF4BrIpfCakYbbKWo7RE1W12lmRNXjWJN5ITToPt
         h87RlYaxqCdOD6+rdy6hI2VoMqLzFm9uwwxgpnvZYvHVdCdMbdNQrJisKRzzcA4hvtFJ
         JbE+QVMyyu1iK3Ny5jSvSwxlatLsXme4n+Qo+iPoJu5OSrt79JSP1oshnXnDRYDDEe6c
         Dq5m3vzOAvFqELLs9ng/nkNj8ADDY/VDTUrEsebOpl6a1NakP4Ixrt9jxCIHPDwdQPXm
         7pjT4sZaWNSNvilpz8LhbNbvQYWWTpvYhoCzynEhpEePB0ONTzdfnyakU96HJ4UJ5CV3
         smiw==
X-Forwarded-Encrypted: i=1; AL+hErE5hHgeRA61ZBtYfnZmOyHBGc1aM92GND6ERZsXGaaXbo8HQoul+cUGioyU9s+JDoUKvAE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wmTe6BbAeReaah+8LgkSSDhqQy1789Cgz4eWONouaoaYg+8Xf
	EXO+y05ALqJq3HRiHj/be4RBW/bGcDWJJhSejHYa/Hl+2W+0HYBnvMHq
X-Gm-Gg: AYBFou04l/e9E+oiEvakOK8I4lkmkyWxTJPdnIzWPpkKdwlGe9dvdPrWqi1cFIJjaa8
	+M05ZGGQ5EAdAhykauwO8ekrDBWCv56qxyRkzZ9lMsVpZba55pRqAfodAAWybfLFMX+dO18xLmw
	E7qJUyaqwbGEToXepPG3CTBk9qF0LxdXlrCb3JXPKgCXhhPczlzPGBdvYRwBgFNkOQWT4WaGddk
	dom1GobnAgBtguLq31nUrHDBSujzYZAlspJEl5uN5RFN5MTvfZAqA3rUIymKGdcadwHQr71xPW8
	UKyRI9Jjd1zPaosGV0ohtdrwgp4yOlPrz4KsuzLFRS7HG+34dr/yaAJitXS5XhJw6SfYHJLXeWS
	YPY7yAXUdmrXhlQPNpmKN9IUAqoapHdKWi7sEw4k3ROa8TWGPBwgOHg+9eaJncsvoZ2PgFFo5kY
	yVxfgFcoPLWSTYWA/0zNwvZPd+9yplwBcn4SRWmZkaHN03ADkx4GY7eZNB1cWvjGvVzyaeqvlku
	C9tqEAIggdX36U9+7KFUpTMXDDeT2mwP0cMxbIWNpf0V8CLSi/eJj/SwQkYv1fIiqHIXSbsF161
	+OQ5O7DyiklFkAgyuEPIeIrKMVZGA386MQzaeiitnmEGIE3pqEzdWJ9LRoTsxQErY5NASH3cESV
	hGdXsGHztDbhcZBmTQlnskl1XwtgAg/hy8MskcyoEMrXGcQo1tqF/LA3afrjnogY=
X-Received: by 2002:a05:620a:4591:b0:93e:5060:f929 with SMTP id af79cd13be357-949ba9b64d9mr171849385a.19.1795124435809;
        Thu, 19 Nov 2026 13:40:35 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f2de5sm52119585a.29.2026.11.19.13.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 13:40:35 -0800 (PST)
Date: Thu, 19 Nov 2026 16:40:35 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 michael.chan@broadcom.com, 
 manishc@marvell.com, 
 joshwash@google.com, 
 hramamurthy@google.com, 
 tariqt@nvidia.com, 
 saeedm@nvidia.com, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 sdf@fomichev.me, 
 willemb@google.com, 
 przemyslaw.kitszel@intel.com, 
 bpf@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.66eaabdbc8a1@gmail.com>
In-Reply-To: <20261118232315.3593731-3-kuba@kernel.org>
References: <20261118232315.3593731-1-kuba@kernel.org>
 <20261118232315.3593731-3-kuba@kernel.org>
Subject: Re: [PATCH net-next 2/8] selftests: drv-net: drop the generic XDP
 hack from the HW GRO setup
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> The HW GRO tests want SW GRO out of the way so that what they observe
> can only have come from the device. On drivers which keyed HW GRO off
> NETIF_F_GRO that was not expressible with ethtool alone, so the setup
> fell back to attaching a generic XDP program, which suppresses SW GRO
> as a side effect.
> 
> Those drivers no longer tie the two features together, so ask for the
> feature combination directly.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../testing/selftests/drivers/net/gro_lib.py  | 21 +------------------
>  .../selftests/drivers/net/hw/gro_stats.py     | 18 ----------------
>  2 files changed, 1 insertion(+), 38 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/gro_lib.py b/tools/testing/selftests/drivers/net/gro_lib.py
> index 875a715b2ae1..6eff19db3541 100644
> --- a/tools/testing/selftests/drivers/net/gro_lib.py
> +++ b/tools/testing/selftests/drivers/net/gro_lib.py
> @@ -263,26 +263,7 @@ def _run_gro_bin(cfg, test_name, protocol=None, num_flows=None,
>          set_ethtool_feat(cfg.ifname, cfg.feat,
>                           {"generic-receive-offload": False,
>                            "rx-gro-hw": True,
> -                          "large-receive-offload": False},
> -                          check=False)
> -
> -        # Some NICs treat HW GRO as a GRO sub-feature so disabling GRO
> -        # will also clear HW GRO. Use a hack of installing XDP generic
> -        # to skip SW GRO, even when enabled.
> -        feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
> -        if not feat["rx-gro-hw"]["active"]:
> -            ksft_pr("Driver clears HW GRO and SW GRO is cleared, using generic XDP workaround")
> -            prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
> -            ip(f"link set dev {cfg.ifname} xdpgeneric obj {prog} sec xdp")
> -            defer(ip, f"link set dev {cfg.ifname} xdpgeneric off")
> -
> -            # Attaching XDP may change features, fetch the latest state
> -            feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
> -
> -            set_ethtool_feat(cfg.ifname, feat,
> -                             {"generic-receive-offload": True,
> -                              "rx-gro-hw": True,
> -                              "large-receive-offload": False})
> +                          "large-receive-offload": False})
>      elif mode == "lro":
>          # netdevsim advertises LRO for feature inheritance testing with
>          # bonding/team tests but it doesn't actually perform the offload
> diff --git a/tools/testing/selftests/drivers/net/hw/gro_stats.py b/tools/testing/selftests/drivers/net/hw/gro_stats.py
> index 70e76e3888bd..569ca81368e6 100755
> --- a/tools/testing/selftests/drivers/net/hw/gro_stats.py
> +++ b/tools/testing/selftests/drivers/net/hw/gro_stats.py
> @@ -173,24 +173,6 @@ def _run_gro_test(cfg, test_name, num_flows=None, ignore_fail=False,
>                         "rx-gro-hw": True,
>                         "large-receive-offload": False})
>  
> -    # Some NICs treat HW GRO as a GRO sub-feature so disabling GRO
> -    # will also clear HW GRO. Use a hack of installing XDP generic
> -    # to skip SW GRO, even when enabled.
> -    feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
> -    if not feat["rx-gro-hw"]["active"]:
> -        ksft_pr("Driver clears HW GRO when SW GRO is cleared, using generic XDP workaround")
> -        prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
> -        ip(f"link set dev {cfg.ifname} xdpgeneric obj {prog} sec xdp")
> -        defer(ip, f"link set dev {cfg.ifname} xdpgeneric off")
> -
> -        # Attaching XDP may change features, fetch the latest state
> -        feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
> -
> -        _set_ethtool_feat(cfg, feat,
> -                          {"generic-receive-offload": True,
> -                           "rx-gro-hw": True,
> -                           "large-receive-offload": False})
> -

Not sure how likely these driver edge cases would be to reach, but FYI:

    gro_stats.py uses its own _set_ethtool_feat(), which, unlike the shared
    set_ethtool_feat() in lib/py/feat.py, never reads the features back
    after `ethtool -K`. This removed `if not feat["rx-gro-hw"]["active"]`
    was the only check that HW GRO actually turned on. Drivers still drop
    GRO_HW in ndo_fix_features for reasons unrelated to SW GRO:
      - qede with MTU > PAGE_SIZE;
      - bnx2x when the MTU doesn't allow GRO;
      - bnxt with BNXT_FLAG_NO_AGG_RINGS;
      - mlx5 with legacy RQ or CQE compression;
      - and, after 3/8, any attached XDP program.
    In those cases the test now runs with both SW and HW GRO off and fails
    later in _check_gro_stats() with a confusing count mismatch, instead of
    skipping. gro_lib.py got that check by dropping check=False, so the two
    tests now behave differently. Either switch _setup_hw_gro() to the
    shared set_ethtool_feat() (and delete the local copy), or keep a short
    read-back
>  
>  def _check_gro_stats(cfg, test_queue, stats_before,
>                       expect_rx, expect_gro, expect_wire):
> -- 
> 2.56.1
> 


