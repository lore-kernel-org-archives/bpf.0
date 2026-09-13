Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2D38F253
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789304732; cv=none; b=imDJrLkIZrTQSFfQQAy9AkUepDMFXqD76KbOxuw3gtuVl8mgPv6JnLnEtPIY6iFPbRLenMZuzp4xgBVyeLb+KAZG5PRCdoWwSVKisKKgiH15aJeAKOLPo9nnyo8H/UC21rbzv0BPvwBMatK1rnYZpO8Qu7WoSoj1e9e28KRydo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789304732; c=relaxed/simple;
	bh=y3XytUCzFPOzJmOW3qwO5ptWzQIM9alzkawtzNUIezE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1hFgd0uaXMLNtyNNhGSSljjlQ+An3YJGGtFJaLb27KtUkl7QYab0zbhiZM/AHwvUFhKX9uEOvqeVKQikTPJ+XXUYv0Xg7SfXfgCKoDGWk97ouW+SeTCF4cpwWL6/0HUfIFGFiC8W/Kg5qglSsBTuP4fVwxZkqI9OQBQScIS3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oz3CoE1E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ge25AXjc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oz3CoE1E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ge25AXjc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DAUIgv1873280
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 13:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JELls357oROzry/uaF5NiB3H
	IAkTSZxgZJvFFmqQnWk=; b=oz3CoE1EymzymXg0gk2BuuNfRruq2znV3UzWzZVd
	QcWJE3ZWvx7sb5vw/S9LmyhETpx3MQJivH8fMuQpONyN+7MhDp+bnQ56OdMNT3HR
	5YTYAmlqm0mZGxxrJUaIxeOvdMGHX6DWADjLAo1gd5cAfcqO0/cOQ+QVRXtPKKTQ
	Zk9Z209tvVy1xtqfMwIzR81DwGu4WVAXbijuMYiAC86Wx5DMHAyrlfHRA7ISt6uB
	9S0dle2tBkw3cCIl+GQtfDJDdRu2PyU3NtQFihI1+1wuBZte+LqKBPn2Fel36s7U
	rZleCMQk1oDTsc45JiT+vPonPrcauqXcJhraf/8L5p33HA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dkak9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 13:05:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93918756165so462166185a.0
        for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789304728; x=1789909528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JELls357oROzry/uaF5NiB3HIAkTSZxgZJvFFmqQnWk=;
        b=Ge25AXjc4WqEF2MgSAitQyf7fB62Ilu6n+JkYQ0kFxPtC+qbJ0bC8mn4LEAdwq/Pfc
         X39LWjVqPg19SbejtVYBtDnzpUWIjn7saTfHrPY3GKlWe7CEE3VAzoO8g5SMh5ej3svt
         ajdFyZWPVISqRm5vSuPY0h0loELTwTNGMSKZfvdC5Yv82JvWRk60s0jCuqcVXSrWiPaI
         nY/EgLFKfQsPTQS/2TOoepEu/War+hBWKrSMvv/Q079HfwB2U44Bu/MIk/26YlilLp4s
         /ImOzyQ2KErtKp+Ofock+TEeIZaiWKH2mi+2ew/RMll169zJL2q4cPGUrSwfDWisatkF
         NaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789304728; x=1789909528;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JELls357oROzry/uaF5NiB3HIAkTSZxgZJvFFmqQnWk=;
        b=MlI7muufIMYaDd67hJVte/JkWidok8UIdeuYhTzzdLGCAyJ6tWd6OvxSBHJ8exOGQo
         Gnb3Ryl5NpTvFJi0HaVshV9Ksmh7bbnd0Z9G5tzw+lXWJfmmxzSec7PopiiWXUilDDZ9
         qyFFQz89xxmJ0/AogZmuAME3MecpWQLOtQx1Soils2fe8Mt0iPzeFUL9ttObAbnXKqyt
         EF75TlCm6FrvOMQvBXzRsiyVCDVA1mDv8EWiJOxythpYN62JKWWjrN5ET7gCrRZ2y1n2
         a+Mi1n46TRx2sYAHDXK5uNUrvIhnVtEiQQ9xMOoDoU6ZPNVu6mfGbZux9bgcjLsG8KtO
         8znw==
X-Gm-Message-State: AFuF++n73/+mNzpJP2pBYwzD698lBj+kbAxDHlm1yipjm+YVuXaIpKfK
	TzrsLHl3DOqAYCn6tui61O838yDqbwSfYUF4JI0pixYgL3q3jboJR/7AjYITfjM2MY/JCC3Kouw
	JmbYjXg8McW3QTCe+AwBVqqO8OCs+fCRu2uSBz93o9JmHJ8bqEDoG/ZI=
