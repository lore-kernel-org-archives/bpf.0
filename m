Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078D175A7F
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782628570; cv=none; b=XTMxlOL32YRl7KyBNBK6ux9Lmelm6ekjmY38cGRZEkjmmU286d7sxuZISP0JmMPbGpLWTPGdo+o0EuVdKUO28xmUmr3xeYtSePe4oD1MAWgxHRCNDCcm9UwBawJ5+hXXdwd3maWgwptPWPY0gRDFPW3OgGTvSY97815ojqAf8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782628570; c=relaxed/simple;
	bh=s644IXHGwwZwz7RR43ekRmlAu/YVAo0KE/f+9qLmtzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChGQ3kxbqGfb2vglR6k36zPXD/zlepowJNPSxRLCiOijjCPCbCrgfWrie6iTp/PgFpKoaalBWsLVbLlf7OgUeTOIY+F2tZO1GOu3b0B8jf/Rqr70dPorEWAF+DgynxeaKxpDktegDx7MeRn1Twban8gbrsnkWY1ZxOpX8q5tV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzXH8CdW; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzXH8CdW"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30ec3dfbcd1so209960eec.0
        for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 23:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782628568; x=1783233368; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q5XNx4q7Z6p8WGo2M6eIxEnOXOYIe6d/zNN6spEqUvI=;
        b=dzXH8CdWbU3ilGhhaTTxrg88yNx0Qsz4CjuDJ7HJoKoOXTBF5GVYdeSxsQMmWivYXe
         XsIef0VdCKGsmugLg1d4UsYYrGdEy6jgxMJvRMdkmQ7aM9s9GqqYQtmZHZmPsCQ67fIa
         1rRp/6Yky2obCC2zJ6tOcSptOtGMrB8wsW7cv35AXY64PS7yGZEIOowLtbS+beAFIMNF
         bbBPcZYFiW8rDjLZlt6uuKBkRPybYebuyq5wPfSqxTdGTEEyD63VgE7jR/1PXrOQTD5H
         vMjLuEfWHYDFV26LxwyTNE0gd8c1OSA+txrJuVnk8Y67uGBtt54c+53Kb2xZhowyX/v7
         x/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782628568; x=1783233368;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5XNx4q7Z6p8WGo2M6eIxEnOXOYIe6d/zNN6spEqUvI=;
        b=lHwCleXmHBdAM3BNqSYpX85nqZndaaO3NYIipFCxVx7EsiLSqBvOuZ41yrgf59jMjV
         x3FcF/MkV4vifvp0ANDIaK67VnuNwc1votkuDhzVsjzU+H/n9J7CEc7e7CLxJxRfbmGG
         cDYHFRPjNPchUXSD2ujCzP2eIFnOEB1Uu6QiWIV7aT1+wJ+zrMRl9IdJQGGqNyXPqiAZ
         ukukEpRtF5l3DzsSi5m04D+3Gp7Ju9hqaaOVDl7jmOMpaCdJI0ddwEdG1I8bWJOZttNk
         8UNtGAn6lKjt8JUuTlLIXJiEy/h+L/FjrRLFaIN0Q4GgE6xhpZzmbEv4f690KHTRc89M
         wvTA==
X-Gm-Message-State: AOJu0YwGqc9d4CUEby8CcJWtBCgaCMkXnHd0+nq4bfLF4KrMCvSWbD9q
	BhrrfA7DgtbyU4GU91TCcQGLngcv9DUifC9t8Bx+9o3ZDy0M1DbmA/BCQpzZeg==
X-Gm-Gg: AfdE7cmhzKKTcJrKRRPHa1XNbsOuwsEMuSqghYAeg+sZ/e60pFnv2hu0NL7pESGQpxB
	/Yb2Meaf/SQw6wsmIsOWDauRlv4Jb3WBo2amYq9zdQ56TbZPzFvtK+MFOiydAvo8PnlvHITd3Qi
	P4nAvISMySj5Dv6XO4hVXksQUa17T12dLk5JTUEH6l8PK3VX1GfsU8h/IWJTpwqOiCrJiZQ/6ne
	C5ZLa5ij2ee/OnKIvBjB5B7iTxZpUbu491kQH6jA2QscKZ8ZOM7/0HzHXnLC4VFZGw131NYFqn+
	OjWVgnftNOlHNt7a1i5asTu/MDYmrE1TkfpCcyV2vcfm2w/s6n7+Wf2YBXxrq5vHf2gDMYk4rzQ
	uzsv/0EkN3o6PQLUOWMp4Yn5gMsrP/XqTwiSY0YXnzUS651bBY3bG6udBSK4ReuwajGXrzCr5Hc
	NP7zxX56rFiLU0I+qOrGI+ewUdOFWm6xBPawdAWfo=
X-Received: by 2002:a05:7300:3084:b0:30c:ab4d:382a with SMTP id 5a478bee46e88-30cab4d3cc0mr6329645eec.44.1782628568353;
        Sat, 27 Jun 2026 23:36:08 -0700 (PDT)
Received: from computer ([2a09:bac5:3b4a:8aa::dd:15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ca5f14f8asm20075142eec.6.2026.06.27.23.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 23:36:08 -0700 (PDT)
Date: Sun, 28 Jun 2026 12:06:02 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] riscv: stacktrace: Implement
 arch_bpf_stack_walk() for BPF
Message-ID: <akDA0mbLQhktZNe-@computer>
References: <20260621144259.288135-1-varunrmallya@gmail.com>
 <20260621144259.288135-2-varunrmallya@gmail.com>
 <20260621145658.C8CBD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260621145658.C8CBD1F000E9@smtp.kernel.org>

On Sun, Jun 21, 2026 at 02:56:58PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does this code need to resolve the ftrace trampoline address?
Yes. I forgot to add that in there. 
> Looking at the generic unwinder walk_stackframe() in the same file, it uses
> ftrace_graph_ret_addr() to recover the real instruction pointer when the
> ftrace function graph tracer is active.
> 
> If a kernel function in the unwinding chain is traced by ftrace, frame->ra
> will point to return_to_handler on the stack. Because return_to_handler is a
> core kernel text address rather than a BPF program address, the stack walker
> might silently skip the caller's frame and miss the BPF exception boundary.
> This would leave the context uninitialized and trigger a kernel panic in
> bpf_throw() when it validates the missing boundary.
> 
> Could pc be passed through ftrace_graph_ret_addr() here to ensure the real
> return address is consumed?
Addressing in next version.
-Varun
> > +	}
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260621144259.288135-1-varunrmallya@gmail.com?part=1
