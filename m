Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE542DC76C
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246830; cv=none; b=WCUp9x0f+HpWJEha3c6Nijm1Y/v692eDyey8r4O/s9GF0Zit99LAWPdl9QR/o3GGtg8DeI5kxdAuHWwXWXqkgQ/6GXFX+TrZXOpjKvgAvPkwtODLT/wrVMMIRMwFV5YLKSpo4KOD4iEim7+enK5g63uRfdYnhbTpKHSxpnGmmdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246830; c=relaxed/simple;
	bh=rkZQB7CmExri+8CjjBQVPCHhPyaffU8DthTqgx6Ywcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXxBzgQCAvIQ2dTLfDipl9uKAxiL/lY3OGrp05RpXCz6HquaZCwXDqemaMyCmQ7Zocb9Hln9iKEEGT9Fcx28myEMmyMRkqzoRl7KZEpR9mW1dg2BTDedcIaebWeX0morRCCzy3Gw1KPFjiwRejhhtBrN2Dv95jHQ9AOGS4/wj3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VDtfzZay; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VDtfzZay"
Message-ID: <206188f9-5642-4348-9fa1-c48f9a890640@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779246826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/BAsYNaRoSPqOC7pVUIR0S0Ozuw6H+s2VNAeqI7FrU=;
	b=VDtfzZay5VTZ6ayBG0Igk+ssjqN7hXy86j6RFoPTY8GN0Ygzj/uEbwWGWXT6/amFp0Ggi/
	4bLUJ5ByOWyeMYlqfFo+xEwbtESaE4tOmDPkplztGbaNuvVGarHgK2BKteVXVnik1izSfP
	hHXeS+BiQAfGgtxOKHCfjV9XqH86LCA=
Date: Wed, 20 May 2026 11:13:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
To: Zhang Cen <rollkingzzc@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zerocling0077@gmail.com, 2045gemini@gmail.com, stable@vger.kernel.org
References: <20260517121626.406516-1-rollkingzzc@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260517121626.406516-1-rollkingzzc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/17/26 8:16 PM, Zhang Cen wrote:
> SK_MSG uses msg->sg.copy as per-scatterlist-entry provenance. Entries
> with this bit set are copied before data/data_end are exposed to SK_MSG
> BPF programs for direct packet access.
>
> bpf_msg_pull_data(), bpf_msg_push_data() and bpf_msg_pop_data() rewrite
> the sk_msg scatterlist ring by collapsing, splitting and shifting
> entries. These operations move msg->sg.data[] entries, but the parallel
> copy bitmap can be left behind or stale in slots that no longer contain
> the original entry. A copied entry can therefore later occupy a slot whose
> copy bit is clear and be exposed as directly writable packet data.
>
> Keep msg->sg.copy synchronized with scatterlist entry moves, preserve the
> copy bit when an entry is split, clear it when a helper replaces an entry
> with a private page, and clear every slot vacated by pull-data
> compaction.
>
> Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> Cc: stable@vger.kernel.org
> Co-developed-by: Han Guidong <2045gemini@gmail.com>
> Signed-off-by: Han Guidong <2045gemini@gmail.com>
> Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
> ---
> v2:
> Sashiko-bot pointed out that bpf_msg_pull_data() could leave stale copy
> bits on collapsed tail entries.
>
> Clear msg->sg.copy for every entry consumed by bpf_msg_pull_data()
> before compacting the scatterlist ring.
>
> While researching recent page cache bugs, we discovered this bug.
> We confirmed it allows overwriting the page cache of read-only files
> via splice(). We haven't attempted to write an exploit, but the
> corruption primitive is verified. PoC available upon request.
> Recommend fixing ASAP.

I think only "splice() + KTLS + sockmap" is vulnerable, right ?

I digded a lot but didn't find any other combo.

Actually the normal TCP/UDP  with splice() will not go through sockmap 
(unsupported yet)





I think only "splice() + KTLS + sockmap" is vulnerable, right ?

I digded a lot but didn't find any other combo.

