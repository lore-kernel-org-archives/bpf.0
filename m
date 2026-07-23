Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB591494A07
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784809583; cv=pass; b=FHNlFBysVl+6HY8GcvjMD2UUul4hvprbiQ1SvkC6F9SxcyCPBzCkkGAW7bFnF2DOnbUQAXQBlk348lmY2AMVWAL0ev81wCzNH2sRSq3m20+EZ3PnnybkNTzC27+n5VHsHyrsdJZeVTWpL5gzfGpUlFsrmueuowgL1L1+L/dwFmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784809583; c=relaxed/simple;
	bh=bm4DvitUdfbXcw1YiUDoIAk0s2etPbKEW6IUc3kOwkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdrUtDx9H7tFmUQhyy27g8Ri+Q05cXNpzDq6P5u2Klu0IzAA24oXA9FRUqE0xSccggNjRycZNi9e/buophAL/qbZ45d1CbfiZs3EZB3tg7l0zUPtvBMG8VESjjYGOx5nyjb33ytKATAWEj7Le0Ix86ahnjTM+5yKaBqLEozRuW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCtYTs4d; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCtYTs4d"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81eff3ddba4so4055967b3.3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784809580; cv=none;
        d=google.com; s=arc-20260327;
        b=gPOJdKo8y8+JpyJI5QaSlQYzJMdmONRoaAZhxMYnif9Loq9fTqMNVNiz2wZMq661Xv
         9CCzka6nGzoXKIOE8wybcScGwX4Ycsc0wtVMr9vi4mgnOQQMbLJid0KaRO1I0LHJzU2a
         6i9IaRXQvGK6ccEVdUf2WzoRhFGaTyfpXaMPF+DhusneITn/7m3J34b+s0XHPoMQy7+5
         WExU7XoJzvhSa56nipsy1ann+w+sCOOGurLJ5pRI1L3AKPevifcHodlPRkyNuDDYTN0k
         NiTXnN3NSoDaWveQjH85ErgcVPgAFoUYl38OWbUCM1FqteqBWyUY2Gl+JBPT17KlC63c
         wyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bm4DvitUdfbXcw1YiUDoIAk0s2etPbKEW6IUc3kOwkc=;
        fh=vK/XqSgEP+XU2XDecxmPr6aXV4bw9drrsQBMKPc6AkQ=;
        b=JdI/w2M4RSek75etQQmtDNjsm8A5jcf8mQkHUvnfMWHY20oF1h16jbHClWR1vAOvwT
         0jS76oW1n0vCYbH5s1kTIrbsyS0ZireC19tD5610vN2q1yLBeM2Ye7+QUJAzY09Tggw6
         uNtZhPg/7tuuikkcKoeLMdqpOvHzo/4qNI/e0XclZAHrGHtyBr/nTNRcJgDVomwANrqC
         Ykvd8nBj0mrUvMYt4IdMPGdvEnZ90BtjpWNVwy1Hfj6IzLkDcHwXtSMO/3AoYsTlXV1s
         e/Q1knsX2nCKrcPyTwmoeM1WMZcvcD19gWWIZPkZeMQSaZbXjXlW48b5AOoK1jB4uKGW
         wpCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784809580; x=1785414380; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bm4DvitUdfbXcw1YiUDoIAk0s2etPbKEW6IUc3kOwkc=;
        b=RCtYTs4dydqp7Ui3YGAFQ3uRrrGuWMtq9BQOysBnJXJqr73M+WR/X9WSbUi5AoVl6N
         9jTPT7mbRumCfhaw4uPEPPDTHHgAuzmZNaf3Q04wWrDND+fscj+3pDX7aJS78K66ljAf
         9iPZewlW006qQUuEM99/qpI0tgrtr2ywAa54hOfQunnd+noq3SUOnj4EFHo7T0Xhy/n3
         U2JH3g8YIy5KGwcGaF9PPTSWiTQekqfvih+gw2LfI9Qn5bqOA92LeZ0PZ9w6hHMbHYsU
         ok6wANgIufHaA8Ol16+aeHgdg6NIo3YI71Ffxdjr6XjziCgKkKLjaw3VBl2q3ArtopHM
         uemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784809580; x=1785414380;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bm4DvitUdfbXcw1YiUDoIAk0s2etPbKEW6IUc3kOwkc=;
        b=cQPIZEEl8HKq2hW0iPfSpXuDlIkIyHqIMm0M7S8u2n6Q34TEYkvEM4x9Tzs5tQ923q
         WHYVszXTEZM+wcuTMeBp4rDtIQOpC9RdfIRH7r955a1byWq0zmJV0GJbXfccN8gNGZo6
         iD1Eqsee9YRqGOEp9vyRZzjtxUj3j446ULT2BmxPEm5NZ2iLL3I/i7FP8n0Zz/X9Wb14
         9GMwB9PQevakWtKhZxtpwCqCSu42ejb0Ua1iy3o8nllpLh7dbx/C/WmNN+dM572IWjV6
         gCHxwfBNR0WvdZAvF9csAy8E7mRAaMgrn3x8rkN+Dyr3IVjk1MQoAgqF/MQM62xERCMY
         COCA==
