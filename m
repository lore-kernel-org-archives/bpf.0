Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793841180;
	b=TFqlbo/mCJNNyVzH1s0IFPJq/Y1yDzOCFEef5YKK9r5MtGrG4tcgASeQPjLbtTyfVRW2
	 hod/iWwFUWLNqsHymiZCuGGSSdjl/6OI8bU2oKlJ6MBjdojMRB/kSezDGiEHIZRIEuRDD
	 9jCeeOjuL1jpi1is6nMR8F7m344iMmQF/oylQT6eqW0wz5nHFKw6qPJv4RZGnYElfK1L7
	 pjNBU6GgNyjGjc6igV/ilXYnJTdDruJ0u5nSWDQEq2okhOtP4vf5eUrRTu5KnzYi5Gx4B
	 LnfzMpPk1Nufx/O9D8q8Enmgdv9vK3x5aJlJqPZgFwYj4jRWnnD8NUCk1/38uKFWhMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793841180;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hIt8TAyX+Lmjam3WJ5VcCBLMCU74kTFlZsoDKCOx2ew=;
	b=T24oaN+lCbieNGZLwc5vIwJ+lpmHBBL+46OwGExxQei+EvIZzetdY0M5c+6LZJ2R9w3C
	 tR6IMM7sErAg+TMicgfrpzhPC9Ei9akLtHtduvigRSaWabg+SnFdy6i85rqE/Xnsu4pWa
	 jsrFyoynoyqOoUdTx7jg2cgh83cTZPEx+GhXKMcYy4bLmk01XKTubrZWS3K7XxCzJWT4o
	 CLjiSKOpa9SAUupkbpYXeIrZjFVU+l30Pyf//tRM88GLbhtvgDw7Y5Un6nx01svL+MI4q
	 nXFqg1PRzyndIwOUjZi/5OxzcdEfUYd1t9BqthjmBVWAsdSFZMBRkpOlRSVoSTZ+TBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=temperror header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=Ljmr2yxA;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b="Qv/SLtAa";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0083606A328
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 01:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0083606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=Ljmr2yxA;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=Qv/SLtAa
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4JGPRB3591703
	for <bpf@vger.kernel.org>; Thu, 5 Nov 2026 01:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=hIt8TAyX+Lmjam3WJ5VcCBLMCU74kTFlZsoDKCOx2ew=; b=Ljmr
	2yxAPF7iUa2TZAjVy3Yylixta1bGAqtvf14wzC5c9JkDRTsjmV4zyWELueHGimgT
	vXf56dT7raWdvljBO/L28JDlJ/gtCOMPzrkbyNbIuyweR+nAFtgCFZN6Z67TQDdL
	iYs5raTWS0q+FdYtaHyAAUbDd23dOFdcUKp9blmx3W1TswVtytsN9uhajK5uWV4u
	/+XGrpHl1haT1NeeukS88z9c/yG3N7Guq0t8Bo0EqvCZO0/uVBkcNqyf6ikIKz6c
	VVZA9sfBz0GTJwZifO2Ks2hXZxOk7cfOWCEXF80ySd+fnP6Qzns1UkItaQLbvuzr
	1feu/ToU5R/dQ6+uWg==
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hqtrumej1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 01:12:53 +0000 (GMT)
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c42888c50c4so63809866b.0
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 17:12:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793841172; cv=none;
        d=google.com; s=arc-20260327;
        b=TY1CRXHDkWMum2Igjr1I9CcnG4MQwxz6OILUMfZKn/Ms/EdW9WnknyAfzXVO4i2YNP
         Hp6MwmWoKLHRzSatSJGopThNYU26HhbANSPkCshETh2tFWxSLgc50TE+ve8QM22uS4D/
         NTjPlqRyXs/aIDjSyrSvTZrhIZYTmvgCFeStDR5V7ouI/oX030goDuS6AyKMhVH7M0HM
         pR6/FddIf1FoHxiw/IoSFZR7QM8o9InDHCRYYPURBDtMqbWq/gbfGRUAabD9oFy2M1yS
         UGk65jNX28kI1evkxysjO7cPIUCW9rDKdp0xSq1i0qP+JJOghlvgHPqe8h4BH4Q/ZooM
         FK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hIt8TAyX+Lmjam3WJ5VcCBLMCU74kTFlZsoDKCOx2ew=;
        fh=ek6yN3ug5cbtrmXDb7ktTG/+OphpYpfEz2ePzRvT2Nk=;
        b=dth97DNwvVCHxSFxXIyZolJS2edhA48SLxYSq7SPllo2aV3pBpCgNGJQ5QiL+sr/I8
         dQr03aDeZL1m8L1eop6D4hV5ALAbd6HQkm41jIwRQjFVgTDEntpIQKOxO1jFs9jdOef0
         coAgNDtCbbFgPRnnANAYMlrEltsfEz0hOQOIJd/MjcodFVhSVibARClkRJgbh0Fras2i
         WZcCBLTiCeBfdMEnBPmyxZKa/Mn6p5VgzZfaok/GC6N9sxExbewmLBIQhnAOtroxyjLy
         jVpzUJqw+11P9SOO5hjqm5zYGCv/US0kNVJqGWqviqtBYJ+O2zvBQajInsr6wOPsfD0A
         YMqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1793841172; x=1794445972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hIt8TAyX+Lmjam3WJ5VcCBLMCU74kTFlZsoDKCOx2ew=;
        b=Qv/SLtAav8ptJbmnd5Ec3nVDusdUkiawGbdP0K+n1ns6GHIUFiKjnV+EsIoA93ZAxt
         /yuGjyh0FEup0DmJXqfEbx0gHQH2+A2SaEd9lD2J8/mQreiDMHX2xCJGYKQAOBUOz8mR
         uaiwZCXgRittxbIg0YNGey6WJRSjjhJSfERlXl0pC7l40ZHbPE2H6pdAb9MQBMNgGq7f
         Zxp9M91/+uZcTBpsrZM6rKu1i//aFhKkia9nWwshXmE+mhCKiU3R3VsOQybtvpfajIyw
         WGmYFgm3z8HEs4nMET65MGuV2khRHfNT4BfqWvcjJ1G9glmSd4NoZ4+t18/TDy7wALmt
         ksmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793841172; x=1794445972;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hIt8TAyX+Lmjam3WJ5VcCBLMCU74kTFlZsoDKCOx2ew=;
        b=CjSVby2YTsf0zZyHr5XVvSvLZ7Fk7iZHIogzDnouI7G4pas1WdUdxthFLjs8LLwNmv
         mHgCVflA4HvHP3qSZDSswb/P3qFHbpGFjv64WsaZVb6hnO3t5rMrwzI5PxGNf6Vnh3Ji
         0O3RuDQFx9/d4rx9UHz2l7UeMr9fZjaR6WHTrNferLiJx9wOoSfxEfexWb1owDzACBvx
         tIJI8wHQLdrlL4vUUaNAL31inYfah4sLteMq07lGebLiN2UpE7J9vuImI6t7gyddhMRL
         Frk0E2f6hLx8U2GkJ6ts44TZ7Tc2FX6kCTMcETOjpJnN06VHchMIMuofRDJ8hnhXNDLX
         0kqw==
