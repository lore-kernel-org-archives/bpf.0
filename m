Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193715;
	b=lbK9cFCWs3li6hEhDaL54pbvHKScYNiIj49pRgTTD6x1/yiLr63mwa5gBd9Kcti0M8u8
	 umtumudvQ9Yl3URKVCDSSrzYLoTeGE4vtuUWF8AsgE4lIQdotvQI4xLQIHpNTLbcd1tK/
	 vx2lwunvRJJ/F8CwtSzVFpqMYwqfrQoHnJMXPajatKvgh6kh6qV9zQrfuX+Cw9Gu+0LLZ
	 ix1F/raQDGfq6pWNiDQw2GWjZfXdyurtRshhiqnYKqFyKM6MRHv4kBLW37o6Y30QhEP4V
	 qQ8F7I88n/1EahGlC34omuAdriRh5kEhnf0L3vs2E0D9JftqKttg66BFh9yHhxiANYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0sZDYHfCBUrE7G/AgueE+PrG6dEwDPLCmAlQ7vBMuvM=;
	b=0nWMm3C9I1gLB7WVQGZcCDyIs0ZTsF9z4rN7O9tK+x9NcwIcjbTjbUWAb4MI02wMpzLj
	 S27hEoeHqisR6q72nNKXBsJmWlnTYMurb7fSJR4/4gwtypWxANGBbYhp5a8T0Nsz8RpYO
	 sbykgxIEaw7A3lgL0lNp2Y1sO9MZiIgoVWSWb+uucW4heDymz4JFFho+l1soc2TaGh7Sq
	 vuDSE7vuMjujnyomNqzd8anEZMcTbbFdaDNfAsAT//EXWeqYuwfhKQwGeq/CJRz8pqOoM
	 mmM0ssF/WyY/KGMO6kenH0DdQrTUAHU1gOxGPU+IJYzvNa94p/0F0ysAkejspRKAa8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pt7WhZXe;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CF606A333
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 03:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 372CF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pt7WhZXe
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so323856a91.3
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 19:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794193714; x=1794798514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0sZDYHfCBUrE7G/AgueE+PrG6dEwDPLCmAlQ7vBMuvM=;
        b=pt7WhZXeywLb/bcQV2nL6QpkS6JEXGU1cssautcEf6mWoJC18Gr54ooaweb+t1ZFIE
         ghCjULBymeJWwH+qHK0m1Spx+TGMO7fWA2VEegBq5iws/+OKiAROe4ChxlkcrC6TXsu7
         WT97TK8qLmt/p895r9JSxv3Qdcu1UKN5ZdMtLrmiwjFTBHBNa29uUxZ1SUXJBuWNMrem
         RXbIrgMJILoskHstKp8XhrNVuesrbsywHykYMIn3llw5DKc5SzjrQxZfDAE6Cz8XyXbl
         ihhd2u7ePq5vCeNgxuVZd2bAObcHZa59CgKxl4MwoUuiC9m1mxyFHKyrMSC5UyvM1KFB
         PHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794193714; x=1794798514;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0sZDYHfCBUrE7G/AgueE+PrG6dEwDPLCmAlQ7vBMuvM=;
        b=gP7L5FJtabSy8E/V9HQ8BIfDqtzCagLTHgueoB4d7TaJ5q1lcUE/dqJOXbEaZNDK16
         APOhvE4wpLHmgKcEnuBASViHOAYSdx8Vew0NtFytc4xa/uImwTWAPvha8ZLBrlhgbakH
         gChpjp0n2ePJXxUQyYV7vtyzy7YiD7Ek7ogdEnhr4wrc2tlF56Qej/HfuYjdPR98del9
         m6y53sMsNTritY1nuqxnVAF8lPVJV6bQ/1RI62/vCfSp+an9wr0HQRT5CWAKoGruweVk
         K6blCASJbVEzaUjNgc2BF7/NKHZCABk2ImKZwhh/BR6hqnSGVTEvq9yjtXD9dclLMxaN
         JDyg==
