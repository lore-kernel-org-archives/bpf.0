Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283563B636B
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311789; cv=none; b=Uke797NIzeUzru0KvGR/V4OiPtaOa8QWkZto6DFNMugqxGUty4xgI+YMi00hchpBabyn84kh8MI+ukpPl16a5FNSMVT4VZHK4vR8W5ULuQ8JLCCjTLrFkgLyK4oOqRTYmmh/OkGRskidz3tnzfPUlJCSD1ElwwpM3ChunhuPqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311789; c=relaxed/simple;
	bh=U4scEkwLlZ0VuAmkLypf9F9edX/OF61hxlh8178UWxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+H9ce6uk/RwJf+/PruZHuPyZ2or7bIqqdJRMYpsDl/we7ObLs81zslL/tzBPPV/chHaNqiApMY2l/EmZWhlQ3ZEDtUXk1HPtoBwq8pmT0wpYofJscyu1l2JfWxfJJAVhPUagN/4yPRC0HhnnoO7eErL1/j1fzbkXBUF37l/W8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xp0hcXsa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKZbzCrh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp0hcXsa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKZbzCrh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773311786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pr+iZcW0Vr1rZJU+b396wxsEji96fYKMPY7NwZ0isYc=;
	b=Xp0hcXsaen/FaUNGVnwczL4Z7gg2isaP7WLifGG3FOJCI18vkH+BlO8yRpoY5uEyC7aIFH
	1oWAnf/upkKtwDF+Mf4FdweehBBqucQHirXcqev4NFTsJ8tYfvEvWdH08yWOKfzSXKoYF+
	yviCDCDdoH+bVYA5cAAiSNPzQ0hoxMA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-p9LyVpwpN6qSgR8Sk33qbQ-1; Thu, 12 Mar 2026 06:36:24 -0400
X-MC-Unique: p9LyVpwpN6qSgR8Sk33qbQ-1
X-Mimecast-MFC-AGG-ID: p9LyVpwpN6qSgR8Sk33qbQ_1773311784
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439b8858b0cso827492f8f.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 03:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773311784; x=1773916584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pr+iZcW0Vr1rZJU+b396wxsEji96fYKMPY7NwZ0isYc=;
        b=SKZbzCrhAwNnxZnaxQFPdwxbGklU0PMxnb0TP9YQ+rHtghOeCcW0NolpUNwZsj/n7X
         FLFNvNc4tU5O+JM+tmFX1fMwiaYt75Px7FmKOT0I0qB6WBhec9j1LeXablK4Fldl9Xcb
         nUYgQ9dKRjBr3Vp7apb7+KOQ+hLPosi4+cyEco3U3OFj8sQHq/9p1KDI+hRJAgD6Uj7I
         DrcyA28xIdZHoTB9Tc5EXzbpCHTKm1dije/06zL8YdQ0PCbfi+uq4NIoKmPtlVkJdvw0
         AieWLzoNp1q2dron/zgAIHvoA/Awu/maejeqRTwKgB2paHGGeQ2kHKPI31DhJ35MYfh+
         Mi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773311784; x=1773916584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr+iZcW0Vr1rZJU+b396wxsEji96fYKMPY7NwZ0isYc=;
        b=QDiSXh9bxVlKZotMgoPhCm9GycqlqJvzv4sp2X4N7YT5GwYnDzZ3xLAkDqZZ3ARfvj
         koi28sNdz0HFMeL/fjc2ArtIUoncTBQMOwfBVFwYppYdjyGjXOCzh4vCyvO2vXizN9ES
         Xx7IrmTUp2VJTF1mxZ2W5F9gUsLECPvHvGecmOHBZfNPCe4q7GmmUDyfnsI28Iv19NoO
         DPeiPRo4ZoDnOtALktOQwknOriGRG0FyHoilJJfC1h68lz1SM5xPC2eFrSge0bXOKC/d
         yPNj4BLM4KemU9cZYZWfgd6tVHqkqaSWLToyibhfzS4M3n9//x6mVMlc9+ZjG5FeoXAH
         CULA==
X-Forwarded-Encrypted: i=1; AJvYcCXiSW38qok0HyjT+LMsyph9m0cJLGN9ThRTa894EC8k+f15D6WIQ+FKRun9eYnwr1CgO4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy88F4WpnNfuuZ+BLjfWJtIvgfSXF7OGV+vdHbooeRds5z9TFug
	s8ArEQ9/0I0UXGI60MRJIhYDwF4/PO8UxQW8nGr79xugo926IBR8+vWSAHYHlkLaZx5ErkYuXhk
	N4Tac4VeHhr+EjragO1eCDB+Rpohbc03B1wEO1wltibbFH/7qJ1Imjg==
