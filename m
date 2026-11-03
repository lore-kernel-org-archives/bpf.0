Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727608;
	b=So6BJ6MlVqcwaLU8RV6sOP+uhuICElrvqt3ywu4HBxxAl/KL0E3+2URo5NviNMBNgI3o
	 8nuRYtmVJqUZJo3t5jgiImYLxAixLrL+qgZTVnJc5mdI8HzqEOtOvveQbp/TUHJ9D8iG8
	 PvjqeOFvik54gzRVCDM5BVysYV9t8lnlRwTFDYT8cs/0T5tvkXphrysB0sMKYElfRR2fH
	 bTC7fjtAkcTQ7bRT2yOlNxprrJhAEWWoTPCnd4EZjPNHVonfhL0rIm8xsLRFFw1jfPNxz
	 byWB8q+ZARo+4ruZ2DuhmVfkZHbXqDhtX8dDC9pB8RVLOBTk5tdcuME0Mm1ugb50GhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=z0GygfKxw4B27PwG3wjW8LBVwALAwJtEQDPEKGZVDSU=;
	b=VMKGP4UaNJXLjUvS+lKv1C7lapGW6OmZsZVg/Ki8mWwwT2EQpwZ+/LDKZcOeMNWg/MT0
	 DfRLFF9eM4U1dYrbj/E1HjyQ4O+bWwvUzow3+c471b33KBrhxz/WDnukyxu1po++NQxJS
	 pMWIntvJ33s1u4LGsPmLml5cBqLjMa83e1axVztm6UhOa/qoO8SNn0u943fwbfBowJkdL
	 xR4Yk3nI+6DwvJAEqQDI+f68Nvc+OdBZv1VmkVVXyUUvGWTByLcsjDVsOSA6QWlbviksK
	 FBZfmBhnOBVxPypmuE3/XFQdWJQdPP8iYSSt0+ID/evqxFmHtJplj8OpPcGtVTq+Eww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Egji2Ggt;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76C606A328
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 17:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C76C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Egji2Ggt
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a06c60065fso3128114b3a.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 09:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793727608; x=1794332408; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z0GygfKxw4B27PwG3wjW8LBVwALAwJtEQDPEKGZVDSU=;
        b=Egji2GgtKG8VkxnFY8MI7OhQDJQOYjTtc03HGW9e0YX04Mm9lrjtPi0Gp7a2LT/NcQ
         dNQ9qbVR7aj38zHNtO/eHIFry0UrPZ5p/4o8cG3V7LjI5J+fW/2ZlSImoNIQ91tjRwJb
         kR91N1plurobXIQ4JEDgVMf9l507Y7VOVSYKf4q2hV4F7jQ7SRYI+plm1i/JHfZ/5eJ/
         4iJeHBhFKyG8IG7zOr/OjF3j+HdKg8aZLqCK/rbVITTktDpYOgF/HvUZbQQ5jUCY34nN
         wVpw3RDmIRgiUArIOooIzABR6UBAJYJHbY/WK6GoZyK2v63CRpboh723SaF1/ZuiITtN
         o27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793727608; x=1794332408;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0GygfKxw4B27PwG3wjW8LBVwALAwJtEQDPEKGZVDSU=;
        b=RZm987SBaypzQtCvgqhYOHXMAOGwr6JIgm+wG+2o3afdb3q/1Awvze9Og14Lzq6nMY
         aHZQyb82YhVZOF440rQQbkPBq1h3S20G8mWG5aCjdjv57tA7tW1MMXzhBTvZ0MJJurSU
         Ot/9QoVh4aQiq9Eimj5GZY/BPE5ZiK5JI+3EtAuTdCKlIZ0wuHaxnrh6kQl2IT+/m/2+
         rGle5kEmx8oFo8HTGeM7FQR1AkpVZs2OJWF0AHB9KpGnAQ7BZTwt/krDByH+7mbdWMCJ
         2lpEdzwQ4qMXkutET88xm/44oonRvgDEao+SFGVJWhjtnn1lsIPZQ7xdT0WYCTpATD+e
         SXdg==
