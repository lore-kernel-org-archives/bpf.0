Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C220468E
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474430; cv=pass; b=AI7M3VFDXS5t9wYHsMYHRNW4ZikJ1XOZgNPyp7cDMwBuhEy90+L6IiofwiL4zN9HAHQf5IkBQM1zfXYBT6tFNtEStd8mPyCY8KRULMjrWxEK1ZlSUdlI2z/9iNztGfZMzXpFp6qdlbx7qRdUN1wkCesPXaGgnW88O/deWgX3V0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474430; c=relaxed/simple;
	bh=Q/aQt5PVJHr++XQKsok9pL1AZHyD3x2U3ZlYZarAK30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5wOXVD2+VQB1Z0/I5w6eIGwRwPiXaPSetLdxTFJuAjmmK2ztX+uJPxhOCBD1xRIuqCf42+8lC8LSvGmM/QzOudIuiDAUWorI1nVTCIkbdMbmQEoP2fgmUJxVerU4ZJXnGomnn5r3ihAyICh3lq9uNNcZlx2fzGKsWbqQ98F5vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=VwfWPS/0; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=mccwYJ5a; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="VwfWPS/0";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="mccwYJ5a"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622H62mP1594320
	for <bpf@vger.kernel.org>; Mon, 2 Mar 2026 18:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=Q/aQt5PVJHr++XQKsok9pL1AZHyD3x2U3ZlYZarAK30=; b=VwfW
	PS/0n8BGR9928w6TadcX5yrXnmKeObeJQlvUW3GnP5LLIDREGe/iy16Y28tQweFT
	//ziFlcQ2AkEJEvIS3Ax9qge0L86WqftTEXtnlSL51US1eIhDPs8gxcJIU7hLXLc
	uHY5T5sEtQJQIDk5jUvtEUOCdP0kujkdYppeeksWuQg3fvViK6Y/rwNEjmAwExZz
	ODXiBU2rI42zaS2/qEeMEYvwdm5WzknRNFXNgB/YxxABcpA6cekw6MQpoCVUhUEe
	od8jq5v8le5HCtx8Ao8u+7ehJtN69puxLiSwjGSVCl0bsSAnEPGn0od0da0w7Xes
	SEduEICCFvT7v2InqA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cmbkwdj9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 18:00:28 +0000 (GMT)
