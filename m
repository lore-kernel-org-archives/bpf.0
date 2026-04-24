Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE03E3DBD48
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047576; cv=pass; b=fXS0fgxyXj/9P0B3R3AZ3wIfV425BZn0683W7moOWtPVFBKAaaTNtWm5mIM477vkQhU2XpSz7mYIB+aVMCeBRFu8srq1EfRSlDWbChh6g0OKMF//ri73+tpRt8ZV4bdoea/p+Pi7kL1WlpJWaKrzimSbkciD6wdFCMtnO9fGQEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047576; c=relaxed/simple;
	bh=rYDLTILzoZXXiTETUhnTrI2U/NCHMkY04igp9fZaqJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWS25BwJkpokMDa3adR8iCJ8n0qZrj0hAlz1N/cZTEAtmhFRkW9akbDqtszrfD5ZJzqsS3oblI1RCAj31xr2uvpzL9bpf/iC17qKyIacNIYEEmdzoa/pt9NtDlt9T1vXs4FGUSmgzdArpbNTZ4aFvA3+ZGgvMfN/OZyrIBRaxnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=j+EbScnJ; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="j+EbScnJ"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63ODxHqE2121003
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 09:19:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PPqYNegI9usH9d/38PpPwMxC8ZvnotzcXAblroD5KNw=; b=j+EbScnJplPs
	JdlpwfHp5p/hNnRLiQv/l0tYcEttKh4DPWWuzd1odKdUk8zJZ+y7aLEdlpQ7zRxZ
	nF9uJ9De33AQDXlI2YW+fmyiIIaebUSpQyx7OhLLkSexG0WRsBm4toe6q6DZa8dl
	xXBAVG+zYMps2F1xRr0MH3t0nlmT4xXpk2LRS2mQFG7BDhsEpAVoXUh4I4ANWiay
	fAST4G7bINs9MUXlOvy8XHajgh8HM8FNJV/I70j6Unqh7J2U3W6THKD+Z37eo58Y
	GQQI2svYYkDy1r/JCeDPb13LvKbgE+NIFIXWEA1CmTojV9aGBv+Gj0lCMADlE5bl
	CPm25Bho0w==
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepayxbp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 09:19:32 -0700 (PDT)
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b934e96af9dso800673866b.3
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 09:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777047571; cv=none;
        d=google.com; s=arc-20240605;
        b=Nc4c/f5YgJrbr+OKuyI6N8NHWopjHnfieJM/U23mwK3i1AM2dwrPxJUPo5S6m+RnfE
         NR9hu961CTUCQxxwWvXgwIEGIrhET4Ij/UPt+BDLlx2AucSZvBJKXiZP3RHFhT7dcTH1
         evAgtdJQZx3H7cdNenTctSxJa7hNX467JycV8RXJNl1QSQUKMYkINPXSjqsJ5l3RXt3Z
         1azLEvOeesjrEH88mEQGHKPXAyUjXpFtX4fRi3uyKYgy6vFOG1aKGwfF2NjRmwHSjlSh
         0wzdsZ6fE5BOOtHIFd2d7T83nXyuEeYCKG18DnQbrkRZybK2ax6i1dhRkMhU/tib79mg
         GsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=PPqYNegI9usH9d/38PpPwMxC8ZvnotzcXAblroD5KNw=;
        fh=6VllGn+Nfp1a8zmsP8IhhZ7W26+eG8OH+tsCtXekga0=;
        b=lC2lskVKqcdniaGsZ5acJRskjFR42kUF+IR/Ud3Xa2QzFO3puPheI4pK0EZlwyOLv0
         q+Wk+83Pa/o9irK8r/vEcVfMBDRDjUr7ChW9LcnEie68jlf49YsnFig32GJdNj+vxIYF
         PsSB09S0Q8iFMYn+HTesY4yAZ0Y6s0BiSUYc90+scqAXKcyYbG2OshtsALc3RbyUUyLg
         lJ1Zk6QX5sMHnmvrrFT52S2pRpm32aYNes/JB7AqGuqIaNHGBp4vuJ3uxLwyFwuYjnhM
         CAEBULrtib4ZoKuUYrAJ8toDpvXK2eHlUp2l57iFMh86i4DtFwDazUnxh8WDPeSS1QZB
         5T6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777047571; x=1777652371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPqYNegI9usH9d/38PpPwMxC8ZvnotzcXAblroD5KNw=;
        b=AGzg/qdlVl5A8lQGwpqdn7KQUTHeCFbEzLLJXHMf4XoAy3WuM0aLE68KwBzqEvNArP
         n+x8Mv30h6ZJB/BktCym/vrxKdqdGEkTPoXJOhOG1U4F/8tXeET+XMWC0B1YkwGEMK3t
         X6bHAiMKbTwqON5SVFNJVh+V74ACo7io30u679FdG+6jWkrXT9doYYEWdb6Gfnfd03Eh
         XPusOhOK9L9M00JgEiZvIZnFh0SRczNQnCkUG7d3kwbgR1m0vdu3Gf2rMnZF0/lAQKsv
         ulWdPzEG0IgMT5r2xatQAXkXQxu3xXWPgCjPT+r9MCXG40Dmqx0/oq+GnyYQwHoDisDD
         FcyA==
