Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608C1392806
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661865; cv=none; b=QMEQ/1o6ut4EkKSjAjKRIfhXRnfUMAJULhz/2rv1NiO3TMCNiV1awlLxleaadSgsTNwsFruU4rQXM3CHa7Ug+VtxMesrKQ2ttKWCtGu2NQm1WbKjzwCWGzDNCqwo5yKCThQX5IJPBJpfGgShFM8a980Yw+dQgGbRoHpE5Q6e1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661865; c=relaxed/simple;
	bh=qajJOJLw9mBKXM/E3+A51MHsuJgG4aC81Z0RI5fTgEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcJ2Pv/b1OSpSB1ZH8zMfurfPT+1SmV16E/3rJU+xVfNx+IabYXFIn2LL80VeHT2cg0Vwi5pCCEbkrU4WYkLtIXwprH5uXakL6B4m9usK7Lj/mkIup4zL1FoEdwFPo8/k8YC+adYOTR8/rkVtdVk97//h1Y3hoCcz0KyUeqqmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ojJzDsWN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dnBugXEN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ojJzDsWN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dnBugXEN"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBhsZ4323839
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qunPmJdABJcMXtrTkw0tgSEaTgsE7szyRj+/D/lI0Nk=; b=ojJzDsWNfjCQlG+b
	VxYlZjBAVLSeZCHiG4pmkK71Flhmt+ZrHnldp7v0YaLF7XkcVedMQxvFMAiyN79/
	/4TvNGS/J+5ix6BkUiTiXquQ0tLHhujkdJkbA73eeIyniWCE9uUQIVEFS/0GEPP8
	q668pYC6r4HN58sH1YKslxOB+MKerr4cHKe4RFYc9xGchoe3r85b4Xd5nEpiV/fU
	y2cy00oI0nPtmtAhjlana8tNoA6w7aZ4d1Nm3B62NS9yLeIHczsCFp7lUpAPfYOA
	TPt1AGMTUGSYAJRsiejp1D1TvQ7yRZW9caLbeBzy/k7boBHE6Pa/F8sh5LP1tvfi
	AiZQ5w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03qnqhd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:51:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd81be6f05so2807650185a.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 04:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773661860; x=1774266660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qunPmJdABJcMXtrTkw0tgSEaTgsE7szyRj+/D/lI0Nk=;
        b=dnBugXENY2Dk2Gr1xJ496hXdeFA+/UrPz7kEO27XzLc4sm3W6dyUny6uNBzNY9p9bO
         NUVEmf6BtuG01Y5Xo1nEL5Sb74ux19y53e39Ypfvi3OrVayv7LSDVhvSf3neIPUCOiwH
         D/J17KXyWoo9EdjjBGSZ+uubFIMHJjF62sbcuOC8Q34SxYzkALKdOIdMOFCzpbkZlI20
         Iltx6arimaw77BzEg4o4EHeZascj0zv5qGyf087+tj637jzW1EwSkFdeoKpsdRSzNLuH
         jeQo+gnCWl0cVV5OxkONAg5vV7HmoXIC3MrB6CwGvS469KbKawLMUrwedV1zWsyG4kOS
         mBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773661860; x=1774266660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qunPmJdABJcMXtrTkw0tgSEaTgsE7szyRj+/D/lI0Nk=;
        b=GTohbXDdgEFcbowj25fcGIWudTRxgtMmhZCU0WXwNyLl0F90YdwHxGUGRr8suAdv61
         LrgwieqkH/xLYqeCBuzsT9p/ACn8NQtLbL8IUPB+fC/nqNAM816R6e8l2V4rI5sqP4BH
         Su5CWWrvOQqFcsXd+Ptnisf9A8HDXL4WsWoJseHTMaEWNBPKNkora/XFdFZ1J44Yk8cZ
         ib4vIPs3bqS9fZl7Z7pgEht10bdAxPLNoiXaAp/Z2OXYtfc1ahfgAOeXFqJow3uu5cWJ
         UdHOQdm+3I3sqINdF19kdb3XaHDBon4Drs2XXkMUFAKkMYXo4EtrM6f+qmOZCczDnaQm
         vZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSmMTX/NNm7ym/R62J5n4xqZxW9tt8/9dlFFoI3J0CSiYPV5oXC+fiAPOihHsUIL0tQmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qIor6cKx0BDxyLnu/t+OrYCanyUoMRMLjaMvKKus3jlS4lWU
	GYcWBChTp6bufMm3h35LxuQSFdSdahlIMbLlUupPXtjHC6wkpiAuF4lKr//mT4ZuKxlfsHD7aLg
	1C/Qn7Kqct9Fsd+L/1LoI24N9/VKIU/ySVt5AwhuYl8WAwSThJCWsETo=
