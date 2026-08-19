Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A7335564
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787175266; cv=none; b=nWGpbDDHZDSVackRSDbfy0AnBlTVQqp5wpITkIqQluvgHe/LPnlr1lzlsX1p5KrQkVU4Xz8c96gqQzB+iCkschsw1nFmhPMtZSEL9oWUKtQrWNbKKP6vtxHXKcJnpMOqypevr6h2ieygIaMX5hxI5Myxb2D19LVY5xe7tdW5GSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787175266; c=relaxed/simple;
	bh=Ouhl7hfuno05RUm4TmMlvCp4iFdazi1ClhurwRMipXM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NaAnZpbUKTcaD5YXp93eu3TaE7GHq+fCeXG7+7TjoTyF1GdqNo63OUoKoGXPAN9zZvT45AUqfGZ62CPguv8OAtGgcFYgKPhHnVPBf+FQPDdiyOST111FiIuhT1/nJ32e0i6W/hqwYx689VQgiNZEkC1/YcD/FYNHDj5BYarX4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=woEaq9kr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="woEaq9kr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cace91f112so15477495ad.0
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787175264; x=1787780064; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZvSzYmeFm5vAIe+RzmI/yulTjUip37BVmsT7quQF4BA=;
        b=woEaq9kr+rAlU6etUyZSfIE3oEiM1iA5oeUAuR7lGVJKd7s+U42dPuC1eWzzqzkPa0
         YE382dnpklcliwJQprnJRKta7twQzC9h9O0tYzgSv9heU7ScAdQiTeViWU6H06vq4AT4
         E1n2+pUWM7LSSGG/aKYfc2DG757PfO9Dc3NIdVwVO3zPrEjfi+B4OS3B+iW6OTTJbqV1
         HKs9Uc729yZ5GLZsEGVc0sCEAw/5QWPsVw+n2hqXHgaGjL1ACj6LaCGEKhJvzML663lF
         2GlXTS0gBSbiqyz59KGjS+UJ2LZtwsghAQE/DnabI7aJ2GbBDcuMjUzhuVnD7j0P57nd
         szLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787175264; x=1787780064;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZvSzYmeFm5vAIe+RzmI/yulTjUip37BVmsT7quQF4BA=;
        b=EHBe4R0cu4O55cwmALrmdTi7Y5a5jFFGdgHStcHncSpfJ4Y0uqGXAc7hfW3luiKX6d
         Pw32KSWPe73dQF37GmEZe0G3N0jblICSxP7IiteMinsFGSnxGdICISnHEVRwZ7tg0nbL
         xqgsFXHwV3k8DybBbJIlilyEyT38Mxh68NhjaraMB9r3C8Fw0f+lgoL8RvtVuW3Ogqet
         xjVkUQHFy2eSS2kwB277uqRozcTJ/yxAqx0gz92gpsq3peE5MnTPVX3w5GwoHOCBFfJM
         +OtojpgLPDZIxTucJZKEHE2sqP6qgRUDVqUkGNjNy1Xty3UjEE1opDH8Ydr/QIT2pnQq
         1FIQ==
X-Forwarded-Encrypted: i=1; AHgh+RppTrHI0BwdgfzEtgCHikYdO23BR7lnIKFPRFYCc+mpEy7DQS+8or3ZTaDvl0xF7Bp0DW4=@vger.kernel.org
X-Gm-Message-State: AFuF++niQeeeS2WOJJwe4INKTb5aoiC8Asug/mviHWfdVWFcb+rhqJIs
	aezTIbg4OW4KTYhNL3zi9hG4Yi+PD6hPyGPhZzq4eki+c6y8Oqi8/nWWwDGzprvZfn0X/S7pjss
	Wzair
X-Gm-Gg: AR+sD11oEuVXy0IqrqqLy2p21ds8nb7hEoVrsFiJMutcbw8TUS1480F1HZzhm0yJtXM
	0Eq9lsiteu+gYJuqfCp/E/3V3nHt3k8LM4klFvqpW8f45DwH9WKX0buYXsi+D43ZT/9Z9BOJJJf
	ewcXE97pbvfDPvHLGBOTrU5uZ4P/LvGDj2Dz4O5ALKsezGyl3qM/0SatOtQwJkCjf7oqqdAqlzI
	tQdgIXSkI++/NEEvgzwusJ5dja+3GIlF3HCnzDj6SVLBbM3NAY23XfxcnOpMIwlsZYHTXGza1w5
	jRMkUuQQfDnZNpw0odK1HbTXJXQRyeAdyD0VhZH2XDX/lRv7vvlM9OPGkrKPLscprXDAQPmqHqi
	5BXjtDW+HZTmFAXibmjPXGmZgixYWVJ+zkWDx3Bp0KDQJ3dkjm9ViED5FFFZNjdG9DtUEIH7BGi
	EzkmZCI02ElD06UjEtiUN9OZ0bijnGoZfWbUURCXgQp7/MuDf+LWNMv1dOVmFdzoF5MxxBRPTuG
	2VG4DoP9Tr7T+W4cYMThE/KA8e1
