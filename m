Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A8439341
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087667; cv=pass; b=NtEptGu0OC1+uDJQP5qVBCBGY4kQi+tDBilK7zYi+fnTr47egS8CQbLUkpFgIQsPw6H9w8CrxdkETQHQAlcWqWSlKo8RfFsucLLG5CJSfNHU9uF6nYfTyfw17dAj8pQD1roAxnilofGI1n2YY01tSRrR21JfBTUytiLKOtNizQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087667; c=relaxed/simple;
	bh=zn7ZAbPX8JSYm/FWXG2CNveYzxYtqKgggKXqtNQepkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzTRMIT4Lx81vRXQbzHOP3WqyNs6k5KVwy2x61snwopOWukq4Z0bId6QOuVqKwNhorIqqUbSL1FH9Kad/duLBENCutv3Yg64mmnxmykhM84iUt4DwWWf/2ySSWk2ns/dzqzYl7HxTaDFV9a2VPH3s7HGkx0ysYfhbEWR3443XxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=FsUOSZLA; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=DY/FPSx2; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="FsUOSZLA";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="DY/FPSx2"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MDMxZb1503236
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 14:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=gQBKx1Dn4vrHIkbovIr3dNdNfGdAC/R04HvZ05mSteg=; b=FsUO
	SZLAR6ynC80k3JPRMPEHDDqxxAZ30B0BVcHg2rmgNNpi/8n2Dm5WiAyDenBDaxcn
	MRz3U6LVXd369HqMfT3TP4t/CNBSaVIpJhYdY+fBpoHY55XXSatnVcviwb8vKj5Y
	9+dvmtsQosmmsBTailc2+HOWymVDPxDe71GGRsyjkwaHKZA7LwVOtlAVQU/GjhB8
	/2qkpIVY766PD6VD6X1VDOJgJpB1xjain7MjyR5GsFEGNO0yNq0Dben9a1ooy47M
	YF/NXg9Q+e2/MddI6kcupvN6ZKgllO8VIiO2Qt63TawZVYZBZwzg/HkCQWkvY1n0
	/8Kq7h/t/QfklQrKag==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4gu7vv40fe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 14:34:23 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9103c9c0b34so62360376d6.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 07:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790087663; cv=none;
        d=google.com; s=arc-20260327;
        b=POPyFADz8pf9gRyu35Fmb/ZMaRxReh9eGB7bI0BbQI63nCs3cLT3IBloCofBBFTIou
         lqYkXHBNhMKqjmizHADvdtE3qU6ez/nna3NZcu2smtZ+fYl/GXe9aW5IIAGV4p0lx/6q
         r3AlkaWI+9gLR29/bFHXmgRpOYHGWYqC3jcgb3Hdpfg3+AD6gJCa8iXLjbNbEdjpIo0U
         8DpWzSk00c5co3uqAQw4UdrGPXsL/HHUqGg4P62/7MyrYO8z9huAvCmBik6LF0YTNdyJ
         HhyK5gi3V7ppK1UmKzWtAh0Vi2/JEtSHU7sn1Z49NN0mGhRD9eE8Mio6Zo/lABDBEeWP
         y1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gQBKx1Dn4vrHIkbovIr3dNdNfGdAC/R04HvZ05mSteg=;
        fh=q/fpgq+uoxYo8dH6lq3H2zptNtoifeygAgpDC/HkOYI=;
        b=sgSMoNlNvsRzuAwSWRjEgVpRFB2DEZCBgPref9lSrmHzo5Raf7KUdxYK2ZfDICg/zp
         j4qRxCm2uzbgrkyGmx92kNH0u1oJ6mscMmN1bLuYbyv7d5E1Z3VCJyukTNnMZOKvNmLe
         sEbzAugNhm9MA32FBQo5a3bs69Q93cHMSh9acxxg7ErHno9EbrTE8sI9jP9Xs1SvZMCQ
         GWn5+NAkCEOZX7bDD1dKnDRw4aAN6agWdjMtPSJV+4E+CL+laNceJWk0SVMv9sMZ7ssn
         ODEg5hZ7ukaH1DRKwNvIYc9Joh1GkxZqaxMM4OEDFBWOyes312qGTfo7H3f0Q4OUNEDR
         mDaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1790087663; x=1790692463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gQBKx1Dn4vrHIkbovIr3dNdNfGdAC/R04HvZ05mSteg=;
        b=DY/FPSx29YGCXJdh4uSl2Dpp6fz+jWfG4wyvgR/RI+8e5eP9ygGkSPe8Uwi8ShDG12
         6IFF9lU3hDzJ0j5vjP0MQcMhJWBTufYiVE7k42+WW/SwOY69XGK5Q0MZ66AuMGQJEdiK
         V+p4XOshK6DGrq6FFb0euP3WJ8J4/IfQ1hRc13i+GTBAQR8AoOE870GmdCFd6e5RGOtL
         RtimyKB1+BkPgz3ssZf7/85lDQLCVDrbHnwweYHis9HFs3fkq3eQgOLem2q/tBfo2heL
         ByI+v4rvhWRdxmL0RGABu8T/dptGqGTyUr07omAHSEo8coCv/KhQLGuNKeNxj6angswI
         Bnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087663; x=1790692463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQBKx1Dn4vrHIkbovIr3dNdNfGdAC/R04HvZ05mSteg=;
        b=sbktpGD9mTAFGHU/80pq6kq6oAUwfQYPRoYWJNdCXn9BwIzVt5RhIHCS4i93OL+2CD
         csGzuor7BrAkgFzL6zGKhMzLRylh7yQC+9jzFI13FX9Xi3hkw99ghCsD9fNB1DFFfWwl
         UJXMuTDxUhDCmvDxKAsmr8UdysAdeB0NeCYkN0qIUGYIgzUiiX9wjL40PNp9m/Uet9Fr
         UvYVKlrOF8xkQ7wDpX2kqigFoqPz3fYNib8XG5z4Zgy5IaSklQq8E2eLmXG5EWQWa0OC
         K661bODaj0cQA6LdefVkD8QWjQdpfKidh8AH+R6tTkcIXwVRGgl+s6yBHL9ydcRkeM1A
         Ywaw==
