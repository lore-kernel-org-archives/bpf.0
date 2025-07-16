Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E6B2749EC
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696166; cv=none; b=af47XSnemqlBDdVzMPScQIcPMAZP+c4SQiK3YwD0/ccxfgjGawwIixeuxtxLTRKn/vm/pFUDkmNKWzjYP+99dQY8GflCgLB8Sra6O7vybc7spYTrxAcsQZEfBnVTfwaqWjPfa4oJYMZbOxgXfms472pKe5AbccVSDaXz0FoUGyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696166; c=relaxed/simple;
	bh=LyZIzMJ+176FVY3wSNBaRyULlAoZ+vWoFImqvhRaayY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tau9WpnQlN6GS98UUoa3NMGJvsRJOBBu6wCeE/0guIelbEqX0ayt1PzPCSHPCj+9L3ojoITyTVz2cdMnqnSL+0snDCnCsTNV0wWqAM41jxqgYGG4gpSw6gOGRXcYA3+eHI3rhdxAqIl+Z0zYmN/okTB/+lKFhxBWIQsxiPzSAco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rdnyA+nd; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rdnyA+nd"
Message-ID: <4c9fcc40-9aca-4ac8-9769-1075e2858b8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752696160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyZIzMJ+176FVY3wSNBaRyULlAoZ+vWoFImqvhRaayY=;
	b=rdnyA+ndWAuYJ7XjkWG90xSnqgOsXJBHoMeXSV7s6Mq95GEULyWiIpp7a0EUTGHaoeEps/
	NVnlIWLLzPKiZ69u+/QlVTt2NUBg0IriCA5vczmUcS3uQlgOHDHRQo9RpYNXETT+0KOzSA
	Biq0G4NF5Zv8jTIxRhHApWA6ll1/vSE=
Date: Wed, 16 Jul 2025 13:02:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: restrict verifier access to bpf_lru_node.ref
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 syzbot+ad4661d6ca888ce7fe11@syzkaller.appspotmail.com,
 Hou Tao <hotforest@gmail.com>
References: <20250715075755.114339-1-shankari.ak0208@gmail.com>
 <CAADnVQJ6_pB8ZU2Cw5S6nB4J-6s7bw5Fp-Hst9M_EE9=HxN8+g@mail.gmail.com>
 <27c7c76c-becf-47b1-812b-05f260a8cd85@linux.dev>
 <CAPRMd3m9NtGXfH3kDWLq-Lu63i1ww4znDJ9aG6ho5J3+Ow_bnQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAPRMd3m9NtGXfH3kDWLq-Lu63i1ww4znDJ9aG6ho5J3+Ow_bnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 11:32 PM, Shankari Anand wrote:
>> I think the percpu_freelist used in the regular hashmap should have similar
>> behavior, so may be worth finding a common solution, such as waiting for a rcu
>> gp before reusing it.
> To resolve this, would it make sense to ensure that elements popped
> from the free list are only reused after a grace period? Similar to
> how other parts of the kernel manage safe object reuse.

The reuse behavior has been there for a long time. It had been discussed
before. Please go back to those threads for the background
and the direction that it is going. This thread is a good start:

https://lore.kernel.org/bpf/20250204082848.13471-3-hotforest@gmail.com/

