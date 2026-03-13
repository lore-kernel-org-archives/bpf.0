Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665EB395279
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411630; cv=pass; b=uVGC+4AMV2myv15NVAegev+byc18CzagN/amMzWk49H0AepXHrzHJXaT/wK3SVTYiUzVKCzwkhyuYYFMCN/W4RbMa6E/fZFqFyUWy3sdYBVGVEXjvobaSsLlokfPR96bWs+A9qA+gs6dHMjk76C9ywHCDAQ/e4CbvbCnWIOWJ1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411630; c=relaxed/simple;
	bh=ckmpy3mw1UK9sEOGwbASSY5L7qTviwDScKOnF+2PxxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmwsUi6+68xyq6AMFdZXq0YhuT3UgjA7ZFLUC1a1yBq6Mke9D2J229C0LGUzvnJDVdOZEYF/j0dUCijJ6IfypaLRZ4D/aEZxWQgLsBUr7E0QIwYQZ3B08ohHCVsWYJWhLY4nAiwoCk5TxMPJ6YCjI+FFsJnqFEsooWPePbTD/ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ0oQ3BB; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ0oQ3BB"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so300109866b.2
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 07:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773411628; cv=none;
        d=google.com; s=arc-20240605;
        b=gnb1vF3qTVUJQa3Zx6sqOUeh3TT7UGgkQNsq3vpsup126G1BxDcmTCe64MRCw072cG
         1cGBjSYCmvYKmEglPNnxotuuMz+pfe8o/IwOKKdJB94pxRVkJWr70Fn+EylfxoJE8lgj
         Lrp2ZOHG8UqwAJtpXtIGNHvyIfp+/nTiWO2n0837xLinRl5JX6lwYtwjovMNymtFhSlS
         dMuI4PpxzXg6HT3YcOpDbZyicYLMGYU5iRk+2JYU52iaVyXqY9Do4k+ma3Txh7+XxvVf
         Nu/nLV+92udM9aP2wJUezDVVGNabtqnicaEbXHHAD+cC+uKz1oP+42LrxMicX5yVwbRs
         IcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ckmpy3mw1UK9sEOGwbASSY5L7qTviwDScKOnF+2PxxU=;
        fh=ZYfgn00HtOgaMN2yfd5O4cx5jR/w2Hofi170fnkmdmk=;
        b=VCifTkuSfA1imdApZUQ9LpaSV0ecdrSmmcY0oC6Jq7Dd6lEZzv234sZ3uG0kcAiJo5
         iCzZUi8l8TB3x9F4bd9SuCD51TnW2cpUigwXMbL+OY22UyyDpSqDJ2IppbO8IQpw1ib5
         YwdvIn4pMq7jGbaRVAIivf5wQWcFOxxCshskbLCN3sGUCYx+rJouzuvJNpaTiwnX60mo
         sVTAlzHlVxNaG2i4MBm0IKTq9Z3c0XJSg8jKBw3Vgq2leQskm2L6kQurkiIdoCYf8HPD
         piCvY3qx3x0zuUGMBS/WIIF0GYNyX50hjoSxFQvIlLh4U8d/13RGm3QeKkQx3y+wSloT
         2LSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773411628; x=1774016428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ckmpy3mw1UK9sEOGwbASSY5L7qTviwDScKOnF+2PxxU=;
        b=VQ0oQ3BBX+NKPpXwhfJnE3bQFV6OpDwvP2Cn7jW6Nbj9DG8VUQxOZLuBQGDzeT6paN
         XdKzdeuUcUZ7G6AUIAmDojIeiiqwIFxPiMyjRIlSI5v4DknxTrc15GtOUH3JN7tXIlxM
         W8FgZ+SWEcGA1IaeajJ8kyKXj5GzUSLh6/pKv9MMPCAZab2VDlZlRqewQmWoaJOSQwZ6
         BVdupAtMGI6fUidSrL6M5+qBi1FwE29ALLQgW5gP/qZQz/2KeiIEN+mOnK45t3rttCxR
         8hQoNlAuQ5Cch9oZed9YePQhEivZBlUoWoS/O/mLsBC0jBvvSHcWUowcabrlTJagi2tF
         at8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411628; x=1774016428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckmpy3mw1UK9sEOGwbASSY5L7qTviwDScKOnF+2PxxU=;
        b=HlpD18Lm+IyOn8kwGm8XXJ+SQjz41D7SaFpsTNUrVLgV7fczVkHa690Aez9ngA6WI6
         gtcHraUNQzUR0Pwt3/qukRf+w4UEBSenqBewmr3ZWhLozFYzy5EFeQDGZMyGzZIG7+AH
         LsKJ3aWbD0P7cs+WbqQ3JjMR+Dp7eTpZMhr3UU5bnryAITy9ZF1GV/t7HvLYQ89IyQFv
         i+JSbxNLpyDGT0oXbVoThtMHnnmxP8cn9yT+W23AJssz+5no7aWP/wYksCOj9t51XEZG
         PrhipfHiIsjiXcr3ZtrrMq+E1lvN7MbFyNpjP+6ooo5B48wGFRMR//FWAjLf0Vje9bXh
         PaeA==
