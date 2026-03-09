Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E22EE608
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773045684; cv=none; b=Z6bD7ZAGrIDlcLpXZG/wOVxaoiLNn2bPgeJ2wUlD8l9tWwbBm8RULg2eKWsfCu3+GDkLR7gdNQgVIyGC5mvt7gI1tfWdFgyv1dYSzfOtb61rAKabUBYDJYAAh2hKva/dmcRLOwoBbg+dnQQu75L+HMd+ueZJ0MdFAYxErg8wVq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773045684; c=relaxed/simple;
	bh=QmC/1aZi1KMAI8qInvYmgDZW0GLqK+zvjW6rUzsfpMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6ho2DNeGUYeE9jrgjg9+57qF551IY6QTQLG0vMudd0Ibk/d3u26oxHq/Dhgy1blqfih7FFE6i1wG609E464VdbiZWfIhPlZOlNluRDQDilEvFJ+56Egob9lilpUYoFursobeveFvydGas4I8USCoC7sU8sBDMozMjBBl3KBleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SdsdnzuP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bQlbtZwo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SdsdnzuP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bQlbtZwo"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62964xTL2288470
	for <bpf@vger.kernel.org>; Mon, 9 Mar 2026 08:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xEa3WzuEsGwlSu+tKPUtbqO0QxG3vgk+PmyiHeY+Zck=; b=SdsdnzuPVbNbaNE+
	W1d/LjZ27mcA+rlHb8qR7wYcsZhPHjwjUbo+SpJncaS3aMK/1HYPDbbI0LcwepaQ
	30GJpjWD+PkJVv2pScUeOl5aWUQbl9z++HUSnRjG66CpBHebZOgbWCXdYicZd1It
	iwM4OeGoSO5Xl9iKb5jKkifS8nh/lUEGu5E+EwK+Wacd6GAX+F3V/donu8lkQp0V
	Sa/ijwZcGApL/bfuueQ3N31nGnyw7JJBY1ikDiYQZY3SGTL9vUy3rF514Nt+rcXp
	nQK0esTLpI1LaVRUxRZwgsG7H5L+eXgLSMRKYF7M68zAJF2CCXXmvYJPvf6dc0u2
	gnNa5w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crayrmqu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 08:41:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7fc27cf7so731605185a.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773045680; x=1773650480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEa3WzuEsGwlSu+tKPUtbqO0QxG3vgk+PmyiHeY+Zck=;
        b=bQlbtZwoYkK2UuwXiLhOB4YG+aekbjZkk8/6JPbtkTA8447mhi0St6zcOTbPPqwHWk
         aBKkeqHx7RgKoOsmWVbrY+S4/A5bMifcnBYskgLrGd+8hP/UYBKrcxFb+/QInmpGiwM5
         fbDoLbRfCtTLJb+7r0O37NTtXIQ9LD56Wb3v5OFFyYahpjxueVHKjbTj1WRrXuzW1egL
         mN26aFUhDzAcOdMCtVQrG1lHxmO0SYg043OrYGSwuPkJx9ZtSLY5uWSIL9X+YXquBkGd
         BW14wXNWIXOTYXVBzVonr0W9Atd6modCaBymlIhXvbMiVUcI9+LdCbo3gLcPU13JC6xC
         b5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773045680; x=1773650480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEa3WzuEsGwlSu+tKPUtbqO0QxG3vgk+PmyiHeY+Zck=;
        b=AM0bTseFWsxAMd/mXcE/0w+YOVJia+dR+BuyciLFYfo/c2Vsm18SeapknlJNgaDYG+
         65Y5fzLgCrau5u5AfZaN3ZsnYfZADpRixY1Qev2xM7yv2XS8ceedEDCu7UrrE5SvNByO
         ebTqTAnhSlMKFJEo8WB3tyzIjyrKvimEGNWbzT1pBbMox63XBYpx41R8EB3LDrHKCrRU
         fpM87Nh8MxBE97JzQfAnABJhaae7NR2u0k8msSfvoJn0l9Va+bEVpsXJIBa6Q6d7wMjF
         vieT2cJQAF7l+2vKTQK2thAkOAVYFo7igqpekA3a+D1SvBfFQVjjCv5ex7J7xAKRTk3c
         Cwzw==
X-Forwarded-Encrypted: i=1; AJvYcCWzOaXVySzoUjCZ7QR4aqWzWiJK8mdurKxdPTQvgKJOa5xzCv0eSW6CHYfNi3hT8tIN4wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMzuO821FvqF7evGrLAToalzu9VIMTBhs5A5jfYfGR6XNBz24
	P862BgqsdW+cpBMPYjsa9hFSZw2ppzr0DybB35UBsstMFLpDZw3c4C1GIzX0PPFb6ot1dcjkOz4
	lwfUSa3tSORhkpy/zTis45cE1iVdCjvwHk0jIKS6uT+h+lqVMoLk6YO4=
