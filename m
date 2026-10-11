Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755643BFE2B;
	Sun, 11 Oct 2026 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791690679; cv=none; b=dCmjjIgrjdOqEQ4O8qKY/6E6b1C6q0UD35O4i+43B7snO6dFt/Pu9PlJbnUz9Zk5GvwJgCHbyVHPia+nnRaABBCz7vktakp5BNsNkNsHuHlHjYj7pSix0p/ZrD7BpbVczudzqgwoJUlT8PJ3cdlPv+wzUjeVA8TG8sh0tmj/vhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791690679; c=relaxed/simple;
	bh=ZvqOF+v/s082r9S8506nNWLLgfVXF4V04WTvyqOsRDE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qUeuGOydKgyWUQYb6XWtmY3vL8jBxVJVG4WOFmeb6wn75dy1gRiRscMPdW740HjeaJ1PQc3VhuQ16J5kHGAlK1QTKJwTGOFXoZJX0pL49000eNMHRNzh22FSk8y3RDnOPudG4+zlBrxeWYElVqJOY3BsHjgQvs4/1TQZOoP1CyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b510PXK8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b510PXK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D86C1F00893;
	Sun, 11 Oct 2026 03:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791690677;
	bh=BxIG9RGXtPeoCRfraWyVT7uMTEzIpuY6URyi2+XVd/I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b510PXK8t7+e5mIzuaKO7Ly8zesK021UNW57R1CeMEbqp4pAfZSvRQdG/oeWkRkbo
	 Yih1wVc9W/Y2hVbWXTmkH4NNNrcbHpWBKNb8Fv/qLnFh4z9L+yhpG9Ddej1u2vw+6u
	 JIKlSFC+ZYTOM5slXJXobtDAV6n0Qaslt0gDG1wqQmstX/mrQlmEgODLRyiwntGT39
	 ePaIUTT8i3lBKwAXtVRI7UKJttIOEWTQYriEbCVDUGMs+/zKD6us5NJoIzzQ48TygH
	 o4bLuzptQZQM6UQktHNo1fccCxik0jbhySsOzqBBaox8RiGZGX3kSxHObIsTuHw2vw
	 oJ5ytWqxcGNgg==
Subject: Re: [PATCH net-next v3 2/2] docs: netmem: document netmem and memory
 provider design principles
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 hawk@kernel.org, ilias.apalodimas@linaro.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 lrizzo@google.com, bjorn@kernel.org, asml.silence@gmail.com
Date: Sun, 11 Oct 2026 03:51:15 +0000
Message-ID: <179169067595.434549.16209693488880004107@kernel.org>
In-Reply-To: <20261010033630.1171692-3-almasrymina@google.com>
References: <20261010033630.1171692-3-almasrymina@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Item 5 of the new Design Principles section in
  Documentation/networking/netmem.rst says every frag in an skb must be…
- [Low] Items 2 and 5 of the new Design Principles section contradict
  each other once a page-backed memory provider exists.
- [Low] Item 3 of netmem.rst, and the matching net_iov comment in
  include/net/netmem.h added by the commit "net: netmem: document netmem…

--

docs: netmem: document netmem and memory provider design principles

This commit adds a Design Principles section to
Documentation/networking/netmem.rst. The section covers the netmem_ref
abstraction, the rule against downcasting, decoupling memory providers
from net_iov and net_iov from unreadability, and delegating type-specific
logic to the lower layers. It also adds a rule against mixing skb fragment
memory sources.

> diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> index 217869d1108dd..6871dcdd700cc 100644
> --- a/Documentation/networking/netmem.rst
> +++ b/Documentation/networking/netmem.rst
> @@ -19,6 +19,59 @@ Benefits of Netmem :

[ ... ]

> +3. **Decouple net_iov from unreadability**: ``struct net_iov`` is flexible and
> +   has no inherent restrictions; it may represent either CPU-readable or
> +   unreadable memory. Today, in-tree ``net_iov`` implementations are unreadable
> +   by the CPU (``netmem_address()`` returns ``NULL``) and some existing code
> +   still reflects that limitation, but new code must not assume ``net_iov``
> +   implies unreadable memory (check readability via ``netmem_address()`` or
> +   ``skb_frags_readable()`` instead) and should, as much as possible, generalize
> +   existing limitations to match the design principles.

[Severity: Low]
Can netmem_address() reliably test readability for page-backed netmem?
For pages, it ends up calling page_address():

