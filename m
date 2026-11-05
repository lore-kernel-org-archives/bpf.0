Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793909832;
	b=e4KxHq1ZMQXaYxm/iUWjEjjcsPvcsr09Pv0PibFE6d8OuP7fkUJz0Z/DYTp/yj5juXtZ
	 0IdnFNqfIUlyiZ6JfW1e2dT+YZtGhICv7NZ30gifUl3epGGGSPsxt5GMRFOLJTkN0O4Jd
	 3VnJHuRGVKHLxlE3EwRaPCGMiupOh5LAHH1p4DYwAdBmTZ0fUxZSpEE3lriUE6aQDCe2+
	 jYgN6Zp7g3uScLu+s0g5iTuZKGdt6gl96Dh4jh8FEtURDuJ3Eriab+tzwRFrxNoylGFBm
	 QE53zTQslb5U5y11MKeZIUXfPSkHJ8ZmT/zRGO405nfmuREVYq6zAIwiXvIZOOibynQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909832;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rTfu7W1DkYeekq0IooSfHUhC1cbKjXYHdVcAXct22yY=;
	b=tdL4eyvZeTEegHPRVU8DKzxAlx5c70rtypj0e7RVQ1TmCb28aEMjSR2uXsIhxoVA8aGv
	 Rq+DjrzsiSd3I942qv8dHZ/ARZJ7Jt+OfoQmEa6PtCg5z1CmACLd1yMgwc/l4sD5VwzcN
	 PfWsjMz4lvwR7gpJvyJN6nsW71UM2mdVs6I52cwm4tTYoPrwcTSUFBGzzRguqqRVOTeO7
	 RHCGLjXMmMG8DCJKwCbc6bUmzPNuhIXXDKTqTjUGr/EIg/ESfFqqqUV+FLUF3/lK/NzJn
	 ckwgSg+D5ttO+HjnV2FbovAWEUeYb4Uu/lfspYGpwdO7hKVWEzGwZDPXuNnJUW7CNsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b="W6zw+k/k";
	dkim=temperror header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b="YaQLh6/+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDAA606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EDAA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=W6zw+k/k;
	dkim=temperror header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=YaQLh6/+
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5GKqcA3184082
	for <bpf@vger.kernel.org>; Thu, 5 Nov 2026 20:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=rTfu7W1DkYeekq0IooSfHUhC1cbKjXYHdVcAXct22yY=; b=W6zw
	+k/k4YX/v09rDfDHhSHoxIruPkCZtWCkkSujL/PN9DDRH3HuoqT851AP1kcOmh/w
	QkHxJFdhng6lJ1K0WQUFNf2Bo7q4RXedv3lg6EgvpEOBkZoUk5Hapmigsc2ZUsdP
	tQ/gGoVTWKJFS2UV6xokQggdjp+Dbin2V18IQ3q2EFEFNV9Tz38aqZFRnQZRFiEM
	5Kv3il4E5uBmkVmr1MtlJVROBri5CIBsAczkPdl8wk2sQeYeY7fdaj5zPswf+Jty
	SiwqVnbMFeNZ93mW3ul7O5N+a4i8yoxfIIc08f6AUrJhRWdNm9hn++ZGkf20BA1d
	Ocb9LL7d0tA5i5H+5Q==
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hrmsaavw5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 20:17:00 +0000 (GMT)
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c4d34d6082fso22916066b.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:17:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793909819; cv=none;
        d=google.com; s=arc-20260327;
        b=l4No1dk+r35BAqMCmh8TxiqOx001plKQjX9PUE+6UA3uj4vQnmyvfE2+qdLvhz9xH0
         3y4g+/E16KhPSHggHIkuYcM/vjuRA4xA+Jbe43/CX93Pj3V8WsgT/jyLVKR2dLeM7zxc
         gOOOqh8ftoVtnw2F/wZTm6ZHH8HwIMVQsNiaHfVdmgT82tpt5iyR1293JvwSEmYuCnMr
         Xz3zIzzxZoid8RaTRVJEnvmyjaBkGLaVF+XTNeoSwg9Ge3oJx2as75SWHYpujUbvdEFx
         ayTEAu3G701WBbD8k5a0ge1Bu98Duscf1m87rpEgXbmnonXRe223YcAzxnKii7+p8RN2
         mZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rTfu7W1DkYeekq0IooSfHUhC1cbKjXYHdVcAXct22yY=;
        fh=+vUpQJE4x7hxBUFnPbIVLJLAAmDzABFnGPUWmWgisb8=;
        b=jXbDuFEhgMZZgFRbh1ZIO9T7RTxL8YQLsM0yiB4jPBFJPyd2n0rWhmWOcM7bHoNuLc
         0DNM5p32i/KTldsiQCximGV3UCKqxyARPwvO17UrtB/4dVo+STerj4hu2cZAkM7JzTg+
         artmoi7nZpmIwID6ToM9obthDTBHUmty3tczYINeeY8tv7o++4IgCVf5AGmnFoBR0Bi1
         zYIQuqtBkqlAJIbvNIZOLS6kdYcmc8jgAkX06RO2kNZ2xOMWwFvMU9hbqMNT5sTifkbe
         pt+5FVoV6EBDnWlG+scUrjek1Tx0xgKX17Wc17aj27qdYe09cV5n/dLtOhfIzvYLa3VW
         6b6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1793909819; x=1794514619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rTfu7W1DkYeekq0IooSfHUhC1cbKjXYHdVcAXct22yY=;
        b=YaQLh6/+K8sPtKjGPQPOAziPmomRkm6opHGV8g26+gImx/ackxhZZnPiBfm6x5KN1z
         nmrQtA9w+WUeAQDWuQzXoZPYeS+/xFwF5hhqTlpPS0rIPum8aPcrbPIl5Bp+exFzmZgC
         1ar3PYSlhjpv/RsFL9NMgjEqDSE44qoXpTaOf6vbNkdq+Tod/t3EjzdcqaQYvKudQV4J
         Kg34j/2HdqQ/P7EbreavUnSX9QALo3MKiezpY4ZYUJY0gFtxEL5rcpooplcMfuJnrDSA
         S5uh/6GESv5ALq39c30/+La08rTgx48CdAw/8Ymz+DmnFRgHYmhkqhxBZ+KRq3HI2gv+
         A5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909819; x=1794514619;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTfu7W1DkYeekq0IooSfHUhC1cbKjXYHdVcAXct22yY=;
        b=kcd4xbeB7kOv5UveZpnXpjPSPtybsoWNDYYi1xewq4L6jzv28RJ2rDK0VADYPX/2xN
         gfuo/wcs+cmSZSdyXM0AF8WcwagM6LfxZ0T6hu0Wp/KJsW5NxfClf5UBh6plj5hpPlTi
         Ro/Qy7faq/9qQu61lm88coMpDgc/BbpWOESOxS7Dtyc/Pjr/QQu9IH61B4jTAvYARVP+
         dYQbgbXOTFpDxF0Dwab9hYFVW97du+74+e8+EZg+eJtaIJVCx9zNWyaL/zE/+Qf0SW0F
         Mb4kfO0YZQwaTK1a1vT10tWVoKk1X0R6xoUIeK5xtVN2u1J6SQXeYPnTm47tZqL2FqN1
         Z4YQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfoFwc0iuE0Dsii/lf6R1+4d5X0yYX6bdd091Ygllfl9UGQJgwwbrS4stLyVHpkQajwE8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5gmsRbkMkTqFI/c8f/0qSCp7jX7FDTLdyJ2ppVC5rZYMUrm7X
	Cz4GNXwc7rHxLwY4MjL6B+9B9KZReA7vZDKaOLVK5oaGXlcIOoeZkeqW8IaqTWnhD9+KBNo0+7A
	fAraq9fSNeJz5neTpS1sjbOOPiq32f4+CmmtQ7WLpOBe05SVHSLJCFgvZ37HgiTQxo57EElV2wc
	Fc4TvxuUbJ3lMN1JAzJ4MTeVTGo1zd
