Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655877;
	b=B5dG9aGie65TWoBiUWBXNKhmnEMQ8wBwgLjv0R2tMVwewQja6W7T5I02cdh4DxcE8hx3
	 bLGR0GR6N8PsaTV742zJ10vX/lwaGi7Q95k8ijjKljLXCK2SxiD4alEkpwGsWWv9+pCya
	 sEChCzpT6IzWsDYgXGiY8rvNHKNdB9n8TJiVkXSNg1yfDLsS067A3k5mNoP1910zHIq/P
	 rx/d25NUzrk48cqok4Zq6nTBNMUW1Zyn/wVareareQ4mvnodWzCr43qxirpYJ+M3r8hHn
	 RRVLEhJ377xzZDOFyeQS6Ry7/CABZJJ0WptHbTrWbNvfmZuytA5i+GxRDwzDbF/GW6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+aRJH0s7CUutYvHA8qpdJ21NjF0/4sgc7Z7eUI52Igw=;
	b=wSZyFcRPdBBhO/9/sf4AMgl8qHQ6aL7rVLrE2BHhjEZJAlWwKu8WtRUmPY9t/2TRK7c0
	 xMKtyvrltY/5X1XP5jUJje9kRy0ZypcmfZJ5Oen0g4pWVNk/vYbq6RasiTTI3AjmqhPxJ
	 U3MeTXEPChV43uF5kTWpBJeqEaBLBbWNbvxi1+EqBV1GqsApMcddFa1j23Eum7fxioSQp
	 4yjAEH2HGMG64sIytP7h2fDu5XP2o5l08IhQe2P5RxfRf61BTYDwGVut0bdJy222qEZrC
	 0z8Cxkamf8Hqyf/IkGUC3VmpAbK78S04xVuqdcyKLWWaV2Jurghrb2BB/cfP9a9mQQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tLdBEdct;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34E606A323
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 01:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D34E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tLdBEdct
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso2569002a12.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795655876; x=1796260676; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+aRJH0s7CUutYvHA8qpdJ21NjF0/4sgc7Z7eUI52Igw=;
        b=tLdBEdct4R7KMIr1y6Ok0/2ZlIjjp7rkHalVCrhS6hjqp/7dcPKVKAD6f/7rM8vAxo
         w+Q4F3mc/RrCWwQAh6JnKtc8gwxxK4lODMxLm8X0kt3ozpw2NtU7wDpxLIwGfWW6aIJX
         SROhBVcRYkvOrRM2ekfUs6v/FiBdEeRwu1HY4nibEdzrCRIVvQraBgD2jXr5/AvOMLko
         AkxoZOMOf3QZqxcclimv/B3zxJSNUugBKMn3Wz2GN4vvoDTvi/DTcy4p4DTpmEWULF//
         VMAYYjFlwaGwfc4auW45j96nABYQAT6bB3pFXkwtGwdA85JJQ38eJkVLIyk9s2IBQl00
         +8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795655876; x=1796260676;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+aRJH0s7CUutYvHA8qpdJ21NjF0/4sgc7Z7eUI52Igw=;
        b=shRp9VCdlC3HGaX/5ZtTZAaSpZ5hW4s6dRi037DlLVn12QitwweeBrITQnMnoGRoEK
         3jdstm2kD61SBHfGEngkAaHMxB05VZwOxWpnsdaTmYEVgXrmvef4Y4k1qlGfP6hxcDEz
         OFqgk8XYuGB7PUcZlCwXkwqbP37ZxNTHSDXE4/n0bOQS292qkf3C6j/XLtgkqtzOWL1Q
         YZsYpTdLzHtCJqXXGQdUo8KVPPBFsDHZtrPdmOe3iXnez+HJ1r0XQPTk7w8qjkqQda2t
         X84O9Dl4RacOim3sy3SVwY+vQqGKsQ1x1wtHkG2DOAy2nS8560d/D9RZgdd3Dmr4/LFu
         6t1g==
