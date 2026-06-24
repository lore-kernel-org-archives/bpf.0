Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0493603D9
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328433; cv=none; b=rrjz+oa4sAVHw/bOerHCozKhds37fsOzM59zWAOTYqL1/qtS03HaQCDMcWcjRfPUee2bBUqy/fxuyfDyyzXbIV8H36jNrsJmOGooZWuOocwmB8zcTuvng2Ld7F5kVGFGPg1H7kbnQD0FQdD+rIrpvTmwPTbtG+BQVGfRrG6KXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328433; c=relaxed/simple;
	bh=O2znNyHwT7hj3JGyh+HMWgbfigbcJcdLD2e0HfA/chs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BOcSx74l6PhP6JcIIAGVWEiiDce03KxFEC+jRxMR9cnst8uztY1+QSYLOw46oCibl6g/e9q4+5mfN88MMSsj4ANBqvZis1Iqwl/wDt908F/Pxnpm17FrGS2HOdgrfp1gX1GEVsPM1oa+n+NaDT6CCXVGEhHr4DTfOvei8tpQLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=GkJzYT/F; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="GkJzYT/F"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so2937917eec.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782328431; x=1782933231; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyUUOXO0No04aRtViU2MfDSWBaoEVdtoOPUeYpvX6qo=;
        b=GkJzYT/FFk9xi97VCzo0qrbye7WcaqcLy6gTc89gnP5HI9GNJ6Qrb9KwBjybvbfQMC
         yI7/3nUT0f1p2InjlN7A9f1SomvfjguMsKztFUOIHLWZoMaOTHZqOJZPCLHtu98OVBQ3
         MSacPHnsTvM2R/dEnU8JdqxE/BrjX2H4SfjrpXz2kxgr6jS9os2cLIYzQfgFNyr+UwWf
         aJI4QbsSzn1pkYjBE1vrQyct3Bmw3hRwwzgWM3Ymrva/IRXFeWWNR27SyaLnXlCeRAiq
         YayGihNveJbHevYFy/EXUaJqR1MBjR7XrHWeZCbMnwThQufuAfsKtPgNYY5/AXFZ49+4
         9K+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782328431; x=1782933231;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uyUUOXO0No04aRtViU2MfDSWBaoEVdtoOPUeYpvX6qo=;
        b=k3oH9ZEvhNHJktCP34aCoCjQmMFT9r+/LsfglgDEwxCAVlvEsFRhutCDzUY4BAycdt
         RiuraBJZM0vFXJHWE6qj0FVsmsE/7U5VK9HKgHI4JJDx79DNcE+evjqicMdnA02mQgts
         KC8ZLSXb1b2UfNmjpLm2cxFLEU8kopuvp7hq62+FFtsvAlPg4lUBdrIpf4cuTZxm1UlP
         9rYHPV+BVFrxkJ7I1rsY/zx0pLrbXCn3XFH5naEN123ETFDUhCLNyYyK4AI/6QU6v04d
         nWQRq/PwE6q+k5FsY91ekINqG/Y0lZ0Za6V5/a+qQsFBWjDhm2fIVOIRm33cVkKAqy58
         XvSA==
X-Forwarded-Encrypted: i=1; AHgh+RrMECm9DufcWBKJgRNt9/WEx3JF3nSC5CXYMeCJdS6zbgPraxIsY+Wckc80EZzieYWCMNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDk+57HUKVI7HGD/c8OX34QbfqMMOIqy2y0LDDTKorCEXF2II
	qNGdj0YnuE0TBCo8LjQE9bBM1XE1pVyP+fdZxUPwrfCf49gmGnSashXvX469KRVSJFk=
