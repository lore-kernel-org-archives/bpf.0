Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776064;
	b=m74fZ77pWKJ2A4VN8EST1a+jrM+tcFrdmtlNmkvBF0DsaliPzijPbHErtChFSvX0YQFU
	 +Oo3d8+ItCmoS/XUbfnZj2aicwGAe9GKkp4xI46MGNUzvcliP6ezRvEHCFMwfa9RAh19P
	 pyqHZrvb6xDScSaYr/FwwQXWbuu9/mReEOPgHrijZLfXuimTvK8Y/BwGD2m1INqOjWap0
	 zutKiVphH9ss4tuczrH1TAmN3gKtZCGMVeh9gqj7M7w9Y8vwltiPq2npEvkFM270tldYY
	 t/2LMi59f4b60LljU+qZmROlUfD0PY4Nx8QisFe8WMGgaLmd84Z/xFobwVHTWqOWhPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=46jt2PFBd8rULQ4Nt62VZapADm8oEY8BfGTGabREOUM=;
	b=2K0jBlmLrcW2DA/tWFs4g7OLljV3sRr6k4IflZ6DmR9/1v+7xvnyUMojnG4YKTEpFD+e
	 TurfUxUlfPYtdFbJ+Da+ByMxB9RhX2T10WdUTi0aV2Xq7HqtN9GWuFpKLV67h6Vo9NxBW
	 M9Tt6un9bY+ITrAr1PTJK0GQfRkYljHWLFuri8VKmxKjW4Z8NVR6UBWEhRg+JgGhefwR5
	 T8rLj/FGTFCwRwnaob8nTO0mP1ITzuPGIN/jDCJyzEV9xWHBMToS9EgMDlNWxiYNwCiyQ
	 jy8T+o2RmYc7HR6ix+gY1O877g4HcchPtnazvrwPY6Vth4prYOa7KA39WbG7TWP+tbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eDuPgHaR;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C270606A6A8
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C270606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eDuPgHaR
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a358881793so4178723f8f.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 02:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795776063; x=1796380863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46jt2PFBd8rULQ4Nt62VZapADm8oEY8BfGTGabREOUM=;
        b=eDuPgHaRC2KPGtaz+A22NSuvwSL5c0S2/zFOdQyD6aCjOhVgcuVtQjzSvQec+NBskO
         GFILsA7kxm2ho56P/w+E23h/xEs5Bem7Wa9d4t0P1GDu20HTExFjtSOd1tJGxqBAFBaO
         d3L+OTKO/C+IgE/s+bt2WgS1WLbycp27c+LeGecVVa44T/RJWT0vWgzhEgwHJS1d562p
         DGdJBkklROvvU8d8szblYMFAHpd/Wl1fSOK+1NkwhzPYY7haLhZraKOtRm5ar0keWauF
         k6LnC66mvpVU018A014jCvDM4f8SusXUeDf/IQwGlUpr/Oh9R/TlCUeFQdOt6gadcfak
         q22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776063; x=1796380863;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46jt2PFBd8rULQ4Nt62VZapADm8oEY8BfGTGabREOUM=;
        b=PVg5RNeFMyXPO8U3kvLfq0Ya18yYPJTQ93FgehrieeosCVC7Xtp8/xH49ptKcdcPlX
         YGk0Er/HOzwd947Fmg6N6f9Egs8q+56LvUVzgVqp00JvYt+XwY125BDGIBusn3QYm1vM
         S6cKndMRVgwb80MgjubuNnhD8Fn89mKYEd2Ari/MOSHsqXfmUXuNlqaMcY2MZTxSTOsI
         djginEL/6rFqVbMX3z2tBicHZLq9t8GOLg30km8ClZhGf0qCGJAIoKLhKxzfk1+D10AH
         SarVMF1Z5pfmInhWCraZNGQaH6HJN+z2Xmlr1QKizfVXtUbp2Vb2CBPwUxPaiI+jpki/
         uEog==
X-Forwarded-Encrypted: i=1; AL+hErF9LsNQEgd33eZP9V/t/p6Fy0yIEWAXMsPqjut4ikZEIoeJSWUciYh0FtfKz/GtYqsxbKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pbAcB/26/ilZkuba+GpQdoB6/W+OvsMoo6zyyxwtNQ4HgkOml
	d/Lkomp8sSUsqItv4issdpViUrKtWiZst0D5t6rGb0FUi9GArZthrsNI
