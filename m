Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C34279E3
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015527; cv=pass; b=WMo+iRIGkMoZs/tIejdUi+EEicrLjRqGUfhLBPjKNqCrp1BrvVzjnAMByY9QLmtQHcBskpY+Zz0Qfkwxc3PF869xDbAED9t/uviHh0wZbhp1LvV/TNaGw8KqRRfb0+G8704XnlN5nxJcpGYIcRqszpY7BDaizETai+YJF/MOb+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015527; c=relaxed/simple;
	bh=G3m/TeF8223oGiWV8LWrSag7Ph7un3ZvTk2MvPdc2eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRT/PdjdK3uyabpr9JAf/m2kEitSGa3fU3wzq/RY1/08Iiou6x8zBGY5XPsx7wIasBEVpHzhPz5+XhL2QNAuXE4gF4k8YtgRIBvJtD86STm5vYf/G3BIdBTPpYjjbVYb4lfGCThvp+YREvlMVB/eYolOUD19nLB2zkGfK4vS7Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SK/wMSZa; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SK/wMSZa"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014acad6f2so128811cf.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:12:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769015525; cv=none;
        d=google.com; s=arc-20240605;
        b=efJHZz+Ls9Z3aaNRZimTQMrVFg4T5a91D1PRV08Pj8ub5JXfSzE1FSx9Jj+lSMSB98
         7jX46pgtUW7+XYwlC+JP3fN/kYwRcFpITMYpDNdMOiEwV/BfOkUId8i9gvzKdXWMxJ7V
         6KFoffuvO2rryX1ekD+IO/m0DIJD9jka1jAuF/4LDeaOoV91Vf8On7p1bIPHAEb7GS2O
         lMVYeTz8um9Jixw59uzHkPDlB8ONgBLPstGRIbO6Js/La2AHRGMnrmK5kn11e28N7WMo
         OmKIYWW2ZSPKWt3Ywd4Yp5rmguF8x4pqRcanQkj/OMVa1FqccV9K4cB83Qvlld27F2HT
         4D8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wxe8ja7BPp0xudXZUtfCAF8pkuXAFux2AU5rIUV3nM4=;
        fh=wP/Xw0qa7IeDDusGEaVGYwy2ldlBEYECbGnfFghH8MU=;
        b=Y3up/h2ZTnjLl4MWZtDrfzxDBz2n2eZEJSjxQQ/CQYfdqw/0bsH7MXpLkubc99mal6
         e8G2pMmp2yxtSUaD6x+wGzC8azmdswYr4XzMe5CyUTJCVxkfx6e+EsxQMa8jocQFsOxv
         fqNCi+KTLyRWTA4J82CKNDgxc2jPqnP1y5PgfOizvcHjPU1OdevXL0Y+Qav5KD8OEWtb
         nT/LW7blCrBvuqx3At2kG/XN9MvzBgNV9c2gvR00XwwK2QpRLMZ0itassWhzMstzqH2X
         zngRtk5yH6oIQAOmGtlKfQPh6vMtlqUMq1eK5TURnbpEiHOz4isxnJi1F/DrpBnl23c2
         GmKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769015525; x=1769620325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wxe8ja7BPp0xudXZUtfCAF8pkuXAFux2AU5rIUV3nM4=;
        b=SK/wMSZavbsaeS/rEFYGs1Jl1I04nk173nsAJHSE5mRIBquLDnepcCF6KyUjE4EYgg
         KXQqH+86GTbT7cI0Y1oWPSO2salurbIvDOhqEY9g7aVmzA0C3PWIdI8emnWi7u1heWn3
         Mir3UGBzIICHydUJjfZWkJXpTY4zW+vAy+aR1lovidNwmMiBcvdjXVq1/yCxCEJumAtE
         ln/a021rKKUb7C7cCsS6DQs528NqnrIXuYriflf2EY4UI376CC1NlKSxoHZDGXtRW7Y6
         4Ivop87QYQoRUBapUPikF85YlFuJMfQF4Vn2e8fVvH3BTxcujw9UXRAZzU3bhubONvVy
         A5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769015525; x=1769620325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wxe8ja7BPp0xudXZUtfCAF8pkuXAFux2AU5rIUV3nM4=;
        b=bn+y5EljsWRqI7lS0/vF2SuDa2apoYBD/YDT75IWP6jWC3U5CrIIG0tyBH2U1yWab6
         qSAid4ywoqc9Gvhf3VvAXkygncNgQcHGPebOpjc0AwFpxl46XI4Uq4Ijmd7/7rh3BrLm
         PGglDzRk8JCgqfZELHyO9e+zri95bchqjWRRq+mkBt3qcan31E5j0H2LvYqFl413zj9g
         J8EQXvPKeavRqxbx3cSG9VeuMPkFQ4gmZYmUcyTL1uVSzdjfMQ3tN4cMsxG058+n0FzZ
         efFVUuhLeq+1dAygqEkEDO4WDFfM7AnaNvIucQxNARdjwB0ULbwk2bOFaTI2dr3vBoLH
         Iz2A==
