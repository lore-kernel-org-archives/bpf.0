Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E492ECD1D
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046081; cv=none; b=QxY30vk/J89yMDikjAY6Xk9neH/mDmtpDClNJkUU7o1pneHtEGSNyWzORAQ5fABRrCTjAd/NM6vnCtVYg0QtQO/Pa55zlc9US58ZdFvSNyubCrzwFYTXiHnqAbgft5r016kxRGIqhJzP59ho53FsL99VSwKUvJlcnwaOeTyESos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046081; c=relaxed/simple;
	bh=TVi9AXhLMPnTnGyLiKcf0IUsC1dU0rVXFtU4+M4Kcd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWKsXMUFy37hmCl1lt1KtywQKiXhN8ov3697O+mGAWzfvhbi5X2WaKbxGft3y13ly72fIvt213ZUDNXvLWdIvJqytQwYDePF+eaiaRoiptLfUV+KrR07c1hbB1+3DX0fvqxcO3Y41SV7Qt/oJC+RK7UjhoaEbCzGLYhHzO13V5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhL2W+Xi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhL2W+Xi"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso3056740f8f.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775046078; x=1775650878; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AMiw21os2snzNIGKTIgB9VuujhFz0NgidhbOk6QUkhY=;
        b=NhL2W+XinW/EyVbKZhJKPvSDi4qO6V6JIkvAi/e2hGqdNtB1WiPwgPjJ1N5bqaA+2g
         dDq18v0K2bp2spIC1syX/mAIx+Jlq/wU8zQmD7vmBCO4++BiLoHYzuyUli27VVtaxGdK
         wBBjMOve3TeBQnNb3zTQ53ru+Zk15ctF80vCdDHQteSzfaEeWxH4RhBePIFOaV3EBo7d
         nkIGAyxsrm3ohlGi2aQV3mXH7MxQfRj6sfOB46vXHZOxuxCZXcNwBybzkksxUF3yKpOf
         6NrHfXlaaAGAKK2XDdeJrCvF6crweAbh8ZkiwkzFINeuUqbtsIgiv6wnvKpfmp9IUjOd
         hdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775046078; x=1775650878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMiw21os2snzNIGKTIgB9VuujhFz0NgidhbOk6QUkhY=;
        b=WQ+HKrJBKiwoJKXT59VVz6iL5ByTWIr+Jia8Cg1Pn0hvzfTn0FGWKtSoUnyGevw4j9
         xoQjPxZBzc1OvLM4nF6iJH7FtN/vIVlL2wQtPmELSH3TY+TsA/rDZUSR9BBkzAlQQ+is
         ZkGIf+4mpfzloZ+Ep4H/paf77/KbL+wTG1ZmdnEPUg3AbO81ha4QccuqNL10Yuia1iXp
         Fwp2f3ahDCvUrkzy7PDRuucIpzOk+Iiu/M9OpCQe9zkJgg7WNzFm9ZGZ/Ok/RRAXLMS+
         FFU03IblEstS501vb3XBvySQiX+iTI5ZaxIad08e8qyWv48x5wUVI1gtBdY/8DsdIp43
         G4bA==
X-Forwarded-Encrypted: i=1; AJvYcCUR/F9Q5Gz7WCTxtz+sJVO1mdBKtDuBdrQO8BohxQnp+TJ/lbXIEMgSYPgCixzyDsav9mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQXJRpdpozQj/Ne+l2hBWmPZsonnUIEzoGSh+QP8aDDqxADtfx
	kewRqJHXYDDbCEWIkGCWj5pu4eS+stXVrNNSYFoDOcIHK2/gFlcxz2t3
X-Gm-Gg: ATEYQzyAd2Zc7iOt4Da5/cObJneadERjE8pfX9UXGOjafkxXpFBuULCy/mryCoHRZpX
	LvmgGFSPygB6kh5aEcyuGi3F10wtRokXCbUxkRX6stcgtVoSHnJpOccukWXcnoN1S2bI1YfA2n0
	EbsKPNrqv/Qa5QMRJ0W5aAxvXBJHg1Jw9YfyZuOwXp0galkAKnJt4ijGY6SuX3bXOSAZ98LcT7K
	URY/bF8qb3QInEiWJfNBqYNf46I4SByuxXQ4/7pxgzHwSCHCq3mBR7+6cZXIqKs39ANgPqbnjIr
	FEBob/Yxq1V06g7TFq4eG6TJSTMPEZbQ2+KyYsIi2KditQNB44NW/i0AJY8nkD+PA9MY3FnaUic
	xxZawSvjm4YnQ81cKjg0YfHmH+U6aYTTiE86vToO6aQSEGoAQ0M9gRfw1RPERgVKoxcZ6ZT0ddH
	hhEf601cq8ii2u7bA+eRpwyDqcYdoXobTi9kOEE/5b235nEpnANOEJ07uNaOttgGS50aUdBFAdg
	0sdGHdNRIuX8ug+QwRSN9qq1tvyVWZFdXLOVkGHaLqtDK5Z6IN8bu32TdQS7mJ4ivQHpJhob22Z
	DZU9b1xxQa3Zv1wGb4iNA8gU+6ZWVuN5jE7COXQcX75AVCbffoVKkA==
