Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345543AA1A7
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833415; cv=none; b=BTNLn9dyHxSAFGlfjE/WnMKF101GdMW+hMojxxkKX/iLDGQ+8Ixar+iUf2lu02lHQFd49duQ7kamHw9Z0c7p3fEk3p7Byy+PgUKRJO8KxlO+DwDtRGj6rmBu2o6/Di1t6ENXcAw1sJtCRANp5Z/XLONY+fY+ZMswQ/iPJjcTJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833415; c=relaxed/simple;
	bh=l4Wp/3K4XsggmCmU1J76IiPLHcFBqnDGk9564RuLd2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFD6OvRPdUWzK/bX9gXmC0nGOwYypZB5APHTqAa5pdibRPXMH9thvi6Bz4RijJDNrZwJEWEfru5WK/nzP1nsuB44a0fELYmLV6FrQwYUPQ7/oayiKyXshv/ueOaTZT3diyxfXvvYxBUaZlrw3gmve+FRUNbFJsz0G4cA/sFgBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi/CXGdy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi/CXGdy"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-441209fb77eso6875324f8f.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 15:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779833412; x=1780438212; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tMaKbE21ONYZ7Ht64eViF0GrjEdmHsGqyp4YQ9xpaAA=;
        b=Hi/CXGdyBtSM+f8Jr3OdRX3K9aGWGrLcLT9gGXAsX9UFYhJXQqRfp1wLA5Gsb66TdE
         J+VX5za2bonGJhkRtN40HCPpLkH2Wp0JGH29piGDE87r4MjpFiwcG1c12KrSp4o3AwH2
         REnUe7PkfDq612/7pmbLMGKqQQQGsb6PJ8KsOSNYp7E5teRWV+5FGr0QYkzm6uA/CWVy
         dJ0VTgcJZnmD0Qp5IYZGCAG/FuSF1iDt9JFaNpMcrDOWhUN4A9XJwRiglABnyo6iT+ez
         XzY9SJnETXkUYMkn0r9n1VaZsrMtCZZZbwCsAwYgDsG3J+x+7bOP29bwyVFslJpIs8r3
         2IOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779833412; x=1780438212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMaKbE21ONYZ7Ht64eViF0GrjEdmHsGqyp4YQ9xpaAA=;
        b=F25dxNo3AF8m8TwdoUeJQinRxLpwiJlekzU1UUm7iFWuTaebFBy6U/FKCTYN1SFULv
         L5m79zxNhDL1ZAa0/FWq92/dan+WCV3YRnS+PWr7DUnyscbrN0VTY/H+DjlhEvih1eD5
         gXpUY8zIpD+07eToGy1k6PPg4vjRPsZE6fP4u3EIvILaEBbcsyYg/W8/mz7tkONcmzwp
         AZeVTOC+7eruy3SfoMnfDyyJZeEvfrNCetvgqzWU8P8KjYzgPFaj2Z8lAlrG6RzMW9MZ
         D26yG2wzCRakz6TyVqkGqZlorGFZdFfkC7xptBZ1LuDGRKl23V4y5RqXcJR/qfLJ/rfg
         vs3A==
X-Gm-Message-State: AOJu0YxNDMrPhZzSr4QECGj158LlUAeTzkSbDvlKEwpzkyAcjPnBz68O
	2Y/1ctgxyVSI/pvbh2PemJQ++p8qN7bHlPN5+VgOJxMYbFWUp1pf0q9A
X-Gm-Gg: Acq92OE+suKenL+X2SEa2lFixc62uyObAW/4VvaH3yHMODVJFfD+yei84qmVozQVDcD
	98XLQwNPF1qxY8Yvnwz4BK43wMz5+B/DSA0781tI4rMKMNKXi0+ouCVZIzerYSmrrm0hclSSW3p
	LCdCF4h8Y94j0pIT9aS8B3INUtmULt8l10BYQPrzbIuvhpaY/65GJNZu7/dTHsTQBlHsx5Uvk+f
	DRxYzr9fAMwU9wN0eGL08U2SNK0NQxzbHY6a44mYXM3xR8vZtDKR8z7VUDc0QsuabAuxnI/4aeJ
	9rknYVKlDOILswR8sR+BbgKXV808EJAbibl5Z59kQcMoreexrys662vZoWvz1eAPENkZEj9Jqot
	2tt3EExdvWw9QSiK7PKyhtrktxyhOZUzmY1pRqBh5MwF3ivpchQ8Aqia8p9FQN6XkMadDl/psft
	GmHTicSUdQCt46f4q3tQq2P9MnM95PnJgCFWJIyCkjebL6daeh3w==