X-Gm-Gg: AYBFou07kA3qwbCWs2gUF/H16OV6ipowXpl/hFuPLSL0Q7PxvPzXqI7o4Rd+QtCFQ2w
	CSnuhyruRaZQG66fcGMiNnjcM7k6QnWv7KOLJjDXJ2H08/GneWcuJT+6H8743TO0vQ3CfxAjtwn
	tInngWEwr9RJg4JPqpRJwUcTRZJU2d/Kqf0sZ/hBB0sSwkpO4N0a1NvIgu8zictu9d2Qhcotx2E
	QjWeEVvWnZrGPuVuhwS7ixPrrSRdFhB+PAqVcEyPsXi8OPNNPVT5aYAeHkUdQQ0PdlHPNNg7JHE
	k5B6OPrZex+/g3HGzSuJz26HMUKPCeUMHijIReU10osaLR/vDQb4YmcUB9bo9Aud6/b8BLa9Yhs
	5JRG9zuLWOr4XYw==
X-Received: by 2002:a05:620a:459f:b0:939:feaa:949c with SMTP id af79cd13be357-939feaa986emr1225216985a.36.1789304728318;
        Sun, 13 Sep 2026 06:05:28 -0700 (PDT)
X-Received: by 2002:a05:620a:459f:b0:939:feaa:949c with SMTP id af79cd13be357-939feaa986emr1225204485a.36.1789304727663;
        Sun, 13 Sep 2026 06:05:27 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34f1f7sm19426713f8f.24.2026.09.13.06.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 06:05:25 -0700 (PDT)
Date: Sun, 13 Sep 2026 15:05:24 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Martin Karsten <mkarsten@uwaterloo.ca>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf, veth: xdp: fix page_pool page leak on
 skb-backed XDP
Message-ID: <aqaflCbYxNRe-13p@lore-desk>
References: <20260911135711.109338-1-jiayuan.chen@linux.dev>
 <20260911135711.109338-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IhgM8RfCWRss2EoK"
Content-Disposition: inline
In-Reply-To: <20260911135711.109338-2-jiayuan.chen@linux.dev>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDE4NyBTYWx0ZWRfXxvToe3a4gj+n
 Sk16gq+DchBjOXJdYfOD7V4I33nx/kVUOAzB23Ht3uCcANTJH/CoV4ZS+msebq0ZFJALIqZsv3M
 a561dDd4sNMhNtBS2I+7Q4YwQFpAN6ThFO28b2hQ8pw5ad2RXKjP9RL4R7w0LF4279pl1vQC0w6
 nTGAaW6MNR0n/uS4OsvpmV702G/5v6UDj8LLB0OyFOIv6lvSjFFhD36Yt5D/HXMyqyrfEsKNOZW
 xpsbzrEorqm+OEJCcKsSnjKgRZgHJYYpuhddVgLlihEEHcUamnAmeqoUPNThli9AAlqzyQkPT0o
 wjdlScuI3m1IRlLkGFWxEIKt68TLf/5Ap5UrskNUi2AMoLLYXVU4Gv8XgJOz6f3I+yhcVATaeMr
 x43PmqWfM9jj7OhBwXYhQiYw507XwqDarBw9GPh/wIyVhaRrxtMrQ1AfagSJlvugGgnApC+GgL1
 qpe1jdby5FgP+Ee2CWw==
X-Proofpoint-ORIG-GUID: cl23znAfa-n-uTh_0t3pCEhBOcX0o8Qx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDE4NyBTYWx0ZWRfX4nOhG5OP9Uu5
 fJqvFaroZWWQ482GEU6PgrPfXfTIvTjV6MEalT9VnOdS2AXI4L0pjrN+N2sEhpzML5j4+VtUd0L
 ok3DRTmmScl62DwRx4UET+MJ1xZTAp0=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa69f99 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=edf1wS77AAAA:8
 a=hSkVLCK3AAAA:8 a=LSqRACfL7P9x1fQBVswA:9 a=CjuIK1q_8ugA:10
 a=MsDrpbGXjJa3Vg-UeTYA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: cl23znAfa-n-uTh_0t3pCEhBOcX0o8Qx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130187

