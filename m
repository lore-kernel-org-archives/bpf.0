Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691901;
	b=NtFsbgpO7v4jOOUfmYf3iwyfZPwZw173dIxXX9fKKUOOaONFuD9BfZ2iOIlpMrUesoXs
	 K8CETtWF8pPP+0DdDPHMfogBTrSr0TZCij5EamtjLe25I60Lbw2Sijrye9UqBtciaNwWI
	 ZWihI0dhXnf0PF8mQwQNVxpaGWYqS1n8Q43GVLQSsnhaFQeGiQlP7ICG4CzuckiegUhMU
	 uCR9dzebNX5BVWEly6e6uAdXx5eoIRXcs5a2zPgGIn+FmNmUfKwUmeQnVTaJp2segN8Al
	 oN+NIcRw7CkjW8hp1PJl1m4Rdqn//pVWLjs0EBrts+AxX/Gg397ZqPOuWagb0aIunng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JuoWZ5PaAqlrxaQWLxCLwI6mxP+p/pP2XqPveJTwQX8=;
	b=CDHkGodl0kLaDqvlP9ejo/Rw8O7Anp+/9if6zVQrd/FXRyFgl8bypBaUyhK14CZXtPut
	 Xs6vvcs0mLROQkld5oBUg9zTTxNWB6Qr7BlwHJq9y/4CkJjg7w2qJDHe/38ajs6QR5dzR
	 H3NSYotUNiSiovGzbHlM6RiqZkDbFX7KbEf0JtiYhrHYdHD2w+XPL89tNIfo6shi/tTJi
	 wQyn8SLSp5Ax7meAo+IPn5/KpB0TwPJXNTE6unNI1+dJvlN596hIfhJi1M+6EZDVaJf5G
	 V2iiyxCdFqEc0eaqnN790sucVI4BHmc3S1jIw5Xmk1BwPL5Al6xsWCcWgItje6YB1lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qhkPM+KJ;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E1606A337
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 11:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE7E1606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qhkPM+KJ
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso6117827f8f.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795691899; x=1796296699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JuoWZ5PaAqlrxaQWLxCLwI6mxP+p/pP2XqPveJTwQX8=;
        b=qhkPM+KJjHl6JvRTr3nsX52B1pi6XW/s4Ud0+mCgkaf3VSLfSM8ZY0HzcwXyRW0Dpv
         i3ldlKH6LVFSLE72hSYMKWEOMnsqEO235oAZC9mlpLEiGFNeH7xcwgC86dkEohNj39iq
         fkhZvFXpfcS9ApnHsgWojX1xrrhHw8UkU6Ji+PENGSVpx9H9SDpILBecSJsEciRh7AEL
         ni2ngDw1oDXHnav9sGlP7kqlk6uWsFVqZjWWo3kXV7M360ybaoKa5l0AXlBhM4DjK4mM
         QXfx72j3E7fbzT7HBGuiBJ7HjFVrB4Zc77Cf+M2iYiSz/frN9uBhwIAI1JYu6iSCakDw
         IhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795691899; x=1796296699;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JuoWZ5PaAqlrxaQWLxCLwI6mxP+p/pP2XqPveJTwQX8=;
        b=rD4/1LT4kukSXqppgVJlcHb3WWVlapgNVnfjANA0PGN4inneTbmeMc9dc3knu17V6R
         3WmLjr2esXhOvz+YF58y8ZwLp/EG7DR83yHMyDLpknaMMrgFVt12HFTfEmEcaKRLlfb0
         vuMR6Rso6cRzMNse2w1Kv3QXzKQ9SPI64CupeqLeES3uGtdLdUgNm4vMIcL7NoWrfCdZ
         KhvAOFcfi6af8CZnI/ykzisfMLAN94U+6N9qmRAggvtJu8tRRTVUDPxqV7SatUs4aCJJ
         tw7IEwjLeqEeUYiuHq0HxwMZOL5cb2R/wswKGyeQFQkf3v8RjCtIAgGYUVN45gfpxjdI
         y5/w==
X-Forwarded-Encrypted: i=1; AL+hErEYGKZBg4w4Uj58kJvj+K7VEa3xjuRWm6C9h1KnlpP3JZDYO8gEGyxLy5M7FRMEKb9Y7MI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mxFTeZ9YCkcwRYnYf8TQIQWGC7Be2eB665nqG4vkzOu9Pp2hR
	oL+EVZs/u6pKkZg5U8/JPgLADwemYwuRFTvGePCs/C9YqULaXVriy/T48pBlyQ==