X-Received: by 2002:a17:902:e94c:b0:2d5:d9c2:bbe0 with SMTP id d9443c01a7336-2d5fd621427mr140996965ad.4.1787175264264;
        Wed, 19 Aug 2026 14:34:24 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb519678sm31564335ad.31.2026.08.19.14.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 14:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 17:34:22 -0400
Message-Id: <DKT8R9H3SX3Z.2PW8ZOHVZ5QFN@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: tc_tunnel - validate decap tunnel state
 without false-pass gaps
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Nick Hudson" <nhudson@akamai.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260818120308.623905-1-nhudson@akamai.com>
In-Reply-To: <20260818120308.623905-1-nhudson@akamai.com>

On Tue Aug 18, 2026 at 8:03 AM EDT, Nick Hudson wrote:
> This follow-up tightens the selftest to guard against false passes in
> GSO decap validation.
>
> It validates the expected post-decap state for both GSO and non-GSO
> packets: expected tunnel gso_type bits must be cleared and
> skb->encapsulation must match the remaining tunnel state.
>
> It also adds explicit assertions that the decap validation path was
> executed, including the large-send phase for GSO-marked subtests, and
> asserts that the large-send marker is reset after the send.
>
> This keeps the tc_tunnel decap checks meaningful and avoids false-pass
> regressions without over-constraining behavior across tunnel modes.
>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
>  .../selftests/bpf/prog_tests/test_tc_tunnel.c | 33 +++++++++++++++----
>  .../selftests/bpf/progs/test_tc_tunnel.c      | 19 +++++++++++
>  2 files changed, 46 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/to=
ols/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> index 67ba27d69347..08d7d90f7772 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> @@ -206,7 +206,7 @@ static void disconnect_client_from_server(struct subt=
est_cfg *cfg,
>  	free(conn);
>  }
> =20
> -static int send_and_test_data(struct subtest_cfg *cfg)
> +static int send_and_test_data(struct subtest_cfg *cfg, struct test_tc_tu=
nnel *skel)
>  {
>  	struct connection *conn;
>  	int err, res =3D -1;
> @@ -215,6 +215,7 @@ static int send_and_test_data(struct subtest_cfg *cfg=
)
>  	if (!ASSERT_OK_PTR(conn, "connect to server"))
>  		return -1;
> =20
> +	skel->bss->decap_expect_large_send =3D 0;
>  	err =3D send(conn->client_fd, tx_buffer, DEFAULT_TEST_DATA_SIZE, 0);
>  	if (!ASSERT_EQ(err, DEFAULT_TEST_DATA_SIZE, "send data from client"))
>  		goto end;
> @@ -226,14 +227,17 @@ static int send_and_test_data(struct subtest_cfg *c=
fg)
>  		goto end;
>  	}
> =20
> +	skel->bss->decap_expect_large_send =3D 1;
>  	err =3D send(conn->client_fd, tx_buffer, GSO_TEST_DATA_SIZE, 0);
>  	if (!ASSERT_EQ(err, GSO_TEST_DATA_SIZE, "send (large) data from client"=
))
>  		goto end;
>  	if (check_server_rx_data(cfg, conn, DEFAULT_TEST_DATA_SIZE))
>  		goto end;
> +	skel->bss->decap_expect_large_send =3D 0;
> =20
>  	res =3D 0;
>  end:
> +	skel->bss->decap_expect_large_send =3D 0;
>  	disconnect_client_from_server(cfg, conn);
>  	return res;
>  }
> @@ -374,10 +378,15 @@ static int configure_ebpf_decapsulation(struct subt=
est_cfg *cfg)
>  	return ret;
>  }
> =20
> -static void run_test(struct subtest_cfg *cfg)
> +static void run_test(struct subtest_cfg *cfg, struct test_tc_tunnel *ske=
l)
>  {
>  	struct nstoken *nstoken;
> =20
> +	skel->bss->decap_validation_seen =3D 0;
> +	skel->bss->decap_gso_validation_seen =3D 0;

Sashiko points out correctly that gso_validation_seen is never checked.
Can we assert it with the others?

The CI bot's point on the other hand doesn't matter that much imo, the
assert for the config variable is good in case we ever add any other
subtests.

pw-bot: cr

> +	skel->bss->decap_large_send_validation_seen =3D 0;
> +	skel->bss->decap_expect_large_send =3D 0;
> +
>  	if (!ASSERT_OK(run_server(cfg), "run server"))
>  		return;
> =20
> @@ -386,7 +395,7 @@ static void run_test(struct subtest_cfg *cfg)
>  		goto fail;
> =20
>  	/* Basic communication must work */
> -	if (!ASSERT_OK(send_and_test_data(cfg), "connect without any encap"))
> +	if (!ASSERT_OK(send_and_test_data(cfg, skel), "connect without any enca=
p"))
>  		goto fail;
> =20
>  	/* Attach encapsulation program to client */
> @@ -398,7 +407,7 @@ static void run_test(struct subtest_cfg *cfg)
>  		if (!ASSERT_OK(configure_kernel_decapsulation(cfg),
>  					"configure kernel decapsulation"))
>  			goto fail;
> -		if (!ASSERT_OK(send_and_test_data(cfg),
> +		if (!ASSERT_OK(send_and_test_data(cfg, skel),
>  			       "connect with encap prog and kern decap"))
>  			goto fail;
>  	}
> @@ -406,7 +415,18 @@ static void run_test(struct subtest_cfg *cfg)
>  	/* Replace kernel decapsulation with BPF decapsulation, test must pass =
*/
>  	if (!ASSERT_OK(configure_ebpf_decapsulation(cfg), "configure ebpf decap=
sulation"))
>  		goto fail;
> -	ASSERT_OK(send_and_test_data(cfg), "connect with encap and decap progs"=
);
> +	if (!ASSERT_OK(send_and_test_data(cfg, skel), "connect with encap and d=
ecap progs"))
> +		goto fail;
> +	if (!ASSERT_NEQ(skel->bss->decap_validation_seen, 0,
> +			"decap validation executed"))
> +		goto fail;
> +	if (!ASSERT_EQ(skel->bss->decap_expect_large_send, 0,
> +		       "decap large-send marker reset"))
> +		goto fail;
> +	if (cfg->test_gso) {
> +		ASSERT_NEQ(skel->bss->decap_large_send_validation_seen, 0,
> +			   "decap validation executed for large send");
> +	}
> =20
>  fail:
>  	close_netns(nstoken);
> @@ -438,6 +458,7 @@ static int setup(void)
>  	SYS(fail_close_ns_client, "ip link add %s type veth peer name %s",
>  	    "veth1 mtu 1500 netns " CLIENT_NS " address " MAC_ADDR_VETH1,
>  	    "veth2 mtu 1500 netns " SERVER_NS " address " MAC_ADDR_VETH2);
> +	SYS(fail_close_ns_client, "ethtool -K veth1 tso off");
>  	SYS(fail_close_ns_client, "ip link set veth1 up");
>  	nstoken_server =3D open_netns(SERVER_NS);
>  	if (!ASSERT_OK_PTR(nstoken_server, "open server ns"))
> @@ -701,7 +722,7 @@ void test_tc_tunnel(void)
>  		if (ret < 0 || !test__start_subtest(cfg->name))
>  			continue;
>  		if (subtest_setup(skel, cfg) =3D=3D 0)
> -			run_test(cfg);
> +			run_test(cfg, skel);
>  		subtest_cleanup(cfg);
>  	}
>  	cleanup();
> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/t=
esting/selftests/bpf/progs/test_tc_tunnel.c
> index 853bca962910..e9bd1c9781f7 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> @@ -16,6 +16,11 @@ static const int cfg_port =3D 8000;
> =20
>  static const int cfg_udp_src =3D 20000;
> =20
> +__u64 decap_validation_seen;
> +__u64 decap_gso_validation_seen;
> +__u64 decap_large_send_validation_seen;
> +__u32 decap_expect_large_send;
> +
>  #define ETH_P_MPLS_UC	0x8847
>  #define ETH_P_TEB	0x6558
> =20
> @@ -690,7 +695,21 @@ static int decap_internal(struct __sk_buff *skb, int=
 off, int len, char proto,
> =20
>  	kskb =3D bpf_cast_to_kern_ctx(skb);
>  	shinfo =3D bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info=
);
> +
> +	if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +		     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
> +		decap_validation_seen++;
> +
> +	if ((flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +		      BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) &&
> +	    decap_expect_large_send)
> +		decap_large_send_validation_seen++;
> +
>  	if (shinfo->gso_size) {
> +		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
> +			decap_gso_validation_seen++;
> +
>  		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
>  		    (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK))
>  			return TC_ACT_SHOT;

