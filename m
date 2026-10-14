Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE0F47DD50
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965112; cv=none; b=TYuYJzlpsS/iZPrilfdaskhZ2crOqq6ibOonmyN+69lj4ESYDnCdU2rOhHKFAKD9lvKPu7Ar4Bc/JiNptBfNRCaqKi5unMfqZiT5nLj59abjBp+1CBBw3geqB44X1DgF/V29Df9Ewy0aAr/dOc+51lWonb3XRypW8ONJDydzMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965112; c=relaxed/simple;
	bh=I37h8tli3u2cUswjNi8bGkFErCKEFwbjTdiH8F64x4Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=nas06GVrXvwiFmp3m3hw0dOIqV4G065nBfNYmzBT7YHqAboZyZFiqpicnlOK/tAhCMf7YfoVL1uBPGchZ6HRIbnw6+79udzWSjUcIfWainruh7lsz17l0h/6iN4/55mspiXa6OA07f1IPKYSqEIhqB8BZCoYbF8OaVWBEoKLrBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DsNz3MYU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DsNz3MYU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EBE9D4E41224;
	Wed, 14 Oct 2026 08:05:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B65A660368;
	Wed, 14 Oct 2026 08:05:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 987BD1032852B;
	Wed, 14 Oct 2026 10:05:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791965107; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=q9eklIDiJSWQCPdkn0nXsZc5X/aS57OChnWV3Hi6Tjo=;
	b=DsNz3MYUacZKjDJ0RiSUgChGjReJvGGkEL6wjrhrs7WipFL+eJq1QfIrngnQHKlovAUaD2
	ZpFdhhwHt3No6J7WbaVQEf5/sEmOHSILYcM6H9Gr74BT9CIjIpADYGudnU1sVSiUZXUKcx
	wF50RH1FhGKnQ5ZCX7RENJN6JNTD33Y5jv5l425gN9adF1f/4hut0ikA1nd7hGqw94U4Nu
	CecnWHZigTRKGxHYmUIb8ijE56HspQ6zGw5KyZX/BPIBvkhlMbEmc8mSDYNU/A+TBVuHQE
	6TeoZHZhc4ob4vORYUJ8JQwpd8Zu2Lb6BGEWGdXoJFNvwm6GcWPfpg6meYz2OA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 10:05:03 +0200
Message-Id: <DM4EM3OM2GQ8.3IWQMARN78YRV@bootlin.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Use its own netns in
 flow_dissector_skb_less_direct_attach
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Qiliang Yuan" <odys.yuan@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261008-selftests-bpf-flow-dissector-netns-v1-1-5d9889aaad84@gmail.com>
In-Reply-To: <20261008-selftests-bpf-flow-dissector-netns-v1-1-5d9889aaad84@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Oct 8, 2026 at 4:02 PM CEST, Qiliang Yuan wrote:
> test_flow_dissector_skb_less_direct_attach() and
> test_flow_dissector_skb_less_indirect_attach() each create a netns to run
> in, and test_progs may run the two at the same time.
>
> Both name their netns flow_dissector_skb_less_indirect_attach_ns. When
> the two tests overlap, one of them fails to create or open the netns, or
> loses it to the cleanup of the other one.
>
> Name the netns of the direct attach test after that test.
>
> Fixes: 2b044dd186f0 ("selftests/bpf: re-split main function into dedicate=
d tests")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Indeed, faulty copy-paste when the original test has been split, thanks
for the fix.

Reviewed-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.=
com>

> ---
>  tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/to=
ols/testing/selftests/bpf/prog_tests/flow_dissector.c
> index fb48926814647..f6fefb14cda3c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> @@ -706,7 +706,7 @@ void test_flow_dissector_skb_less_direct_attach(void)
>  	struct bpf_flow *skel;
>  	struct netns_obj *ns;
> =20
> -	ns =3D netns_new("flow_dissector_skb_less_indirect_attach_ns", true);
> +	ns =3D netns_new("flow_dissector_skb_less_direct_attach_ns", true);
>  	if (!ASSERT_OK_PTR(ns, "create and open netns"))
>  		return;
> =20
>
> ---
> base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
> change-id: 20261008-selftests-bpf-flow-dissector-netns-c347cf31e5f1
>
> Best regards,





--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