X-Received: by 2002:a05:6000:1a89:b0:43b:436d:77f6 with SMTP id ffacd0b85a97d-43d150d62f1mr6681399f8f.37.1775046078066;
        Wed, 01 Apr 2026 05:21:18 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0077853c1cf79fe628.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7785:3c1c:f79f:e628])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e26basm33049409f8f.3.2026.04.01.05.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:21:17 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:21:16 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: Exit early if reg_bounds_sync gets
 invalid inputs
Message-ID: <ac0NvOIc7AhifyNM@mail.gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <704bf39f66a98877f66a4982c77cddb42f14fc82.1774025082.git.paul.chaignon@gmail.com>
 <ed85ac25cd315ac4273de335943f9f3a2c1f36e8.camel@gmail.com>
 <CAM=Ch053GkzkXGxNbfE6Xo=bcR0di_DraDPLP-6y+YJ2rQ3DDg@mail.gmail.com>
 <54d5347331905486d367542613b71b09fd81134c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54d5347331905486d367542613b71b09fd81134c.camel@gmail.com>

On Tue, Mar 24, 2026 at 12:33:51PM -0700, Eduard Zingerman wrote:
> On Tue, 2026-03-24 at 15:28 -0400, Harishankar Vishwanathan wrote:
> > On Mon, Mar 23, 2026 at 2:47 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > 
> > > On Fri, 2026-03-20 at 17:49 +0100, Paul Chaignon wrote:
> > > 
> > > [...]
> > > 
> > > > @@ -2786,8 +2786,13 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
> > > >       reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
> > > >  }
> > > > 
> > > > +static bool range_bounds_violation(struct bpf_reg_state *reg);
> > > > +
> > > >  static void reg_bounds_sync(struct bpf_reg_state *reg)
> > > >  {
> > > > +     /* If the input reg_state is invalid, we can exit early */
> > > > +     if (range_bounds_violation(reg))
> > > > +             return;
> > > >       /* We might have learned new bounds from the var_off. */
> > > >       __update_reg_bounds(reg);
> > > >       /* We might have learned something about the sign bit. */
> > > 
> > > Is it possible for the invariants violation to manifest after
> > > __update_reg{32,64}_bounds() calls, once cross domain boundaries are
> > > propagated?
> > 
> > The short answer is yes.
> > 
> > The sub-sync functions, i.e. __update_reg_bounds, __reg_deduce_bounds,
> > __reg_bound_offset are individually sound (checked by Agni).
> > This means that they preserve any concrete value x that is contained in all
> > the range bounds and tnum inputs, after refinement.
> > 
> > But if in the input, there is no concrete value x that is contained in
> > ALL the range bounds and tnum, then an invariant violation can
> > manifest. Note that this can happen in the presence
> > of the current early exit commit, i.e., even if
> > range_bounds_violation(reg) is false.
> > 
> > For example,
> > 
> > before reg_bounds_sync: s64=[1, 1], tnum=0
> > after reg_bounds_sync: s64=[1, 0] tnum=0
> > 
> > Could you elaborate on your concern? Did you perhaps imply that we should
> > be checking for reg_bounds_violation in
> > simulate_both_branches_taken after each sub-sync function?
> 
> My main concern is that we might loose useful signal.
> It would be nice to adjust reg_bounds_sync() such
> that it would stop (e.g. return false, as you suggested previously)
> if it hits invariant violation mid-step.

We discussed this with Hari and agree it would be good to use
transient/mid-step invariant violations as a signal to improve
precision. I'd however prefer to implement that as a follow-up, to keep
the current patchset small and focused on fixing the invariant
violations that cause kernel warnings and program rejections. It sounds
like we may want to backport this at some point, so it's easier if it
keeps a restrained scope.

The "transient" invariant violations already exist today and using them
will only improve precision (potentially allow the verifier to accept
more program than it does today). I would see that as an improvement
rather than a fix we'd want to backport.

Hari thinks we can also use the empty intersection checks he mentioned
in the other thread [1] to avoid/use these transient invariant
violations. It would allow us to use this as a signal to improve
precision without making reg_bounds_sync more complex (and harder for
Agni to verify). I'll let him explain, but as mentioned in the other
thread, it still needs a bit of benchmarking.

1: https://lore.kernel.org/bpf/CAM=Ch05-XWF-x_VzUZAWhRO9eum-bjdutuwvPXEcOvnx_0omAA@mail.gmail.com/

