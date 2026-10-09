Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8939F4DEC0D
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562299; cv=pass; b=pU7keW7J6RNWkdgm5Bi0ehP+u1f4A7loxJgZIb5uaDzZ7GjhcRJFRX4m8azJs+f/EF2VTkmGL/fOgJFpqGI9nBdXJXCR4px0Fr82t8doLsUiogrvjDeK34xVKfsl7nW2YlKshfzgsQRnwICfgy03y7ZoEBHzl6zXzrfn2gAEHII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562299; c=relaxed/simple;
	bh=wruMCtXy7SaidqAshqYiUfIEclThOLN0o3WVP1sMiRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyU2KRIJ1qrvRmlRBpXfL6ILyr8X/ZQLdUHHGQw/d19cs4zgl/glCrqpYneWOTsVqn/YQ7oyxDl9AOo8khhy67uIU3wOHBjQQYeSI93A/d66J0CxmJc0SH3dZVzp1RWz/mMKDmFalj+2Ou8S1iel/MJ2uf5cSD8E9t0i4emybNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbAIioPv; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbAIioPv"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so12021a12.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 09:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791562296; cv=none;
        d=google.com; s=arc-20260327;
        b=njh9LjL0BjVI77Q8cgL8LyMVyVpS9uUGx878lqQoloBVpK9yltDFZ2XKzaRkkOU4xd
         l3yxYMD0QYdIE2evHPS6KU3DsMOhOs+Cmp90rFh2HpYc/44s4eO/wFaaAmY0sl+5uSAl
         l1AZGnPfTNcSBPGSuRG4Qz+ZKL43aXKGKlz7SX5R9+6Dfz/GUMcjDgCLe2jIQmYZBuOy
         xxNy5lpfCBpJvItos8t/PAOzcLNUWK0OjGOaMenvTNhZvrecBr7YibaFTwS/gtteNtap
         V8wGoDUdSiia1q5OwwG2QxSCXNfZckWiVk7K2+byLOzYW4fx4G5bTwzcwhq7IqPqiEuu
         UTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FMY8+4K3G/+VX3FzbqjT/yR5SuMJ7etOIbd7i1CeENM=;
        fh=Xl4Z2tU1YTLP8q5GI+WE7F/DaXrvYkcUhQrzHiF61qE=;
        b=BXWFhzYsO8WSLsfLLtXDj2L8aIC4BdyN21ucVUDYH8PXMDxJ8VTqOp8eAGO9yK/yzo
         CYc0nL7fbRksdvfdPVMt31k4i62Ry37FZYiqwrzf1sQXMaXJXjUqXc3Y6uuqUXc8qUKW
         BNV/nNm8RwIMgWTHZAdUZu3FsFuGkexkPoG3Ne9qvstshH7A8yRSLGwemX/pc1EaYmnC
         W/NVmUuSXDrBspLYtfD5EHuOdPhkaoRBBp2LAqCL+byX0AaZU36nsBA+4C36T6jSmt0o
         47ty4J8OW4wrKV/8ZvtfpUFxiMrz8m4h/NR9EX3WC8qV22Yi0c2+TmT2aHUu0Nol9lhc
         Ktfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791562296; x=1792167096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FMY8+4K3G/+VX3FzbqjT/yR5SuMJ7etOIbd7i1CeENM=;
        b=VbAIioPv5ZrQGr2UOclc2HATlUsoTuE/N7m6AKiGDp3g7O7YsQ6hHfnOE8YR1XQCpb
         2IzR/dN3t0QE/8paeKo4ph5JmVzXv9u8JoIFRwq37ewzgIL/R3jI7QxpjOA1BgDJE79S
         C8GKR9P7K088GxbjT6jaIMXWfnoTjtbDkbj2YeRxQhmvuydZF529udmbmMJY2v3xo5bJ
         UKEvMtA2SIecJn0WiZmcQJWtKl2x/vu/T7CV0CU2SRv7dRvzl37KMFgwgH9mnb1JZD2Q
         MfrXwHqYbcGKdTFt4B24/3mRCaDnf7QxWS1D8u9TCMWmGLO4ODyp9yo9j46/Sm6LmUsG
         yefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562296; x=1792167096;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FMY8+4K3G/+VX3FzbqjT/yR5SuMJ7etOIbd7i1CeENM=;
        b=JqstUS2idzxBC84vHBzhxK6Vk7Ain51rO7doDIUuhp+YqFRvPMQ1nTWUAviV80oANX
         no4PLvLKrwS9mZSNOoflrWFTjufuUiIFT3KiErlvETkxm3nORMZ/ldartK1PEZ+xMKJK
         TfA/xxmncIGTvF79wi00jRcTd9Kxm0bef7TYIZl73TQTAplo1+gumxX6IaDr0OrcvgiX
         2YLSZva6don4pC4FFxDx7BhHSwC7JAoZsez6aXFISAj8VNmvzE7vybMtlJndqp7/G3ze
         j4mKKczPSiatDkjW38QcceIcmKoIvdCVHp2KG5gAyQoGhmKVsVYqKSFEmCHCo9365Enk
         rPXQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7DS8tjgQfWYCN3bTd7PXdh/XB3JycJzkJIWFinA/aUe7M37rwFgy1AsH3FS9nLYV+ttk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI15qVTOnK+Po8oOL9RfiJU/m5T69gcGp606upnPAf9aoWsPmGx
	DaojrG4KYgQgi1IJwPijUiRryWYU9t6u+MSlFDtlqzhox/J04m86QAQpBuJ2uIHIhhGmawf8++y
	jev2AFdyB5doVyqccGPPfzDbdgwHN26Kh0qpDxbguuJ/B5OnQqJRj+tyT