Received: from 04WPEXCH011.crowdstrike.sys (10.100.11.81) by
 04WPEXCH016.crowdstrike.sys (10.100.11.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 18:00:27 +0000
Received: from mail-yw1-f199.google.com (10.100.11.78) by
 04WPEXCH011.crowdstrike.sys (10.100.11.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Mar 2026 18:00:26 +0000
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7986f771f69so61934087b3.1
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 10:00:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772474426; cv=none;
        d=google.com; s=arc-20240605;
        b=QFbsJL0IF5e609Ws7jDAd42R3HOJDnOg9xoetNes6qrtJDk5UUdPBgE3X/1Y4Kzpvc
         imtrnPuURuFutAT5nA3OsT65jyeugWDvxJWHOCMCZ7u4tJ4x4doyS0f3SEp0sWTvLNDw
         rOayORxgLNZPikEzwhRIoNfWqIWySIaMy3priBgaPeesHdJA6dvj97D175b+Ej9Y1sKa
         WkRO4MmF6plP/oht0z2+q9mo0QgUqT2itFRmtTqq6OzkZMXLbPOX4NgYQaGEJLYvaYOO
         StG/oG+LyyEXBPz52gBAw729cQNUEwtPi7SSXYYWNlAHlDdZFftALuzSvl4lk/azMv+H
         RVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q/aQt5PVJHr++XQKsok9pL1AZHyD3x2U3ZlYZarAK30=;
        fh=SNorWcmTvo7qPYlkEwm/qDKRLOcwcAJ4fwsGKOJ2Nhg=;
        b=HQ1nT8zNxeBBnnSBkLUGN7sjioyh4Rj5KTQUnJh3doXinL8KwTHowTCF9Oqwt7vQHS
         AqVw1+rrKQ8xqdJR+oFQ4waZ9/Bzu0Zfk2gddj7MjqyogQPGwLwgxjtX14Ogv0tdl1GY
         +MP/l5OgZ7kI7vjARXGFGYxkS7j0qrw6Dt/1oHP3/Ot/ragFJ/FcLQ0K7ELkY0nWTrFQ
         nai6ccvKGTRwNS3IXjMULEw3igDpLLRHBmZWlReKkH9CxlgFrQsOgpbdCnd/Vv+3TvPV
         rdO3oIaRhQfQ/zjVtyXcLltwAii5fGOSJZG07pZ9R13fqChNZhR/AvZEFSYjq9b7Qf7Z
         stYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772474426; x=1773079226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/aQt5PVJHr++XQKsok9pL1AZHyD3x2U3ZlYZarAK30=;
        b=mccwYJ5a8VIL1Tt7mrSV5ggQ3WfvxxtTZ2Te3y2nw6y7MzXYwMpzB1E1cdQMWXF+rW
         Ia31rEJny/eKyuf9c05H2Ex8rgusZiZmcZVXytL6S6rdjHg7otzvYv8AWrEX7czSnvuz
         DVd/HeHuCFc1eB+1n7peR6+lIjT6KjtVFt2MkhKEERb0DjQEBtzSAnIOqxRmHFb6Pq0s
         CRSuoOUsw7B9sj43uPD+I8hBdYgtLjlwIxULJfFBT7oBNrHXeX/5kS8o1jvZYUMwb3pn
         EQnOl5fohulVwQC3mwaAF1VD4jf5O7T4MSnaGksNELBHXjRbTXohgCaJ4ihj+gwsHlh6
         y8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772474426; x=1773079226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/aQt5PVJHr++XQKsok9pL1AZHyD3x2U3ZlYZarAK30=;
        b=EmSRLTCZjmE/nuf+PLHyPgtc1oDoThCmdx/P3HrgTWqIQM/exPyUvGraKEoddggEBS
         bX1OncVctFNy+D5R72smg5QSZI5CBXHBgJCEc2QhWaGSUV9YCox5SPZ7UTp6aZnhKilW
         HKkLOyCNOrh+CTJpmL1pSTbfEo9WNXiO+uAWWcAXxxkbh4FWahbkyfTOLyTEsuHSe6BZ
         pqHsdYpNXWgOaD3ytSRfhnciJWYmCXTnsV0mY/VTamzfRw8UqCA+cojDomw1qgovagXn
         Aeijx89eakTEebQGgw6Wacqvzd3ltMwAHtnC9w++Y0BupEY42bzzHv+s2bMnhynjd5Vd
         HWYw==
X-Gm-Message-State: AOJu0Yz381F4m6fLv7UvkRpmEtiu8NDB2rg1Iim5oAHlSmTjn2hbXWb+
	Cba7sh0PggDt4akTOUgTC4zMKPPUbIFy4SetOygC6UnaJiVC92Uhh7mL12W/ANLIAFxESwCY7FV
	qkyVNpZ/ARfw8WEQCj7++GFPylXPQUc0yndzwAHI2O1tH29Uk8rYWPhy2KmtNzJQlLtuShTpkQ2
	LSfGcofyL/O4jWtLWAF2i0rPxIVtF2vjwVZiA1FH0veaLRLsj1+xwRpw==
X-Gm-Gg: ATEYQzyObZtRMiAOGbuNdr/9gu2rQzA7iuzfnPKc2fmZxPEQvdnK+Ma5XnWXQkkw/tR
	nDUyloKk3FRbtUjPC3B3mH0PnYIfBUgOAqLHGFTZlBshN5Ls4g0Jv6AokNCbNDLpWevOUOY62Xr
	fatWClZfH6dCVKMOnF7piuC58DgwgpMzlEKuK9jgZhd/fYSKG2GVLjx+iJcu9uQcrmdXecwd6MO
	MYy
X-Received: by 2002:a53:8581:0:b0:64c:9ee6:1ff7 with SMTP id 956f58d0204a3-64cc2ec651fmr8267074d50.17.1772474425997;
        Mon, 02 Mar 2026 10:00:25 -0800 (PST)
X-Received: by 2002:a53:8581:0:b0:64c:9ee6:1ff7 with SMTP id
 956f58d0204a3-64cc2ec651fmr8267016d50.17.1772474425021; Mon, 02 Mar 2026
 10:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com> <87o6l6e6td.fsf@cloudflare.com>
In-Reply-To: <87o6l6e6td.fsf@cloudflare.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Mon, 2 Mar 2026 13:00:13 -0500
X-Gm-Features: AaiRm53JADr2PFbHAdzOiPHNYtrjmhka4oHQHSkhMU3e00CqwsJzEQjLMls36-M
Message-ID: <CAOu3gNjBHokznoRKD1bY_zdV8KjHBJ0-tuLCtWLoKBy1N6vnpg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next v3 0/3] Optimize
 kprobe.session attachment for exact function names
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-open-source@crowdstrike.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org,
        rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0MyBTYWx0ZWRfXzk05bTA65Aih
 UrEU1QQxWynHT6r6PNS0EXwa+a7vsXIN//Sr+VaT8mgK5w0IrUkAIHckyODPn3Pv1meDSXD29NB
 VjtAu8ECUpJR2A0UlP/0V/EtvFr6SY/ahaeK2BvxDkLcUYxykDeqDN9RFuF/qv1KcacTA4CjQOg
 aYsnoNC3uOHUW2bGDC9Fl4u0ZKoMeGTsZTLMNpr9yCJMjdpXK0FnCccbSkD9SdWu4SptWALnYXf
 YCK7fBOU18rnY56CYq0bX2mTCgbJ5yZAdmryTlNOiLQNsfLV6DWkGFwN3vuhHhVmH1XtpDIrG5L
 9LIX0G36MEtOcjMmEEY3I9BZrVWIb6Uyr7MnUsly/rACE7/88mtl4fqGj+Z01sgL7cv8Eq9JZ0V
 Q/+xs3vYIDpKHngyqDvq/E0VMpmbInTy/r/ggZ5LYF7TAmNBdt6dHEY3kTGZ3+4oSo+IFF3hUaq
 ZgMkgGsEuRXtA3YgFwA==
X-Authority-Analysis: v=2.4 cv=M4RA6iws c=1 sm=1 tr=0 ts=69a5d03c cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22
 a=VwQbUJbxAAAA:8 a=EG7W4yiQAAAA:8 a=eitxDzI_jGvlV6N2DNYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: u4vUAlgLbWAWVm1UhihIfRp3XdvXselZ
X-Proofpoint-ORIG-GUID: u4vUAlgLbWAWVm1UhihIfRp3XdvXselZ
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020143

On Mon, Mar 2, 2026 at 7:48=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> On Fri, Feb 27, 2026 at 03:40 PM -05, Andrey Grodzovsky wrote:
> > - Patch 1: libbpf detects exact function names (no wildcards) in
> > bpf_program__attach_kprobe_multi_opts() and bypasses kallsyms parsing,
> > passing the symbol directly to the kernel via syms[] array.
> > ESRCH is normalized to ENOENT for API consistency.
>
> FWIW, Ivan was also trying to make it faster from the kernel side:
>
> https://urldefense.com/v3/__https://lore.kernel.org/bpf/20260129-ivan-bpf=
-ksym-cache-v1-1-ca503070dcc0@cloudflare.com/__;!!BmdzS3_lV9HdKG8!zla5HijIg=
6Vbdu0M8yoWocdwUD_o1-XyD5HUD7ZHbjKt9D846oT35Srz6_uXjkfS4eSc_i-lOw6IllBHvfaZ=
gPHdXrKp$
>
> But, IIUC, with this change we're not hitting get_ksymbol_bpf at all.

Exactly. Also, note plz that patch [2/3] includes an extra
optimisation in the kernel ftrace path too.

Andrey
