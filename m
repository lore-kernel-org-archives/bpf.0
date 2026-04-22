Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A56526CE05
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859139; cv=none; b=FtBQajo6bqOWYawRBNfXcnoqLhmpRdu8vlWXq5tL2J9A58Aft9WtkH/hqbtJ8ZobonX0Seeu92ZznfLxvA6NQhwaCi1bTfDJglltNT2GyAjKkWyZKcQaT5qd0QuDLQ5SJGYJP/e/xUJKS+ZsX/QpK8yJ5G+5c05I7CmN4wbUMgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859139; c=relaxed/simple;
	bh=9RHzK+uswo2gCjFa0kvq4X21oBMczUOfb7mfVGy3Y8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEx2em+T9Bk9YX7+KwE+nV0uqbcMjBFKaJXegzZuRHIpbXngidJU0rgmz4+H1X0Er4A7PM8vcgBql7+f17Dou88XMjHfE2cAk8YtM/xE5k9Q8Z67mPtwgRwd+7nf59+ky39SFOuS94x/KQEVS/3G90Bqm080DkXtuWrAS3QGTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA0rMV17; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA0rMV17"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-797ab169454so70367297b3.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 04:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776859137; x=1777463937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5u1OT4tC2otu34XuAeavAhJ1IpX+6mEHksz8U/dyyjs=;
        b=cA0rMV17/LLkEa6qc/6BHHB9QeZkV4LMdBcWireKJHzaqoi9xG3vaQVTXaEI+3XH1f
         6lVuo+yKC0k950tZMFGgIWKeh+S/P71tEW+xfDWHu10d0q9XRXnR7tPVmsEc9FdDThAp
         qyRYVH8fUn9xxLfAxZmBSVbPpDJxXpjoqDEXWmhy1bXieqacJCcd1DGjXBEoxebyZYSm
         cPienVJBVduA+T1a2MNnydP4vYDfz0ej2Z9ntYChyDOhduCSu3zTRlWJTx9CHL7H+27f
         vlILwypxSrj9WsbD6KDoYWv2UkgXyTwLY4IJlis5O4X7lkU48B6MAx5096IfM0otEjtE
         +hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776859137; x=1777463937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5u1OT4tC2otu34XuAeavAhJ1IpX+6mEHksz8U/dyyjs=;
        b=XNr/9buB+yu3vUNvyzf1SLKRQ6/2Z/lNais5u4ANoFGsAm9keTRA7K6QquPygQgdXF
         h/XGWiUSYHIftMS6ayVnMv8MmCXJ6CCpUJbcOfM18bQO58kR9v/ee2JxIUOgqQqnlMuE
         qJC44uboO4rTuRccvfMT70HHkFdUy7vD79Kukd9tBoctH82rHWpWhfFk+DhZ9vydEi6K
         vcm1x+IJAP4F2aN3f+1T22KlL+ezdtCEF/4cXIXCOvmIWGK/ccVeu4NfhdeetRqdj4FT
         rYB6kGz0PcBRxcGYq/eo6HxauI8V1eTAYuRlSCnTsyH7iZuR6BRlvx2Z9+L8YiEu9UhM
         9WzA==
X-Gm-Message-State: AOJu0YyNyAMSrB/QzOfzARvK3wNmfsFz041nVxBeX10XBMLtycYupniu
	hkyTKFdU8EhUzzjqET3BrPu9zTAuwa07OuJsJXb+cnFgdAgwcKRQbeuX
X-Gm-Gg: AeBDietidt3MNsG6FiDAHmwvegkC69CHZa8PyLvmc1TnRTZspOPNreBmVjJaJhG1qNn
	p21WTzsQ7m3d1Wdyl2y1vN0uxe4uy5xxJXylD4lrEw5ZPd1ZJ13a3vh9RpgL/YcIEuue3gKTWSJ
	eYndBiczRev0Eu3roDkXaXc2E+ekf/3/qtl1Mie9qb66znD9+QjYBJhZP0Q9RWnUmbWlr+ZViCN
	Z9m0uUzu2RRHIO6m7rGy9zpIoJFa2pywAWYP8TOeIMCQciiHTAkpzij+LtlR9cuycn+EqgkY7ob
	TtdA+h7CiGpzyMix+Ud2qw2dF9BJ8JmoAWQLb37aFMysGVZiRJm6eutaXtI7lLfBy+aBFRdzSI9
	psWyiHJO7LFonOMupfKobXEQxZ23u9bDIHDAoxETiWm4HQv43AwqxlgWU3iN2nFWks4jHNIfRVS
	5YsFLaKyfQ/AuzCKDHZxiGleDGW0gMiMRApcAUKRAWi0hitJYnOP5nvQ8lTog8gg2znOUs
X-Received: by 2002:a05:690c:f06:b0:7ba:f712:95e3 with SMTP id 00721157ae682-7baf712ba0dmr115284027b3.1.1776859136396;
        Wed, 22 Apr 2026 04:58:56 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:a9c4:f98e:7195:7721])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee8c2083sm66894197b3.17.2026.04.22.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 04:58:55 -0700 (PDT)
Date: Wed, 22 Apr 2026 07:58:54 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev,
	yonghong.song@linux.dev, jolsa@kernel.org
Subject: Re: [BUG] bpf: Soft lockup / panic triggered by
 bpf_task_release_dtor from NMI on rcu_nocbs CPU
Message-ID: <aei3_mfpuAGI5-qG@zenbox>
References: <20260421201035.1729473-1-utilityemal77@gmail.com>
 <CAP01T77FND4_i0fB8zrYPJj0HAx=CkvTFB4=eV4EyZbdpuqgow@mail.gmail.com>
 <aeftTnQjdOgjZyYP@zenbox>
 <CAP01T77626uOQLrxkiMRDE_-VyMO=BDEYYRNEW1fgkj9yRv1NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T77626uOQLrxkiMRDE_-VyMO=BDEYYRNEW1fgkj9yRv1NQ@mail.gmail.com>

On Tue, Apr 21, 2026 at 11:44:42PM +0200, Kumar Kartikeya Dwivedi wrote:
> > [...]
> 
> We can add it but return false when expected_attach_type ==
> BPF_TRACE_ITER. For all other cases, allowing it doesn't make sense
> because these might potentially run in NMI context.
> 
> Please let me know if you'd like to send a fix + tests, otherwise I
> can follow up. Feel free to fold in the diff I sent into your fix, no
> attributation needed.
>
I'll send a fix and selftest.

There needs to be some documentation matrix of prog/attach type to
kptr / other features to prevent bugs like this, but this can be a
future patch.

I may make a series improving documentation as there are many other
verifier "quirks" I had to discover by reading the kernel source. :)

Justin
> > I'm honestly still not sure what the difference is, but they are
> > different [1]
> >
> > Would you rather do this or just reject the dtors with a
> > kfunc filter for this program type?
> >
> > Or teach the verifier that the kptr ops need to be offloaded with
> > bpf_task_work_schedule_resume_impl?
> >
> > [1]: https://docs.ebpf.io/linux/program-type/BPF_PROG_TYPE_TRACING/