X-Gm-Gg: ATEYQzxHTKiRAArYFTPBz0t29tyj6ti/z/iUJJYsgTABBF2Fc3CB7nREIOawdHzHuc3
	LuhACrrUtyrJ3XVnVHT8hzURrZv8UZaohbO+ANjv7soad4sl8pnoxh/Strcn/NUWy2Ype/6Hr5O
	xU/fCCfWJ4DXiDTRUH084ZgSB0fKB6ZhNCwPhYpQ+oEW9uGGhpDbeHqRL5f+wwwnEcYhY/XHIzl
	0yyIeVE4yXQ6uCmBqdttNWU1YanbgGERMmchp/jbLlVOJh3IV2C5jC9R/I7qhYeMxdNIvcAyYRy
	dlArCoy4eUCM2WZDrM/jLSEntbrntGnvIz4odIcqHLSonh0SA4j7ciTaBhCnRZ0+MfDPXYltPZH
	h10Zq04pS2OTR6CmBb3wywr6FsjVkARPwT8ue146iQL32SQxWvtS4DWU7PRbBTsodCMV4DjsX98
	Hg9nHUScUb
X-Received: by 2002:a05:620a:2916:b0:8be:6733:92ab with SMTP id af79cd13be357-8cdb57a672dmr1626228385a.0.1773661859776;
        Mon, 16 Mar 2026 04:50:59 -0700 (PDT)
X-Received: by 2002:a05:620a:2916:b0:8be:6733:92ab with SMTP id af79cd13be357-8cdb57a672dmr1626224385a.0.1773661859231;
        Mon, 16 Mar 2026 04:50:59 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5dfc:3995:22ce:d286? ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485696a12d0sm23785665e9.13.2026.03.16.04.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:50:58 -0700 (PDT)
Message-ID: <e6c0df77-98e3-4a34-be84-6b43ec263215@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 12:50:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/30] tools: lib: thermal: Fix typo
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
 <20260311-tools_build_fix_zero_init-v4-1-9e35bdb99cb3@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-1-9e35bdb99cb3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: A3JMImtb0epxWD6UWG7H-f9Gb1chbn_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MCBTYWx0ZWRfX2EugYSl0pXR6
 Xw4pqF8hqLo932cXws3sd+XuRVx4FLfYrfFdPW1lj+TV5gGjbVBRjsQJkNMnKkw7CNxClQrTl9t
 rHk1+bscPA7v/AcVWPGFGyBJvG875LSyXLnoC36Riz7IaIcTVDtVaPGuLqEcS3dzc6pBl6/+qAm
 vrl/+ivrhgbBOY48OKendA20gjNx09xn/yyjfyAyuaIJSzYaKjynbLd2sHazCXngvxpkpySOSAD
 ds3b6n9sq8pFSG/CZNEJPUFFZAlYNwkKtzytYFzOnDjx0fBrs3P9z7SMZw5esXz5d/KrjN4lBDL
 ZA+LA8kzlG07x2+fHGekK5hcfXH3cGjDaDICFzRyb4cV4cV566oc9y4S6YqUoj8oe1NE+KJE5CN
 JTrrK1QC2pN8/Q1SFdE/UnXpvOP8nHUvEnhdiU1A6vIOk1G+ZDLqDFMpcCDGk5c2UTbISuD3gQM
 V+Bb8YHs71k+Af8zlkw==
X-Proofpoint-ORIG-GUID: A3JMImtb0epxWD6UWG7H-f9Gb1chbn_U
X-Authority-Analysis: v=2.4 cv=ZbQQ98VA c=1 sm=1 tr=0 ts=69b7eea4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=Qrd8ctaAbqGiTqi1YC0A:9 a=QEXdDO2ut3YA:10 a=u2kJyrKl4JkA:10
 a=0lgtpPvCYYIA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160090

On 3/11/26 09:29, Leo Yan wrote:
> s/CFGLAS/CFLAGS
> 
> Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@kernel.org>

Thanks !

