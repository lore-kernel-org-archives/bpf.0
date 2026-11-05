Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793911482;
	b=T4Cyfl0tTtH9AQIZ5LTP4q5eklPbjE9fN/yr3zjnXtjiiKNyOz+yh1DFeCGhyqEWRycD
	 vpkHgAfCcdkGC+5ptCpJ62XiHqqYxQcVMjJzUgkxfyFWZ8/OiCUFkCllQCWDfxFmikO+D
	 8CiX1l5McqI5DjjfBBpAmqXdgZYxor0aGBmFAKPzaJYzRv0xGSX/cAGqmhmtKMgIkLV5l
	 1pBeuRwjd3K2OeOatN0apBT3opWpFThKHXYQYBRjVrnO7UQO0gzMXenFn3oeKV92mGmC2
	 HU1TW6SBc3l/ZHwNUYNvqkKz3mR9QlSgi/32rkMbDvb+/xIP6ZL/FI9z/8g5cKGPlsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911482;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ao5vTyt0f88nNNdXkQb9TlB4+Hnk+6IPL5xnEoHdaVM=;
	b=NZPeuhCw0ka7efpZ3MXFmBqDTKA/P5B5nGlZy6oTIrXYLMgpQKWSATRimI7SkVlMooZj
	 421zDwbHSFiTEmno35a1OUcmFCFRrtctL6f9+iwIhD5hpjG/O6UGeichd1ejBv3wF2G8P
	 JMPVzf+61ss2cOs3VCSL4h9iuZrJ3hsFsG49ZFqt6Ig5B6B1JfBJLbQTl0iN1XcA2dUiV
	 hCgGQaAr/2eqDqE4EelQ8sZKjPtVt2GBMDcPWZKA01GCAOEJ/yANOavfe0BXy91tGSwPk
	 cwZP1Ukuk7GH4u/8iw4kR7sWLfpk7wyEVlUU6LXWlwdLSdmzbGAD74a2UBBWgvhQplg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=BJ6Vc4Bn;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=BG038r1d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE9C606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BE9C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=BJ6Vc4Bn;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=BG038r1d
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5KNa8l3713451
	for <bpf@vger.kernel.org>; Thu, 5 Nov 2026 20:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=ao5vTyt0f88nNNdXkQb9TlB4+Hnk+6IPL5xnEoHdaVM=; b=BJ6V
	c4BntNkjkkda/UZwOgHQybgHbKBTf70duMytHISYD8fZlPFOC7pQ3KtB2H49YY2j
	fA/Xq2vBz9pOEeGea+zUbDowvp595UQSG6MbSz2v/xM17+TQvdbo7pBRazaUJiJF
	xbhLrxm25HQLAewoZEMRYxNz7Ir9g9dh1kKNDAImZI5bBoTGwpAnxLMwyvdr7hM0
	Y1LqB5zisPwRkA1q0WkIIIgb6NSy/ZceUacOrW9yP8GnRvUoY95AedCtDVsnsjPJ
	1sZFqgFcxfwGr+44douE2DzuTzn0AR1M2BMzjUmmXhjrjrFI9rT0YRzd3VJ0jmdf
	JuXa6lwJwR+pJymZ5A==
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hrpuhjma2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 20:44:40 +0000 (GMT)
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c4048584447so64571466b.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:44:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793911479; cv=none;
        d=google.com; s=arc-20260327;
        b=M4+/Y7puHDqHbFU9nBwOA7v/MoIsnhLraqv/1A2TDqKhdYOCPJE4xj6r5vg+1N3v8d
         WGmzHMcNWbYFm85TUFVEGS9EvnLvXlwC+iOfCop/CuePTrlETEB+1c7Vnzh9I0R6ktUM
         ZRXhzZWJW9RtkEgZL+0ljMoBCbyICniaXDd/0lS+jGw4WGRpPI8pRRIwpW185H0B8q4R
         8PognXmFK3zzN9E1SFGUzUMvcoNfq16cJMWSewLGYrM+zvsM4hp/yYN4FamThNyDqfDS
         zdEIveQEiOzOpWB3jFyN51cM5tH5JK9Bpn0kh+ur/B4o3DPN19dV0RNHapZQWDgbPuNs
         DD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ao5vTyt0f88nNNdXkQb9TlB4+Hnk+6IPL5xnEoHdaVM=;
        fh=efe9WvP7deMCcBq37hjMAaFA0j3hSsc7OtSIhgm/RlE=;
        b=I8vaEZYwhheV6NYRX2/+ywEhYjZVs5ecfoP9/WbLDnk3cbUgx6qlfdRT8uRtq4J0iO
         3dOldPi1tL2bLHoRwuBH40347dksvGgUjgU5elcsN51LTvgxZmOCYqbHOyNDhChPlSag
         NZArRa5rCcaPsmCkXtl1+BKZyfweYr0pq2K2skaVaSf+/IGPj52WEj3WdwWCSN+0rxRP
         QlM5zQdyht69Ios96JEXjZDh5W9ZQ0d+li3d4BUqo/7VS6TMxTsuVszRJLlqyizrRlvF
         2EhpBbvU7+A+A0wQsV2+dvQE9mfueprekZIgixvgT/a5SoTnITgI9KUYU4u2bGBJqkMn
         +isA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1793911479; x=1794516279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ao5vTyt0f88nNNdXkQb9TlB4+Hnk+6IPL5xnEoHdaVM=;
        b=BG038r1dKbdbDwE9apXSFD1bmbsBgKa2kmPasGPXI569Vpb38f6s379Sd2whmzKLC3
         uALKWgsbCrDc7BwSbrY/4efKL8b1XwtzfUktWNGinx/dH5z3uDEm5g5iEdkWxDgaXILe
         rjhEj4QpHqA8mFDhLsr9h/RYrxo5ra17zCxxX1p8jrYMAyjoa+Z0Y1VKpTww2Ku0QCN4
         HMaWLL+0E+IaIJfoHGEaH8Q9KTIVrgKxXGt+4mY8/qEa8pZkFWiLFtx+sL+d+g6xwkU/
         UCTVr3pNl9inYrdCO8Oza+rFEzs54SLnuhzHhLSFKJufNeyA2WLENvLzRcmMvnYnw18K
         wFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911479; x=1794516279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ao5vTyt0f88nNNdXkQb9TlB4+Hnk+6IPL5xnEoHdaVM=;
        b=0w6bKClj8eIa6niwjU39k23EF3Hp/355cjSG//IKJUnXhnDgeZNw+SxDml/8r/ezT1
         d/3G7jCmqyzMfH5//8KgxUnNTCios84CapnXZNxu7ru9XIZ33EUdOZn5JeUJGyg/Vf1s
         Qq8/Yt5Pzh+W6e5KXwB0rcXhoQLNTrOlt1vYb7KyOS3gdZEEA2QDRXWaK6CcHgw5MvUg
         yf0qsLZMAufOfjHdf9UTaRJaXATyHLgjaTOIoz6hgnL/Osn4SJE0o26lceTmQtB5j8yC
         v9y1+ffLX8hrr6ECWCvd0CFnuTrSQ2K56kF/gYppLWshNFJ3FjFfpwxIOdC1kHMeP2q6
         2O0w==
