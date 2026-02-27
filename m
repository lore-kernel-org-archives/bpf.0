Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EA229B38
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772226923; cv=pass; b=QqP9SqjiD3rnDL4kdWQRMSpP9ddje45rIObHLDcrp962FMd9qK1nJvQAuea/ChbfjBsV67vnSbCBWWsVYwTIOupVAZ5tkfi/JTAo5nEEybSezC538huDMpMMHPKcLDbov7ZVKUJxMd6WlikdpqOU+xmNm+CynZPTWsQsnUZ33bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772226923; c=relaxed/simple;
	bh=1yvV4S40P07S6s7yMHiVnEnVC4FZeL25AgvTpsI9MGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+qY3Z2RBXM7AonuiGM3h49itvPj8qQLEDe24RN6neV6+0M6atce9wAZ+wJcM9EZUhvP33VqPhE9Tv+wIuBC7kO/0Hlw4gxGIXGluIKm8gc/TUn9LHR//03FD0fmu+uwDOSj+XSaI9kIqAolPbZZwJEiiD5I7ORq19mXsywl8yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=kP2IkOF7; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=KO6k8bOm; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="kP2IkOF7";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="KO6k8bOm"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RK085P013998
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 21:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=1yvV4S40P07S6s7yMHiVnEnVC4FZeL25AgvTpsI9MGs=; b=kP2I
	kOF7dLWOZcJAMXMnLEpi6RKZNPgzD9Z7mcJCQe1iyzoagiIK8pUWqUbiQJTQcWof
	d0BoniW409J7WEwKksMGdoIYx8HwuxB0p/r2H8RM1Vb8IPoBDdBaumCpjM8Zlr/n
	np+xa9lbQiWfpb7BYdfzk2DfmV1prJEA3NucPsaoy3B6UwugUdL6zOr5PbKLEViq
	Vj1VC9mL4r9DSam7y8mL+442SiK98SRGsFCREthXGefszJAes5MdZyf+opHzL34l
	NBqwUbwk+Ieh84oN9tGW02gp4JsfyjmozFCVt3ZKTNRvOUsebLwECiEhRu2Qf0R0
	hfKEROGLx6Btz1wU4w==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cjyq2uwy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 21:15:21 +0000 (GMT)
