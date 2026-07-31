Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF72D14ABE
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536394; cv=none; b=tnj55mbmKaMTzh7lTcv5Ihd0WRBinODZVvBz2DGgOS6rZiZ0SGwpv2/fElN34+2rCMAM8n3bbCpkAmsRYfT6BqgUmqQlMww+TaQ62acmdilubzEGvgCFs4d9eMO6bfyqqBKYMDSUnyHf3x6yjfVgNuG8U7V7LmBLHh+rQjI9AFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536394; c=relaxed/simple;
	bh=ktQJy9tSdfCkdp0q830pBzfb7kBiwjVvN0HZqmeX7Jg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=pVA2zAbzOQ4vpubdg936GfUbLq43LmrGRHXRmVaXm+ja/RfSpZ4Dm+UJy35I1P+K+d87cu3C5vZWkrJ4C/d06OaCSbrhBsG5tBgLlmBBYuqhg9LNuRJLI7E60A0yxCD+rpkkOYZENutAFres1tqsDmVHiZHnpKACaa4PCJr1y/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=m41tsr3R; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="m41tsr3R"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ceaf8a1265so17905835ad.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785536391; x=1786141191; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7MwibsIfMTqtB/083gKYST2P75fGlBAEuh+xfpD1zqc=;
        b=m41tsr3RY9oGA3gpkcraH7rYME2b+xec0e8y8tKYJ8xOuQeCLNW5JifzbQw0mfmfut
         HzIdH03Pj0T3j7pz/yuzupipkSrhQYZDbliSzOGP4FJnwqzubuhqbyMGtAYyWYltPRun
         ZCm7pr1oH60CX2eY6rEdgWlOyIHJ1qE1rgi2732bI7TGxWgACO29A+ANIE+K7COq4yHS
         yr0q60IOKVhrk45OB+R/aibVaytf1JofKKaKH3VYmW/cntfOQK4168VTn6Pfa+wlZbzo
         SnVi43AeSz4RRSPqp4etdufouz6rwdcyNsnLkDpHA/E0OFlAyfez3i6UiJK7xmUfsj+b
         8r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785536391; x=1786141191;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7MwibsIfMTqtB/083gKYST2P75fGlBAEuh+xfpD1zqc=;
        b=A/Gn9EQudTbukDliacE5DA6/y0QLtee4COF+upba67grBJllJ5NWvH5XyeLPH8Zr+j
         2Ls/upyBFbhA0aEZROcoAnTAobvcEk2c+euGN4PbkS0m4LafLcqAKHRIhAPTQHDszgZy
         223HKePjVO4MhCDRvB8hJ8dOWduHvF9miga2171UkFdjrsZy5erWgN95dMMPQaTLrSw1
         T3S4DwzZbPAld3uj0TffsXCowU2WFBhxZHaTSRNxIhwpqQNPkvnrdNO8u88yHp8WTQBG
         hvihO393OMZo50uIYvYR4PJaHnzzSJkahU8EA4LHhN3RiqJw55/m0JT6dRVwztsqOkGz
         lpYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp96zjhV/Rm9PloPkA1/hR+iupthLduH4Vf7FNdoIGroJpBH2pWQxGLBQPyWONQuQTdaNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Zv+SqXr7v9OVDc7fRnxvZthUb1jSx0/yiak2yU1a0ys+zydU
	tPvUCd/xl+LXcY0tVxgFKrL7XtwQNnz6EYPPiy3aRiCHPSN1z0I2iQ/QRgkG6OC8S2o=
X-Gm-Gg: AR+sD13p2Wdi3XPIw3fgSGgKcoBQQ7ouJg27Pfppz/gO1l7pj8aiRD6vlJMGw3TU+25
	rJzd2GS5XFi6l9wLwL/Abxq+h8CvInif8Fi8LR8brBR2dhasS71Jq3bsZFiPDGzXl8G0RV/Y0IU
	VJORjBAVuDDpbOARZJutt4AFvqWBZ6vHkU4JoVvTujYbCMk2QuaBUU9VEkAAGjCf2AbzUBYPPzf
	hTubZbY51+USzzaOjQCJH5OeK6sRY8GXr7zU266lsShj0Ch5uGVZHuo5YfJoEqENekTlQcmt1bk
	tW2OQNQE6/i3Kat2a8v9AYEi4xFth86e+9wtqGWIO22K6+a5C/rPs9cCTTpmMRWHWQDEgCtNY2d
	Zq6cu3TFIiKKewBhEFvp15zZGpb2IQBNQfQcobBTjKMLs/oDAfb+LXN05Xop2UO08Xxbz0zYfmD
	bQ/AD80LEXfddiz1E0/4tbsxk+iSW8SogOPi0l9Io+ySrINDW3V/ncN/MZu19wTJdG6RTscvB/C
	+T5QiruOqk7gW/nZOAC50zJDe0S
