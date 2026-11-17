Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794954607;
	b=Tzwc+ldFkJ/zjkJxqsStaWB3jAS9qt/0BSoQ73geSrv1eXc/3SMDXoX8kMr5LMQAtqa/
	 7CW7b6dK2vzivqEb8kTechV0S0szZKDBWUNqRk+VHzANii5hapkxhLrku05l/7qoSuLkg
	 flK9dTqboKEK4/16BHj39tkC+tn7LOsQoGH59Lfs7FSLJwUy1eASjZkit8pawbcSZoAyr
	 v9nAmxxG04rUfcB08AWomgNKwkWaRGWlJxh2RkaCLgPdH7aZcb2Rv5zV4YaqgHGA21R6L
	 CTPepFlACnvNbJKUKkni17lNdYk0eZ02Jb9fhDfvMYIphZjccTGH8B3E/xMQrWZIS6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954607;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=KyDWO0/aXgj9Rt69ltOENPsFV1jksEPL0QStiZFNoLw=;
	b=0IwiUVXYoe+auoqHnITo22vjJRYjKagimKMJbpnqRofRmU2ltUV8BKv5lW6Z+iGiMoku
	 GCDMHUfe+MmvKupO72jBaygx7CSYoWYN10WcYheAST7hTXeR4jPCEgBh15BLdF2EEeghF
	 Eh2OFsVBf78P70jv7CXKUE94h9KFUXX2CXkh7/+9tCVdMaP6yPr5HrHVQHSk7TpXTes2j
	 1vpCahwe5ozwxv+SfvLeY5iXOPNmuO0VPXRlqNWkxYCcronDSiGhCd/BK8XxZj+qpv98q
	 xsHUylWyK6MaAApK5rO10AJj8QECpoM49Vp/ihUEpZkidS3OOy1GhEKCuBVhQ2cIEDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=bOfEnIBU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3D606A336
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 22:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5B3D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=bOfEnIBU
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AHM25II3825575
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:30:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=KyDWO0/aXgj
	9Rt69ltOENPsFV1jksEPL0QStiZFNoLw=; b=bOfEnIBUXJ7bXz2NrfMubG5jwGR
	6jN9LTRddaVvweRF6J6poXO1rNj6AwMta2gKHOV3hwyI88N0Ig55OW1IcebZwrtv
	mc6yE82eh5XbzOd8B2PGTR28CGWx1oj9Ay/mzcEzSVSMkGfaG4LYgl+dpJWjuvvD
	V1ZmON0tX1Osf2Lm0wPDir0fCLzcZuRoYUsO1Iy4vMbA9POOA+6JH40mOWi3TCsm
	dRTW56gk4loflTT37NNmVrKcvR2hIuxQKe3hfu01wDEigH9osq5WP3LFJMTv0UCJ
	vUJBimgVSMDyiDFY/PodREJjfSxqnIOleJ/qCq82tGOD/cfLXNpVqmZmpEg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by m0001303.ppops.net (PPS) with ESMTPS id 4j0pb2p5hr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:30:05 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdb8e8bccdeso157978a12.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:30:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794954604; cv=none;
        d=google.com; s=arc-20260327;
        b=ETV++wRaeDkshRx0p81OiWW/rDjsWtXXhTy+ll++n0kRGQs/bQQArHRNJTe8bTyznq
         IENu7Z8DezPZOfUkGT2Nz7B5Ws9BXtA+Lseyca3Tv/eq1MoOGhaNwBql+yDbWZFvg+jZ
         JULN1BucBB8wt+mTZzL3ribocVP+u2bi7Rvr/TQXEFZeu/bz8/ew4HisSjzOm7gc/HxB
         YqvxEMBV8nWbirRq2hh4VugtLlkkZ+S1V+BNPMHP7ymcJGquFzl65wIP3pTw7DY3koeN
         fT3MaL/rNZ1lQrBCkUT3qysjFYdpNzwwhKjM/nC90ATRqFV9B/3KhES18KKxzoxUNjqr
         E9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=KyDWO0/aXgj9Rt69ltOENPsFV1jksEPL0QStiZFNoLw=;
        fh=Kol6QdGt6ODgYZLHruW7LVa/T2cfrq4K5P7ZTeUjhh4=;
        b=YCh9D7pAYlXpJb/GsLBk7QEU1m+9mLK+5bTbDctJqZuscumDZgblVq5zyuZEdN6q3i
         ATs2MCJQisTY3TIZAVipoKOPA5Ook/4l6x3vyBdYMy1w5SVu5GrUtw1/w9QVCrmqxk9B
         3qKyjAxzH8BrLYka1dcZneTHMi1U1qFAZxHjB7ZzFmJi3TJrDDNYZ3Og88zQk6iKFk2c
         qZnQWOI+CIbK3gULxSKsKiSGaYP/0yQBViNhFThVqZfjcUAInEMCHdEar0RwYiStsRei
         8BPQudyZKXtpfffWtr6dC0cj02FJ6bcNqQUksrnM9eBoY0by3CBpJGIGtoupcKFqAyC6
         4/EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794954604; x=1795559404;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KyDWO0/aXgj9Rt69ltOENPsFV1jksEPL0QStiZFNoLw=;
        b=Q4/NkrEwIGA7ABsDjpInQUBsaaojgzKsCxUQbx1Uz0Ta/ntHxG0Xm/zE1tE4yz/vRZ
         mr6WYxMBlGiuk9rkknvUnP8ot77UmjGigmg5LO6xF3Zqq/I4KaIv1dy3Ph6Dp4+xeBVN
         gfBryX1AvJpTHic1XorxDp7LOlZdMVlLnBmA/GnNaP7eMq9EVbxhjaPVQVDp7YtG81W2
         f5KsrR5iimLsSB+BiKkrboS/x57xSEOYfkl1ykOtdIXRboczh2lgxXYb/g1vqGRLmz7n
         9FMpjcHEoSLyj3+jQ+ivcJotD/qzUNUsdjMbmaDYG/2S8msxG9sMv75htxlYXX/Bbs/j
         bdcg==
