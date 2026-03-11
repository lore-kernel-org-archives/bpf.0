Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED2312825
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218661; cv=none; b=swjjCEQfmkUH1VU4Uw3Z9bx1Zx71ZHO/PGQKQcSl4z4PM6Vm+Dpg6Y5Rng7SC6ZZMZAPYpllcc3lAs0PZeu6sqNd74nGr0KX8hN6qOJC0Bxg2VTl+HlXC7q9ZMK52as0STg1uHJ5D89UhFV13UQl/PeYqBj4It+WFFI82Jn6ttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218661; c=relaxed/simple;
	bh=Imjp1fxzvFdfmkh1WVAbM18uVmKE1yiH3pmg83B4nQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFJ4JllXifCnmzCbFc/ukYhsJ40J71mo2ITZlGqzc6YwmxqyIcSrCBPLVxZYpBFW0qgFKQP9cjNeScb3ao3EEhh9vDwZU2mWt2VG7KlihI0bufzrXbggS1s5zUimSGCFTCcCgwunt6gl4sb4PWbVkV7WKyPnTQ5aO/j6tNYZuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XDk3i07k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RN36wmQ0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XDk3i07k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RN36wmQ0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B3VDND614061
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 08:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EqiFk0X3+BAunLh8qic9ybUFgfcvYe5yryI0mSRxLWM=; b=XDk3i07k5AbMgZEE
	GPfzdLbnekR62LdXCUL2wbKO4dJuHBf5HvtlfhVS8gTAMhBWv2G6zp3ww7bY7cvk
	sflliOaL3Vab4D4/NIMSDO1xwwiINd5liCB2ewkeczDYaLxG31LqZW/ER/yrGd4E
	Y2avzBH9FkCKhqn5+qljEzCZ/UNcPCgizEfjtVlQpRLwEJQfm6FKXtM5SeNmhaLN
	q18X+nzPVATsnsGr8QwGTVLO1+ncxpCP/pPLvTK9NXP/Qe8xD8UZcM3ZM6J6QmHP
	nrG68etSME5UCppqhYxYYeR5HJ0y3siqmYNKyTLhDvP5cW+yP/aZt/ara6HDhADI
	UQ0ntQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu0jf106m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 08:44:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd81c571a5so1742395185a.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 01:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773218659; x=1773823459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqiFk0X3+BAunLh8qic9ybUFgfcvYe5yryI0mSRxLWM=;
        b=RN36wmQ0Xbe0ODFQEBx4IUNbl3KSsj3F2FdqFFiEQgtmleuVEzudFWAIqKO4KpZPZm
         yQwy7oz6K9Q3lBBu/PC8NIGATFRhXL2Xb9EPAo2q+U4LlIPxG72DWEQcFA+CQZY29YpH
         vwlvXAo86Acw7qW1EintpCJcEHPxGY8jpzisISCqdPdqXfUsoM0+jMnm97eWzPIo58Jj
         2ejAxN7yejLAAiqH5lLNtEzwhje0QhWmZ3Hf6alMxvHOGg7f7RZdNIuPA6+wGQBKfV4I
         wb6ImTlLpuqQFXoxsfLkvZxMXedYApYqRqTP7GGEL0E9VVIIHZ2DShPWgcFfm+Mof6q9
         KyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218659; x=1773823459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqiFk0X3+BAunLh8qic9ybUFgfcvYe5yryI0mSRxLWM=;
        b=BcmB6aiUuMIWs6VutEuo7Ts6j01EQBhcSE5SrMwyjk16ORHN389jIBLbqIrxKoJddi
         HWwZSRO5Ilr0t4gkEdooTI39+YVzZDpv21RlSXqj4T9gjBF/nZbMrIkvzvkZiULt192k
         dJA3IPxQS3u5hy7hyLbXcp3xQLHbaRJSYHl4oDgiQau76pwhjjIPjTHU93//kOw13/Rf
         C20hG4pkGXwWCeIWRTyUV2Dc2y1YME+3Hs25QMOCvIsEuXsDeS/3pAmmOSlIqUMvreq2
         prNycD3JBaQr33ThY/n6ZracG+pVnRFcZ3zx17n3HloFKGfb+zfxPu4mZDa/daX8mTVb
         SSVg==
X-Forwarded-Encrypted: i=1; AJvYcCX6L8xG6Jl19xYAP/RrLqilPN8xlCB3Yq+gBVUqiLX7Hstn5RdFbZuYuHVT28RdqMnvSb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMQMF/7yhVw1GmErs+3U1BiI8AUfLEAFzOCuBaWl9W8Xpp2B0G
	+6QruqbiMApLrbTCwU9NLHZ1PRi33pFGnAL5nMLzGWhb4bv6gHcNJfwh0+VGoEahiCW3UeJC4AX
	a/aaSQ53bFwPJTclx6U5NQVUtP/KZlTerx9De9FMdPprxuL9N6VXXPIY=
