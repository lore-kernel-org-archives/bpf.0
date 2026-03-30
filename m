Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CE2D97B7
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872354; cv=none; b=dRZcmGOI1VFbytsQltX3Kkmy8VF7jI8ZCeGTY9fv+JhnsGJH/B/gEXTVhnfjci93aSORtFpAPnFvgcOTN2iqd50860dj9+gWt6hO3azLeczN79RLD3t502ra6AHi+Uh4BRX2VdBPDb5iyc2a5W/6BIJpZ2P2gBVQQYY7DK/N/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872354; c=relaxed/simple;
	bh=WwfoiDsGXEYee32x6vSfF/i54EZe1Z+Hf22yLLlr46E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3BIAB23cUWLuH630R0oPtJsiOhX7QHPIxIT3jQpYBezw9PVhWxVtaoSCNARZouHXQ7v1DrgQTcsaOWQPiNMeNS23JPl96RQxKOm+bOqbwtsUZm4EooccOmefVk/0hx0zkPz02okYWxLzGuvvkOyLsZTdAKwuJP1YZgq6cRW9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLl/7Dre; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLl/7Dre"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so58556715e9.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774872351; x=1775477151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=do2NCSY/GmE1zYBgGX0yt+76FyjYYoU4ApNdaK6fwMQ=;
        b=iLl/7Dre6iczWfyYZOt1ZBzcW/n1H2rJpSBo9xvXrWMOvv05y6sqFvaO0HvKd5PaGN
         S4plgFy7+EmVbg4jY+4szcPANqffXVhpBZR6YjENynfzeoQ6StMVimy83aZ9hAhKW3kK
         /j6pM4lIUoh8peGtMpj6dQM8uHg9wP75LflaMgsME0r89BDsE+QTlVKX3O+zEn+GdX7Q
         oJ/sDU0XHoeLznCFv5LKhuvhLXqXBa8Llp9rkADo5ab3bDaHdArxEQPWQqDQHeuJS1eO
         ux7E3EnzYKQk5rHxoBY3TrkiN6YxgxEsX8C0ow3E0dfzl/FC2FFOXuo8Fvfjjo5v74zg
         Yo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774872351; x=1775477151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=do2NCSY/GmE1zYBgGX0yt+76FyjYYoU4ApNdaK6fwMQ=;
        b=atKQsIhdysooCOPxg+K6sNygGF/F1rED3jvI+v9zD3HBwtrmdp51hLUeNRH2KSfEqK
         tFfIpn705W4Qsc/nmnE7l+cib7RC2An1MT7Kq7X+aFe+ZQL+v+InBYpbpAqlDs4Ufwyb
         HktZywis4Jbi4vKfb7E1f+zd0OSdHoEkhv1Dhyac5TTFEj26MIF1Y0CiG6MHQNB9jcNy
         l8IKZ7S4JifESBRiaQ9uZwUJVbUrWLM+tOZagPzzrhj0N3Dh3oeD7wHHuda624owlkBe
         QO6HL4gNAul7TAgfoXZCtIJXmhXgO654h4C4DXJe5w8/5EnjC0JREiwr1eKpUwCcGCkv
         kENw==
X-Forwarded-Encrypted: i=1; AJvYcCW/hkA9FKeYUCKqcWsbYLg5Xy2noPyYLkbTwwCnt0XENgO6MamvP3Eee6GZRPvO8HANIMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqL15n19j1Mujx42l1xQHNur7eeWzzqPCK3IQLXphSBHnJxIfC
	w1Q0D1BPtt6aVKbSQFqjbLKs85y53Qht9Rl+LoYlgSL7mukx/mFhAxjp