X-Gm-Gg: ATEYQzytmVmmWw9f1vL7bJ5KrHWBKYyU8G7mBUVGbBBbtjbJdHK4D7IMwTj96laBE4J
	KVFEfUcRAmz3uM5V7zc33xXIRfgcqbHbzE/L61F3GuLwyPfVMmA5wvmePN2NcZREUiM2H+sqx7P
	AvfPMyqkik39zVjCH1tGarPxSHtl4+JsxOLPA0DojRCa9mo7H5E94tiq8kvWM9/WVN2a9YMx8cU
	vLa6EdYPoVA/gaL5v82FisbALf9U2e4cADz8RtaOGTnbUbBLW5bWaf2yun8Etvo2Ql4CLXw+ofh
	H14LWxki1oGAlbshYG1AHqxLZqMAPQrQQmzCeIwq3BWf3IAZOELXW4wDvocPolrzPTUqhsPEz94
	IRVvvqvgf8S8XdLSUjCCteWcNS5kD9gfeTnxk1wRf8F8W3WPyKgJCuK0D3Y2HGapSNcicx6Rtwh
	+2JOlrI8q+
X-Received: by 2002:a05:620a:1707:b0:8cb:b062:c2e5 with SMTP id af79cd13be357-8cd6d386908mr1323664385a.27.1773045679961;
        Mon, 09 Mar 2026 01:41:19 -0700 (PDT)
X-Received: by 2002:a05:620a:1707:b0:8cb:b062:c2e5 with SMTP id af79cd13be357-8cd6d386908mr1323656285a.27.1773045679422;
        Mon, 09 Mar 2026 01:41:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853a946978sm88693385e9.1.2026.03.09.01.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 01:41:18 -0700 (PDT)
Message-ID: <2ae5e4e5-a860-4f94-9655-67368d558f86@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 09:41:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/30] tools/thermal: Initialize CFLAGS before
 including Makefile.include
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
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
 <20260308-tools_build_fix_zero_init-v3-4-6477808123b7@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-4-6477808123b7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=U5qfzOru c=1 sm=1 tr=0 ts=69ae87b0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=7CQSdrXTAAAA:8
 a=ZAywS_63PuHDt0GrRrsA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: uLmCMC6hBnEbOzxQFd5u2UD1xZNGrKHK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA3OSBTYWx0ZWRfX5NNHfEvML9RV
 3iQLIMqh6RXMfBHBZQ3jzPIAUfQReDKIZtj4IH98xLY1FCUF3Tei/DmChd8soovEWUxhG8x4asI
 YeakflyR3EU0tEnviWfNvm1TOaXxAEc9hTXZcFHQQXZtE82qNEfF/u7c3tNZc4dzwgHLqY0nwob
 m0CTrvwXzeCGXvidDfVFZbtlllvhqYo8zP8vDrbkOFlVNlcB1Djsu2jyOQRAEdM4pHsf83qqrV1
 6Y61EsWZwxqrX+PUULP6j5KpUorJ8Yoh2gjsRvJhhRU/RFZezrBwUDuc5g10nZXdcW8qXapuKMT
 R3yWVTgmzCpzBqyIWuPnaRKfhXnvmzC+e+b7ZPvIfYiEGZFVclkappFCnyfRlM3mgS4yTpSv0pt
 CH3AcwGEHn+0eBxj+w7iYHi6D90eZWCx5+d4qGYR2IYuxQLCpoDie8Hxg6mH6G6+UHJ9088Ke7C
 KeECRAyKYgnCUnN/xAw==
X-Proofpoint-GUID: uLmCMC6hBnEbOzxQFd5u2UD1xZNGrKHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090079


Hi Leo,

On 3/8/26 17:46, Leo Yan wrote:
> Initialize CFLAGS to the default value before including
> tools/scripts/Makefile.include.
> 
> Defer appending EXTRA_CFLAGS to CFLAGS until after including
> Makefile.include, as it may extend EXTRA_CFLAGS in the future.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/thermal/lib/Makefile | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
> index 056d212f25cf51cd8c02260fbe2ef28dda5e4acb..1890779f1574ebd9015f3001b9bb31d4bc0ae5ce 100644
> --- a/tools/thermal/lib/Makefile
> +++ b/tools/thermal/lib/Makefile
> @@ -23,6 +23,14 @@ INSTALL = install
>   DESTDIR ?=
>   DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
>   
> +# Defer assigning EXTRA_CFLAGS to CFLAGS until after including
> +# tools/scripts/Makefile.include, as it may add flags to EXTRA_CFLAGS.
> +ifdef EXTRA_CFLAGS
> +  CFLAGS :=
> +else
> +  CFLAGS := -g -Wall
> +endif
> +

Sorry, I don't get the comment :/

Can you clarify the intended purpose with this change and the 'override' 
directive below ?


>   include $(srctree)/tools/scripts/Makefile.include
>   include $(srctree)/tools/scripts/Makefile.arch
>   
> @@ -39,13 +47,6 @@ libdir = $(prefix)/$(libdir_relative)
>   libdir_SQ = $(subst ','\'',$(libdir))
>   libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
>   
> -# Set compile option CFLAGS
> -ifdef EXTRA_CFLAGS
> -  CFLAGS := $(EXTRA_CFLAGS)
> -else
> -  CFLAGS := -g -Wall
> -endif
> -
>   INCLUDES = \
>   -I/usr/include/libnl3 \
>   -I$(srctree)/tools/lib/thermal/include \
> @@ -56,6 +57,7 @@ INCLUDES = \
>   -I$(srctree)/tools/include/uapi
>   
>   # Append required CFLAGS
> +override CFLAGS += $(EXTRA_CFLAGS)
>   override CFLAGS += $(EXTRA_WARNINGS)
>   override CFLAGS += -Werror -Wall
>   override CFLAGS += -fPIC
> 

