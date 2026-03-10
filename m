Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F363E6DE0
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144044; cv=none; b=K4JHDq2fuyTFOA27ocETmg9lM8+jEb+JA9Q5cROxv5PvpkmHXgP88uEGnP3WOmNi9H2Xx9e4p2PHW5O9tTcDJGHbBXCEg09pAJ5FYePTIxn9LN+W9KJBNqRQssG0H73SuSoeP5DjJZQpK6RFLGP2IacX6imoNikqbqjrO07HUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144044; c=relaxed/simple;
	bh=D9iZSNFVB24G3xKDmALq4i98bet+bBZhXWdzP2XCqFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMh4KDJvyqE0F9suwM+TM2qBN2hvXj/2Ptf1KA2gJ8Uf4Lubzkn361gymKR8dPMRGyJsi2SDc30/CfHfx3mOk5VCuZs+lRj0P6SOIz7sMhkbYU2MuQMP4iFilc0eL8z0UmGh3qflr+eGn/bBLMsdJ0RKr6pGZw4bQ0TCXjQQEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ay5JzxIJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P7M52gKh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ay5JzxIJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P7M52gKh"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AB4Q7p568739
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 12:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7PiBOFzuzqFI5tzekAPpBmjHMmBsUsnCV3nemX3vE3Y=; b=Ay5JzxIJ7B5VUt/L
	eRInS7bqeb6/zo5enAprotVYESxAGUW0uSwy/SyLW2Hkew7nbf2ecPNL1nVKyerT
	r3IBeU1sESVDJggMolkaiL2wRY2cJzmVM3lIhtelxRflxEqf5FRjT/pHBl38BAl+
	MVPMy23RDykeV+CisliL7/1udU4NaNqn005OtHah8YvQfGwVaE0LcTEkiul6oEGB
	yy8ftgIIoovni3QZdo3qPfSPdvaepqxFMWbI7vVI9k7dgsF8yAqCJaxQeu4frHcd
	x/FhVA/Vy1cWmBiJrisOo7U2rOkmMEcc30dinqof71SjW5Pw5MidAMJoZvzhqRea
	4Knt/Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctdf8hbxt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 12:00:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd85e08fddso2023837285a.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 05:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773144041; x=1773748841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PiBOFzuzqFI5tzekAPpBmjHMmBsUsnCV3nemX3vE3Y=;
        b=P7M52gKhdKkKMhETrWewIlj6Mk+Xx1dR84cjD/TY3BlFlsFx1idG9+D4TWROFYUPXL
         a0yT47vLXHgIsLXUHRbvosWvu+F8sYDGxETo0IAsMFuAfxs81wlpG+qux2wllPMw7NCt
         jc8FwwOvjinbavd3ApEHT8x+MS1OtnWYmIrNX5Ne/qc0G1rCzDqTu198pg2rk1zYzrgD
         /ZT68RBYRHIhoKojJGNZe9bXymWvZQW6yrQ9L5xINZRSzLnu8CMq7DNozLdIW/fj1u/n
         6BpDtT5eZtGSfEemSBF82s2Cx2XfT1kQ18pshT48txK4wtKh5Da0umNewpeyAJXnrPMg
         UHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144041; x=1773748841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PiBOFzuzqFI5tzekAPpBmjHMmBsUsnCV3nemX3vE3Y=;
        b=poh2tVBXCby7jj6szU+LaMMPBwQWoebc2pY/UAeNOgu6BAr02aTOXGTOuPeayuQLkB
         o827N5X7ltrTiPp3FHNyz3MZ6FRVlkm243UMg3e9nLJyU/34ec8oDv8EqMevlAGEpLU5
         sigieHUuEBkqpNZSGLcFt4SVQ3r5Fie/g88GkufcoSb05qr3m0CR3noDaZrSLae/V+Jx
         FYpl0u66wkLYeUWsAux265vEIr59Pls/x5oaBwN7+3wv4S7nk23K8seuFrF064lkf0m0
         cWJPA249mxuC8w2+pZEvBtJTPAo2fUswkHKactSJaF9xOx3iKFhK8wV1ZiZ6QzRnMag5
         xaaw==
