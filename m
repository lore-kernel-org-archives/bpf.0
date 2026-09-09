Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95786218EBA
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928060; cv=none; b=DzLDC4bs6jc6B3l5XCZt9uvsJ4XsP0aY3E4GKhbsarO1srYG8pTC5TIlvh64GfbIeYUkRJIQlKyZaiF54np/nefAeaqq/Ac8aWqnhlRfU2vcpaVcQo/SHJk3WvBllb2JLV4TTNHTZ0rx2pCGO/tvmzQf//ufEmpPvuPD1W2HqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928060; c=relaxed/simple;
	bh=AQh0DnUn/QQR6cYF+IfoPIhyN5htSqg8CRDUSS+ku0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DpRXgQrF+bJQFl+wG9ZtVUvZ6odVD88/cDx8DzxFNA/wPLQwSCLk8bLapXUuO0N77uhgf5Tyk0HAwc8KJq8+ragtdkywvBHXn8y7GpX3akTqShMHKrZJswOJdIdM6atErgJYyUvcWK9SEX9CnTRuDmbRI0mMbt0WhwGTKTg4z4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzeK653L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzeK653L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D7B1F00A3A;
	Wed,  9 Sep 2026 04:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788928059;
	bh=0yLqaFh7KINPo8BQZY83oaqMVwEKc6HtBpY5RlsvztQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzeK653LKT1uwXguskG2hc58Xo8olOg+3hWCAUkobjOlECpgNNwRPmBJRpXEdE6ej
	 DkeoTd6twKOB6rSpwXolYEXS2zQkfRmRW+5caW/x1HZjJqdiJ6jQNMrATBg/NjUf0n
	 FlDaHdC+b+AsHAe59/AZZSmtBgMSEAgSZ+h1L+AgN4my0y9QNMl+bKAJLmvlZVKJWz
	 oag7D70dgF7StSYPDkWj9VIQHSCGPJHLVUriRh5Wh4iI/3thbKPYbK4vucntyFtxWK
	 5XYzL+T/xL/Lug77ctnsQXH9WXmT150MR19Iy1jiGkWEi2n2DjsMxoBRee2wYO26dn
	 Tw0sdDhvRot1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: disallow bpf_skb_pull_data() for
 LWT_SEG6LOCAL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909040807.3885815-2-bestswngs@gmail.com>
References: <20260907192129.557377-2-bestswngs@gmail.com>
 <20260909040807.3885815-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:27:38 +0000
Message-Id: <20260909042739.20D7B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] LWT-specific SRv6 helpers (bpf_lwt_seg6_action(), bpf_lwt_seg6_adj=
ust_srh(), and bpf_lwt_seg6_store_bytes()) can leave srh_state->srh danglin=
g if an error occurs after skb->head is reallocated, leading to a Use-After=
-Free when the BPF program finishes.
- [High] bpf_lwt_seg6_adjust_srh() corrupts cloned SKB data when shrinking =
the header (len < 0).
--

commit 432b32d6ccc70f500393dbc29ce68e92bc184b1c
Author: Weiming Shi <bestswngs@gmail.com>

bpf: disallow bpf_skb_pull_data() for LWT_SEG6LOCAL

An LWT_SEG6LOCAL program can invalidate its cached SRH with
bpf_lwt_seg6_adjust_srh() and then call bpf_skb_pull_data(), leaving the
per-CPU SRH pointer dangling. This commit disallows bpf_skb_pull_data() for
LWT_SEG6LOCAL programs so the verifier rejects this unsafe combination.

Link: https://lore.kernel.org/bpf/DL9COXZQXX4V.1FN45QO2Q77ZH@gmail.com/

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8513167a858a8..2a84f9d011314 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9044,6 +9044,8 @@ static const struct bpf_func_proto *
>  lwt_seg6local_func_proto(enum bpf_func_id func_id, const struct bpf_prog=
 *prog)
>  {
>  	switch (func_id) {
> +	case BPF_FUNC_skb_pull_data:
> +		return NULL;
>  #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
>  	case BPF_FUNC_lwt_seg6_store_bytes:
>  		return &bpf_lwt_seg6_store_bytes_proto;
>  	case BPF_FUNC_lwt_seg6_action:
>  		return &bpf_lwt_seg6_action_proto;

[Severity: High]
This is a pre-existing issue, but do these LWT-specific SRv6 helpers also
leave srh_state->srh dangling if an error occurs after skb->head is
reallocated?

For instance, in bpf_lwt_seg6_action(), if bpf_push_seg6_encap() fails, the
error path skips bpf_update_srh_state(), leaving the cached SRH pointer
dangling if the head was already reallocated:

net/core/filter.c:bpf_lwt_seg6_action() {
        ...
        err =3D bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6,
                                  param, param_len);
        if (!err)
                bpf_update_srh_state(skb);

        return err;
}

A similar pattern appears in bpf_lwt_seg6_adjust_srh() where an early return
on ipv6_find_hdr() failure misses updating srh_state->srh:

net/core/filter.c:bpf_lwt_seg6_adjust_srh() {
        ...
        if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
                return -EINVAL;
        srh_state->srh =3D (struct ipv6_sr_hdr *)(skb->data + srhoff);
        ...
}

If the BPF program ignores the error and exits with BPF_OK, does this allow
input_action_end_bpf() to call seg6_bpf_has_valid_srh() and write to the
dangling pointer causing kernel memory corruption?

>  	case BPF_FUNC_lwt_seg6_adjust_srh:
>  		return &bpf_lwt_seg6_adjust_srh_proto;

[Severity: High]
This is another pre-existing issue, but does bpf_lwt_seg6_adjust_srh()
corrupt cloned SKB data when shrinking the header?

When len is less than 0, the code skips skb_cow_head() and directly
modifies the SKB via memmove():

net/core/filter.c:bpf_lwt_seg6_adjust_srh() {
        ...
        } else {
                ret =3D bpf_skb_net_hdr_pop(skb, offset, -1 * len);
        }
        ...
}

If an LWT_SEG6LOCAL BPF program is executed on a cloned SKB,
bpf_skb_net_hdr_pop() verifies the buffer via pskb_may_pull() which
returns 1 without uncloning because the target data is already within the
linear portion.=20

Will bpf_skb_generic_pop() then use memmove() to modify skb->data,
corrupting the data buffer for other users of the cloned SKB?

>  #endif
>  	default:
>  		return lwt_out_func_proto(func_id, prog);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909040807.3885=
815-2-bestswngs@gmail.com?part=3D1
