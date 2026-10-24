Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792841735;
	b=t+OCOjy/+a6m3wyhRIPgRBxw9P66Rkc2kZyQD7dr0ilgcY6zzvRDe54cfxYbKax4AwKt
	 HpWO7yrxEGUDK3C+3SXcXZIwV50yht1TruL5n0lA2hR3UFtzHbwoXcf++lxF4c7O2n3TW
	 0AL5jyuwHbdKinyQDdIrh5GxW4Z7yySlazgL7et2NDCRevT3ovbTvw95I7zeIs88f9fhk
	 nJdG1fpr3gNsxuGhxTGmCzWOd7CVgESaWLXI4Oq1pMx6d27AwHM65M0zcgsXKpEOzYzME
	 xjDL50i8zg31EpNqfomMKdKBiZcd9y1/lFPCc6YCkl+Y1e/EP96hnfZFUUksfsRhjog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4Sv2Ckx2zgnf0FNK273cchWmqdaiROeR0BuSXmJ+PR0=;
	b=FToPLQ0pxBTi6/lkEhjyTtsIr5nRa60lnbzZ74hmEXVkhM+X53ab/2c7uSmSEHb1Xb2Q
	 brW9lfy5arymmr1pql0sqj/LrHDm9GOhD25lSVgzrUlahTXKNJFaXP+T0KMW5I/u7XBXB
	 t9L0zLRJj/2TI7LxEFdIjz+WyZEsAmOU5aUlzc6iixYDFHKW6OkE7BeVHb6gy1qn4mEhy
	 xHXUKvDMYD4oaj0GEwAkCDR+In86telAgNSVrsQXC+NBXkT/xCCrEC0/fzRM5niC6IxNf
	 FGIXaP/mNKThAtK44/LbpFbE7hcRviPIo7kE1WuyWEkloQkD/5qj4Wzir/QfptI4HIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UDpQHhjO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.0
Received: from mail-dy2-f0.google.com (mail-dy2-f0.google.com [74.125.229.0])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70465606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 11:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70465606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UDpQHhjO
Received: by mail-dy2-f0.google.com with SMTP id 5a478bee46e88-3117f9b9e64so151206eec.0
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 04:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792841734; cv=none;
        d=google.com; s=arc-20260327;
        b=WbWzcfSp5Ej+UwWTGaW6N6C2qBErj09vt5B5Ndt7VHD3kaeGmQBNqz1waPPNUn7ilf
         /imtslITsiSa0l3/LcDoDsxilOF11dkCw8M8q19vAMyR2obJ814t2LsZdMYwpeBLx3Ew
         SpWHOamxiAbDSNtmuMTPauj8f38tZ198Nig0L0ZDTxl7wGQaLHJFmAt+NjJCmd8nrsG0
         /z2/Icm3RA4ZKFnp30fRfT36DjWD6/FxQapgrTKOMI1jCNQu+/a63BiHR75BWirP/o1P
         OoUza6BXlYsMfmmLUG8TFoNL2ObE+4GjE/YnaD3KQT3b4YgDerTtS1F/pyKAREAj8y5X
         0iWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Sv2Ckx2zgnf0FNK273cchWmqdaiROeR0BuSXmJ+PR0=;
        fh=WhoaZYtQ1eexBRZm5d4AyoXA8C0K2J2aIK3WLiJh70U=;
        b=Mppct6oQzmrA9BAFKymteP+7sIPyaKiNGDkYmyIZGZGKdTFFUSlxb5mJ8KE1Afb/J2
         8JqlSaNQBedzMgBmTQ2YgWIm45/pZMB37wMdIpQOcW8sZ2f6bk9UuLnF7mnWQtH9oyRQ
         X908iIhvd//RttVy90tZ8xzIlJotLbdwkMt5YPtb3IxCe7MchxPjUsyLoR3VrgadJGcB
         nPCimRE2ijiPCDMyIlem+I/pqdCb7rUGtwbuFURseGxEXRzE2Ruu3CnKQcXxYzHJuGxK
         ROi6VdAldyzzLGgO3gcOF9M0ElP53Mgzac0uUiQ8P1tb45XNrGOOu1z3SVRsQIFMkTFE
         5PrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792841734; x=1793446534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Sv2Ckx2zgnf0FNK273cchWmqdaiROeR0BuSXmJ+PR0=;
        b=UDpQHhjOOpLeAQ+UqfGehYdrCjlB46HMjQ/EW8qK/18tiEejR8MvCMHJZhZB+Dbz/R
         dlwWzTaBw3JbXtV9nAmMH4d5UVrTFgJjvvWCWj7LbKp1N3xectQvJaecfiHJLA21W20l
         7w/xMA/SQT8Gal2+9D+D+DseL0QDgJV7lt7CumiG/qpIqXC+iBRyhwCNtB6BUNvK1sr1
         LwwNEEA6NFQCQ3XVX3bwmopi/vLJ5SGeDu29X3N1Voy4LUcY5wdbaHfgJLuT/xnLpz5U
         ShjTjQbba90lUXadzxqleOieNVGfH3S0VWRDy20FCfKTz+Q2OA2QKNQEDOiXChyGYpRM
         uOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792841734; x=1793446534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Sv2Ckx2zgnf0FNK273cchWmqdaiROeR0BuSXmJ+PR0=;
        b=MQ7HTDtsj0T2rEdSaXgXEq/K2a5/Sk4qZ46aqSNReKT/BV+xA376Ambi/saJmu1JLn
         lk+Jf09Pm66xwcL0IJTzgmXqaMzdzKANfZbOUt0hlqeXu/+9B4Ai3s2yY4+5V0EgJzcE
         CJKoB+BaAh9ycPQ9NnhuQGoxwwjiy08kWUC3xYESJysFaVZC267QkPooQKCzN5ZZsbjY
         gToT3ABOQmCwHLMG5OFj9o1ycIJVu/rqrnCtemxq9I7TNZ7knJztXvMNsOSVyY2FA0FX
         yAPGcaD5j8e80LiQll8eGbCIaLKK8otrX+L0u7IRD9TonW682gN/e4eFuV1TAtSRpSxG
         i3Xw==