--IhgM8RfCWRss2EoK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> bpf_xdp_shrink_data() frees a released frag via __xdp_return() using
> xdp->rxq->mem.type, but that type is wrong for skb-backed XDP: the skb is
> cow'd into page_pool memory while the rxq still says MEM_TYPE_PAGE_SHARED,
> so the page_pool page is freed with page_frag_free() and we hit
> "Bad page state ... page_pool leak".
>=20
> Both generic XDP and veth are affected. A non-linear skb is cow'd into
> page_pool memory (skb_cow_data_for_xdp() -> skb_pp_cow_data() for generic
> XDP, veth_convert_skb_to_xdp_buff() for veth), so its frags become
> page_pool pages while the rxq keeps MEM_TYPE_PAGE_SHARED.
>=20
> We can't just fix rxq->mem.type in place:
> - generic XDP: xdp->rxq is dev->_rx[queue].xdp_rxq (see
>   bpf_prog_run_generic_xdp()), a shared rxq that other CPUs may access in
>   parallel, so we must not write to it.
> - veth: rq->xdp_rxq.mem is shared per-queue state that veth resets on XDP
>   teardown, and with GRO that reset runs without stopping in-flight NAPI,
>   so a type stashed there can be clobbered under a packet still in flight.
>=20
> Adding a check in __xdp_return() or bpf_xdp_shrink_data() itself is not an
> option either: without recording it somewhere, both can only guess the
> frag's memory type, which quickly gets confusing.
>=20
> So record it in the xdp_buff. A dedicated mem_type field (mirroring
> xdp_frame->mem_type) would read more naturally, but it grows xdp_buff, and
> struct xdp_page_head embeds two of them, which shifts the layout the
> xdp_do_redirect live-frames selftest hard-codes (MAX_PKT_SIZE). So use a
> flag bit: add XDP_FLAGS_FRAGS_PAGE_POOL, the two skb-cow sites set it, and
> bpf_xdp_shrink_data() frees the frag to the page_pool when it is set,
> otherwise it keeps falling back to xdp->rxq->mem.type unchanged.

I have not looked into the details yet, but I am wondering if it is possible
to just move xdp_mem_info type (or ever the full xdp_mem_info) in xdp_buff =
and
remove it from xdp_rxq_info struct. What do you think?