X-Forwarded-Encrypted: i=1; AJvYcCVgf/4MXk/wsmboG56RRFRkk9pkv2QEoYfqFO0VITyfBHWZyrSoA+3t6Mb7i4+P1LXL+6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1UIKTdc7r8onT2f8n+6dKUEzzzjumHiCYV/MEWq8S8eZmuUAc
	LHHu3yXcqMH3xM5m8gYFnERS3PYSeLGu9koeb55BA/xA69Bq3iIJyV//O2gcuy36nGU/jEVR5f6
	oFo87WOQl+JZpQDeSDvJMe6weDD8TiZQq1YEvfSpJQMfzhalGtvv0OsI=
X-Gm-Gg: ATEYQzwlZEcvHRMs5pmVnmFTIqxj0I8Fv8ITXTZ7PoBzgSp/c/H7zYSADoIk1Cm2Hd6
	5AcRw01XCwBD7BjfBn+FMyPyDUQJKmXbHVimWwdZFBYeSchk8Nd9XfGo2UjQLfmkzu9CP6LeLwA
	hOkIsUL13pyUwazVZlISbcJ9PMassGhFHhYdHgQ2S4Gjnz6ZNy2N8VFsUgsVk6oYCmmLe073dP/
	5QbUogtmM5QQWwLOeKlN2+EOQEMjXgOToW2KU1mBk6Zs9q/dGt+sRJCgPpMc3XHiZELvkxD7Pu0
	f9gAZnYrZMpjJd7XbGmE3k05NO1eryX9Io5JNdOt43e2USsgUec9E+BeipLJNT8KN8bf15noGDw
	XnriswAPaRLMXtRPKXoZ0p5IDd/NSTt0Tln51Mw1q/4q/WAibFAhJc1XfL3XmeF3ApyZGeyzit5
	ZHweLpdQN7
X-Received: by 2002:a05:620a:3713:b0:8cb:3df5:4b6b with SMTP id af79cd13be357-8cd6d4e9f2emr1884846085a.61.1773144041062;
        Tue, 10 Mar 2026 05:00:41 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:8cb:3df5:4b6b with SMTP id af79cd13be357-8cd6d4e9f2emr1884828285a.61.1773144040247;
        Tue, 10 Mar 2026 05:00:40 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246ed174sm176194055e9.5.2026.03.10.05.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 05:00:39 -0700 (PDT)
Message-ID: <be927e81-6931-4541-a927-4dc8bbc54169@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 13:00:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/30] tools/thermal: Initialize CFLAGS before
 including Makefile.include
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        Benjamin Tissoires <bentiss@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
 <20260308-tools_build_fix_zero_init-v3-4-6477808123b7@arm.com>
 <2ae5e4e5-a860-4f94-9655-67368d558f86@oss.qualcomm.com>
 <20260309100708.GN1098637@e132581.arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260309100708.GN1098637@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEwNCBTYWx0ZWRfX5QxRlorkv/T6
 ReO/A9XGxQd/FqARn2XQCif8Yd81o8b0nwsrMyBJGek1Fbcgft7n2qNbTRnhGGvUTWjuN2nIVUs
 1ZQka7bbVDDRJ+xeCdEjjVQJfAFFD+8OZRMUaUsjCbmmBdcEhtLCAlsp03xymu+OYr0loaumGwg
 DuI1wcRdwY47ISfUdhGkdalCbnNhtTO1smltVCnCnuiEPNY8Fm+sLaCAj7nr9TpzNHJidRG6Ftx
 YcX2vJGzqLYGo/DYQk4Rrp0AJ9/nPNCLkFqg5b1M9fHl4EBV5ZZq2U3yUGKMpBhMd6R0aRCZmgq
 /rTzLVC2zUvNZoUPn7RNm1dEdziW3Du73bJoj10Z8teyP/vEGh/KCRs3ndwdFf+8kqBL4V+iJlm
 VO32gt8c3TlwYQVcOqqp4yqnPzULVfJZ92pFrxb0YPVAHVtbdryYaSLIqQUBbeNFmTu/nGmFoRz
 FJhczlzOqm8WC6m6y8g==
