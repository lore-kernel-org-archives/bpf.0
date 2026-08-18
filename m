Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516CF346ADB
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070390; cv=pass; b=kSEShQp40jgUSfq86WVgv8c7GJg40KLClenIFz5krpa5Fo+ujNiqKucIhQ1lqtI5fng6csCke5Q4DW9uwl6w1U6afAaBhq0YDHPvEiBd5OBTysMvPbnyGbezbuy3E4TyHglrh5MoBR8xhRYLM/26/IbotG7cCtKGyOv9YlMzS0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070390; c=relaxed/simple;
	bh=boxmTyMFq29LCfG4VMNLF0pnUpUmPagiT8ecsCV/s6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfiDqtHc4GXV398S5cacu8imh0ue0zMBs5KyxqjVnZw8zDwY862eH8z0nATnOtOZCwM8ttrO36A8Q4jTEWt3uGh3WNl36eMaWRejS+rmGOiIoO/bzE17Uhwe6mEEze/Q5Oz9KCO/YrJKsKekjk9lCybO1yqP72gZw/Dhzg+vRJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbMdr37i; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbMdr37i"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccdf36f63dso124045ad.0
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 09:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787070388; cv=none;
        d=google.com; s=arc-20260327;
        b=ensWxT/GWvkBrDb3TaLPE3fBZwpy0QT2QGBC4SGhcCfwyIFefbTdvki2S68/x7b5sZ
         GbD7Ha4HtxlIaErOOjvT9yEKZdW6dqqgb96mMUf3mLmcVY+L9cgqQXTK4vFTrKZEGlUB
         AZknJSA0kk049SVaLBjfbQkG5p7ZSm2g7Xg4vdlGazBiEBNqONEpVg/IUHIncAJhmRfc
         PGnkxhr0JYwwnvcwCYqbux7DcS6prGOJNZIRY8L3D67A1/jSoKVgFYScIMua3XPuJCXv
         3OxU9VHawCmZnPRBEqJcmtBznhDp1P5HW64zHo/xUVhitCL4iWGNuNLwhhYr+SjB9QH9
         gdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=boxmTyMFq29LCfG4VMNLF0pnUpUmPagiT8ecsCV/s6Q=;
        fh=euEx/oqlLsTy1ph+n9k/W+VKNtdWp01wOic06Gxl+Dg=;
        b=rep94DwhtxHbXZ24cg9TsyZvjMx6rOKx4pKW9f/fAMWZ1EltHoOo3fvHUMb+wQQtgs
         Oy2ZJ+JOUfLxJ0RsVUtW6b4T7rfBnv9f8wZw27BVQGkj/zF88XW3UEyyjKo3pXbCw85q
         gg9KB/EdJovb4bjLyC++Woue2TV9ZMV1ujz0MDTJl9IZM2/LAvrBHDWAcdY5rnjAihT9
         aMWw+nwxQezW45iLo7v1h8mcAqiYn0RfH3XCYKLzAMLl9s2mY77D8UvczLwG8SAtzIYV
         +T3teMfnnhknU2GFlx0GD9mYeYKX5swEytZcT8ecWQvOwVWdptIkrOHXjK83PtK01twt
         Ujdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787070388; x=1787675188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=boxmTyMFq29LCfG4VMNLF0pnUpUmPagiT8ecsCV/s6Q=;
        b=cbMdr37ipLubWoECADncUh9dMoO0uC7oXVvBXb7iWd+rwMv0K1jbw9SXP0DkvBhDs4
         1cYtN9/AnegPBycAcXWZnpH67kbD8nYDnt0tlx4FnJwjnyCX69zSEveaqf4Z8NVLg2xM
         axMzU3y5qx3DZJovyTcP7k8l8hEOXagUFSBvb2JIlahCzLMqy/aocMkCjpMkIWO5L6JG
         IzSItWdZjsigrX6B4rB+ydovDN3nkLL9ZUV+H/c4l8STyuJRSov2fgIBQegVbjhULvb2
         1QcOTg3K1nnrQdJ9l1rnvq7bJCenoABdk0WW6qPWLRAGcj0yv/edvOYtfIML0UDUWjrr
         wyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787070388; x=1787675188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=boxmTyMFq29LCfG4VMNLF0pnUpUmPagiT8ecsCV/s6Q=;
        b=pHqSnXREmJjOgputOUQM2N/+RScejH7jnW6tP6vYKOgrLcFEjT97pCS7TCD2o5Z115
         uJaD7yEvRozXOmdRj7itHQZ/2mH9e4X4+f1eIKJPlvKYV6BBmgxYAm3cnyuf1t031l1N
         hH3ySFc6DZj15JyhjveSXPFVM8ZovA8cU3M/wzWaG+3ZGXqu20yoRiMhhgbzHTMDVumM
         3r69Tn8xfid1P2mK+9TBzCFtDvJ2p2W0RgGHkwgMarrAl4epWWkCZNohFbeTHgahhntj
         uQ4F2a15Ff5S9R4tGtYYUCjle+X+MC9wjHQ589g68zDfRXTfQzfSXNK6HO6MxBs/FKcN
         9pXA==
