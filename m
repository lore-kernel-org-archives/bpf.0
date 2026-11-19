Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118562;
	b=cNZ3jwKiorpxrGfbp8CaHbChEcjtXWPU/Uzs1pZJ472zrKdpzlKp5PiQ+3AGymucPcVa
	 QefD3kzudvHIbHVqDAHQTdc1fyKuY3zbVDgBTVL2PS3xivXjBv0m+cjTPq4MZrVDfSN6c
	 MtabZbIVeExDNpJja8rcCE5OKpuTqjaYGDPo8apzoF5eXfPLT/DqkybbZA0btLtXjdq98
	 J352fTbxUCE6MS9rM+DP0DnXPDDkTtJmKHa/vCPOdWwBL6AM8F/iMg7Q2zjLWpB+hWlYm
	 mH1hKRQQZ4FoXjhGcsmGKeNHFEHuTA8ZpyDN9Oit5FDqekvzuZ++NivLOES4RWFec2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118562;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yS5HZGb4ZYV7fzhYyCITQ/ILCiUQlwy/aDQIF+31MW8=;
	b=i31hE0NfRR69/uxeX3XCN8+shdE+Dl8XUq6mPeVaNesWw6frPljEJi2HLK3pTLwR58Yt
	 II261cAk5mhI6dh2qRdy1nATmUyHBAQHn0hTDIxIrbTnanJAsaGCT29pKFeQ5wA+SCeTu
	 Y33QtVWt/bK01BJd1l0/71ii8eQ6iZtLXd1+uQHAaYjlSP4Yiixor4OswshooVXDIIzjN
	 fLghMB0pMx3FquCdQwJEnRjDnNAAvV0hyXv5uZb9OjbKJHVcfo36KZu8mXob2GscXMK6L
	 ckJ/+CdCl2AqWUVMJmJuyWQGQif7Vu3UUYk/tR4S2s4lqBGdzGsWvEzPTU4NzC4IUgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fxU/TGcC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B884606A324;
	Thu, 19 Nov 2026 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxU/TGcC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BDA1F000C6;
	Thu, 19 Nov 2026 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795118562;
	bh=yS5HZGb4ZYV7fzhYyCITQ/ILCiUQlwy/aDQIF+31MW8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fxU/TGcCrY5xlJwFFLlAn1jTWV0E5hTnmdN+IJB9RNcS+a2vw+7uiwuntML6Sw1d3
	 Z7fp5QL6FsWvBNluBljxGexs56t7UNh4LZfNHad68IONQMoMsPncnV2376zbbxFwtS
	 ndGZvc7ZBTPtk5bzUBInv4x19bp1Ach9QXK45SPmNauF4/Y2wGjzEv60klCxoKaoxN
	 bHT9/bxJEmnW749qgs71MIZE/s+/X2dwZaStZ89ZFDxc/6dMlAd1gR6Nhoh226pkH7
	 BqmxZxQ7/qDudV1kXRaHI8J4C1bwmMWuAwPSSF0VjaJXN5pO/c2SNOi3b6VhkxcseC
	 7IVbvd9N+EwPg==
Subject: Re: [PATCH net-next v4 1/4] net: xfrm: interface: restore dst_orig on
 every xfrm interface
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bpf@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com,
 sashiko-bot@kernel.org
Date: Thu, 19 Nov 2026 20:02:40 +0000
Message-ID: <179511856062.3136.18243971639206515341@kernel.org>
In-Reply-To: <CORE-9NOG.v4.r0.20261116135311-1@mojatatu.com>
References: <CORE-9NOG.v4.r0.20261116135311-1@mojatatu.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This commit fixes real, user-visible bugs but carries no Fixes:
  tag.
- [Low] The commit message does not mention that the old per-cpu design
  leaked a route reference, and that this patch fixes the leak.

--

net: xfrm: interface: restore dst_orig on every xfrm interface

This commit makes xfrmi_xmit2() restore dst_orig from the xfrm metadata
in both the collect_md arm and the configured if_id arm. It takes its own
reference with dst_clone() and drops the metadata dst from the slot
first. It also switches bpf_skb_set_xfrm_info() from a shared per-cpu
metadata dst to a per-skb one and removes xfrm_bpf_md_dst.

> net: xfrm: interface: restore dst_orig on every xfrm interface

[ ... ]

> The same slot overwrite is in the unstable helper a tc-bpf program uses to
> attach that metadata: bpf_skb_set_xfrm_info() records the route as dst_orig
> and installs a per-cpu metadata dst over it. The per-cpu dst is shared by
> every invocation of the program, so the restore cannot keep anything in it.
>
> The Fix:
> Restore dst_orig in both arms of xfrmi_xmit2(), taking a reference with
> dst_clone() so the metadata dst keeps its own, and empty the counted slot
> with skb_dst_drop() before the route is installed. The helper allocates a
> metadata dst per skb instead of a per-cpu one, so the route it records
> belongs to that skb and is released with it; the per-cpu allocation is no
> longer used and goes away.

[Severity: Low]
Should the commit message also say that the per-cpu design leaked the
route reference, and that this change fixes the leak?

Before this patch, bpf_skb_set_xfrm_info() moved the skb's reference on
the route into the shared per-cpu xfrm_md_info:

	skb_dst_force(skb);
	info->dst_orig = skb_dst(skb);

	dst_hold((struct dst_entry *)md_dst);
	skb_dst_set(skb, (struct dst_entry *)md_dst);

Only the collect_md arm of xfrmi_xmit2() returned that reference, by
clearing md_info->dst_orig. Some packets never reach that arm:
TC_ACT_SHOT, a redirect to a non-xfrm device, an xfrm interface with a
configured if_id, or any drop before xmit. For those packets, the next
helper call on the same CPU overwrote info->dst_orig without calling
dst_release().

xfrm_bpf_md_dst is never freed, so metadata_dst_free_percpu() never runs
for it. The route therefore leaks, along with the net_device reference it
holds. That can leave the device stuck in "unregister_netdevice: waiting
for <dev> to become free".

With the per-skb metadata dst, the route is released when the metadata
dst is destroyed:

dst_destroy()
  metadata_dst_free()
    dst_release(md_dst->u.xfrm_info.dst_orig);

At the moment the message only says the per-cpu allocation goes away.
Could it mention the leak as well?

[ ... ]

> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Should this patch have a Fixes: tag?

These three pieces all appear to come from the same commit:

- the per-cpu metadata dst in bpf_skb_set_xfrm_info()
- the xfrm_bpf_md_dst pointer in net/core/filter.c
- the collect_md-only dst_orig restore in xfrmi_xmit2()

That commit is:

Fixes: 94151f5aa966 ("xfrm: interface: Add unstable helpers for setting/getting XFRM metadata from TC-BPF")

The configured if_id drop and the clone sharing problem date back to
that commit as well. The slot overwrite started to warn, or panic with
panic_on_warn, only after a890348adcc9 ("net: Add skb_dst_check_unset")
added this check:

	DEBUG_NET_WARN_ON_ONCE((skb->_skb_refdst & SKB_DST_PTRMASK) &&
			       !(skb->_skb_refdst & SKB_DST_NOREF));

The message says the tc-bpf case needs no other patch from the series.
Without the tag, stable tooling can't tell how far back the fix applies.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/CORE-9NOG.v4.r0.20261116135311%40mojatatu.com
