Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356D84C601
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048469; cv=none; b=r8wDKeYgjhm33JU3e5cXqdmAsuND/TvuVEgWhlG8bsY0+veQ3+pts8ADUFo6zoKwSuamSDxarQ/zzB5vT14saAs25j+QUubSlk54OM0Jf8LwTS9JVB8I5rwiityCxVZUlrJWqb/opo/ag7Gl14jiLq2xXG3/TVGN2QTBu57IaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048469; c=relaxed/simple;
	bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbv1XoM30zf4QDRUxsMEcTiKYy4G4klPM7SttqQyYAAYLHkEHGtU2t1W/D2wxMCzN1qW514LkIm2rnhVomSYlVgwHCMAonIjEN2OP0vCLgPP4vs2gTHCwKRWrQK15CzbF6UcXFHhOfpAcd7BqMbV87P5Y50oywlq+c049ZZWyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cDjjv68p; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cDjjv68p"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a2601f0562so230739a91.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712048467; x=1712653267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=cDjjv68pp8Lpkc4pFaT/whgl3Fs+P6d5V2OBtHJkViOaKCAn51bVEvF0g1r+A1/7/m
         d7g5Z2lPLhOmNKyUFalTKtMbg4oBMLRMUUHm0thDbsrcrNmkvAWoBBeigo7BK2QMifAk
         AUaOIWTRxbQKcTx6BkcaAgf8UCEK3weuTAWj1dlnlvFqpxZlVjn5IACWJ3rkpwh16xld
         rOqP5bgDbA98uRMPGmbrhHnab+yl40xcsCuocGxFl8xlR8svxC6ZeTIVLo6AZCxR+jL0
         867QqlF6Y9/0s6szyppRANS9oR0vC9BfjcazjRCOk175vzLvTtW1jfxinE6dDgU9CU2z
         +Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048467; x=1712653267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=vK0H2g+qt9a9UXH3T/yEPim4210LpuavN0mLYDJE8VsxFVBhrk29pZQ04LodqRiWaC
         NDtsOPmJFBsfeQkRDVbyOSL27yRxe7gggx/QTS+3wmFLIwRfBqGXYtW/7+HIrHDOjPvJ
         NW+svITLegcWI05ZlC9Dk6Wof6vJ0TeUuY/bwk0YrfGxzZ/7h1oSN1WydYP0uj2M0oxP
         gW+2pNGXHIH6C/BXi71s+9o8/2Y9Iay5KFkXE0HCgfd+hNfK3+cr4Mlu3anqK/g5w1MJ
         JJqXsniJUmtBOTLQYeZbJIdotEoadWkk/e9VWIhn4ZFfQco+eqeIUPVmmkzC1ZzACPuc
         Yr4g==
X-Forwarded-Encrypted: i=1; AJvYcCVIVF8W2nx8/L2vFOOkr4eqbOevLJy/0BM+U7qw5Wcolg4/fd3tLnkFexAD3DldJUlqG4Wt8i/DCNc3q+Q0l78jqW8i
X-Gm-Message-State: AOJu0YykW09yg49bFg5Tr4kMJQCUke9oWtzYgLu4D37rlGUF5iqvDyEt
	vKQWQMUFbzUWhTUhwIV1iYRbuxLmZAQySTD224lAY8+Gg4sfjBzlPGTDRCy7P8xM/5vW9dqObsf
	zl+MicgfuYKotasU7PLQ1aKgF2he+4dRGc+gi2ONfVjt089BMPxo=
X-Google-Smtp-Source: AGHT+IEsH5g/yQ7549h0WSFp/og1oUajTS1sjB7Vh97/Wgv/VHLuGRQTOVZXjAhxRMgyq22jN/7H5kj6HX5rDOi6i4o=
X-Received: by 2002:a17:90a:b111:b0:2a2:47a2:9bba with SMTP id
 z17-20020a17090ab11100b002a247a29bbamr2890042pjq.3.1712048467530; Tue, 02 Apr
 2024 02:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000090fe770614a1ab17@google.com>
In-Reply-To: <00000000000090fe770614a1ab17@google.com>
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 2 Apr 2024 11:00:56 +0200
Message-ID: <CAGn+7TXh4gzeQ3EktnYQ=TXO_LutRU8iSQ=VbBpPpVX=Cr_UEA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
To: syzbot <syzbot+d4066896495db380182e@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
