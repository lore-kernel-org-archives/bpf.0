Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185923EAAD
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873044; cv=pass; b=eI9X2Mltlc6zigyOqLWnkBklepz3bJch5jMyOCuvnJlm/pV0Iox1jGmqTPaaua8VfAroVW2qyl6OeAvy0HviefQQ3nSbrhSphzX0lX+rH3S5KDcYJjLLlCF2UbuH6UKML2eHZ2odThwMH1xzD5nu40uUfhVwcgOx5HgKC40Ojok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873044; c=relaxed/simple;
	bh=0lYsCJZYmlrXENi/P9CsVLSpTSqMJmaLmV8FVryJ8/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPq+FWGTgJrQDNScwpOR695GfOCiBfegE2MX4q2lNaDjsm27RsLuHfsGZjVf9UT8U7QqSrcFBg/FREJVqvMbYWuqzpKk+YW2PAddrt+Kg0npnEayTVZx2817zDRze4+T/FuCWc56m0CXN0wGW+mt66ojW6Cqb21OTF9tib+8hhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=c5+YNtIZ; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=YFTIl0XW; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="c5+YNtIZ";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="YFTIl0XW"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NGqYuj2268388
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 18:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=pdF6sW9eyhPOn6Xj5jXUmbHQ03YhPMarl8djCrb0PJk=; b=c5+Y
	NtIZ/u0OedqVltVizx779py6qQX1/ZVCNGMvxU1rbK+aE/u+PkiWrnqR3N9aIrTI
	bjw2k6kBvsidKxY5ij0sIOtWmA2EJfKLozzI4EKWriOAcVXopYj8WrRb0kzdnAye
	n71OkA8dDagt5S/ytgVh5+/Tvqai5fTXfQZXi18glsTvwFX4awYYaE3//YIolubv
	Aw41WT2lolBDRfbikBSt9qi4Joxq2cmzXyljPUPrUen3JpVdoxDNQVtgqp5FD4C/
	C+U71JrYd8P3+niH/QXBWC0IjBxCPvPWcQi5/1O8GVxbpB8j8CFLNgOPlgn5XiRQ
	6rKNjY5aAIrFAVQ0+g==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cfqnjebv0-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 18:57:18 +0000 (GMT)