X-Received: by 2002:a05:6000:1889:b0:45e:8edc:dacc with SMTP id ffacd0b85a97d-45ea31ce398mr40425669f8f.27.1779833412510;
        Tue, 26 May 2026 15:10:12 -0700 (PDT)
Received: from gmail.com ([2a01:e0a:488:3510:15a1:dbd2:86bb:c4e9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb549e79sm1307141f8f.7.2026.05.26.15.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 15:10:11 -0700 (PDT)
Date: Wed, 27 May 2026 00:10:10 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 7/7] selftests/bpf: add bpf_icmp_send
 recursion test
Message-ID: <ahYaQv4C0FXUvn8b@gmail.com>
References: <20260526153708.279717-8-mahe.tardy@gmail.com>
 <20260526202232.631751F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526202232.631751F00A3A@smtp.kernel.org>

On Tue, May 26, 2026 at 08:22:31PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Attaching to the system-wide root cgroup without PID filtering intercepts all system-wide loopback ICMP traffic, causing data races and network disruption.
> - [Low] Multi-line comments do not follow the mandated BPF subsystem style.
> --
> 
> commit a40313de8eec16152c739a5ecc571fcd166b9bba
> Author: Mahe Tardy <mahe.tardy@gmail.com>
> 
> selftests/bpf: add bpf_icmp_send recursion test
> 
> This commit adds a test to verify that recursive calls to bpf_icmp_send
> from a BPF program return -EBUSY and stop early.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> 
> [ ... ]
> 
> > @@ -201,3 +202,42 @@ void test_icmp_send_unreach_tc(void)
> >  	bpf_link__destroy(link);
> >  	icmp_send__destroy(skel);
> >  }
> > +
> > +void test_icmp_send_unreach_recursion(void)
> > +{
> 
> [ ... ]
> 
> > +	trigger_prog_read_icmp_errqueue(skel, ICMP_HOST_UNREACH, AF_INET,
> > +					"127.0.0.1");
> > +
> > +	/* Because there's recursion involved, the first call will return at
> > +	 * index 1 since it will return the second, and the second call will
> > +	 * return at index 0 since it will return the first.
> > +	 */
> 
> [Severity: Low]
> This isn't a bug, but BPF subsystem multi-line comments should have the
> opening /* on its own line.

Style issue could be fixed if required.

> 
> > diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
> > --- a/tools/testing/selftests/bpf/progs/icmp_send.c
> > +++ b/tools/testing/selftests/bpf/progs/icmp_send.c
> 
> [ ... ]
> 
> > @@ -125,4 +128,45 @@ int tc_egress(struct __sk_buff *skb)
> >  	return TCX_DROP;
> >  }
> >  
> > +SEC("cgroup_skb/egress")
> > +int recursion(struct __sk_buff *skb)
> > +{
> 
> [ ... ]
> 
> > +	} else if (iph->protocol != IPPROTO_ICMP) {
> > +		return SK_PASS;
> > +	}
> > +
> > +	/* This call will provoke a recursion: the ICMP packet generated by the
> > +	 * kfunc will re-trigger this program since we are in the root cgroup in
> > +	 * which the kernel ICMP socket belongs. However when re-entering the
> > +	 * kfunc, it should return EBUSY.
> > +	 */
> 
> [Severity: Low]
> This isn't a bug, but this multi-line comment should also have the opening
> /* on its own line.

Dito.

> 
> > +	ret = bpf_icmp_send(skb, unreach_type, unreach_code);
> > +	rec_kfunc_rets[rec_count & 1] = ret;
> > +	__sync_fetch_and_add(&rec_count, 1);
> 
> [Severity: Medium]
> Could attaching to the system-wide root cgroup without PID filtering
> intercept all system-wide loopback ICMP traffic and disrupt other processes?
> 
> Because ICMP traffic is not filtered by port, any ICMP traffic to 127.0.0.1
> on the host will trigger this BPF program and generate unintended ICMP
> Destination Unreachable replies.
> 
> Also, can concurrent executions cause a data race here? Two CPUs could read
> the same rec_count, overwrite each other's return values in the array, and
> corrupt the state, causing test flakes.
> 
> Would filtering by the test's PID securely isolate the test? The recursive
> kernel socket call executes synchronously in the same task context, which
> should make PID filtering reliable here.

I don't think it's necessary, we already added some filtering here, we
can always add more but I'm really not sure it's useful.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260526153708.279717-1-mahe.tardy@gmail.com?part=7
