Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F97C33D6C1
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780109879; cv=none; b=GwC6VGBmKS0O21Tk36+Sz8Eia8ZxZI1RVB75UqoKInnuGrLN87yResQxbbrQlrVE+2dIhMTKSIKof6aV93upGNZFh7GyWxSnIeL1Yijsj7s8LeybY2YNDWghx9c0wVcLh85LbSCf1MB+hyLM0wIjUvKHeXv75Pkmu28ZSUCLJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780109879; c=relaxed/simple;
	bh=hzmV7jCw4Ve6lJJtReFG4xws5w/86mHQ3cXJgWEv2As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgho6Y7wfopxmW9OcDWYVtO2elxEJcMBrd0fAM+CfCjj9+8GBUMv8ujJHVeHUuKsAhewZBsWTl7VMIgo39iTsmff894VUR2Xqo1Ate7ThwAdacrU1nJjiwR/jPnZBb9yOwn+97KXl5550t2Rjyi7cuo899LowlBTs16WhBCfHak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o4H9iEWr; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o4H9iEWr"
Date: Fri, 29 May 2026 19:57:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780109866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzmV7jCw4Ve6lJJtReFG4xws5w/86mHQ3cXJgWEv2As=;
	b=o4H9iEWrQi7ekeOvZA2Y4XLn6PxJewqI+nnSfQRu743DVM97puDrZO97ojwIrq2Da8F6so
	P1MEabCrzP5yBwpyQ6uXNnsz+8WqZiTrbEznAVL/mfPUtiLhjjNbQMJsy/jhXts5swDlFE
	UsN8l0lUJrU9aKSL1NePdojWB54wPvI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	netdev@vger.kernel.org, Amery Hung <ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: MAINTAINERS: Update bpf maintainers
Message-ID: <202653023041.2jVo.martin.lau@linux.dev>
References: <20260529203909.1222164-1-martin.lau@linux.dev>
 <CAL+tcoCtph-RS2sASvPtYpiLrmLjNgxp0GfvapzWfQods4owHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL+tcoCtph-RS2sASvPtYpiLrmLjNgxp0GfvapzWfQods4owHg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, May 30, 2026 at 09:35:47AM +0800, Jason Xing wrote:
> Maybe it's not an appropriate timing to ask this, but considering the
> further development I really want to know if you'll continue with the
> latest series around struct_ops? Or you will delegate someone to take
> over your work?

It had already been discussed in another thread [1] that you were involved
and cc'd. In short, Amery will respin it.

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20260523083001.2911931-4-kuniyu@google.com/#26971716