X-Gm-Message-State: APuU4Z+2teg/Zxdxf/rkx2nhLKWZf4sdLWusS5G3UveJwsRsKrPo60BW
	tcCJaRY+82KI3QuB685fXA8kq+2IPib7L/uh5BCLG5tRcK+0JuK+bMCe
X-Gm-Gg: AZFdTZcjqWm6Zotmm3kDhxEep1K+KUVIHC4oMARHOwdTBjlTNnbmDfFJB68HcH+0AEO
	vS20EMDdVtQDy/bH8olJ0RTsP82f9yuF2V/BP8LdIMDIMv7ss/L2NNp0Ax+B56qc+fC7+3pDslj
	Mr3JbKKBRImWfQXIBJS4kzpk0ZEUPZ2ikWFTK7WfRBu4UvBnr4avQfDtpD5vzFKGjJQd8zWhOWJ
	MjRfDHl/CppQwwq5U2ZCPptHnjSDvgJ8TRIYrcaGdTpsKTXxUJ6E4RymZLBtLrBu3DqhhOODZKq
	0Le+QvTRfg081KvWHzRN3wJRvWIFE0fXdcA9m3hhy5Y2YCnJM5miVlOO3qpqcXwdKPxmCTxnlJF
	edlQPhJ1Cq8WAUBifXCE1ugI/A2D0cOTrVu/AHXm9RAt354actbFhnIreNVGx2L4zHiLwdzE1Ul
	T4Z4HUMmr//UR1bzW3RyVgQV34Mu8LZkU1BvthlmSq+bPrXmLrDSh85Dag3lyqupK0vvFBXrGaN
	j3OPlfzMZE7WgAJq9yQEMP9MUp1RrAKyRnDqM3gWEXMkTWdhoj63LjJKrVs+PlQR6epyuXUcYck
	3j/wVLAQWHzz0+W8rYwQ7wI2DmaIzYugzgzqMHZsKfJIA74YiJBB7UcR+cJjI4yaW0Cwz0q5ccU
	NpcWn9lC4a+aXJiqxN0VwRWd/5u0rHqA4RA==
X-Received: by 2002:a17:90a:d44f:b0:3ac:8897:7ba5 with SMTP id 98e67ed59e1d1-3b41c98ec99mr18155731a91.59.1795655875720;
        Wed, 25 Nov 2026 17:17:55 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm29921315a91.8.2026.11.25.17.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 17:17:55 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 01:17:54 +0000
Message-Id: <DN4QVSWEI27E.32PRRHCUBAZFK@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Cc: <bpf@vger.kernel.org>, <loongarch@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Restrict JIT tests to 64-bit
 LoongArch
In-Reply-To: <20261125103208.15242-1-yangtiezhu@loongson.cn>
References: <20261125103208.15242-1-yangtiezhu@loongson.cn>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 02:32 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> Now that 32-bit LoongArch support has been added to the kernel while the
> eBPF JIT remains 64-bit only (HAVE_EBPF_JIT depends on 64BIT), limit the
> BPF JIT-specific test cases and architecture macros to 64-bit LoongArch.

Most of them are not JIT-specific.
The interpreter runs sdiv, bswap, movsx and gotol.
The default build of test_progs fails against such a kernel anyway.
dummy_st_ops_success.c takes struct bpf_dummy_ops from vmlinux.h,
and that struct is under CONFIG_BPF_JIT.
raw_tp and kprobe progs can't load there either:

  select HAVE_PERF_EVENTS if 64BIT

> This is a cleanup patch, inspired by Sashiko AI review:
> https://lore.kernel.org/bpf/sashiko-outbox-228693@kernel.org/

That comment is about the new guard in bpf_insn_array.c.
Nothing is broken. I don't think we need this patch.
Pls don't change 16 files because a bot said so.

pw-bot: cr
