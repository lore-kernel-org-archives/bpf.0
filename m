Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BC377AB5
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791644643; cv=none; b=ZdWuA/aFVqkKpHPwMRB1ZJUk68zE7kj6XuClOwixL05yE5UrbbcM/POtezAxO3Gj096jw0dUvPobPZ0L1jtki35Mxo5v2NBmM0Qfc3TwysaUcGJ6q57cLUeEkN4P2fzsaQAOEDwEg2t7+UsZHRPo4Wjk7o17U52B/dxpK1n3nxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791644643; c=relaxed/simple;
	bh=rrEuVFF9qt2ExznLnpFSdKJhkx2zEyv13JVuLMjniE0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=W82hFaX2xR9hsigRTlcyTw43HRP5SHS8T9PXuRRX1lNir1CsmDF6xaRgrQPFwVbY7wk46K0GBWwRf6Lyae2/J/yaEeWrLl/R9RNsb6h+Pemoh/t1nziiEnL+ab+dmANzeYCskPXuZFn0xgj2HsNEKfHMCFWiLrwL5Pb1gff6XKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+UOkNex; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+UOkNex"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ccc6b11a19aso203611a12.0
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791644640; x=1792249440; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pNJ6TIjTklQSSAZPNgokCc7WCHaLss8vICq1aN2yffs=;
        b=c+UOkNexBfyZ6OfA5JrblBtVkgMLD+JUhVzzZJlZfzmOo0n67raK+Xx0TuVbGPa9ra
         VAnh9RQ9FSvtyN1JjVes8+feycdSAJB3XsD3YKScfmy9ndNB28YKRU2opdM9B0agccXP
         54ElgA+qg4d5LKVcVgBgHy/8qpkWG87iyLPLCbpy2ZP6PAZ7g847fiSpqMUSFtMRDDSx
         JrT2J8fm/YALUkhtiJVmv8sznKMpjlXv3Hq/J7A2f+QnWA2e6W2qpAXAjanebqRwg+OL
         FQgFWR6zM5IbdDXiXBzbDXzTdChqZDTH/zju6OfdjjboyiSsESeKeVA7x88+0BCjAbvI
         VC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791644640; x=1792249440;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pNJ6TIjTklQSSAZPNgokCc7WCHaLss8vICq1aN2yffs=;
        b=cJu2+FDuNfW3EPBdb7POR6y7/Z0qjay47WIyKjyonxvfvRnBvpNMJpnklV6lqKHxPc
         TOtg8eMk9QFKZlHfaVix2wKUAixB53wKtTkQwdrKyVJL4w8CXbnV75kXCg55GbjxN/DD
         Q9rzgg/llNra1xiLAy85dXoSxRRppL37YeIdeRI4saOG1javY0kb6WkfR9IGsPTrWxH/
         wVB/ShWHKkWcKEunWG+qS9Qz4GEfQWDxwOEuLbjZ/HDv0AtI54pkQn2Xvl+Q2b38+xTc
         2LgqNTk54VbPIz2+XDrYUm3seji7LhvDIC+R+17PceqwPrXVUJWIZJqW1CAJdouJT6Eh
         lYsg==
X-Forwarded-Encrypted: i=1; AKwUvByMdt27CIt0sQuMUkB1hZD0SA6xYMuaw5naEIOVw46aSTe0c6vtw79D8tL5+ZFeO7bH/sY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBR7u9kzEY/UOlyz5pWucq7GfxCjsIYRI+wsKZUb2qdRF1XBDH
	wULoUEVKiSpZuMDRguf+irCOEAjiAx3MoiAoE/QaStG0/VtRfCxxL8SB
