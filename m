Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8EA40DFD5
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777069466; cv=none; b=rv+SBjh7A3jqMyhgxeXk/YUgos2ISR69dUmslV5y8WBXcax6G8Zg3Y9dEk5zXvg4l8SjFNWMLg9G0N24C76DHtNo/dt6GPfYPfyg4Fg8wdySeYGX+eYotwzk9Hxqhc/OdwGj5R6WbJFqiwzHgZ/ybE6dUrTmXhDNZgkYGFqfu7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777069466; c=relaxed/simple;
	bh=WzcPEgt2z4P410FoDjWUqv6zuEY6eLGFJwPIVF7EA6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f7P+wj8F33SLiMhay2g6evi5nPdzFy+D2ED/iMsdP0o6CPzwBwagv73YforZI0iuqJQp4lJMk3aZK//qYGGZXvpRe6I8cvD48mJyCosGfskCmp+9WlXPvHqOeEgpaXVjUeA8AC2YMNJub5whI38XxzfD0se89JtT+n0fknIWO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXcXemRf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXcXemRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710D2C19425;
	Fri, 24 Apr 2026 22:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777069466;
	bh=WzcPEgt2z4P410FoDjWUqv6zuEY6eLGFJwPIVF7EA6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GXcXemRfQGhCL3V8mHmjDPQNfnYHHaXMuXoWyTxpXF5xEUi7IQHWI8tNHSsJ03hXX
	 lr81HUyxkI98aHzvjzbMMflXjhwGj4TbE0pLQUjQd/qoThT9wwcnWuDlGS1dt6VU+s
	 /EVhB6TqWoIfG35EUQvmcjxpzn0cC95CIdnqNd7T/Azx7rheTbdBdWby0MFDLuLcnc
	 elXu+w3aKwePLGYFDuq76GiOFj2i7pTn0APLie49/pSZnYUDUWLVeMCxAfnp37CqXj
	 fdDzIJAOfgbyeGPxGikPorThfa6d9LphnSL1gBgmiJC9B19Q5szXBkjv4cj8+BRLWl
	 cO3ck49scppVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 1/1] bpf: Fix sk_local_storage diag dumping
 uninitialized special fields
Reply-To: sashiko@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260423222356.155387-1-ameryhung@gmail.com>
References: <20260423222356.155387-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 22:24:25 +0000
Message-Id: <20260424222426.710D2C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] Calling `check_and_init_map_value()` on a netlink payload buff=
er writes kernel pointers into the message, causing a KASLR bypass.
--

commit 3db95684928f56c741f1722b8018d7049c261634
Author: Amery Hung <ameryhung@gmail.com>

bpf: Fix sk_local_storage diag dumping uninitialized special fields

This commit attempts to prevent uninitialized memory from being leaked to
userspace during socket diag dumps. It calls check_and_init_map_value() on
the netlink payload buffer to initialize special map fields that are skipped
by copy_map_value().

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -558,6 +558,7 @@ static int diag_get(struct bpf_local_storage_data *sd=
ata, struct sk_buff *skb)
>  				      sdata->data, true);
>  	else
>  		copy_map_value(&smap->map, nla_data(nla_value), sdata->data);
> +	check_and_init_map_value(&smap->map, nla_data(nla_value));

Does calling check_and_init_map_value() directly on the netlink payload leak
kernel pointers to userspace?

The function check_and_init_map_value() calls bpf_obj_init() to initialize
the special fields in the map value.

For fields like BPF_LIST_HEAD and BPF_RB_NODE, bpf_obj_init() invokes
initialization macros like INIT_LIST_HEAD() and RB_CLEAR_NODE().

INIT_LIST_HEAD() assigns self-referential pointers to the list structure:

static inline void INIT_LIST_HEAD(struct list_head *list)
{
        WRITE_ONCE(list->next, list);
        WRITE_ONCE(list->prev, list);
}

Because this initialization is performed directly on the allocated netlink
payload inside the socket buffer, valid kernel heap addresses are written
into the message instead of zeros. When this message is sent to userspace,
it leaks the kernel addresses.

> =20
>  	nla_nest_end(skb, nla_stg);
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423222356.1553=
87-1-ameryhung@gmail.com?part=3D1
