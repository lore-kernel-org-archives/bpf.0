Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D551FAC34
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772068989; cv=pass; b=ZkrUbhdW3OEPnK8qsGybcnfY1N1TQR93T3GPkemHZIZmyEFSq8USGZcWGlSo/wQOzA6CH+kdC4Wg2RmCnPmslJMXu31++R60e3+Ai7nH2TYd/M65652VF+A1XeoqF/K3yXIxs5gUc/IkMbfKx18ccjqpKOgI2h1tfr6eAOo4Oyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772068989; c=relaxed/simple;
	bh=oM6CMh+8rhBd+PynAnJhr6ksr6Ad3jODJTlmsQRlKsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHWz4Gv8ABfXVlH+UoHFbC+z6Wd+5+R8apHXZ6DThqu0+Ald7kHQgcbDyygS9FMRS9NGqokrezMO8uIwO5z8f222VVcLf/mMSqjR44/1+fRvtTsjfhjfVSvAKY8F3wQlFFdkm9ogp3OkVVe6giPtU5jnHCSmpC3wOlvGkijGPMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=tXsHCLJ4; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Q5MLxerB; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="tXsHCLJ4";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Q5MLxerB"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q13UvC2839824
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 01:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=oM6CMh+8rhBd+PynAnJhr6ksr6Ad3jODJTlmsQRlKsE=; b=tXsH
	CLJ4yADM+T3LoVdPgi8UuMYDqlWTAbowmGbXVLxtbZ+Zo4LU75SjgUgP/b175Nxk
	vlSVJHVdJbqF9ZZmET2nGO7Ta1EZA+AhoeLxB4uiy14gst/4Gbi19yXHD5G+1LN2
	W1qJjCgMGbilQsJPK7iZcXhmBQsibCJqIz07JGl4yFLCfb9hTOytmMC1nMcX7+A0
	ev3r4JjJFRBbf43ZioONVPAjRwByeYKRRwYxAoLhLDLFLVx7MwhoFahhLC6MIx++
	T0rTjR+0sCx/OaBGrakSEBaIxB4r8KwkUYl4O3oZW0I4NHgGqAoZbYz0+JUEgHpl
	i9wvzbZzbFwM80ZOrw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4chkgqx1yt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 01:23:02 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7986dd1b9e1so6122037b3.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 17:23:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772068982; cv=none;
        d=google.com; s=arc-20240605;
        b=Ph0soCZsExvGUP93QuZdSRXwcRGmRcqC5eM8z/5zYKdxX9z2QpY0xKW7KB2VieYZKw
         eMWuLV5O7Z9szA4+5vKFPD78abmICOMLvhS1p2v/SFNfQddz1E4QQSRmAYgFRQ/8hwRs
         msyfH9FZLibqhRKHPl7K2NmyCkD4lV1hwx345YuUyDGl7Yw5v5YBGlmjHtBP1ohAIfe9
         Mh7qUd7ypvqvQvzYhiu8REk9FEz9yAvOeNrT41+u504TDKSMujFNP08F4odUCyX+VcT0
         g04nHDcx532EmmwVrSUrSOxNQxUAq8lpC7T9ZAU3EU6Np4GpsitQRcGBdOXoybWsFYFq
         oDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oM6CMh+8rhBd+PynAnJhr6ksr6Ad3jODJTlmsQRlKsE=;
        fh=C+VYcy1dMoSMEQiy9ik4xIIESmZNKn6r/UzTfhDMOzw=;
        b=bPr6SQmX68VErBIezIXXSNGg0VwEAQKE7OwOn73MW1UBCp6gl9D0k7WqSBdWQM9zpN
         4I5ZmjZ4rLB5py+a8tbIl6WDqaKnPuopmXWn/MLiRO8rdIdhCWvLkk+vrQC+pWKR64XN
         xkXEdUG2JyhK/L0Iw9YqvhT1mOc0S++OJEnJjKpOxxV7N/jNaOhR3tkZNnuLHJopOPJe
         kg4K1S3TlItXVzEHra5/9LspodtPu/76gYMpLZKnPV/Ph2sPhGskEVIdptlmPttvafJR
         6m7Zgwwlse1E3b5A/TLVFgGr7+F3OD1x4jdTQilDOxd7tUzB/xh8SZ7SzEkjNuGIV4Ns
         J6xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772068982; x=1772673782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM6CMh+8rhBd+PynAnJhr6ksr6Ad3jODJTlmsQRlKsE=;
        b=Q5MLxerBzgRpt/8OHfnlsMhhWsrT16F6zfLZaAJnU+8YYrSENSTLU9piNdcV/0PRM6
         7jtHdDEzr58TTfv+oYFd+mwkHcWl9ERMxn3rKpX2+rNaOQV1qk2NIeAp2K+KTfgLaCZn
         VyYSUhsQm3BbheDlmyhOwfLYsTTwQqAVlJKagFPVr/p3T4kUoI03Vx+0k1iCvwu7EqIi
         GCrpuukCOMooAg5okhGxCljibrRk/zrRs6NyVcPpsD2vBcv/IDN1BUOxGneToAmbKWse
         /IF8p5NvNmZy7viShJUF++QhEFVRfUgtNeTz7gab7Vnr58HjNJ+FG/4a1FP4NTTDn36G
         K32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772068982; x=1772673782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oM6CMh+8rhBd+PynAnJhr6ksr6Ad3jODJTlmsQRlKsE=;
        b=YQmunXtTd1zs4Xt5kfJ62ynf7eg41Hoq7u53Ws03T5IerUQQwujPcinaSRwBIu+8wE
         PLi5qkQ3sd5IuxT1RIF9sgy91uXF/mnDAEcLi17nTpsBNNOIY4nZjj46PqPqfsBRuzra
         WZ1NPRjXt/InDVL/8U1UmHBamf8xNu6Wo/lwNyv+CSGP8kCiaVvPEkf4wiCNL57gvzI5
         z9NUf44aFOetFWX75y/G86U5CRV74tkUtuF65NkzfBF0k2x925xcX6Bn0YtwGa2RSZEB
         St/ihgmiQo8xo2VcsnzPZNfuJDnux3EivIGXfulhax1cy/y0xw8Vk+bXRRRzJsjc+3YP
         0qLA==
