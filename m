Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A427E05F
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061263; cv=none; b=uU4JdxZIEecthelykKxllBMSrO4ukNitCLNpt2+6dW0ZsLYUVV3cfCZAraI9cfASB+unJWQGygtCjI+0TYZdNnA7Lm1qBiehE5DwS35iaIGSpTYPymzEhnJSQ6u6lkPxgjD7jde9TZ1CW6a8zEvUSQXlQR324R9z7BQv1RdFhu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061263; c=relaxed/simple;
	bh=ybEdMnj+IV21R50M/Nq06VgnFb302XMUbdzsNI1SGq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krvoc1bFU3s18ON9cBS3U/xnfmsY0zDU8ACBXQ14cwWfx94GAYlzIJ+BleTm6HBaeq/8U99howeNX0wGw59i8wuuTPQzzjmmTPlXBDbMgiw2sRONZHgwlJ03D3nITAJ/DUA1CfXzjLBxUXjGf9pJOFrace6YtUqf7Jqa9AQHdjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BiVhvwcI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BiVhvwcI"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9c01854477so352039366b.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775061261; x=1775666061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wMfn5M+yor9qcHDuzn1ye+wM03ph8KGxN0vfAlP2l30=;
        b=BiVhvwcIr+JLr6v9XTi7LSqzRtB2J5oLC2w7L59HMIGYg8lnO5uLH8XXANWMBwUaMt
         gcHx24kpgadoHBZurhBnYxKoCRLCdE0YV7y+laj3CztfUzjJ2yzXXCgm75h45CpPWP8o
         Gs83UvOaUOpZp14zmgURgrgo4txa2noTgwb2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775061261; x=1775666061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMfn5M+yor9qcHDuzn1ye+wM03ph8KGxN0vfAlP2l30=;
        b=kHyWLyyoeBCrkPHeQF/EGUM0DVeY9JAX9fMfFwLqmb8s60emaN9cbbY+AiNEd1yzSJ
         /gVYv0N3SFXtVpUfXDvHZQjOQsCpeC+GWQy30JnPma5tfj64OuN0GR1idZ1vOhWDD90u
         sTbC2RXHw/niBDLI4PEBaWcydCkiStD0Rlk2hQ5YpvVp3ab2u0yGTgVdRFbHi/rSGOe2
         kFebpqrxoy7NBYgqF3mNbdtDa/2mxSSidgKHJ8iRc/X8vdpdTySxMjSOnV/E3g6bLS5a
         WgfFPA75er2KaCZ1kZaAyw5meC7I2IPcNCkpH4iCyPTIFZUj5YIEy196Loyz39MxRahN
         6HOA==
X-Forwarded-Encrypted: i=1; AJvYcCXqATdkql5W8XuQWC7eGIr2VxPa+xJcGKdXcpF3kC+sKrL+dUGsDXmBuYULzOaL3XrU+IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0ATbOdXT4xEtnb3E/c8HF2UWVz7EGYOXeX/u0kVbnFtG9Cfv
	PzBvsV1SNYzq26PVQ9E2gNHy7IN1KZJFzzR9NO4kvZkW4lPlWQg0bs0LB1IIhVuFz25cq3REbZg
	k1AdxWZ66aw==
X-Gm-Gg: ATEYQzweQG9ubiJVWkGGq2J3QxRl49clt6PcuEFqfovAvvyc7GBUOyntizyikloDUPc
	LclOT6sy2YmcVDyXJ+ia5AAOEbx6l2lKHvlP7ZcmWN9mLOB8XOmi9FpaiU3t/jvOMo0flxT1rtb
	AWC6MYCIMtUhtM149+lU22aaGd1N/LVIoAA4Vz2AFfhKmGIEfeCpun+lF2GJRuUV581douGrSiN
	wCSV8K28r235XUCngVxDrQV0DvTHZQBQUaMhHfBlwTWLMNmAVUjE8O+EApio+b4TfpRVgCSpJml
	zZ1hMST2T/b95m2IfZkzaih2Vuq80+wBe7ulhW4Y4/YI7sX9czSVWUHSMExkcIZbCR9QtsZ3Bb+
	XLJfovNMuI1xJfpyHN55gAt6c0Hh2UvxHVdTQpy0sWQuVwcNa4bc5+5q1yvSjzWX2ebTPcdBiCX
	O/e0JIy2o40bHTJeRDFrL5lO+3n0QTY8PSP358xGn6tVLlLU/bReRgzzfvE/ly+qrqFrMuDGE1
X-Received: by 2002:a17:907:84d1:b0:b97:7d03:68c1 with SMTP id a640c23a62f3a-b9c13b0441bmr228322266b.30.1775061260405;
        Wed, 01 Apr 2026 09:34:20 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c97218esm6313366b.9.2026.04.01.09.34.20
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:34:20 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66dd27d4465so1811164a12.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:34:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgXywISTsAOBZk7bCwYz31xuZris0Rn7Ipgw3Qc0LKFX3sXd+kBYPLg1IbJ0XVKKhgGik=@vger.kernel.org
X-Received: by 2002:a05:6402:35d0:b0:663:4315:7271 with SMTP id
 4fb4d7f45d1cf-66db0cfbdaamr2927572a12.23.1775060766098; Wed, 01 Apr 2026
 09:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-7-dwmw2@infradead.org>
 <CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
 <252823d75e9221647e7f8ccef6105432aabe8d6f.camel@infradead.org> <20260401080657.70cd9bd1@phoenix.local>
In-Reply-To: <20260401080657.70cd9bd1@phoenix.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Apr 2026 09:25:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5KW97ZHUi_5kCwC+Lh53_sj2HJ1SnBU1pQAOtnk7oGw@mail.gmail.com>
X-Gm-Features: AQROBzBuhMzLrgonz6WGspEvkWFhuj-ddiDGEYTFKbMu2F_LUT3de-t_k_EwsPU
Message-ID: <CAHk-=wj5KW97ZHUi_5kCwC+Lh53_sj2HJ1SnBU1pQAOtnk7oGw@mail.gmail.com>
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Eric Dumazet <edumazet@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
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
	Guillaume Nault <gnault@redhat.com>, Kees Cook <kees@kernel.org>, Alexei Lazar <alazar@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oss-drivers@corigine.com, bridge@lists.linux.dev, bpf@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 08:07, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 01 Apr 2026 10:28:23 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> >
> > Maybe on this date next year, we could make it not possible to build
> > the kernel *without* IPv6... ?
>
> There are some government agencies that used to require that IPV6 was disabled
> for security reasons. Yes they had broken old firewalls

I think you missed the big clue here. "This date".

Sigh. It's going to be a long long day.

              Linus
