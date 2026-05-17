Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B9308F0A;
	Sun, 17 May 2026 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779001840; cv=none; b=pzYZYwFHfqWiwslXnIUeYpI/Er+VStGw8UcP/cdLYvBhQLtogYSNEbuz//9ZutF46qQ8FQAw1Z6FktTqojxu8Ob2ehEkp+kraGhcxpDUmtFqwdmqQy2IhHSxAR0gzu9Cgm2xprDCMf02arB+O4jSgWoMjO5wlBaffZAh79sPfho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779001840; c=relaxed/simple;
	bh=/Ipadmz08bt9/6+a3Fb2p9rcrrvSMZiXHfyJPXXYKzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV5D6KC/TiWtB1IxdR+s4JIymBZuEUJdX1rl4N+PVvvN2SOjG5b2LfJe5VeuHRFfHo9tTEjdgP7Jn95bLet33lmaucJolKQTXSSFiu3vQOAZsmoJT5z5DmopWETmOHBCIo19b9py29+a+dQAWQazS4N/a/Wz+VU1AmZ/DLZUfdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oMLtXSW1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oMLtXSW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8087C2BCB0;
	Sun, 17 May 2026 07:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779001840;
	bh=/Ipadmz08bt9/6+a3Fb2p9rcrrvSMZiXHfyJPXXYKzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMLtXSW1C3ZLM3ONbVP1VZhKXnwOHJFqisAgu8QK2CeJ4x973YSV7eUVXkfil5dcr
	 AC7aA3dH9SF7Co2k9ZnCp/s/MMfQNWbQi1IbXAFJSeolew0eRHvQ3UypQCDziGSK6V
	 cT3BEhDy2xBIGLs+GM5Vm3HkjfraY750zl+9o5zA=
Date: Sun, 17 May 2026 09:09:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Afi0 <capyenglishlite@gmail.com>
Cc: security@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org
Subject: Re: Race condition in bpf_arena fault handler leads to page table /
 range tree desynchronization
Message-ID: <2026051739-herbs-spring-fdf9@gregkh>
References: <CAEABq7efY7w0RrEJHDen8sGVr+gYbeorap+Sv__f_V9T1Ay_Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEABq7efY7w0RrEJHDen8sGVr+gYbeorap+Sv__f_V9T1Ay_Vw@mail.gmail.com>

On Sun, May 17, 2026 at 06:23:24AM +0000, Afi0 wrote:
> Hi list,
> 
> Apologies for initially sending only to Greg. Resending to the full list as
> requested.

Again, can you resend with your real name and not in html format?

thanks,

greg k-h
