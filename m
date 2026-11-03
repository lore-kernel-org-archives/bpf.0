Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727929;
	b=sjPpD3odLwkTqifBiobrJSTgRYxa61C7F3WHkwSyzT+G6jUWk/hqlEni4QB/QK18to6f
	 RheYeJELeZQQmc8WHgeIHmaOkOk1s3YZOfMfUX17R1bD+lhj/dCKTnqo5rqAY8FhmyMD3
	 NUn8fKElRjdaw9gvYizy7DourILwjCnYO5vZWngsCrm5aZFzVDuhNM2NWEEN3udLh2LhT
	 odjYWWcjtBeXMxPD4NrHVYOC+m8R4LtPgWgVkuLPLJ2rncssO2E0SGW6y/0x8Z8pRYPOf
	 1e22vomHZbU02JrkaWkwS/jXa+24H9VM/B7zn3vYRIY16E30nf95weUJayEAsf/wdag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=s7a5BjTlVy5qDDxlYreFMP8bhQHYDNYYYQTm/X/d22k=;
	b=HWkjN/Mvby3PYnD127lLiBJ6p1BqDUGh+vckD+NRErbnnzJJi9Tqcwf+1mvBkOXOZR+6
	 vP0vcu//TjDJZ0AEzvPSqnN34OGAAaN5jOmvfa0n3fSL1+IqybuR18xW4ArflgMNXv2sQ
	 FckEmfKtb5eFPLUhbM6eMXO4gcEr8O1uxr2TwIn9edXk1UN3chnB2Gj7D4xOpfFXzIFWX
	 wZ3mRRkvNNwM14H7Daz+IEqvKEfkY2LC2SGGmf5uPtpu3LwG9x3Vx8FWeGO4zPWch6+dh
	 isX0vEwKvVcOIB/V9LUKUXkj0B7aJwZcG8msh/MQ9ryFjT7cfZLnN2/ktBlsDDgg7Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hzwzjPJi;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BE2606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 17:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51BE2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hzwzjPJi
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso2005376a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 09:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793727929; x=1794332729; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7a5BjTlVy5qDDxlYreFMP8bhQHYDNYYYQTm/X/d22k=;
        b=hzwzjPJiN09HrzHhZTBsbfhc1iQdbmzIAGAwuTVh+eHXGFRKSW1m7yHq9EPSp/ywHY
         kwawDpqecqfDGFA5Qa9ubFxN5So5EcudjYHy+wNorcwUaz+mX8rT2jOHvLDqR/oulVq1
         +yPt0Z/r12pKcwN+A6uwHGXGfllwLe4BsoMj9DW0ZuaRq3zeqrC8Q0RRf4yrOOLiKpEn
         83p9hMXIO/7yKwHUhY+RIWgxZtCKxgQ3FUYXojEh6hLzFWxvk3VH28A5Uk6kZ5BuVQV8
         0TQnNFjP4lvF2jY3wL8CjUKIdD54joe9W79m/NklCQ2TC2Uooq8IjAr7z0t0m4vC5WIl
         cVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793727929; x=1794332729;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s7a5BjTlVy5qDDxlYreFMP8bhQHYDNYYYQTm/X/d22k=;
        b=Hhox0jWq+PSeYlg5Yqw/sfU4pgn/kscS/rZZC1WY6Wgbg1eQx1HNaBfDH3ttLEAYjD
         2NbgYZvuhdUnP1H8pNVMho1VAmw+fDBcviRLbukMvJn80PkZ+CdYjpCodVI259aD6brj
         dS4/umU/C48a+cDkfcYykXnpfdxicTKnr5wgXjj5docBPU30hhS0wl92xKr3Zl0qMhFD
         AOaoHICDTskhKgJw6CTWAPLVzDrtvje/rzY+64IXRQaDERc7NEJYXUCa+6RHgPBVwuYa
         pSkgHKamTkyGe8wQ1bXXUI+aPnpZhKDbKqr+lFp2GRWBE4hXg3FBSXvPGJJIjmbcaa7M
         /aBw==
X-Forwarded-Encrypted: i=1; AKwUvBy5YgqVgeEQ1Ph45X6ir6POrR8hmbL15eoqGjhY5Rjck1tMEs4CGXOWJaoC1HplvNy6pfk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/z7RvLYIr+kVxYmMIpTDO77W81LKsIyLcWZ5oGeDg4uWUx1tAi
	BpJYmyq3oNXMGEekZYd2rhgklWdT88g9hHFgA8w7ZbxNhpX37dNgj9LKYc2pYw==
X-Gm-Gg: AYBFou1a+LrCDj8C4gREJpLjhjedLC/EC3/BSRO0lA652xJ4GtJnNpEN9i3t7CndL2D
	ymPAMCImtBAlpnYxfRlVBlIduxsgbcEEBfPNT7XNdwDPHwHZhQDe7ipZgan2mkiXZZwXRcNhsVu
	zvwDFS+R8cjt5O4XtXevC/p7w0tHLIlyM+SctEzEc7mLcgPNEttuVZriYXdghNy+EWoQa/RIb72
	Ydi92txIOwz0rqxtPkX4vp9u6HEz0iqwXDy2NmQ0eFUqqsogC2mosPTzGURV82kWyFhOwKezDT8
	fAK12SNlR4F/yI7nNxZ0Gkmh2hrUaP2ERTaZ0Qf3DZJc/JQeN9WnojxuUjSGg7gI8YpWApaFLQo
	/9IV92h0oerrHCGmLqVriRaWCu4X492D+3KXbZUSIVxXZvpl2EPsHTF7kev9TZTAvlvRCLtpnEP
	7qnctIKVeZ1RxW8dvntDely0Y8iEYF4EOvmtxq50jmDMsz1/s5eHx3vqAl/Wi0fajxHFyC/uxFR
	14GXOx+UtFyOfpqThkVp6tSdfr0KHy7/p+scF2JgVgTexOBN1BdstwMe8bGTT5p9gwzt3dxgr56
	qpJ5oP5XJ4p/eXsOrxJhmYgADvvF1QHbCR92leDSvPnMenNUsyTASIWAttO+hhTRBLD6KRQSGlt
	A358TFIZZiVIzZCsEr80c9zHel1xEnYVQXYY=
X-Received: by 2002:a17:90a:e7c5:b0:3ad:5c64:c7ae with SMTP id 98e67ed59e1d1-3ae897b67cfmr11186509a91.57.1793727928391;
        Tue, 03 Nov 2026 09:45:28 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5adc33sm5373411a91.1.2026.11.03.09.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 09:45:27 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 17:45:27 +0000
Message-Id: <DMLRHE17SEYJ.3UGA8BKK3ZUTW@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: <puranjay@kernel.org>, <memxor@gmail.com>, <xukuohai@huaweicloud.com>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 08/20] bpf, arm64: Consolidate the load and
 store emission into a helper
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261103122733.1383002-9-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net> <20261103122733.1383002-9-daniel@iogearbox.net>
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

On Tue, Nov 03, 2026 at 04:27 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> three times the same code. Add emit_ldst() for it, with the A64 size
> and type derived from the instruction. The emitted code is unchanged.

17 of the A64_LDR*() and A64_STR*() macros in bpf_jit.h have no users
after this patch. A64_LDR64() loses its last user in patch 14.
Pls drop them.
