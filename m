Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B840C5B0
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900260; cv=none; b=kwzfzNXE4Y2e1vonAhQZf+5pN/E+LM2khPi2CQ6OsbpdspbH0zuX30zZSo+vn5hhRwqJq6J62VTJZDjXbQ3jQtJR1jcMR2j1Il3+TNw9lbZEJKZCOP1Q5S6bObedUDKyQJdX6V+LgjA6VVppJ6hhaPmterrOLJUrqGXmXEWnTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900260; c=relaxed/simple;
	bh=qDt4IJXQvKhSSerbr9KXeA+PEQui6XrmNBKRGQz2I48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TEz+KaQbHuo8AXr71SaV9N2oVimSyAyjhmpa3ZHs0Uat/AdriMVIQ+Clv73g9nb7N/4l6BzPiR5l3hUeJoYwE2l4SfJ08cwouUdTCBr267yQQRS3kXOWFktgiBi1Vmb9P0emdOAYPri+jL9grIPuboJ8nUk+7uJI2huM9JIx4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=M87KMhdW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="M87KMhdW"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6986287534eso771406a12.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 03:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782900257; x=1783505057; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bT9HoVUGh6XBwX6Pxk2VzEI2sj1gJsAoh4mTRhpR9ew=;
        b=M87KMhdWiWAYpzTFrVall3N+fOXOuIdU0RAXU1ZTclTeHO00kneSM6z1CDeiY/vSVW
         P+9BwzUlN0IZyFgM0c+dXZLOW8j3/cRAzNWBurxJowenjNxF6OmQ69ly3ggPr2gj8915
         +gtArshZ1hqg6JAZS4TJdiYcTKrnNA422qfTjj5Z7kZP9ntKsCyjMgpKGNCAnbyAbJOy
         9I8BdZgRzG/hFtX7j+lyxVHRFgasXrvJwd6KygSTMBCS6JdpyMJRA9F1RjB9FyC7JXVc
         aRVJb6lG51/0pgFPBFzoXiyIls4KFG0PRcHlBXnaqiadKht2Lteyrq4VjulyW4jXjFra
         DznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782900257; x=1783505057;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bT9HoVUGh6XBwX6Pxk2VzEI2sj1gJsAoh4mTRhpR9ew=;
        b=EPbpcBPr1IsKLaDwFbzSandyZJ21ETeTTs51LC5zWZ8WC9kPiMPXFJaHj5hLIv8PHZ
         PvmBnT28gwq8yKBgwgQ2DLg6ahSrRbpzADJ4ucZvI++YVql8MIRq8Vj9FWnwfNstNhas
         Xk3lUSci4c7/A8rAoxqrbJOHU5v3zkdDKhNmRb61PDmBIyrOB0DAQxoLk6zxAOp7SxuL
         Cz/PzvStzOMGC07DIxZp6s8czDkyaFO/M6A+gRZkguhCkcRVohk2SeoIkzoMT3BZksNP
         iu7kMn+ZtZWr92ddOXUpYLhkFuPipXxREEKsVeiBVG9xJ+AR6XqWtIaHUidcsa453saR
         jO6A==
X-Forwarded-Encrypted: i=1; AHgh+RpCI35O4uJy8AQzBzWeqDU5Hl51z18ZKVqoocuuUeYNgCRAjHp0njjbDUjQYEKMB30t8xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFYWTnpCtpHFsZJG4EiAFWnodXKdJJ8mcl/n/vGR7rPcxAGiOu
	OKk+gQYEBXgyyT+k3GPB7imMG61SaTXbQhnRPorg0hfzJupA/fr+XnMU42ijhPl55UGO5TLf0Ja
	81gyaeUQ=
