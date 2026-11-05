Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793913104;
	b=uFwkVT6Syw/wCupqa8WM3QsKGYq4uXdssC4A2jtfIPu3Z3nuYkIHpTIW/j6891887xaz
	 lZMZonjb2rYfDLIFAxPrFqLaf9bYaCQprzq+YWv0zfG7eDCut9GzsYIOX/p3WcdmxxhTQ
	 5ZbLuxyn/6KatpGzz8LtFIaI/zSk12C42+XCLRuBiPqb2F7Kbi50vViuqot6tWOmHXomp
	 Cuf9tseK9UcGsQUPB8lWMedorWX1NljwghK3sE/gMa4gjyeG7jaluREoJs3rHGdBnARrk
	 bQBa59RTin0wjSazhlc6AsvLban0KS1SiX9uKpLt0h10MCAHRq/A9oLVJUtR/sw+WAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913104;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ww/Ky12z8kY0m7ktU2CqeMinUpnlKKPyaD44um6v3bw=;
	b=z32d+kDu2zzM08tvaUKqRUep01PknwISr/Smg3mJFdD9TaamyAR+DNUottAVA3eHpei0
	 w6cK6yUloNAP5Hzzr4CGFojp5D3yLGgmK4sq5v3/50D3ocxhByu/jJOthIRTtldaQ3blZ
	 dODbgPocNNdqxKrbYfNlTAwKzF5ChWXxwCbLU6lr6VmXV2vvkt2GP2siNI87NF7/GdvIb
	 I/k2/N79VDlRbm4XCpcOTenlE20CXgzvB2vH8TsPuKjfOxCi4jx4B8tBkL/+6o2Z+pYBE
	 55dxE35C8YeQyvPmYF7uzFMRzkq7gJczDySLw5mUfDbSug0H+q/TX7jZna95rdj2j1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=temperror header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=wmuSZD6G;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b="Hcmb/f/k";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331EE606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 331EE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=wmuSZD6G;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=Hcmb/f/k
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5KLbxm2434557
	for <bpf@vger.kernel.org>; Thu, 5 Nov 2026 21:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=ww/Ky12z8kY0m7ktU2CqeMinUpnlKKPyaD44um6v3bw=; b=wmuS
	ZD6GJgOLyd9o3FxMzCIWfh/isB98pMHOKECgcbilgrNptojIzJa88Fntl8SAKgBy
	7H79EMg9VJaA8qHLYrLktT7RCTByV8pDfGTKiub9g+96E+cR3LhnVWwWtaMOXVZ6
	7UgFDRhReTbkLqFj/8XW8fxIRABa+UaMuGN56w1C79bYx5kFgRGh+nYFWQVp2FgH
	ygNNq46gKOBD/j551zQah9c0c9TS1dd15Azgo0wkSkZWhldBzpZqjoYy5A/F+aq8
	J0b5ydWnNlsXQ162gJ4TqSbwkjsDEX/rLVq3bXP8972y1Fud0LiG+WqWAa0W8QiH
	yGFX5zUlNeJVcqIotQ==
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hrm99b1nw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 21:11:31 +0000 (GMT)
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c3613c35145so106808066b.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 13:11:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793913091; cv=none;
        d=google.com; s=arc-20260327;
        b=UZFRcU43s8vfxNt+MWDQAGfJBjBpcpJsjr3XaMdVieKjpMcYxOBGqfp4QbLpDlvI3s
         mmjN5NEyXCKpafrqDxw8jOVj2NDTQeqPfUgnFY9qfpmIt1OeAsY0KQbMTnzrLiqMi6JB
         EzmhiGJkLGj8PsSrIauRzslFDSCzqxKgEpH5pBIgAFN4gxK2vbWYuQY6bwvZj6EkVfqh
         jdrGT0loLKiWHiB6AU3EJcdTFfnx0FR/+vmKaeXyV2HpNJSdrbyEFk2qTJXEmaoYoICN
         HVJeRmw/yOhWuXJlt1umbGjwPHK/QQ7G7XARGQjpZZ8iFb62f12zR0pQHEun5Bo+M0PS
         wh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ww/Ky12z8kY0m7ktU2CqeMinUpnlKKPyaD44um6v3bw=;
        fh=7OoQ6IrhvagWloHlCvtLGyUuR0kvp84dVLZ3PXlso8s=;
        b=m17fH5QdwlnJtsSSAiqPPF8sw7jw/gvj8+nZEV9PP6oi88WHfeXv3s2Q7WPLoA18hG
         9GXDUpL0SaZC1K5XFMuAfLNlKbPzqq6a2RmQOusLIndW6dB/7IcRFeOSO88+AJ2zK1nJ
         0PkdTbWWfpWMniQcQn61lZNQs0LxKSV5G+FyVlz1sKFe2nAJPUZiZ6cqFd//w6ttXiHy
         O+ZXHKjsjwGLbrLVzZR43LeXm/3Oru/yYklp6B1/qNxR1LelSRL5dIfeLwqRfECtz16O
         oCcSXTPGBrV3zuI/G8IeHyBhdv8K896aTK3vPTJJgx8CKspg0IXAK6jrj84IxMJmXAbk
         DSDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1793913091; x=1794517891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ww/Ky12z8kY0m7ktU2CqeMinUpnlKKPyaD44um6v3bw=;
        b=Hcmb/f/kif60JRaO89pC7K6vrAeZqaS9XXmio+c77pBbfy/RTNPa01K8I0mh8oPYI0
         L9c5Gp6aWYIZ7YA75PPrMLB0CGqMgUb2rSEjOM/Xu9NG1/ToVA4LISRUWLQ8siwn8Ow4
         Rn9wzEG3cHERVPD4VdaurcO2x0DptX7aUq7uvZ6pv6UyV4j943KXnMdtlnqOhn1329hg
         7f39RpyZT2LBhhmb6IcA+zfyvmhHwJPTgJF88sEWMja93e+mi8hvMk9EZVtTU5qB3QN4
         Ck59u+gSJ1BzJpjB66yshJe7g8WVh9U6X0daHf/Mmx2fXqS+0CjIhtVH9m30P8mPMIn7
         Rmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793913091; x=1794517891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ww/Ky12z8kY0m7ktU2CqeMinUpnlKKPyaD44um6v3bw=;
        b=1UOWg5E9zLdIZ++VqA77Fod5UIbvZSQ6e6AtE8OyD5IM7NrjHZzJPprdhyTofpBcAq
         XnFOF9fT8eJDVgcDHaJskpawhdckvsgV996tffysXd+Om41IdAlcRITDKzMX7tPpVd8V
         dT+9UxHy4xFDT9AcdeZcBDRbI9gUqWlmb0ER3L9U6yYwKWkwpLIGiJhWIV3SEbTJDa5d
         2XW4sqrY3a+Z7ORwM6Lvty57PMWTo7W5U4/b0WNW+krlYKNEsBz2PzHGk7/Um5xpKN6A
         DwAtKrVuSStaaO9gOyxXMasCXiqwX9+HRThdwNtbLZVd+65eifGQFdu63bv0GbVJzd47
         t6eg==
