Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C330C359
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604624; cv=pass; b=nhkDw482ZVjooWWG0Ewm8PSmNbuROWhoGyL14s1ZdalFWKpqfsy4aTBkKszyIsKqauZ/vPBW6Y5poh1n8/o9oGUVSO4EUshtysE9/3ySWlU2+poPvyv4I9eiNwUtMYi4ClK8HWQvlZP1FVH0aZ+X2FImjqA7WnoEgo5EIb5WLvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604624; c=relaxed/simple;
	bh=pXqMftAEsAoyBbG/1CC1gj/Q4FpHE8NcgP5Jxej9pdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoyJqhKIM9EUKbiQuVPRcJnY+4wNWPpIwGZ4f9LI81IS/Zei4NH68FLpglwJkG9Mc7VQjy3zFVzIe05SSuLYz4bS/sMGrShNZkScUygI699lunUeaFFDaBMNAv5q4i9AlCVwS4N/Ve+iqabQ7BXoYYhA9f795DE//TjLFmbLlaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=mxiJ7nCB; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=JcHNXvD4; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="mxiJ7nCB";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="JcHNXvD4"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GNSV541204658
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=/fHBfXv0ywrLROfnVRClyD0bnjzDW561qLcBXnHoaqk=; b=mxiJ
	7nCBAxxXIcYirell9CGrFsQdIgPqKRHmABszPXO8+cfljLlgEjGfWnilz25wsG96
	fcEaGabVLkHPHmj/7LHYAXNldZ7qyIQU4Oyta4LAmmmmK81HqpRUhmWtxTk5CaW9
	v+KPIu6lpAGk6UnyX/ckVHM9hYQxkTfhZyalbevvxcWYnfXuQV+Sg9Q0eAFMGdTc
	Z6HuuU3erxafVelskab2dZ21nuTwJd77SttpXnXgpskzF2JmtTpggbZTq9We2gT7
	hsfYSBrFh2zVwKRaGBIR+UYKxg5xe8swZxsQu7ZYlBKumqgFuz/u8X/KpPmDE/jT
	RUvObqwBicI7lQDBQg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gqyajhfp2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:04:56 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-895241d7405so160017b3.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 17:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789603496; cv=none;
        d=google.com; s=arc-20260327;
        b=SVsnTrlw8INhWM4U5uGaIBgKnp+KgdL++TTdjKcaRId7HbYBTZpv3rDuAwC1SM7xhX
         67648VUK9QaogL0oHDRkKHl5kO1iEK9RVt+Ix0I5D6spjUhjJPdkyeRxHHUEFpasEhEG
         tBmdLYPms0hSEE6ExEf3ZDuYssZmXvAC8ItNm2XwfqRic/CA6MlF6AAu/dYWRiyy5Mdi
         sgsMGMnp6qgpnEPIstOtwoIxEpa26mvkC9c0JtM4XgkIYXBWc2aaC6/ibnhOeQCh/y6D
         4t+kJfHvrBwby36WjwVeNkdmfoEPhQJYY+95RFqOCLvWhkNfTfLEePItc3vEifzHpjSM
         We3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/fHBfXv0ywrLROfnVRClyD0bnjzDW561qLcBXnHoaqk=;
        fh=qt29tRmMv9RTRwthwC9TubzTxuwxPM3tixKceu/18cU=;
        b=koEGTMAzyL+bsj7Pe7G6kSI2UB6o03T9g+rv5TPJ+7briaCdXTyeCJCVLaFmGr8DEI
         QwB7zhxV6H3Z89FNX2OozETRxiBpb77nv7pFmfS+4n3npdD0/TDuDUyAvf/EAOtpZAlk
         bDdIcuunPRMJsPlTiH5JEF8w52HL9Gnjufi5hp7+e7U7BUTgCDtVD7gnnmayUjBYXyvM
         Tqjru/9/XSYmG0pCAAIi0l7LgCBuJdovANfGBER52ZJGxiCiKWMLA4yBrfQq6uh6r4Ov
         ivG3tAQlSbFwNuikdd1zTXnhZm1Ym99bZ1zclFq+u8/zQhik42xd0i1WHydNQO7BrqgB
         He6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1789603496; x=1790208296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/fHBfXv0ywrLROfnVRClyD0bnjzDW561qLcBXnHoaqk=;
        b=JcHNXvD4TasSiHinv9ZwH9GMrj47JXJXFb3jxqEnpVtvfTxKRFGKZAB4ntzJrwYTpI
         pYbz55X0vx2Z2PPEOif1Jda4GuoS1pdcmDfFHCC6xXiZi4xq0a9Totn9t4jDlr4h0Qdl
         AtYPVfbEpQuz4gFEhpkWlvlbUEygLlGOpqrpsMjOAUzq86+eTaS+fFbL0bFvC//KOgs1
         OjbLH50PtwrFIl8BP0Cqn7FPkSv9bPEpf86owmq05rqtx1TUALn7l4HoETHi7Z09M9w5
         6T0Fjhz6H6zZbsdB29yUzywiAxUbmNW9Io5c6bNdBendLaVC/unIPke+wqbBVn1iBm7h
         wMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789603496; x=1790208296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/fHBfXv0ywrLROfnVRClyD0bnjzDW561qLcBXnHoaqk=;
        b=vQfEHbudKog5QvkPdfXNIzGflCYCpHPb0/TdnVV56UKFsKeG7ABalftXkyQZpLOFKF
         23GgB72DEIld7tZMCNkHWWD7652kuHe2AAaC8evSDvAk42GIgiz6+eMfyVHJ/Xcw3iMU
         qyV5++wNMpeX+67yLHJal2AKLtd2Ija0MG2Gt86Ol8YLLG4A6jBqS/rr53eZ8mZght/d
         m2tLpx7IbO/YWPYxurJWGdNyHZaHiQbI2WSli4a4kqQmeDkMtRTGOgDGwiHmBQnR1xoz
         BJus9lMC0arYc/WJ6mC8JVDPNckVqVfuTowXGHzoeTnqvlVAhvBWQWihKmsEQ94Ns6mS
         28xw==
