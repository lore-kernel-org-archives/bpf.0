Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110493DD501
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146403; cv=none; b=GwBqMhI14oIaCUqrWan4AeaoEmBD7aOPoc/cHmbQXkg0LiY16BRgJgcxxkXKpDtiw4BRE4DeUaItCfErR0JNfhMEVXYIkB1l2uswO0JROhSko5kBpjrKt0F2TWiVmiD966oPsdGob8l8monQiVgxNtm9HISD4ay6iMQjB4SxLIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146403; c=relaxed/simple;
	bh=b3fiJZPf+KksQH1z66J9vDcRdtI6eXl/7HGK7rAUDG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmLwHxmRtgLbRXzqBWuRX+utZTnAsb4lO3qsQUVFiomc0860NtDClXi9J9s+PqziF91hu9OUxtJoQkBpLooIwM33waVHfrWm9C/fljFJHgVDR84ZAxaXJMFCZ7VcMm03Fe/xExAcZ+1pwF/kA/lbZCNaLXBQtu/IudiadeptlwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=EmVWikST; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="EmVWikST"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4671119c1c0so1116315b6e.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 05:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1773146401; x=1773751201; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mtNh8fAk+ErgpMDFlX2j7RYrdoBeiifVpivZrCpt870=;
        b=EmVWikST/8CfFRHcbCpySgDWfVI2qrR8f2Y97MpcPLLWR8RPuFqxnuQBUk/eECiOqq
         qmrlfs6g9pwJ5K4qG7p0rmEZh74stvC7Ntunk+G8OV+7XEXcV4yyRC4JKnhbRuzoo/wF
         zg3/guyBGv8VlMfpCK/gaKzGZNKwOvSQT6iHtaiYTxwR8XjzQt9Ya9JtH5uGm8P1KdXf
         IW8UpTeB6WaV2757AhanUBzjU96X2U4vL5u7BaXs9Ioq57zrYsNk5/0AyAlVYL5M12+V
         JJ4Mrc8Ydj53bI5mIVLiACXQCLThm4Pk1VuMzrVsp33X3qeltn7jTGqcihmn07ktVIJD
         HvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773146401; x=1773751201;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtNh8fAk+ErgpMDFlX2j7RYrdoBeiifVpivZrCpt870=;
        b=qwFZbbrgdPRjBl2mruu4wsmkB2u7DIikUyWA4dbD5Ydzst7+UapGSVLvV7vJXFZFcO
         U6hgvOS2cQ4/Q3rzIZU8JrgrE5tnZ3ifRI3zlrdpVp7g88l/U6HcJ9XB5LrOk4JvBgoj
         dlJ8F7aWzVv2caRUDogx2hzq8O0iHPaqH9QZKr8R9cVeIZkVVDZfvHuuJcYCOX2YhaIu
         EmXHQdb2i6brdsHTYo7n9BeIcD/nt2iU5uHkMI4QxOZee30k6tybcDzygTs0PWDWjUhZ
         O/04tJAjOjIXwk4ABv3ZpDNYLjOIKb+f4TzlTzLzUbQZJE/MRA7L4B2RY8HiSEQ1AI2r
         bmTg==
X-Forwarded-Encrypted: i=1; AJvYcCW9KPHpAM+uGECaCMLsCcKgqETrBaPhN7NNaJi3xpEOfGIMvTkHhBeChY+xIQqrHlQx/9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlf8KoLWwJirl7krRm4Rlrg2xsUOYsVYM78m3BxBi8K6iYZXdt
	iNk/rOOdVeWikeZD83ZTRvN3G0L86OrQOT/lP0nHKZ3DOGnS30FRrxDUsxEvQ4Wy4Wk=