X-Gm-Gg: AYBFou0Fl7UNET84KT8UIAQtLREw17WlS2X5j04S5L4MnPoUw42pXktDujB7cOOzhB0
	hMFwwQERzD4S9AL5dEKt80uAw0oyy4XwJPH7m7DSG/60ieQGK0rk7jQAU+EMIifIRBBq13gftGA
	yFvVifB1NaqzJErNtUFxJqO5VwLx5PqThU8l9/vRceOyO4UCDr/hxZ5Vrl8EZL61Ft0JwVs8v7F
	Pub7v06jUQE3QITObLME5upmQSp1dXObVRwKcR6iaZBCBzAUCudkpjs+qLfvwC1AxX43TuJyCAb
	cJYUwXUB05qRInOwjWTLwYAH7oG/++Gbf5hEqHOVJyj/H/9+iEps7yc=
X-Received: by 2002:a05:6402:404e:20b0:6a9:f353:ef65 with SMTP id
 4fb4d7f45d1cf-6b177f1c488mr52368a12.5.1791562295275; Fri, 09 Oct 2026
 09:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com> <20261006-b4-skbuff-bug-on-v1-8-1b4434c5357c@toxicpanda.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-8-1b4434c5357c@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 Oct 2026 09:11:23 -0700
X-Gm-Features: AclHuK9fcYwhDbADMIDURGeGAhGxa_d-APkp5QvjpXYNwtTkKCU00ou2GsgfiEU
Message-ID: <CAHS8izPxwo35ExaJvK5FgGG3TGFS5uGybk5O=ZoY_1=z15Z-ug@mail.gmail.com>
Subject: Re: [PATCH net-next 8/9] net: skbuff: don't BUG() on a missing
 head_frag in skb_zerocopy()
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 10:10=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> skb_zerocopy() BUG()s if @from has no head_frag and the caller passed
> hlen =3D=3D 0, meaning the caller didn't ask for the head to be copied an=
d
> the head can't be referenced as a page either.  The check runs before
> anything is touched, and skb_zerocopy() already documents -EFAULT for
> bad skb geometry.  Warn once and return that.
>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