X-Gm-Gg: ATEYQzx2bS39iJEtGUmXmMCR/WqfJSpiR4n5FZCwyc4ES43qzCEILmwetyC1g8TcgyP
	aQy9CV0YgrgY8QhEktO4nJVW9siEKNQSTp7KKRdVpbTYk7X22243Yimc5c4Lh47PdtpRmOAW+kA
	jIkcnjLmdDds+TTDdgVApkKfn6ZBkSR3k3aYFhHeeLe9nlF2d2sgzi8BDaRJ+KonnN8lcDTFy9x
	WTuXVwkv4qAAunQ7yr8GwdsT3+wsuHUdsJguicXfse4mNLT3UNBJ/oxGo5HMpHnDHh+pmvyOJY5
	fATSN0W+nEev5dkPOZY2od05hlAGcAwrAf+t3e7N4Qq/ADyW7nHp4o+oubbvxqBwsHxH08y/0CN
	M0cK8E4xw2TwjvJ9Utnd3iO9CUy1990m71E9SKcuhdkiwHBleJaHsTH+kxLvhy4ogH1hUwwFpu3
	/M3sVk5RAXmZg5O8kRIk5UCVzzlx6rlP8vWC9b7JoPThPOl0ddvVMcuwF9OrNb7cMZKBqoTzKH3
	JEIb5ekM2i5u8Py+qDB4lPDIEbDI6QYNhNskJjSOlqU0w3ztzlo/1+YFf2EFxQsF1WuZR2oVdbP
	9SknkMONvlY7HVeJnTQB1XB9EPAizW5QWwZyo/GaAJg=
X-Received: by 2002:a05:600c:c109:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-48727ec776bmr154971425e9.18.1774872351135;
        Mon, 30 Mar 2026 05:05:51 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c04fbae8c649ce1c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c04f:bae8:c649:ce1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48737a73062sm39198795e9.34.2026.03.30.05.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:05:49 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:05:48 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: KaFai Wan <kafai.wan@linux.dev>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 2/6] bpf: Use bpf_verifier_env buffers for
 reg_set_min_max
Message-ID: <acpnHDASo5QGw7BZ@mail.gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <9fdf9830803fe3a5c4059341c84a03836105f5bf.1774025082.git.paul.chaignon@gmail.com>
 <33c006d7275cb443b5750f062cb78c38449a7537.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33c006d7275cb443b5750f062cb78c38449a7537.camel@gmail.com>

On Mon, Mar 23, 2026 at 11:42:11AM -0700, Eduard Zingerman wrote:
> On Fri, 2026-03-20 at 17:49 +0100, Paul Chaignon wrote:

[...]

> > @@ -17196,30 +17192,23 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
> >  	 * variable offset from the compare (unless they were a pointer into
> >  	 * the same object, but we don't bother with that).
> >  	 */
> > -	if (false_reg1->type != SCALAR_VALUE || false_reg2->type != SCALAR_VALUE)
> > -		return 0;
> > -
> > -	/* We compute branch direction for same SCALAR_VALUE registers in
> > -	 * is_scalar_branch_taken(). For unknown branch directions (e.g., BPF_JSET)
> > -	 * on the same registers, we don't need to adjust the min/max values.
> > -	 */
> > -	if (false_reg1 == false_reg2)
> 
> A side note:
> 
> The above hunk was added as a part of [1] to mitigate some invariant
> violation errors. Surprisingly, none of the tests added in [1] fail
> on current master if above hunk is commented out. Probably due to
> recent improvements in bounds deduction. Should we remove these
> tests as a part of the series?
> 
> [1] https://lore.kernel.org/all/20251103063108.1111764-3-kafai.wan@linux.dev/

Nice catch! Out of those five new tests, the three "jset on same
register, scalar value unknown branch" never fail if you revert the
commit they were testing, even at the time they were added. I believe
these three tests were intended to cover the above "false_reg1 ==
false_reg2" check and supposed to fail with an invariant violation when
the check is missing.

I believe this check was never actually needed. For an invariant
violation to happen, we need regs_refine_cond_op to refine a register
based on a incorrectly-detected branch being verified. For jset, that
can only happen if one of the two registers is constant. In our case,
that would mean both registers are constant. But if both registers are
constant, then is_scalar_branch_taken is always able to precisely
deduce the outcome of the jset. Hence, we wouldn't even reach this
"false_reg1 == false_reg2" check.

I think I'll remove this check in a preparatory commit, along with the
related selftests and an explanation why it's all not-needed. Cc'ing
KaFai Wan in case I missed something.

> 
> [...]