Received: from 04WPEXCH010.crowdstrike.sys (10.100.11.80) by
 04WPEXCH007.crowdstrike.sys (10.100.11.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 27 Feb 2026 21:15:20 +0000
Received: from mail-yw1-f198.google.com (10.100.11.78) by
 04WPEXCH010.crowdstrike.sys (10.100.11.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 27 Feb 2026 21:15:20 +0000
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7962a21167dso43984167b3.3
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 13:15:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772226920; cv=none;
        d=google.com; s=arc-20240605;
        b=bD7Bp+ISf5lJTuOhAir322DHLJSM75FKk781zcieUWCErDteRtptGzw3JU066OMNO8
         kvmdq9WOpZADvYiY2e+QKMe55E0ywEFK9RPGrtJx6jNOMrecswS4cdS2BX57hfBgpM/J
         1L7lX0zO9Wc0RFdY1o4FzEnWzaabaxlDEXqsn3k5WS2Gfeiq6KDV1jgDqe67GFwAW/10
         GgTMpL1Las+EuzdPpkb/shSA0g+Wkg6LSnC4URhrBFE+XN+XJIFKwX8kbh5P8K4+7Gsp
         EqCScyjLeK68O1WY2LIIh1tM17xPFbtfyAhuervjQaGsO87v8Ijaoep/bp+sHlWBPUWC
         ZbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1yvV4S40P07S6s7yMHiVnEnVC4FZeL25AgvTpsI9MGs=;
        fh=iL3/c7fVEPSA+J0srkeoW2WxqEJF37fP0IO6oxodxYw=;
        b=b/z/Vdv0dl2dZEGUhvOFv05XMvGrz9+xBkULyTfXFdaWhZ5W2Jp/rlufv1jhE7MKhw
         w9j6AwDEIi+5Gaxrn23cdnYOaa62I3G8v9OMJf7893Fuo5QxifCsbTBG/27AgQEJdHPM
         B1A5/reKnxaIM3VoKdjqvWjyuZMzgQb9mYgIpgTfFpuDujRjFqRuCCS6rjMc4iEs+fIx
         AepoNOZ3HeEzWwvzpHKHgE6PPluzq/sYU+f/fiJoSsxAJ6znaxR7hW34VkQnTmVqLk5y
         MXk3yRCE2NOCFL4nY8qA7PeB1jqrccGRz0C1ZxrbKOtw9P/x6gKwKDgHugVpShnxT/ot
         Asvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772226920; x=1772831720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yvV4S40P07S6s7yMHiVnEnVC4FZeL25AgvTpsI9MGs=;
        b=KO6k8bOm04uYVCSopxf+GP94UWswqYja2OwPjddDTIrhrG85jNn2yqfLj8F0ZpMXHz
         B/e1kaQvntXC+4RbSnigwGbdpfGoKSf8431hWbSOIG/IRjtM9i7CuSztTAgfHI3BDtbj
         K3EZwiOhs7xdRSdxvWvkjwtD+ILmzY824NFJGXhZHAJGvsfDnx6Op54TTZ4C1SLYCpbc
         gmkBVCnKAIrLWICmB2yCD+bB8k5rBr89f8UudqjGMH2QMoQT1ZZMBC4FFAsWF4SqkDRe
         8GBq7WJEVG8bdp2FSjj7zJiW0BirflbPgKvLaWwfxaRpBV1J1Vjh/4L38h0reKmGMamM
         CSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772226920; x=1772831720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1yvV4S40P07S6s7yMHiVnEnVC4FZeL25AgvTpsI9MGs=;
        b=goQLzKSQG9KBQLOMdl6a2MpALA3y8wYaZ/B4TXxxurhCqx6sWqXzxILcaTQDLN+WKo
         nA7RJD4xMH9WMLODk/I11pJg9Y2i8td3GlXLNaqKFOqFKx+KvuNKHJ78MQ7L4hwEui5w
         qOhtXeGfHkYD+b5vkqNpqDMVQib7wsRZdZ6+VDR50QZbjDpLlTgiVHUn9HoFcFxx4dGZ
         dozxpSiLHZMTb1/wI1lq8l/S9pFLUNvsl0SVrRTCtChPlIKNFaYxToZbw/4L3CyWuw2w
         cVjnjklRiqa/XmDBDJaW1AktnfC1LIRS/o1Y8BH8efN3mnGEA4nytmlqFIKzGxuQ9aId
         M7xA==
X-Gm-Message-State: AOJu0YzlSKQYI5p3xeWR8N7IQVqlONW6oFyHRhVyyy1Sb9XfHXN24Py6
	TSBArviwz5YR/xTczjSGia+7NZVyOhFi8C2k+z+2OgajWFFmjzEVfMTDQPF1DQ76sBYgoa/suFC
	tqeibIOE+Kn9dVLYfg16X1MILZ1BYPWNATl96aQL8EUeSz3ua8ykJo99Z2nZe482pItq5KHLKd8
	EwxWH8l84qLJLDLAzs/CK/uZQcfrjcgQZnnlirjfs6YeQ=
X-Gm-Gg: ATEYQzwOS/Li7gwt9ipfKq6ubEjDXdclprn9Clz2Di1nAGUKQhdvvSlFTya1UD9Fyex
	VaXzaK1jlHqlSiLvNIhTIbSHop4668UXf3v3R7hcD6R45OAne++MBi+1Zbt/jKS3kvuVuqbytiD
	v+NsTHO08rZNn+X/pqYg8z7ofbQ3knsD3gZDJz1Hr32YK9pIbOmTRS2UDNEBJ9m1zAxiyq7eUau
	rIJ
X-Received: by 2002:a53:acd4:0:10b0:64c:a0c0:96e with SMTP id 956f58d0204a3-64cc236e115mr3251518d50.89.1772226920092;
        Fri, 27 Feb 2026 13:15:20 -0800 (PST)
X-Received: by 2002:a53:acd4:0:10b0:64c:a0c0:96e with SMTP id
 956f58d0204a3-64cc236e115mr3251498d50.89.1772226919592; Fri, 27 Feb 2026
 13:15:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com> <CAADnVQLrhkCkpE6UZbkPaNTFMYRoa_ZtyknhVM7FMmsH7Lvj5A@mail.gmail.com>
In-Reply-To: <CAADnVQLrhkCkpE6UZbkPaNTFMYRoa_ZtyknhVM7FMmsH7Lvj5A@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Fri, 27 Feb 2026 16:15:07 -0500
X-Gm-Features: AaiRm50TrzWhq-x0h5445TfCiH-NK44oIyPX-1EDhdc5a9emZ1l1QCYw-7Yq50o
Message-ID: <CAOu3gNhBcW-JQ_VQ00GnLd8iB6xu7Ew80Bs4VHoXOct5g-wr4g@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next v3 0/3] Optimize
 kprobe.session attachment for exact function names
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4NyBTYWx0ZWRfX5FHEMk7BBNfY
 yJT57cHoyyjZ8qFzwFhyam1DBa0X65LtxFf6yKnUeqV9NeO4PHdxo5Zfy84Lfg6QPruUnxxsK72
 60M1PsrCZbXLCqt5TY5WoqW9e9SUolj1gYymeKpQl1n/0meIZjXlpdMP4+2pVTaVjLD8lZIHlBK
 JtQSn5FwDhFX+WAjhtAhspJ24ID29BYt5cxuAIke0EXZ71mbIUw1RSH/ZjDdiEXzY8z2MNAEUj4
 E7dXf61fe4q7EwkMnpaNjOSnCiXAl5FWsGSJWACkmJ+bt3B4NLKX6VMBZEWNEjUx2pGjr7w7HLp
 m0mXwM4mR3+lEeWtPjBd4TYMVXdKnvzKWO5V6AgkiuWLWpxiBCAw4cZw2cXF4Qwyi5h81FcVB/K
 dvU5bdo9vvwJG2FiQ2CBXjovfwzNYEbSRlo+DZXzbBFHi+1TLbetg8gamVIniGB45RIHCvkNy6a
 mMIPcWy+1yfA9wpFEgQ==
X-Proofpoint-GUID: oplxLCog46lZkb8Q6VAmOqwfAI30UxNv
X-Proofpoint-ORIG-GUID: oplxLCog46lZkb8Q6VAmOqwfAI30UxNv
X-Authority-Analysis: v=2.4 cv=B7O0EetM c=1 sm=1 tr=0 ts=69a20969 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22
 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8 a=DfUOPM2WMsoQciiG4eQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270187

Hey Alexei, just to be clear, do you mean drop the entire RFC letter or,
Drop the RFC prefix from the letter so the CI pipeline can be properly
triggered ?

Thanks,
Andrey


On Fri, Feb 27, 2026 at 3:43=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 27, 2026 at 12:41=E2=80=AFPM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> >
> > Changes since v2 [2]:
> > - Use if/else-if instead of goto (Jiri Olsa)
> > - Use syms =3D &pattern directly (Jiri Olsa)
> > - Drop unneeded pattern =3D NULL (Jiri Olsa)
> > - Revert cosmetic rename in attach_kprobe_session (Jiri Olsa)
> > - Remove "module symbols" from ftrace comment (CI bot)
>
> RFC series are ignored by CI.
> If you want things to land, drop RFC.