X-Proofpoint-ORIG-GUID: I4Tc0MV9ymP19q4MmGKXJTWbhr1yUaTu
X-Proofpoint-GUID: I4Tc0MV9ymP19q4MmGKXJTWbhr1yUaTu
X-Authority-Analysis: v=2.4 cv=b+W/I9Gx c=1 sm=1 tr=0 ts=69b007e9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=cDDQTrPvQg6LDxInEB0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100104


Hi Leo,

On 3/9/26 11:07, Leo Yan wrote:
> Hi Daniel,
> 
> On Mon, Mar 09, 2026 at 09:41:16AM +0100, Daniel Lezcano wrote:
> 
> [...]
> 
>> On 3/8/26 17:46, Leo Yan wrote:
>>> Initialize CFLAGS to the default value before including
>>> tools/scripts/Makefile.include.
>>>
>>> Defer appending EXTRA_CFLAGS to CFLAGS until after including
>>> Makefile.include, as it may extend EXTRA_CFLAGS in the future.
>>>
>>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>>> ---
>>>    tools/thermal/lib/Makefile | 16 +++++++++-------
>>>    1 file changed, 9 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
>>> index 056d212f25cf51cd8c02260fbe2ef28dda5e4acb..1890779f1574ebd9015f3001b9bb31d4bc0ae5ce 100644
>>> --- a/tools/thermal/lib/Makefile
>>> +++ b/tools/thermal/lib/Makefile
>>> @@ -23,6 +23,14 @@ INSTALL = install
>>>    DESTDIR ?=
>>>    DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
>>> +# Defer assigning EXTRA_CFLAGS to CFLAGS until after including
>>> +# tools/scripts/Makefile.include, as it may add flags to EXTRA_CFLAGS.
>>> +ifdef EXTRA_CFLAGS
>>> +  CFLAGS :=
>>> +else
>>> +  CFLAGS := -g -Wall
>>> +endif
>>> +
>>
>> Sorry, I don't get the comment :/
>>
>> Can you clarify the intended purpose with this change ?
> 
> Sure. Since this series sets EXTRA_CFLAGS in Makefile.include (patch 05).
> Without this patch, the init behavior of the thermal Makefile may change.
> 
> For example:
> 
>    make -C tools/thermal/lib/
> 
> Before this series, the Makefile initializes:
> 
>    CFLAGS := -g -Wall
> 
> If _only_ patch 05 is applied, EXTRA_CFLAGS is implicitly set in
> tools/scripts/Makefile.include to work around compiler bugs. The
> Makefile would initialize:
> 
>    CFLAGS := $(EXTRA_CFLAGS)
> 
> This patch preserves the original initialization of CFLAGS, but changes
> the sequence:
> 
>    CFLAGS := -g -Wall
>    CFLAGS += $(EXTRA_CFLAGS)
> 
> If $(EXTRA_CFLAGS) is set by Makefile.include, it will be appended.
> Otherwise, if $(EXTRA_CFLAGS) is empty, the behavior remains unchanged.
> 
>>   and the 'override' directive below ?
> 
> The override directive is used to override any CFLAGS set on the make
> command line.  This patch does not introduce the directive; it simply
> follows the existing style.  As you can see, the following lines
> already use the directive when appending options.

Thanks for the clarification

Acked-by: Daniel Lezcano <daniel.lezcano@kernel.org>


