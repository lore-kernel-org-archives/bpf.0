Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994A3644AF
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018082; cv=pass; b=Ygpbq7Rc3FavRsjAP+8IERI1Dxnuul6YavrE0dOS8B1iE5Lsu6qThD68C9e9nDka+kkZEvsckQvxBz6a3l3nI0TOC3Mply6xmc5jDnXzB8equCJloZlUkDQRxjwPO3NIF6Pq9uHykwKxrKOtxzzUKBBMKc+MmrAwucxO8ugxuOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018082; c=relaxed/simple;
	bh=SSmU4KFIykBxo6FySs6q0GKem+cafJaj8Xh8Wg5ydJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9+Zz8owYlUw2f4B90FYPWdYTjaR4a+hE+UlHzKdeBvcyOSuPU63R6/Jk7KruN7niB9euryZAZyYII3BLXH51uUo8GVCq+b8t6q5OTPer45SOThJBdEa5/WrAxyQvymiHn8O9z3eAvYX1vmy6m5ZOr92JKjp2Dhze8WtSn/9wrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zX3bvHJQ; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zX3bvHJQ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5014acad6f2so7421cf.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:54:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769018077; cv=none;
        d=google.com; s=arc-20240605;
        b=IwdRQuD1FhB4hjLF6aHc0le3L0njzKal31iu+QOVFNsFLYANeuVrfNQPGzf0WO43iB
         kM46g7CDQrcFYzIih+bj+lkRzttsTxN6c2ReN+LxqhbS4Qt/zW2Hrva+nEIJEak+0lDH
         8A3m0MRtI2p46cR36FpQ46Gg/fWS1gyK9J8UXbPeGXqmwMui6qewJGVElAqA/SC24SCU
         G0EbSszG8SVhKjNjqv+FOChVPWfWY8KImDgV7FpSAkAnODe3+qKpalpHS0+qlBNgdooa
         ZfcaiACBFuAwKAKP/q56dbbJzZmilVWc/8KsDZ3h6AJHfW4MP8Qd/Kxz1biAYI+WCAG4
         EnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xH16wCmi7yX9t7ufNOPGVV4N0WTciDc4F9eI40Y8JvU=;
        fh=z+J0KdxotliIbL6A6GXfHfQ5Gm/yzMvzgiLGfnarvAs=;
        b=UOSEQuQ8jUpG+r18nEoMIA+i5n8ynqkk6bmnMxOKIxkvCVJHa8rNHGXRtrnUdPxTie
         cJzE+LTHFw8VBLM20a2yvQ3PiqWA0LjPIZqXq3J49tGNWgKKzjIW0iqOJsR8WfmOHfRw
         n+rqU+kjDYDePGyFSiCX5/Ls2HQ7JSGfo0dlLMF0SQYoDQGBSO7THxKRemBhIfcDm+Qj
         bE4wRhJBrD8TMPu64xb/zy13YJF+cJn5jodVTi0dRh4upmMKSm+Z88Ttmwy9jNyLQj6Z
         +FZT2qVrWBrQ8cWaDh7DU7bc/NUb0iqE8CZzKfMmMucxCh3InZ529jCuLfBEuO+XXzSm
         BqDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769018077; x=1769622877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xH16wCmi7yX9t7ufNOPGVV4N0WTciDc4F9eI40Y8JvU=;
        b=zX3bvHJQHsGYDnllMtE2/gJ+NIpmd4XxlmRabbyW/mhqopEe+gEZ8rgjVQP6nzyeH2
         1zkeHCm9+mzwPzfb5WL8L3sGnh/0QKrBVE+Rgpyh/QzpP6rsPC2juq+Utl8C/HGGFf41
         CiGfruW1zYHBpa9UqdIsn3wecOo67dn1P3M7UlvTq/LMnPVOGgwa0ieYEPC/cgmiz5RA
         gf4+O7oAts2f4sgWZgAPS577/k643MErRYf18SE7QYmXmSpayOrYqYc+fRMh40RBlDvt
         7dKLMCHYUKz6XpO66Gmn1kUZaN7P6EGvQwQ7gsdpxxzIjeO+j529hnm6yzbmGtXY1nUK
         XKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769018077; x=1769622877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xH16wCmi7yX9t7ufNOPGVV4N0WTciDc4F9eI40Y8JvU=;
        b=JOvDUFcDdy4eIZK2ZijMBfXWQprtI1KlfmJgjQpOhLiLIbfAxBQW5UEDuyUP9wMfA0
         pETqwUhlV6NN79ff1xv6eZzbAycOE/GM9BpxHzsWj5r6Bn5BdY4eJVXgIEL6Vu0CG2ce
         4eS002ZNwhr+5T9hx8ZrwmXHPoh4rmjY41Q8cJqe08wa7zPQEb0foCjTgkpBIjWL5LvY
         94m8cMrZmUtNLF7VFzFJjb1/t/j/7R80MgNWzfm55YATvfs4YkrPaXJNruEsYBbLfu8Y
         QX/W0ri+VRbs/q73iT9PbXjTQCMmNAVKA+wlyDiSm1ZvTfcx/rEcNDPlheEqNoGpKDEc
         w03Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9P06cbl63YMUBvM1MH0FksmFHT1nNOiS1LJGdj0GoCfb2FJ7hdGi3COgCCp69grg7Fc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRgz7WeFHPXGJXyuM3KQJUACj8qkJe5XfTQpik9hTof75B8L9G
	CegJmKCZ9G3Ye9D4bbsSp51Nc5kQP1Badd04CNYZN78zKkI4D/0/9PWPWX1oRfZKAEOixPRL8Eo
	X1bqbQFsjj+5BkevHr7hlCYKfsQJlE494gk3fwap8