X-Gm-Gg: ATEYQzzxzEsoDN1mSLpESMuetSrFkR2ZS6sCoGgLKvTkL+TJIEzBOHtx/goPbuMq4hb
	z7+kjDbWO5JjTPQ04rCAAr+q0d2o7JhmsYY+v/auWKC0pFDv3X9sQvO9i6jkqdd3j0B3k0qCuo1
	lGtwDhyC+3q8JcfcY2vuyl4S65QkzyvJpc7NnancOLBp/jaBul+pUWxE+mlHR98y5/yDx5jlPZf
	pvSbq6t/E3DzoA5x3hENLqi3fzp8UXHCjYcJQSSztphlcC5uhae7K+Lc3ytRqLY15zL0H/kyFKR
	7ZHm8Bd+M0nfD7gWkl9421KFynBh9XWP7HFFQ2k58h8rBi2InWzDMlmaw2Xe0jQvSEl8gYd3V3N
	mwJCQQMrFTK2TFcw4oQKCH11tLpI8lnjhGKhZuqqyMtZ2aV/tnhht6CUKKJhXFUD7v4AqhKHWS2
	hphEDlueB/
X-Received: by 2002:a05:620a:294b:b0:8b2:74e5:b36 with SMTP id af79cd13be357-8cda1a58338mr222191885a.68.1773218659241;
        Wed, 11 Mar 2026 01:44:19 -0700 (PDT)
X-Received: by 2002:a05:620a:294b:b0:8b2:74e5:b36 with SMTP id af79cd13be357-8cda1a58338mr222183885a.68.1773218658603;
        Wed, 11 Mar 2026 01:44:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f818d5eesm5866352f8f.1.2026.03.11.01.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 01:44:17 -0700 (PDT)
Message-ID: <6707888c-a31a-4d38-a99a-86ae42351561@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 09:44:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/30] tools build: Append -fzero-init-padding-bits=all
 option
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
        linux-perf-users@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vQL1Hs5jPJtP2JhRmwicrbn4yohOEjGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA3MyBTYWx0ZWRfX/k7zUbVBoe3t
 RaG9Kq+dNBrPOSZRu532s7IGLdC5EdlHRKeTbq/UdKzCNsP2C+tykSz+T8bK1w5wAh7Bosw5i5l
 hnqGzknB4dJFVH5f1piISdrx++43e7k8CsNfvpylCNG0kOWiPJRSEsepX9dwQw5TRdfLTomcjp/
 a/f0Tlc9OJqjNRa4xBzM/UN+Tfc6rXsT5+qGNAP3F6WCtdJ61gmc4CZCwHlTL8gaVG4bZxmER9X
 aaKk/mD00yAitjlVPJeZlMjbKkr8hnvcOWhyI1pCKPNIEM5RP1bnYxEUC1WyY1U1FrDcIOWMI2t
 aI0Zrz1K10KUrBEXWF+C4Aa9YI9adldar9C0P/IYofW0XE0o7msNIHLmC2doHV6HeyX9Z5UKOKY
 eRljD5QYP4PgRgLpHoxmF+AXUx2PsCEcB9lbq8o0s3VQkieyOqBX54/Io4UwH2n9ID7EXEGfpx3
 0Ek0cB+E8gYp8+IZ2xA==
X-Authority-Analysis: v=2.4 cv=FMMWBuos c=1 sm=1 tr=0 ts=69b12b64 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=fUoFdtiNKAmboDELQeUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: vQL1Hs5jPJtP2JhRmwicrbn4yohOEjGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110073


Hi Leo,

On 3/11/26 09:29, Leo Yan wrote:
> Thank you for reviewing v3 and I appreciate much Ian's suggestions, most
> of which have been adopted into this series.
> 
> For anyone new to the series, the reason for appending this compiler
> option is described in v3 (see "Link to v3" below).
> 
> In this version, the changes are organized into three parts:
> 
>    Patches 01 – 07: Preparation before adding the new compiler option.
>                     Fix typos, adjust Makefiles to ensure the newly
>                     introduced option does not cause regressions.
>    Patch 08:        Propagate -fzero-init-padding-bits=all to
>                     EXTRA_CFLAGS and HOST_EXTRACFLAGS for the
>                     CC and HOSTCC compilers, respectively.
>    Patches 09 – 30: Apply EXTRA_CFLAGS and HOST_EXTRACFLAGS in
>                     project Makefiles.
> 
Through which tree do you expect these patch to be picked up ? Each 
maintainer picks the patches related to their subsystem ?