include/net/netmem.h:netmem_address() {
	if (netmem_is_net_iov(netmem))
		return NULL;

	return __netmem_address(netmem);
}

With CONFIG_HIGHMEM, page_address() in mm/highmem.c returns NULL for a
highmem page that has no permanent mapping. The CPU can still read that
page through kmap_local_page(), which item 1 uses as its example.

Highmem page frags are normal in skbs on 32-bit kernels. They come from
sendfile/splice or from MSG_ZEROCOPY user pages.

Could new code that follows this advice and treats a NULL return from
netmem_address() as "unreadable" wrongly reject or skip valid highmem page
frags?

The same advice appears in the struct net_iov comment in
include/net/netmem.h. That comment was added by "net: netmem: document
netmem and memory provider design in comments".

Would it be more accurate to say that a NULL netmem_address() means "no
permanent kernel mapping"? Another option is to point only to
skb_frags_readable() or to a dedicated netmem readability helper.

[ ... ]

> +5. **Do not mix skb fragment memory sources**: All ``frags[]`` in an
> +   ``sk_buff`` must either be ``struct page``-backed or belong to the same
> +   memory provider instance (for example, the same ``devmem`` binding or
> +   ``io_uring`` area). Mixing ``struct page`` and memory-provider fragments,
> +   or mixing fragments from different memory providers within a single
> +   ``sk_buff``, is not allowed (including when coalescing ``sk_buff``\ s).

[Severity: Medium]
Is this invariant enforced anywhere today? Items 2 and 3 note that some
existing code does not follow them yet, but this item has no such note.

The companion commit "net: netmem: document netmem and memory provider
design in comments" adds this comment in skb_try_coalesce():

net/core/skbuff.c:skb_try_coalesce() {
    ...
	/* All frags in an skb must either all be struct page-backed or all
	 * belong to the same memory provider instance; do not coalesce skbs
	 * that would mix them.
	 */
	if (skb_frags_readable(from) != skb_frags_readable(to))
		return false;
    ...
}

skb_frags_readable() only returns !skb->unreadable. Two unreadable skbs
can carry net_iovs from different devmem bindings, or from a devmem
binding and an io_uring zcrx area. Both would pass this check, and their
frags would then be merged.

Other places look similar:

- tcp_skb_can_collapse() in include/net/tcp.h compares only readability.
- skb_gro_receive() in net/core/gro.c checks pp_recycle and skb_zcopy(),
  but not readability or provider identity.

On TX, tcp_sendmsg_locked() looks up the binding again on every sendmsg
call with net_devmem_get_binding(sk, sockc.dmabuf_id). Before it appends
to the tail skb, it only checks:

	if (copy <= 0 || !tcp_skb_can_collapse_to(skb) ||
	    unlikely(skb_frags_readable(skb) != !binding)) {

msg_zerocopy_realloc() then extends the tail skb's uarg. Because of that,
the -EEXIST check in skb_zerocopy_iter_stream() never triggers.

bind-tx does not require privileges. Could a user bind two dmabufs to one
netdev, then send two back-to-back MSG_ZEROCOPY sendmsg calls with
different dmabuf_ids? That would leave net_iovs from two bindings in one
skb.

validate_xmit_unreadable_skb() in net/core/dev.c already relies on this
invariant, because it only checks frags[0]:

	niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
	if (net_is_devmem_iov(niov) &&
	    READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev)
		goto out_free;

Should these places get a provider-identity check? Otherwise, could this
item and the skb_try_coalesce() comment say that only readability is
enforced today, the way items 2 and 3 describe their own limitations?

[Severity: Low]
Do items 2 and 5 conflict once a page-backed memory provider exists?

Item 2 says "a memory provider that returns struct page-backed
netmem_refs to upper layers is allowed". A frag from such a provider
fits both categories in the first sentence here: "struct page-backed"
and "same memory provider instance". Read that way, it could share an
skb with ordinary page frags, or with page frags from a different
page-backed provider. skb_try_coalesce() would allow that today.

The second sentence, however, forbids "Mixing struct page and
memory-provider fragments, or mixing fragments from different memory
providers".

The new skb_frag_t comment in include/linux/skbuff.h uses the same
wording.

Could the two categories be stated so they don't overlap? For example,
"non-provider struct pages" versus "frags from a single provider
instance, whatever their backing".

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010033630.1171692-1-almasrymina%40google.com