X-Forwarded-Encrypted: i=1; AKwUvBzD3Y1zA6tAwnn1KqWw+H0CfXXYasOVEqkldGGH0osY4v7O6f+Xd9RRly3W5xUiG7Q5ntM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/p4nMmOMBygRVv0lkN6V4+qJfKkD7tJxXtgBlc8DKsRwFaOV9n
	A0kbd6XkEWeUogjT+eJ1FI/bUxpoodKf+1Xtrh7KR6eIq3IN9RlyDcRS5kzSjGsk8HOBPkv2urs
	Tit+ToBBc8bzaTmz0mnQnApTYd1nUArcMco1ULKLfImeDhd6aww8L778nEGjKAja1q7TQaYfSw7
	+Vr2KCfej7h63kZvWu6WELxq7/jcVP
X-Gm-Gg: AYBFou0NO+vW9ENS5EkKpIF5PDrVEcUFAnOplqTU6lrBrQEA3YtO79BtCcira2xdFJ4
	G8WVG8l5oFylKL6i/qsZ4UrOEM+WRXGP3vsuaTYKCoClk5LZIAM9Mb7Sl9vpCf9yhiZcfQS2ogw
	NCzHFr2GuKt4gXOanEy2be3h+faF4+c4FhwL9D7UGjNT0ovHMLFO/8A+sLEP4cILZFeTxXiLj87
	Z4jfJgwcRJZQo9lZ1FN+/VXUl1FkM5FXXrMtNHgZZ2v+f6d4oa/MMlBJvXBme0i686TfyhIwbPv
	Dg==
X-Received: by 2002:a17:907:3d4b:b0:c46:645f:ced7 with SMTP id a640c23a62f3a-c4d3550b4e7mr52050566b.39.1793911478962;
        Thu, 05 Nov 2026 12:44:38 -0800 (PST)
X-Received: by 2002:a17:907:3d4b:b0:c46:645f:ced7 with SMTP id
 a640c23a62f3a-c4d3550b4e7mr52049066b.39.1793911478527; Thu, 05 Nov 2026
 12:44:38 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
 <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com> <CAPnbwjrB_je6jXt3BGD-1q1yFs_wFd-Yh9KzixKzLK_X3Stuag@mail.gmail.com>
 <DML75890DWIX.EYB690LPBM1O@gmail.com> <CAPnbwjpv3bkGAKVjc7Eywgo-H4X6uDLYPJWFuSakGs_sBdgr3w@mail.gmail.com>
 <DMM2FJ2SNYYO.24TEJ05OOR08E@gmail.com> <CAH=2mMABxvf+GNr7vUKNkGvyU-gmaXKMGNJHg4URUCW_eyuxGg@mail.gmail.com>
 <20261105122604.GB1779021@noisy.programming.kicks-ass.net>
