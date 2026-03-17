Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93837C921
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728098; cv=none; b=hpCqmHzJ/YeBHSAtvZjcdGCdUz9wk5HhIJFNUSTY0GqGv++8Ns7+5Bc9RPRANsjKf8p+G+f4PIBIyBwiKphhX6LHpn3JyxoRi/DCW5TJzOUhKMrwURv7VThPt8TdcgLj97rcYnPvofvhcttMth/2RHuWNb9o//a0KvLAFK5UDC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728098; c=relaxed/simple;
	bh=EpC3Q1uATZdW5DNW7cvSa/4vtrP4tqKheY4p3QcR4cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec79js7nWqLyrWlxN/Vti890PHbtMitGZQnFi9/DAoD5G4wXwLjD5GiiNr/R3Ix6/1Q6CijmcE6BTWqJ4No3EWhvF8p2Sr26ijEGnli8lQJcn9mvLX6M5ndDFU9b+3h0xkE9bDw6QFjG0LQNl0iWRAS6t+1HuWadSISzaRi4+IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dWcYGYWb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dWcYGYWb"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b40003d13so1639556f8f.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773728095; x=1774332895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+5rs/HO0oAQOh2XKtL3EKv31FmtrmeZ6Q+QFspSMEw=;
        b=dWcYGYWbxteT0CMuc+eGtdzmacfxj9/Umq1lh9qaCarBCU8ygueyF3DQ+t/a+g8iCd
         iiOosDUGcxwxwjXZPVtIuNQ9ertn/bJyOYr22bzcw6KktoyngrvEuMZknvStW2q4kjKL
         I/CQ2OXTP4rqTLGgBcfy9qHXLx+SgrwyY+6NOJVaqV9F1/rrLa+3nXEYSpn3obUWzPpS
         QAGc3nTiJOM3Iwv6B99Pj1wBcPBiKPufOeow0fTC0+35avwTcXBTUEXFgP5xdCda58yR
         UXbQgTA62gW7OU4To7kF4/bsUilv3Ln6tZyAzpk9oOZ5cgvdcJURRb54EyzEVmWIeVUA
         BFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773728095; x=1774332895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+5rs/HO0oAQOh2XKtL3EKv31FmtrmeZ6Q+QFspSMEw=;
        b=dX8Kzxckm7h2YoDCH2m3irej0nhgzweO7d/cH7234h9Q9NGFFJmiPKb0Vg23Uo78y0
         a9tQJHRkRf/JTl86DZxuM2ld62JTYV8/s7JFG0iFAt9mf9PHxPybwDzZxtdC5nG8ao+L
         OYd17yBNgJ7PVfScQ36d8RBTOuwjTYmHYonWdBPhTBb/J4GoVqBjEVfbeko4asKY7ThG
         XPBSjA0u9qJUb+rI4fnOpqTttGLAkrNddIsY1X1spdQAMC2UEemcxr9uDexcQCA+YsUe
         pKSLgoH7meFzvmzDaB1pVbJtaOl7VUwNd8fJu7GmsOBxTsSyduirgSwZW0o4b84O7HfK
         61Gw==
X-Gm-Message-State: AOJu0Yze+17kpCiCwcJNo07vJYM9RdRfgLuGsE3Lv0MjjpcrnKliEFG8
	OjNN9in6fgBq44+QK+ayHk7TSixXW+FkVgi3Xi8HobI03X0Re7OCrXAhL2oviAJu4V0=
X-Gm-Gg: ATEYQzxknGPIe2MjlOEXZxuD2ByNjoDuE9/8uZZQ7zkK8fegyZ8lrHDzQG83cQIMKGf
	HVEDeJ50hSOxMcWJ1eXtiBcwiJMz8Qhl6bzyJgxWb4FkmXvSAoQK6jpCssCkkI53s6nFlftSmto
	MGRuQFzZePZOYO4kGLgzHEQ1W9Rz5W4RjmWAks0gEa+WdS8cefS6HQ2LFTDUp2S0RHk7/W9PbJr
	+7y2E3eG8RJMCcSsLZkdgdPUGQl9IaLL0lPpwzrdfST+s0V0qxq+y2tRG9JH0zANReVXpph4Jng
	IOUcwEoQXFzRlTG5rC3aE/7oUkBa+SdjydRrXTpd/LlxB589wztZjGtZpV83aa6I1/18n3j8YNg
	ehZKC9Hlj0xBigVqGtmfvbvqKLr5JixGIR3oJ16UMImtIqlrEDZFGEhsGRgSJ/wFOvQexuxWhd4
	jVi28+LK869Z97sOk7Tso=
X-Received: by 2002:a05:600c:3ba4:b0:485:3f72:3230 with SMTP id 5b1f17b1804b1-485566d936dmr280008695e9.15.1773728095027;
        Mon, 16 Mar 2026 23:14:55 -0700 (PDT)
Received: from u94a ([2401:e180:8d6c:7ab0:11ab:2f6c:191f:b326])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada9703esm1627189a91.13.2026.03.16.23.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 23:14:54 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:14:48 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Simulate branches to prune based on
 range violations
Message-ID: <swmeukekw55emiwcduoq4jpjk6hwqk7nzxbcs4xgw4mir5ldd7@mqyinrubwmlo>
References: <cover.1773441432.git.paul.chaignon@gmail.com>
 <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>

On Fri, Mar 13, 2026 at 11:54:43PM +0100, Paul Chaignon wrote:
> From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> 
> This patch fixes the invariant violation warnings. These warnings

Nit: I would say this patch fix the invariant violation (minus the
warning part), warning are gone after this, but that because we have
fixed the caused of the warning.

> happen after we refine ranges & tnum based on an incorrectly-detected
> branch condition. For example, the branch is always true, but we miss
> it in is_branch_taken; we then refine based on the branch being false
> and end up with incoherent ranges (e.g. umax < umin).
...
> Fixes: 5f99f312bd3b ("bpf: add register bounds sanity checks and sanitization")

Following the thought above, I am uncertain about the fixes tag here.
Commit 5f99f312bd3b surface the invariant violation as warning, but
invariant violation still happens before that, we just don't catch it.
That actual root cause would probably go even further back, but probably
would be too much of a hassle to figure out. Maybe drop the tag?

Put it in another way. If a tool uses this fixes tag to determine where
this fix needs to be applied in stable, it would determine it is only
needed for anything v6.8+, when 5f99f312bd3b is merged. But this patch
probably should was be applied to stable kernel before v6.8, because
IIUC invariant violation likely also happens there.

> Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
> Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
...