X-Forwarded-Encrypted: i=1; AKwUvBzaYKvV6SCAkqQ7YpVFJS+ypf4fGBz2yRG8TnUdnlmGfto8jDTWPq+dj9AQUXA61gymMgU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/904TwDQiKU2idaBkN8gY0L/Lq1FDw2ZmE+IoDS2sa7SFhx+83
	4mUdKJOrMtnMs3F38YBoJ55HKjNHnnPjV5UKTnf1Oq8FiZwZPzl9UvDd
X-Gm-Gg: AYBFou3Jp+9hhJnynLuUVfP3cLdZXtyQmC+5RLZ1fuWhjMjygzRRxx+G7kLv2cp6h2J
	F9gziD00YspnE2AwtCxX+6niQaN4LxI40LaNkNFAg7pSivlefyLU1pqiwSqS6W9hwcpsRbBmagd
	C8CaVvlwtabK6NoxpILTjxSvbhbkmE0/r7F9kSUSygORHyR19X5IPsW9jCWTFUxij8c5hH4W6De
	ZhNCWWUCiOP05IXU7IaCNjn9NQGuDuQbJDlseBmyT9+EDwqVZ7SYu36cDksVhrDU+0EuprnqVah
	CV+h56CLQyUK5ie8wptpwUSE4pGjysM5lLP5CXVfnZy3wu4Vb1jPzxeu8IQUQFt71JHhI2TOEzO
	9GZErVQ1RbQ4Buy6g3oo1fM0/z4vNM8UqMxw77blRQk1zXqPNYEIOQ4bMVf5aejiLcv0vtXSakY
	cSMG2chkJWeavQlsbZVxZABQlqrsJZ3KwEug0o/d1i+H1vDhlY6QmqNk5C2rFQPz26adgEkTNhS
	0V0PDrZavoryVz7z/TTsc9+UcTLK+iYj4PvNlaTmGbpQ4WxSlfs6yZDBYimD7mPEsoUr3M7tf97
	2GXmySwpmcMbehGgsmPTyDBXZoRf+6yLEBTBwa0nTgGBSavRfIQxGIThx1AAd3AL5leSrAesq1s
	HQxh19hy37t6G1PH4AuskkGUMZWx9RriIvLGrJIgxMcVcxsEo2eZ3RDsR
X-Received: by 2002:a05:6a00:290f:b0:8a3:df84:4c14 with SMTP id d2e1a72fcca58-8a9bee525bbmr10517197b3a.57.1793727606391;
        Tue, 03 Nov 2026 09:40:06 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d3603sm3435238b3a.37.2026.11.03.09.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 09:40:05 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 17:40:04 +0000
Message-Id: <DMLRD9KZPGMA.17182J5DEZ43B@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>, "Qiliang Yuan"
 <odys.yuan@gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mark Brown" <broonie@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Eduard Zingerman" <eddyz87@gmail.com>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "bpf" <bpf@vger.kernel.org>,
 "Networking" <netdev@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <aunq4v24N-Gzx_n3@sirena.org.uk>
In-Reply-To: <aunq4v24N-Gzx_n3@sirena.org.uk>

On Tue Nov 3, 2026 at 2:08 PM UTC, Mark Brown wrote:
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/fixups.c
>
> between commits:
>
>   ec274bb4665c2 ("bpf: One may_goto time slice per prog invocation")
>   1ddffb57b3623 ("bpf: Emit timed may_goto for JITed progs only")
>   1ddffb57b3623 ("bpf: Emit timed may_goto for JITed progs only")
>
> from the bpf tree and commit:
>
>   a7a767c66a2e2 ("bpf: Queue the rewrites of bpf_do_misc_fixups()")
>
> and likely others from the bpf-next tree.  Given the nature of the
> conflict and my total lack of familiarity with this code it seems
> vanishingly unlikely that I'd be able to do a sensible merge here,
> instead I will hold the bpf-next tree at the version from next-20261102.
> If someone could help me out with the merge here that would be very much
> appreciated.
>
> The conflict is:

Yep. It wasn't easy.
bpf tree is now ffwded and merged into bpf-next.
Conflict is resolved.

