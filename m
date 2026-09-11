Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBAD12AAF1
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170267; cv=pass; b=ZS6C1q7+GupTLvyuJByBT9jXNCH3UvF0sWzJ6J2PV0D3AqPUEDOIT2UU/QtkO446Dq330tBH4GBNpcUmZRJUojoKZo4d9Bdu/+yLdAJ8ccIUBA6ZWNXrGIxgFvWNnVh4+pgjRoJhgHNZJ8xpdjoambT+tn5ePX0dQuKaMXVon+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170267; c=relaxed/simple;
	bh=mvc2KxV8FvED5Z+w6AlD6I8rlEMnErJRV4BeojrPCnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDXcUNjbA7nXnTKfDW5VdxzAOyzTzbo1oLTwPdWfXfr57gEVEQZZWBwVSlywRs5Vm7zBWggNlR8GpujkGd9GTLWW84bIhgz2CY1Y/zrUONmQG+/d6dxp+iAX1sMyPAisXnnF2SK8Qv0IHU7B2otsXSPtitvWx/MVr25b290Frbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFjsbEof; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFjsbEof"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so109498a91.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789170265; cv=none;
        d=google.com; s=arc-20260327;
        b=eL6KDg79FmkSrevMBQUzN3q7gcsO6fVFdU+0Wm2MOrB2nLZBRxRZLIctaxqobEj4S7
         gPtw4beZL9z91qMpt+fFltaAW50P/+33EWdeLKJL5nAXbBKGm3BD5B75b9h8qtJoGywR
         AwPKoN73e8xgbpJwSEfVtJQxAiLDwCuUPc5A307t578zon4RScx2vlXYEKFW96ePARl1
         BDbdRw23qmLQYJu281KKsXEOlrQY/coulal9kWMdAJg/Jq/nItOVNeZ7eQGUWXKQFuga
         FU+fytLSRg9AKo54r4ZyE1RYDDCCpJJaQBgxeHUWMud8M8nH+Ki0ykLdGgat5a8Q5/lv
         DDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nFqp0Ff8ptw2iS7CKXRlIY1Awbefty1BGH9aPuhPjXs=;
        fh=Pt6sKbZv0ijAhavqZflLqF3fSjEVzNxt6H6Xlv9tcSU=;
        b=iGJvAWxPGr0QhM7AhDWd4hPyTAah9BMJZg/aNGnZTjHSpEFenDEl/tqeUrYBw1U92g
         dz2KxlZ8wry4UFwqBUk5ocaUnKldiNrRe9YhxzZZQrYGXx5rZFSuYmYjp+z0QNt9aLi7
         qS/qMbCCxF/2I3jSzpTPPOpCDSrcZQADD/FCKkRH5V10mks7xdfiI2iXivbsEoCZFOFj
         xSeLZ/9UiS+5qe3YvBuhfDaZen05WAyS/FFfKfDg7C/mg65Iu+VsHL18DzJSQvCyybCL
         gSiOWXUflN/1utLANhfD2LnuoZdoRHF22QFUvsqXzeCpTVssM/9gca2Uh+lJIzZVSsY8
         Y4pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789170265; x=1789775065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nFqp0Ff8ptw2iS7CKXRlIY1Awbefty1BGH9aPuhPjXs=;
        b=JFjsbEofSHxRusQ75T7E+dxucTNXp0L8+xCCO9vyFfQGmuUkTrcnUaLuNE6xyRkZH1
         RqYRrV8hG39h1XkmT+d8bIbpOFHTuh1LPmBgIpbPAXEsoPB6qvzI9EB5rude9ymEviHc
         7D2c6FFqWhVjzaj1wtNO5W+V9Gp0+FV1WyMoGNYGOINuPz19IxKOW2ML5mySs/pPbVyh
         OyQYQb6vPzDXqYvDSW3zmaw9Q+EeyMh99yajuteko2k7N8DoAyYwIrvoJa1UgHwi8BuJ
         e4OOBOT+Iw/susgBQ8fSm7gL3EOhpm/qYMjCOeRnopRMtMz/9ehdLV4trVNbk/VWQmI1
         bDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789170265; x=1789775065;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFqp0Ff8ptw2iS7CKXRlIY1Awbefty1BGH9aPuhPjXs=;
        b=N0VYHVvijePnDgX37nNvIm6/ZjARWEAqpOTa62PevN/mi57TV/LY3iUphZFDQFuWCF
         nvSquYdVKTb7LMNBZBM7/Ss05wuH7o3ksUNxOPBtjSuIVEERjCo0lN0L/RPwqVQ1hK5W
         jCyvKOgLlMttA1r/xW4ZlrHRJp7qttVrHkRgA+8KiKcDtKmv8V+cdHUqsPykvePI3pzF
         NhdyLNg2/EFfxibrwjMObMQ43vP2xCb9wX+eCW59yCrMkjQYGr6TRsDmEcxwpkOHOWZt
         2ylmHJJyPBj9bBsnhKCp6TK3nr+JHM7/Gz8vzKkZNU9c35LeFeyW5ZxRh0htU9hYnyXj
         lbGw==
