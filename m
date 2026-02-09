Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33065318B81
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662711; cv=pass; b=IfrnqnfiNI5y3bFL+0/FLJmdHt7UbRedxM4qwACaVruU19rXu51JVl6IJG7xnSZzNDFUAVKCeAhiIMdI2NSS51MVpjRQAXF4QO7r1lVbF7nb8y5nZqCqdC1m4SHhLIMUcpL+fpQn7u/3/7uQuxpRC4AXiYy6MMdGzxQeS/a6ixA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662711; c=relaxed/simple;
	bh=sqMmVYyUYpGstje1wz4BDAufr1v680Vkae44YBH6/xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8yhLUFWSEeeYkcGO3ym4nrz5vN0DGqjEYfTBdeMDo+Zzmsdob1lR2ia3fvZlkHCuKTZSR1ruZp5Q9NvTu238RYF5Z0moxWob2Q5xiwmX1w4ZIQdmhYyr+nYHx/2rd1PhEAVLvvviJJFRFeEd1yxa7QuD3TiJ5T107gHFDoVqZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSXQtycm; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSXQtycm"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-436e87589e8so1442324f8f.3
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 10:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770662709; cv=none;
        d=google.com; s=arc-20240605;
        b=P8fki3Ej02JdrKSxuH0gDKhWZ43lGATn0LyZU2VodX1SkJWMFc/fO6UIy0SHVqrqRn
         7MIOMPaMwS/3CP9t+MNFt2ZPp2CB9AJf0yBJwkh7BfWrYihddHacngzlH45/wWKshg/y
         vr6o3b/7mRlunO7u1LQDQAkYDVW25IAbeHcyKu6qqHkKcKjGlOO3wFbaFuoj+31U9k/A
         isLJG/udN+f60tTFveJDxB2+wdpngx1yLlS599CJpIfj9s031unutdJ8UAiAGhG/dfRX
         /sFuHg9X4PhDGMDSMKIJqwGH6UFnObpQr2SuJgeLEV+24KNkwWDao7a/C9qW/fHigFYO
         BjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sqMmVYyUYpGstje1wz4BDAufr1v680Vkae44YBH6/xk=;
        fh=w3EAH58XY8O1mwStW4Zq37B4CWizgRTw9lJdk/Y7H2s=;
        b=Uw3hA5H52R0mfBceR/4PMCcpKp4gdidQSYODPu1ZfVOcybSW5l5lukmS2TtEICiP8B
         +Rcp39XxcjHxvui4NND4Ni0smsHUglYXjsCk8QChyX0iRMoevJE/80MYPvgJJ1vD9Pwf
         IdNdKKM1Mn7jq0KubiY23aDaH+U1gbtWtvbqw8f+/U8GS6uXDIExcI0Gqmo1PqmTusl4
         XPVDVMtvfmPMx8hRPyri8H/TYb+kKnQnnmek9WOvnYCAquM+mFFtALdK+9trMKHdXrxL
         nOEVIRs60wb7b89crzy7ygaTJRIe3Qm+BEu0YymD+asvOTzku2a+JJ1RSvlW19dFYwG7
         SQIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770662709; x=1771267509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqMmVYyUYpGstje1wz4BDAufr1v680Vkae44YBH6/xk=;
        b=LSXQtycmfmH1+2BCwo+kK1vOtMr0AbFNbYR0G518XT49Hk9usOWDH6MR1QcBK3QVjZ
         gUnzpUJRsiks6wnWYUigoGGA4pi27cQmoM7L60DIpMUoDubOnoEFmdLHvbNYAwgUobUN
         vqmUKsdnHCHfFLoh15g6mz0MQ38Z0nrAWCLJFp5HkzdbEDGlqrD27c5XNkc2PjYk3K1a
         aeVN2M9Hq77LHdGmJuqxa4OUBcYIjtHFFBtsMhBlXAZBDv/6lKgDXBhOGWPiW8Mf34Fl
         kpa2WVe1BjdaDwWI8AUR+n3D/qSKMwiUsyE9cs9jvP9BedO9ropUNEteGdSHZG4GvrqZ
         Dc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770662709; x=1771267509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sqMmVYyUYpGstje1wz4BDAufr1v680Vkae44YBH6/xk=;
        b=timu7sx9YLdHYzyYkZws2HjCm8FtsSih2EfRsYjw31Rxdj7hRDOXCNYjFAcSDEhwKu
         +3RsVOQlU1uu45rkpCPgZK/WVIip8R40/PqT+SYPNJ6EtLgkPZcCA3czIYa6dBK9kE4H
         TCmgHOaXgfG6xp8IvQpajvSd15952c3HbSoFGUxASoaBOAAbvrgtbUsXF5Y5LoTI69Mq
         NRelxxAtrW6agTgKo9eGzV7PGzVr+oUoxVZDKLe69lVoQvpiIG+qbGH/MswZEXDsrX2G
         A3YYlcqcPXR0lc+XD3SGnpi6hqDjBdZiVNJMovYuut71a0Qr3vDWbwHxMTcvrFQqzuTI
         xkMw==