X-Gm-Gg: AZuq6aJQSBUWGClqXGMNWxmFRo3274MCfSzKEPAcXBY1uebkPB8W1oHWu92iiwjd2zv
	yebGQ/Dg6W8qGgaPuwqvDYYI/Tnvo/ZAHqDADFZi+mKKZ49yz9Mtw3F/iZRILxYf2KfYBusv0JT
	YHXQJUYqvxSoQwHAdREvSSjTHn2/OTljFZsNc7sqOHJyAACzJkZ5x7Cx7TmbC2+YsW9gwmrhODu
	9jo0lGgFKuFZnkDbdcC2t2LLzvCWxX1LRI+REV4lx3W9u3hLyxa6jJQnniRYtBNl9acx8s2Kmeg
	m2OLkkXKQ8XKhxQUEVkM2EbsUbLZpNZvPQ==
X-Received: by 2002:a05:622a:1392:b0:501:4eae:dbfc with SMTP id
 d75a77b69052e-502e1a8066bmr12579381cf.5.1769018076530; Wed, 21 Jan 2026
 09:54:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-15-5595cb000772@suse.cz> <dxrm4m545d4pzxmxjve34qwxwlw4kbmuz3xwdhvjheyeosa6y7@2zezo6xejama>
 <6a814aef-7b81-4b9d-a0a5-39f7dd7daf3d@suse.cz>
In-Reply-To: <6a814aef-7b81-4b9d-a0a5-39f7dd7daf3d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 17:54:24 +0000
X-Gm-Features: AZwV_QgoKQ8T9fdP0Ka4mFnfPpLd-1PHmliqOQBpu_g2EWtZ_-XqW6Axzna0iU8
Message-ID: <CAJuCfpHRrFS3a8=x4shoNXHLtmvkFgV8xASsQL0-hiUBb-O1Kw@mail.gmail.com>
Subject: Re: [PATCH v3 15/21] slab: remove struct kmem_cache_cpu
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Hao Li <hao.li@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 2:29=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/20/26 13:40, Hao Li wrote:
> > On Fri, Jan 16, 2026 at 03:40:35PM +0100, Vlastimil Babka wrote:
> >> @@ -3853,7 +3632,7 @@ static bool has_pcs_used(int cpu, struct kmem_ca=
che *s)
> >>  }
> >>
> >>  /*
> >> - * Flush cpu slab.
> >> + * Flush percpu sheaves
> >>   *
> >>   * Called from CPU work handler with migration disabled.
> >>   */
> >> @@ -3868,8 +3647,6 @@ static void flush_cpu_slab(struct work_struct *w=
)
> >
> > Nit: Would it make sense to rename flush_cpu_slab to flush_cpu_sheaf fo=
r better
> > clarity?
>
> OK
>
> > Other than that, looks good to me. Thanks.
> >
> > Reviewed-by: Hao Li <hao.li@linux.dev>

I noticed one hit on deactivate_slab in the comments after applying
the entire patchset. Other than that LGTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> Thanks!
>