X-Gm-Message-State: AFuF++kYaFshsLV0ATQSmUIYhEAIp+rSN00agiPdIKuGJPWSQXRP4zo1
	TyIXTT2+fSoiwOGFYer/a3KQAQVrSHjC76CXoq6Clz/+uOn0Ym/1lE1ePPEZ//ZXAWLJgjMHowE
	I1+icMpN1pDNEWGaFy5HT/uflaCZsXJ47oA==
X-Gm-Gg: AYBFou2zWXTKLTFYgTZcYN+urEQGSfmwU6IzyCmsHkjAKkQDN1zJIcQfH9HpIjvqxIK
	UhseY3OLDLQyQs5hhOLpKpQ7gMaXUyEQ1X/MmYpo+3t2CjNJCFG25HLoVQqXhdXhF2w1Cp5IGTq
	0Rh2adV5iVL3Lu9QhJ2jQIoZKc0Rcqe28QBJtxAFrjdO4q8j4ToCw4c/WHrWh7mpigIAMngE3hD
	LpsUCohhLLM9PzZz+BBLWWWkYqWpjI9rV3lSPqWxdH/hs5GAKUtD1ttQoSoTLKG4qq0TQN4NNBC
	nnDL5E7V5y/muSB0KVY3YDxEYUnqE4tBFNQhZOL4oh7O+JQ45gZNE17j+SaQo8QaTdL1+tBcqWf
	37Z8LOINJG01OTrSF+pAhHn3TMR9zcp4G/v6b
X-Received: by 2002:a17:90b:288e:b0:39b:5622:d645 with SMTP id
 98e67ed59e1d1-39d9782102dmr6568219a91.0.1789170264651; Fri, 11 Sep 2026
 16:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com> <20260826181825.1826541-4-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260826181825.1826541-4-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 16:44:09 -0700
X-Gm-Features: AcwNN1VS2yYhMuWbBkecvc-TQVHtC8H1J7xSA29ZZvUDcml3CVYOnGuCXmcMYq4
Message-ID: <CAEf4BzY4WrknceDP2=ZU19RkPgWcS5siFVEoGqDtJN0+XBSgSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] libbpf: Convert bpf_program__set_autoload()
 to load-type enum
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, martin.kelly@crowdstrike.com, 
	slava.imameev@crowdstrike.com, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:18=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> Convert bpf_program__set_autoload() from bool to enum bpf_prog_load_type,
> to unify the API with the new tri-state load type. Reject
> BPF_PROG_LOAD_TYPE_DYNAMIC to preserve the original autoload on/off
> meaning; only BPF_PROG_LOAD_TYPE_DYNAMIC is dynamic-load-only. Also
> restore autoattach when leaving BPF_PROG_LOAD_TYPE_DYNAMIC via
> set_load_type(), fixing a bug where a program left dynamic load and
> became autoload-eligible but never re-attached.
>
> Assisted-by: Claude:claude-sonnet-5
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c   | 29 ++++++++++++++++++-----------
>  tools/lib/bpf/libbpf.h   | 39 +++++++++++++++++++++++++--------------
>  tools/lib/bpf/libbpf.map |  6 +++---
>  3 files changed, 46 insertions(+), 28 deletions(-)
>

if we go with bpf_program__set_load_type() (or whatever the name), I
don't think we need to change the existing API, let's just leave it
be.

[...]
