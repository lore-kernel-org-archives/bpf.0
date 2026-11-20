Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163114;
	b=5BMw+3ftxBbGe865ss+Q0+n7vD8izl0Z+3q6+DXurvaFi3TgWQ2gPfoQACPwCw3Uvmki
	 ibMiED4hhGBMPMicWUkQ9UWkZSU6jBHORytNKRP+sHOrQr27GJzvu0v0/mvGGUCmncGdQ
	 zyFFCHnjzoDyyzIwow4nC8dUn1C1T4t9/ZykJy/3SnK6VXjHrxnHcw8h1xT3geFwLB5h+
	 kIiuEWGLdsQFWHzVjKrdZq1DahRKqfEsKkJYnP59q5EoENoQ0zD114CTOq4Ken/4Sf76S
	 GtRSGSsZXClPYHV8OeUuy/RPWV8/sP52/0RlFE0Bo9ixDAEeof9SpctY2b9gOymMktA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163114;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=K5oaAvv2eua2tu733A3jt/kl277TiCPEKT1zocE+LPQ=;
	b=t+lMzitpPEZHoFBt66H8lsCd78yA89GIorLwux16+2cdcd/sBTNgcTFhaYV6/23aSHlq
	 pTqQ4IWMofod2yv/sHOrKgN6MgegSzosC5fQYQkHwctFg3CJ7dEmTdNfQSsaNET87X6K/
	 /x86SwjhNvy5lZX90AWDNy6OZqHVtWfBWPUbtjXA+A2VmcwzEvpjP629NQRTrCbY3bWWD
	 RO6nBdsOXKClYCzP4EdIqyYLgMS1RNN63lSWa1+A1sgP6laeOLulTCOXgUnzB1dkn5VD/
	 Pqntj4QirK4/Q99h0ZkfIqwRF86o4EAOCvtsrYcggd83HSw10G3i60WBaqZKgr7zHxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOxkmPw7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A245606A326
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOxkmPw7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8A21F000C6;
	Fri, 20 Nov 2026 08:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163114;
	bh=K5oaAvv2eua2tu733A3jt/kl277TiCPEKT1zocE+LPQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hOxkmPw7Gg/X0MI7OhOFBGuUPqjuozR5QyMZdF93S4vVz0Q5SzixFe+oO+obW3Mmt
	 +73Ox1u8TS+/c8JRVjfMFENXw6MNBAKs7ssbIZnkraxDRCq4Mi1Yl8286wpGp0XlVZ
	 NvrZD9VPhsCbUSD5N4fRpVI4iaUAaeBqUb/Xm6f1IQyFwIkVBb+tVhRPZZD9+3ChgH
	 K419lr7z9KPNuamD1KMjRt8gl2QXShPrKptnvibuX5ZTC3Nudv87fND8UpRGLV4lan
	 AytWfAZbOQVDzl/I1kFjlBPw/72atUQt2yOA6JKa+nkUz1PWA0h1tCA7gUGdjeVcWa
	 jjJZc4BgNyNjw==
Content-Type: multipart/mixed; boundary="===============4269253814818405099=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <be5f0100ca8784de347b24fec90655fbbce3f5b56f35552caf0bab3f91147c22@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-14-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-14-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 13/49] bpf: Remember how many bytes of a packet are checked
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:12 +0000 (UTC)

--===============4269253814818405099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Remember how many bytes of a packet are checked

TL;DR: Possible verifier state-pruning hole: if regsafe() doesn't compare the
new pkt_min_len, an old state may subsume a current one and accept an
out-of-bounds packet access; the described rules weren't found.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -117,7 +117,10 @@ struct bpf_reg_state {
>  	u32 id;
>  	union {
>  		/* valid when type == PTR_TO_PACKET */
> -		int range;
> +		struct {
> +			int range;
> +			int pkt_min_len;	/* see pkt_min_len() */
> +		};

A subsystem pattern flags this as potentially concerning: a new field that
affects safety for PTR_TO_PACKET and PTR_TO_PACKET_META needs an explicit
comparison in regsafe(), since the packet case compares fields one by one.

The commit message says "A join takes the smaller number. A state with the
larger number does not subsume a state with the smaller number."  I could not
find either rule in this commit or later in the series.  regsafe() is called
from stacksafe() and func_states_equal() in kernel/bpf/states.c, but no
regsafe() is defined in the tree after 32e8f52de3c8 ("bpf: Delete the old main
pass of the verifier").

If the regsafe() that is brought back lets an old state with pkt_min_len = 54
subsume a current state with pkt_min_len = 0, with the other fields matching,
then a later:

    p += -4..4;
    *p

would be accepted on the current path with range 54, although only the
smaller length was checked on that path.  That would be an out-of-bounds
packet access.

Could the changelog point to the patch that adds these rules?  And should the
PTR_TO_PACKET case of the new regsafe() require
old->pkt_min_len <= cur->pkt_min_len?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============4269253814818405099==--
