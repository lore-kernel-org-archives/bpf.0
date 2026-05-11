Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4E46AEDD
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521515; cv=none; b=qoc1fR3uVlJOQZX20Jmb5XHoY8Tag5vqsRZLu0GOwFjQ0625GfRuX97VyMSxS4GQKgPxSFcGh1Y4q6/cn5QHmYpgA2y3NyQOxtY+KDhxnuSPzz9kedKyJq7x95bICAgDmo61G+6g6S68VsuBvFuuR1lK+n/2qg17vU1E8dF1D/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521515; c=relaxed/simple;
	bh=v9RZd5XVM5mKL1+0Sn8Ag2xabiqEIQ7V32te9P0NC+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbsAShvkCCDzzWvrQvAelO7of73dF/slGbzyvq4McTwS8OLt+fhRdPsqiWgZZTpn/u3PDypR+0Pem9VbH66G/EK3eOdIUFzB8JbPlXEbJBJg5OjBInYS5C9mzCAHj4PfTUWmwGGLciCIXqvUihEAEe+B4UpXkZ65NnibSFTm0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZztBXXv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZztBXXv"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso39344255e9.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778521512; x=1779126312; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uK9M1IMpDQmhMIBFb/aMTJcryejvQYs5/OIG8MuD4U0=;
        b=fZztBXXvKH7GrvbUzv/LwuTYkzTuAb3x4Th1hiSz3QMcnSSnGRvagMfoCDHzwZnonx
         cwx5AT8KAln8HVMS91XjYe0lA82fjt9AHbyHxg3M1NRoj5DkvFs7QGOppKWEqBXsTE4Y
         VOWPLw0RnTcxs/CPiogOK5vq9mkjgjEIsucdMyTyuFCEXMgWcDUTdb4m3pXmkyY7SPIQ
         3XUgDGe2JtcemcVcLjAftpE4YcwwFKjtpiAGtOc+1KnKsfP+OM/W2d5y9cjpgqUV1TZ7
         QfiqRXGem2OBMlOICw5DMX4jaZSwmz+/h9XWGIyck0QEJjzlK7lnMrCzLts9k3cP1JdJ
         DOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521512; x=1779126312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uK9M1IMpDQmhMIBFb/aMTJcryejvQYs5/OIG8MuD4U0=;
        b=gKUdai4kh3a1SlkNLEbyJfe+t92d9kefIXLnMRIU/BrUvy9FWilCNLRBWazG58PUHt
         UIbm5JZeMEVqijT3uv04D5M6HJCeckMCxN2wc7ExfLRWuiK+yno2poyuuk9vgnZt1JI8
         0HyVz8JfiRw8TSDs5rf8tIffayimsVEGbg9QYbiFmRNCGWvGmWOloZx2KvzQ9nKBb1yA
         +lsN6ymcUhJgnfa6hlpXbDXbJOPF6YZGnxw+IMkR5sCPMAsbmE+nnHKSN0tFIeO+fdjl
         QIVUiLaESb1/wPeFxeFtomxHFcm9v1lCAHry1ykeBQMdYZCO26D8r4oAGXmzOxVB6kHz
         xqzg==
X-Gm-Message-State: AOJu0YxakCRH04gpPmGVm79CjZMFQ1ZGxWW+JQJ1MmTUll3p4C6JWbvx
	O9vDt0Rp/Mst7bHvlI5ajUj4leZklTcQKhSBrGyHkl1xXLP92ofl1gKg
X-Gm-Gg: Acq92OHBMOw0b+XvKCwpYtxcvNuDTQfZCWunjsxPOH9E3+yIzyuar8yUAi0x+sh33oH
	GcRLRAtgi+Qy06+TqJd5xbiWkruEcZAj1HNvAz0JtTW/eUMSDc7p6zQodjafC9tCQ5MbgxIHMbM
	eO44i5sc87wKorZiEs1bo3Vwl3u2v+1fhNcvTnqxAAQ/m9wq9PYaRo1hpl5BQlvtV5PA2bYIXzG
	rQXYsjuPPlTfl4tmioZPB7OEASHX1xd5o+KDDU/2famQ2ZpA2jRZujoh0f3D6bI0xU1QD0Sz6TD
	Ucfcpez6m+1TMnxrLNp9mDeV7ucC6qMi7BRfR77jCMf1VNCLbLNnjW7oRL80kJjnM0ylKJUbp8s
	aHOWYIWOU8TVgTcItOQl04pPSnse/Uz3t8JFHCh5VC3F70taPjCYsSB84WHlx6FN96cVHD5hB4I
	pj9SNZtDhIYL8DCnwaXaSca9l4+WQVbbcpkNiYeioM7Oi9agqoCqf4F9cIBxzY1mLxPTtlGQfHd
	O86vzKC7qwaD+UVa6YyZTivsGbY+y5qlJZ8lEmSi7TJsfH8tDMWd7G5PElKg5kuj0tbTxy5Qx0v
	SLD2qWuFkbvlYerwARjwQ6yD9m3A4O04fz/fNU2ko3Q=
