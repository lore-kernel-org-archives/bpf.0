Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F29F4FA
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773879217; cv=none; b=EaEY1Tn86mNdwy2VNk+mcLiCvRl9EZ6qQ8FZ+NI+XbaCf9G/qfICDh8O9c4a0i2oEivkzj5ouxiQD8RTY9VVEfMs+frEaINm4WnL0o1mNaM2cMyOvDc3IZnfK12snjZSFrBwa4mCJUKxUfd+hgS06lHv7kFxJiZf78HPiSjpBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773879217; c=relaxed/simple;
	bh=5g0VK6kme5wwsUqScUl8PiZ0gV3dvNzHnThH+4tbnxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pc7Wq7G3bO5KNVYga0awjSkGOcmgDxyeEwgBtmqC3RqwOlSd1p4jHR7nhjFMQEktC0AiGO3uw1ppqpiTTDo6JC+2ClvFRZOV+AgUbsIi0iqM3/m+83GciU2e5X1CARvspkeCq30tWnSDCk5CuHfAyhKByXbOUi3COAlk6AVt6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2aSrFWs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2aSrFWs"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so2848685e9.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 17:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773879214; x=1774484014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NmDHJ5jHSbWD6gmyIdRsWl5EzP5w1MjcT+q6BrRMB/g=;
        b=T2aSrFWs+0pSapLJXzDE7GMXhnWZPyDpGJpJhywWjXggkTuQB3ODJadwbjusUoY209
         eWWyDu6O7ODmmfSG8eUqCuYFplyrjuD7k/npwujPy1xm7VnXW80uCgXmQKVRrEct7/8x
         RSMTjmq3vNYRcruRg56NM4mclLn7yHnQgBfTNwFkCB+6q+1YlqxHfzAeEwgtR8JP68Id
         qEY1gMLaU6xxM66ma5m8mCbyRKX8QONq7Chh4ufKtt2Aqx8JG/0yi8U0OZlOjtYch8C9
         5LtSn7FHDlyJ5J/i2NYjJU6TRsMgVAV7bCz43p5PegQsfE0flA92HGVXHUAZ+ayWwzW5
         dQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773879214; x=1774484014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmDHJ5jHSbWD6gmyIdRsWl5EzP5w1MjcT+q6BrRMB/g=;
        b=J7nHC5hXOGF+U7wLQnRLkcs4fQ6hJBRYEcUEydyZl+zh5cYevYUcnqwxOR6r3yztp0
         jSCJyn//I7OeFHeb87HrZRPspJcOrWs6dD2390EUSth1nKYcXb62cV3+Hw/unzoidBuA
         je0tvMFPcE9T0QF/OMCvV1wEglKG9176Lz5aKqVE+3FuD29Ng9J3qTmh37GgXrr8UoGj
         sRxeVid6fJPdy1yC7TaerLfM8DHAD+zmXN7SEc34vfpk3LARcJTEKKDYdUbyhEBIJqlN
         T0oLQskCdxKQwc8R4EGqXM9T8xnS6Viw6+Rb87Eeg7S8kv0LRk677y5BgKcpt6/gIMnl
         MymA==
X-Forwarded-Encrypted: i=1; AJvYcCUrjqTMRteoT7nAqqy+gptZzOYPO8rVlcvWNzc19gdzJvCDirVgADG91jRnf59mGEFhsQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7FIEXqZNbKr9Xbb1xZD8wLhlMgrzJ8yHoXxhvIDlU5AZ64FeP
	uOmtcu6tq+E0cYNDjwS5PbEFNWNCSKjg248Kidq3MA5KYocaN/AIYjMf
