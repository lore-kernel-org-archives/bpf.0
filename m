Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC21378826
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777831032; cv=none; b=ZFzMl66jQE8iCks7FK1Bjn65G+UwvOLFjpmENbNEszeTopS7Ghc9LL3qxKx3fWQQXNCajImnCZntjdWN3i9f51nURLdiFCjnQ++zkWEGrZbWxndMQQ4gFBjLggmMDGF4QkBP4FbzJIw42khLdNzKKzEkq2lKtxmd4RvVjeDtvjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777831032; c=relaxed/simple;
	bh=1XE2vYB14dioBFRhAgV5y7WwaOpoCWCjDjwrjYCgAk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3yLJlHFuBPkVz715y09fjyPBQSGnomvVnnjxgR3YbCvBMQJ57Ws1vNopVjUf79MQyMkLLuQMkqnlfA8R35ZSaCnxO7LiS/r11BAgcIy1s3fD0mQdF3LQxfx9vOl/V+PpxyFxOBNwaHlKQAwdI5Lm2pd69SXYrUVpbjjDexRp+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K62Ur1a5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K62Ur1a5"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c70c112cb61so1924081a12.0
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 10:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777831030; x=1778435830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1I20Yc1jyO4cAtDXypF5oj/hHWjCxlXQ+fPgE0FtSo=;
        b=K62Ur1a5u+ohVZsD6jKsEzlU/BCzhH8Cyy3bmFcrISLrhobpzdPrLZfVcJ/z9j8n92
         rNg230PKN4dvUQD/CxL3AAwUDT7aKnJKxQEzW1O8i7hnli9kQjP02YbHv6L4IO0olbZ9
         tQmtXW57dS9+eA/MYBmZIcBPSw4FP4v1ykPJdTaMd65gNG4vZuG+V8lUOJsaHvO0vv2K
         k6ZWuRCBk+HLxwf/iWez5JCVXvq8x9P+/O67IvoRW11FmyMdGZXt/aRa3NTk+J/f8Zii
         cadIZMe7WNwLb91An75YQNb6MJHGFSS+9Wpgja5n+1ZQceDf3vKgp5wntgQlj/Z4sZzb
         6qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777831030; x=1778435830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1I20Yc1jyO4cAtDXypF5oj/hHWjCxlXQ+fPgE0FtSo=;
        b=oS6UUdXCgZDH5+N5nKJK+0JqJYOjqcVTDP1yBpjcxYZatSWSVM/W3q8ipEuxR3f5zJ
         KK5frZYQqY3HjItDTNrKS3XR/NE/ySFGv3lZUGIgZsyvMEjNFUHNB/48P49hpRDbqBVP
         v+sc6/5Usjji59LV9raM/BLw9YRNh70cbmRhTonZcuCt4S4GjL+96Wlqt9Ib8ktxlzLU
         rzsOpcDHrjx69BgrXQJffhZo9EizQjFiKa69a+OUjjmshHvazAMAIG6zjGJQL8FLQzfO
         WJ5jxKTGWRKp8sCVE533OmJ08cD3oyBN5ga5cwJeNqWL+Pg5pBa3ZfI+gPq+02QtIhSg
         bx9w==
X-Forwarded-Encrypted: i=1; AFNElJ/WofFDbU0IdoV6vxiz3AxTXsk5ReMuKUDdiJpF4o8oS67jruF/cS0d2BPvYvs2Km25n1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuPjb91UxZTTiBpEpee0A4vLLWFm4yG1/pb6f3AgFNu1rAB0wX
	ENXTpysY3lvCBTXtqtk4lmE2EzQg4wtSGkdfhIgVhfZz1Dv9CKMeAujw
X-Gm-Gg: AeBDieuMf3VGI519NI7QV4EIUXTHwBGCuQkanh456NvvfCy6WEZNYEcAsBow8MNr82w
	JBoo7ED6zwvnCqqm1/+jP7KvDITPgK9kjFQJtXD3+6YnP8HGz3DPAXhDDepp0BVzrk/vY/WfUBu
	fWHUXo7ibLFq7iOJzTkhnn73+Ln4zB2rGhlUjgZVR3RbTGmjOqv+ABw1MT4avvKXCAk2G77qQi/
	dNPmsHXShtkI35DFU7FvLWVdSRdz4yUBADU2oG6TT6rLT12GPARNsD9cg7Wl2rdrGetMOXRVi+9
	Gbc5ZKF66YHI7o4jzD9dB742QQnBZnx8WSC3okO8x8+GpL+75T6HUaPiaM/A+s8/flfikvmaG0n
	akx/V2qeiG/TK4RRPsSOtUtn3PiI7YqPJKi/OI46CQh4+KKg3YPPJD9DAAj2ii2cXcz6ycqo58j
	2/YPV4e+hq+hshgRnvOSgvQzy39mjq6aCf7C0sdMXTgco1kL9qAsPCj5bOQQOscEXz/H8LKEMLY
	BhB6/Gl
X-Received: by 2002:a05:6a20:7f96:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3a7f1ca3049mr6620214637.21.1777831030416;
        Sun, 03 May 2026 10:57:10 -0700 (PDT)
Received: from google.com (61-230-38-200.dynamic-ip.hinet.net. [61.230.38.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158bc863sm8450886b3a.26.2026.05.03.10.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 10:57:10 -0700 (PDT)
Date: Mon, 4 May 2026 01:57:05 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: geert@linux-m68k.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] m68k, bpf: Add initial BPF JIT compiler support
Message-ID: <afeMcXsismO_ft_d@google.com>
References: <20260429124046.3480827-1-visitorckw@gmail.com>
 <98dfc3ebe6bf519aec70bf629acae897903d8146.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98dfc3ebe6bf519aec70bf629acae897903d8146.camel@physik.fu-berlin.de>

On Wed, Apr 29, 2026 at 03:59:44PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Kuan-Wei,
> 
> On Wed, 2026-04-29 at 12:40 +0000, Kuan-Wei Chiu wrote:
> > Add a BPF JIT compiler for the m68k architecture.
> > 
> > The JIT generates m68k machine code targeting m68020+ processors. It
> > currently excludes 68000/68010 and coldfire processors, as it relies on
> > 32 bit branch displacements (b<cc>.l) to handle large bpf programs.
> 
> First of all, this is extremely cool! Thanks a lot for the work!

Thanks. :)

> 
> Secondly, since you seem to be well-versed in compiler-related stuff on
> m68k, may I ask you whether you would be interested in helping to fix a
> stopper bug in the LLVM M68k backend?
> 
> I have outlined the problem in [1], maybe you could help getting this fixed
> as this would fully enable LLVM on M68k which means we could finally use
> Rust on the architecture and maybe also build the Linux kernel on m68k
> with clang.
> 
I'm not very familiar with the llvm codebase, but I'll definitely take
a look at it and see how much I can help out. :)

Regards,
Kuan-Wei
