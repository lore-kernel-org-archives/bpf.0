Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9625BA21
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712292065; cv=none; b=F6+gNqoWmtC+8cWS5of9gsOvydK0zJLM5GAa7LUh6AOj9qRKYdseDtQvAD490ffncbVmKZyL0ToxGxlG2qLFcygay/SwAOCPfqmWJIZEFXRJR/BeCpnSStXY6cZ0xuRIPVMxYSaj/MEPEJKJogKb2ZkAt2BOePkrjz/t9jts1tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712292065; c=relaxed/simple;
	bh=uGQcxPWDBZc12OT+0uph4ce1nHL4oPCjCXJyc8XlB44=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KKqf4jDzRvVwn9lXK7L1zUEx+MLYg8je6xJ3KX75HLL4su/Vt5AlRPD4ZGLMIXucmSEvw5LYiLpkK+Ce3Tp4VJPyJ/FAbmKr5NGXuQc7x7IVbBoURDRKl3DSk4PtlwvmsTYUBGV7OnaF9i/RjjIRbkuV/glaV2MWiKALYcyV+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRTXiotv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRTXiotv"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0411c0a52so16451305ad.0
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 21:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712292063; x=1712896863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vmz07lHRN07F1L0TcWGl0tUlHVu5aMo7/6D+QPfaRwY=;
        b=YRTXiotvgsUAMhf5NHu1F5OMV/HxaRHaRrHg2AjVQcDpRCQekVMNiyqXSjg6WYcWDw
         eQeZ+ky+U/nYI4hMPRcP+1KVTqi1+R62NaxCxbXP6+0w15Jqs+xNh1XOOzEHEutj0e4K
         /naoWMAYTscsHiFZc3s+Ohpq97RGCZDvtcuIsxcNca7qv3RuIvJbVpCHO+RuczVoszeM
         Kfkl/VEClJHUB0Gnjxhx601jaXAQwGOBMcmTBIWQxTQSrfPjkOqUaziKSjukgBsiKxpq
         Yx/zW9PAR8NqGNsbg6soiYbD+nlZ8koInjbIaAeBz8KGHDG94V9b9gxwoU83wEsC+4zo
         YVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712292063; x=1712896863;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vmz07lHRN07F1L0TcWGl0tUlHVu5aMo7/6D+QPfaRwY=;
        b=j+fKcx6V7XqCaQG9A6ly3mZBPe717ylyJ6aRtoQ+tnzkvQf6IQgj2N3/9uJdhorWBC
         c5XeUjf7e8RTHT99xF/QKb3Fa2FPJMSm1XMtl8dH5ISG7584L0LSpN0lFgtbkDlCraim
         rQE9Bb1I00pRHms1uKgjxtV5gXDEZohP9NkRUcciYkXtIiKNympAg/eATXQxYrI9mS16
         +6BseduQPEp6ObmhwO8ao+BXvaq80g7Ysme4MLxe4iW/fwQ0oSPdRiuYOa+mI78/rsls
         zZwUkwJK1atsTJK9oBFArF3dZjkWhf7s7WfW3Hl/cfd0mGJc5MA3y6L6XiDBL3laVZ8y
         VvLQ==
X-Gm-Message-State: AOJu0YxSRHzu+By78/+lUfr7a7iDAHjzLm7vfyLZBoae9v09hN+TDYn4
	CLmQ4cd9Sk0E1EZEoVnqJJQDlaXPq3nzMMrnFJiaUQgXFZ0aVRup
X-Google-Smtp-Source: AGHT+IFbJPnhYXOLmf6f6BB5/Lf5YT/FqXpw0QUxxIGkN8Kbwg4Iq1qfGSlcz9yxXFcqJDULvRk9mg==
X-Received: by 2002:a17:903:3004:b0:1e0:e85b:b9ca with SMTP id o4-20020a170903300400b001e0e85bb9camr293629pla.21.1712292062755;
        Thu, 04 Apr 2024 21:41:02 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b001e2b4f513e1sm533508plk.106.2024.04.04.21.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 21:41:02 -0700 (PDT)
