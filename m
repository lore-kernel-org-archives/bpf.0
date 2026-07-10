Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728A34A76F
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714638; cv=pass; b=pnzQekJDoR/gGNO4ogfpBp+DjDsKpCANHBvN3pd2ZfigXl1UoMvoqMk7Uqo05aGHSxP7kwpknN6za+RA5a3Bs234NHY5pHIPr00mXAx50Srz+hZz28/q655QdHMjD5RIRCoI6RgWC4WzCvP8yNftBCFJ+XX+icm0mfG/H0Bkd44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714638; c=relaxed/simple;
	bh=Y4PxDIWZ8cuCtlKygAvLCUl9kmb0W8gzO10lBIXLIFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oterEVvJXNsebSJ3m4If5SI3lnZ0+dMqhmWhPq+CjSPjBw0SiO/BV4TgfI/MI60xgEe0VsIPPOPSdnnFW3yPdf2SM/dXnbV2fHwkGF8c+gjWowApzE4KbnxOp/90Ii4GURf2YIpEu+iSvdi7B8BF3JRqKV+egR/iEBI/dvPcYdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbM69qn9; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbM69qn9"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15f360851aso198903966b.2
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 13:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783714635; cv=none;
        d=google.com; s=arc-20260327;
        b=onX4nth7fyw1m45GwF4cv9vOLtPCfl0VynwLqRM5e5b7oXIYZ5ajWe6okwl/14LPSf
         YcL/NUxzdAxJbKoEDwIqIAA/MaBEEBpQ3UJ6ula85nrP3j//bv2NX0TLRygnyEaqH696
         aBFbAxMBlrfOIxyeYicSP1KvH2GP8hSKrVeC0WFUfMc3MDHjj4DYdM7crKgcAkTHPeJ2
         qiiiesI3PQ/nOkCR20bZfUmTMGwO3rEDKgsbn1huQgPa9ST7n1aO9KBK/qiKywODPAyf
         WfTxzMXGoTmxbfkdqjJX0knwtG3/8v8+3AQ1b+nQA0ICJtKNNXsuTYkpqDZcPqXx3VWU
         tvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y4PxDIWZ8cuCtlKygAvLCUl9kmb0W8gzO10lBIXLIFk=;
        fh=u5JhxeZzYQwERvb6WTVdWgOTjc+XXbs6+Q1e25pXPPI=;
        b=JqtkaK9tZc5jCwUwSCCsNQpRo9U7Ho9+HczGP/l3k1F1aPXpbwkj50Svy2V3SqNTB7
         2Ooq33CWfmVTn0t2WVwBx6L7Co1djOpgZ38dXQHKXA70YBv8As8fncMlEHz5itxuMiva
         4rvo/YJ878aELOhF4oFMSxKE8uk45s5p6B+GABtS4OKPai1NmBtaKf/xlx5ooz96fxyX
         hzwPc5IHt/scHPALiHTB6Pl0GfEVNt8fBPW+IngK6KvKWozFb959d60dsPccFZVEHu2f
         sY6X8JfyVFd9bgrJchaBzj8bwZqONMth1ek8VzXI/aSuDkUnToe3hj4APxzwIktyJxMf
         +zdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783714635; x=1784319435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y4PxDIWZ8cuCtlKygAvLCUl9kmb0W8gzO10lBIXLIFk=;
        b=HbM69qn97/BJYlaOyFs5fd5JGraAjBpNLk5x3e9eAFATQYh3mREVpmcBllS8KfL9CH
         ogoizhBLwVM79F+VNHfT+1Y4JqHd8U9/L7l6n9HhPrHCwdxKxxakK9KAub+Ed4zYcOu8
         Y7ithnbInt5Y9IOdaLERajGwceQOngm6SefHQMMqgmQaU6XLI8DGOXd4hGaECRliGjwC
         alJLBnMwGTIcyd0pjhSko6GS0dyt5h74PCm/esWcTOb19zlpT2prBc8JfRfy8oXzlabw
         tAGuVLow8q5lXbnFAWUfudqUCBo1+JVWgTpzSOIcK6ULbEWvRfx0xZCRS43aHKOxT9ou
         H2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783714635; x=1784319435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y4PxDIWZ8cuCtlKygAvLCUl9kmb0W8gzO10lBIXLIFk=;
        b=EhtZrH0wgR7j0SQuGHviXT/qjEjkSMAwfB519Fte9pWsKinX279m5MjfzpP5Reb+H8
         q5Ew/+Ad1bk+CX6KwTHGnOKYHBt2FUI8BifcdFAFIUlVPBb5W1r87NT3f28qbAU2r5KQ
         sJ/rkIoXtozWyciZPWxTyh3WGrxjP7GKZgq7EmmtoacQjJVh47mOpR+fNojHZZ56LXtY
         eZVCGyVPyCZZfIYoiIXppdkmx6mdh1z5CO1oeSJ0mLkhBpZFGElewS+AT28TguIv3iGy
         zd8+UBmpWeJE2PFXYdRwDt+TjWWdXVbiPe+tlkeKuYp66ZrdUGNmzsOuxG4LrAXHTM18
         tNzw==