X-Gm-Gg: AZFdTZfRHQwIJQ9reoC1UunLdRhaMvvHqqQAyzc5Xh/5shCPRfsB/Wdv4/CIjpIYRtA
	8sfar4XYNjjasC2J6Wh4nQXUmgzkSE2Z3P6lIhL/UCc9mZpXOd4cF4288m0+PDngO+75ck0FwHp
	t+OpntQDqprFYCRHPk2JXu1bV4gb5vGLNbdB5dnH0OHuWDz2KE49EH4yT1UiubMAEop8vJwHQWs
	NYqEg1jNdbMK+YwbN2TDO6QWSFhr9xkLzHoR86Qt6ayPiteMoEfxuQon+qbvyDfIbsvUki1iruE
	nVTvqJ0rPzM3tKV1HdBLpaJnINpXLu278ZwaZrJgJ9G2d5uwB8HPRwET56Nj4SADQrKxUQBwaOR
	nNE0MDSN1IhiMi+tYksRG/LJV63aE1opX9yM3LWBCpkm61JYfnwvauQkclH0Msd7hs9T4bsIIMT
	QPRvEIzkHVh+JgbIRfvpz5+6Tx3A8hDCwwDw5t8NZM5b5E10mpWRhdbXVgiP4JXsYdq4XLdK2Ur
	yz6qSF9XPanmnpnHBQWIvEP+5wNq1meTsKAuW9T/L0CL4+fGkm13k0jIQWdOAchJkQIJvNTxJV1
	luyRXEmhT2n/B+yLxFxqrodpiPBq/bKSYSDlfg==
X-Received: by 2002:a05:600c:848a:b0:4bb:6626:5a25 with SMTP id 5b1f17b1804b1-4bb88813462mr356555095e9.20.1795691899208;
        Thu, 26 Nov 2026 03:18:19 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b8429sm933119555e9.14.2026.11.26.03.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 03:18:18 -0800 (PST)
Date: Thu, 26 Nov 2026 11:29:55 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 3/5] resolve_btfids: Exclude a set of
 functions by name
Message-ID: <awgYM-6nmK3-SzvV@mail.gmail.com>
References: <20261125212849.868523-1-a.s.protopopov@gmail.com>
 <20261125212849.868523-4-a.s.protopopov@gmail.com>
 <DN4QFIRN445M.9M05B3SZ7T44@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DN4QFIRN445M.9M05B3SZ7T44@gmail.com>

On 26/11/26 12:56AM, Alexei Starovoitov wrote:
> On Wed, Nov 25, 2026 at 01:28 PM Anton Protopopov <a.s.protopopov@gmail.com> wrote:
> > +		"bpf_remove_dentry_xattr_locked",
> > +		"bpf_set_dentry_xattr_locked",
> 
> The bug from the log of patch 2 stays one call below the helper.
> bpf_unlocked_sk_getsockopt() has no tag now.
> It passes optval, ARG_PTR_TO_UNINIT_MEM, to __bpf_getsockopt():
> 
> 	if (err)
> 		optlen = 0;
> 	if (optlen < saved_optlen)
> 		memset(optval + optlen, 0, saved_optlen - optlen);
> 	return err;
> 
> __bpf_getsockopt() is in net/core/filter.c and takes no bpf type.
> By the rules in fmodret.c it keeps the tag with -EINVAL.
> After a skip the memset() doesn't run and the prog reads its stack.
> __bpf_skb_load_bytes() has the same memset() in front of -EFAULT.
> 
> can we skip bpf_*() and __bpf_*() of vmlinux by prefix ?
> Both *_locked names go away.
> Modules stay as they are, bpf_testmod_retval_*() need their tags.
> A few lines in fmodret.c on top of patch 5
> 
> diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> index 384efb5..18b3fbc 100644
> --- a/tools/bpf/resolve_btfids/fmodret.c
> +++ b/tools/bpf/resolve_btfids/fmodret.c
> @@ -93,8 +93,6 @@ static bool excluded_by_name(const char *name)
>  	static const char *const names[] = {
>  		"copy_from_kernel_nofault",
>  		"aarch64_insn_patch_text_nosync",
> -		"bpf_remove_dentry_xattr_locked",
> -		"bpf_set_dentry_xattr_locked",
>  	};
>  	unsigned int i;
>  
> @@ -166,7 +164,8 @@ static int read_bpf_code(char ***names, size_t *nr)
>  
>  static bool is_bpf_code(char **names, size_t nr, const char *name)
>  {
> -	return bsearch(&name, names, nr, sizeof(*names), cmp_name);
> +	return !strncmp(name + strspn(name, "_"), "bpf_", 4) ||
> +	       bsearch(&name, names, nr, sizeof(*names), cmp_name);
>  }
>  
>  /* Find kfuncs and helpers */
> @@ -380,8 +379,8 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
>  			continue;
>  		if (excluded_by_name(name))
>  			continue;
> -		/* Skip the code of kernel/bpf and of the JIT */
> -		if (is_bpf_code(bpf_code, nr_bpf_code, name))
> +		/* Skip bpf_*(), __bpf_*() and the code of kernel/bpf and of the JIT */
> +		if (!base && is_bpf_code(bpf_code, nr_bpf_code, name))
>  			continue;
>  		nr_scanned++;
>  		err = scan_func(scan, func, &values);
> 

Thanks, will address al of these (and add names from the other message) in v2.
