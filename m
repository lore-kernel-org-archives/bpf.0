Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344B37AA78
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004352; cv=none; b=fPGkxVtKhk0u6CUQWNxqz5F3EVi/v36yiJncLGdAfvm0M1kXDkf/IZP8eETvtpr5Wno78xa6RRwDjLKkG5Tn9zuySbUWhZz2WrW/nYaKIi0nRVt0mFcgoTZpcjrZZa/kJbGiMDy+L/0nQ8x534Q+RrcECCRfHYSVVCpUwuJ9djQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004352; c=relaxed/simple;
	bh=Rk54IAaE6VVUUw2LLHOVHkQVqBe3J7+3RvRWEEH/U2c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gNY+fq2i1SQ2Zl3AChM7LZBtslcVt3dnax0De7+cnWfpe6rRXTl2udpT8DOmJy0J448eJ/CH/SeJR4Pdd5H8AUrdmlufWT5wIWNaOEbtA0I7AClLvRB6ZHHgpyZCdgMWBVu+5ObsP5b7rofyQIZK0S0aEAgfmZSJFNRvuNVCE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACUdX9uh; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACUdX9uh"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5e91e422859so2241808e0c.2
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792004350; x=1792609150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LubmNDov+kRdJeSgDmNkTIoCyYOuN6AaFESo8XksX+A=;
        b=ACUdX9uhrjCQKOJNqny++2sBR8t9Y6CrMAgUBfktaL/EF9F1nnfYH5IMEf/GDjjFGt
         QA5VTDoOGMvg3vJybBlg56rMVFd5NkHgVijKVbD8i51daSkxfMwtLEjgQy0lpF5UBdmI
         VMlVOXW8oEgddav0TP9GZT5Mr3ycKRToI9WhY7BOSbApSNCS10G+etk+v6HUFcau5Kqf
         2nGjWFB/i6zxDoQGqUMD7BNaif120D1yDDUzvaV3PB40SglQZnkaMYWi6BTkEGxNSU6E
         yIsb2stFBpB747PFuJRhoV3q60H20gP6xU1cMrAXEMbJ4vqMcX3+8UofL5iE4FiAiqtz
         2uWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792004350; x=1792609150;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LubmNDov+kRdJeSgDmNkTIoCyYOuN6AaFESo8XksX+A=;
        b=XHJU4E+yf3w+PyHfXgHLMsys3mdoyFl0fkzQykGS12ECstJA/RBKGpsCXzGrx2bRcS
         4G4ospWsYBYriasnHhu+L8njVvKk40rSNJRIyLv0VITmalDWwa14llWHkAvOlYSb9UzI
         jYvZ/+LDeFDAVNxezbUhinCcFmWTz160+RcIDkMNMpW/+drh8CG0uZ+HZ/1TJeQcbiW4
         RWWkBFB9e5VcD2iSGVYn1JpKKGCR6vgEWs/9BgSJg7BArAhw48lMJqqpHkqj6YBIB0lq
         HlkxQzGOxV534DTL4+J8Y6u6LpKAZto/9Wxe0uxyofWygMe7jUHa4DOiMI7RdX2xvUOk
         00gA==
X-Forwarded-Encrypted: i=1; AKwUvBwSXUZ6dDVUxXozx48nOtbMWIegwHMPc0QTDriq8hYiQy1y8wQDkP6/h4Sriht5SZit6cg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRoQuuUf9ygc+eeYGrcZfKL1311rgreQPziX+RixEk5b9hEnJO
	+GssFGkd3STIctrbod2nV5u6v0GVXsVev0cuNF0MuAs/KA9wEupmUZ+M
X-Gm-Gg: AYBFou3FakoLvwaJ00Wa3RPSAGfQQp5lPCH2EI2mV/uOFnyvE2ZyyVJ2j+F4AOGGMqT
	biQPP/6hQGStnUEj4lfNoyJojHHC8w0x7UuvHWC+MJtSn1ykQfyQWnC/wXhlP2aW23yT5OWmiv/
	rJvw5Uh/FuZlryVCtrx4NQO6IgxXA4fxb9W/CcGTJ1mV3GAcW17VZfmaSJMhtoR3JaxEu7tIG/T
	3aHd37mmcmQtVdT5YgX4dCz5hIP+BKMGbRoOZKnbAccG5hBYZeBhtWIoN1poasgSCvSfcrsgoCS
	CJViJi+2ZsnYg6ith8/QyayToyWAwIgG3l65UQASXxJ/EQuP7eU82vt8VDqkus6q6sGC4p0dx6K
	LwKX0mZshgi5x68nnK9sg6GnuruUtvXAuCJ/Rgv6yzrVAHCsy4MeK6uXen6Fab82LnO2eUAvRTA
	hRn2vLkLuhPrqFoT1vOLApkab44SBQS14n9p2nXuj7ylvM+PaS62M5t8gw/7tVUzCNRWz4oWOSP
	NBA9fWrUi9WCaEDUptqBnyDTZAhKSXOQvvKD8sn+bJr631pgF38IUdPHNsliEXTmFRGlv7Pym+U
	nj1oWCLhtP0JdLr3fj6eUkeOXdf6ctO2qmWdFQ==
X-Received: by 2002:a05:6122:4f9d:b0:5e1:c1c8:9ff9 with SMTP id 71dfb90a1353d-5e91f28cd89mr6035507e0c.2.1792004350298;
        Wed, 14 Oct 2026 11:59:10 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cc14668sm11985603e0c.16.2026.10.14.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 11:59:09 -0700 (PDT)
Date: Wed, 14 Oct 2026 14:59:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
Message-ID: <willemdebruijn.kernel.1725d296e3ac6@gmail.com>
In-Reply-To: <willemdebruijn.kernel.140f4eac91ab3@gmail.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
 <willemdebruijn.kernel.140f4eac91ab3@gmail.com>
Subject: Re: [PATCH net-next 0/9] net: skbuff: convert most BUG_ON()s to
 WARN_ON_ONCE() and an error
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Josef Bacik wrote:
> > I'm going through and reducing BUG_ON() usage in areas that have created
> > the most problems for us.  89 commits in the tree quote "kernel BUG at
> > net/core/skbuff.c", 31 of them since 2024, and some of those could be
> > triggered from inside a user namespace.
> > 
> > The first patch is a fix: skb_copy_and_csum_bits() leaves stale bytes
> > in a buffer headed for the wire when it hits unreadable frags.  The
> > BUG_ON() conversion of the same function needs the same handling, so
> > it's here rather than sent separately.
> > 
> > The rest of the series converts 17 of the 19 BUG_ON()s in skbuff.c.
> > Each one becomes
> > 
> > 	if (WARN_ON_ONCE(cond))
> > 		<error path>;
> 
> Good idea. I was thinking of doing exactly this sweep after addressing
> one case recently in commit ee1972def665 ("net: downgrade BUG_ON
> EIOCBQUEUED in sock_sendmsg_nosec")
> 
> Instead of WARN_ON_ONCE, which still triggers a panic on systems with
> panic_on_warn, DEBUG_NET_WARN_ON_ONCE?

Just to understand: do you plan to resubmit with this change?