X-Forwarded-Encrypted: i=1; AL+hErFtK10wi6YVDjQU0JEHc5jj0QQm4v5O/cYulsobsbD+rAMr8bQN4VrflUpIkneHcYvn4oA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qGy7UUoZL27q7/pgW/Vro1xgM9jreRBpavWjdol8n/vgFeRuE
	RCOVyTMm8zLtSjKFY/XwDaJoNE46Fa+hONeab8APAVuoQExyIPlmI1LQEPsI8reyKczqfKaOMJS
	k1ht+G22kNdbqinuGqIQSLA7urYfTfXm5V5juHyvOrBv4PqOol8dLVv2gMxT0Avm7IocixMsTAm
	cD2gIuUivpidWLh9yi/UmZgz56FlA=
X-Gm-Gg: AZFdTZftA8/u2TpFeLlILAkaocLuVJW4ZvSiH3lcfr3NskOdu7oZUED4a5cSLYTgmdH
	iLQFkhCiDj/rDiEXpG6bkn/WwvTbxRM8MtWOF7z4vhPixDfgZwCVweo7SpCTGCoRqqf2pkGY9Hu
	pBVvULH8fTleSsodecRhJdiZFOGvCa2vg2Qw/GdYcw5cWKuo9GFAym7kitRHFw0AHmTX55Kjp08
	O1rgiUlGJBElSsC4ZFavEmmb1GoiF2+yNTBj6gtclOtJKYc3po=
X-Received: by 2002:a17:90b:2fcc:b0:3b0:b64e:1e34 with SMTP id 98e67ed59e1d1-3b3d07d93eemr814947a91.51.1794954604495;
        Tue, 17 Nov 2026 14:30:04 -0800 (PST)
