Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2123CBE66
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034901; cv=pass; b=M0py/CYVzosU0pWgnci/CsKar8augGCyehXxktsuTshTtdxi4vD40ai0RiL6tRj7QoRmfsn+ETVNl2vFpH3VNTKQYc3neam8tw4FgT4TjAWzf+o4eDXImyKVt/Af41XkLbKQBqwdJJi0YlTJKpXoqg281SheCJsK8Mwp0qA3LNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034901; c=relaxed/simple;
	bh=Px8VZ/mZa/wVBiSvlhUqswxvgLPunBza8vM2mBYbtJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ND3vOCHk6MNKIxh0xZ/lG2DHhWD82OIq7uxy4RpSjIpUNmdgD4mMcm7PdOcLmuO2mP4OCN6mC5oOMEDlduCJHe2VrMcJ+1uAN56qgJbRzCVxdhQV/82GqzxD/wMYvENuSYrfqKSZ2t7HDoASoYux/2LRziXjuBtOvDDEMjQ1ANg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PcbMzFc1; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PcbMzFc1"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50baf2df711so43305351cf.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 02:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775034898; cv=none;
        d=google.com; s=arc-20240605;
        b=SKHpZuTIHPrERlw+dtki2S85D4f1YqAxXn/vCDo7kAqFJCrNIBmjLDzD0K2ZZuA7eU
         RRSzizmQr2IPTclmyEnEWvyJiiWfpeb7DqAl4Y+cAE0zRZSnRjI9UWvw2XwSFGtMOK2/
         zVEfb1VleDdHOwcyYYaXRfDEPK4OJWshRRYOhdo6iebKzReprsvUrSQ7J8dHvhYdl2jw
         0HQjLRAO5VRePwo/7CQaMgwrgyXd6ZiWy3ONXudYeCeq17/SMTp9BHy304l780Y34YiI
         3bzCZ8TtVdNz3+d4P4lyQ/AuPBz6yPauQIo4InESfhLGGTkVUY+ongaAwGPN1dJhxgDA
         9jFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        fh=JSmce9sldpjyPW53j7ggTa5/yF5gAvunPcuNjFaMyn8=;
        b=YFC1Z3sJbCLqPySRbBz/+gA/1XyxJINS2syL40bwYavfVtBcdi5fevW0rT1sZ/S1kT
         Iys/O4QswXqpW0hR/oJ+sMhnaHxqz787Fw1xA+NfSCutVaqOw2cAc+9BhYdR3RONIcAf
         DMc7WKNoYfcqoW3qPvwltb463nQ3Wby5qWvjFlQaMcklyXUC/RUzIQ/U+ET2LoEFOJHs
         2TvcTwpapp7sfwViMYc2aCHNbXo1zpKfBs9DuTMqY4hXlwf9UkcKkZAhOmAOYun4RcYA
         9EUrSiT0qfGoqbRu235O2OYd6mCKJ9wYwzRAog35sJtUbFWb+9TbzWi0LrvFNHLb3pIy
         RQKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775034898; x=1775639698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        b=PcbMzFc143UJPNLa1IszL9pPW8NVryFgbF485R7GCAGuU6p+ZrBk02ECuyE3QGpPPR
         s8PmzFSS1wArBXxvuc+UtXXMnAOwCJ+jq+1vNSV+UniMmd1Z5E8/yTmPY7jdYzGGTVr6
         NzWp9TOvjIix3ogAaxIjggzONpWn1bnYrGEVP35Jv2A4mKUlB7v6q/VKR1ubhl2Awk3s
         Kxcz59bI9slSkfdhXbqubS/KzGRsdYjcTJgVAK0tjaZi0oohw05fsUO/dcsMUFE+pl0E
         aVByIpngrWTZAFOiI7hgEJOSTa3dRZmFq7KhzfK0ZJxLzy54WLBvphLnzo2fZIpudTwx
         M7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034898; x=1775639698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        b=dAq0Rt/CEoU2cM6vGaSm+NOzE1OAGSYplLHbvATVgjN6XeW3X9pKF4s1TjpHymNeN1
         oMPuZbSYYr055ensCGqX+7+K7sZqSOWWxiU5kz+yJfb7PRNeY4fwQVWoKNXweEbwVVYG
         ScSKgWa9u9Cmj0DlWPHLKe7lPg5tM0vdutQeOayDBD6rQS2pQ1p5mpdNom8v3EzSBMZg
         gYVxlzAVZ5MTAq7ONXNfexZ/pMcMOsL67hTIqn6wBHsy65+l4HgD3g9yk0Byp9XIzQ0+
         u3ZZ+h1fwmT08EKV7XZAHsG/icv2Tqop5S9whkcAYuiz1JjkM/kcNgMn23jf/fFWZWAJ
         g9ag==
