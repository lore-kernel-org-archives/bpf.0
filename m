Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14634EF0C
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144001; cv=none; b=mLq3b8RHtYBx6YaKY1QlpPMcNuOcyPLyQfBe4CIo2ibp9Ys8EnhRLIAAGs/dCluXxtSORexMzaNQwTeGR6LnToOQl7cHZ55amo8aNx1mQo8vH/cnpXA+K8e3GVVXHwBfm22OjBrON90pFpHljPLCc05yUdjYfDeGVt0lMUGkhNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144001; c=relaxed/simple;
	bh=yMqnqUNFox8wKqlIyYsdw493YGu2RpM6xI0J6HkQRZI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PrpnLuAWrl8NjnuTdHzlvnGQ/WJLHGjGd4rIv8nEsx3W+ciFBS55P0uKuT578BELW02jfSNtIPe/5STmfr20ieDirVaDZI4FXSaE+GZ9hV5jtBbbPYX+Cg/OcH/NF43yRWtF8+sUuTYTGQWOnxZYwmehnIvwMgT2v8+xK2zCDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g722jmN+; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g722jmN+"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bd65693so2805655e9.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790143998; x=1790748798; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PF5MzKkNoEIWYa+3K5GWbxEGrek7CrC+ou3xLUgYO10=;
        b=g722jmN+WvODxp6zBFWHAG4Zla5wk4C9BArRxWCUZQxSXtREa0N5bp51mohxxKOnyG
         vSjN5oLfU5UvnHE8lH8bwYN6qr2VpsH5n+wEbIt4KU0Z64epb7g5wOL6MUvk4voM+R+D
         WMl5s2khglLvEgwarcusIoxA1Y3rPhfzTgZSry7PweWLu6z2Nxn2m2KnYQjzprxRcSP2
         /a0PwnjOfX5ndUd1JD/HgCwNUZ+mydOTvahrNh5AIHGYERAprRNVgmg00yBcn/Ck1uNb
         PU/6+GX4aOFMgcdBEVBlG7cDjxT5otror72+Z/K1StJZXSBO1De8e1Igqf2v5bSXbr9d
         0OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790143998; x=1790748798;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PF5MzKkNoEIWYa+3K5GWbxEGrek7CrC+ou3xLUgYO10=;
        b=2ZcRf+tihbelFDXNcXdc5lN6FmmKN++NaDyW4X/Q60DZsjmGgH1JaMh3DcawbgUPWS
         GMNDDQ5DUd7bVft3yntDVTUqzPFLvXhwSCppRm6TbguVOt02RQI8OufC/3pUhzVsIVaR
         y4cW2cTQM2e013/O3doZE7n1ZoDqKhTYXEjKPyq7nH0ULCpSmY+PokGc5qNIqf/KJACK
         d2k+wZzkbrxHjkVvXvao9rIbaQ4xq8rdmUzOL5tR7rnn7wzB2dI5o37iri/kU1yt3Jm+
         Umz9WTwnYoWxrS19xYg//cFuEqR0M8nvYZmBqpfZ0y5aq/cy+G5QJsrxPXwQ/Oz3KGID
         dzjw==
X-Forwarded-Encrypted: i=1; AKwUvBzLfGXCroQqb3NBpVogJv3brJVdPVO+ruatMYPYTDCELvSuFBR+N9gZUk9++sLihEea/os=@vger.kernel.org
X-Gm-Message-State: AFuF++kTPaRdx4JZYc3FLPS++wabP5P2TcdYnMJc30l4XcQLBCduDCOy
	aDBqLXgYsjbU29CDekiqxtvWe1MsLvE2CQ9ZGNy4mWgFt9eOuCu+q39I
X-Gm-Gg: AYBFou2yG/LMOa7u6vvRMcKxwxLECGE0rhP7pQRqDIWnlMXJ65jjcHjFhreb6f39YI0
	Um9kV13YR1RdAxsrqsnQYuPBmj9FxOq5swcDGpqvM2Vkur9cvVthgpEwYKUrGqCRlvQzpkgNo+u
	/3dRS2beZ0kLfXL8fGvnuBs454Dqxwt97IcxA1y+t2ifPaNABzj+5Hlz2FC8VrG2CI18BvQCN4v
	PxXihqwJqOjz79tVz92TaVnL+OAIyTgCiozf0z3cya9e4OqBbNqZGrATae3VYW+Ori0gtw9CeXV
	fl/z/wccx3u+UNFIrRIhAENVa/Rpih1ACkfvl3BxCaRH482cB3gsZJjDqruTVTX2Hujczq9SGSh
	k0UwGS4gFQ3pFwnqz1Ckf2pCVehRVdP7gFIrXlVmQMdysmfFq8x7R4v87nrQjeXuID+l/f7jDQR
	arx7EemXYZTysr/vteIVmKPVk97uLq51bmytOMn8+wnpcLxRdd0xGGQPn2T3VgQKEbrCQL86xTT
	STBNlsQkO060uyn4Twb93qMHsSUgI5SunF5rQwKr5ccCj4uiwXOzhaIenTucE3aFHrPTgGr9gXO
	UMwmoIE6WuVYsHRoV9MewM3ruD1ypkvmh4tmeg==
X-Received: by 2002:a05:600c:19c6:b0:49c:fed6:cd3f with SMTP id 5b1f17b1804b1-49fdf139574mr15648985e9.23.1790143998377;
        Tue, 22 Sep 2026 23:13:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde17dab9sm62060025e9.2.2026.09.22.23.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 23:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 08:13:17 +0200
Message-Id: <DLMH33D9NQ73.1U8QUEJHZM1BO@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v5 03/21] bpf: Add the bpf_unwind_resume()
 kfunc
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
 <20260923045901.2415616-1-yonghong.song@linux.dev>
In-Reply-To: <20260923045901.2415616-1-yonghong.song@linux.dev>

On Wed Sep 23, 2026 at 6:59 AM CEST, Yonghong Song wrote:
> A compiler-emitted cleanup landing pad ends with a call to
> _Unwind_Resume(), which carries the unwind on once that frame's cleanups
> have run. The kernel provides the same terminator as a kfunc, named
> bpf_unwind_resume() to keep the 'bpf_' prefix kfunc convention; a later
> libbpf patch resolves the compiler's name to it.
>
> The kfunc is defined here but not registered with any program type yet. A
> call to it is only ever valid inside a landing pad, and the verifier cann=
ot
> say that until it knows what a landing pad is, so registration waits for
> the patch that adds the rule.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/helpers.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 301b35bd85c8..249418e60ee4 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3445,6 +3445,19 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  	WARN(1, "A call to BPF exception callback should never return\n");
>  }
>
> +/*
> + * Terminator of a compiler-emitted cleanup landing pad. The compiler na=
mes
> + * this _Unwind_Resume, the base unwind ABI's entry point for carrying a=
n
> + * unwind on once a frame's cleanups have run. To match kernel kfunc
> + * convention, the kernel calls it bpf_unwind_resume and libbpf maps the
> + * compiler's name onto it.
> + */
> +__bpf_kfunc void bpf_unwind_resume(void)
> +{
> +	/* Never reached: a JIT emits the way out of a landing pad instead. */
> +	WARN_ONCE(1, "A JIT should have replaced the exception cleanup resume\n=
");
> +}
> +

Can we change this to void bpf_unwind_resume(void *ptr__ign)?

Itanium ABI passes the exception descriptor to _Unwind_Resume. We do not ne=
ed it
right now, but I feel like it might be better to take and ignore it. Changi=
ng it
later might be more expensive, while it costs nothing to change for now.
