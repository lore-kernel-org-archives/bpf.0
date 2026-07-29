Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540683EC800
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337249; cv=pass; b=eXQ1tU2VuII/BT13DxuhuR0QGs2Fq/SKdx0hIlQ97F5WZNdglgmzDaezXgwr8gJ2p1Gn2HPOLZ+tBa1jyt9yfddx1huu4N/6efMxgsUl4D3z3O9cls9sqekL5g4DIo9K/ZRZQJtx6q8vWeQ3JiGa13oFhv1tFGHT0EDrjum2EYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337249; c=relaxed/simple;
	bh=WoRDoEi0VL1vigksALz/83dPkS3F5vPYjkl8rzXgfkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wh3L4teOu4MyQi0L56yKF4p3P5NdRBwjgSFKomoeRAbePV/LfU6T1nLvINBHMdAeS9ETsqmYnQEqr+qV5qCDkB01E44ZOLsBooECSzGlL8Q+sdbBcPhSkLe25ntru+TaV8UuYE1SVW/Wtg68Pet64DMDcf3GSSVof8E2A9a/KfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=McQ1nMx8; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=jYaEjwpO; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="McQ1nMx8";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="jYaEjwpO"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TDkjOP030617
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 15:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=KNsIs+LJSh7r0iAi+d65HQSOE09/M+m4FY1F+mUNWXY=; b=McQ1
	nMx8M7wPOjuOLAkLDA6WuHxFcrcAStnEaL9XPowHaB61V31/WItQ/KdjBYstRpwK
	P+O5TLQc91sUMJSjuMaWZyc8qd1Aeg3A7MrBzuKtAkVZ9D2TEjrYp75iz3jQDOja
	WFnbMcZOrkrsE4DyxHhfuFuY6UhCfcM9qYgnJBF5r88ZTN1MSo+1YXmC8nwwX6ud
	fyvDRcg+iKR2WyvT8SjElYxyjfR9i80ynYuEp4yEzjRI44b5nuM3wy6zlupaiH5Y
	eslsUCM8lDphmgvIYrnuVGF0Jb4CsfC8FFNXl8wPmf/x5yjgfL3pdJtA2FWBQRUG
	vw9r71nevvUHAXnFvw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fq1eem70a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 15:00:47 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-80ee3cb097eso19091927b3.1
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 08:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785337246; cv=none;
        d=google.com; s=arc-20260327;
        b=OHEVpvw92gRildDUxB8tzdzdZJrLbzSj5H4B70APnY/RuOaVaaGw+Bth7K+jXX85fW
         C6Xq4vOaOQAyBzSLw20f4XEssZYVyFdE2pcvCWgxsCmBPOJMVYPEa9IS4rqwGEIMXZp2
         7QIDoeX9Y7NA6Ngf/QdkWi9Juo6hUh+7zZOK/EWmMcEoocLv7akfRhn6fauozjHcYW3e
         ul6pa1QfGPZyqpTiFmgklGJlcO8wNHQXQ2RHkz+qYV+egfUkBZKl8uoJtC+GgC35GsX7
         DexImKxf72ESN6T2KGv5+UsyDB31+5Bft34qpAfRaXdJl2JBxsYajbr9fcV1B39xjbpq
         CJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNsIs+LJSh7r0iAi+d65HQSOE09/M+m4FY1F+mUNWXY=;
        fh=0QRfLx7zOSdmk2TSQqT2C+F7aS8+QlERjLNnzn3wNvc=;
        b=KkcUkr/XUbkvN7mUHbgp6rDAwliYUPs51EV9td4ETr5fdgtBFEGP2EPuVJHrEX9uaS
         nIJlNVLYVAv0Hvjf8VuN7UK/RPM0KeOLfE62F5Xd9Yjw0g0P5qSzoHeNlrAHhYr17v/U
         bix/Tdesc7pvqZ5STcIp72ICsa5ya2MCoE5htv8c6i0Xa+vL5WtyxXXlfJk4hRDvyS5r
         9MM0aJ9QuHBOIAXsWafF0w8jJaKghav12hW4lYfhCfKEXoUUX2fhqsc3dpKqjCbgHUYH
         Hbk0nyqsiIWR9MOP8G7y4gNyTSRaz5+L0Dfub5InvMsvJMc7oxZE1CQEHgVZzo4x0UZI
         JfcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1785337246; x=1785942046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KNsIs+LJSh7r0iAi+d65HQSOE09/M+m4FY1F+mUNWXY=;
        b=jYaEjwpOt0oNiX8NA8NagnzYHK9Y5yd9ggDFJRYMNaeuLPXx34rvWe+dVGnTzt/oRu
         fc9xxLRZL1f2BFkYMK253YThcOZbivV07zlqauFvYvgfS6atsee5fEbVKvzFiSaw2V/s
         bWcZf53bvzO8Dhpcwm+QEvxuNio7JjUH8NIvPZAKfzC8KFvcybzPvNaa9roxUV7nOkyG
         qMmHfrhjEAG5AUicPt2OvQ0s+pFxqdFa6estaSvmLastHCGCPmepPsOVNWBNrNcAbXUH
         UL8vDRjsznZBjoH7xtJ9sWTRgpnMn7ZQu3OGKIh4Rds90MK8HONevIQHot9jMF04yIgU
         E9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337246; x=1785942046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNsIs+LJSh7r0iAi+d65HQSOE09/M+m4FY1F+mUNWXY=;
        b=B16Fef0Fl2K2iV5MDOgPHrgTbPVJ8eO5j2T+hMVgl9hCASemkq9OzdDp+WdByB0Foa
         iY3lpBzoThGaQdiS7jDBTHsSkji/m3H/WMaJbmFZLQB/mT6QzIDMznGnW06oR8gFox5k
         Gq5h9lTPMl0VXzS1AjgL18WEIv8cMVLFtdRO8Q0jTu2pc31Y75sEce3BQ4Wpoy3XPOq2
         pbyKcv10TadYt43vgZKKuRYVjkmxQfzY9mjzHqAOa8RWKKqWor1AF8EHAc+qecsGHAf/
         EGb4emmjcJ0bVsbnNS0m4sa6ii/mrUl1FTyMXvlRk+rIwVfiC/PRRhbfApfUEZ0ck83T
         cUnQ==