X-Gm-Gg: AfdE7ckEBqiubBn4lfFi56NhRO3BLzOSxzsBFyUXEynLclsho8TTHE3ZxYzQX54Dxt/
	9TTDubgATK5OQT3o/m7gTQOqAk74fjpKrXSfU0X+CeCvpJ1+78xufdRFZtMTnQGa7BVjaxVXo/m
	oCC/r4Q78GkS89ZDYqP4shDW/LbDtYg78j5Vuijwl+M55RvMepVFEcqmQj+lv5G4Ng6tx3i8F0J
	0bIPlbwttr9hm5krNipEkJWNrUdbfjIi7j3m585UdEY14BYcFCmD10amePXZfRIsNRcDgU1mgJU
	TfEfQw2Mr808J5xOLT4hcPbUZMOhgGRFdS10Jsduw0R2N6lsjBISTLfaAvGrHUIgN24lVWV9csm
	1sp6x4PVm+CklIbhKkGcp7gigulDdgVBtOrH6/wzWkbj/rll89fTt2tsxtcJNPm4hUq17ig==
X-Received: by 2002:a05:7301:7c12:b0:305:56a:c38f with SMTP id 5a478bee46e88-30c1dc33984mr14541949eec.26.1782328430915;
        Wed, 24 Jun 2026 12:13:50 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::bf4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52d669sm1120765eec.11.2026.06.24.12.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 12:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 15:13:48 -0400
Message-Id: <DJHIP4PVP1AN.2QYBJCTRQFH91@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <john.fastabend@gmail.com>, <jordan@jrife.io>, <martin.lau@linux.dev>,
 <yonghong.song@linux.dev>, <emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v9 5/5] selftests/bpf: add bpf_icmp_send no
 route test
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260624185554.362555-1-mahe.tardy@gmail.com>
 <20260624185554.362555-6-mahe.tardy@gmail.com>
In-Reply-To: <20260624185554.362555-6-mahe.tardy@gmail.com>

On Wed Jun 24, 2026 at 2:55 PM EDT, Mahe Tardy wrote:
> For normal live cgroup_skb paths, the skb should already be routed. The
> exception is for test run via BPF_PROG_TEST_RUN with packets created
> via bpf_prog_test_run_skb. Those lack dst route and thus the icmp_send
> would quietly fail by returning early.
>
> This test exercises this and makes sure the kfunc returns -ENETUNREACH.
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../bpf/prog_tests/icmp_send_kfunc.c          | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/t=
ools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> index bb532aa0d158..ffaf0fe1880b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> @@ -169,6 +169,29 @@ static void run_icmp_test(struct icmp_send *skel, in=
t af, const char *ip,
>  	}
>  }
>
> +static void run_icmp_no_route_test(struct icmp_send *skel)
> +{
> +	struct ipv4_packet pkt =3D pkt_v4;
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		.data_in =3D &pkt,
> +		.data_size_in =3D sizeof(pkt),
> +	);
> +	int err;
> +
> +	pkt.iph.version =3D 4;
> +	pkt.iph.daddr =3D inet_addr("127.0.0.1");
> +	pkt.tcp.dest =3D htons(80);
> +	skel->bss->server_port =3D 80;
> +	skel->bss->unreach_type =3D ICMP_DEST_UNREACH;
> +	skel->bss->unreach_code =3D ICMP_HOST_UNREACH;
> +	skel->data->kfunc_ret =3D KFUNC_RET_UNSET;
> +
> +	err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.egress), &op=
ts);
> +	if (!ASSERT_OK(err, "test_run"))
> +		return;
> +	ASSERT_EQ(skel->data->kfunc_ret, -ENETUNREACH, "kfunc_ret_no_route");
> +}
> +
>  void test_icmp_send_unreach_cgroup(void)
>  {
>  	struct icmp_send *skel;
> @@ -193,6 +216,9 @@ void test_icmp_send_unreach_cgroup(void)
>  	if (test__start_subtest("ipv6"))
>  		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);
>
> +	if (test__start_subtest("no_route"))
> +		run_icmp_no_route_test(skel);
> +
>  cleanup:
>  	icmp_send__destroy(skel);
>  	if (cgroup_fd >=3D 0)
> --
> 2.34.1

