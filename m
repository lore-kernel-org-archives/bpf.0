Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795471290;
	b=ceUiAIkH9kevd/4EtfKoot7sBSMPkc9OK0epkeuBae3EeLcgbzauRFsB5ia6zO/L9IEn
	 ZRFOMDr6aBJRVUnMaOQbQuf8EPoRkL68kpOpDr1RZ7/CbvQrzE8RYCBa+0Hhh92KNgzbs
	 6OFx1IQOAkuhOw44wbj4jtOHp3/kUmyIoQGhU3mH9ObaJqEeBCT6f4TLwFm2mtI8Za307
	 GZlDEsBh9bzKhvVKWCALou9CWK7wSg/cp6v3NA9ZOm855xIK2pHqcNg3tdXfc8M4JV18W
	 ADLKQucv4lD/+UnVBnuEH88G2KHoZVpLc0afbrLstyIjSrvk1TfUVfDBqtzMsTv0sQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=srL4Uf6AX26Xr4iCAP6zHkN1OE8a5FhQcDs//2mI1Q8=;
	b=C5NiOfM1MwflRlOKJQnlBYoCZwBUh4f5Nl/XMReF9/VRY1JHp2pLxrr6lQCbw4vUtiQ3
	 jSIyMGfzoVBOpvoCt9GDybmfCgntaV433gGFUNRYmgHO8+oCxbJDShgHpOFHCQ9S6uUj9
	 an5sQ8dlv9svGE/fS+FkQvCidWZgR/h4k0Dm9HD2jK6EUU2/0GD+CUp+YQvBaaTfzkmJR
	 LfrqM3lpcZSOb/Cel4FR9PdjHib93yI7c9JTHE5i5bGHD8R+rWNz+rO1Xb3l611VGKVZ9
	 nwcU4PeR5u7c1AO/hqptzaHIi1PPdxcBNHakTNfSEH2dlTHMzvm+UHsPxn90bq1xHrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=bIEcMOri;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9E606A32A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F9E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=bIEcMOri
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4877837890fso2143973fac.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 14:01:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795471289; cv=none;
        d=google.com; s=arc-20260327;
        b=mPECR54vExc5cCwDKHWpG7M6MjdXAj4yXhKrGTRWplEictMe8RnT+2VTRKAC5JfUN9
         mmE3Uob/cERlpF5zVwIkvZgxtK7NFKWCpmYaXYB325A5h6UYVDZAFFPWzAJ6M6fQpbxI
         hwjd9IqXYSZSx0U2tHuhNQ6Q9ghA2xhKWVQGr6CFLJHT+h2+KWL3QWN8gLyV7XZzXz4k
         p4uC0YKSeTACMYE3ApDk7yL21UzpvglovJAdGCUP5OOCoxFmsijIVqu+5qVooXKzhQU5
         gXdcKz1SIz5BeZP/1s9DRc+pMerUPvD0VgEAZ/5l17mDLr8gWm8DYzFYAc6Vr1z7u/eM
         cKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=srL4Uf6AX26Xr4iCAP6zHkN1OE8a5FhQcDs//2mI1Q8=;
        fh=9ZKTGBU5oBXOpS5tZggmP8v8kTLF7bZE8T1ZnFmHUMw=;
        b=aAcI7r0dCXg2ZXcidSZ96X+41ecTA6F+K67MUF4qJiNJxKarBpBzo7spLM212y2Ts2
         k9GFfSXpla8rbz8PIrkbFAnGNxxVoqe9qcYoneIv0RWxa4imtYk2u6EUXDHv/8HtA0aK
         mhciq+cNFu4oULKqCDpP8eTPRIytWEB9+rKtco8vEV/Q2WfX1Xu9bC4mI/i7TPTYFloC
         XaGHEkuvCV/7U6eZiBq2LSRovwTtYYyB1W/3cMXX6q1bOffwmqtODaNb/W73VNmHOzd0
         MMZ/SfXWSf2V03KRjkhOMuc/U2U0bEVPXgd/ir3HAmuxME0O4+zd9mSHsACBXTy7uWkW
         p0+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795471289; x=1796076089; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=srL4Uf6AX26Xr4iCAP6zHkN1OE8a5FhQcDs//2mI1Q8=;
        b=bIEcMOri8Aax8dKFPrgYNg8wJhG1TdHlstGt2MlCyltgaYxCPE3njcf/ibhUFjv9+A
         DUCiQLx8Ue8lqs8APjUUIua4gZUO8hcQX5Mpziqka8UfmD+frjU+gJD+i+bF5k7RHgwj
         fpdDp2HDYwI0VfSnwrxLMhUzCsK58c2MIKdK56m2LP31pTpIPMaOGEdrx/LC/YAxGnRV
         xDNA95uN/5YkxdEZ6dQjD3YfWy3iBL1pEQc/bRHawTjj21LlnI30bfI7XWeA5oSCgrC5
         inFIAx1nx0xqQpVBsutU31JvUAm5Z3V0Qg87HKJTPqRxxFl8nRb+b27K2AMX0xRg9Dej
         aBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471289; x=1796076089;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=srL4Uf6AX26Xr4iCAP6zHkN1OE8a5FhQcDs//2mI1Q8=;
        b=FD/iBXqdYD9RUoRYLBn0W33xiq1TLjiA8LRP/FKRZaIa2kv7QRe2CbFr0CQ5DHLRJz
         2hDpZxrY1GhVTMrO72CRZndwWz++aP2CfGtc2/QHjmqaAge4Km34PmH7iipNecsJ5yOi
         m/M9GKBSxr3Bpoa1lhTICDaTt8TWsMNyvwZVn/cwlMLzqvUAQWB2xoDD+i+vuMJQhuDZ
         njP+gNUUtLN8OpVOkWethG6GpIXHxJ2kFEyToCwE4MZW2uhh/3PWdrCsXkvNlHocnEw4
         7/JR9LBS/Fzv5kwUBLfq+AT6fX/nLaMM83fkh+ooMxA0bzXqlBXkzelkxhUKHw9k4WkA
         SM1A==