X-Gm-Gg: ATEYQzxShGXMXh+jGldlf8zK8hfg2x8Joy378Yazz20xHlKoJy8B4NbbGPKzW+/Ob65
	rYx1x2QhVRvcyR400o7fK1Xf/J2d4I+jAJs88+3yg5pY0I0xa72VR4x0Sz84fs/g7gEhtv2Ezpf
	TcD/pJ9XNXNVv2p/CPvNZUpYTICOkgG1g86QF06Xqy5onw01htxZLRgQ8rGW/b5WGokTNr4yQ9N
	AgNKFQB7uW/GCaN4NfDKaovB/Fnww2boOnPWtcj7/f9JsnBHw8CMie9J+4YTbOXxkYyNLsQ+Whi
	HFw8N8m+diagQ9gLOSXFtK9NEQke9Xa5qO0qzLqrfxBEU5lzvuVSC5+Djs2xmPhLq1OX58z65kA
	P5bqIvGu4YlZrZpNM3ym0TozS96xEkR7Wm3B7pV+vIgBvyOFQbdYkjFykRu9zsWFmltYpPNMlKT
	t7wd+zryBiSKWBxhR87Ck9n4wjDTd6i9m8BUIi50mrNRRO32kWXfPtnAy/aeXKfCKfSOjeOvhCk
	rzh9z9dNh74H/R/wKq23UF60CfThQ2dg0ENYmBlBKKbBEMxyc8nio+qEeTSk0qXjHK36r3joXK+
	NYLjR+xS3HI=
X-Received: by 2002:a05:600c:828e:b0:485:4533:9c47 with SMTP id 5b1f17b1804b1-486f4475401mr89414965e9.22.1773879214215;
        Wed, 18 Mar 2026 17:13:34 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e008f10c8feee10c16e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8f10:c8fe:ee10:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c53153sm28149255e9.13.2026.03.18.17.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 17:13:33 -0700 (PDT)
Date: Thu, 19 Mar 2026 01:13:31 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH bpf-next 2/4] bpf: Simulate branches to prune based on
 range violations
Message-ID: <abs_q7hZf_7vYJDL@mail.gmail.com>
References: <cover.1773441432.git.paul.chaignon@gmail.com>
 <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
 <a41262218c37af754dda48811b3a165341c92028.camel@gmail.com>
 <CAM=Ch06pLOWKx4D=sVJ5oqCCy6R_N9Lxv7t-UV_yQCjFhBtO+Q@mail.gmail.com>
 <7a9255803fdfef52d86c257ccb00d3b1d37de5cc.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a9255803fdfef52d86c257ccb00d3b1d37de5cc.camel@gmail.com>

On Mon, Mar 16, 2026 at 10:09:07AM -0700, Eduard Zingerman wrote:
> On Sat, 2026-03-14 at 01:01 -0400, Harishankar Vishwanathan wrote:
> 
> [...]
> 
> > > > +     /* Fallthrough (FALSE) branch */
> > > > +     regs_refine_cond_op(&false_reg1_c, &false_reg2_c, rev_opcode(opcode), is_jmp32);
> > > > +     /* If there is a range bounds violation in *any* of the abstract values in either
> > > > +      * reg_states in the FALSE branch (i.e. false_reg1, false_reg2), the FALSE branch must be
> > > > +      * dead. Only TRUE branch will be taken.
> > > > +      */
> > > > +     if (range_bounds_violation(&false_reg1_c) || range_bounds_violation(&false_reg2_c))
> > > > +             return 1;
> > > 
> > > How hard would it be to modify reg_bounds_sync() such that it
> > > preserves invariant violation? Thus avoiding the first round of
> > > range_bounds_violation() checks.
> > 
> > We can exit early in reg_bounds_sync by detecting ill-formed inputs
> > (using reg_bounds_violation itself), and have reg_bounds_sync preserve
> > the invalid bounds.
> > Unsure if preserving invalid inputs is a good idea for
> > reg_bounds_sync. Or if we should be
> > calling __mark_reg_unbounded on invalid inputs.
> 
> Agree, early exit is a good option.

Thanks for the review!

We're preparing a v2 with this change and the temporary registers inside
bpf_verifier_env.

