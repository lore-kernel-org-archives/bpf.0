Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58FB439F75
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937596; cv=none; b=M8remA1ZNS2rOw6/Nvf1SULs8QAL/zM86G5rqEgWxGTdY1wdKKrC/pDtakOOHh1v1uB5GIuRkDt/UD2fUX6dHaHUO9LrGYK8DT2L5vpWqm0I7YqGHulDFcx4bIiRbS6F9fE+OVz46pCh6wbA2lNAqflF9f2+84i9Rshj3jGmyoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937596; c=relaxed/simple;
	bh=tTO+7+ZgzFEwuxwpdIZgFN1E1eYqvPQIZEf5tpjIkME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6dXGCjJPUqZFbn64HYaBxXsWDbf9CCtEhjm2QnOvSco1eHRGRnB1GAJU7lBiaWMQMofO4SfFokHOsjsEb92Zp/8nWzH+iEnjHwz9iOpAxClKn1m3IgPAuAh5SkpYWCX2lI68M6eFwDACxHfiVYLF5jJtJUasb0pMO+lqu3rKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/mZsWZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/mZsWZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D411F0089D
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 10:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937594;
	bh=tTO+7+ZgzFEwuxwpdIZgFN1E1eYqvPQIZEf5tpjIkME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=b/mZsWZddQJ/lQmYug2Wvt7BcP/a9sy1Y5HnCF8Xp259t+Rcl8VHhlt3ApYPUV96H
	 uK3SfHVEDEm8I0mk9lrc6AFAenk0QEDw8uCoBztrr3eYutxx/N+VT2RNyHf6AfxAZx
	 2zUFEsobl1evSXPPxUAKjEhPAgCt8DVpys1xVoKq0xNJN1tvEVr7sfMyUlE5tgLo4q
	 cHzn6NjCAKuZvH4/A5QCUS/Eskj6IL13OoM/2G7Ov9zR8n2D/vIMBKkCkTZDEjAfmd
	 v/CmISRG6eb4MHeveLJEsphVLcFWygiz8exeTGNP5jxDkWD1T5e9Oa2mNZmjyP09Qb
	 0s9dLTj/zpasg==
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-48f0056ef38so7033387fac.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 03:39:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzRoXb7pq6PKAV9YHcw+Vud0+jBytwhnrO2Vm3E/5Cu8NkK6q5szTNG3f/MqXqm3Zoa/1k=@vger.kernel.org
X-Gm-Message-State: AFuF++mbyDk+PUx2YhtzhD5q5lrd7GqtuKJmcNadO6/MG3TgCdPZFa0n
	7CVybZQZCy6qdEBNu7QoROKJiCTmXDC53IafCpY45d4SMtby3D5iaP+2HeZVDy27MNhfQsZ5hQ3
	1d2hraJoAm21mPpeGayS5cXEp17TMSHw=
X-Received: by 2002:a05:6870:d1c1:b0:48f:e0f6:bd65 with SMTP id
 586e51a60fabf-49e15e8b5cfmr2201401fac.54.1790937593711; Fri, 02 Oct 2026
 03:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790850176.git.petalzu987@gmail.com> <5c396b7011168cd98b9812df4d6bbd00a96048e7.1790850176.git.petalzu987@gmail.com>
In-Reply-To: <5c396b7011168cd98b9812df4d6bbd00a96048e7.1790850176.git.petalzu987@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 2 Oct 2026 12:39:42 +0200
X-Gmail-Original-Message-ID: <CAL4WiiraPM45Sc40gfVjrY2caV1b-1ORV2wSXRz9mCAyF8RWTw@mail.gmail.com>
X-Gm-Features: AclHuK_KzuaoxAaxooJQgOEV52rWy5JlXa4Dt-2pqaZymTfVEsyhqo48AuRTiqw
Message-ID: <CAL4WiiraPM45Sc40gfVjrY2caV1b-1ORV2wSXRz9mCAyF8RWTw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] ipv6: defrag: orphan skb before queuing
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, dsahern@kernel.org, 
	idosch@nvidia.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, joe@wand.net.nz, ast@kernel.org, kafai@fb.com, 
	vega@nebusec.ai, petalzu987@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 11:25=E2=80=AFAM Ren Wei <weir@nebusec.ai> wrote:
>
> From: Zixuan Chai <petalzu987@gmail.com>
>
> IPv4 and nf_conntrack fragment queues orphan skbs before returning
> -EINPROGRESS, but ip6_frag_queue() leaves the socket association intact.
>
> A socket installed by bpf_sk_assign() may use SOCK_RCU_FREE and be releas=
ed
> while its fragment remains queued. The skb destructor can then dereferenc=
e
> a stale socket pointer.
>
> Orphan the skb before returning -EINPROGRESS so the queued fragment no
> longer retains the socket association.
>
> Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---

Thanks for the v2.

The changelog should describe the crash you actually hit:
inet_frag_reasm_finish() clears fp->sk on frag_list skbs but leaves
fp->destructor set to sock_pfree, so freeing the reassembled skb calls
sock_pfree() with a NULL sk.
Please include a trimmed stack trace.
The SOCK_RCU_FREE stale pointer is a second consequence of the same
missing orphan.

Please also mention 18685451fc4e ("inet: inet_defrag: prevent sk
release while still in use"), which moved skb_orphan() into
ip_frag_queue() and nf_ct_frag6_queue() but missed ip6_frag_queue().

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