X-Forwarded-Encrypted: i=1; AL+hErH0U/ms/E4pLAfhkWwYynQgQh11op0+260lunJNcZQvI3MczP7ExIemFY7Mmvz/vY0nKjk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8g48/OMNL77eqCmwj9Kog+D3GvJrRO5PyY5aBRa4Jji/ErKvnF
	NGLJHShURLIVHphgcSD9Yfy2Fb5+rwd8H7veZwjrwNk9QjLzgbRS2m+jWixaiuc5pXlBAmUdS5c
	SVOdaBJnLRlwXsOx8EMY592V/rgX3yoGKtzH5B4ILGQ==
X-Gm-Gg: AZFdTZcVuDgP9b8ZxA+pnCcWIzskbbRNCuaBrE+Fp1/bzQuz0rNTUFo6tlbk6qpEu9o
	tlcTf6Mk0c1fP8Uk7W+t9j81UbivUNQDbHCrNt8JofoMbJnjj4d3MleyM4++zjmBH8Zuf8ZwQYw
	qQ9Xxtg/KrT0//AaYeBA/cMbWZ/Slk0PFAbs2D+EUqQLeAfHGyARDcpvbdxFlvVwK57cQ0Hh7dt
	sot5HIhAOE+5YSJkMKOvvGlRjjq1t9hmW/+YlpFQ1WqFv/IJaVhzlXTjoXBXXPZWXpHoIS9uSRV
	80zQUQgsqUuyF9WU8igsKZfhAM2AuOe/d2lyK135QDRMDPtOFoymlsR69wRHNsH2wFMHhUi898b
	Bptrigv5lE19WOchocC+c2QLuwaehBxGSxgx8acf5SMs09tEimmOFP6GqXRjlrwtzclrGrSA=
X-Received: by 2002:a05:6871:60c:b0:475:a153:2dce with SMTP id
 586e51a60fabf-4bc84926567mr11531088fac.36.1795471288917; Mon, 23 Nov 2026
 14:01:28 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com> <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com> <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
In-Reply-To: <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Mon, 23 Nov 2026 22:01:17 +0000
X-Gm-Features: Aa3M54rB6Tkjt_a_xBRCBKw7WSvCOL2uVv3n24p_DPRCDrCGO9kKs27p19qzjqs
Message-ID: <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Paul Greenwalt <paul.greenwalt@intel.com>, Alice Michael <alice.michael@intel.com>, 
	Eric Joyner <eric.joyner@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	tianyi.gao@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 2026-11-23, Alexander H Duyck wrote:
> For example, one recent one I saw was an issue on the Tx side where
> an outgoing XDP program was modifying the frame and actually not
> updating the pseudoheader checksum. As a result it was breaking Tx
> checksum offloads for NICs that were using the HW_CSUM that used
> that checksum header. We could have fixed it by forcing all the
> drivers to recalculate the pseudo-header checksum, but instead we
> pushed back on the program that was making that change.

Thank you for the explanation, Alex.

On Tx the checksum is in the frame, so the program can fix it. On Rx
the program can't touch skb->csum at all, so there is nothing to push
back on.

> The point is you are fixing things for your use case, but anybody
> who is using the CHECKSUM_COMPLETE to compute the checksum on the
> frames and using XDP without changing the frames will see this as a
> significant performance regression.

Without GCS, TCP and UDP still get CHECKSUM_UNNECESSARY, same as
E810. GCS only came in v6.15, so this just puts E830 with XDP back
to where it was.

The cases I can think of that are truly impacted are IPv6 with
extension headers, and UDP tunnels that the NIC does not parse and
that have a zero outer checksum. These fall back to software
checksum.

And programs that do change the frame are worse off today. Every
packet gets summed again in software, plus the "hw csum failure".

I don't see a fix that meets all of these:

1. It is small enough and can be backported to stable.
2. It fixes the problem fully. We could drop CHECKSUM_COMPLETE only
   when the program moved data or data_end, but some in-place
   writes, e.g. NAT or the IPv6 hop limit, would still trigger
   "hw csum failure". IMO that brings more problems.
3. It keeps CHECKSUM_COMPLETE for programs that do not change the
   frame. But that looks like a bigger change, which doesn't fit
   net.

If you have one, I am happy to take it. Otherwise, as I understand
it, the choice is between:

1. A performance regression for some programs, but no "hw csum
   failure".
2. No regression for those programs, but "hw csum failure" stays
   for programs that change the frame.

I would like to know how the community normally decides between
these.
