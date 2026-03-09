Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18E396B82
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054575; cv=none; b=WsHo8lr3OfwblZ7JnyJWXT20VAcKzCfBr/fGmDqzHHxBCOnJaPtXK0VVd4lltbiwM20Xy2mPr7hNnPCBBrJVLX1DZQ+1n/Eqk74gqJcM7x9/bfRvDpzutoMHdIJb3+I+ApRjw7vq2hGWvxIS7kJ2n8aj6M1OBEi5Z9W1Xpa2K/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054575; c=relaxed/simple;
	bh=mlB8qmzpghjkcBf2jC3IMZmhP8FmCGFD29j68Ajp3Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BottE4oBDa1Xg4nVzjEqyZhwxMMD80F+BNtB9vSxNGZj0rql5cm2PuNFbHK0JMQFb+BG1egTZc6blAA+QXh26UlPF1ZJ/Mil5LpYMIZ1HfKpf92XF0S4TZ0+jzW6XGmLdpkyj3+a9CmFC7MclbwdPRybIqRiqLRMaWh8glZaQSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jezcy0lB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jezcy0lB"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852a8482fcso22187205e9.3
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 04:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773054572; x=1773659372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TAkOhHSMZTrDASu8q5NwKTyxSRAs80hErF+Sb+YPdeg=;
        b=jezcy0lB8/o19JtaFUd8QCuHwBJpbbf4vrg7B7TrW6uk0X41J02L/TBor430Xroxpe
         50aQkuG6nIKgKrnNciNJ1RAze5fUP5BQaZNzXFyllb5fX59AatZci6DR+rTkRmX9HQm5
         dzqjJKzoPgqSbkrZ3UH5Mq5QvssJULDKkAnMx83pPMwF1kDjpovFIjTb9jNhuPpoiUez
         AepTzX0YVdNDgIuyHfTYzURzLS/RlT2e845pA6lAdgCP3VImyMsbFZPWOOUVHVJNz2Yp
         y6CS19uxETN0lGmEjcUP8ZZ7kiQKm9SUvOwQub3mMJL96osPmRBlgIbGy/AMBx/UMheH
         F+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773054572; x=1773659372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAkOhHSMZTrDASu8q5NwKTyxSRAs80hErF+Sb+YPdeg=;
        b=VdAV8bqCYYGSIZM1tV16TKiBPzEtak8yqupvSHg3ddSxQdwepXi6cr5i5gF9MxMdV2
         vOHYKe896sb9PF8MfA8qg6KER0OUmFSeUzF+/adxdjLa71dTq1usVODJWo9aHjMRCD57
         J1R5jXg8QOxV4hBqoDZvW8ZFxILjAu/Oy3TZS5mq3VrbC0UeYEc2aScsk1OJ46+mdqAi
         YT663jLL1NamF4XuV61yo/438kgmw6hpen0tWd7VW4mLrquuO7kIRQF9uLwtzkiMrLcS
         N8gSqQhE+nwyIJsQyN5Twk7rnVZqvbyD6/6HVMleh6rNuzFehTvTkIV3SvM91yTeJO2S
         2/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCV98Q3L1cU/XEAdBBLsA4Bn5uO4F0yNKcEVPZG+bs22V9Cw01F5WAMbwr0w0nvGxtaEVps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0e7DIt8y5+tf5vkDFGecWEJEnAzsRj3erMVe/j2QUYOMLkr7Y
	k/Y2qeLZp8SeAx5NZF7Pt7a3XdBcWDzEcLAfxQkfORKn3KKJaj2CgOoI
