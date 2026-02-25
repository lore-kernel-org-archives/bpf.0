Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAADC3DA7D7
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034314; cv=none; b=noADo/+U3fWGahoO0IF/5wXCjI+mvVKAsEcqUwQpYlShBlEl3WIo3WFCXmUulL6/QHVJ6+q0zRpsCT/4YWIWFkrV5XbbCqFAHyhWE31wSlIFAmtlEHug0+u8C0YEIm7drCxIaztedT5kivK0yOg3Fz7A8jqPdlMEwe93MdvGP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034314; c=relaxed/simple;
	bh=gPvFcEfXiqPuy7lYBnMUvduvXgSEpCGhKTVWVx2/xH4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iNUSRlXUy379/aE0j/6O1D/Pzb712VqZuVKzTB7YEbWAhTigfpR1+cl2pn9imvlMLQMP2N0jInpYjNu/G8rIS/m/mkY5KlKn2q2N8TWLxj1h3lNpK4QdST7nrqZ9u3Z1EEo1OF1eVoaiQmKEsYLiPLJJakmrw3ftWiARwBpBXYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGDskJud; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGDskJud"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7947cf097c1so65295357b3.2
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 07:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772034312; x=1772639112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uO65KSWBr0mQ6tb0/2KN58uTscIuAO7gxPT58NJtVsw=;
        b=eGDskJudULKb/RUybAan/2Ryee8o0N11aDPibQUfrc9YGkz/71ZBZTqdyYUvyLokoE
         MtVLmwz2KoHoXbwumeTFJe2VroVsRQHeqbSkV227hLYQr7fBMaYd6GFVZmccAWV95aSN
         VT2Czwc6ZCrtb8gDL3y8oDfRemKfUnbNN4Uq0wn5uybtnyJWThAIyMRN350xWD66OHqg
         jiTrTciICrM/tl1e0Oep2PvQWr3dQ1qC4mS5SD7l4Aq1sSaSDFdZBKhyDWsSUNJMKXgQ
         FAIjJzvqhbiAH4KuUG7B5hGBBROn/EMpRP9Luue0YJx1kkF/1oDTPSRPpQTQcSwUsGna
         5bgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772034312; x=1772639112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uO65KSWBr0mQ6tb0/2KN58uTscIuAO7gxPT58NJtVsw=;
        b=Xq9HZp9BdVACJSUb7F/xItWbGvExgoIBumU/MB5MHcKiBj1Q/mnZnmY1jY9zV35sgB
         un7r/foUPcd1MHOre3mwgcz7UzdiIakI36w5yxKxX71amz79+QDpeWKh3plaUVB/Z0rj
         98fWpgTKjysPLqjv+jGE1Rl2p7Ut+taGNXMCULSdY9407NsgsV0IBxKSmQz6mAPpEjQY
         UCAPU1U+sG94lwQvvTj1+pKyDortCKjYNYrb+TWHNzeIi7N3k42aidMOMs9l7l8wxBSU
         wuJIOOQyejXQhr2ypIgcL1YWJnU9dn0KUIO8p4gvzRXaZVxdhIk3w7jkhy4jjnxNLa9X
         Gszw==
X-Forwarded-Encrypted: i=1; AJvYcCVFwIiV/Z8dPMMlv/jL9Ukm8knkWBJSWi09aHe+vY1R0fyqck1X/eI46qpy/6Hp+ozxtaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8kKfwuuqjFbuGh9GWSr5E7BN9Yurnfewprl2EeN+rtOrFKJtR
	/6SC/b6GqO+iGONazuk60+5X46Fn2fNQqwjuz104aHse9MbnrlqOQVfq
X-Gm-Gg: ATEYQzx8wVh9/fkc8zPotF/rGyrPqQyLhdzqTk95umAFJDBDbVMHEffyP8tiF3OsFSB
	QKyxIiaLKsZMUeKRgyve7vtLY0O0kDldTfR4XmFVBuEAQOSD8fwTo72rOavS2jiFuhr3cbmsWnM
	WSQt0WXr8dl0w/Q+7ABj8pCcu5Ckuiiuf0JNYj5lJxwsgpVPsITuIsOJ4uCorFMateIusmRuko2
	8/h8QE0l2GV6bW5sEErdXdcDgEgrncvxH8E+n3TJR4enpp6H6E/aPhCy2Qma5E2c2Ljs725xcqI
	voPDlpKbwp15ZYqjKFYE06Njf5cbqGC6ij+PUWn29LYfQ0QDu8k5f54KTTbLU+vodFqBPAsTUOM
	YWm1BnSHIi3snYPdfrybESnfDxbcCDt8W/dxpQJhXMFgC/W849LFejhV7DmU0aDe6JJEw6kTtrQ
	/J17ygfoZGvOF8+0lEEjX1ctUcN1AZP9+Z2iB9QbodaftpLEe5jVrFZLIvRNS779MQ6660TxjXU
	ULP+CsOhA==
