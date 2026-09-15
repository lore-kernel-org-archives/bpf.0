Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B947F3DA
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510896; cv=pass; b=FkEatbzXZ5HR7u2mDvgDwcKpBF9qsAk21v/xdmEpy2nPe9RL4416HKZFysREDXxZyyuGlEKjfVW0rTSoCs9091z11tfNT3B4BrGSTDyv58oneJFByFxw3LVhLiFmPYa4Ukytz3LqBGeba0HS0cowapsLxr82M9IuzuPnFldMY7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510896; c=relaxed/simple;
	bh=zMEH3dKvgIFeOLNgenpgNKtSSPQyo3I2Bi4hOFPx7Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZWNvWeqATms0ktY3JyEQJji2eg/9+f+J0W2KtekoN0JmJwNT74Fv8IzMAhep00FVm9jSIWxbj4kZUNjLOAsrPXkaAI1cQyNGjY8r0b5D+OHUtcwz96BtGC8IGONPSF2vTlRiowykvZ9l3/lZFXFS+JleMl1/lXB6tQhUIdTHK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IV/k2TQj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aB07AtjI; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IV/k2TQj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aB07AtjI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLYnmF619821
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=; b=IV
	/k2TQjkUrsTGpshqW8f1AkLpzgE6WqJLnJXyVNHKYz8mozA+vLQbIOpShvI99Nvk
	BGk11nj45xZQZMebNdo7NiYw/EO7W5wcvHVc8eAkRKtGrNMclkKkbe3unomYvdUd
	vFaT1byqggr1zubtRjDzuTG9pECEQdOzFAiv4kdIU3d7CXM0IsQ27dhrP8NvQBkU
	TlOdMgPnM8h4FF25SXM2n03VFD94RLvjnLlaGSHHxie20ptztZeSDX3B4EelrzMT
	n1DLEJiB1mKEp0dVH3Si7JCiMZpC8ZcIigaByfbQDV2F2ANWVcL1rru5kNRyAlZ9
	ag1DWjYpUlLQQuGalXdA==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq2y2kj6y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:21:31 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-46524220c5aso5637299fac.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789510891; cv=none;
        d=google.com; s=arc-20260327;
        b=MhSHfJufLodmuIRAdKaFhiZwMdVm22s/RuC4coVXMm23SsqLCzc9ibqmG8enfpSS2f
         qjpXaaOEQL7fDFeeHXmuJTNSsA0oqXclHea6EG0Eb3Nldy1j5PCmKnR55PbRUDIa3UT/
         tdQr9WNHy0v6Tg9GIMPFYHpUxbJxp1PyEvq2l1rTqe9qXWCTDqcswd03z5DpEpWWoMVS
         YCiqNXZzUa1bPsip+ZkOV1/Rh95vB929q8on8IJYamCL/wz9wx5E0c2ohr2VUFOfUV6g
         jO5xLPvJCOzko/DM40KPYe4aCMdznorknNHW2VZprVhtKAVNikwRuIIYQVC5RvwWbZuK
         XbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        fh=39dImIlvj/R3FCe8D22GCdLUnmqn3RbUUMrE9sPoFwc=;
        b=s+5QsclhHZJm7ST/N7kUEc2k2K7Jpud/P6XxitHxqtE2gfKFashzWml5US/WCuRqYm
         PqKvJlbiRcty1gEhtMa8BYCMNUtJhiMP1RI+02PhfNVXq6adnfdsQSIbG4E0gKCY7RaD
         HM57sUoSfW2yROf/zB0TYJAjSnaAu8e786r8poGbd1UC7d8dCvRP5ZePsQBLDhachE8c
         VkSR4A4SCspghAl+QB4F0f/fn9qXnOmesNyko0+kuhhXgoSOiRUCuFe4qoa8ylElOH0r
         OhAHEECLp7KqM7CtlSyyWLW4C27oMzTrqrdq0oH02u7LwmjYKjz9RCDMvej2oWWvjgpQ
         CYdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789510891; x=1790115691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=aB07AtjIKjPYRGcvBSuVUhbZlxd1+55zy/NhIuvnz19m7qssQTpE/4jhghs82a98Dx
         rtzGuCLITyYJpv6qqsfwRyWf2V/rvp/BavfnHKk+3jeYdHSZJCYDfk5x4efzm884vIfW
         UjGKSA8ySqC+bc1butY/HkkuCwEw+HH62Uipjk8j8bjqvTXRubAdUvP+c5BJvALTKQeE
         2MFV1Wjr7h5QJcQaotkuVTv077nzlClUSJUJjEEq6X2ukv02bdE+qejZx/+uCM7gRcPt
         xEQKVpHKyQ6abdYF/Q1vdcAj2ZFa315JGdv0g44dh8zUZEwY87qYbRStthdyfxwDukm3
         Mbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789510891; x=1790115691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=XtY3p2R/o7Htv74tCFLOiNykT1RogPZR5mVSP862ByOMu7PMSzIK/1dM5vCT8pIAKN
         su+8l9HRLjYF3lqnEamQzyOOk1jrj17ohYQ9WzesTQZ5iEbaxVbfijZPH13oliAOeR58
         bp0CbL4temhpt2XnkHvxNvT9p+acfPOO2BQ0hXCRqaO2R22ghjk7ES7vmlQZ6dDLo8Ak
         fbXqmTz8Z2U4ztwEYch53WIYYwPgpRJs6Qbt16UoclfkH3uwVWyEfuy7J0VEaCqw64xB
         mQoVLOxCW05qnwEc+7r3V+Kjiri+8QFwNfbTUvmNT9aBiNTiqgkgn1JsCdKV/dBw/VzN
         E77w==