X-Forwarded-Encrypted: i=1; AFNElJ+SHUKSY0j/ZKhpWbyhgLP0kceH9JITnJBcov/WkwKcFtcQCojBHGpOAl6AZkRccDe4b+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3GjOCZbmvnJShfJpS6fufNjG0vHqj9PUYF34xZy6GsocplGht
	1lh6xrcXwt6Xbceay+MDQJUrI3+eW28w5Apd5E5h6rfV3//oO7pzKIV+PBuD/8BbcsdYPUDD8lb
	QiPrEn3SrsUxG0pvJZNpqOYU/1VR6YUiFgmGB1O7rDFve2yZ8EnMjiD6eegyxyUZ+L/y2hqOiRR
	cmvDiqdrvCY5/Uwu7ubTbabrD6Nnc=
X-Gm-Gg: AeBDieuI16J7D00veP0H5CRjCqAujwIOqK/qHm1bUCOEPa3KAkW+U2hpw1iPlNV6Suy
	HlmNlbxVNsNw0F+m89qPj6G+uR2P6J5CP8rvjti3bm17KS6Vp/9hqnXDM8ph1jTlz8fhFP0oDH/
	eiBim/CkTXZpLc71fnT6Kl9YSg+807/ujOWd/ZBTJ13pfVslJBLKoIWYl1rIlqC94ppDDpqsRbp
	QFPlXXnhbjcv9BR
X-Received: by 2002:a17:907:1c96:b0:b87:173f:61b with SMTP id a640c23a62f3a-ba41bacff3fmr1412962466b.9.1777047571229;
        Fri, 24 Apr 2026 09:19:31 -0700 (PDT)
X-Received: by 2002:a17:907:1c96:b0:b87:173f:61b with SMTP id
 a640c23a62f3a-ba41bacff3fmr1412960166b.9.1777047570660; Fri, 24 Apr 2026
 09:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <DI0Z4SJ0TXOA.2N0IY94AF254F@gmail.com>
 <CAMB2axMg=Y5q=9CEFs=8rHLQJipT-5rYkg3wp2BhWgDwVvOUQw@mail.gmail.com> <DI1FPX3685EI.3QPD29NY965FO@gmail.com>
In-Reply-To: <DI1FPX3685EI.3QPD29NY965FO@gmail.com>
From: Amery Hung <ameryhung@meta.com>
Date: Fri, 24 Apr 2026 09:19:19 -0700
X-Gm-Features: AQROBzA5YX-DRt-31x1bYiwHU3hSYgUaI4xAICCiBNdcKd5XFtq986xHrU4yI0s
Message-ID: <CAP17u3MmGy-k06C=COaJqvohk-ghTJ562AE5Cs4LKXL1-pRPSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/9] Refactor verifier object relationship tracking
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, memxor@gmail.com, martin.lau@kernel.org,
        mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Rd_rTP8aRVoQV6jg37sqmYCiWp2cTcpl
