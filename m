Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1E515998
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682051; cv=none; b=MS9lXzPeSEmhn4DGTeGXNuPY6OSihhBSFuwkg7+2xqhe/81cRh9hgI6AEUwMvYiQ3iyyKqVBfw8k0+NshSkigUs88srQoD02oJ6Cjdk1fNDnpBkYpN04BHRuMs/sm8P+rTKfn0hfb+mcxG/E6uHZcXY2G+EkAtg+xBNOa8cBQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682051; c=relaxed/simple;
	bh=2PZLUL5oSIBuaK283VNbvlWiCgCbxwYfk5ez/QHeZ4Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jJuadw6muH0I1jEw03Pf9+WV0FiLtz3iGFPnjlaqcqrm9bDruQOq9OecQa3d//YKbwasJfQ5vMFTrB4du3F7ylao/wMe0z6DdjNbcOh62UQ3Z5weqEAKrQLM/SBGza8aPoP2ELTJxomqwBdshWIaudLnwhzfd7+NVre28PrQSlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZffO+6lw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZffO+6lw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2251F00898;
	Tue, 29 Sep 2026 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790682049;
	bh=X/OuZ19qRdl5sO6HI0HZbm91p4+R3ovsQ07wGI5oWRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZffO+6lwRkZbgg0lDGo2y/fVtQN03uOyerVRgWY2UPSbikJ3Ja87SXEF9GpVM7aud
	 xp5dv9C9ppd//I8/FzF02jRdJLPSZJCwgPMBtk8y/jS/2m5k3WtAmSMeHwxkmuhirY
	 KSjymHPszLDlXCtNSsxKkk/xNb3HtzkZz4N6cGYj8OlqzgAr5lKKmqvtAtUS1NEgWp
	 Fbkrs81IERFIFq1aeJMipHcEBiLDot6RgSVZPwZBTnI3o2Q7CG/B7NFUhT4KrP/DYp
	 dGp9hHW3fhjcu9ELqhtwZlqgX948YR4PLk46BEzRY17sAULCDFHwgVseZeBYknE762
	 N+7QNRgnwwBUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 01/15] bpf: Add gated tracepoints for skb
 life-cycle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-1-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
 <20260928-bpf-meta-gated-tracepoints-v1-1-844dbf3e1edf@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:40:49 +0000
Message-Id: <20260929114049.5A2251F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] bpf: data race in bpf_trace_skb() corrupts SKB bitfields on shared=
 SKBs
- [Medium] bpf: premature tracepoint emission in skb_release_head_state rep=
orts NOT_SPECIFIED instead of CONSUMED
- [Medium] bpf: skb_copy tracepoint exposes uninitialized slab memory to BP=
F programs
- [Low] build: build failure and tracepoint suppression due to improper CON=
FIG_SKB_EXTENSIONS nesting
--

commit 35624cd8e7b29d9f94cba0d236454331934ce45d
Author: Jakub Sitnicki <jakub@cloudflare.com>

    bpf: Add gated tracepoints for skb life-cycle

    BPF programs attached at different points in the network stack have no =
way
    to pass data between each other on a per-packet basis. xdp/skb->data_me=
ta
    works for XDP-to-TC handoff, but is not available to programs running at
    later hooks like cgroup/skb, sock_ops, socket filters, tracing or LSM.
   =20
    Enable programs to keep per-packet metadata in a shared BPF map keyed by
    the skb address. What rides on the packet is only a marker: a new
    skb->traced flag, occupying the spare bit after csum_valid, which makes=
 the
    packet's lifetime events observable.

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 84308498a3a8c..0353df4a46379 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1002,6 +1003,9 @@ struct sk_buff {
>  	__u8			encapsulation:1;
>  	__u8			encap_hdr_csum:1;
>  	__u8			csum_valid:1;
> +#ifdef CONFIG_SKB_GATED_TRACEPOINTS
> +	__u8			traced:1;
> +#endif

[Severity: High]
Does this new bitfield introduce a data race?

Since it is packed alongside other widely modified flags within the same by=
te,
unprotected modifications can lead to read-modify-write data races on cloned
or shared SKBs, potentially silently corrupting adjacent metadata flags like
csum_valid or encapsulation.

[ ... ]

> @@ -5147,6 +5183,8 @@ static inline void skb_ext_del(struct sk_buff *skb,=
 int unused) {}
>  static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_buf=
f *s) {}
>  static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buf=
f *s) {}
>  static inline bool skb_has_extensions(struct sk_buff *skb) { return fals=
e; }
> +static inline void skb_maybe_trace_free(struct sk_buff *skb,
> +					enum skb_drop_reason reason) {}
>  #endif /* CONFIG_SKB_EXTENSIONS */