X-Forwarded-Encrypted: i=1; AKwUvBzdwHHC1iFFKDaDCqWSVCmTA19+Lqp1mLLRf9JXc2IpN4FaYdBXN6KNvDoL9ZZLhvX9WeM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SvrU+MKyEASr0n/TV8I0BS2X3RQ84VaGrOQnIVFXICKcl1iHa
	041jsMDAwlQKt0gCOkXQrZj2L6XQOQOk8QF68LTih4AUv40dhxRfV56nR/5+z5whkEgAoWp+4vV
	y1SlFNb34WzcF7qmv5rfqNkeBYZ/BfVlip/rsw9Kfzh4wVAuAEefJZPEWd2mLHiNgpi+17sUE7G
	MhLtQ7cnWNGPRyqdZAHDxZpMVpho3y
X-Gm-Gg: AYBFou2TK3WaTtNIwuetEWmnNRvLopukQIX0DV2bq9r3AvQK2+bBCiuPLy/5XVPDh0K
	N+9vdQarDPDheqB62bke4lC2wGfNafue/nVjVs0DZkB0bfSk7lzoNe43bOwwy1aHL7KttshdCag
	8I2kmrJN3hWxDwK6gJUijk1DAqVaX5B5LF+ZvSPs2NH7QbCNZGbVZW3u6QX1ODCeMJ8uO9JiuGB
	RUTsmIsb+QjWwK/Adbpp/ws6LvyVg5NFpxxe+pbHk7CRiFY86OKPw3LR5R5eXp6BqzE24iWEcHd
	jA==
