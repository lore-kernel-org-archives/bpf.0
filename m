Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793131780;
	b=SApIoLYnxmHVIw9HK02z+PVpC4zLMsPnXRLMVBEwxzi6KMCor0rFwcRDIpsPwJRjVpsl
	 lldU/yojDRYWLcQeHOH63KOomq1/D6unnbRfXNKa6x5qdfZkeBRAflrt3ihqOJFZMKS9b
	 FT3QPUtxa/Wo/jVmZY1M9bK5EtgEp3mGkzYe1rtv4poXrFvlryCnsrq+rv/FNo46WPv04
	 wv5B9HbqBFR9lX0Dz/a5gBa3nK/Ue870A5IwwNm5kgsQ4PbI/yUdpx2icnhcINjHbSjlP
	 ohPDgm7dNqwRTP9Xa3//3I5BfmmR4gWFWOcFo6OoQBtXpA1nQn6GBciXLVZJo1GHuJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/P2TITrzXa/dPGDQewBh/P5JTe2uDqJxgBUDeRvmS0Y=;
	b=1zd5jvzHTTb8okFVs/46uh/QuGSO4pOE+ptAe6Hwn9mUiZv3ia9/GxsixfLaT/lOiT2P
	 Mkvq4md09lMkpjm+axH46SAHEh4VoiNunXrdminUxEdWXYfetouPdor1LYUhFmwWFXrZm
	 rmJUs1XhB1yFlvx/oxn9bv1EY1BIQBrEaErMX3EpG0+m/ZgA1bJDHgS4Uj5mKfxF9xSS9
	 avpCnq5bgfRiLasuqvVrrPNhraa1mHGpgLmYPrz3RCDHC6gir9pANPuPJjzS7oNMwGF7t
	 JUa3nUdi+Lr4Ntzj84j40oWQ5ot2elfNt5XPimqEm0xtbWsjYMBoyk/UiUSb+bUa7Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXmjAZDU;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13072606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 20:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13072606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXmjAZDU
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a01cac8733so213719b3a.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793131779; x=1793736579; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/P2TITrzXa/dPGDQewBh/P5JTe2uDqJxgBUDeRvmS0Y=;
        b=DXmjAZDUN9bXDcXUTC5U27e+ra5u8vEt2f3QGTyVHE0sgXyhJtpCj0bbDiiN4TIc/q
         8W5eGWjkqpjjPXBom3ZzFFeNd3jUnp0YemjVtblA/yOMPo9J7FE4MjeJiyIm0/QTKEdU
         yX1eecB16mDJI7FK/KFhE/LOrj2wQQ7C9k8E5wglAVxBuxv7+77+C5LCthVee7R+tZql
         q/odmZiAA+N94rYQN9NIslbpq539rusAXFMsywfjZzUIlrWiD9LOCLrch0HyRNihbigm
         Q46i9FXunOKPm7dFAM1baXYE4Jkv4LNfOsx6hD/WLpsnVY/XhZnOEF8FE77BeFguEjx6
         S5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793131779; x=1793736579;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/P2TITrzXa/dPGDQewBh/P5JTe2uDqJxgBUDeRvmS0Y=;
        b=g59gxpsCC+KeUMWJcDAbIXLO9PziLhXXOQVnLTld42Wn5AH1M5gJZ2iOo5uEaLHKKI
         Pb6vP03WOgnMIoagi/eITGnTc86evTjbJlZO05/iHk59Ge5HM626T7UAQJsEJiPL1aL9
         bNlWucvrxwfIR/kZNxHrHxYpxQtDOZJDe3AnDc8DH3YJZ8hEWCL3OHRIIt6a/36Qa9mu
         7vqhZryDZRrP6neIgl18W1imQvFk3rCDvQCO+TrVm/tvvCaYlSIsnt3KeC1JbBaI3h/j
         XwpEbvMPfQPcWuqlTZ86m43O6LbMV0atQh4sMNxJIXVcAtBRCRgXchl03rYJJHFrbJ/3
         VAgw==
X-Forwarded-Encrypted: i=1; AKwUvBzPKhAezY833bKdhZBxbjBPBPqc5ov6m/jR4gL3ukwrVcHSp8jRMSkCV9HkxdlO4WCTi98=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNgwYeVOzCWx8OLd1lheGQfgpHKZ2r6UI/3HSYpmwRMkAYh6YB
	rLVw1W3E/qVxD9lINiujhW2LdjU3o/l84y+N/l2v4r2usTtZ7zvlU2R3GC8pxQ==