X-Forwarded-Encrypted: i=1; AJvYcCV4frnsr7MZET6t8mj3wJGJaawy0DwjsR/zulCPDGtx/rvu/jM5Qk3nDl9B/dOgEHvtekU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5XofohjTmFwPw1BD5U7xmmJsZ9gZSCJlzHuGmrskXnEwrKepw
	pIeBBriAjTOw7v9olxh7ZoHN6pupnDSqTh/yiJTxxfwpWdaW10cd8KkeSYgU0ViiOv3/Qnnh7Ce
	MLQmhR4OK/YDcq7CskrSjaH3WUzNR467zIoZ0zAaB
X-Gm-Gg: AZuq6aL3/qqy1rUUV7UAjDeTIenrZLMByvEK77jDPYsJB4BDjY40ESG+/fE1aNCU6Zr
	h9VW0WHUZ+NEjdjJ071N1nwgXCcN5JqcuBfNLkndAV9wTomrWRQ80QZWUHnl259hyw20+cCwK9p
	Kil+Hq6O8cdsmn/khLEc1Eh6KXFLHPewZNdOIlGoeJSUW2FPZetX4xJGG0WnVVZPp89C9HM9xS2
	QV2zk/5GxlwJ9YjTf119O0cFOzUxjqRPGtEqWeHxcVsM1MIyN4ub+lMbnirGuJpGbxfzSfTjBvX
	5i8DF5PX+UMqbhwrzTfv3ZE=
X-Received: by 2002:ac8:7e8c:0:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-502e0c62ce0mr14559311cf.14.1769015518740; Wed, 21 Jan 2026
 09:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-13-5595cb000772@suse.cz> <veqtpod2liqsi4mgcxndgaiyqlhupnymmj4pquueqziqyakmnk@fzympoan5pds>
In-Reply-To: <veqtpod2liqsi4mgcxndgaiyqlhupnymmj4pquueqziqyakmnk@fzympoan5pds>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 17:11:47 +0000
X-Gm-Features: AZwV_Qi9FJEvRsSrApnNVXPgEwKn9hYifa6IChzrQfzwFnpFd6X3lSwIuICSEss
Message-ID: <CAJuCfpH3DVwK7FqfKb3WChWyz_ZJvECBf57Ehxr7qCzS=Ym_8g@mail.gmail.com>
Subject: Re: [PATCH v3 13/21] slab: remove defer_deactivate_slab()
To: Hao Li <hao.li@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 9:35=E2=80=AFAM Hao Li <hao.li@linux.dev> wrote:
>
> On Fri, Jan 16, 2026 at 03:40:33PM +0100, Vlastimil Babka wrote:
> > There are no more cpu slabs so we don't need their deferred
> > deactivation. The function is now only used from places where we
> > allocate a new slab but then can't spin on node list_lock to put it on
> > the partial list. Instead of the deferred action we can free it directl=
y
> > via __free_slab(), we just need to tell it to use _nolock() freeing of
> > the underlying pages and take care of the accounting.
> >
> > Since free_frozen_pages_nolock() variant does not yet exist for code
> > outside of the page allocator, create it as a trivial wrapper for
> > __free_frozen_pages(..., FPI_TRYLOCK).
> >
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/internal.h   |  1 +
> >  mm/page_alloc.c |  5 +++++
> >  mm/slab.h       |  8 +-------
> >  mm/slub.c       | 56 ++++++++++++++++++++-----------------------------=
-------
> >  4 files changed, 27 insertions(+), 43 deletions(-)
> >
>
> Looks good to me.
> Reviewed-by: Hao Li <hao.li@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Thanks,
> Hao
