Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5136DA0F
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115176; cv=none; b=C1UPzqRbGLGFB6KiyyUxh/zHljvDpYpWK+XD0nmQtFY2Pdxsxw4W9oMThfeRdn1pllV+Sw5zKBbCQUx4jQZ/Ueoe2tRmwiyMuszLWDRjxfy+7vWBEoTrvVPkxZx6MnKv9pYxioeMsEZm4o+uE3gH32kDetWV16GB7GkglLNQJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115176; c=relaxed/simple;
	bh=RogBAxxq8noxKAc7aW/xyYbRbLZgr4qUmDiwc9tcu2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFpiJPCvNsybXAAl6pv9WiEX3zbmeh5GlM2AJT+wtCnxguuKpApKMmldU5CYI+JE2fWfhFitEuQBmtZ83gAkYygWQJFp9vbf2GhrEBc7ypUTs+F/YB8tWUqcgGc0Gnk9/lW3+uz0MK3hI64NgS+Wj75xRbr2GvsprCqhMKUN9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDoFq9u1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDoFq9u1"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44b330c5cc6so1712363f8f.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779115174; x=1779719974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUlcTJbqHH/a0lNc4ZwIftVoYCcktEMzS3W/h9hsyBs=;
        b=mDoFq9u1AsPUh543t3oCblxxKR0/v4u1fk5NZ5KmUcc1zN+5W7fQiD4Whs+NSDfCAb
         tLoPheKhObqnFK0GvtIIYalhaHbA/RO9dV6FOHeEDdYZIJsqduraswBuYTqPHIy6ZbGb
         s4p0PzjsjWwXOr3XGbnvfwgcbdwugG9a6V0r26HHIHn7HxJf/C/6XhUEF5ym/DYM2V8p
         YEElN95KLcDABbgX259B8Hv6lq+AiAEcBVpq02k8l5dYzVcShN+VBYIkmE1ZqBXDE3x5
         fNQMrJWe3yhJJaBbGuwOUnnBxoOAgwGWUNSx5BJ8w/HHi71RTgRU5I3uu5U6g1SzbbgL
         aYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779115174; x=1779719974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUlcTJbqHH/a0lNc4ZwIftVoYCcktEMzS3W/h9hsyBs=;
        b=tY+CAEOfzYhL2S9LkocYODSFgjBxH58XjbtpZBuaNXiYaVDnkRNY5u/Ezprw2lQI+b
         FZu2g7tiwRgvpIccyJHqgluh8q4iu10FXgNg1pZnLGdH5jfrVvNbFtCvRBnvDgkbrCm9
         TAz22fVlYT/pTfjXIs5iFVAdEcI90rLiaF1X9oNH8oh9DG5bE2sSg0mrHvoB13WzR1UE
         EGg8tfOoQU5yp/2spZb7dmjiCs52etLw6HPSGUTdGak3EDeWin1CpiBdxbteR+C703si
         NCXv5y5kx6JGbhOjsAc8S5ETh7khBG1Z29k72Wi4Ps+BTmWPxUMXghKsNmKLE5p6PPWJ
         0ESg==
X-Gm-Message-State: AOJu0YzPrAPot7slQ2uM89VIDMXz7H0IRZWv+JTMHp4kI3OPOLRICsAZ
	aDrokvYTljNKRZ1uDWzyF0aKsOipu87mKXynPNu1lx86eT2xkm3TdVy7
X-Gm-Gg: Acq92OGyIM+Rd2W07i0JKA0Sx3ubghTWHw8gwwG9tUproutCTluw2ghEst8/an2Udbr
	LqhbRzb2nNyUH5nOd1wiB+lwDZ6WLrfnd2Dma46seiLzBHUzvG5ib9P26z3MdG93KuGliHkarkO
	TElM4KIJ6NDdPpQj/BF1zI9TsMLo4GY8gPS+W093Y6aaDfLQI6FBKxkcUGji8mx0kqZMWo5WQMr
	0MAz9jofa9RxC1pnzBuBbqzcATqOza6jdzJGPaCSvJ/eaQrFabRE+JHBrhkNXFxzpQlQYkMX6bN
	0FraI+mmHIu7pFZUM9Lp1+ObbL384wsr2GLyvN0OtPAUcyC7yp1RkMXyJHwxIxPv1dUx2Ioz4Sx
	++NW34fqNd3wMKBCJOhL8KyN9ljf4CVA+b2xvopm6byRByv8mVzip6mv6UcBPw4vSTWpOZ++LZp
	7U1jW96qXH+fCllnYDHIcXPxzIZUkiRvFT+H9+uPk/G1wZYkNipMgKaSM=
X-Received: by 2002:a05:6000:240b:b0:452:bc55:c684 with SMTP id ffacd0b85a97d-45e5c5d6764mr25771099f8f.19.1779115173464;
        Mon, 18 May 2026 07:39:33 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45e7c22d8b7sm8741804f8f.6.2026.05.18.07.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:39:33 -0700 (PDT)
