Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613849;
	b=XPmmxsiw4SFwrkTcaUBEPB+Qi2cbSehJ+e3FIC+LGnyYttSh8h3UxlVNdgxS/a7Ydojp
	 YRx0pdQU/i8VnhpqNqYKxnNPSzeuum5hXBOkpl5Nir15yu54ac9BQnb/GzSgKH65RgKZf
	 sT1DLinnXq8Ak3irMWy1Ilui9/bkdDUnWPtagNcfcb/5FB22CqqMIBbA4f4yPpamlr5B9
	 YYuCHdI+/E36UBowJh+qDI8pU6mgrWOsMdvUow0CiSmfhttmgziJulv08ut2gJ0GTzr/u
	 JXFeo2QvA5s2CjT5oWnzFPAlBwJ9UjI1kw2WBcZWwlOX66BMNJSwnQtf1j1gUtM7n9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Subject:From:To:Cc:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aW4OUjIIQjUPFcHTtnWclyPPg4R7VFoUgK4imjGVz3A=;
	b=TDhZyU1rgvcHi5X4edBOsbOhWNhMHebyNOT1XnraBMb/SXZrFeFkP2xP4Jx8FftCpVcv
	 aTvOEu16hPFM9HnW1AckIeD8v+RM7y8YIxc5XBxMzXwc21oowy+qoNS4no5fqiIAhbepx
	 D8s9ZDw2UjSocUhbDVQ4Lf3MIqbT6ie5Tf7ZbskKtwidWgvoDnSj6JFKCIKp5gmRMOzLy
	 ITJQGTMLZmNyjJIhUe/gQb6KycJ8XEfe6Cv9pbb07chEvAj+Y0Gq7pc6IHRZnlnopBqg4
	 LHwYd7x+F8LmU5QhcPQN6oS4CmXARQxAySxYw/FAD0CuM8l25o03fYpGP7PcEqf+hQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v2faQj2s;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87038606A88E
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87038606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v2faQj2s
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso550833a91.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794613848; x=1795218648; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aW4OUjIIQjUPFcHTtnWclyPPg4R7VFoUgK4imjGVz3A=;
        b=v2faQj2sHjPThklo3kvSAsdztwwUVuRSFp3BgLG0TbuqHqTjQ0SRFZfLGVnHzRdt4h
         BPFLguLiU6iNuxLrBySq2qMcoIL3vedz6F9MaXkfKvqUDFhpuaNBtgnmkHiFN/1GspGh
         umudzPDvpiOKqZHDOz3xtaZuVQOO4OQspjSacvFJFWn5Vi5TqLdJZQRqwf36D8FOzL8Z
         JKLL6pd7Z1vDlXZYPL0d4CYDZ7Ev5uVq/MEIJfj5uYrgkG1M9zvh2KIFJ04OGhAwgJJj
         vFxiuvwsWIbcMUERQhKmZu2sg78xA3dM76/kDq8MFXa0ZnoAoeGo8sosWedpCZzi4SeW
         HQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794613848; x=1795218648;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aW4OUjIIQjUPFcHTtnWclyPPg4R7VFoUgK4imjGVz3A=;
        b=UIokGKmZv+mfQ3+B/HWqZCCM260N4pBvPQ/znsPrHmoG/WJtY9illUSMskjhEeHRuv
         DS0s1EUwKaBsLp9OFt/5KiK/QmFCPFu8g7G8PfcmEFv72cWWPRZUcOkD+XiC6JbTr+0y
         uJvHdOWwb7VrdToHDubKHWoKwb0MUMprLUFDq+gEbKrxssanifEVu5Nc7taRoFveX+7m
         wKj4Bh454z7CaAqydMN8a03W2xL2RayhFU7Y/8H9+3GSZguIvwik1fCTCNZqGubhpJz8
         Z1J3YxqiZa+sjLoRFsHdEoMT2NJGj3WC8O4NgP1V2xz6GGhCyNGwnysqkZL8RFCUq1JE
         en3Q==
X-Gm-Message-State: APuU4Z+Rb6b6xQIrW8P+GkYFCTKOkl/n9Z6VwT0CZeVumDjofs/eHlKr
	GlC8QGB9DCNAiwc0L2QFI5/M4caFh3GHFFU/sArMcWLqRiVhhzpzlUZF
X-Gm-Gg: AYBFou31eyz9afZO/9DpKLRDRqWzR3AV5YgIp1nwzOdftdEujdGSN09/AJTqqyBrpyx
	YSji3RmHwBEm5gg2ZPbFaL9hHUn2gbAuywDUgGSOnOsBPpX7djnNqzAinXnuU7wKP5XZiI23Mo5
	ZNvwUDTDosnxSnRoophyMpCZ0dhL9n4xmY+XFPHGY0KpirU1IvCyjd6fXEw1WvjSKGWQztkGLm6
	6vA511WEabI/fybhA+EVuhIPBGIkXg6ni1fhEKMcNRw9YFa7tRhPw7z5DWV9ozuX6JeJ7YIeyOZ
	1yzZxgkAqA44uT7pca0U9G4Cjdt/BVA3rnPvKsGkM7k714UEIzytkReX5QsieBc7oTBn/s1MhmB
	Aqre7MDfEoom0TW+WIJQm1cRZDd1MuFTcNN3mYl/RlkkzRWSt699m6OWG4IIwodOP9hcAg+e14x
	wFegW92tenQAOfOw5mIOGgIqvHH9tSPwvKjYwV/DtJJ7o+mcom0qTJLFyBdcTLkWHPVVuyvth6J
	nusd/K66U6zZIWbjlCai23px5+U1F1oL/mR8iGYCtHhfkYAoMHEOg7imBaIQy9wXdEIfIvnNKsQ
	2h7bWxBySNLeUIgrHwcC03WrHDeIy7kTIp+MuiQmUkHGGDTwugZrDwwrGpG1XVC+HZVTyTJgPUS
	hHqlRqtJA+895zyVZhhDNjtc2QakweRlvssY=
X-Received: by 2002:a17:90b:2f0c:b0:3b0:8947:fad2 with SMTP id 98e67ed59e1d1-3b1b0ba0a4emr3788699a91.53.1794613847830;
        Fri, 13 Nov 2026 15:50:47 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c6c9c5sm11507001a91.1.2026.11.13.15.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 15:50:46 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 23:50:45 +0000
Message-Id: <DMUHIJ5FC8EA.2XFM7TJ6AH0YB@gmail.com>
Subject: Re: [PATCH bpf] bpf: mask speculative out-of-bounds skb helper
 loads
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <datrujillo@nvidia.com>, =?utf-8?q?Dani=C3=ABl_Trujillo_via_B4_Relay?=
 <devnull+datrujillo.nvidia.com@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20261113-cbpf-ind-nospec-v1-bpf-v1-1-764ac4c14573@nvidia.com>
References: <20261113-cbpf-ind-nospec-v1-bpf-v1-1-764ac4c14573@nvidia.com>
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

On Fri, Nov 13, 2026 at 12:15 PM Daniël Trujillo via B4 Relay <devnull+datrujillo.nvidia.com@kernel.org> wrote:
> Mask the load address when the converted offset falls outside the
> permitted range. This removed the leakage in the described setup.
> Derive the lower bound from the network and MAC header
> positions. An out-of-bounds transient offset dereferences NULL instead
> of a potential secret.

I suspect you don't have a reproducer and it's all theoretical.
Because if you had one you would have seen that your patch does nothing.
convert_bpf_ld_abs() inlines the LD_ABS fast
path with its own bounds check.

wont-fix.

pw-bot: cr