X-Forwarded-Encrypted: i=1; AKwUvBwBXexA+JN1DE1YyhpzmNjLhlCUmxJT98pN6pmv2Frt9bP9pgAOKU8QDWAWKfrwK47tNLc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKs+yj7DdgkK4/Lk/QD6+tWYvlyPEbL+weqIXN1lBsexEn79jbx
	Q/8E1c/RdTf5+QbEpHQsWdqHC4RkZ3M9jNZtsXrGTqB1jER+uaIRAKDV4VgBW4PD2x/mXGqhd9B
	Lyj2hbuhFIHcx2EkMTwTqFnZUn1mIQyzph65m5t/AcAEV
X-Gm-Gg: AYBFou2VbtrDAVPkLJmcUhs2SnvRi2auHB54xQoF1G6qNlmoN3eSPrHQgxp60bMZzoe
	5aowNyn8LMLvfSmakG89sMckrG86BXJVtcfxDW6HzsKj7IvQ0Cy6I2/i1Bm/+q/bxo6QseBttX/
	EiGDWMAnMbDj46rH5tEPw1tMI30HcMhOSdRzAdOZ7fhhiSKTt9dONXbbLlYOGNo1RA4Ww9OLcgh
	NrWsVofdfb1O00nLnhgH9dP2CsIiUjwqRtNYxM8H7l0Li4mAFo/6+CfHkOTmNUCsSiewHbDEHBw
	R34XxO7I5ghAaxvkL1poW7NaQ+kSgIajIoUCoN6FjLHyvljD7C7otSRg2BX4d+FXwI1DikLQHxy
	US/thLWDq1LVKVtg5WvQKHb9jP9k97Vl+tgs=
X-Received: by 2002:a05:7023:906:b0:192:a481:361 with SMTP id
 a92af1059eb24-1994d8b9822mr2570217c88.7.1792841734448; Sat, 24 Oct 2026
 04:35:34 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <179283334099.3327.11706883238489839470@kernel.org>
In-Reply-To: <179283334099.3327.11706883238489839470@kernel.org>
From: =?UTF-8?B?546L6I2j5bOl?= <testwrzwrz@gmail.com>
Date: Sat, 24 Oct 2026 19:35:22 +0800
X-Gm-Features: AclHuK9pxstbMYf0EyqcMH-TBmz-g6K5xQuClbbepH1SlLVllcKyJtSHElNXP04
Message-ID: <CAKg18mkvJVPgYTr8ie2K6_q+rBAHfvCnxgbb9i+3Wh_v-cBXow@mail.gmail.com>
Subject: Re: [PATCH net] xsk: defer software checksum until the skb is complete
To: netdev-bot+sinfo@kernel.org
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I found this while studying the AF_XDP kernel implementation and running my
own multi-buffer TX tests. When I enabled XDP_UMEM_TX_SW_CSUM and sent a UD=
P
packet as two descriptors, the checksum on the wire did not match the
expected value; the same packet as a single descriptor was correct. I then
traced it to xsk_skb_metadata() calling skb_checksum_help() before the
remaining fragments were added.

This was not a production or syzbot report. I reproduced it with a standalo=
ne
AF_XDP TAP test and extended the kernel selftest: the unpatched kernel give=
s
actual 8817 vs expected 52507, while the patched kernel gives the same
correct checksum for both single- and multi-buffer TX.

Thanks,
Rongzheng


<netdev-bot+sinfo@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8824=E6=97=A5=
=E5=91=A8=E5=85=AD 17:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