X-Received: by 2002:a05:690c:6010:b0:796:3079:ab9 with SMTP id 00721157ae682-7986fca012dmr7700337b3.23.1772034311854;
        Wed, 25 Feb 2026 07:45:11 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79868dc683csm8102117b3.3.2026.02.25.07.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 07:45:10 -0800 (PST)
Date: Wed, 25 Feb 2026 10:45:09 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Hudson, Nick" <nhudson@akamai.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Glasgall, Anna" <aglasgal@akamai.com>, 
 "Tottenham, Max" <mtottenh@akamai.com>, 
 "Hunt, Joshua" <johunt@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Paul Chaignon <paul.chaignon@gmail.com>, 
 Mykyta Yatsenko <yatsenko@meta.com>, 
 Tao Chen <chen.dylane@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, 
 Tobias Klauser <tklauser@distanz.ch>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.7c6e5a81afba@gmail.com>
In-Reply-To: <7C8018C7-B0E2-435F-B155-60F29BCF5018@akamai.com>
References: <20260219104710.1490304-1-nhudson@akamai.com>
 <20260219104710.1490304-2-nhudson@akamai.com>
 <willemdebruijn.kernel.5766d0a10c73@gmail.com>
 <7C8018C7-B0E2-435F-B155-60F29BCF5018@akamai.com>
Subject: Re: [RFC PATCH 1/1] bpf: Add tunnel decapsulation and GSO state
 updates per new flags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hudson, Nick wrote:
> =

> =

> > On 20 Feb 2026, at 21:08, Willem de Bruijn <willemdebruijn.kernel@gma=
il.com> wrote:
> > =

> > !-------------------------------------------------------------------|=

> >  This Message Is From an External Sender
> >  This message came from outside your organization.
> > |-------------------------------------------------------------------!=

> > =

> > Nick Hudson wrote:
> >> Enable BPF programs to properly handle GSO state when decapsulating
> >> tunneled packets by adding selective GSO flag clearing and a trusted=

> >> mode for GSO handling.
> >> =

> >> New decapsulation flags:
> >> =

> >> - BPF_F_ADJ_ROOM_DECAP_L4_UDP: Clear UDP tunnel GSO flags
> >>  (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM)
> >> - BPF_F_ADJ_ROOM_DECAP_L4_GRE: Clear GRE tunnel GSO flags
> >>  (SKB_GSO_GRE, SKB_GSO_GRE_CSUM)
> >> - BPF_F_ADJ_ROOM_DECAP_IPXIP4: Clear SKB_GSO_IPXIP4 flag for
> >>  IPv4-in-IPv4 (IPIP) and IPv6-in-IPv4 (SIT) tunnels
> >> - BPF_F_ADJ_ROOM_DECAP_IPXIP6: Clear SKB_GSO_IPXIP6 flag for
> >>  IPv6-in-IPv6 and IPv4-in-IPv6 tunnels
> >> - BPF_F_ADJ_ROOM_NO_DODGY: Preserve gso_segs and don't set
> >>  SKB_GSO_DODGY when the BPF program is trusted and modifications
> >>  are known to be valid
> >> =

> >> The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
> >> renamed to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
> >> Run Everywhere) lookups in BPF programs.
> >> =

> >> By default, bpf_skb_adjust_room sets SKB_GSO_DODGY and resets
> >> gso_segs to 0, forcing revalidation. The NO_DODGY flag bypasses this=

> >> for trusted programs that guarantee GSO correctness.
> >> =

> >> Usage example (decapsulating UDP tunnel with IPv4 inner packet):
> >>  bpf_skb_adjust_room(skb, -hdr_len, BPF_ADJ_ROOM_NET,
> >>                      BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
> >>                      BPF_F_ADJ_ROOM_DECAP_L4_UDP);
> > =

> > This patch is doing to much in one patch.
> =

> Sure, I=E2=80=99ll split it up.
> =

> > =

> > Also not convinced of the need for the NO_DODGY flag.
> =

> The reason for NO_DODGY is that, without it, the egress interface will =
see the
> SKB_GSO_DODGY flag. In our use case, we want to avoid marking the egres=
s tap as
> NETIF_F_GSO_ROBUST, so the skb will fail skb_gso_ok() with SKB_GSO_DODG=
Y set.
> When skb_gso_ok() fails, validate_xmit_skb() calls skb_gso_segment().

I understand why you might want it. But the dodgy check has long been
there for a reason: becauses these transformations are not blindly
accepted by the kernel. This use case does not change that.=