X-Received: by 2002:a17:90b:2fcc:b0:3b0:b64e:1e34 with SMTP id
 98e67ed59e1d1-3b3d07d93eemr814926a91.51.1794954604046; Tue, 17 Nov 2026
 14:30:04 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-8-toddfreed@meta.com> <179471270091.2199510.4320994626979041884@kernel.org>
In-Reply-To: <179471270091.2199510.4320994626979041884@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Tue, 17 Nov 2026 14:29:53 -0800
X-Gm-Features: AclHuK8ozq1AL-AsYPXNzCLCrFAtXWz49sr600reWw55cTUb-tnGMH92_LvEb0k
Message-ID: <CADh2yMwoR3ZJUwCSbUuY85qPN=c-TKqb6BZeB87q=B24tTTaRw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 07/15] bpf: don't redirect decrypted skbs from
 egress to ingress
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
        bjorn@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        daniel.zahka@gmail.com, donald.hunter@gmail.com, edumazet@kernel.org,
        kuba@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
        john.fastabend@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, martin.lau@linux.dev, pabeni@redhat.com,
        saeedm@nvidia.com, horms@kernel.org, tariqt@nvidia.com,
        weiwan@google.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: yxXbP3YAYljuVBAgFSdv70xX5F6gx8sJ
X-Proofpoint-ORIG-GUID: yxXbP3YAYljuVBAgFSdv70xX5F6gx8sJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4OSBTYWx0ZWRfX7JXdYGftHPCA
 l2h57bXLlf/D6Ro8iBxwqzij+z6/zhmN2Qnfj3b/NCLh3ECuNi9i8UNH9FOeNrIi02m1oQI/QIL
 WPDtDLf82buyn122QqKKTBgYiWmwmv8=
X-Authority-Analysis: v=2.4 cv=QfLzLcbv c=1 sm=1 tr=0 ts=6afcd56d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=DLdrzcY1xBZ9M_96H7gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4OSBTYWx0ZWRfX2W1ls9h4ywLO
 n7r9U8OKGvFRIpwLkflqRNGhI4UK6is0U0d71v/pIyly9KZeuxnOaJPcs+L8Nbd6ohcZ6FYnURO
 oN4gmP29d/eJTveioSkz/eYT6V55rPDBZAwMsTNIkO7Sh8GGIdnrqtesXZGJh+5MJrS4EUBa26D
 jWwCOBT7gZoyrBesFNz43VDE7FCNBTcoLPlBiTKu85xICN6lXvyAQEo0EJqtYG4/V+xiwJNg0R8
 COdfdGArm1yxmp05EH1xcOp1q2Uzgd2KKG3vDh5sPiYtwFNjYEGM9QeX5wi5ELvUItTmdO8FkYt
 qvydI0O9NGxobKkD6UusvsM8zee26+s8b+fFj60P73pik3ESjv85gfdhSyt9ecE4q7L652+4mAD
 g+v2yYmu92OKRHJ/36mjmilJgEd4rBFzdX7TLyjrBQrH5wy/pjXYbS869T+XhAHVMaNjxgPSSFn
 bAKxmcRcNekzvIEWNXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01

> [Severity: Medium]
> Is skb_at_tc_ingress() a reliable direction signal for every caller of
> __bpf_redirect()?
>
> tcf_mirred_act() only checks this inside a tc hook, where tc_at_ingress
> is always current. But __bpf_redirect() is also reached from LWT xmit
> programs. lwt_xmit_func_proto() gives those programs bpf_redirect() and
> bpf_clone_redirect(), and BPF_F_INGRESS is an accepted flag:
>
> ...
>
> Without a tc ingress hook on the host-side veth, the same packet and the
> same program get -EINVAL, and the packet is dropped.

Real finding.

This patch was re-posted as a Fix to net as patch2 in the series
"net: don't redirect decrypted skbs to ingress, psp time-wait validator".
This path is addressed there by calling tcx_set_ingress(false) in bpf_xmit().

-Todd