X-Received: by 2002:a17:906:9f87:b0:c46:9ca9:f524 with SMTP id a640c23a62f3a-c4ca7a6e316mr1557348266b.32.1793841172368;
        Wed, 04 Nov 2026 17:12:52 -0800 (PST)
X-Received: by 2002:a17:906:9f87:b0:c46:9ca9:f524 with SMTP id
 a640c23a62f3a-c4ca7a6e316mr1557346166b.32.1793841171763; Wed, 04 Nov 2026
 17:12:51 -0800 (PST)
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
 <DMM2FJ2SNYYO.24TEJ05OOR08E@gmail.com>
In-Reply-To: <DMM2FJ2SNYYO.24TEJ05OOR08E@gmail.com>
From: Martin Kelly <martin.kelly@crowdstrike.com>
Date: Wed, 4 Nov 2026 17:12:15 -0800
X-Gm-Features: AclHuK8EP8p_pw05vhXYbJX0eJnM2768KCmin6qj0zZtyoXbTG7BkPesBjfqqM0
Message-ID: <CAH=2mMABxvf+GNr7vUKNkGvyU-gmaXKMGNJHg4URUCW_eyuxGg@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: ENa1xG1lF9KQvTwUfP2NldxnV0JeFnQm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAwNCBTYWx0ZWRfX1LDEfViZoz4H
 1yYbI+9M2E/4bCiHv5i8a+1mbMCtJi66jnRxGcr1fAmlirEhF+d0Pp1LNZqfpITlX9kp5M6MIi8
 kxPPSGuAvHyWQHRRIEo0j1cz9msA4BVNJV1/js1mc71Q1qJXjO4ODAcqeZGggwDN/pZET+hsLLU
 X+JoruMIgwtXTL5TOBuYzNwthzb7o22i+Tt6l9HLHWet40LqEz4crS1XrkZYb0WEv1TDqZvD3km
 9z+dk8iwzh/rN7AkDQ9B6JgOuVog9ljYwU/ThZsw72V1LBNxG1OzOF967AKll/Bh0YbDtKWP0Cr
 QY1xikwz703DevEbKtOamSzl8IqBwi7TzjuTmng2G9MI4G2o7dbMsuGNhsSic9fZVT0X6B3zqQc
 /YSTUD3y839h2NM9jPe5WCERvCOTfh+zJP6pks2bRz4JhjYp12jWsmpyEbQaLRXMYqvdTWvyFh5
 6me8eFAAMDh0pV5/NZw==
X-Proofpoint-GUID: ENa1xG1lF9KQvTwUfP2NldxnV0JeFnQm
X-Authority-Analysis: v=2.4 cv=VO1IDNPX c=1 sm=1 tr=0 ts=6aebd815 cx=c_pps
 a=edIAN7ErZTGbxav20d8A7Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=vDKVRhTs-M86Ea50iKLw:22 a=pGLkceISAAAA:8 a=Air4arOKohGtuptOluoA:9
 a=QEXdDO2ut3YA:10 a=nIuFr-8touD1a-RngYHT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAwNCBTYWx0ZWRfX7XkwfNTWLfm5
 fGgbhMW49l2CG+Te6E/vK6qvCZBbcEtj1tacNano/hToqVWehFeK6wnABXv2SfZhQ+8j26qrYjp
 zjzyOfviDFiSH3CVzDdBxp4zVVxcrdBHC4dqjOB7Lc8lGMzgVdSf
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11956
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050004

We have noticed this issue independently in testing of our own security
agent and have hit the same false recursion skips on 7.0 and 7.1
kernels. More details and measurements below.

