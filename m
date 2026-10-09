Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F6389458
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563297; cv=pass; b=Xu4uEHLKg1zW0UID1Tzs0F5K/nWlTVdaoSZmB0KskHzW7nS7sVexsk3Qks5pi4yLg0VqPJh/IrbMUzSGy/KRoYn2umQwL3x2BkaLlWlnuPs44YfvSH9ZTRCs+UpFDrNl0+AMc8JFXWorgJZzfPIf/USElCvX+Y2MKlA3xA88YlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563297; c=relaxed/simple;
	bh=aEEZOJq1YQBCl+EBhhXBbW8ir1k7qWPCFd9LKrrdcJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ReK3tlhqE8LEkyw4Q5YPmIbM8mua6LuvfnzIsfaqx92BVtBeq5jEYO0AJ5T6rhVdaebXGFXLBPMKb2R6ApwKzsdnMNALOX2HmUb0ZUNB9X8GsYsXa6Hc9wKEsCe08X6AfukJ5nQ/0geT9b5RxhGvobLv8YL2J8sv22BjdnwcLmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Utp7NN0a; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Utp7NN0a"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-151de818519so1618c88.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 09:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791563296; cv=none;
        d=google.com; s=arc-20260327;
        b=YuI2Rd0jjvOBxdFdWbSkWB6kZeANyh2EXeUEPiWMKHeyZLqPTsj+YNetCfhXMe3s0s
         VqQJp9dlitS+QxnlSgmo+v7prynMQX6hljlnrrQWnHNDeDgUScZUqyd5X3EocVya0vnI
         VSYPJGGaK5EmIKA2a4OdOkyUqEAwnHih264SSV54+HTFeljK32cL5/AjI4oB/bj8s5ow
         mqlSkHgR2AkiRdR6oZ+14BW4slEOPdSehF/hUJVpNpQ5qEMJYCd/YUzx3m7pL18N2drU
         2qHgxTmpi/vWvss9AdSK6vmZDdTQHPs5idR5tr2es9Tw7dlY/lslzepoKDvmapEus+rs
         uWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gEeyzzUSwXoU/QlTHcalzbT11R3NUJQd27RQiZ05uEw=;
        fh=/W+Eyd0usQM0AFYjzFHnbHZMps8ujiFA7VDtvpfunGs=;
        b=JMvDjSWv/q2uNIavpMPKgCSBLj4pb08ImHFdZ05rUPCSwCZOEBzJBh3sTD8Jcz5BFX
         /dDFjxGPcWBr5jJdD69Zo695rQ8ggXxSdQJkZnQJp9cpV4na3lEM0QoP4buEWRPXCj72
         u+GmttjjEO5LA9tUDtOd8VSkeDfOknqvSEIhQjHIf/nd+Mm+UmeJlL39HnY0Fiu5ShJl
         0zE16oFBpIw0kWx1bZuBh8jCa6Hjo+yFEoGOgBhXKWc/I0hrrcv1OyIsDY6ybTAZXabO
         GeiNEgAcD0LBOfIL8qWAR0a5XS5imrEbrRl0/+8MysGIY/hqasUwYrLIk6u+CmX4sOjc
         6gNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791563296; x=1792168096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gEeyzzUSwXoU/QlTHcalzbT11R3NUJQd27RQiZ05uEw=;
        b=Utp7NN0ae3nBHl5dPegpeqPeXqV0ulz05k4PKQtpGHWZ7oKvpRXJyJhKkXAnLMyFr9
         D/ImR+s506O2SNOevXfe2NC5tjQoXsnxDveIjCB1Fd0xzSDftTwp34gUkh2Q9/ZzYxrN
         KBMTyM1a2fWLybA9Wye3D3tGZPZDnGvu0xTmZvLh2scvju2cWxpOY1dm4kZYGPHOhC5n
         +tM6mQ9QH22y41vJdCCllwpCrk18MF1eRrczA4gEjP6CnpfNfmsFKOovNq/7IYHX7mDM
         k0FVikWGGe4OaWUdc4IkSO/GFXKEhe7l3FTC7o75iGAYbdSFGfK1hzypA6h1/rg2/wyf
         rsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791563296; x=1792168096;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gEeyzzUSwXoU/QlTHcalzbT11R3NUJQd27RQiZ05uEw=;
        b=LsYL6eUZB6DVPCaXQ31Ys5BF91+VzbgCcbDQawNge23DZnLLqLWmn1AnqGdqzPYwZt
         DG+we6H/x7udBBjtvOZcy9ZdCsh4k+2AMfczJcELGKjeIb48Bdkkq9/xWsd1W1RKRr3m
         HwEMc2Y7/dkh/t96Evw9BXsHgqy6xMj9CqezG+k6Ie6ONJOShK+NcWrFTYr5R6w/W52I
         6cAXsWMfif4WBmHCYhvTdT3zSZVrPeOpjEF+bucsw5KDoA1eor2WwYk7EOYXwfB76T1C
         5pkKrvrSRGArb1kxS+iT3MpsQUhkxDgOKio5ZVyW2YbbIXNC8Ux4FCK9czj60He4e4B7
         7jWQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5C4YxgigEGizfIwu9UyHKZclSjsANDFq4jxkLsb6ATdUhDO8jF8GWvkWixfStQbv6CIc=@vger.kernel.org
