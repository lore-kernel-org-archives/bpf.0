Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A783939A3
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661895; cv=none; b=mZKIYhsa1isS0jyobBzAFtZJmJHsmgmZbOGFCT6H1sQdZ12OzWk908lNwxGkqd5s3JkZe9uRvF4HqFFnr1UQ+DXlvLI381Y6t03UwgplnFtP1t25XDqrgsMVAYt3U6l4YAZPiAXfV7SP97ZW99TCZrsmgBOmiTNH74rqj5tIEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661895; c=relaxed/simple;
	bh=wMfcOM1E8NveOMqBTy2g6Kl0T5mgMJ6P36Bxrnzupx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGRpl7Y1gST3rkJ2VYlOPyaUVG9cgBZSxcZAx7REGD0T7k8tHfpOG1QD3eDeSMQDLoOFkO1TwVOeI/LmNdtxjcfOnNRtIkbY2lPuMCrH/rgwrkPbhVeyf8DiTxiX1shS2vCGNMeXlRstcy05Eu44A1LqWczqie2D/bpSSsopqms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jn5C4KsD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JBvK2FwV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jn5C4KsD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JBvK2FwV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBjjA91428813
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+ZXaHmFaCXo06Z77INsskRFP9ADKCiNWDgJzdazMXTg=; b=jn5C4KsD9OFzgWxR
	MrdUrbYqFnKXwZzWsOVEVJE2t4JS6NeWON/rsCmqtYcpQQHVPYv11tJWf8J5zN+f
	gWdtYyyxmnjQyljVOuqDhD1ivVpREbikOcLyAOF+dZh6zVYB9NqV8rFeiU88+dw1
	aA1QJYxz+RGOoeMvzffqhiFsi0X4/gK2W4DGa+aEi2Othp6vJIbkQoblbxd6WJZe
	1sIzibrRG1FqL6x6tGR6rauFQ4ZuQlWd9VqnJZSzpgykRRq7SMDUg51COHArf59g
	Xm3xmtxPWLcoVU9MS/4/i2tucosBqVchnPJ7K/RcXhAOhArRWZh+/5lD8/3kgBqt
	JVjaMw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxh9981h1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:51:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb6291d95aso5135532985a.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 04:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773661891; x=1774266691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZXaHmFaCXo06Z77INsskRFP9ADKCiNWDgJzdazMXTg=;
        b=JBvK2FwVgUdI8j1gSxDCRbIgKj5WR8FoY/V3lfW5iNeUfjLz6dedukEvqIc1EevzB9
         7K7KlnIqReXCfDMiY2rCbepBc+Q1frzXTZH8+PQ/HZ3csP2crqMm1ev1pK9FkIpeuPly
         MMEGP+SrL3ye7vzQB9WnxUmUGtdpn8X1VVdQBFp0yeIrzNe/m6rrrxMVmQRj9Lu0qbSI
         TkzkK08lQm8VVmFW4cZr8CfkSuvLl9pcFFKOd4Un8KZBXw57qEKIvCKE8QOQofrblX9E
         AFwFUrOvx9MXGRF+pAZbYk73xwS9gjO4fMLs+z/qgbOoZCafvYPKuy+nr1T6G2fdqdRQ
         UsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773661891; x=1774266691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZXaHmFaCXo06Z77INsskRFP9ADKCiNWDgJzdazMXTg=;
        b=XPvxYHbY2s9XcIXma4gepCuge1LBP8FzqdOiWkQ+f5/70d0sDdAUJD0VR5/0A37pVZ
         f34MoYd82m0Mn/9PP9uI5K4Yn8oLjHLJ1PV9HUqNxmQDltqooU44svEM4nFhByTSXYn6
         DbtD5RZhu/GHMUCQjLI3IMtfP6w1jzs4sGQ4JDMgPmivT6suLp++PMRd2ufvISOhMfxI
         qvRz1LaToDV1wrQyYumrDlJY6PoL+FTj4REUq44rqeuwnJ+y8JpnY9O/mf+SXpUa0tXb
         nOAxZkAWoWUINL6oqOj8/bQ/TNuZM0IigcqUGn4+T+N7I4uNVDqvPnJmPn2ROgtyj5bV
         z+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUorXwbQ+kct7f6TPLFr8W05B9j0X1nLjD0Ocs7S1E+lFBg7al5ojlyseGBf+zn/h8/phQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwalloL+8sdXoENcYo0gLa69qkBj8ZnJFV32JuS+ti9NwYT1ewI
	2X8FEn0i67qoGQ6eJItfaa8A4FwqTFtnjD1ROnaT0IXdJF5G1erviG97XKWxE2rdScV/WXmYy5t
	WeByPrP65TEIf9oqQaPUmk1ylSx5KSiLR4q4c3hhcEd25Fqv4EaGBK54=