X-Forwarded-Encrypted: i=1; AHgh+RqEdX5HTpxK/3lSWO7MENZONrGBDtf0nC6chwdsUwA/iGpASQvu70z8Wl0/o/U0WjYNQc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0UauEVi77K2E5yf6M0veVlAhmM+oGGVpEMWvrP4wZ0Esw6Zu2
	NB8QrlVkeBPEwikF8dX0Agpqjorb88Op9hjN5UfSxsz/ftZTRTcgz6wtCVeCMtNX8xx/NH2C+Ha
	zQ1h9Mh1gCvAsN6GLe+2ZU0LmKcti1pc=
X-Gm-Gg: AR+sD10tY44X7YjxXy5NO37jZhKA/YFbx7Z9W6PAqj0nTQeraoXHNpnx1KXq99L2ia+
	niqN6Hp+n8NlXy5+i71iuzBJU8fXVY1AXwLbTxudt/rK0j8BDOaeB2r95ZduRBYGtTuQn6kgl7E
	IUDgzpjkuLBgA7Mh0lHLKOKge/BrsmTr1Ex8YJzApCDJj8iRHJ1pi5mdvvB2ei4HOlGL77ojipp
	ubq9TS2a3mbqt/xXLAs7hAj4SmjPrsbCke4ldjr5I77yYn0fCn6n/7RN+voIBN8UuIyNzz+WQ==
X-Received: by 2002:a05:690c:c4cd:b0:81e:69fe:a58a with SMTP id
 00721157ae682-81f4c3b05a1mr8095877b3.67.1784809580672; Thu, 23 Jul 2026
 05:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722041326.75199-1-blbllhy@gmail.com> <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
 <amHuIvHN1zY4wYpt@boxer> <CAB8m9WjDoHb67ixPVs=6XgFfGP2D4kqM_SSUj5as=xegF63NMQ@mail.gmail.com>
 <amIGs3ek+0vOp5cd@boxer>
In-Reply-To: <amIGs3ek+0vOp5cd@boxer>
From: Cen Zhang <blbllhy@gmail.com>
Date: Thu, 23 Jul 2026 08:26:09 -0400
X-Gm-Features: AUfX_my9rcfIsLY_uIDVhxM2dZNQpjWSfMOA2YXk4NqsAsUSFcmPLjtGDnliEA4
Message-ID: <CAB8m9WjVdbq4Nr4poHZ6nP761rSFS8sQ=rYe1PNyEjS_u5sNtQ@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: reject undersized tx_metadata at runtime validation
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, magnus.karlsson@intel.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me, 
	horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"

Not at all! Thanks for both your suggestion and Stanislav's rewrite!
