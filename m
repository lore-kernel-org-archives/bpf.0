Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA203587DF
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769871510; cv=pass; b=CEM//ti5uQsSAiQbTqTj8Kz52EvdXVQ6Z1wWxaCi4otaP/m4jskE1pcX3nogemOf5D+eV9fviMxwzBDGtsOnAVfVh2z+s4rndk73Pu6JUqW2+OoadpKeptVEyc8j39ov0qR+JfdC0iQINjJ6E6Or87a41zyKgbSWIVKCfPoZTFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769871510; c=relaxed/simple;
	bh=XoPjc3FsSnhAH36Ksfm3BAJI9jxzPUWZyt5vdnTXd18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDEkN+2B6dzG9U3LMQL5eFqzgoaak6JMlG5SX4jzCMjX5AU6cYBY3vRW6+2btWeLQE9Zu7ypZKwBLn2s2qhz0JRH3sBlhyY4OLV8cSfDoE9R1G+cnpx8/XD1V897OhNPosM5S+l67IQBwH4lB+5vq4p4ZxGbnVnDloQSWRlqP2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OvHzB4qP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ik1dSwSL; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OvHzB4qP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ik1dSwSL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60V4Sv1I3956362
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 14:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=; b=OvHzB4qP/0jw0pjw
	qHWpKU9MTVgAy76IZFOwvomNtT5ojMnLFjv9vAMABxUYDDdhCdM/mdh/1U5ckbR1
	OHXys8Fv+a3PchmsefgHP4EyfqjCbDSoUrH0Z9vDG2TJsjY7dmvbMOIBYgB07cQC
	ID8YMzju3Vh/8MpgAyNwHRivnN+v5eYDr5CIhLCfTj2mGS4XRYyxzAUFh9cINBG3
	4lbqX8kwiPdpC2X1VC+X57Yc4hGnLxfwp4WoeziP1V7KW8OWpTYzBS2/84Kelkij
	c7Hl5zdRcBv8uYhTITx455LsNqpLBdwF+tnJlsXg2fGzqhfqDBQ8OAyarNxVhK3m
	+a43bA==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1are8xsv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 14:58:27 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-649b6352303so426915d50.2
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 06:58:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769871507; cv=none;
        d=google.com; s=arc-20240605;
        b=Cn9ntoSfcrPhMCWk3LCslQwn+RwgDWFO/inpheJ70OyG/2iVeitmKKvC3x7QQPE7eF
         VdSuSrhz9fgJ5uRVBaErCqkt5Rm2qlEKCYv7Z4zMgzTpSOn+4kqsKdpifU5PjpPav2Uq
         witcEORHhhIE9jrGYAiVuvfyv3pvosohOUd9niJuYg/SAG8Kg9l8qcXjE8hlJxt53oaY
         zreAvLZC03PO0UW+gZkBUt8pVujlTp6w4f79fYz1a1lSdlEVN72Qutg5lBMgnYATfv6o
         kGy1jCO5mAJjMNiSHUt5lTy1xRBL6oncnO0B9sIow+rOAb48739NUTwSOCIA956+Wtnx
         UCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=;
        fh=CJjZENiQ3H8h8BlwQF7U9DZlWviwEJETqLyJLYW6bE4=;
        b=T+IzZiMnLiFOZjhFiFUTkaGDdXJwBoeFgxITim1teA4TnyNdz6KaN6fO94Q4w3uTen
         56VDjFNGPq9YfsSvSBMXdb3uV64S2v6yYlbWspLoWdq7zlFAb5SeTemayzkZ+cK86DKR
         ns03wXk71mDUELup35kcNoaIkzr34DoZryWpoZk+7uXHV9I6h72Jztbrue6Db+RSFCkA
         8TDHsGvIJaHxxhO4/x6cZutjnuBI1H37sFSVXE5fzuwY/kdjRl4vjfBSrDgwDF5yu5o5
         U1yFWZ7PLOpUrJKMvbbMcrJ93/ygQoq42x2i+u+aMAq+2BMkpvkszccOP0B2pokDN8kj
         iQWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769871507; x=1770476307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=;
        b=ik1dSwSLQ5gKPr8itJihjb1p2ii6Z3jsGGCTSkLMElBTfrxMKk2BzSGAZs6Y3u/2Rm
         5Jc6JSviSstpkzoM62LilXKmZWvAB9DOuIyh5Gb+T0bn5eaFS/fm+ubSY0bwOoKcsOy0
         uUtdXIcMt8Yss89aVvVX6L4TWX7ziVDAwkZMGPY0zF71BzqoENGzauAVtQ4TysgmoZlo
         JTHS3Hq7Z/oREAC5DERRmVVlk1h39H69Q2dO8oZHQipUVCajubHib4a4IvOOCF6qUMnD
         V0QpB+SrFFffsYYxdEviApG9Tsmxy5nAA4c6446S0S+5+7eyl2juS3VlFK3vrM2U/7eF
         ejDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769871507; x=1770476307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=;
        b=nxldr815u8DhjhmFodOvQiDTRFM7GkWEDEj9sZQb/OE8QYRg/jWsh/owwUyFDZwSw1
         z0NnYL0LEgjlUgFU3b8W5Fo25Pqtb+ZzpdZ5SSt4sDiVr9YbZg2cRTBtVvypWEqqK8Xh
         foAEyf5uNWAOUtht8qz+8BI/rJ1QXbdVNPZgOA8J/B9Usvo6QcJNBB+RgpvmLbVTHAnO
         FS3Tvt8i04Agl/RZoK9jlU9NOWxhL6OpJYaHD9o1uUk2WvdQVPbHRmGR/brtvqB+hKtW
         XIBckp494jeFBCygHe0kGGTDRRqD9AbW01XkRR4PK53yFGoCb+ck7VvEwHGCPYtutPcd
         03MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKqjXq7NV8z0ujjcQDfhrlyfgiz0bCQtJVJipFWulv1wt8I2yT1hZRu5jvI6tRlFjF4BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwthZHtHTt/fYXyUT9DQ+sM/B6YZQrjbmDNp5r4Mcl2h+ZEVMD0
	G2oIzsPbwTr73iQu+jbbvoqStL0jHBwDLS6wjjyeJAgAtqSKI91yCGlRYTEIpATwCuqZxAvvBFw
	b6QutN48vdNubCEJirKL65kit0lmQPCbQCyZctT3+mBlRBedvV920vK6Pr9LyrTpCvq4fcRlFDK
	dqZuxMWMgOfnK5SJwWaEq9hFpaQn5BmG0jzMooqbkU
