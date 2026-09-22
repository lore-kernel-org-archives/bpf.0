Received: from mta1.migadu.com (out-20.mta1.migadu.com [95.215.58.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAF31280D
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790054938; cv=none; b=cV2ni8wWeMRW1zwJyA6jbmyCqJAHnr/kRr/qQhoa2t9HbOyUfJ56k/skqH2f6Rm8KQAUSh3jU3FbAJ2ks1uNK4Yeu5BhmoBALl0m2ep/7fDAYAH5jOL6ZoAWP28kRgeS5xbx5e4O+Fn2/OTIoukWNzVrNEvPqi5nZFWbu7/gwGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790054938; c=relaxed/simple;
	bh=bfjKa8K9D4FGrWHXy1J1JQgiFh8ST14uRK2uWJmEHMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFHBnfCi5izG95vHOMxd8o/fKI6Z1d5gWyOCncUGXt3s78Gkj4cle3rN6QnG25ZDRCmRFfq3dE6bbcZg+2cAjjOML2TmF1HFQ2XljVb8bflXzVYlwqCVpiRswQM3QWV9BmSWKEHXAXrFSx+Kbr+9WsB7EBbYXm/FVZGxBI4az6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S4gTPC7S; arc=none smtp.client-ip=95.215.58.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S4gTPC7S"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bfjKa8K9D4FGrWHXy1J1JQgiFh8ST14uRK2uWJmEHMs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790054933; v=1; x=1790659733;
 b=S4gTPC7SwOA+0PdSY3sRPyXUPxv0xF7dD4m3ggDKJOgSwV2fzLRvFKdylvjZHPszXjdMDXUl
 pJD9Z+j/KcQvhcXtm6/ED7GlNOCw3DJNP7u/NbbI07a+baa95/Whn47UTVZpEw2Poa2IrVqbZeq
 s6rH6v5xmiGGdyVZg0fCAYHE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c794051371fad01a;
	Tue, 22 Sep 2026 05:28:53 +0000
X-Mizu-Trace-ID: c794051371fad01a
X-Migadu-Flow: FLOW_OUT
Message-ID: <3c0abf51-ec3a-4efb-b893-b0e2178ce160@linux.dev>
Date: Mon, 21 Sep 2026 22:28:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 03/20] bpf: Add lookups for exception cleanup
 resumes and landing pads
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210048.1717268-1-yonghong.song@linux.dev>
 <DLLJPU88F1B9.1T58POQICACW7@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLLJPU88F1B9.1T58POQICACW7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/26 9:04 PM, Alexei Starovoitov wrote:
> On Mon Sep 21, 2026 at 9:00 PM UTC, Yonghong Song wrote:
>> -static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
>> +static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt,
>> +				 bool falls_through)
> next time pls ask AI whether Alexei (me) likes bool-s in arguments.
> I hope it's training data set is new enough to know what I really don't like.
> I ranted my times on the list about the reason why 'bool foo' is wrong.

Okay, will fix.

>
> pw-bot: cr

