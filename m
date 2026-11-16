Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848665;
	b=GDpNloMOu9vGLVpA2uoTCdSMAEb3oGchBgJCJA8P/dQCbci+fpn8JvU9OLXG0hGlp0Yx
	 prWG0SAfNnZcy03ml++zzsRi26gx0FZtmJ+HB9xwG31URuY5zUZtJtqQ2Br3Qromqsk4F
	 jFKLzmyc2HKCnibfQLwAsjC/opCkig9gvlFWKjZJHJjeVs9YUdLhvPLkpf4RpnM6bh1KY
	 Nqtg8HgPMR7RPio0cBUfXHV1+6o7VaA8oPupFMeSBSN1REVDuW+F9koUct407V1qZQ3tv
	 oo8jg3FoOoHBFzMSCahs+4VyXp5Zc/d4w5JnWComfsTQaLfakdRmeTLGCeV4iIk6Qhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=L1hT+97K/K9N6aADAlPB66PeMF4gDFwltjwUCDDeJPw=;
	b=Oc8mkbSDi+cGPhl5crqMSW987caLTzOAMqokPw53457OTH0DRFODBvzJ0O8MAMTrFJkZ
	 YYWSUPPu7X/8AK4AcL2PPZX5bGMGxL0Hl5bLANiITENjyTDcB6yhrVL18DASvV2u2sC+U
	 n3elRsRQpSO+RYFKXcK5cIizJPHT++eoQt25YVecwvN/UL+vtS1ML21kKx+EgAuNlbpqF
	 Qwsi4dkH6yGYmncNERcKGiCth+PqMSNRXSvB0bhzaPFmU5dZXIyC47CtWREbYrynq1VgU
	 OCu9QgcZ6WjNJ3T5uLaNBXxUHJNxz8PhuKdwc7OGSYBsq/ixU57Kp3xyxwyo7l9Ddsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Xh8yP6lX;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40675606A881
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 17:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40675606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Xh8yP6lX
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4395d31228so596893366b.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 09:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794848664; x=1795453464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L1hT+97K/K9N6aADAlPB66PeMF4gDFwltjwUCDDeJPw=;
        b=Xh8yP6lX+BPj20RAK/eBul9EDB6/2oy1PyKatTxPRBo9kRtGfKIX2qjIxa5c8xSAZy
         8cEXNuSoibZZB/pbA31WLxk6XqNRGu5xm+gvWnDlKkmyZz0+6OvHbG6LXkZZqrMuxvh2
         usERjfPixx2vu8U3q8mY9/qGZD7NeBfUNaOqJAFlaM3dpO4QQQYia/XuN0ACeLlmlwAU
         1tKTqFwdb4kjXTsnEn9GqPMz04guC/uUXwdSPbhUZSRcVcajS5e6Q3Y4qNlB3nTF0rPq
         Fuz1O34kiQQp9maVl1+HigJ5WTz05GQ1FL5rUN/Bjj7acV6rH+/NERK/gxzf/J+DSxlG
         +2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794848664; x=1795453464;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1hT+97K/K9N6aADAlPB66PeMF4gDFwltjwUCDDeJPw=;
        b=AxEXqlJEheveYvwbGjGqqZzMMT2upu5mB6NslC2bVaAHlPjWX8HK5x6QCgrWGWlB/Q
         B+HFwlMOWBvVxXRkC9JwsBhno4qzcw+fet72J/YMrbPGHTmeV94uXSzp6dSZDvgFrrRY
         1ZR08Bgmscf/1MEcwQzFtt1itGpZerFe1iInmPV3JCbcZ5F6KD6PR8+YBmcL50n3k/el
         /FgBZh6bEC8HdOvDzF7lpB5QmFUB7ACovCSwa2Ih2FGi57vKVnXgcsAQG7wcFtF7GUWd
         bYCKdX2CztQrnC5uCEVNXXHTFxMkIFIaZz8k8DvuxvyozlK+9vMmtL4NaEm1kyshU0xs
         I7MQ==