X-Forwarded-Encrypted: i=1; AL+hErGoYCP+NpPQFphybHKz84epsJ6ygNtmaNNj2M5PCyYnQGwB74PPCBqzI4BsZAYwriGQ2h4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Y0SYTAEEEANiUEHAHiV8FvH6NNfUWyrozmnJunE9HCicKYm5Z
	Jjw/sIqEwz6LCS0RtYbe0u06uEYhkvz5YJtS4hz2vn34hUlL1IEQO61HB4tYw6AzX2w=
X-Gm-Gg: AYBFou0vfKsgU7SFAIhqHS0s7y+0DvgkNsDULRpNMn6H78VucNvUvISXd7D/03RlRlH
	vfTeez/o3OSsGu7g8sMki5LXuu+Rk8vzcOKBZx9k3FvhZplllxxILE5cAtFYeViSVMg8KeLicfm
	IPGRfp23Wx/DHnKhuLosldVyK0NMbn6PhaMeFq/hc9HgfcvfDymmKN3Fgi06J/PIEtzJE8mMqvb
	3VHpWSAE0VHpKh1w7nwOS57SHrWQWqz9XPSuw+QPWngUMis89e0A9oseZndj+G1ASCqUkJohjn2
	1J8SLHckQ53XfC4KeggOJJnJHePs3xF0+0tIvKsCcUO8w4jFX7BSiZcqDZ241E0g/E8bfhX9QqE
	zGqw8EL4UBGZ9PmNoV2ir1HhaHu/NqhC+5urFa3De1k7ji5NWiI0BYOlOLgfgsjbL4hf5HJ3Mr0
	zT3HVGLEmGjuz6I/fUAPE/9/f9jp4RijKqP1PwAztE6fFRYIwVmLLhI7tCOj9CgQRl7Sidy3ChP
	cJqgIx9GuzardG7UBQXfIImUhI4v87AltGlALjWQpPI1APExftXoVt5ZrMwOpKlWHETgyg6bGOp
	9aArLSPUQ9GhnG145ucfvQKWXcn49n0K9F30L1dM4/y+I5Rtp4X6+D/zdEr2N9WIFJuM73nu
X-Received: by 2002:a17:90b:2d87:b0:3a0:9c9d:eb18 with SMTP id 98e67ed59e1d1-3b12d479035mr2604915a91.54.1794193714581;
        Sun, 08 Nov 2026 19:08:34 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1032b8c55sm5027795a91.2.2026.11.08.19.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:08:33 -0800 (PST)
Date: Sun, 8 Nov 2026 19:08:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Tianyi Gao <tianyi@cloudflare.com>, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, Simon
 Horman <horms@kernel.org>, David Keogh <dkeogh@amazon.com>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, David
 Woodhouse <dwmw2@infradead.org>, Dragos Tatulea <dtatulea@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>, Alasdair McWilliam
 <alasdair@mcwilliam.dev>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Alexei Starovoitov
 <ast@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
 <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Breno Leitao
 <leitao@debian.org>, =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5l?=
 =?UTF-8?B?c2Vu?= <ast@fiberby.net>, Danielle Ratson <danieller@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@cloudflare.com, nh-open-source@amazon.com
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and
 LL_ALLOC_SPACE()
Message-ID: <20261108190831.3f991a13@phoenix.local>
In-Reply-To: <willemdebruijn.kernel.2c6a653eb65fa@gmail.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
	<e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
	<willemdebruijn.kernel.1d64e7848503b@gmail.com>
	<20261107182526.69543-1-tianyi@cloudflare.com>
	<willemdebruijn.kernel.2c6a653eb65fa@gmail.com>
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