X-Forwarded-Encrypted: i=1; AKwUvBwkl7uGzAfQ0rPR2RvcLnktTjJqlFGD1j+hQcLd6NMZ947Q6YhgnMMaENuwmfeJkRigseY=@vger.kernel.org
X-Gm-Message-State: AFuF++ltUUaiuTyEOMISOB/lbJ3EeuI6gA/oAZ/rWm2Rxnym/OYbm66Z
	tg7LnXs32MH0DRbuFOp3fWgd0W6Ni1ZC5XnSfplHDLz68s12dpJShJwZaL+4+10Wek+qg4XGPs+
	lbK0uOSTOwtX0TTEjMWpptTOmJI0qGnAkBItXTKCMazNT3gWl88l61sY43Gs5Y9NevXD6QS11bo
	KcLocclS2+XRc13BRBQ7143FAEea7bpQ==
X-Gm-Gg: AYBFou0r55uXRHNC0Q6pJARpPuE9ZAg+/AX30eEbsv41yRQ+xVuccSbZ51PCbFsoMwT
	kfRAANShTv6HIxK0/+JMEofsrK6l9dAgw+VASPuqS1nbjKVRSkyvl+1hR3ImWB3+pGGGNBNtaET
	5MgQrWV8z0aaQ9TC8199kH3LIj3Xu1YV9irouOVGtiIepZHTRAJIN2Lyn7
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id 586e51a60fabf-4847584c51dmr189748fac.2.1789510890839;
        Tue, 15 Sep 2026 15:21:30 -0700 (PDT)
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id
 586e51a60fabf-4847584c51dmr189724fac.2.1789510890430; Tue, 15 Sep 2026
 15:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 15:21:18 -0700
X-Gm-Features: AcwNN1UxxSxAxz0XPK7niSod0Tx_HsUs-C3mKdcqDSaFkh659BGkCorPygYZGHE
Message-ID: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
        David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: qlkxJcCKr5ZG3h_Tu3u6fY7mlmOSE6vI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX5gLfpTb6VRxG
 LKTXAvJhxxMQZqDQ2FOwiKW7h0nTu4e4o7Ghomok1KEkVoZ7Uv3qxMl0z7P70LRQfPlEAjRpReH
 oM/Wou3hCBkMxwhrrbYQh5Dr3SL8B7zD4UKMIOz8obnCcnoA1BTZrqe6P7mkNom/IQsrhb80SKM
 wXTz+5TruvP/ufryEN2lZRgwjVD7MgaaQV1mgZrOC8HR5f4bmdnbwl+iVoKoKDUXVzYlzKnIu5C
 uJp4usrjshMMfbpTPjFPbbM9codzrCsCCkbqAWG3EdBHpnvD+ip7uWcMgl8ELz2p6/lg7B1CHZk
 5V6gAMD4oVZoUt+MMflKXOfTp7bgSQSlCPQXCFL6eVnp7+vUnwuO581myrgSWQFAhemHlSJDv7s
 s/GmMHA/b3jjIFhnAEZrTmkXMyEt4qCFhtGDW9NlynqebutkhydZUwWWjv5kJt91fzGaiIoYJj4
 AF191W72GOTKin7uUHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX080CHPq5kBe4
 xv5BKAXeMEhynTZmQJrnUceZXGWUKUGg6PfbpOmlBqEsuzekqHjeOUQgHwna90TPaxFZuU4djcJ
 8QlOE4k5HSrOM0VdtqEAZ1OpWnqi++8=
X-Proofpoint-GUID: qlkxJcCKr5ZG3h_Tu3u6fY7mlmOSE6vI
X-Authority-Analysis: v=2.4 cv=IcISymqa c=1 sm=1 tr=0 ts=6aa9c4eb cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
 a=2Rxv5svHm-zNKBYa0PsA:9 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150326

On Tue, Sep 15, 2026 at 9:02=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wro=
te:
> >
> > TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> > allocates a descriptor like get_unused_fd_flags() does and records it i=
n
> > a slot on the task. fd_stage() attaches the file to that slot and
> > returns the number.
>
> Honestly, I am *not* a fan. At all.
>
> I think this adds complexity rather than removing it.
>
> The diffstat tells a story:
>
> >  106 files changed, 962 insertions(+), 861 deletions(-)
>
> in how this adds a hundred lines more than it deletes.
>
> But to make things worse, it adds them in bad places: low-level
> architecture assembly code.
>
> Those extra lines are *not* making complicated code simpler. Quite the
> reverse. They are taking fairly straightforward "just deal with errors
> with normal cleanup in the place where it makes sense" and makes the
> *straightforward* case simpler, while making the big picture more
> complicated and subtle, and adding new code to places that are not
> simple and just blindly do somethign that makes no sense in that
> context.

With fd's it is more than just about error rollback.. exposing an fd
to userspace mid-way thru an ioctl is an easy security bug to write..

OTOH, "just use FD_PREPARE() / fd_publish()"..

BR,
-R