Date: Thu, 04 Apr 2024 21:41:01 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 kernel-team@fb.com, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Message-ID: <660f80dd964ec_50b87208d1@john.notmuch>
In-Reply-To: <d3c6024d-f57a-4e41-ba1e-07ca6d5fcd79@linux.dev>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022158.656285-1-yonghong.song@linux.dev>
 <CAEf4BzbkcKFVEWaHSavbRi9+9VQMbqCgP36p9fzk6Hai2v2izA@mail.gmail.com>
 <27046774-e3d6-40c2-b3e3-ae6e64ecd33b@linux.dev>
 <CAEf4BzaYh6q_0TUUARd8m0eK+5RBxWQJ8=-n84vdayPPh4Z61g@mail.gmail.com>
 <660d964a1444b_1cf6b20885@john.notmuch>
 <e49ccf43-ae90-4df1-bc10-5ee180ec47ec@linux.dev>
 <660dfe2f46769_24afa20845@john.notmuch>
 <d3c6024d-f57a-4e41-ba1e-07ca6d5fcd79@linux.dev>
Subject: Re: run bpf prog w/o sockmap [was: bpf: Add bpf_link support for
 sk_msg and sk_skb progs]
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yonghong Song wrote:
> 
> On 4/3/24 6:11 PM, John Fastabend wrote:
> > Martin KaFai Lau wrote:
> >> On 4/3/24 10:47 AM, John Fastabend wrote:
> >>> on my todo list, I want
> >>> to just remove the map notion and bind progs to socks directly.
> >> Run the bpf prog without the sockmap? +1, it would be nice.
> > Part of my motivation for doing this is almost all the bugs syzbot and
> > others find are related to removing sockets from the map. We never
> > do this in any of our code. Once a socket is in the map (added at
> > accept time) it stays there until TCP stack closes it.
> >
> > Also we have to make up some size for the map that somehow looks like
> > max number of concurrent sessions for the application. For many
> > server applicatoins (nginx, httpd, ...) we know this, but is a bit
> > artifically derived.
> >
> >>> but other than quick hacks I've never built such a thing nor ran it
> >>> in production.
> >> How do you see the interface will look like (e.g. attaching the bpf prog to a sk) ?
> > I would propse doing it directly with a helper/kfunc from the sockops
> > programs.
> >
> >    attach_sk_msg_prog(sk, sk_msg_prog)
> >    attach_sk_skb_prog(sk, sk_skb_prog)
> >
> >> It will be nice if the whole function (e.g. sk->sk_data_ready or may be some of
> >> the sk->sk_prot) can be implemented completely in bpf. I don't have a concrete
> >> use case for now but I think it will be powerful.
> > Perhaps a data_ready prog could also replace the ops?
> >
> >    attach_sk_data_ready(sk, sk_msg_data_ready)
> >
> > The attach_sk_data_ready could use pretty much the logic we have for
> > creating psocks but only replace the sk_data_ready callback.
> 
> sounds a good idea. Do we need to support detach function or atomic
> update function as well? Can each sk has multiple sk_msg_prog programs?

I've not found any use for multiple programs, detach functions, or updating
the psock once its created to be honest. Also why syzbot finds all the bugs
in this space because we unfortunately don't stress this area much. In the
original design I had fresh in my head building hardware load balancers and the
XDP redirect bits so a map seemed natural. Also we didn't have a lot of the
machinery we have now so went with the map. As I noted above the L7 LB
hasn't really got much traction on my side at least not yet.

In reality we've been using sk_msg and sk_skb progs attaching 1:1
with protocols and observing, auditing, adding/removing fields from
data streams.

I would probably suggest for first implementation of a sk msg attach without
maps I would just make it one prog no need for multiple programs and even
skip a detach function. Maybe there is some use for multiple programs but
we just have a single agent so it hasn't come up yet. Maybe similar to cgroups
though because we only have single prog in those at the moment.

Thanks.