X-Gm-Gg: ATEYQzyD9aFv4XHhSQjOyHXoQ/ogfdKtljBVrS7WWgJBS05x3ehEhkK1caMUovLEhmz
	uGZ9FOKbK5ahnktEvlks74EM8JJ5p3pmLvcEmtHLbREqd7T0vUQLFYiPDXyJQelmW3JSQ7LHY2v
	ZJoI9s3R7RMIUm39tzD1M364nKzQxiW9gvAYHEAg7kXggyGERxwLPqthQ3UD3r3P0+VgF0mtr8j
	O4AR5NVNyljRv1a4NCvVwyNH3/WE3lvgbnrkKRjJMPu1SUQA/2RDc9+d9UT7n9jhW4VZHKMfAHd
	eOYnX3yPJfj4BEkWeraCmzfreFD3wHWnWbenl59deDpDB6g4xFZ5ovppJ7JqTFLxVAwFjLPstCJ
	ML6hvY++763TFmnu6CRZmW3p3P1OQy5HzJA4cWAaVyK83hD0o9hYn2m6Ha0i+Af42Dei3TCuJVi
	D5r71H5q/btWfuUm1Kazvy2+LhnxjNgQeFHyZbcF10RQHBV4SuHSBT7vqGY8n4xIF/L/iAnQsSn
	s0T+i6LJ+0+rmxYboNGUiJMyEwDUWrO3meRamqsNL63wUU72W1WwZPIS5JX7/TFEcZRucIrAzU7
	TOwYvh5hPCk=
X-Received: by 2002:a05:600c:6384:b0:485:3026:2b8b with SMTP id 5b1f17b1804b1-48530262d83mr98771515e9.29.1773054571718;
        Mon, 09 Mar 2026 04:09:31 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e004d45b0158e0dd203.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:4d45:b015:8e0d:d203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b0adasm235611045e9.10.2026.03.09.04.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:09:31 -0700 (PDT)
Date: Mon, 9 Mar 2026 12:09:29 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrea Righi <arighi@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Avoid one round of bounds deduction
Message-ID: <aa6qacWKIhTnW66e@mail.gmail.com>
References: <aac2GMpnpoAKD4jX@mail.gmail.com>
 <d9c98aac-6c4c-483e-9e9a-0659dc03f9e7@linux.dev>
 <umlxk5jo72ii4efzcethwcwtr7e4scq5iicb57huuhb3qtvcuc@xhl3c6acyzga>
 <ff92fa059a5f5427fec24be6758afa033ee43af2.camel@gmail.com>
 <aamB3iv2njtHWgPB@Tunnel>
 <6fze6gmkwsw7ph7moafjujufjpoyr5tyfupzcbdrk6bpqzoisa@dqohjosm7kas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fze6gmkwsw7ph7moafjujufjpoyr5tyfupzcbdrk6bpqzoisa@dqohjosm7kas>

On Mon, Mar 09, 2026 at 01:52:47PM +0800, Shung-Hsi Yu wrote:
> Cc Andrea and Emil from the other thread:
> 
>   https://lore.kernel.org/all/20260220190736.230329-1-arighi@nvidia.com/t/#u
> 
> On Thu, Mar 05, 2026 at 02:15:10PM +0100, Paul Chaignon wrote:
> > On Thu, Mar 05, 2026 at 03:10:00AM -0800, Eduard Zingerman wrote:
> > > On Thu, 2026-03-05 at 14:54 +0800, Shung-Hsi Yu wrote:
> > > > On Wed, Mar 04, 2026 at 04:48:43PM -0800, Ihor Solodrai wrote:
> > > > > On 3/3/26 11:27 AM, Paul Chaignon wrote:
> [...]
> > > I'll probably continue playing with cnums at leisure pace.
> > > 
> > > [a] https://github.com/eddyz87/bpf/tree/cnum-sync-bounds
> > > [b] https://github.com/eddyz87/bpf/tree/32-bit-range-overflow
> > 
> > IIUC, your current patch doesn't maintain a cnum domain alongside the
> > existing abstract domain, but instead builds it only when needed, in
> > is_scalar_branch_taken. Would your long-term goal still be to replace
> > the existing four ranges with two cnum domains?
> 
> Borrowing upon the above, would like to about ask about the work on
> "avoiding inconsistent state with is_scalar_branch_taken vs
> reg_set_min_max difference". Is the current plan to address that once we
> have the cnum domains?

IMO, the two are fairly orthogonal. If cnum is merged first, then it may
help reduce invariant violations a bit (?). If it's merged in second, it
will probably improve is_branch_taken's accuracy a bit.

We're preparing a patchset with Hari (cc'ed) to use regs_refine_cond_op
for is_branch_taken. It should fix the invariant violations once and
for all—they're a pretty big syzbot sink at the moment for BPF :(
I'm currently collecting test cases from new syzbot reproducers and will
send it afterwards.