X-Received: by 2002:a17:902:e88f:b0:2ca:ef16:8e8 with SMTP id d9443c01a7336-2d0523fa021mr13868555ad.29.1785536390905;
        Fri, 31 Jul 2026 15:19:50 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19411sm10745475ad.8.2026.07.31.15.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 15:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 18:19:49 -0400
Message-Id: <DKD3TPJVVM4G.2N5G3FVGL6V73@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 12/15] bpf: tcp: Support parse/len/write
 header option hooks in bpf_tcp_ops
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-13-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-13-ameryhung@gmail.com>

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> Add the TCP header option callbacks to the bpf_tcp_ops struct_ops type:
>
>   parse_hdr     - parse the options of an incoming skb on an established
>                   connection
>   hdr_opt_len   - reserve space in the TCP header for bpf options
>   write_hdr_opt - write the reserved bpf options
>
> These mirror the BPF_SOCK_OPS_PARSE_HDR_OPT_CB, _HDR_OPT_LEN_CB and
> _WRITE_HDR_OPT_CB legacy sockops callbacks, but are exposed as struct_ops
> members so a program can implement them with normal function signatures
> and per-member helper sets.
>
> The reserved header window is shared between the legacy sockops and
> bpf_tcp_ops paths. tcp_{syn,synack,established}_options() first run the
> legacy BPF_SOCK_OPS_HDR_OPT_LEN_CB and then call hdr_opt_len, so both
> sources accumulate into opts->bpf_opt_len; at write time the legacy
> options are emitted first and bpf_tcp_ops writes after them.
>
> API design
>
> bpf_tcp_ops overloads the sock_ops header-option helpers rather than
> introducing a new API: bpf_reserve_hdr_opt(), bpf_store_hdr_opt() and
> bpf_load_hdr_opt() are exposed per-member (reserve for hdr_opt_len,
> store/load for write_hdr_opt, load for parse_hdr) and share the existing
> kernel option-walking core via _bpf_sock_ops{store,load}hdr_opt(), with
> the bpf_tcp_ops wrappers synthesizing a temporary bpf_sock_ops_kern from
> the program ctx. This keeps a port from the legacy
> BPF_SOCK_OPS*_HDR_OPT_CB callbacks mechanical (same helper calls) and
> adds no new UAPI helper/kfunc surface.
>
> An alternative considered was to drop the option helpers entirely: have
> hdr_opt_len reserve space purely through its return value, and introduce
> a dedicated TCP-header-option dynptr used for both reading and writing.
> That is a cleaner, more self-contained interface, but it is a larger
> change and does not reuse the legacy helpers, making a port from sockops
> less mechanical. It can be pursued as a follow-up; the helper-based
> interface here keeps this series focused on moving the hooks to
> struct_ops.
>
> The hdr_opt_len fast path in tcp_established_options() is gated by
> cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS). Note this is a global,
> per-attach-type static branch: it is enabled whenever any bpf_tcp_ops is
> attached, even one that does not implement hdr_opt_len or that is attache=
d
> to a different cgroup. In those cases the block still runs but
> bpf_tcp_ops_hdr_opt_len() no-ops via the per-member check in the dispatch
> macro. A per-member/per-cgroup gate could be added later if the extra
> fast-path work proves measurable.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

One question I've had both for this and the previous patch: Why are we
defining new functionality as helpers and not kfuncs? Is it that we can
allowlist with helpers and not with kfuncs?