X-Forwarded-Encrypted: i=1; AL+hErHv+EL+Ngjr9VIg55eP89TwDVotsAh+jXSZ0M/2FXbhQIo4bVctGE9vVtmpMPUjqQlASLI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+inLUDl5WukdVuFnafEtqWw9hoPr97ft0+BgyN6F13dR6w9moW
	Vhuke8nuMAmvP94FA70LZOBfWqU7Pg+FWAZjxVv4xrbsc+Xdv9QSC/K87VTgO4mTsgc=
X-Gm-Gg: AYBFou0HlfAL4RxhCNKft2/skTPcW4xHua3EbR4wjuj29Zf4nGkr0olQ6zf5RQwqg4t
	Qjj3WXVyFstjSqpaG9G1QkQSzldAxm2Flx9L5CnAkXNKIPN1aVEpawwS6rC+PLJsjJGJ1fhfXc1
	SquVuRgE7cyD328jYSaNICykfwaa12KLTlsXsqc0+k/9OtvjEK+2MmNcG8QfUkW6AK0/u8UzGHF
	a2sW0lW/OZb5+x04YfxAQHsrLU4A9r+5uefrEgE4bopk9rBekB2Z+dT9e5u+xs2ni8utQsnaGXU
	/BLD3pOQnSW3aMJNdGAvMwc2LVIbgmEKC2IMPX3EQJB/I9GA34aJENE+KcOCBpy0v1iyGt5sIep
	e8dE/O/pY3uF3nRoW7hLPYG8oVmD9WeM1/BDWRtDubeIu3cfF9X27N2Vbg9M7HKeTRrT2KqW3Ea
	o6ORtF7q5J3bjrDMTJ9+65Kajjkh5F44nj4AlMCkWHaaQ/uBL1xpDJAPl1cbZA+9l8ZgwwrcADp
	YHTH8Uab0SDPyQV6leolpyYdlooQB0LKcZidehun1fMqKQlNSymp4mE7cEfrXbwra+jeFo5y1Bu
	EQpP/iDerYJlNQz8n2JDFNUnMF1yCU0sf37ZNfDb++Btgfw=
X-Received: by 2002:a17:907:6d11:b0:c26:2a2:b91d with SMTP id a640c23a62f3a-c509612a23fmr1038875566b.6.1794848663649;
        Mon, 16 Nov 2026 09:04:23 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b44739sm439299566b.40.2026.11.16.09.04.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 09:04:22 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	yoong.siang.song@intel.com,
	kerneljasonxing@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net] xsk: reject TX checksum requests that overflow skb->csum_start
Date: Mon, 16 Nov 2026 17:03:41 +0000
Message-ID: <20261116170341.53580-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179484673444.3291.12899618485319674206@kernel.org>
References: <20261116162834.30087-1-tianyi@cloudflare.com> <179484673444.3291.12899618485319674206@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi,

On Mon, Nov 16, 2026 at 04:32:14PM +0000, netdev-bot+sinfo@kernel.org wrote:
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.

Sashiko reported this several times, and I reproduced it on a 64K-page
arm64 kernel built from net at aa40afa831eb, under QEMU.

The test sends one TX descriptor from an AF_XDP socket in copy mode on a
veth device, with XDP_UMEM_TX_SW_CSUM, a 64K chunk, a length of 65520,
csum_start 65500 and csum_offset 6. The headroom is 64, so
skb->csum_start wraps to 28:

  skb len=65520 data_len=0 headroom=64 headlen=65520 tailroom=65168
  csum(0x6001c start=28 offset=6 ip_summed=3 complete_sw=0 valid=0 level=0)
  ...
  offset (-36) >= skb_headlen() (65520)
  WARNING: net/core/dev.c:3696 at skb_checksum_help+0x1d0/0x238, CPU#0: xsk_csum_overfl/200
  ...
  Call trace:
   skb_checksum_help+0x1d0/0x238 (P)
   __xsk_generic_xmit+0xb90/0xdf0
   xsk_sendmsg+0xcc/0x188
   __sys_sendto+0x128/0x1c0
   __arm64_sys_sendto+0x2c/0x48
   invoke_syscall.constprop.0+0x60/0x108
   do_el0_svc+0x48/0xd8
   el0_svc+0x40/0x238
   el0t_64_sync_handler+0xa0/0xe8
   el0t_64_sync+0x198/0x1a0

With this patch, sendmsg() returns -EINVAL and there is no warning.

Cheers,
Tianyi