Date: Mon, 18 May 2026 16:39:31 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, martin.lau@kernel.org,
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 6/6] selftests/bpf: add bpf_icmp_send
 recursion test
Message-ID: <agsko7KjEILkHAk4@gmail.com>
References: <20260518122842.218522-7-mahe.tardy@gmail.com>
 <92695da279ff66c47eeab8c93562f171982732ad4f420f0057c773efb6c1db8f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92695da279ff66c47eeab8c93562f171982732ad4f420f0057c773efb6c1db8f@mail.kernel.org>

On Mon, May 18, 2026 at 01:07:53PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > index d0ac0502f6df..a9e9806877cf 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
> > index 6e1ba539eeb0..7830334b747a 100644
> > --- a/tools/testing/selftests/bpf/progs/icmp_send.c
> > +++ b/tools/testing/selftests/bpf/progs/icmp_send.c
> > @@ -13,6 +13,9 @@ int unreach_type = 0;
> >  int unreach_code = 0;
> >  int kfunc_ret = -1;
> >
> > +unsigned int rec_count = 0;
> > +int rec_kfunc_rets[] = { -1, -1 };
> > +
> >  SEC("cgroup_skb/egress")
> >  int egress(struct __sk_buff *skb)
> >  {
> > @@ -65,4 +68,32 @@ int egress(struct __sk_buff *skb)
> >  	return SK_DROP;
> >  }
> >
> > +SEC("cgroup_skb/egress")
> > +int recursion(struct __sk_buff *skb)
> > +{
> > +	void *data = (void *)(long)skb->data;
> > +	void *data_end = (void *)(long)skb->data_end;
> > +	struct iphdr *iph;
> > +	int ret;
> > +
> > +	iph = data;
> > +	if ((void *)(iph + 1) > data_end || iph->version != 4)
> > +		return SK_PASS;
> > +
> > +	/* This call will provoke a recursion: the ICMP packet generated by the
> > +	 * kfunc will re-trigger this program since we are in the root cgroup in
> > +	 * which the kernel ICMP socket belongs. However when re-entering the
> > +	 * kfunc, it should return EBUSY.
> > +	 */
> > +	ret = bpf_icmp_send(skb, unreach_type, unreach_code);
> > +	rec_kfunc_rets[rec_count & 1] = ret;
> 
> Will this program affect background traffic when running on the system?
> 
> The recursion program is attached to the root cgroup and intercepts all
> IPv4 traffic. While v5 changed SK_DROP to SK_PASS to avoid blocking
> traffic, the program still calls bpf_icmp_send() on every IPv4 packet
> without filtering for test-specific traffic.
> 
> This means background IPv4 traffic (SSH, DNS, other tests) will trigger
> ICMP Destination Unreachable messages, potentially causing network
> disruption and test races on rec_kfunc_rets and rec_count.
> 
> The egress program demonstrates proper filtering by checking for TCP,
> SERVER_IP, and server_port:
> 
> SEC("cgroup_skb/egress")
> int egress(struct __sk_buff *skb)
> {
> 	void *data = (void *)(long)skb->data;
> 	void *data_end = (void *)(long)skb->data_end;
> 	struct iphdr *iph;
> 	struct ipv6hdr *ip6h;
> 	struct tcphdr *tcph;
> 
> 	iph = data;
> 	if ((void *)(iph + 1) > data_end || iph->version != 4)
> 		return SK_PASS;
> 
> 	if (iph->protocol != IPPROTO_TCP)
> 		return SK_PASS;
> 
> 	if (bpf_ntohs(iph->daddr) != SERVER_IP)
> 		return SK_PASS;
> 
> 	tcph = (struct tcphdr *)((void *)iph + sizeof(*iph));
> 	if ((void *)(tcph + 1) > data_end)
> 		return SK_PASS;
> 
> 	if (tcph->dest != server_port)
> 		return SK_PASS;
> 	...
> }
> 
> Could the recursion program use similar filtering to explicitly check for
> the test's traffic?

I could restrict a little bit more by ignoring all traffic that is
non-TCP for the dest port or non-ICMP but not sure this is actually
needed. E.g. writing something like this before bpf_icmp_send:

if (iph->daddr != bpf_htonl(SERVER_IP))
	return SK_PASS;

if (iph->protocol == IPPROTO_TCP) {
	tcph = (void *)iph + iph->ihl * 4;
	if ((void *)(tcph + 1) > data_end ||
	    tcph->dest != bpf_htons(server_port))
		return SK_PASS;
} else if (iph->protocol != IPPROTO_ICMP) {
	return SK_PASS;
}

But not sure this is strictly needed.

> 
> > +	__sync_fetch_and_add(&rec_count, 1);
> > +
> > +	/* Let the first ICMP error message pass */
> > +	if (iph->protocol == IPPROTO_ICMP)
> > +		return SK_PASS;
> > +
> > +	return SK_DROP;
> > +}
> > +
> >  char LICENSE[] SEC("license") = "Dual BSD/GPL";
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26034287312