X-Gm-Gg: AYBFou1B3pnEdXrkBSgy/Dv4MJCVh6zbeEsFDGPlbNgzZ5S+es8QAdRVPnNHghKqhj8
	58hYYbMxy5zGiZogABryit+Dp9AosnV0il9wD9RUj/sGqDRAzIxFI3pNAsRzzgbYtkvLWSVo7e3
	9ShRq7bUIztIr8UETF7dPiXYwSfXfICpVCOgkLf6VqJPtxhMKkKD035ffFsAXwPWvV9IeFzeBpw
	Qi8h3AY3AzIYYgSHd4jAku53L3tOntvbOhIH1zudlJBYPRaU5fut3FT2jETgIUImLU5EaSvm3kr
	eGBC4GlcFOq32vgOPMhHyj99MaSaaLI2IlvJ0VoDEzAUH/5R9OeQWPLqUD3AmpOgy+8Rp0GAO/K
	U+uCtUYzTZA/JBBU/lhdDmQBiAfzkBWpd+qnqhA3KscEnvKYxXBt4k6Wr3n2DK1R5eFoyTFks2d
	jFrZ04k4jXiId4NAoCs17el9hXq13P3WY1QG1NkIdcBR6zkaOx2ZpQFfs9hpkC8nCJpq3ySJNKE
	Nct4GBEDjNVuiYv7D0d4T/tHAaH34g0Pb3A7wBxmbao3QVTu+KAPHdePAK67nVceyv3rp8k35qj
	MhifTcuEWgCVLm134+mm9up64K4hPkeN/BOsncNzJb7rrU2PLvqo9TzdcQEKbeazgQ0BrvOTMXx
	+U9jnyiV4/fi1AUlXGvMwn3mfngjCaXt7GQ==
X-Received: by 2002:a05:6a00:a83:b0:886:9187:1a00 with SMTP id d2e1a72fcca58-8a6e8887c5amr242962b3a.59.1793131779263;
        Tue, 27 Oct 2026 13:09:39 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a6cfa0e7sm440601b3a.36.2026.10.27.13.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 13:09:38 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 20:09:38 +0000
Message-Id: <DMFW5YZ93QUU.1AGG5BSIGD0JW@gmail.com>
Subject: Re: [PATCH v2 bpf 14/19] bpf: Reset the range of a packet pointer
 that scalar evolution clamps
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-187068@kernel.org>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com> <20261027190314.1440199-15-alexei.starovoitov@gmail.com> <sashiko-outbox-187068@kernel.org>
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

On Tue, Oct 27, 2026 at 12:30 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +		if (type_is_pkt_pointer(reg->type))
>> +			reg->range = max(entry_reg->range, 0);
>
> [Severity: Medium]
> Should bpf_widen_scev_regs() also clamp reg->range with max(reg->range, 0)
> when widening a packet pointer at loop entry?

[...]

> If the loop has a negative slope that moves the pointer backwards into the
> packet on subsequent iterations, is_pkt_ptr_branch_taken() in
> kernel/bpf/verifier.c will still fold pkt_end comparisons on the widened
> register using the stale negative range marker.
>
> In addition, when the backedge reaches the loop header, bpf_clamp_scev_regs()
> sets rcur->range to 0 via max(entry_reg->range, 0) while the widened header
> state still has rold->range < 0, causing regsafe() in kernel/bpf/states.c to
> reject state pruning at the loop header:

Not a bug.
The negative range is correct in the first iteration. The next iterations
come from the clamp with range 0. regsafe() doesn't prune 0 against -2,
so the verifier verifies the loop again with range 0 and takes both
branches of the compare.
The cost is one more pass over the loop. It's the same before this patch:
adjust_ptr_min_max_vals() clears a negative range in r6 -= 8.

>>  		err = bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
>>  					bounds.base, bounds.step);
>
> [Severity: Critical]
> Can preserving entry_reg->range across bpf_set_reg_range() here (and in
> bpf_widen_scev_regs()) allow out-of-bounds packet reads and writes past
> pkt_end when bounds.step tightens reg_umax(reg)?

[...]

> Here bounds.step becomes 8. Calling bpf_set_reg_range() -> reg_bounds_sync()
> -> __update_bounds_from_step() -> cnum64_intersect_linear() then rounds
> reg_umax(reg) down from 58 to 56 while reg->range remains 58 (and similarly
> rounds [0, 50] down to [0, 48] with range = 50 for a negative slope r6 -= 8).

yeah. It's an old bug, not from this patch.
bpf_widen_scev_regs() has it since commit 6ccf49f79327: it keeps the range
and lowers umax in the same way. The clamp is not necessary to hit it.

I have a fix ready and will send in follow up after this lands.