> ---
>  include/linux/filter.h         |   5 ++
>  include/net/tcp.h              |  40 ++++++++++
>  include/uapi/linux/bpf.h       |  35 +++++---
>  net/core/filter.c              |  32 +++++---
>  net/ipv4/bpf_tcp_ops.c         | 142 ++++++++++++++++++++++++++++++++-
>  net/ipv4/tcp_input.c           |  13 +++
>  net/ipv4/tcp_output.c          |  46 +++++++++++
>  tools/include/uapi/linux/bpf.h |  35 +++++---
>  8 files changed, 309 insertions(+), 39 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 67d337ede91b..fe28db65fb6a 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1843,6 +1843,11 @@ static __always_inline long __bpf_xdp_redirect_map=
(struct bpf_map *map, u64 inde
>  	return XDP_REDIRECT;
>  }
> =20
> +int __bpf_sock_ops_load_hdr_opt(struct bpf_sock_ops_kern *bpf_sock,
> +				void *search_res, u32 len, u64 flags);
> +int __bpf_sock_ops_store_hdr_opt(struct bpf_sock_ops_kern *bpf_sock,
> +				 const void *from, u32 len, u64 flags);
> +
>  #ifdef CONFIG_NET
>  int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void *to=
, u32 len);
>  int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *f=
rom,
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2102f9f2afd6..7bf702117602 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -3005,6 +3005,45 @@ struct bpf_tcp_ops {
> =20
>  	/* Called on listen(2), right after the socket enters TCP_LISTEN. */
>  	void (*listen)(struct sock *sk);
> +
> +	/* Parse the TCP header options of an incoming skb received on an
> +	 * established connection. Use bpf_dynptr_from_skb()/bpf_skb_load_bytes=
()
> +	 * to access the options.
> +	 */
> +	void (*parse_hdr)(struct sock *sk, struct sk_buff *skb);
> +
> +	/* Reserve space in the outgoing TCP header for options to be written
> +	 * later by write_hdr_opt(). Call bpf_reserve_hdr_opt() to reserve byte=
s.
> +	 *
> +	 * @skb: outgoing packet. NULL when called from tcp_current_mss()
> +	 *       (MSS sizing).
> +	 * @req: request_sock on the synack path; NULL otherwise.
> +	 * @syn_skb: incoming SYN on the synack path; NULL otherwise.
> +	 * @synack_type: TCP_SYNACK_COOKIE indicates a stateless syncookie.
> +	 * @remaining: pointer to the size of space still available; cast it
> +	 *             using bpf_rdonly_cast() before dereferencing.
> +	 */
> +	void (*hdr_opt_len)(struct sock *sk, struct sk_buff *skb,
> +			    struct request_sock *req, struct sk_buff *syn_skb,
> +			    enum tcp_synack_type synack_type,
> +			    unsigned int *remaining);
> +
> +	/* Write header options into the space reserved earlier by hdr_opt_len(=
).
> +	 * Use bpf_store_hdr_opt() to write; it appends within the reserved win=
dow
> +	 * shared with legacy SOCKOPS.
> +	 *
> +	 * @skb: outgoing packet.
> +	 * @req: request_sock on the synack path; NULL otherwise.
> +	 * @syn_skb: incoming SYN on the synack path; NULL otherwise.
> +	 * @synack_type: TCP_SYNACK_COOKIE indicates a stateless syncookie.
> +	 * @opt_off: offset in the outgoing @skb's TCP header where the
> +	 *	     bpf_tcp_ops portion of the reserved window begins, i.e. after
> +	 *	     the kernel and legacy options.
> +	 */
> +	void (*write_hdr_opt)(struct sock *sk, struct sk_buff *skb,
> +			      struct request_sock *req, struct sk_buff *syn_skb,
> +			      enum tcp_synack_type synack_type,
> +			      u32 opt_off);
>  };
> =20
>  #define bpf_tcp_ops_call(op, sk, ...)					\
> @@ -3056,6 +3095,7 @@ do {									\
>  	}								\
>  	__retval;							\
>  })
> +
>  #else
>  #define bpf_tcp_ops_call(op, sk, ...)		do { } while (0)
>  #define bpf_tcp_ops_call_int(op, init_retval, sk, ...)	(init_retval)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c982801ec7db..fb1b2cb72fd2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4799,15 +4799,18 @@ union bpf_attr {
>   * 		The non-negative copied *buf* length equal to or less than
>   * 		*size* on success, or a negative error in case of failure.
>   *
> - * long bpf_load_hdr_opt(struct bpf_sock_ops *skops, void *searchby_res,=
 u32 len, u64 flags)
