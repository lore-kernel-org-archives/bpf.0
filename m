Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21190420E9D;
	Mon, 14 Sep 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377748; cv=none; b=pSY8bQC3hIZ7HwGqQXmhfRFgyP6THmmITZxm6+G+pNs+YW8U09hD2IArc6a9Gpkz3SvQPf2VML6KRD8hrpBT6zR7BjnZ9XrCZrp0GeFyHXoliNaeD2gME5++5t173fFf9FQ66FlqX7hrxWmapH5CIRdbR/YZx4aMX0zDM6kE0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377748; c=relaxed/simple;
	bh=rmKTVutRr5r4ozn9rP4kxBeXsrYHk02+BBEkn8hwYcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGH+18d6Jy19zq56QlWVcN/SoqV04OQD7wkl7iz7jrMc5tSbkxx4/C18wziU2pkzzC1xo5TFNHvKautiQ4KGWYyEKkahUYXhAdw1urJu7XQoDTHxIafxejN21tysTOkLt4KcTsDCbFOvPyig+edx22dsNde9uG8GawT2Q47qxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XgccO5fc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fg0eA/xU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XgccO5fc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fg0eA/xU"
Date: Mon, 14 Sep 2026 11:22:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789377745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=05x4mMxTSx/33JYljcT44N9GMsyEVpbh4p1MGBKXnB8=;
	b=XgccO5fcbM1qfJdaRULmKcwi/PQnHDT9T3k6q3/qQlrf64bSZtDtIziQr1yBUS4BQ6cLNR
	dk+Ecj61qr0gu4M0HyWlB3ZXgrH3a53O7ZEeZJbpgsM+OGhwmRqUMk0osguxXJ1gkBxqIn
	+cAgagvceZw1OBwesdBP5nnlTlPBU7P91E3/l12+AmlXePyfv73pC7OjurKWz2AcNEIQ+l
	NNL5UamyjWbo/E4w3sT+rYBRktp+9kVxpufLq63XKPduBZztA4tLoUsl8u9CQWJXKZHuGw
	NZ2ySvQFWdiTFlfSQF8EksJ0XJo8wED+hrIQ+cQZtUbBWqm6UxqMUd3FTpqgHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789377745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=05x4mMxTSx/33JYljcT44N9GMsyEVpbh4p1MGBKXnB8=;
	b=Fg0eA/xUKqk/ptXFS1KpDggPsHG6V+mKtkkqLWp9JOrv/715PtA/p6QJK5oZUewIgvlILg
	x9xrZuZ8m6m8gOCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, ihor.solodrai@linux.dev, ast@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, shuah@kernel.org, martin.lau@kernel.org,
	mason@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Replace %pK output with 0
Message-ID: <20260914092223.nZd-E_QE@linutronix.de>
References: <20260911145011.kErTVDkS@linutronix.de>
 <d8f2687c7b00a0ce9f54fe1ba4ed7d461860dbbe33464a014b90913b0652aa95@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8f2687c7b00a0ce9f54fe1ba4ed7d461860dbbe33464a014b90913b0652aa95@mail.kernel.org>

On 2026-09-11 15:41:45 [+0000], bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
> > index 07c834433b38..75ff1142c185 100644
> > --- a/tools/testing/selftests/bpf/README.rst
> > +++ b/tools/testing/selftests/bpf/README.rst
> > @@ -187,7 +187,7 @@ The symptom for ``bpf_iter/netlink`` looks like
> >    ...
> >    15: (bf) r2 = r7
> >    16: (0f) r2 += r1
> > -  ; BPF_SEQ_PRINTF(seq, "%pK %-3d ", s, s->sk_protocol);
> > +  ; BPF_SEQ_PRINTF(seq, "%p %-3d ", s, s->sk_protocol);
> >    17: (7b) *(u64 *)(r7 +0) = r2
> >    only read is supported
> 
> This excerpt is a historical clang-10 verifier log illustrating an old
> failure case. The patch rewrites the quoted source to "%p %-3d ", but the
> actual code now reads BPF_SEQ_PRINTF(seq, "0  %-3d ", s->sk_protocol) in
> bpf_iter_netlink.c - the sock pointer argument is gone entirely.
> 
> Should the historical log remain untouched, or should it be updated to
> reflect that the netlink iterator no longer passes a pointer to
> BPF_SEQ_PRINTF?