X-Forwarded-Encrypted: i=1; AHgh+Rrwam9QAJBStpOoAmXZ/HEqGB/1LBw111c+833FRTj+S9MGQCXP7tRdNmyWaUO5CSmfKzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyziUDC+Kb3wGdXRrm91402c9CP1TKkG1OSKo32yTOccKDi2iyu
	svCPgdl7GzjC4XsSJdBY1jquZlUlQeKRU6Xfijqf+yFWWQtSUCXduDO2h4c8ASaApGABnEo8FMm
	APVNFi5xF9azC0vzvl7tV8y2nV+KDKeh2Pkse
X-Gm-Gg: AfdE7cmXFrZLCbIs80czaAMBkYQK0IOpksfqfSIAkn1aFnt7r0A28bqU6EZZ+T3LLwm
	iolMN8I0n7P5QshJHKmp5/F3RO4oJszAqQkr6Xj1tWRoX+v+FV8K8fFG5aAbKboQCqitivDNaI8
	fVNo5Wgw5vVNyNs1liXjBYusgt2RaXSeA/CmA/TsDECVWB56yKxgVVTpyEQdaMae5EcooGHBsI7
	3X5ymbWhihoc8/MzrbOdQ1jx16aNOndPNkDbAx+u60npUZlWVdabN9Mb021eLpj4jfgUU6kKYA=
X-Received: by 2002:a17:907:3e1f:b0:c11:efec:6ca9 with SMTP id
 a640c23a62f3a-c161e957178mr13260166b.8.1783714635022; Fri, 10 Jul 2026
 13:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
 <20260709182800.2037938-2-main.kalliope@gmail.com> <20260709183918.E42371F000E9@smtp.kernel.org>
 <DJV4TO9OH6AN.58C10SBPE8FF@gmail.com>
In-Reply-To: <DJV4TO9OH6AN.58C10SBPE8FF@gmail.com>
From: Admin <main.kalliope@gmail.com>
Date: Fri, 10 Jul 2026 16:17:03 -0400
X-Gm-Features: AVVi8Ce7nxoaP15UgvOn9HuvcMHcwPU6nRe8Rrrfu2vJWWJjWqqoYYbC7UgQaF8
Message-ID: <CAJZwKki8MwOmij3JZK=KnnO0hEUuxWA-iY=GK-TtvtVRvOkjOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for bpf_cpumask_populate()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 3:18=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> Once this lands, please send a follow up to address this.

Thanks. Patch 2/2 covers this, which updates the cpumask_common.h
declaration to take struct bpf_cpumask *, drops
the struct cpumask * casts from the existing populate tests, and adds
the borrowed-destination rejection test.
