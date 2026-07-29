Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4F45C717
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341329; cv=none; b=atIHbENhTM07Yj//wiZGSrKA9CKkCswt5NrnWuDv6eoMFIwrcNlTUYAGOeRJvwVxLa/LuZT+m/QTxVX7mj9OxYWULJHWk8MRQZf4njroqzFSI9KOKCkqSa3gKImLO4K19vki/yEdro6OrIEZi5Oafjqi2LL7zV/fJZZaBpq4lh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341329; c=relaxed/simple;
	bh=kYKzQHXQeWZGyowPRp9EDzR3wb05wPIoipTHdRklPhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrHeSOBiOf3yYBSP4M0quj+41mfYN9EE1wKWyK2AIf787FjH9EEqYBFYKnRHk/GeUqzNZnmzGP4lGxj782hjIsrNwdK3bsUDWfgtFgYUAWFeB4Y9A4+965WKBWJvbH/fGUhuDDYqMxWRm7+Yjla+78aqNPVeY9TOU4SUE+50I/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvG3LmId; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvG3LmId"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-381c69ad0d9so587547a91.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785341323; x=1785946123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xpR48eIXR1Ci0/Y8C1oaWZVWu8i3+nXBnNEaQ1vsjLQ=;
        b=TvG3LmIdzClsKDp/nJ1EugEL/z6n6qt34GCO2G4lA8h2EUB5j6OMxvzOChUldO/n4J
         WjmwP3M+9VuchMpBckNrSS98ulOMwEnbuUIXXoXNWDeZKjbYtbKsN8Nz9HjVFj2s0SRd
         22LheU5D5wyu4A0v1rsgpJi3L8bBLSlgDYIoxCy9k2zcwEcw1VzULoVCIa1SzxsgJxuh
         muQUFOlsGdk+mRPgk/S+YvqG56CW3Whjxi3Or4eApUIOUxEExgtqruey1DNeg3GGOY1E
         sS/uwHkYGS0Z2rs+l3wgChSn5cM89WykexAIi4UVIf6rlXAcovc3prlM16xQdi4YpKjz
         wiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785341323; x=1785946123;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpR48eIXR1Ci0/Y8C1oaWZVWu8i3+nXBnNEaQ1vsjLQ=;
        b=EU3qXhxjbUBDtuPWX8sKPFpjcpHipnQO/0ARjaGdfgi3hhBgztIE/gtKDPPye5XfbS
         m5J1VmFDtkuXJGwLhx+d8D5v0cG3fgpJjEtvrsPZPztRnHeiAzxBN9xgcXXU2uEHB7PA
         8GLRRO49u7fjuZ0zukGzyCwrByeNZb3p4LbQ5Kwns0QIrBsJZYx0HxRAtJphey+W9Hd9
         oYEkVEMrDv62FIOWBPJokJdr7hxEDbiacoSfWvY7ekjHUEj8Ynd3rQAXn+jsncmJOsqQ
         vni7sToj+6EDoc8Kk4jhIOHX0SBja3NGXJoLoZulfvrta5dRHsuvdIk2j4DVITtPLBpi
         SgvA==
X-Forwarded-Encrypted: i=1; AHgh+RqxvW02qcWY5rUbdHAbysffxQzu9JRNoh27ITLx87qFu2AcK+WrPfYArvaPvmD3cz6p1FE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykoo+faKjbhkC3+krhetzSJI9qrRZhj2s8mfY307K4u7XwiziI
	n1CHZaAHXaIA7QClzbfP9odDJjZdjN6u/sCwHmRATOq9WXbvRkPuk7u2