X-Gm-Gg: AZFdTZdnTu7ByU9j3ViEmNhFbZzpb+03AfMnoLp/LwBNdyxUwypUlstA5GI8ZD0Cypw
	Uq8HUj4PVfX1lp9ttWvtRt+RPEGxjziLKpQ5XViMBcs9eVW/UkM+spspM93fhG3YhZGeBfC2KX1
	4QPl6DjTozRGWNqyxed8j8ixe84Ki1MOTh1evHsD8p6U5AZFnb8EY6OPzoyfF1xt3gSMnVyTKRA
	COXQO5ZCVy5Atn81HK1YzzqemxYw6qo76c604/0jDUWH6d7H8LD76CkZ64Lfh6ZQ1IGZZm2ygGq
	Ww9LL2jwL3o3Z4BlkvnsDkARX6yvRe8D5QVNexNG7Da7Bp0sbjoFkmo/9JZr/YgZeOIgKqDgeVn
	UaCeOrvSvYzQ9TSjNnv309TtbmflxepaAJLQa1A6Iy9s7YPzpm++Om92wpJB1UyFhwdVCbjTlan
	qUqmOLZUauroTa+R0uG5buRMCfcRSLD1SLOAxxusMUwqejkBj4Y7XL0wvIWlq+46xIj8EfylPS/
	1OFhlVz4QvH1NT3/pbedfzDo8Za/gA62P/RqzMh6efAuGFTHq8iaVjvecofZIksv7pqqW0Hubav
	wF9UjK3goYJ8lrddXxmlqEHWcPJvgjoNMN5oZ0x6vZChTRW3HBAhLJfXm/y1oPR9Ow==
X-Received: by 2002:a05:6000:470c:b0:4a7:593a:f421 with SMTP id ffacd0b85a97d-4abb73b557amr44307973f8f.47.1795776062532;
        Fri, 27 Nov 2026 02:41:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b2c9sm47910577f8f.31.2026.11.27.02.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:41:02 -0800 (PST)
Date: Fri, 27 Nov 2026 10:41:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, David
 Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, Xuanqiang Luo
 <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net-next v1 0/6] net: avoid stack canaries in TCP/IPv4
 fast paths
Message-ID: <20261127104100.3c915088@pumpkin>
In-Reply-To: <bffee809-2992-40eb-97c7-72d919de0aed@linux.dev>
References: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>
	<20261126102058.1fecf50f@pumpkin>
	<bffee809-2992-40eb-97c7-72d919de0aed@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Nov 2026 15:33:15 +0900
Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:

> On 2026/11/26 at 19:20 David Laight wrote:
> > On Tue, 24 Nov 2026 22:06:25 +0900
> > Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:
> >   
> >> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>
> >> With CONFIG_STACKPROTECTOR_STRONG=y, a function that has a local array or
> >> passes the address of one of its locals to another function needs a stack
> >> canary. The canary is set up and checked on every call, also when the
> >> local is only used on a path that almost never runs.
> >>
> >> This series removes the canary from functions of the TCP/IPv4 fast paths,
> >> by returning results by value, by using storage that is not on the stack,
> >> or by not calling a function that has nothing to do.
> >>
> >> Patch 1 returns the two mptcp_space() values in a structure, so that
> >> __tcp_select_window() no longer needs a canary.  
> > 
> > While all (I think) architectures can return a big integer in two
> > registers (dx:ax on x86), not all ABI do the same for small structures.
> > For those architectures returning a struct by value is implemented by
> > passing the address of a hidden on stack structure.
> > So code generation may be worse than passing the values by reference.
> > I can't remember the list of architectures, mostly old ones - but not
> > 32bit x86 because the compiler option was set when regparm=3 was added
> > for 2.6.
> > (Note that this is different from passing small structures by value.)
> > 
> > David  
> 
> Hi David,
> 
> Good point! thanks for bringing that up.
> 
> The small-struct-by-value pattern in patches 1 and 4 follows the same
> approach Eric used in commit 7a4cd71fa451 ("net: add
> vlan_get_protocol_offset_inline() helper"), which returns a 2-field
> struct vlan_type_depth to avoid stack canaries in callers.
> 
> I did note the 8-byte struct ABI distinction you mentioned:
> - On the main 64-bit targets (x86_64, arm64, riscv64, ppc64le, loongarch64)
>    as well as 32-bit x86 (with -mregparm=3 / reg-struct-return), both
>    8-byte structs (struct mptcp_space_info and struct skb_coalesce_res) are
>    returned in registers and the stack canaries are dropped cleanly.
> - On ABIs that return structs (> 4 bytes on 32-bit ARM EABI, or any struct
>    on s390x) via a hidden stack buffer, it indeed falls back to a hidden
>    pointer. Even there, the callers previously passed *two* pointers to
>    locals (&space/&full_space in patch 1, &fragstolen/&delta_truesize in
>    patch 4), so passing one hidden 8-byte return slot should not be worse
>    than before, while keeping the code cleaner and type-safe.

There might be a subtle difference in the function itself.
I think the result structure gets allocated on stack and then a memcpy()
used to copy that to the caller's buffer during the function return.
That may, or may not, be faster.

> 
> That said, if maintainers prefer packing the two fields into a u64 so that
> even 32-bit ARM / s390x return them in registers, I'd be happy to change
> patches 1 and 4 to do that in v2.

That is horrid ... and you'd need to use a u128 on 64bit.
It really is a shame that C doesn't have a syntax for returning 2 integers
even though pretty much all ABI have always supported it.

	David

> 
> Thanks,
> Xuanqiang