X-Gm-Message-State: AFuF++kj2e8eI5h1ZLbC6Ph3MDj75BMYgDpcwKFi/DNq3gJu2donQC1k
	wFBfTZYkCOffqvlxH7hWkQHSWAsur+ss/mh7m65xv/DvHcPkPEncpWih+lXuUSanfPWy8v0U2p0
	h1+IjyhpdN2S3+G7JzOiWsGH/5fq/qYOb0BnoE421
X-Gm-Gg: AYBFou26U7v5UXxljwET/ZgzITqAX9kiy+/HZ0L+BBiqrurIVuneWlhekOredCDPSI/
	5aUa25uxM+Az6UK7vlvMM8bhaAQTGAAB2L+AUqIPjK4zvSOVcKm7+Ux5i6WwsWzwcosRuObTYlj
	nueJIoe8ocG5gVoiEwOWlHDdG9/JzHi0Ffv/YDULt8c84wtQmQOlQ5Kt9QxJf9YUdD2l9aRUTR0
	iGN0vD8sGog0dK+/rcwg1a227gHWfcfRvJETnXp2FHNUmZTndzPPb8PbhRvD/wh4A48sGrfdK8n
	F8x/hvx5be1xZXeUvZavSJZJcUqjn3IF249yky+W4GB/RRpw+0JjstuByoHs0gd79g==
X-Received: by 2002:a05:7022:1506:b0:12b:ff98:1ed9 with SMTP id
 a92af1059eb24-16a4d57c474mr309609c88.12.1791563255822; Fri, 09 Oct 2026
 09:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com> <20261006-b4-skbuff-bug-on-v1-5-1b4434c5357c@toxicpanda.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-5-1b4434c5357c@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 Oct 2026 09:27:14 -0700
X-Gm-Features: AclHuK81ahTE51wC2Bp7FXQn_Jc8YWHqO5IFJUkY7wkhMiw-xblsjCBwxgAMBh4
Message-ID: <CAHS8izPj0JCi=-tjNBTYH3=-ak_VLCeKeWxTrwAt7vs8LDgn5Q@mail.gmail.com>
Subject: Re: [PATCH net-next 5/9] net: skbuff: don't BUG() on leftover length
 in skb_checksum() and friends
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 10:10=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> skb_checksum(), skb_crc32c() and __skb_to_sgvec() walk the head, frags
> and frag_list and BUG() if they run out of skb before they run out of
> @len.  By then nothing has been read past the end of the skb.  The walk
> stopped at the end of the data, and the check only tells us the caller
> asked for a range the skb doesn't have.  commit 06a0afcfe2f5 ("xfrm: do
> pskb_pull properly in __xfrm_transport_prep") fixed one such caller that
> crashed in __skb_to_sgvec().
>
> Warn once and return what each function already returns when it can't
> do the work:
>
>  - __skb_to_sgvec() returns -EINVAL.  Every skb_to_sgvec() caller has
>    checked for a negative return since it learned to return -EMSGSIZE.
>  - skb_checksum() and skb_crc32c() return 0, as they already do for
>    unreadable frags.  The resulting checksum is wrong, so the packet
>    fails verification on receive or goes out with a bad checksum on
>    transmit, rather than taking the machine down.
>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
