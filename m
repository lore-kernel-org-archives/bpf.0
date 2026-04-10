Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C919CD1D;
	Fri, 10 Apr 2026 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775825596; cv=none; b=eO9+IWyvmhDt1SdhC4xA7zjV2dGAKhM+1pLNl8XE6ncL5NKPpHYHFsrnsfMq8naWvkEU9BMIbDb/YxDW1b8F1ZKN24ryZcOOyPsIMOs22FF1RwOPnfyX7r92Vy28MadPx/X37GzfSVSZh8GEJmK0CWOrC7vh7XgsElkiEHkxPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775825596; c=relaxed/simple;
	bh=78eO/RhEGzQ7R+UACmqqoYhNnqZ+OTIjMLHiGzmZez4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEA4hbggTOI3ELkplXQj2bssj3ifFwBn7Q+6ZltBp16V4dJJTHv3heDPKeZId4Xk6sZI+u2kGQEGs+xGCrD5I/NwXTWhv2FWvArl6PKsq57cpFg3EP9Bv0WgbubGVczAD7Sc2qX9UHASlPPZbqZv7W1imZgNoeOtaM3wMSyu+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qKtFLnER; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qKtFLnER"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pjl+6brdGuCJE8FILPe3GaAjxEZMhkcWUKGm+oI58gg=; b=qKtFLnERmT1d15r7x1DF3Gqjmu
	U4sXEw52jSln3OqBiudR8SK6+/CsPdksjxEbsrd3z28jkxN3q+Q4ByNKB7j8tLyuJFqJfQOIou8XF
	VR4apM88VPV6AsFQY6DFCEu4OF3y3pdYixvsgEtqpNu9YUCvegOnU1QcD+szIgsbaDwpEst8fLW67
	tQQCciOSEPn8+dJ7/khhbVzMQWyGRbtITDoWfkhDgPrY0XxSLFu+f3+BMwcUPMOoEgVj6YKVOKoNw
	eMsIGJhFs8cgxRwZOBWdD//zPWFEvMnRLvhbeU7X/Ag8v2SIGriC9l/e//XnG4t/pEBVH2Nr+hLUR
	NkUkBxFQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wBBM4-009zVc-2F;
	Fri, 10 Apr 2026 12:53:01 +0000
Date: Fri, 10 Apr 2026 05:52:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, metze@samba.org, 
	axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>, io-uring@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/4] net: move .getsockopt away from __user
 buffers
Message-ID: <adjvoD9f7QaQMu5K@gmail.com>
References: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
 <adaJqy6Q4L7c-eTs@devvm17672.vll0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaJqy6Q4L7c-eTs@devvm17672.vll0.facebook.com>
X-Debian-User: leitao

Hello Stanislav,

On Wed, Apr 08, 2026 at 10:02:36AM -0700, Stanislav Fomichev wrote:
> On 04/08, Breno Leitao wrote:
>
> LGTM! Not sure what's your plan for the selftest? You wanna keep it
> outside or maybe repost v4 with it?

I'd be glad to include a selftest. I've already developed one covering both
protocols in this series and can respin with it if you'd like.

Test available at:
https://github.com/leitao/linux/commit/2d9311947061f1baa43858f597dd6c54d7ccc5d2

> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks for the review and guidance.

> I'm also not sure your unconditional 'copy-optlen-back' will work for every
> proto, but I think we can put something into sockopt_t to make it avoid
> the copy if needed in the future.

Good point. I'd prefer not to over-engineer this now, but keep it
straightforward to add later if needed. This could be easily achieved with
something like:

  typedef struct sockopt {
        struct iov_iter iter_in;
        struct iov_iter iter_out;
        int optlen;
+       bool optlen_dirty;      /* set by callback when optlen should be written back */
  } sockopt_t;

Wrapper becomes:

  if (opt.optlen_dirty &&
      copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
        return -EFAULT;

and the protocol callback would need to set

   opt->optlen_dirty = true;

I don't think this is needed yet, and if we do need it, it would be better
to review and commit them together, making the rationale clearer for
future developers/LLM agents.

What do you think?

Thanks,
--breno