In-Reply-To: <20261105122604.GB1779021@noisy.programming.kicks-ass.net>
From: Martin Kelly <martin.kelly@crowdstrike.com>
Date: Thu, 5 Nov 2026 12:44:01 -0800
X-Gm-Features: AclHuK-QbtNDfOwcT6C7zf6IVXI9cH4b0FGauUAGbW7YvuxTYSfVQ8tmszmGMLk
Message-ID: <CAH=2mMBDMjex_oGm3Fj7F2P=kxgh79n7w4+hW7b1UsCCfx8V+w@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption
 cause false recursion drops in trampoline progs
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mike Bazov <mikeba@sentinelone.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
        Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX7okfXdHrJECz
 zZcnzShAUwyvd9k2hLhJKxN8xGi2AXFCexLXYbv+C63VniRw8hpBSMpVe55YGv26eEGlARxSxcV
 qYJCuK9HeIIMrNqv/o04UBccsnlxKkmOc2pIIcKprM2ncibzBmll
X-Proofpoint-GUID: G2tpPzVsZtXdku-qMgk072DGEKIOSZPP
X-Proofpoint-ORIG-GUID: G2tpPzVsZtXdku-qMgk072DGEKIOSZPP
X-Authority-Analysis: v=2.4 cv=Rc8FmFtv c=1 sm=1 tr=0 ts=6aeceab8 cx=c_pps
 a=D+UBI74RbQA8i2EYnbuvxw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=JfrnYn6hAAAA:8 a=3KWSPp3VrHgpKBhhfMwA:9
 a=QEXdDO2ut3YA:10 a=PsfoTyiJ_72bb7xyA04f:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX7nN7434dDK0F
 fjZGrmNVFlUQKtxAqT7zdBRn9qoG+NS37htpRQF759WJj/0hf1AQ84343yB5xsHZq8+215Wu1LM
 /pEbZ7aY5hCMk4IQCeDT6vfJyey7AisRTHaeFThrpUh3cszeR0054q5cVjotCEkaj3La7GiunvO
 i+r7yURgD0Y5vwg9QTmVQJh6aht0jABUYVcJbDRc9QiOFsn03Lf7wXUJcULbYufSNOkqJad7Igl
 /QqQfXZte+AtXOzcRNVs4fzuOwUDUcRAYA9rnEjJav2u6xp3JO9YXuwyEKwZPLQ9ykI7LIWSEXt
 Kvu47MPu8yj7BGzabBG72Z7G4wkVgn8eDAd+mk7e7SCgqO2PFZfgJkLJ8pmXjbw9nN/7/9N6FFj
 PRboJZ4uZfsfZmfQVJT3iBvadt1ItJUiHCnZj7Eb0nwWF5bZcaIYLQKvjHRainQMhhVttV371Hs
 qa+cCx3rZygtGaKcEiQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050082

On Thu, Nov 5, 2026 at 4:26=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
> This seems weird; your task-B bpf prog would never run due to the
> prog_active thing.

Sorry, I misspoke a bit. The issue we hit was a per-CPU array shared
across different programs. Since prog->active is per program, this
wasn't safe once programs were preempted.

> You've not mentioned your CONFIG_HZ setting? Anyway, something daft like
> the below would make promotion less aggressive (also, clearly I couldn't
> come up with a decent name for the intermediate step :-).

The 7.1.5 system we tested had the below settings. The 7.0.9 system was
the same other than CONFIG_HRTIMER_REARM_DEFERRED.
CONFIG_HRTIMER_REARM_DEFERRED=3Dy
CONFIG_PREEMPT_LAZY=3Dy
CONFIG_PREEMPT_DYNAMIC=3Dy
CONFIG_PREEMPT_RCU=3Dy
CONFIG_HZ_1000=3Dy
CONFIG_HZ=3D1000
CONFIG_SCHED_HRTICK=3Dy

The 7.1.5 system also had these:
$ cat /sys/kernel/debug/sched/preempt
full (lazy)
$ grep -oE '(NO_)?HRTICK(_DL)?' /sys/kernel/debug/sched/features
HRTICK
HRTICK_DL

> I would strongly prefer all BPF programs that attach to known
> preemptible sites to use a per-task recursion counter or something of
> that sort.

I agree; it seems to me with per-task + per-prog tracking, we could have
arbitrary preemption without recursion_misses. The question is how to
implement this efficiently.

> ---
> diff --git a/include/asm-generic/thread_info_tif.h b/include/asm-generic/=
thread_info_tif.h
[...]

We will test this with and without HRTICK on and let you know what it
does to the miss rates.

Thanks,
Martin