On Tue, Nov 3, 2026 at 6:24=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> Today a fentry prog never runs twice at the same time on one cpu.
> Existing progs rely on that for their per-cpu maps.
>
>   task A, cpu 0                     task B, cpu 0
>   buf =3D lookup(&percpu_scratch)
>   fill buf
>   <preempted>
>                                     buf =3D lookup(&percpu_scratch)
>                                     fill buf
>                                     output(buf)
>   output(buf)   <- data of B
>
> A plain (*cnt)++ in a per-cpu map loses updates the same way.
> Today B is skipped and recursion_misses counts it.
> With the per-task check A sends a corrupted event and nothing counts it.

Our programs avoid writing to per-CPU arrays because of corruption on
PREEMPT_RT kernels, where trampolines have always been preemptible and
thus can corrupt these structures. So for us, an opt-in flag that allows
preemption (instead of skipping) would work well and not regress current
programs that don't opt in. A verifier scan for per-CPU arrays could
also work, but it would need to distinguish read-only vs write access to
those maps.

> Add bpf_preempt_disable().
> Your test forces the preemption in the middle of the prog.
> Explicit bpf_preempt_disable() will fix it.
> And you'll have an easy way to see why disabling preemtion
> for the whole program might hurt your own production.

We tried bpf_preempt_disable()/bpf_preempt_enable() around our hooks on
a 2-vCPU 7.1.5 VM with HRTICK under an open/close stress test load.
recursion_misses for the locks_remove_file fentry actually increased
slightly 29M to 31M (this may be within noise). As far as we can tell
from the code, the trampoline takes prog->active before the program's
first instruction and releases it in __bpf_prog_exit_recur() after the
program finishes. bpf_preempt_enable() calls preempt_enable(), which is
a reschedule point. That reschedule happens with prog->active still
held.

There are a few recent changes that make preemption much more likely
than it used to be. These were done for valid reasons but have made
tracing programs noticeably less reliable (see below test results).
Although newer program types like BPF-LSM are useful, they're not
broadly available on every distro, nor do they support every function
needed for security use cases, so we still depend on tracing programs.
We'd like to see if there's a way forward for allowing tracing program
preemption while minimizing recursion_misses.

Changes that increased preemption
=3D=3D=3D
7dadeaa6e851 ("sched: Further restrict the preemption modes") introduced
in kernel 7.0: on architectures with lazy preemption support, this
removes PREEMPT_NONE and PREEMPT_VOLUNTARY as options, leaving only full
and lazy. Distributions that previously shipped voluntary preemption
(where non-sleepable BPF programs were never involuntarily preempted)
now get BPF program preemption when PREEMPT_RCU is enabled.

a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL()
with SRCU-fast") introduced in kernel 7.0: results in RAW_TRACEPOINT
hooks being preemptible. This means the false skips are not only in
fentry/fexit hooks.

9213aa4784cf ("sched: Default enable HRTICK when deferred rearming is
enabled") introduced in kernel 7.1: this enables HRTICK and HRTICK_DL by
default when CONFIG_HRTIMER_REARM_DEFERRED is enabled. We think this
means that even fast BPF hooks are more likely to be preempted since it
makes the scheduler more granular.

Recursion miss results
=3D=3D=3D
In a process-heavy workload on a 2-vCPU VM (~1M fork+exec of
short-lived processes, ~606/second) we recorded the following number of
recursion_misses on a 7.0.9 and a 7.1.5 kernel. Both kernels use lazy
preemption with PREEMPT_RCU enabled. The miss rate has increased
significantly, which we suspect is due to the HRTICK change.

                                  7.0.9 (HRTICK off) 7.1.5 (HRTICK on)
                                  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
security_file_permission fentry   1 in 61,580        1 in 1,568
security_inode_getattr fentry     1 in 59,242        1 in 1,707
do_file_open fexit                1 in 813,983       1 in 2,503
sched_process_exec raw_tracepoint 1 in 1,000,816     1 in 500,408

The sched_process_exec raw_tp had few misses (1-2) but is included just
to show that raw_tp can have misses as well since tracepoints became
preemptible.

Possible approaches
=3D=3D=3D
We don't have a preferred mechanism and are generally open to any
approach that would help reduce these recursion_misses. Whatever the
mechanism, it would be ideal to cover raw_tp programs too, since
a46023d5616e made those preemptible.

We'd be happy to help test or develop patches if needed.

Thanks,
Martin
