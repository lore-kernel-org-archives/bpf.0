Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F261DD0D4
	for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771793010; cv=pass; b=OHOEbtOvOzntYOEroyrzfXidG+J9odPJgYTgj07RnK8CgwA4aTx16uIuuj8gvgSx8bRM/5m9Ge+Bne6xPLq8QqRxOXBEfRLzTOL/T5wqwYGD7B08j4dwK2DuCJ2nnH43b1xk5LYWl0nmOsmR2T7rKZU5oPb3sO8GFOiqQStOE20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771793010; c=relaxed/simple;
	bh=saP8pFW/226uPrq2XfEF4g2chnkOYZlE1tgay7R7kbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2155umLwgLoWFIo9eZCUy92l2r7gNxH+Mj+jr3GjCifochesu5Ju+gjauv6ZrgOvdZuo2TaTbML2qJb7YbOaG3oUNWaErhur4XWqv67SmByIhUvL2DwPcTBQTDKWYPaz8vUPG5fEQOdWdfwbuFY5bhQDD9N2+m1YmHpBk1vl10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=JELJgyNp; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="JELJgyNp"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ba90683995so1530491eec.1
        for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 12:43:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771793008; cv=none;
        d=google.com; s=arc-20240605;
        b=AaahtHEKH5A1ZwSmE+ahpZlLX6ehsAj8+Q//4jxGF6GF4c2B5CXyd+dJZCyTGD47bo
         AtQy4YFl0CB+sCkH0D6Sg1jZYS7D5c6kD26iFu3Fp7fAkGdXfgwNGeuosvurwvT4nR59
         y4jbFIDu+6GQeZ90xBDXMLr3chvCrRxw7WbOAUX34eIx9wOlGIgTjE9u59b6GuWP7guo
         NKj2Hy92vydg+MZNOHHfcjddxXP7yJfFu6R62VR/IjjQKlkNHgW7lUuf6G1nYo7yqP6d
         E9Ota1rNBsZqO1jm44x4dUS+htW9OriojWKkhWZyL0fi/+eWA77IJTzYhSBDNe8voYio
         tK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/gVvBlMQHVmM1i05fzZ7RTLAREi+xNZTShVkxOXwOuw=;
        fh=x3WgcLbDBhBThYwomdizoMHFXqnTaI31J6lRG8N9aIY=;
        b=CnrNXaIw+juTcvvM7cIT8AigOuNCRXZwvgYSd132FsK5suJGyTQPS8UFgAohdJljX2
         0r//ymO1D3iIwF2PqJuXXZ6QHviE0juPJOESncYuwHBHvSfw59n/22zzSQQ2jQOl8DxX
         WfCEBgvlYfiIefjUcKRcsXn5ZneELPV0Zj6iJM9g1uCLVdMj1uoW9nLv2ZwCGA7MnheC
         sTDzNep9wB+LzvWZ+5H9f92aTE4UOR2HkIQu3TNDCJoSdtHvpcaDMsO87YRXRk/WxEZZ
         bd2GcVgYGNajFYzMtzz3iNAs6mmlS7VwudXNa8MGriYyl8pwTc9KCl/VzHITtBl/pxm0
         XDKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771793008; x=1772397808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gVvBlMQHVmM1i05fzZ7RTLAREi+xNZTShVkxOXwOuw=;
        b=JELJgyNpZZ+SiNTrtVSSo0jJ8Wnll4TW2PnsC+Eu8Mn4Xnntbxpp0ocAG7i2VzurnH
         DTov7uAfcr5opcq+XfBUsB7uDRo7LHsCl3l+PJ9jXV2KS/J3FDYSr5DvDrr2rrO/4wQI
         sk70O3TSZ5oQ6LYQ+pBDg+Uf0kbbxVZQS175/51KoQFoMk0/tdyepRz4s3CHCivju7Xt
         0G+LCDT/fQ7LFxV+uOvzgtK0IJhIVPg2C/zrvsOx/k8ot2gykU44UHR9jcH39DdPJUnn
         oxG4JOz/hYKO/MuwTVhTS2dxADMud4I9IHNtnpsXkAQeIgRZ3hpi8WbvkFHUAxkRxR6f
         JQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771793008; x=1772397808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/gVvBlMQHVmM1i05fzZ7RTLAREi+xNZTShVkxOXwOuw=;
        b=WCxGet+WjuGLjqRwm2xRDvIiCaNLRLcJwC96ZbVbjsxr4fI653Qax+Kf5uokZX7iqD
         MlxodLbPMO0IuUjO2jj4Bj8ca7T7Td5LligmZm27WLXfIGe0wA4N7sSGgTxvB67RXjQ6
         MQ0HXEyiJtT+H8bMUNC1vNQQLqvPlz3IB+NCj78NL8cGAsco7ztu2buR8KEHyu02UkF7
         syOaAswFfNe/JZS4+wr2kjhEnPkgAWINxQTt9coo3hRf2LEkG789mvbhebyQhynncU1V
         V1DzPwsBzo6WMaChx6oYwKUiWxqCNbEzydw0Oa95fAy2SSU1sNBsQK0XGPwef2icF4FU
         WCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWTdUAA08aSaTR9lyh4LLTE39ft7Cduq9ZzThteu2UaYY+EuJ5JPTwqrLlxYhTAiKKvI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuA6D++93fxxSDwQAT38rCaqupwstquqc0Jn7tmMQhpxzevQcQ
	r34+ftM0nqq0Tjehiv4NyCVGKK8vCZbNWzhwMQ4DX6UVgUkPczKXcSZ//dayTf9+KasbF82Ur54
	TCMfCnQvNLiZCaTwZruzLvU9JOAqLZnB9Y19RORxBwg==
