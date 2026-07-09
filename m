Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3029E116
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627365; cv=none; b=PbRTnGzPF70No4bH0FAfqYEwS5Y1Q2KQs+OQ/qd35x8KT8kh+XeHjRayVsOXMhPxmf4qlN4xSX47OmUDy3J/qXeHG8xtuwKctlWFSzGeqn0dc3f+DWOqMjYQ8TByaai7L1TkytnkkGpDMOTNM8800yH+lOlYL+W+dhG1xBrpK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627365; c=relaxed/simple;
	bh=wFU7lwFBL7GY5YosKy0dwqF08R/RRnLVA84JFHiqCYw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h7m5zFFgyKtPuIs7pBig2JzixHGNv+kEFKArBYJ4MwYBf8BvSncpQE7n5ocyVotGRW748BIaSyJuwYUHMyBSp3QFPjnrUxkCXH4vNLCn39gqiUe8vJJ6HQ7DY4RKt/FTWMCCHYnrzAWm59Qt4mrWLo/XZQ8iklfqDkJvqRqZLSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWA1S2JH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWA1S2JH"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc891373e0so1497315ad.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783627363; x=1784232163; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wFU7lwFBL7GY5YosKy0dwqF08R/RRnLVA84JFHiqCYw=;
        b=FWA1S2JH1Ggz/sRpo9Z+4uQiw1ScWuwVMKCi4FD8DEyuzQ4HKEqjmiCvIAfpRu8B6p
         S2AOgvkpR8ldOu3Xzwrjjxxo1vloYPNzqXF564cpz4j6213e2N+JDQCgOSpPWwIP7Bvo
         4VTgKB8Y8wf/03cRgoQTKmzCJ8F05b4O5wFMaUcbpdModQ4NnSSQtFy5U2OiM4reLV0w
         otWcFRlCedc2+aPrXth1Q479+IIr9Wg/UWRloxblPWvnTDuTkvaJ5ieoRMjSZA4PS613
         ZtkIj+RrJo8Rjh7LoKcla7iFPi65quI5zgwXUIkusBjtzU59MqyxPiIAoqany+H1bEAk
         +qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783627363; x=1784232163;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wFU7lwFBL7GY5YosKy0dwqF08R/RRnLVA84JFHiqCYw=;
        b=VM08f8jBlzy+7FUqIRaMt2aC89LWeoS8uvEEJ7m2s+pnJV9OAXTGEnrI8Asws/+Cwi
         1OkDaI3etKiOcsRT8B426ik3eexesTtXegWjn+87uBEmUKWaOgNF8JpxRZ02T6GZngtS
         qk+yf/uKFyl+kROuKJ+JagwML6nsy84ie3jlNaX0ASvM4NAqaDP2WIpZMYkWvH0/c7h3
         ubMRgeOPVlQ8JBxmdTJnq+kY54kWJL0FsDjzQH5YK7lQMZUGOEYJH/SV7trDqXNPxUnZ
         m80kbcWPrDw5g1XvySgx5O7WkRiL4g52BnbDD+Qg7JL8CkF+zwpZw/na5FIJmU4UMD+U
         P50g==
X-Forwarded-Encrypted: i=1; AHgh+Rq9WqJnzavfzKaXvUxl8cUkssLkW5XfVujWhTq5QqIZl3CKN0I6sNAN/2bfsinsz0+bVsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAVNavig2GKgX0oKOKXSRt9aFTFea0Y6YNKQDWs1wAlbivw+f3
	kFVode+FCZ0P7Zj0u4xxHmsoIZFppFmQhNKyS0bSFWnDWd+adQJvr/zMsd/dxw==
X-Gm-Gg: AfdE7clBfG/NUsXDTLw4LmOpQlxCYChka3fN1B7SEkZRs1tuFos8x4uUcLpQ8N+YaLF
	7LYhoJjxucr8pILEDSqMxu242tC5gfs/aOp1GNamm+xKToDYpr1OWlCp5CAJn01fCwtoYHE8M+G
	bdX3DeG/InlCi6GKjQaafVuB6YOqb0W+gduAW1yg9IQHYk7RlpQaLPqFzwZ6VaHt6+RSTj4/G3n
	Mn1gLHR5eWdeIrB9/bCS+nBPF0aHE0zwx3o2sesLkGTGW6GeY2hxpLQRKIN9ENr7XuGihB1Amto
	mIIXdEz1rCSYelsSy6SS4K05OIkIUeQ++ZU8KhES39p0C44d9/TWOi9GmuBCEX9lXqzz3TN5j+b
	Jh1z0+f9bokHtgB0M7wjje+Ugeq/T4hP+plMs2eDifPF3cSCPEY51nuYi+ZsCo4jt78OchkpAvz
	E0uLrxC8wOBY/Cqmrez6QP6gm9qw8P/9kkqfKwM0ybyvOskOFzJEY=
X-Received: by 2002:a17:902:eccb:b0:2ca:d7a0:1318 with SMTP id d9443c01a7336-2ccea3ab636mr81851685ad.11.1783627363337;
        Thu, 09 Jul 2026 13:02:43 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb72fsm49217185ad.6.2026.07.09.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:02:43 -0700 (PDT)
Message-ID: <b7c0ba1e4ff8a5e1a9ce3a4f7bc43e8e5fb3cd9a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add test for oversized
 rdonly/rdwr_buf_size kfunc argument
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nicholas Dudar <main.kalliope@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Date: Thu, 09 Jul 2026 13:02:40 -0700
In-Reply-To: <20260709155837.1879230-3-main.kalliope@gmail.com>
References: <20260709155837.1879230-1-main.kalliope@gmail.com>
	 <20260709155837.1879230-3-main.kalliope@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-09 at 11:58 -0400, Nicholas Dudar wrote:
> Add a load-failure test to the kfunc_call suite using the existing
> bpf_kfunc_call_test_get_rdwr_mem() test kfunc. Its rdwr_buf_size
> argument is a const int, so the test uses a 64-bit immediate load in
> inline asm to place 2^64 - 192 (0xffffffffffffff40) in the argument
> register. The verifier records r0_size from the full 64-bit register
> value, and the test asserts that BPF_PROG_LOAD rejects it with
> "rdonly/rdwr_buf_size exceeds u32 max".
>=20
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