X-Gm-Message-State: AOJu0Ywzg8/R4josRcM2HIFkmaj93Hs+1J73kC+GebMRhi8I8G/8e90u
	Pi8PkSVSEisGZZ7KYFzGpqxJ+LuuefcjdXpGqo4gPj00lgSi/RZkDblxOCuI1LCSjkZsanham/b
	HF6U3Z5LEaMK1NIAZVotxxNFjVgvdBlG1byo3daJFrDqcAG+WQ2R6xUNC3QFlNfy4iw3HXwLBNK
	oqMEBhhTpC1xN+ksq+LpegdIVi9zaL
X-Gm-Gg: AR+sD10HHF3CNht/HaoC5HXYGGOtfqKXhbCpj6Uw+dYor0PVJqJ7c+mLdEi5lvf6BEd
	KU3Q5w8fkk5Gocz7QlbRMjtHMt6Ta7Vm1AWgLJf+CnQ9iy8/xvxl83ei4VTJdSIzjPlfNLP4E8B
	xscZUwLUjWqpYexU1utTykpbfpudK7Fa/Z9gR2GraUCk5mglCZdo4a9XU2
X-Received: by 2002:a05:690c:6a85:b0:7fe:1413:f6b7 with SMTP id 00721157ae682-81f993340e2mr37633027b3.48.1785337244992;
        Wed, 29 Jul 2026 08:00:44 -0700 (PDT)
X-Received: by 2002:a05:690c:6a85:b0:7fe:1413:f6b7 with SMTP id
 00721157ae682-81f993340e2mr37631177b3.48.1785337242714; Wed, 29 Jul 2026
 08:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com> <20260729104114.04298a48@gandalf.local.home>
In-Reply-To: <20260729104114.04298a48@gandalf.local.home>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 29 Jul 2026 11:00:31 -0400
X-Gm-Features: AUfX_mxePSJcFU2kU3VYl-YapXlBxTsM8pdNfueUNu8RCOjDR26LSYERFFJr5l8
Message-ID: <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, jolsa@kernel.org,
        naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
        stable@vger.kernel.org, linux-open-source@crowdstrike.com,
        mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX6J2oJq78QyCf
 8FFY1aGGjaWOtFYRtD/fQ5OyoEA/93eBy3/Zx+D2E4vggYRJ8kZS9LE2mzhfR/obQNT6tugs7CO
 qu2JqeLEgVs8dFjME94JCVO77eXSnsKPnHfsjsIU3qu8DCEQ24zH