X-Gm-Gg: AYBFou0rkuROZKPsmujAhgYWhqttHWx93EALlTIhYW7PW0FMEzCf8v7LCadzAWgNUTr
	7jjZG0EFOiH0wHqpJIbqhvYR8ykokm+j87aEPouQa4wNgmxtpE/l3jgob2EVqtLrvlmUmcRBj2S
	e2S2HWUJqZU70IDrfx42QhzNpUKQCPDojRWdYBziG6Dd7zb1q8S9Z9AGzuN6Xf2X6ywhisidy5g
	ezZ6qnAiwV1MOx2k2UZOEsl1Zr70fhYDelAaj5tivMDt1Gcw9KS8k9kCvHeOJpLJoy6u2o11L2r
	iw==
X-Received: by 2002:a17:907:d22:b0:c29:659e:2fd2 with SMTP id a640c23a62f3a-c4d35519e9fmr43189966b.27.1793909818795;
        Thu, 05 Nov 2026 12:16:58 -0800 (PST)
X-Received: by 2002:a17:907:d22:b0:c29:659e:2fd2 with SMTP id
 a640c23a62f3a-c4d35519e9fmr43187366b.27.1793909818311; Thu, 05 Nov 2026
 12:16:58 -0800 (PST)
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
 <DMN0USP1E59A.34N710IJOO0PJ@gmail.com>