> + * long bpf_load_hdr_opt(void *ctx, void *searchby_res, u32 len, u64 fla=
gs)
>   *	Description
>   *		Load header option.  Support reading a particular TCP header
> - *		option for bpf program (**BPF_PROG_TYPE_SOCK_OPS**).
> + *		option for bpf program (**BPF_PROG_TYPE_SOCK_OPS**).  For the
> + *		**bpf_tcp_ops** struct_ops, this helper can be called from the
> + *		**parse_hdr**\ () and **write_hdr_opt**\ () operators.
>   *
> - *		If *flags* is 0, it will search the option from the
> - *		*skops*\ **->skb_data**.  The comment in **struct bpf_sock_ops**
> - *		has details on what skb_data contains under different
> - *		*skops*\ **->op**.
> + *		If *flags* is 0, it will search the option from the packet
> + *		associated with the current operation.  For
> + *		**BPF_PROG_TYPE_SOCK_OPS**, the comment in
> + *		**struct bpf_sock_ops** has details on what skb_data
> + *		contains under different *op*.
>   *
>   *		The first byte of the *searchby_res* specifies the
>   *		kind that it wants to search.
> @@ -4840,6 +4843,8 @@ union bpf_attr {
>   *
>   *		* **BPF_LOAD_HDR_OPT_TCP_SYN** to search from the
>   *		  saved_syn packet or the just-received syn packet.
> + *		  Not supported by the **bpf_tcp_ops** struct_ops, which
> + *		  rejects all flags.
>   *
>   *	Return
>   *		> 0 when found, the header option is copied to *searchby_res*.
> @@ -4860,9 +4865,9 @@ union bpf_attr {
>   *		packet.
>   *
>   *		**-EPERM** if the helper cannot be used under the current
> - *		*skops*\ **->op**.
> + *		operation.
>   *
> - * long bpf_store_hdr_opt(struct bpf_sock_ops *skops, const void *from, =
u32 len, u64 flags)
> + * long bpf_store_hdr_opt(void *ctx, const void *from, u32 len, u64 flag=
s)
>   *	Description
>   *		Store header option.  The data will be copied
>   *		from buffer *from* with length *len* to the TCP header.
> @@ -4878,7 +4883,9 @@ union bpf_attr {
>   *		by searching the same option in the outgoing skb.
>   *
>   *		This helper can only be called during
> - *		**BPF_SOCK_OPS_WRITE_HDR_OPT_CB**.
> + *		**BPF_SOCK_OPS_WRITE_HDR_OPT_CB**, or from the
> + *		**write_hdr_opt**\ () operator of the **bpf_tcp_ops**
> + *		struct_ops.
>   *
>   *	Return
>   *		0 on success, or negative error in case of failure:
> @@ -4893,9 +4900,9 @@ union bpf_attr {
>   *		**-EFAULT** on failure to parse the existing header options.
>   *
>   *		**-EPERM** if the helper cannot be used under the current
> - *		*skops*\ **->op**.
> + *		operation.
>   *
> - * long bpf_reserve_hdr_opt(struct bpf_sock_ops *skops, u32 len, u64 fla=
gs)
> + * long bpf_reserve_hdr_opt(void *ctx, u32 len, u64 flags)
>   *	Description
>   *		Reserve *len* bytes for the bpf header option.  The
>   *		space will be used by **bpf_store_hdr_opt**\ () later in
> @@ -4905,7 +4912,9 @@ union bpf_attr {
>   *		the total number of bytes will be reserved.
>   *
>   *		This helper can only be called during
> - *		**BPF_SOCK_OPS_HDR_OPT_LEN_CB**.
> + *		**BPF_SOCK_OPS_HDR_OPT_LEN_CB**, or from the
> + *		**hdr_opt_len**\ () operator of the **bpf_tcp_ops**
> + *		struct_ops.
>   *
>   *	Return
>   *		0 on success, or negative error in case of failure:
> @@ -4915,7 +4924,7 @@ union bpf_attr {
>   *		**-ENOSPC** if there is not enough space in the header.
>   *
>   *		**-EPERM** if the helper cannot be used under the current
> - *		*skops*\ **->op**.
> + *		operation.
>   *
>   * void *bpf_inode_storage_get(struct bpf_map *map, void *inode, void *v=
alue, u64 flags)
>   *	Description
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 05f492c215e0..1ce958ed73dc 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7887,17 +7887,14 @@ static const u8 *bpf_search_tcp_opt(const u8 *op,=
 const u8 *opend,
>  	return ERR_PTR(-ENOMSG);
>  }
> =20
> -BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_so=
ck,
> -	   void *, search_res, u32, len, u64, flags)
> +int __bpf_sock_ops_load_hdr_opt(struct bpf_sock_ops_kern *bpf_sock,
> +				void *search_res, u32 len, u64 flags)
>  {
>  	bool eol, load_syn =3D flags & BPF_LOAD_HDR_OPT_TCP_SYN;
>  	const u8 *op, *opend, *magic, *search =3D search_res;
>  	u8 search_kind, search_len, copy_len, magic_len;
>  	int ret;
> =20
> -	if (!is_locked_tcp_sock_ops(bpf_sock))
> -		return -EOPNOTSUPP;
> -
>  	/* 2 byte is the minimal option len except TCPOPT_NOP and
>  	 * TCPOPT_EOL which are useless for the bpf prog to learn
>  	 * and this helper disallow loading them also.
> @@ -7958,6 +7955,15 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_s=
ock_ops_kern *, bpf_sock,
>  	return ret;
>  }
> =20
> +BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_so=
ck,
> +	   void *, search_res, u32, len, u64, flags)
> +{
> +	if (!is_locked_tcp_sock_ops(bpf_sock))
> +		return -EOPNOTSUPP;
> +
> +	return __bpf_sock_ops_load_hdr_opt(bpf_sock, search_res, len, flags);
> +}
> +
>  static const struct bpf_func_proto bpf_sock_ops_load_hdr_opt_proto =3D {
>  	.func		=3D bpf_sock_ops_load_hdr_opt,
>  	.gpl_only	=3D false,
> @@ -7968,17 +7974,14 @@ static const struct bpf_func_proto bpf_sock_ops_l=
oad_hdr_opt_proto =3D {
>  	.arg4_type	=3D ARG_ANYTHING,
>  };
> =20
> -BPF_CALL_4(bpf_sock_ops_store_hdr_opt, struct bpf_sock_ops_kern *, bpf_s=
ock,
> -	   const void *, from, u32, len, u64, flags)
> +int __bpf_sock_ops_store_hdr_opt(struct bpf_sock_ops_kern *bpf_sock,
> +				 const void *from, u32 len, u64 flags)
>  {
>  	u8 new_kind, new_kind_len, magic_len =3D 0, *opend;
>  	const u8 *op, *new_op, *magic =3D NULL;
>  	struct sk_buff *skb;
>  	bool eol;
> =20
> -	if (bpf_sock->op !=3D BPF_SOCK_OPS_WRITE_HDR_OPT_CB)
> -		return -EPERM;
> -
>  	if (len < 2 || flags)
>  		return -EINVAL;
> =20
> @@ -8036,6 +8039,15 @@ BPF_CALL_4(bpf_sock_ops_store_hdr_opt, struct bpf_=
sock_ops_kern *, bpf_sock,
>  	return 0;
>  }
> =20
> +BPF_CALL_4(bpf_sock_ops_store_hdr_opt, struct bpf_sock_ops_kern *, bpf_s=
ock,
> +	   const void *, from, u32, len, u64, flags)
> +{
> +	if (bpf_sock->op !=3D BPF_SOCK_OPS_WRITE_HDR_OPT_CB)
> +		return -EPERM;
> +
> +	return __bpf_sock_ops_store_hdr_opt(bpf_sock, from, len, flags);
> +}
> +
>  static const struct bpf_func_proto bpf_sock_ops_store_hdr_opt_proto =3D =
{
>  	.func		=3D bpf_sock_ops_store_hdr_opt,
>  	.gpl_only	=3D false,
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index 3febbc8dd1a0..b27613898337 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -4,6 +4,7 @@
>  #include <linux/bpf.h>
>  #include <linux/btf_ids.h>
>  #include <linux/bpf_verifier.h>
> +#include <linux/filter.h>
>  #include <net/bpf_sk_storage.h>
>  #include <net/tcp.h>
> =20
> @@ -55,6 +56,26 @@ static void listen_stub(struct sock *sk)
>  {
>  }
> =20
> +static void parse_hdr_stub(struct sock *sk, struct sk_buff *skb)
> +{
> +}
> +
> +static void hdr_opt_len_stub(struct sock *sk, struct sk_buff *skb__nulla=
ble,
> +			     struct request_sock *req__nullable,
> +			     struct sk_buff *syn_skb__nullable,
> +			     enum tcp_synack_type synack_type,
> +			     unsigned int *remaining)
> +{
> +}
> +
> +static void write_hdr_opt_stub(struct sock *sk, struct sk_buff *skb,
> +			       struct request_sock *req__nullable,
> +			       struct sk_buff *syn_skb__nullable,
> +			       enum tcp_synack_type synack_type,
> +			       u32 opt_off)
> +{
> +}
> +
>  static struct bpf_tcp_ops __bpf_tcp_ops =3D {
>  	.timeout_init =3D timeout_init_stub,
>  	.rwnd_init =3D rwnd_init_stub,
> @@ -66,6 +87,102 @@ static struct bpf_tcp_ops __bpf_tcp_ops =3D {
>  	.retrans =3D retrans_stub,
>  	.connect =3D connect_stub,
>  	.listen =3D listen_stub,
> +	.parse_hdr =3D parse_hdr_stub,
> +	.hdr_opt_len =3D hdr_opt_len_stub,
> +	.write_hdr_opt =3D write_hdr_opt_stub,
> +};
> +
> +BPF_CALL_4(bpf_tcp_ops_store_hdr_opt, void *, ctx, const void *, from,
> +	   u32, len, u64, flags)
> +{
> +	u64 *args =3D ctx;
> +	struct sk_buff *skb =3D (void *)(unsigned long)args[1];
> +	struct bpf_sock_ops_kern sock_ops =3D {};
> +	u32 opt_off =3D args[5];
> +	u8 *op, *opend;
> +
> +	/* bpf_tcp_ops does not keep track of the end of the written TCP header
> +	 * options, so search for it every time the helper is called. The free
> +	 * space is NOP-filled, so a TCPOPT_NOP ends the search rather than bei=
ng
> +	 * skipped as in a normal option walk in sockops.
> +	 */
> +	op =3D skb->data + opt_off;
> +	opend =3D skb->data + tcp_hdrlen(skb);
> +	while (op < opend && *op !=3D TCPOPT_NOP) {
> +		if (*op =3D=3D TCPOPT_EOL || op + 1 >=3D opend || op[1] < 2)
> +			break;
> +		op +=3D op[1];
> +	}
> +
> +	sock_ops.skb =3D skb;
> +	sock_ops.skb_data_end =3D op;
> +	sock_ops.remaining_opt_len =3D opend - op;
> +
> +	return __bpf_sock_ops_store_hdr_opt(&sock_ops, from, len, flags);
> +}
> +
> +static const struct bpf_func_proto bpf_tcp_ops_store_hdr_opt_proto =3D {
> +	.func		=3D bpf_tcp_ops_store_hdr_opt,
> +	.gpl_only	=3D false,
> +	.ret_type	=3D RET_INTEGER,
> +	.arg1_type	=3D ARG_PTR_TO_CTX,
> +	.arg2_type	=3D ARG_PTR_TO_MEM | MEM_RDONLY,
> +	.arg3_type	=3D ARG_CONST_SIZE,
> +	.arg4_type	=3D ARG_ANYTHING,
> +};
> +
> +BPF_CALL_4(bpf_tcp_ops_load_hdr_opt, void *, ctx, void *, search_res,
> +	   u32, len, u64, flags)
> +{
> +	u64 *args =3D ctx;
> +	struct sk_buff *skb =3D (void *)(unsigned long)args[1];
> +	struct bpf_sock_ops_kern sock_ops =3D {};
> +
> +	/* No flags supported. In particular BPF_LOAD_HDR_OPT_TCP_SYN, which
> +	 * loads from the saved SYN, is not available because bpf_tcp_ops has n=
o
> +	 * carrier to track the SYN source across the hooks.
> +	 */
> +	if (flags)
> +		return -EINVAL;
> +
> +	sock_ops.skb =3D skb;
> +	sock_ops.skb_data_end =3D skb->data + tcp_hdrlen(skb);
> +
> +	return __bpf_sock_ops_load_hdr_opt(&sock_ops, search_res, len, flags);
> +}
> +
> +static const struct bpf_func_proto bpf_tcp_ops_load_hdr_opt_proto =3D {
> +	.func		=3D bpf_tcp_ops_load_hdr_opt,
> +	.gpl_only	=3D false,
> +	.ret_type	=3D RET_INTEGER,
> +	.arg1_type	=3D ARG_PTR_TO_CTX,
> +	.arg2_type	=3D ARG_PTR_TO_MEM | MEM_WRITE,
> +	.arg3_type	=3D ARG_CONST_SIZE,
> +	.arg4_type	=3D ARG_ANYTHING,
> +};
> +
> +BPF_CALL_3(bpf_tcp_ops_reserve_hdr_opt, void *, ctx, u32, len, u64, flag=
s)
> +{
> +	u64 *args =3D ctx;
> +	unsigned int *remaining =3D (void *)(unsigned long)args[5];
> +
> +	if (flags || len < 2)
> +		return -EINVAL;
> +
> +	if (len > *remaining)
> +		return -ENOSPC;
> +
> +	*remaining -=3D len;
> +	return 0;
> +}
> +
> +static const struct bpf_func_proto bpf_tcp_ops_reserve_hdr_opt_proto =3D=
 {
> +	.func		=3D bpf_tcp_ops_reserve_hdr_opt,
> +	.gpl_only	=3D false,
> +	.ret_type	=3D RET_INTEGER,
> +	.arg1_type	=3D ARG_PTR_TO_CTX,
> +	.arg2_type	=3D ARG_ANYTHING,
> +	.arg3_type	=3D ARG_ANYTHING,
>  };
> =20
>  BPF_CALL_0(bpf_tcp_ops_get_retval)
> @@ -102,14 +219,20 @@ get_func_proto(enum bpf_func_id func_id, const stru=
ct bpf_prog *prog)
>  	case BPF_FUNC_sk_storage_delete:
>  		return &bpf_sk_storage_delete_proto;
>  	case BPF_FUNC_setsockopt:
> -		/* The listener is not locked. */
> +		/* The sk may be an unlocked listener (synack path) or NULL
> +		 * fullsock; disable for members that can run unlocked.
> +		 */
>  		if (moff =3D=3D offsetof(struct bpf_tcp_ops, rwnd_init) ||
> -		    moff =3D=3D offsetof(struct bpf_tcp_ops, timeout_init))
> +		    moff =3D=3D offsetof(struct bpf_tcp_ops, timeout_init) ||
> +		    moff =3D=3D offsetof(struct bpf_tcp_ops, hdr_opt_len) ||
> +		    moff =3D=3D offsetof(struct bpf_tcp_ops, write_hdr_opt))
>  			return NULL;
>  		return &bpf_sk_setsockopt_proto;
>  	case BPF_FUNC_getsockopt:
>  		if (moff =3D=3D offsetof(struct bpf_tcp_ops, rwnd_init) ||
> -		    moff =3D=3D offsetof(struct bpf_tcp_ops, timeout_init))
> +		    moff =3D=3D offsetof(struct bpf_tcp_ops, timeout_init) ||
> +		    moff =3D=3D offsetof(struct bpf_tcp_ops, hdr_opt_len) ||
> +		    moff =3D=3D offsetof(struct bpf_tcp_ops, write_hdr_opt))
>  			return NULL;
>  		return &bpf_sk_getsockopt_proto;
>  	case BPF_FUNC_get_retval:
> @@ -117,6 +240,19 @@ get_func_proto(enum bpf_func_id func_id, const struc=
t bpf_prog *prog)
>  		    moff =3D=3D offsetof(struct bpf_tcp_ops, rwnd_init))
>  			return &bpf_tcp_ops_get_retval_proto;
>  		return NULL;
> +	case BPF_FUNC_reserve_hdr_opt:
> +		if (moff =3D=3D offsetof(struct bpf_tcp_ops, hdr_opt_len))
> +			return &bpf_tcp_ops_reserve_hdr_opt_proto;
> +		return NULL;
> +	case BPF_FUNC_load_hdr_opt:
> +		if (moff =3D=3D offsetof(struct bpf_tcp_ops, parse_hdr) ||
> +		    moff =3D=3D offsetof(struct bpf_tcp_ops, write_hdr_opt))
> +			return &bpf_tcp_ops_load_hdr_opt_proto;
> +		return NULL;
> +	case BPF_FUNC_store_hdr_opt:
> +		if (moff =3D=3D offsetof(struct bpf_tcp_ops, write_hdr_opt))
> +			return &bpf_tcp_ops_store_hdr_opt_proto;
> +		return NULL;
>  	default:
>  		return bpf_base_func_proto(func_id, prog);
>  	}
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 12fb690d21c4..a36146789138 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -208,6 +208,18 @@ static void bpf_skops_established(struct sock *sk, i=
nt bpf_op,
>  }
>  #endif
> =20
> +static void bpf_tcp_ops_parse_hdr(struct sock *sk, struct sk_buff *skb)
> +{
> +	switch (sk->sk_state) {
> +	case TCP_SYN_RECV:
> +	case TCP_SYN_SENT:
> +	case TCP_LISTEN:
> +		return;
> +	}
> +
> +	bpf_tcp_ops_call(parse_hdr, sk, skb);
> +}
> +
>  static __cold void tcp_gro_dev_warn(const struct sock *sk, const struct =
sk_buff *skb,
>  				    unsigned int len)
>  {
> @@ -6431,6 +6443,7 @@ static bool tcp_validate_incoming(struct sock *sk, =
struct sk_buff *skb,
> =20
>  pass:
>  	bpf_skops_parse_hdr(sk, skb);
> +	bpf_tcp_ops_parse_hdr(sk, skb);
> =20
>  	return true;
> =20
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index a91770adfb3a..9025008819ba 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -573,6 +573,13 @@ static void bpf_skops_write_hdr_opt(struct sock *sk,=
 struct sk_buff *skb,
>  	if (nr_written < max_opt_len)
>  		memset(skb->data + first_opt_off + nr_written, TCPOPT_NOP,
>  		       max_opt_len - nr_written);
> +
> +	/* bpf_tcp_ops portion is NOP-filled (everything past the sockops
> +	 * writer's bytes). The writer find the append point by scanning from
> +	 * first_opt_off + nr_written to the first NOP.
> +	 */
> +	bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, synack_type,
> +			 first_opt_off + nr_written);
>  }
>  #else
>  static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
> @@ -594,6 +601,32 @@ static void bpf_skops_write_hdr_opt(struct sock *sk,=
 struct sk_buff *skb,
>  }
>  #endif
> =20
> +static u32 bpf_tcp_ops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
> +				   struct request_sock *req,
> +				   struct sk_buff *syn_skb,
> +				   enum tcp_synack_type synack_type,
> +				   struct tcp_out_options *opts,
> +				   u32 remaining)
> +{
> +	unsigned int remaining_out =3D remaining, reserved;
> +
> +	if (!remaining)
> +		return 0;
> +
> +	/* bpf_tcp_ops_reserve_hdr_opt() reserves space via remaining_out */
> +	bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_type, &rema=
ining_out);
> +
> +	reserved =3D remaining - remaining_out;
> +	if (!reserved)
> +		return remaining;
> +
> +	/* round up to 4 bytes */
> +	reserved =3D (reserved + 3) & ~3;
> +
> +	opts->bpf_opt_len +=3D reserved;
> +	return remaining - reserved;
> +}
> +
>  static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
>  				      const struct tcp_request_sock *tcprsk,
>  				      struct tcp_out_options *opts,
> @@ -1053,6 +1086,8 @@ static unsigned int tcp_syn_options(struct sock *sk=
, struct sk_buff *skb,
> =20
>  	remaining =3D bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
>  					  remaining);
> +	remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
> +					    remaining);
> =20
>  	return MAX_TCP_OPTION_SPACE - remaining;
>  }
> @@ -1141,6 +1176,8 @@ static unsigned int tcp_synack_options(const struct=
 sock *sk,
> =20
>  	remaining =3D bpf_skops_hdr_opt_len((struct sock *)sk, skb, req, syn_sk=
b,
>  					  synack_type, opts, remaining);
> +	remaining =3D bpf_tcp_ops_hdr_opt_len((struct sock *)sk, skb, req, syn_=
skb,
> +					    synack_type, opts, remaining);
> =20
>  	return MAX_TCP_OPTION_SPACE - remaining;
>  }
> @@ -1244,6 +1281,15 @@ static unsigned int tcp_established_options(struct=
 sock *sk, struct sk_buff *skb
>  		size =3D MAX_TCP_OPTION_SPACE - remaining;
>  	}
> =20
> +	if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {
> +		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> +
> +		remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
> +						    remaining);
> +
> +		size =3D MAX_TCP_OPTION_SPACE - remaining;
> +	}
> +
>  	return size;
>  }
> =20
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index c982801ec7db..fb1b2cb72fd2 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -4799,15 +4799,18 @@ union bpf_attr {
>   * 		The non-negative copied *buf* length equal to or less than
>   * 		*size* on success, or a negative error in case of failure.
>   *
> - * long bpf_load_hdr_opt(struct bpf_sock_ops *skops, void *searchby_res,=
 u32 len, u64 flags)
> + * long bpf_load_hdr_opt(void *ctx, void *searchby_res, u32 len, u64 fla=
gs)
>   *	Description
>   *		Load header option.  Support reading a particular TCP header
> - *		option for bpf program (**BPF_PROG_TYPE_SOCK_OPS**).
> + *		option for bpf program (**BPF_PROG_TYPE_SOCK_OPS**).  For the
> + *		**bpf_tcp_ops** struct_ops, this helper can be called from the
> + *		**parse_hdr**\ () and **write_hdr_opt**\ () operators.
>   *
> - *		If *flags* is 0, it will search the option from the
> - *		*skops*\ **->skb_data**.  The comment in **struct bpf_sock_ops**
> - *		has details on what skb_data contains under different
> - *		*skops*\ **->op**.
> + *		If *flags* is 0, it will search the option from the packet
> + *		associated with the current operation.  For
> + *		**BPF_PROG_TYPE_SOCK_OPS**, the comment in
> + *		**struct bpf_sock_ops** has details on what skb_data
> + *		contains under different *op*.
>   *
>   *		The first byte of the *searchby_res* specifies the
>   *		kind that it wants to search.
> @@ -4840,6 +4843,8 @@ union bpf_attr {
>   *
>   *		* **BPF_LOAD_HDR_OPT_TCP_SYN** to search from the
>   *		  saved_syn packet or the just-received syn packet.
> + *		  Not supported by the **bpf_tcp_ops** struct_ops, which
> + *		  rejects all flags.
>   *
>   *	Return
>   *		> 0 when found, the header option is copied to *searchby_res*.
> @@ -4860,9 +4865,9 @@ union bpf_attr {
>   *		packet.
>   *
>   *		**-EPERM** if the helper cannot be used under the current
> - *		*skops*\ **->op**.
> + *		operation.
>   *
> - * long bpf_store_hdr_opt(struct bpf_sock_ops *skops, const void *from, =
u32 len, u64 flags)
> + * long bpf_store_hdr_opt(void *ctx, const void *from, u32 len, u64 flag=
s)
>   *	Description
>   *		Store header option.  The data will be copied
>   *		from buffer *from* with length *len* to the TCP header.
> @@ -4878,7 +4883,9 @@ union bpf_attr {
>   *		by searching the same option in the outgoing skb.
>   *
>   *		This helper can only be called during
> - *		**BPF_SOCK_OPS_WRITE_HDR_OPT_CB**.
> + *		**BPF_SOCK_OPS_WRITE_HDR_OPT_CB**, or from the
> + *		**write_hdr_opt**\ () operator of the **bpf_tcp_ops**
> + *		struct_ops.
>   *
>   *	Return
>   *		0 on success, or negative error in case of failure:
> @@ -4893,9 +4900,9 @@ union bpf_attr {
>   *		**-EFAULT** on failure to parse the existing header options.
>   *
>   *		**-EPERM** if the helper cannot be used under the current
> - *		*skops*\ **->op**.
> + *		operation.
>   *
> - * long bpf_reserve_hdr_opt(struct bpf_sock_ops *skops, u32 len, u64 fla=
gs)
> + * long bpf_reserve_hdr_opt(void *ctx, u32 len, u64 flags)
>   *	Description
>   *		Reserve *len* bytes for the bpf header option.  The
>   *		space will be used by **bpf_store_hdr_opt**\ () later in
> @@ -4905,7 +4912,9 @@ union bpf_attr {
>   *		the total number of bytes will be reserved.
>   *
>   *		This helper can only be called during
> - *		**BPF_SOCK_OPS_HDR_OPT_LEN_CB**.
> + *		**BPF_SOCK_OPS_HDR_OPT_LEN_CB**, or from the
> + *		**hdr_opt_len**\ () operator of the **bpf_tcp_ops**
> + *		struct_ops.
>   *
>   *	Return
>   *		0 on success, or negative error in case of failure:
> @@ -4915,7 +4924,7 @@ union bpf_attr {
>   *		**-ENOSPC** if there is not enough space in the header.
>   *
>   *		**-EPERM** if the helper cannot be used under the current
> - *		*skops*\ **->op**.
> + *		operation.
>   *
>   * void *bpf_inode_storage_get(struct bpf_map *map, void *inode, void *v=
alue, u64 flags)
>   *	Description

