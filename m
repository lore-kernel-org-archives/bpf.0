Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13C26CE11
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785588962; cv=none; b=DdlqRc0pPVE/ALQrJcxWnBiRjWB/99z2kzzxNSWw7GWeAJMez1wEaZ479e03rUyry6HY8Jn9mZOuJem5o2AoPCECoSZ1saHn5h+zUT+WRjJDLDm7oO0yPO7xbCyRdAJhQswcvL9o/QLnZb/gh9CC+sIiVhq+nquFFFAttAOBdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785588962; c=relaxed/simple;
	bh=lCMhQDZ4j1i9eJ05uc/LHgMnsi7rTcH25lhjvEDnelI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YxWVDqVedMn4NfKs799rqtSpYmVtPGcs4e09dgYZJsLWgztr4ohOSIcd215QOgI22s/6GPVsQB/xb0d9Z3d/+8n4GHvaRFZ0L6Ft1VIPf4eRRZV+XgqOOFylMLLo6Z6FPXaWl12ZajKSb88ZtgrfVvCp0J+PZehh/Zf8rsLrS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net; spf=pass smtp.mailfrom=bobrowski.net; dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b=ZSBKHu4a; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b="ZSBKHu4a"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1690329a12.1
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 05:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1785588959; x=1786193759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lCMhQDZ4j1i9eJ05uc/LHgMnsi7rTcH25lhjvEDnelI=;
        b=ZSBKHu4aZ5AHVxAs0RERrGiVxgTYd4loH77Lc6g2M+ajZVgWJMqvNzieEw/HRT1soA
         JXfBY2HOGwkiWmbrSSi7XiHzWoH4yI94qYFV7jaCYohWIFdrJQcsoz8nD08dslLuTTFF
         nDq/sU0i3MzAJB51j63LF1yDiWs5sh4pr8fU2Atvq+IDoF5u/U1ihPhLDZ2BsoC9XTKO
         +F9uOu4lx4Eonarc4YI2QD/O8C6bs9vrtPYhNMrEhVIDdtGjC3zpOz+baRFbw853l+Al
         +mXNmpEAo1W/SWl9PL307BrVTQ+dpnV2xn84ucD/T0qTQx7k2lgDRgF1sgpnWFCszVfT
         lBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785588959; x=1786193759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lCMhQDZ4j1i9eJ05uc/LHgMnsi7rTcH25lhjvEDnelI=;
        b=Xg9NX//ZjRxvAqHxlzy1FC1ATxAASYucmPLmWmKt/+48dLXoiA1bssF3xEjH8k6G2L
         55cx3+m1sW1l5qVHQXzLLo54GhYFKQESAvE6X8ae84/EkgudDUNBrHqwwaT2PE0faU5k
         fwNXQvX01NRqHOq6Yo+iTrpuN9psAHXyML2OuYXofytKcn55aFwJ64HBeMIf+CALZIew
         onD9sUx9XsHvNawyHQCHJByyJ8EWEHohwZvsjB3qSEg7hdt6cabkQBL7KGFo7qYCG5pH
         pqI54Ij3t39oe7pHrmOAJ0PyrFpB39odLcvYa987yb4Zsl+oTy/fUiB2ajLYcVA0CRSm
         C64g==
X-Gm-Message-State: AOJu0Ywr071qVwMKZzsJoCrvq/ZJ96mrvSQZ294paEB9S8/3/ODfzZs+
	lRLAJks7qN9oEaBi+vb+CWUEtteA+1yPN56wr35ee+L9OoX93o9iiQB+w5mQU8zZxj02Nw4XKRW
	vcmHPYg==
X-Gm-Gg: AR+sD12YPB+ohILdCe8q93Dk+HQl7jzZMxb959KQYy/YbTUZ8C4uef0YBmKr28oR6Q8
	DgOj782Xz8DDU64mPfqyGVb+Vi7mlV/CRyK+Z76Wlvgalq1Df/9L9IVhV4uEsSb9Js/te+otqq6
	h5Vbh5fqlewIXHcf/ozHw+j0YnVUQ+BHW3Ie+YheetLYxhePUDr4dHx/Iy88yyHxU5wfyDwoaMu
	unrFHyZGoGpm49aoAVHBdXfggQ7ABSmoJ4WZ0lmJz5hQdDINUwHkjT1PCcpSiQ4as7/1iC91rcR
	TwwdhOBMBQdZiTJBAFfPo4Bxss8h7i9X34p4DuRti0AsXhZucWJf/GC2OyU9Sl/kkTzNUKeaf9G
	3hfk3zcBaypmm+RCzommGwwKcQfa1U4vN1ASdKac4ndIFqlnthOxpoG03xtKjBf7g1pbms8BGrZ
	5wkjLxR2sPLnACVtoZKM/LjKEiB15XJz8DQb+CFD40KkwQjaOMNE646POQ6RrR1FbqHCOkcowRX
	TXbbjKI7hbjRJTiQS/stt0vmPCPpxmp7plMxmO9sfE=
X-Received: by 2002:a05:6a20:728d:b0:3c0:b766:74f4 with SMTP id adf61e73a8af0-3c92a7545a7mr3390226637.31.1785588959405;
        Sat, 01 Aug 2026 05:55:59 -0700 (PDT)
Received: from lima-development (202.128.115.4.nsw.leaptel.network. [202.128.115.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm29978339eec.28.2026.08.01.05.55.57
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 05:55:59 -0700 (PDT)
Date: Sat, 1 Aug 2026 22:55:55 +1000
From: Matt Bobrowski <matt@bobrowski.net>
To: bpf@vger.kernel.org
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
Message-ID: <am3rqHmP9-64T7k7@lima-development>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhR8RpkP-N4J0wGbv167NctjFTOg5Z+n4_M0pjp3Fbnamw@mail.gmail.com>

Yes, I've recently left Google. Unfortunatley I lost access to my
mattbobrowski@google.com mail address before having a chance to update
the relevant MAINTAINERS entry with my new mail address. Anyway, I've
literally just sent a patch to the mailing list to address this.