X-Gm-Gg: AZuq6aK1Zabln6cNVs5IFXRN3MONDxGCspjIl9FVA2OaY0ICgQWwCjq8BDC8h62X38u
	ZCwPYBZKLLbicE0qBS+hDLmib9LoFDSMjTpI7ajxozZBm5D6oig3kuM1nRwDuhpM9/CMpvPy+FD
	N7WRbp4AJPoch2cR6OffAvimHGzBTaqDy1R/04Bmg3ln1NheSIwWcBHIVdrmNg+OzPxNo=
X-Received: by 2002:a05:690e:4107:b0:649:7c5c:88e3 with SMTP id 956f58d0204a3-649a8547db8mr4403463d50.95.1769871506944;
        Sat, 31 Jan 2026 06:58:26 -0800 (PST)
X-Received: by 2002:a05:690e:4107:b0:649:7c5c:88e3 with SMTP id
 956f58d0204a3-649a8547db8mr4403441d50.95.1769871506570; Sat, 31 Jan 2026
 06:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV> <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
In-Reply-To: <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
Date: Sat, 31 Jan 2026 20:28:15 +0530
X-Gm-Features: AZwV_Qjt6-X-XbfNyo2_bleHjewtRG1qoA5gEXW9Hu9LjqRyKmxz-97xcVzcIio
Message-ID: <CAEiyvppoiL2EiSmVvNV3DEkr7wwyC1Fbwhm14h7Rfus4Z8uP7g@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Samuel Wu <wusamuel@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Greg KH <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu,
        neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org,
        linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com,
        linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
        selinux@vger.kernel.org, borntraeger@linux.ibm.com,
        bpf@vger.kernel.org, clm@meta.com,
        android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=NNfYOk6g c=1 sm=1 tr=0 ts=697e1893 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=1XWaLZrsAAAA:8 a=drOt6m5kAAAA:8 a=wEBb_YokH4NsbSDSc3AA:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-GUID: eSN8oUtnHAIkQugF2614KD_i5x16Vf7r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDEyNSBTYWx0ZWRfX2VQrD1QmSJqh
 FQldHDNY2Q53/E8JO770TH377yNrRMwLKnVhQDXUBA9Cq6rexhqT7vvbHr+YTr9fwECas0RijJJ
 aSMQ089Cn6NUQUmLadgH18KtRrok1oLS/BjAA8PbqFxce9+uHKk9SBHYRACMLvpRQW3R341wSSG
 o/1M4w8E9rSojfACWWj3bY2cRc9ss8B/xCZ6Q3Skv5gxWUEy9zv/xgIlnK/F5LMwzKHCdNfD8UD
 CTYYs70Gk89Ym2XkMnqJjg+S/r+FR7Pm464hm6MjlwYk6audG3xc45ZBnJIcVDSPRkeJNFzai5R
 AJvHAki/eDNddujdSAcQyXyYURPUcNkWddgd1o8hYv30F97+p5Biv2SNna3tjdQpXvHBdPl1pg7
 62vel3b/K0/VUKM5Ecg2vzwqC2Cbnr58IAaEkGY9pMhx0SFbxETKKIdosdgJVG4anRwzYIAmh4v
 bNJUpx8LOl2o1+9C07w==