X-Authority-Analysis: v=2.4 cv=N9oZ0W9B c=1 sm=1 tr=0 ts=69eb9814 cx=c_pps
 a=D+UBI74RbQA8i2EYnbuvxw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=pGLkceISAAAA:8 a=38rVSPPHnL7GY0vxgvQA:9 a=QEXdDO2ut3YA:10
 a=PsfoTyiJ_72bb7xyA04f:22
X-Proofpoint-GUID: Rd_rTP8aRVoQV6jg37sqmYCiWp2cTcpl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE1NSBTYWx0ZWRfXxSKURDxig2I5
 aLnyiVEPW/TuZ7wxEdj7eS5gREXxRQdbpXray7aCbBsiQGxQY0bPJpWFLq9eTELvGrav1qwJEQd
 AZBPZKUa9KBPtBk56jxrpBlXhPp1hrHMgW5BFyglLlXx8CvNvThA7pFykDFwVRiwbcBaqW39qYH
 IWvgMIpsP1zSo5BmdWKCPfN4FdlpqOh8EMi0afRoTuaHpainLvfHRVegPY9caPXdeOn8cg6cF1r
 KV39araWCf/xBmodXG477qxm7PHRQMZuTkYPVzsTsKptGgTr9gzuiTRrpAKV4D0NgIRY6xNUgCO
 7Z+pUJlNJHwuvOcZblp5pWKao08cv8SPpZtYUphv3FbcgdM8lHaHRZzc/cXvF3VZ1sSLZp/WhON
 /jT2hlmvryFupnMPRcDX0Tw/LnXxzty4KayBh/zpwRPtvG3hm17uK+IHMUPt+S/3rjPb7WLYppE
 06WmGofnrwrjyuhbliw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01

On Fri, Apr 24, 2026 at 7:03=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu Apr 23, 2026 at 10:44 PM PDT, Amery Hung wrote:
> > On Thu, Apr 23, 2026 at 5:55=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Tue Apr 21, 2026 at 3:10 PM PDT, Amery Hung wrote:
> >> >
> >> > (3) Referenced dynptr with referenced parent:
> >> >
> >> >                      file (1,1,0)
> >> >                            ^ ^
> >> >      bpf_dynptr_from_file  | +-------------------------------+
> >> >                            |       bpf_dynptr_clone(A, C)    |
> >> >              dynptr A (2,3,1)                  dynptr C (4,3,1)
> >> >                          ^                                 ^
> >> >                          |                                 |
> >> >                          dynptr A and C have the same lifetime
> >>
> >> If I understand the proposal correctly above should be:
> >>
> >>                      file (1,0,0)
> >>                            ^
> >>      bpf_dynptr_from_file  +-------------------------------+
> >>
> >> ref_obj_id will be inited bpf_dynptr_clone() as 3 into A and C.
> >> but original file->ref_obj_id will be zero.
> >>
> >> ?
> >
> > This is the existing behavior. bpf_get_task_exe_file() is tagged with
> > (KF_ACQUIRE | KF_RET_NULL). Therefore, file will have id and
> > ref_obj_id both initialized to the same value. Here is the
> > corresponding verifier code:
> >
> > if (is_kfunc_acquire(&meta)) {
> >         int id =3D acquire_reference(env, insn_idx);
> >
> >         if (id < 0)
> >                 return id;
> >         if (is_kfunc_ret_null(&meta))
> >                 regs[BPF_REG_0].id =3D id;
> >         regs[BPF_REG_0].ref_obj_id =3D id;
>
> ok, but the arrow should still point to first '1', since that's
> what parent_id inherits?

Ohh yes. I totally missed the error. Thanks for pointing out.