X-Authority-Analysis: v=2.4 cv=a4MAM0SF c=1 sm=1 tr=0 ts=6a6a159f cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=FNDBzpQLrQZLHPu8S4MA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX39VKnfwuG0Ea
 QLkBuEQOw32ud3LtINUkz9d1x4Itgj0wqJuUYlDza/wpSv8bK86lQdLm0O9UtZdLxnkYSfVxeyl
 BFLYfn78piuKhWajW/HhQf0R7cBXqBZNzmFFZrDvJ6w8UVAuj8DvL9p0vldOAdnQ6jFLa5Fq1OE
 CYuHkafZlKGO1tX+rs7fExDPRwBwwFD+fH//uNVHlLfRTd/1vrM4o2G5xpYQ3IKHhqdvd5K9uoY
 SDjhdu+yg+Skr11kjh1QHdRqRfxSf72A3pWxoWW0/mqz613SVoMLkvVtZK/35SHF+l6L6mQO6Cj
 Imsig5ryN5rsE1ciqn+MEF2zh3End4lvLQy2J9IBBU8Lee4Xeny5TJNWEMhoPemaygyHGyhbQAs
 GNWRG77w5q/kublFIemDqcTYOuUiHTzZ8h1fAhRbzti5EMPQOLmUL1ypTuDX6dmvEYm8BZu9XAL
 2vL+w7M5mPY7h78T2Zg==
X-Proofpoint-GUID: UA_anCVJXMiC_xUBjeDtonvHPnwzSC9L
X-Proofpoint-ORIG-GUID: UA_anCVJXMiC_xUBjeDtonvHPnwzSC9L
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290121

,

On Wed, Jul 29, 2026 at 10:40=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 28 Jul 2026 20:59:56 -0400
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > This fixes a long-standing issue: kernel.ftrace_enabled=3D0 silently
> > disables BPF trampolines (fentry/fexit) and ftrace-based
> > kprobes/kretprobes. The write succeeds, the hook stops firing with no
> > error, and re-enabling silently restores it. Livepatch already solved
> > this for itself via FTRACE_OPS_FL_PERMANENT, which refuses to disable
> > ftrace while a permanent ops is registered and refuses to register
> > one while ftrace is disabled[1].
>
> The /proc/sys/kernel/ftrace_enabled was added as a "safety kill switch"
> back when ftrace was first added to the kernel. It's addition was namely
> there because live runtime modification of kernel code was new and we wer=
e
> worried about how stable it could be.
>
> Honestly, I would love to get rid of it as today ftrace has proven to be
> rather stable. But as it is a user space ABI, I'm not sure what will brea=
k
> if we do. I wonder if we just make it a nop, and print a message to dmesg
> saying:
>
>   "ftrace_enabled no longer does anything. Please report if you need it t=
o."
>
> ?

Thanks Steven, if you and/or other community members would approve such
approach I would happily do this instead for a few reasons -

1) Seems like the more correct course of action if idneed this switch
effectively became obsolete in usage instead of piling extra logic to work
around it.

2) As I mentioned in the end of the cover letter, I believe for some cases
such as fsessions/ksessions and multi opts retprobes, this patchset is
not effective and the issue will persist, requiring a more complicated solu=
tion
for them anyway if we want watertight resilience.

If you approve this - I can try what you suggested, this would include
making the
knob a NOP with a message, dropping the FTRACE_OPS_FL_PERMANENT
flag and reverting/cleaning what's possible from the original livepatch pat=
chset
that dealt with this issue [1]

One question is what the correct set of tests to run in such a case
would be to verify
we didn't break anything. For this patchset I ran BPF and livepatch
selftest suites, but
I wonder what else would need to be run.

CC Miroslav for Livepatch.

Thanks,
Andrey

[1] - https://lore.kernel.org/all/20191016113316.13415-1-mbenes@suse.cz/T/#=
u

>
> >
> > For trampolines this restores a historical property: from 2019-2022
> > they shared one global direct_ops, marked permanent the same
> > way[2].It was later lost as a side effect of the 2022
> > per-trampoline-ops split (patch 1's Fixes tag) and never
> > restored.[3][4] Kprobes never carried this protection at all, so
> > for them that is long-standing issue rather than a regression.
> >
> > Patch 1: trampolines. Patch 2: classic kprobes/kretprobes. Patch 3:
> > a selftest covering both directions for all four hook types.
> >
> > P.S
> > I initially implemented a per-record opt-in flag[5], but dropped it
> > as over-engineering once I saw the original blanket restriction.
> >
> > P.P.S
> > Open question: kprobe.multi/kretprobe.multi/kprobe.session
> > (fprobe-backed) aren't covered -- return-capturing fprobes share the
> > function-graph tracer's subops manager with unrelated tracers, so
> > marking it permanent needs a different, per-record approach. Perhaps
> > something along the lines of [5].
>
> Honestly, I would like to start deprecating that kill switch.
>
> For the series:
>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>
> -- Steve