X-Forwarded-Encrypted: i=1; AHgh+RqNomZ8GKeKqwpYhG9zYskEpz68RtCXCLyT1hrn7ePgiQrREez6PD7xox6fwVQVLp1enjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHaGd5Q1h/FcRJDzKN7wgf0/MeIEQcvhoJYvFzY2RmNQAiQ77T
	WkoHf7gMqrMeXb35PVrBym5IrOAq0ve5BHFB1UGJMdqXwZVk71Kvtxo03UUKQvqsdj9N+QJhvSQ
	IaDqe9AXt7GMZGgOIP1o+YyV/6fXfE1Hdcojc5bDM
X-Gm-Gg: AR+sD10F8H209j6PKOY/OrJV1mwSU1nMkO22PrhZPxjtvALHE+Juw+xcPLc7/5RFywO
	i1LQhUDSaVGQP1C2HTl6hWl/dFlCc10ZFFfNmOUrhbugQ9lXEglv14dXiNB1FDesTzJ8HBsTsmB
	Eh5GkJZQshwTxIu1MfbsiV5BiI73CxyV/sqoEwOaDhovwlKkjrE3xa9ZpOpkojYJNKVM20Ci1Yf
	KchFl0RTg8tkZaJMg5xD8Xuaq+KGhadkI1vaL7B1rRUmWJ1j249YJ2jSH2gDisV1kuuZezWjTcE
	C91wdEYZ9jZhHnAau2m6LLa/RnSn8WtD6O4oc7GxRMAW4vUtrTCDHZWeHgNRDGyKcVaJ2PNm++s
	vgWmJr7ahWXKfCQ==
X-Received: by 2002:a17:902:f682:b0:2d5:db38:8013 with SMTP id
 d9443c01a7336-2d5db3884camr4553885ad.18.1787070387689; Tue, 18 Aug 2026
 09:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
 <CAEAWyHerP_n3ucJaEqrCZqVFQTPKzydYXOPYZkk8d0iKf8UWow@mail.gmail.com> <20260817183904.6e0fd5a5@kernel.org>
In-Reply-To: <20260817183904.6e0fd5a5@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 18 Aug 2026 09:26:16 -0700
X-Gm-Features: AcwNN1XvAvV0q4175YkxzKnksGXpJuWQyNr6fD5SZcYJFVMGRRHl5k4ZnrMHHXw
Message-ID: <CAEAWyHehCR6+mV1d1JJz=wdsT-LrUyowT2v0CsFR8cw3CVqYhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/15] gve: AdminQ mode related refactors
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, jordanrhee@google.com, willemb@google.com, nktgrg@google.com, 
	maolson@google.com, thostet@google.com, jacob.e.keller@intel.com, 
	przemyslaw.kitszel@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 6:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 17 Aug 2026 14:45:08 -0700 Harshitha Ramamurthy wrote:
> > Sashiko has spotted a few issues - will look through them and fix them =
in v5.
>
> net-next has closed. I'll take the first 3 from v4 and the rest has to
> wait until after the merge window.

Sounds good, will post the rest when net-next opens. Thanks!
