Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96909241C8C
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773500927; cv=pass; b=R/dzQcVBy44WH6IgjLvZOpTQqp2pz558vLU9H+Kv1/Ak7Vq5scPNaDpixaghYTrULiC3bSCD22ccZxrSwUyIw5pR+0VezZoU0iO1Nr4yBQkmFes4y249kGvDA+NxF5VqysOl07aq94dRrD0PXLAv6LcddQq6eU6Yk1bnxvej0KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773500927; c=relaxed/simple;
	bh=cbqoDPOkYwqEbjObOVEfnxmqsWUbTCTlD7okLVBHU/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rx1eUO+/x4TMvMBjacz9zBgbeayEipaZGmxSQYZ8Ss7yZU0c7j2Zl1ZUfP8lI7ojM0OhLSUz/L74kGJ8yWR3C+bn1fRI0Ig7/M0G7EB3t9f4/RA8RdnKsMpU3wlaMBWapuZ83RsGCVmpEioEpsOYCDSzGYZ0sC9JkVqrnjQdIx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtOjDLzg; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtOjDLzg"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso3256635f8f.1
        for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 08:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773500925; cv=none;
        d=google.com; s=arc-20240605;
        b=hIIfPJB3AHSyKlXlKofulJ/3P0BVpVCWpMJEoatNIDIT+h4mydeUvr4/7gVxxsUFQa
         CGeSN/Mby2w39H8y7FOcY03wMazKSmttPv5pCZ2l9I1acLmWkQxkiFz+8Exa7YK2lwda
         5ijTNm/JzGjvxApAeupfWtOihafG5Ppe05hIjfBs6VX4TUagfJRXczB+ER9qkGnWMxoY
         HsA8zNQR92ebUqAstl72i2Prx8xqogJYG5XMRXZHS7LRO1rUKOJVQV4kTiOVVo0om+M4
         cRUu6zqayHrRz3MPpZtYg5YnwV2pt1R1qFxUEB7ET6GrcMw57dVpvdCpnMf3I5/Cvqef
         pWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cbqoDPOkYwqEbjObOVEfnxmqsWUbTCTlD7okLVBHU/w=;
        fh=7fYzPqxJIV5fLm/850cNULWbiXQgGcR4c4VjuuJFewQ=;
        b=ESdEpHrf3tsb5aD6j1OPCeEi9nJXhUNpXZ9kxkd9+j3A9fMVZy+1eUn3MzqXiimeHX
         +l4QCVQrHwjUfnpOlHll07FrctwdbFDiCRQchkUZ0orvhWB0QBGEjrcmJR9Tg3p3VSXV
         rT6gjchNhE7oDPJWNpACHfckD2VEb+l2AxjHJIZZsXYaAO9nTYoYJXhSQk180KXpj7LQ
         uioMo2j0aSjKoeWHuSc81lsOXef/gMWCIkfIjEtp+V/X17rNZeVvti4EgjFte+Xq/rg0
         Njf2ZUbiBWPOTYFgwP28ynL5izbfg6RzLkFJgAWAbbJQFZZQ1EnQQdvtXsF3VO/VSCAT
         lBPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773500925; x=1774105725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbqoDPOkYwqEbjObOVEfnxmqsWUbTCTlD7okLVBHU/w=;
        b=AtOjDLzg/uL44gnlp3KCTkWiX5UEzFPfyjvhkkhWy/VGiyW6KKH5lljJ6+atG3SvJv
         VEwMgOF1yAYITIlI/RIa4Ynm2T3vHxWWaLnzEVs6BE3uGA+7Di3/j+mIq/Wy0XqcVvML
         QTErlXQsEXQoBpeF4WNqAbJDysU81pccUAKWjkniGzrfLBtKAMJ2hKXSwgEzc+z5Ke3F
         pLFnr33oeeaTJxtLjQIgNYaOSC3Oi1uBbRnnlNgWK5670MXUqIO75csQZIfuesOHH9ee
         tg55Y6t6+3WX0CLRtBpcxz1PWBzchldv0jOVfTe9ZaFFNmWxwHa91Aetbp53tQVzplAa
         WgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773500925; x=1774105725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbqoDPOkYwqEbjObOVEfnxmqsWUbTCTlD7okLVBHU/w=;
        b=QnCzy7rJsRHwxABWXLFKv8VEKH7jeoCYlwDsAJ6kT2We/8R7jRqiLeh8lVE4q8Pd7U
         yDMRzQ9Z/qWWEQ/g/6w+zlIGzZg36kVz+gaGyuDv9mb73wOfQxrxcse5Q3TLYVyEe6JU
         op+qb7rhd8cEtUw/E/u9triFzG+qd1zVtt/oxIiegh5RmZMRSmf1ijhNjLtTAqwsp/Fz
         LAo+5Q8/F4FggqWZ/GmcvddGKtZ7AOAYVsnsKGPpSJ7GkuGnid6nkRWJnIItw5/ppwMG
         pwlE6oW8G+lHnL9R0zcSEoGHfq6WtTWV0NEWuqFs7arDbfQF+fpMUzAYyFj7e7TNoEic
         G05A==
