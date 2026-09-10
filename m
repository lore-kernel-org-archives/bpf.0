Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F3391E59
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053113; cv=none; b=ncJQLR3g/HxWDViJugTQYuWwyfCJzqepUMgBF2qEsEE7FYIKEMYGaL87GpQT/FBLcvNFZgZMup2Gz4Oi8SlN7roRdYJ/WD3X1ZRX/vONbol7sURMDS3dVf3eZF0xjnoaezOwL8rgnfsw/Xqydj2MAxe78MD3sEVaqs2oFK64wMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053113; c=relaxed/simple;
	bh=3jgrdQIt1ET0uZMiWj0NPWB1AYpRC88AwB/JQGmEhfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMBut3gRB1oiQO8iEZpjj8N1uxmF8q0ybS1EH/Ws7pCNBcGRgQEWKnwCwEDHBHZpmvbbeTYALSMvJPP2TW1w5UtHMJgTVZUop17KnhtWAl44jOZa2Yx9mEEbk8CpSPlC+wi9SDtUkRil5taXXQ+q0uBxlagO23ypoXkha8QOv0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fpjLan0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fpjLan0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000C41F00893;
	Thu, 10 Sep 2026 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789053107;
	bh=YsCCXRD/9vt7ikuAEg5QWjKX/23+8fEhGND7H0+R/SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fpjLan0EySG2xLb+DGFxfOToqb7PgxcRmxel0g7ppnQeKV/Y5oTQkmNtJLzkyTWhj
	 bxqT1fq5R8/qUEd4EQ95KK9LW1XQUIcnKOvvcVKAXKn8dIuEzQIQbcNyGES28j/bBJ
	 ID+ohrW5YO0Ryvc/tS3XWQPanMyxO2uSxIRYvr24=
Date: Thu, 10 Sep 2026 17:11:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Daksh Vohra <vohradaksh4@gmail.com>
Cc: security@kernel.org, bpf@vger.kernel.org
Subject: Re: [SECURITY REPORT] Logic bug in eBPF verifier
 (reg_bounds_sanity_check)
Message-ID: <2026091005-blouse-unmolded-61c2@gregkh>
References: <CAOgkP-w9MqFwZs-rgVPAky4r8oih_=Q6rzf=kwpwhi=jr0wUPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOgkP-w9MqFwZs-rgVPAky4r8oih_=Q6rzf=kwpwhi=jr0wUPw@mail.gmail.com>

On Thu, Sep 10, 2026 at 07:36:36PM +0530, Daksh Vohra wrote:
>  Dear Linux Kernel Security Team,

You also sent this to the bpf public mailing list, so just send a normal
patch and it can be reviewed that way, as something went really wrong
with your text:

> memory operations inside the kernel. Suggested Fix: The register's ID
> and delta relationship tracking must be safely cleared whenever an
> internal invariant violation recovery happens: ---
> a/kernel/bpf/verifier.c +++ b/kernel/bpf/verifier.c @@ -... @@ static
> int reg_bounds_sanity_check(struct bpf_verifier_env *env, out:
> verifier_bug(env, "REG INVARIANTS VIOLATION (%s): %s
> r64={.base=%#llx... if (env->test_reg_invariants) return -EFAULT; +
> clear_scalar_id(reg); + reg->delta = 0; __mark_reg_unbounded(reg);
> return 0; } Please look into this issue and let me know if you need
> any additional information regarding the tracking mismatch.

thanks,

greg k-h
