Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646499;
	b=FavXYbOVozTlVqcDAsx/uw+phbeSD7a09gomV3JjmEsjmob1MabLtB7EnVpD33qkX7Hc
	 RTg75RlCS5Smi9WgNjqWqg4AyxbpzV2hWIEOQoMecUsRXSsnp+TsGyzufl4mEchDDRb25
	 PxIOHHDPeFZ0m+/VINjpF4idWx/4Z07j+dzx/s6k7sv7PlVB/3oHyFg4KSxuCghV69XRv
	 Z+ZORdmOPFF632CeauW7UbEf8zryTU0ABYCnrxpKnyb0Re5LvVgASUlzOAiVfSCt0hB5v
	 eyrw1pokduy2FHWizaHPtRnfc6utyC9qTEnP008Ao3VMb57aPpiwbvoGklhMZeGtaWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=kj8YL9zT2SsjKfkqyT0D+tGPgdgEYEXga34qjFIME+Y=;
	b=cZgLq37lDrb39hkSs9akVGPTvnu1xqhpmk8ku3CmXKrVe45RGY2Q0+PCbHvhIfLD8AwN
	 30tN6fLB8Sfgg4PDk5iEv2ySJ99Vbm46aTzzLNffsNcZJ2wiuZ5elGQ6yJofRoDyhlRh8
	 HRGA5vB8gbMdRtGJkXwCzXz2P8Grp3Ve38Q5AuixNyPtuKgjy33kbseIOjr136wF+qAzQ
	 2qwdRDX1OwpZtfGtphNtW4itN4BQk7ATN8w7PSkmvgRmJeU0IqQzlpFVTZf1zY0tKGPY1
	 YeNT37RBA2yRF4EqX3Kmkdm9rXUOOcvfKNDoi5X5OCTbXTZm3jVB1ACdUa1hd3Xc3Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HGkgbnuB;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600E606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 05:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6600E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HGkgbnuB
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ccca948203aso440288a12.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 22:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646499; x=1793251299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kj8YL9zT2SsjKfkqyT0D+tGPgdgEYEXga34qjFIME+Y=;
        b=HGkgbnuBATVCGwmb/lA6c7BGP9/I+ovdSFi+vmWXuodwn4VbXa8ZkXUvxZmBVas2RE
         wmt+sl2Nispxc4A+pIP2vFfIdfxhwVET6saSnKewADABOU0aMyws/W6bevNRNeGTnRq5
         lvRl6rpoOCYsbaBM/9FpD2CNT/pgX0ctOROaR0413ORSHPgduhgGGXNczis7oFN6gUJc
         hbNgI/Y27QpKtu/qy1T82Dve0uRy+noh5FpG/xlLHpAOpatKXko58aFppyGmy/LBNbVw
         QdPsK/vwwdK7HhwRKwyA17NFszWjo1FfBjm4jVN5V5ANyCEUkLAEBivYqqowiGSPl9CK
         mj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646499; x=1793251299;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kj8YL9zT2SsjKfkqyT0D+tGPgdgEYEXga34qjFIME+Y=;
        b=Ya8NwCoRs7K0JefHYk87NmTbuTqQF5K3/A4HUiNLcSSKeUPxoiEHB22tm4+nqzJHBS
         o/XOIWUraFrZ9ZvOvdweKJiswb2b2ojYb4LF46BFKa83PIBB1VF/3WTOegR1my6lFI45
         hxBCZm6lLVyw+vK99rGn7m6XuFVtnxcflzhmRbRaFQ3EY89JqqVAp95PG1Xa3R0pF+Ia
         sdEOK2jxfUZOkH5+1EzzS3HnV5BDe/S4aFLgoOQvX6kGNYsdFDah4riA2F0b0agoHCqb
         TtVnuY3T/2mG8TLwmXzzpnnzzq+J3zrfSdBRD5m1/d4FcWTrnsx4o0jNb6FXkigsyZRa
         n4Dw==
X-Gm-Message-State: AFq9FYJPQIvmrEcOKehsIetEMYt9DtBit8piDpMps0EOQJXHqgz0EG5V
	eaBnGIfGPUQbvxjP7g43vpG/NKF9C3ALtgrVWn38RKx9JFwT2JnqCeMTiFIQ8Hu1iw==
X-Gm-Gg: AYBFou3bl8lM/xFUdzZzRzZeOfnJhJaVMNWvZPTDiP3YFmYqmaEhWMqpV1b03R4vC6u
	DabgZe7+P7WOUGks9ZN715naH3RkK1gZrMmIPmAuYzqXwCX7SRNffGkmZVQ/FcbzezDEjnUlYuw
	QsjweencJoUhNQugtNYnJJnxKTRGnW5/fdQWZbJfnqqn9FukBaTQY9LCxXYP+N4s5R1Z2vzF6tM
	O9BqUvDdCUi5I4qkEC3o7hrpWfS/m+L53uS2WdAC1p5P90/F9uYGzMusDervDEagwJdOKNYwjcp
	3fNQAEHZXfigAP/Al0oWeiwvQlqz7EKpCUkQZ0+ZLRYa/EnM4Wzp5NGQEVtYvU30+O+3bOajSB7
	cH8FqoZ5wb3uQn/rvJorDXYYGyiqpgWJRUk9cJbxTMjwZ9/Ovlrd7VhJgBd/IMXHboc4ee4Dxs9
	6k1ETVHM4+4Psu3sxIj5B480IAc3MOnUky4o/CH7TGjY3dnXmmynVQnOvK6k1YI8Jq7MgmDrqGT
	sgwflM5P5tGJeMeTwJKWrdz0cuFV3AkeU73blgpLmh8yK2OcwWhNsjgVQGFlSZ0PQ==
X-Received: by 2002:a17:90b:3b4c:b0:3a8:a98c:ea07 with SMTP id 98e67ed59e1d1-3ad86cd5f14mr3391090a91.13.1792646498645;
        Wed, 21 Oct 2026 22:21:38 -0700 (PDT)
Received: from localhost.localdomain ([185.220.238.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48bb6f1sm2389386a91.14.2026.10.21.22.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 22:21:38 -0700 (PDT)
From: Wang Yibo <szwyb123@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 bpf-next 0/6] bpf: Unwinding with unwind_goto and unwind_exit
Date: Thu, 22 Oct 2026 13:21:34 +0800
Message-Id: <20261022052100.21-1-szwyb123@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DMAO9WXLPZ4Q.3KZLMI783AR3Y@gmail.com>
References: <20261020043319.3031996-1-alexei.starovoitov@gmail.com> <20261021011249.17-1-szwyb123@gmail.com> <DMAO9WXLPZ4Q.3KZLMI783AR3Y@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Alexei,

Thanks for the explanation.

I re-ran the suite on arm64 against bpf-next master b116ac608, which
includes v4 and the fixes. verifier_unwind is 42/42 with no skips --
the jit subtest matches the new JIT output, without pacia1716 and
autia1716 -- and unwind_attach and unwind_cxx pass as well. The
regression set (test_bpffs, global_funcs, exceptions, data_in_arena)
is 160 subtests, no failures.

Thanks,
Wang Yibo