Received: from 04WPEXCH011.crowdstrike.sys (10.100.11.81) by
 04WPEXCH010.crowdstrike.sys (10.100.11.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 18:56:29 +0000
Received: from mail-yw1-f199.google.com (10.100.11.78) by
 04WPEXCH011.crowdstrike.sys (10.100.11.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 18:56:29 +0000
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7962a21167dso82273197b3.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 10:56:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771872988; cv=none;
        d=google.com; s=arc-20240605;
        b=JLp3i4tpEijgSFm7S37V9FHWByUcMmgpqtPnkqMsi6S+01B9PsTfKWrHZqsYXfJAJE
         Tl/dPhuFzxB6FYNz/WdqeR8nIupx701Crz8Z8gc/GEbvhyObtAAzxINxPwv2wMmxuwRt
         zE3Dt0ruxvVmyDkV3b3y7H78Gf6SOu+PJE4Pa0wJo8u4D445QhxVLvXTIoc7t7LuUuXG
         9rnT6XuXRFNEVW/FGuTLp3l6x3aR9ZCmnJ07fK5vbUkZZodNNcEfNJcPL4uY2oXtMP0V
         SVEig104sPTn4F8DeoOZ1jqo30ikkKeQq8DBmR/jlmteDDz9x6oBcjDCPuMkMJB9Wcyo
         pB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pdF6sW9eyhPOn6Xj5jXUmbHQ03YhPMarl8djCrb0PJk=;
        fh=vTwoLV+vwMk+/vhSU8Xr1TcF1uom00Hue6hGxhxQk78=;
        b=j1YIW8VRPOtiepCr00Ffq6edSnKicf2p9myuOgZPV+TuoNVgKoHjgJZOumxI+IhTsi
         bdIoVx4DHZogeXGMohs0ZJWZD7yjVU4gCQE++ZALG+IRBCprKLrbzjSs0sAGP2JrLGfo
         WGJntYB1Vy/zf9pUK4e8zJ9LX7ltUDyickDVdgzNZCvP88gUt/Wzj1BarJb5TerzTes5
         iBjWTSakqiYM+NFFMdyjYbeOB3vV3RzlUIEh5HUQEdZKj1D9b0e08YNgQZAnZ5r+UlgL
         Dgj1FuLHf39tpmr0laN6oKwSciVLTsW31ntGSizWoh+qWCvbuCHphqzBioGV8Or177h8
         FYFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1771872988; x=1772477788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdF6sW9eyhPOn6Xj5jXUmbHQ03YhPMarl8djCrb0PJk=;
        b=YFTIl0XW6ma8/kkDk8VlW+IBJnsNUkNTO3mT8PyHZe6RQriI4RThqrpWnWs9/q5CgF
         sU9yB3+x0IDxuSzv4Umq0IjSwszLTpP8VNYY58dLXtG9Mwp4MgZkPVcneOvxPE1xrmre
         k4zC1QURTXpU1I/Ro+49umKH6hzpxvJ0uIzqmGBAfSVmsWpNynBMJYToyJmypkYcaANY
         G19+G9rhkUjzNIToMS6qRUFo4WjGVopXG3EIAoFAXwd13esa36xVLI6/Vj8JG/Mzxru0
         qHeAFiTBOxIsnSwjqgeFc83BI0ui13NLmkmixoRrYKwFOoF1RtDVEuGN0Sv6GSHu8bIb
         RKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771872988; x=1772477788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pdF6sW9eyhPOn6Xj5jXUmbHQ03YhPMarl8djCrb0PJk=;
        b=PhtB+BC738JqDC4xvKo0rodVWizLo9/yIuNkgojBz44Oio4X6M9+e7FxHhKg89qOn2
         tmIell7ci4FzkmXr4n0gX+fFIqJd/0Nf9x7YNDOJwHZK7AjYYzgfj8P7JNmTtxmD9y5G
         NQKnpnIBtoD8hNbZklDfewzG/h9UVbKCgQs6x3f2hCXrY/LqsIqU8wZaWGDztYrtv+Ng
         ulRWI4MfXc+e8SGU/InIzVReCJR+n+QRTsoBLmF/ZR0oNLWn8epXrPTZAZIJVWLfIHLc
         nSbxaM/T36XqpgE29TZOPxDFnFntD3dE9n8qOZbqj6pEUSi0W4VWpdthZ5xZYNcgL4gu
         w9cQ==
X-Gm-Message-State: AOJu0YzM1oAhu3oxkW7c6tCnaLdoLdHNZ7zRowYI4lGqWUkn32QaFXWq
	NwElS1iS4bYtlEyLq6KpEEB/YiBXZczwyLY4zpm908k+0EDR+aUTIq6dCq7+mwMSfCOfcSGhg/E
	ZPYDJJgXnJJE6CSP87aQncRAJGHyubSqdlsXUQM+gK/FWoNLPTA3HY0YaTup0Mf9KBS4rLG7Qji
	8IocbvxP9ScDJWufL/S6vyNmGxB9/Bq3S3gdzErdC9EQY=
X-Gm-Gg: ATEYQzwx0PdTnOVzlQPDOvEZLNkEewr4eFpKp+UbZ3l5xjVprLPZRAwil0AUSJSqmfs
	HhlikJFrHiEkIoPV8RAVE0H1O3f6/XbRNFzr1IEiGEj0MyRBQv2lO/WDBxdKykyHNnZzNF7meg+
	G35O/DmFbVg9ZkKw9lYo6ypKUlVf52jXH5/FhORtAquYcGojT9U5VuNe1DESDE/byoWuqXk5G76
	KPO
X-Received: by 2002:a05:690e:d4c:b0:64a:d1bd:8c64 with SMTP id 956f58d0204a3-64c789c7d59mr7362961d50.36.1771872988436;
        Mon, 23 Feb 2026 10:56:28 -0800 (PST)
X-Received: by 2002:a05:690e:d4c:b0:64a:d1bd:8c64 with SMTP id
 956f58d0204a3-64c789c7d59mr7362939d50.36.1771872987892; Mon, 23 Feb 2026
 10:56:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218225617.354858-1-andrey.grodzovsky@crowdstrike.com>
 <20260218225617.354858-3-andrey.grodzovsky@crowdstrike.com> <aZwbhsJ1PgL21oXr@krava>
In-Reply-To: <aZwbhsJ1PgL21oXr@krava>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Mon, 23 Feb 2026 13:56:15 -0500
X-Gm-Features: AaiRm53If8q9quJ3DmtY-96gZEDHM_qLBOdArr2UAKSMvdSQB7Vqql5GkvI0SDU
Message-ID: <CAOu3gNhZrtgVU=Vt-Eu972RL0fh9j1BRRt0QYjwN7QnfGQAjaw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next 2/2] selftests/bpf: Add tests
 for duplicate kprobe symbol handling
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2NCBTYWx0ZWRfX3ZqHIr0FbHbX
 NTl/+uqcdAw2Zg7e7R+tUmY6QZLuzHoOrkjLUpXDcFI7Niw54rMtMbILgQkLWYAxGi+gUtH2hRg
 2DmZD3Uk7W/S4qmU69AcFOgxJWlNsDn53V5WwafzsBaR0mZiEebGKgH+3CAPNsOePJ3yDPYupWc
 6lmW0CHRNmWw0f+HYES5DAD/nkbeYhQjWX6fcGj80HRor7nxbqtu7rr3Gc3whqgw8CSjVDDdSph
 mXcU4eeshdzgOIYdSUj8HWwA+YKRiFKLGvPAGRh06IGviOf7bwuWRi8vlj1iSXHIVmwv19STGQ2
 lp1p1NdDihXF+KQD7J8g/5tkjrrCKI/WIVD2jpT0MB52pWMLF2TkaEH/lYPtJO/UJoWTvnedHXd
 35wa44niI1qBFpn8bZLeJPgqP7JPPwnwxR/R0X+8xZ0F+EgxGu6u5KOfL7WYwIPjLR09Q5wwnqg
 ADwAVrLD8AR7xj4MyWw==
X-Proofpoint-ORIG-GUID: oUz2B-5YgPSQuOiOuHWrZ3PQ26v0s8Qp
X-Authority-Analysis: v=2.4 cv=UoJu9uwB c=1 sm=1 tr=0 ts=699ca30e cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22
 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=rytgDo7t5E_5Z9sAIMUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oUz2B-5YgPSQuOiOuHWrZ3PQ26v0s8Qp
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11710
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230164

On Mon, Feb 23, 2026 at 4:19=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Feb 18, 2026 at 05:56:17PM -0500, Andrey Grodzovsky wrote:
>
> SNIP
>
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym=
.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
> > new file mode 100644
> > index 000000000000..98b3e085ae90
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
> > @@ -0,0 +1,45 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 CrowdStrike */
> > +/* Test module for duplicate kprobe symbol handling */
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +
> > +/* Duplicate symbol to test kprobe attachment with duplicate symbols.
> > + * This creates a duplicate of the syscall wrapper used in attach_prob=
e tests.
> > + * The libbpf fix should handle this by preferring the vmlinux symbol.
> > + * This function should NEVER be called - kprobes should attach to vml=
inux version.
> > + */
> > +#ifdef __x86_64__
> > +noinline int __x64_sys_nanosleep(void)
> > +#elif defined(__s390x__)
> > +noinline int __s390x_sys_nanosleep(void)
> > +#elif defined(__aarch64__)
> > +noinline int __arm64_sys_nanosleep(void)
> > +#elif defined(__riscv)
> > +noinline int __riscv_sys_nanosleep(void)
> > +#else
> > +noinline int sys_nanosleep(void)
> > +#endif
> > +{
> > +     WARN_ONCE(1, "bpf_testmod_dup_sym: dummy nanosleep symbol called =
- this should never execute!\n");
> > +     return -EINVAL;
> > +}
>
> hi,
> this fails to build for me:
>
>   CC [M]  bpf_testmod_dup_sym.o
> bpf_testmod_dup_sym.c:14:14: error: no previous prototype for =E2=80=98__=
x64_sys_nanosleep=E2=80=99 [-Werror=3Dmissing-prototypes]
>    14 | noinline int __x64_sys_nanosleep(void)
>       |              ^~~~~~~~~~~~~~~~~~~
>
> jirka

Hey Jiri, ran i on my local mirror of CI repo  with latest rebased to
origin/bpf-next_base with command
tools/testing/selftests/bpf/vmtest.sh -- ./test_progs -t attach_probe
and (arch is x86) and eveyrhing pass.
Then i also ran in guthub
https://github.com/kernel-patches/bpf/pull/11138 and the only single
failure i got
is during runtime is some unrealted test failure.
https://github.com/kernel-patches/bpf/actions/runs/22318486040/job/64571209=
293?pr=3D11138
This seems to be because of me defining sys_nanosleep duplicate
without static qualifier and so if your
local build has -Werror=3Dmissing-prototypes,  this warning cause a
failure? Do you think we should
add static here ?

Andrey

>
> > +
> > +static int __init bpf_testmod_dup_sym_init(void)
> > +{
> > +     pr_info("bpf_testmod_dup_sym: loaded (duplicate symbol test modul=
e)\n");
> > +     return 0;
> > +}
> > +
> > +static void __exit bpf_testmod_dup_sym_exit(void)
> > +{
> > +     pr_info("bpf_testmod_dup_sym: unloaded\n");
> > +}
> > +
> > +module_init(bpf_testmod_dup_sym_init);
> > +module_exit(bpf_testmod_dup_sym_exit);
> > +
> > +MODULE_AUTHOR("Andrey Grodzovsky");
> > +MODULE_DESCRIPTION("BPF selftest duplicate symbol module");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.34.1
> >