>=20
> The flag describes the buff, so the buff <-> frame conversions have to ke=
ep
> it consistent:
> - buff -> frame: xdp_update_frame_from_buff() copies xdp->flags into the
>   frame. veth XDP_TX/XDP_REDIRECT hand the frame to the peer, and cpumap
>   and devmap run a second program on it, so the peer would inherit a stale
>   tag; strip it, an xdp_frame describes its memory with ::mem_type.
> - frame -> buff: xdp_convert_frame_to_buff() rebuilds a buff, and veth and
>   devmap then run a program whose rxq says MEM_TYPE_PAGE_SHARED even for a
>   page_pool frame (only cpumap copies mem_type into the rxq). A shrink
>   there leaks the same way (this predates the series: bpf_xdp_adjust_tail=
()
>   frees frags by rxq->mem.type), so re-derive the flag from the frame's
>   ::mem_type.
>=20
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in gene=
ric mode")
> Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
> Fixes: bf25146a5595 ("bpf: add frags support to the bpf_xdp_adjust_tail()=
 API")
> Reported-by: syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D237bbeed8dfe0699b7f5
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  drivers/net/veth.c |  6 ++++++
>  include/net/xdp.h  | 30 +++++++++++++++++++++++++++++-
>  net/core/dev.c     |  6 ++++++
>  net/core/filter.c  |  7 +++++++
>  4 files changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 6ed3ee81153fb..a3fdf1959b76c 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -775,6 +775,12 @@ static int veth_convert_skb_to_xdp_buff(struct veth_=
rq *rq,
>  	if (skb_shinfo(skb)->nr_frags) {
>  		skb_shinfo(skb)->xdp_frags_size =3D skb->data_len;
>  		xdp_buff_set_frags_flag(xdp);
> +		/*
> +		 * A nonlinear skb was cow'd into rq->page_pool above, so the
> +		 * frags must be freed to that pool, not via the rxq's
> +		 * MEM_TYPE_PAGE_SHARED.
> +		 */
> +		xdp_buff_set_frag_pp(xdp);

Even if it is not a real problem at the moment, I still think we should
set it not just if we have a non-liner skb, but for all skb returned by
skb_pp_cow_data().

>  	} else {
>  		xdp_buff_clear_frags_flag(xdp);
>  	}
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c358..8fd4139e9cbd3 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -81,6 +81,14 @@ enum xdp_buff_flags {
>  	 * XDP program is not attached.
>  	 */
>  	XDP_FLAGS_FRAGS_UNREADABLE	=3D BIT(2),
> +	/*
> +	 * frags are page_pool memory even though rxq->mem.type is not: a
> +	 * skb-backed XDP buff (generic XDP, veth) is cow'd into a page_pool.
> +	 * xdp_buff only: an xdp_frame describes its memory with ::mem_type, so
> +	 * this is stripped in xdp_update_frame_from_buff() and re-derived from
> +	 * ::mem_type in xdp_convert_frame_to_buff().
> +	 */
> +	XDP_FLAGS_FRAGS_PAGE_POOL	=3D BIT(3),
>  };
> =20
>  struct xdp_buff {
> @@ -131,6 +139,16 @@ static __always_inline void xdp_buff_set_frag_unread=
able(struct xdp_buff *xdp)
>  	xdp->flags |=3D XDP_FLAGS_FRAGS_UNREADABLE;
>  }
> =20
> +static __always_inline void xdp_buff_set_frag_pp(struct xdp_buff *xdp)
> +{
> +	xdp->flags |=3D XDP_FLAGS_FRAGS_PAGE_POOL;
> +}
> +
> +static __always_inline bool xdp_buff_is_frag_pp(const struct xdp_buff *x=
dp)
> +{
> +	return !!(xdp->flags & XDP_FLAGS_FRAGS_PAGE_POOL);
> +}
> +
>  static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff =
*xdp)
>  {
>  	return xdp->flags;
> @@ -394,6 +412,15 @@ void xdp_convert_frame_to_buff(const struct xdp_fram=
e *frame,
>  	xdp->data_meta =3D frame->data - frame->metasize;
>  	xdp->frame_sz =3D frame->frame_sz;
>  	xdp->flags =3D frame->flags;
> +	/*
> +	 * frame->flags never carries XDP_FLAGS_FRAGS_PAGE_POOL (it is stripped
> +	 * in xdp_update_frame_from_buff()); re-derive it from the frame's own
> +	 * memory type. veth and devmap rebuild a buff here and run a program
> +	 * whose rxq says MEM_TYPE_PAGE_SHARED, so without this a shrink would
> +	 * free a page_pool frag through page_frag_free().
> +	 */
> +	if (frame->mem_type =3D=3D MEM_TYPE_PAGE_POOL)
> +		xdp_buff_set_frag_pp(xdp);
>  }
> =20
>  static inline
> @@ -420,7 +447,8 @@ int xdp_update_frame_from_buff(const struct xdp_buff =
*xdp,
>  	xdp_frame->headroom =3D headroom - sizeof(*xdp_frame);
>  	xdp_frame->metasize =3D metasize;
>  	xdp_frame->frame_sz =3D xdp->frame_sz;
> -	xdp_frame->flags =3D xdp->flags;
> +	/* XDP_FLAGS_FRAGS_PAGE_POOL is xdp_buff only, don't carry it over */
> +	xdp_frame->flags =3D xdp->flags & ~XDP_FLAGS_FRAGS_PAGE_POOL;

IIUC this is only necessary for the veth case, right? If so, I would sugges=
t to
move it in veth driver (or to have a helper function called just in veth).

Regards,
Lorenzo

> =20
>  	return 0;
>  }
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 290e0f099e6bf..94268f4d3c5f7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5532,6 +5532,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, =
struct xdp_buff *xdp,
>  	if (skb_is_nonlinear(skb)) {
>  		skb_shinfo(skb)->xdp_frags_size =3D skb->data_len;
>  		xdp_buff_set_frags_flag(xdp);
> +		/*
> +		 * A nonlinear skb was cow'd into page_pool memory by
> +		 * skb_cow_data_for_xdp() before we got here, so the frags must
> +		 * be freed to that pool, not via the rxq's MEM_TYPE_PAGE_SHARED.
> +		 */
> +		xdp_buff_set_frag_pp(xdp);
>  	} else {
>  		xdp_buff_clear_frags_flag(xdp);
>  	}
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e7535523..d34ba56d79d8f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4378,6 +4378,13 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *x=
dp, skb_frag_t *frag,
>  	if (mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL) {
>  		netmem =3D 0;
>  		zc_frag =3D bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
> +	} else if (xdp_buff_is_frag_pp(xdp)) {
> +		/*
> +		 * Skb-backed XDP (generic XDP, veth) cow's the frags into a
> +		 * page_pool while the rxq stays MEM_TYPE_PAGE_SHARED, so free
> +		 * the frag to the pool, not via page_frag_free().
> +		 */
> +		mem_type =3D MEM_TYPE_PAGE_POOL;
>  	}
> =20
>  	if (release) {
> --=20
> 2.43.0
>=20

--IhgM8RfCWRss2EoK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqaflAAKCRA6cBh0uS2t
rHNBAPkBHi09tn1jQ/byaHiBeGbsxzmeuu/TzTI7dk6V/wHKxQEA67Ovgsf+Cg4A
oXBSPVc4vic9RMJpfzh6FXJYmpdXSwk=
=NGTU
-----END PGP SIGNATURE-----

--IhgM8RfCWRss2EoK--