X-Forwarded-Encrypted: i=1; AJvYcCWlaibcVKSd3RzviqRinQ4ChssdiwkFyKWiQ7UaOjJzYAv7SO5NNxYgPJIAxNnFa9fWplI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXY9bB4ZcvWcwybNA7fxCBm6fLHvIdQgK3V/5ORTvhbqtZH6c+
	rAF9BFsbca8XJZAgTvY3tv4nEkTULkFrLkGiO6l4ZxVCumikVVEquxSQfX6xhghamiqwoO803XR
	w33Y2OY92g13/ysVZu0y5i8kuv+gr7O5MJS26ENrb
X-Gm-Gg: ATEYQzzi1Rhu6takyTTo9CBieSZBCnwBt477bkxK72b3POehKtWdKNKntLc6tbhS1Qw
	A8jm2MtEL+AYWSxcKBG2caHrrb9bkBsU04j4ijbKMANKESkugEEyyBSjKgZwIdJlVI9pnjBniN1
	XOrzM/RSJBCqTiT0UkkbmE2BC+QW1uajgF8beWiioIJEHQO+Q7DzHDN1GyoxalHS2IAruEr9XDG
	Ms7KMnk8B179t5nj7C3geTrH4uF36HuQ5px9hDvWp0TgJ52S/8B6B4zlRD+NbueyZWpbRxKHMTA
	H3llPA==
X-Received: by 2002:a05:622a:1c05:b0:509:2ef7:7034 with SMTP id
 d75a77b69052e-50d3bcf5f5dmr36705111cf.50.1775034897967; Wed, 01 Apr 2026
 02:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-4-dwmw2@infradead.org>
In-Reply-To: <20260401074509.1897527-4-dwmw2@infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 02:14:45 -0700
X-Gm-Features: AQROBzAoGbAvZgGI1SP1QOjEPB9AfHu4JQqffzH3Pc3uWqwtvvbxFW3VGI6Tc4w
Message-ID: <CANn89i+iRUgqtd+eirfSUM3k+keNZKzLwsHxZtwE+vHdv7H5PQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] net: Guard Legacy IP entry points with CONFIG_LEGACY_IP
To: David Woodhouse <dwmw2@infradead.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	Guillaume Nault <gnault@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>, 
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oss-drivers@corigine.com, 
	bridge@lists.linux.dev, bpf@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 12:45=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Wrap the IPv4-specific registrations in inet_init() with
> CONFIG_LEGACY_IP guards. When LEGACY_IP is disabled, the kernel
> will not:
>  - Register the AF_INET socket family
>  - Register the ETH_P_IP packet handler (ip_rcv)
>  - Initialize ARP, ICMP, IGMP, or IPv4 routing
>  - Register IPv4 protocol handlers (TCP/UDP/ICMP over IPv4)
>  - Initialize IPv4 multicast routing, proc entries, or fragmentation
>
> The shared INET infrastructure (tcp_prot, udp_prot, tcp_init, etc.)
> remains initialized for use by IPv6.
>

...

>
>         /* Add UDP-Lite (RFC 3828) */
> -       udplite4_register();
> +       if (IS_ENABLED(CONFIG_LEGACY_IP))
> +               udplite4_register();

udplite has been removed in net-next.

I would think your patch series is net-next material ?