X-Gm-Message-State: AOJu0Yy1YhGP1NyaQimSfZqzjqLhdR/b3s6OUj3GcMDaYx/0n2ql0Mb6
	PguJ19CIpyVxQVd5+UdMZVpcuxGooEovaYg9mYpufR3dx4IOwTfuLq+qf9eOxpDSZwRIWAfvn60
	TwDNQ+6GzovRF+rtTc7QXTlznpeB+bd00BQ2RGcOrawJLeS4C6LNpB9i6+2AhNR6fZIYfWI0n/y
	D5NfqWZf1upiFgk6tx2defhZCg5kVC
X-Gm-Gg: ATEYQzzdz/1wZ9mi/HaRsQ3mqeUMmCz3ofG55SY4GfYENowwEHkHzfqfWQJCrvrUjBe
	ACelsj6NbRPQLHbndw8i2BJ4QA3BK+s/2v95BxD+7v5e9A2casPeF3d52evMJadGAoMCezx2JbZ
	77RMFEJgPmxKEKwKuwmDa9iZhB25jPCThxLnngpIaaq5RnzuT66zm93I4KbIP19bJJh4WtEXs6L
	+y+
X-Received: by 2002:a05:690c:c4f1:b0:797:b1d7:6aa9 with SMTP id 00721157ae682-79876e681e7mr4865307b3.65.1772068981864;
        Wed, 25 Feb 2026 17:23:01 -0800 (PST)
X-Received: by 2002:a05:690c:c4f1:b0:797:b1d7:6aa9 with SMTP id
 00721157ae682-79876e681e7mr4865157b3.65.1772068981374; Wed, 25 Feb 2026
 17:23:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
 <20260223215113.924599-3-andrey.grodzovsky@crowdstrike.com>
 <20260225064723.53bcce3e@fedora> <CAOu3gNjdE_GaEEC__L=4v44iMJZt_eBN2Se_FotCDjX0BXwi1w@mail.gmail.com>
 <20260225183220.7ba404cf@fedora>
In-Reply-To: <20260225183220.7ba404cf@fedora>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 25 Feb 2026 20:22:50 -0500
X-Gm-Features: AaiRm52JbYjl7c4ahxWsFUL_dy1KHW9LDoAbY9pOXV9qXcoEJS3eOdqghy0Sccw
Message-ID: <CAOu3gNiHGBEP2oU07fY73=qOBzLJou+_wUY-6txhrnvRo84pAg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next 2/3] ftrace: Use kallsyms
 binary search for single-symbol lookup
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, jolsa@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: T_PJ1W20gnquHrV0UzX996jcQ02Urj-B
X-Proofpoint-ORIG-GUID: T_PJ1W20gnquHrV0UzX996jcQ02Urj-B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAwOSBTYWx0ZWRfX5rWJeA0oVx69
 NA64fyKDj8srNbj7ZQoZVWEYSoR7ImfBjTZ8l22hQAeJXkhl5F8P4Hfn3+Peos6uDU2OuT2w9SX
 kYLIpeguxQAoWHqZf4vbMb4jtzDWeCuGCSljjpRXQcHTB3iNPQxHsGJtGzyREfJ5rsb1CII9naN
 vgrV/GbcUmsYDr1VPuJI20qoHiXIJYNeRc7ilis6wQUYylcS7VMNNpfSLtLd0wx+3gk6EWfPBR6
 5fIiWx9IYozfni3Xj53xBOpd6PkTvg/RzZmoPZm/Pey27ownYGu5XOHP1otsMICwys0oDK3lQHM
 3ohM8IsbmQ+/CGceRSnqTP05n1N2LIVPuTCdJxqx97eLjJj+zqlcnV99OjTfelBBPyhkCL4030L
 lm7R87khani1QwRyBaORQ0AJfxOhkRDAD7fUQ7G/xJ2GEMvLw2d+45BPLhBssVZ9T056uTRIpFg
 vBeJMjTWaRVxAYD4XDQ==
X-Authority-Analysis: v=2.4 cv=J5OnLQnS c=1 sm=1 tr=0 ts=699fa076 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=Kz1IbYNgjC_DFncX2M0A:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11712
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260009

On Wed, Feb 25, 2026 at 6:32=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 25 Feb 2026 10:25:04 -0500
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > Hey Steve, are there any extra steps required on my side to make this g=
o
> > through your tree?
>
> I see you Cc'd linux-trace-kernel which places it into the tracing
> patchwork. If there's no dependency on any other patch, I can add it to
> my 7.1 queue. That is, after I get some more time to review it a little
> deeper.
>
> -- Steve

There are no dependencies, I performed the original optimization in libbpf
(patch 1) in hopes this will make session kprobes faster then legacy
kprobe/kretprobe pairs and when it didn't, I dug deeper and came up
with this second optimization here (patch 2).

Let me know of any issues once you have time to review, in the meantime
I will roll V2 with all the fixes per Jiri's comments including this patch.

Andrey.