In-Reply-To: <DMN0USP1E59A.34N710IJOO0PJ@gmail.com>
From: Martin Kelly <martin.kelly@crowdstrike.com>
Date: Thu, 5 Nov 2026 12:16:21 -0800
X-Gm-Features: AclHuK8JgYiZJpf7c-VRiUqEK3vIdAU7ZjKP7fLp1Y2VHxGJrDEumK1dGFkMIGM
Message-ID: <CAH=2mMCmmmjq0HEA9xxtFyaupDy++zJmd=aAJeitEHtSmoXxyw@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption
 cause false recursion drops in trampoline progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mike Bazov <mikeba@sentinelone.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MCBTYWx0ZWRfX1It7pfs2PI+w
 rL9BbZB9fNrDl8me19VWsTmO5Dem8kj/CHFE9IW+heGEkq1accJcUILmzJQvkSUFsyIewLKHmZD
 SMA9/2e6M3NRrw2aCA2ZJ5FtkPBLih2HeIlxo9QltoyKZflqD29Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MCBTYWx0ZWRfX+Y56UA/WtWSs
 9U7acOXUoquB0E77f2l56gXLBnn5WwXS4qc7B22h8xR9d2JWjoigbuNsXxAn0pkqcSo9zOKFuy3
 1OMFKBvzLqIOK25Pqf+pfpkvYGdIxQskLGuDfEGqeDUVs4y67spfGzSitJLyOAicqSkGOEjRNrC
 7mQtpdogT6ZtIWo/EyZDrQA3RpuEgWCob2ckrJPdn2mWgNolG6QnFRH51y+qOFgWdOTt/7e+dER
 yjZ1tI0IlcNsJJG7cNQxTJ9FNUlIg3qgmYNbCHQXR3ynR7lu/IyGY1vQMwMsmHFkHechDFzw/j8
 0l+WiyH8mj9NlT/Y3QrrcjO5KBz6zo2lNd98tlrQcvZ3cFnR5AOeLe53Ap4l/olxJtItxLIecBP
 tA0Fnp23UDcH0q3rXuaYenyOrgAjElbR3jaAMqepyCD6Q1uKxzIu98TdtNFI/dkzF8AwUTOSifo
 AOS7QdrLI/tGuq6W23Q==
X-Authority-Analysis: v=2.4 cv=D8fSufRj c=1 sm=1 tr=0 ts=6aece43c cx=c_pps
 a=D+UBI74RbQA8i2EYnbuvxw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=pGLkceISAAAA:8 a=BM2dtbHZsqdhYTBwM7sA:9
 a=QEXdDO2ut3YA:10 a=PsfoTyiJ_72bb7xyA04f:22
X-Proofpoint-ORIG-GUID: 68gdzLFA0AjferhnIPWbHS0DqisSiX9y
X-Proofpoint-GUID: 68gdzLFA0AjferhnIPWbHS0DqisSiX9y
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050080

On Wed, Nov 4, 2026 at 9:18=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> what do you mean? the reentrance prevention counter works on PREEMPT_RT t=
oo.
> per-cpu array are not corrupted there.

Sorry, I should have been clearer. The issues we hit were with using a
single per-CPU array across multiple *different* trampoline programs,
not a single program exclusively using a given per-CPU array. The
verifier doesn't prevent this, and we hit it on RT kernels, where
trampolines have always been preemptible. On 7.0+, this issue is likely
now exposed on non-RT kernels too. The per-CPU issue doesn't affect us
since we stopped using per-CPU arrays, but the recursion_misses still
do. Since prog->active is per program, the per-CPU exclusivity only
applied within a single BPF program, not across programs sharing
maps (which is very common).

> Thanks for the numbers.
> Are you saying turning off HRTICK is not an option for your production?

We support many different Linux distros, so we have to work with what
the vendor provides and cannot change CONFIG_ values. Since it's now the
default, it's starting to be used by distros, which is why we're
noticing the issue now. Changing it dynamically is up to the customer,
and if we changed it on their behalf, it could affect their other
workloads. Debugfs is also not always mounted, and it still wouldn't
help with the increased drops on 7.0 kernels, since we have misses there
even with HRTICK off (1 in 61,580 on security_file_permission in the
above data).