X-Proofpoint-ORIG-GUID: eSN8oUtnHAIkQugF2614KD_i5x16Vf7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601310125

On Fri, Jan 30, 2026 at 6:46=E2=80=AFAM Samuel Wu <wusamuel@google.com> wro=
te:
>
> On Thu, Jan 29, 2026 at 2:52=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
>

[...]

> I'm exploring a few other paths, but not having USB access makes
> traditional tools a bit difficult. One thing I'm rechecking and is
> worth mentioning is the lockdep below: it's been present for quite
> some time now, but I'm not sure if it would have some undesired
> interaction with your patch.
>
> [ BUG: Invalid wait context ]
> 6.18.0-rc5-mainline-maybe-dirty-4k
> -----------------------------
> irq/360-dwc3/352 is trying to lock:
> ffffff800792deb8 (&psy->extensions_sem){.+.+}-{3:3}, at:
> __power_supply_set_property+0x40/0x180
> other info that might help us debug this:
> context-{4:4}
> 1 lock held by irq/360-dwc3/352:
>  #0: ffffff8017bb98f0 (&gi->spinlock){....}-{2:2}, at:
> configfs_composite_suspend+0x28/0x68
> Call trace:
>  show_stack+0x18/0x28 (C)
>  __dump_stack+0x28/0x3c
>  dump_stack_lvl+0xac/0xf0
>  dump_stack+0x18/0x3c
>  __lock_acquire+0x794/0x2bec
>  lock_acquire+0x148/0x2cc
>  down_read+0x3c/0x194
>  __power_supply_set_property+0x40/0x180
>  power_supply_set_property+0x14/0x20
>  dwc3_gadget_vbus_draw+0x8c/0xcc
>  usb_gadget_vbus_draw+0x48/0x130
>  composite_suspend+0xcc/0xe4
>  configfs_composite_suspend+0x44/0x68
>  dwc3_thread_interrupt+0x8f8/0xc88
>  irq_thread_fn+0x48/0xa8
>  irq_thread+0x150/0x31c
>  kthread+0x150/0x280
>  ret_from_fork+0x10/0x20
>

Hi Samuel,

 Not sure if it helps, but Prashanth recently pushed a patch to
address this vbus_draw kernel panic:
 https://lore.kernel.org/all/20260129111403.3081730-1-prashanth.k@oss.qualc=
omm.com/

 Can you check if it fixes the above crash in vbus_draw.

Regards,
Krishna,