On Sun, 08 Nov 2026 10:13:03 -0500
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Tianyi Gao wrote:
> > On Sat, Nov 07, 2026 at 09:51:07AM -0500, Willem de Bruijn wrote:  
> > > Tianyi Gao wrote:  
> > > > From: David Keogh <dkeogh@amazon.com>
> > > >
> > > > Add a tx_extra_headroom field to struct net_device for that purpose,  
> > >
> > > Main high level concern is just adding an extra field. What's next,
> > > do we need to add a field extra_extra_headroom?  
> > 
> > Thanks for the review.
> > 
> > A user needs more room either in every packet or only in new skbs.
> > needed_headroom covers the first case and tx_extra_headroom the
> > second. I do not see a third case.
> > 
> > needed_headroom does not only set the headroom of new skbs. It is also
> > the minimum that ip_finish_output2() and ip_forward() require of
> > existing skbs. Raising it for new skbs also raises that minimum. With
> > XDP on a veth peer and needed_headroom raised to 256, throughput drops
> > by 2.8% to 5.8% for local TCP and by 4.0% to 20.8% for forwarded
> > traffic. The cover letter has the detailed analysis. veth also cannot
> > set needed_headroom from user space today.
> > 
> > pahole on x86_64 (defconfig, net/core/dev.o) shows that the field fills
> > the 2-byte hole after needed_headroom, so struct net_device does not
> > grow:
> > 
> > before:
> > 	unsigned short             needed_headroom;      /*    60     2 */
> > 	/* XXX 2 bytes hole, try to pack */
> > 	/* size: 2688, cachelines: 42, members: 187 */
> > 
> > after:
> > 	unsigned short             needed_headroom;      /*    60     2 */
> > 	unsigned short             tx_extra_headroom;    /*    62     2 */
> > 	/* size: 2688, cachelines: 42, members: 188 */  
> 
> Thanks.
> 
> Pushing back on another design choice: the UAPI change. That both cannot be
> undone, and is fragile and laborious, requiring manual admin arithmetic.


I agree with Willem. This is heading the wrong direction.


The more wordy AI analysis is from the iproute2 patch side:


Network configuration should not require pre-guessing this value. To set
it correctly an administrator must know which TC egress programs are
attached, how many bytes each pushes, and whether XDP is attached on the
veth peer. That is a kernel-internal sizing decision being pushed out to
user space, where the information is not reliably available. Worse, it
goes stale silently: attach another encap action or move the peer to a
different netns, and the value that was right at "ip link add" time is
now wrong with nothing reporting it.

The reply that a stale value only costs performance is true but does not
rescue the design. The entire purpose of the field is performance. A
setting that quietly stops delivering the benefit it exists for is one
operators carry indefinitely without knowing whether it still helps.
Failing quietly in the only dimension the knob was added for is the cost,
not a mitigation.

Since the motivating case is XDP, the mechanism should let the XDP program
ask for the padding it needs, rather than making the operator translate
the program's requirement into a device setting by hand. XDP already
guarantees XDP_PACKET_HEADROOM to its programs. The requirement is known
to the kernel, in the right units, at the moment of attach. Propagating it
from the attach point beats an administrator's arithmetic and cannot go
stale, because detach undoes it.

Your own reply already works this out:

> - XDP on a veth peer: veth_xdp_set() and generic_xdp_install() can
>   increase the headroom of the peer to XDP_PACKET_HEADROOM on attach
>   and reset it on detach.

That is the mechanism, and it needs no uapi, no operator arithmetic, and
no stale state. I would rather see it implemented for the cases it covers
than add a permanent uapi that removes the incentive to do so.

To be clear on what I am not asking for: this is not auto-tuning. Your
objections to auto-tuning are good ones. The kmalloc-2048 to kmalloc-4096
cliff being crossed without anyone deciding to is a real problem, and the
reset-on-detach bookkeeping across namespaces is real work. Attach-time
propagation is a different thing: a known requirement, declared at a known
point, with a natural reset.

On the argument that program-side declaration is itself new uapi, and that
the labeled device is often not the device the skb was allocated on:
granted for the general TC egress case. It does not apply to the
attach-time propagation above, which is in-kernel plumbing rather than
uapi.

Which leaves the genuinely hard case, the one you describe at Cloudflare: a
service in a netns sends through a veth pair, the host forwards to the
uplink, and a TC egress program there encapsulates, after ip_rcv_core()
has orphaned the skb so the allocating device cannot be identified. If
that is the real residue, make it the problem being solved and argue for
the narrowest mechanism that solves it. As posted, the series leads with
cases that in-kernel propagation handles and uses them to justify an
interface sized for the case it does not.



