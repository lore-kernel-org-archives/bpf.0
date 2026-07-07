Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E13F4849
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421752; cv=none; b=bis6BDlFxuUARLOXIMrVa+ApCv/6PTrcHMhqCX6dMiDZ8j7li5TTEr9UxePd2k9gdB5vnypVARD9iCTHOxn3u3lET9dh1OyoWb4OwYvQyMK+RtIkEoWFBiB4z/NMdIIu+vYBjBn/QTTdjUVXhkuN8wh7b0mdT/LiwlN5aqz9V1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421752; c=relaxed/simple;
	bh=OradJnCnADgzFPbxANLo72rOESMfc4ZJ1phaB4Pj8Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yjhe6EvHUCUbTfrcSFEy1F0ZZzV5h5qwjEXyZSo+ZS3XOZwBOWqRW6upwjGLqSNzyIAVxWrZFuRymt1emuAm/Y/R16KOzHF2ZiD5Kt3aKXovQjxpCGYO415hOsra5Fg5ZUNCefMJP1NoGVg2MNoANPFUaJhycTkiY1qhuDB3AmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S86pS8zE; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S86pS8zE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783421737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OradJnCnADgzFPbxANLo72rOESMfc4ZJ1phaB4Pj8Mo=;
	b=S86pS8zE4Ujd08ShplkuDWPmEm29RUs9xwVLXyRl2WKHi+boRHIZvA4v0njIlMRyexLdGr
	pA+mKtZCsFwlwnEyh2FN9EzaK7pcoRtal0xraN/s8Mici/5Jwziemkqk98ylu/p+48ruNK
	LGWiLobrXzbba30TAGCux4NPqmXGRSs=
From: George Guo <dongtai.guo@linux.dev>
To: yangtiezhu@loongson.cn
Cc: chenhuacai@kernel.org,
	hengqi.chen@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kernel@xen0n.name,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 07/11] LoongArch: BPF: Support atomics on arena pointers
Date: Tue,  7 Jul 2026 18:55:28 +0800
Message-Id: <20260707105528.362985-1-dongtai.guo@linux.dev>
In-Reply-To: <850ef512-b48c-3fd6-1959-2a71363f983f@loongson.cn>
References: <850ef512-b48c-3fd6-1959-2a71363f983f@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> Adding code in patch 6 and deleting it in patch 7 is unnecessary code
> noise. Please implement it cleanly in patch 6 from the start.

Agreed, will fix in the next revision -- patch 6 will introduce
bpf_jit_supports_insn() without the atomics-rejection case at all,
since patch 6 itself has nothing to do with atomics; patch 7 then
won't need to touch the function.

Thanks,
George