[Severity: Low]
Are we missing the fallback declaration for skb_maybe_trace_copy() here?

The #else block for CONFIG_SKB_EXTENSIONS provides a stub for
skb_maybe_trace_free() but completely omits skb_maybe_trace_copy(). When
compiling with CONFIG_SKB_GATED_TRACEPOINTS=3Dy and CONFIG_SKB_EXTENSIONS=
=3Dn,
this will cause a build failure in __copy_skb_header() which calls it
unconditionally.

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 70dc621672f2e..33c1ee3b966b0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12426,6 +12426,51 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_=
buff *s, u64 flags,
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_SKB_GATED_TRACEPOINTS
> +/**
> + * bpf_trace_skb() - Opt an skb into gated lifetime tracepoints

[ ... ]

> +__bpf_kfunc int bpf_trace_skb(struct sk_buff *skb, u64 flags__k)
> +{
> +	if (flags__k)
> +		return -EINVAL;
> +
> +	if (!skb->traced)
> +		skb->traced =3D 1;
> +
> +	return 0;
> +}

[Severity: High]
Does this code corrupt SKB bitfields on shared SKBs?

The kfunc bpf_trace_skb() performs a non-atomic write on the shared bitfield
byte without verifying if the SKB is shared. Any BPF program that calls this
kfunc on a shared packet can concurrently modify the bitfield and corrupt
adjacent kernel memory flags.

[ ... ]

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 8912a66cd9097..038854c83701a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1187,6 +1187,7 @@ void skb_release_head_state(struct sk_buff *skb)
>  	}
>  	nf_reset_ct(skb);
>  	skb_ext_reset(skb);
> +	skb_maybe_trace_free(skb, SKB_DROP_REASON_NOT_SPECIFIED);
>  }

[Severity: Medium]
Will this premature tracepoint emission cause us to miss the actual
consumption event?

When an SKB with head state is consumed via __consume_stateless_skb() (for
example, in udp_rcv()) or deferred via napi_consume_skb(),
skb_release_head_state() is called first.

This prematurely fires skb_maybe_trace_free() with NOT_SPECIFIED and clears
the skb->traced bit before the actual consumption happens. As a result, BPF
programs monitoring the skb_free tracepoint receive an incorrect drop reason
and the subsequent actual consume tracepoint fails to fire.

[ ... ]

> @@ -1601,6 +1607,7 @@ static void __copy_skb_header(struct sk_buff *new, =
const struct sk_buff *old)
>  	CHECK_SKB_FIELD(tc_index);
>  #endif
> =20
> +	skb_maybe_trace_copy(new, old);
>  }

[Severity: Medium]
Could this tracepoint expose uninitialized slab memory to BPF programs?

In __skb_clone(), __copy_skb_header() is called before critical structural
fields (like len, data_len, mac_len) are initialized:

__skb_clone()
   n->sk =3D NULL;
   __copy_skb_header(n, skb);
   C(len);
   C(data_len);

By unconditionally invoking skb_maybe_trace_copy() inside
__copy_skb_header(), the tracepoint passes the partially constructed clone
immediately to the BPF program, allowing it to observe uninitialized slab
memory from the new SKB.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-bpf-meta-g=
ated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com?part=3D1