X-Forwarded-Encrypted: i=1; AKwUvBzEl3Yi0f2oXOegVRpHHgC5um/sua2tZHMi7nDLR9Oil+6xgEmFRpbLNH0hxIDGIrHhXbs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rLwT2fuyzh30NeGLXQ2GHtWeKc+m4zkgJ4v5PrkgzOge2fub+
	eJrQURcygvTLFlYZz15C/mcBh2sDZ+7TCMxNU8bHtpZHyEqVpiDf3FQsZkNycq1+OlWZ8AbECgt
	HhaBsf3r9xc6q+0h7uf4+VPn8OWEm/pFMVu2GLqGqhvjVqrupTLy66DvCW5N154bSKH2DJx456x
	vWczilMK9ajm1h+kwVTgk3xsjhxUab
X-Gm-Gg: AYBFou3Opf7Wqh9z0bkA0xE6GiyvfdFeXOmMBwUPb9ot5IaeKpfltiJZmqOmor+koqz
	OgJTkgR8/WA5G+6cSST/yZOSqoM/XwHNhahvLTHjbLm2uLgc1C6FzAjMNX98Pa/NvepgBRAvhog
	F8jhMIihjV9hjQyE7Qmq2aNKtEzo/jIDsP8h4jvtFYfszzeCgcHzWQsGwukjz1EFivby8n0cN7b
	sgUi+UG1Lci2D+aJ+ioRtRryEHNpZRFw7r1b7ObFa6glr3E8yBMIthe+7GtK4eu3eT+cAj/98Ri
	Vw==
X-Received: by 2002:a17:907:d22:b0:c29:659e:2fd2 with SMTP id a640c23a62f3a-c4d35519e9fmr51348066b.27.1793913090750;
        Thu, 05 Nov 2026 13:11:30 -0800 (PST)
