Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CBA4B0CBB
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552245; cv=none; b=N+L3jAgc+b0GJVqkuF8X9f4gplHwDkw9FHQtrxNBLa4Ce8Ra5C/+ysnFYtLO60DhlDuPonEtApJx8IkgCS6r2skCurmKX5PWCEiq/ObjlrAfmo5nKNzuG9vXfPLaqjzVsEG7sWlly+fdbu8GITfMc+hq4AVhLMsEtDV/XnJMaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552245; c=relaxed/simple;
	bh=zVftL0e6KTn1Fup/RmgkkUqXURXldH56P13A6WLi8KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0Kkn2jGP+Infb34cFt6cUC2d8urDe46xbCvzkrjLaTG1KPfl08KFE4IrD52DU7uycpw4TeRkzQvoiczF8mVA19PVO/FWLo6OdSRlrAjAp9yL8AUfiUN2P7rMarXu17nsUC6gCoo+WjTnZuwQmGE+ztEbQIEqlLGCQHgdeTx6Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dzby88uf; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dzby88uf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso3137585e9.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789552219; x=1790157019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
        b=Dzby88ufsV19pEuHSQnO0Z3r75FgiJ44qF/jXgKTm3w+wAYVSGDUH6LyexeTQiqa/g
         mb7EWvB3UuhKI7YAj+i2TOZr9/Z0Jn4HnQ3SO6kUkIrvAwSnRTzKzvfGb0So06LetuEf
         Ts3VEs9CM5zHiWBu1V4JZ71jpXN6ZkETnLDwqKE7PV3aA5kY0+ABvWOim6YHWnbq5cCK
         nHzOneSJDYvvXY/C7BkTDDo/hN/r3+9IBjrwRhsKYcoz9kdWM+uOTg6K8qjcDaH6D7EX
         KA0rYEGGzwyipB5cM3imDGmhTpbUuWgcSiyW3ZIBr1TR7/Q7dN5mD7jr++kuJyreI5UR
         skeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552219; x=1790157019;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
        b=zJ6lr/JWuitgKWJLnd+AY8W6jhrz+8EnDknTpx8eFzXP70VnDgqTz/R2lWfB7Pcuw7
         HebwFsiU4YmqCrLG3Xa01Wd2QGbU3zxsh8mp0Xr23gS0OqHRMGMMN77jS+GBdBQiDiUQ
         y7JjF2H9LcN/Z7ndFvWExT866T8cTqottLqk40DFwLbvaYVCWK500OYA64FFp3bjclwC
         S0+pWORFNuRQxlJn+eb+vVNx6C0QcdRsN2oLlOx9rEpkzg7CdEtyCW6C8CpNih0AkXT/
         NCXIOdALeYMrorbKLj15Q4eXVmdS5tWnWRGwKku/G3Gmf4Y8l8MEyMfonH2wkIJo4E6t
         HSkQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6+py1UNwoDTb1wm0KmvWwWgi9nIe0ccbwer9CbkoR1XdFx1uIm1+4bm6LDuX4oAQS/2g=@vger.kernel.org
X-Gm-Message-State: AFuF++lq2a9GGmYorOEJQKzKLDOKIuyXItifK1Fnk4FitJevIC4UGaGP
	09oOMDFPHhRzdaIbGP2D5QLlKNt8xbJnrbKe89cdqAdux6F/TMZvQfT/
X-Gm-Gg: AYBFou0zXuzfHl1sU1DkbyBrCP2XjXN2gjCznFN32EZOB9hJ0WN/+MIZNNygySDDvXS
	Y3XvBqk4pMcyRAG5jOvRIDaEXEHZ1YeQaG9Tvpp0JJjJCuVNFi2e4VDQcqP4GsR5UWpf0A/urBS
	ZUT4jV/a0+qWea8AY7cSsisZDzwVWVO0VOF/JGs/COaCtTSh55qBYrvuFTAgD6IHqCVbp0rtwiL
	KGODX3+lhczWB8J22J/5DeWncEf3jrjkQ2lQIIfGV4SFA+rJ+sc1KSXD8Y4oBnYszLef/J6YAVk
	0iVd/iAiX/oRe1gzDRxbmRcR1eeIQnMS7zkFOlf3fZ8ex9g8+PJnnNxYnZ+BBBmbFaJh/H9sMmr
	EipEnXmH9n3Vh0g65evmfecGFvkVpbKAWy/7VLprs5jZ3N2nxTcE4BpHt/7Nr2hdY8RSU1yAbMn
	TGPQK43o3VVbKdwi7uOnnTX2faUD6bJ09jkd1xdEBtE7hsaVC6iStg8pA/QoAzmLC2EvlqaZD5K
	FE9T8tUJvyl2GxdIQ4UcenyOWrs/Qh+rm4LCopRPzB1nUo=
X-Received: by 2002:a05:600c:4ec6:b0:49c:fea3:8633 with SMTP id 5b1f17b1804b1-49eb732aec0mr19444455e9.24.1789552219000;
        Wed, 16 Sep 2026 02:50:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83b02245sm84055225e9.10.2026.09.16.02.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:50:18 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:50:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, Jens Axboe
 <axboe@kernel.dk>, io-uring@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
Message-ID: <20260916105017.13ea5e36@pumpkin>
In-Reply-To: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
	<CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
	<CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 12:08:57 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
> >
> > Is this mainly about stuff like "we installed a file descriptor and
> > then the following put_user() failed"? Because if so, I think a nicer
> > fix would be to have a policy of "if userspace provides unwritable
> > memory to a syscall, just keep going and pretend the access worked",
> > and maybe have a sysctl that kills the process when this happens to
> > emphasize that userspace should not be doing this.  
> 
> We've done that before, where we just ignore put_user() errors and the
> user gets whatever the user gets.
> 
> It is maybe not optimal, but it's fine. You can find quite a lot of
> unchecked put_user() calls with a pattern like
> 
>         git grep '^[[:space:]]*put_user(.*);'
> 
> and some of them are in core code - see the two in kernel/fork.c, for example.
> 
> One of them says "if userspace has not set up a proper pointer then
> tough luck". The other one doesn't even bother with a comment.

I think the code should try to return EFAULT (IIRC that is too hard
in one of the exec cases).
Otherwise very unexpected things might happen if the memory is just
readonly.
If you ignore the error and the pointer is invalid the application will
get a SIGSEGV and (usually) die.
But winding back kernel data because a user copy failed is likely to
be problematic/difficult and at best have error path code that isn't
really tested.

As well as writing fd numbers to userspace, some sockopt code tries to
wind back if the write to optlen fails (which has been read earlier).

I've forgotten which Unix converted EFAULT to SIGSEGV in the system
call exit code - I'm sure one of the ones I've used did.

David

> 
> The scheduler has two cases too, although one of them is admittedly
> for another error case.
> 
> So yes, saying "if you pass bogus arguments, you get what you get" is
> a valid model. It's perhaps not the *preferred* model, but it's not
> wrong.
> 
> It *would* be wrong to take code that already has error handling and
> remove the error handling, though.
> 
>                   Linus
> 

