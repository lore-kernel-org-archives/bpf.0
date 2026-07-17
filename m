Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4213750CB;
	Fri, 17 Jul 2026 03:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784258933; cv=none; b=kMdHcg5yqC7CYNis06ebJla8irKYM1pYD/fM5XmbxqxCbtJptMxLsF8Fq4qZNmtgJFmoYoCoE7QsCJzOyAmsPrYY05rMpFjNPZSmGJKn3/UaVKdSPWQVz2om8J47a8BTsTQnvgK7WUlJ2664Wfeebm2Jg7ky/LCMvlBXzIBQf9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784258933; c=relaxed/simple;
	bh=CFvoVcZIx1dFwO0Ci0FJuR6lHhaU5JTofeRASD9Xl5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEiU6xRlfd3MbxRLHGAN3zGnVhjDQGtKwx+uPdwwV1MFy/Mw+P2HTOl7pb9SwiD7ReSfhaGtO9gjZ5unMR0qDPb9s1F/88B2Qv/SXkalgbIrzBMk00htyxJGL153sjl6ETciYpJZIE9dO3+pwfwp94PCMGZ8E4YWhIgzh+KN4Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9e7d2a60818f11f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d811b572-e5b2-42bd-a1ba-c30d82780afe,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:bc5ead1f839908384fe6a72a23752c91,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9e7d2a60818f11f1aa26b74ffac11d73-20260717
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1940698584; Fri, 17 Jul 2026 11:28:46 +0800
Message-ID: <b4281b16-5c87-423b-bcc3-d6f623c8cd6b@kylinos.cn>
Date: Fri, 17 Jul 2026 11:28:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests/bpf: enable timed may_goto tests for
 riscv64
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, Pu Lehui <pulehui@huawei.com>,
 Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260715-riscv-bpf-timed-may-goto-v3-0-cf2a9c3d843f@kylinos.cn>
 <20260715-riscv-bpf-timed-may-goto-v3-2-cf2a9c3d843f@kylinos.cn>
 <877bmvwekq.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <877bmvwekq.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/7/16 15:58, Björn Töpel wrote:
> Feng Jiang <jiangfeng@kylinos.cn> writes:
> 
>> Enable verifier_may_goto_1 (raw instruction tests), stream_cond_break
>> (250ms timeout path), and the may_goto_interaction_arm64 fastcall test
>> on riscv64 now that the JIT supports timed may_goto.
> 
> Really a nit, but now that may_goto_interaction_arm64() handles more
> than just aarch64, maybe rename that function?
 
Makes sense, will rename it to may_goto_interaction in v4.

-- 
With Best Regards,
Feng Jiang