X-Gm-Message-State: AFuF++lsZEfsARCb/NWWDxfrHkyfrFKjOR7tA2hmSAgAZWWPug1uNh5o
	eWCMGDHG90mPfgXULrIMph6lMnmX6ud0HrApxshBuwnkMuokIOxY/yxO+5XRUPyltnCRmKfDpCk
	q3XExCfob/nra5uLEV/CxxvDA9neWcGV7YUuNFiISJJYr9ur1zS2kHHQdCgAbGDfOJkdMXx045F
	do/rq6/GJruaWBG5Rk/kda/FJFHlDv
X-Gm-Gg: AYBFou26xNaMzpAc92TObTM+dPo8sR22ttiJqkYrPdt+qxkkhzDc/BYoOlngWqXR993
	M7Meu24vzgIQsUhi48DwmU8Zr2S6Hy9FderL7qsm1+ZNUrR3sRMPzJqmcZUcVepaYybrdvbjBam
	Pb6I9nOpBGBAFtgFR6TxmAs70fMhA/2gvokLjvHrx13WV3JnKlsRwuZHa1
X-Received: by 2002:ad4:5ce2:0:b0:910:7076:b681 with SMTP id 6a1803df08f44-913fc899191mr59458236d6.2.1790087662809;
        Tue, 22 Sep 2026 07:34:22 -0700 (PDT)
X-Received: by 2002:ad4:5ce2:0:b0:910:7076:b681 with SMTP id
 6a1803df08f44-913fc899191mr59457856d6.2.1790087662325; Tue, 22 Sep 2026
 07:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com> <DLLGL0Q2REDU.3CMU5XBIMBWGC@gmail.com>
