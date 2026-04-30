Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34F46AF36
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571925; cv=none; b=bBVwIqndEN8GnoNUN0ZpZ14R1iZ/bFJxA88RGxSI4kacWGdC82erpEJiO3Ro3dVW54LpKpcJp6gLlugCvtNv+NlPtuXkO33amqXr+j5v7mTszyAUkx1chyT1w7PjVe6H18CBGbVKaHtMshtRMwB/RngnT3aHZSmTx2pSl2iPCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571925; c=relaxed/simple;
	bh=Kcg8W+ZTOQE+8cA7HvSd25KeCKMT9zrWl3FRkgAmEEM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=VrG5Dd94Cgbr87cTv8poU4JB0n659+NAWJs1NoTHhdnkJzz+HSfo6622U7pPXwF/HnCUvnpYbj2gK6X7GSDVVS/dQhFbiK8qPeDk27PNlNiGpCeFmzKxpp5TADki0vVk6gGMAq0yXuvCqMEDUwp+Ax2hyuGpcAAU5c0pxlWix3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uZ8wyOb8; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uZ8wyOb8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777571921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRR2X5+N0mws7NhlZiDaLMl7yupCWnFgOdxSvhMHF1c=;
	b=uZ8wyOb83tUgcddITbF9Vx34FdPW9/eUEGYzcPVNHSLnnedSTZoEFIVmaEc+COVClkF0TU
	tI/HWfCfiQWd0J6Qywj45V0OnmMVXFI0vslhiEKDhEim8rHnEhvPf7J8+8xsXy+m5HAV12
	lTLGVS4kbEyJax8ftJMBcHNgxc+122I=
Date: Thu, 30 Apr 2026 17:58:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <ddc93184e197c3f4793aff5ab72b5ead782e4412@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net 5/7] selftests: bpf: cover wrapped sk_msg ring
 chaining in ktls TX path
To: "Jakub Kicinski" <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 john.fastabend@gmail.com, sd@queasysnail.net,
 linux-kselftest@vger.kernel.org, "Jakub Kicinski" <kuba@kernel.org>,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 shuah@kernel.org, isolodrai@meta.com
In-Reply-To: <20260429222944.2139041-6-kuba@kernel.org>
References: <20260429222944.2139041-1-kuba@kernel.org>
 <20260429222944.2139041-6-kuba@kernel.org>
X-Migadu-Flow: FLOW_OUT

2026=E5=B9=B44=E6=9C=8829=E6=97=A5 15:29, "Jakub Kicinski" <kuba@kernel.o=
rg mailto:kuba@kernel.org?to=3D%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.=
org%3E > wrote:


>=20
>=20Add a regression test for the off-by-one in tls_push_record() where
> the sg_chain() entry count was MAX_SKB_FRAGS instead of NR_MSG_FRAG_IDS=
,
> causing the chain pointer to overwrite a live ring slot when an sk_msg
> scatterlist ring wrapped (sg.end < sg.start).
>=20
>=20The new "tls tx wrapped sg chain" subtest:
> 1. attaches an SK_MSG program (prog_sk_policy_drop) that drops the firs=
t
>  N bytes of a message via bpf_msg_apply_bytes() + SK_DROP,
> 2. splices 17 single-byte frags through a kTLS TX socket so the ring
>  fills to sg.start=3D16, sg.end=3D17,
> 3. removes the socket from the sockmap and sends one more byte, which
>  wraps sg.end to 0 and exercises the wrap branch in tls_push_record().
>=20
>=20Without the fix the kernel hangs on the wrapping send (the corrupted
> chain pointer leaves the sg traversal stuck); with the fix the test
> completes cleanly.
>=20
>=20Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: ast@kernel.org
> CC: daniel@iogearbox.net
> CC: andrii@kernel.org
> CC: martin.lau@linux.dev
> CC: eddyz87@gmail.com
> CC: memxor@gmail.com
> CC: song@kernel.org
> CC: yonghong.song@linux.dev
> CC: jolsa@kernel.org
> CC: shuah@kernel.org
> CC: john.fastabend@gmail.com
> CC: jiayuan.chen@linux.dev
> CC: isolodrai@meta.com
> CC: bpf@vger.kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>=20=20

Reviewed-by:=20Jiayuan Chen <jiayuan.chen@linux.dev>
