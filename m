Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C82D3AAF67
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581142; cv=none; b=U6FVgTEcWFJd2ic2E4ywU9h19Mfz2UyPljsY42IBBTC5HYFBg0EbRlfG2zOYgS5MSzjoC/PftuYpEJFEVVslGLsePS0EFlXdv340eY/d5zUMPOsr59Rm0zujaxFENIvT2QTB9x73JiTWGkHVjCNN1Sj/t3c+nlJKP7DSp4+3x3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581142; c=relaxed/simple;
	bh=JYguKpWYYDdj85O8UNrflccHJDrj4xz7wT+IHO0o+TI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=epSAnW6e6pTnsNEa75QVjAtMqXVijD70m+RnnUgPHb6bQ1FG7yM3a6fvDFV1QTpE1RxpMzrU2bYnCSiucDKXMpmadXilgbIWniANP59G2V7EhtW0qGaAsNcpmWeXslgxoKtO+7IDtxXHcuKTLYf2y2DfVIdZg9AhmaZIdx+w5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSxOnD8+; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSxOnD8+"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fdc579daso16770485ad.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790581140; x=1791185940; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NrMGPZQfXAem1w1eTjPgNNpDrfOCX+chlCVcm7+bkR4=;
        b=CSxOnD8+FAiM1CguoaAzVBcp7KirSRa1BsTjvvt42KqpJ/9y5hIF4OSsxiqNEPKoLL
         f+LtXK0/nFALt/2rOrnnXzzq4D5g33A+HfiYMgIAECXgyB0avC1LMjtNPv/Sv0iUsDuR
         Laz7KJHY1h8fMh188aNXkeD/7OJnZO1Z0weHcZS7e6/i4nXSMfYDYArKuC//4cYmLMMd
         fvPXwstO9Sr8E85AA3zR7tTvGIhwPNxf63JWLzqF8wMcCtADl9mSBCmTxwKVX0P4hJFN
         kq6T63Ccmkg6YOBNRctP29Uh7x5yxc/AA1mjaUgnPlzXp8MncVCZqVJuNIhnZLBe9IR7
         vYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581140; x=1791185940;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrMGPZQfXAem1w1eTjPgNNpDrfOCX+chlCVcm7+bkR4=;
        b=qW9oPzcOu5kPQKuuWi7xs0pp2pThZS+JLzousBn0sC2LVpYMON0k0GoLE2f/Ls0VHe
         BmmV3fK2KvpepDOSYsJ4gkDfcNooF9VNCHAfx9BDqZT6cDKn3RwoYSUgR056XR9/h8Ua
         UYMAaMD2fd3gCE3fcaF2LjfmpsHDZN9pmr9WgR+sJbaJw0FcvM8xTcrfCElguVYJiSVO
         0f7iZmWIUKlts9KKRCUl2FCtG5SVtF9gh3DOv+egfhq6KGAkhVLrGnSN0QrZwd83iePo
         XdVIGMi+w4hhWWY7Geqyvy0qZKDJccqCku+zpN3NvOo3XDqyRtf2jAj0N9fXpkdKDT2Z
         16RA==
X-Forwarded-Encrypted: i=1; AKwUvBzaObV+Sumu+IRIQ1I2wpWqqLDqFOQasX1phfl9MN0bS7FyWNP8QJGFlW3cr5CErM+1JDs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5VoupISB+cxVKh/Y/GccuMWyesplqfvMNz9mZpuZxsoekwJC6
	sUL3uG8zijxxTQ6wcVPt7O1O/sQPeYYocOxnaDYdhX7cZBTIjUAi/v49
X-Gm-Gg: AYBFou0GW1WkLHW/IIfDLu+Fu0BddSOniwomDclF9BIVktlNM9Y+nBGtFt/AWTmPolO
	Lbg1sP0Nv474JgPETL09SQUlbPTmmb3seQuHQvWVNJ3XS8mZ75bmknYhsGABn+1rq1Q/oYCqwXr
	RVUyTd2UwN5kv+nw6Qug//ve4RXcTADCCq4Edu4wHpKk7LgAm9Ah4UrUbpohaNz6VPUMzLJrOZX
	Z+TCtLhWs0sLtp2A5tTdeBSY0PJaD8PewfmoG7IvqOYJImdack6dbEFxVUwbZ2KojocEsGqXLp2
	Qs1ifCgTOXPkuST1wBSsXJTpSvTMb2B+/vffg0g1MU8eXG/0F19l2RbEH4fMYbht+lIaL1RYus9
	pvJElPB1TsbAYasK5LxMrAb5BqBhDhIsM32C8Jic5fKlg5tCAOa8G6kvV6G1BeAdfqGAZEeWbJm
	eDrl/3fh4WBih/bmwzeAbIQbaXmdwtyH6p2N+x2r0dTALUNiqGP/NpVFQ16/FuYS7wDU5hjvL2z
	/VCzQB0Oq+UM8UGBrKDaBWCXs9jTxktQBi8Ynl683+rH/J+MV6I0mIKycqLqZqIRL3KEnnSc0/G
	HhjA
X-Received: by 2002:a17:902:fc4f:b0:2da:f7ad:cfea with SMTP id d9443c01a7336-2df7dd76871mr98510165ad.8.1790581140234;
        Mon, 28 Sep 2026 00:39:00 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91444763sm36663265ad.60.2026.09.28.00.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 00:38:58 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 07:38:57 +0000
Message-Id: <DLQS1EUNZG5T.1ZCONM8DQM45@gmail.com>
Cc: <stable@vger.kernel.org>
Subject: Re: [PATCH] bpf: Initialize IMA hash helper output buffers
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiale Yao" <yaojiale02@163.com>, "KP Singh" <kpsingh@kernel.org>, "Matt
 Bobrowski" <matt@bobrowski.net>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Roberto Sassu" <roberto.sassu@huawei.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20260927121400.1188165-1-yaojiale02@163.com>
References: <20260927121400.1188165-1-yaojiale02@163.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, Sep 27, 2026 at 08:14 PM Jiale Yao <yaojiale02@163.com> wrote:
> The output arguments of bpf_ima_inode_hash() and bpf_ima_file_hash()
> are marked as ARG_PTR_TO_UNINIT_MEM, so the verifier considers the full
> range initialized after either helper returns.  The IMA hash functions,
> however, leave the buffer unchanged on error and only copy the digest
> length on success.  A BPF program can therefore read stale data from
> the untouched portion of the buffer.

That's not a bug.
These helpers are available to LSM progs only and LSM progs
require CAP_PERFMON to load.
With CAP_PERFMON the verifier allows reading uninitialized stack
with or without the helper call.

Since commit 5da4a9f26fca ("bpf: Preserve stack initialization for
generic output buffers") MEM_UNINIT helpers don't have to write
the whole buffer.

pw-bot: cr
