Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378156;
	b=K3wSG6WafK0E3SyA+tIzjlblVQ7JrOlsPg6bTJhNElEBV0bFLMpEJ6ZfSWhhlRpcxwlW
	 dXnvWrkPy9Y5PtyUSjgFnFnpGGYhQ3c53PsyozIQIzk9ejRsJ7bKqUayN2yUREDxY+4vz
	 TxVsxWRUB7pS9vLQLeEv9ccpg7fNII7G2Ad8TVvZswCZARs2Eg+ZAPvARQ+WTVLNIg6x4
	 w8QCY9RfHul6dKfoukJHrOGnMZ4QxwDb8CN2BuyxbK1qftQmubbIGo4tR8PkQ7+R89uSh
	 1aj895e7CNtZ3GUT+MwCBKxvW4ItUv6av7aR4w+CTExaCrqazxmoS677RY23RNduSMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378156;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mOEUES3n9WBz+Td5J2UDOLswgdajrwsgPl86q0xc+mo=;
	b=wrg4XPvi1Lqi2pw+9dAPOsRIOAazgzW3HFGHmv3d4Dm7FMm2c4xq6c+KcsO8ylzTs0K9
	 Wv0w5WaREONOIfWoEWFD+kyEO5gWaQ4j8WD1OxcyADH+IbRVvfORRvF2O1hRiiKjqJoaE
	 5XRjvQdSOrHxcewXNfZajRhBPosOfmU1/OyxvDFgXL0ttl3hGebYhpjPbehH9GWi5ccIk
	 yJthOT8TC5dNTd5ZD5WK/KkcxLz6XtTGOrS3T3G1b+FiZA+1tF+v7/tfncZIvbbCatDcy
	 pWj7yySN5N+7o4IkYEqbWIIEHaqQ0YsXeaaBej+9Ewj+GSQFhnS9DKokcKTQxaYsbCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=UUkf8cLT;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145F606A680;
	Sun, 22 Nov 2026 20:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5145F606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=UUkf8cLT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 99DA440E01E1;
	Sun, 22 Nov 2026 20:09:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WDR8YvqfB9hL; Sun, 22 Nov 2026 20:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795378150; bh=mOEUES3n9WBz+Td5J2UDOLswgdajrwsgPl86q0xc+mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUkf8cLTX8lQXqdd2QA8oqcZ2DG1R/hpaxXJ4+FLRZTrqhEkoQsNKMUI6rbL4PLsi
	 uB8iNuqOK2fpoYZKyyc+EKPRXm7JSuDVuDA83d0KiTTFwoDzml7Cv3quKIIGssllLI
	 DBEYh/pIgvwuyoH/uwJ1rqgX4tqPgRzk5V75V3Q25LKzqS8MDQVbFFXdYlHaUicZbr
	 YCVPvsFY28sJDG7QRth9yBanZCyrfBufyst7CxLjD2Gzgg7moq67rp+tAabZNkX7Lo
	 BS7s128qXP5n/zWr1qIxpJ7JuSG95gLDm5bs/4Z3MbjrIpEfLQUK/8wPJYGH/zOKeR
	 33C8hZ7jm2+C0MIDihkEE1MqVS6EEEnpjeLThZBRXe6eMaigdRDD712iKFqFC1aXkl
	 2ENuO5SZFcftngaqeeLNjAVG/JsCeKvKffcmNjWbh1g4AnS1yvBX5q+kaKBb5iztLV
	 dSBP4FseoZiqN4AI+xMtHEtCLbbwYt+tYuDueS+J2PLw3J6yFgNke87R0303d2Ih/s
	 C4wmdn4McfRupBgrBeFU+tfznQj47fYjr0ODf/oIEjYZArL+kB7ARXvqUwc9sl1nDj
	 g5TgbS2PK033jY63jDrWkKRDEyq6gi1TPyCryCqrmb+1eWcMTjJIsxGF6GQuLlvwIK
	 ac9iFFbEXDKawosAXrtZFHdc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C2DE40E015B;
	Sun, 22 Nov 2026 20:08:51 +0000 (UTC)
Date: Sun, 22 Nov 2026 12:08:48 -0800
From: Borislav Petkov <bp@alien8.de>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	kkd@meta.com, kernel-team@meta.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for
 user address faults under SMAP
Message-ID: <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local>
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
 <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local>
 <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>

On Fri, Oct 09, 2026 at 05:23:13PM +0200, Kumar Kartikeya Dwivedi wrote:
> The advantage is losing significant amount of code size in JITed programs and
> the associated runtime overhead (you can see the numbers in the cover letter).
> 
> Do note that we can make it more generic, we can follow up and optimize
> copy_from_kernel_nofault() with cpu_feature_enabled(X86_FEATURE_SMAP) as well.
> But I didn't want to go there just yet. I am happy to work on a follow up if so
> desired.

So we basically disable SMAP around bpf programs when they are about to
accesss potentially stale memory and the only line of defense is for
is_bpf_text_address() to really DTRT.

And once we open the floodgates here, I'm sure you bpf folks will find another
creative way to flip the kernel on its head.

And all that just to save some bytes.

Sorry, this is simply not worth the risk from where I am standing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