X-Received: by 2002:a05:600c:8707:b0:48e:8741:fd3d with SMTP id 5b1f17b1804b1-48e8e238f28mr7807145e9.14.1778521512091;
        Mon, 11 May 2026 10:45:12 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f76596008310132d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f765:9600:8310:132d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a68ebsm25382197f8f.1.2026.05.11.10.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:45:11 -0700 (PDT)
Date: Mon, 11 May 2026 19:45:09 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v4 10/14] bpf: change logging scheme for live
 stack analysis
Message-ID: <agIVpXzC_bXgJ44N@mail.gmail.com>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
 <20260410-patch-set-v4-10-5d4eecb343db@gmail.com>
 <af0gXEqD3FPFYZDj@mail.gmail.com>
 <639f1b0f97330c98668c00244c0a7bae19e30e3c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <639f1b0f97330c98668c00244c0a7bae19e30e3c.camel@gmail.com>

On Fri, May 08, 2026 at 06:46:23AM -0700, Eduard Zingerman wrote:
> On Fri, 2026-05-08 at 01:29 +0200, Paul Chaignon wrote:
> > On Fri, Apr 10, 2026 at 01:56:01PM -0700, Eduard Zingerman wrote:
> > > Instead of breadcrumbs like:
> > > 
> > >   (d2,cs15) frame 0 insn 18 +live -16
> > >   (d2,cs15) frame 0 insn 17 +live -16
> > > 
> > > Print final accumulated stack use/def data per-func_instance
> > > per-instruction. printed func_instance's are ordered by callsite and
> > > depth. For example:
> > 
> > Hi Eduard,
> > 
> > Sorry to revive an old thread.
> > 
> > We've started running a kernel with this patchset in Cilium's CI and
> > noticed a big increase of log verbosity for BPF_LOG_LEVEL2. To get an
> > idea, a full dump of all (uncompressed) verifier logs for our
> > tested programs used to take ~8.4G. With this patchset, it now takes
> > 15G. [1] helps a bit to reduce it, but still only getting to 12G.
> > 
> > The increase seems to come from print_subprog_arg_access(), which prints
> > full functions with the results of the fixed-point analysis, from
> > print_instances(), which prints full functions with the use/def slots,
> > and to a lesser extent from compute_subprog_args(), which prints the
> > fixed-point iterations.
> 
> Hi Paul,
> 
> Do you have a break-down? I'd expect most of the log to come from
> arg_track_log(), as it visits instructions multiple times
> (although, convergence might take only a few iterations).
> If it is a significant chunk, I think we can drop it completely.

That was also my first guess, but looking at a couple examples, it seems
to converge fairly quickly. Some statistics to confirm this: if I filter
my 12G of logs to only lines containing " -> " (so coming from
arg_track_log()), then I only get 30M of logs remaining. So
arg_track_log() looks really negligible here.

> 
> As for print_subprog_arg_access() and print_instances(), as you
> suggest the output can be combined, such that the full function is
> printed only once per call depth. This combined print-out can also
> include results of registers liveness analysis.

Yep, that makes sense. I'll try to find some time to look into that.

>  
> > I'm wondering if maybe there are other opportunities to reduce
> > verbosity here (besides [1]). Maybe we don't need to print the
> > fixed-point iterations if we're already printing the results? Or maybe
> > we could put the more detailed liveness-related logs behind
> > BPF_LOG_LEVEL3 or BPF_LOG_LIVENESS?
> 
> Had this been a normal compiler or jit engine, I'd vote for
> BPF_LOG_LIVENESS log channel, I'm not sure what our stance regarding
> user visible ABI here.

IIUC, it was only released in an RC and the logs themselves are not
really part of the ABI, no? Or is there some other concern I'm missing?

> 
> Regarding BPF_LOG_LEVEL3, I think that the original idea behind
> BPF_LOG_LEVEL2 is that it would serve as a "debug log" that regular
> users won't need to consume. What is the motivation behind collecting
> level 2 log on your CI? Is it to infer clues regarding programs
> hitting 1M instructions limit?

At the moment, we collect this (1) in case of failures due to the 1M
limit and (2) to compute the maximum combined stack depth using the
per-subprog stack depths and the callgraph. (1) is not expected to be
happening often and isn't much of an issue. For (2), I'm planning to
send a patch to have the verifier report the max stack depth itself.

Overall, this isn't an issue for us. We're just using a bit more memory
and disk space. I just though the sudden increase was unexpected and
thought I'd have a look :)

> 
> [...]
