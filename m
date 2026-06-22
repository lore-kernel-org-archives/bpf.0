Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5634C130
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159842; cv=none; b=Im/1RPdAdurGb53tc9swQn8RFPuRH0YLPtT5o6QWppGL/HSHGpIdHgBTGEvDNcaQlVt2MOpUqqbXJNnY6OV+FSqJdh0T5ivTpw4UhqmU40BHJ935MFuyyhY1Z7bdIersaql9sAP2Z7lq+wWa3AlY4qsNKcjPExFi8nzPzXwlrGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159842; c=relaxed/simple;
	bh=H5cpwCepsxhixKLNTuJkp0Y44Iv6O2UiPDuOJDmxpRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=URWy5TmTfLpsBvO94v1/vXg9VasVjP6aZsptls6uhdwbn8tht1auwprLxc1VDNK/j10oL0Aer1rtjqJhnJUoiUnSUipvGaCokNz3PEsUVuHr3lfWZRPKsg6hy8AYR6fez/72/+qeomc08bVnMn5PcM51yfFhCtv0bI0fygs4bBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QNFstsFm; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QNFstsFm"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-696bf0e7c9cso657998a12.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782159839; x=1782764639; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/IySwbjdjXdYnWQzeR8fepg9364jfucwrDIdGzLDupY=;
        b=QNFstsFmVAHKlcPRfWohAHiPOQvVIdo2TmyS8FBnmQe0qE13iQXfKI4PbXJJt/E628
         IsJpjN2cWcYnTiwwhEBoRRztKYAOW1gih8KeVZ/PDycG5RMNcMUc5+wE5qOHlY1BuILo
         hTRXKXHgk1/l7wl7WzkB8ySa+4uRTVXc7umBaiRwzJUBywC0Jn67py0C+YRzfKI0G22n
         avngiBFBWBRQ8Ri+RPVjnOaGuBpYXt+Jg0YXwGOUZ3soD+7L7NuT+eRaU1IpTJiG1hAQ
         LhN6JJ9MAXo3RSTsUTgXw6DTSFvKOqem4GFwex1tnrg3p7fp4mL/1TB7/C6VcohbNr89
         t6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159839; x=1782764639;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/IySwbjdjXdYnWQzeR8fepg9364jfucwrDIdGzLDupY=;
        b=BPQ8rg5HNPNliIA4Ov0EZrfbXr3YJt8UUTaiHPPfPmTGoO1Us66DtVBeoc4nTcY2IZ
         BFSOAwatJzvmAV98Y5XIpPn8ES7vyfHbmSBXcx1KlALZeQ6NwgOIe7+OF03NkMx02Y9U
         5H5lABaq2gEYYQXK7RnoCvtRkPK8KvgSAgHoSX8is8a5ik/Vais6VxLaKPf43KbC0uig
         MJXemtBA9PEbRU+Wfhdt7CoseUDwqxjPDQdZdOHIhASqOp2IZsFndAHRiR4LEl976MN2
         Ng8ORH7mEvX4lAEca9yLexUvvYhvUURXLBUNE2nMD0Zeh6/vuOa0TuiPWt7iEe5jQoFt
         l9Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/uwtRLmLdyLaBzgDcvHMGJi4QkhtyjMfmTGgKZhA2CdIqeAOU0fykWj20yTLoAgMg47uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7923fE2bv/VB3p2CUsYWRxtD1wt2GxMS0ujgU/Hfn44VGlFjV
	LtBsryXX1m7ya1IeBEalVdkUo3XDWTyIoEj/4RVy9WNva9CD1fC2sBANKpB3S/vXwas=
X-Gm-Gg: AfdE7ckjebwkcfYTMc3oDEP0pBTFFOo1z/JlqkCAKXoyTOTUjmzBKqC7i8Ot/vVoWlc
	oBeJK24ZHbPHy4YCgRNzd2vX52R75mbd1n6vKGGITwd7MzF08ln0c3OKwYwwbE5RB26khpDPzlQ
	Y8sFabix8xW1VhNqNCX8su2PcdGMP+LIdTHwqpMbvHJe3A6i/rkriX2//QLqY3aCxrdlOLaVim3
	pA3I/da8w1gbPSg0KBcHNcSaN+nR4oZTuG1qDNZV/jYlmHl/1q3Qf1ZAq8qLkp0G30WvwqvqRU+
	YNAy3qS83VmWwiE5ncrj3N2xnzHN6URbk5FICL0oNfnYxujp3NzWiHF69DQmrWwcms+YA8onsyy
	oNNZ9fkQqrY2vwtHzWtWv9dyACGFwsfYTOz72ibBKDbPTVGRJ3L6+7fk3JqTS9AePQxRKD83o3f
	8dwlza2K5baDbhxNo=
X-Received: by 2002:a05:6402:278c:b0:697:83e1:5ef3 with SMTP id 4fb4d7f45d1cf-697d4317020mr518300a12.14.1782159839361;
        Mon, 22 Jun 2026 13:23:59 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be31ca1sm3633269a12.19.2026.06.22.13.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 13:23:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: ast@kernel.org,  bpf@vger.kernel.org,  daniel@iogearbox.net,
  jiayuan.chen@linux.dev,  john.fastabend@gmail.com,
  kernel-team@cloudflare.com,  kuba@kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, unix: Guard sk_msg-dependent code behind
 CONFIG_NET_SOCK_MSG
In-Reply-To: <20260622161221.1742161-1-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Mon, 22 Jun 2026 16:11:40 +0000")
References: <20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com>
	<20260622161221.1742161-1-kuniyu@google.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 22 Jun 2026 22:23:57 +0200
Message-ID: <877bnq4942.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 22, 2026 at 04:11 PM GMT, Kuniyuki Iwashima wrote:
> From: Jakub Sitnicki <jakub@cloudflare.com>
> Date: Mon, 22 Jun 2026 14:58:34 +0200
>> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG.
>> 
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  net/unix/unix_bpf.c | 6 ++++++
>
> AFAIU, everyhing in this file is for BPF_SYSCALL && NET_SOCK_MSG,
> or am I missing something ?
>
> I feel that it would be cleaner to add a new Kconfig that depends
> on BPF_SYSCALL and NET_SOCK_MSG, change Makefile obj-$(CONFIG_XXX),
> and guard .psock_update_sk_prot in af_unix.c

What I'm aiming for is to have all code for sockmap-based redirects
behind BPF_SYSCALL && NET_SOCK_MSG, and the rest, which is the
implementation of sockmap container for socket refs, behind just
BPF_SYSCALL.

You're right that in the unix_bpf case, the whole file could be behind
BPF_SYSCALL && NET_SOCK_MSG because while you can keep refs to Unix
sockets in sockmap without doing redirects, it won't be of much use
(there's no sk_lookup or tc-sk_assign).

We can add a new config but I won't be able to follow that pattern for
either tcp_bpf and udp_bpf, which are next in line.
