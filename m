Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA54AC162
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384534; cv=none; b=LbNSdVr5pXHwV0Oyarr/xroTijoTsJz07UwU6gBR+Bof28/7Nxz0gmln/WO2/0ApN7gIKoVvcWia8b4KtELBW0/J4XmKtCioEhGg23mWKMy1b3u4tn/c3RhtopLT4DnEED2b1/xbBtlJBIAW7pDyByiS9jBLDVsQqgovj1vYbvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384534; c=relaxed/simple;
	bh=7Y2j2y6ajaG/zDk1wERigWBnYImYN4e7RWhBT0nBLk0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JmMbz80nAGwW9/3fvK6JkhsLgBkN0qJp21XY7DmnHPlOlfPjujoeB+VeUnowMbirNZWD3uxXvprGDYAfXOySs/4qUDTP6xGvD3MrBoIi05XcFsKO/Dz+JQnXckGGRNF7+zE6wkU7pRHgdKOlV7m8K/BL5ZwTgjPrA0XhEtP6m5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBh1OzzV; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBh1OzzV"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ab432273c5so20726397b3.3
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791384529; x=1791989329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dfiB9VnO/q2CSY+pSu0B7BRn9rM8krRdw97n0xu/4ys=;
        b=iBh1OzzVt5rLZycOZGB+FE/Dx7KJ94fIf5Tln25acSfTQME3YfWMkMU62E6sKlVtg2
         GFzOTKFOECNZit0yflIkuVmPXI0twmZ3QVT78uj1L1UKiZrUiAO615JR42NZOVOCtOTi
         OmUMw4ddDMT3i/yomQAGbVrn9SyIUZaTSzjtOVzbAC7hanKHhf3fS0WmivGKRK+2y7Vb
         Xz9O3G62LOmHc+XTte+l0S5FXF/PzxW2O/OvE/Cwlt8xlwEyFBzBRNbowoF6IZwS+w51
         4U94T3pFA1sDXagXwi8coKdE2omF3Oyl4ak8VmA0G7pe65K98ARH/VCUv0TW7i8GCRLx
         plDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791384529; x=1791989329;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfiB9VnO/q2CSY+pSu0B7BRn9rM8krRdw97n0xu/4ys=;
        b=bLGc6ptVR476ZgbdUNk0+T0+kic+YktxFVkJ2dtjTUOr5StA87LNkVujdZan1g42xV
         QLZhrGwkXyQHvmTUuin5hMOiDNRiapjiSf4XIFyaF5SD5xW2PFmat7lAIlq7hE8oyqHV
         BQpvclnAqqWWSo1xay10nCzxWVsPC5wBLMVXR9v7EzpZkWUUPvNwfcywNr7/P/T+MHVw
         SVA/cQYjs2clV2fGCOEAtVv1FvAjYGh01xNdsI5KnQMtycFxRuCCeaAzYnL/sk9V8tCB
         trTls+7cI/nySZom0TuHm/U5L7NDjgS19suT9NdZD2/X2wOSWEPrcExo8/sEDsu5MD2d
         K4aw==
X-Forwarded-Encrypted: i=1; AKwUvBysk3l7k4lnK9b7mRjf0xsY9BA/xugre3feGSODfBk8e7ifP0MHqQb+Lmey3nlWqAELYQI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0J3dtA17bnUphat/0fuArg6PyWNVOISopPPAJhI1aloiC/s79
	teO7NT5Beo4mmaXDIC1lQC+O012W2ZJmgvhZt2F2eMXKSb+Kio5/bK7t/rt3yA==
X-Gm-Gg: AYBFou3kVX871aXscefgNkav3NCHtug/0qJ+OAnG76gbnPnwZZy1jxIOCrbk7UjLM6+
	k0lHpCcaGHIDEYyr9h5OJ//C7ImrGhEvxrO7M9aWbRfekgOqBvIx7amwrV2MAR/6lYVT5HEjbOG
	R95oXTJ6NWvymQZGrsMC4QShqyNwFVgGwB9HCoKbiaXqNasm1OqIKEGxSgmDindfUNpPDncLlpu
	jobxyiudz+QpAFqs2XEdP6/0rsf2SGPLdeoqwR6Ydo02iqhbF4+BqWNEq5J54qdMX9Ji5tQzq5g
	zNHdHWF0FZmR+AWXPhPVn8ZkiNg9nN3fohKygj/RCn4SJRvMJ5gHtKDCZxkppfwRJBLVBs4yHoe
	d3B9CisEWYphl7nW/YYGNinTE0oW3sPwc4zGjegvjFxsl4uHZ11lcKAMcys37Csndt7UU/NdnVL
	nUTFRmnotYl/c9nS5OqPBAMmsT8Y/wvdukZuVSvAG863aQqbY+fj3WiJEuZYScmCgdGMBIT3EIt
	L/l5tKCar0jk2a/P8D2cmyy+awbZgMw3Y/sPG8DlPwJrv1ZFm9SZQsKA21cdJD7km7TGlmZqXAx
	jm2yx8sylcrQYtasT/Kd+/MDYyH/mzCAI9XCbA==
X-Received: by 2002:a05:690c:ec6:b0:861:a2ae:8c6b with SMTP id 00721157ae682-8b05ac458e3mr23348817b3.2.1791384528499;
        Wed, 07 Oct 2026 07:48:48 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05abda9ffsm9529857b3.39.2026.10.07.07.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 07:48:47 -0700 (PDT)
Date: Wed, 07 Oct 2026 10:48:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
Message-ID: <willemdebruijn.kernel.140f4eac91ab3@gmail.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
Subject: Re: [PATCH net-next 0/9] net: skbuff: convert most BUG_ON()s to
 WARN_ON_ONCE() and an error
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Josef Bacik wrote:
> I'm going through and reducing BUG_ON() usage in areas that have created
> the most problems for us.  89 commits in the tree quote "kernel BUG at
> net/core/skbuff.c", 31 of them since 2024, and some of those could be
> triggered from inside a user namespace.
> 
> The first patch is a fix: skb_copy_and_csum_bits() leaves stale bytes
> in a buffer headed for the wire when it hits unreadable frags.  The
> BUG_ON() conversion of the same function needs the same handling, so
> it's here rather than sent separately.
> 
> The rest of the series converts 17 of the 19 BUG_ON()s in skbuff.c.
> Each one becomes
> 
> 	if (WARN_ON_ONCE(cond))
> 		<error path>;

Good idea. I was thinking of doing exactly this sweep after addressing
one case recently in commit ee1972def665 ("net: downgrade BUG_ON
EIOCBQUEUED in sock_sendmsg_nosec")

Instead of WARN_ON_ONCE, which still triggers a panic on systems with
panic_on_warn, DEBUG_NET_WARN_ON_ONCE?