X-Forwarded-Encrypted: i=1; AJvYcCUCbNCfKPIysCX+q5d1Szv9uoFH/Il1lupcrriJPenRmU5CpF8CK2uJbyi5vFg3dm4gf0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjpK/rPuAbY2cg1nCh1M1s8I8C4fXsFM29RUGO9Q8hVBAxrHqw
	ag0HB7yVbmdfTIkvP/PsiUrekoIElm9SuQ7uLlPuXTEDWXz/U04NpyJklV6fysVOMsk3cJ7Qd4j
	V50g99Pd7dAi0TXWECZD0dxFDAJ7alKk=
X-Gm-Gg: AZuq6aIfQK6y6UofhrADsdcNcwE7s4GIGg9brJBaIeAZL3cpeZJQst2XPMhMouKwrw4
	3CJYBgE1/dlBI469k9zDirFV0/QMvN3cT48K7bXjW52SCp+h+WFhkRPTAuEl4R19XNczHIAQ7IU
	Cb7CzdL+qv5eduF5CyDXk5kXYpppIpdAx4FqyCYJ9wWwAQIwSsm7IdH/GuiQDI+e5WJQr+imAIs
	Lt5FlfdUdwAcHVlLO1qD/DIXv99pH9kcIyHOMPRKI/BkL5ISMre6Y/jEyikHanG1/QKYuU5HVH8
	Cu0iWqSBHTRfNovw8X0vSuTalQ8DFGRmZ9qXIzJg3iwoLWqhPWlCq+eKoD8ARDx0byKBEGHKeLK
	ym+CkvomwkVkEYA==
X-Received: by 2002:a05:6000:2285:b0:435:a0ca:bdce with SMTP id
 ffacd0b85a97d-436293b6d91mr19720428f8f.63.1770662709254; Mon, 09 Feb 2026
 10:45:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206093410.160622-1-harry.yoo@oracle.com> <20260206093410.160622-5-harry.yoo@oracle.com>
 <CAADnVQ+rNYeb5Pu2aHRVc+hYDeAF5t19MVwzXsyn2HkOuLPNLg@mail.gmail.com> <ebc2eb77-722d-4966-8376-f11607de53c2@suse.cz>
In-Reply-To: <ebc2eb77-722d-4966-8376-f11607de53c2@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Feb 2026 10:44:57 -0800
X-Gm-Features: AZwV_QhH5LLE8iIvDB7Twan7nOo9YGILnwQ7hrloMARMGnUSRQtlNRKOCRmQfK8
Message-ID: <CAADnVQ+q3QPqNdV3MuysQJQgxSS4g6CV+VzN2=UqCPHw7xq=SQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] mm/slab: free a bit in enum objexts_flags
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 1:38=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 2/6/26 21:09, Alexei Starovoitov wrote:
> > On Fri, Feb 6, 2026 at 1:35=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com>=
 wrote:
> >>
> >> Since kfree() now supports freeing objects allocated with
> >> kmalloc_nolock(), free one bit in enum object_flags.
> >>
> >> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >
> > For patches 3 and 4:
> >
> > Acked-by: Alexei Starovoitov <ast@kernel.org>
> >
> > I think patches 3 and 4 are ready.
> > Would be great to land them for this merge window
> > (if Vlastimil agrees).
>
> We should have an ack from Catalin for kmemleak. Also better take them ou=
t
> of the RFC and send as 2 non-rfc patches first, with cc list reduced
> accordingly etc.
>
> Then I can put them to -next and try sending second merge window PR next
> week. Can you also point to any bug reports that would be fixed? (that yo=
u
> had to work around or delay merging or something) that would help the
> argument to not wait a cycle.

Here is one example:
https://lore.kernel.org/all/20251114201329.3275875-1-ameryhung@gmail.com/

"
RFC v1 tried to switch to kmalloc_nolock() unconditionally. However,
as there is substantial performance loss in socket local storage due to
1) defer_free() in kfree_nolock() and 2) no kfree_rcu() batching,
replacing kzalloc() is postponed until necessary improvements in mm
land.
"

This patch addresses both 1 and 2. The freeing is done in a good context.
The only reason we use kfree_nolock() and suffer from defer_free and
lack of batching is due to kmalloc_nolock()->kfree_nolock() matching
requirement. So this small patch is a big deal.
We will be able to use kmalloc_nolock() -> kfree_rcu().