X-Gm-Message-State: AFuF++nH7V2ainrS8uaLYiIHCgc7+eVn/D4rbQMhwJ0us/V4wjZdf8ep
	7DBp33Liqyx/QfqnquATgu/BtI0dPZn29YlARAbX0s0eOPU35AW0/aVbQuG7AERfvQJdOS3q2wI
	47ZuMtKVhlcfpAg1hiowJrLJZFI/OGNxaur2rMgVsjISMqkUU90NLsRL8WfLgJPN4KFlyeyn6rl
	phewVgO28irMVAKO4uQMAfW3qt5TCT
X-Gm-Gg: AYBFou3vnv+33s3LIYMBzQK/uePaomKSgyk2NVDYl6dEd1jQ6wg682tYLYKujW9CFEx
	EdXpGRaZsKTF1dlejA5CZyYsesdghE1JsR/6YnYcTdj9KQplYipiXw/AQUEXwhP7Ec3CZzegwCv
	23ih/Wpl8UvCsbJQapR2tiyzPmpp5VZlFCOsUqOELo5FU6Q3tfuzXGsdYZsQ==
X-Received: by 2002:a05:690c:113:b0:87f:e563:de9b with SMTP id 00721157ae682-89221bcf587mr14810187b3.18.1789603496347;
        Wed, 16 Sep 2026 17:04:56 -0700 (PDT)
X-Received: by 2002:a05:690c:113:b0:87f:e563:de9b with SMTP id
 00721157ae682-89221bcf587mr14810097b3.18.1789603495883; Wed, 16 Sep 2026
 17:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
 <20260826181825.1826541-6-andrey.grodzovsky@crowdstrike.com> <CAEf4BzaaNbEZnV=wADR1T-AQJapgXhJzGeaoHOMu3mj4=PNANw@mail.gmail.com>
