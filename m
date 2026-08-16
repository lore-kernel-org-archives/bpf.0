Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B773C454F
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 05:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786858197; cv=pass; b=sSZz39jzDDBHG0Wi0ue+jjf8jztVVlfy5TxZGa3T6yklaClPwIyyZhFAJ2K52RydZEC5zAk82R+Ya23ZYTjW/Su6s9uIi6xQaVOd9SY5u/RMhfEoI2AVQMOGDCUWiyTeu59TojEp7j5SfGxVViZ6SUjlHD84Lhxz3lyIa64jcbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786858197; c=relaxed/simple;
	bh=0GMogYTNpbTF5VIQI3Tj0Z3WDeNmKEadOpeGZiPUrEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dnd5vy4xifClSrn5nC16GkAVn8J4tnWb2mzJYD/Slq4Y0UQ1a/nLZQA1OTmzrvdAE8+49EZIsuaJtybC8TCdy2hrtLMtGNaKfwt8tJQx6MQuXLlRDI4coIdzYfrHqbGtNaC1qPSjUkdEpq35ou+OfsAPAKHlBFzEHCv7DFdY9h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6efumHj; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6efumHj"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so241810566b.1
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 22:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786858194; cv=none;
        d=google.com; s=arc-20260327;
        b=eKi1XOrj5ckf85Ajcs3MWLra2tpUy1l+qV92KVKlzR8UZLVdXJ/uxdToNsmDRKqP9N
         L/XyntWCqegtJB7ab1jfoyKq9Frva/w014HUtrIMyS4EJtw9NKn5oFZRmXdQMeT7iXfq
         uSHrpQqnEgqDMi8R+EgbQRfA1l/CtPiYUrGMwTiRjU+9ksoB91dvtuGYEQVFPY19Flqt
         BzXv2Rf0LnymTRGo250gIKlyFyXuI9sNz6ncqUj71JSzSwiQtl39QdOAFWt8Xvci3nN0
         otNMZGD4HebTK1r5Y3lNyFwC6YsK+hJr/R1Vlq8lPufbP70WM8VyKuvADWpfpWvKFYIg
         eJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0GMogYTNpbTF5VIQI3Tj0Z3WDeNmKEadOpeGZiPUrEs=;
        fh=1+WoQEZUrThSPmy+EVdRGjmxDxUVNPxXMKvglkUdF6U=;
        b=j0CsJ53w1uEvyy65XzaN2Jl+42m635EdPN88V5dEV+61UJSIbaTWOd4CdYJuCDys1s
         JaktkklW5KeQvKiD65HzZwp4WmO5ujfYxnmMqwEIcIvE32xFNzNgD0cnYFex/2cA26Ko
         MGVTXRoKzkgVKXCYcej3OmNLI6bv4CNDIIM6h4+/hNfjZRj4Zi042bHS2eSIZ3AVCQKt
         OhRuT1IUugclIEV3WHQ5luUSLPsQ8cfT3JJHth5ljCtXT6BWOoEpSiSzoP/Ql2+5PQdn
         g40zbQd++kzkPpQYcsSmvcPbdw1j5yI0sxhA5fd9kF8plrgC+Uwhjpk2NogdTPUwOV0t
         YjMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786858194; x=1787462994; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0GMogYTNpbTF5VIQI3Tj0Z3WDeNmKEadOpeGZiPUrEs=;
        b=i6efumHj/UP+vr0j5972EHSS85O4+ucNdfTNSumbKdzLdUK2PqmMDO0qUkMuY3r7MN
         NQtMqDc3zLRBXNWr7MWgkxeAYe5AX+0/ATwihgSODSJr7uWKlbPbn/PjrBkXsBcR/S/V
         nkVFuUEWQWt5eeDKjhDCoToqJiqMnV1wIRZu9gvrBM2FD3wuqOBvh4Z+LoyLuEl2Xo8k
         QiJDB+n8rHrGE+ktrlHj3dV4+DVluPb4T3UnWpDUokyRrMPPCRprYpj/jhrZDP6iZvbi
         1NzH63US02YXSPcZECYasB9f7TqWeWkfa/cHBeTXPPVrDKEA4EvT09C5s0dNrDBHGwEQ
         xj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786858194; x=1787462994;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0GMogYTNpbTF5VIQI3Tj0Z3WDeNmKEadOpeGZiPUrEs=;
        b=gwFQxOTLFgOwcsOcsWCFZpz9EqUFxxW75A1frbyM9lkNEVIh7WzKnvjKpftCqDyy9/
         kTVNywkg59zrciMiATbknXkOoiDC8K2EUJL4zvRItIwq22QUCNaaVeVsAIhTxEjGZ/Li
         zXnN3G5YmbQSSxd55VX5PnC+nyiIbZhCWkeBc2osv9GS/EDsr4yw2dJnBe2V0haXuBB3
         twvde+QfY2f8km/Sq1vya9sXhOnxBnWNUAFD0snsXnC+rh7mabaPR/gtUvX9R4JjcUyb
         36/OS14sCvc1398isqk3HnTOsR52o4UOTW6KtHOcWcEvjoz1/K+i3W007uXTHDXIUp5k
         qLnA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5sEKQ/t45VoF4zTFRP1SGvQeL8OySoxMjnXp1841lhMmydx4CG8Yzi6G9ywKQnNPEZlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk59xEFbpbtt/rYDU9/aMTPDAKK20AtdU5ho3H6jTNTQclsP4H
	t2OEv6s8BTpQ5v4K9k1EN52448Lx1Qtums4/VIVSquyWCvotkejQOXq+V9M/8oewphR9UlWR9Wd
	AuxlJJP0toTe28XwS8dg6qN1YitofXsFqrmgVz/zP
X-Gm-Gg: AR+sD10fMvvjsDEyHfcrXp99epDRkezX/Gf8vyrY+pSYrVeh5zzzEwOc6+0OS5qisH4
	FBLOSmwQYTQGMmSc30wHE3u9ZKMXa7eKxaSVaPIAWK+Q2EmdRWkNJ/fVT55f0f2M6312DSpImaq
	UcnQlcmVNP55NZji7AJLxcHgMguhmxOCFjLWa0erwC35LCNbZrzuPBU49D7CQGgBah9YFgUBciK
	qZfc/6t3yZYsQlAoBc5rQKIqvMM+8JxEvwqI6TGHLmoGoxLhlo0OnRtn1O3fTSQ+NPqzl4Cwni9
	z1wvhmqNktwHqKcQDYNJN1ZBxe6p+GRsWQsTH6YH7KQeqw==
X-Received: by 2002:a17:907:7b9e:b0:c20:33db:41d3 with SMTP id
 a640c23a62f3a-c2129bd0001mr748392866b.11.1786858193993; Sat, 15 Aug 2026
 22:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814234845.773189-1-joshwash@google.com>
In-Reply-To: <20260814234845.773189-1-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Sat, 15 Aug 2026 22:29:39 -0700
X-Gm-Features: AcwNN1UyYmeHLBsfX_QGjqXqAtj1GIDQi_SA3bNYfMThTGhnY9c3uKATUeY0Mxk
Message-ID: <CALuQH+WN+xftDONAk=T8zeB1qF5y=yaJ4F23DAg4W6puP+jToA@mail.gmail.com>
Subject: Re: [PATCH net 0/6] gve: various XDP fixes
To: netdev@vger.kernel.org
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Ankit Garg <nktgrg@google.com>, 
	Tim Hostetler <thostet@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quite a few review bot concerns on this patch series. I will respin to
address the concerns and manually run Sashiko to hopefully catch any
other lingering issues before resubmitting.
