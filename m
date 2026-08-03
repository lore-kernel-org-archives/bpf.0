Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259273AAF52;
	Mon,  3 Aug 2026 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747558; cv=none; b=Mki8jxfl+tgxQ5LlCApKM0hQUCNbyq5EjfhGlqD+xKxxxSskk/ioTLBLFUE7LxKAnaavIPKJBM23+naHsK4TEHnlkHo0VisnmfTf9LPWU+8cR8j99TdK/9hizyP6T1s+h5dqNvjlQNV4sZbCMwSiUNLMr4av0vjRQfOQAafgP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747558; c=relaxed/simple;
	bh=Uz7pQWv7kH8qOAbxa29cop3HtGle5l8g08h0cTTulEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uxcb6jKFeSKNUR5n3Smu+OVWyrnODn3tr76zUnB+v+VyZ19ru0TEf7ngoSTJqur9rh48KDNdTm9Zxk6ZxwL/bER7b1uzSAs9CW+byu+Qomc3/oGm2VYMfQpFyG4KL1RDXmEtvt37tku5mUjY9jxX5wwrcYe6JONsQExitHXRYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JEVzOADs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d7YtTSpN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JEVzOADs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d7YtTSpN"
Date: Mon, 3 Aug 2026 10:59:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785747555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjR9KfNljtdyMcyqsTTvIsJbyXaYhF+J/Xq/oM2Nk10=;
	b=JEVzOADsT37vlekMQ+SfvBqewzo4W021OPOfEZHQrzpzOj2KmltVIeXierbL5HmRzGN3Hz
	2NTykRCZO0UyedhOSb4c1H5QLN9SZyPtKzM5be/OqPbPRoLUBg3K20sxe8k53GFhbN7ocK
	PbbtQuGE1SBqLjLX1KHoP/4b8gI8x49jOioXAZ6oJ9o+CpubA7AQrEcK8CJZ/oR8g5trvc
	JMgPl5uLlXiN3yCi3aN/m7KDN13kXRatjww+hEr5VJKndi2ja7WHRjzg1150hRMK6azUaR
	oD/OG+/aWEBw2qMZ7ibEykAsRd5HChh7Oz9hgROy59obcjpAkuLi3SfD+fAVIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785747555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjR9KfNljtdyMcyqsTTvIsJbyXaYhF+J/Xq/oM2Nk10=;
	b=d7YtTSpN2lynxkdzc3ogMAqhlbgP+9AlKdNK+OZV38DruunGWtEf4YUJgw9xgALKDSZUEP
	tKClnbMHqVwWBTDQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next] btf: Remove the dependency on BPF_SYSCALL
Message-ID: <20260803105558-f788c3d1-b159-4a79-ab22-3d784322dbbf@linutronix.de>
References: <20260803-btf-dep-bpf-syscall-v1-1-a03291e27888@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803-btf-dep-bpf-syscall-v1-1-a03291e27888@linutronix.de>

On Mon, Aug 03, 2026 at 09:52:39AM +0200, Thomas Weißschuh wrote:
> BTF has become useful without the BPF syscall being present.
> It is used by debuggers and introspection tools like pahole.
> The dependency prevents the usage of BTF without pulling in the
> rest of the BPF subsystem.
> 
> Remove the dependency.

Please disregard this patch.
Sashiko found a few valid issues:

https://sashiko.dev/#/patchset/20260803-btf-dep-bpf-syscall-v1-1-a03291e27888%40linutronix.de

The patch somehow passed the 0day bot. I'll investigate.

Also pahole is perfectly fine using DWARF debug data.
If no debug information is available at all, it prints an error about
missing BTF information, which confused me.


Thomas