In-Reply-To: <DLLGL0Q2REDU.3CMU5XBIMBWGC@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Tue, 22 Sep 2026 10:34:10 -0400
X-Gm-Features: AcwNN1UcyszfYqqEcHjxhH78v0ESKKy_fn53dqalL9qibQ9H3J6rvG9Oil6omIc
Message-ID: <CAOu3gNgYiVfX2e_sST=n-bth_an6b1FgGJ76f=nO5UMq-+4+Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/7] libbpf: BPF program manual loading
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, martin.kelly@crowdstrike.com,
        slava.imameev@crowdstrike.com, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 4tK0TRIz0pq9d88FP54dZF9bS6nh92gH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIxMiBTYWx0ZWRfX7300Cu4WkoqR
 FgRDEe68T4cTa8O0KaK1MuzBbPqB3yoDouhYqISvyH2XXC5kTloADF9HfRBCvMaYGi/O62ppDe+
 PzGo4cSV7VjbsdGxVkg8qrfGutjY5VlWjQDwqS6rT+zWDFaLwbgLCoSoPlZdYeKNbHybGYzhUq9
 6I5ci0w1Roo2JwvM0E65F5XYTmOvpV2L2tDGCPLAPhg+ZjILlBzuzO9Nqw4q/m6U2+zVytEaS4v
 qZN0k05gs1YPIR8On5Un0b1GUETRI7HB+fFRw4HrHWAdWGdm8gNvDunkn/6Db7p+LNul6Am2r9N
 KrLvj68SKiuYrMduFAtGBoGcQOExSfy8StfHms7cO4kZnctieeokfCJQbmd5uQsjnrdbPG2h3LZ
 N8YkFg9KFKFtGNwGOzgNchfPNTGnWXxhiMOO3lp+UAI2+XxbSJNIMuPHpp1MYrhVO44mckMPjHg
 n3tl9gFPJf6K2bTVpTQ==
X-Authority-Analysis: v=2.4 cv=WaKZ+EhX c=1 sm=1 tr=0 ts=6ab291f0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8
 a=DYNH-wFMyQ5AiOR2ZpIA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 4tK0TRIz0pq9d88FP54dZF9bS6nh92gH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIxMiBTYWx0ZWRfX9QJ5Yk9HejeU
 OX1XPt9iwdoQDdJcWw05/8cseBVSDEAWWlhEh6dc4FInH+e2uIOR5tU3w0EmJkkgvbSRVXYPK+L
 078FS/+9Y6pUEE8iMN3aw9oKtu3MzXsXRAq8yopXsw1SxFJCdTdx
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11913
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220212

On Mon, Sep 21, 2026 at 9:37=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 21, 2026 at 06:39 PM Andrey Grodzovsky <andrey.grodzovsky@cro=
wdstrike.com> wrote:
> > after the initial bpf_object load. This v4 addresses all outstanding re=
view
> > feedback from v3's two CI bots, folds bpf_program__load_manually()/
> > unload_manually() into a single load()/unload() naming pair, and adds
> > a new patch that properly versions bpf_program__set_autoattach()'s
> > ABI change instead of leaving it as a silent break for out-of-tree
> > consumers (see changelog below).
>
> What happened to the veristat conversion?
> In v2 Andrii asked to try this in veristat to see whether it can replace
> bpf_program__clone():
> https://lore.kernel.org/bpf/CAEf4Bzaf9AMBUWQeUj1Uor8F7A-tOPpVMa-CjRB0MNH4=
zRHEeQ@mail.gmail.com/
> and you replied that it builds and passes test_progs -t veristat.
> Pls include that patch in the respin.

Hey, the reason I didn't include that patch is because  as I mentioned
to Andrii in the reply[1], I found out RODATA maps gets bound on every
load which clone()
deliberately skips to avoid mutating object state. Therefore, I was
awaiting follow-up input on whether this could be a deal breaker for
the substitution approach.

I will happily add this in the next iteration (V5), along with fixes
for other issues the BOTs raised during the review of V4.

Andery

[1] - https://lore.kernel.org/bpf/CAOu3gNhbz0m7=3DcPAAD-NWPix-TCL7B3iFFTHn1=
JzaaukAXP3oQ@mail.gmail.com/
