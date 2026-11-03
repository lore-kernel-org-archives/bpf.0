Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728001;
	b=1tnWPxBBB0k0vQjwW71DcJ/dTvcLF8MP8maYu7SRtX3FdREy3Q93Ujxb6MTnAFRrSlFi
	 p7Uxqnwiga4C8SsRnQ34F9JehV4CmGMYAo0jrmgwRsqLL6RAO+mY2NPwQKGBJ96nIUF3n
	 zF0vKDtpGB/85FwH8ciSeAk54hdKcpM7w5i0u/afYyb0coQjrrbEOspCyTPCeaND5iYbK
	 0IdB4I06DdsNJABzPdsWKOPVD6WkjwP/ls66IKI/icZbXY0EcheWvlJ96Dlq8OADElsS8
	 ypNjmClYzW3t1UacvRwExJ8rfxpp1L+QHNvAUhLzz01vWaZdnGe+88RWuzyhbLDtbIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=8/lRFJSLlrplgIckySNMRrsk28zuenuv/AZIMYCznLk=;
	b=wk3MbTMoOI/Csh9+wzcKRsPetMenNxI6WcQYgoTxyF0g950+Xz0rG2xtQm5k1f0E7t5V
	 yPA3di0s1F2fKIvF94SzDLTe2254FiL2qAxwJa8Q0U3EWNZpzo7GGD56udDYkLP+kM0pi
	 nBZay03fOlI8B2XKdxURDgk9Z/9N/8AQAnYCBlKPP8io/KWnbKyfwfnVwCzIgfSrw57Gs
	 SNsh0U4vJsKB+Lq1c1InvCcCoy4oV1UQVl6Se9TMqco81F5jx4qjxVoGc2TONGgwBSdEn
	 TP95LSlHRNA5WVuH2eyoTRPTDb2E9dxDF/2BulkoxtLYlVkjIV4M1mituTLxvQ3blAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L2my9Aoa;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B3606A32D
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 17:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B5B3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L2my9Aoa
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1951755a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 09:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728000; x=1794332800; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8/lRFJSLlrplgIckySNMRrsk28zuenuv/AZIMYCznLk=;
        b=L2my9AoabqMhfaRotZnqlGF1eEVjoJvR0KQ0vlZkpLyX3HI3M3w4WGmgKmZWhJDO+f
         sEcs8kZSHhyWj+eBQvrwK2EmKXYSsxrxkk9n1osF0xJhz/mAaiNj8X5NnKew5WJHAzO5
         d+CVonYS9paMR5cqw4CvJN+Fv8sxw9XXmmjlq+jU+B/T1KThQJw6C/y/gQGh4Z1qxVE5
         4FS6/ekBg4iWZnr42tPp51vRD+pAAzpOQk+K3X9YjS0kRT3DR3Fbvb+d8IB/xBisDB8c
         qnhj0InXDbnDe5pQ2Q0CG+Sc/evGhhQ3JD7I65FMw+WBDg9WRAfXg7CRTi6/WoTYoYpx
         FPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728000; x=1794332800;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/lRFJSLlrplgIckySNMRrsk28zuenuv/AZIMYCznLk=;
        b=2Jcw1SNKXuOgovu6GFlgt4xPX7L6YsxpZPNK3bwu8D03Wt01w4g8CcLpnDF1OOM885
         o0mYdoMuLUS662mM9ndaCqjagLMMmsUXQ07ddyfFIGnMF/zoC6zsF4eWopsCvsslaKDu
         mDy5QP/iAOiRYAiot3ytmnStUAXHBQ+qTd0dn2vAnhUsiO5ccTjQInnoZIOqbh3A1KBv
         mfdtYss3iWEsWh1NmCc94g0d+E1JUd1L70Kiz3x8XQn9Hp9Ij2AGYTihdL984ushDUMJ
         SA25AI0+aobfWLkV9kbsHNeHhoNIoFdiTvSssM4j3Bz4oTI2yhaODenI6syLgk3k0Gnm
         uoYQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/zeXEKNukughtGmMicswdQee+aYOyT23/X6LLCSvzPJWmtCHiJvhMhlqWm3tWAh7s794=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GAw6/JyTKBUR4XaC+1Ml333FIm/ILF0bg+tQPHJGbwV16wicO
	VXkBbMTcrCeAPM0WiIb2kyQwaJX3OaiNkSYd3WRgJrc+SW1DpyQ57QqP
X-Gm-Gg: AYBFou0LyB2DTClggMJIi8N5P4YSBu0Fr8B+qUKYpD9iat9+zm7zxRcCEqxfeh1pS2l
	zCgTwroI/9rzXg2O3KiRRgo37wfpSnw06v/Of4uTomJWjO7fy1WJqTRPqYHtCu03Ktg4BmkJAnE
	4DB9JtKxhh1Feplu4MeuxZlMdXPPGUiwJoiwb2OPtb/xnoW3U1a0nO/EhtCT/HbXLpDh/ibyr/J
	qjMS2m5/DpCu58Uan8AJu0gNxsn4maZyMlrmPC0bUUJi9Bxxd/t51yTO7rmpDj1tduvBSh7el5+
	u7YuXkW9Hi1To42W/QgpTbAaU+Ecp8F4B0vn8zqjzRNSFOcfNdL3Lqibinz9w52LIFb+SjuPrG/
	zjKRl676NnYLV0G7Qqyj050C3W7OyCKCCJayeMqW+Cg8NoRhzAQWkq6T5QDmqJA7RejDMjbMH5j
	aVodhogl4pD9770WEYoWGu9hGlnjvh9HuOyrviPc89PsLwFuXdU8ZDlMextQzBTRNdfoS6RV1s5
	BJLtH9rYnqUKGpz90UHbmsA9OnjTXJ5zkpw3tF3otDbo7Vg4W7MbYhO5iUpExrag3I0u4F336TT
	gUzdhrbKCuxOpOKkiKQ0eAzmsPzeGCMC6H+TUWUEA0aO0S0LGXL4MWtl/BRLXXQxeh1qYEUEu+F
	ZEmJXEW5Lbjkp7u/zQBA2HYYH1b2pJS4Ghg==
X-Received: by 2002:a17:90b:3b4f:b0:3a8:6a04:80ef with SMTP id 98e67ed59e1d1-3ae8957a24dmr11468391a91.6.1793728000346;
        Tue, 03 Nov 2026 09:46:40 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5aa69fsm5407249a91.2.2026.11.03.09.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 09:46:39 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 17:46:38 +0000
Message-Id: <DMLRIAUOTJWR.28H0O8LS1RMMN@gmail.com>
Cc: <puranjay@kernel.org>, <memxor@gmail.com>, <xukuohai@huaweicloud.com>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 06/20] arm64, insn: Add the LDUR/STUR and
 TBZ/TBNZ encodings
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>
In-Reply-To: <20261103122733.1383002-7-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net> <20261103122733.1383002-7-daniel@iogearbox.net>
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

On Tue, Nov 03, 2026 at 04:27 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>  u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
>  				    enum aarch64_insn_register base,
>  				    enum aarch64_insn_register offset,
> +				    enum aarch64_insn_extend_type extend,
> +				    bool scaled,

since you're going with v3, pls remove 'bool'.
I really dislikes them.
aarch64_insn_gen_add_sub_extended_reg() takes 'int shift' after 'extend'.
Do the same here ?
