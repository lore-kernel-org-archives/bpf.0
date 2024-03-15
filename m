Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E44CB37
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527408; cv=none; b=Pz6FpCGUGtv/XHgZahzxXs3bpCE+85uRSFabZ+rmNHyYRDkSkufj7hH3uHPYTi+E9TrvULrxCdp4KDfe+ldHg6iEdKZlsEQsaxMZ1RdZzWDghqPj6T1JLKFSm41TmuxPkOda0BbQ1htRg/bw7ueogzxWFNnoOqGEtXBmT2MU0qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527408; c=relaxed/simple;
	bh=2CY3iY7WFMaadqVPoCDCxcWGOVu+MgkPKPo9nbRdhSc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q/SuuNhhscD0mIFaesVy9qhJ4+Rd2hIf9jFkGPSlW4yCH36XUFt2vs8JEvjJoctBzE/qUOYc93s+X+u8Mwl+X2wGUxhf4+Ya7P9NyYVXzkA5kqfstPxbS2xkaeZ4zFpdHjRSrk3GWVeH5ZGXitun61JZZ0KV/QiAB7+Da1xdJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gLwhfWyJ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLwhfWyJ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cfc2041cdfso1844448a12.2
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710527406; x=1711132206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5G1Y3qw0gKwLwzXpV+7qDHQyHhpinIiFbTLqmHrd/Y=;
        b=gLwhfWyJzHKvCGp2VjR0Yoj4oPjmLCxZJNDZeRoJETD0mG5Y2+7HBHstUXvC4hEbp9
         PFWE30QLyMsvguMfGHqIlYed7wuW3BGQfpWBd4PjliNe8JxLsJGWw0279lU5LUjM5uoE
         QmxsVvzDehC9Q6xiz24JQFl8Q1xcJLv5/n37iFmCxISKPSgqlEa3vDH/Fo09YIkfrA+v
         ZEPOnB2lzO4e3KoukO5PUvJwZsBKTDNRd9qfplbnW60u6s1CIkQpjg/+ynpWm/36i3Bc
         nBsaRDKznO0CCcpoGgTcmTzOVI94AinhmiQ4vzvRKKt8K48gV1uLG3Wb2rOct/NOzb0E
         NLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710527406; x=1711132206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5G1Y3qw0gKwLwzXpV+7qDHQyHhpinIiFbTLqmHrd/Y=;
        b=mOTeePkrR2vPRfNdmyD76FKTQ0eRkz+jQpllsKRIg0zREKXIo3OSqdmby0xR8Sb/ox
         vd9EHy693YkRf35QOfsQFZPgNpPUsD5DG89TF4AFVPGkUvvG7hHl2eb9Ps+Oqmpa/nMq
         ybvo0pcoiQKHVrCLcF5baPhofVWvbjZI241EYvfLn/lS2vUz1wGnoxd26qT0ieQCk9Pb
         M7FNBLsIZzeKc7bprjD9OMv8UHvdzcNsIl6QESqR6dNgHNvsTDSguaWrYE1OtneSTIXk
         9gOb6CEUt0LWd6WnXqA3vwVcsyoIviG3j1BtmXCHE32S6IKUJrQ6cP7Mr0vjUeeOiAIB
         M3mA==
X-Gm-Message-State: AOJu0YyqoCO2NMGws0Bf7OdWUyPjC0YmHy2qaaz3fRDmwiU86Wsd4LWq
	0lu+fCnCBbio9AMbGT3iGfQf7M0QlmIyQB/nAkKuii7Z2mEfxZcBqiEqmz8kpVtUhw==
X-Google-Smtp-Source: AGHT+IFcuPBryZ1ntjaFPATHblXCxMxO6pIJC/bUyAXszX/U+Vjv2d7HO0URfMljx2hOJgTA+AHCIXU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a65:6544:0:b0:5d8:cd91:44e4 with SMTP id
 a4-20020a656544000000b005d8cd9144e4mr8052pgw.12.1710527405220; Fri, 15 Mar
 2024 11:30:05 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:30:03 -0700
In-Reply-To: <dc02f7f4-6996-4a1e-a45d-09784c164939@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <12a4fa23-fd37-4cc9-9744-09ae056fc872@gmail.com>
 <ZfSF6aNQ419Dx9yS@google.com> <dc02f7f4-6996-4a1e-a45d-09784c164939@gmail.com>
Message-ID: <ZfSTq3tBoHoiUNMv@google.com>
Subject: Re: PF_PACKET RPS like using bpf
From: Stanislav Fomichev <sdf@google.com>
To: Alexandre Cassen <acassen@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 03/15, Alexandre Cassen wrote:
> 
> 
> On 15/03/2024 18:31, Stanislav Fomichev wrote:
> > On 03/14, Alexandre Cassen wrote:
> > > Hello,
> > > 
> > > While implementing a large scale L2 processing soft, there is a need for
> > > high perf ingress handling.
> > > 
> > > In short: using BPF socket_filter prog with a hash func over ethernet
> > > address to distribute load across multiple PF_PACKET sockets: mainly
> > > filtering out non related hkey packets. It simplify userland app by using
> > > multiple PF_PACKET sockets in dedicated pthread.
> > > 
> > > Longer discussion + quick source code illustration here:
> > > 
> > > https://github.com/acassen/bpf-pfpacket-rps
> > > 
> > > 
> > > My question would be related to sockmap. I tried to figure out how to
> > > perform the same policing design using sockmap. And cant find my way around
> > > it :/ If bpf verdict prog can get socket fd from __sk_buff then it could
> > > drives the same hash/policing decision.
> > > 
> > > Is it possible to get socket fd from __sk_buff from sockmap verdict prog ?
> > 
> > Don't have an answer about sockmap, but I'd suggest you look at AF_XDP
> > if you want the best perf out there with raw frames.
> > IIRC, it just recently got a mode where you can redirect into multiple
> > sockets (== consumer threads):
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=2863d665ea41
> 
> thanks for replying, __sk_buff bpf mirror doesnt export struct sock as
> present into kernel skbuff, so no options but extending.
> AF_XDP is an option. Will extend test code with it later on.

We do export bpf_sock in __sk_buff:

	__bpf_md_ptr(struct bpf_sock *, sk);

But it has a very minimal set of 'struct sock' fields exported.