X-Gm-Gg: AfdE7cmX4fhVgkX0KwU8+NEn4vmfvOY+TjbyCb0jGUW5KO3L3CmhXgBA9SRLNRz33qc
	5GMtmaM63gd1PH0KZyseg3CS9KgmqCuGMwbcMKws9R/mDLVH3LwmyMzFeL4gm17u9RqujNeBtxG
	ArlwVIS50v7gKe9MNVZp45wKbJAgHwiXFD0mfLm4ShmJoiyG5MPcY1A7rmcD7EgkFWC26H/0WpU
	zFWgba+vMDNn4lAvOikPnuZPSiQbRgBiMVKKx0bk1GDNdLsxdzLSlXQUrCBtpiFMIVYKbSCHcE3
	TDzD7mCbEjq/AflCjRGs4Sat6fOpR3JtNOpRw025tR0MH5x5/3jcaYAW0G4pdBg5ORA0oPaHfRb
	V/aQuVti7WYpejHVh4sZX05E8g+nYZ32zot+HrTcTnnFdaIKAkBuCe8eJRxA4u5gk6/nGnTC7Tg
	Wk
X-Received: by 2002:a05:6402:26d0:b0:698:821d:aa37 with SMTP id 4fb4d7f45d1cf-6989f378252mr441815a12.24.1782900256737;
        Wed, 01 Jul 2026 03:04:16 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c968201sm2389522a12.24.2026.07.01.03.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 03:04:16 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: sashiko-reviews@lists.linux.dev,  bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
In-Reply-To: <26ecbce0-48ad-4b53-a0b7-34b59870e010@rbox.co> (Michal Luczaj's
	message of "Mon, 29 Jun 2026 23:40:49 +0200")
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
	<20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
	<20260626205814.BAC3C1F000E9@smtp.kernel.org>
	<e08be4f5-0bd9-4228-843d-86ed20594bac@rbox.co>
	<87v7b137cx.fsf@cloudflare.com>
	<26ecbce0-48ad-4b53-a0b7-34b59870e010@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 01 Jul 2026 12:04:14 +0200
Message-ID: <87echn2fhd.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 29, 2026 at 11:40 PM +02, Michal Luczaj wrote:
> On 6/29/26 13:37, Jakub Sitnicki wrote:
>> On Sun, Jun 28, 2026 at 11:59 PM +02, Michal Luczaj wrote:
>>> On 6/26/26 22:58, sashiko-bot@kernel.org wrote:
>>>> [Severity: High]
>>>> Could a memory ordering regression here allow unbound UDP sockets to still
>>>> bypass this check?
>>>>
>>>> In udp_v4_get_port(), the flag and hash are set:
>>>>
>>>> net/ipv4/udp.c:udp_v4_get_port() {
>>>>     ...
>>>>     sock_set_flag(sk, SOCK_RCU_FREE);
>>>>     sk_add_node_rcu(sk, &hslot->head);
>>>>     ...
>>>> }
>>>>
>>>> Because these stores lack a memory barrier between them, could sk_hashed(sk)
>>>> return true on another CPU while SOCK_RCU_FREE is not yet visible, allowing
>>>> the leak to still trigger?
>>>
>>> I'd like to verify it on a weakly-ordered CPU; please give me a day or two.
>> 
>> False positive, IMO.
>> Both ->get_port and sock_map_sk_state_allowed run with sk_lock held.
>
> What about an update coming from iter/task_file? You get an unlocked socket
> via bpf_sock_from_file(ctx->file). And sock_map_update_elem()'s
> bh_lock_sock(sk) doesn't care if socket is owned.

You're right. No exclusive access to socket there.

I think we should block map updates from all iterators but iter/sockmap,
where we know the socket is already in the correct state.

This is in the spirit of the API lockdown that is in progress [1]

[1] https://msgid.link/akRZ_e7DJh2aP-2i@john-p8

> I was looking at iter/task_file in the context of [0]'s follow-up. With or
> without [1], we're getting closer to enforcing (stronger) locking in
> sock_map_update_elem(), per Martin's suggestion. Along the lines of
>
>    if (!has_current_bpf_ctx() && sock_owned_by_user_nocheck(sk))
>       ret = -EBUSY;
>    else if (WARN_ON_ONCE(has_current_bpf_ctx() && !sock_owned_by_user_nocheck(sk)))
>       ret = -EINVAL;
>    ...
>
> Would that fly?
>
> [0]: https://lore.kernel.org/bpf/20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co/
> [1]: https://lore.kernel.org/bpf/20260629172704.1302218-1-rhkrqnwk98@gmail.com/