X-Gm-Gg: AZuq6aIPl28VJLeXIGG9/hEqGEKG5nizWxIoj6osz/HFHIo35dQcI4Ox5ByJ4BaFZ5p
	jXrZba9eI9tOdc+5WBNEfCaOt9zLTjPaVmFJ2Vd4LXK+U8kZ8MMQPfJanmvFjh1THfbUu2xjty/
	ecTuEv2DLeyLkHXM3uBXbDKStXNeDCEUqPs5FAlqW3DS/9nmddnxny/4z/BxzzEjt38WvgZWwJW
	KZy3GLSZuZXzd18J7b3dTc6ZPRjUSsBlM2StD3wyAn0shCNKiqCXOkaP/QOP28oANAy0N1LSEN6
	mzjDakMvxfMwH9h+8n5lEEZ+C1NpQKwWaxEqTNjNbA==
X-Received: by 2002:a05:693c:2b0c:b0:2b7:4f83:9a84 with SMTP id
 5a478bee46e88-2bd6080df2fmr3859030eec.17.1771793008145; Sun, 22 Feb 2026
 12:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771625484.git.josef@toxicpanda.com> <e582d9289c7b7c2682808db22da6bc3ba907d884.1771625484.git.josef@toxicpanda.com>
 <CAADnVQJuyryVdvS7wKHGoC4nePxrtg45441fDyKTFUwRDxk65g@mail.gmail.com>
In-Reply-To: <CAADnVQJuyryVdvS7wKHGoC4nePxrtg45441fDyKTFUwRDxk65g@mail.gmail.com>
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 22 Feb 2026 15:43:16 -0500
X-Gm-Features: AaiRm51VlWasL5daysbKR1dO4weyrmXzKcmBkp2vh2YxSFVtVM3fR_WAJB3lXv0
Message-ID: <CAEzrpqczwOk01a+QEEUmxETcgk7c4JVaQhyHap=iHxR3Xztaew@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selftests/bpf: add test for btf__add_btf() with
 split BTF sources
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Chris Mason <clm@meta.com>, bpf <bpf@vger.kernel.org>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 6:07=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 20, 2026 at 2:44=E2=80=AFPM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >
> > Add a test that verifies btf__add_btf() correctly handles merging
> > multiple split BTF objects that share the same base BTF. The test
> > creates two sibling split BTFs on a common base, merges them into
> > a combined split BTF, and validates that base type references are
> > preserved while split type references are properly remapped.
> >
> > Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
>
> v4 and it is still missing your SOB.
>

I didn't want you to feel left out, had to leave you something to yell
at me over.  Thanks,

Josef
