Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024843;
	b=SOh58VuALEKboZ12zWDGwjuAUt6EDYNAwEA8UWzEbM2vugWgqDdZI0+Ox8YeCDNGqhBb
	 QvQPgiv2/VEF1AvLIM7+kcu0V0tGzoVdzu3Q4h7HOAP7L4hrP+FfqQASLVkaNE8V6vTs8
	 7y2G6ZU8MlFbBB4Rn1rJy4Su9zq3Z93Szdivxb77Ga1RL8waPBw7OA+xDXqvnqXNL7sJT
	 5GUwRPIfGRIRZV0OqUuHUqTTHeYhjoU5jNv/aZDh4HAUdlf4i8wnkg6+LA7wvAwLF7u8s
	 hcK/vb41IQqLsWIme6xME5VLlVBRvzJNcyeibQVFnx1S0es7iArF7zDSzarZ9j+KHpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pWNIDudccydM955IzkAINXE2ZjY/ipVqw0niCy80XBs=;
	b=OUlzpWCi/LAxBDQ0IVF7qqFCfnElJGHOR8/WYIG6lFB0sYTpYk18TjuRzQUS2FY52Ei0
	 holYuy2Un6UJqNWY3OJncvrfQITd1KKlyOu2NL5S1Mu4DJvghn9lnQtRyEnZG5ddOD8Ru
	 k/yzvAzAIOYTZyqueSFq11Plva4TzZB66erVDJw/idaUJXSZMBIijZZH+Up1OnP+B8dwh
	 ABiOOTox3Na98mEmrjyUgtHaJvqTqg/pHEnqG2ZwWpfGxuKT4XBMgaz2st/ophGHoW/Dz
	 P6gINFQJJU452A2EsJYYVpwiiOfAVZojRP0hy9sAA4V8qBYn6o9w3tNzWeRaPPT3P9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XhlxvgU1;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08C6606A31E
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 14:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D08C6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XhlxvgU1
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2df921c1d0eso13749765ad.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793024842; x=1793629642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pWNIDudccydM955IzkAINXE2ZjY/ipVqw0niCy80XBs=;
        b=XhlxvgU1GrMaPNJspEjfRmGarJy5LJYRRhTg1Hq/82/Zw43IZLmp1XR/SVpCsCs05U
         BoGs9OSrt8nbSJESb3b6dLlIhykpaBy28HH8+8wK9xG+vb2OSN/fiGslwFxR/GKZEZ8z
         m19YStf2V0YttCwB+h1Ew2WhtANJutgxfoX0HLvXOn6juDf2bZROzyGtjQ4vvRzF+7XO
         pm4XP+AZgP36L+2ig5rDwJ0P1QJdE8Q0aVP36TEb1uirPl3ZKJ1WrDZOhzgckhWRNmIn
         GkkvbnCuyiz50A6qCwqJCiz9XxLWrqnGx7fqHQfrfdSw5/PXSL0VMpNbQxZQedFvav1G
         +gzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024842; x=1793629642;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pWNIDudccydM955IzkAINXE2ZjY/ipVqw0niCy80XBs=;
        b=H2NpnGfgkN2tTMQ1EgVO0NIVHs4+cEEasfif3EDhbaiAE5svZRWoNYSVBxLtgr6gwk
         sabdvD+H5aVggFEuLHhnRNOkvz349crnPg6Sg6edmtRB2fyB8K/lLldl4EuNpxMIP9kJ
         8cTtZdTon6Y+XDPbz+fH9xEINMz86h13w/pjifkQPnDFICRijrYlV0e+C/Far4JpfssR
         3ihYuPGzfcAF27edvbJeyOOfAmaoZkA/pMNgxBKRnUqcqDfQCbi5xM2rRak6XLSZmhuA
         QOjwsLsSzlgPBz4Q/m+UKYSBDttsipDlDkc6KF82Sk4UwUP6AkkfITO52CPdjTNUsmt/
         UFoA==
X-Forwarded-Encrypted: i=1; AKwUvByeuFjRgyYWeCEDl1Gmsn8Qu0VahGnHQeBlxCh+b4BtwvBQE5e3ECvJo4JSO+Rj8yz6Xgo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK86DxCdvqgRTvWas1X2sDVaG3KNCLlV4vQ46AjtRGoD0YJMWHV
	oVNdO4qXtFau6sQnv81z3kaxSwVk1bXrxDN14+2IGjG14/DPfP58q5bP