X-Gm-Gg: ATEYQzyoEXZ2/m0ikWqcJVaYWRPyTNP27TLb1OPWIuz9OoGsWdxwr3Yjssj1M68/LJK
	CjfqbXmljzkVCTqBeg+270IEEDBQjP7yrTsh+vdjn/tfo80Y8T9etO82tvN4/Hic2BGdKfwfyyf
	68O315RPNymQ9md+lG0FPH2hlV1LfPw+heuTGi2OoOLaVx04sjUiDKi1BLh59HrhHJbyT+Uox53
	IB+PwVe4zwSW7hr5LseRpiTwi89epmUXmRD/4bSyeIu8NNA9iCCdvvmNR8y1lnkS0VhkkrwtU6P
	ZEekh3S3hSxqKS8B1/rCNcwpIpt2YGF9UY2AxkcUM364zjwOws4fMc0G1qXqjSkW+ecbTb9IcIZ
	znOEVRW408rHa2Jd4d+AKRAWJd4qcgFOhQdqYRhQIEDcNzoKDxgHqBdRWAaeZrCrJOoa+YdkTyX
	IZBVbExjIU
X-Received: by 2002:a05:620a:468c:b0:8cb:4d64:e993 with SMTP id af79cd13be357-8cdb5a964famr1517110585a.26.1773661890682;
        Mon, 16 Mar 2026 04:51:30 -0700 (PDT)
X-Received: by 2002:a05:620a:468c:b0:8cb:4d64:e993 with SMTP id af79cd13be357-8cdb5a964famr1517101585a.26.1773661890086;
        Mon, 16 Mar 2026 04:51:30 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5dfc:3995:22ce:d286? ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3a09e453sm19896229f8f.0.2026.03.16.04.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:51:29 -0700 (PDT)
Message-ID: <9de4e5fb-3ce9-4b3c-aa51-f7e09ac5b3e3@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 12:51:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/30] tools/thermal: Fix typo
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
        Quentin Monnet <qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nsc@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        William Breathitt Gray <wbg@kernel.org>,
        Barry Song <baohua@kernel.org>, Qinxin Xia <xiaqinxin@huawei.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Kent Gibson <warthog618@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton
 <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
        Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
 <20260311-tools_build_fix_zero_init-v4-2-9e35bdb99cb3@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-2-9e35bdb99cb3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RJ++3oi+ c=1 sm=1 tr=0 ts=69b7eec3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=9qkRzJ4zGrA7FPkgJCsA:9 a=QEXdDO2ut3YA:10 a=u2kJyrKl4JkA:10
 a=0lgtpPvCYYIA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MCBTYWx0ZWRfX2Tt32aETg73i
 FbPcIWltuZzVlP2BWDevpJ3cD0laUt1Ak4LFSEQvoFhryfTERldsSiPKzijDcsK5kbNo/whcjyC
 yjtTI7CHYXA7qIIN2r7jdxrLx5Itx9bKy6fuIy+a/z+nCxKFp89S0DW/iovfGctxdF7oFeQujaU
 FoX9jYs8/HtYSJT2+g8ipzEuiFRfEUE9XjEfj6KKapURz3f+7a6HUEisCXVhz9/TYCgCklQVgl+
 CX4RYfCj0zTZCyfircB54S81zl+8GdkNHwgOSny6PX5EmA/9e9lm3P9LvYplwvePbIpkoR23xU5
 WyHDUrUE7cg47J60jejqkRqpvtPtg3UFmBaCL8VfdNh5jSKBbj5PSPOZ6VViEeVEgOGIF1E5JiA
 5WR8Z5rfaiJ1NEm43QII9i4RM1zv8aYSOcXcIkGRwijJrFtTXJ8TA1jTuutLmExz62I6Of7n9A4
 V45Pmdh5qWse9YE6P9A==
X-Proofpoint-ORIG-GUID: Yeq4oeQBBkxygfsr-4vPBqMGQ-ya7aYh
X-Proofpoint-GUID: Yeq4oeQBBkxygfsr-4vPBqMGQ-ya7aYh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160090

On 3/11/26 09:29, Leo Yan wrote:
> s/CFGLAS/CFLAGS
> 
> Fixes: 3b7c5e8adf9c ("tools/thermal: Add util library")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@kernel.org>

Thanks !