X-Forwarded-Encrypted: i=1; AJvYcCXTdMG3nu3jegkOzOxayz8Bm7BQ/B6r0T3eFiFjgigMd04JeBAsJ9fEG8uSR/4AgHwGKrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBImtokCzfECB/GEF0bnZFhIsW61gci0Yq+kAWwjtVZrSP954j
	DSwFpd3VZQ65T38dFj40sRI9/GwY9BE7Fd4fR0N64By/CAVoaubxcDx5ei0hSTTMSMxJwNVYHgp
	ukjx9z9/KXXmw8yifI2puNLLoxXkWAGM=
X-Gm-Gg: ATEYQzxezJb5q+/BWJGc3koAhyU8WItJ2NpDGqcMZXx4qTHy8Wzi5lcLQU8qfLtxHJ2
	p46YVpXOgrfRuRgGNrySzwFGd5PFlZDiBepkXSpyFeIoK5lGSdUsFzM6wTa24anOsxmP5ty6nLC
	XSvocnV3qxXQYLfkSCm6hhkWoYJ/JZiaQ2cgU1cM0i8qyXArEvsLqyDrjQGJCG54l8R9ZiSHTJS
	/sXB6Ya8zbenD2eO91mrCM8F+egm0igzFFIN/tKZfoBeMiPIc9mSyNqmfUkO++kHQmB8QJZQCSf
	s7aPP4QCdn8yZZndOBk9SnUIM0ORL1un4kOhxIYaAl82sLaEGXe3eegDhD2nl97yNYE=
X-Received: by 2002:a05:6000:1849:b0:439:be67:a038 with SMTP id
 ffacd0b85a97d-43a04dc0a33mr11806474f8f.41.1773500924716; Sat, 14 Mar 2026
 08:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773401138.git.paul.chaignon@gmail.com> <ede050cd3a7ac94a839c2960a8a09b1dcd1f0777.camel@gmail.com>
 <CAADnVQKw-8ZBy3H+kP_nvtFY=8neF1Lm3tuVoQ=OpKrxb-qj8w@mail.gmail.com> <bff0a144925370ba4c34be610f910a8ca0f91efb.camel@gmail.com>
In-Reply-To: <bff0a144925370ba4c34be610f910a8ca0f91efb.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 14 Mar 2026 08:08:33 -0700
X-Gm-Features: AaiRm50_poQzh5hoBvtDXBUFquttLeRWzYn2p_-FFPF56kYv7JcAPq-pnpsK7Xk
Message-ID: <CAADnVQ+40y34+e48m3T8tmvBypvE7NpXLpcdY7Tu_ohjwHnJJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] Optimize bounds refinement by reordering deductions
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 1:22=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
>
> So, unless people agree with me that [1] is easier to understand /
> maintain, there is little reason to switch to wrapped intervals.

Since the code is there and it passes tests please post it for
proper review. One giant patch is fine. If it passes the initial
"is it easier to understand" test then it can be split into
patches for landing.