In-Reply-To: <CAEf4BzaaNbEZnV=wADR1T-AQJapgXhJzGeaoHOMu3mj4=PNANw@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 16 Sep 2026 20:04:44 -0400
X-Gm-Features: AcwNN1V_z8ERYI3ngEmeRyW27ffBs03x0vG8iI7A5_08dWSbdqLBGdq7ZGJ88-Y
Message-ID: <CAOu3gNjK5FJce3d9+FrNurQDK-KV0r4GHPFLoEZoYe6QZy=P1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Cover BPF program dynamic loading
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, martin.kelly@crowdstrike.com,
        slava.imameev@crowdstrike.com, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMzOCBTYWx0ZWRfXx4xDFvOvTfnF
 DdF1+h6A19Y3QSY39UbQp8oyVpgjxZ7YHMIfjuHealSqbUs4PDGWJZ/3CDV+2G36J6PeMsw/kfr
 fzfyG+jRl8sD0AGNhJxobTdJ/He0QE5HbeqF4/awJKp1n2hI7vT6
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6aab2ea8 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=R_n4Uisa8axJ7jemP0ek:22 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8
 a=cGfXP6NIhzqT8PZqI3cA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-ORIG-GUID: 3pywO0ydWz-L_CN16M6FUi64qBQDTGAA
X-Proofpoint-GUID: 3pywO0ydWz-L_CN16M6FUi64qBQDTGAA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMzOCBTYWx0ZWRfX02zRNVnEUW1c
 FH8Dbu+5RtnPUkTx2v2FyIuqIzaKjFyHOTqFWHeqkO/2JPUED/uc3FDG171kERT3vlmVD1DqaFs
 rXKKRiHvexBUUpH4sZyg5ni+gFVtSBKvAsHF6AsPvvl5wShBwwVO4n12Ul372IA9XdYk23+QHNE
 g+vPXwSdmJl7JQ7ySy7fswh11kFQLb1wx79BFOD6IxmzOGRc9u6VwjY6Ym7fBpZAnJul+/DrYUK
 +y8fHWnvgdw7ZKwK9XVTV8Jao7Q/SHIHpunrW7kQh5K3hd1H3ygtmBsqeMYfWlwGx8PNtCTgOj/
 pMSZqg0UApUxxo1FrL799Dqh/+SaK9aMW2wOYrwdDqJiLAUVaMeMJklShffcrtLeSlblVRgXsx3
 Pj6lgQG7dSCxANTeqLkVlwosMqONWAmeMUBhsNVpoJwSShr4HfajPgghFd+6sNyAzGYBzQW1BuG
 bDpU6Ojix9zVYGYLCBg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11907
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160338

On Fri, Sep 11, 2026 at 7:44=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 26, 2026 at 11:18=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > From: Slava Imameev <slava.imameev@crowdstrike.com>
> >
> > Add load_type and dynamicload tests: the per-program load type enum
> > (disabled/auto/dynamic) and its transitions, set_autoload() bool/enum
> > compatibility and autoattach restore on exit from dynamic load, the
> > full dynamic load/attach/reattach/unload lifecycle, and the
> > loadtype:dynamic BTF decl_tag as a declarative alternative to an
> > imperative set_load_type() call.
> >
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  .../selftests/bpf/prog_tests/dynamicload.c    | 222 ++++++++++++++++++
> >  .../selftests/bpf/prog_tests/load_type.c      | 167 +++++++++++++
> >  .../selftests/bpf/progs/test_dynamicload.c    |  40 ++++
> >  .../selftests/bpf/progs/test_load_type.c      |  31 +++
> >  4 files changed, 460 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicload.=
c
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicload.=
c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c
> >
>
> I could barely find that __load_dynamic tag, seems a bit subtle. Maybe
> we should just go with SEC() prefix like with SEC("?..."). E.g.,
> SEC("!...") to mark manual loading. Seems to kind of fit, exclamation
> mark calls for attention, no? WDYT?

Yep, it aligns more naturally with the existing pattern. Will update.

Andrey

>
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/dynamicload.c b/too=
ls/testing/selftests/bpf/prog_tests/dynamicload.c
> > new file mode 100644
> > index 000000000000..799c43034ff9
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
> > @@ -0,0 +1,222 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +#include <time.h>
> > +#include "test_dynamicload.skel.h"
> > +
> > +/* prog4 is tagged __load_dynamic in the source instead of being set
> > + * imperatively; verify that an explicit bpf_program__set_load_type() =
call
> > + * before load overrides the tag's declarative default.
> > + */
>
> [...]