X-Gm-Gg: AYBFou1/7ZA1YEF7ro5AgeQKNBhVGePpuFA9O0c0uLZKjCFWs1YpsWn2KGWir8aJvqh
	9xg/Dho68QNMLotAygwxde4nWXS2b3zC4JqeDkICpfvPYWGqyk/BRbmR+JONmOkABpfqXx+226u
	54+sGBAzCQvhc89GsLcMazRJgqGErxWUyxz+xz0SaCml8M/DNJiqzK+Qo8xzJWtErTgeydoG9Mp
	0KvssaC7ZYb88dXNKqEse4F8G+ytCPP39j25ZJlrCEUDDIW1WuagylAXkyyiPfzD52TwP7vVABT
	OQOxeSacvJxWp2YrULEZZ6G5DHzvo9Ifj3TK25T7KqrMxDEhPrgbsCrIQVUA/dlRMiqMmsODj2V
	o2H5c/64bM6Dv1BxnXkplJYp6ob7mIRa0Eh9E6iAgGdfjV3PsQKd/OEHyrWTx3IERo3il2yM22e
	mqZQXxqRvh4WoGXIyujI3D2i7G14FWpzUnIj0J9140UwnJZaAAsoJ+4e5/8A9z3x9CbYfZpt+0K
	ZoSQeACoQFSV32OOgkYYnR3CqDUtZV7AaOUve38uNyBRuz4pQvFOItaTg8PMP8lqzrGQST+0muB
	WVeokJH1tl0C1lqH
X-Received: by 2002:a17:902:f68d:b0:2e9:a090:dd80 with SMTP id d9443c01a7336-2ea9c69710dmr55298395ad.22.1793024842080;
        Mon, 26 Oct 2026 07:27:22 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2300:286:8580:7ae4:15b1:705])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b121725sm17638495ad.14.2026.10.26.07.27.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 07:27:20 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
Date: Mon, 26 Oct 2026 22:27:05 +0800
Message-Id: <20261026142705.4564-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <at82NLzM7g8HGgum@boxer>
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com> <20261024141157.59301-2-testwrzwrz@gmail.com> <at82NLzM7g8HGgum@boxer>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Maciej,

Thanks for the review.

Yes. xsk_skb_metadata() is only called for the first descriptor when
skb is NULL; continuation fragments do not call it. So
skb->ip_summed == CHECKSUM_PARTIAL means the first fragment requested
the checksum.

I'll preserve unlikely() around pool->tx_sw_csum like this:

    static int xsk_skb_sw_csum(struct sk_buff *skb,
                               struct xsk_buff_pool *pool)
    {
            if (unlikely(pool->tx_sw_csum &&
                         skb->ip_summed == CHECKSUM_PARTIAL))
                    return skb_checksum_help(skb);

            return 0;
    }

For the drop path: xsk_drop_skb() increments tx_invalid_descs and
consumes the skb; sendto() returns the error from skb_checksum_help().
Since the descriptors are already consumed, retrying is not useful. The
current metadata validation makes the malformed-packet path effectively
unreachable, so this is a defensive drop.

I verified the propagation in a local QEMU test kernel. For the test
only, I temporarily changed xsk_skb_sw_csum() to:

    static int xsk_skb_sw_csum(struct sk_buff *skb,
                               struct xsk_buff_pool *pool)
    {
            if (unlikely(pool->tx_sw_csum &&
                         skb->ip_summed == CHECKSUM_PARTIAL))
                    return -EINVAL;

            return 0;
    }

and ran test_xdp_metadata. It failed at the first generate_packet()
sendto:

    generate_packet:FAIL:sendto unexpected sendto: actual -1 < expected 0
    Summary: 0/0 PASSED, 0 SKIPPED, 1/0 FAILED
    TEST_RC=1

The normal kernel still passes. The test harness does not print errno,
so I can only state that sendto() returned -1; the injected error was
-EINVAL. I restored the source after the test.

Magnus suggested a distinct counter for malformed packets. I agree that
would be more precise than tx_invalid_descs, but I'd prefer to do that
in a separate patch instead of extending the UAPI in this stable fix.

I'll address the remaining feedback and send v3 as a new thread.

Thanks,
Rongzheng
