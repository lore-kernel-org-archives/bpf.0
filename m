Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98BB357A4A
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236360; cv=none; b=f0vwu3nP2Z+lpMzeSc3j9Cn8Ee2b54xqASccu1lJXru3No7vFgSD7s/RXMs3UmiT69oJF9bZLVndubaq98MQYiPsXfhfsCQTQgOlfFj3rdQJ/ELN4ZW/OwJDS4YJL80yfzATgvXYi8lSDg/ngs8aXvNaXARUJEn5SDQn5PPuR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236360; c=relaxed/simple;
	bh=5kZRqOhgJuG9B/HE8Ph/4js4rgGVTxAXy3MOWKyr5l8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fhaolrX5yZIL9bCakbSdvVDji48y+myhpf+M8hUF9deMEY950Z/CLNPZC7pKApeAfEGKIYn045UgpphHb7R1QuBhG0AfuikPm+1mVm6MF7FC2TLCubJpa3UCSJtD2rlx8fTSExJkveOgvw1YbC05X90wlqPEVqK72OnkdFXk7f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJORCjkE; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJORCjkE"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c16060ba9ecso22270166b.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787236356; x=1787841156; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5kZRqOhgJuG9B/HE8Ph/4js4rgGVTxAXy3MOWKyr5l8=;
        b=VJORCjkEB4dYDdfzoRNbec/URBWVQcgOK+ZDcM/SFjuG5BXMUgWRxvMxzjik+awNRh
         cFqEcbiKIa967LaG4NV855qW9QoYvS4yApaXKLK7J59n6/w7HM8v+ESYVntWIIJEpaZE
         exBqPSW8QWzLuV1elEVx0zaGzNMLxyL8P+drSPstSfeqhXz9TbqG8ngZAEmBbeK5Krgt
         EhYTuYmEIkem2+2+T884e9U2TP0FbvFy8R8p7hGutnAsIC/F3ri7+Ce5Iy2F1fL0mwbD
         x0kYky04RC9G12nekjNLgAQtr4NmETIoHCZjvbR9GsyVRf8Hua73cx3coq9S61CB0edR
         rkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236356; x=1787841156;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5kZRqOhgJuG9B/HE8Ph/4js4rgGVTxAXy3MOWKyr5l8=;
        b=QC2rjrsNqFOtfPnCtxrvg3OtwTPWCNHFd2c7plzEUKX3+tZ0hd4auFN76lxZRde1qJ
         QlE67ttVxBnJPv+dvvPWE3ZLrZNtmKzXEzXNLG75Sv6rSczAi9m8JIkp1Ey1V+DwgOwv
         VSaIHkXa5S282MIv2yhFIv6a36G0I6Yhan0s3B3o3Y+6Nd7iHWqYwNGmwLECJI2D67HZ
         07DSqcJBuXvrvTd6JGhbGQPtE2PiJFtNv5Cj9F+LvHB8PC7ZRYhZ2Vu+8RrV1SPrpjjI
         hsENmKSYEqLPzb+BlolILK121UMvBb+Vxx1AGVLYQgjDAAi8PwvwV4s0WumBnK3b8y2K
         jlLA==
X-Forwarded-Encrypted: i=1; AHgh+RqDO36VDEqCz0IkTmTWev5cNH32SvKVlx0cK51npYiVzUu75ohwJ7kY3EiQSHgSSeF7/J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZk9Q7upGMb2Qq5rueZnd1I+U1Y/8UIfYP081hxLFlxwhh1+j
	FBeqo6+n3FOddhf4aSkvov7fP9qv0dj1L9C2H11c0/GEH58PiidRqAzQ
X-Gm-Gg: AR+sD11jxhZj5IDCUKdAbMVpKJ9gEypnIuiYhMKHJnQrshfDUc5Gh4SB7MWfhra0WA4
	4p0vpR12p7CGt+jyKz2QUgDVcxzQsOLT3RcvGjlx3VYIg1gMk0N7uDhqJe6g5VkkwaAIHrj05zL
	IiuwpgW3EnhQ4WadDmvNQ23n5wtOFN1Uxqg8EX/nqzu468rjkNkDp/GNqsdn4+PKGOWLw1cQK8o
	48x0UebOZx14MaSpBf0HsZW0qFTADn+OGHt6Eo6BETntudqiLbdB7x86hgsFV/Y8d/Utn0jO+YM
	s/zk7RgddrPIVidA3Nmqib6KTA5m0nfVSjQfwa0TmLqzAhUDTXLJkrpaBhz8SfZegSOKu2769Xv
	1pzCag/8B6UcNe95Sps561TCSKycPCN7pxFmoCzpVd0XrsG90WsHi6CQLEdzPgHoWiT02W6GmUo
	MUWiA0Xhkzb77bQbhDnmpA1vHO5qcfiTTxMweizosbshyS1dED1a5hga/8nddBabiMpWdjxwjsX
	fncHPuAyHoE1q06q7+++vz0G506r3EV4yq4wgqKv2dw8+DBMaOcSlPLNdYKN5Frrbpa1DrYur3T
	x1vXAnLX7r5xKu9sMxGvcG06OEE=
X-Received: by 2002:a17:907:a703:b0:c21:4698:ee9e with SMTP id a640c23a62f3a-c244d51f63cmr580971366b.7.1787236355670;
        Thu, 20 Aug 2026 07:32:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df465sm77222066b.48.2026.08.20.07.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 07:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 16:32:34 +0200
Message-Id: <DKTUEUJ343P7.2ULJ2RYGV6XZZ@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "John Fastabend" <john.fastabend@gmail.com>,
 <bpf@vger.kernel.org>, "David Vernet" <void@manifault.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: sched_ext: Mark ops argument container
 pointer fields as trusted
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>
X-Mailer: aerc 0.21.0
References: <95d7ccc17681aa3a4a2eeb1b073f00f7@kernel.org>
In-Reply-To: <95d7ccc17681aa3a4a2eeb1b073f00f7@kernel.org>

On Thu Aug 20, 2026 at 7:20 AM CEST, Tejun Heo wrote:
> Walking an unannotated pointer field of a trusted struct yields a bare
> PTR_TO_BTF_ID in non-sleepable programs, which kfuncs and helpers accept,
> but PTR_UNTRUSTED in sleepable programs, which they reject. This gets in =
the
> way of making ops.init_task() sleepable, which schedulers want for
> allocations. For example, passing args->cgroup into bpf_cgrp_storage_get(=
)
> then fails verification and the only recourse is round-tripping through t=
he
> cgroup ID with bpf_cgroup_from_id().
>
> The pointer fields in the sched_ext ops argument containers are all pinne=
d
> by the callers for the duration of the ops calls and are never NULL. Add
> them to the verifier's trusted-fields whitelist so that they are PTR_TRUS=
TED
> in both sleepable and non-sleepable programs.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

I (or others) will add Fixes tag when applying, no need to respin.

> [...]