X-Gm-Gg: ATEYQzw08iJi1WSJLEPnzrGohgf+fm0XyFMJL77NjNfc8M7XldcWZu0LLZKaBYuEJeJ
	RijeeBA/gXUJ1hnn9apQaShPzqsGLWOVJ8/P8q5jbzZBshjBtdccDjuTZ/2y0dBK2VS/64cJ5DS
	0syNGz8/n5gNAhzR6MzZs6JZve0vhlXHFuryBSXt56bgGI5TQ2ltWc0++OifLmnNjkcsgOq5UkF
	Jyf3h/nO0QjqZnpAfYCcI7t5wR1IooVzZMAwx52e6/UfT2FRt2z3nAV8qM2M4SHX4tek2+Trthu
	ZzfmdgTpPnGbmPVMgZLhrUXmJKkOH5QopswvueCT1Nca9gx5HKcYcd/84sZJjXE1w/LUlPo5wC9
	VS7gAeiIVziMi4djVjVYQhbz0kAbUveaclOlPkBcBfLOt0vlehpxbgoi3xCHmKcUuBzBbiLL0BI
	knI0E9A9kRylAZE3y3ZkK5
X-Received: by 2002:a05:6808:221f:b0:45f:174a:1297 with SMTP id 5614622812f47-466dc69625fmr7733846b6e.0.1773146400893;
        Tue, 10 Mar 2026 05:40:00 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46718c843e6sm2261455b6e.12.2026.03.10.05.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:39:59 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:39:55 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
	jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
Message-ID: <abARG4sHFdUNqcRV@penguin>
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev>
 <abAFRbJNinhN3O5v@penguin>
 <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
 <CANn89iLOyWzWW7w262Vsy2MOMVDXA0+UZGpEbsdLwe6e75mhKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLOyWzWW7w262Vsy2MOMVDXA0+UZGpEbsdLwe6e75mhKQ@mail.gmail.com>

On Tue, Mar 10, 2026 at 01:07:15PM +0100, Eric Dumazet wrote:
> On Tue, Mar 10, 2026 at 1:00 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Tue, Mar 10, 2026 at 12:49 PM Nikolay Aleksandrov
> > <razor@blackwall.org> wrote:
> > >
> > > On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
> > > > From: Jiayuan Chen <jiayuan.chen@shopee.com>
> > > >
> > > > bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> > > > check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> > > > when the bond mode is round-robin. If the bond device was never brought
> > > > up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> > > >
> > > > The XDP redirect path can reach this code even when the bond is not up:
> > > > bpf_master_redirect_enabled_key is a global static key, so when any bond
> > > > device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> > > > interception is enabled for all bond slaves system-wide. This allows the
> > > > path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> > > > bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> > > > reached on a bond that was never opened.
> > > >
> > > > Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id()
> > > > before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was
> > > > never opened), fall back to get_random_u32() for slave selection. The
> > > > allocation in bond_open() is kept, with WRITE_ONCE() added to safely
> > > > publish the pointer to the XDP read side. A plain read suffices for the
> > > > !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
> > > > under RTNL lock and is the only writer of rr_tx_counter.
> > > >
> > > > Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> > > > Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> > > > Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
> > > > Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> > > > ---
> > > >  drivers/net/bonding/bond_main.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > >
> > >
> > > This is Jay's patch + the unlikely change, looks good to me.
> > > Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> >
> > Orthogonal to this patch  :
> >
> >  get_random_u32() typical cost is around 10 to 20 ns, I really wonder
> > if this makes sense
> > for the packets_per_slave == 0 or 1 case to haves this kind of
> > randomness in the first place.
> >
> > Perhaps we could use a
> >
> > static DEFINE_PER_CPU(u32, rr_tx_counter)
> >
> > And :
> >  slave_id = this_cpu_inc_return(rr_tx_counter);
> 
> I also have mixed feelings about this patch.
> 
> We probably should detect that the device is not ready before hitting
> something deeper in the stack.
> 
> Sure, a NULL deref is avoided, bu what happens next ?
> 
> We send a packet while the device is not UP, I am pretty sure this
> violates at least some RCU rules in device dismantling.

IIRC when the redirect continues, the packet should get dropped if the device is
not up (checks at a few places), but that's outside of bond's jurisdiction and
after the slave id is needed in xdp master redirect's path unfortunately.
I'm not sure it can reach much further, it just has the master dev's slave id
generation in its path.

In any case we shouldn't crash in the slave id generation in the bonding,
that ndo's only job is to return a slave id.