X-Gm-Gg: AR+sD12AYO+VXg4HlLxnGum+v1COuIOJ0oviad82+0z+fxRybyH5BrATDse0fzw5Oqs
	/DqbcHNlaF4ckWSstuY6OkyKuxA/m4geic9AHUf4NzYQRzlpXU3LxI+PsO73NzzG1QfnSkAD588
	cKnj7Gz1PyRghI8bByyGd6dIcjtzzvZ+jhbqPy6y4LnGnRT8c4SKeGS4XhwItGzD83arUue3XX6
	VFiNUssuQzt1A+r9irF+5I4Yy5FzECNeE/veKTY9i8tRpfMJYAiVoW+fvyN8euHnn3kauxOzAfS
	SHuoVggl7c7CVO04c49eL1nuNyHhhCLY9zmLWvSJOo8GzJ4g6sZtip3nwGtWPbrAIVdLEkEfJ5N
	3BcvcngIFc1VMYlNkn/IGWz3cYoDPsGxojXGBd9BoBhPVmywvoVi19ygObZR4CbUgCXT7vuiPXM
	x1VuP0uGdPmkoF+OpvsoOFrBt7xOFcL2Br4bdh4sNG2tyqGIpcpZcVMA==
X-Received: by 2002:a17:90b:4ed0:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-38f6a373a5amr7799688a91.15.1785341323530;
        Wed, 29 Jul 2026 09:08:43 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f64111008sm2958119a91.2.2026.07.29.09.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:08:42 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:08:27 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, maxime.chevallier@bootlin.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, aleksander.lobakin@intel.com, 
	horms@kernel.org, magnus.karlsson@intel.com, witu@nvidia.com, 
	alice.kernel@fastmail.im, dtatulea@nvidia.com, yoong.siang.song@intel.com, 
	martin.lau@kernel.org, intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, leon@kernel.org, AutonomousCodeSecurity@microsoft.com, 
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Subject: Re: [PATCH net 0/6] xsk: harden TX metadata validation against races
Message-ID: <amolBkuwEasuthzu@devvm7509.cco0.facebook.com>
References: <20260727161959.885642-1-sdf@fomichev.me>
 <amnKVlHTITILY8H8@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amnKVlHTITILY8H8@boxer>

On 07/29, Maciej Fijalkowski wrote:
> On Mon, Jul 27, 2026 at 09:19:53AM -0700, Stanislav Fomichev wrote:
> > Cen Zhang reported a KASAN out-of-bounds read when AF_XDP is configured
> > with a TX metadata area smaller than struct xsk_tx_metadata. The metadata
> > is also shared with user space, so reading its flags more than once can
> > produce inconsistent validation and processing decisions.
> > 
> > Require enough space for the flags and one request field, validate the
> > launch-time field against the configured metadata length, and use one
> > snapshot of the flags while processing each request. Carry the validated
> > decision through completion handling so later user-space changes cannot
> > enable an unrequested completion timestamp.
> 
> Stan,
> 
> I'm taking week off and I see one sashiko-reported issue which is not a
> pre-existing one. Hope you could clarify it and unless no one picks the
> review of this set i'll get back at it next week.

Went through the issues, I don't think it found anything interesting.
Everything is pre-existing, but still worth addressing, will send
those fixes separately.

> >  static inline struct xsk_tx_metadata *
> >  __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
> >  {
> >  	struct xsk_tx_metadata *meta;
> > +	u64 flags;
> >  
> >  	if (!pool->tx_metadata_len)
> >  		return NULL;
> >  
> >  	meta = data - pool->tx_metadata_len;
> > -	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
> > +	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
> >  		return NULL; /* no way to signal the error to the user */
> >  
> >  	return meta;
> The snapshotted flags are validated for size compliance in
> xsk_buff_valid_tx_metadata() but then discarded, returning the
> un-snapshotted user memory pointer (meta) to the driver.
> Later in the zero-copy driver path, xsk_tx_metadata_request() re-reads
> meta->flags directly from user memory:
> include/net/xdp_sock.h:xsk_tx_metadata_request() {
>     ...
>     if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
>         ops->tmo_request_launch_time(meta->request.launch_time, priv);
>     ...
> }
> Does this create a Time-of-Check to Time-of-Use (TOCTOU) race condition in
> the zero-copy TX metadata validation where userspace can concurrently enable
> launch time after the size validation?

For this, yes, it is explained in the commit message:

  Note that only xsk_skb_metadata is properly using the flags,
  __xsk_buff_get_metadata ignores them. Next commits address that.

And eventually addressed in "[PATCH net 6/6] xsk: validate metadata when
processing requests". Couldn't find a less confusing way to split the
patches..