X-Gm-Gg: ATEYQzwanh0YllvKeYGNof31wst/jhpkoTEZvc1lYhAvEf5DT+VBRrWCyg6UssQzvCa
	Z1Zn8tu3pgWHJrDm6jRnMNPk5sZm3ugTIo9K6zsHVYBkwuq5/nx+oaCkmk0o9isuyOPD/qhK4qe
	0JvbsEH9fMIvxBDCdG0IMadMItF6p5YkJD2+d9g6mkn/J4N73Bumi4BP5EqPi/oRyuyrD+alHkh
	XBYY/OcV255OM9chV2gmh7hVnmFOndtkuvxVLqkQIcgqhMAjHxScbu0Z39nbv0NuuaU3ryCcLhO
	HQVADG5xT14+gO4xPReGYObBWmKqmKwBQ+DiIfYq1nlpzDx8jYto4AmmkJVFpUbJfJG9KPsu6ZZ
	Wfy+sqtbfR+YCH/HTvIkqX/rh2Gx9QoVu7HMjVIYygFeyWdJTPDDX8Bg=
X-Received: by 2002:a05:6000:25c2:b0:439:df60:f87a with SMTP id ffacd0b85a97d-439f8434264mr10631501f8f.46.1773311783591;
        Thu, 12 Mar 2026 03:36:23 -0700 (PDT)
X-Received: by 2002:a05:6000:25c2:b0:439:df60:f87a with SMTP id ffacd0b85a97d-439f8434264mr10631438f8f.46.1773311783136;
        Thu, 12 Mar 2026 03:36:23 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c0b4sm8118630f8f.25.2026.03.12.03.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 03:36:22 -0700 (PDT)
Message-ID: <8d746046-eed9-4d82-a064-c20b6a131bdc@redhat.com>
Date: Thu, 12 Mar 2026 11:36:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Eric Dumazet <edumazet@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 jiayuan.chen@shopee.com,
 syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
 Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev> <abAFRbJNinhN3O5v@penguin>
 <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
 <CANn89iLOyWzWW7w262Vsy2MOMVDXA0+UZGpEbsdLwe6e75mhKQ@mail.gmail.com>
 <abARG4sHFdUNqcRV@penguin>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <abARG4sHFdUNqcRV@penguin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/10/26 1:39 PM, Nikolay Aleksandrov wrote:
> On Tue, Mar 10, 2026 at 01:07:15PM +0100, Eric Dumazet wrote:
>> On Tue, Mar 10, 2026 at 1:00 PM Eric Dumazet <edumazet@google.com> wrote:
>>>
>>> On Tue, Mar 10, 2026 at 12:49 PM Nikolay Aleksandrov
>>> <razor@blackwall.org> wrote:
>>>>
>>>> On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
>>>>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>>>>
>>>>> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
>>>>> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
>>>>> when the bond mode is round-robin. If the bond device was never brought
>>>>> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
>>>>>
>>>>> The XDP redirect path can reach this code even when the bond is not up:
>>>>> bpf_master_redirect_enabled_key is a global static key, so when any bond
>>>>> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
>>>>> interception is enabled for all bond slaves system-wide. This allows the
>>>>> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
>>>>> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
>>>>> reached on a bond that was never opened.
>>>>>
>>>>> Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id()
>>>>> before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was
>>>>> never opened), fall back to get_random_u32() for slave selection. The
>>>>> allocation in bond_open() is kept, with WRITE_ONCE() added to safely
>>>>> publish the pointer to the XDP read side. A plain read suffices for the
>>>>> !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
>>>>> under RTNL lock and is the only writer of rr_tx_counter.
>>>>>
>>>>> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
>>>>> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
>>>>> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
>>>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
>>>>> ---
>>>>>  drivers/net/bonding/bond_main.c | 9 +++++++--
>>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>
>>>> This is Jay's patch + the unlikely change, looks good to me.
>>>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>>>
>>> Orthogonal to this patch  :
>>>
>>>  get_random_u32() typical cost is around 10 to 20 ns, I really wonder
>>> if this makes sense
>>> for the packets_per_slave == 0 or 1 case to haves this kind of
>>> randomness in the first place.
>>>
>>> Perhaps we could use a
>>>
>>> static DEFINE_PER_CPU(u32, rr_tx_counter)
>>>
>>> And :
>>>  slave_id = this_cpu_inc_return(rr_tx_counter);
>>
>> I also have mixed feelings about this patch.
>>
>> We probably should detect that the device is not ready before hitting
>> something deeper in the stack.
>>
>> Sure, a NULL deref is avoided, bu what happens next ?
>>
>> We send a packet while the device is not UP, I am pretty sure this
>> violates at least some RCU rules in device dismantling.
> 
> IIRC when the redirect continues, the packet should get dropped if the device is
> not up (checks at a few places), but that's outside of bond's jurisdiction and
> after the slave id is needed in xdp master redirect's path unfortunately.
> I'm not sure it can reach much further, it just has the master dev's slave id
> generation in its path.
> 
> In any case we shouldn't crash in the slave id generation in the bonding,
> that ndo's only job is to return a slave id.

I'm sorry for the back and forth, but I share Eric's concern. I think
the approach suggested by Daniel:

https://lore.kernel.org/netdev/4d15be93-b497-4499-996d-9f3a67a2abc6@iogearbox.net/

or the initial patch form:

https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.dev/T/#m7c67bb12f85bc88d583788fb6e41113c46208ae7

would be better. To respond to old concerns raised there: the check is
IMHO bond-specific, as control moves from the lower interface to the
upper bonding device, and the code is under an RCU critical section, the
device can't go away before the xmit is completed.

/P