X-Gm-Gg: AYBFou1D4ImKmDadfm8EYib8Vjr14MNfJEDnvhqXHlMZVMKV8wxHyOX6LzzkjhJs6G0
	QwietJq9qN4vNOMsgrLvTYMwQMipSRloWE83SdbirVkShTKh6B8MiFgIxKhfy5OcCVc35FauqN+
	crvAgzgysMrQ1y8LtawfoLQlDB0tAG8bGZeGKvtcbxAtAnmJQb176eCo7kiglLEHnVCoXhwRDED
	lijAQ0TNsYncSMm894VziKzu98iyYK9wMuavMJyNDwcsEbT+hzolD7sbVW5q4+vhLSg288w+thP
	EgGSaKASNIH7HDd32l9hwOpXEVkd0cBLZg1K7IC5x1lX4+jFqF3dFyBvN3VlTDQ3T8DAUE0X066
	pf+TwiaJbmzyQPUDmCR3WFZ309nFcmc8F4mydXwyO3iWYEMWClYYT6BS5kYtN7Hni93CHcBt122
	0lFLo9fI3ORHXDPAz7r63mGE1nb1aDH7JCahVIoNacS6CZls/jfDsSolqk8ANdXbbB9hGvDT4Tz
	a6E8o52QXbxHUmWTWR7lKo6KRgSi6nCYqMPMQZ9jyefIz1+ls/WnjZwHn2R5F4oSs14swuDvnPm
	l84=
X-Received: by 2002:a17:90a:1016:b0:3a7:ee74:e8cb with SMTP id 98e67ed59e1d1-3ab3a94fff3mr2710215a91.11.1791644639568;
        Sat, 10 Oct 2026 08:03:59 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38fc9e52sm8380984a91.13.2026.10.10.08.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 08:03:59 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 10 Oct 2026 15:03:58 +0000
Message-Id: <DM190ODIIKXQ.342O0FWIBBKTB@gmail.com>
Subject: Re: [PATCH net 1/1] net: lwt_bpf: preserve encap header across skb
 head realloc
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ren Wei" <weir@nebusec.ai>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Cc: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@kernel.org>, <zirajs7@gmail.com>, <fmancera@suse.de>,
 <leon.hwang@linux.dev>, <luoxuanqiang@kylinos.cn>, <posk@google.com>,
 <vega@nebusec.ai>, <rakukuip@gmail.com>
In-Reply-To: <68db88ada2fd01fc03f17dc7d54a705aa245ddea.1791433504.git.rakukuip@gmail.com>
References: <cover.1791433504.git.rakukuip@gmail.com> <68db88ada2fd01fc03f17dc7d54a705aa245ddea.1791433504.git.rakukuip@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 09, 2026 at 12:59 AM Ren Wei <weir@nebusec.ai> wrote:
> The BPF verifier permits an skb-backed bpf_dynptr_slice() pointer to
> satisfy the helper's ARG_PTR_TO_MEM | MEM_RDONLY header argument.

That's the bug. Fix it there.
PTR_TO_PACKET is rejected as 'hdr', since the helper doesn't have
pkt_access. None of the helpers in bpf_helper_changes_pkt_data() do.
The slice of skb dynptr is the same memory, but it's PTR_TO_MEM
and check_helper_mem_access() lets it through.

> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")

Wrong tag. There was no way to pass skb memory into this helper before
commit 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr").

> +	if ((u8 *)hdr >= skb->head && (u8 *)hdr < skb_end_pointer(skb)) {
> +		memcpy(hdr_buf, hdr, len);
> +		hdr = hdr_buf;
> +	}

Patching it in one spot doesn't help.
BPF_LWT_ENCAP_SEG6 mode of the same helper does skb_cow_head() and then
memcpy(isrh, osrh, hdrlen) in __seg6_do_srh_encap().
bpf_skb_store_bytes() does bpf_try_make_writable() and then
memcpy(ptr, from, len). When offset is in frags __pskb_pull_tail()
reallocates the head and 'from' is stale.
bpf_dynptr_write() into skb dynptr and the rest of seg6 helpers
are the same.

Reject reg_is_dynptr_slice_pkt() arguments in the helpers that
change packet data.
commit a6c1edfbe240 ("bpf: Reject pkt arguments in mutating subprogs")
did that for global subprogs.
ing_cls_dynptr_write() in test_xdp_meta.c will need an update.

Add a selftest and target bpf-next tree instead of net.

pw-bot: cr