X-Forwarded-Encrypted: i=1; AJvYcCUdvQIF3ocSp6kkPffrweSYMWxmKM6u2ibPCQPn+sANg8QRPQ0IawYLUFzqi0NYOFLnR74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzht86mKSv1X+W0mmnCYuX4PCjsSkRNL6iq+IYvOyP5krgjkjtj
	q3vNDJNqhdev9e9we5ZcTh6qaWnZdBG6SumwaNwFFmRcY5VgRCihRtedbUORJc/ovXqGrgF8vNf
	Df/VV/E0bFDGnndwOmMZbAdMyA55mdu8=
X-Gm-Gg: ATEYQzxsz0NzYhRuqYPWZbEXLUbCNH5+xE6jn8HssEkL7f1PqypQeVvcjGPPzhvT72J
	o3ng8ac3ZkWssN2N0mu90E5nAm+nVGTe46uTJdqo/HbdLObjCwFzCt8ab9QGFT/nsxhU4G89ITN
	G9Wc7jR8K+aA+RCAqYNnLq3ZZW+tYvwPDIcL3SvP5TGKjqNQOiQdBywnSn0Sa0MbVqbZbdF8czm
	Nz2ghQYWe6X8Rrm4r/s07UTeHsl5YBdNz/RtOqjE1Qo9UV6Sl81Avc2g9p9ldrovMPdHqxt2yCD
	RXVJ/3eRZg==
X-Received: by 2002:a17:906:338d:b0:b97:408f:edba with SMTP id
 a640c23a62f3a-b976519a11fmr150342866b.35.1773411627235; Fri, 13 Mar 2026
 07:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312183817.104878-1-teknoraver@meta.com> <20260313131624.6562-1-kohei@enjuk.jp>
In-Reply-To: <20260313131624.6562-1-kohei@enjuk.jp>
From: Matteo Croce <technoboy85@gmail.com>
Date: Fri, 13 Mar 2026 15:19:50 +0100
X-Gm-Features: AaiRm512HRVQlYKx8veJJyzZ-hM-j0qXfMX8S7Ikh0C8Ns4fLLpJwVe8NvjC1OQ
Message-ID: <CAFnufp1xYV9+o=25OSjUc==tjRitqNoO1THwxtPvq7puJZkzjA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] e1000e: add XDP support
To: Kohei Enju <kohei@enjuk.jp>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"

Il giorno ven 13 mar 2026 alle ore 14:16 Kohei Enju <kohei@enjuk.jp> ha scritto:
>
> On Thu, 12 Mar 2026 19:38:15 +0100, Matteo Croce wrote:
> > Add XDP support to e1000e driver. First patch adds basic XDP support,
> > while the second one adds support for AF_XDP.
> > Tested on an Intel 82574L Gigabit card.
>
> I'd Cc intel-wired-lan@lists.osuosl.org since this series is about e1000e.
> Is there any reason not to Cc the list?

Hi, get_maintainers said "moderated list" so I thought that I had to
register first to send a message.
I'll post the v3 there too, hoping that a moderator approves it.


--
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay
