Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B74F30C1
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167166; cv=pass; b=bFE5jinWZJaTBioI45xxwjOQJ+lBhhZw119G6jM8OU1phA3ef0arHID8Gsz9nnLo7yoP4TMsI4En4j8lPfZ5Ti2XumFte2C6QT24qIODe4QrMu3qfPMcOaYASehVMDEjDNhsnKnnB8Fixtg6VqGhZfjp5BTqUtmrK5+8IcR3L64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167166; c=relaxed/simple;
	bh=zBk/WWunbgjQ1PnhejDQFmkv3G3u9bY8Wo8DwzlmXqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RvHNkPphxN5FHh89w0s+iJpfy2+HUOzt82X2ikTLQl51vlvGoWJTHnw/pRV/ocbVm3SDeAkTVkaZ1IWz6ibz6U8MDcpXDoiuNdfmMEeocZ/XX5mSO2dIBGfOV6dWmN/IN7CuCEwUvyz/09t2AcvimuxOvoW9kKLCZDY2l6fYsQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=VKucz2sm; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="VKucz2sm"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ab27b4924aso183141fa.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 09:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792167161; cv=none;
        d=google.com; s=arc-20260327;
        b=lkJzPC6KwqvIBWRL7H1LC4HTmTB1cNMtR71duBp9qfTPjfAoLodZo5RcPIuoewOwYn
         syYOCO+h3uyG4ODtWTrSKkLsH5ziqonlO0hJBsJfonLGdzzNpC69iWXcuBA8sQJ8XmVv
         ZaHrZ9PydcoEfdu8IGsqAYcueNCukhANZAjp3B+QjDLJYanntw1CHJqhwrLnpDYNNdhd
         gkRi5ulMc6S2DndqUOIXwuX3m/7cYku3EjCbn/HXa6H+tGXxppBy9F6iisEzkn/sb9Nl
         gOmKfdKSikMAj9ng5KfelsTf9Zz8UgmfCaycme1Aj4yL58XurM0C56YbzIxCplSyCeeD
         vDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1DBXJxHvquUaLKJ+tkdkfcHBt7XZVv/oRHXlHwD+SAo=;
        fh=gb4zSiTxebXIppbWTpjmx1E09xXKy2KgDSEDNixdI4M=;
        b=ose8fIz1il81BEUjSMxliFKQWK0d2EISZjUBj9bjvruN6QOOvxftI1giDdPUqpB8ow
         Hi0UqQhgQBPShrj5O1eQmKZLMtOSbI5vp+7rAQOWy7LnJxVAoD9s5rNVANHPD0fQkajh
         GWb51DnqQFYBoUdEm7evNpYUYUjtet2Lfqh2zYI1Y6nLD6f0H2/NgrLgiaH107GeVFFy
         M6NkkHdRl6fRXqNu+PAD3lBc1lplxV95H0VPWwGhLQK8n24zS+FBqR2O2q6bkudbkGn+
         kR547wFTtKQDAM7F/VSi0B8Cn0rggIxo7qcW0JgHHy13xYiP4sZ5ATc4qBoVdmOQmE1+
         Lyyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792167161; x=1792771961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1DBXJxHvquUaLKJ+tkdkfcHBt7XZVv/oRHXlHwD+SAo=;
        b=VKucz2smIC8VhKndOqTkTpEQsySepSdlJpFzfZluXj78ZBSnrV25g2OTSGN1TsquKO
         rWSeULc51d/TxTMaNo3gKW6eIdSBLMsmNOcSk/vZLDFEoz4UVBZWOFV2QG/YQ1hPkdb4
         6MdNUEY+6jHK1xptQ3OKYl+YmHIeTviMQz/g2yx2XvgwSGnLkMBzS9Qt5KoISmsXGy5s
         n4Kb9UBrFGDh9tQzClgauJs37IDjDoaaDexxj+gm6CX+ODirLf0WTwkd27NaFyCnRl0k
         hTWjtFYGh7tmv+7lg3ojIdi2a3PPqwlJZ12wwwb+DROkXpIWNSYPfjU84yDJE351tI/S
         GHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792167161; x=1792771961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1DBXJxHvquUaLKJ+tkdkfcHBt7XZVv/oRHXlHwD+SAo=;
        b=O9ndjUL81Zww6550aRqdz5d/OtSyn2RDwG7QkRs62iJE8/lYuVcz9XPj5dXtU70wIR
         vm+e5pjxA3TtEJsdjZHuPED9tqSLnzPvFAXHwAKS42H8Qz4dVJDkZ2iWTSZ9aG8gf+kr
         jE3cMajb++6H/1UQqutTT7wDDQnZlli5HlpyK+0/y4cPjTN9J6AauK6Bm03JrH+nXTkW
         afmVVNe+OehaVFC+je4Qc3hJRpdQUwwaT+rzxgnePeJurTJhgsYTkBfgCnrZSp0IIJpc
         pL2kOC0vbhoQNf+Y4qtUCoU/aZ5p0xx0GqRXEVbayP5LO0ZCOcf4j3w1A7E+osKKU/7e
         izoQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2mLUQODSdtaXBKEPrj2889z2/GwDGkA7y8nwPY402ISxmhQy0zJ72bKe4A/CJzKBPozI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7IwqzxjI0f8OYC6mup8LX9OTU0D+L23iKqEYFQgr9N2GLkG3O
	rqLU2gCkIzhyxtgBepGLmbyQ5vtuJLbU5Wgqtf4ZQ+CU3tY5D+X1zvdVCjiWN831Ulwc/cQNqYP
	75XSseXQFTNF9G8K2NlGjmWxnrvJRpZLG5Wpmg75AciE=
X-Gm-Gg: AYBFou2ORU1Q4fOWCebEoZeKsk5Bje18ld4Uz/3uRYhfnrT3w5e67kntiTAERvOo9q6
	nb/t+Q/Zy0dVZyA1AU/U47F1ouUHZ6kUjFWdXIDbCg1b8vULtPzpXmMy6sl/zEC5mpJhrWmYYjX
	nx/SXpK7tT34kL+UNz0Zp3JiK1IG/oVSsmKw+d7gME4TYX4Qu4Tx9tH6cUzN3jWEJz3if7x6BOl
	GrYo5P0xC7y7GCCKDwNvH/NrzGkrLUKgzas4O/ATZNPnVVHmbG7h1caittSiT1cfjR0I/SxolUw
	uNzWshk0128qw6+gBjz+wF250suJNOjyyUHC9K4mugVITmx/X/v6H9sAJE4ZxSnqsHkFgqM7e2W
	7/n6PJYB+NA==
X-Received: by 2002:a2e:9a10:0:b0:3a9:c840:10ee with SMTP id
 38308e7fff4ca-3ab2927a909mr511431fa.5.1792167160733; Fri, 16 Oct 2026
 09:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1792048855.git.zihanx@nebusec.ai> <atCtUFcG9b4ykXY3@strlen.de>
In-Reply-To: <atCtUFcG9b4ykXY3@strlen.de>
From: zihan xi <zihanx@nebusec.ai>
Date: Sat, 17 Oct 2026 00:12:27 +0800
X-Gm-Features: AclHuK9WXLPZ_WQaM633BzwfDjRGTUWRZmkMt1BFBbMb-E1VSzEd_hb2wxJXXZk
Message-ID: <CAANe3eTSz3-EE0=9JNFBMFDqZ9NUfScHdi8EN30UVaTiRq0vcg@mail.gmail.com>
Subject: Re: [PATCH nf v8 0/3] netfilter: bound asynchronous packet duplication
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, virtualization@lists.linux.dev, 
	intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org, pablo@netfilter.org, 
	phil@nwl.cc, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kaber@trash.net, jengelh@medozas.de, andrew+netdev@lunn.ch, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, aleksander.lobakin@intel.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	willemb@google.com, alice.kernel@fastmail.im, eilaimemedsnaimel@gmail.com, 
	imv4bel@gmail.com, shiming.cheng@mediatek.com, sd@queasysnail.net, 
	vega@nebusec.ai, root@tr0jan.top
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 6:39=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Zihan Xi <zihanx@nebusec.ai> wrote:
> > Hi Linux kernel maintainers,
> >
> > We found and validated an issue in netfilter packet duplication. The bu=
g
> > is reachable by an unprivileged user in user and network namespaces.
> > Bounded tests exercised the fixes. Non-duplication packet semantics are
> > intended to remain unchanged. MIRRED flow offload for affected netdev d=
up
> > rules is rejected because it cannot enforce the duplication-depth limit=
.
> >
> > We will provide detailed information about the bug
> > in this email, along with a PoC to trigger it.
>
> Series makes no sense to me, sorry.  I dislike the 2nd patch, I see no
> reason why we need to make changes all over the place for this...?
>
> Also, if we go with 2nd patch, why do we still need the first?
>
> > The IPv4 and IPv6 duplication helpers use a task-local guard while a cl=
oned
> > packet traverses output hooks. If NFQUEUE suspends that traversal, the
> > output call can return and clear the guard before a later verdict resum=
es
> > the remaining hooks. The resumed packet can reach another duplication
> > consumer without the original guard. This can cause repeated packet
> > processing and consume CPU and network resources.
>
> "Don't do that, then"?
>
> I think the kernel should not crash when misused, but I don't think
> kernel should have to do extreme stunts to detect such loops.
>
> There are probably many other ways to make kernel allocate lots of
> memory or waste cpu cycles.
>
> E.g. via create use of veth and bridges, sched plug, teql, ...
>
> > Patch 1 records the
> > guard in the queue entry and restores it during reinjection. It keeps
> > bottom halves disabled during the reinjection traversal, restoring the
> > verdict task state before reenabling them.
>
> Its small enough, so I have no objections to this patch.
>
> > The netdev nft dup path has a separate synchronous transmit recursion
> > counter. It does not accompany a duplicated skb through asynchronous
> > software receive paths. Patch 2 carries a bounded duplication depth thr=
ough
> > skb and supported XDP conversions, resets it on reused buffers, and rej=
ects
> > MIRRED flow offload where the software depth cannot be enforced. This s=
cope
> > covers software skb/XDP continuity, not packet loops through physical
> > hardware or userspace device round trips.
>
> I think it would be better to first go to the drawing board and make ONE
> facility that governs the recursion part.
>
> From a quick glance, the difference is historical from time when
> per-module pcpu counters were used, so nf_dup netdev could not see the st=
ate
> of nft_dup toggle.  Now that its in task struct anyway, maybe its time to
> just zap the egress recursion counter and first make a patch that
> uses the bool toggle for both egress and normal dup?
>
> I would like to remove code, not add more.
>
> > At PRE_ROUTING and LOCAL_IN, the IPv4 and IPv6 helpers decrement TTL or
> > hop limit on the copy. Patch 3 stops creating copies when the value is
> > <=3D 1, so the decrement cannot reach zero or wrap a zero value to the
> > maximum.
>
> Thats unrelated problem.  There are other places that do TTL/HL
> decrements.  I think it makes sense to clean this up in -next and
> add common helpers and then use those.

Hi Florian,

Following up on my earlier note, I reviewed the NFQUEUE and netdev
paths and narrowed the proposed fix.

For IPv4/IPv6 duplication through NFQUEUE, the queue entry can preserve
current->in_nf_duplicate from the task that queued the packet. Reinjection
can restore that value while hook traversal resumes, then restore the
verdict task's previous value on exit. The reinjection path also needs
bottom halves disabled across that traversal so the task-local state
cannot be changed by BH processing during reinjection. The fail-open
case is synchronous: the queue entry carries the set state, so the
diagnostic must not warn merely because current->in_nf_duplicate is set
on entry.

The netdev duplication path is separate. It uses
nf_dev_xmit_recursion(), and the current counter does not follow the skb
through asynchronous software receive paths. My earlier patch 2 tried
to cover skb/XDP state propagation across those paths, but I agree that
it was too broad and complex. I have dropped it from this series rather
than present it as a complete or sufficiently small design. I have also
dropped the unrelated TTL/hop-limit change.

I will send a one-patch v9 series for the NFQUEUE guard preservation
only. It does not address netdev duplication or claim to provide a
general facility for bounding every asynchronous duplication path.

Best regards,
Zihan
