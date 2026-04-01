Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878BD35F5E1
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056045; cv=none; b=gii1Xxd0DHLL1d/2ICNRqF1krW6d3BSEKf46rT+j0nWsVeGjkHjag3BSZbYxAiviXswdPd2uXqjC+IIT13S3F3LWkj0oS2F5dryHHqVVRefzduzqjrJ7RrofJ3kNcFiN9XETbH+077woFEhpySLYshrN1+4A3b0oxwZCWyQvkeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056045; c=relaxed/simple;
	bh=bjcwsYJwkpqzg1+Jd+PAkNPiIUaqng2IgQHyEKuA3jU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ku1R44tnczdC1ChV19bo40RoDgD1poVjw7WuLP3e3JgHdfDo0MTYRhXD9ij4zDRihBwVlHZx2mU6n7bXCZz9LAkNY1N44JJ9ctK8qmIXUeWuxG/zKmo5F93YfzDjTQcatVo1jx3SczQHO83M0fW9Mcv5j2DBwEI97gAr8Y/HRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=pvvONBMP; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="pvvONBMP"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3591cc98871so3098119a91.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 08:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775056044; x=1775660844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJuOxpA+gsO22gNPhXzJ2+Gj7ezb5L7fZMCH+oDlAG8=;
        b=pvvONBMP+FusaaII65++8DgYTon6o6wvICY7wRMlqojsy0Pz2YGtw88a5ZndpiPNbJ
         qApVXIfMuAlgCD44nPizCmr4iR7FiifOEdooE9ZdElP6qgbJM47ryxVSvZhkakeX4uUm
         D1QciWzNs6UF/wBlFOs2hpmQ6TyFFVEfnYAZc1eTT2BMauvPiNqrRKECaKK/e0zQaUJx
         8SG+BVXpG7aqQlKQLetcu2ylQX5TP1dNbyu1FbFsI5RpadI9uHwBzLOBwza76U9AXPAa
         UrL6hK7TB90Vg7hL16+6LmbBqOYsCfyq/QmR7a/EUCLAwasUUpGWxYhb1ZHhrKqpHvoT
         pqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775056044; x=1775660844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QJuOxpA+gsO22gNPhXzJ2+Gj7ezb5L7fZMCH+oDlAG8=;
        b=Np0eITGzeZqfRwBboZRzukCF4iKo7LIDHpHUZdhtEVQijvNpz0UOzdy+LvyE54joM9
         ErX85QKq0+QplRYoZOBummdewQ+z352wGsXrNQL6pTNP0j8T9tVQymdLwVUItZi/cR1j
         tUctQcwuQ0s0UhGmeq7Ygt342jBxF4KYNM0avtnPJZPn9jUDsYwLPQybZZ11Kl5R62Ur
         ku5zXGcus+UrYirUgy2zfdHlSTUNV0+MghIVKzhN2dBCX/lJSD//j9t5eUoaE3yXR5El
         ZORhsVEKApFL+ASUrxxRmqP+M+vSwoYRyPHsFX9oVEz+J5t2CvN98P2fj2YDB2aZY/UR
         Jdow==
X-Forwarded-Encrypted: i=1; AJvYcCXBImep7mOoIXileuApZv3Fs3Y8JvsGYkn6NiVj2JPj2w9Pmw9V0Do0nQuscXlvHFvP7No=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxnkYlsekXbteSTeiImkcnsAl11zqgvSvPX6fjqYBwUHehXGV6
	nDiYOy5ocUO7BFKb49OlGD7KBaZYg9udryqo7RisA/pG5v0sg8adgJ2VLciQDVfY/pg=
X-Gm-Gg: ATEYQzxiZv5wUozJiShiWKL3pBlV6LlORnJplhO6U1MRyiy8JdNXBPbvvzqPB7cpVBN
	6GM7Vwh9Ztk15kTwKuc8xsxhYxmKtb3ILC/kUEhSyQk1bZcmUdceWkWV+GKUv5gTockDMabjUXJ
	1jYeyj04s5WnTMngsSTrhBbpI9GlN/qTFMvlS0j/mL0u0dYkK5fL69Op7wCAFeNB4p1VkRUH3gE
	0qEtOTt2Xckvd5+7sl0ocEhD8iyo336UWtwlqOeEZDgPtwaqOksa1ljquw2CL7vve277eq7W1qK
	nsvmVjEbVm7ko6nRSfcBm/fKzq8zXoBzslkKtfjtpSpSHDpVlnToBJ8JoM5E9nmpIj2PAwyepBC
	HL+2hO9sqXjjzWPETR6qITRnKHVjBA9/axVAwf69oidRCkncoWIhGxLeHPC4YVpkfjehlg7Qymw
	osbxawD3lUqyL47n/TlYdmHlaUan5fDsnpf4Yp47CX1JmBNQ==
X-Received: by 2002:a17:90b:3e4f:b0:359:fdc0:4621 with SMTP id 98e67ed59e1d1-35dc6e9b097mr4036315a91.11.1775056043722;
        Wed, 01 Apr 2026 08:07:23 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe623754sm5043344a91.6.2026.04.01.08.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 08:07:23 -0700 (PDT)
Date: Wed, 1 Apr 2026 08:06:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Johannes Berg <johannes@sipsolutions.net>, Pablo
 Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil
 Sutter <phil@nwl.cc>, Guillaume Nault <gnault@redhat.com>, Kees Cook
 <kees@kernel.org>, Alexei Lazar <alazar@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 oss-drivers@corigine.com, bridge@lists.linux.dev, bpf@vger.kernel.org,
 linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
Message-ID: <20260401080657.70cd9bd1@phoenix.local>
In-Reply-To: <252823d75e9221647e7f8ccef6105432aabe8d6f.camel@infradead.org>
References: <20260401074509.1897527-1-dwmw2@infradead.org>
	<20260401074509.1897527-7-dwmw2@infradead.org>
	<CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
	<252823d75e9221647e7f8ccef6105432aabe8d6f.camel@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 Apr 2026 10:28:23 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> > Some kernels are built without CONFIG_IPV6, so this warning would be
> > quite misleading.  
> 
> Maybe on this date next year, we could make it not possible to build
> the kernel *without* IPv6... ?


There are some government agencies that used to require that IPV6 was disabled
for security reasons. Yes they had broken old firewalls
