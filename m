Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492F93EFD04
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898131; cv=none; b=M4ysoUrYZqpoj+J8fzcrGEiSkKsUZkzOl4wmO9n1zzAyiqnvNNOlSwLDJDfRWUCAv5e3vhVZhIF/pmBAnuJMQ+OecYjqDFbJs74kQoBWuYzUPru1jwQmxXj+0SELILcrJebJcP63wq21jO5loprWDO9I0MwBhD8jAuXjxSMrETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898131; c=relaxed/simple;
	bh=sr0k1d1NhOQsip+Xzw0s2NcwtVXRJi62aNuS+q9S+Lo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcZmwdYi+kOunRN7aeSfRdlnNTCN68xvDlrDpaHJIAYDc/t7rbq9vVghrdVNSm/MDP68HzgQB/x//Hj8uCNy3u0uu4Nm2x+o5OINghG6WVEdQrE1B5x1ne/9ekN3VX4DHjqUbBsj944wjZrQE7E3IpAdxwkhXmOBlRHwL3abwF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ7r5S5U; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ7r5S5U"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso2092455e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782898129; x=1783502929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WRbki0GQJaNcrLB+xSEtBVJukwNO7EFac3s8dHYCr9w=;
        b=CZ7r5S5UNRmpk5PlKtQBEKFvqhqdkp8khWB8PafjLFtsozmXve0SVY+rMB16/w31sy
         0nXYbMEE+oX7dpjce5d31oIEX+wX46u33UYjsbWJoPpMoIYMq+VJ5RotQd38zYQSqkzs
         R+aLMS0TYMFiyZZb9eNg3rVbJ6vECJ9QDDeXqF5G9pBbyu78fJ2d7Lv30FKapZPaIU9k
         nWV0ngsXCOieVZFi37+HzOY12yfqJimsrM7mBsa/TGW1pYUWkjf3SIb8IoO8QOe/S0Pj
         tNWd/o9UaTfTr81aXUsE+HwpRczSCeHN5A19TfqJFQPOu4ssiATUOpl9C+wZH7Yf0/iR
         H+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782898129; x=1783502929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRbki0GQJaNcrLB+xSEtBVJukwNO7EFac3s8dHYCr9w=;
        b=g81yfstIVNDbO7bvaMiHzTeVduAkvuLfNlMFFhD0XIJaEho1auR0HeyvRJ/OLsJZtS
         7n+F2OF67joZ5s5tVAB5pd2MkwEOB0f655zdJBpeycAxdpcehYLhKHFsbyc2rpLxdOx7
         rJpRFOQFhBsNeZd2zXbVd1+mq4nRPFmBMaTtnkTAe9h/4CeDD5MNF1evtWmlmg80exNm
         cqZx8NWlH06CvU2eAlC+LVjS8dA/XoA4b9kH9Ll0y3jvFur5aN6sUc5C459lh2QP2hH8
         jJnDDflhv5zU5l5uNPT61RTIjyFtwYk/eiS2KSCjQ6Dcz/Ful2NN2JA8ubLJIE4CpS6c
         5R3g==
X-Forwarded-Encrypted: i=1; AFNElJ+amJoKHqN+95yvR6etv07dIWXXbHK4rpKyr0rPPQhjRsQwkeqOmAhNirThnztOZPQ63Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJcA25914rHD/JmcJiUQNRGnsrhFO6rVPogB4vpjClb3tO8DA
	Q0qaK2ZxZ6q0fXL7KNr9ooP46eYNQx5nhOGR43C7QySdB5JC9fdXlPFW
X-Gm-Gg: AfdE7cn+SF20nBnqWHgASBnb3/LcoFBIuf6Ak3rqK29MM3WRsgOcbvp2Hb/a1QfXBCB
	KXgDYO8MZlxmwxVuTWNUBgcVFJuXFigKAMlq3CmRtyvY6wRM4JXzh9bB3h1/9urtp5TbXMKHGRp
	NYBd/HRScucPfz6as59I/mb6d2HQtyRKRBqky2G2h94lMgbXZyY6u0ESlSfq0jvWOp2Oai6IQwE
	uOWt0ARHn38/zcqWJFf/+TMoaqxtYR8X7CSifglBI3E8BxEDsE18/bSkP7rZKuqxozY2Zhl932O
	yeKEz0JsasRiHV2ndchctuubpESLx0rQzf3uNUsrr5pTGC59CPes8RHtmDJd3WPjlDNGgGGNUpQ
	6MgZf8LphpESCk8B4IhZcq+1nlqc3mXzYJteFULXqyFEjchsvKQF2ol+xkTRualWvNN2yLzY7Iy
	R2eSDF0vZ+iwEZIUPOTKwGJ9ZT
X-Received: by 2002:a05:600c:8117:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-493c2b99aafmr11244445e9.27.1782898128375;
        Wed, 01 Jul 2026 02:28:48 -0700 (PDT)
Received: from krava (37-188-177-177.red.o2.cz. [37.188.177.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm58292775e9.9.2026.07.01.02.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:28:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Jul 2026 11:28:43 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 02/13] uprobes/x86: Remove struct uprobe_trampoline
 object
Message-ID: <akTdy5EX9f5D2Tql@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-3-jolsa@kernel.org>
 <ajvrZ_mMXnKrWf7h@redhat.com>
 <aj0veiIdtp3YcKyK@krava>
 <aj0xonQHcEQgIi77@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj0xonQHcEQgIi77@redhat.com>

On Thu, Jun 25, 2026 at 03:48:18PM +0200, Oleg Nesterov wrote:
> On 06/25, Jiri Olsa wrote:
> >
> > On Wed, Jun 24, 2026 at 04:36:23PM +0200, Oleg Nesterov wrote:
> > >
> > > Perhaps we can later optimize this code a bit? I mean something like
> > >
> > > 	start_reachable = ...;
> > > 	end_reachable = ...;
> > >
> > > 	VMA_ITERATOR(vmi, mm, start_reachable);
> > >
> > > 	for_each_vma(vmi, vma) {
> > > 		if (!vma_is_special_mapping(...))
> > > 			continue;
> > > 		if (vma->vm_start > end_reachable)
> > > 			break;
> > > 		return vma;
> > > 	}
> >
> > looks good, will try to use that
> 
> See my next email, we can use for_each_vma_range().
> 
> But let me repeat, we can add this mimor optimization later, I don't want
> to delay this series.
> 
> > > >  static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > > >  				  unsigned long vaddr)
> > > >  {
> > > > -	struct uprobe_trampoline *tramp;
> > > > -	struct vm_area_struct *vma;
> > > > -	bool new = false;
> > > > -	int err = 0;
> > > > +	struct pt_regs *regs = task_pt_regs(current);
> > > > +	struct vm_area_struct *vma, *tramp;
> > > >
> > > > +	if (!user_64bit_mode(regs))
> > > > +		return -EINVAL;
> > > >  	vma = find_vma(mm, vaddr);
> > > >  	if (!vma)
> > > >  		return -EINVAL;
> > >
> > > I guess find_vma() can't fail, the caller arch_uprobe_optimize() has called
> > > copy_from_vaddr() under mmap_write_lock()... Nevermind.
> >
> > hum, how's that.. I'll check, but where's the magic? :)
> 
> arch_uprobe_optimize() -> copy_from_vaddr() reads this mm at the same vaddr,
> this means that vma at this vaddr must exist. Unless I am totally confused ;)
> But even if I am right please ignore. I just tried to understand if find_vma()
> can fail or not here.

ok, will leave these 2 changes for later

jirka