X-Received: by 2002:a17:907:d22:b0:c29:659e:2fd2 with SMTP id
 a640c23a62f3a-c4d35519e9fmr51345666b.27.1793913090205; Thu, 05 Nov 2026
 13:11:30 -0800 (PST)
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
 <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com> <e3f63654-0f7c-462b-b58d-05f3164fe340@linux.dev>
 <DMM2G9OX9ACV.231CHJEPK0OHU@gmail.com> <CAPnbwjpQBR-KHwOMG2bo1uhdp22ZW_O5sUj3=vjazVu=Rdnb7A@mail.gmail.com>
 <DMN0RC27TJRM.3KUSPS9QTBV4G@gmail.com>
In-Reply-To: <DMN0RC27TJRM.3KUSPS9QTBV4G@gmail.com>
From: Martin Kelly <martin.kelly@crowdstrike.com>
Date: Thu, 5 Nov 2026 13:10:53 -0800
X-Gm-Features: AclHuK80YOzI2BQNU2ehKijMeyWHkLC1DDyHgXW5LfR8ObnEvZ5A2mjJk9W6SIw
Message-ID: <CAH=2mMD-N+JXZR3eeXf3cOf4snnjkAHjRditS1o1Fb_oxNQEdg@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption
 cause false recursion drops in trampoline progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mike Bazov <mikeba@sentinelone.com>, JP Kobryn <jp.kobryn@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NCBTYWx0ZWRfX1b31RvjrMtu1
 SWJ6aVA+k6hw0PMBSrTar5EM5w7w7gbutFbzVjtOVC6jzWCHVQnwB9aBHBnj+XI9pj5JpQ3/vkN
 Xkr15FGlGX0EKVHOSioIhvua/kC0W6npdlhjo16MQ7pnUIEgpUvylsWqpl3K3QeapWD6lgr9mQB
 ubaTTuMz78XtoLXKArX3ebrfNu3Jmg2W19aFi4Q607w3JwZKAbzDZugG7l4lYGYR4FNbpcT9VFt
 W5FNNINTjYRDmYAoe84M+4rWzxV9KbYxtzpAKMy+OijWIEvlRTrBr6g55KPmuSV08Xzot+ob6Lp
 vdf1EJh0Wp7vTWMxnqicGT5M+BhbCY0itLsjgJ3sGjgr6j1SNCABuq2Qu7ES8QPklEyAklsAgXl
 nJTQWfXGXS1R0d7zkSecr/Cf4/0nXcKuAL+EbEHYrPmpMItZFDoDdDL7H36mhFCiOI7IHuxrU4F
 XuELVLU9G+nSsASz7JA==
X-Proofpoint-GUID: k51g0x_NMIt8ZUczLpjlwjoomWnTirEL
X-Proofpoint-ORIG-GUID: k51g0x_NMIt8ZUczLpjlwjoomWnTirEL
X-Authority-Analysis: v=2.4 cv=PJ6aavqC c=1 sm=1 tr=0 ts=6aecf103 cx=c_pps
 a=edIAN7ErZTGbxav20d8A7Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=vDKVRhTs-M86Ea50iKLw:22 a=pGLkceISAAAA:8 a=FZbjhw69-ufqTzFgkyEA:9
 a=QEXdDO2ut3YA:10 a=nIuFr-8touD1a-RngYHT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NCBTYWx0ZWRfX8O9+pm72SOaJ
 W07BmPa0qGjGO7u9fRWU/Iw9kYoymTcXN92GSAJ7DakI4Vxl+bT5hIr42Z2nlmW7cf0p+Qb11WY
 cSRcjLXhZu9gMCWWI8Q8JCh+OSegD2nzpWXIT9RfpkdxeJoHuqJ2
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050084

On Wed, Nov 4, 2026 at 9:21=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> >      run_cnt 38040015, recursion_misses 4063
>
> hmm. you really cannot tolerate that small drop? it's tracing at the end.

We realize tracing programs don't have a full guarantee, but prior to
7.0 and HRTICK, they were still reliable in many practical cases. It's
less about the absolute rate and more that the same workload had a
~35-300x increased drop rate (depending on hook) in one release, and
that behavior is now the default. Since the long-term direction of the
kernel is for more preemption, the recursion_misses issue looks like it
will keep getting worse until we can move away from per-CPU BPF
recursion counters.

> Also it needs to be per-task + per-prog. How will it look like?

We're going to look into options for per-task + per-prog tracking and
let you know how it goes.

Thanks,
Martin
