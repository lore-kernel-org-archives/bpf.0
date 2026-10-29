Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793255317;
	b=ChdcYbLTU9QLsLZOrB/s6cJ7EH61f4DB1d90GnPqKZl93tucQki5Q/WlTtZLVbtPcfPI
	 v95g+v5mA98nECmjB1u0KeNZuDU55NotHBryhXLUD6beQ5oWB8AcwZSXhFfuuIxfCJWUq
	 mJONiUpn1Pe14iSDAxICvDaE6awstOK4Cn5ZYmBeBomPcX11bw9wfeF3fNzPtEmVUN+xi
	 3y4aeotYSXk098uRSAmha3KVcL7OKADnz5nwsevIyHBuY1jWXzM8vHLPD3TSo4XcQmFq3
	 8NX8m0l2TpiK+Dx8HfqDFV+oJEQWLwXqsCZ61nBWskECDy0wLD18sWplomCZPQ0k9XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255317;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=1iJxU2srr5LwVZydpcZZOyNys/GEnKfXjQqJD4/acz4=;
	b=O3Nf1aZ+BKoct6dV5MYqJCF58wNJah4dWhVin9nFpuJ2uZn71dRzuMcKoCst7AuNmoW8
	 mWj1oC0M1B6EdNiXMzQfjW6/Hw2x/jjY/C9zdAUa0Lpc2uICenGnP2Sb/l7A9tbiE3WBC
	 uja0lGBeYAmI/PMSDW/EsRSH3GNthrFFEeRc2whrXf9C/ywisWuhRgweaFLbXkVBZUpr7
	 eUgGIKE7su6Fqti7ec8zfHCkQ2ZiGHgjJcXigSzZKJncktZs9iXp0rtAIn+4Ieyp6Wety
	 Dy7qjOLsSLBRmP/RBoT1lbZdyxTh8di86JzCFl4GAYtspMy8B9TlQMwbmZNK9dzWkOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dXGQZ8gE;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XExwyMTA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F2606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 06:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 100F2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dXGQZ8gE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XExwyMTA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793255316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1iJxU2srr5LwVZydpcZZOyNys/GEnKfXjQqJD4/acz4=;
	b=dXGQZ8gEyOQ5oh3QEezH5FCP2bIHc+ugtLtAan7KtKRVi4GrAdNesMpbYLg0xJ7Sco7hyN
	eXscDYWjLUAH5lbnXYY7RCRZqOSKHPVF4m7LCON460vnEwvp+TTNqkQxIJHTLQxMpr3anR
	V+faZnOCEZqbpJjoYyfyfUibw7lFWKs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-1r1ykRA6NM-Bv-sYXf79yw-1; Thu, 29 Oct 2026 02:28:34 -0400
X-MC-Unique: 1r1ykRA6NM-Bv-sYXf79yw-1
X-Mimecast-MFC-AGG-ID: 1r1ykRA6NM-Bv-sYXf79yw_1793255313
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5be48f8ead6so965005e87.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 23:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793255313; cv=none;
        d=google.com; s=arc-20260327;
        b=I8IarFvy98PVzQtcf7Kdk6e/wtrIVtmro3/7jok+KJqOSgvxwOqk2DipiYO4Ar8s1p
         ZYNMZa0BG1hPOOI92FGKKVM3JQGcVwgQfnLgPWMPggwMZ15BzLh87URUYgJt1GlBzQ1x
         o2PY3ZAfRUdMpeexI/O9kNZyymyPv/LKIgaIGraQvwtxczWmDhrlnethGv+SKe7yC+pH
         xbCBbMW9HF8ksm+71ahB0IWg08bDGIIk18I85l7bRnYce3e7lwa2KuFwdLlMxwpyIcy7
         n623zuS7PERuvf6tcfUgPEFkIdyNYqXi3C5yog4swFhmP/v/ZK4ETMWrYLdIvYHf5uvL
         9foQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1iJxU2srr5LwVZydpcZZOyNys/GEnKfXjQqJD4/acz4=;
        fh=/6Y5lGVtjSeoIB5n57PvheRdwIaWqnFpTDz0BpDFKFQ=;
        b=hRbidE0qJO5tCiBY2wsYZvW1cevE4ilgaE2eQo5WXxHYoRx9EVLvfyN3K78LNmDNnC
         j8dOzaVYqBXOSWlkicBZxQ0lSF6z0c/zM2SAoKFvmuClgUKwbWGQrfusBrpWvvmfD7NY
         hjCoHhr/PXI5fS1iJ/KIvvikGPjSmgiXtXjlwp6pgk3ef1k46w3E1lpumbnLAKqBr3M8
         moaW9OOnXlADRUsz9FrWidZrMPof+6k3BUym+NROp4G+HHaLM2Xx3bPgLLhjZxPWN5nq
         eHTI3FHFJHMmqan50ZnIeduAkL8CInsubVVgKWPsTAZLFf0dH73TBUIdQiu5ww6asLCi
         F2Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793255313; x=1793860113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1iJxU2srr5LwVZydpcZZOyNys/GEnKfXjQqJD4/acz4=;
        b=XExwyMTA8DYbGGxcBAgigzAVW0ncFH8daEbWVof1HBicSweDQIU9RlX7anvY7lmysf
         m0XqJHSVZKGmAnYYXH4iR2dDd5VWahEwXyZr+VUM+Ou2Nogratli96r3ctrjc9z5FHZ0
         NHOXhaUs0n2MzhoySUyTY/s64ZpNAPg1v5rIIefRgTxgMk/efdoYlJGN7Qar9S4/fqaJ
         5wno6MaPs3c4ncrTtY/0er52+/EQsiseLH2ydHp+GzJ9Lt6OVSuLhaTjz7VntlrXXtdg
         +7YalFMtHTlECAURj7OwLv/Ht9+9YPk/rSEorxTWmpfO5OIF1ddX8PTUOpgq6I2ebCe7
         oznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793255313; x=1793860113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1iJxU2srr5LwVZydpcZZOyNys/GEnKfXjQqJD4/acz4=;
        b=JirD7KZDW2vizGkgevPqa5W1ryZQcUyXPI/kiqj37xiBuliQqwLa9NjNACjsaA7rAL
         Uv5m+F08ekpU/KGFIdKxQCCe6vbucinEpAcZG7a0Y5RLJPKS9V94U6fuI93VfFw6H8wx
         qkTrDD7N71pIila2Nrv6Am5ikSCXgPn/rYRwopZrQf08UVtwpGwm/nUUuIfwkMmEwjxO
         60YmGTeS/lm5R1N3Xn0vtsus3flQ3VbIbRSW9fvquwT4UqMHu4c/Ph20u+QeOLZwXIC5
         Aaz9/hKNtiYJosLxhbLH9PjqynsegFvSjs0pEI5x+plEJzUajawFXeUbcL/ga7MQizdb
         6sEg==