I would prefer to remove the K and the plain %p should provide the same
historical input. Replacing it with 0 (and removing the argument) might
no longer do the job. As of commit ce3267a39a92b ("kbuild: Bump minimum
version of LLVM for building the kernel to 17.0.1") the minimum required
version is way passed 10. I don't know if this also applies to BPF here
(but why not?). If the required version is 17+, then there is probably
no need to reference a fix for llvm which is included as 11+.

> > diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> > index 4e4a82d54f79..f2cd442c4683 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> > @@ -16,7 +16,7 @@
> >  #define MIN_SYM_RET  sizeof(EXP_SYM_OUT)
> >
> >  /* The third specifier, %p, is a hashed pointer which changes on every reboot */
> > -#define EXP_ADDR_OUT "0000000000000000 ffff00000add4e55 "
> > +#define EXP_ADDR_OUT "ffff00000add4e55 "
> >  #define EXP_ADDR_RET sizeof(EXP_ADDR_OUT "unknownhashedptr")
> 
> The comment says %p is the third specifier, but after removing %pK from
> the BPF program (test_snprintf.c:59), %p is now the second specifier in
> the format string "%px %p".
> 
> Should this comment be updated to say "The second specifier"?

Yeah, that makes sense.

> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
> > index a2652c8c3616..36690478992f 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
> > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
> > @@ -44,8 +44,7 @@ int dump_unix(struct bpf_iter__unix *ctx)
> >  	if (seq_num == 0)
> >  		BPF_SEQ_PRINTF(seq, "Num               RefCount Protocol Flags    Type St    Inode Path\n");
> >
> > -	BPF_SEQ_PRINTF(seq, "%pK: %08X %08X %08X %04X %02X %8lu",
> > -		       unix_sk,
> > +	BPF_SEQ_PRINTF(seq, "%08u: %08X %08X %08X %04X %02X %8lu", 0,
> >  		       sk->sk_refcnt.refs.counter,
> >  		       0,
> >  		       sk->sk_state == TCP_LISTEN ? __SO_ACCEPTCON : 0,
> 
> The header shows "Num               RefCount" (18 columns before RefCount).
> The old format "%pK: " produced 18 columns (16 hex digits + ':' + ' '),
> matching the header width.
> 
> The new format "%08u: " with argument 0 produces "00000000: " (10 columns),
> so every column from RefCount onward is now shifted 8 characters left of
> its header label.
> 
> Should the header be updated to match the new field width, similar to how
> bpf_iter_netlink.c was adjusted from "sk               Eth" to "sk Eth"?

Missed that. The net: version expected a 32bit pointer while the bpf one
expects always a 64bit pointer. I tried to shrink the net one to
something smaller but there was a selftest somewhere expecting the exact
size so I just went with it.

Let me align everything with net then shrink this one including the
description, too.

> Regarding the commit message:
> 
> > Networking recently replaced the socket output with a plain 0 because the
> > socket pointer added no value to the output and the %pK should be removed
> > fom library handling. The format remained otherwise unchanged in order not
> > to break any tools which are parsing this information.
> 
> There's a typo: "fom library handling" should be "from library handling".

Thank you.

> Also, the statement "The format remained otherwise unchanged" is
> contradicted by the netlink header change from "sk               Eth Pid"
> to "sk Eth Pid", and by the field width changes across all modified files
> (varying from 1 to 10 columns vs the original 16-17 columns).
> 
> If maintaining format stability for parsers is the stated goal, should the
> width-preserving spelling be used consistently?

"stability for parsers" means not to remove pointer and therefore a
column so it will work for the human eye but the parse would expect a
certain column. The padding here is just for the human eye and the
parser does not care.

Sebastian