X-Forwarded-Encrypted: i=1; AKwUvBwi13zPipuiZZi2h8IWhgFEJdB0WNMm0lNFA/04HUulvUmgEYApiKUD7va7d2YgAVk7y7A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3RHLpLBdek35+lJemoOPWL5neKERNK5petpgVr8OIXS/nKT7u
	SW03QWhRakiD1iDlG3fAUfuIwqItWEUCL3CySqBrrqDAecW4oFgIK0yzfQhcGne7YyCrzRu2fse
	pUw/sruR+/44BKu32c9S1yKEW4dswjN6PCPqfpD/HN4oLJw8ivcnyUB/XXpp9leUeW+6VX8Y96/
	Z6QPM+n4uqorkmCjWR6Y3Q59U6uEKt
X-Gm-Gg: AYBFou3VpjFatRNDW8TmMLDCQA5pCt56cxTA0VUi969h14UJpk2A9HYnE+1J6yhwhax
	vxF/3+3zvrpAWX65OIXeDwxvAUiGZeaGiYcGmtJ6zCYlGfipx297yBgEBrrLCGgUfzOSPYK2FyX
	pRzdq3b6uU3TDjdfHidNM3TF7jhJl5s0WLYVlhx3h8gv1+SaYY8snDQPba
X-Received: by 2002:a05:6512:1318:b0:5b8:f8f9:e080 with SMTP id 2adb3069b0e04-5bfcad432cdmr1771558e87.26.1793255312829;
        Wed, 28 Oct 2026 23:28:32 -0700 (PDT)
X-Received: by 2002:a05:6512:1318:b0:5b8:f8f9:e080 with SMTP id
 2adb3069b0e04-5bfcad432cdmr1771542e87.26.1793255312465; Wed, 28 Oct 2026
 23:28:32 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028191103.623156-1-ihuguet@riseup.net> <20261028191103.623156-3-ihuguet@riseup.net>
 <CAAVpQUC7hezdMEQkzAX4oqFdO_uzBmtRwn85_5_iWf4ExPqpTA@mail.gmail.com>
In-Reply-To: <CAAVpQUC7hezdMEQkzAX4oqFdO_uzBmtRwn85_5_iWf4ExPqpTA@mail.gmail.com>
From: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date: Thu, 29 Oct 2026 07:28:21 +0100
X-Gm-Features: AclHuK-x6fsuiHpokXnJ3Qx6-V8BzmKKkHRK86q2oMBiEy9ie31bHyN-v0SCuv4
Message-ID: <CACT4oueJgvE=CKSY2T2jkpD0cjT4bwU+ME4bb=j-cno2q57Kxw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/3] net/ipv6: don't route packets with unknown
 source address
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@riseup.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Neal Cardwell <ncardwell@google.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>, coreteam@netfilter.org, 
	Emil Tsalapatis <emil@etsalapatis.com>, Fernando Fernandez Mancera <fmancera@suse.de>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Jeff Layton <jlayton@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Joe Damato <joe@dama.to>, 
	John Fastabend <john.fastabend@gmail.com>, Junseo Lim <zirajs7@gmail.com>, 
	Kees Cook <kees@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, 
	Li RongQing <lirongqing@baidu.com>, linux-kselftest@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, Phil Sutter <phil@nwl.cc>, 
	Qi Tang <tpluszz77@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Simon Horman <horms@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>, 
	Yonghong Song <yonghong.song@linux.dev>, Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 1:02=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
> This changes longstanding user-visible behaviour,
> so the series should target net-next.

You're absolutely right and I already agreed on sending it to
net-next, but sent to net by mistake.

Please review here and I'll send v4 to net-next.


--=20
=C3=8D=C3=B1igo Huguet

